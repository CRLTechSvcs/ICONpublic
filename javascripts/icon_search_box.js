/********************************************
  AJE 2014-01-23: icon_search_box.js supports icon_search_box.php + requires search_functions.js
    - build lastSQLquery, using value in text box
    - set a cookie with value of lastSQLquery
    - redirect to search.php, which will read the cookie and display results
*********************************************/

var SQL = new String("SELECT p.*, country_name, b_showFullText, ref_data_uri, ref_data_body, ref_data_title, ");;
    SQL += "ref_source_title FROM publications p ";
    SQL += "JOIN countries c USING (country_id) ";
    SQL += "LEFT JOIN reference_linkage rl USING (pub_id ) ";
    SQL += "LEFT JOIN reference_data rd USING (ref_data_id) ";
    SQL += "LEFT JOIN reference_sources rs USING (ref_source_id) ";
    SQL += "WHERE (pub_title LIKE \"%FAKETERM%\" ";
      SQL += "OR pub_title_alt LIKE \"%FAKETERM%\" ";
      SQL += "OR pub_id LIKE \"%FAKETERM%\" ";
      SQL += "OR OCLC LIKE \"%FAKETERM%\" ";
      SQL += "OR ISSN LIKE \"%FAKETERM%\" ";
      SQL += "OR pub_city LIKE \"%FAKETERM%\" ";
      SQL += "OR country_name LIKE \"%FAKETERM%\" ";
      SQL += "OR numberingNote515 LIKE \"%FAKETERM%\" ";
      SQL += "OR summary520 LIKE \"%FAKETERM%\" ";
      SQL += "OR descriptionNote588 LIKE \"%FAKETERM%\" ";
      SQL += "OR bib_relationships LIKE \"%FAKETERM%\")";


function submit_icon_search_box(){
    var searchTerm = $("#basic_searchbox").val();
    //alert('no changes yet to: ' + SQL);
    var lastSQLquery = SQL.replace("FAKETERM", searchTerm, "g");
    var strDebug = searchTerm +'\n'+ lastSQLquery;
    //if( confirm(strDebug) ){
  	var expdate = new Date();
  	var exdays = 1;
	  setCookie('Search type', 'basic', 1);
	  setCookie('Enter search term', searchTerm, 1);
	  setCookie('Basic search field', 'keyword', 1);
	  ///setCookie('lastSQLquery', lastSQLquery, 1);
	  setCookie('lastSQLquery', escape(lastSQLquery), 1);

    //alert("this is what the cookie just got\n\n" + lastSQLquery);

    location.href="search.php"; //submit the form



    //}//end if
}//end submit_icon_search_box



$(document).ready(function() {

  $("#basic_searchbox").keyup( function(event) {
    if (event.keyCode == 13) {
      submit_icon_search_box();
    }
  });

  $("#search_icon_button").click( function() {submit_icon_search_box() } ); // not the box but the button
});//end doc.ready func

//end icon_search_box.js