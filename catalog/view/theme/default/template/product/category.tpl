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
<div class="box-heading">Категория
</div>
<div class="box-content">


<?php echo $content_top; ?>
  <div class="breadcrumb" style="display:block;">


     <?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
        <?php echo $breadcrumb['separator']; ?><?php if($i+1<count($breadcrumbs)) { ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a> <?php } else { ?><?php echo $breadcrumb['text']; ?><?php } ?>
        <?php } ?>



  </div>
  <h1><?php echo $heading_title; ?></h1>

    <?php if($big_image) { ?>
        <div class="big_image">
            <img src="<?php echo $big_image; ?>"/>
        </div>
    <?php } ?>

<?php if ($categories) { ?>
    <?php if ($series_category) { ?>
        <div class="category-list series-category">
        <?php for ($i = 0; $i < count($categories);) { ?>
        <ul>
            <?php $j = $i + 2; ?>
            <?php for (; $i < $j; $i++) { ?>
            <?php if (isset($categories[$i])) { ?>
            <li class="<?php if($categories[$i]['thumb']) { ?>catimglist<?php } ?>">
                <a class="vvv" href="<?php echo $categories[$i]['href']; ?>">
                    <div class="catimg_container">
                        <?php if($categories[$i]['thumb']) { ?>
                        <img src="<?php echo $categories[$i]['thumb'];?>">
                        <?php } ?>
                    </div>
                    <div class="catname_container">
                        <div class="catname"><?php echo $categories[$i]['name']; ?></div>
                    </div>

                </a>
            </li>
            <?php } ?>
            <?php } ?>
        </ul>
        <?php } ?>
        </div>
    <?php } else { ?>
    <div class="category-list">
        <?php $r=1; $td=1; $col = 1; $catInCol = 1;?>
        <table style="width: 771px;">
            <tr>
                <td class="cat-column" style = "border-left: 0;">
                    <ul>
                        <?php $catCount = count($categories); ?>
                        <?php $maxCatInCol = ceil($catCount/3); ?>
                        <?php foreach($categories as $category) { ?>
                        <li>
                            <a href="<?php echo $category['href']; ?>">
                                <div class="catname_container">
                                    <div class="catname"><?php echo $category['name']; ?></div>
                                </div>
                            </a>
                        </li>
                        <?php
                            if ($catInCol < $maxCatInCol){
                                $catInCol++;
                            }else{
                                echo '</ul> </td>';
                                echo $col == 3 ? '' : '<td class="cat-column"> <ul>';
                                $col ++;
                                $maxCatInCol = ceil(($catCount-$catInCol)/2);
                                $catInCol = 1;
                            }
                        }
                        ?>
            </tr>
        </table>
    </div>
    <?php } ?>
<?php } ?>




  <?php if ($products) { ?>



<div class="product-filter">

     <?
     //dymm
     ?> 
    <div class="price-download">
    	<a href="index.php?route=tool/price/download&path=<?=$price_path?>">Скачать прайс</a>
    </div>
    <div style="float: right">
    <div class="limit"><b><?php echo $text_limit; ?></b>


      <a href="<?php echo $hreflimit15; ?>">15</a>
       <a href="<?php echo $hreflimit30; ?>">30</a>
        <a href="<?php echo $hreflimit100; ?>">100</a>


    </div>
    <div class="display"><b><?php echo $text_display; ?></b> <?php echo $text_list; ?>  <a onclick="display('grid');"><?php echo $text_grid; ?></a></div>

    <div class="sort"><b><?php echo $text_sort; ?></b>

    <!--sort-->

     <?php if ($order=='ASC') { ?>
         <a href="<?php echo $href2; ?>">по цене</a>

        <?php } ?>
         <?php if ($order=='DESC') { ?>
         <a href="<?php echo $href; ?>">по цене</a>

        <?php } ?>




     <?php if ($order=='ASC') { ?>
         <a href="<?php echo $hrefna2; ?>">по наименованию</a>

        <?php } ?>
         <?php if ($order=='DESC') { ?>
         <a href="<?php echo $hrefna; ?>">по наименованию</a>

        <?php } ?>


         <?php if ($order=='ASC') { ?>
         <a href="<?php echo $hrefrating2; ?>">по популярности</a>

        <?php } ?>
         <?php if ($order=='DESC') { ?>
         <a href="<?php echo $hrefrating; ?>">по популярности</a>

        <?php } ?>





    <!--sort-->


   </div>

    </div>
  </div>

  <div class="pagination"><?php echo $pagination; ?></div>


  <div class="product-list">
    <?php $k=0;  $p=0; foreach ($products as $product) {  $k=$k+1; $p=$p+1; ?>
    <div <? if ($k==1) { echo 'class="grey"';  } if ($k==2) $k=0; ?>  <? if ($p==3) { echo 'id="thre"';  } if ($p==3) $p=0; ?> >
       <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>

      <?php if ($product['thumb']) { ?>
      <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
      <?php } ?>
      <div class="model">Код: <?php echo $product['model'];  ?></div>
	  <?php if($product['multiplicity'] && $product['multiplicity'] > 1){ ?>
	  <div class="multiplicity">Кратность товара равна <?php echo $product['multiplicity'];  ?></div>
		<?php } ?>
      <div class="manufacturer">Производитель <span ><?php echo $product['manufacturer']; ?></span></div>
      <?php if ($product['price']) { ?>
	  <div class="stock"><?php echo $text_stock;?> <?php echo $product['stock']; ?></div>
      <?php } ?>


      <div class="description"><span style="color: #000"><?php echo $product['description']; ?></span></div>

      <?php if($product['product_colors']) { ?>
      <div class="product_colors">
          <ul>
              <?php foreach ($product['product_colors'] as $item) { ?>
              <li>
                  <a <?php echo $item['current'] ? 'class="current"' : '' ; ?> href="<?php echo $item['href']?>" title="<?php echo $item['color_title']?>">
                  <img src="<?php echo $item['color_img']?>"/>
                  </a>
              </li>
              <?php } ?>
          </ul>
      </div>
      <?php } ?>

      <?php if ($product['price']) { ?>
      <div class="price">
        <?php if (!$product['special']) { ?>
        <?php echo $product['price']; ?>
        <?php } else { ?>
        <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
        <?php } ?>
        <?php if ($product['tax']) { ?>
        <br />
        <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
        <?php } ?>
      </div>
      <?php } ?>
      <?php if ($product['rating']) { ?>
      <div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
      <?php } ?>
      <?php if ($product['price']) { ?>
       <?//dymm
            if($product['multiplicity']){
              ?>
              <small>Кратность товара равна <?=$multiplicity?></small>
              <?
            }
          ?>
      <div class="cart">
		<input type="text" value="<?php echo $product['multiplicity']; ?>" id="item-<?php echo $product['product_id']; ?>" class="input_q" />
		<div class="input_arrow_q">
		<input type="button" class="quantity_box_button quantity_box_button_up" onclick="var qty_st = <?php echo $product['multiplicity']; ?>; var qty_el = document.getElementById('item-<?php echo $product['product_id']; ?>'); var qty = qty_el.value; if( !isNaN( qty )) qty_el.value=qty_el.value*1+qty_st;return false;" />
		<input type="button" class="quantity_box_button quantity_box_button_down" onclick="var qty_st = <?php echo $product['multiplicity']; ?>; var qty_el = document.getElementById('item-<?php echo $product['product_id']; ?>'); var qty = qty_el.value; if( !isNaN( qty ) &amp;&amp; qty > 0 ) if(qty_el.value*1-qty_st>0)qty_el.value=qty_el.value*1-qty_st;return false;" />
		</div>
		<input type="button" value="<?php echo $button_cart; ?>" onclick="addQtyToCart('<?php echo $product['product_id']; ?>', this);" class="button_q" />
      </div>
      <?php } ?>
      <?
      	//dymm
      	if (isset($this->session->data['compare'])){
      	if (in_array($product['product_id'], $this->session->data['compare']))
      		$show_comp = false;
      		else
			$show_comp = true;
      	}else{
      	    $show_comp = true;
      	}
      	if (isset($this->session->data['wishlist'])){
		if (in_array($product['product_id'], $this->session->data['wishlist']))
      			$show_wish = false;
      		else
			$show_wish = true;
	}else{
	    $show_wish = true;
	}
	
      ?>
      <div class="wishlist" id="wishlist<?php echo $product['product_id']; ?>">
      	<input onclick="addToWishList('<?php echo $product['product_id']; ?>');" name="wishlist" type="checkbox" value="" <?=((!$show_wish)?"checked":"")?>/>
      	<a class="wish" <?=(($show_wish)?"":"style='display:none'")?> onclick="addToWishList('<?php echo $product['product_id']; ?>');">
      		<?php echo $button_wishlist; ?>
      	</a>
      	<a class="textRed gowish" <?=((!$show_wish)?"":"style='display:none'")?> href="index.php?route=account/wishlist">
      		Перейти в избранные
      	</a>
      </div>
      <div class="compare" id="compare<?php echo $product['product_id']; ?>">
      	<input onclick="addToCompare('<?php echo $product['product_id']; ?>');" name="compare" type="checkbox" value="" <?=((!$show_comp)?"checked":"")?>/>
      	<a class="comp" <?=(($show_comp)?"":"style='display:none'")?> onclick="addToCompare('<?php echo $product['product_id']; ?>');">
      		<?php echo $button_compare; ?>
      	</a>
      	<a class="textRed gocomp" onclick="compare()" <?=((!$show_comp)?"":"style='display:none'")?> >
      		Перейти к сравнению
      	</a>

      </div>
    </div>
    <?php } ?>
  </div>
  <div class="pagination"><?php echo $pagination; ?></div>
  <div class="product-filter">

        <div class="price-download">
    	<a href="index.php?route=tool/price/download">Скачать прайс</a>
    </div>
    <div style="float: right">

    <div class="limit"><b><?php echo $text_limit; ?></b>


      <a href="<?php echo $hreflimit15; ?>">15</a>
       <a href="<?php echo $hreflimit30; ?>">30</a>
        <a href="<?php echo $hreflimit100; ?>">100</a>


    </div>
    <div class="display"><b><?php echo $text_display; ?></b> <?php echo $text_list; ?>  <a onclick="display('grid');"><?php echo $text_grid; ?></a></div>

    <div class="sort"><b><?php echo $text_sort; ?></b>

    <!--sort-->

     <?php if ($order=='ASC') { ?>
         <a href="<?php echo $href2; ?>">по цене</a>

        <?php } ?>
         <?php if ($order=='DESC') { ?>
         <a href="<?php echo $href; ?>">по цене</a>

        <?php } ?>




     <?php if ($order=='ASC') { ?>
         <a href="<?php echo $hrefna2; ?>">по наименованию</a>

        <?php } ?>
         <?php if ($order=='DESC') { ?>
         <a href="<?php echo $hrefna; ?>">по наименованию</a>

        <?php } ?>


         <?php if ($order=='ASC') { ?>
         <a href="<?php echo $hrefrating2; ?>">по популярности</a>

        <?php } ?>
         <?php if ($order=='DESC') { ?>
         <a href="<?php echo $hrefrating; ?>">по популярности</a>

        <?php } ?>




  </div>
    <!--sort-->




    </div>
  </div>

  <?php } ?>


