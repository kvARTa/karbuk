<?php echo $header; ?>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<?php echo $column_left; ?>
<div id="content"><div class="box-heading"><?php echo $heading_title; ?>
</div>
<div class="box-content"><?php echo $content_top; ?>
  <div class="breadcrumb">
   <?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
        <?php echo $breadcrumb['separator']; ?><?php if($i+1<count($breadcrumbs)) { ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a> <?php } else { ?><?php echo $breadcrumb['text']; ?><?php } ?>
        <?php } ?>
  </div>
  <h1><?php echo $heading_title; ?></h1>
  <p><?php echo $text_account_already; ?></p>
  <form action="<?php echo $action; ?>" id="uregform" method="post" enctype="multipart/form-data">
    <h2><?php echo $text_your_details; ?></h2>
    <div class="content">
		<table class="form">      
 		  <tr style="display:none;">
		    <td><span class="required">*</span> <?php echo $entry_login; ?></td>
		    <td><input type="text" name="login" value="<?php echo $login; ?>" />
		      <?php if ($error_login) { ?>
		      <span class="error"><?php echo $error_login; ?></span>
		      <?php } ?></td>
		  </tr>
		   <tr>
		    <td><span class="required">*</span> <?php echo $entry_firstname; ?></td>
		    <td><input type="text" name="firstname" value="<?php echo $firstname; ?>" />
		      <?php if ($error_firstname) { ?>
		      <span class="error"><?php echo $error_firstname; ?></span>
		      <?php } ?></td>
		  </tr> 
		  <tr>
		    <td><span class="required">*</span> <?php echo $entry_lastname; ?></td>
		    <td><input type="text" name="lastname" value="<?php echo $lastname; ?>" /></td>
		  </tr>
 		  <tr>
		    <td><span class="required">*</span> <?php echo $entry_email; ?></td>
		    <td><input type="text" name="email" value="<?php echo $email; ?>" />
		      <?php if ($error_email) { ?>
		      <span class="error"><?php echo $error_email; ?></span>
		      <?php } ?></td>
		  </tr>
		  <tr>
		    <td><span class="required">*</span> <?php echo $entry_telephone; ?></td>
		    <td><input type="text" name="telephone" value="<?php echo $telephone; ?>" />
		      <?php if ($error_telephone) { ?>
		      <span class="error"><?php echo $error_telephone; ?></span>
		      <?php } ?></td>
		  </tr>
		</table>
    </div>
    <h2><?php echo $text_company_data; ?></h2>
    <div class="content">
		<table class="form">      
		  <tr>
		    <td><span class="required">*</span> <?php echo $entry_company; ?></td>
		    <td><input type="text" name="company" value="<?php echo $company; ?>" />
		      <?php if ($error_company) { ?>
		      <span class="error"><?php echo $error_company; ?></span>
		      <?php } ?></td>
		  </tr>     
		  <tr>
		    <td><span class="required">*</span> <?php echo $entry_inn; ?></td>
		    <td><input type="text" name="inn" value="<?php echo $inn; ?>" />
		      <?php if ($error_inn) { ?>
		      <span class="error"><?php echo $error_inn; ?></span>
		      <?php } ?></td>
		  </tr>  
		  <tr>
		    <td><?php echo $entry_kpp; ?></td>
		    <td><input type="text" name="kpp" value="<?php echo $kpp; ?>" /></td>
		  </tr>  
		  <tr>
		    <td><?php echo $entry_ur_address; ?></td>
		    <td><input type="text" name="ur_address" value="<?php echo $ur_address; ?>" /></td>
		  </tr>  
		  <tr>
		    <td><?php echo $entry_fact_address; ?></td>
		    <td><input type="text" name="fact_address" value="<?php echo $fact_address; ?>" /></td>
		  </tr>  
		</table>
    </div>
    <h2><?php echo $text_your_address; ?></h2>
    <div class="content">
		<table class="form">
	<!--	  <tr>
		    <td><span id="postcode-required" class="required">*</span> <?php echo $entry_postcode; ?></td>
		    <td><input type="text" name="postcode" value="<?php echo $postcode; ?>" />
		      <?php if ($error_postcode) { ?>
		      <span class="error"><?php echo $error_postcode; ?></span>
		      <?php } ?></td>
		  </tr> -->
		  <tr style="display:none;">
		    <td></td>
		    <td><select name="country_id">
			<option value="176" selected="selected"></option>
		      </select>
		    </td>
		  </tr>
