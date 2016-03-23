<?php
  /*
    database.php exists to redirect users to the real ICON search page
      - the URL <http://icon.crl.edu/database.php> was included in a CRRA document sent to their stakeholders
      that's a valid link on the 2009 site, but it's not part of the new model: search.php has link to show/hide advanced search

      - we'll just redirect here with a noscript in mainContentArea

  */

?>
<!DOCTYPE html>
<!--[if IE 8]><html class="no-js lt-ie9" lang="en"><![endif]-->
<!--[if gt IE 8]><!--><html class="no-js" lang="en"><!--<![endif]-->
	<head>

	  <script>
	    location.href = "search.php";
	  </script>


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

			<noscript>
        <h3>
          If you are seeing this message, you have JavaScript turned off in your browser.<br/>
          The ICON site depends on JavaScript for most of its functionality; please consult the documentation for your browser to see how to turn on JavaScript.
        </h3>
        <h3>
          To search the main ICON site, <a href="search.php">&lt;click this link&gt;</a> (the page you are viewing is from the old version  of the site).
        </h3>
			</noscript>

			</div><!--end mainContentArea-->
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