<div id="bottom_info">
<?php if ($thumb || $description) { ?>
<div class="category-info">
    <?php if ($description) { ?>
    <?php echo $description; ?>
    <?php } ?>
</div>
<?php } ?>


<!-- Здесь проходимся циклом по массиву имен и ссылок производителей -->
<?php if (!empty($manufacturers)) : ?>
<div>
    <ul class="manufacturers">
        <?php foreach ($manufacturers as $manufacturer) : ?>
        <li>
            <?php if ($manufacturer['manufacturer_id'] == $manufacturer_id) : ?>
            <a href="<?= $manufacturer['href']; ?>" class="active"><?= $manufacturer['name']; ?></a>
            <?php else : ?>
            <a href="<?= $manufacturer['href']; ?>"><?= $manufacturer['name']; ?></a>
            <?php endif; ?>
        </li>
        <?php endforeach; ?>
        <li>
            <?php if ($manufacturer_id == 'null') : ?>
            <a href="<?= $manufacturer['hrefOther']; ?>" class="active">Другие</a>
            <?php else : ?>
            <a href="<?= $manufacturer['hrefOther']; ?>">Другие</a>
            <?php endif; ?>
        </li>
        <li>
            <?php if (!$manufacturer_id) : ?>
            <a href="<?= $manufacturer['hrefall']; ?>" class="active" ><?= $text_all; ?></a>
            <?php else : ?>
            <a href="<?= $manufacturer['hrefall']; ?>"><?= $text_all; ?></a>
            <?php endif; ?>
        </li>
    </ul>
