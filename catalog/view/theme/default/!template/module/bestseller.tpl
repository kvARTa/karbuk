<div class="box">
  <div class="box-heading textRed"><?php echo $heading_title; ?></div>
  <div class="box-content bestdeller">
    
    
    <div id="carousel33">
  <ul class="jcarousel-skin-opencart2">
  
    
      <?php $k=0; foreach ($products as $product) { $k=$k+1; ?>
      <li <? if ($k=='4') echo 'class="last_r"'; ?> >
        <?php if ($product['thumb']) { ?>
        <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
        <?php } ?>
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
              
      </li>
      <?php } ?>
    </ul>
    
     
  </div>
</div></div>
<script type="text/javascript"><!--
$('#carousel33 ul').jcarousel({
	vertical: false,
	visible: 4,
	scroll: 1
});
//--></script>