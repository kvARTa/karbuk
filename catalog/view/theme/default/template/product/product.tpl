<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content">
<script type="text/javascript">
Shadowbox.init({
    handleOversize:     "drag",
    displayNav:         true,
    handleUnsupported:  "remove",
    autoplayMovies:     false
});
</script>
<div class="box-heading">Карточка товара
</div>
<div class="box-content">

<?php echo $content_top; ?>
  <div class="breadcrumb" style="display:block;">
  <?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
        <?php echo $breadcrumb['separator']; ?><?php if($i+1<count($breadcrumbs)) { ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a> <?php } else { ?><?php echo $breadcrumb['text']; ?><?php } ?>
        <?php } ?>


  </div>

  <div class="product-info">
    <?php if ($thumb || $images) { ?>
    <div class="left">
      <?php if ($thumb) { ?>
      <div class="image"><a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" class="colorbox" rel="colorbox"><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image" /></a></div>
      <?php } ?>
      <?php if ($images) { ?>
      <div class="image-additional">

<div id="slider1">
		<a class="buttons prev" href="#">left</a>
		<div class="viewport">
			<ul class="overview">



        <?php foreach ($images as $image) { ?>
        <li>
        <a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" class="colorbox" rel="colorbox"><img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a>
        </li>
        <?php } ?>
        </ul>
		</div>
		<a class="buttons next" href="#">right</a>
	</div>
      </div>
      <?php } ?>
    </div>
    <?php } ?>
    <div class="right">
    <h1 class="textRed"><?php echo $heading_title; ?></h1>

      <div class="description">

        <h2 style="font-weight: bolder; color: #000;"><?php echo $text_model; ?> <?php echo $model; ?><br /></h2>
        <?php if ($manufacturer) { ?>
        <span><?php echo $text_manufacturer; ?></span> <a href="<?php echo $manufacturers; ?>" style="text-transform:uppercase;">
        <?php echo $manufacturer; ?></a><br />
        <?php } ?>
        <?php if ($reward) { ?>
        <span><?php echo $text_reward; ?></span> <?php echo $reward; ?><br />
        <?php } ?>
