<?php

static $config = NULL;
static $log = NULL;

// Error Handler
function error_handler_for_export($errno, $errstr, $errfile, $errline) {
	global $config;
	global $log;
	
	switch ($errno) {
		case E_NOTICE:
		case E_USER_NOTICE:
			$errors = "Notice";
			break;
		case E_WARNING:
		case E_USER_WARNING:
			$errors = "Warning";
			break;
		case E_ERROR:
		case E_USER_ERROR:
			$errors = "Fatal Error";
			break;
		default:
			$errors = "Unknown";
			break;
	}
		
	if (($errors=='Warning') || ($errors=='Unknown')) {
		return true;
	}

	if ($config->get('config_error_display')) {
		echo '<b>' . $errors . '</b>: ' . $errstr . ' in <b>' . $errfile . '</b> on line <b>' . $errline . '</b>';
	}
	
	if ($config->get('config_error_log')) {
		$log->write('PHP ' . $errors . ':  ' . $errstr . ' in ' . $errfile . ' on line ' . $errline);
	}

	return true;
}


function fatal_error_shutdown_handler_for_export()
{
	$last_error = error_get_last();
	if ($last_error['type'] === E_ERROR) {
		// fatal error
		error_handler_for_export(E_ERROR, $last_error['message'], $last_error['file'], $last_error['line']);
	}
}


class ModelToolPrice extends Model {

	var $styles = array();
	var $max_name_length = 0;
	var $csv_content = '';



	function clean( &$str, $allowBlanks=FALSE ) {
		$result = "";
		$n = strlen( $str );
		for ($m=0; $m<$n; $m++) {
			$ch = substr( $str, $m, 1 );
			if (($ch==" ") && (!$allowBlanks) || ($ch=="\n") || ($ch=="\r") || ($ch=="\t") || ($ch=="\0") || ($ch=="\x0B")) {
				continue;
			}
			$result .= $ch;
		}
		return $result;
	}

	protected function getDefaultLanguageId( &$database ) {
		$code = $this->config->get('config_language');
		$sql = "SELECT language_id FROM `".DB_PREFIX."language` WHERE code = '$code'";
		$result = $database->query( $sql );
		$languageId = 1;
		if ($result->rows) {
			foreach ($result->rows as $row) {
				$languageId = $row['language_id'];
				break;
			}
		}
		return $languageId;
	}


	protected function getDefaultWeightUnit() {
		$weightUnit = $this->config->get( 'config_weight_class' );
		return $weightUnit;
	}


	protected function getDefaultMeasurementUnit() {
		$measurementUnit = $this->config->get( 'config_length_class' );
		return $measurementUnit;
	}

	function getCell(&$worksheet,$row,$col,$default_val='') {
		$col -= 1; // we use 1-based, PHPExcel uses 0-based column index
		$row += 1; // we use 0-based, PHPExcel used 1-based row index
		return ($worksheet->cellExistsByColumnAndRow($col,$row)) ? $worksheet->getCellByColumnAndRow($col,$row)->getValue() : $default_val;
	}

	function validateHeading( &$data, &$expected ) {
		$heading = array();
		$k = PHPExcel_Cell::columnIndexFromString( $data->getHighestColumn() );
		if ($k != count($expected)) {
			return FALSE;
		}
		$i = 0;
		for ($j=1; $j <= $k; $j+=1) {
			$heading[] = $this->getCell($data,$i,$j);
		}
		$valid = TRUE;
		for ($i=0; $i < count($expected); $i+=1) {
			if (!isset($heading[$i])) {
				$valid = FALSE;
				break;
			}
			if (strtolower($heading[$i]) != strtolower($expected[$i])) {
				$valid = FALSE;
				break;
			}
		}
		return $valid;
	}

	function clearCache() {
		$this->cache->delete('category');
		$this->cache->delete('category_description');
		$this->cache->delete('manufacturer');
		$this->cache->delete('product');
		$this->cache->delete('product_image');
		$this->cache->delete('product_option');
		$this->cache->delete('product_option_description');
		$this->cache->delete('product_option_value');
		$this->cache->delete('product_option_value_description');
		$this->cache->delete('product_to_category');
		$this->cache->delete('url_alias');
		$this->cache->delete('product_special');
		$this->cache->delete('product_discount');
	}

