
	
<?php if ($products || $vouchers) { ?>
<div class="cart_info">
<a href="<?php echo $cart; ?>" >В корзине</a>
	<div class="colich"><?php echo $total2 ?> товара</div>
  
    
    <div class="suma" >на <?php echo $total3 ?></span></div>
 

</div>
	<?php } else { ?>
    <div class="cart_info">
		<div class="empty"><?php echo $text_empty; ?></div>

</div>
	<?php } ?>
    
    

