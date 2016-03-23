/*-------------------------------------------------------------*/
/* J Q U E R Y   I N I T I A L I Z A T I O N   F U N C T I O N
/*-------------------------------------------------------------*/
$(function() {
	$('#search_type_link').text('Switch to advanced search');
	$('#title_and_keyword_search').css('display','none');
	$('#number_search').css('display','none');
	$('#location_year_search').css('display','none');
	$('#language_search').css('display','none');
	$('#basic_search').css('display','block');
	//Clear message area, and results
	$('#message').empty();
	$('#message_container').css('display','none');
	search_type = 'keyword';
	searchterm_entered = false;
	tempSearchHeight = '';
	if (document.cookie.length > 0) {
		restoreSearchState();
		lastSQLquery = getCookie('lastSQLquery');

    if (lastSQLquery){ // AJE 2014-03-18 only then do we ajax
		$.ajax({
				type: "POST",
				url: "resubmit_title_query.php",
				data: {lastSQLquery: lastSQLquery},
				success: displayTitles,
				error: displayTimeoutMessage,
				//timeout: 5000,  # AJE 2014-08-14 there was a comma here like it shows ...
				timeout: 10000,
			});
		}//end if AJE 2014-03-18

	}
	$.get("get_countries.php", populateCountryDropdown);
	$.get("get_languages.php", populateLanguageDropdown); // AJE: new 2015-07-24
	$("#go_button").click(function() {
		var today = new Date();
		searchterm_entered = false;
		deleteCookie('lastSQLquery',new Date(today.getTime() - 24 * 3600 * 1000));
		if ($('#search_type_link').text() == 'Switch to advanced search') {
			//User selected basic search
			//Clear advanced search controls
			$('.searchbox[id!="basic_searchbox"]').val('');
			deleteCookie('State country',new Date(today.getTime() - 24 * 3600 * 1000));
			$('#state_country_dropdown').val(0);
			if ($('#basic_searchbox').val() != 'Enter search term') {
				searchterm_entered = true;
			}
 			if (!searchterm_entered) {
    		$('#search_results_list_container').empty();
    		$('#search_results').css('display','none');
    		$('#message').empty().append("Please enter a search term.");
    		$('#message_container').css('display','block');
 			} else {
    		validateSearchTerms();
 			}
		} else if ($('#search_type_link').text() == 'Return to basic search') {
			//User selected advanced search
			//Clear basic search controls and cookies
			deleteCookie('Enter search term',new Date(today.getTime() - 24 * 3600 * 1000));
			deleteCookie('Basic search field',new Date(today.getTime() - 24 * 3600 * 1000));
			$('#basic_searchbox').val('');
			$('#basic_search_dropdown').val('Keyword');
			validateSearchTerms();
		}
	}); // end go_button click function
	$("#clear_button").click(function() {
		clearCookies();
		search_type = 'keyword';
		searchterm_entered = false;
		title_sort_order = 'ascending';
		from_year_sort_order = 'descending';
		to_year_sort_order = 'descending';
		$('#search_results').css('height','');
		tempSearchHeight = '';
		$('input[type="text"]').val('');
		$('#message').empty();
		$('#message_container').css('display','none');
		$('#search_results_list_container').empty();
		$('#search_results').css('display','none');
		$('#message_container').css('display','none');
		$('#basic_search_dropdown option[value="keyword"]').attr('selected', 'selected');
		$('#basic_search_dropdown').css('color','#181818');
		$('#state_country_dropdown option[value="0"]').attr('selected', 'selected');
		$('#state_country_dropdown').css('color','#999999');
    $('#language_dropdown option[value="0"]').attr('selected', 'selected');
		$('#language_dropdown').css('color','#999999');
		$('.searchbox').each(function( index ) {
  		$(this).addClass('placeholder');
  		$(this).val($(this).attr('placeholder'));
  	});
  	if ($('#search_type_link').text() == 'Switch to advanced search') {
  		$('#basic_searchbox').focus();
  	}
	});
	$('#search_type_link').click(function() {
		if ($(this).text() == 'Switch to advanced search') {
			$('#message').empty();
			$('#message_container').css('display','none');
			$('#title_and_keyword_search').css('display','block');
			$('#number_search').css('display','block');
			$('#location_year_search').css('display','block');
			$('#language_search').css('display','block');
			$('#basic_search').css('display','none');
			$(this).text('Return to basic search');
			$(this).removeAttr('title');
			if (getCookie('Search type') == 'basic') {
				$('#search_results').css('display','none');
			} else if (getCookie('Search type') == 'advanced') {
				$('#search_results').css('display','block');
			}
		} else if ($(this).text() == 'Return to basic search') {
			$('#message').empty();
			$('#message_container').css('display','none');
			$('#title_and_keyword_search').css('display','none');
			$('#number_search').css('display','none');
			$('#location_year_search').css('display','none');
			$('#language_search').css('display','none');
			$('#basic_search').css('display','block');
			$(this).text('Switch to advanced search');
			$(this).attr('title','Click for more search options');
			if (getCookie('Search type') == 'advanced') {
				$('#search_results').css('display','none');
			} else if (getCookie('Search type') == 'basic') {
				$('#search_results').css('display','block');
			}
		}
		$("#clear_button").click();
	});
	$("#sort_title_button").click(function() {
		title_sort_type = 'title';
		sorting = true;
		if (title_sort_order == 'ascending') {
			title_sort_order = 'descending';
		} else if (title_sort_order == 'descending') {
			title_sort_order = 'ascending';
		}
		$("#go_button").click();
	});
	$("#sort_from_year_button").click(function() {
		title_sort_type = 'from_year';
		sorting = true;
		if (from_year_sort_order == 'ascending') {
			from_year_sort_order = 'descending';
		} else if (from_year_sort_order == 'descending') {
			from_year_sort_order = 'ascending';
		}
		$("#go_button").click();
	});
	$("#sort_to_year_button").click(function() {
		title_sort_type = 'to_year';
		sorting = true;
		if (to_year_sort_order == 'ascending') {
			to_year_sort_order = 'descending';
		} else if (to_year_sort_order == 'descending') {
			to_year_sort_order = 'ascending';
		}
		$("#go_button").click();
	});
	//Select contents when user tabs to or clicks on a search textbox
	$(".searchbox").focus(function(){
		// Select input field contents
		this.select();
		var input = $(this);
		if (input.val() == input.attr('placeholder')) {
    	input.removeClass('placeholder');
  	}
	}).blur(function() {
  	var input = $(this);
  	if (input.val() == '' || input.val() == input.attr('placeholder')) {
    	input.addClass('placeholder');
    	input.val(input.attr('placeholder'));
  	}
	}).blur();
	//Submit when user presses 'Enter' while in a search textbox
	$(".searchbox").keyup(function(event){
		if(event.keyCode == 13){
  		$("#go_button").click();
		}
	});
	//Submit when user presses 'Enter' while on search type dropdown
	$("#basic_search_dropdown").keyup(function(event){
		if(event.keyCode == 13){
  		$("#go_button").click();
		}
	});
	$('#basic_search_dropdown').change(function() {
		search_type = $(this).val();
		$(this).css("color", "#181818");
	});
	$('#state_country_dropdown').change(function() {
		if ($(this).val() == "0") {
			$(this).css("color", "#999999");
		} else {
			$(this).css("color", "#181818");
		}
	});
});
function validateSearchTerms() {
	//NOTE:  Searching for a date in the Keyword field will return titles containing those digits in bibliographic identifier fields.
	//For example, keyword search on '1920' returns sn85030000 (Advertiser, Mission, KS) because its OCLC number is '11920219'.
	if (($('#state_country_dropdown').val() != "0") || ($('#language_dropdown').val() != "0")) {
		searchterm_entered = true;
	} else {
		$('.searchbox').each(function( index ) {
			if ($(this).attr('class').search('placeholder') == -1) {
				searchterm_entered = true;
				return false;
			}
		});
	}
	if (!searchterm_entered) {
		$('#search_results_list_container').empty();
		$('#search_results').css('display','none');
		$('#message').empty().append("Please enter at least one search term.");
		$('#message_container').css('display','block');
	} else {
		//Capture search criteria
		var search_title = search_lccn = search_oclc = search_issn = search_city = search_keyword = search_from_year = search_to_year = search_state_country = search_state_country_name = search_language = '';
		var tempField = tempValue = '';
		var searchParameterArray = null;
		//Capture non-placeholder search terms
		$('input.searchbox').each(function(index) {
			tempField = tempValue = null;
			if (!($(this).attr('class').search('placeholder') != -1)) {
				//User entered a real search term
				tempField = $(this).attr('id').replace('_searchbox','');
				tempValue = $(this).val();
				switch(tempField) {
					case 'basic':
					  if (search_type == "title") {
					  	search_title = tempValue;
						} else if(search_type == "lccn") {
							search_lccn = tempValue;
						} else if(search_type == "oclc") {
							search_oclc = tempValue;
						} else if(search_type == "issn") {
							search_issn = tempValue;
						} else if(search_type == "city") {
							search_city = tempValue;
						} else if(search_type == "keyword") {
							search_keyword = tempValue;
						} else if(search_type == "state_country") {
							search_state_country_name = tempValue;
							//console.log(tempValue);
						}
					  break;
					case 'title':
					  search_title = tempValue;
					  break;
					case 'lccn':
					  search_lccn = tempValue;
					  break;
					case 'oclc':
					  search_oclc = tempValue;
					  break;
					case 'issn':
					  search_issn = tempValue;
					  break;
					case 'city':
					  search_city = tempValue;
					  break;
					case 'keyword':
					  search_keyword = tempValue;
					  break;
					case 'from_year':
					  search_from_year = tempValue;
					  break;
					case 'to_year':
					  search_to_year = tempValue;
					  break;
					default:
				}
			}
		});
		if ($('#search_type_link').text().search('advanced') == -1) { //Advanced search

			search_state_country = document.getElementById('state_country_dropdown').options[document.getElementById('state_country_dropdown').selectedIndex].value;
			search_language = document.getElementById('language_dropdown').options[document.getElementById('language_dropdown').selectedIndex].value;

			// AJE 2015-08-13 : when these get set to value of <select> index (which is zero), no results get returned
			if (search_state_country == 0){ search_state_country = ""; }
			if (search_language == 0){ search_language = ""; }

		}
		//Validate search criteria
		if (search_lccn.length > 0 && search_lccn.length < 8) {
			$('#search_results_list_container').empty();
			$('#search_results').css('display','none');
			$('#message').empty().append("Please enter at least 8 characters in LCCN field.");
			$('#message_container').css('display','block');
		//Validate OCLC search term
		} if (search_oclc.length > 0 && search_oclc.length < 7) {
			$('#search_results_list_container').empty();
			$('#search_results').css('display','none');
			$('#message').empty().append("Please enter at least 7 characters in OCLC field.");
			$('#message_container').css('display','block');
		//Validate ISSN search term
		} else if (search_issn.length > 9)  {
			$('#search_results_list_container').empty();
			$('#search_results').css('display','none');
  		$('#message').empty().append("ISSN search term exceeds 9 characters - please re-enter.");
			$('#message_container').css('display','block');
		} else if (search_issn.length > 0 && search_issn.match(/[^\d|^x|^-]/i))  {
			//Only hyphen, numeric characters, and 'X' or 'x' are allowed in ISSN search term
  		$('#search_results_list_container').empty();
			$('#search_results').css('display','none');
  		$('#message').empty().append("Invalid character(s) in ISSN search term - please re-enter.");
			$('#message_container').css('display','block');
		} else if (search_issn.length > 0 && search_issn.length <= 9 && search_issn.match(/-[\d]{0,2}X$|X.+$/i))  {
			//If ISSN search term contains an 'X' or 'x', it must be in the last position
			//If ISSN search term fragment ends with an 'X' or 'x' and contains a hyphen, there must be exactly three numeric digits between them
  		$('#search_results_list_container').empty();
			$('#search_results').css('display','none');
  		$('#message').empty().append("ISSN search term has an alpha character in the wrong position - please re-enter.");
			$('#message_container').css('display','block');
		} else if (search_issn.length > 4 && search_issn.length < 8 && search_issn.search('-') == -1) {
			$('#search_results_list_container').empty();
			$('#search_results').css('display','none');
  		$('#message').empty().append("ISSN search terms between 5 and 7 characters in length must include a hyphen.");
			$('#message_container').css('display','block');
		} else if (search_issn.length == 9 && !(search_issn.match(/^([\d]{4}-([\d]{4}|[\d]{3}X))$/i))) {
			$('#search_results_list_container').empty();
			$('#search_results').css('display','none');
  		$('#message').empty().append("Invalid ISSN search term - please re-enter.");
			$('#message_container').css('display','block');
		} else if ( (search_from_year.length > 0) && (search_from_year.length != 4 || !($.isNumeric(search_from_year)) ) )  {
			$('#search_results_list_container').empty();
			$('#search_results').css('display','none');
			$('#message').empty().append("Please enter a four-digit year in 'From year' field.");
			$('#message_container').css('display','block');
		} else if ( (search_to_year.length > 0) && (search_to_year.length != 4  || !($.isNumeric(search_to_year)) ) ) {
			$('#search_results_list_container').empty();
			$('#search_results').css('display','none');
			$('#message').empty().append("Please enter a four-digit year in 'To year' field.");
			$('#message_container').css('display','block');
		} else {
			//It seems that valid search criteria have been entered
			//If user entered 8 numeric digits in ISSN searchbox, insert hyphen
			if (search_issn.length == 8 && search_issn.search('-') == -1) {
				search_issn = search_issn.substr(0,4) + '-' + search_issn.substr(4,4);
				$('#issn_searchbox').val(search_issn);
			}
			//Clear any existing search results and display animated loading gif while performing new search
			//if (sorting) {
			//	$('#search_results').css('height',tempSearchHeight);
			//}
			$('#search_results_list_container').empty();
			if (!sorting) {
				title_sort_type = 'title';
				title_sort_order = 'ascending';
				from_year_sort_order = 'descending';
				to_year_sort_order = 'descending';
				$('#search_results').css('height','');
				tempSearchHeight = '';
				$('#search_results').css('display','none');
				$('#message').empty().append('<div id="loading_titles"><p>Searching for titles&nbsp; . . . &nbsp;&nbsp;<img src="images/loading_titles.gif" /></p></div>');
				$('#message_container').css('display','block');
			}
			saveSearchState();
			$.ajax({
				type: "POST",
				url: "get_titles.php",
				data: {title: search_title,
							 lccn: search_lccn,
							 oclc: search_oclc,
							 issn: search_issn,
							 city: search_city,
							 state_country: search_state_country,
							 state_country_name: search_state_country_name,
							 search_language: search_language,
							 keyword: search_keyword,
							 from_year: search_from_year,
							 to_year: search_to_year},
				success: displayTitles,
				error: displayTimeoutMessage,
				// timeout: 5000,   # AJE 2014-08-14 there was a comma here like it shows ...
				// timeout: 10000,  # AJE 2015-08-13 why a comma ? and how weird that a year later ...
				timeout: 10000,
			});
		}
	}
}
function saveSearchState() {
	var tempFieldName = tempFieldValue = null;
	var today = new Date();
	if ($('#search_type_link').text() == 'Switch to advanced search') {
		setCookie('Search type', 'basic');
		setCookie('Basic search field',$('#basic_search_dropdown').val());

	} else if ($('#search_type_link').text() == 'Return to basic search') {
		setCookie('Search type', 'advanced');
		setCookie('State country',$('#state_country_dropdown').val());
		setCookie('search_language',$('#language_dropdown').val());
	}
	$('.searchbox').each(function( index ) {
		tempFieldName = $(this).attr('placeholder');
		tempFieldValue = $(this).val();
		if ($(this).attr('class').search('placeholder') == -1) {
			setCookie(tempFieldName, tempFieldValue);
		} else {
			deleteCookie(tempFieldName, new Date(today.getTime() - 24 * 3600 * 1000));
		}
	});
	return false;
}
function restoreSearchState() {
	if (getCookie('Search type') == 'advanced') {
		$('#search_type_link').text('Return to basic search');
		$('#title_and_keyword_search').css('display','block');
		$('#number_search').css('display','block');
		$('#location_year_search').css('display','block');
		$('#language_search').css('display','block');
		$('#basic_search').css('display','none');
		$('.searchbox[id!="basic_searchbox"]').each(function( index ) {
			//$('.searchbox').each(function( index ) {
			$(this).val(getCookie($(this).attr('placeholder')));
		});
		var today = new Date();
		deleteCookie('Enter search term',new Date(today.getTime() - 24 * 3600 * 1000));
		$('#basic_searchbox').val('');
		$('#state_country_dropdown').val(getCookie('State country'));
		$('#language_dropdown').val(getCookie('search_language'));
	} else if ( !(getCookie('Search type')) || (getCookie('Search type') == 'basic') ) {
		$('#search_type_link').text('Switch to advanced search');
		$('#title_and_keyword_search').css('display','none');
		$('#number_search').css('display','none');
		$('#location_year_search').css('display','none');
		$('#language_search').css('display','none');
		$('#basic_search').css('display','block');
		$('#basic_searchbox').val(getCookie('Enter search term'));
		$('#basic_search_dropdown').val(getCookie('Basic search field'));
	}
	return;
}
function populateCountryDropdown(results, textStatus) {
	var countryId = countryName = tempOption = null;
	var countryArray = JSON.parse(results);
	var stateCountryDropdown = $('#state_country_dropdown');
	var stateCountryOptions = stateCountryDropdown.attr('options');
	for (var i = 0; i < countryArray.length; i++) {
		countryId = countryArray[i].countryId;
		countryName = countryArray[i].countryName;
		$('#state_country_dropdown').append($('<option>', { value : countryId }).text(countryName));
	}
	//Restore selected state/country
	$('#state_country_dropdown').val(getCookie('State country'));
	if (getCookie('State country') == '0') {
		$('#state_country_dropdown').css('color','#999999');
	} else {
		$('#state_country_dropdown').css('color','#181818');
	}
	//Select search term textbox control
	$('#basic_searchbox').focus();
} // end populateCountryDropdown


