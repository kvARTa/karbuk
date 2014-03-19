<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content">
<div class="box-heading"><?php echo $heading_title; ?>
</div>
<div class="box-content"><?php echo $content_top; ?>
  <div class="breadcrumb">
   <?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
        <?php echo $breadcrumb['separator']; ?><?php if($i+1<count($breadcrumbs)) { ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a> <?php } else { ?><?php echo $breadcrumb['text']; ?><?php } ?>
        <?php } ?>
  </div>
  <h1><?php echo $heading_title; ?></h1>
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
    <h2><?php echo $text_location; ?></h2>
    <div class="contact-info">
      <div class="content"><div class="left"><b><?php echo $text_address; ?></b><br />
        <?php echo $store; ?><br />
        <?php echo $address; ?></div>
      <div class="right">
        <?php if ($telephone) { ?>
        <b><?php echo $text_telephone; ?></b><br />
        <?php echo $telephone; ?><br />
        <br />
        <?php } ?>
        <?php if ($fax) { ?>
        <b><?php echo $text_fax; ?></b><br />
        <?php echo $fax; ?>
        <?php } ?>
      </div>
    </div>
    </div>
    
    
    
  </form>
  <div id="yandex_karta">
  
  
  <script type="text/javascript" charset="utf-8" src="//api-maps.yandex.ru/services/constructor/1.0/js/?sid=y7F1KAfR80MfZOHWB4TdKjHiIhuEcJRq&width=746&height=450"></script>
  
  
  </div><!--yandex_karta-->
  
  
  <?php echo $content_bottom; ?></div></div>
<?php echo $footer; ?>