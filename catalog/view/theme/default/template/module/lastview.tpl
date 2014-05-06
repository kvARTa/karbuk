<?php if($this->request->get["route"] == "checkout/simplecheckout"){ ?>
<div class="box">
  <div class="box-heading textRed"><a href="#">Вы смотрели</a></div>
  <div class="box-content bestdeller">
    
    
    <div id="carousel33">
  <ul class="jcarousel-skin-opencart2">
      <?php $k=0; foreach ($products as $product) { $k=$k+1; ?>
      <li <? if ($k=='4') echo 'class="last_r"'; ?> >
        <?php if ($product['thumb']) { ?>
        <div class="image"><a href="<?php $product['href'] = str_replace($_SERVER['HTTP_HOST'], "", $product['href']);
            	$product['href'] = str_replace("http://", "", $product['href']);
                echo $product['href']; ?>"><img style="width:112px;height:85px;" src="<?php 
            	$product['image'] = str_replace($_SERVER['HTTP_HOST'], "", $product['image']);
            	$product['image'] = str_replace("http://", "", $product['image']);
                echo $product['image'];
                 ?>" alt="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
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
	scroll:1,
	animation: 1500,
});
//--></script>
<?php }else{ ?>
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
                <div class="image">
                
                <a href="<?php $products[$i]['href'] = str_replace($_SERVER['HTTP_HOST'], "", $products[$i]['href']);
            	$products[$i]['href'] = str_replace("http://", "", $products[$i]['href']);
                echo $products[$i]['href']; ?>">
                
                <img src="<?php 
            	$products[$i]['image'] = str_replace($_SERVER['HTTP_HOST'], "", $products[$i]['image']);
            	$products[$i]['image'] = str_replace("http://", "", $products[$i]['image']);
                echo $products[$i]['image'];
                 ?>" alt="<?php echo $products[$i]['name']; ?>" /></a></div>
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

<? if ($j<='4') :?>
<style>
#mycarousel{
    overflow: hidden;
    padding: 0px;
    position: relative;
    margin: 0;}


#mycarousel li{
    float: left;
    list-style: none outside none;
    height: 74px;
    width: 155px;
    border-bottom: 1px solid #E5E5E5;
    margin: 10px 0px;}

</style>
<?php endif ;?>

<? if ($j=='5') :?>
<script type="text/javascript">

jQuery(document).ready(function() {
  jQuery('#mycarousel').jcarousel({
  vertical: true,
  scroll: 1,
  animation: 1500,
  });
});

</script>

<?php endif ;?>

<?php } ?>