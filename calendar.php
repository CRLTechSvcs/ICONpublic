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

    <meta http-equiv="cache-control" content="max-age=0" />
    <meta http-equiv="cache-control" content="no-cache" />
    <meta http-equiv="expires" content="0" />
    <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
    <meta http-equiv="pragma" content="no-cache" />

		<title>ICON - Select issue date</title>
		<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
		<link rel="stylesheet" href="stylesheets/foundation.min.css">
		<link rel="stylesheet" href="stylesheets/app.css">
		<link rel="stylesheet" href="stylesheets/icon.css">
		<link rel="stylesheet" href="stylesheets/D3_SVG.css">

		<!--https://www.google.com/jsapi is needed for Google Charts API-->
		<script src="https://www.google.com/jsapi"></script>
		<!--CRL versions of calls to Google Charts API are in next script: -->
		<script src="javascripts/googleChartsAPIfunctions.js"></script>



	</head>
	<body>
		<div class="row header" style="margin-top: 20px; margin-bottom: 20px;">
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
			<div class="nine columns mainContentArea">
				<!-- <br/><div align="center"><img src="images/temp_main_content.jpg" width="591" /></div> -->

				<div class="row">
					<div class="twelve columns">
				<div id="content_wrapper">
					<!--Hidden pagination controls-->
					<input type='hidden' id='current_page' />
					<input type='hidden' id='show_per_page' />
					<div id="left_navbar">
						<div id="selection_control_wrapper">
							<div class="row">
							  <?php include 'new_search_container.php'; ?>
							</div>
							<div class="row">
								<div class="twelve columns centered" id="title_location_container">
									<div class="row">
										<div class="twelve columns" id="title_location">
											<div id="title_container">
												<span id="title_span"></span>
												<span id="more_span">&nbsp;&nbsp;<a id="more_link" href="javascript:;">more ...</a></span>
											</div>
											<div id="location_container"></div>
											<div id="title_info_container"></div>
										</div>
									</div>
								</div>
							</div>
							<!--
							<div id="loading-calendar" class="loading-calendar-visible">
								<p></p>
							</div>
							-->
							<div id="inner_selection_control_wrapper">
								<!--
								<div class="row">
									<div class="twelve columns">
										<label id="timeline_label">TIMELINE</label>
									</div>
								</div>
								-->
								<div class="row">
									<div class="one column offset-by-one" id="year_option_container">
										<select id="year_option" name="year_option" ></select>
									</div>
									<div class="four columns offset-by-one">
										<div id="month_year_container">
											<div id="month_control_wrapper">
												<div class="month_box" id="jan">JAN</div>
												<div class="month_box" id="feb">FEB</div>
												<div class="month_box" id="mar">MAR</div>
												<div class="month_box" id="apr">APR</div>
												<div class="month_box" id="may">MAY</div>
												<div class="month_box" id="jun">JUN</div>
												<div class="month_box" id="jul">JUL</div>
												<div class="month_box" id="aug">AUG</div>
												<div class="month_box" id="sep">SEP</div>
												<div class="month_box" id="oct">OCT</div>
												<div class="month_box" id="nov">NOV</div>
												<div class="month_box" id="dec">DEC</div>
											</div>

										</div><!--#month_year_container-->
									</div>
									<div class="five columns end">
										<div type="text" id="datepicker_container">
										</div>

                    <div id="datepicker_help_container" style="display: block;">
                    <a href="#" id="datepicker_help_button" class="button" data-reveal-id="datepicker_color_key"><img src="images/sage_question_mark.png" /></a>
                    </div>

									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				</div>
				</div>


	<!-- TAB HEADERS -->
				<div class="row" id="tab_container">
					<div class="twelve columns">
