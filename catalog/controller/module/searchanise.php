<?php
/***************************************************************************
*                                                                          *
*   (c) 2004 Vladimir V. Kalynyak, Alexey V. Vinokurov, Ilya M. Shalnev    *
*                                                                          *
* This  is  commercial  software,  only  users  who have purchased a valid *
* license  and  accept  to the terms of the  License Agreement can install *
* and use this program.                                                    *
*                                                                          *
****************************************************************************
* PLEASE READ THE FULL TEXT  OF THE SOFTWARE  LICENSE   AGREEMENT  IN  THE *
* "copyright.txt" FILE PROVIDED WITH THIS DISTRIBUTION PACKAGE.            *
****************************************************************************/

/* [Searchanise] */

class ControllerModuleSearchanise extends Controller {
	private $_url = null;
	private $seo = null;

	private $se_tax = null;

	/*
	 * Modes
	 */
	protected function index($setting) {
		static $module = 0;
		
		// Code should be added only once.
		if ($module == 0) {
			$this->load->model('setting/store');
			$this->load->model('localisation/language');

			Searchanise::seCheckImportIsDone();

			$this->formationSearchaniseParams();

			$this->data['module'] = $module++; 

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/searchanise.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/module/searchanise.tpl';
			} else {
				$this->template = 'default/template/module/searchanise.tpl';
			}
			
			$this->render();
		}
	}

	public function async() {
		session_write_close();
		if (!Searchanise::seCheckSearchaniseStatus($this)) {
			die("Searchanise add-on uninstalled.");
		}

		$check_key = false;
		if (isset($this->request->get['parent_private_key'])) {
			$request_private_key = $this->request->get['parent_private_key'];
			$store_id = $this->config->get('config_store_id');
			if (Searchanise::seGetParentPrivateKey($store_id) === $request_private_key) {
				$check_key = true;
			}
		}

		$fl_ignore_processing = false;
		if ($check_key && isset($this->request->get['ignore_processing'])) {
			$fl_ignore_processing = $this->request->get['ignore_processing'] === 'Y';
		}

		if ($check_key && isset($this->request->get['display_errors']) && $this->request->get['display_errors'] === 'Y') {
			@error_reporting(E_ALL);
			@ini_set('display_errors', 1);
		} else {
			@error_reporting(0);
			@ini_set('display_errors', 0);
		}

		$this->load->model('catalog/product');
		$this->load->model('tool/image');
		$this->load->model('module/searchanise');
		$this->load->model('account/customer_group');

		@ignore_user_abort(1);
		@set_time_limit(0);
		$async_memory_limit = Searchanise::SE_MEMORY_LIMIT;
		if ($async_memory_limit) {
			if (substr(ini_get('memory_limit'), 0, -1) < $async_memory_limit) {
				@ini_set('memory_limit', $async_memory_limit . 'M');
			}
		}

		$xml_header = $this->seGetXmlHeader();
		$xml_footer = $this->seGetXmlFooter();

		$q = Searchanise::seGetQueueByStoreId();

		if (class_exists('ControllerCommonSeoUrl')) {
			$this->seo = new ControllerCommonSeoUrl($this->registry);
		} elseif (class_exists('ControllerCommonSeoPro')) {
			$this->seo = new ControllerCommonSeoPro($this->registry);
		}

		while (!empty($q)) {
			if (Searchanise::checkDebug($this)) {
				Searchanise::printR($q);
			}
			$xml = '';
			$status = true;
			$store_id = $q['store_id'];
			$lang_code  = $q['lang_code'];
			$data = unserialize($q['data']);
			$private_key = Searchanise::seGetPrivateKey($store_id, $lang_code);

			$this->_url = new Url(
				Searchanise::getStoreUrl($store_id), 
				Searchanise::isStoreUsedSsl($store_id) ? Searchanise::getStoreSecureUrl($store_id) : Searchanise::getStoreUrl($store_id)
			);

			if (empty($private_key)) {
				$condition_params = array('queue_id' => $q['queue_id']);
				Searchanise::seDeleteQueue($condition_params);
				$q = array();
				continue;
			}

			if ($q['status'] == 'processing' 
				&& ($q['started'] + Searchanise::SE_MAX_PROCESSING_TIME > time())) {

				if (!$fl_ignore_processing) {
					die('PROCESSING');
				}
			}

			if ($q['error_count'] >= Searchanise::SE_MAX_ERROR_COUNT) {
				Searchanise::seSetImportStatus('sync_error', $store_id, $lang_code);
				die('DISABLED');
			}

			$update_params = array(
				'status' => 'processing',
				'started' => time()
			);
			Searchanise::seUpdateQueue($q['queue_id'], $update_params);

			if ($q['action'] == 'prepare_full_import') {
				$this->seActionPrepareFullImport($store_id, $lang_code);

			} elseif ($q['action'] == 'start_full_import') {
				$status = Searchanise::seSendRequest('/api/state/update', $private_key, array('full_import' => 'start'), $store_id, $lang_code);

				if ($status) {
					Searchanise::seSetImportStatus('processing', $store_id, $lang_code);
				}

			} elseif ($q['action'] == 'end_full_import') {
				$status = Searchanise::seSendRequest('/api/state/update', $private_key, array('full_import' => 'done'), $store_id, $lang_code);

				if ($status) {
					Searchanise::seSetImportStatus('sent', $store_id, $lang_code);
					Searchanise::seSetSetting('last_resync', $store_id, $lang_code, time());
				}

			} elseif ($q['action'] == 'update') {
				$products = array();
				
				foreach ($data as $p_id) {
					$products[$p_id] = $this->model_module_searchanise->seGetProducts($p_id, $lang_code);
				}

				foreach ($products as $product_data) {
					$xml .= $this->seGenerateProductXml($product_data);
				}

				if (!empty($xml)) {
					if (function_exists('gzcompress')) {
						$data = gzcompress($xml_header . $xml . $xml_footer, 5);
					} else {
						$data = $xml_header . $xml . $xml_footer;
					}

					Searchanise::seSendRequest('/api/items/update', $private_key, 
											   array('data' => $data), $store_id, $lang_code);
				}
			} elseif ($q['action'] == 'delete') {
				foreach ($data as $product_id) {
					$status = Searchanise::seSendRequest('/api/items/delete', $private_key, array('id' => $product_id), $store_id, $lang_code);

					echo '.';

					if ($status == false) {
						break;
					}
				}
			}

			if (Searchanise::checkDebug($this)) {
				Searchanise::printR('status', $status);
			}

			if ($status) {
				$condition_params = array('queue_id' => $q['queue_id']);
				Searchanise::seDeleteQueue($condition_params);
				$q = Searchanise::seGetQueueByStoreId();
				
			} else {
				$next_started_time = (time() - Searchanise::SE_MAX_PROCESSING_TIME) + $q['error_count'] * 60;

				$update_params = array(
					'status' => 'processing', 
					'error_count' => 'error_count + 1', 
					'started' => $next_started_time
				);
				Searchanise::seUpdateQueue($q['queue_id'], $update_params);

				break;
			}
			echo ".";
		}

		die('OK');
	}

	public function info() {
		if (!Searchanise::seCheckSearchaniseStatus($this)) {
			die("Searchanise add-on uninstalled.");
		}
		
		Searchanise::seCheckImportIsDone();

		$store_id = $this->config->get('config_store_id');
		$engines_data = Searchanise::seGetEnginesData($store_id);

		$request_private_key = "";
		if (isset($this->request->get['parent_private_key'])) {
			$request_private_key = $this->request->get['parent_private_key'];
		}
		$result = '';

		if (empty($request_private_key) 
			|| Searchanise::seGetParentPrivateKey($store_id) !== $request_private_key
		) {
			foreach ($engines_data as $e) {
				$result[$e['store_id']][$e['lang_code']] = $e['api_key'];
			}
		} else {
			$resync = '';
			$product_id = 0;
			$product_ids = array();
			$lang_code = 'en';

			if (!empty($engines_data)) {
				$current_data = reset($engines_data);
				if (!empty($current_data)) {
					$lang_code = $current_data['lang_code'];
					$store_id = $current_data['store_id'];
				}
			}

			if (isset($this->request->get['product_id'])) {
				$product_id = $this->request->get['product_id'];
			}
			if (isset($this->request->get['product_ids'])) {
				$product_ids = $this->request->get['product_ids'];
			}
			if (isset($this->request->get['lang_code'])) {
				$lang_code = $this->request->get['lang_code'];
			}
			if (isset($this->request->get['resync'])) {
				$resync = $this->request->get['resync'];
			}

			if ($product_id) {
				$product_ids = array($product_id);
			} elseif ($product_ids) {
				$product_ids = explode(',', $product_ids);
			}
						
			if ($resync === 'Y') {
				$this->load->model('setting/store');
				$this->load->model('localisation/language');

				$this->language->load('module/searchanise');

				Searchanise::seSignup();
				Searchanise::seQueueImport();

			} elseif (!empty($product_ids)) {
				$xml = '';
				$products = array();

				// It is need for generate product url.
				if (class_exists('ControllerCommonSeoUrl')) {
					$this->seo = new ControllerCommonSeoUrl($this->registry);
				} elseif (class_exists('ControllerCommonSeoPro')) {
					$this->seo = new ControllerCommonSeoPro($this->registry);
				}
				$this->_url = new Url(
					Searchanise::getStoreUrl($store_id), 
					Searchanise::isStoreUsedSsl($store_id) ? Searchanise::getStoreSecureUrl($store_id) : Searchanise::getStoreUrl($store_id)
				);

				$this->load->model('catalog/product');
				$this->load->model('tool/image');
				$this->load->model('module/searchanise');
				$this->load->model('account/customer_group');

				foreach ($product_ids as $p_id) {
					$products[$p_id] = $this->model_module_searchanise->seGetProducts($p_id, $lang_code);
				}

				foreach ($products as $product_data) {
					$xml .= $this->seGenerateProductXml($product_data);
				}
				$result = $xml;

			} else {
				$result['parent_private_key'] = $request_private_key;
				foreach ($engines_data as $e) {
					$result['private_key'][$e['lang_code']] = $e['private_key'];
					$result['api_key'][$e['lang_code']] = $e['api_key'];
					$result['import_status'][$e['lang_code']] = Searchanise::seGetImportStatus($e['store_id'], $e['lang_code']);
				}

				$result['next_queue'] = Searchanise::seGetQueueByStoreId($store_id);
				$result['total_items_in_queue'] = Searchanise::seGetTotalQueueByStoreId($store_id);
				$result['addon_version'] = Searchanise::VERSION;
				if (defined('VERSION')) {
					$result['core_version'] = VERSION;
				}

				$result['addon_status'] = Searchanise::seCheckSearchaniseStatus($this) ? 'active' : 'disabled';

				$result['max_execution_time'] = ini_get('max_execution_time');
				@set_time_limit(0);
				$result['max_execution_time_after'] = ini_get('max_execution_time');

				$result['ignore_user_abort'] = ini_get('ignore_user_abort');
				@ignore_user_abort(1);
				$result['ignore_user_abort_after'] = ini_get('ignore_user_abort_after');

				$result['memory_limit'] = ini_get('memory_limit');
				$async_memory_limit = Searchanise::SE_MEMORY_LIMIT;
				if ($async_memory_limit) {
					if (substr(ini_get('memory_limit'), 0, -1) < $async_memory_limit) {
						@ini_set('memory_limit', $async_memory_limit . 'M');
					}
				}
				$result['memory_limit_after'] = ini_get('memory_limit');
			}
		}
		
		Searchanise::printR($result);

		die();
	}

	/*
	 * Interface data
	 */
	private function formationSearchaniseParams() {
		$store_id = $this->config->get('config_store_id');
		$lang_code = $this->config->get('config_language');

		$host = Searchanise::SE_SERVICE_URL;
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$host = str_replace('http://', 'https://', $host);
		}

		$searchanise_data = array();

		$searchanise_data['api_key'] = Searchanise::seGetApiKey($store_id, $lang_code);
		$searchanise_data['import_status'] = Searchanise::seGetImportStatus($store_id, $lang_code);
		$searchanise_data['store_id'] = $store_id;
		$searchanise_data['host'] = $host;
		$searchanise_data['date'] = time();

		if (
			isset($this->request->server['HTTPS']) 
			&& (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))
		) {
			$searchanise_data['async_link'] = $this->url->link('module/searchanise/async', '', 'SSL');
		} else {
			$searchanise_data['async_link'] = $this->url->link('module/searchanise/async', '');
		}

		if ($this->customer->isLogged()) {
			$searchanise_data['min_price'] = $this->customer->getCustomerGroupId();
		} else {
			$searchanise_data['min_price'] = $this->config->get('config_customer_group_id');
		}

		$currency_params = array(
			'rate' => 1 / $this->currency->getValue(),
			'decimals' => $this->currency->getDecimalPlace(),
		);

		if ($currency_symbol = $this->currency->getSymbolLeft()) {
			$currency_params['symbol'] = $currency_symbol;
			$currency_params['after'] = 'false';
		} else {
			$currency_params['symbol'] = $this->currency->getSymbolRight();
			$currency_params['after'] = 'true';
		}

		if ($this->language->get('decimal_point')) {
			$currency_params['decimals_separator'] = $this->language->get('decimal_point');
		} else {
			$currency_params['decimals_separator'] = '.';
		}

		if ($this->language->get('thousand_point')) {
			$currency_params['thousands_separator'] = $this->language->get('thousand_point');
		} else {
			$currency_params['thousands_separator'] = '';
		}

		$searchanise_data['price_format'] = $currency_params;

		$this->data['searchanise'] = $searchanise_data;
	}

	/*
	 * Searchanise
	 */

	private function seGetXmlHeader() {
		return '<?xml version="1.0" encoding="UTF-8"?>
		<feed xmlns="http://www.w3.org/2005/Atom" xmlns:cs="http://searchanise.com/ns/1.0">
		<title>Searchanise data feed</title>
		<updated>' . date('c') . '</updated>
		<id>' . $this->config->get('config_url') . '</id>
		';
	}

	private function seGetXmlFooter() {
		return '</feed>';
	}

	private function seActionPrepareFullImport($store_id, $lang_code) {
		$condition_params = array('store_id' => $store_id, 'lang_code' => $lang_code);
		$exclude_condition_params = array('action' => 'prepare_full_import');
		Searchanise::seDeleteQueue($condition_params, $exclude_condition_params);

		$insert_queue_data = array(
			'data' => 'N;',
			'action' => 'start_full_import',
			'store_id' => $store_id,
			'lang_code' => $lang_code
		);
		Searchanise::seInsertQueue($insert_queue_data);

		$i = 0;
		$step = Searchanise::SE_PRODUCTS_PER_PASS * 50;

		$sqls_arr = array();

		$min_max = Searchanise::seGetMinMaxProductIds();

		$start = (int)$min_max['min'];
		$max   = (int)$min_max['max'];

		do {
			$end = $start + $step;

			$prod_ids = Searchanise::seGetProductIds($start, $end, $step, $store_id);

			$start = $end + 1;

			if (empty($prod_ids)) {
				continue;
			}

			$prod_ids = array_chunk($prod_ids, Searchanise::SE_PRODUCTS_PER_PASS);
			
			foreach($prod_ids as $product_ids) {
				$sqls_arr[] = "('" . serialize($product_ids) . "', 'update', "
							  . "'{$store_id}', '{$lang_code}')";
			}

			if (count($sqls_arr) >= 30) {
				Searchanise::seMultiInsertData($sqls_arr);
				echo '.';
				$sqls_arr = array();
			}
		} while ($end <= $max);
		
		if (count($sqls_arr) > 0) {
			Searchanise::seMultiInsertData($sqls_arr);
		}

		echo '.';

		$insert_queue_data = array(
			'data' => 'N;',
			'action' => 'end_full_import',
			'store_id' => $store_id,
			'lang_code' => $lang_code
		);

		Searchanise::seInsertQueue($insert_queue_data);
	}

	private function seGenerateProductPricesXml($product_data) {
		$entry = '';

		// Save default config_customer_group_id, after calc prices it will be return to default.
		$config_customer_group_id = $this->config->get('config_customer_group_id');
		if (!$this->se_tax) {
			$registry = new Registry();
			$registry->set('config', $this->config);
			$registry->set('db', $this->db);

			$se_customer = new Customer($registry);

			$registry->set('customer', $se_customer);
			$this->se_tax = new Tax($registry);
		}
		$price = $this->se_tax->calculate($product_data['price'], $product_data['tax_class_id'], $this->config->get('config_tax'));
		$entry .= '<cs:price>' . $price . '</cs:price>'."\n";

		$customer_groups = $this->model_account_customer_group->getCustomerGroups();
		if ($customer_groups) {
			foreach ($customer_groups as $customer_group) {
				$_price = $product_data['price'];
				$customer_group_id = $customer_group['customer_group_id'];

				if (isset($product_data['discount'][$customer_group_id])) {
					$_price = $product_data['discount'][$customer_group_id];
				}
				if (isset($product_data['special'][$customer_group_id])) {
					$_price = $product_data['special'][$customer_group_id];
				}

				// Set CustomerGroupId for right calculate tax.
				$this->config->set('config_customer_group_id', $customer_group_id);
				// Set tax if it is need.
				$_price = $this->se_tax->calculate($_price, $product_data['tax_class_id'], $this->config->get('config_tax'));

				$entry .= $this->seCreateAttribute($_price, 'price_' . $customer_group_id, 'float');
			}
			$this->config->set('config_customer_group_id', $config_customer_group_id);
		}

		return $entry;
	}

	private function seGenerateProductXml($product_data) {
		$entry = '<entry>'."\n";
		$entry .= '<id>' . $product_data['product_id'] . '</id>'."\n";
		$entry .= '<title><![CDATA[' . $product_data['name'] . ']]></title>'."\n";
		$entry .= '<summary><![CDATA[' . htmlspecialchars_decode($product_data['description']) . ']]></summary>'."\n";

		$_link = $this->_url->link('product/product', 'product_id=' . $product_data['product_id'], true);
		if (Searchanise::isStoreUsedSeo() && $this->seo) {
			$_link = $this->seo->rewrite($_link);
		}
		
		$exist_amp = strrpos($_link, '&');

		if ($exist_amp === false) {
			// Nothing.
		} else {
			// Example: 'A&B', 'A&amp;B' or 'A&quot;B'.
			$_link = htmlspecialchars_decode($_link);
		}
		$_link = htmlspecialchars($_link);
		$entry .= '<link href="' . $_link . '" />'."\n";

		$entry .= '<cs:quantity>' . $product_data['quantity'] . '</cs:quantity>'."\n";
		$entry .= '<cs:product_code><![CDATA[' . $product_data['sku'] . ']]></cs:product_code>'."\n";

		if (!empty($product_data['image'])) {
			$thumb = null;
			$_image_patch = DIR_IMAGE . $product_data['image'];
			// Not need because It work correctly with '//'
			// $_image_patch = str_replace('//', '/', $_image_patch);

			if (!file_exists($_image_patch)) {
				// Nothing because image could located in another server.
				// model_tool_image->resize already has support image which located in another server.
			}

			try {
				$thumb = $this->model_tool_image->resize($product_data['image'], Searchanise::SE_THUMBNAILS_WIDTH, Searchanise::SE_THUMBNAILS_HEIGHT);
				// Not need because It work correctly with '//'.
				// $thumb = str_replace('//', '/', $thumb);
				$thumb = str_replace($this->config->get('config_ssl'), $this->config->get('config_url'), $thumb);
			} catch (Exception $e) {
				// Nothing.
			}

			if (empty($thumb)) {
				$thumb = $product_data['image'];
			}
			
			if (!empty($thumb)) {
				$entry .= "<cs:image_link><![CDATA[" . $thumb . "]]></cs:image_link>\n";
			}
		}

		$entry .= $this->seCreateAttribute((int)$product_data['sort_order'], 'sort_order', 'int');
		$entry .= $this->seCreateAttribute($product_data['rating'], 'rating', 'float');
		$entry .= $this->seCreateAttribute($product_data['model'], 'model', 'text', true, Searchanise::SE_INPUT_SEARCH_WEIGHT);
		$entry .= $this->seCreateAttribute((int)strtotime($product_data['date_available']), 'date_available', 'int');
		$entry .= $this->seCreateAttribute($product_data['status'], 'status', 'text');

		if (isset($product_data['categories']) && !empty($product_data['categories'])) {
			$entry .= $this->seCreateAttribute($product_data['categories'], 'category_id', 'text');
		}
		if (isset($product_data['stores']) && !empty($product_data['stores'])) {
			$entry .= $this->seCreateAttribute($product_data['stores'], 'stores', 'text');
		}

		$entry .= $this->seGenerateProductPricesXml($product_data);

		$entry .= $this->seCreateAttribute((int)$product_data['quantity'], 'amount', 'int');
		$entry .= $this->seCreateAttribute($product_data['manufacturer'], 'manufacturer', 'text', true, Searchanise::SE_INPUT_SEARCH_WEIGHT);
		$entry .= $this->seCreateAttribute($product_data['tag'], 'tags', 'text', true, Searchanise::SE_INPUT_SEARCH_WEIGHT);

		if (isset($product_data['attributes']) && !empty($product_data['attributes'])) {
			foreach ($product_data['attributes'] as $attribute_id => $attribute_value) {
				$attribute_name = 'attribute_' . $attribute_id;
				$entry .= $this->seCreateAttribute($attribute_value, $attribute_name, 'text', true, Searchanise::SE_INPUT_SEARCH_WEIGHT);
			}
		}

		$entry .= $this->seCreateAttribute($product_data['upc'], 'upc', 'text', true, Searchanise::SE_CODES_SEARCH_WEIGHT);
		$entry .= $this->seCreateAttribute($product_data['ean'], 'ean', 'text', true, Searchanise::SE_CODES_SEARCH_WEIGHT);
		$entry .= $this->seCreateAttribute($product_data['ean'], 'jan', 'text', true, Searchanise::SE_CODES_SEARCH_WEIGHT);
		$entry .= $this->seCreateAttribute($product_data['isbn'], 'isbn', 'text', true, Searchanise::SE_CODES_SEARCH_WEIGHT);
		$entry .= $this->seCreateAttribute($product_data['mpn'], 'mpn', 'text', true, Searchanise::SE_CODES_SEARCH_WEIGHT);
		
		$entry .= "</entry>\n";

		return $entry;
	}

	private function seGetProductPrice($product_price, $tax_class_id) {
		return $this->tax->calculate($product_price, $tax_class_id, $this->config->get('config_tax'));
	}

	private function seCreateAttribute($attribute_val, $attribute_name, $attribute_type, $is_search = false, $weight = null) {
		$res = '';

		if ($attribute_val !== '') {

			$res = '<cs:attribute name="' . $attribute_name . '" type="' . $attribute_type . '"';
			if ($is_search) {
				$res .= ' text_search="Y" ';
			}
			if ($weight) {
				$res .= ' weight="' . $weight . '" ';
			}
			$res .= '>';

			if (is_array($attribute_val)) {
				foreach ($attribute_val as $_val) {
					$res .= ' <value>' . $this->seCreateAttributeVal($_val, $attribute_type) . '</value>';
				}
			} else {
				$res .= $this->seCreateAttributeVal($attribute_val, $attribute_type);
			}

			$res .= "</cs:attribute>\n";
		}

		return $res;
	}

	private function seCreateAttributeVal($attribute_val, $attribute_type) {
		if ($attribute_type != 'int' && $attribute_type != 'float') {
			$attribute_val = '<![CDATA[' . $attribute_val . ']]>';
		}

		return $attribute_val;
	}
}

?>