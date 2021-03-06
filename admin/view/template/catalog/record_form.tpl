<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/record.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a>
      <a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a>
      <a href="<?php echo $url_back; ?>" class="button"><?php echo $url_back_text; ?></a>
      </div>
    </div>
    <div class="content">
      <div id="tabs" class="htabs"><a href="#tab-general"><?php echo $tab_general; ?></a><a href="#tab-data"><?php echo $tab_data; ?></a><a href="#tab-links"><?php echo $tab_links; ?></a><a href="#tab-attribute"><?php echo $tab_attribute; ?></a><a href="#tab-option"><?php echo $tab_option; ?></a><a href="#tab-image"><?php echo $tab_image; ?></a><a href="#tab-design"><?php echo $tab_design; ?></a></div>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-general">
          <div id="languages" class="htabs">
            <?php foreach ($languages as $language) { ?>
            <a href="#language<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
            <?php } ?>
          </div>
          <?php foreach ($languages as $language) { ?>
          <div id="language<?php echo $language['language_id']; ?>">
            <table class="form">
              <tr>
                <td><span class="required">*</span> <?php echo $entry_name; ?></td>
                <td><input type="text" name="record_description[<?php echo $language['language_id']; ?>][name]" size="100" value="<?php echo isset($record_description[$language['language_id']]) ? $record_description[$language['language_id']]['name'] : ''; ?>" />
                  <?php if (isset($error_name[$language['language_id']])) { ?>
                  <span class="error"><?php echo $error_name[$language['language_id']]; ?></span>
                  <?php } ?></td>
              </tr>
              <tr>
                <td><?php echo $entry_meta_description; ?></td>
                <td><textarea name="record_description[<?php echo $language['language_id']; ?>][meta_description]" cols="40" rows="5"><?php echo isset($record_description[$language['language_id']]) ? $record_description[$language['language_id']]['meta_description'] : ''; ?></textarea></td>
              </tr>
              <tr>
                <td><?php echo $entry_meta_keyword; ?></td>
                <td><textarea name="record_description[<?php echo $language['language_id']; ?>][meta_keyword]" cols="40" rows="5"><?php echo isset($record_description[$language['language_id']]) ? $record_description[$language['language_id']]['meta_keyword'] : ''; ?></textarea></td>
              </tr>
              <tr>
                <td><?php echo $entry_description; ?></td>
                <td><textarea name="record_description[<?php echo $language['language_id']; ?>][description]" id="description<?php echo $language['language_id']; ?>"><?php echo isset($record_description[$language['language_id']]) ? $record_description[$language['language_id']]['description'] : ''; ?></textarea></td>
              </tr>
              <tr>
                <td><?php echo $entry_tag; ?></td>
                <td><input type="text" name="record_tag[<?php echo $language['language_id']; ?>]" value="<?php echo isset($record_tag[$language['language_id']]) ? $record_tag[$language['language_id']] : ''; ?>" size="80" /></td>
              </tr>
            </table>
          </div>
          <?php } ?>
        </div>
        <div id="tab-data">
          <table class="form">
            <tr>
              <td><?php echo $entry_keyword; ?></td>
              <td><input type="text" name="keyword" value="<?php echo $keyword; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_image; ?></td>
              <td><div class="image"><img src="<?php echo $thumb; ?>" alt="" id="thumb" /><br />
                  <input type="hidden" name="image" value="<?php echo $image; ?>" id="image" />
                  <a onclick="image_upload('image', 'thumb');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#thumb').attr('src', '<?php echo $no_image; ?>'); $('#image').attr('value', '');"><?php echo $text_clear; ?></a></div></td>
            </tr>
            <tr>
              <td><?php echo $entry_date_available; ?></td>
              <td><input type="text" name="date_available" value="<?php echo $date_available; ?>" size="12" class="date" /></td>
            </tr>
              <tr>
                  <td>Дата создания:</td>
                  <td><input type="text" name="date_create" value="<?php echo $date_create; ?>" size="12" class="date" /></td>
              </tr>


            <tr>
              <td><?php echo $entry_comment_status; ?></td>
              <td><select name="comment_status">
                  <?php if ($comment_status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr>


            <tr>
              <td><?php echo $entry_comment_status_reg; ?></td>
              <td><select name="comment_status_reg">
                  <?php if ($comment_status_reg) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr>

            <tr>
              <td><?php echo $entry_comment_status_now; ?></td>
              <td><select name="comment_status_now">
                  <?php if ($comment_status_now) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr>


            <tr>
              <td><?php echo $entry_status; ?></td>
              <td><select name="status">
                  <?php if ($status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_sort_order; ?></td>
              <td><input type="text" name="sort_order" value="<?php echo $sort_order; ?>" size="2" /></td>
            </tr>
          </table>
        </div>
        <div id="tab-links">
          <table class="form">
            <tr>
              <td><?php echo $entry_blog; ?></td>
              <td><div class="scrollbox">
                  <?php $class = 'odd'; ?>
                  <?php foreach ($categories as $blog) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array($blog['blog_id'], $record_blog)) { ?>
                    <input type="checkbox" name="record_blog[]" value="<?php echo $blog['blog_id']; ?>" checked="checked" />
                    <?php echo $blog['name']; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="record_blog[]" value="<?php echo $blog['blog_id']; ?>" />
                    <?php echo $blog['name']; ?>
                    <?php } ?>
                  </div>
                  <?php } ?>
                </div>
                <a onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a></td>
            </tr>
            <tr>
              <td><?php echo $entry_store; ?></td>
              <td><div class="scrollbox">
                  <?php $class = 'even'; ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array(0, $record_store)) { ?>
                    <input type="checkbox" name="record_store[]" value="0" checked="checked" />
                    <?php echo $text_default; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="record_store[]" value="0" />
                    <?php echo $text_default; ?>
                    <?php } ?>
                  </div>
                  <?php foreach ($stores as $store) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array($store['store_id'], $record_store)) { ?>
                    <input type="checkbox" name="record_store[]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                    <?php echo $store['name']; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="record_store[]" value="<?php echo $store['store_id']; ?>" />
                    <?php echo $store['name']; ?>
                    <?php } ?>
                  </div>
                  <?php } ?>
                </div></td>
            </tr>
            <tr>
              <td><?php echo $entry_download; ?></td>
              <td><div class="scrollbox">
                  <?php $class = 'odd'; ?>
                  <?php foreach ($downloads as $download) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array($download['download_id'], $record_download)) { ?>
                    <input type="checkbox" name="record_download[]" value="<?php echo $download['download_id']; ?>" checked="checked" />
                    <?php echo $download['name']; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="record_download[]" value="<?php echo $download['download_id']; ?>" />
                    <?php echo $download['name']; ?>
                    <?php } ?>
                  </div>
                  <?php } ?>
                </div></td>
            </tr>
            <tr>
              <td><?php echo $entry_related; ?></td>
              <td><input type="text" name="related" value="" /></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td><div class="scrollbox" id="record-related">
                  <?php $class = 'odd'; ?>
                  <?php foreach ($record_related as $record_related) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div id="record-related<?php echo $record_related['record_id']; ?>" class="<?php echo $class; ?>"> <?php echo $record_related['name']; ?><img src="view/image/delete.png" />
                    <input type="hidden" name="record_related[]" value="<?php echo $record_related['record_id']; ?>" />
                  </div>
                  <?php } ?>
                </div></td>
            </tr>
          </table>
        </div>
        <div id="tab-attribute">
          <table id="attribute" class="list">
            <thead>
              <tr>
                <td class="left"><?php echo $entry_attribute; ?></td>
                <td class="left"><?php echo $entry_text; ?></td>
                <td></td>
              </tr>
            </thead>
            <?php $attribute_row = 0; ?>
            <?php foreach ($record_attributes as $record_attribute) { ?>
            <tbody id="attribute-row<?php echo $attribute_row; ?>">
              <tr>
                <td class="left"><input type="text" name="record_attribute[<?php echo $attribute_row; ?>][name]" value="<?php echo $record_attribute['name']; ?>" />
                  <input type="hidden" name="record_attribute[<?php echo $attribute_row; ?>][attribute_id]" value="<?php echo $record_attribute['attribute_id']; ?>" /></td>
                <td class="left"><?php foreach ($languages as $language) { ?>
                  <textarea name="record_attribute[<?php echo $attribute_row; ?>][record_attribute_description][<?php echo $language['language_id']; ?>][text]" cols="40" rows="5"><?php echo isset($record_attribute['record_attribute_description'][$language['language_id']]) ? $record_attribute['record_attribute_description'][$language['language_id']]['text'] : ''; ?></textarea>
                  <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
                  <?php } ?></td>
                <td class="left"><a onclick="$('#attribute-row<?php echo $attribute_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
              </tr>
            </tbody>
            <?php $attribute_row++; ?>
            <?php } ?>
            <tfoot>
              <tr>
                <td colspan="2"></td>
                <td class="left"><a onclick="addAttribute();" class="button"><?php echo $button_add_attribute; ?></a></td>
              </tr>
            </tfoot>
          </table>
        </div>
        <div id="tab-option">
          <div id="vtab-option" class="vtabs">
            <?php $option_row = 0; ?>
            <?php foreach ($record_options as $record_option) { ?>
            <a href="#tab-option-<?php echo $option_row; ?>" id="option-<?php echo $option_row; ?>"><?php echo $record_option['name']; ?>&nbsp;<img src="view/image/delete.png" alt="" onclick="$('#vtabs a:first').trigger('click'); $('#option-<?php echo $option_row; ?>').remove(); $('#tab-option-<?php echo $option_row; ?>').remove(); return false;" /></a>
            <?php $option_row++; ?>
            <?php } ?>
            <span id="option-add">
            <input name="option" value="" style="width: 130px;" />
            &nbsp;<img src="view/image/add.png" alt="<?php echo $button_add_option; ?>" title="<?php echo $button_add_option; ?>" /></span></div>
          <?php $option_row = 0; ?>
          <?php $option_value_row = 0; ?>
          <?php foreach ($record_options as $record_option) { ?>
          <div id="tab-option-<?php echo $option_row; ?>" class="vtabs-content">
            <input type="hidden" name="record_option[<?php echo $option_row; ?>][record_option_id]" value="<?php echo $record_option['record_option_id']; ?>" />
            <input type="hidden" name="record_option[<?php echo $option_row; ?>][name]" value="<?php echo $record_option['name']; ?>" />
            <input type="hidden" name="record_option[<?php echo $option_row; ?>][option_id]" value="<?php echo $record_option['option_id']; ?>" />
            <input type="hidden" name="record_option[<?php echo $option_row; ?>][type]" value="<?php echo $record_option['type']; ?>" />
            <table class="form">
              <tr>
                <td><?php echo $entry_required; ?></td>
                <td><select name="record_option[<?php echo $option_row; ?>][required]">
                    <?php if ($record_option['required']) { ?>
                    <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                    <option value="0"><?php echo $text_no; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_yes; ?></option>
                    <option value="0" selected="selected"><?php echo $text_no; ?></option>
                    <?php } ?>
                  </select></td>
              </tr>
              <?php if ($record_option['type'] == 'text') { ?>
              <tr>
                <td><?php echo $entry_option_value; ?></td>
                <td><input type="text" name="record_option[<?php echo $option_row; ?>][option_value]" value="<?php echo $record_option['option_value']; ?>" /></td>
              </tr>
              <?php } ?>
              <?php if ($record_option['type'] == 'textarea') { ?>
              <tr>
                <td><?php echo $entry_option_value; ?></td>
                <td><textarea name="record_option[<?php echo $option_row; ?>][option_value]" cols="40" rows="5"><?php echo $record_option['option_value']; ?></textarea></td>
              </tr>
              <?php } ?>
              <?php if ($record_option['type'] == 'file') { ?>
              <tr style="display: none;">
                <td><?php echo $entry_option_value; ?></td>
                <td><input type="text" name="record_option[<?php echo $option_row; ?>][option_value]" value="<?php echo $record_option['option_value']; ?>" /></td>
              </tr>
              <?php } ?>
              <?php if ($record_option['type'] == 'date') { ?>
              <tr>
                <td><?php echo $entry_option_value; ?></td>
                <td><input type="text" name="record_option[<?php echo $option_row; ?>][option_value]" value="<?php echo $record_option['option_value']; ?>" class="date" /></td>
              </tr>
              <?php } ?>
              <?php if ($record_option['type'] == 'datetime') { ?>
              <tr>
                <td><?php echo $entry_option_value; ?></td>
                <td><input type="text" name="record_option[<?php echo $option_row; ?>][option_value]" value="<?php echo $record_option['option_value']; ?>" class="datetime" /></td>
              </tr>
              <?php } ?>
              <?php if ($record_option['type'] == 'time') { ?>
              <tr>
                <td><?php echo $entry_option_value; ?></td>
                <td><input type="text" name="record_option[<?php echo $option_row; ?>][option_value]" value="<?php echo $record_option['option_value']; ?>" class="time" /></td>
              </tr>
              <?php } ?>
            </table>
            <?php if ($record_option['type'] == 'select' || $record_option['type'] == 'radio' || $record_option['type'] == 'checkbox' || $record_option['type'] == 'image') { ?>
            <table id="option-value<?php echo $option_row; ?>" class="list">
              <thead>
                <tr>
                  <td class="left"><?php echo $entry_option_value; ?></td>
                  <td class="right"><?php echo $entry_quantity; ?></td>
                  <td class="left"><?php echo $entry_subtract; ?></td>
                  <td class="right"><?php echo $entry_price; ?></td>
                  <td class="right"><?php echo $entry_option_points; ?></td>
                  <td class="right"><?php echo $entry_weight; ?></td>
                  <td></td>
                </tr>
              </thead>
              <?php foreach ($record_option['record_option_value'] as $record_option_value) { ?>
              <tbody id="option-value-row<?php echo $option_value_row; ?>">
                <tr>
                  <td class="left"><select name="record_option[<?php echo $option_row; ?>][record_option_value][<?php echo $option_value_row; ?>][option_value_id]">
                    </select>
                    <input type="hidden" name="record_option[<?php echo $option_row; ?>][record_option_value][<?php echo $option_value_row; ?>][record_option_value_id]" value="<?php echo $record_option_value['record_option_value_id']; ?>" /></td>
                  <td class="right"><input type="text" name="record_option[<?php echo $option_row; ?>][record_option_value][<?php echo $option_value_row; ?>][quantity]" value="<?php echo $record_option_value['quantity']; ?>" size="3" /></td>
                  <td class="left"><select name="record_option[<?php echo $option_row; ?>][record_option_value][<?php echo $option_value_row; ?>][subtract]">
                      <?php if ($record_option_value['subtract']) { ?>
                      <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                      <option value="0"><?php echo $text_no; ?></option>
                      <?php } else { ?>
                      <option value="1"><?php echo $text_yes; ?></option>
                      <option value="0" selected="selected"><?php echo $text_no; ?></option>
                      <?php } ?>
                    </select></td>
                  <td class="right"><select name="record_option[<?php echo $option_row; ?>][record_option_value][<?php echo $option_value_row; ?>][price_prefix]">
                      <?php if ($record_option_value['price_prefix'] == '+') { ?>
                      <option value="+" selected="selected">+</option>
                      <?php } else { ?>
                      <option value="+">+</option>
                      <?php } ?>
                      <?php if ($record_option_value['price_prefix'] == '-') { ?>
                      <option value="-" selected="selected">-</option>
                      <?php } else { ?>
                      <option value="-">-</option>
                      <?php } ?>
                    </select>
                    <input type="text" name="record_option[<?php echo $option_row; ?>][record_option_value][<?php echo $option_value_row; ?>][price]" value="<?php echo $record_option_value['price']; ?>" size="5" /></td>
                  <td class="right"><select name="record_option[<?php echo $option_row; ?>][record_option_value][<?php echo $option_value_row; ?>][points_prefix]">
                      <?php if ($record_option_value['points_prefix'] == '+') { ?>
                      <option value="+" selected="selected">+</option>
                      <?php } else { ?>
                      <option value="+">+</option>
                      <?php } ?>
                      <?php if ($record_option_value['points_prefix'] == '-') { ?>
                      <option value="-" selected="selected">-</option>
                      <?php } else { ?>
                      <option value="-">-</option>
                      <?php } ?>
                    </select>
                    <input type="text" name="record_option[<?php echo $option_row; ?>][record_option_value][<?php echo $option_value_row; ?>][points]" value="<?php echo $record_option_value['points']; ?>" size="5" /></td>
                  <td class="right"><select name="record_option[<?php echo $option_row; ?>][record_option_value][<?php echo $option_value_row; ?>][weight_prefix]">
                      <?php if ($record_option_value['weight_prefix'] == '+') { ?>
                      <option value="+" selected="selected">+</option>
                      <?php } else { ?>
                      <option value="+">+</option>
                      <?php } ?>
                      <?php if ($record_option_value['weight_prefix'] == '-') { ?>
                      <option value="-" selected="selected">-</option>
                      <?php } else { ?>
                      <option value="-">-</option>
                      <?php } ?>
                    </select>
                    <input type="text" name="record_option[<?php echo $option_row; ?>][record_option_value][<?php echo $option_value_row; ?>][weight]" value="<?php echo $record_option_value['weight']; ?>" size="5" /></td>
                  <td class="left"><a onclick="$('#option-value-row<?php echo $option_value_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
                </tr>
              </tbody>
              <?php $option_value_row++; ?>
              <?php } ?>
              <tfoot>
                <tr>
                  <td colspan="6"></td>
                  <td class="left"><a onclick="addOptionValue('<?php echo $option_row; ?>');" class="button"><?php echo $button_add_option_value; ?></a></td>
                </tr>
              </tfoot>
            </table>
            <?php } ?>
          </div>
          <?php $option_row++; ?>
          <?php } ?>
          <script type="text/javascript"><!--
          <?php $option_row = 0; ?>
          <?php $option_value_row = 0; ?>
		  <?php foreach ($record_options as $record_option) { ?>
          <?php if ($record_option['type'] == 'select' || $record_option['type'] == 'radio' || $record_option['type'] == 'checkbox' || $record_option['type'] == 'image') { ?>
		  <?php foreach ($record_option['record_option_value'] as $record_option_value) { ?>
		  $('select[name=\'record_option[<?php echo $option_row; ?>][record_option_value][<?php echo $option_value_row; ?>][option_value_id]\']').load('index.php?route=catalog/record/option&token=<?php echo $token; ?>&option_id=<?php echo $record_option['option_id']; ?>&option_value_id=<?php echo $record_option_value['option_value_id']; ?>');
		  <?php $option_value_row++; ?>
		  <?php } ?>
		  <?php } ?>
		  <?php $option_row++; ?>
          <?php } ?>
		  //--></script>
        </div>

       <div id="tab-image">
          <table id="images" class="list">
            <thead>
              <tr>
                <td class="left"><?php echo $entry_image; ?></td>
                <td class="right"><?php echo $entry_sort_order; ?></td>
                <td></td>
              </tr>
            </thead>
            <?php $image_row = 0; ?>
            <?php foreach ($record_images as $record_image) { ?>
            <tbody id="image-row<?php echo $image_row; ?>">
              <tr>
                <td class="left"><div class="image"><img src="<?php echo $record_image['thumb']; ?>" alt="" id="thumb<?php echo $image_row; ?>" />
                    <input type="hidden" name="record_image[<?php echo $image_row; ?>][image]" value="<?php echo $record_image['image']; ?>" id="image<?php echo $image_row; ?>" />
                    <br />
                    <a onclick="image_upload('image<?php echo $image_row; ?>', 'thumb<?php echo $image_row; ?>');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#thumb<?php echo $image_row; ?>').attr('src', '<?php echo $no_image; ?>'); $('#image<?php echo $image_row; ?>').attr('value', '');"><?php echo $text_clear; ?></a></div></td>
                <td class="right"><input type="text" name="record_image[<?php echo $image_row; ?>][sort_order]" value="<?php echo $record_image['sort_order']; ?>" size="2" /></td>
                <td class="left"><a onclick="$('#image-row<?php echo $image_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
              </tr>
            </tbody>
            <?php $image_row++; ?>
            <?php } ?>
            <tfoot>
              <tr>
                <td colspan="2"></td>
                <td class="left"><a onclick="addImage();" class="button"><?php echo $button_add_image; ?></a></td>
              </tr>
            </tfoot>
          </table>
        </div>
       <div id="tab-design">
          <table class="list">
            <thead>
              <tr>
                <td class="left"><?php echo $entry_store; ?></td>
                <td class="left"><?php echo $entry_layout; ?></td>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td class="left"><?php echo $text_default; ?></td>
                <td class="left"><select name="record_layout[0][layout_id]">
                    <option value=""></option>
                    <?php foreach ($layouts as $layout) { ?>
                    <?php if (isset($record_layout[0]) && $record_layout[0] == $layout['layout_id']) { ?>
                    <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
              </tr>
            </tbody>
            <?php foreach ($stores as $store) { ?>
            <tbody>
              <tr>
                <td class="left"><?php echo $store['name']; ?></td>
                <td class="left"><select name="record_layout[<?php echo $store['store_id']; ?>][layout_id]">
                    <option value=""></option>
                    <?php foreach ($layouts as $layout) { ?>
                    <?php if (isset($record_layout[$store['store_id']]) && $record_layout[$store['store_id']] == $layout['layout_id']) { ?>
                    <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
              </tr>
            </tbody>
            <?php } ?>
          </table>
        </div>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>
<script type="text/javascript"><!--
<?php foreach ($languages as $language) { ?>
CKEDITOR.replace('description<?php echo $language['language_id']; ?>', {
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
<?php } ?>
//--></script>
<script type="text/javascript"><!--
$('input[name=\'related\']').autocomplete({
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/record/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.record_id
					}
				}));
			}
		});

	},
	select: function(event, ui) {
		$('#record-related' + ui.item.value).remove();

		$('#record-related').append('<div id="record-related' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" /><input type="hidden" name="record_related[]" value="' + ui.item.value + '" /></div>');

		$('#record-related div:odd').attr('class', 'odd');
		$('#record-related div:even').attr('class', 'even');

		return false;
	}
});

