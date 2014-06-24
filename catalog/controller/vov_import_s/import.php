<?php   
class ControllerVovImportsImport extends Controller {
	public function index() {		

		$this->load->model('vov_import_s/import');
		echo "start\n";

// 		$customers = $this->model_vov_import_s_import->load_cust();
// 		foreach($customers as $cust){
// 			$this->model_vov_import_s_import->addCustomer($cust);
// 		}
// 		die;

		$this->model_vov_import_s_import->load_to_mysql();
		echo "dba loaded\n";

 		//$this->model_vov_import_s_import->delete_categories();
		$this->model_vov_import_s_import->delete_discount();
 		//$this->model_vov_import_s_import->delete_products();
 		//$this->model_vov_import_s_import->delete_manufacturers();
		$this->model_vov_import_s_import->delete_attributes();

		echo "base cleared\n";

       // $this->model_vov_import_s_import->upCategoryIds();

		$this->model_vov_import_s_import->import_categories();
		//echo "categories done\n";

        //$this->model_vov_import_s_import->upProductsIds();
        //echo "products ids changed\n";
       // $this->model_vov_import_s_import->import_products2();
        //echo "new products ids changed\n";
		$this->model_vov_import_s_import->import_products();
		//echo "products done\n";
		
		$this->model_vov_import_s_import->import_xsell();
		echo "xsell done\n";
		
		$this->model_vov_import_s_import->delete_absent();
		echo "absent deleted\n";
		
		$this->cache->delete('category');
		$this->cache->delete('product');
		$this->cache->delete('manufacturer');
		
		$this->response->setOutput("all done\n");
  	}
}
?>