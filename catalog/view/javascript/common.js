$(document).ready(function() {
	/* Search */
	$('.button-search').bind('click', function() {
		url = $('base').attr('href') + 'index.php?route=product/search';

		var filter_name = $('input[name=\'filter_name\']').attr('value');

		if (filter_name) {
			url += '&filter_name=' + encodeURIComponent(filter_name);
		}

		location = url;
	});

	$('#header input[name=\'filter_name\']').bind('keydown', function(e) {
		if (e.keyCode == 13) {
			url = $('base').attr('href') + 'index.php?route=product/search';

			var filter_name = $('input[name=\'filter_name\']').attr('value');

			if (filter_name) {
				url += '&filter_name=' + encodeURIComponent(filter_name);
			}

			location = url;
		}
	});

	/* Ajax Cart */
	$('#cart > .heading a').live('click', function() {
		$('#cart').addClass('active');

		$('#cart').load('index.php?route=module/cart #cart > *');

		$('#cart').live('mouseleave', function() {
			$(this).removeClass('active');
		});
	});

	/* Mega Menu */





	$('#menu ul > li > a + div').each(function(index, element) {
		// IE6 & IE7 Fixes
		if ($.browser.msie && ($.browser.version == 7 || $.browser.version == 6)) {
			var category = $(element).find('a');
			var columns = $(element).find('ul').length;


			$(element).find('ul').css('float', 'left');
		}






		var menu = $('#menu').offset();
		var dropdown = $(this).parent().offset();

		i = (dropdown.left + $(this).outerWidth()) - (menu.left + $('#menu').outerWidth());

		if (i > 0) {
			//alert((dropdown.left + $(this).outerWidth()));
			//alert((menu.left + $('#menu').outerWidth()));
			$(this).css('margin-left', '-' + (i + 0) + 'px');
		}
	});

	// IE6 & IE7 Fixes
	if ($.browser.msie) {
		if ($.browser.version <= 6) {
			$('#column-left + #column-right + #content, #column-left + #content').css('margin-left', '195px');

			$('#column-right + #content').css('margin-right', '195px');

			$('.box-category ul li a.active + ul').css('display', 'block');
		}

		if ($.browser.version <= 7) {
			$('#menu > ul > li').bind('mouseover', function() {
				$(this).addClass('active');
			});

			$('#menu > ul > li').bind('mouseout', function() {
				$(this).removeClass('active');
			});
		}
	}

	$('.success img, .warning img, .attention img, .information img').live('click', function() {
		$(this).parent().fadeOut('slow', function() {
			$(this).remove();
		});
	});
});

function getURLVar(urlVarName) {
	var urlHalves = String(document.location).toLowerCase().split('?');
	var urlVarValue = '';

	if (urlHalves[1]) {
		var urlVars = urlHalves[1].split('&');

		for (var i = 0; i <= (urlVars.length); i++) {
			if (urlVars[i]) {
				var urlVarPair = urlVars[i].split('=');

				if (urlVarPair[0] && urlVarPair[0] == urlVarName.toLowerCase()) {
					urlVarValue = urlVarPair[1];
				}
			}
		}
	}

	return urlVarValue;
}





function addToCart(product_id, quantity) {
	quantity = typeof(quantity) != 'undefined' ? quantity : 2;
//alert (quantity);
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: 'product_id=' + product_id + '&quantity=' + quantity,
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, .information, .error').remove();




			if (json['redirect']) {
				location = json['redirect'];
			}

			if (json['success']) {
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
						
				$('.success').fadeIn('slow');
				
				//$('.checkout-heading a').remove();

				$('.left_cart_empty').remove();
				$('.left_cart').remove();
				$('#cart').prepend('<a href="index.php?route=checkout/cart"><div class="left_cart" >  </div></a>');


				$('#cart-total').html(json['total']);

				//$('html, body').animate({ scrollTop: 0 }, 'slow');
			}
		}
	});
}
function addToWishList(product_id) {
	$.ajax({
		url: 'index.php?route=account/wishlist/add',
		type: 'post',
		data: 'product_id=' + product_id,
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, .information').remove();

			if (json['success']) {
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');

				$('.success').fadeIn('slow');

				$('#wishlist-total').html(json['total']);

				if(json['result'] == 'add'){
					$('#wishlist'+json['product_id']+' .wish').hide();
					$('#wishlist'+json['product_id']+' .gowish').show();
					$('#wishlist'+json['product_id']+' input').attr('checked',true);
				}else{
					$('#wishlist'+json['product_id']+' .wish').show();
					$('#wishlist'+json['product_id']+' .gowish').hide();
					$('#wishlist'+json['product_id']+' input').attr('checked',false);
				}

				//$('html, body').animate({ scrollTop: 0 }, 'slow');
			}
		}
	});
}

function addToCompare(product_id) {
	$.ajax({
		url: 'index.php?route=product/compare/add',
		type: 'post',
		data: 'product_id=' + product_id,
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, .information').remove();

			if (json['success']) {
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');

				$('.success').fadeIn('slow');

				$('#compare-total').html(json['total']);

				if(json['result'] == 'add'){
					$('#compare'+json['product_id']+' .comp').hide();
					$('#compare'+json['product_id']+' .gocomp').show();
					$('#compare'+json['product_id']+' input').attr('checked',true);
				}else{
					$('#compare'+json['product_id']+' .comp').show();
					$('#compare'+json['product_id']+' .gocomp').hide();
					$('#compare'+json['product_id']+' input').attr('checked',false);
				}

				//$('html, body').animate({ scrollTop: 0 }, 'slow');
			}
		}
	});
}