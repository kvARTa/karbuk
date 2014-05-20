<?php   
class ModelVovImportsImport extends Model {
	private $cat_parent_cache;
	private $manufacturer_cache;
	private $attribs_cache;


// 	public function load_cust() {
// 	  $customers = array();
// 	  $this->db->query('USE wwwkarbukru');
// 	  $query = $this->db->query('SELECT * FROM customers LEFT JOIN address_book ON customers.customers_id = address_book.customers_id');
// 	  foreach($query->rows as $c){
// 		  $customer = array();
// 		  $customer['login'] = $c['login'];
// 		  $customer['firstname'] = $c['customers_firstname'];
// 		  $customer['lastname'] = $c['customers_lastname'];
// 		  $customer['email'] = $c['customers_email_address'];
// 		  $customer['telephone'] = $c['customers_telephone'];
// 		  $customer['inn'] = $c['inn'];
// 		  $customer['kpp'] = $c['kpp'];
// 		  $customer['ur_address'] = $c['ua'];
// 		  $customer['fact_address'] = $c['fa'];
// 		  $customer['manager'] = $c['manager'];
// 		  $customer['password'] = $c['open_password'];
// 		  $customer['company'] = $c['entry_company'];
// 		  $customer['confirm'] = 1;
// 		  $customer['newsletter'] = 1;
// 		  $customer['customer_group_id'] = $c['customers_groups_id'];
// 		  $customer['status'] = 1;
// 		  $customers[] = $customer;
// 	  }
// 	  $this->db->query('USE test');
// 
// 	  return $customers;
// 	}  
// 	public function addCustomer($data) {
//       	$this->db->query("INSERT INTO " . DB_PREFIX . "customer SET login = '" . $this->db->escape($data['login']) . "',firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', email = '" . $this->db->escape($data['email']) . "', telephone = '" . $this->db->escape($data['telephone']) . "', inn = '" . $this->db->escape($data['inn']) . "', kpp = '" . $this->db->escape($data['kpp']) . "', ur_address = '" . $this->db->escape($data['ur_address']) . "', fact_address = '" . $this->db->escape($data['fact_address']) . "', manager = '" . $this->db->escape($data['manager']) . "', newsletter = '" . (int)$data['newsletter'] . "', customer_group_id = '" . (int)$data['customer_group_id'] . "', password = '" . $this->db->escape(md5($data['password'])) . "', status = '" . (int)$data['status'] . "', date_added = NOW()");
//       	
//       	$customer_id = $this->db->getLastId();
//       	
//       	if (isset($data['address'])) {		
//       		foreach ($data['address'] as $address) {	
//       			$this->db->query("INSERT INTO " . DB_PREFIX . "address SET customer_id = '" . (int)$customer_id . "', address_1 = '" . $this->db->escape($address['address_1']) . "', city = '" . $this->db->escape($address['city']) . "', postcode = '" . $this->db->escape($address['postcode']) . "', zone_id = '" . (int)$address['zone_id'] . "'");
// 				
// 				if (isset($address['default'])) {
// 					$address_id = $this->db->getLastId();
// 					
// 					$this->db->query("UPDATE " . DB_PREFIX . "customer SET address_id = '" . $address_id . "' WHERE customer_id = '" . (int)$customer_id . "'");
// 				}
// 			}
// 		}
// 	}
	public function delete_discount(){
		$this->db->query("TRUNCATE TABLE " . DB_PREFIX . "product_discount ");
	}

