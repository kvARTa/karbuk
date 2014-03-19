<?php
//session_start();
class ControllerProductSearchJson extends Controller
{
    /**
     * @var null data search category
     */
    protected $dataSearchCategory = null;
    /**
     * @var null data search product
     */
    protected $dataSearchProduct = null;
    /**
     * @var string keyword list
     */
    protected $keywordList = '';
    /**
     * @var string old keyword list
     */
    protected $oldKeywordList = '';

    /**
     * @param $string
     * @return string
     */
    protected function orfFilter($string)
    {
        /*Кол-во попадений не правильных слов в строке чтобы считать что строка написана в не правильной раскладке*/
        $countErrorWords = 0;
        /*счетчик не правильных слов*/
        $countError = 0;
        /*При попадении таких слов, считать что выбрана не правильная раскладка клавиатуры*/
        $errorWords = array('b', 'd', 'yt', 'jy', 'yf', 'z', 'xnj', 'c', 'cj', 'njn', ',snm', 'f', 'dtcm', "'nj", 'rfr', 'jyf', 'gj', 'yj', 'jyb', 'r', 'e', 'ns', 'bp', 'pf', 'ds', 'nfr', ';t', 'jn', 'crfpfnm', "'njn", 'rjnjhsq', 'vjxm', 'xtkjdtr', 'j', 'jlby', 'tot', ',s', 'nfrjq', 'njkmrj', 'ct,z', 'cdjt', 'rfrjq', 'rjulf', 'e;t', 'lkz', 'djn', 'rnj', 'lf', 'ujdjhbnm', 'ujl', 'pyfnm', 'vjq', 'lj', 'bkb', 'tckb', 'dhtvz', 'herf', 'ytn', 'cfvsq', 'yb', 'cnfnm', ',jkmijq', 'lf;t', 'lheujq', 'yfi', 'cdjq', 'ye', 'gjl', 'ult', 'ltkj', 'tcnm', 'cfv', 'hfp', 'xnj,s', 'ldf', 'nfv', 'xtv', 'ukfp', ';bpym', 'gthdsq', 'ltym', 'nenf', 'ybxnj', 'gjnjv', 'jxtym', '[jntnm', 'kb', 'ghb', 'ujkjdf', 'yflj', ',tp', 'dbltnm', 'blnb', 'ntgthm', 'nj;t', 'cnjznm', 'lheu', 'ljv', 'ctqxfc', 'vj;yj', 'gjckt', 'ckjdj', 'pltcm', 'levfnm', 'vtcnj', 'cghjcbnm', 'xthtp', 'kbwj', 'njulf', 'dtlm', '[jhjibq', 'rf;lsq', 'yjdsq', ';bnm', 'ljk;ys', 'cvjnhtnm', 'gjxtve', 'gjnjve', 'cnjhjyf', 'ghjcnj', 'yjuf', 'cbltnm', 'gjyznm', 'bvtnm', 'rjytxysq', 'ltkfnm', 'dlheu', 'yfl', 'dpznm', 'ybrnj', 'cltkfnm', 'ldthm', 'gthtl', 'ye;ysq', 'gjybvfnm', 'rfpfnmcz', 'hf,jnf', 'nhb', 'dfi', 'e;', 'ptvkz', 'rjytw', 'ytcrjkmrj', 'xfc', 'ujkjc', 'ujhjl', 'gjcktlybq', 'gjrf', '[jhjij', 'ghbdtn', 'pljhjdj', 'pljhjdf', 'ntcn', 'yjdjq', 'jr', 'tuj', 'rjt', 'kb,j', 'xnjkb', 'ndj.', 'ndjz', 'nen', 'zcyj', 'gjyznyj', 'x`', 'xt');
        /*Символы которые нужно исключить из строки*/
        $delChar = array('!' => '', '&' => '', '?' => '', '/' => '');
        /*Исключения*/
        $expectWord = array('.ьу' => '/me');
        /*Символы для замены на русские*/
        $arrReplace = array('q' => 'й', 'w' => 'ц', 'e' => 'у', 'r' => 'к', 't' => 'е', 'y' => 'н', 'u' => 'г', 'i' => 'ш', 'o' => 'щ', 'p' => 'з', '[' => 'х', ']' => 'ъ', 'a' => 'ф', 's' => 'ы', 'd' => 'в', 'f' => 'а', 'g' => 'п', 'h' => 'р', 'j' => 'о', 'k' => 'л', 'l' => 'д', ';' => 'ж', "'" => 'э', 'z' => 'я', 'x' => 'ч', 'c' => 'с', 'v' => 'м', 'b' => 'и', 'n' => 'т', 'm' => 'ь', ',' => 'б', '.' => 'ю', '/' => '.', '`' => 'ё', 'Q' => 'Й', 'W' => 'Ц', 'E' => 'У', 'R' => 'К', 'T' => 'Е', 'Y' => 'Н', 'U' => 'Г', 'I' => 'Ш', 'O' => 'Щ', 'P' => 'З', '{' => 'Х', '}' => 'Ъ', 'A' => 'Ф', 'S' => 'Ы', 'D' => 'В', 'F' => 'А', 'G' => 'П', 'H' => 'Р', 'J' => 'О', 'K' => 'Л', 'L' => 'Д', ':' => 'Ж', '"' => 'Э', '|' => '/', 'Z' => 'Я', 'X' => 'Ч', 'C' => 'С', 'V' => 'М', 'B' => 'И', 'N' => 'Т', 'M' => 'Ь', '<' => 'Б', '>' => 'Ю', '?' => ',', '~' => 'Ё', '@' => '"', '#' => '№', '$' => ';', '^' => ':', '&' => '?');
        /*Меняем ключ со значением в массиве $arrReplace*/
        $arrReplace2 = array_flip($arrReplace);
        /*Удаляем некоторые символы*/
        unset($arrReplace2['.']);
        unset($arrReplace2[',']);
        unset($arrReplace2[';']);
        unset($arrReplace2['"']);
        unset($arrReplace2['?']);
        unset($arrReplace2['/']);
        /*И соединяем массивы в один*/
        $arrReplace = array_merge($arrReplace, $arrReplace2);
        /*Переводим в нижний регистр, удаляем пробелы с начала и конца, разбиваем предложение на слова*/
        $string2 = strtr(trim(strtolower($string)), $delChar);
        $arrString = explode(" ", $string2);
        /*Проверям есть ли неправильно написаные слова и считаем их кол-во*/
        foreach ($arrString as $val) {
            if (array_search($val, $errorWords)) {
                $countError++;
            }
        }
        return ($countError >= $countErrorWords) ? strtr(strtr($string, $arrReplace), $expectWord) : $string;
    }

