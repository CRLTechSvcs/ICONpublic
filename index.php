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

		<title>ICON - International Coalition on Newspapers</title>
		<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
		<link rel="stylesheet" href="stylesheets/foundation.min.css">
		<link rel="stylesheet" href="stylesheets/app.css">
		<link rel="stylesheet" href="stylesheets/icon.css">


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
			<!--div class="nine columns mainContentArea"-->
			<div class="nine columns" id="mainContentArea"><!-- AJE 2014-03-18 id has no style definition; want to skip border-right on index pages-->

			  <?php include "index_sub_masthead.html"; ?>

        <div style="clear:both;"><br/></div>

        <?php include "icon_search_box.php"; ?>

        <div class="twelve columns landing_page_content">

          <div class="row landing_content_text">

            <div id="landing_db_intro">
              The <strong><a href="search.php">ICON database</a></strong> is the most comprehensive source of information about significant newspaper collections in print, digital and micro formats. The large and growing database is designed to inform library decisions on the development, management and preservation of newspaper collections.
              <!--is a collection development tool aiming to provide comprehensive and granular data about significant newspaper repositories and libraries to support informed decisions about newspaper collection development, management and preservation.-->
            </div>
<br/>
            <div id="landing_statistics">
              <strong><a href="statistics.php">Current statistics:</a></strong>

              <!--statistics are scripted at bottom of page-->
              <span id="issuesCountValue"><img src="images/loading_titles.gif" /></span> issues from
              <span id="publicationsCountValue"><img src="images/loading_titles.gif" /></span> publications
              dating from <span id="minYearValue"> </span>&ndash;<span id="maxYearValue"> </span>.
              <br/>
              See <a href="statistics.php">more ICON statistics and visualizations</a>.

            </div>

            <?php include "icon_funding.php"; ?>

          </div><!--landing_content_text-->

          <div class="twelve columns offset-by-ten landing_content_text"><a href="icon_information.php">More information</a></div>
        </div><!--landing_page_content-->


			</div><!--mainContentArea-->

      <!-- RIGHT CONTENT AREA -->
      <div class="three columns rightContentArea">

        <?php include "news.php"; ?>

        <?php include "icon_about.html"; ?>

      </div><!--rightContentArea-->

		</div><!--row contentArea-->

<!-- FOOTER -->
<?php include("footerCRL.html"); ?>

<?php include("help_selection_timeline.php"); ?>

<?php include("footer_script_tags.php"); ?>

    <script src="javascripts/statistics_tiny.js"></script>
    <script src="javascripts/search_functions.js"></script>
    <script src="javascripts/icon_search_box.js"></script>

	</body>
</html>