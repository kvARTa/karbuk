<?php  
class ControllerModuleLogin extends Controller {
	protected function index() {
		$this->language->load('module/login');

      	$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['entry_email_address'] = $this->language->get('entry_email_address');
		$this->data['entry_password'] = $this->language->get('entry_password');
		
		$this->data['button_login'] = $this->language->get('button_login');
		$this->data['button_logout'] = $this->language->get('button_logout');
		$this->data['button_create'] = $this->language->get('button_create');
		
		$this->data['action'] = 'index.php?route=account/login';
 		
		$this->id       = 'login';
		//$this->template = $this->config->get('config_template') . 'module/login.tpl';
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/login.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/module/login.tpl';
        } elseif (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . 'module/login.tpl')) { //v1.3.2
				$this->template = $this->config->get('config_template') . 'module/login.tpl';
		} else {
            $this->template = 'default/template/module/login.tpl';
        }
		
		$this->render();
		
	}
}
?>