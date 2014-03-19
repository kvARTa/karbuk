<?php
class ModelCatalogCategory extends Model {
	public function getCategory($category_id) {
		return $this->getCategories((int)$category_id, 'by_id');
	}

	public function getCategories($id = 0, $type = 'by_parent') {
		static $data = null;

		if ($data === null) {
			$data = array();

			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND c.status = '1' ORDER BY c.parent_id, c.sort_order, cd.name");

			foreach ($query->rows as $row) {
				$data['by_id'][$row['category_id']] = $row;
				$data['by_parent'][$row['parent_id']][] = $row;
			}
		}

		return ((isset($data[$type]) && isset($data[$type][$id])) ? $data[$type][$id] : array());
	}

	public function getCategoriesByParentId($category_id) {
		$category_data = array();

		$categories = $this->getCategories((int)$category_id);

		foreach ($categories as $category) {
			$category_data[] = $category['category_id'];

			$children = $this->getCategoriesByParentId($category['category_id']);

			if ($children) {
				$category_data = array_merge($children, $category_data);
			}
		}

		return $category_data;
	}
/*Вот она самая суть доработки здесь последовательно начиная от товара вычисляем зависимость категории от производителя*/
/* в базе это отдельные таблицы поэтому такие танцы с бубном */
	public function getManufacturers($category_id) {
		$manufacturers = $this->db->query("
			SELECT m.name, p.manufacturer_id
			FROM
				" . DB_PREFIX . "product p,
				" . DB_PREFIX . "manufacturer m,
				" . DB_PREFIX . "product_to_category ptc
			WHERE    ptc.category_id       = " . $category_id . "
			AND      ptc.product_id        = p.product_id
			AND      p.manufacturer_id     = m.manufacturer_id
			GROUP BY p.manufacturer_id ORDER BY m.sort_order ASC"
		);
		return $manufacturers->rows;
	}
/*Здесь подготавливаем массив для прогона в контролере т.е. $category_id загоняем в функцию выше*/
	public function getManufacturersToForm($category_id) {
		$manufacturers_data = $this->getManufacturers($category_id);
		return $manufacturers_data;
	}

	public function getCategoryLayoutId($category_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_to_layout WHERE category_id = '" . (int)$category_id . "' AND store_id = '" . (int)$this->config->get('config_store_id') . "'");

		if ($query->num_rows) {
			return $query->row['layout_id'];
		} else {
			return $this->config->get('config_layout_category');
		}
	}

	public function getTotalCategoriesByCategoryId($parent_id = 0) {
		return count($this->getCategories((int)$parent_id));
	}
}
?>