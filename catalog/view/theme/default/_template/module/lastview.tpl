<?php 
if (isset($products) && count($products)) { ?>
<div class="box">
  <div class="box-heading"><a href="#" style="text-decoration:none; color:#404040">Вы смотрели</a></div>
  <div class="box-content lastviewed">
    <div class="box-product2">
    <ul id="mycarousel" class="jcarousel jcarousel-skin-tango">
        <?php 
        $j=0;
      	for ($i=count($products); $i>=0; $i--) {
      
      		if (isset($products[$i]['image'])) {
                ?>  
                 <li>
                <div>
                <div class="lastview_left">
                
                <?php if ($products[$i]['image']) { ?>
                <div class="image"><a href="<?php echo $products[$i]['href']; ?>"><img src="<?php echo $products[$i]['image']; ?>" alt="<?php echo $products[$i]['name']; ?>" /></a></div>
                <?php } ?>
                </div>
                <div class="lastview_right">
                <div class="name"><a href="<?php echo $products[$i]['href']; ?>"><?php echo $products[$i]['name']; ?></a></div>
                <?php if ($products[$i]['price']) { ?>
                <div class="price">
                  <?php if (!$products[$i]['special']) { ?>
                  <?php echo $products[$i]['price']; ?>
                  <?php } else { ?>
                  <span class="price-old"><?php echo $products[$i]['price']; ?></span> <span class="price-new"><?php echo $products[$i]['special']; ?></span>
                  <?php } ?>
                </div>
                <?php } ?>
                    </div>
                
               
              </div></li>
          <?php } ?>
          <?php 
            if ($j == $limit) {
              	break;
            }
            $j++;          
          ?>
          
      <?php } ?>
      </ul>
    </div>
  </div>
</div>
<?php } ?>


<script type="text/javascript">

jQuery(document).ready(function() {
  jQuery('#mycarousel').jcarousel({
  vertical: true,
  scroll: 3
  });
});

</script>