	public function load_to_mysql() {
		
		$filename1 =  DIR_APPLICATION.'../import/export.DBF';
		$filename2 =  DIR_APPLICATION.'../import/export2.DBF';
	
		$db = dbase_open($filename1, 0);

		if ($db) {
			$this->db->query('TRUNCATE TABLE vov_export1');
			$this->db->query('TRUNCATE TABLE vov_export_aks');
			
			$record_numbers = dbase_numrecords($db);
			for ($i = 1; $i <= $record_numbers; $i++) {
			    $row = dbase_get_record_with_names($db, $i);
			    //print_r($row);die;
			    $id = $row['ID'];
			    $isparent = $row['ISPARENT'];

			    if(isset( $row['PARENT'])) {
				$parent = $row['PARENT'];
			    } else {
				$parent = 0;
			    }

			    if(isset( $row['TITLE'])) {
				$title = trim(iconv('WINDOWS-1251', 'UTF-8', $row['TITLE']));
			    } else {
				$title = '';
			    }
			    
			    if(isset( $row['PRICE'])) {
				$price = $row['PRICE'];
			    } else {
				$price = '';
			    }
			    
			    if(isset( $row['BASEPRICE'])) {
				$baseprice = $row['BASEPRICE'];
			    } else {
				$baseprice = '';
			    }
			    
			    $sp = $row['SP'];
			    $ssp = $row['SSP'];
			    
			    $ordern = $row['ORDER'];
			    
			    if(isset( $row['PROD'])) {
				$prod = trim(iconv('WINDOWS-1251', 'UTF-8', $row['PROD']));
			    } else {
				$prod = '';
			    }
			    
			    if(isset( $row['ARTICLE'])) {
				$article = $row['ARTICLE'];
			    } else {
				$article = '';
			    }
			    
			    
			    if(isset( $row['KOMMENT'])) {
				$komment = trim(nl2br(iconv('WINDOWS-1251', 'UTF-8', $row['KOMMENT'])));
			    } else {
				$komment = '';
			    }
			    
			    for ($j=2; $j<=14; $j++) {
				if(isset( $row['KOMMENT'.$j])) {
				    $komment .=  trim(nl2br(iconv('WINDOWS-1251', 'UTF-8', $row['KOMMENT'.$j])));
				}
			    }
			    
			    $sklad = $row['SKLAD'];
			    $sklad_post = $row['SKLAD_POST'];
			    $kratn = $row['KRATN'];
			    $hit = $row['HIT'];
			    $newn = $row['NEW'];
                if (isset($row['TRANSLIT'])){
                    $translit = strtolower(trim($row['TRANSLIT']));
                    $translit = str_replace('"','',$translit);
                    $translit = str_replace('/','-',$translit);
                    $translit = str_replace('+','',$translit);
                    $translit = str_replace('.','_',$translit);
                    $translit = str_replace('(','',$translit);
                    $translit = str_replace(')','',$translit);
                    $translit = str_replace(', ','_',$translit);
                    $translit = str_replace(', ','_',$translit);
                    $translit = str_replace(' ','_',$translit);
                    $translit = str_replace(',','',$translit);
                    $translit = str_replace('\'','',$translit);
                }else{
                    $translit = '';
                }

                if (isset($row['TYPE'])){
                    $type = trim(iconv('WINDOWS-1251', 'UTF-8', $row['TYPE']));;
                }else{
                    $type = '';
                }

                if (isset($row['COLOR'])){
                    $color = trim(iconv('WINDOWS-1251', 'UTF-8', $row['TYPE']));;
                }else{
                    $color = '';
                }


			    $sql_add = '';
			    for ($j=1; $j<=6; $j++) {
					if(isset($row['PR_'. $j])) {
						$sql_add .= ", pr_" . $j . "='". (float)$row['PR_'. $j] ."'";
					}
			    }


			    $this->db->query("INSERT INTO vov_export1 SET idn='".(int)$id."', isparent='".(int)$isparent."', parent='".(int)$parent."', title='".$this->db->escape($title)."', price='".(float)$price."', baseprice='".(float)$baseprice."', sp='".(int)$sp."', ssp='".(int)$ssp."', prod='".$this->db->escape($prod)."', article='".(int)$article."', komment='".$this->db->escape($komment)."', ordern='".(int)$ordern."', sklad='".(int)$sklad."', sklad_post='".(int)$sklad_post."', kratn='".(int)$kratn."', hit='".(int)$hit."', translit='" . $this->db->escape($translit) . "', type='" . $this->db->escape($type) . "', color='" . $this->db->escape($color) . "', newn='".(int)$newn."'  ". $sql_add);
			    
			    
			    for ($j=1; $j<=15; $j++) {
				if(isset($row['AKS'.$j]) && ((int)$row['AKS'.$j])) {
				    $this->db->query("INSERT INTO vov_export_aks SET idn='".(int)$id."', aksid='".(int)$row['AKS'.$j]."'");
				}
			    }

	    //                 print_r($row); //die;
	    //                 if ($i == 5) die;
			}
			dbase_close($db);
			
		} else {
		    echo $filename1. " can't open ";
		}
			
			$db = dbase_open($filename2, 0);
		
		if ($db) {
		    $this->db->query('TRUNCATE TABLE vov_export2');
			      
		    $record_numbers = dbase_numrecords($db);
		    for ($i = 1; $i <= $record_numbers; $i++) {
		    
			$row = dbase_get_record_with_names($db, $i);
		      
			$id = $row['ID'];
			
			if($i == 1 || (isset($lastid) && $id != $lastid)) {
			    $sort = 1;
			}  else {
			    $sort++;
			}
			$lastid = $id;
			
			$type = trim(iconv('WINDOWS-1251', 'UTF-8', $row['TYPE']));
			$value = trim(iconv('WINDOWS-1251', 'UTF-8', $row['VALUE']));
			
			
			$this->db->query("INSERT INTO vov_export2 SET idn='".(int)$id."', type='".$this->db->escape($type)."', val='".$this->db->escape($value)."' , sort_order ='".(int)$sort."'");

			//print_r($row); die;
		    }
		    dbase_close($db);
		    
		} else {
		    echo $filename2. " can't open ";
		}
		
  	}
  	
