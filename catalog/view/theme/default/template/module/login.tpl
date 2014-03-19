<?php if (!$this->customer->isLogged()) { ?>
<div class="box">
  <div class="box-heading"><?php echo $heading_title; ?></div>
  <div class="box-content">
	
	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="module_login"> 
	
    <span style="text-align: left; "><input type="text" name="login" class="login" placeholder="Логин" class="text11"/></span>
    
   
    <input type="password" name="password" class="login" placeholder="Пароль" class="text11" />
        
 
    <div style="float:left; text-align: right; margin:5px 0 0 0;"><a onclick="$('#module_login').submit();" class="button_login"><span><?php echo $button_login; ?></span></a></div>
    <br style="clear:both;"/>
   
   
   <div class="login_info"><a href="index.php?route=account/login" class="textBlue">Зарегистрироваться</a></div>
    
     
    </form>
  </div>
 </div>
  <script type="text/javascript"><!--
  $('#module_login input').keydown(function(e) {
	  if (e.keyCode == 13) {
		  $('#module_login').submit();
	  }
  });
  //--></script>
<?php } ?>
