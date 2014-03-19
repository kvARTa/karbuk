<?php echo $header; ?>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/search_advanced.css" />
<?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content">
 <?php echo $content_top; ?>
 <div class="breadcrumb">
  <?php foreach ($breadcrumbs as $breadcrumb) { ?>
  <?php echo $breadcrumb['separator']; ?>
  <a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
  <?php } ?>
 </div>
 
 <h2><?php echo $text_search; ?></h2>
 <?php if ($products) { ?>
 <div class="product-filter">
  
  <div class="limit"><?php echo $text_limit; ?>
   <select onchange="location = this.value;">
    <?php foreach ($limits as $limits) { ?>
    <?php if ($limits['value'] == $limit) { ?>
    <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
    <?php } else { ?>
    <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
    <?php } ?>
    <?php } ?>
   </select>
  </div>
  <div class="sort"><?php echo $text_sort; ?>
   <select onchange="location = this.value;">
    <?php foreach ($sorts as $sorts) { ?>
    <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
    <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
    <?php } else { ?>
    <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
    <?php } ?>
    <?php } ?>
   </select>
  </div>
 </div>

 <!--product_list-->
  <div class="product-list">
    <?php foreach ($products as $product) { ?>
   <div class="product_one">
    <!--product_up-->
    <div class="product_up">
     <!--pruduct_image-->
    <div class="image">
      <?php if ($product['thumb']) { ?>
      <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>
      <?php } ?>
      </div>
         <!--!pruduct_image-->
      
         <!--pruduct_description-->
      <div class="pruduct_description">
      <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
      <div class="description"><?php echo $product['description']; ?>
      
     
       <a href="<?php echo $product['href']; ?>" class="readon">Подробнее</a>
      </div>
      </div>
       <!--!pruduct_description-->
      
       <!--pruduct_price-->

      <div class="pruduct_price">
       <div class="stock">
       <?php echo $product['stock']; ?>
      </div>
      
      
      <?php if ($product['price']) { ?>
      <div class="price">
        
        <?php if (!$product['special']) { ?>
        <span class="uah"><?php echo $product['price']; ?></span>
         <span class="usd"> <?php echo $product['price2']; ?></span>
         
         
        <?php } else { ?>
        <span class="price-old"><?php echo $product['price']; ?> <?php echo $product['price2']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
        <?php } ?>
        <?php if ($product['tax']) { ?>
        <br />
        <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
        <?php } ?>
      </div>
      <?php } ?>
       <div class="cart"><a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button"><span><?php echo $button_cart; ?></span></a></div>
      
      </div>
       <!--!pruduct_price-->
      
     
     
     
    </div>
     <!--product_up-->
    
    
     <!--product_dawn-->
    	<div class="product_dawn">
        
        
      <div class="review">
             
             <?php echo $product['reviews']; ?>
             </div>
             
             <div class="rating">
             <img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" />
        
		</div>    
        </div>  
        <!--!product_dawn-->
    </div>
    <?php } ?>
  </div>
  
  <!--!product_list-->
  
  
 <div class="pagination"><?php echo $pagination; ?></div>
 <?php } else { ?>
 <div class="content"><?php echo $text_empty; ?></div>
 <?php }?>
 <?php echo $content_bottom; ?>
</div>

<?php echo $footer; ?>