    protected function changeKeyboardLayout($keyword)
    {
        $this->keywordList = $this->orfFilter($keyword);
        // params search category
        $this->dataSearchCategory = array(
            'filter_name' => $this->keywordList,
            'limit' => 0,
            'start' => 0
        );

        // params search products
        $this->dataSearchProduct = array(
            'filter_tag' => $this->keywordList,
            'filter_name' => $this->keywordList,
            'limit' => 5,
            'start' => 0
        );
    }

    /**
     * Index method search
     * - load models
     * - search category
     * - search products
     * - get total count result
     * - put result to json
     */
    public function index()
    {
        $this->language->load('product/search_json');

        $json = array();
        $this->data['products'] = array();

        if (isset($this->request->get['keyword'])) {

            $this->keywordList = $this->request->get['keyword'];
//            $_SESSION['newKeywordList'] = $this->keywordList;

            $this->load->model('tool/image');
            $this->load->model('catalog/category_search');
            $this->load->model('catalog/product');

            // params search category
            $this->dataSearchCategory = array(
                'filter_name' => $this->keywordList,
                'limit' => 0,
                'start' => 0
            );

            // params search products
            $this->dataSearchProduct = array(
                'filter_tag' => $this->keywordList,
                'filter_name' => $this->keywordList,
                'limit' => 5,
                'start' => 0
            );

            // total count category
            $category_total = $this->model_catalog_category_search->getTotalCategories($this->dataSearchCategory);
            // total count products
            $product_total = $this->model_catalog_product->getTotalProducts($this->dataSearchProduct);

            if ($category_total == 0 && $product_total == 0) {
                $this->changeKeyboardLayout($this->keywordList);
                // total count category
                $category_total = $this->model_catalog_category_search->getTotalCategories($this->dataSearchCategory);
                // total count products
                $product_total = $this->model_catalog_product->getTotalProducts($this->dataSearchProduct);

                if ($category_total == 0 && $product_total == 0) {
                    $this->changeKeyboardLayout($this->keywordList);
                }

                if ($category_total > 0 || $product_total > 0) {
                    $_SESSION['keywordList'] = $this->keywordList;
                }
//
//                if (isset($_SESSION['keywordList'])) {
//                    $oldKeywordList = $_SESSION['keywordList'];
//                    $lengthOldKeyword = strlen($oldKeywordList);
//                    //$this->keywordList = $oldKeywordList;
//                    $lengthNewKeyword = strlen($_SESSION['newKeywordList']);
//                    $sizeDifference = $lengthNewKeyword - $lengthOldKeyword;
//                    //$this->keywordList = $sizeDifference;
//                    $badWorld = substr($this->keywordList, - $sizeDifference);
//                    //$_SESSION['keywordList'] = $oldKeywordList . $this->orfFilter($badWorld);
//                    $this->keywordList = $oldKeywordList . $this->orfFilter($badWorld);
//                    $this->changeKeyboardLayout($this->keywordList);
//                    $_SESSION['keywordList'] = $this->keywordList;
//                    // total count category
//                    $category_total = $this->model_catalog_category_search->getTotalCategories($this->dataSearchCategory);
//                    // total count products
//                    $product_total = $this->model_catalog_product->getTotalProducts($this->dataSearchProduct);
//                }
            } else {
                $_SESSION['keywordList'] = $this->keywordList;
            }

            if (empty($_SESSION['keywordList'])) {
                $_SESSION['keywordList'] = null;
            }

            if ($category_total) {

                // search
                $results = $this->model_catalog_category_search->getCategoriesByData($this->dataSearchCategory);

                foreach ($results as $result) {

                    if ($result['image']) {
                        $image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
                    } else {
                        $image = false;
                    }

                    $categoryPath = $this->model_catalog_category_search->getCategoryPath($result['category_id']);

                    $this->data['products'][] = array(
                        'product_id' => $result['category_id'],
                        'thumb' => $image,
                        'name' => htmlspecialchars_decode($result['name']),
                        'href' => str_replace('&amp;', '&', $this->url->link('product/category', 'path=' . $categoryPath)),
                        //'href' => str_replace('&amp;', '&', $this->url->link('product/category', 'path=' . $categoryPath . '&product_id=' . $result['category_id'])),
                        'typeResult' => 'category',
                        'keywordList' => $this->keywordList,
                    );

                }
            }

            if ($product_total) {

                // search products
                $results = $this->model_catalog_product->getProducts($this->dataSearchProduct);

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

                    if ($this->config->get('config_review_status')) {
                        $rating = (int)$result['rating'];
                    } else {
                        $rating = false;
                    }

                    $categoryPath = $this->model_catalog_category_search->getCategoryPath($result['category_id']);

                    $this->data['products'][] = array(
                        'product_id' => $result['product_id'],
                        'thumb' => $image,
                        'name' => htmlspecialchars_decode($result['name']),
                        //'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 100) . '..',
                        'price' => $price,
                        'special' => $special,
                        //'tax'         => $tax,
                        //'rating'      => $result['rating'],
                        //'reviews'     => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
                        'href' => str_replace('&amp;', '&', $this->url->link('product/product', 'path=' . $categoryPath . '&product_id=' . $result['product_id'])),
                        'typeResult' => 'product',
                        'keywordList' => $this->keywordList,
                    );
                }
            }

            // total count search result
            if (empty($this->data['products'])) {
                $this->data['products'][] = array(
                    'product_id' => '',
                    'thumb' => '',
                    'name' => $this->language->get('text_no_result'),
                    //'description' => '',
                    'price' => '',
                    'special' => '',
                    //'tax'         => '',
                    //'rating'      => '',
                    //'reviews'     => '',
                    'href' => '',
                    'typeResult' => 'info',
                    'keywordList' => $this->keywordList,
                );
            } else if ($product_total> count($this->data['products'])) {
                $remainder_cnt = $product_total - count($this->data['products']);
                if ($remainder_cnt > 0) {
                    $this->data['products'][] = array(
                        'product_id' => '',
                        'thumb' => '',
                        'name' => $remainder_cnt . $this->language->get('more_results'),
                        //'description' => '',
                        'price' => '',
                        'special' => '',
                        //'tax'         => '',
                        //'rating'      => '',
                        //'reviews'     => '',
                        'href' => str_replace('&amp;', '&', $this->url->link('product/search', 'filter_name=' . $this->keywordList)),
                        'typeResult' => 'info',
                        'keywordList' => $this->keywordList,
                    );
                }
            }

            $json = $this->data['products'];

            $this->response->setOutput(json_encode($json));
        }
    }

}
