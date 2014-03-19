<?php if (!$ajax) { ?>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/search_advanced.css" />
<div class="box">
 <div class="box-heading2"><?php echo $heading_title; ?></div>
 <div class="box-content2">
  <?php if(!$category_status) { ?>
  <input type="hidden" id="filter_category_id" name="filter_category_id" value="<?php echo $filter_category_id; ?>" />
  <?php } ?>
  <?php if($keyword_status || $category_status) { ?>
  <div class="content">
  
   <?php if($category_status) { ?>
   <select id="filter_category_id" name="filter_category_id">
    <option value="0"><?php echo $text_category; ?></option>
    <?php foreach ($categories as $category_1) { ?>
    <?php if ($category_1['category_id'] == $filter_category_id) { ?>
    <option value="<?php echo $category_1['category_id']; ?>" selected="selected"><?php echo $category_1['name']; ?></option>
    <?php } else { ?>
    <option value="<?php echo $category_1['category_id']; ?>"><?php echo $category_1['name']; ?></option>
    <?php } ?>
    <?php foreach ($category_1['children'] as $category_2) { ?>
    <?php if ($category_2['category_id'] == $filter_category_id) { ?>
    <option value="<?php echo $category_2['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
    <?php } else { ?>
    <option value="<?php echo $category_2['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
    <?php } ?>
    <?php foreach ($category_2['children'] as $category_3) { ?>
    <?php if ($category_3['category_id'] == $filter_category_id) { ?>
    <option value="<?php echo $category_3['category_id']; ?>" selected="selected">
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?>
    </option>
    <?php } else { ?>
    <option value="<?php echo $category_3['category_id']; ?>">
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?>
    </option>
    <?php } ?>
    <?php } ?>
    <?php } ?>
    <?php } ?>
   </select>
   <?php } ?>
   <br /><br />
   
  
  </div>
  <?php } ?>
  <form id="search_attributes_content">
   <?php } ?>
   <?php if ($manufacturers || $attributes) { ?>
   <div class="content">
    <h3><?php echo $text_filter; ?></h3>
    <?php if ($manufacturers) { ?>
    <div class="attr_cont">
     <em onclick="toggle_filter('fm_0')"><?php echo $text_m_title; ?></em>
     <div id="fm_0">
      <?php foreach ($manufacturers as $manufacturer) { ?>
      <?php if ($manufacturer['checked']) { ?>
      <input name="fm[]" type="checkbox" value="<?php echo $manufacturer['id']; ?>" checked="checked" />
      <?php echo $manufacturer['name']; ?><br />
      <?php } else { ?>
      <input name="fm[]" type="checkbox" value="<?php echo $manufacturer['id']; ?>" />
      <?php echo $manufacturer['name']; ?><br />
      <?php } ?>
      <?php } ?>
     </div>
    </div>
    <?php } ?>
    <?php if ($attributes) { ?>
    <?php $i = 0; ?>
    <?php foreach ($attributes as $attribute1) { ?>
    <b><?php echo $attribute1['name']; ?></b>
    <?php foreach ($attribute1['text'] as $attribute2) { ?>
    <?php if ($attribute2['type'] == 'checkbox' || $attribute2['type'] == 'radio') { ?>
    <div class="attr_cont">
     <em onclick="toggle_filter('fa_<?php echo $i; ?>')"><?php echo $attribute2['name']; ?></em>
     <div id="fa_<?php echo $i; ?>">
      <?php foreach ($attribute2['text'] as $attribute3) { ?>
      <?php if ($attribute3['checked']) { ?>
      <input name="fa[<?php echo $attribute2['id']; ?>][]" type="<?php echo $attribute2['type']; ?>" value="<?php echo $attribute3['value']; ?>" checked="checked" /> <?php echo $attribute3['value']; ?><br />
      <?php } else { ?>
      <input name="fa[<?php echo $attribute2['id']; ?>][]" type="<?php echo $attribute2['type']; ?>" value="<?php echo $attribute3['value']; ?>" /> <?php echo $attribute3['value']; ?><br />
      <?php } ?>
      <?php } ?>
     </div>
    </div>
    <?php $i++; ?>
    <?php } else if ($attribute2['type'] == 'slider') { ?>
    <div style="clear:both;"></div>
    <em><?php echo $attribute2['name']; ?></em></br></br>
      <div id="slider_<?php echo $attribute2['id']; ?>" ></div>
   <div class="input_price">
    от <input name="fa[<?php echo $attribute2['id']; ?>][min]" style="text-align:right; border:none;" type="text" class="pr_box" />
    до
    <input name="fa[<?php echo $attribute2['id']; ?>][max]" style="text-align:left; border:none;" type="text" class="pr_box" /> грн</div>
  <br />
	<script type="text/javascript">
	$("#slider_<?php echo $attribute2['id']; ?>").slider({
		range: true,
		min: <?php echo $attribute2['text']['min']; ?>,
		max: <?php echo $attribute2['text']['max']; ?>,
		step: <?php echo $attribute2['text']['step']; ?>,
		values: [<?php echo $attribute2['text']['min_cur']; ?>, <?php echo $attribute2['text']['max_cur']; ?>],
		slide: function( event, ui ) {
			$("input[name='fa[<?php echo $attribute2['id']; ?>][min]']").val(ui.values[0]);
			$("input[name='fa[<?php echo $attribute2['id']; ?>][max]']").val(ui.values[1]);
		}
	});
	$("input[name='fa[<?php echo $attribute2['id']; ?>][min]']").val($("#slider_<?php echo $attribute2['id']; ?>").slider("values", 0));
	$("input[name='fa[<?php echo $attribute2['id']; ?>][max]']").val($("#slider_<?php echo $attribute2['id']; ?>").slider("values", 1));
	</script>
    <?php } ?>
    <?php } ?>
    <div style="clear:both;"></div>
    <?php } ?>
    <?php } ?>
   </div>
   <?php } ?>
 
   

   
   
   <?php if (!$ajax) { ?>
  </form>
  <div class="right" align="right"><a id="button-search" class="button"><span><?php echo $button_search; ?></span></a></div>
 </div>
</div>
<script type="text/javascript">
function toggle_filter(id) {
	$('#search_attributes_content .attr_cont div').css({'z-index':'1000'});
	$('#' + id).css({'z-index':'1001'}).slideToggle("fast");
}
$(document).ready(function(){
	$('#filter_category_id').bind('change', function() {
		$.ajax({
			url: 'index.php?route=module/search_advanced/getFilter&ajax=true',
			type: 'get',
			dataType: 'html',
			data: 'filter_category_id=' + $(this).attr('value'),
			beforeSend: function()  { $('#search_attributes_content').hide(500); },
			success: function(data) { $('#search_attributes_content').html(data).show(500); }
		});
	});
	$('#button-search').bind('click', function() {
		url = 'index.php?route=product/search_advanced';
		var filter_name = $('.content input[name=\'filter_name\']').attr('value');
		if(filter_name) url += '&filter_name=' + encodeURIComponent(filter_name);
		var filter_category_id  = $('.content select[name=\'filter_category_id\'], input[name=\'filter_category_id\']').attr('value');
		if (filter_category_id != 0) { url += '&filter_category_id=' + encodeURIComponent(filter_category_id) + '&path=' + encodeURIComponent(filter_category_id); }
		var filter_sub_category = $('.content input[name=\'filter_sub_category\']:checked').attr('value');
		if (filter_sub_category) { url += '&filter_sub_category=true'; }
		var filter_description  = $('.content input[name=\'filter_description\']:checked').attr('value');
		if (filter_description) { url += '&filter_description=true'; }
		var filter_attributes    = $('#search_attributes_content').serialize();
		if (filter_attributes) { url += '&' + filter_attributes; }
		location = url;
	});
});
</script>
<?php } ?>