	function getStoreIdsForProducts( &$database ) {
		$sql =  "SELECT product_id, store_id FROM `".DB_PREFIX."product_to_store` ps;";
		$storeIds = array();
		$result = $database->query( $sql );
		foreach ($result->rows as $row) {
			$productId = $row['product_id'];
			$storeId = $row['store_id'];
			if (!isset($storeIds[$productId])) {
				$storeIds[$productId] = array();
			}
			if (!in_array($storeId,$storeIds[$productId])) {
				$storeIds[$productId][] = $storeId;
			}
		}
		return $storeIds;
	}


	function getLayoutsForProducts( &$database ) {
		$sql  = "SELECT pl.*, l.name FROM `".DB_PREFIX."product_to_layout` pl ";
		$sql .= "LEFT JOIN `".DB_PREFIX."layout` l ON pl.layout_id = l.layout_id ";
		$sql .= "ORDER BY pl.product_id, pl.store_id;";
		$result = $database->query( $sql );
		$layouts = array();
		foreach ($result->rows as $row) { 
			$productId = $row['product_id'];
			$storeId = $row['store_id'];
			$name = $row['name'];
			if (!isset($layouts[$productId])) {
				$layouts[$productId] = array();
			}
			$layouts[$productId][$storeId] = $name;
		}
		return $layouts;
	}


	function populateProductsWorksheet( &$worksheet, &$database, &$imageNames, $languageId, &$priceFormat, &$boxFormat, &$weightFormat, &$textFormat )
	{
		// Set the column widths
		$j = 0;
		$worksheet->setColumn($j,$j++,max(strlen('model'),10)+1);
		$worksheet->setColumn($j,$j++,max(strlen('name'),30)+1);
		$worksheet->setColumn($j,$j++,max(strlen('manufacturer'),10)+1);
		$worksheet->setColumn($j,$j++,max(strlen('price'),10)+1,$priceFormat);

		// The product headings row
		$i = 1;
		$j = 0;
		$worksheet->writeString( $i, $j++, 'model', $boxFormat );
		$worksheet->writeString( $i, $j++, 'name', $boxFormat );
		$worksheet->writeString( $i, $j++, 'manufacturer', $boxFormat );
		if ($this->customer->isLogged()){
		    $worksheet->writeString( $i, $j++, 'price', $boxFormat );
		}else{
		    $worksheet->writeString( $i, $j++, '', $boxFormat );
		}
		$worksheet->setRow( $i, 30, $boxFormat );
		
		// The actual products data
		$i += 1;
		$j = 0;
		$storeIds = $this->getStoreIdsForProducts( $database );
		$layouts = $this->getLayoutsForProducts( $database );
		$query  = "SELECT ";
		$query .= "  pd.name,";
		$query .= "  p.model,";
		$query .= "  m.name AS manufacturer,";
		$query .= "  p.price ";
		$query .= "FROM `".DB_PREFIX."product` p ";
		$query .= "LEFT JOIN `".DB_PREFIX."product_description` pd ON p.product_id=pd.product_id ";
		$query .= "  AND pd.language_id=$languageId ";
		$query .= "LEFT JOIN `".DB_PREFIX."manufacturer` m ON m.manufacturer_id = p.manufacturer_id ";
		$query .= "GROUP BY p.product_id ";
		$query .= "ORDER BY p.product_id; ";
		$result = $database->query( $query );
		foreach ($result->rows as $row) {
			$worksheet->setRow( $i, 26 );
			$worksheet->writeString( $i, $j++, $row['model'] );
			$worksheet->writeString( $i, $j++, html_entity_decode($row['name'],ENT_QUOTES,'UTF-8') );
			$worksheet->writeString( $i, $j++, $row['manufacturer'] );
			if ($this->customer->isLogged()){
			    $worksheet->write( $i, $j++, $row['price'], $priceFormat );
			}else{
			    $worksheet->write( $i, $j++, '', '');
			}
			$i += 1;
			$j = 0;
		}
	}

	protected function clearSpreadsheetCache() {
		$files = glob(DIR_CACHE . 'Spreadsheet_Excel_Writer' . '*');
		
		if ($files) {
			foreach ($files as $file) {
				if (file_exists($file)) {
					@unlink($file);
					clearstatcache();
				}
			}
		}
	}

