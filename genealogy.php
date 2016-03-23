<?php
		/* AJE 2012-11-21
			genealogy.php:
				- inside #page after calendar_selection_controls;
				- target for output from ./scripts/genealogy_functions.js
			 CFJ 2013-06-19
			  - Full page version of ICON genealogy display
			  - Target of calendar.php --> Genealogy tab --> 'Open in a new window' link
		*/
?>

<!--<div id="genealogy_header" class="pub_data_header">
	Publication genealogy: <!--change genealogy_header.padding-right if change caption-->
<!--</div>
<div id="genealogy_list" class="pub_data_content">-->
	<!--tag rewritten when script output runs-->
<!--</div>-->

<!DOCTYPE html>
<!--[if IE 8]><html class="no-js lt-ie9" lang="en"><![endif]-->
<!--[if gt IE 8]><!--><html class="no-js" lang="en"><!--<![endif]-->
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width" />

    <meta http-equiv="cache-control" content="max-age=0" />
    <meta http-equiv="cache-control" content="no-cache" />
    <meta http-equiv="expires" content="0" />
    <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
    <meta http-equiv="pragma" content="no-cache" />

		<title>International Coalition on Newspapers (ICON)</title>
		<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
		<link rel="stylesheet" href="stylesheets/foundation.min.css">
		<link rel="stylesheet" href="stylesheets/icon.css">
		<style type="text/css">
			/* -----------------------------------------
			  STYLES UNIQUE TO THIS PAGE
			--------------------------------------------*/
			.mainContentArea {
				background-color: #FFFFFF;
			}
		</style>
	</head>
	<body>
		<div class="row header" style="margin: 20px auto;">
<!-- CRL LOGO -->
			<div class="six columns" style="padding-left: 0px;">
				<a href="http://www.crl.edu"><img src="images/CRL_logo.png" /></a>
			</div>
<!-- ICON TEXT -->
			<div class="six columns" style="padding-right: 0px;">
				<h1 class="iconTitle iconTitleLong">International Coalition on Newspapers</h1>
				<h1 class="iconTitle iconTitleShort">ICON</h1>
			</div>
		</div>
		<div class="row contentArea">
<!-- MAIN CONTENT AREA -->
			<div class="twelve columns mainContentArea">
				<!-- <br/><div align="center"><img src="images/temp_main_content.jpg" width="591" /></div> -->
				<div id="content_wrapper">
					<div class="row">
						<div class="twelve columns" id="genealogy_container" style="margin-bottom: 15px;">
						</div>
					</div>
				</div>
			</div>
		</div>

<!-- FOOTER -->
<?php include("footerCRL.html"); ?>

<?php include("help_sort_button.php"); ?>

<?php include("footer_script_tags.php"); ?>

<?php include "set_selectedPubId.php"; ?>
<script>
	$(function() {
		$.get("get_genealogy_info.php?selectedPubId=" + selectedPubId + '&new_win=true', displayGenealogyVisualization);
	});
</script>
<script src="javascripts/collapsible_tree_functions.js"></script>

	</body>
</html>