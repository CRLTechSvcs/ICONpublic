<?php

	// RETRIEVE PUBLICATION ID

		if (!empty($_GET['pub_id'])) {$pub_id = str_replace('%20', '', $_GET['pub_id']);}

?>
<!DOCTYPE html>
<!--[if IE 8]><html class="no-js lt-ie9" lang="en"><![endif]-->
<!--[if gt IE 8]><!--><html class="no-js" lang="en"><!--<![endif]-->
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width" />
		<title>International Coalition on Newspapers (ICON)</title>
		<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
		<link rel="stylesheet" href="stylesheets/foundation.min.css">
		<link rel="stylesheet" href="stylesheets/app.css">
		<link rel="stylesheet" href="stylesheets/icon.css">
	</head>
	<body>
		<div class="row header">
<!-- CRL LOGO -->
			<div class="six columns">
				<a href="http://www.crl.edu"><img src="images/logo.gif" /></a>
			</div>
<!-- ICON TEXT -->
			<div class="six columns">
				<h1 class="iconTitle iconTitleLong">International Coalition on Newspapers</h1>
				<h1 class="iconTitle iconTitleShort">ICON</h1>
			</div>
		</div>
		<div class="row contentArea">
<!-- MAIN CONTENT AREA -->
			<div class="nine columns mainContentArea">
				<!-- <br/><div align="center"><img src="images/temp_main_content.jpg" width="591" /></div> -->
				<div id="content_wrapper">
					<!--Hidden pagination controls-->
					<input type='hidden' id='current_page' />
					<input type='hidden' id='show_per_page' />
					<div id="left_navbar">
						<div id="selection_control_wrapper">
							<div id="loading-calendar" class="loading-calendar-visible">
								<p></p>
							</div>
							<div id="inner_selection_control_wrapper">
								<select id="year_option" name="year_option" ></select>
								<label id="select_year_label" class="calendar_label">Select year from dropdown or by clicking on a bar below:</label><br/>
								<ul class="timeline">
									<!--timeline container-->
									<li id="li_1690s">
										<span class="label"><a>1690s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>1700s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>1710s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>1720s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>1730s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>1740s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>1750s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>1760s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>1770s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>1780s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>1790s</a></span>
										<ul></ul>
									</li>
									<li id="li_post_1790s">
										<span class="label"></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>1800s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>1810s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>1820s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>1830s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>1840s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>1850s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>1860s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>1870s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>1880s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label" ><a>1890s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label" ></span>
										<ul></ul>
									</li>
									<li>
										<span class="label" ></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>1900s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>1910s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>1920s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>1930s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>1940s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>1950s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>1960s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>1970s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>1980s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>1990s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>2000s</a></span>
										<ul></ul>
									</li>
									<li>
										<span class="label"><a>2010s</a></span>
										<ul></ul>
									</li>
								</ul>
								<div class="six columns">
									<div id="month_year_container">
										<label id="select_month_label" class="calendar_label">Select month by clicking on a box below:</label>
										<div id="month_control_wrapper">
											<div class="month_box" id="jan">JAN</div>
											<div class="month_box" id="feb">FEB</div>
											<div class="month_box" id="mar">MAR</div>
											<div class="month_box" id="apr">APR</div>
											<div class="month_box" id="may">MAY</div>
											<div class="month_box" id="jun">JUN</div>
											<div class="month_box" id="jul">JUL</div>
											<!--<div class="month_box" id="aug">AUG</div><br />-->
											<div class="month_box" id="aug">AUG</div>
											<div class="month_box" id="sep">SEP</div>
											<div class="month_box" id="oct">OCT</div>
											<div class="month_box" id="nov">NOV</div>
											<div class="month_box" id="dec">DEC</div>
										</div>
									</div>
								</div>
								<div class="six columns">
									<label id="select_day_label" class="calendar_label">Select day by clicking on a calendar link:</label>
									<div type="text" id="datepicker_container">
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
	<!-- TAB HEADERS -->
				<div class="twelve columns">
				<dl id="pub_tabs" class="tabs four-up contained">
					<dd class="active"><a href="#issueDate">Issue Date</a></dd>
					<dd><a href="#repositories">Repositories</a></dd>
					<dd><a href="#formats">Formats</a></dd>
					<dd><a href="#geneology">Geneology</a></dd>
				</dl>
				<ul class="tabs-content contained">
	<!-- ISSUE DATE TAB -->
					<li id="issueDateTab" class="active">
						<div id="issue_date_display"></div>
						<div id="issue_info_display">
							<div id="loading-issue-info" class="loading-issue-info-invisible">
								<div class="loading"><img src="images/loading.gif" style="vertical-align: basline;" /> Loading issues...</div>
							</div>
							<div id="inner_issue_info_display"></div>
						</div>
					</li>
	<!-- REPOSITORIES TAB -->
					<li id="repositoriesTab">
						<?php echo 'PUB ID: ' . $pub_id; ?>
					</li>
	<!-- FORMATS TAB -->
					<li id="formatsTab">
						<?php echo 'PUB ID: ' . $pub_id; ?>
					</li>
	<!-- GENEOLOGY TAB -->
					<li id="geneologyTab">
						<?php echo 'PUB ID: ' . $pub_id; ?>
					</li>
				</ul>
				</div>
			</div>
