<?php if ($modules) { ?>
<div id="column-left">

  <?php
  if($this->customer->isLogged()){
  ?>

 <div class="box">

  <div class="box-heading">Личный кабинет</div>

  <div class="box-content">
<div class="left_link">

    

            <a href="index.php?route=account/account">Моя информация</a>
<br>
            <a href="index.php?route=account/edit">Изменить основные данные</a>
<br>
      <a href="index.php?route=account/password">Пароль</a>

            <br><a href="index.php?route=account/wishlist">Закладки</a>
<br>
      <a href="index.php?route=account/order">История заказов</a>
<!-- <br>
      <a href="index.php?route=account/return">Возвраты</a>
-->      
<br>
      <a href="index.php?route=account/newsletter">E-Mail рассылка</a>
<br>
            <a href="index.php?route=account/logout">Выход</a>

          </div>

  </div>




</div>


  <?php
  }
  ?>


    <div class="box">
        <div class="box-heading">
            <p>Онлайн консультант</p>
        </div>
        <div class="box-content">
            Код счетчика
        </div>
    </div>



    <?php 
    ini_set('error_reporting', 0);
     ?>
  <?php foreach ($modules as $module) { ?>
    <?php if (eregi('компании', $module)
    && isset($_GET['filter_name']) && isset($_GET['route']) && $_GET['route']='product/search' && $_GET['filter_name']!=''){
	echo "<div class=\"box\">



 <div class=\"box-heading\"><p>

    Фильтр:</p>

</div>

<div class=\"box-content\">
<div class=\"left_link\">
<a href='/index.php?route=product/search'>Сбросить</a>

 </div> </div></div>
";

    } ?>
<?php $module = str_replace('http://karbuk.ru/test', '', $module);?>
<?php $module = str_replace('http://index.php', '/index.php', $module);?>

<?php 
//Vremennaya bredyatina
$module = str_replace('/index.php?route=account/login', '/test//index.php?route=account/login', $module);
if (eregi('blog_id=64', $module) or eregi('information/contact', $module)){
    $module = str_replace('/index.php', 'index.php', $module);
}

echo $module; ?>
  <?php } ?>
</div>
<?php } ?> 
