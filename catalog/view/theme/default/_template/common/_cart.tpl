
  <br><br>  <div class="link">
                    <?php if (!$logged) { ?>
                    <?php echo $text_welcome; ?>
                    <?php } else { ?>
                    <?php echo $text_logged; ?>
                    <?php } ?>
             	 </div>
         <br>
                 <div id="wish" class="link">
                 <a href="<?php echo $wishlist; ?>" id="wishlist_total"><?php echo $text_wishlist; ?></a>
                 </div>

<br><br>
<div class="box" id="module_cart">
  <div class="box-heading"><a href="<?php echo $cart; ?>"><?php echo $heading_title; ?></a></div>
  <div class="box-content">
  <div class="cart-module">
	
	<? if (empty($total_quant)) echo "0"; else echo $total_quant; ?> товара<br>
    
     <?php echo $total3; ?>

  </div>
  </div>
</div>