<!--AJE 2014-01-17 pub_tabs elements get click functions in calendar_selection_functions.js-->
					<dl id="pub_tabs" class="tabs four-up contained">
						<dd id="issue_info_tab" class="active"><a href="#issueDate">Issue Information</a></dd>
						<dd id="organizations_tab"><a href="#organizations">Organizations</a></dd>
						<dd id="formats_tab"><a href="#formats">Formats</a></dd>
						<dd id="genealogy_tab"><!--AJE 2014-01-14 PER AMY HIDE GENEALOGY FOR LIVE SITE <a href="#genealogy">Genealogy</a>--></dd>
					</dl>
					<ul class="tabs-content contained">
		<!-- ISSUE DATE TAB -->
						<li id="issueDateTab" class="active">
							<div class="row">
								<div class="twelve columns">
										<div id="loading-calendar" class="loading-calendar-visible">
											<p></p>
										</div>
										<div id="issue_date_header">
										</div>
										<div id="breadcrumb_container">
											<a class="breadcrumb" href="" onclick="displayFilterLinks(); return false;">Back to filter list</a>
										</div>
								</div>
							</div>
							<div id="issue_info_display" class="row">
								<div id="loading-issue-info" class="loading-issue-info-invisible">
									<div class="loading">Loading issue information for this publication date . . .<img src="images/loading_issue_info.gif" style="vertical-align: baseline;" /></div>
								</div>
								<div id="inner_issue_info_display" class="eleven columns centered">
									<div class="row">
										<div class="org_info_container twelve columns">
										</div>
									</div>
								</div>
							</div>
						</li>
		<!-- ORGANIZATIONS TAB -->
						<li id="organizationsTab">
							<div class="row">
								<div class="twelve columns">
									<div id="organizations_header">
										Organizations holding any date of this publication:<!--change organizations_header.padding-right if change caption-->
									</div>
								</div>
							</div>
								<div id="org_display">
									<div id="loading-organization-info" class="loading-organization-info-invisible">
									<div class="loading">Loading all organizations for this publication . . . <img style="vertical-align: baseline;" src="images/loading_organizations.gif"></div>
									</div>
                  <div id="orgs_chart_canvas_tab">
                    <!--AJE 2013-11-11
                    content added by Google Charts API script-->
                  </div>
									<div id="organizations_list" class="pub_data_content">
									<!--tag rewritten when script output runs-->
								</div>
							</div>
						</li>
		<!-- FORMATS TAB -->
						<li id="formatsTab">
							<div class="row">
								<div class="twelve columns">
									<div id="formats_header">
										Formats held for any date of this publication: <!--change formats_header.padding-right if change caption-->
									</div>
								</div>
							</div>
								<div id="format_display">
									<div id="loading-format-info" class="loading-format-info-invisible">
									  <div class="loading">Loading all formats for this publication . . . <img style="vertical-align: baseline;" src="images/loading_formats.gif"></div>
									</div>
                  <div id="formats_chart_canvas_tab">
                    <!--AJE 2013-11-11
                    content added by Google Charts API script-->
                  </div>
									<div id="formats_list" class="pub_data_content">
									<!--tag rewritten when script output runs-->
								  </div>
							</div>
						</li>
		<!-- GENEALOGY TAB -->
						<li id="genealogyTab">
							<!--
								CFJ 2013-05-29 17:22:40
								- If ICON database contains genealogy info for this pub_id, genealogy tab will be dynamically populated
								- with a title history visualization.  If not, a 'no genealogy info' message will be displayed.

								AJE 2014-09-24 this was disabled a year ago:
								  calendar_selection_functions has function populateIssueCounts() with calls to get_genealogy_info.php
							-->
						</li>
					</ul>
					</div>
				</div>



			</div><!-- end class="nine columns mainContentArea"-->
<!-- RIGHT CONTENT AREA -->
<?php
  include "sidebarTimeline.php";
?>

		</div><!--end class="row contentArea"-->


<!-- FOOTER -->
<?php
  include("footerCRL.html");

  include("help_selection_timeline.php");
  include("help_selection_orgs_chart.php");
  include("help_selection_formats_chart.php");
  include("help_selection_collections_chart.php");
  include("help_selection_datepicker_color_key.php");

  include("footer_script_tags.php");

  include("set_selectedPubId.php");
?>
	<script src="javascripts/calendar_selection_functions.js"></script>
	<script src="javascripts/collapsible_tree_functions.js"></script>
	<script src="javascripts/d3_visualization_functions.js"></script>
	<script src="javascripts/collections.js"></script>
	</body>
</html>