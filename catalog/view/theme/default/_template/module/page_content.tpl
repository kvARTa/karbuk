<? if (!empty($heading_title)) {?>

<div class="box">

 <div class="box-heading"><?php echo $heading_title; ?></div>
<div class="box-content">
<?php echo $message; ?>
 </div> </div>
 
 <? }
 else 
 {
  ?>
  <div class="nobox">
  <?php echo $message; ?>
  </div>
  <? } ?>