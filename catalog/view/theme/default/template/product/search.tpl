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

<div class="box-heading">Поиск
</div>
<div class="box-content"><?php echo $content_top; ?>
  
  
  <div class="breadcrumb">
   <?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
        <?php echo $breadcrumb['separator']; ?><?php if($i+1<count($breadcrumbs)) { ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a> <?php } else { ?><?php echo $breadcrumb['text']; ?><?php } ?>
        <?php } ?>
  </div>
  
  
  
<script type="text/javascript">
window.onload= function() {
	    document.getElementById('svernut').onclick = function() {
	        openbox('search_header_block', this);
	        return false;
	    };
	};
	function openbox(id, toggler) {
	    var div = document.getElementById(id);
	    if(div.style.display == 'none') {
	        div.style.display = 'block';
	        toggler.innerHTML = 'Закрыть дополнительные параметры поиска';
	    }
	    else {
	        div.style.display = 'none';
	        toggler.innerHTML = 'Открыть дополнительные параметры поиска';
	    }
	}
</script>  
  
  

<div id="search_header_block_header">
    <a id="svernut">Открыть дополнительные параметры поиска</a>
</div><!-- search_header_block_header -->


<div id="search_header_block" style="display:none;">
  
  
  <h1><?php echo $heading_title; ?></h1>
  <b><?php echo $text_critea; ?></b>
  <div class="content">
    <p><?php echo $entry_search; ?>
      <?php if ($filter_name) { ?>
      <input type="text" name="filter_name" value="<?php echo $filter_name; ?>" />
      <?php } else { ?>
      <input type="text" name="filter_name" value="<?php echo $filter_name; ?>" onclick="this.value = '';" onkeydown="this.style.color = '000000'" style="color: #999;" />
      <?php } ?>
      <select name="filter_category_id">
        <option value="0"><?php echo $text_category; ?></option>
        <?php foreach ($categories as $category_1) { ?>
        <?php if ($category_1['category_id'] == $filter_category_id) { ?>
        <option value="<?php echo $category_1['category_id']; ?>" selected="selected"><?php echo $category_1['name']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $category_1['category_id']; ?>"><?php echo $category_1['name']; ?></option>
        <?php } ?>
        <?php foreach ($category_1['children'] as $category_2) { ?>
        <?php if ($category_2['category_id'] == $filter_category_id) { ?>
        <option value="<?php echo $category_2['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $category_2['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
        <?php } ?>
        <?php foreach ($category_2['children'] as $category_3) { ?>
        <?php if ($category_3['category_id'] == $filter_category_id) { ?>
        <option value="<?php echo $category_3['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $category_3['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
        <?php } ?>
        <?php } ?>
        <?php } ?>
        <?php } ?>
      </select>
         <br>
      <?php if ($filter_sub_category) { ?>
      <input type="checkbox" name="filter_sub_category" value="1" id="sub_category" checked="checked" />
      <?php } else { ?>
      <input type="checkbox" name="filter_sub_category" value="1" id="sub_category" />
      <?php } ?>
   
      <label for="sub_category"><?php echo $text_sub_category; ?></label>
    </p>
    <?php if ($filter_description) { ?>
    <input type="checkbox" name="filter_description" value="1" id="description" checked="checked" />
    <?php } else { ?>
    <input type="checkbox" name="filter_description" value="1" id="description" />
    <?php } ?>
    <label for="description"><?php echo $entry_description; ?></label>
  </div>
  <div class="buttons">
    <div class="right"><input type="button" value="<?php echo $button_search; ?>" id="button-search" class="button" /></div>
  </div>
  
  


</div><!-- end search_header_block-->  
  
  
  
  <h2><?php echo $text_search; ?></h2>
  <?php if ($products) { ?>
    <div class="product-filter">
    
    
    
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
  
  <div class="pagination"><?php echo $pagination; ?></div>
  
  
  
  <!---->
   <div class="product-list">
    <?php $k=0;  $p=0; foreach ($products as $product) {  $k=$k+1; $p=$p+1;?>
    <div <? if ($k==1) { echo 'class="grey"';  } if ($k==2) $k=0; ?>  <? if ($p==3) { echo 'id="thre"';  } if ($p==3) $p=0; ?> >
       <div class="name"><a href="<?php echo $product['href']; /*var_dump($product);*/?>"><?php echo $product['name']; ?></a></div>
      
      <?php if ($product['thumb']) { ?>
      <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
      <?php } ?>
      <div class="model">Код: <?php echo $product['model']; ?></div>
    
      <div class="manufacturer">Производитель <span ><?php echo $product['manufacturer']; ?></span></div>
      <div class="stock"><?php echo $text_stock; ?> <?php echo $product['stock']; ?></div>
       
      <div class="description"><?php echo $product['description']; ?></div>
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
       <?php if($product['product_colors']) { ?>
       <div class="product_colors">
           <ul>
               <?php foreach ($product['product_colors'] as $item) { ?>
               <li>
                   <a <?php echo $item['current'] ? 'current' : '' ; ?> href="<?php echo $item['href']?>" title="<?php echo $item['color_title']?>">
                   <img src="<?php echo $item['color_img']?>"/>
                   </a>
               </li>
               <?php } ?>
           </ul>
       </div>
       <?php } ?>
      <?php } ?>
      <?php if ($product['rating']) { ?>
      <div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
      <?php } ?>
      <div class="cart">
    	
 <input type="text" value="<?php echo $product['multiplicity']; ?>" id="item-<?php echo $product['product_id']; ?>" class="input_q" />

 <div class="input_arrow_q">  
		<input type="button" class="quantity_box_button quantity_box_button_up" onclick="var qty_st = <?php echo $product['multiplicity']; ?>; var qty_el = document.getElementById('item-<?php echo $product['product_id']; ?>'); var qty = qty_el.value; if( !isNaN( qty )) qty_el.value=qty_el.value*1+qty_st;return false;" />
		<input type="button" class="quantity_box_button quantity_box_button_down" onclick="var qty_st = <?php echo $product['multiplicity']; ?>; var qty_el = document.getElementById('item-<?php echo $product['product_id']; ?>'); var qty = qty_el.value; if( !isNaN( qty ) &amp;&amp; qty > 0 ) if(qty_el.value*1-qty_st>0)qty_el.value=qty_el.value*1-qty_st;return false;" />

       </div>
 
 
<input type="button" value="<?php echo $button_cart; ?>" onclick="addQtyToCart('<?php echo $product['product_id']; ?>', this);" class="button_q" />
      </div>
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
        <a class="textRed gocomp" <?=((!$show_comp)?"":"style='display:none'")?> href="index.php?route=product/compare" rel="shadowbox; width=1024">
          Перейти к сравнению
        </a>

      </div>
     </div> 
    <?php } ?>
  </div>
  <div class="pagination"><?php echo $pagination; ?></div>



 <div class="product-filter">
    
    
    
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
    
    
    
    
    </div>   </div>

  <!---->
  
  <?php } else { ?>
  <div class="content"><?php echo $text_empty; ?></div>
  <?php }?></div>
  <?php echo $content_bottom; ?>
