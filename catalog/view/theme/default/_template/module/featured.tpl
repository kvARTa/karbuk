<div class="box">
  <div class="box-heading textRed"><?php echo $heading_title; ?></div>
  <div class="box-content featured">
    
    
    <div id="carousel33">
  <ul class="jcarousel-skin-opencart2">
  
    
      <?php $k=0; foreach ($products as $product) { $k=$k+1; ?>
      <li <? if ($k=='4') echo 'class="last_r"'; ?> >
        <?php if ($product['thumb']) { ?>
        <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
        <?php } ?>
         <div class="name_price">
        
        <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
        <?php if ($product['price']) { ?>
        <div class="price">
          <?php if (!$product['special']) { ?>
          <?php echo $product['price']; ?>
          <?php } else { ?>
          <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
          <?php } ?>
        </div>
        <?php } ?>
        </div>
        <div class="cart">
    	
 <input type="text" value="1" id="item-<?php echo $product['product_id']; ?>" class="input_q" />

 <div class="input_arrow_q">  
 <input type="button" class="quantity_box_button quantity_box_button_up" onclick="var qty_el = document.getElementById('item-<?php echo $product['product_id']; ?>'); var qty = qty_el.value; if( !isNaN( qty )) qty_el.value++;return false;" />
		<input type="button" class="quantity_box_button quantity_box_button_down" onclick="var qty_el = document.getElementById('item-<?php echo $product['product_id']; ?>'); var qty = qty_el.value; if( !isNaN( qty ) &amp;&amp; qty > 0 ) qty_el.value--;return false;" />
       </div>
 
 
<input type="button" value="<?php echo $button_cart; ?>" onclick="addQtyToCart('<?php echo $product['product_id']; ?>');" class="button_q" />
      </div>
              
      </li>
      <?php } ?>
    </ul>
    
     
  </div>
</div></div>
<script type="text/javascript"><!--
$('#carousel33 ul').jcarousel({
	vertical: false,
	visible: 4,
	scroll: 15
});
//--></script>
