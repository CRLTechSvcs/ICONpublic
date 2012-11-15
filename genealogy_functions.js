/*-------------------------------------------------------------*/
/* AJE piggybacking on calendar_selection_functions.js to test genealogy
/*-------------------------------------------------------------*/
selectedPubId = selectedPubId.replace('%20', '');
$.get("get_genealogy_info.php?pub_id=" +selectedPubId, { 'selectedPubId': selectedPubId }, displayGenealogyTest);

function displayGenealogyTest(results, textStatus) {
	if ((results.search(/Error/i) != -1) || (results.search(/\<b>Notice/i) != -1 )) {
		document.writeln(results);
	} else {

		var relationships = JSON.parse(results);
//prompt("results=\n" +results+ "\nrelationships.length==" +relationships.length +"\n"+ relationships, relationships); // [object Object]
		if (relationships.length > 0) {
			var genealogyString = "<ul>";
			for (var i=0; i < relationships.length; i++) {
				relType			= relationships[i].rel_type_description;
				relFrom 		= relationships[i].relationshipFrom; // this is actually the current pub_id
				relToTitle 	    = relationships[i].relationship_to_title;
				relToID 		= relationships[i].relationship_to_pub_id; // pub_id of the related one; the actual publications.pub_id; usually LCCN, sometimes OCLC or even ISSN
				relToID 		= relationships[i].relationship_to_control_num; // usually OCLC number, or some other system control number which is not our pub_id
				relHREF 		= 'calendar.php?pub_id=' +relToID;
				relToISSN		= relationships[i].relationship_to_ISSN;
				genealogyString += '<li>';
					genealogyString += relFrom + ' ' +relType+ ' relationship to ' +relToTitle;
					genealogyString += ' (id:<a href="'+relHREF+'" style="text-decoration:underline;">'+relToID+'</a>';
					if (relToISSN) {
						genealogyString += ', ISSN:' +relToISSN;
					}
					genealogyString += ')';
				genealogyString += '</li>';
			}//end for
			genealogyString += '</ul>';
			$('<div class="block"><h4>Publication genealogy</h4></div><div id="pub_genealogy" class="block"><p></p>' + genealogyString + '<p></p></div>').insertBefore($('h4:contains("Genealogy of paper")')[0]);
		}//end if relationships
	}//end if-else
}//end displayGenealogyTest
