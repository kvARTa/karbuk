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
  <div class="sitemap-info">
    <div class="left">
      <ul>
        <?php 
        foreach ($categories as $category_1) { 
          if(isset($category_1['switch_to_left'])){
          ?>
            </ul>
          </div>
          <div class="right">
            <ul>
          <?
          }
        ?>
        <li>
          <b>
              <a href="<?php echo $category_1['href']; ?>"><?php echo $category_1['name']; ?></a>
          </b>&nbsp;(<?=$category_1['total']?>)    
          <?php if ($category_1['children']) { ?>
          <ul>
            <?php foreach ($category_1['children'] as $category_2) { ?>
            <li><a href="<?php echo $category_2['href']; ?>"><?php echo $category_2['name']; ?></a>&nbsp;(<?=$category_2['total']?>)             
              <?php if ($category_2['children'] && $show_third_level) { ?>
              <ul>
                <?php foreach ($category_2['children'] as $category_3) { ?>
                <li><a href="<?php echo $category_3['href']; ?>"><?php echo $category_3['name']; ?></a>&nbsp;(<?=$category_3['total']?>)</li>
                <?php } ?>
              </ul>
              <?php } ?>
            </li>
            <?php } ?>
          </ul>
          <?php } ?>
        </li>
        <?php } ?>
      </ul>
    </div>   
  </div>
  <?php echo $content_bottom; ?></div></div>
<?php echo $footer; ?>