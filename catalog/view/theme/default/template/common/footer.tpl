
    
    
    
    
    <div id="footer">
  <?php if ($informations) { ?>
  
  <div id="footer_columns">
  
  <div class="column" style="padding-left: 5px; padding-right: 5px;">
    <h3><?php echo $text_information; ?></h3>
    <ul>
    
      <li><a href="index.php">Главная</a></li>
      <li><a href="index.php?route=information/information&information_id=4">О нас</a></li>
      <li><a href="index.php?route=information/information&information_id=5">Для связи</a></li>
      <li><a href="index.php?route=information/information&information_id=8">Вакансии</a></li>
      <li><a href="index.php?route=information/information&information_id=9">Реквизиты компании</a></li>

    </ul>
  </div>
  <?php } ?>
  <div class="column">
    <h3><?php echo $text_service; ?></h3>
    <ul>
      <li><a href="index.php?route=information/information&information_id=7">Помощь</a></li>
      <li><a href="index.php?route=information/feedback">Отзывы</a></li>
      <li><a href="index.php?route=information/information&information_id=10">Скачать каталог</a></li>
      <li><a href="index.php?route=tool/price/download">Скачать прайс-лист</a></li>
      <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
    </ul>
  </div>
  
  <div class="column">
    <h3><?php echo $text_catalog; ?></h3>
    <ul>    
      <li><a href="index.php?route=information/catalog">Каталог товаров</a></li>
      <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
      <li><a href="index.php?route=product/latest">Новинки</a></li>
      <li><a href="index.php?route=product/special">Акции</a></li>
      <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
   </ul>
  </div>
  
  </div><!-- end footer_columns -->
  
  
  <div class="column_power">
 
  <div id="powered"><?php echo $powered; ?>
  <br />Создано в  <a href="http://www.web-systems.com.ua">web-systems</a>
  </div>
    
  </div>
</div>
</div>
</body></html>