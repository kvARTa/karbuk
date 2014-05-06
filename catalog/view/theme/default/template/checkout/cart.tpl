<?php echo $header; ?>
<?php if ($attention) { ?>
<div class="attention"><?php echo $attention; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
<?php } ?>

<?php //if ($success) { ?>
<!--<div class="success"><?php //echo $success; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>-->
<?php //} ?>


<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
<?php } ?>
<?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content">
<div class="box-heading">Корзина
</div>
<div class="box-content">


<?php echo $content_top; ?>
  
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
    <div class="cart-info">
      <table>
        <thead>
          <tr>
            <td class="image"><?php echo $column_image; ?></td>
            <td class="name"><?php echo $column_name; ?></td>
            <td class="model"><?php echo $column_model; ?></td>
            
            <td class="price"><?php echo $column_price; ?></td>
            <td class="quantity"><?php echo $column_quantity; ?></td>
            <td class="total"><?php echo $column_total; ?></td>
             <td class="status">Статус</td>
          </tr>
        </thead>
        <tbody>
          <?php $k=0; foreach ($products as $product) { $k=$k+1; ?>
        
        <? if ($k==1) echo '<tr>'; else echo '<tr class="grey">'; if ($k==2) $k=0; ?> 
          
        <td class="image"><?php if ($product['thumb']) { ?>
              <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
              <?php } ?></td>
            <td class="name" style="text-align: left;"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
              <?php if (!$product['stock']) { ?>
              <span class="stock">***</span>
              <?php } ?>
              <div>
                <?php foreach ($product['option'] as $option) { ?>
                - <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small><br />
                <?php } ?>
              </div>
              <?php if ($product['reward']) { ?>
              <small><?php echo $product['reward']; ?></small>
              <?php } ?></td>
            <td class="model"><?php echo $product['model']; ?></td>
           
            <td class="price"><?php echo $product['price']; ?></td>
             <td class="quantity"><input type="text" name="quantity[<?php echo $product['key']; ?>]" value="<?php echo $product['quantity']; ?>" size="1" style="width: 10px;"/>
              &nbsp;
              <input type="image" src="catalog/view/theme/default/image/update.png" alt="<?php echo $button_update; ?>" title="<?php echo $button_update; ?>" />
              &nbsp;<a href="<?php echo $product['remove']; ?>"><img src="catalog/view/theme/default/image/remove.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" /></a></td>
            <td class="total"><?php echo $product['total']; ?></td>
            <td class="statuss"><?php echo $product['stockk']; ?></td>
          </tr>
          <?php } ?>
          <?php foreach ($vouchers as $vouchers) { ?>
          <tr>
            <td class="image"></td>
            <td class="name" style="text-align: left;"><?php echo $vouchers['description']; ?></td>
            <td class="model"></td>
            <td class="quantity"><input type="text" name="" value="1" size="1" disabled="disabled" />
              &nbsp;<a href="<?php echo $vouchers['remove']; ?>"><img src="catalog/view/theme/default/image/remove.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" /></a></td>
            <td class="price"><?php echo $vouchers['amount']; ?></td>
            <td class="total"><?php echo $vouchers['amount']; ?></td>
            <td class="status"><?php echo $product['stock']; ?>cc</td>
          </tr>
          <?php } ?>
        </tbody>
      </table>
      
      
      
       <div class="cart-total">
    <table id="total">
      <?php foreach ($totals as $total) { ?>
      <tr>
        <td width="570" class="right" ><b style="color:#000; "><?php echo $total['title']; ?>:</b></td>
        <td class="right" style="text-align:left;"><?php echo $total['text']; ?></td>
      </tr>
      <?php } ?>
    </table>
  </div>
  <div class="buttons cart">
    <div class="left"><a href="<?php echo $checkout; ?>" class="button2" style="font-weight: bolder; font-size: 20px; text-decoration: none"><?php echo $button_checkout; ?></a></div>
    <div class="left"><a href="<?php echo $continue; ?>" class="button2"><?php echo $button_shopping; ?></a></div>
    <div class="right"></div>
    
  </div>

  <table  border="0" class="comment_cart_tb">
      <tr>
    		<td class="comment_cart_tb_left"> 
      			Комментарии по заказу
    		</td>
    		<td class="comment_cart_tb_right" valign="top"></td>
  	 </tr>

    
    
  <tr>
    <td class="comment_cart_tb_left"> 
       <form action="" method="post" enctype="multipart/form-data"> 
     
         <textarea name="comment"  class="multinput cart"></textarea>
       </form>
       </td>
    
    <td class="comment_cart_tb_right" valign="baseline">
            <a href="<?php echo $checkout; ?>" class="button comment" ></a>
    </td>
  </tr>
