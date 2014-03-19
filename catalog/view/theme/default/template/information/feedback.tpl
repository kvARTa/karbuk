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
<div class="anons">
  <p>
  С целью сделать функционирование нашей компании безупречным, квалифицированные сотрудники готовы активно обсуждать нюансы нашей работы с вами. Созданный подраздел «Обратная связь» позволяет каждому озвучивать свое мнение. Компетентные менеджеры профессионально отвечают на вопросы любого рода либо реагируют на озвученное замечание. Будьте уверены, пристальное внимание априори будет уделено каждому сообщению. 
</p>
<p>
Грамотно организованная обратная связь с клиентами предоставляет полноценные возможности для понимания и проведения глубокого анализа происходящих бизнес-процессов компании, последующего улучшения сервисных условий. На динамичном рынке сложно назвать более эффективный и полезный инструментарий, нежели этот. Именно «Обратная связь» предоставляет собой высокоэффективный метод получения требуемой актуальной информации о действительной ситуации. 
</p>
<p>
Помимо этого, Клиент, который при возникновении определенных вопросов безоговорочно получил оперативную помощь специалиста, с максимальной вероятностью обратится к нам неоднократно в будущем, что полностью соответствует нашему основному приоритету - полноценному удовлетворению Ваших требований.
  </p>
</div>  
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
    <!-- <h2><?php echo $text_contact; ?></h2> -->
    <div class="content">

    <b><?php echo $entry_subj; ?></b><br />
    <select name ="subj">
        <option value='0'>Выберите тему сообщения...</option>
        <?
        foreach($messages as $k =>$m){
            $selected = ($k == $subj)?'selected':'';
        ?>
            <option value='<?=$k?>' <?=$selected?>><?=$m['text']?></option>    
        <?
        }
        ?>
    </select>    
    <br />
    <?php if ($error_subj) { ?>
    <span class="error"><?php echo $error_subj; ?></span>
    <?php } ?>
    <br />    

    <b><?php echo $entry_name; ?></b><br />
    <input type="text" name="name" value="<?php echo $name; ?>" />
    <br />
    <?php if ($error_name) { ?>
    <span class="error"><?php echo $error_name; ?></span>
    <?php } ?>
    <br />

    <b><?php echo $entry_city; ?></b><br />
    <input type="text" name="city" value="<?php echo $city; ?>" />
    <br />
    <?php if ($error_city) { ?>
    <span class="error"><?php echo $error_city; ?></span>
    <?php } ?>
    <br />

    <b><?php echo $entry_company; ?></b><br />
    <input type="text" name="company" value="<?php echo $company; ?>" />
    <br />  

    <b><?php echo $entry_enquiry; ?></b><br />
    <textarea name="enquiry" cols="40" rows="10" style="width: 99%;"><?php echo $enquiry; ?></textarea>
    <br />
    <?php if ($error_enquiry) { ?>
    <span class="error"><?php echo $error_enquiry; ?></span>
    <?php } ?>
    <br />
   

    <?
    if(false){
    ?>
        <b><?php echo $entry_rating; ?></b> <span><?php echo $entry_bad; ?></span>&nbsp;
        <input type="radio" name="rating" value="1" />
        &nbsp;
        <input type="radio" name="rating" value="2" />
        &nbsp;
        <input type="radio" name="rating" value="3" />
        &nbsp;
        <input type="radio" name="rating" value="4" />
        &nbsp;
        <input type="radio" name="rating" value="5" />
        &nbsp;<span><?php echo $entry_good; ?></span><br />
        <br />
    <?}?>        
    <b><?php echo $entry_captcha; ?></b><br />
    <input type="text" name="captcha" value="<?php echo $captcha; ?>" />
    <br />
    <img src="index.php?route=information/contact/captcha" alt="" />
    <?php if ($error_captcha) { ?>
    <span class="error"><?php echo $error_captcha; ?></span>
    <?php } ?>
    <br/>

    <b><?php echo $entry_email; ?></b><br />
    <input type="text" name="email" value="<?php echo $email; ?>" />
    <br />
    <?php if ($error_email) { ?>
    <span class="error"><?php echo $error_email; ?></span>
    <?php } ?>
    <br />
     <b><?php echo $entry_phone; ?></b><br />
    <input type="text" name="phone" value="<?php echo $phone; ?>" />
    <br />
    <?php if ($error_phone) { ?>
    <span class="error"><?php echo $error_phone; ?></span>
    <?php } ?>
    <br />
    </div>
    <div class="buttons">
      <div class="right"><input type="submit" value="<?php echo $button_continue; ?>" class="button" /></div>
    </div>
  </form>
  <?php echo $content_bottom; ?></div></div>
<?php echo $footer; ?>