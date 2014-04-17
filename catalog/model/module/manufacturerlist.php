<?php
class ModelModuleManufacturerList extends Model {

	public function getManufacturers($category_id = 0, $limit = 0) {
		$manufacturer_data = $this->cache->get('manufacturerlist.' . (int)$this->config->get('config_store_id') . '.' . (int)$this->config->get('config_language_id') . '.' . (int)$category_id . '.' . (int)$limit);

		if(!$manufacturer_data) {
			$sql = "SELECT DISTINCT m.manufacturer_id, m.name, m.image FROM " . DB_PREFIX . "manufacturer m LEFT JOIN " . DB_PREFIX . "manufacturer_to_store m2s ON (m.manufacturer_id = m2s.manufacturer_id) ";
			$sql .= " LEFT JOIN " . DB_PREFIX . "product p ON (p.manufacturer_id=m.manufacturer_id) LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p2c.product_id=p.product_id)  WHERE m2s.store_id = '" . (int)$this->config->get('config_store_id') . "'";
			if($category_id) {
				$sql .= " AND p2c.category_id = " . (int)$category_id;
			}
			$sql .= " ORDER BY m.sort_order";
			if((int)$limit >0){
				$sql .=" LIMIT " . (int)$limit;
			}
			$query = $this->db->query($sql);
			$manufacturer_data = $query->rows;

			$this->cache->set('manufacturerlist.' . (int)$this->config->get('config_store_id') . '.' . (int)$this->config->get('config_language_id') . '.' . (int)$category_id . '.' . (int)$limit, $manufacturer_data);
		}

		return $manufacturer_data;
	}
}

?>