<!--         <?php if ($stock) { ?>
        <span><?php echo $text_stock; ?></span> <?php echo $stock; ?>
        <?php } ?> -->
      </div>
      <?php if($product_colors) { ?>
            <div class="product_colors">
                <ul>
                <?php foreach ($product_colors as $item) { ?>
                     <li>
                         <a <?php echo $item['current'] ? 'current' : '' ; ?> href="<?php echo $item['href']?>" title="<?php echo $item['color_title']?>">
                            <img src="<?php echo $item['color_img']?>"/>
                         </a>
                     </li>
                <?php } ?>
                </ul>
            </div>
        <?php } ?>
      <?php if ($price) { ?>
      <div class="price"><div class="text_price"><?php echo $text_price; ?></div>
        <?php if (!$special) { ?>
        <?php echo $price; ?>
        <?php } else { ?>
        <span class="price-old"><?php echo $price; ?></span> <span class="price-new"><?php echo $special; ?></span>
        <?php } ?>
        <br />
        <?php if ($tax) { ?>
        <span class="price-tax"><?php echo $text_tax; ?> <?php echo $tax; ?></span><br />
        <?php } ?>
        <?php if ($points) { ?>
        <span class="reward"><small><?php echo $text_points; ?> <?php echo $points; ?></small></span><br />
        <?php } ?>
        <?php if ($discounts) { ?>
        <br />
        <div class="discount">
          <?php foreach ($discounts as $discount) { ?>
          <?php echo sprintf($text_discount, $discount['quantity'], $discount['price']); ?><br />
          <?php } ?>
        </div>
        <?php } ?>
        
        
        
<script type="text/javascript"><!--

function animBoxShadow(product_id, self){
	console.log($(self));
	setTimeout(function(){
		$('.left_cart_empty').remove();
		$('.left_cart').remove();
		$('#cart').prepend('<a href="index.php?route=checkout/cart"><div class="left_cart" >  </div></a>');
	}, 1000);		
				
	$(self).animate({"box-shadow":"0px 0px 10px #f6364d"});
    // Animation complete.
	$(self).val("Добавлено");
	
	setTimeout(function(){
		$(self).animate({"box-shadow":"0px 0px 0px"});
		$(self).val("В корзину");
	}, 1500);
	
}
 
//--></script>       



        <div class="cart">

        <div>

          <input type="text" name="quantity" size="2" value="<?php echo $multiplicity; ?>" class="input_q"  id="item-<?php echo $product_id; ?>"/>

 <div class="input_arrow_q">
		<input type="button" class="quantity_box_button quantity_box_button_up" onclick="var qty_st = <?php echo $multiplicity; ?>; var qty_el = document.getElementById('item-<?php echo $product_id; ?>'); var qty = qty_el.value; if( !isNaN( qty )) qty_el.value=qty_el.value*1+qty_st;return false;" />
		<input type="button" class="quantity_box_button quantity_box_button_down" onclick="var qty_st = <?php echo $multiplicity; ?>; var qty_el = document.getElementById('item-<?php echo $product_id; ?>'); var qty = qty_el.value; if( !isNaN( qty ) &amp;&amp; qty > 0 ) if(qty_el.value*1-qty_st>0)qty_el.value=qty_el.value*1-qty_st;return false;" />

       </div>
          <input type="hidden" name="product_id" size="2" value="<?php echo $product_id; ?>" />

         
          <input type="button" onclick="animBoxShadow('<?php echo $product['product_id']; ?>', this);" value="<?php echo $button_cart; ?>" id="button-cart" class="button_q" class="button" />
        </div>
        

         <?php if ($minimum > 1) { ?>
        <div class="minimum"><?php echo $text_minimum; ?></div>
        <?php } ?>
           <?//dymm
            if($multiplicity && $multiplicity > 1){
              ?><br/><br/>
              <small style="font-size:12px;">Кратность товара равна <?=$multiplicity?></small>
              <?
            }
          ?>
      </div>

   <?php } ?>
	<?
	
		//dymm
		if (isset($this->session->data['compare']) && $this->session->data['compare']){
		    if (in_array($product_id, $this->session->data['compare']))
			    $show_comp = false;
		    else
			    $show_comp = true;
		}else{
		    $show_comp = true;
		}
		if (isset($this->session->data['wishlist']) && $this->session->data['wishlist']){
		    if (in_array($product_id, $this->session->data['wishlist']))
			$show_wish = false;
		    else
			$show_wish = true;
		}else{
		    $show_wish = true;
		}
	?>
	<div style="float:left; width: 370px;">
      <div class="wishlist" id="wishlist<?php echo $product_id; ?>">
      	<input onclick="addToWishList('<?php echo $product_id; ?>');" name="wishlist" type="checkbox" value="" <?=((!$show_wish)?"checked":"")?>/>
      	<a class="wish" <?=(($show_wish)?"":"style='display:none'")?> onclick="addToWishList('<?php echo $product_id; ?>');">
      		<?php echo $button_wishlist; ?>
      	</a>
      	<a class="textRed gowish" <?=((!$show_wish)?"":"style='display:none'")?> href="index.php?route=account/wishlist">
      		Перейти в избранные
      	</a>
      </div>
      <div class="compare" id="compare<?php echo $product_id; ?>">
      	<input onclick="addToCompare('<?php echo $product_id; ?>');" name="compare" type="checkbox" value="" <?=((!$show_comp)?"checked":"")?>/>
      	<a class="comp" <?=(($show_comp)?"":"style='display:none'")?> onclick="addToCompare('<?php echo $product_id; ?>');">
      		<?php echo $button_compare; ?>
      	</a>
      	<a class="textRed gocomp" <?=((!$show_comp)?"":"style='display:none'")?> href="index.php?route=product/compare" rel="shadowbox; width=1024">
      		Перейти к сравнению
      	</a>
      </div>     
</div>      	
      






        <div class="share"><!-- AddThis Button BEGIN -->
         <div class="share42init"></div>
