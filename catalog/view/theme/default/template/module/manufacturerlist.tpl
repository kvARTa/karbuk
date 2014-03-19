<div class="box">
	<style type="text/css">
		.box-manufacturer > div {
			display: inline-block;
			margin-bottom: 20px;
			margin-right: 20px;
			vertical-align: top;
		}
	</style>
	<div class="box-heading"><?php echo $heading_title; ?></div>
	<div class="box-content">
		<div class="box-manufacturer">
			<?php foreach($manufacturers as $manufacturer) { ?>
			<div>
				<?php if($manufacturer['thumb']) { ?>
				<div class="image"><a data="<?php echo $manufacturer['manufacturer_id']; ?>" href="<?php echo $manufacturer['href']; ?>"><img
						src="<?php echo $manufacturer['thumb']; ?>" alt="<?php echo $manufacturer['name']; ?>"/></a></div>
				<?php } ?>
				<div class="name"><a data="<?php echo $manufacturer['manufacturer_id']; ?>" href="<?php echo $manufacturer['href']; ?>"><?php echo $manufacturer['name']; ?></a>
				</div>
			</div>
			<?php } ?>
		</div>
	</div>
</div>
