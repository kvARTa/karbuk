<?php if (isset($_SERVER['HTTP_USER_AGENT']) && !strpos($_SERVER['HTTP_USER_AGENT'], 'MSIE 6')) echo '<?xml version="1.0" encoding="UTF-8"?>'. "\n"; ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" xml:lang="<?php echo $lang; ?>">
<head>
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<?php if ($icon) { ?>
<link href="<?php echo $icon; ?>" rel="icon" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/stylesheet.css" />
<?php foreach ($styles as $style) { ?>
<link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<script type="text/javascript" src="catalog/view/javascript/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css" />
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/external/jquery.cookie.js"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/colorbox/jquery.colorbox.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/colorbox/colorbox.css" media="screen" />
<script type="text/javascript" src="catalog/view/javascript/jquery/tabs.js"></script>
<script type="text/javascript" src="catalog/view/javascript/common.js"></script>

<script type="text/javascript" src="catalog/view/javascript/jquery/jquery.placeholder.js"></script>


<link rel="stylesheet" type="text/css" href="shadowbox/shadowbox.css">
<script type="text/javascript" src="shadowbox/shadowbox.js"></script>
    <!-- vova 55 -->






<script type="text/javascript" src="catalog/view/javascript/jquery/jquery.tinycarousel.min.js"></script>
  <script type="text/javascript">
    $(document).ready(function(){
      $('#slider1').tinycarousel(); 
    });
    
    jQuery('input[placeholder], textarea[placeholder]').placeholder();
    
  </script> 



<?php foreach ($scripts as $script) { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>
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
<?php echo $google_analytics; ?>




<script type="text/javascript" src="catalog/view/javascript/jquery.hoverdelay.js"></script>







<script type="text/javascript">
//    function focusItem(status) {
//        var categoryObj = window.document.getElementById('mactive');
//        if (status == 1) {
//            categoryObj.style.removeProperty('background');
//            categoryObj.style.color = '#fff';
//        } else {
//            categoryObj.style.background = '#fff';
//            categoryObj.style.color = '#cd181f';
//        }
//    }
    $(document).ready(function () {
        $('#menu ul li').hover(function (e) {
            $('div', this).css("display", "table");
			
			var contentH = $('#content').height()+25;
			var menuH = $('div', this).height();
			if (menuH > contentH){
				$('#content').css('height',menuH);
			}
			
        }, function () {
            $('div', this).css("display", "none");
			$('#content').css('height','');
        }, 500);
    })
</script>

<script type="text/javascript" src="catalog/view/javascript/firstwordselect.js"></script>

<script>

$(document).ready(function() 
{ 
    $('.product-grid .model, .product-grid .manufacturer, .product-grid .stock').each(function() { 
        var h = $(this).html(); 
        var index = h.indexOf(' '); 
        if(index == -1) { 
            index = h.length; 
        } 
        $(this).html('<span class="firstWord">' + h.substring(0, index) + '</span>' + h.substring(index, h.length)); 
    }); 
});

</script>

<!--<script type="text/javascript">
   $(document).ready(function(){
   $('.compare input').click(function(){
    
    $("a.to_compare_page").css("font-weight","bold");
                   
                   
  });
});
</script>-->

  

<!--<script type="text/javascript">
 $(document).ready(function(){
              
    if($(".compare input").prop("checked")){
      $("a.to_compare_page").css("font-weight","bold");
      
    } else {
      $("a.to_compare_page").css("font-weight","normal");   
      
    }
})    
</script>-->
<!--<script type="text/javascript">
 $(document).ready(function(){
 var checked_count= $('.compare :checkbox:checked').length;
 alert (checked_count);


})    
</script>-->

<script type="text/javascript" src="catalog/view/javascript/jquery.animate-shadow-min.js"></script>


    <script type="text/javascript">
        Shadowbox.init({
            handleOversize:     "drag",
            displayNav:         true,
            handleUnsupported:  "remove",
            autoplayMovies:     false
        });
    </script>

    <!-- BEGIN JIVOSITE CODE {literal} -->
    <script type='text/javascript'>
        (function(){ var widget_id = '146153';
            var s = document.createElement('script'); s.type = 'text/javascript'; s.async = true; s.src = '//code.jivosite.com/script/widget/'+widget_id; var ss = document.getElementsByTagName('script')[0]; ss.parentNode.insertBefore(s, ss);})();</script>
    <!-- {/literal} END JIVOSITE CODE -->

</head>
<body>

<div id="container_up" style="border-bottom:1px ridge #FFF;">
 <div id="welcome">
    <?php if (!$logged) { ?>
    <?php echo $text_welcome; ?>
    <?php } else { ?>
    <?php echo $text_logged; ?>
    <?php } ?>
  </div>
  </div>
<div id="container" style="padding-left: 5px; padding-right: 5px; border-right:1px ridge #FFF; border-left:1px ridge #FFF;">
<div id="header" >

  <div id="header_up">
    <div id="header_up_left">
  <?php if ($this->customer->isLogged()) {
  ?>
  <div style="position: absolute; top: 127px; ">
  &nbsp;&nbsp;&nbsp;&nbsp;
  <a href="index.php?route=account/wishlist">
  Избранные товары</a>
&nbsp;&nbsp;&nbsp;
  <a class="to_compare_page" href="index.php?route=product/compare" rel="shadowbox; width=1024">
  Товары для сравнения</a>
&nbsp;&nbsp;&nbsp;
<a href="index.php?route=account/account">Личный кабинет</a>
    </div>
  <?php
  }
  ?>





  <?php if ($logo) { ?>
  <div id="logo"><a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a></div>
  <?php } ?>


  </div>
  <div id="header_up_center">
  <div id="header_up_center_tel" style="position: relative; top: -20px; left:-30px; font-weight: bolder;">
<span>(495)</span>649-10-89&nbsp;&nbsp;<span>(495)</span>645-23-29
</div>
  </div>
  
  
  <div id="header_up_right">
  <?php echo $cart; ?>
  
  
  
  
  
  </div>
  
  
  </div>
  
   <!--header_middle-->
  <div id="header_middle">
  <div id="search">


   
    <?php if ($filter_name) { ?>
    <input type="text" name="filter_name" value="<?php echo $filter_name;?>"/>
    <?php } else { ?>
    <input type="text" name="filter_name" value="<?php echo $text_search; ?>" onfocus="this.value = '';" onkeydown="this.style.color = '#000000';" />
    <?php } ?>
     <div class="button-search" title=" Искать " onclick="this.style.background-image='/catalog/view/theme/default/image/button-search2.png'"></div>
  </div>
  
  </div>
  <!--!header_middle-->
  
  <!--header_dawn-->
   <div id="header_dawn">
   
<?php if ($categories) { ?>
	<div id="menu">
	  <ul>
		<?php foreach ($categories as $category) { ?>
			<li <?php if ($category['active']) { ?> style="width: 139px;"  <?php } else { ?>style="width: 127px; padding-left: 11px;" <?php } ?>>
			<!--li-->
			<?php if ($category['active']) { ?>
				  <a href="<?php echo $category['href']; ?>" class="active first" <?php if ($category['active']) { ?> style="width: 147px; "  <?php } ?>><?php echo $category['name']; ?></a>
			<?php } else { ?>
				  <a href="<?php echo $category['href']; ?>" class="first"><?php echo $category['name']; ?></a>
			<?php } ?>

			<?php if ($category['children']) { ?>
				<div>
				
				<?php $r=1; $td=1; $col = 1; $catInCol = 1;?>
				<table style="width: 970px;">
					<tr>
						<td class="child1" style = "border-left: 0;">
								<?php $catCount = count($category['children']); 
									$maxCatInCol = ceil($catCount/3);
									foreach($category['children'] as $child) {
										$children2 = $this->model_catalog_category->getCategories($child['category_id']);
										?>
										<a href="<?php echo $child['href']; ?>" style="color: #000; font-weight: bolder; <?php echo  $catInCol == 1 ? '' : 'padding-top:10px;' ?>"><?php echo $child['name']; ?></a>	
											<? if ($children2){?>
												<ul>
												<?php
													foreach ($children2 as $child2){
														$href  = $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'].'_'.$child2['category_id']);?>
														<li class="child2">
															<a href="<?php echo $href?>"><?php echo $child2['name']?></a>
														</li>
													<? } ?>
												</ul>		
											<?}
										if ($catInCol < $maxCatInCol){
											$catInCol++;
										}else{ 
											echo '</td>';
											echo $col == 3 ? '' : '<td class="child1">';
											$col ++;
											$catInCol = 1;
										}
										
									}
								?>
					</tr>
				</table>
				</div>
				 
		  <?php } ?>
		</li>
		<?php } ?>
	  </ul>
	</div>
<?php } ?>
   
   
   
   
  </div>
  
  <!--!header_dawn-->
  
  
 



</div>


<div id="notification" style="display:none;"></div>