$('#record-related div img').live('click', function() {
	$(this).parent().remove();

	$('#record-related div:odd').attr('class', 'odd');
	$('#record-related div:even').attr('class', 'even');
});
//--></script>
<script type="text/javascript"><!--
var attribute_row = <?php echo $attribute_row; ?>;

function addAttribute() {
	html  = '<tbody id="attribute-row' + attribute_row + '">';
    html += '  <tr>';
	html += '    <td class="left"><input type="text" name="record_attribute[' + attribute_row + '][name]" value="" /><input type="hidden" name="record_attribute[' + attribute_row + '][attribute_id]" value="" /></td>';
	html += '    <td class="left">';
	<?php foreach ($languages as $language) { ?>
	html += '<textarea name="record_attribute[' + attribute_row + '][record_attribute_description][<?php echo $language['language_id']; ?>][text]" cols="40" rows="5"></textarea><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />';
    <?php } ?>
	html += '    </td>';
	html += '    <td class="left"><a onclick="$(\'#attribute-row' + attribute_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
    html += '  </tr>';
    html += '</tbody>';

	$('#attribute tfoot').before(html);

	attributeautocomplete(attribute_row);

	attribute_row++;
}

$.widget('custom.catcomplete', $.ui.autocomplete, {
	_renderMenu: function(ul, items) {
		var self = this, currentCategory = '';

		$.each(items, function(index, item) {
			if (item.blog != currentCategory) {
				ul.append('<li class="ui-autocomplete-blog">' + item.blog + '</li>');

				currentCategory = item.blog;
			}

			self._renderItem(ul, item);
		});
	}
});

