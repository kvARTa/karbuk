<?php
class ModelCatalogSearchMr extends Model {

  /*
   * Modification of standart getProducts() metod add support morphology and relevance
   */
  public function getProducts($data = array()) {
    $this->load->model('catalog/product');
    $this->load->model('tool/morphy');    
    
    $search_mr_options = $this->config->get('search_mr_options');
    if (!$search_mr_options) {
      $search_mr_options = array();
    }
    
		if ($this->customer->isLogged()) {
			$customer_group_id = $this->customer->getCustomerGroupId();
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}	
		
		$cache = md5(http_build_query($data + $search_mr_options));
		
		$product_data = $this->cache->get('search.' . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.' . (int)$customer_group_id . '.' . $cache);
		
		if (!$product_data) {

					$words = explode(' ', trim(preg_replace('/\s\s+/', ' ', $data['filter_name'])));
					
            $words = $this->model_tool_morphy->getRoots($words);
			$where = "WHERE";
			$ind = 0;
			foreach($words as $word){
				if($ind == 0){
					$where .= " name LIKE '%".$word."%'";
				}else{
					$where .= " AND name LIKE '%".$word."%'";
				}
				$ind++;
			}
			$sql = "SELECT * FROM(SELECT * FROM (SELECT * FROM (SELECT p9.name as name, p7.product_id as product_id, p8.category_id as categ FROM `product` p7 LEFT JOIN `product_to_category` p8 ON p7.product_id = p8.product_id LEFT JOIN `product_description` p9 ON p9.product_id = p7.product_id) p10 ".$where.") p13 LEFT JOIN (
 SELECT * FROM (SELECT COUNT(product_id) as count, cat FROM (SELECT * FROM (SELECT p2.name as name, p1.product_id as product_id, p4.category_id as cat FROM `product` p1 LEFT JOIN `product_description` p2 ON p1.product_id = p2.product_id LEFT JOIN `product_to_category` p4 ON p1.product_id = p4.product_id) p3 ".$where.") p5 GROUP BY cat) p6 
 ) p11 ON p13.categ = p11.cat) p14 ORDER BY count DESC";
 
			if (isset($data['start']) || isset($data['limit'])) {
				if ($data['start'] < 0) {
					$data['start'] = 0;
				}				
	
				if ($data['limit'] < 1) {
					$data['limit'] = 20;
				}	
			
				$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
                      
			}

      $product_data = array();
			$x = $this->db->query("SELECT * FROM `".DB_PREFIX."product` WHERE model='".$data["filter_name"]."'");
			if($x->num_rows == 1){
				$product_data[$x->row["product_id"]] = $this->model_catalog_product->getProduct($x->row["product_id"]);
				$this->cache->set('search.' . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.' . (int)$customer_group_id . '.' . $cache, $product_data);
			}else{
				$query = $this->db->query($sql);
				foreach ($query->rows as $result) {
					$product_data[$result['product_id']] = $this->model_catalog_product->getProduct($result['product_id']);
				}
				
				$this->cache->set('search.' . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.' . (int)$customer_group_id . '.' . $cache, $product_data);
			}
		}
		
		return $product_data;
	}
	
  /*
   * Modification of standart getTotalProducts() metod add support morphology
   */	
	public function getTotalProducts($data = array()) {
     $this->load->model('catalog/product');
    $this->load->model('tool/morphy');    

	$words = explode(' ', trim(preg_replace('/\s\s+/', ' ', $data['filter_name'])));
					
            $words = $this->model_tool_morphy->getRoots($words);
			$where = "WHERE";
			$ind = 0;
			foreach($words as $word){
				if($ind == 0){
					$where .= " name LIKE '%".$word."%'";
				}else{
					$where .= " AND name LIKE '%".$word."%'";
				}
				$ind++;
			}
			$sql = "SELECT COUNT(*) AS total FROM(SELECT * FROM (SELECT * FROM (SELECT p9.name as name, p7.product_id as product_id, p8.category_id as categ FROM `product` p7 LEFT JOIN `product_to_category` p8 ON p7.product_id = p8.product_id LEFT JOIN `product_description` p9 ON p9.product_id = p7.product_id) p10 ".$where.") p13 LEFT JOIN (
 SELECT * FROM (SELECT COUNT(product_id) as count, cat FROM (SELECT * FROM (SELECT p2.name as name, p1.product_id as product_id, p4.category_id as cat FROM `product` p1 LEFT JOIN `product_description` p2 ON p1.product_id = p2.product_id LEFT JOIN `product_to_category` p4 ON p1.product_id = p4.product_id) p3 ".$where.") p5 GROUP BY cat) p6 
 ) p11 ON p13.categ = p11.cat) p14 ORDER BY count DESC";

		$query = $this->db->query($sql);
		
		return $query->row['total'];
	}

}
