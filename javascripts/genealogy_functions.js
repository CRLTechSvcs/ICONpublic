/*-------------------------------------------------------------*/
/* AJE piggybacking on calendar_selection_functions.js to test genealogy
/*-------------------------------------------------------------*/

//selectedPubId = selectedPubId.replace('%20', ''); //selectedPubId set in headTagContents.php

$.get("get_genealogy_info.php?pub_id=" +selectedPubId, { 'selectedPubId': selectedPubId }, displayGenealogyTest);

function displayGenealogyTest(results, textStatus) {
	if ((results.search(/Error/i) != -1) || (results.search(/\<b>Notice/i) != -1 )) {
		document.writeln(results);
	} else if (results != ""){
		//console.log("I'm here now");

		var relationships = JSON.parse(results);

		if (relationships.length > 0) {
			var genealogyList = '<div id="genealogy_list" class="pub_data_content"><h3>NO 787S IN QUERY 2013-04-12 AJE</h3><ul>';
			for (var i=0; i < relationships.length; i++) {
				relType			= relationships[i].rel_type_description;
				relFrom 		= relationships[i].relationshipFrom; // actually current pub_id
				relToTitle 	= relationships[i].relationship_to_title;
				relToID 		= relationships[i].relationship_to_pub_id; // pub_id of related one; actual publications.pub_id; usually LCCN, sometimes OCLC or even ISSN
				relHREF 		= 'calendar.php?pub_id=' +relToID;
				relCtrlNum 	= relationships[i].relationship_to_control_num; // usually OCLC number, or some other system control number which is not our pub_id
				relToISSN		= relationships[i].relationship_to_ISSN;

				genealogyList += '<li>';
/*
	DEVNOTE:
		A) want to see title corresponding to relFrom (relFrom is a pub_id)
		B) want the relFrom title to be linked to that calendar.php

*/
					genealogyList += relFrom + ' ' +relType+ ' --&gt; ' +relToTitle;
					genealogyList += ' (id:<a href="'+relHREF+'" style="text-decoration:underline;">'+relToID+'</a>';
					if (relToISSN) {
						genealogyList += ', ISSN:' +relToISSN;
					}
				genealogyList += ')</li>';
			}//end for
			genealogyList += '</ul></div>';

			$('#genealogy_list').html( genealogyList );
			resetHeightsAndOffsets($('.matchingColumn')); //headTagContents.php
		}//end if relationships
	} else { // no results
		//console.log("No results");
		//alert(selectedPubId+ "\nthere were no relationship results: \nrelationship results = \n'" +results+ "'");

	}//end if-else
}//end displayGenealogyTest