function attributeautocomplete(attribute_row) {
	$('input[name=\'record_attribute[' + attribute_row + '][name]\']').catcomplete({
		delay: 0,
		source: function(request, response) {
			$.ajax({
				url: 'index.php?route=catalog/attribute/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
				dataType: 'json',
				success: function(json) {
					response($.map(json, function(item) {
						return {
							blog: item.attribute_group,
							label: item.name,
							value: item.attribute_id
						}
					}));
				}
			});
		},
		select: function(event, ui) {
			$('input[name=\'record_attribute[' + attribute_row + '][name]\']').attr('value', ui.item.label);
			$('input[name=\'record_attribute[' + attribute_row + '][attribute_id]\']').attr('value', ui.item.value);

			return false;
		}
	});
}

$('#attribute tbody').each(function(index, element) {
	attributeautocomplete(index);
});
//--></script>
<script type="text/javascript"><!--
var option_row = <?php echo $option_row; ?>;

$('input[name=\'option\']').catcomplete({
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/option/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						blog: item.blog,
						label: item.name,
						value: item.option_id,
						type: item.type
					}
				}));
			}
		});
	},
	select: function(event, ui) {
		html  = '<div id="tab-option-' + option_row + '" class="vtabs-content">';
		html += '	<input type="hidden" name="record_option[' + option_row + '][record_option_id]" value="" />';
		html += '	<input type="hidden" name="record_option[' + option_row + '][name]" value="' + ui.item.label + '" />';
		html += '	<input type="hidden" name="record_option[' + option_row + '][option_id]" value="' + ui.item.value + '" />';
		html += '	<input type="hidden" name="record_option[' + option_row + '][type]" value="' + ui.item.type + '" />';
		html += '	<table class="form">';
		html += '	  <tr>';
		html += '		<td><?php echo $entry_required; ?></td>';
		html += '       <td><select name="record_option[' + option_row + '][required]">';
		html += '	      <option value="1"><?php echo $text_yes; ?></option>';
		html += '	      <option value="0"><?php echo $text_no; ?></option>';
		html += '	    </select></td>';
		html += '     </tr>';

		if (ui.item.type == 'text') {
			html += '     <tr>';
			html += '       <td><?php echo $entry_option_value; ?></td>';
			html += '       <td><input type="text" name="record_option[' + option_row + '][option_value]" value="" /></td>';
			html += '     </tr>';
		}

		if (ui.item.type == 'textarea') {
			html += '     <tr>';
			html += '       <td><?php echo $entry_option_value; ?></td>';
			html += '       <td><textarea name="record_option[' + option_row + '][option_value]" cols="40" rows="5"></textarea></td>';
			html += '     </tr>';
		}

		if (ui.item.type == 'file') {
			html += '     <tr style="display: none;">';
			html += '       <td><?php echo $entry_option_value; ?></td>';
			html += '       <td><input type="text" name="record_option[' + option_row + '][option_value]" value="" /></td>';
			html += '     </tr>';
		}

		if (ui.item.type == 'date') {
			html += '     <tr>';
			html += '       <td><?php echo $entry_option_value; ?></td>';
			html += '       <td><input type="text" name="record_option[' + option_row + '][option_value]" value="" class="date" /></td>';
			html += '     </tr>';
		}

		if (ui.item.type == 'datetime') {
			html += '     <tr>';
			html += '       <td><?php echo $entry_option_value; ?></td>';
			html += '       <td><input type="text" name="record_option[' + option_row + '][option_value]" value="" class="datetime" /></td>';
			html += '     </tr>';
		}

		if (ui.item.type == 'time') {
			html += '     <tr>';
			html += '       <td><?php echo $entry_option_value; ?></td>';
			html += '       <td><input type="text" name="record_option[' + option_row + '][option_value]" value="" class="time" /></td>';
			html += '     </tr>';
		}

		html += '  </table>';

		if (ui.item.type == 'select' || ui.item.type == 'radio' || ui.item.type == 'checkbox' || ui.item.type == 'image') {
			html += '  <table id="option-value' + option_row + '" class="list">';
			html += '  	 <thead>';
			html += '      <tr>';
			html += '        <td class="left"><?php echo $entry_option_value; ?></td>';
			html += '        <td class="right"><?php echo $entry_quantity; ?></td>';
			html += '        <td class="left"><?php echo $entry_subtract; ?></td>';
			html += '        <td class="right"><?php echo $entry_price; ?></td>';
			html += '        <td class="right"><?php echo $entry_option_points; ?></td>';
			html += '        <td class="right"><?php echo $entry_weight; ?></td>';
			html += '        <td></td>';
			html += '      </tr>';
			html += '  	 </thead>';
			html += '    <tfoot>';
			html += '      <tr>';
			html += '        <td colspan="6"></td>';
			html += '        <td class="left"><a onclick="addOptionValue(' + option_row + ');" class="button"><?php echo $button_add_option_value; ?></a></td>';
			html += '      </tr>';
			html += '    </tfoot>';
			html += '  </table>';
			html += '</div>';
		}

		$('#tab-option').append(html);

		$('#option-add').before('<a href="#tab-option-' + option_row + '" id="option-' + option_row + '">' + ui.item.label + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'#vtab-option a:first\').trigger(\'click\'); $(\'#option-' + option_row + '\').remove(); $(\'#tab-option-' + option_row + '\').remove(); return false;" /></a>');

		$('#vtab-option a').tabs();

		$('#option-' + option_row).trigger('click');

		$('.date').datepicker({dateFormat: 'yy-mm-dd'});
		$('.datetime').datetimepicker({
			dateFormat: 'yy-mm-dd',
			timeFormat: 'h:m'
		});

		$('.time').timepicker({timeFormat: 'h:m'});

		option_row++;

		return false;
	}
});
//--></script>
<script type="text/javascript"><!--
var option_value_row = <?php echo $option_value_row; ?>;

