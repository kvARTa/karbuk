<?php if ($modules) { ?>
<div id="column-right">
  <?php foreach ($modules as $module) { ?>
  <?php 
    if (!eregi('Личный кабинет', $module)){
	    echo $module; 
    }	
?>
  <?php } ?>
</div>
<?php } ?>