</table>



<table  border="0" class="tovar_in_cart_tb">
 <form action="index.php?route=checkout/cart/add_model" name="addmodelform" method="post" enctype="multipart/form-data">
 <tr>
    <td class="tovar_in_cart_tb_left quick_kod_title"> 
      Быстрое добавление по коду
    </td>
    <td class="tovar_in_cart_tb_right" valign="top"> 
    </td>
  </tr>

  <tr>
    <td class="tovar_in_cart_tb_left"> 
         <input id="sdass" name="model_to_cart" type="text" class="input cart" placeholder="Введите коды товаров, через запятую" />
    </td>
    <td class="tovar_in_cart_tb_right"> 
        <a href="javascript: void(0);" onclick="$.post('index.php?route=checkout/cart/add_model',{model_to_cart:$('#sdass').val()},function(){window.location.reload();});" class="button grey"></a>
    </td>
  </tr>
  </form>
</table>     


  
  
  <div class="price cart">
  
  <div class="line1">

      <div class="left"></div>
      
        <div class="center">
     		<a onclick="saveCartToCsv()">Сохранить корзину в файл (формат CSV для Excel)</a>
        </div><!-- end center -->
        
  </div><!-- end line1 -->
  
  <script type="text/javascript">
  $(document).ready(function(){
  $("a.filecart").click(function(){
	  $("#uploadfile").show();
  });			
})   
  </script>
  
  
  <div class="line2">

      <div class="left"></div>
      
      <div class="center">
      	<a class="filecart" style="float:left">Загрузить корзину из файла</a>
        
        <div id="uploadfile" style="display:none; float:left; margin-left:10px;>
	  	<form name="forma" action="index.php?route=checkout/cart/loadCartCsv" method="post" enctype="multipart/form-data">
                    
                    <input name="formcsv" type="hidden" value="1">
                    <input class="csvsel" name="csv" type="file" value="">&nbsp;<input class="csvsubmit" type="submit" value="Загрузить" disabled="disabled">
					<input name="flaginfocsv" id="flag-csv-result" type="hidden" value="0">
        </form>
        </div><!-- end uploadfile-->
        </div>
  </div><!-- end line2-->

<script type="text/javascript">
    $(document).ready(function(){
        $("input.csvsel").click(function(){
            $("input.csvsubmit").removeAttr('disabled');
        });
    })
</script>
        
  <div class="line3">

      <div class="left"></div>
      
      <div class="center">
     		<a href="http://karbuk.ru/catalog.html" id="callback" >Скачать каталог товаров “Карбук”</a>
      </div>
  </div><!-- end line 3-->
  
  
    </div><!-- end price cart -->
    
    
    
    
</form>
</div>