function addOptionValue(option_row) {
	html  = '<tbody id="option-value-row' + option_value_row + '">';
	html += '  <tr>';
	html += '    <td class="left"><select name="record_option[' + option_row + '][record_option_value][' + option_value_row + '][option_value_id]"></select><input type="hidden" name="record_option[' + option_row + '][record_option_value][' + option_value_row + '][record_option_value_id]" value="" /></td>';
	html += '    <td class="right"><input type="text" name="record_option[' + option_row + '][record_option_value][' + option_value_row + '][quantity]" value="" size="3" /></td>';
	html += '    <td class="left"><select name="record_option[' + option_row + '][record_option_value][' + option_value_row + '][subtract]">';
	html += '      <option value="1"><?php echo $text_yes; ?></option>';
	html += '      <option value="0"><?php echo $text_no; ?></option>';
	html += '    </select></td>';
	html += '    <td class="right"><select name="record_option[' + option_row + '][record_option_value][' + option_value_row + '][price_prefix]">';
	html += '      <option value="+">+</option>';
	html += '      <option value="-">-</option>';
	html += '    </select>';
	html += '    <input type="text" name="record_option[' + option_row + '][record_option_value][' + option_value_row + '][price]" value="" size="5" /></td>';
	html += '    <td class="right"><select name="record_option[' + option_row + '][record_option_value][' + option_value_row + '][points_prefix]">';
	html += '      <option value="+">+</option>';
	html += '      <option value="-">-</option>';
	html += '    </select>';
	html += '    <input type="text" name="record_option[' + option_row + '][record_option_value][' + option_value_row + '][points]" value="" size="5" /></td>';
	html += '    <td class="right"><select name="record_option[' + option_row + '][record_option_value][' + option_value_row + '][weight_prefix]">';
	html += '      <option value="+">+</option>';
	html += '      <option value="-">-</option>';
	html += '    </select>';
	html += '    <input type="text" name="record_option[' + option_row + '][record_option_value][' + option_value_row + '][weight]" value="" size="5" /></td>';
	html += '    <td class="left"><a onclick="$(\'#option-value-row' + option_value_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
	html += '  </tr>';
	html += '</tbody>';

	$('#option-value' + option_row + ' tfoot').before(html);

	$('select[name=\'record_option[' + option_row + '][record_option_value][' + option_value_row + '][option_value_id]\']').load('index.php?route=catalog/record/option&token=<?php echo $token; ?>&option_id=' + $('input[name=\'record_option[' + option_row + '][option_id]\']').attr('value'));

	option_value_row++;
}
//--></script>
<script type="text/javascript"><!--
var discount_row = <?php echo $discount_row; ?>;

