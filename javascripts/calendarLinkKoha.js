/*
	AJE 2012-Sep-10:
	new toplogo is in /usr/share/koha/opac/htdocs/opac-tmpl/prog/en/includes/masthead.inc

	This file WAS included in
		/usr/share/koha/opac/htdocs/opac-tmpl/prog/en/modules/opac-detail.tt
	NOW it's in
		/usr/share/koha/opac/htdocs/opac-tmpl/prog/en/includes/masthead.inc

	begin calendarLinkKoha.js; testing some ways to display a link to ICON database pages
		in the KOHA bib record display (/usr/share/koha/opac/htdocs/opac-tmpl/prog/en/xslt/MARC21slim2OPACDetail.xsl).

*/

		//IP address on server changes most every time we reboot during development
		//	and we're testing a bunch of different files, so here we make it easy to change
	var serverIP   = "192.168.1.142";//CentOS MACHINE - STATIC IP
	var serverPath = "http://" +serverIP+ "/ICON/"; //CentOS
	var serverFilename = "calendar.php"; //Constance's 21-Dec-2011
	var calendarUrl = serverPath + serverFilename;
	var ajaxUrl = serverPath + "find-pub_id.php"; //search DB for correct publications.pub_id

		// critical: corresponds to pub_id field in DB, submitted as 'pub_id' form field
	var pub_id = "dummy_pub_id";

		//feedback-debugging var...
	var strDebug = "";
		//strDebug += "calendarLinkKoha has calendarUrl = '" +calendarUrl+ "'\n";


/********************************************
	AJE 2013-02-20 18:09:08
	testing after http://javascript.about.com/library/blajax01.htm failed, see calendarLinkKohaXMLHttpRequest.bkup
	try after http://stackoverflow.com/questions/6809053/simple-jquery-php-and-jsonp-example
*/
function handleJSON(JSONP){
	var jDebug = "JSONP evals to " +eval(JSONP) + "\n";
	/*
	console.log(JSONP);
	if (JSONP == null) jDebug += "JSONP is null\n";
	if (typeof JSONP  === "undefined") jDebug += "typeof JSONP is undefined\n";
	if (JSONP.pub_id == "") jDebug += "JSONP has no pub_id\n";
	*/

	var jStr = JSON.stringify(JSONP);
	pub_id = jStr.substring( jStr.indexOf('":"')+3, jStr.indexOf('"}]') );
	jDebug += "\njStr = " +jStr+ "\npub_id = " +pub_id;
	return pub_id;
}//end handleJSON
/**********************************************/



$(document).ready(function(){

	if(location.href.indexOf("opac-detail") != -1){ //then we're on a bib details not browse page
	 	//get a candidate value for the pub_id: prefer LCCN (MARC 010), settle for OCLC number
		var lccnSpan = $('span.results_summary:contains("LCCN")');
			//lccnSpan.css("color","#00ff00"); //works
		var lccnData = lccnSpan.text(); //parameter value; jQuery methods
			lccnData = $.trim(lccnData.substring( lccnData.indexOf(":")+1 ));
			if (lccnData.indexOf("-") != -1) {
				lccnData = lccnData.replace(/-/g, "0");
			}

		var oclcSpan = $('span.results_summary:contains("OCLC")');
		var oclcData = oclcSpan.text(); //parameter value; jQuery methods
			oclcData = $.trim(oclcData.substring( oclcData.indexOf(":")+1 ));
			oclcData = oclcData.substring( oclcData.indexOf("(OCoLC)")+7 ); //gets the 1st OCLC but there may be another so...
			oclcData = oclcData.substring( 0, oclcData.indexOf("("));
			strDebug += "\n oclcData = "+oclcData;

		if (lccnData != ""){
			pub_id = lccnData;
		} else if (oclcData != ""){
			pub_id = oclcData;
		} // else pub_id stays at the dummy value, global outside the doc.ready func

		pub_id = pub_id.replace(' ', ''); //remove spaces
		pub_id = encodeURI(pub_id);
			strDebug += '\n before ajax call, pub_id = '+pub_id;

//alert(pub_id);

			// send candidate pub_id to /ICON/find-pub_id.php + check DB for correct pub_id
		$.ajax({
		  dataType: 'jsonp',
		  data: 'pub_id=' +pub_id+ '&callback=handleJSON',
		  jsonp: 'callback',
		  url: ajaxUrl,
		  //success: function () { alert("success function in body is alive") }, //NOT triggered if callback successful: goes to callback func
		});
		strDebug += "\n after ajax call, pub_id = " +pub_id;
		//alert("javascripts directory\n\n" + strDebug );
		/* end filling pub_id
		**********************************************************************/

			//now have pub_id, find where we want to put link + append it to page
		var calFG = "#2d2d4d";
		var calBG = "#adbd90";//"#adbd90"; //olive //"#4e4f7f"; lighter purple
		var formMethod = "GET";
		var formLinkText = "See organizations, dates and formats held, etc.";

		var inputType = "hidden";//change to 'text' for testing
		var	formHTML = '<form name="calendarForm" id="calendarForm" ';
				formHTML += 'method="' +formMethod+ '" ';
				formHTML += 'action="' +calendarUrl+ '" ';
				formHTML += 'target="_blank">';
				formHTML += '<input type="' +inputType+ '" name="pub_id" id="pub_id" value="' +pub_id+ '" />';
				//calendarButton.js has old image input button
			formHTML += "</form>";

			formHTML += '<a href="javascript:document.calendarForm.submit();" id="ICONpageLink">';
			formHTML += formLinkText;
			formHTML += '</a>';

			strDebug += "\nformHTML:\n"+formHTML+"\n";



			//TARGET IS IN /usr/share/koha/opac/htdocs/opac-tmpl/prog/en/xslt/MARC21slim2OPACDetail.xsl
		var targetChild = $('span[id="ICONlinkLocation"]');//where to put link to calendar, actual target
		targetChild.html(formHTML);
	}//end if opac-detail
});//end giant $(document).ready(function()








