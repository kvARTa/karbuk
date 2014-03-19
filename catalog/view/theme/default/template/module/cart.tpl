<?php if ($products || $vouchers) { ?>
<div id="cart">
<a href="index.php?route=checkout/cart"><div class="left_cart">&nbsp;</div></a>


<div class="right_cart">
  <div class="head">
       <span id="cart-total"><?php echo $text_items; ?></span>
       </div>
   <div class="right_cart_link">
  <a href="index.php?route=checkout/cart"><?php echo $text_checkout; ?></a>
  </div>
</div>

</div>


<? } else { ?>
    
    
   <div id="cart">
	<a href="index.php?route=checkout/cart"><div class="left_cart_empty">&nbsp;</div></a>
<div class="right_cart">
  <div class="head">
       <span id="cart-total"><?php echo $text_items; ?></span>
       </div>
   <div class="link">
  <a href="index.php?route=checkout/cart"><?php echo $text_checkout; ?></a>
  </div>
  </div>

</div>
    
    
    <?php } ?>
