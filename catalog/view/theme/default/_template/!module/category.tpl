<div class="box">
    <div class="box-content">
    <div class="box-category">
      <ul>
        <?php foreach ($categories as $category) { ?>
        <li>
          <?php if ($category['category_id'] == $category_id) { ?>
          <a href="<?php echo $category['href']; ?>" class="active"><?php echo $category['name']; ?></a>
          <?php } else { ?>
          <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
          <?php } ?>
        
        
        
              
              
              
              <!---->
               <?php if ($category['children']) { ?>
       <ul>
        <?php for ($i = 0; $i < count($category['children']); $i++) { ?>
       
        
             <?php if (isset($category['children'][$i])) {
              $children2 = $this->model_catalog_category->getCategories($category['children'][$i]['category_id']);
              $str='';
              $child_activ='';
              if ($children2){ $str='str';}
              
             if  ($category['children'][$i]['category_id'] == $child_id )  {$child_activ='activ2';
             }
              
              ?>
              
              
          <li class="<? echo $child_activ; ?>"><a href="<?php echo $category['children'][$i]['href']; ?>" class="parent <? echo $child_activ; ?>"><?php echo $category['children'][$i]['name']; ?></a>
          
          
          <?php   
         
          if ($children2){
           echo " <ul>";
          foreach ($children2 as $child2) {
          
          $href  = $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $category['children'][$i]['category_id'].'_'.$child2['category_id']);
          
          echo '<li><a href=' .$href. ' class="children2"> ' .$child2['name']. '</a></li>';
          }
           echo "</ul>";
          }
          ?>
 
       
          
          </li>
          <?php } ?>
         
        
        <?php } ?>
        </ul>
       
         
      
        
        
        
     
      <?php } ?>
              <!---->
              
              
              
              
           
        </li>
        <?php } ?>
      </ul>
    </div>
  </div>
</div>

  <div class="link"> <a href="/">Доставка</a></div>
  <div class="link"><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></div>
