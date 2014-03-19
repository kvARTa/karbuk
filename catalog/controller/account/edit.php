<?php
class ControllerAccountEdit extends Controller {
	private $error = array();

	public function index() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/edit', '', 'SSL');

			$this->redirect($this->url->link('account/login', '', 'SSL'));
		}

		$this->language->load('account/edit');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('account/customer');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_account_customer->editCustomer($this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('account/account', '', 'SSL'));
		}

      	$this->data['breadcrumbs'] = array();

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),     	
        	'separator' => false
      	); 

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_account'),
			'href'      => $this->url->link('account/account', '', 'SSL'),        	
        	'separator' => $this->language->get('text_separator')
      	);

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_edit'),
			'href'      => $this->url->link('account/edit', '', 'SSL'),       	
        	'separator' => $this->language->get('text_separator')
      	);
		
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_your_details'] = $this->language->get('text_your_details');
		$this->data['entry_login'] = $this->language->get('entry_login');

		$this->data['entry_firstname'] = $this->language->get('entry_firstname');
		$this->data['entry_lastname'] = $this->language->get('entry_lastname');
		$this->data['entry_email'] = $this->language->get('entry_email');
		$this->data['entry_telephone'] = $this->language->get('entry_telephone');
		$this->data['entry_company'] = $this->language->get('entry_company');
		$this->data['entry_inn'] = $this->language->get('entry_inn');
		$this->data['entry_kpp'] = $this->language->get('entry_kpp');
		$this->data['entry_ur_address'] = $this->language->get('entry_ur_address');
		$this->data['entry_fact_address'] = $this->language->get('entry_fact_address');
		$this->data['entry_manager'] = $this->language->get('entry_manager');

		$this->data['button_continue'] = $this->language->get('button_continue');
		$this->data['button_back'] = $this->language->get('button_back');

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->error['firstname'])) {
			$this->data['error_firstname'] = $this->error['firstname'];
		} else {
			$this->data['error_firstname'] = '';
		}
		
		if (isset($this->error['email'])) {
			$this->data['error_email'] = $this->error['email'];
		} else {
			$this->data['error_email'] = '';
		}	
		
		if (isset($this->error['telephone'])) {
			$this->data['error_telephone'] = $this->error['telephone'];
		} else {
			$this->data['error_telephone'] = '';
		}

		if (isset($this->error['company'])) {
			$this->data['error_company'] = $this->error['company'];
		} else {
			$this->data['error_company'] = '';
		}

		if (isset($this->error['inn'])) {
			$this->data['error_inn'] = $this->error['inn'];
		} else {
			$this->data['error_inn'] = '';
		}

		$this->data['action'] = $this->url->link('account/edit', '', 'SSL');

		if ($this->request->server['REQUEST_METHOD'] != 'POST') {
			$customer_info = $this->model_account_customer->getCustomer($this->customer->getId());
		}

		if (isset($this->request->post['login'])) {
			$this->data['login'] = $this->request->post['login'];
		} elseif (isset($customer_info)) {
			$this->data['login'] = $customer_info['login'];
		} else {
			$this->data['login'] = '';
		}

		if (isset($this->request->post['firstname'])) {
			$this->data['firstname'] = $this->request->post['firstname'];
		} elseif (isset($customer_info)) {
			$this->data['firstname'] = $customer_info['firstname'];
		} else {
			$this->data['firstname'] = '';
		}

		if (isset($this->request->post['lastname'])) {
			$this->data['lastname'] = $this->request->post['lastname'];
		} elseif (isset($customer_info)) {
			$this->data['lastname'] = $customer_info['lastname'];
		} else {
			$this->data['lastname'] = '';
		}

		if (isset($this->request->post['email'])) {
			$this->data['email'] = $this->request->post['email'];
		} elseif (isset($customer_info)) {
			$this->data['email'] = $customer_info['email'];
		} else {
			$this->data['email'] = '';
		}

		if (isset($this->request->post['telephone'])) {
			$this->data['telephone'] = $this->request->post['telephone'];
		} elseif (isset($customer_info)) {
			$this->data['telephone'] = $customer_info['telephone'];
		} else {
			$this->data['telephone'] = '';
		}

		if (isset($this->request->post['company'])) {
			$this->data['company'] = $this->request->post['company'];
		} elseif (isset($customer_info)) {
			$this->data['company'] = $customer_info['company'];
		} else {
			$this->data['company'] = '';
		}

		if (isset($this->request->post['inn'])) {
			$this->data['inn'] = $this->request->post['inn'];
		} elseif (isset($customer_info)) {
			$this->data['inn'] = $customer_info['inn'];
		} else {
			$this->data['inn'] = '';
		}
		if (isset($this->request->post['kpp'])) {
			$this->data['kpp'] = $this->request->post['kpp'];
		} elseif (isset($customer_info)) {
			$this->data['kpp'] = $customer_info['kpp'];
		} else {
			$this->data['kpp'] = '';
		}
		if (isset($this->request->post['ur_address'])) {
			$this->data['ur_address'] = $this->request->post['ur_address'];
		} elseif (isset($customer_info)) {
			$this->data['ur_address'] = $customer_info['ur_address'];
		} else {
			$this->data['ur_address'] = '';
		}
		if (isset($this->request->post['fact_address'])) {
			$this->data['fact_address'] = $this->request->post['fact_address'];
		} elseif (isset($customer_info)) {
			$this->data['fact_address'] = $customer_info['fact_address'];
		} else {
			$this->data['fact_address'] = '';
		}
		if (isset($this->request->post['manager'])) {
			$this->data['manager'] = $this->request->post['manager'];
		} elseif (isset($customer_info)) {
			$this->data['manager'] = $customer_info['manager'];
		} else {
			$this->data['manager'] = '';
		}

		$this->data['back'] = $this->url->link('account/account', '', 'SSL');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/edit.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/account/edit.tpl';
		} else {
			$this->template = 'default/template/account/edit.tpl';
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

	private function validate() {
		if ((utf8_strlen($this->request->post['firstname']) < 1) || (utf8_strlen($this->request->post['firstname']) > 32)) {
			$this->error['firstname'] = $this->language->get('error_firstname');
		}

		if ((utf8_strlen($this->request->post['email']) > 96) || !preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $this->request->post['email'])) {
			$this->error['email'] = $this->language->get('error_email');
		}
		
		if (($this->customer->getEmail() != $this->request->post['email']) && $this->model_account_customer->getTotalCustomersByEmail($this->request->post['email'])) {
			$this->error['warning'] = $this->language->get('error_exists');
		}

		if ((utf8_strlen($this->request->post['telephone']) < 3) || (utf8_strlen($this->request->post['telephone']) > 32)) {
			$this->error['telephone'] = $this->language->get('error_telephone');
		}

		if ((utf8_strlen($this->request->post['company']) < 1) || (utf8_strlen($this->request->post['company']) > 32)) {
			$this->error['company'] = $this->language->get('error_company');
		}

		if ((utf8_strlen($this->request->post['inn']) < 1) || (utf8_strlen($this->request->post['inn']) > 12)) {
			$this->error['inn'] = $this->language->get('error_inn');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
}
?>