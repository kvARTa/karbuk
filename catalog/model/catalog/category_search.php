<?php
class ModelCatalogCategorySearch extends Model
{
	protected $_items = array();
	protected $_childs = array();

	/**
	 * Проверка на наличие элемента
	 * @param mixed $id
	 * @return boolean
	 */
	public function itemExists($id){
		return isset($this->_items[$id]);
	}
	/**
	 * Получить кол-во элементов дерева.
	 * @return integer
	 */
	public function getCount(){
		return sizeof($this->_items);
	}
	/**
	 * Добавление элемента в дерево
	 * @param mixed $id
	 * @param mixed $parent
	 * @param mixed $data
	 * @return void
	 */
	public function addItem($id , $parent = 0 , $data)
	{
		$this->_items[$id] = array(
			'id'=>$id ,
			'parent'=>$parent ,
			'data'=>$data
		);

		if(empty($this->_childs[$parent]))
			$this->_childs[$parent] = array();

		/*
		* Cсылка использована преднамеренно, на производительность не влияет,
		* но позволяет изменять элементы, например, при внедрении сортировки
		*/
		$this->_childs[$parent][$id] = & $this->_items[$id];
	}
	/**
	 * Получить элемент по индификатору
	 * @param mixed $id
	 * @throws Exception
	 * @return array
	 */
	public function getItem($id){
		if($this->itemExists($id))
			return $this->_items[$id];
		else
			throw new Exception('wrong id');
	}
	/**
	 * Проверка на наличие дочерних элементов
	 * @param mixed $id
	 * @return boolean
	 */
	public function hasChilds($id) {
		return isset($this->_childs[$id]);
	}
	/**
	 * Получить дочерние элементы
	 * @param mixed $id
	 * @return array
	 */
	public function getChilds($id){
		if(!$this->hasChilds($id))
			return array();
		return $this->_childs[$id];
	}

	/**
	 * Рекурсивное удаление элементов (узел + дочерние)
	 * @param mixed $id
	 * @return void
	 */
	protected function _remove($id)
	{
		/**
		 * Получаем дочерние элементы
		 */
		$childs = $this->getChilds($id);
		if (!empty($childs)) {
			/**
			 * Рекурсивное удаление дочерних элементов
			 */
			foreach ($childs as $k => $v) {
				$this->_remove($v['id']);
			}
		}
		/**
		 * Удаляем узел элемента
		 */
		if (isset($this->_childs[$id])) {
			unset($this->_childs[$id]);
		}
		/**
		 * Получаем id родительского узла
		 */
		$parent = $this->_items[$id]['parent'];
		/**
		 * Удаляем из родительского узла ссылку на дочерний
		 */
		if (!empty($this->_childs[$parent])) {
			foreach ($this->_childs[$parent] as $key => $item) {
				if ($item['id'] == $id) {
					unset($this->_childs[$parent][$key]);
					break;
				}
			}
		}
		/**
		 * Удаляем элемент
		 */
		unset($this->_items[$id]);
	}

	/**
	 * Удаление узла
	 * @param mixed $id
	 * @return void
	 */
	public function removeItem($id)
	{
		if ($this->itemExists($id)) {
			$this->_remove($id);
		}
	}

	public function removeChilds($id)
	{
		/**
		 * Получаем дочерние элементы
		 */
		$childs = $this->getChilds($id);
		if (!empty($childs)) {
			/**
			 * Рекурсивное удаление дочерних элементов
			 */
			foreach ($childs as $k => $v) {
				$this->_remove($v['id']);
			}
		}
	}

	/**
	 * Returns the path to a category in the format 1_2_3
	 *
	 * @param int $category_id
	 * @return string the path to the category
	 */
	public function getCategoryPath($category_id)
	{
		$path = '';

		$category = $this->db->query("SELECT * FROM " . DB_PREFIX . "category c WHERE c.category_id = " . (int)($category_id));
		if ($category->row['parent_id'] != 0) {
			$path .= $this->getCategoryPath($category->row['parent_id']) . '_';
		}

		$path .= $category->row['category_id'];

		return $path;
	}

	/**
	 * Get category data by pk category
	 *
	 * @param $category_id int category pk
	 * @return array data category
	 */
	public function getCategory($category_id)
	{
		return $this->getCategories((int)$category_id, 'by_id');
	}

