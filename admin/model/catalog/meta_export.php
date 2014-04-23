<?php
/**
 * @autor: Rostislav Shvets
 * Date: 23.04.14
 */

class ModelCatalogMetaExport extends Model
{
    public function getMeta()
    {
        $sql = "select pd.product_id,pd.name,pd.seo_h1, pd.seo_title, pd.meta_keyword, pd.meta_description from product_description pd
                where pd.meta_description not like '' or pd.meta_keyword not like '' or pd.seo_title not like '' or pd.seo_h1 not like ''
                UNION
                select cd.category_id,cd.name,cd.seo_h1, cd.seo_title, cd.meta_keyword, cd.meta_description from category_description cd
                where cd.meta_description not like '' or cd.meta_keyword not like '' or cd.seo_title not like '' or cd.seo_h1 not like ''";
        $result = $this->db->query($sql);
        return $result->rows;
    }

    public function prepareCsv($metaData)
    {
        $headersCsv = [];
        $headersCsv[] = 'Код';
        $headersCsv[] = 'Наименование';
        $headersCsv[] = 'Мета-тег H1 (HTML-тег H1)';
        $headersCsv[] = 'Мета-тег Title (HTML-тег Title)';
        $headersCsv[] = 'Мета-тег Keywords';
        $headersCsv[] = 'Мета-тег Description';

        foreach ($metaData as $data){
            $rowCsvArr = [
                $data['product_id'],
                $data['name'],
                $data['seo_h1'],
                $data['seo_title'],
                $data['meta_keyword'],
                $data['meta_description'],
            ];
            $dataRender[] = join(';', $rowCsvArr);
        }

        $headersCsv = join(';', $headersCsv);
        $dataRender = array_merge([$headersCsv], $dataRender);
        return join("\n", $dataRender);
    }
} 