	function writeCategory($category_id, $path){	
		$this->load->model('catalog/category');
		$this->load->model('catalog/product');

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

		$query = $this->db->query("select p.product_id,p.price,p.tax_class_id, p.model, pd.name, m.name AS manufacturer   
								   from product p 
								   	LEFT JOIN product_description pd ON p.product_id = pd.product_id 
								   	LEFT JOIN manufacturer m on m.manufacturer_id=p.manufacturer_id								   	
								   	INNER JOIN product_to_category ptc on ptc.product_id=p.product_id								   	
								   where p.status = 1 AND ptc.category_id=".$category_id." ORDER BY ".$sort." ".$order);
		$results = $query->rows;


		if($category_id){
			$category_info = $this->model_catalog_category->getCategory($category_id);

			$this->csv_content .= "<tr><th colspan=4><b>" .$category_info['name']."</b></td></tr>";
     		$this->csv_noprice_content .= "<tr><th colspan=3><b>" .$category_info['name']."</b></td></tr>";
		}		
		
		
	
		if(count($results)){
			foreach ($results as $product) {

			   $this->csv_content .= "<tr>";
		       $this->csv_content .= '<td>' . $product["model"] . '</td>';
		       $this->csv_content .= '<td><a href="'.$this->url->link('product/product', 'path=' . $path . '&product_id=' . $product['product_id']).'">' . $product["name"] . '</a></td>';
		       //$this->csv_content .= '"' . tep_href_link(FILENAME_PRODUCT_INFO,'products_id='.$product["products_id"]) . '"' .$delimeter;
		       $this->csv_content .= '<td>' . $product["manufacturer"] . '</td>';

		       $this->csv_noprice_content .= "<tr>";
		       $this->csv_noprice_content .= '<td>' . $product["model"] . '</td>';
		       $this->csv_noprice_content .= '<td><a href="'.$this->url->link('product/product', 'path=' . $path . '&product_id=' . $product['product_id']).'">' . $product["name"] . '</a></td>';
		       //$this->csv_content .= '"' . tep_href_link(FILENAME_PRODUCT_INFO,'products_id='.$product["products_id"]) . '"' .$delimeter;
		       $this->csv_noprice_content .= '<td>' . $product["manufacturer"] . '</td>';

		       if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')));
			   } else {
					$price = '';
			   }	

		       $this->csv_content .= '<td>' . $price . '</td>';
		       $this->csv_content .= "</tr>";
		       $this->csv_noprice_content .= "</tr>";			
			}	
		}		

		
			
		$results = $this->model_catalog_category->getCategories($category_id);
		//echo count($results);
		//die('asd');	
		foreach ($results as $result) {			
			$cpath = $path.'_'.$result['category_id'];
			$this->writeCategory($result['category_id'],$cpath);
			
		}
	}

	function rus2translit($string) {
	 $converter = array(

	        'а' => 'a',   'б' => 'b',   'в' => 'v',
	        'г' => 'g',   'д' => 'd',   'е' => 'e',
	        'ё' => 'e',   'ж' => 'zh',  'з' => 'z',
	        'и' => 'i',   'й' => 'y',   'к' => 'k',
	        'л' => 'l',   'м' => 'm',   'н' => 'n',
	        'о' => 'o',   'п' => 'p',   'р' => 'r',
	        'с' => 's',   'т' => 't',   'у' => 'u',
	        'ф' => 'f',   'х' => 'h',   'ц' => 'c',
	        'ч' => 'ch',  'ш' => 'sh',  'щ' => 'sch',
	        'ь' => '\'',  'ы' => 'y',   'ъ' => '\'',
	        'э' => 'e',   'ю' => 'yu',  'я' => 'ya',
	        'А' => 'A',   'Б' => 'B',   'В' => 'V',
	        'Г' => 'G',   'Д' => 'D',   'Е' => 'E',
	        'Ё' => 'E',   'Ж' => 'Zh',  'З' => 'Z',
	        'И' => 'I',   'Й' => 'Y',   'К' => 'K',
	        'Л' => 'L',   'М' => 'M',   'Н' => 'N',
	        'О' => 'O',   'П' => 'P',   'Р' => 'R',
	        'С' => 'S',   'Т' => 'T',   'У' => 'U',
	        'Ф' => 'F',   'Х' => 'H',   'Ц' => 'C',
	        'Ч' => 'Ch',  'Ш' => 'Sh',  'Щ' => 'Sch',
	        'Ь' => '\'',  'Ы' => 'Y',   'Ъ' => '\'',
	        'Э' => 'E',   'Ю' => 'Yu',  'Я' => 'Ya',

	    );

	    return strtr($string, $converter);

	}

	function str2url($str) {

	    // переводим в транслит

	    $str = $this->rus2translit($str);

	    // в нижний регистр

	    $str = strtolower($str);

	    // заменям все ненужное нам на "-"

	    $str = preg_replace('~[^-a-z0-9_]+~u', '-', $str);

	    // удаляем начальные и конечные '-'

	    $str = trim($str, "-");

	    return $str;

	}