function addDiscount() {
	html  = '<tbody id="discount-row' + discount_row + '">';
	html += '  <tr>';
    html += '    <td class="left"><select name="record_discount[' + discount_row + '][customer_group_id]">';
    <?php foreach ($customer_groups as $customer_group) { ?>
    html += '      <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>';
    <?php } ?>
    html += '    </select></td>';
    html += '    <td class="right"><input type="text" name="record_discount[' + discount_row + '][quantity]" value="" size="2" /></td>';
    html += '    <td class="right"><input type="text" name="record_discount[' + discount_row + '][priority]" value="" size="2" /></td>';
	html += '    <td class="right"><input type="text" name="record_discount[' + discount_row + '][price]" value="" /></td>';
    html += '    <td class="left"><input type="text" name="record_discount[' + discount_row + '][date_start]" value="" class="date" /></td>';
	html += '    <td class="left"><input type="text" name="record_discount[' + discount_row + '][date_end]" value="" class="date" /></td>';
	html += '    <td class="left"><a onclick="$(\'#discount-row' + discount_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
	html += '  </tr>';
    html += '</tbody>';

	$('#discount tfoot').before(html);

	$('#discount-row' + discount_row + ' .date').datepicker({dateFormat: 'yy-mm-dd'});

	discount_row++;
}
//--></script>
<script type="text/javascript"><!--
var special_row = <?php echo $special_row; ?>;

