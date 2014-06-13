<?php foreach ($blogies as $blog) {?>
<div class="box blog">
<div class="moduletable_blog">
  <div class="box-heading-blog"><?php echo $blog['name']; ?></div>
  <div class="box-content-blog">
    <div class="box-category">
      <ul>
        <?php foreach ($blog["records"] as $record) { ?>
        <li>
<img src="<?=$record['thumb'] ? $record['thumb'] : "http://karbuk.ru/test/image/cache/no_image-40x40.jpg"?>" style="float: left;width: 21%;margin-right:10px;">
    <?php echo $record['date_added'] ;?>
          <a href="<?php echo $record['href']; ?>"><b><?php echo $record['name']; ?></b><br/><?php $d = date_parse($record['date_added']); echo $d["day"].".".$d["month"].".".substr($d["year"],2); ?><span style="color:#999999;"><?php echo $record['description']; ?></span></a>
         
          <?php if ($blog['children']) { ?>
          <ul>
            <?php foreach ($blog['children'] as $child) { ?>
            <li>
              <?php if ($child['blog_id'] == $child_id) { ?>
              <a href="<?php echo $child['href']; ?>" class="active"> - <?php echo $child['name']; ?></a>
              <?php } else { ?>
              <a href="<?php echo $child['href']; ?>"> - <?php echo $child['name']; ?></a>
              <?php } ?>
            </li>
            <?php } ?>
          </ul>
          <?php } ?>
		  <br style="clear:both;">
        </li>
        <?php } ?>  
      </ul>
    </div>
  </div>
  
  </div><!-- end moduletable_blog--> 
</div>
<?php } ?> 