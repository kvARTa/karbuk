<?php  
class ControllerInformationCatalog extends Controller {
	public function index() {
    	$this->language->load('information/catalog');
 
		$this->document->setTitle($this->language->get('heading_title')); 

      	$this->data['breadcrumbs'] = array();

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
        	'separator' => false
      	);

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('information/catalog'),      	
        	'separator' => $this->language->get('text_separator')
      	);	
		
    	$this->data['heading_title'] = $this->language->get('heading_title');

		
		$this->load->model('catalog/category');
		$this->load->model('catalog/product');
		
		$this->data['categories'] = array();
					
		$categories_1 = $this->model_catalog_category->getCategories(0);

		$grand_total = 0;
		$cat_count = 0;

		$third_level = $this->language->get('third_level');
		$this->data['show_third_level'] = $third_level;
		
		foreach ($categories_1 as $category_1) {
			$subcats = 0;
			$level_2_data = array();
			
			$categories_2 = $this->model_catalog_category->getCategories($category_1['category_id']);
			
			foreach ($categories_2 as $category_2) {
				$subcats++;
				$level_3_data = array();
				
				$categories_3 = $this->model_catalog_category->getCategories($category_2['category_id']);
				if($third_level){
					foreach ($categories_3 as $category_3) {

						$subcats++;
						$data = array(
							'filter_category_id'  => $category_3['category_id'],
							'filter_sub_category' => true	
						);
									
						$product_total = $this->model_catalog_product->getTotalProducts($data);	
						$grand_total+=$product_total;
						$cat_count++;

						$level_3_data[] = array(
							'name' => $category_3['name'],
							'href' => $this->url->link((isset($this->request->get["c"]) ? 'product/category' : 'tool/price/download'), 'path=' . $category_1['category_id'] . '_' . $category_2['category_id'] . '_' . $category_3['category_id']),
							'total'	   => $product_total
						);
					}
				}	

				$data = array(
					'filter_category_id'  => $category_2['category_id'],
					'filter_sub_category' => true	
				);
							
				$product_total = $this->model_catalog_product->getTotalProducts($data);
				$grand_total+=$product_total;
				$cat_count++;
				
				$level_2_data[] = array(
					'name'     => $category_2['name'],
					'children' => $level_3_data,
					'href'     => $this->url->link((isset($this->request->get["c"]) ? 'product/category' : 'tool/price/download'), 'path=' . $category_1['category_id'] . '_' . $category_2['category_id']),
					'total'	   => $product_total
				);					
			}

			$data = array(
				'filter_category_id'  => $category_1['category_id'],
				'filter_sub_category' => true	
			);
						
			$product_total = $this->model_catalog_product->getTotalProducts($data);
			$grand_total+=$product_total;
			$cat_count++;

			$this->data['categories'][] = array(
				'name'     => $category_1['name'],
				'children' => $level_2_data,
				'href'     => $this->url->link((isset($this->request->get["c"]) ? 'product/category' : 'tool/price/download'), 'path=' . $category_1['category_id']),
				'total'	   => $product_total,
				'subcats'  => $subcats	
			);
		}	

		$subcats_total = $cat_count/2;
		$subcats_subtotal = 0;
		foreach ($this->data['categories'] as $k=>$cat) {
			$subcats_subtotal += $cat['subcats'];
			if($subcats_subtotal > ($cat_count/2)){
				$this->data['categories'][$k]['switch_to_left']	= 1;
				break;
			}
		}

		$this->data['grand_total'] = $grand_total;	
		$this->data['cat_count']   = $cat_count;	
		


		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/catalog.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/information/catalog.tpl';
		} else {
			$this->template = 'default/template/information/catalog.tpl';
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
?>