function addSpecial() {
	html  = '<tbody id="special-row' + special_row + '">';
	html += '  <tr>';
    html += '    <td class="left"><select name="record_special[' + special_row + '][customer_group_id]">';
    <?php foreach ($customer_groups as $customer_group) { ?>
    html += '      <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>';
    <?php } ?>
    html += '    </select></td>';
    html += '    <td class="right"><input type="text" name="record_special[' + special_row + '][priority]" value="" size="2" /></td>';
	html += '    <td class="right"><input type="text" name="record_special[' + special_row + '][price]" value="" /></td>';
    html += '    <td class="left"><input type="text" name="record_special[' + special_row + '][date_start]" value="" class="date" /></td>';
	html += '    <td class="left"><input type="text" name="record_special[' + special_row + '][date_end]" value="" class="date" /></td>';
	html += '    <td class="left"><a onclick="$(\'#special-row' + special_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
	html += '  </tr>';
    html += '</tbody>';

	$('#special tfoot').before(html);

	$('#special-row' + special_row + ' .date').datepicker({dateFormat: 'yy-mm-dd'});

	special_row++;
}
//--></script>
<script type="text/javascript"><!--
function image_upload(field, thumb) {
	$('#dialog').remove();

	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');

	$('#dialog').dialog({
		title: '<?php echo $text_image_manager; ?>',
		close: function (event, ui) {
			if ($('#' + field).attr('value')) {
				$.ajax({
					url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).attr('value')),
					dataType: 'text',
					success: function(text) {
						$('#' + thumb).replaceWith('<img src="' + text + '" alt="" id="' + thumb + '" />');
					}
				});
			}
		},
		bgiframe: false,
		width: 800,
		height: 400,
		resizable: false,
		modal: false
	});
};
//--></script>
<script type="text/javascript"><!--
var image_row = <?php echo $image_row; ?>;