	function download() {
		global $config;
		global $log;
		$config = $this->config;
		$log = $this->log;
		set_error_handler('error_handler_for_export',E_ALL);
		register_shutdown_function('fatal_error_shutdown_handler_for_export');
		$database =& $this->db;
		$languageId = $this->getDefaultLanguageId($database);

		$dir = dirname(__FILE__).'/../../../excel/';

		$path = isset($this->request->get['path'])?$this->request->get['path']:0;

		if (isset($this->request->get['path'])) {
			$path = '';		
			$parts = explode('_', (string)$this->request->get['path']);
			$category_id = end($parts);
			$path = $this->request->get['path'];
		}else{
			$category_id = 0;
			$path = '0';
		}	

		$this->load->model('catalog/category');

		if($category_id){
			$category_info = $this->model_catalog_category->getCategory($category_id);
			$top_category_name = $category_info['name'];
			
		}else{
			$top_category_name = '';	
		}	

		$fname = 'karbuk_price_'.$this->str2url($top_category_name). '_' . date("d-m-Y").'.xls';				

		$price_file = $dir . $fname . '.xls';
   		$noprice_file = $dir . $fname . '_noprice.xls';

		$filename = $dir.$fname;

		if (!file_exists($price_file)){
			$generate = true;
		}	
		else{
			$fl_param = stat($price_file);
		    if (time()-$fl_param['mtime']<86400) 
		    	$generate = false;
		    else 
		    	$generate = true;
		}
		if($generate){

		   error_reporting(E_ALL);
	       ini_set('show_errors',1);

		   $delimeter = "\t";
		    
		   $this->csv_content = $this->csv_noprice_content = '<html dir="LTR" lang="ru"><head><meta http-equiv="Content-Type" content="text/html; charset=windows-1251"></head><body>';

		   $this->csv_content .= "<table align=center border=1px><tr><th colspan=4>Karbuk.ru — комплексное снабжение организаций.<br> (495) 649-10-89, (495) 645-23-29</th></tr>";
		   $this->csv_content .= "<tr><th colspan=4>Прайс-лист категории &laquo;<b>".$top_category_name."</b>&raquo;</th></tr>";
		   $this->csv_content .= "<tr><td colspan=4>&nbsp;</td></tr>";
		   $this->csv_content .= "<tr><td>Код</td><td>Название</td><td>Производитель</td><td>Цена</td></tr>";

		   $this->csv_noprice_content .= "<table align=center border=1px><tr><th colspan=3>Karbuk.ru — комплексное снабжение организаций.<br> (495) 649-10-89, (495) 645-23-29</th></tr>";
		   $this->csv_noprice_content .= "<tr><th colspan=3>Прайс-лист категории &laquo;<b>".$top_category_name."</b>&raquo;</th></tr>";
		   $this->csv_noprice_content .= "<tr><td colspan=3>&nbsp;</td></tr>";
		   $this->csv_noprice_content .= "<tr><td>Код</td><td>Название</td><td>Производитель</td></tr>";


		   $this->writeCategory($category_id, $path);

		   $this->csv_noprice_content .= "</table></body></html>";
		   $this->csv_content .= "</table></body></html>";


		   $this->csv_content = iconv('UTF-8','windows-1251',$this->csv_content);
		   $this->csv_noprice_content = iconv('UTF-8','windows-1251',$this->csv_noprice_content);

		   //echo $this->csv_content;
		   //die();
		   
		   file_put_contents($price_file,  $this->csv_content);
		   file_put_contents($noprice_file,  $this->csv_noprice_content);
		}  

		  header("Expires: Mon, 26 Nov 1962 00:00:00 GMT");
		  header("Last-Modified: " . gmdate("D,d M Y H:i:s") . " GMT");
		  header("Cache-Control: no-cache, must-revalidate");
		  header("Pragma: no-cache");
		  header("Content-Type: Application/xls");
		  header("Content-disposition: attachment; filename=" . $fname . ".xls"); 

		  echo file_get_contents($price_file);

			
		if(false){
		
			set_include_path(get_include_path() . PATH_SEPARATOR .$dir.'Classes/');


			require_once $dir.'Classes/PHPExcel/IOFactory.php';



			


			//создаем объект класса-писателя
			include($dir."Classes/PHPExcel/Writer/Excel5.php");

			$path = $this->request->get['path'];

			$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
			$objWriter->save($filename);
		}

		
		
		exit;
	}


}
?>