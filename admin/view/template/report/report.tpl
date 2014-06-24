<?php echo $header; ?>
<div id="content">
    <div class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
        <?php } ?>
    </div>
    <div class="box">
        <div class="heading">
            <h1><img src="view/image/report.png" alt="" /> <?php echo $heading_title; ?></h1>
        </div>
        <div class="content">
            <table class="list">
                <thead>
                <tr>
                    <td class="left">Код</td>
                    <td class="left">Название</td>
                </tr>
                </thead>
                <tbody>
                <?php  if ($items) { ?>
                <?php  foreach ($items as $name => $group) { ?>
                <tr>
                    <td colspan="2"><?php echo $name; ?></td>
                </tr>
                <?php foreach($group as $item) { ?>
                <tr>
                    <td class="left"><?php echo $item['id']; ?></td>
                    <td class="left"><?php echo $item['name']; ?></td>
                </tr>
                <?php } ?>
                <?php  } ?>
                <?php  } else { ?>
                <tr>
                    <td class="center" colspan="4">Нет результатов</td>
                </tr>
                <?php  } ?>
                </tbody>
            </table>
        </div>
    </div>
</div>
<?php echo $footer; ?>