  	public function deleteProduct($product_id) {
        $this->db->query("DELETE FROM " . DB_PREFIX . "product WHERE product_id = '" . (int)$product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int)$product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_description WHERE product_id = '" . (int)$product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_discount WHERE product_id = '" . (int)$product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_image WHERE product_id = '" . (int)$product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_option WHERE product_id = '" . (int)$product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_option_value WHERE product_id = '" . (int)$product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE related_id = '" . (int)$product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_reward WHERE product_id = '" . (int)$product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int)$product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_tag WHERE product_id='" . (int)$product_id. "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . (int)$product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_to_download WHERE product_id = '" . (int)$product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_to_layout WHERE product_id = '" . (int)$product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_to_store WHERE product_id = '" . (int)$product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "review WHERE product_id = '" . (int)$product_id . "'");
        
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_xsell WHERE product_id = '" . (int)$product_id . "'");
        
        $this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'product_id=" . (int)$product_id. "'");
        
        
    }
  	
  	private function insert_or_update_category($data) {

        $exist_query = $this->db->query("SELECT category_id FROM ".DB_PREFIX."category WHERE old_id='".$data['idn']."'");
        
        
        
        if($exist_query->num_rows) {
            $category_id = $exist_query->row['category_id'];
        } else {
            $category_id = 0;
        }
                
        $language_id = $this->config->get('config_language_id');
        
        if(!$category_id) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "category SET parent_id = '0', status = '1', top = '1', date_modified = NOW(), date_added = NOW(), old_id='".$data['idn']."', sort_order='".(int)$data['ordern']."', sorted_parent='0'");
            $category_id = $this->db->getLastId();
            
            $this->db->query("INSERT INTO " . DB_PREFIX . "category_description SET category_id = '" . (int)$category_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($data['title']) . "'");

        } else {
            $this->db->query("UPDATE " . DB_PREFIX . "category SET sort_order='".(int)$data['ordern']."', date_modified = NOW() WHERE category_id = '" . (int)$category_id . "'");
            
            $this->db->query("UPDATE " . DB_PREFIX . "category_description SET  name = '" . $this->db->escape($data['title']) . "' WHERE category_id = '" . (int)$category_id . "' AND language_id = '" . (int)$language_id . "'");
        }

        //url alias
        $this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'category_id=" . (int)$category_id . "'");

        if (!empty($data['translit'])) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'category_id=" . (int)$category_id . "', keyword = '" . $this->db->escape($data['translit']) . "'");
        }
        //url alias end
        
        $store_id =  $this->config->get('config_store_id');
        $this->db->query("DELETE FROM " . DB_PREFIX . "category_to_store WHERE category_id = '" . (int)$category_id . "'");

        $this->db->query("INSERT INTO " . DB_PREFIX . "category_to_store SET category_id = '" . (int)$category_id . "', store_id = '" . (int)$store_id . "'");
        
  	}
    
    private function get_parent_category($parent) {
        
        $parent_id = NULL;
        
        if (isset($this->cat_parent_cache[$parent])) {
            $parent_id = $this->cat_parent_cache[$parent];
        } else {
            $parent_query = $this->db->query("SELECT c.category_id FROM " . DB_PREFIX . "category c WHERE c.old_id='".$parent."'");
            
            if($parent_query->num_rows) {
                $parent_id = $parent_query->row['category_id'];
                $this->cat_parent_cache[$parent] = $parent_id;
            } else {
                print $parent." parent not found\n";
            }
        }
        

        return $parent_id;
    }
    
    private function get_manufacturers_id($manufacturers_name) {
        if (isset($this->manufacturer_cache[$manufacturers_name])) {
            $manufacturers_id = $this->manufacturer_cache[$manufacturers_name];
        } else {
            $manufacturer_query = $this->db->query("SELECT manufacturer_id FROM " . DB_PREFIX . "manufacturer  WHERE name LIKE '".$manufacturers_name."'");
            
            if($manufacturer_query->num_rows) {
                $manufacturers_id = $manufacturer_query->row['manufacturer_id'];
                $this->manufacturer_cache[$manufacturers_name] = $manufacturers_id;
            } else {
                $this->db->query("INSERT INTO " . DB_PREFIX . "manufacturer SET name = '" . $this->db->escape($manufacturers_name) . "'");
                $manufacturers_id = $this->db->getLastId();
                
                $language_id = $this->config->get('config_language_id');
                $this->db->query("INSERT INTO " . DB_PREFIX . "manufacturer_description SET manufacturer_id = '" . (int)$manufacturers_id . "', language_id = '" . (int)$language_id . "' ");
        
               
                $store_id =  $this->config->get('config_store_id');
                $this->db->query("DELETE FROM " . DB_PREFIX . "manufacturer_to_store WHERE manufacturer_id = '" . (int)$manufacturers_id . "'");
                $this->db->query("INSERT INTO " . DB_PREFIX . "manufacturer_to_store SET manufacturer_id = '" . (int)$manufacturers_id . "', store_id = '" . (int)$store_id . "'");
            }
        }
        
        return $manufacturers_id ;
    }
    
    private function get_attribs_id($attribs_name) {
        
        if(!empty($attribs_name)) {
            $language_id = $this->config->get('config_language_id');
        
            if (isset($this->attribs_cache[$attribs_name])) {
                $attribs_id = $this->attribs_cache[$attribs_name];
            } else {
                $attribs_query = $this->db->query("SELECT attribute_id FROM " . DB_PREFIX . "attribute_description WHERE name LIKE '".$attribs_name."' AND language_id='".$language_id."'");
                
                if($attribs_query->num_rows) {
                    $attribs_id = $attribs_query->row['attribute_id'];
                    $this->attribs_cache[$attribs_name] = $attribs_id;
                } else {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "attribute SET attribute_group_id='4'");
                    $attribs_id = $this->db->getLastId();
                    
                    $this->db->query("INSERT INTO " . DB_PREFIX . "attribute_description SET attribute_id = '" . (int)$attribs_id . "', language_id = '" . (int)$language_id . "', name='".$this->db->escape($attribs_name)."' ");
                }
            }
        } else {
            $attribs_id = 0;
        }
        return $attribs_id ;
    }
  	
  	private function set_parent_category($data) {
        $parent_id = $this->get_parent_category($data['parent']);
        
        $this->db->query("UPDATE " . DB_PREFIX . "category SET parent_id = '".$parent_id."', sorted_parent=1, date_modified = NOW() WHERE category_id = '" . (int)$data['category_id'] . "'");
        
  	}
    
    private function insert_or_update_product($data) {
        $exist_query = $this->db->query("SELECT product_id FROM ".DB_PREFIX."product WHERE old_id='".$data['idn']."'");

        if($exist_query->num_rows) {
            $product_id = $exist_query->row['product_id'];
        } else {
            $product_id = 0;
        }

        $language_id = $this->config->get('config_language_id');

        if (!empty($data['prod'])) {
            $manufacturers_id = $this->get_manufacturers_id($data['prod']);
        } else {
            $manufacturers_id = 0;
        }

        if (file_exists(DIR_IMAGE.'data/'.$data['article'].'.jpg')) {
            $image = $this->db->escape('data/'.$data['article'].'.jpg');
        } else {
            $image = NULL;
        }

        if ((int)$data['sklad'] || (int)$data['sklad_post'] ) {
            $quantity = 10;
        } else {
            $quantity = 0;
        }



        $data['kratn'] == 0 ? ($data['kratn'] = 1) : false;

		$groups = array(
			"pr_1" => 8,
			"pr_2" => 9,
			"pr_3" => 10,
			"pr_4" => 11,
			"pr_5" => 12,
			"pr_6" => 13
		);

        if(!$product_id) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "product SET color='" . $data['color'] . "', type='" . $data['type'] . "', price = '".number_format($data['price'], 2, '.', '')."', multiplicity='".$this->db->escape($data['kratn'])."', model='".$this->db->escape($data['article'])."' , status = '1', image='".$image."', manufacturer_id='".(int)$manufacturers_id."' , quantity='".(int)$quantity."', sort_order='".(int)$data['ordern']."', stock_status_id='8' , special_marker = '".(int)$data['sp']."', hit = '".(int)$data['hit']."', newprod='".(int)$data['newn']."',  date_modified = NOW(), date_available=NOW(), date_added = NOW(), old_id='".$data['idn']."'");
            $product_id = $this->db->getLastId();

            $this->db->query("INSERT INTO " . DB_PREFIX . "product_description SET product_id = '" . (int)$product_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($data['title']) . "', description='".$this->db->escape($data['komment'])."' ");

        } else {
            $this->db->query("UPDATE " . DB_PREFIX . "product SET color='" . $data['type'] . "', color='" . $data['type'] . "', price = '".number_format($data['price'], 2, '.', '')."', multiplicity='".$this->db->escape($data['kratn'])."',  model='".$this->db->escape($data['article'])."' , image='".$image."' , kratn='".$data['kratn']."' , manufacturer_id='".(int)$manufacturers_id."' ,  quantity='".(int)$quantity."', stock_status_id='8' , special_marker = '".(int)$data['sp']."', hit = '".(int)$data['hit']."', newprod='".(int)$data['newn']."', sort_order='".(int)$data['ordern']."',  date_modified = NOW() WHERE product_id = '" . (int)$product_id . "'");

            $this->db->query("UPDATE " . DB_PREFIX . "product_description SET  name = '" . $this->db->escape($data['title']) . "' , description='".$this->db->escape($data['komment'])."' WHERE product_id = '" . (int)$product_id . "' AND language_id = '" . (int)$language_id . "'");
        }
		foreach($groups as $key => $value){
			$this->db->query("INSERT INTO " . DB_PREFIX . "product_discount SET product_id='".$product_id."', customer_group_id='".$value."', quantity='1', priority='1', price='".number_format((($data[$key] > 0 ? $data[$key] : 1)*$data['baseprice']), 2, '.', '')."'");
		}


        $attribs_query = $this->db->query("SELECT * FROM ".DB_PREFIX."vov_export2 WHERE idn='".$data['idn']."'");

        $this->db->query("DELETE FROM ".DB_PREFIX."product_attribute WHERE product_id='".$product_id."' ");

        foreach($attribs_query->rows as $attrib_data) {

            $attribute_id = $this->get_attribs_id($attrib_data['type']);

            $this->db->query("INSERT INTO ".DB_PREFIX."product_attribute SET product_id='".$product_id."' , attribute_id = '".(int)$attribute_id."' , language_id='".(int)$language_id."' , text ='".$this->db->escape($attrib_data['val'])."', sort_order='".(int)$attrib_data['sort_order']."'");
        }

        $this->db->query("DELETE FROM " . DB_PREFIX . "product_image WHERE product_id = '" . (int)$product_id . "'");


        $add_images = glob(DIR_IMAGE.'data/'.$data['article'].'-*'.'.jpg');

        if(is_array($add_images)) {
            foreach ($add_images as $imagefile )   {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_image SET product_id = '" . (int)$product_id . "', image = '" . $this->db->escape('data/'.basename($imagefile)) . "', sort_order = '" . (int)$imagefile . "'");
            }
        }

        //url alias
        $this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'product_id=" . (int)$product_id. "'");

        if (!empty($data['translit'])) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'product_id=" . (int)$product_id . "', keyword = '" . $this->db->escape($data['translit']) . "'");
        }
        //url alias end

        $parent_id = $this->get_parent_category($data['parent']);

        $this->db->query("DELETE FROM  " . DB_PREFIX . "product_to_category WHERE product_id = '" . (int)$product_id . "'  ");
        $this->db->query("INSERT INTO  " . DB_PREFIX . "product_to_category SET product_id = '" . (int)$product_id . "' , category_id='".$parent_id."', main_category='1' ");

        $store_id =  $this->config->get('config_store_id');
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_to_store WHERE product_id = '" . (int)$product_id . "'");
        $this->db->query("INSERT INTO " . DB_PREFIX . "product_to_store SET product_id = '" . (int)$product_id . "', store_id = '" . (int)$store_id . "'");

    }
  	
  	public function delete_categories() {
        $this->db->query("TRUNCATE TABLE " . DB_PREFIX . "category ");
        $this->db->query("TRUNCATE TABLE " . DB_PREFIX . "category_description ");
        $this->db->query("TRUNCATE TABLE " . DB_PREFIX . "category_to_store ");
        $this->db->query("TRUNCATE TABLE " . DB_PREFIX . "category_to_layout ");
        $this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query LIKE 'category_id=%'");
        
        $this->cache->delete('category');
  	}
  	
  	public function delete_products() {
        
//     $this->db->query("TRUNCATE TABLE " . DB_PREFIX . "attribute ");
//     $this->db->query("TRUNCATE TABLE " . DB_PREFIX . "attribute_description ");
        $this->db->query("TRUNCATE TABLE " . DB_PREFIX . "product ");
        $this->db->query("TRUNCATE TABLE " . DB_PREFIX . "product_attribute ");
        $this->db->query("TRUNCATE TABLE " . DB_PREFIX . "product_description ");
        $this->db->query("TRUNCATE TABLE " . DB_PREFIX . "product_discount ");
        $this->db->query("TRUNCATE TABLE " . DB_PREFIX . "product_image ");
        $this->db->query("TRUNCATE TABLE " . DB_PREFIX . "product_option ");
        $this->db->query("TRUNCATE TABLE " . DB_PREFIX . "product_option_value ");
        $this->db->query("TRUNCATE TABLE " . DB_PREFIX . "product_related ");
        $this->db->query("TRUNCATE TABLE " . DB_PREFIX . "product_xsell ");
        $this->db->query("TRUNCATE TABLE " . DB_PREFIX . "product_reward ");
        $this->db->query("TRUNCATE TABLE " . DB_PREFIX . "product_special ");
        $this->db->query("TRUNCATE TABLE " . DB_PREFIX . "product_tag ");
        $this->db->query("TRUNCATE TABLE " . DB_PREFIX . "product_to_category ");
        $this->db->query("TRUNCATE TABLE " . DB_PREFIX . "product_to_download ");
        $this->db->query("TRUNCATE TABLE " . DB_PREFIX . "product_to_layout ");
        $this->db->query("TRUNCATE TABLE " . DB_PREFIX . "product_to_store ");
        $this->db->query("TRUNCATE TABLE " . DB_PREFIX . "review ");
        
        $this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query LIKE 'product_id=%'");
        
        $this->cache->delete('product');
  	}
  	
  	public function delete_manufacturers() {
        $this->db->query("TRUNCATE TABLE " . DB_PREFIX . "manufacturer ");
        $this->db->query("TRUNCATE TABLE " . DB_PREFIX . "manufacturer_description ");
        $this->db->query("TRUNCATE TABLE " . DB_PREFIX . "manufacturer_to_store ");
        $this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query LIKE 'manufacturer_id=%'");
            
        $this->cache->delete('manufacturer');
    }
    
    public function delete_attributes() {
        $this->db->query("TRUNCATE TABLE " . DB_PREFIX . "attribute ");
        $this->db->query("TRUNCATE TABLE " . DB_PREFIX . "attribute_description ");

    }
    
    public function import_categories() {
    
        $this->cat_parent_cache = array(); //1s id=> shop db id
        $this->cat_parent_cache[0] = 0;

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "vov_export1 WHERE isparent=0");
       // print_r($query->rows); die;
        foreach($query->rows as $data) {
            $this->insert_or_update_category($data);
        }

        //$query = $this->db->query("SELECT c.category_id, ve1.parent, ve1.idn FROM " . DB_PREFIX . "category c, ".DB_PREFIX." vov_export1 ve1 WHERE c.sorted_parent=0 AND c.old_id=ve1.idn");
        $query = $this->db->query("SELECT c.category_id, ve1.parent, ve1.idn FROM " . DB_PREFIX . "category c, ".DB_PREFIX." vov_export1 ve1 WHERE  c.old_id=ve1.idn");

        foreach($query->rows as $data) {
            $this->set_parent_category($data);
        }
    }
    
    public function import_products() {
        $this->manufacturers_cache = array();
        $this->attribs_cache = array();
    
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "vov_export1 WHERE isparent=1");
        foreach($query->rows as $data) {
            $this->insert_or_update_product($data);
        }
    } 
    
    public function import_xsell() {
        $aks_query = $this->db->query("SELECT p.product_id as product_id , pp.product_id as xsell_id FROM ".DB_PREFIX."product p, ".DB_PREFIX."product pp,  ".DB_PREFIX."vov_export_aks vea WHERE vea.idn=p.old_id AND vea.aksid=pp.old_id ");
        
        foreach($aks_query->rows as $aks_data) {
            $this->db->query("REPLACE INTO ".DB_PREFIX."product_xsell SET product_id='".(int)$aks_data['product_id']."' , xsell_id = '".(int)$aks_data['xsell_id']."' ");
        }
    }
    
    public function delete_absent() {
        $prods_query = $this->db->query("select p.product_id, ve1.idn from " . DB_PREFIX . "product p LEFT JOIN  vov_export1 ve1 on (p.old_id = ve1.idn) where ve1.idn IS NULL");
        
        foreach ($prods_query -> rows as $product) {
            $this->deleteProduct($product['product_id']);
        }
    }
    
}
?>