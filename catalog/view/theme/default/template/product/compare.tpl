<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/stylesheet.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Сравнение товаров</title>




<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/stylesheet.css" />

<script type="text/javascript" src="catalog/view/javascript/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css" />
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/external/jquery.cookie.js"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/colorbox/jquery.colorbox.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/colorbox/colorbox.css" media="screen" />
<script type="text/javascript" src="catalog/view/javascript/jquery/tabs.js"></script>
<script type="text/javascript" src="catalog/view/javascript/common.js"></script>

<script type="text/javascript" src="catalog/view/javascript/jquery/jquery.placeholder.min.js"></script>


<link rel="stylesheet" type="text/css" href="shadowbox/shadowbox.css">
<script type="text/javascript" src="shadowbox/shadowbox.js"></script>






<script type="text/javascript" src="catalog/view/javascript/jquery/jquery.tinycarousel.min.js"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery.animate-shadow-min.js"></script>

	<script type="text/javascript">
		$(document).ready(function(){
			$('#slider1').tinycarousel();	
		});
		
		jQuery('input[placeholder], textarea[placeholder]').placeholder();
		
		function addQtyToCart(product_id, self){
	$(self).animate({"box-shadow":"0px 0px 10px #f6364d"});
    // Animation complete.
	$(self).val("Добавлено");
	setTimeout(function(){
		$(self).animate({"box-shadow":"0px 0px 0px"});
		$(self).val("В корзину");
	}, 1500);
 
  var qty = $('#item-' + product_id).val();
  if ((parseFloat(qty) != parseInt(qty)) || isNaN(qty)) {
        qty = 1;
  }
  addToCart(product_id, qty);
}
		
	</script>	




<!--[if IE 7]>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/ie7.css" />
<![endif]-->
<!--[if lt IE 7]>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/ie6.css" />
<script type="text/javascript" src="catalog/view/javascript/DD_belatedPNG_0.0.8a-min.js"></script>
<script type="text/javascript">
DD_belatedPNG.fix('#logo img');
</script>
<![endif]-->



</head>

<?php 
if (count($_SESSION['compare'])<2){
?>
<script>
//alert('Пожалуйста, выберите более одного товара, для сравнения');
//parent.Shadowbox.close();
</script>
<?php
die('<center><h2>Пожалуйста, выберите более одного товара, для сравнения</center</h2>');
}
?>



<div id="content">

<!-- <div class="box-heading">Сравнение товаров

<div class="close2">
<a href="#" onclick="parent.Shadowbox.close();return false;" >  </a >

</div>
</div> -->

<div class="box-content-compare">

  <div class="breadcrumb">
   <?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
        <?php echo $breadcrumb['separator']; ?><?php if($i+1<count($breadcrumbs)) { ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a> <?php } else { ?><?php echo $breadcrumb['text']; ?><?php } ?>
        <?php } ?>
  </div>
  <div id="notification"></div>
  
