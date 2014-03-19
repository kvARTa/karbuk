<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content">
<div class="box-heading"><?php echo $heading_title; ?>
</div>
<div class="box-content">
<?php echo $content_top; ?>
  <div class="breadcrumb">
   <?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
        <?php echo $breadcrumb['separator']; ?><?php if($i+1<count($breadcrumbs)) { ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a> <?php } else { ?><?php echo $breadcrumb['text']; ?><?php } ?>
        <?php } ?>
  </div>
  
  <div class="content"><?php echo $text_error; ?></div>
  
  <?if (isset($tovar_in_cart)) { ?>
	<div class="cart-info">
	<table  border="0" class="tovar_in_cart_tb">
	 <tr>
		<td class="tovar_in_cart_tb_left"> 
		  Быстрое добавление по коду
		</td>
		<td class="tovar_in_cart_tb_right" valign="top"> 
		</td>
	  </tr>

	  <tr>
		<td class="tovar_in_cart_tb_left"> 
			 <input id="sdass" name="model_to_cart" type="text" class="input cart" placeholder="Введите коды товаров, через запятую" />
		</td>
		<td class="tovar_in_cart_tb_right"> 
			<a href="javascript: void(0);" onclick="$.post('index.php?route=checkout/cart/add_model',{model_to_cart:$('#sdass').val()},function(){window.location.reload();});" class="button grey"></a>
		</td>
	  </tr>
	</table>
	</div>	
  <? } ?>
  <div class="buttons">
    <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
  </div>
  <?php echo $content_bottom; ?></div></div>
<?php echo $footer; ?>