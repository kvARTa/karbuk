<?php 
class ControllerInformationFeedback extends Controller {
	private $error = array(); 
	    
  	public function index() {
		$this->language->load('information/feedback');

		$this->document->setTitle($this->language->get('heading_title'));  


		
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
				$messages = $this->language->get('messages');
				$mailto = $messages[$this->request->post['subj']]['email'];
				
				$mail = new Mail();
				$mail->protocol = $this->config->get('config_mail_protocol');
				$mail->parameter = $this->config->get('config_mail_parameter');
				$mail->hostname = $this->config->get('config_smtp_host');
				$mail->username = $this->config->get('config_smtp_username');
				$mail->password = $this->config->get('config_smtp_password');
				$mail->port = $this->config->get('config_smtp_port');
				$mail->timeout = $this->config->get('config_smtp_timeout');				
				//$mail->setTo($this->config->get('config_email_feedback'));
				$mail->setTo($mailto);				
				
				$mail->setSender($this->request->post['name']);
				$mail->setFrom($this->config->get('config_email'));
				$mail->setSubject(html_entity_decode(sprintf($this->language->get('email_subject'), $messages[$this->request->post['subj']]['text']), ENT_QUOTES, 'UTF-8'));

				$text = "";
				$text.= sprintf($this->language->get('email_name'), $this->request->post['name'])."\n";
				$text.= sprintf($this->language->get('email_city'), $this->request->post['city'])."\n";
				$text.= sprintf($this->language->get('email_company'), $this->request->post['company'])."\n";
				$text.= sprintf($this->language->get('email_email'), $this->request->post['email'])."\n";
				$text.= sprintf($this->language->get('email_phone'), $this->request->post['phone'])."\n\n";

				$text.= strip_tags(html_entity_decode($this->request->post['enquiry'], ENT_QUOTES, 'UTF-8'));				
				
				
				$mail->setText($text);
				
				$mail->send();

				$this->redirect($this->url->link('information/feedback/success'));
		}

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),        	
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('information/feedback'),
			'separator' => $this->language->get('text_separator')
		);	
				
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_contact'] = $this->language->get('text_contact');
		$this->data['entry_good'] = $this->language->get('entry_good');
		$this->data['entry_bad'] = $this->language->get('entry_bad');

		$this->data['entry_name'] = $this->language->get('entry_name');

		$this->data['entry_city'] = $this->language->get('entry_city');
		$this->data['entry_company'] = $this->language->get('entry_company');
		$this->data['entry_email'] = $this->language->get('entry_email');
		$this->data['entry_phone'] = $this->language->get('entry_phone');


		$this->data['entry_enquiry'] = $this->language->get('entry_enquiry');
		$this->data['entry_rating'] = $this->language->get('entry_rating');
		$this->data['entry_captcha'] = $this->language->get('entry_captcha');

		$this->data['entry_subj'] = $this->language->get('entry_subj');

		$this->data['messages'] = $this->language->get('messages');

		if (isset($this->error['subj'])) {

    		$this->data['error_subj'] = $this->error['subj'];
		} else {
			$this->data['error_subj'] = '';
		}

		if (isset($this->error['name'])) {
    		$this->data['error_name'] = $this->error['name'];
		} else {
			$this->data['error_name'] = '';
		}

		if (isset($this->error['phone'])) {
    		$this->data['error_phone'] = $this->error['phone'];
		} else {
			$this->data['error_phone'] = '';
		}

		if (isset($this->error['city'])) {
    		$this->data['error_city'] = $this->error['city'];
		} else {
			$this->data['error_city'] = '';
		}

		if (isset($this->error['email'])) {
    		$this->data['error_email'] = $this->error['email'];
		} else {
			$this->data['error_email'] = '';
		}
		
		if (isset($this->error['enquiry'])) {
			$this->data['error_enquiry'] = $this->error['enquiry'];
		} else {
			$this->data['error_enquiry'] = '';
		}

 		if (isset($this->error['captcha'])) {
			$this->data['error_captcha'] = $this->error['captcha'];
		} else {
			$this->data['error_captcha'] = '';
		}	

		$this->data['button_continue'] = $this->language->get('button_continue');
    
		$this->data['action'] = $this->url->link('information/feedback');
		$this->data['store'] = $this->config->get('config_name');
		$this->data['address'] = nl2br($this->config->get('config_address'));
		$this->data['telephone'] = $this->config->get('config_telephone');
		$this->data['fax'] = $this->config->get('config_fax');


		if (isset($this->request->post['subj'])) {
			$this->data['subj'] = $this->request->post['subj'];
		} else {
			$this->data['subj'] = 0;
		}
    	
		if (isset($this->request->post['name'])) {
			$this->data['name'] = $this->request->post['name'];
		} else {
			$this->data['name'] = $this->customer->getFirstName();
		}

		if (isset($this->request->post['city'])) {
			$this->data['city'] = $this->request->post['city'];
		} else {
			$this->data['city'] = '';
		}

		if (isset($this->request->post['company'])) {
			$this->data['company'] = $this->request->post['company'];
		} else {
			$this->data['company'] = '';
		}

		if (isset($this->request->post['email'])) {
			$this->data['email'] = $this->request->post['email'];
		} else {
			$this->data['email'] = '';
		}

		if (isset($this->request->post['phone'])) {
			$this->data['phone'] = $this->request->post['phone'];
		} else {
			$this->data['phone'] = '';
		}
		
		if (isset($this->request->post['enquiry'])) {
			$this->data['enquiry'] = $this->request->post['enquiry'];
		} else {
			$this->data['enquiry'] = '';
		}
		
		if (isset($this->request->post['rating'])) {
			$this->data['rating'] = $this->request->post['rating'];
		} else {
			$this->data['rating'] = '';
		}

		if (isset($this->request->post['captcha'])) {
			$this->data['captcha'] = $this->request->post['captcha'];
		} else {
			$this->data['captcha'] = '';
		}		

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/feedback.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/information/feedback.tpl';
		} else {
			$this->template = 'default/template/information/contact.tpl';
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

  	public function success() {
		$this->language->load('information/feedback');

		$this->document->setTitle($this->language->get('heading_title')); 

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('information/feedback'),
			'separator' => $this->language->get('text_separator')
		);	
			
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_message'] = $this->language->get('text_message');

		$this->data['button_continue'] = $this->language->get('button_continue');

		$this->data['continue'] = $this->url->link('common/home');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/success.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/success.tpl';
		} else {
			$this->template = 'default/template/common/success.tpl';
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

  		if (!intval($this->request->post['subj']) ) {
			$this->error['subj'] = $this->language->get('error_subj');
		}

		if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 32)) {
			$this->error['name'] = $this->language->get('error_name');
		}

		if ((utf8_strlen($this->request->post['email']) < 3) ) {
			$this->error['email'] = $this->language->get('error_email');
		}
		if ((utf8_strlen($this->request->post['phone']) < 3) ) {
			$this->error['phone'] = $this->language->get('error_phone');
		}
		if ((utf8_strlen($this->request->post['city']) < 3) ) {
			$this->error['city'] = $this->language->get('error_city');
		}

		if ((utf8_strlen($this->request->post['enquiry']) < 10) || (utf8_strlen($this->request->post['enquiry']) > 3000)) {
			$this->error['enquiry'] = $this->language->get('error_enquiry');
		}

		if (empty($this->session->data['captcha']) || ($this->session->data['captcha'] != $this->request->post['captcha'])) {
			$this->error['captcha'] = $this->language->get('error_captcha');
		}
		
	
		if (!$this->error) {
	  		return true;
		} else {
	  		return false;
		}  	  
  	}

	public function captcha() {
		$this->load->library('captcha');
		
		$captcha = new Captcha();
		
		$this->session->data['captcha'] = $captcha->getCode();
		
		$captcha->showImage();
	}	
}
?>