<div id="dialog-form" title="Заказать каталог" style="display: none;" >
    <p class="validateTips"></p>
    <form>
    <fieldset style="text-align:left;">
        <label for="call_name">Имя<span class="required">*</span></label>
        <input type="text" name="call_name" id="call_name" class="ui-widget-content ui-corner-all" /><br /><br />
        <label for="call_phone">Телефон<span class="required">*</span></label>
        <input type="text" name="call_phone" id="call_phone" value="" class="ui-widget-content ui-corner-all" /><br /><br />
        <label for="call_company">Компания</label><span class="required">*</span></label>
        <input type="text" name="call_phone" id="call_company" value="" class="ui-widget-content ui-corner-all" /><br /><br />
        <label for="call_email">E-mail</label><span class="required">*</span></label>
        <input type="text" name="call_email" id="call_email" value="" class="ui-widget-content ui-corner-all" /><br /><br />
    </fieldset>
    </form>
</div>
 
  <?php echo $content_bottom; ?>
<script type="text/javascript"><!--
$('input[name=\'next\']').bind('change', function() {
	$('.cart-module > div').hide();
	
	$('#' + this.value).show();
});
//--></script>
<?php if ($shipping_status) { ?>
<script type="text/javascript"><!--
$('#button-quote').live('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/cart/quote',
		type: 'post',
		data: 'country_id=' + $('select[name=\'country_id\']').val() + '&zone_id=' + $('select[name=\'zone_id\']').val() + '&postcode=' + encodeURIComponent($('input[name=\'postcode\']').val()),
		dataType: 'json',		
		beforeSend: function() {
			$('#button-quote').attr('disabled', true);
			$('#button-quote').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('#button-quote').attr('disabled', false);
			$('.wait').remove();
		},		
		success: function(json) {
			$('.success, .warning, .attention, .error').remove();			
						
			if (json['error']) {
				if (json['error']['warning']) {
					$('#notification').html('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					
					$('.warning').fadeIn('slow');
					
					$('html, body').animate({ scrollTop: 0 }, 'slow'); 
				}	
							
				if (json['error']['country']) {
					$('select[name=\'country_id\']').after('<span class="error">' + json['error']['country'] + '</span>');
				}	
				
				if (json['error']['zone']) {
					$('select[name=\'zone_id\']').after('<span class="error">' + json['error']['zone'] + '</span>');
				}
				
				if (json['error']['postcode']) {
					$('input[name=\'postcode\']').after('<span class="error">' + json['error']['postcode'] + '</span>');
				}					
			}
			
			if (json['shipping_method']) {
				html  = '<h2><?php echo $text_shipping_method; ?></h2>';
				html += '<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">';
				html += '  <table class="radio">';
				
				for (i in json['shipping_method']) {
					html += '<tr>';
					html += '  <td colspan="3"><b>' + json['shipping_method'][i]['title'] + '</b></td>';
					html += '</tr>';
				
					if (!json['shipping_method'][i]['error']) {
						for (j in json['shipping_method'][i]['quote']) {
							html += '<tr class="highlight">';
							
							if (json['shipping_method'][i]['quote'][j]['code'] == '<?php echo $shipping_method; ?>') {
								html += '<td><input type="radio" name="shipping_method" value="' + json['shipping_method'][i]['quote'][j]['code'] + '" id="' + json['shipping_method'][i]['quote'][j]['code'] + '" checked="checked" /></td>';
							} else {
								html += '<td><input type="radio" name="shipping_method" value="' + json['shipping_method'][i]['quote'][j]['code'] + '" id="' + json['shipping_method'][i]['quote'][j]['code'] + '" /></td>';
							}
								
							html += '  <td><label for="' + json['shipping_method'][i]['quote'][j]['code'] + '">' + json['shipping_method'][i]['quote'][j]['title'] + '</label></td>';
							html += '  <td style="text-align: right;"><label for="' + json['shipping_method'][i]['quote'][j]['code'] + '">' + json['shipping_method'][i]['quote'][j]['text'] + '</label></td>';
							html += '</tr>';
						}		
					} else {
						html += '<tr>';
						html += '  <td colspan="3"><div class="error">' + json['shipping_method'][i]['error'] + '</div></td>';
						html += '</tr>';						
					}
				}
				
				html += '  </table>';
				html += '  <br />';
				html += '  <input type="hidden" name="next" value="shipping" />';
				
				<?php if ($shipping_method) { ?>
				html += '  <input type="submit" value="<?php echo $button_shipping; ?>" id="button-shipping" class="button" />';	
				<?php } else { ?>
				html += '  <input type="submit" value="<?php echo $button_shipping; ?>" id="button-shipping" class="button" disabled="disabled" />';	
				<?php } ?>
							
				html += '</form>';
				
				$.colorbox({
					overlayClose: true,
					opacity: 0.5,
					width: '600px',
					height: '400px',
					href: false,
					html: html
				});
				
				$('input[name=\'shipping_method\']').bind('change', function() {
					$('#button-shipping').attr('disabled', false);
				});
			}
		}
	});
});
//--></script> 
<script type="text/javascript"><!--
$('select[name=\'country_id\']').bind('change', function() {
	$.ajax({
		url: 'index.php?route=checkout/cart/country&country_id=' + this.value,
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

$('select[name=\'country_id\']').trigger('change');
//--></script>


<script type="text/javascript">
$(function() {
    // a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
    $( "#dialog:ui-dialog" ).dialog( "destroy" );

    var call_name = $( "#call_name" ),
        call_phone = $( "#call_phone" ),
        call_email = $( "#call_email" ),
        call_company = $( "#call_company" ),
        allFields = $( [] ).add( call_name ).add( call_phone ).add( call_company ).add( call_email ),
        tips = $( ".validateTips" );

    function updateTips( t ) {
        tips.text( t ).addClass( "ui-state-highlight" );
        setTimeout(function() {
            tips.removeClass( "ui-state-highlight");
        }, 500 );
    }

    function checkLength( o, n, min, max ) {
        if ( o.val().length > max || o.val().length < min ) {
            o.addClass( "ui-state-error" );
            updateTips( "Поле " + n + " должно иметь от " +
                min + " до " + max + " символов" );
            return false;
        } else {
            return true;
        }
    }

    function checkRegexp( o, regexp, n ) {
        if ( !( regexp.test( o.val() ) ) ) {
            o.addClass( "ui-state-error" );
            updateTips( n );
            return false;
        } else {
            return true;
        }
    }

    $( "#dialog-form" ).dialog({
        autoOpen: false,
        height: 350,
        width: 300,
        resizable: false,
        modal: true,
        buttons: {
            "OK": function() {
                var bValid = true;
                allFields.removeClass( "ui-state-error" );

                bValid = bValid && checkLength( call_name, "Имя", 3, 20 );
                bValid = bValid && checkLength( call_phone, "Телефон", 5, 20 );
                bValid = bValid && checkLength( call_company, "Компания", 2, 50 );
                bValid = bValid && checkLength( call_email, "E-mail", 3, 20 );



                if ( bValid ) {
                    $.ajax({
                        type: 'POST',
                        url: 'index.php?route=checkout/cart/callback',
                        data: 'call_name=' + encodeURIComponent($('#call_name').val()) + '&call_phone=' + encodeURIComponent($('#call_phone').val()) + '&call_company=' + encodeURIComponent($('#call_company').val()) + '&call_email=' + encodeURIComponent($('#call_email').val()),
                        dataType: 'json',
                        beforeSend: function() {
                            $('.validateTips').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
                        },
                        complete: function() {
                            $('.wait').remove();
                        },
                        success: function(json) {
                            tips.text(json.msg);
                            setTimeout(function() {
                                $( "#dialog-form" ).dialog( "close" );
                            }, 1500 );
                        }
                    });
                }
            },
            Cancel: function() {
                $( this ).dialog( "close" );
            }
        },
        close: function() {
            allFields.val( "" ).removeClass( "ui-state-error" );
        }
    });

    $( "#callback" ).click(function() {
            $( "#dialog-form" ).dialog( "open" );
            $( ".validateTips" ).html('');
            return false;
    });
});
</script>

<?php } ?></div></div>
<?php echo $footer; ?>