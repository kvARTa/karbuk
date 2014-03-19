<?php echo $header; ?>
<?php echo $column_left; ?>
<div id="content">

<div class="box-heading"> <h1><?php echo $heading_title; ?></h1> </div>

<div class="box-content">

<?php echo $content_top; ?>


    <div class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
        <?php } ?>
    </div>
    
    <?php if (isset($error_warning)) { ?> 
        <?php if ($error_warning) { ?>
            <div class="warning"><?php echo $error_warning; ?></div>
        <?php } ?>
    <?php } ?>
    
