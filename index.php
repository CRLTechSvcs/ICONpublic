<?php
		/*PHP manual:
			"Many proxies and clients can be forced to disable caching with" ...*/
	header("Cache-Control: no-cache, must-revalidate"); // HTTP/1.1
	header("Expires: Sat, 15 Oct 2011 00:00:00 GMT"); // Date in the past

	//setcookie(name, value, expire, path, domain);
	//setcookie("emailAddress", "you@email.com", time()+60*60*24, "/", "192.168.1.142");

		//SstrTRcolor vars modified in calendarFunctions.php --> setTRcolor(integer)
	$strTRcolor 		= "#adbd90"; //darker
	$strTRcolorAlt 	= "#e9e6d3";	//lighter
	//include ("calendarFunctions.php");

$bShowDebug = 0; // value of 0 = don't show application debugging; 1 = do show it
$strAppDebug = "<br/>Application debugging data for display during development: ";
/*
$strAppDebug .= "<h4>$ _ RQ[pub_id] = '" . $_REQUEST['pub_id'] . "'</h4>";
$strAppDebug .= "<h4>$ _ POST[pub_id] = '" . $_POST['pub_id'] . "'</h4>";
$strAppDebug .= "<h4>$ _ GET[pub_id] = '" . $_GET['pub_id'] . "'</h4>";
*/

	//set database file name, table choice in that database, + search data: shd be submitted in a form
$strAppDebug .= "<p>DB_NAME = '<strong>";
if (isset($_REQUEST["DB_NAME"])) 	{
	$DB_NAME = urldecode($_REQUEST["DB_NAME"]);
	$strAppDebug .= $DB_NAME . "</strong>' from IF block</p>";
} else 	{
	$DB_NAME 	= "icondata"; //original test database
	$strAppDebug .= $DB_NAME . "</strong>' from the ELSE block (not received from form submission: what's up with this?)</p>";
}
$strAppDebug .= "<p>tableChoice = '<strong>";
if (isset($_REQUEST["tableChoice"])) 	{ // used in SQL statements
	$tableChoice = urldecode($_REQUEST["tableChoice"]);
	$strAppDebug .= $tableChoice . "</strong>' from IF block</p>";
} else 	{
	$tableChoice 	= "issues";
	$strAppDebug .= $tableChoice . "</strong>' from ELSE block</p>";
}
$strAppDebug .= "<p>pub_id = '<strong>";
if (isset($_REQUEST["pub_id"])) 	{ // LCCN, OCLC number or similar
	$pub_id = urldecode($_REQUEST["pub_id"]);
	$strAppDebug .= $pub_id . "</strong>' from IF block</p>";
} else 	{
	$pub_id 	= "sn82016245";
	$strAppDebug .= $pub_id . "</strong>' from ELSE block</p>";
}
$strAppDebug .= "<p>title = '<strong>";
if (isset($_REQUEST["title"])) 	{
	$title = urldecode($_REQUEST["title"]);
	$strAppDebug .= $title . "</strong>' from IF block</p>";
} else 	{
	$title 	= ""; //original test database
	$strAppDebug .= $title . "</strong>' from the ELSE block</p>";
}
//end setting DB_NAME, tableChoice, pub_id


	/**********************************************************
		VARS FOR FILE SYSTEM */

	$thisServerIP = $_SERVER['SERVER_ADDR'];
		$strAppDebug .= "<p>thisServerIP = '<strong>" . $thisServerIP . "</strong>'</p>";

	// CFJ 31-Aug-12 - former Innovative WebOpac stylesheet Holdings.css is no longer needed.
	// All styles are now defined in styles.css, selection_page_stylesheet_ff.css, and selection_page_stylesheet_ie.css.
	//$holdingsStylesLink = '<link rel="stylesheet" type="text/css" href="http://';
	//$holdingsStylesLink .= $thisServerIP;
	//$holdingsStylesLink .= '/IMLS/Holdings.css" />';
	//$strAppDebug .= "<p>holdingsStylesLink = '<strong>" . $holdingsStylesLink . "</strong>'</p>";

	$thisUrl 		  = $_SERVER['PHP_SELF']; // '/IMLS/includes/CRLcatalog/index.php' or similar
		$strAppDebug .= "<p>thisURL = '<strong>" . $thisUrl . "</strong>'</p>";
	$parts 		= explode("/", $thisUrl);
	$partsSize 	= count($parts); //returns array length
	$thisFile	= $parts[ $partsSize - 1];
		$strAppDebug .= "<p>thisFile = '<strong>" . $thisFile . "</strong>'</p>";
	/* end VARS FOR FILE SYSTEM
	**********************************************************/


