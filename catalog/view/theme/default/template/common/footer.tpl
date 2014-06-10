
    
    
    
    
    <div id="footer">
  <?php if ($informations) { ?>
  
  <div id="footer_columns">
  
  <div class="column" style="padding-left: 5px; padding-right: 5px;">
    <h3><?php echo $text_information; ?></h3>
    <ul>
    
      <li><a href="index.php">Главная</a></li>
        <li><a href="<?php echo $this->url->link('information/information&information_id=4');?>">О нас</a></li>

      <li><a href="<?php echo $this->url->link('information/information&information_id=5');?>">Для связи</a></li>
      <li><a href="<?php echo $this->url->link('information/information&information_id=8');?>">Вакансии</a></li>
      <li><a href="<?php echo $this->url->link('information/information&information_id=9');?>">Реквизиты компании</a></li>

    </ul>
  </div>
  <?php } ?>
  <div class="column">
    <h3><?php echo $text_service; ?></h3>
    <ul>
      <li><a href="<?php echo $this->url->link('information/information&information_id=7');?>">Помощь</a></li>
      <li><a href="<?php echo $this->url->link('information/feedback');?>">Отзывы</a></li>
      <li><a href="<?php echo $this->url->link('information/information&information_id=10');?>">Скачать каталог</a></li>
      <li><a href="<?php echo $this->url->link('tool/price/download');?>">Скачать прайс-лист</a></li>
      <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
    </ul>
  </div>
  
  <div class="column">
    <h3><?php echo $text_catalog; ?></h3>
    <ul>    
      <li><a href="<?php echo $this->url->link('information/catalog');?>">Каталог товаров</a></li>
      <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
      <li><a href="<?php echo $this->url->link('product/latest');?>">Новинки</a></li>
      <li><a href="<?php echo $this->url->link('product/special');?>">Акции</a></li>
      <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
   </ul>
  </div>
  
  </div><!-- end footer_columns -->
  
  
  <div class="column_power">
 
  <div id="powered"><?php echo $powered; ?>
  <br />Создано в  <a href="http://www.web-systems.com.ua">web-systems</a>
  </div>
    
  </div>
  
  
  <div id="footer_counter">

      <!-- Yandex.Metrika counter -->
      <script type="text/javascript">
          (function (d, w, c) {
          (w[c] = w[c] || []).push(function() {
          try {
          w.yaCounter24520133 = new Ya.Metrika({id:24520133,
          clickmap:true,
          trackLinks:true,
          accurateTrackBounce:true});
          } catch(e) { }
          });

          var n = d.getElementsByTagName("script")[0],
          s = d.createElement("script"),
          f = function () { n.parentNode.insertBefore(s, n); };
          s.type = "text/javascript";
          s.async = true;
          s.src = (d.location.protocol == "https:" ? "https:" : "http:") + "//mc.yandex.ru/metrika/watch.js";

          if (w.opera == "[object Opera]") {
          d.addEventListener("DOMContentLoaded", f, false);
          } else { f(); }
          })(document, window, "yandex_metrika_callbacks");
      </script>
      <noscript><div></div></noscript>
      <!-- /Yandex.Metrika counter -->

  
  </div><!-- end footer_counter -->
  
  
</div>
</div>
</body></html>