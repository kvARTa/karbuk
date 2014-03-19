

     
     

<table class="cart">
 <?php if ($products || $vouchers) { ?>

<? if (empty($total_quant)) echo "0"; else echo $total_quant; ?> товара<br>
    
     <?php echo $total3; ?>
</table>
<div class="checkout"></div>
<?php } else { ?>
<div class="empty"></div>
<?php } ?>
