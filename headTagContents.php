<head>
	<title>International Coalition on Newspapers (ICON)</title>


	<link rel="stylesheet" type="text/css" href="css/styles.css" />
	<link rel="stylesheet" type="text/css" href="css/styles_ff.css" />
	<!--[if IE]>
		<link rel="stylesheet" type="text/css" href="styles_ie.css" />
	<![endif]-->

	<link rel="shortcut icon" type="image/x-icon"  href="images/favicon.ico" />

	<script type="text/javascript" language="javascript" src="scripts/json2.js"></script>
	<script type="text/javascript" language="javascript" src="scripts/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" language="javascript" src="scripts/jquery-ui-1.8.9.custom.min.js"></script>

	<script type="text/javascript" language="javascript" src="scripts/initialize_variables.js"></script>
	<script type="text/javascript" language="javascript">
			//Strip spaces out of the pub_id passed in from bib rec: PHP writes out the JS values
			<?php
				if (ISSET( $_REQUEST['pub_id']) ) {
					$selectedPubIdWithoutSpace = str_replace("%20", "", $_REQUEST['pub_id']);
					$selectedPubId = $_REQUEST['pub_id'];
				} else { //no pub_id
					$selectedPubIdWithoutSpace = 'no_pub_id';
					$selectedPubId = $selectedPubIdWithoutSpace;
				}
				echo 'selectedPubIdWithoutSpace = "' . $selectedPubIdWithoutSpace .  '";';
				echo 'selectedPubId = "' . $selectedPubId .  '";';
			?>
	</script>
	<script type="text/javascript" language="javascript" src="scripts/calendar_selection_functions.js"></script>
	<script type="text/javascript" language="javascript" src="scripts/genealogy_functions.js"></script>

	<script type="text/javascript" language="javascript">
			/* AJE 2012-11-21
				resetHeightsAndOffsets after: http://buildinternet.com/2009/07/four-methods-to-create-equal-height-columns/
					- called after genealogy loads
					- receives jQuery object representing elements with .class 'matchingColumn'
					- coordinates heights of #page + #sidebar;
					TO DO: move #footer to accomodate;
					SEE ALSO:
						- displayRepositoryList() in calendar_selection_functions.js
				*/
		function resetHeightsAndOffsets( columns ){

			var tallestcolumn = 0;

			var strDebug = "resetHeightsAndOffsets...\n";

			columns.each( function(){
				currentHeight = $(this).height();
				strDebug += '\n' + $(this).attr('id') + ' begins with height ' + currentHeight;
				if (currentHeight > tallestcolumn) {
					tallestcolumn  = currentHeight;
				} //end if
			}); //end anon func each

			columns.height(tallestcolumn);

			strDebug += '\n\n\n'
			columns.each( function(){ //just checking
				strDebug += '\n' + $(this).attr('id') + ' ends with height ' + $(this).height();
			}); //end anon func each
			strDebug += '\navailable_repositories has height ' + $('#available_repositories').height();


			var adjustmentFactor = 20; // AJE 2012-11-26: RANDOM TRIAL + ERROR NUMBER THAT SHOULD NOT BE NECESSARY
			/*
			var genHeight = $('#genealogy_list').outerHeight(true);
			$('#container').height( genHeight + adjustmentFactor );
			$('#content').height( genHeight + adjustmentFactor );
			$('#page').height( genHeight + adjustmentFactor );
			$('#sidebar').height( genHeight - adjustmentFactor ); 		*/

			//var containerOffset = $("#container").offset();


			var formatsHt = $("#available_formats").outerHeight(true);
			var reposHt = $("#available_repositories").outerHeight(true);
			var genHt = $('#genealogy_list').outerHeight(true);

				//expand page to hold all the sub-lists
			$("#page").height( reposHt + formatsHt + genHt);
			$('#sidebar').height( $("#page").outerHeight(true) ); //expand sidebar to match page

				//move footer down the page
			var footerOffset 	= $("#footer").offset();
			var footerNewTop = ( $("#page").outerHeight(true) + (adjustmentFactor * 5));
			$("#footer").offset({ top: footerNewTop, left: footerOffset.left });

			//alert(strDebug);
		}//end resetHeightsAndOffsets

		$(document).ready(function(){
			resetHeightsAndOffsets($('.matchingColumn'));
		});//end doc.ready func

	</script>
</head>