function populateLanguageDropdown(results, textStatus) {
	var language_id = language_name = tempOption = null;
	var language_array = JSON.parse(results);
	var language_dropdown = $('#language_dropdown');
	var language_options = language_dropdown.attr('options');
	for (var i = 0; i < language_array.length; i++) {
		language_id = language_array[i].language_id;
		language_name = language_array[i].language_name;
		native_name = language_array[i].native_name;
		$('#language_dropdown').append($('<option>', { value : language_id }).text(language_name));
		$('#language_dropdown').append($('<option>', { value : language_id }).text(native_name));
	}
	//Restore selected language
	$('#language_dropdown').val(getCookie('search_language'));
  //console.warn('populateLanguageDropdown: getCookie("search_language") = ', getCookie('search_language'));
	if (getCookie('search_language') == '0') {
		$('#language_dropdown').css('color','#999999');
	} else {
		$('#language_dropdown').css('color','#181818');
	}
	//Select search term textbox control
	$('#basic_searchbox').focus();
} // end populateLanguageDropdown



function displayTitles(results, textStatus) {
	var pubId = pubTitle = pubCity = countryId = countryName = pubBgnDate = pubEndDate = tempHREF = language_name = null;
	var titleString = titleInfo = stateAbbrev = '';
	$('#message').empty();
	$('#message_container').css('display','none');
	$('#search_results_list_container').empty();
	if (results == "No results returned") {
		$('#message').append('Sorry, no matching titles were found in the ICON database.');
		$('#message_container').css('display','block');
		$('#search_results').css('display','none');
	} else if (results == "Too many titles to display") {
		//More than 500 titles match search criteria.  Ask user to refine query.
		$('#message').append('Sorry, more than 500 matching titles titles were found.  Please limit your search further.');
		$('#message_container').css('display','block');
		$('#search_results').css('display','none');
	} else {
		$('#message_container').css('display','none');
		$('#search_results').css('display','block');
		var titleArray = JSON.parse(results);
		/*alert("Go Red Sox! titleArray[0] = \n\n" +titleArray[0]);*/
		if (title_sort_type == 'title') {
			titleArray = titleArray.sort(compareTitles);
		} else if(title_sort_type == 'from_year') {
			titleArray = titleArray.sort(compareFromYears);
		} else if(title_sort_type == 'to_year') {
			titleArray = titleArray.sort(compareToYears);
		}
		titleString = '<ul id="search_results_list">';
		for (var i = 0; i < titleArray.length; i++) {
		  //alert("in the for loop displayTitles");
			titleInfo = '';
			pubId = titleArray[i].pubId;
			pubTitle = titleArray[i].pubTitle;
			pubCity = titleArray[i].pubCity;
			countryId = titleArray[i].countryId;
			countryName = titleArray[i].countryName;
			pubBgnDate = titleArray[i].pubBgnDate;
			pubEndDate = titleArray[i].pubEndDate;
			if (countryId.substr(2,1) == "u") {
				if (countryId != "nbu") {
					stateAbbrev = countryId.substr(0,2).toUpperCase();
				} else {
					stateAbbrev = "NE";
				}
				titleInfo = pubTitle + ' (' + pubCity + ', ' + stateAbbrev;
			} else {
				titleInfo = pubTitle + ' (' + pubCity + ', ' + countryName;
			}
			/*
			  AJE 2016-01-27
		    With new ISO dates (actually text, but formatted like ISO date)
		      in many publications.pub_bgnDate/publications.pub_bgnDate fields,
		      we still only want to show the 4-digit year portion in the list of results.
		    Use regex
			*/
			var ISOpattern = /\d{4}-\d{2}-\d{2}/i
			var pubBgnDate_display = '';
			var pubEndDate_display = '';
			if (ISOpattern.test(pubBgnDate)) {
			  pubBgnDate_display = pubBgnDate.substr(0,4);
        //console.info('MATCH pubBgnDate = ', pubBgnDate, ' ; pubBgnDate_display = ', pubBgnDate_display);
			} else {
			  pubBgnDate_display = pubBgnDate;
        //console.info('no match pubBgnDate = ', pubBgnDate, ' ; pubBgnDate_display = ', pubBgnDate_display);
			}
			if (ISOpattern.test(pubEndDate)) {
			  pubEndDate_display = pubEndDate.substr(0,4);
        //console.info('no match pubEndDate = ', pubEndDate, ' ; pubEndDate_display = ', pubEndDate_display);
			} else {
			  pubEndDate_display = pubEndDate;
        //console.info('no match pubEndDate = ', pubEndDate, ' ; pubEndDate_display = ', pubEndDate_display);
			}
			//if (pubBgnDate == pubEndDate) { // original 2016-01-27 AJE changed
			if (pubBgnDate_display == pubEndDate_display) {
				//titleInfo += ': published ' + pubBgnDate + ')'; // original 2016-01-27 AJE changed
				titleInfo += ': published ' + pubBgnDate_display + ')';
			} else {
				//titleInfo += ': published ' + pubBgnDate + ' to ' + pubEndDate + ')'; // original 2016-01-27 AJE changed
				titleInfo += ': published ' + pubBgnDate_display + ' to ' + pubEndDate_display + ')';
			}
			//tempHREF = "/ICON/calendar.php?pub_id=" + pubId; // 2014-04-04 AJE reconfigured AWS server
			tempHREF = "calendar.php?pub_id=" + pubId;
			titleString += '<li><a href="' + tempHREF + '">' + titleInfo +'</a></li>'

		}
		//To prevent flicker when sorting, maintain current height of search_results element
		if (sorting) {
			tempSearchHeight = $('#search_results').css('height');
			tempSearchHeight = parseInt(tempSearchHeight) + 4;
			tempSearchHeight = tempSearchHeight + "px";
			$('#search_results').css(tempSearchHeight);
		} else {
			$('#search_results').css('height','');
			tempSearchHeight = '';
		}
		titleString += '</ul>';
		//setCookie('Title results', titleString);
		$('#search_results_list_container').append(titleString);
		$('#search_results_list li:odd a').css('backgroundColor','#F0F0F0');
	}
	sorting = false;
}
function displayTimeoutMessage(results, textStatus, errorThrown) {
	if (errorThrown == "timeout") {
		$('#message').empty();
		$('#search_results_list_container').empty();
		$('#message').append('Sorry, there are too many titles to display. Please limit your search further.');
		$('#message_container').css('display','block');
	}
}
function sortAssociativeArray(arrayArg) {
	var tuples = [];
	for (var key in arrayArg) tuples.push([key, arrayArg[key]]);
	tuples.sort(function(a, b) {
		a = a[1];
		b = b[1];
		return a < b ? -1 : (a > b ? 1 : 0);
	});
	return tuples;
}
function compareTitles(a,b) {
	if (title_sort_order == 'ascending') {
		if (a.pubTitle.toLowerCase()>b.pubTitle.toLowerCase()) {
			return 1;
		} else if (b.pubTitle.toLowerCase()>a.pubTitle.toLowerCase()) {
			return -1;
		} else if (a.pubTitle.toLowerCase()==b.pubTitle.toLowerCase()) {
			return 0;
		}
	} else if (title_sort_order == 'descending') {
		if (a.pubTitle.toLowerCase()>b.pubTitle.toLowerCase()) {
			return -1;
		} else if (b.pubTitle.toLowerCase()>a.pubTitle.toLowerCase()) {
			return 1;
		} else if (a.pubTitle.toLowerCase()==b.pubTitle.toLowerCase()) {
			return 0;
		}
	}
}
function compareFromYears(a,b) {
	//Sort by pubBgnDate, then by pubEndDate
  var fromYear1 = a.pubBgnDate;
  var fromYear2 = b.pubBgnDate;
  var toYear1 = a.pubEndDate;
  var toYear2 = b.pubEndDate;
  if (from_year_sort_order == 'ascending') {
	  if (fromYear1 != fromYear2) {
	    if (fromYear1 < fromYear2) return -1;
	    if (fromYear1 > fromYear2) return 1;
	    return 0;
	  }
	  if (toYear1 < toYear2) return -1;
	  if (toYear1 > toYear2) return 1;
	  return 0;
	} else if (from_year_sort_order == 'descending') {
		if (fromYear1 != fromYear2) {
	    if (fromYear1 < fromYear2) return 1;
	    if (fromYear1 > fromYear2) return -1;
	    return 0;
	  }
	  if (toYear1 < toYear2) return 1;
	  if (toYear1 > toYear2) return -1;
	  return 0;
	}
 }
