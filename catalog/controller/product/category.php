<?php
class ControllerProductCategory extends Controller
{
    private $series_categories = array('528_278570','528_274888','528_239257');

	public function index()
	{
		$this->language->load('product/category');

		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'p.sort_order';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		if (isset($this->request->get['limit'])) {
			$limit = $this->request->get['limit'];
		} else {
			$limit = $this->config->get('config_catalog_limit');
		}
		/* Смотрим что находится в адресной строке если там замечен filter_manufacturer_id то присваиваем одноименную переменную */
		if (isset($this->request->get['filter_manufacturer_id'])) {
			$filter_manufacturer_id = $this->request->get['filter_manufacturer_id'];
			/* Также создаем переменную для того чтобы определить активный пункт */
			$this->data['manufacturer_id'] = $this->request->get['filter_manufacturer_id'];

		} else {
			$filter_manufacturer_id = '';
			$this->data['manufacturer_id'] = '';
		}

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home'),
			'separator' => false
		);

		if (isset($this->request->get['path'])) {
			$path = '';

			$parts = explode('_', (string)$this->request->get['path']);

			foreach ($parts as $path_id) {
				if (!$path) {
					$path = $path_id;
				} else {
					$path .= '_' . $path_id;
				}


				$category_info = $this->model_catalog_category->getCategory($path_id);


				if ($category_info) {

					if ($category_info['name'] != '') {
						$this->data['breadcrumbs'][] = array(
							'text' => $category_info['name'],
							'href' => $this->url->link('product/category', 'path=' . $path),
							'separator' => $this->language->get('text_separator')
						);
					}


				}
			}
            if (in_array($this->request->get['path'],$this->series_categories)) {
                $this->data['series_category'] = true;
            }else{
                $this->data['series_category'] = false;
            }

			$category_id = array_pop($parts);
		} else {
			$category_id = 0;
		}


		//dymm
		$this->data['price_path'] = $this->request->get['path'];


		$category_info = $this->model_catalog_category->getCategory($category_id);

		if ($category_info) {
			if ($category_info['seo_title']) {
				$this->document->setTitle($category_info['seo_title']);
			} else {
				$this->document->setTitle($category_info['name']);
			}

			$this->document->setDescription($category_info['meta_description']);
			$this->document->setKeywords($category_info['meta_keyword']);

			$this->data['seo_h1'] = $category_info['seo_h1'];

			$this->data['heading_title'] = $category_info['name'];

			$this->data['text_stock'] = $this->language->get('text_stock');
			$this->data['text_refine'] = $this->language->get('text_refine');
			$this->data['text_empty'] = $this->language->get('text_empty');
			$this->data['text_quantity'] = $this->language->get('text_quantity');
			$this->data['text_manufacturer'] = $this->language->get('text_manufacturer');
			$this->data['text_model'] = $this->language->get('text_model');
			$this->data['text_price'] = $this->language->get('text_price');
			$this->data['text_tax'] = $this->language->get('text_tax');
			$this->data['text_separator'] = $this->language->get('text_separator');
			$this->data['text_points'] = $this->language->get('text_points');
			$this->data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
			$this->data['text_display'] = $this->language->get('text_display');
			$this->data['text_list'] = $this->language->get('text_list');
			$this->data['text_grid'] = $this->language->get('text_grid');
			$this->data['text_sort'] = $this->language->get('text_sort');
			$this->data['text_limit'] = $this->language->get('text_limit');
			$this->data['text_all'] = $this->language->get('text_all');

			$this->data['button_cart'] = $this->language->get('button_cart');
			$this->data['button_wishlist'] = $this->language->get('button_wishlist');
			$this->data['button_compare'] = $this->language->get('button_compare');
			$this->data['button_continue'] = $this->language->get('button_continue');

			if ($category_info['image']) {
				$this->data['thumb'] = $this->model_tool_image->resize($category_info['image'], $this->config->get('config_image_category_width'), $this->config->get('config_image_category_height'));
			} else {
				$this->data['thumb'] = '';
			}

            $dir_cat_big_img = 'images_big/';
            $cat_big_img = DIR_IMAGE . $dir_cat_big_img . $category_id . '.jpg';
            //echo $cat_img.'<br>';
            if (file_exists($cat_big_img)) {
                $this->data['big_image'] = $this->model_tool_image->resize($dir_cat_big_img . $category_id . '.jpg', 771, 250, false);
            } else {
                $this->data['big_image'] = null;
            }

			$this->data['description'] = html_entity_decode($category_info['description'], ENT_QUOTES, 'UTF-8');
			$this->data['compare'] = $this->url->link('product/compare');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			if (isset($this->request->get['filter_manufacturer_id'])) {
				$url .= '&filter_manufacturer_id=' . $this->request->get['filter_manufacturer_id'];
			}

			$this->data['categories'] = array();

			$results = $this->model_catalog_category->getCategories($category_id);

			//var_dump($results); die;
			//$manufacturers = $this->model_catalog_category->getManufacturersToForm($category_id);
			//var_dump($results); die;
			//var_dump($this->model_catalog_category->getManufacturersToForm($category_id)); die;

			/* Сперва мы создаем пустой массив по производителям */
			$this->data['manufacturers'] = array();
			/* Подгружаем отдельно созданный метод для вывода производителей для данной категории $category_id*/
			$manufacturers = $this->model_catalog_category->getManufacturersToForm($category_id);
			/* Создаем массив и проходимся по нему*/
			foreach ($manufacturers as $manufacturer) {
				$this->data['manufacturers'][] = array(
					/* Вычисляем id производителя для активного пункта*/
					'manufacturer_id' => $manufacturer['manufacturer_id'],
					'name' => $manufacturer['name'],
					'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&filter_manufacturer_id=' . $manufacturer['manufacturer_id']),
					/* Добавляем ссылку для показа всех товаров без фильтра производителей*/
					'hrefall' => $this->url->link('product/category', 'path=' . $this->request->get['path']),
					// manufacture_id == 0
					'hrefOther' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&filter_manufacturer_id=null'),
				);
			}
			/* Конец*/