<script type="text/javascript" src="/share42/share42.js"></script>
<script type="text/javascript">share42('/share42/')</script>
          <!-- AddThis Button END -->
        </div>

      </div>



      <?php if ($review_status) { ?>
      <div class="review">
        <div><img src="catalog/view/theme/default/image/stars-<?php echo $rating; ?>.png" alt="<?php echo $reviews; ?>" />&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $reviews; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $text_write; ?></a></div>

      </div>
      <?php } ?>
    </div>
  
        <div class="prod-info">
      
      	Внимание! Цена действительна только при заказе товара через интернет-магазин. В розничных магазинах и при заказе по телефону цена может быть другой. <br />
        Изображения товара, приведенные на сайте www.karbuk.ru, включая цвет, размер, могут отличаться от реального внешнего вида товара.
        
      </div>

  
  </div>
  
  
  
  <div id="tabs" class="htabs"><a href="#tab-description"><?php echo $tab_description; ?></a>
    <?php if ($attribute_groups) { ?>
    <a href="#tab-attribute"><?php echo $tab_attribute; ?></a>
    <?php } ?>
    <?php if ($review_status) { ?>
    <a href="#tab-review"><?php echo $tab_review; ?></a>
    <?php } ?>
    <?php if ($similar_products) { ?>
    <a href="#tab-similar">Аналогичные товары</a>
    <?php } ?>
    <?php if ($products) { ?>
    <a href="#tab-related"><?php echo $tab_related; ?> (<?php echo count($products); ?>)</a>
    <?php } ?>
  </div>
  <div id="tab-description" class="tab-content" style="color: #000">
  <?php $description = str_replace("\n", "", $description);
  $description = str_replace("\r", "", $description);
 $description = str_replace("<br /><br />", "<br>", $description);
  echo $description; 
  ?></div>
  <?php if ($attribute_groups) { ?>
  <div id="tab-attribute" class="tab-content">
    <table class="attribute">
      <?php foreach ($attribute_groups as $attribute_group) { ?>
      <tbody>
        <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
        <tr>
          <td class="tech_fc"><?php echo $attribute['name']; ?></td>
          <td class="tech_sc"><?php echo $attribute['text']; ?></td>
        </tr>
        <?php } ?>
      </tbody>
      <?php } ?>
    </table>
  </div>
  <?php } ?>
  <?php if ($review_status) { ?>
  <div id="tab-review" class="tab-content">
    <div id="review"></div>
    <h2 id="review-title"><?php echo $text_write; ?></h2>
    <b><?php echo $entry_name; ?></b><br />
    <input type="text" name="name" value="" />
    <br />
    <br />
    <b><?php echo $entry_review; ?></b>
    <textarea name="text" cols="40" rows="8" style="width: 98%;"></textarea>
    <span style="font-size: 11px;"><?php echo $text_note; ?></span><br />
    <br />
    <b><?php echo $entry_rating; ?></b> <span><?php echo $entry_bad; ?></span>&nbsp;
    <input type="radio" name="rating" value="1" />
    &nbsp;
    <input type="radio" name="rating" value="2" />
    &nbsp;
    <input type="radio" name="rating" value="3" />
    &nbsp;
    <input type="radio" name="rating" value="4" />
    &nbsp;
    <input type="radio" name="rating" value="5" />
    &nbsp;<span><?php echo $entry_good; ?></span><br />
    <br />
    <b><?php echo $entry_captcha; ?></b><br />
    <input type="text" name="captcha" value="" />
    <br />
    <img src="index.php?route=product/product/captcha" alt="" id="captcha" /><br />
    <br />
    <div class="buttons">
      <div class="right"><a id="button-review" class="button"><?php echo $button_continue; ?></a></div>
    </div>
  </div>
  <?php } ?>
  <?php if ($products) { ?>
  <div id="tab-related" class="tab-content">
    <div class="box-product">
      <?php $k=0; foreach ($products as $product) { $k=$k+1; ?>
      <div <? if ($k==4)echo 'class="four"'; if ($k==4) $k=0 ?>>
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
         </div>
        <?php } ?>
        <?php if ($product['rating']) { ?>
        <div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
        <?php } ?>


        <div class="cart">

 <input type="text" value="1" id="item-<?php echo $product['product_id']; ?>" class="input_q" />

 <div class="input_arrow_q">
 <input type="button" class="quantity_box_button quantity_box_button_up" onclick="var qty_el = document.getElementById('item-<?php echo $product['product_id']; ?>'); var qty = qty_el.value; if( !isNaN( qty )) qty_el.value++;return false;" />
		<input type="button" class="quantity_box_button quantity_box_button_down" onclick="var qty_el = document.getElementById('item-<?php echo $product['product_id']; ?>'); var qty = qty_el.value; if( !isNaN( qty ) &amp;&amp; qty > 0 ) qty_el.value--;return false;" />
       </div>


<input type="button" value="<?php echo $button_cart; ?>" onclick="addQtyToCart('<?php echo $product['product_id']; ?>');" class="button_q" />

      </div>



        </div>
      <?php } ?>
    </div>
  </div>
  <?php } ?>

  <?php if ($similar_products) { ?>
  <div id="tab-similar" class="tab-content">
    <div class="box-product">
      <?php $k=0; foreach ($similar_products as $product) { $k=$k+1; ?>
      <div <? if ($k==4)echo 'class="four"'; if ($k==4) $k=0 ?>>
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
		<?php if ($product['rating']) { ?>
		<div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
		<?php } ?>
		<?php if ($product['price']) { ?>
		<div class="cart">
			<input type="text" value="1" id="item-<?php echo $product['product_id']; ?>" class="input_q" />
			<div class="input_arrow_q">
			<input type="button" class="quantity_box_button quantity_box_button_up" onclick="var qty_el = document.getElementById('item-<?php echo $product['product_id']; ?>'); var qty = qty_el.value; if( !isNaN( qty )) qty_el.value++;return false;" />
			<input type="button" class="quantity_box_button quantity_box_button_down" onclick="var qty_el = document.getElementById('item-<?php echo $product['product_id']; ?>'); var qty = qty_el.value; if( !isNaN( qty ) &amp;&amp; qty > 0 ) qty_el.value--;return false;" />
			</div>
			<input type="button" value="<?php echo $button_cart; ?>" onclick="addQtyToCart('<?php echo $product['product_id']; ?>', this);" class="button_q" />
            
		</div>
		<?php } ?>
        </div>
      <?php } ?>
    </div>
  </div>
  <?php } ?>

  <?php if ($tags) { ?>
  <div class="tags"><b><?php echo $text_tags; ?></b>
    <?php for ($i = 0; $i < count($tags); $i++) { ?>
    <?php if ($i < (count($tags) - 1)) { ?>
    <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
    <?php } else { ?>
    <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
    <?php } ?>
    <?php } ?>
  </div>
  <?php } ?> </div><?php echo $content_bottom; ?></div>