</div>
<?php endif; ?>
<!-- Конец производителей-->

</div><!-- end bottom_info-->













  <?php if (!$categories && !$products) { ?>
  <div class="content"><?php echo $text_empty; ?></div>
  <div class="buttons">
    <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
  </div>
  <?php } ?>
  <?php echo $content_bottom; ?></div></div>
<script type="text/javascript"><!--



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



function display(view) {


	if (view == 'list') {
		$('.product-grid').attr('class', 'product-list');

		$('.product-list > div').each(function(index, element) {

			html = '<div class="up">';
			html += '<div class="left">';

			var image = $(element).find('.image').html();

			if (image != null) {
				html += '<div class="image">' + image + '</div>';
			}

			html += '</div>';

			html += '<div class="right">';
			html += '  <div class="name">' + $(element).find('.name').html() + '</div>';



			html += '<div class="manufacturer">' + $(element).find('.manufacturer').html() + '</div>';
			html += '<div class="stock">' + $(element).find('.stock').html() + '</div>';
			html += '  <div class="description">' + $(element).find('.description').html() + '</div>';





            var price = $(element).find('.price').html();

            if (price != null) {
                html += '<div class="price">' + price  + '</div>';
            }

            var rating = $(element).find('.rating').html();

            if (rating != null) {
                html += '<div class="rating">' + rating + '</div>';
            }


            html += '<div class="pl_bottom_block">';

            html += '<div class="pl_bottom_block_lc">';

            html += '  <div class="wishlist" id="'+$(element).find('.wishlist').attr('id')+'">' + $(element).find('.wishlist').html() + '</div>';
            html += '  <div class="compare" id="'+$(element).find('.compare').attr('id')+'">' + $(element).find('.compare').html() + '</div>';


            html += '</div>';


            html += '<div class="pl_bottom_block_rc">';

            var product_colors = $(element).find('.product_colors').html();

            if (product_colors != null) {
                html += '<div class="product_colors">' + product_colors  + '</div>';
            }

            html += '</div>';





			html += '</div></div></div>';

				html += '<div class="dawn">';
				html += '<div class="model">' + $(element).find('.model').html() + '</div>';
			if (price != null) {
				html += '  <div class="cart">' + $(element).find('.cart').html() + '</div> <div style="float:right;color: #313131;min-height: 11px;padding: 0px 20px 20px;line-height: 32px;font-weight: bold;">'+$(element).find('.multiplicity').html()+'</div>';
			}
			html += '</div>';
			html = html.replace("null", "");


			$(element).html(html);
		});

		$('.display').html('<b class="display_text"><?php echo $text_display; ?></b> <div class="list active"><?php echo $text_list; ?></div> <a onclick="display(\'grid\');" class="setka" ><?php echo $text_grid; ?></a>');

		$.cookie('display', 'list');
	} else {
		$('.product-list').attr('class', 'product-grid');

		$('.product-grid > div').each(function(index, element) {
			html = '';

			var image = $(element).find('.image').html();

			html += '<div class="name">' + $(element).find('.name').html() + '</div>';

            html += '<div class="image_colors_container">';

			if (image != null) {
				html += '<div class="image">' + image + '</div>';
			}

            var product_colors = $(element).find('.product_colors').html();

            if (product_colors != null) {
                html += '<div class="product_colors">' + product_colors  + '</div>';
            }

            html += '</div>';



			html += '<div class="model">' + $(element).find('.model').html() + '</div>';
			html += '<div class="manufacturer">' + $(element).find('.manufacturer').html() + '</div>';
			html += '<div class="stock">' + $(element).find('.stock').html() + '</div>';
			html += '<div class="description">' + $(element).find('.description').html() + '</div>';



			var price = $(element).find('.price').html();

			if (price != null) {
				html += '<div class="price">' + price  + '</div>';
			}

			var rating = $(element).find('.rating').html();

			if (rating != null) {
				html += '<div class="rating">' + rating + '</div>';
			}
			if (price != null) {
				html += '<div class="cart">' + $(element).find('.cart').html() + '</div>';
			}
			html += '<div class="wishlist" id="'+$(element).find('.wishlist').attr('id')+'">' + $(element).find('.wishlist').html() + '</div>';
			html += '<div class="compare" id="'+$(element).find('.compare').attr('id')+'">' + $(element).find('.compare').html() + '</div>';

			
			html = html.replace('null', '');			

			$(element).html(html);
			    
		});

		$('.display').html('<b class="display_text"><?php echo $text_display; ?></b> <a onclick="display(\'list\');" class="list" ><?php echo $text_list; ?></a> <div class="setka active"> <?php echo $text_grid; ?></div>');

		$.cookie('display', 'grid');
	}
}

view = $.cookie('display');

if (view) {
	display(view);
} else {
	display('list');
}


    function compare(){
        var compareLink = "index.php?route=product/compare";
        var compreCountLink = "index.php?route=product/compare/count";
        var width = 265;
        $.post(compreCountLink, function(count){
            //alert("Data Loaded: " + data);
            Shadowbox.open({
                content:    compareLink,
                type:        "iframe",
                player:      "iframe",
                width:      width + (180*count),
                options:   {
                    loadingImage:"loading.gif",
                    handleUnsupported:  'link'
                }
            });
        });
    };
//--></script>
<?php echo $footer; ?>