			foreach ($results as $result) {
				$data = array(
					'filter_category_id' => $result['category_id'],
					'filter_sub_category' => true
				);

                $dir_cat_img = 'category_images/';
                $cat_img = DIR_IMAGE . $dir_cat_img . $result['old_id'] . '.jpg';
                //echo $cat_img.'<br>';
                if (file_exists($cat_img)) {
                    $image = $this->model_tool_image->resize($dir_cat_img . $result['old_id'] . '.jpg', 345, 230, false);
                } else {
                    $image = null;
                }



				$product_total = $this->model_catalog_product->getTotalProducts($data);

				$this->data['categories'][] = array(
					'name' => $result['name'] . ' (' . $product_total . ')',
					'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '_' . $result['category_id'] . $url),
                    'thumb'=> $image
				);
			}

			$this->data['products'] = array();

			$data = array(
				'filter_category_id' => $category_id,
				/* В модели вывода товара есть нигде не используемая переменная для вывода товара filter_manufacturer_id для чего его разработчики */
				/* добавили я так и не понял, но она пришлась как раз кстати*/
				'filter_manufacturer_id' => $filter_manufacturer_id,
				'sort' => $sort,
				'order' => $order,
				'start' => ($page - 1) * $limit,
				'limit' => $limit
			);

			$product_total = $this->model_catalog_product->getTotalProducts($data);

			$results = $this->model_catalog_product->getProducts($data);

			foreach ($results as $result) {
                if ( (!$result['image'] or !file_exists(DIR_IMAGE . $result['image'])) && $this->config->get('config_product_no_image')  ) {
                    continue;
                }

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

                $product_colors = array();
                if ($result['type']){
                    $colors = $this->model_catalog_product->getProductColors($result['type']);

                    if ($colors) {
                        foreach ($colors as $item){
                            $color_img = 'colors' . DIRECTORY_SEPARATOR . $item['color'] . '.jpg';
                            //if (file_exists(DIR_IMAGE . $color_img)){

                            if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
                                $color_img =  HTTPS_IMAGE . $color_img;
                            } else {
                                $color_img = HTTP_IMAGE . $color_img;
                            }

                            $product_colors[] = array(
                                'product_id'  => $item['product_id'],
                                'color_img'   => $color_img,
                                'color_title' => $item['color'],
                                'href'        => $this->url->link('product/product', $url . '&product_id=' . $item['product_id']),
                                'current'     => $result['product_id'] ==  $item['product_id'] ? true : false,
                            );
                            // }
                        }

                    }
                }


