<?php 
class ControllerToolPrice extends Controller { 
	public function download() {

		// set appropriate memory and timeout limits
		//ini_set("memory_limit","128M");
		//set_time_limit( 1800 );

		// send the categories, products and options as a spreadsheet file
		$this->load->model('tool/price');
		$this->model_tool_price->download();
	}
}
?>