	/**
	 * Get categories
	 *
	 * @param int $id int pk category
	 * @param string $type string the type category
	 * @return array data categories
	 */
	public function getCategories($id = 0, $type = 'by_parent')
	{
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

	/**
	 * Get total count category
	 *
	 * @param array $data array data params for search
	 * @return mixed total count category to be searched
	 */
	public function getTotalCategories($data = array())
	{
		$sql = "SELECT COUNT(DISTINCT c.category_id) AS total FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id)";

		$sql .= " WHERE cd.language_id = '" . (int)$this->config->get('config_language_id') . "'";

		if (!empty($data['filter_name'])) {
			$sql .= " AND (";

//            $implode = array();
//
//
//            $words = explode(' ', trim(preg_replace('/\s\s+/', ' ', $data['filter_name'])));
//
//            foreach ($words as $word) {
//                $implode[] = "LCASE(cd.name) LIKE '%" . $this->db->escape(utf8_strtolower($word)) . "%'";
//            }
//
//            if ($implode) {
//                $sql .= " " . implode(" OR ", $implode) . "";
//            }
			$word = trim(preg_replace('/\s\s+/', ' ', $data['filter_name']));

			$sql .= " LCASE(cd.name) LIKE '%" . $this->db->escape(utf8_strtolower($word)) . "%'";

			$sql .= ")";
		}


		$query = $this->db->query($sql);

		return $query->row['total'];
	}

	protected function searchChildren(array &$categoryData)
	{
		foreach ($categoryData as $pkCategory => $category) {
			if (isset($categoryData[$category['parent_id']])) {
				foreach ($categoryData as $pkCategoryL2 => $categoryL2) {
					if (isset($categoryData[$categoryData[$category['parent_id']]['parent_id']])) {
						foreach ($categoryData as $pkCategoryL3 => $categoryL3) {
							if ($categoryL3['parent_id'] === $category['parent_id']) {
								unset ($categoryData[$pkCategoryL3]);
							}
						}
					} else {
						if ($categoryL2['parent_id'] === $category['parent_id']) {
							unset ($categoryData[$pkCategoryL2]);
						}
					}
				}
			}
		}
	}

	protected function deleteAllChildren(array &$categoryData, $childId, $parentId)
	{
		if (empty($categoryData[$categoryData[$parentId]['parent_id']])) {
			unset ($categoryData[$childId]);
		} else {
			$this->deleteAllChildren($categoryData, $parentId, $categoryData[$categoryData[$parentId]['parent_id']]);
		}
	}

	/**
	 * Get categories data by params
	 *
	 * @param array $data array data params
	 * @return array categories data
	 */
	public function getCategoriesByData($data = array())
	{
		// search
		$sql = "SELECT DISTINCT c.category_id AS total FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id)";

		$sql .= " WHERE cd.language_id = '" . (int)$this->config->get('config_language_id') . "'";

		if (!empty($data['filter_name'])) {
			$sql .= " AND (";

//            $implode = array();
//
//
//            $words = explode(' ', trim(preg_replace('/\s\s+/', ' ', $data['filter_name'])));
//
//            foreach ($words as $word) {
//                $implode[] = "LCASE(cd.name) LIKE '%" . $this->db->escape(utf8_strtolower($word)) . "%'";
//            }
//
//            if ($implode) {
//                $sql .= " " . implode(" OR ", $implode) . "";
//            }
			$word = trim(preg_replace('/\s\s+/', ' ', $data['filter_name']));

			$sql .= " LCASE(cd.name) LIKE '%" . $this->db->escape(utf8_strtolower($word)) . "%'";

			$sql .= ")";
		}


		$sql .= " GROUP BY c.category_id";

		// sort data
		$sort_data = array(
			'cd.name',
			'c.sort_order',
			'c.date_added'
		);

		// sorting
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			if ($data['sort'] == 'cd.name') {
				$sql .= " ORDER BY LCASE(" . $data['sort'] . ")";
			} else {
				$sql .= " ORDER BY " . $data['sort'];
			}
		} else {
			$sql .= " ORDER BY c.sort_order";
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC, LCASE(cd.name) DESC";
		} else {
			$sql .= " ASC, LCASE(cd.name) ASC";
		}

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$category_data = array();
		$query = $this->db->query($sql);

		foreach ($query->rows as $result) {
			$category_data[$result['total']] = $this->getCategory($result['total']);
		}

		//$this->searchChildren($category_data);

		foreach ($category_data as $pkCategory => $category) {
			$this->addItem($pkCategory, $category['parent_id'], $category);
		}

		//$this->removeItem(221);
		//var_dump('<pre>', $this->_childs);die;

		foreach ($this->_items as $key => $value) {
			$this->removeChilds($value['id']);
		}
//
		$categoryData = array();

		foreach ($this->_items as $key => $item) {
			$categoryData[$key]  = $item['data'];
		}

//		echo $this->getCount();
//
//		var_dump($categoryData);
//		die;



		return $categoryData;
	}
}