<?php if ($addresses) { ?>
<input type="radio" name="<?php echo $type; ?>_address" value="existing" id="<?php echo $type; ?>-address-existing" checked="checked" />
<label for="<?php echo $type; ?>-address-existing"><?php echo $text_address_existing; ?></label>
<div id="<?php echo $type; ?>-existing">
  <select name="address_id" style="width: 100%; margin-bottom: 15px;" size="5">
    <?php foreach ($addresses as $address) { ?>
    <?php if ($address['address_id'] == $address_id) { ?>
    <option value="<?php echo $address['address_id']; ?>" selected="selecteyyd"><?php echo $address['address_1']; ?></option>
    <?php } else { ?>
    <option value="<?php echo $address['address_id']; ?>"><?php echo $address['address_1']; ?></option>
    <?php } ?>
    <?php } ?>
  </select>
</div>
<?php } ?>
<p>
  <input type="radio" name="<?php echo $type; ?>_address" value="new" id="<?php echo $type; ?>-address-new" />
  <label for="<?php echo $type; ?>-address-new"><?php echo $text_address_new; ?></label>
</p>
<div id="<?php echo $type; ?>-new" style="display: none;">
  <table class="form">
    <tr class="hidden">
      <td><span class="required">*</span> <?php echo $entry_firstname; ?></td>
      <td><input type="text" name="firstname" value="" class="large-field" /></td>
    </tr>
    <tr class="hidden">
      <td><span class="required">*</span> <?php echo $entry_lastname; ?></td>
      <td><input type="text" name="lastname" value="" class="large-field" /></td>
    </tr>
    <tr class="hidden">
      <td><?php echo $entry_company; ?></td>
      <td><input type="text" name="company" value="" class="large-field" /></td>
    </tr>
    <tr>
      <td><span class="required">*</span> <?php echo $entry_address_1; ?></td>
      <td><input type="text" name="address_1" value="" class="large-field" /></td>
    </tr>
    <tr class="hidden">
      <td><?php echo $entry_address_2; ?></td>
      <td><input type="text" name="address_2" value="" class="large-field" /></td>
    </tr>
    <tr class="hidden">
      <td><span class="required">*</span> <?php echo $entry_city; ?></td>
      <td><input type="text" name="city" value="" class="large-field" /></td>
    </tr>
    <tr class="hidden">
      <td><span class="required">*</span> <?php echo $entry_postcode; ?></td>
      <td><input type="text" name="postcode" value="" class="large-field" /></td>
    </tr>
    <tr class="hidden">
      <td><select name="country_id" class="large-field" >
   
   <option value="176" selected="selected">Россия</option>
    
  </select>
  <br />
  <br />
  <span class="required">*</span> <?php echo $entry_zone; ?><br />
 <select name="zone_id" class="large-field">
   <option value="2726" selected="selected">Алтай</option>
  </select></td>
          <td></td>
    </tr>
    
  </table>
</div>
<br />
<div class="buttons">
  <div class="right"><a id="button-address" class="button"><span><?php echo $button_continue; ?></span></a></div>
</div>
<script type="text/javascript"><!--

$('#<?php echo $type; ?>-address input[name=\'<?php echo $type; ?>_address\']').live('change', function() {
	if (this.value == 'new') {
		$('#<?php echo $type; ?>-existing').hide();
		$('#<?php echo $type; ?>-new').show();
	} else {
		$('#<?php echo $type; ?>-existing').show();
		$('#<?php echo $type; ?>-new').hide();
	}
});
//--></script> 