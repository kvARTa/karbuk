<?php
/**
 * @autor: Rostislav Shvets
 * Date: 23.06.14
 */

class ModelReportReport extends Model
{
    public function getProductsWithoutPictures($products){
        $products = $this->db->query("SELECT p.product_id, pd.name FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY pd.name ASC");
        if ($products->num_rows) {
            $products_without_images = array();
            foreach ($products->rows as $product){
                $images = glob(DIR_IMAGE.'data/'.$product['product_id'].'.jpg');
                if (!$images) {
                    $products_without_images[] = array(
                        'id'   => $product['product_id'],
                        'name' => $product['name'],
                    );
                }
            }
            return $products_without_images;
        } else {
            return '';
        }
    }

    public function getProductsWithoutAttributes(){
        $query = "SELECT distinct p.product_id as id, pd.name FROM " . DB_PREFIX . "product p
                  left join " . DB_PREFIX . "product_description pd on (p.product_id = pd.product_id)
                  WHERE p.product_id not in (SELECT product_id from " . DB_PREFIX . "product_attribute)";
        $result = $this->db->query($query);
        return $result->num_rows ? $result->rows : '';
    }

    public function getCategoriesWithoutProducts(){
        $query = "SELECT distinct c.category_id as id, cd.name FROM " . DB_PREFIX . "category c
                  left join " . DB_PREFIX . "category_description cd on (c.category_id = cd.category_id)
                  WHERE c.category_id not in (SELECT distinct c2.parent_id from " . DB_PREFIX . "category c2) AND c.category_id not in (SELECT category_id from " . DB_PREFIX . "product_to_category)";
        $result = $this->db->query($query);
        return $result->num_rows ? $result->rows : '';
    }

    public function getCategoriesWithoutCatAndProd(){
        $query = "SELECT distinct c.category_id as id, cd.name FROM " . DB_PREFIX . "category c
                    left join " . DB_PREFIX . "category_description cd on (c.category_id = cd.category_id)
                    WHERE c.category_id in (SELECT distinct c2.parent_id from " . DB_PREFIX . "category c2) AND c.category_id in (SELECT category_id from " . DB_PREFIX . "product_to_category)";
        $result = $this->db->query($query);
        return $result->num_rows ? $result->rows : '';
    }

    public function prepareCsv($data)
    {
        $headersCsv = array();
        $headersCsv[] = 'Код';
        $headersCsv[] = 'Наименование';

        $dataRender = array();
        foreach ($data as $name => $items){
            $dataRender[] = $name;
            foreach ($items as $item) {
                $rowCsvArr = array(
                    $item['id'],
                    '"' . $item['name'] . '"',
                );
                $dataRender[] = join(';', $rowCsvArr);
            }
        }

        $headersCsv = join(';', $headersCsv);
        $dataRender = array_merge(array($headersCsv), $dataRender);
        return mb_convert_encoding(join("\n", $dataRender),"windows-1251", "UTF-8");
    }
} 