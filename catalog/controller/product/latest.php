<?php 
class ControllerProductLatest extends Controller { 	
	public function index() { 
    	$this->language->load('product/latest');
		
		$this->load->model('catalog/product');
		
		$this->load->model('tool/image');
		
						    	
		$this->document->setTitle($this->language->get('heading_title'));

		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
      		'separator' => false
   		);

		$url = '';
		
		
					
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('product/latest', $url),
      		'separator' => $this->language->get('text_separator')
   		);
		
    	$this->data['heading_title'] = $this->language->get('heading_title');
   
		$this->data['text_empty'] = $this->language->get('text_empty');
		$this->data['text_quantity'] = $this->language->get('text_quantity');
		$this->data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$this->data['text_model'] = $this->language->get('text_model');
		$this->data['text_price'] = $this->language->get('text_price');
		$this->data['text_tax'] = $this->language->get('text_tax');
		$this->data['text_points'] = $this->language->get('text_points');
		$this->data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
		$this->data['text_display'] = $this->language->get('text_display');
		$this->data['text_list'] = $this->language->get('text_list');
		$this->data['text_grid'] = $this->language->get('text_grid');		
		$this->data['text_sort'] = $this->language->get('text_sort');
		$this->data['text_limit'] = $this->language->get('text_limit');

		$this->data['button_cart'] = $this->language->get('button_cart');	
		$this->data['button_wishlist'] = $this->language->get('button_wishlist');
		$this->data['button_compare'] = $this->language->get('button_compare');
		
		$this->data['compare'] = $this->url->link('product/compare');
		
		$this->data['products'] = array();

	
		
		
		$data = array(
			'sort'  => 'p.date_added',
			'order' => 'DESC',
			'start' => 0,
			'limit' => 30
		);
		
			
		$product_total = $this->model_catalog_product->getProducts($data);
			
		$results = $this->model_catalog_product->getProducts($data);
			
		foreach ($results as $result) {
			if ($result['image']) {
				$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
			} else {
				$image = false;
				$image = $this->model_tool_image->resize('no_image.jpg', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));

			}
			
			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$price = false;
			}
			
			if ((float)$result['special']) {
				$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$special = false;
			}	
			
			if ($this->config->get('config_tax')) {
				$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
			} else {
				$tax = false;
			}				
			
			if ($this->config->get('config_review_status')) {
				$rating = (int)$result['rating'];
			} else {
				$rating = false;
			}
			
				if ($result['quantity'] <= 0) {
				$stock = $result['stock_status'];
			} elseif ($this->config->get('config_stock_display')) {
				$stock = $result['quantity'];
			} else {
				$stock = $this->language->get('text_instock');
			}
						
						/**/
				if ($this->config->get('config_tax')) {
					$tax = $this->currency->format((float)$result['special'] ? $product_info['special'] : $result['price']);
				} else {
					$tax = false;
				}		
				
				$this->data['attribute_groups'] = $this->model_catalog_product->getProductAttributes($result['product_id']);
						$length_classes=$this->getLengthClassDescriptions($result['length_class_id']);
								
								foreach ($length_classes as $length_class) {
								$length_classe_title= $length_class['unit'];
								}
								
					/**/
						
				$this->data['products'][] = array(
					'product_id'  => $result['product_id'],
					'manufacturer' => $result['manufacturer'],
					'multiplicity' => $result['multiplicity'],
					'model' => $result['model'],
					'thumb'       => $image,
					'stock'       => $stock,
					'name'        => $result['name'],
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 100) . '..',
					'price'       => $price,
					'special'     => $special,
					'tax'         => $tax,
					'rating'      => $result['rating'],
					'reviews'     => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
					'href'        => $this->url->link('product/product', '&product_id=' . $result['product_id'])
				);
		}

		

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/latest.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/product/latest.tpl';
		} else {
			$this->template = 'default/template/product/latest.tpl';
		}
		
		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'
		);
	
		$this->response->setOutput($this->render());			
  	}
		public function getLengthClassDescriptions($length_class_id) {
		$length_class_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "length_class_description WHERE length_class_id = '" . (int)$length_class_id . "'");
				
		foreach ($query->rows as $result) {
			$length_class_data[$result['language_id']] = array(
				'title' => $result['title'],
				'unit'  => $result['unit']
			);
		}
		
		return $length_class_data;
	}
}
?>