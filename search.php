<?php
  /*
  CFJ 2013-04-22 14:57:00
  This page will never be invoked with a pub_id parameter.
  Instead, once page has loaded the user will enter search term(s) and click on the 'Go' button to retrieve publication info.
  Search is also triggered by pressing Enter key while in a textbox.
  */

?>
<!DOCTYPE html>
<!--[if IE 8]><html class="no-js lt-ie9" lang="en"><![endif]-->
<!--[if gt IE 8]><!--><html class="no-js" lang="en"><!--<![endif]-->
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width" />

		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="Wed, 18 Jan 1967 00:00:00 GMT">

		<title>International Coalition on Newspapers (ICON)</title>
		<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
		<link rel="stylesheet" href="stylesheets/foundation.min.css">
		<link rel="stylesheet" href="stylesheets/icon.css">

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
					<div class="row" id="search_form">
						<div class="twelve columns" style="margin-bottom: 15px;">
							<div class="row" id="top_search_form">
								<div class="row">
									<div class="seven columns">
										<label id="search_type_label" class="inline" style="margin-left: 40px;">Search by:</label>
									</div>
									<div class="two columns offset-by-three">
										<ul class="button-group radius two-up even">
										  <li><a href="#" id="go_button" class="button">Go</a></li>
										  <li><a href="#" id="clear_button" class="button">Clear</a></li>
										</ul>
									</div>
								</div>
							</div>
							<div class="row" id="basic_search">
								<div class="row">
									<div class="three columns offset-by-one">
										<select id="basic_search_dropdown" title="Select search type" class="eleven">
       								<!--<option value="0">Select search type</option>-->
       								<option value="keyword">Keyword</option>
       								<option value="title">Title</option>
       								<option value="lccn">LCCN</option>
       								<option value="oclc">OCLC</option>
       								<option value="issn">ISSN</option>
       								<option value="city">City</option>
       								<option value="state_country">State/Country</option>
        						</select>
									</div>
									<div class="six columns end">
										<input id="basic_searchbox" class="searchbox" tabindex="0" type="text" placeholder="Enter search term" title="Enter search term"/>
									</div>
								</div>
							</div>
							<div class="row" id="title_and_keyword_search" style="margin-top: 15px;">
								<div class="row">
									<div class="six columns offset-by-one">
										<input id="title_searchbox" class="searchbox" type="text" placeholder="Title" title="Title"/>
									</div>
									<div class="four columns end">
										<input id="keyword_searchbox" class="searchbox" type="text"  placeholder="Keyword" title="Keyword" />
									</div>
								</div>
							</div>
							<div class="row" id="number_search">
								<div class="row">
									<div class="three columns offset-by-one">
										<input id="lccn_searchbox" class="searchbox" type="text" placeholder="LCCN" title="LCCN" />
									</div>
									<div class="three columns">
										<input id="oclc_searchbox" class="searchbox" type="text" placeholder="OCLC" title="OCLC number" />
									</div>
									<div class="three columns end">
										<input id="issn_searchbox" class="searchbox eleven" type="text" placeholder="ISSN" title="ISSN"/>
									</div>
								</div>
							</div>
							<div class="row" id="location_year_search">
								<div class="row">
									<div class="three columns offset-by-one">
										<input id="city_searchbox" class="searchbox" type="text"  placeholder="City" title="City" />
									</div>
									<div class="three columns">
       							<select id="state_country_dropdown" title="State or country">
       								<option value="0">State/Country</option>
        						</select>
      						</div>
      						<div class="two columns">
										<input id="from_year_searchbox" class="searchbox twelve" type="text"  placeholder="From year" title="Publication began this year or later" />
									</div>
									<div class="two columns end">
										<input id="to_year_searchbox" class="searchbox twelve" type="text"  placeholder="To year" title="Publication ceased by this year"/>
									</div>
								</div>
							</div>

<!--AJE 2015-07-27 : new language widget-->
							<div class="row" id="language_search">
								<div class="row">
									<div class="three columns offset-by-one">
       							<select id="language_dropdown" title="language">
       								<option value="0">Language</option>
        						</select>
									</div>
									<div class="three columns">
									  <!--DEVNOTE: Limit search to publications with ICON issue data
									  <input type="checkbox" name="limit_valid_issues" value="1" />-->
									</div>
      						<div class="two columns">&nbsp;</div>
									<div class="two columns end">&nbsp;</div>
								</div>
							</div>
<!--AJE 2015-07-27 : new language widget-->


							<div class="row" id="search_type_link_row">
								<div class="three columns offset-by-one" style="padding: 0 0 10px 0;">
									<div id="search_type_link_container" style="visibility: visible;">
										<a id="search_type_link" href="javascript:;" title="Click for more search options">Switch to advanced search</a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row" id="message_container">
							<div class="eleven columns centered" id="message">
							</div>
					</div>
					<div class="row" id="search_results">
						<div class="twelve columns centered">
							<div class="row" id="top_search_results">
								<div class="three columns">
									<label id="search_results_label" class="inline">SEARCH RESULTS</label>
								</div>
								<div class="two columns offset-by-two">
									<label id="sort_by_label" class="inline" style="text-align: right;">Sort by:</label>
								</div>
								<div class="five columns">
									<ul class="button-group radius" id="sort_button_container">
									  <li><a href="#" id="sort_title_button" class="button">Title</a></li>
									  <li><a href="#" id="sort_from_year_button" class="button">From year</a></li>
									  <li><a href="#" id="sort_to_year_button" class="button">To year</a></li>
									  <li><a href="#" id="sort_help_button" class="button" data-reveal-id="search_help"><img src="images/sage_white_question_mark.png" /></a></li>
									</ul>
								</div>
							</div>
							<div id="outer_search_list_container">
							<div class="twelve columns" id="search_results_list_container">
								<ul id="search_results_list">
								</ul>
							</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

<!-- FOOTER -->
<?php include("footerCRL.html"); ?>

<?php include("help_sort_button.php"); ?>

<?php include("footer_script_tags.php"); ?>

<!--
	AJE 2013-02-25 18:18:10
	- something like this is needed for the scripts to work
	- used to include headTagContents.php
-->
<?php include "set_selectedPubId.php"; ?>
	<script src="javascripts/search_functions.js"></script>
	</body>
</html>