<!-- 		  <tr>
		    <td><?php echo $entry_zone; ?></td>
		    <td><select name="zone_id"></select></td>
		  </tr> -->
		  <tr>
		    <td><?php echo $entry_city; ?></td>
		    <td><input type="text" name="city" value="<?php echo $city; ?>" /></td>
		  </tr>
		  <tr>
		    <td><?php echo $entry_address_1; ?></td>
		    <td><input type="text" name="address_1" value="<?php echo $address_1; ?>" /></td>
		  </tr>
		</table>
    </div>
    <h2><?php echo $text_your_manager; ?></h2>
    <div class="content">
		<table class="form">
		  <tr>
		    <td><?php echo $entry_manager; ?></td>
		    <td><input type="text" name="manager" value="<?php echo $manager; ?>" /></td>
		  </tr>
		</table>
    </div>
    <h2><?php echo $text_your_password; ?></h2>
    <div class="content">
		<table class="form">
		  <tr>
		    <td><span class="required">*</span> <?php echo $entry_password; ?></td>
		    <td><input type="password" name="password" value="<?php echo $password; ?>" />
		      <?php if ($error_password) { ?>
		      <span class="error"><?php echo $error_password; ?></span>
		      <?php } ?></td>
		  </tr>
		  <tr>
		    <td><span class="required">*</span> <?php echo $entry_confirm; ?></td>
		    <td><input type="password" name="confirm" value="<?php echo $confirm; ?>" />
		      <?php if ($error_confirm) { ?>
		      <span class="error"><?php echo $error_confirm; ?></span>
		      <?php } ?></td>
		  </tr>
		</table>
    </div>
    <h2><?php echo $text_newsletter; ?></h2>
    <div class="content">
		<table class="form">
		  <tr>
		    <td><?php echo $entry_newsletter; ?></td>
		    <td><?php if ($newsletter) { ?>
		      <input type="radio" name="newsletter" value="1" checked="checked" />
		      <?php echo $text_yes; ?>
		      <input type="radio" name="newsletter" value="0" />
		      <?php echo $text_no; ?>
		      <?php } else { ?>
		      <input type="radio" name="newsletter" value="1" />
		      <?php echo $text_yes; ?>
		      <input type="radio" name="newsletter" value="0" checked="checked" />
		      <?php echo $text_no; ?>
		      <?php } ?></td>
		  </tr>
		</table>
    </div>
    <?php if ($text_agree) { ?>
    <div class="buttons">
      <div class="right"><?php echo $text_agree; ?>
        <?php if ($agree) { ?>
        <input type="checkbox" name="agree" value="1" checked="checked" />
        <?php } else { ?>
        <input type="checkbox" name="agree" value="1" />
        <?php } ?>
        <input type="submit" value="<?php echo $button_continue; ?>" class="button" />
      </div>
    </div>
    <?php } else { ?>
    <div class="buttons">
      <div class="right">
        <input type="submit" value="<?php echo $button_continue; ?>" class="button" />
      </div>
    </div>
    <?php } ?>
  </form>
  <script>
$("#uregform").on("submit",function(){
	$("#uregform").find("input[name='login']").val($("#uregform").find("input[name='email']").val());
});
  </script>
  <?php echo $content_bottom; ?></div>
<script type="text/javascript"><!--
$('select[name=\'customer_group_id\']').live('change', function() {
	var customer_group = [];
	
<?php foreach ($customer_groups as $customer_group) { ?>
	customer_group[<?php echo $customer_group['customer_group_id']; ?>] = [];
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_display'] = '<?php echo $customer_group['company_id_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_required'] = '<?php echo $customer_group['company_id_required']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_display'] = '<?php echo $customer_group['tax_id_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_required'] = '<?php echo $customer_group['tax_id_required']; ?>';
<?php } ?>	

	if (customer_group[this.value]) {
		if (customer_group[this.value]['company_id_display'] == '1') {
			$('#company-id-display').show();
		} else {
			$('#company-id-display').hide();
		}
		
		if (customer_group[this.value]['company_id_required'] == '1') {
			$('#company-id-required').show();
		} else {
			$('#company-id-required').hide();
		}
		
		if (customer_group[this.value]['tax_id_display'] == '1') {
			$('#tax-id-display').show();
		} else {
			$('#tax-id-display').hide();
		}
		
		if (customer_group[this.value]['tax_id_required'] == '1') {
			$('#tax-id-required').show();
		} else {
			$('#tax-id-required').hide();
		}	
	}
});

$('select[name=\'customer_group_id\']').trigger('change');
//--></script>   
<script type="text/javascript"><!--
$(function() {
	$.ajax({
		url: 'index.php?route=account/register/country&country_id=176',// + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('.wait').remove();
		},			
		success: function(json) {

			if (json['postcode_required'] == '1') {
				$('#postcode-required').show();
			} else {
				$('#postcode-required').hide();
			}
			
			html = '<option value=""><?php echo $text_select; ?></option>';
			
			if (json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
        			html += '<option value="' + json['zone'][i]['zone_id'] + '"';
	    			
					if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
	      				html += ' selected="selected"';
	    			}
	
	    			html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			
			$('select[name=\'zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

//--></script>
<script type="text/javascript"><!--
$('.colorbox').colorbox({
	width: 640,
	height: 480
});
//--></script> 
</div><?php echo $footer; ?>