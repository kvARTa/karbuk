<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content">
<div class="box-heading"><?php echo $heading_title; ?>
</div>
<div class="box-content">
<?php echo $content_top; ?>
  <div class="breadcrumb">
   <?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
        <?php echo $breadcrumb['separator']; ?><?php if($i+1<count($breadcrumbs)) { ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a> <?php } else { ?><?php echo $breadcrumb['text']; ?><?php } ?>
        <?php } ?>
  </div>
  
  <div class="content"><?php echo $text_error; ?></div>
  
  <?if (isset($tovar_in_cart)) { ?>
	<div class="cart-info">
	<table  border="0" class="tovar_in_cart_tb">
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
	</table>
	</div>


    <script type="text/javascript">
        $(document).ready(function(){
            $("a.filecart").click(function(){
                $("#uploadfile").show();
            });
        })
    </script>




	<div class="price cart emptycart">

        <div class="line2">

            <div class="left"></div>

            <div class="center">
                <a class="filecart" style="float:left">Загрузить корзину из файла</a>

                <div id="uploadfile" style="display:none; float:left; margin-left:10px;">
	  	<form name="forma" action="index.php?route=checkout/cart/loadCartCsv" method="post" enctype="multipart/form-data">

                <input name="formcsv" type="hidden" value="1">
                <input class="csvsel" name="filecsv" type="file" value="">&nbsp;<input class="csvsubmit" type="submit" value="Загрузить" disabled="disabled">
                <input name="flaginfocsv" id="flag-csv-result" type="hidden" value="0">
                </form>
            </div><!-- end uploadfile-->
        </div>

        <div class="right">
            ( <a href="/csv_example/cart.csv" class="primer_faila"><span>Скачать пример</span></a> )
        </div><!-- end right -->


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
            <a href="http://karbuk.ru/index.php?route=information/information&information_id=10" id="callback" >Скачать каталог товаров “Карбук”</a>
        </div>
    </div><!-- end line 3-->


    
  </div><!-- end price cart -->



    <? } ?>
  <div class="buttons">
    <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
  </div>
  <?php echo $content_bottom; ?></div></div>
<?php echo $footer; ?>