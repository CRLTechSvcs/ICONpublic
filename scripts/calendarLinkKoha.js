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

$(document).ready(function(){

		//IP address on server changes most every time we reboot during development
		//	and we're testing a bunch of different files, so here we make it easy to change

	var serverIP   = "192.168.1.142";//CentOS MACHINE - STATIC IP
	var serverPath = "http://" +serverIP+ "/ICON/"; //CentOS
	var serverFilename = "calendar.php"; //Constance's 21-Dec-2011
	var calendarUrl = serverPath + serverFilename;

		//feedback-debugging var...
	var strDebug = "calendarLinkKoha has calendarUrl = '" +calendarUrl+ "'\n";

		//database used, and table there
	var DB_NAME 		= escape("icondata");
	var tableChoice = escape("issues");

	//file popupWindowTitleCode.js has irrelevant code that was here (get bib title for display in <title> of popup)


	/***********************************************************************
		fill the critically-important 	pub_id 	var:
			- corresponds to pub_id field in DB, submitted as 'pub_id' form field
			- prefer LCCN (MARC 010)
			- settle for OCLC number
			- supply a dummy value so db query won't even run if LCCN + OCLC fail
	*/
	var lccnSpan = $('span.results_summary:contains("LCCN")');
		//lccnSpan.css("color","#00ff00"); //works
	var lccnData = lccnSpan.text(); //parameter value; jQuery methods
		lccnData = $.trim(lccnData.substring( lccnData.indexOf(":")+1 ));
		if (lccnData.indexOf("-") != -1) {
			lccnData = lccnData.replace(/-/g, "0");
		}
		//strDebug += "lccnData='"+lccnData+"'\n";

	var oclcSpan = $('span.results_summary:contains("OCLC")');
		 //oclcSpan.css("color","#ff0000");
	var oclcData = oclcSpan.text(); //parameter value; jQuery methods
		oclcData = $.trim(oclcData.substring( oclcData.indexOf(":")+1 ));
		strDebug += "oclcData='"+oclcData+"'\n";	strDebug += "oclcData='" + oclcData +"'\n";

	var pub_id = "dummy_pub_id";
	if (lccnData != ""){
		pub_id = lccnData;
	} else if (oclcData != ""){
		pub_id = oclcData;
	} // else pub_id stays at the dummy value

	pub_id = pub_id.replace(' ', ''); //remove spaces
	pub_id = encodeURI(pub_id);
		strDebug += '\tnow pub_id="'+pub_id+'"';

	/* end filling pub_id
	**********************************************************************/


	var calFG = "#2d2d4d";
	var calBG = "#adbd90";//"#adbd90"; //olive //"#4e4f7f"; lighter purple
	var formMethod = "GET";
	var formLinkText = "See repositories, dates and formats held, etc.";

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

//alert(strDebug);

		//TARGET IS IN /usr/share/koha/opac/htdocs/opac-tmpl/prog/en/xslt/MARC21slim2OPACDetail.xsl
	var targetChild = $('span[id="ICONlinkLocation"]');//where to put link to calendar, actual target
	targetChild.html(formHTML);

});//end giant $(document).ready(function()








