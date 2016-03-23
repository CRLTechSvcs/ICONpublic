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

            <div id="icon_information">
              <strong>ICON information</strong> current contributions, details about the collection process, and how to contribute data.
            </div>

            <ul class="landing_list">
              <li class="landing_list_header"><strong>Current contributors of holdings information to ICON:</strong></li>
              <li><a href="http://www.americanantiquarian.org/" target="_blank">American Antiquarian Society</a></li>
              <li><a href="http://www.crl.edu/" target="_blank">Center for Research Libraries</a></li>
              <li><a href="http://chroniclingamerica.loc.gov/" target="_blank">Library of Congress</a></li>
              <li><a href="http://www.nypl.org/" target="_blank">New York Public Library</a></li>
              <li><a href="http://infoweb.newsbank.com/?db=WHNPX" target="_blank">Readex - World Newspaper Archive</a></li>
              <li><a href="http://www.lib.washington.edu/" target="_blank">University of Washington</a></li>
            </ul>

         <?php include "icon_funding.php"; ?>

          </div><!--landing_content_text-->


          <div class="twelve columns offset-by-ten landing_content_text"><a href="index.php">Main page</a></div>

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

    <script src="javascripts/search_functions.js"></script>
    <script src="javascripts/icon_search_box.js"></script>

	</body>
</html>