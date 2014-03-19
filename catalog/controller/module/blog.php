<?php
class ControllerModuleBlog extends Controller {
	protected function index($setting) {
		$this->language->load('module/blog');


    	$this->data['heading_title'] = $this->language->get('heading_title');

		if (isset($this->request->get['blog_id'])) {
			$parts = explode('_', (string)$this->request->get['blog_id']);
		} else {
			$parts = array();
		}

		if (isset($parts[0])) {
			$this->data['blog_id'] = $parts[0];
		} else {
			$this->data['blog_id'] = 0;
		}

		if (isset($parts[1])) {
			$this->data['child_id'] = $parts[1];
		} else {
			$this->data['child_id'] = 0;
		}

        $this->load->model('catalog/blog');
		$this->load->model('catalog/record');

		$this->data['blogies'] = array();
														//dymm
		//$blogies = $this->model_catalog_blog->getBlogies($setting['blog_id']);

		//foreach ($blogies as $blog) {

        $blog_info = $this->model_catalog_blog->getBlog($setting['blog_id']);

        $this->load->model('tool/image');

         if ($blog_info) {
             	if ($blog_info['image']) {
				$thumb = $this->model_tool_image->resize($blog_info['image'],$this->config->get('config_image_wishlist_width'), $this->config->get('config_image_wishlist_height'), 1);
			} else {
				$thumb = '';
			}

         }


			$children_data = array();

			$children = $this->model_catalog_blog->getBlogies($setting['blog_id']);

			foreach ($children as $child) {
				$data = array(
					'filter_blog_id'  => $child['blog_id'],
					'filter_sub_blog' => true
				);

				$record_total = $this->model_catalog_record->getTotalRecords($data);


				 $blog_child_info = $this->model_catalog_blog->getBlog($child['blog_id']);



		         if ($blog_child_info) {
		             	if ($blog_child_info['image']) {
						$thumb_child = $this->model_tool_image->resize($blog_child_info['image'], $this->config->get('config_image_wishlist_width'), $this->config->get('config_image_wishlist_height'), 1);
					} else {
						$thumb_child = '';
					}

		         }





				$children_data[] = array(
					'blog_id' => $child['blog_id'],
					'name'        => $child['name'],
					'count'		  => $record_total,
					'thumb' 	  => $thumb_child,
					'href'        => $this->url->link('record/blog', 'blog_id=' . $blog['blog_id'] . '_' . $child['blog_id'])
				);
			}

			$data = array(
				'filter_blog_id'  => $setting['blog_id'],
				//'filter_sub_blog' => true,
				'start' => 0,
				'limit' => 4,
				'order' => 'DESC',
				'sort'	=> 'p.date_added'
			);

			$results = $this->model_catalog_record->getRecords($data);
			$records = array();
			foreach ($results as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
				} else {
					$image = false;
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

				if ($this->config->get('config_comment_status')) {
					$rating = (int)$result['rating'];
				} else {
					$rating = false;
				}

				$records[] = array(
					'record_id'  => $result['record_id'],
					'thumb'       => $image,
					'name'        => $result['name'],
					'description' => mb_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 100) . '..',
					'price'       => $price,
					'special'     => $special,
					'tax'         => $tax,
					'rating'      => $result['rating'],
					'date_added'        => $result['date_added'],
					'viewed'        => $result['viewed'],
					'comments'     => (int)$result['comments'],
					'href'        => $this->url->link('record/record', '&record_id=' . $result['record_id'])
				);
			}

			//$record_total = $this->model_catalog_record->getTotalRecords($data);

			$this->data['blogies'][] = array(
				'blog_id' => $setting['blog_id'],
				'name'        => $blog_info['name'],
				'children'    => $children_data,
				'records'	  => $records,
				//'count'		  => $record_total,
				'meta'		  => $blog_info['meta_description'],
				'thumb'		  => $thumb,
				'href'        => $this->url->link('record/blog', 'blog_id=' . $setting['blog_id'])
			);
		//}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/blog.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/blog.tpl';
		} else {
			$this->template = 'default/template/module/blog.tpl';
		}

		$this->render();
  	}
}
?>