<!-- RIGHT CONTENT AREA -->
			<div class="three columns rightContentArea">
				<h6>Title Information</h6>
				<div class="panel">
					<?php echo 'PUB ID: ' . $pub_id; ?>
				</div>
				<h6>Genealogy Of Paper</h6>
				<div class="panel">
					<a class="more" href="javascript:function x() {return false;}">Learn More &#187;</a>
					<!--<?php echo 'PUB ID: ' . $pub_id; ?>-->
				</div>
				<h6>Profiles Of All Archiving</h6>
				<div class="panel">
					<a class="more" href="javascript:function x() {return false;}">Learn More &#187;</a>
					<!--<?php echo 'PUB ID: ' . $pub_id; ?>-->
				</div>
				<h6>Geneology Of Preservation Activities</h6>
				<div class="panel">
					<a class="more" href="javascript:function x() {return false;}">Learn More &#187;</a>
					<!--<?php echo 'PUB ID: ' . $pub_id; ?>-->
				</div>
			</div>
		</div>
<!-- FOOTER -->
		<div class="row">
			<div id="footer">
				<div id="footer_bar"></div>
				<div id="footer_container">
					<div id="footer_title"><a href="http://www.crl.edu" target="_blank">Center for Research Libraries</a></div>
					<div id="subfooter">
						<ul id="metanav">
							<li><a href="http://www.crl.edu" target="_blank">www.crl.edu</a></li>
						</ul>
						<div id="address">
							<div>
								6050 S. Kenwood Avenue<br/>
								Chicago, IL 60637-2804 USA
							</div>
							<div>
								Phone: (800) 621-6044 <em>or</em> (773) 955-4545<br/>
								Fax:  (773) 955-4339
							</div>
						</div>
						<div id="footer_nav">
							<ul class="left">
								<li><a href="http://www.crl.edu/about/" target="_blank">About CRL</a></li>
								<li><a href="http://www.crl.edu/membership/">Membership</a></li>
								<li><a href="http://www.crl.edu/collaborations" target="_blank">Collaborations</a></li>
							</ul>
							<ul class="right">
								<li><a href="http://www.crl.edu/collections/" target="_blank">Collections</a></li>
								<li><a href="http://www.crl.edu/services/" target="_blank">Services</a></li>
								<li><a href="http://www.crl.edu/archiving-preservation/" target="_blank">Archiving &amp; Preservation</a></li>
							</ul>
						</div>
						<div style="clear:both;"></div>
					</div>
				</div>
			</div>
		</div>

		<script src="javascripts/json2.js"></script>
		<script src="javascripts/foundation.min.js"></script>
		<script src="javascripts/jquery-1.7.1.min.js"></script>
		<script src="javascripts/jquery-ui-1.8.9.custom.min.js"></script>
		<script src="javascripts/initialize_variables.js"></script>
		<script src="javascripts/app.js"></script>

<!--
	AJE 2013-02-25 18:18:10
	- something like this is needed for the scripts to work
	- used to include headTagContents.php
-->
<?php include "headTagPiece.php"; ?>
<?php include "sidebarDivContents.php"; ?>
	<script src="javascripts/calendar_selection_functions.js"></script>
	</body>
</html>