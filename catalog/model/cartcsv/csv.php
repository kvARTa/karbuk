<?php
class ModelCartcsvCsv extends Model
{
	public function parseCsv(array $csvData)
	{
		if (count($csvData) == 0) {
			return false;
		}
		$processedCsvData = [];
		foreach ($csvData as $csvRow) {
			$csvRow = mb_convert_encoding($csvRow, "UTF-8", "windows-1251");
			$csv = explode(';', $csvRow);

			if (trim($csv[3]) == '' && trim($csv[3]) == 'Артикул') {
				return false;
			}

			$processedCsvData[] = [
				'name' => str_replace(',', '.', trim($csv[2])),
				'url' => '',
				'code' => str_replace(',', '.', trim($csv[0])),
				'price' => str_replace(',', '.', trim($csv[1])),
			];
		}
		return $processedCsvData;
	}
	
	public function preparationSaving(array $productData)
	{
         //print_r($parseData);die;
		$headersCsv = array();
		$headersCsv[] = 'Артикул';
		$headersCsv[] = 'Количество';


		$dataRender = array();
		foreach ($productData as $data) {
			$rowCsvArray  = [
				$data['product_id'],
				$data['quantity']
			];


		$dataRender[] = join(';', $rowCsvArray);
		}
		$headersCsv = join(';', $headersCsv);
		$dataRender = array_merge([$headersCsv], $dataRender);
               
		return mb_convert_encoding(join("\n", $dataRender), "windows-1251", "UTF-8");
	}

	/**
	 * @return Csv
	 */
	public static function factory() {
		return new self();
	}
}
?>