//DEVNOTE: script in crlFunctions.js resets the title anyway: this ends up having no effect
if (isset($_REQUEST['title'])) $titleParameter = $_REQUEST['title'];
else $titleParameter = "holdings on this publication";
?>

<!--body bgcolor="#485b2e"-->
<?xml version="1.0" encoding="UTF-8" standalone="no" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<!-- 2012-06-08 AJE and CFJ - following title no longer applies
			<title>Calendar for <?PHP echo $title ?></title>
		-->
		<title>ICON Project holdings</title>
		<!-- 2012-05-30 AJE and CFJ - use standalone stylesheet rather than catalog server version -->
		<link rel="stylesheet" type="text/css" href="styles.css" />
		<link rel="stylesheet" type="text/css" href="selection_page_stylesheet_ff.css" />
		<!--[if IE]>
			<link rel="stylesheet" type="text/css" href="selection_page_stylesheet_ie.css" />
		<![endif]-->

		<!-- 2012-05-30 AJE and CFJ - use standalone favicon rather than catalog server version -->
		<link rel="shortcut icon" type="image/x-icon"  href="images/favicon.ico" />

		<script type="text/javascript" language="javascript" src="json2.js"></script>
		<script type="text/javascript" src="jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="jquery-ui-1.8.9.custom.min.js"></script>
		<script type="text/javascript" src="calendar_selection_functions.js"></script>
		<script type="text/javascript" src="initialize_variables.js"></script>
	</head>
	<body>

<!--AJE added, 9-Mar-2012-->
<!--CFJ removed, 9-Mar-2012-->
<!--Instead of including get_publication_info.php, it will be called via Ajax in calendar_selection_functions.js-->
<!--php
	//require_once('get_publication_info.php');
-->
<!--CFJ removed, 9-Mar-2012-->
<!--end AJE, 9-Mar-2012-->


<!------------------------------------------------------------------------------------------------------------------->
<!--                          B E G I N   T O P L O G O _ S 3 6 . H T M L                                          -->
<!------------------------------------------------------------------------------------------------------------------->
<!-- At Andy's suggestion, incorporating toplogo_s36.html elements directly, rather than via PHP include           -->
<!-- CFJ 31-Aug-2012 -->


<!--2012-06-08 AJE and CFJ - title now set in index.php and calendar_selection_functions.js
<script language="JavaScript" type="text/javascript">
	// set document.title, as displayed in title bar, based on SESSION_SCOPE cookie
	//setTitle(); //lives in crlFunctions.js
</script>
-->

<div id="container"><!-- Container sets page width etc. -->

<div id="header"><!-- logo and site title -->
	<a href="http://www.crl.edu"><img height="61" width="389" border="2" alt="Center for Research Libraries - Global Resources Network" src="images/logo.gif"/></a>
	<div id="scopeTitleSmaller">
		<h1 class="generalTitle">International Coalition on Newspapers</h1>
		<h2 class="specificTitle">ICON</h2>
	</div>
</div>

<div style="clear:both"></div>

<div id="languageHandler"></div><!--AJE 11-Mar-11: not supporting French catalog for JSTOR/PARC, retain this div because it is referenced in scripts-->

<div>
	<noscript><p>This site makes extensive of use of Javascript.  If you are seeing this message, you have either turned off javascript in your browser, or your browser does not support it.  As a result, this page may not work as intended for you.  Please review your browser's documentation for specifics on how to remedy this problem.</p></noscript>
</div>


<div id="content"><!-- white boxed area of page, contains main content, language handlers and sidebar -->


