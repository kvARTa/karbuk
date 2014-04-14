<?php
class ControllerModuleManufacturerList extends Controller {
	protected function index($setting) {

		$category_id = 0;

		if(isset($this->request->get['path'])) {

			$parts = explode('_', (string)$this->request->get['path']);
			$category_id = array_pop($parts);
		}

		$this->data['heading_title'] = $setting['title'];

		$this->load->model('module/manufacturerlist');

		$this->load->model('tool/image');

		$this->data['manufacturers'] = array();

		$results = $this->model_module_manufacturerlist->getManufacturers($category_id, $setting['limit']);

		foreach($results as $result) {
			if($result['image']) {
				$image = $this->model_tool_image->resize($result['image'], $setting['image_width'], $setting['image_height']);
			} else {
				$image = false;
			}

			$this->data['manufacturers'][] = array(
				'manufacturer_id' => $result['manufacturer_id'],
				'thumb' => $image,
				'name' => $result['name'],
//				'href' => $this->url->link('product/manufacturer', 'manufacturer_id=' . $result['manufacturer_id']),
				'href'	    => $this->url->link('product/manufacturer/product', 'manufacturer_id=' . $result['manufacturer_id']),
			);
		}

		if(file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/manufacturerlist.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/manufacturerlist.tpl';
		} else {
			$this->template = 'default/template/module/manufacturerlist.tpl';
		}

		$this->render();
	}
}

?>