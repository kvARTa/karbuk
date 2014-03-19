<?php echo $header; ?>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><div class="box-heading"><?php echo $heading_title; ?>
</div>
<div class="box-content"><?php echo $content_top; ?>
  <div class="breadcrumb">
   <?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
        <?php echo $breadcrumb['separator']; ?><?php if($i+1<count($breadcrumbs)) { ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a> <?php } else { ?><?php echo $breadcrumb['text']; ?><?php } ?>
        <?php } ?>
  </div>
  <h1><?php echo $heading_title; ?></h1>
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
    <h2><?php echo $text_your_details; ?></h2>
    <div class="content">
      <table class="form">
        <tr>
          <td><?php echo $entry_login; ?></td>
          <td><?php echo $login; ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_firstname; ?></td>
          <td><input type="text" name="firstname" value="<?php echo $firstname; ?>" />
            <?php if ($error_firstname) { ?>
            <span class="error"><?php echo $error_firstname; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><?php echo $entry_lastname; ?></td>
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
        <tr>
          <td><span class="required">*</span> <?php echo $entry_company ?></td>
          <td><input type="text" name="company" value="<?php echo $company; ?>" />
            <?php if ($error_company) { ?>
            <span class="error"><?php echo $error_company; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_inn ?></td>
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
        <tr>
          <td><?php echo $entry_manager; ?></td>
          <td><input type="text" disabled="disabled" name="manager" value="<?php echo $manager; ?>" /></td>
        </tr>
      </table>
    </div>
    <div class="buttons">
      <div class="left"><a href="<?php echo $back; ?>" class="button"><?php echo $button_back; ?></a></div>
      <div class="right">
        <input type="submit" value="<?php echo $button_continue; ?>" class="button" />
      </div>
    </div>
  </form>
  <?php echo $content_bottom; ?></div>
</div><?php echo $footer; ?>