				$this->data['products'][] = array(
					'product_id' => $result['product_id'],
					'manufacturer' => $result['manufacturer'],
					'multiplicity' => $result['multiplicity'],
					'model' => $result['model'],
					'thumb' => $image,
                    'product_colors' => $product_colors,
					'stock' => $stock,
					'name' => $result['name'],
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 100) . '..',
					'price' => $price,
					'special' => $special,
					'tax' => $tax,
					'rating' => $result['rating'],
					'reviews' => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
					'href' => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'])
				);
			}

			$url = '';

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$this->data['sorts'] = array();

			$this->data['sorts'][] = array(
				'text' => $this->language->get('text_default'),
				'value' => 'p.sort_order-ASC',
				'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.sort_order&order=ASC' . $url)
			);

			$this->data['sorts'][] = array(
				'text' => $this->language->get('text_name_asc'),
				'value' => 'pd.name-ASC',
				'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=pd.name&order=ASC' . $url)
			);

			$this->data['sorts'][] = array(
				'text' => $this->language->get('text_name_desc'),
				'value' => 'pd.name-DESC',
				'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=pd.name&order=DESC' . $url)
			);


			######################3

			$this->data['hrefna2'] = $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=pd.name&order=DESC' . $url);
			$this->data['hrefna'] = $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=pd.name&order=ASC' . $url);
			##############################


			$this->data['sorts'][] = array(
				'text' => $this->language->get('text_price_asc'),
				'value' => 'p.price-ASC',
				'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.price&order=ASC' . $url)
			);

			$this->data['sorts'][] = array(
				'text' => $this->language->get('text_price_desc'),
				'value' => 'p.price-DESC',
				'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.price&order=DESC' . $url)
			);


			######################3

			$this->data['sortspa'][] = array(
				'text' => $this->language->get('text_price_asc'),
				'value' => 'p.price-ASC',
				'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.price&order=ASC' . $url)
			);


			$this->data['href2'] = $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.price&order=DESC' . $url);
			$this->data['href'] = $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.price&order=ASC' . $url);

			##############################


			if ($this->config->get('config_review_status')) {
				$this->data['sorts'][] = array(
					'text' => $this->language->get('text_rating_desc'),
					'value' => 'rating-DESC',
					'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=rating&order=DESC' . $url)
				);

				$this->data['sorts'][] = array(
					'text' => $this->language->get('text_rating_asc'),
					'value' => 'rating-ASC',
					'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=rating&order=ASC' . $url)
				);
			}

			######################3

			$this->data['hrefrating2'] = $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=rating&order=DESC' . $url);
			$this->data['hrefrating'] = $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=rating&order=ASC' . $url);
			##############################


			$this->data['sorts'][] = array(
				'text' => $this->language->get('text_model_asc'),
				'value' => 'p.model-ASC',
				'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.model&order=ASC' . $url)
			);

			$this->data['sorts'][] = array(
				'text' => $this->language->get('text_model_desc'),
				'value' => 'p.model-DESC',
				'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.model&order=DESC' . $url)
			);

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			$this->data['limits'] = array();

			$this->data['limits'][] = array(
				'text' => $this->config->get('config_catalog_limit'),
				'value' => $this->config->get('config_catalog_limit'),
				'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&limit=' . $this->config->get('config_catalog_limit'))
			);

			$this->data['limits'][] = array(
				'text' => 25,
				'value' => 25,
				'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&limit=25')
			);


			######################3

			$this->data['hreflimit15'] = $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&limit=15');
			$this->data['hreflimit30'] = $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&limit=30');
			$this->data['hreflimit100'] = $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&limit=100');

			##############################


			$this->data['limits'][] = array(
				'text' => 50,
				'value' => 50,
				'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&limit=50')
			);

			$this->data['limits'][] = array(
				'text' => 75,
				'value' => 75,
				'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&limit=75')
			);

			$this->data['limits'][] = array(
				'text' => 100,
				'value' => 100,
				'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&limit=100')
			);

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$pagination = new Pagination();
			$pagination->total = $product_total;
			$pagination->page = $page;
			$pagination->limit = $limit;
			$pagination->text = $this->language->get('text_pagination');
			$pagination->url = $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&page={page}');

			$this->data['pagination'] = $pagination->render();

			$this->data['sort'] = $sort;
			$this->data['order'] = $order;
			$this->data['limit'] = $limit;

			$this->data['continue'] = $this->url->link('common/home');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/category.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/product/category.tpl';
			} else {
				$this->template = 'default/template/product/category.tpl';
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
		} else {
			$url = '';

			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$this->data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('product/category', $url),
				'separator' => $this->language->get('text_separator')
			);

			$this->document->setTitle($this->language->get('text_error'));

			$this->data['heading_title'] = $this->language->get('text_error');

			$this->data['text_error'] = $this->language->get('text_error');

			$this->data['button_continue'] = $this->language->get('button_continue');

			$this->data['continue'] = $this->url->link('common/home');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/error/not_found.tpl';
			} else {
				$this->template = 'default/template/error/not_found.tpl';
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
	}
}

?>