<?php //var_dump($manufactureres)?>
<div class="manufacturer_module">
<div class="box">
  <div class="box-heading"><?php echo $heading_title; ?></div>
  <div class="box-content">
  <div class="box-product">
        <?php foreach ($manufactureres as $manufacturer) { ?>
<div>
<div class="image"><a href="<?php echo $manufacturer['href']; ?>"><img src="<?php echo $manufacturer['thumb']; ?>" title="<?php echo $manufacturer['name']; ?>" alt="<?php echo $manufacturer['name']; ?>" /></a></div>
      <div class="name"><a href="<?php echo $manufacturer['href']; ?>"><?php echo $manufacturer['name']; ?></a></div>
</div>
        <?php } ?>


    </div>
  </div>
</div>
</div>