function addImage() {
    html  = '<tbody id="image-row' + image_row + '">';
	html += '  <tr>';
	html += '    <td class="left"><div class="image"><img src="<?php echo $no_image; ?>" alt="" id="thumb' + image_row + '" /><input type="hidden" name="record_image[' + image_row + '][image]" value="" id="image' + image_row + '" /><br /><a onclick="image_upload(\'image' + image_row + '\', \'thumb' + image_row + '\');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$(\'#thumb' + image_row + '\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#image' + image_row + '\').attr(\'value\', \'\');"><?php echo $text_clear; ?></a></div></td>';
	html += '    <td class="right"><input type="text" name="record_image[' + image_row + '][sort_order]" value="" /></td>';
	html += '    <td class="left"><a onclick="$(\'#image-row' + image_row  + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
	html += '  </tr>';
	html += '</tbody>';

	$('#images tfoot').before(html);

	image_row++;
}
//--></script>
<script type="text/javascript" src="view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript"><!--
$('.date').datepicker({dateFormat: 'yy-mm-dd'});
$('.datetime').datetimepicker({
	dateFormat: 'yy-mm-dd',
	timeFormat: 'h:m'
});
$('.time').timepicker({timeFormat: 'h:m'});
//--></script>
<script type="text/javascript"><!--
$('#tabs a').tabs();
$('#languages a').tabs();
$('#vtab-option a').tabs();
//--></script>
<?php echo $footer; ?>