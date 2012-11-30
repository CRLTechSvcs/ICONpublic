<?php
		/*PHP manual:
			"Many proxies and clients can be forced to disable caching with" ...*/
	header("Cache-Control: no-cache, must-revalidate"); // HTTP/1.1
	header("Expires: Sat, 15 Oct 2011 00:00:00 GMT"); // Date in the past

	include ("debugJunk.php");

?>

<?xml version="1.0" encoding="UTF-8" standalone="no" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<?php
	include('headTagContents.php');
?>

<body>

	<div id="container"><!-- Container sets page width etc. -->
	<?php
		include('header.php'); //logo, site title, clear div, noscript
	?>

	<div id="content" class="matchingColumn"><!-- white boxed area of page, contains main content, sidebar -->

		<div id="sidebar" class="matchingColumn">
			<?php
				include('sidebarDivContents.php');
			?>
		</div><!--#sidebar-->

		<div id="page" class="matchingColumn"><!-- main text and search results area -->
			<?php
				include "calendar_selection_controls.html"; //insert actual calendar controls here
				include "available_repositories.php"; //target for output from ./scripts/calendar_selection_functions.js --> displayRepositoryList()
				include "available_formats.php"; //target for output from ./scripts/calendar_selection_functions.js --> displayFormatList()
				include "genealogy.php"; //target for output from ./scripts/genealogy_functions.js
			?>
		</div><!--#page: main text and search results area -->

	</div><!--#content: white boxed area of page, contains main content, sidebar -->

</div><!--#container: sets page width etc. -->

<?php
	include("footerCRL.html"); // footer could be outside of #container
?>

</body>
</html>