<script type="text/javascript">
    $(document).ready(function() {
        $('table.attribute tr:odd').addClass('odd');
        $('table.attribute tr:even').addClass('even');
    });
</script>

<script type="text/javascript"><!--
$('.colorbox').colorbox({
	overlayClose: true,
	opacity: 0.5
});


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





//--></script>



<script type="text/javascript"><!--
$('#button-cart').bind('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: $('.product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea'),
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, information, .error').remove();

			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						$('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
					}
				}
			}

			if (json['success']) {
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');

				$('.success').fadeIn('slow');

				$('.left_cart_empty').remove();
				$('.left_cart').remove();
				$('#cart').prepend('<div class="left_cart" >  </div>');

				$('#cart-total').html(json['total']);

				//$('html, body').animate({ scrollTop: 0 }, 'slow');
			}
		}
	});
});
//--></script>
<?php if ($options) { ?>
<script type="text/javascript" src="catalog/view/javascript/jquery/ajaxupload.js"></script>
<?php foreach ($options as $option) { ?>
<?php if ($option['type'] == 'file') { ?>
<script type="text/javascript"><!--
new AjaxUpload('#button-option-<?php echo $option['product_option_id']; ?>', {
	action: 'index.php?route=product/product/upload',
	name: 'file',
	autoSubmit: true,
	responseType: 'json',
	onSubmit: function(file, extension) {
		$('#button-option-<?php echo $option['product_option_id']; ?>').after('<img src="catalog/view/theme/default/image/loading.gif" class="loading" style="padding-left: 5px;" />');
		$('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', true);
	},
	onComplete: function(file, json) {
		$('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', false);

		$('.error').remove();

		if (json['success']) {
			alert(json['success']);

			$('input[name=\'option[<?php echo $option['product_option_id']; ?>]\']').attr('value', json['file']);
		}

		if (json['error']) {
			$('#option-<?php echo $option['product_option_id']; ?>').after('<span class="error">' + json['error'] + '</span>');
		}

		$('.loading').remove();
	}
});
//--></script>
<?php } ?>
<?php } ?>
<?php } ?>
<script type="text/javascript"><!--
$('#review .pagination a').live('click', function() {
	$('#review').fadeOut('slow');

	$('#review').load(this.href);

	$('#review').fadeIn('slow');

	return false;
});

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').bind('click', function() {
	$.ajax({
		url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
		type: 'post',
		dataType: 'json',
		data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-review').attr('disabled', true);
			$('#review-title').after('<div class="attention"><img src="catalog/view/theme/default/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#button-review').attr('disabled', false);
			$('.attention').remove();
		},
		success: function(data) {
			if (data['error']) {
				$('#review-title').after('<div class="warning">' + data['error'] + '</div>');
			}

			if (data['success']) {
				$('#review-title').after('<div class="success">' + data['success'] + '</div>');

				$('input[name=\'name\']').val('');
				$('textarea[name=\'text\']').val('');
				$('input[name=\'rating\']:checked').attr('checked', '');
				$('input[name=\'captcha\']').val('');
			}
		}
	});
});
//--></script>
<script type="text/javascript"><!--
$('#tabs a').tabs();
//--></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript"><!--
if ($.browser.msie && $.browser.version == 6) {
	$('.date, .datetime, .time').bgIframe();
}

$('.date').datepicker({dateFormat: 'yy-mm-dd'});
$('.datetime').datetimepicker({
	dateFormat: 'yy-mm-dd',
	timeFormat: 'h:m'
});
$('.time').timepicker({timeFormat: 'h:m'});
//--></script>


<script type="text/javascript">
Shadowbox.init({
language: 'ru',
players: ['img','iframe'],
});
</script>



<?php echo $footer; ?>