function compareToYears(a,b) {
	//Sort by pubBgnDate, then by pubEndDate
  var toYear1 = a.pubEndDate;
  var toYear2 = b.pubEndDate;
  var fromYear1 = a.pubBgnDate;
  var fromYear2 = b.pubBgnDate;
  if (to_year_sort_order == 'ascending') {
	  if (toYear1 != toYear2) {
	    if (toYear1 < toYear2) return -1;
	    if (toYear1 > toYear2) return 1;
	    return 0;
	  }
	  if (fromYear1 < fromYear2) return -1;
	  if (fromYear1 > fromYear2) return 1;
	  return 0;
	} else if (to_year_sort_order == 'descending') {
		if (toYear1 != toYear2) {
	    if (toYear1 < toYear2) return 1;
	    if (toYear1 > toYear2) return -1;
	    return 0;
	  }
	  if (fromYear1 < fromYear2) return 1;
	  if (fromYear1 > fromYear2) return -1;
	  return 0;
	}
 }
function setCookie(c_name,value,exdays) {
	var expdate = new Date();
	expdate.setDate(expdate.getDate() + exdays);
	var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires="+expdate.toUTCString());
	document.cookie = c_name + "=" + cookieValue;
}
function getCookie(c_name) {
	var c_value = document.cookie;
	var c_start = c_value.indexOf(" " + c_name + "=");
	if (c_start == -1) {
		c_start = c_value.indexOf(c_name + "=");
	}
	if (c_start == -1) {
		c_value = null;
	} else {
	  c_start = c_value.indexOf("=", c_start) + 1;
	  var c_end = c_value.indexOf(";", c_start);
	  if (c_end == -1) {
			c_end = c_value.length;
		}
		c_value = unescape(c_value.substring(c_start,c_end));
	}
	return c_value;
}
function checkCookies() {
  var fieldNameArray = ['Title','Keyword','LCCN','OCLC','ISSN','City','From year','To year'];
  //for (var i = 0; i < fieldNameArray.length; i++) {
	//	console.log(fieldNameArray[i] + ' ' + getCookie(fieldNameArray[i]));
	//}
}
function clearCookies() {
	//var fieldNameArray = ['Title','Keyword','LCCN','OCLC','ISSN','City','From year','To year'];
	var fieldNameArray = ['Search type','Enter search term','Title results','Title','Keyword','LCCN','OCLC','ISSN','City','From year','To year'];
	var today = new Date();
	var expired = new Date(today.getTime() - 24 * 3600 * 1000); // less 24 hours
	for (var i = 0; i < fieldNameArray.length; i++) {
		deleteCookie(fieldNameArray[i],expired);
	}
	deleteCookie('Basic search field',expired);
	deleteCookie('State country',expired);
	deleteCookie('lastSQLquery',expired);
}
function deleteCookie(name,expDate) {
	document.cookie=name + "=null; path=/; expires=" + expDate.toGMTString();
}