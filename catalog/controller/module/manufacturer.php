<?php  
class ControllerModuleManufacturer extends Controller {
	protected function index($setting) {
		$this->language->load('module/manufacturer');
		
    	$this->data['heading_title'] = $this->language->get('heading_title');
		
		if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
		} else {
			$parts = array();
		}
		
		if (isset($parts[0])) {
			$this->data['manufacturer_id'] = $parts[0];
		} else {
			$this->data['manufacturer_id'] = 0;
		}
		
		if (isset($parts[1])) {
			$this->data['child_id'] = $parts[1];
		} else {
			$this->data['child_id'] = 0;
		}
							
		$this->load->model('catalog/manufacturer');
		$this->load->model('catalog/product');
		$this->load->model('tool/image');
		/*
		$this->load->model('catalog/manufacturer');
		$m = $this->model_catalog_manufacturer->getManufacturers(0);
		var_dump($m);
		*/
		$this->data['manufactureres'] = array();
					
		$results = $this->model_catalog_manufacturer->getManufacturers(0);
		foreach($results as $result)
		{
			
				if ($result['image']) {
						$image = $result['image'];
					} else {
						$image = 'no_image.jpg';
					}
			
			$this->data['manufactureres'][] = array(
				'thumb' => $this->model_tool_image->resize($image,$setting['image_width'], $setting['image_height']),
				'manufacturer_id' => $result['manufacturer_id'],
				'name'        => $result['name'] ,
				'href'        => $this->url->link('product/manufacturer/product', 'manufacturer_id=' . $result['manufacturer_id'])
			
		
				//route=product/manufacturer/product&manufacturer_id=6
			);
		}
		/*
		foreach ($manufactureres as $manufacturer) {
			$children_data = array();
			
			$children = $this->model_catalog_manufacturer->getManufacturers($manufacturer['manufacturer_id']);
			
			foreach ($children as $child) {
				$data = array(
					'filter_manufacturer_id'  => $child['manufacturer_id'],
					'filter_sub_manufacturer' => true
				);		
					
				$product_total = $this->model_catalog_product->getTotalProducts($data);
							
				$children_data[] = array(
					'manufacturer_id' => $child['manufacturer_id'],
					'name'        => $child['name'] . ' (' . $product_total . ')',
					'href'        => $this->url->link('product/manufacturer', 'path=' . $manufacturer['manufacturer_id'] . '_' . $child['manufacturer_id'])	
				);					
			}
			
			$data = array(
				'filter_manufacturer_id'  => $manufacturer['manufacturer_id'],
				'filter_sub_manufacturer' => true	
			);		
				
			$product_total = $this->model_catalog_product->getTotalProducts($data);
						
			$this->data['manufactureres'][] = array(
				'manufacturer_id' => $manufacturer['manufacturer_id'],
				'name'        => $manufacturer['name'] . ' (' . $product_total . ')',
				'children'    => $children_data,
				'href'        => $this->url->link('product/manufacturer', 'path=' . $manufacturer['manufacturer_id'])
			);
		}
		*/
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/manufacturer.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/manufacturer.tpl';
		} else {
			$this->template = 'default/template/module/manufacturer.tpl';
		}
		
		$this->render();
  	}
}
?>