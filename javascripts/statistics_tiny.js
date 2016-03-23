/********************************************
  AJE 2014-01-23
    - statistics_tiny.js copied from statistics.js, separate so the rest of that doesn't triger + raise errors
    - sets values of how many issues, publications, and 1st/last years
*********************************************/
function addCommasToNumString(nStr){ // after: http://www.mredkj.com/javascript/numberFormat.html
	nStr += '';
	x = nStr.split('.');
	x1 = x[0];
	x2 = x.length > 1 ? '.' + x[1] : '';
	var rgx = /(\d+)(\d{3})/;
	while (rgx.test(x1)) {
	  x1 = x1.replace(rgx, '$1' + ',' + '$2');
	}
	return x1 + x2;
}//end addCommasToNumString

function preparePubsIssuesCounts(pubIssJSON){
  var pubsIssuesCountsArray = JSON.parse(pubIssJSON);
  var strDebug = "preparePubsIssuesCounts(\n\t" +pubIssJSON+ "\n) \n has length " +pubsIssuesCountsArray.length;
  var countPubs = -1;
  var countIssues = -1;
  for (var i = 0; i < pubsIssuesCountsArray.length; i++) {
    strDebug += "\npubsIssuesCountsArray["+i+"]=" +pubsIssuesCountsArray[i];
    countPubs = pubsIssuesCountsArray[i].countPubs;
    countIssues = pubsIssuesCountsArray[i].countIssues;
  }//end for
  strDebug += "\nafter loop: pub = " +countPubs+ "\ncountIssues = " +countIssues;

  $("#publicationsCountValue").html( addCommasToNumString(countPubs) );
  $("#issuesCountValue").html( addCommasToNumString(countIssues) );
  //alert( strDebug );
} //end preparePubsIssuesCounts

$(document).ready(function() {
  $("#minYearValue").text("1649"); //all pages static or live
  $("#maxYearValue").text("2015"); //all pages static or live
  $.get("get_issues_and_publications_counts.php", preparePubsIssuesCounts);
});//end doc.ready func
//end statistics_tiny.js