<?php if ($success) { ?>
<div class="success">Товар удален из списка сравнений</div>
<?php } ?>
  <?php if ($products) { ?>
  <table class="compare-info">
     <tbody>
      <tr>
        <td  class="com_first_col grey-td">Для сравнения вы выбрали</td>
        <?php foreach ($products as $product) { ?>
        <td class="name grey-td"><a href="<?php echo $products[$product['product_id']]['href']; ?>" style="color:#000;text-decoration:none;"><?php echo $products[$product['product_id']]['name']; ?></a></td>
        <?php } ?>
      </tr>
      <tr>
        <td></td>
        <?php foreach ($products as $product) {  ?>
        <td><?php if ($products[$product['product_id']]['thumb']) { ?>
       <div class="image">   <img src="<?php echo $products[$product['product_id']]['thumb']; ?>" alt="<?php echo $products[$product['product_id']]['name']; ?>" /></div>
          
           
           
           
           
            <div class="model"><h2><b> Код:
       <?php echo $products[$product['product_id']]['model']; ?></b></h2>
        </div>
           
           
           
        <div class="manufacturer"><?php echo $products[$product['product_id']]['manufacturer']; ?></div>
           
           <div class="price">
           
           <?php if ($products[$product['product_id']]['price']) { ?>
          <?php if (!$products[$product['product_id']]['special']) { ?>
          <?php echo $products[$product['product_id']]['price']; ?>
          <?php } else { ?>
          <span class="price-old"><?php echo $products[$product['product_id']]['price']; ?></span>
           <span class="price-new"><?php echo $products[$product['product_id']]['special']; ?></span>
          <?php } ?>
          <?php } ?>
           
           
           </div>
           
           
           
           
           <div class="cart">
    	
 <input type="text" value="<?php echo $product['multiplicity']; ?>" id="item-<?php echo $product['product_id']; ?>" class="input_q" />

 <div class="input_arrow_q">  
  <input type="button" class="quantity_box_button quantity_box_button_up" onclick="var qty_st = <?php echo $product['multiplicity']; ?>; var qty_el = document.getElementById('item-<?php echo $product['product_id']; ?>'); var qty = qty_el.value; if( !isNaN( qty )) qty_el.value=qty_el.value*1+qty_st;return false;" />
		<input type="button" class="quantity_box_button quantity_box_button_down" onclick="var qty_st = <?php echo $product['multiplicity']; ?>; var qty_el = document.getElementById('item-<?php echo $product['product_id']; ?>'); var qty = qty_el.value; if( !isNaN( qty ) &amp;&amp; qty > 0 ) if(qty_el.value*1-qty_st>0)qty_el.value=qty_el.value*1-qty_st;return false;" />
      </div>
 
 
<input type="button" value="<?php echo $button_cart; ?>" onclick="addQtyToCart('<?php echo $product['product_id']; ?>', this);" class="button_q" />
      </div>
           
          
          <?php } ?>
          
          <br>
          
           <div class="compare"><input name="compare" type="checkbox" value="" /><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" style="color:#313131">Добавить в избранные</a></div>
          
      
           
        
  
          
          </td>
        <?php } ?>
      </tr>
      
<?php /*      <tr class="grey-td2">
        <td class="com_first_col"><?php echo $text_weight; ?></td>
        <?php foreach ($products as $product) { ?>
        <td><?php echo $products[$product['product_id']]['weight']; ?></td>
        <?php } ?>
      </tr>
      <tr class="grey-td">
        <td><?php echo $text_dimension; ?></td>
        <?php foreach ($products as $product) { ?>
        <td><?php echo $products[$product['product_id']]['length']; ?> x <?php echo $products[$product['product_id']]['width']; ?> x <?php echo $products[$product['product_id']]['height']; ?></td>
        <?php } ?>
      </tr>
 */ ?>
    </tbody>
    
     <table class="compare-info">
     <tbody>
    <?php foreach ($attribute_groups as $attribute_group) { ?>
   
    <?php $k=0; foreach ($attribute_group['attribute'] as $key => $attribute) { $k=$k+1; ?>
    <tbody>
      <tr <? if ($k==1) {echo 'class="grey-td2"'; $k=0;} else echo 'class="grey-td"'?> >
        <td align="center"><?php echo $attribute['name']; ?></td>
        <?php foreach ($products as $product) { ?>
        <?php if (isset($products[$product['product_id']]['attribute'][$key])) { ?>
        <td><?php echo $products[$product['product_id']]['attribute'][$key]; ?></td>
        <?php } else { ?>
        <td></td>
        <?php } ?>
        <?php } ?>
      </tr>

    </tbody>
    <?php } ?>
    <?php } ?>
    <tr>
      <td style="width:50px;"></td>
      <?php foreach ($products as $product) { ?>
      <td class="remove"><a href="<?php echo $product['remove']; ?>" class="button1">Удалить из сравнения</a></td>
      <?php } ?>
     </tr>
    </tr>
  </table>
    
  <div class="close3">
<a href="#" onclick="parent.Shadowbox.close();return false;" >  </a >

</div>
  
  <?php } else { ?>
  <div class="content"><?php echo $text_empty; ?></div>
  
  <?php } ?>
  </div>

  
<body>
</body>
</html>
