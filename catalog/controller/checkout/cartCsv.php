<?php 
class ControllerCartCsv extends Controller {

	public function addCartCsv(){
	//$this->load->model('cartcsv/csv');
		$fileDir = 'tmp' . DIRECTORY_SEPARATOR . 'cart.csv';
		$data= array();
		$products = $this->cart->getProducts();
		foreach ($products as $product){
			$productData[] = array('product_id' => $product['product_id'], 
									'quantity' => $product['quantity']
									);
 		}

		
              //print_r($parseData);die;
		//$headersCsv = array();
		$headersCsv = array ('Артикул','Количество');
		$dataRender[] = join(';', $headersCsv);
		foreach ($productData as $data) {
			$rowCsvArray  = array(
				$data['product_id'],
				$data['quantity']);
				
				$dataRender[] = join(';', $rowCsvArray);
		}
		//$headersCsv = join(';', $headersCsv);
		//$dataRender = array_merge($headersCsv, $dataRender);
               
		$dataCsv = mb_convert_encoding(join("\n", $dataRender), "windows-1251", "UTF-8");
		
		file_put_contents($fileDir, $dataCsv);
		
		$this->response->setOutput($fileDir);
		
	}	
}