<div id="sidebar">

	<div class="block">
		<h4>Genealogy of paper</h4>
		<!--per Amy 13 July 2011.-->
		<!--CFJ - disable links until Amy advises on sidebar content -->
		<!--<p>Devnote: content and <a href="javascript:alert('no content');return false;" target="_blank">links</a> to be supplied.</p>-->
		<p>Devnote: content and links to be supplied.</p>
		<div class="boxfoot">
			<!--<a class="more" href="javascript:alert('no content');return false;" target="_blank">Learn More &#187;</a>-->
			<a class="more" href="javascript:function x() {return false;}">Learn More &#187;</a>
		</div>
	</div>


	<div class="block">
		<h4>Profiles of all archiving</h4>
		<!--per Amy 13 July 2011.-->
		<!--CFJ - disable links until Amy advises on sidebar content -->
		<!--<p>Devnote: content and <a href="javascript:alert('no content');return false;" target="_blank">links</a> to be supplied.</p>-->
		<p>Devnote: content and links to be supplied.</p>
		<div class="boxfoot">
			<!--<a class="more" href="javascript:alert('no content');return false;" target="_blank">Learn More &#187;</a>-->
			<a class="more" href="javascript:function x() {return false;}">Learn More &#187;</a>
		</div>
	</div>


	<div class="block">
		<h4>Genealogy of preservation activities</h4>
		<!--per Amy 13 July 2011.-->
		<!--CFJ - disable links until Amy advises on sidebar content -->
		<!--<p>Devnote: content and <a href="javascript:alert('no content');return false;" target="_blank">links</a> to be supplied.</p>-->
		<p>Devnote: content and links to be supplied.</p>
		<div class="boxfoot">
			<!--<a class="more" href="javascript:alert('no content');return false;" target="_blank">Learn More &#187;</a>-->
			<a class="more" href="javascript:function x() {return false;}">Learn More &#187;</a>
		</div>
	</div>


</div>

<div id="page"><!-- main text and search results area -->

	<?php

		//include "server_calendar_selection_controls.html"; //insert actual calendar controls here

			//AJE 2012-11-19 NEW : QUERY ALL ISSUES + PUBLICATIONS
		include 'form_query_ICON.php';
		if ($_REQUEST['ICONquery']) { //respond to the submitted query
			include('get_query_ICON.php');
		}//end if



	?>




<script language="javascript" type="text/javascript">
	//Strip spaces out of the pub_id passed in from bib rec
	selectedPubIdWithoutSpace = "<?php echo str_replace("%20", "", $_REQUEST['pub_id']); ?>";
	selectedPubId = "<?php echo $_REQUEST['pub_id']; ?>";
</script>

<!--AJE: BGN GENEALOGY TEST SCRIPTS-->
<!--NEXT DEPENDS ON selectedPubId BEING IN JAVASCRIPT SCOPE ALREADY-->
<script type="text/javascript" src="genealogy_functions.js"></script>
<?php
	//require_once('get_genealogy_info.php'); //AJE messing with GENEALOGY stuff 2012-10-08 16:05:09
	//NO: get_genealogy_info.php is called in genealogy_functions.js
?>
<!--AJE: END GENEALOGY TEST SCRIPTS-->


<?php

if ($bShowDebug) echo $strAppDebug;

	/**********************************************************
		VARS FOR DATABASE + PAGE LINKING	*/

	$recordStep = 10; //how many to get for each page
		$strAppDebug .= "<p>recordStep='<strong>" . $recordStep . "</strong>'</p>";
	if (isset($_REQUEST["beginID"])) 	$beginID = $_REQUEST["beginID"];
	else 	$beginID 	= 1;
	if (isset($_REQUEST["endID"])) 		$endID = $_REQUEST["endID"];
	else	$endID		= $beginID + $recordStep;

	$strSQLDescribe 	= "DESCRIBE $tableChoice";

	//names for various result operations, hold resources or booleans returned by mysqli_query
	$result = "";
	$selectResult = "";
	$updateResult = "";
	$confirmResult = "";
	$describeResult = "";

	/* end VARS FOR DATABASE + PAGE LINKING
	**********************************************************/

?>

</div><!-- end Page div; main text and search results area -->
</div><!-- end Content div; white boxed area of page, contains main content, language handlers and sidebar -->
</div><!-- end Container div; sets page width etc. -->


<div id="footer">
	<div id="footer_bar"></div>
	<div id="footer_container">
		<div id="footer_title"><a href="http://www.crl.edu" target="_blank">Center for Research Libraries</a></div>
		<div id="subfooter">
			<ul id="metanav">
				<li><a href="http://www.crl.edu/about/staff-directory/" target="_blank">Staff Directory</a></li>
				<li><a href="http://www.crl.edu/feedback?location=node/11&amp;title=Membership" target="_blank">Feedback</a></li>
			</ul>
			<div id="address">
				<div>6050 S. Kenwood Avenue<br/>
				Chicago, IL 60637-2804 USA</div>
				<div>Phone:  (800) 621-6044 <em>or</em> (773) 955-4545<br/>

				Fax:  (773) 955-4339</div>
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

</body>
</html>