<script type="text/javascript"><!--
$('#content input[name=\'filter_name\']').keydown(function(e) {
	if (e.keyCode == 13) {
		$('#button-search').trigger('click');
	}
});

$('#button-search').bind('click', function() {
	url = 'index.php?route=product/search';
	
	var filter_name = $('#content input[name=\'filter_name\']').attr('value');
	
	if (filter_name) {
		url += '&filter_name=' + encodeURIComponent(filter_name);
	}

	var filter_category_id = $('#content select[name=\'filter_category_id\']').attr('value');
	
	if (filter_category_id > 0) {
		url += '&filter_category_id=' + encodeURIComponent(filter_category_id);
	}
	
	var filter_sub_category = $('#content input[name=\'filter_sub_category\']:checked').attr('value');
	
	if (filter_sub_category) {
		url += '&filter_sub_category=true';
	}
		
	var filter_description = $('#content input[name=\'filter_description\']:checked').attr('value');
	
	if (filter_description) {
		url += '&filter_description=true';
	}

	location = url;
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

            var product_colors = $(element).find('.product_colors').html();

            if (product_colors != null) {
                html += '<div class="product_colors">' + product_colors  + '</div>';
            }
			
			var price = $(element).find('.price').html();
			
			if (price != null) {
				html += '<div class="price">' + price  + '</div>';
			}
			
			var rating = $(element).find('.rating').html();
			
			if (rating != null) {
				html += '<div class="rating">' + rating + '</div>';
			}
				
       //dymm
      html += '  <div class="wishlist" id="'+$(element).find('.wishlist').attr('id')+'">' + $(element).find('.wishlist').html() + '</div>';
      html += '  <div class="compare" id="'+$(element).find('.compare').attr('id')+'">' + $(element).find('.compare').html() + '</div>';  
			//html += '  <div class="wishlist">' + $(element).find('.wishlist').html() + '</div>';
			//html += '  <div class="compare">' + $(element).find('.compare').html() + '</div>';
				
				
			html += '</div></div>';
			
				html += '<div class="dawn">';
				html += '<div class="model">' + $(element).find('.model').html() + '</div>';
			html += '  <div class="cart">' + $(element).find('.cart').html() + '</div>';
			
			html += '</div>';	

						
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
			
			if (image != null) {
				html += '<div class="image">' + image + '</div>';
			}
			
			html += '<div class="model">' + $(element).find('.model').html() + '</div>';
			html += '<div class="manufacturer">' + $(element).find('.manufacturer').html() + '</div>';
			html += '<div class="stock">' + $(element).find('.stock').html() + '</div>';
			html += '<div class="description">' + $(element).find('.description').html() + '</div>';

            var product_colors = $(element).find('.product_colors').html();

            if (product_colors != null) {
                html += '<div class="product_colors">' + product_colors  + '</div>';
            }
			
			var price = $(element).find('.price').html();
			
			if (price != null) {
				html += '<div class="price">' + price  + '</div>';
			}
			
			var rating = $(element).find('.rating').html();
			
			if (rating != null) {
				html += '<div class="rating">' + rating + '</div>';
			}
						
			html += '<div class="cart">' + $(element).find('.cart').html() + '</div>';
      //dymm
      html += '  <div class="wishlist" id="'+$(element).find('.wishlist').attr('id')+'">' + $(element).find('.wishlist').html() + '</div>';
      html += '  <div class="compare" id="'+$(element).find('.compare').attr('id')+'">' + $(element).find('.compare').html() + '</div>';
			//html += '<div class="wishlist">' + $(element).find('.wishlist').html() + '</div>';
			//html += '<div class="compare">' + $(element).find('.compare').html() + '</div>';
			
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
//--></script> </div>
<?php echo $footer; ?>