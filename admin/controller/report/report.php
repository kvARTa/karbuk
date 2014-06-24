<?php
/**
 * @autor: Rostislav Shvets
 * Date: 23.06.14
 */

class ControllerReportReport extends Controller
{
    public function index(){
        $this->load->language('report/report');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('report/report', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->data['items'] = array();

        $this->load->model('catalog/product');

        $products = $this->model_catalog_product->getProducts();

        $this->load->model('report/report');
        $products_without_img = $this->model_report_report->getProductsWithoutPictures($products);
        //print_r($products_without_img);
        $products_without_attr = $this->model_report_report->getProductsWithoutAttributes();
        $category_without_products = $this->model_report_report->getCategoriesWithoutProducts();
        $category_without_cat_and_prod = $this->model_report_report->getCategoriesWithoutCatAndProd();

        $this->data['items'] = array(
            'Товары без картинок'                   => $products_without_img,
            'Товары без характеристик'              => $products_without_attr,
            'Пустые категории'                      => $category_without_products,
            'Товары на одном уровне с категорией'   => $category_without_cat_and_prod
        );
        //print_r($this->data['items']);


        $this->data['heading_title'] = $this->language->get('heading_title');
        $this->data['text_no_results'] = $this->language->get('text_no_results');

//        $this->template = 'report/report.tpl';
//        $this->children = array(
//            'common/header',
//            'common/footer'
//        );
//        $this->response->setOutput($this->render());

        $csv = $this->model_report_report->prepareCsv($this->data['items']);

        $this->response->addheader('Pragma: public');
        $this->response->addheader('Connection: Keep-Alive');
        $this->response->addheader('Expires: 0');
        $this->response->addheader('Content-Description: File Transfer');
        $this->response->addheader('Content-Type: application/octet-stream');
        $this->response->addheader('Content-Disposition: attachment; filename=report.csv');
        $this->response->addheader('Content-Transfer-Encoding: binary');
        $this->response->addheader('Content-Length: '. strlen($csv));
        $this->response->setOutput($csv);
    }
} 