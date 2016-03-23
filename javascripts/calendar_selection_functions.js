/****************************************************************

  2015-02-09:   calendar_selection_functions.js is included in calendar.php
  2015-02-09:   this file underwent major reorganization



****************************************************************/


/****************************************************************
 GLOBAL VARIABLES
****************************************************************/
var pubFormatsArray = []; // AJE 2013-11-22 Array to be filled in display_formats_list + used in googleChartsAPIfunctions.js

var holders_org_ids = []; // AJE 2013-11-12 Array to be filled in display_orgs_list + used by appendOrgsArrayIssues + 2014-09-11 used by display_orgs_list to show CRL eDesiderata profile link
var holders_org_names = []; // AJE 2013-11-19 same as abv
var orgsArrayIssues = [];     // AJE 2013-11-12 Array to be filled in display_orgs_list + passed to Google charts

// AJE 2015-02-06 populateIssueCountAndMinMaxYears will fill next group of variables
var num_valid_issues = -1;
var num_distinct_issues = -1;
var MINissue_date = '-1';
var MAXissue_date = '-1';
var MINissue_year = '-1';
var MAXissue_year = '-1';

var load_calendar_gif = '<img src="images/loading-calendar.gif" />';
var no_holdings_div = '<div id="holdings_info_container" class="five columns"><ul><li id="holdings_info_heading" style="font-weight: bold; text-align: right;">NO ICON HOLDINGS</li></div>';
var no_issues_para = '<p>Sorry, there are no issues in ICON for this title.</p>';

/****************************************************************
 JQuery INITIALIZATION FUNCTION
****************************************************************/
$(function() {
	//Detect whether browser is IE
	ie = /*@cc_on!@*/false;
	//If IE, detect and store whether version is ie10
	//See advantages of this method at http://stackoverflow.com/questions/9900311/how-do-i-target-only-internet-explorer-10-for-certain-situations-like-internet-e
	if (ie) {
		if (Function('/*@cc_on return document.documentMode===10@*/')()){
    	document.documentElement.className+=' ie10';
		}
	}
	//Remove anchor tag from URL bar, if any. Populated when user clicks on a tab. AJE noticed that presence of anchor tag increases load time.
	var tempURL = window.location.toString();
	if (tempURL.search('#') != -1) {
		tempURL = tempURL.split('#')[0];
		window.location = tempURL;
	}
	selectedPubIdWithoutSpace = unescape(selectedPubIdWithoutSpace);
	selectedPubId = selectedPubId.replace('%20', '');

	$.get("get_publication_info.php", { 'pub_id': selectedPubIdWithoutSpace }, display_title_info);

	// AJE 2015-10-13 new : in collections.js
	$.get("get_collection_list.php", { 'pub_id': selectedPubIdWithoutSpace }, display_collection_info);
	// AJE 2015-10-13 new end

	//Genealogy information is now retrieved in collapsible_tree_functions.js
	$('#loading-issue-info').attr('class', 'loading-issue-info-visible');
	$('#loading-organization-info').attr('class', 'loading-organization-info-visible');
	populateStartupMonths();
	//Change year via dropdown
	$('#year_option').change(function() {
		$('#issue_date_header').html('').css('display','none');
		$('#pub_tabs dd a')[0].text = 'Issue Information';
		$('#inner_issue_info_display').html('').hide();
		$('#loading-issue-info').attr('class', 'loading-issue-info-visible');
		clearAvailableMonths();
		clearOrganizationInfo();
		changeYearFlag = true;
		selectedYear = $('#year_option :selected').text();
		whiteOutCalendar();
		styleAvailableMonthBoxes();
		$('option:selected').css('backgroundColor', '#00224C').css('color', '#dfe2e6').css('fontWeight', 'bold');
		$('option:not(:selected)').css('backgroundColor', '#BFCCA8').css('color','#00224C').css('fontWeight', 'normal');
		$('.count[id="year'+selectedYear+'"]').css('backgroundColor','#00224C');
		$('.count:not([id="year'+selectedYear+'"])').css('backgroundColor','#BFCCA8');
	});	$('.month_box').addClass('month_box_not_available');
	$('.month_box').click(function() {
		$('option:selected').css('backgroundColor', '#00224C').css('color', '#dfe2e6').css('fontWeight', 'bold');
		$('option:not(:selected)').css('backgroundColor', '#BFCCA8').css('color','#00224C').css('fontWeight', 'normal');
		clearOrganizationInfo();
		//Clear and hide issue info display
		$('#issue_date_header').html('').css('display','none');
		$('#pub_tabs dd a')[0].text = 'Issue Information';
		$('#breadcrumb_container').css('display','none');
		$('#inner_issue_info_display').html('').hide();
		$('#loading-issue-info').attr('class', 'loading-issue-info-visible');
		//Deselect all other available month boxes
		var tempMonthBoxId = tempMonthBox = null;
		for (var m in availableMonths) {
			tempMonthBoxId = availableMonths[m];
			tempMonthBox = $('#month_control_wrapper').find('#' + tempMonthBoxId);
			tempMonthBox[0].className = "month_box month_box_available";
		}
		//Apply 'selected' class to this month box if there are available issues
		var tempClass = this.className;
		if (tempClass.search('month_box_available') != -1) {
			this.className = 'month_box month_box_available month_box_selected';
		}
		selectedMonth = this.id;
		selectedMonth = getMonthNumber(selectedMonth);
		whiteOutCalendar();
		populateAvailableDays();
	});
	$('#datepicker_container').delegate('.ui-icon-circle-triangle-w', 'click', function() {
		//'Previous' arrow in calendar control
		//Move back one month
		changeYearFlag = false;
		$('#inner_issue_info_display').html('').hide();
		if (selectedMonth == 0) {
			//Year is about to change, so make sure it is within holdings range
			if (parseInt(selectedYear,10) - 1 >= minHoldingsYear) {
				selectedMonth = 11;
				selectedYear = parseInt(selectedYear,10) - 1;
				if (getObjects(issueCounts, 'year', selectedYear)[0]) {
					//There are holdings for this year, so highlight timeline bar
					$('.count[id="year'+selectedYear+'"]').css('backgroundColor','#00224C');
					$('.count:not([id="year'+selectedYear+'"])').css('backgroundColor','#BFCCA8');
				}
			}
		} else {
			selectedMonth = selectedMonth - 1;
		}
		if (getObjects(issueCounts, 'year', selectedYear)[0]) {
			//There are holdings for this year, so style calendar controls accordingly
			clearAvailableMonths();
			styleAvailableMonthBoxes();
			var tempMonthBox = document.getElementById(monthNameArray[selectedMonth]);
			//Apply 'selected' class to this month box if there are available issues
			var tempClass = tempMonthBox.className;
			if (tempClass.search('month_box_available') != -1) {
				tempMonthBox.className = 'month_box month_box_available month_box_selected';
			}
		}
	});
	$('#datepicker_container').delegate('.ui-icon-circle-triangle-e', 'click', function() {
		//'Next' arrow in calendar control
		//Move ahead one month
		changeYearFlag = false;
		$('#inner_issue_info_display').html('').hide();
		if (selectedMonth == 11) {
			//Year is about to change, so make sure it is within holdings range
			if (parseInt(selectedYear,10) + 1 <= maxHoldingsYear) {
				selectedMonth = 0;
				selectedYear = parseInt(selectedYear,10) + 1;
				if (getObjects(issueCounts, 'year', selectedYear)[0]) {
					//There are holdings for this year, so highlight timeline bar
					$('.count[id="year'+selectedYear+'"]').css('backgroundColor','#00224C');
					$('.count:not([id="year'+selectedYear+'"])').css('backgroundColor','#BFCCA8');
				}
			}
		} else {
			selectedMonth = selectedMonth + 1;
		}
		if (getObjects(issueCounts, 'year', selectedYear)[0]) {
			//There are holdings for this year, so style calendar controls accordingly
			clearAvailableMonths();
			styleAvailableMonthBoxes();
			var tempMonthBox = document.getElementById(monthNameArray[selectedMonth]);
			//Apply 'selected' class to this month box if there are available issues
			var tempClass = tempMonthBox.className;
			if (tempClass.search('month_box_available') != -1) {
				tempMonthBox.className = 'month_box month_box_available month_box_selected';
			}
		}
	});
	//Change year via timeline bar click
	$(".timeline").delegate('.count', 'click', function(){
		$('#issue_date_header').html('').css('display','none');
		$('#pub_tabs dd a')[0].text = 'Issue Information';
		$('#inner_issue_info_display').html('').hide();
		$('#loading-issue-info').attr('class', 'loading-issue-info-visible');
		$('#year_option').attr('disabled', true);
		clearOrganizationInfo();
		clearAvailableMonths();
		changeYearFlag = true;
		selectedYear = $(this).attr('id').replace('year','');
		whiteOutCalendar();
		styleAvailableMonthBoxes();
		$('option:selected').css('backgroundColor', '#00224C').css('color', '#dfe2e6').css('fontWeight', 'bold');
		$('option:not(:selected)').css('backgroundColor', '#BFCCA8').css('color','#00224C').css('fontWeight', 'normal');
		$('.count[id="year'+selectedYear+'"]').css('backgroundColor','#00224C');
		$('.count:not([id="year'+selectedYear+'"])').css('backgroundColor','#BFCCA8');
		//Reapply bottom border to last bar in each decade
		$('.count').filter(function() {
			return this.id.match(/9$/);
		}).css('border-bottom', '1px solid #A8A8A5');
	});
	$(".timeline").delegate('.count', 'mouseover', function(){
		//Bar turns orange on mouseOver event
		$(this).css('backgroundColor', '#E97100');
	});
	$(".timeline").delegate('.count', 'mouseout', function(){
		//Bar returns to normal color when not hovered over
		//COLOR MUST BE CONDITIONAL ON WHETHER OR NOT IT'S THE SELECTED YEAR!!
		if ($(this).attr('id').search(selectedYear) != -1) {
			$(this).css('backgroundColor', '#00224C').css('border', 'none');
		} else {
			$(this).css('backgroundColor', '#BFCCA8').css('border', 'none');
		}
		//Reapply bottom border to last bar in each decade
		$('.count').filter(function() {
			return this.id.match(/9$/);
		}).css('border-bottom', '1px solid #A8A8A5');
	});



	/*
	  2015-02-09 : AJE : see backup drive, calendar_selection_functions_init_populateFilteredIssues.js
	  for orphaned code from here
	*/

	$('.page_link').click(function() {
		$('.page_link').css('fontWeight', 'normal');
		$(this).css('fontWeight', 'bold');
	});
	$('#new_search_button').click(function(){
		window.location='search.php';
	})
}); // end INITIALIZATION function



/*
  AJE 2015-02-06: REMOVED jQuery paginateTable() plugin code section to new file: paginate_table_unused.js
*/




/*
2014-09-24 : AJE : finishInitialization has been restructured:
  - it handles both no issue cases and regular populated cases
  - copied this from initializeGenealogyVisualization:
  - we're not calling genealogy for like a year now and can avoid that query
*/
function finishInitialization() {
	if (issueCounts == null) {
		$.get("get_zero_date_issues.php", { 'selectedPubId': selectedPubId }, display_issue_info_NO_issues);
		$('#holdings_info_container').remove();
		$('#bib_id_holdings_row').append( no_holdings_div );
		$('#loading-calendar').html( no_issues_para );
		$('#loading-issue-info').hide();
		$('#loading-organization-info').hide();
		$('#loading-format-info').hide();
		$('#sidebar_charts').css('display', 'none');
  }//end if no valid issues
  else { // AJE 2014-09-24: there are valid issues
		startupFlag = true;
		yearBox = document.getElementById("year_option");
		selectedYear = issueCounts[0].year;
		//Populate barchart timeline
		displayDecadesBarchart();
		//Populate an array with available months for first available year
		//Month box and calendar controls are populated in the callback
		styleAvailableMonthBoxes();
    $('#tab_container').show();
  }//end else: there are valid issues
} // end finishInitialization **********************************/



/****************************************************************
 BEGIN functions handling LOAD + DISPLAY of PUBLICATIONS DATA: the BIBLIOGRAPHIC DATA
****************************************************************/

function display_title_info(titleJSON, textStatus) { //  callback for get_publication_info.php
	if ((titleJSON.search(/Error/i) != -1) || (titleJSON.search(/\<b>Notice/i) != -1 )) {
		document.writeln(titleJSON);
	} else {
		var tempPubId = tempPubTitle = tempDisplayTitle = tempPubTitleAlt = tempPubCity = tempPubState = tempCountry = tempFrequencyIdCode = null;
		var tempISSN = tempOCLC = null;
		var tempPubBgnDate = tempPubEndDate = tempDate260C = tempDate362 = tempFrequency310 = tempFormerFrequency321 = null;
		var language_information = null;
		var tempNumberingNote515 = tempSummary520 = tempDescriptionNote588 = tempBibRelationships = null;
		var tempRefDataBody = tempRefDataTitle = tempRefDataURI = tempRefSourceTitle = tempShowFullText = null;
		var addRefString = '';
		var tempTitleParts = [];
		var shortenTitle = false;
		var tempMoreLink = null;
		var titleDisplayString = '';
		var locationString = '';

		var data = JSON.parse(titleJSON);
		/*
		if (data) console.log("have data, YAY!\n", data);
		if (!data) console.warn("data is null or some !not!\nBOO");
		*/
		//if (data.pubTitle == "") {
		if (!data) {
			$('#title_location').append('<div id="message" style="padding: 10px;">Sorry, this title does not appear in the ICON database.</div>');
			$('#loading-issue-info').hide();
			$('#loading-organization-info').hide();
			$('#loading-format-info').hide();
			$('#sidebar_charts').css('display', 'none');
		} else {
			/*
			  AJE REPLACED THIS: 2013-08-14
			  in June Amy wanted to skip the 'oc' prefix on OCLC numbers,
			  but fact is that not displaying 'oc' will make it impossible for them to use the pub_id in any searches
			  // tempPubId = data.pubId.replace(/oc./g,''); //OLD CJ
			 */
			tempPubId = data.pubId; //NEW AJE
			tempOCLC = data.OCLC.replace(/oc./g,'');
			//CFJ - 05-31-13 - Delete leading zero from OCLC number at Amy's request
			tempOCLC = tempOCLC.replace(/^0/g,'');
			tempMarc001 = data.marc001.replace(/\\/g,'');
			tempISSN = data.ISSN;
			tempPubTitle = data.pubTitle;
			document.title = document.title + " for " + tempPubTitle;
			tempPubTitleAlt = data.pubTitleAlt;
			tempPubCity = data.pubCity;
			tempPubState = data.countryId.substr(0,2).toUpperCase();
			if (data.countryId.length == 3 && data.countryId.substr(2,1) == 'U' && data.countryId.substr(2,1) == 'C') {
				//Country is US or Canada
				tempCountry = data.countryId.substr(2,1);
			} else {
				//Other country
				tempCountry = data.countryName;
			}

			tempPubBgnDate = data.pubBgnDate;
			tempPubEndDate = data.pubEndDate;
			tempDate260C = data.date260C;
			tempDate260C = tempDate260C.replace(/</g,'&lt;');
			tempDate260C = tempDate260C.replace(/>/g,'&gt;');

			tempDate362 = data.date362;
			if (tempDate362 != null) {
				tempDate362 = tempDate362.replace(/</g,'&lt;');
				tempDate362 = tempDate362.replace(/>/g,'&gt;');
			}

			tempFrequencyIdCode = data.frequencyIdCode;
			tempFrequency310 = data.frequency310;
			tempFrequency310 = tempFrequency310.replace(/</g,'&lt;');
			tempFrequency310 = tempFrequency310.replace(/>/g,'&gt;');
			tempFormerFrequency321 = data.formerFrequency321;
			tempFormerFrequency321 = tempFormerFrequency321.replace(/</g,'&lt;');
			tempFormerFrequency321 = tempFormerFrequency321.replace(/>/g,'&gt;');

      language_information = '<li class="non-table_list_item">Language: <a href="display_publications_by_language.php?language_name=';
      language_information += data.language_name + '" target="_blank">' +data.language_name;
      if((data.native_name) && (data.native_name != data.language_name)) language_information += ' ; ' + data.native_name + '</a></li>';
      //console.info(' HEY language_information = ', language_information);

			tempNumberingNote515 = data.numberingNote515;
			if (tempNumberingNote515 != null) {
				tempNumberingNote515 = data.numberingNote515;
				tempNumberingNote515 = tempNumberingNote515.replace(/</g,'&lt;');
				tempNumberingNote515 = tempNumberingNote515.replace(/>/g,'&gt;');
			}
			tempSummary520 = data.summary520;
			tempDescriptionNote588 = data.descriptionNote588;
			tempBibRelationships = data.bib_relationships;
			tempRefDataBody = data.refDataBody;
			tempRefDataTitle = data.refDataTitle;
			tempRefDataURI = data.refDataURI;
			tempRefSourceTitle = data.refSourceTitle,
			tempShowFullText = data.showFullText;

			//Build location display string
			if (tempCountry == 'u' || tempCountry == 'c') {
				//US or Canada, so display city and state but not country name
				locationString += tempPubCity + ', ' + tempPubState;
			} else {
				//Other country, so display city and country name, but not state
				locationString += tempPubCity + ', ' + tempCountry;
			}
			$('#location_container').append(locationString);

			//At startup, display only title proper
			if (tempPubTitle.match(/^[^=]*:/)) {
				//Alt title precedes subtitle
				tempTitleParts = tempPubTitle.split(' :');
				tempDisplayTitle = tempTitleParts[0];
				shortenTitle = true;
			} else if (tempPubTitle.match(/^[^:]*=/)) {
				//Subtitle precedes alt title
				tempTitleParts = tempPubTitle.split(' =');
				tempDisplayTitle = tempTitleParts[0];
				shortenTitle = true;
			} else {
				//No subtitle or alt title
				tempDisplayTitle = tempPubTitle;
				shortenTitle = false;
			}
			$('#title_span').text(tempDisplayTitle);
			//Hide or display 'show more' element as necessary
			if (shortenTitle) {
				$('#more_span').css('visibility','visible');
			} else {
				$('#more_span').css('visibility','hidden');
			}
			tempMoreLink = document.getElementById('more_link');
			tempMoreLink.onclick = function() {
				if(this.textContent == "more ...") {
					this.textContent = "less ...";
					$('#title_span').text(tempPubTitle);
				} else {
					this.textContent = "more ...";
					$('#title_span').text(tempDisplayTitle);
				}
			}

      // AJE 2015-10-13 : gave generic UL an ID attribute
			//publicationInformationString += '<div class="title_section_first"><div class="title_heading" style="margin-top: 0px;">PUBLICATION INFORMATION:</div><ul>';
			publicationInformationString += '<div class="title_section_first"><div class="title_heading" style="margin-top: 0px;">PUBLICATION INFORMATION:</div><ul id="pub_info_first_list">';
			if (tempFrequency310 != '') {
				publicationInformationString += '<li class="non-table_list_item">Frequency: ' + tempFrequency310 + '</li>';
			}
			if (tempFormerFrequency321 != '') {
				publicationInformationString += '<li class="non-table_list_item">Former frequency: ' + tempFormerFrequency321 + '</li>';
			}
			//Publication dates
			if (tempDate362 != '' && tempDate362 != null) {
				publicationInformationString += '<li class="non-table_list_item">' + tempDate362 + '</li>';
			} else if (tempDate260C != '') {
				if (tempDate260C.search(/^-/) != -1) {
					publicationInformationString += '<li class="non-table_list_item">' + tempPubBgnDate + tempDate260C + '</li>';
				} else if (tempDate260C.search(/-$/) != -1){
					publicationInformationString += '<li class="non-table_list_item">' + tempDate260C + tempPubEndDate + '</li>';
				} else {
					publicationInformationString += '<li class="non-table_list_item">BEGIN: ' + tempPubBgnDate + '</li>' +
											                    '<li class="non-table_list_item">END: ' + tempPubEndDate + '</li>' +
										                      '<li class="non-table_list_item">DATE 260C: ' + tempDate260C + '</li>';
				}
			} else if ((tempPubBgnDate != '') || (tempPubEndDate != '')) {
				publicationInformationString += '<li class="non-table_list_item">BEGIN: ' + tempPubBgnDate + '</li>' +
										  '<li class="non-table_list_item">END: ' + tempPubEndDate + '</li>';
			}
			//publicationInformationString += '</ul></div>';
			if ( (tempNumberingNote515 != '' && tempNumberingNote515 != null ) || (tempSummary520 != '' && tempSummary520 != null)
			     || (tempDescriptionNote588 != '' && tempDescriptionNote588 != null) ||  (tempBibRelationships != '' && tempBibRelationships != null)) {
				//publicationInformationString += '<div class="title_section"><div class="title_heading">NOTES:</div><ul>';
				if (tempNumberingNote515 != '' && tempNumberingNote515 != null) {
					publicationInformationString += '<li class="non-table_list_item">' + tempNumberingNote515 + '</li>';
				}
				if (tempSummary520 != '' && tempSummary520 != null) {
					publicationInformationString += '<li class="non-table_list_item">' + tempSummary520 + '</li>';
				}
				if (tempDescriptionNote588 != '' && tempDescriptionNote588 != null) {
					publicationInformationString += '<li class="non-table_list_item">' + tempDescriptionNote588 + '</li>';
				}
				if (tempBibRelationships != '' && tempBibRelationships != null) {
					publicationInformationString += '<li class="non-table_list_item">' + tempBibRelationships + '</li>';
				}
			}
			if (tempRefDataURI != '' && tempRefDataURI != null) {
				//If available, display additional reference information for title
				if (tempShowFullText == "1") {
					//Display additional reference text as well as link
					addRefString = '<li class="non-table_list_item">From <a href="' + tempRefDataURI + '" id="add_ref_link" target="_blank">' + tempRefSourceTitle + '</a>: ' + tempRefDataBody + '</li>';
				} else {
					//Display additional reference link only
					addRefString = '<li class="non-table_list_item">Related title on ' + tempRefSourceTitle + ': <a href="' + tempRefDataURI + '" id="add_ref_link" target="_blank">' + tempRefDataTitle +  '</a></li>';
				}
				publicationInformationString += addRefString;
			}

			if(language_information != ''){
        publicationInformationString += language_information;
			}

			publicationInformationString += '</ul></div>';

			//Display IDs in a table.  Foundation columns leave too much space between labels and values.
			bibIdString = '<ul><li><table id="id_table"><tr><td class="id_label" colspan=2>Bibliographic identifiers:</td></tr>';
			bibIdString += '<tr><td class="id_label">ICON ID:</td><td class="id_value">' + tempPubId + '</td></tr>';
			if (tempMarc001.search(';') != -1) {
				//Delete spaces before semicolons
				tempMarc001 = tempMarc001.replace(/\s;/g,';');
				//Want to display only LCCNs in this field, so suppress values containing 'MWA', 'mwa', 'oc', or 'ISSN'
				var originalMarc001Array = tempMarc001.split('; ');
				var goodMarc001Array = new Array();
				$.each(originalMarc001Array, function(index, value) {
					if (value.search(/oc.|mwa|ISSN/ig) == -1) {
						goodMarc001Array.push(value);
					}
				});
				bibIdString += '<tr><td class="id_label">Other identifier:</td><td class="id_value">' + goodMarc001Array.join('; ') + '</td></tr>';
			}
			if (tempOCLC.length > 0) {
				if (tempOCLC.search(';') != -1) {
					//Delete spaces before semicolons
					tempOCLC = tempOCLC.replace(/\s;/g,';');
				}
				bibIdString += '<tr><td class="id_label">OCLC:</td><td class="id_value">' + tempOCLC + '</td></tr>';
			}
			if (tempISSN.length > 0) {
				if (tempISSN.search(';') != -1) {
					//Delete spaces before semicolons
					tempISSN = tempISSN.replace(/\s;/g,';');
				}
				bibIdString += '<tr><td class="id_label">ISSN:</td><td class="id_value">' + tempISSN + '</td></tr>';
			}
			bibIdString += '</table></li></ul>';
			bibIdString += '</li></ul></div>';

			$('#title_info_container').append('<div class="row" id="title_info_row"><div id="title_info">' + publicationInformationString + '</div></div>');
			$('#title_info_container').append('<div class="row" id="bib_id_holdings_row"><div id="bib_id_container" class="six columns">' + bibIdString + '</div></div>');

			// AJE 2015-10-13 add a space for collection_list once AJAX processing is done ;
			//  LATER: fits better elsewhere, forget it
			//$('#title_info_row').append('<div class="row" id="collections_container_row"><div id="collections_container" class="six columns">&nbsp;</div></div>');

			$('#bib_id_holdings_row').append('<div id="holdings_info_container" class="five columns"><ul><li id="holdings_info_heading">Searching for issues&nbsp;...<img src="images/loading-calendar.gif" /></li></ul></div>');

			update_progress_message('formats');
			$.get("get_formats_calendar.php", { }, populateStaticFormats);

		} // end else: data.pubTitle exists
	} // end else: there are no errors in the JSON
} // end function display_title_info


function populateStaticFormats(staticFormatsJSON, textStatus) {
		if ((staticFormatsJSON.search(/Error/i) != -1) || (staticFormatsJSON.search(/\<b>Notice/i) != -1 )) {
		document.writeln(staticFormatsJSON);
	} else {
		var data = JSON.parse(staticFormatsJSON);
		staticFormats = data;
		update_progress_message('condition');
		$.get("get_conditions_calendar.php", { }, populateStaticConditions);
	}
} // end populateStaticFormats *********************************/



function populateStaticConditions(staticConditionJSON, textStatus) {
		if ((staticConditionJSON.search(/Error/i) != -1) || (staticConditionJSON.search(/\<b>Notice/i) != -1 )) {
		document.writeln(staticConditionJSON);
	} else {
		var data = JSON.parse(staticConditionJSON);
		staticConditions = data;
		update_progress_message( 'archive status' );
		$.get("get_archiveStatus_calendar.php", { }, populateStaticArchiveStatuses);
	}
} // end populateStaticConditions ******************************/



function populateStaticArchiveStatuses(archiveStatusJSON, textStatus) {
		if ((archiveStatusJSON.search(/Error/i) != -1) || (archiveStatusJSON.search(/\<b>Notice/i) != -1 )) {
		document.writeln(archiveStatusJSON);
	} else {
		var data = JSON.parse(archiveStatusJSON);
		staticArchiveStatuses = data;
		update_progress_message('organizations');
		$.get("get_distinct_organizations_calendar.php", { 'selectedPubId': selectedPubId }, populateStaticOrganizations);
	}
} // end populateStaticArchiveStatuses ******************************/



function populateStaticOrganizations(staticOrgsJSON, textStatus) {
		if ((staticOrgsJSON.search(/Error/i) != -1) || (staticOrgsJSON.search(/\<b>Notice/i) != -1 )) {
		document.writeln(staticOrgsJSON);
	} else {
		var data = JSON.parse(staticOrgsJSON);
		staticOrganizations = data;
      //console.info('AJE 2016-02-08 staticOrganizations = ', staticOrganizations);
      //  2015-02-06 new script: get total number of issues from separate (not the main 'issues') table
    $.get("get_issue_count_minmax_dates.php", { 'selectedPubId': selectedPubId }, populateIssueCountAndMinMaxYears);
      // next is the important one
		$.get("get_all_issues.php", { 'selectedPubId': selectedPubId }, populateAllIssues);
	}
} // end populateStaticOrganizations ***************************/



function toggleFullTitle() { // whether to show or hide data from alternate title fields
	if ($('#toggle_full_title').text() == "more ...") {
		$('#toggle_full_title').text("less ...");
	} else {
		$('#toggle_full_title').text("more ...");
	}
} // end toggleFullTitle

/****************************************************************
 END functions handling DISPLAY of PUBLICATIONS DATA: the BIBLIOGRAPHIC DATA
****************************************************************/

/*******************************************************************************/


/****************************************************************
 BEGIN functions handling ACTUAL DISPLAY of CALENDAR + TABS: the ISSUE DATA
****************************************************************/

/*
  2015-02-09 update_progress_message is new: display a string to show loading progress
*/
function update_progress_message( load_waiting ){

  if (( load_waiting == 'format') ||
      ( load_waiting == 'condition') ||
      ( load_waiting == 'archive status') ||
      ( load_waiting == 'organizations')
      ){
    holdingsInfoString = '<ul><li id="holdings_info_heading">Load ' +load_waiting+ ' data&nbsp;...'+ load_calendar_gif+ '</li></ul>';
  } else if (load_waiting == 'issues') {
    holdingsInfoString = '<ul><li id="holdings_info_heading">Load ' +addCommasToNumString(num_valid_issues)+ ' individual issues&nbsp;...</li></ul>';
  }
  $('#holdings_info_container').empty();
  //<div id="holdings_info_container" class="five columns"><ul><li id="holdings_info_heading">Searching for issues&nbsp; . . . &nbsp;&nbsp<img src="images/loading-calendar.gif" /></li></ul></div>
  $('#holdings_info_container').html(holdingsInfoString);
  //$('#holdings_info_container').append(holdingsInfoString);

} // end update_progress_message



/*
2013-11-11 :
  appendOrgsArrayIssues: callback for get_org_issues_for_pub.php, which gets number of issues of publication held by specific organization
  appendOrgsArrayIssues: helper function for display_orgs_list
*/
function appendOrgsArrayIssues(orgsArrayJSON, textStatus) {
  //console.info('appendOrgsArrayIssues: ', orgsArrayJSON);
  var data = JSON.parse(orgsArrayJSON);
  orgsArrayIssues.push(data);
}//end appendOrgsArrayIssues ***********************************/

/*
2015-02-09 :
  display_orgs_list is callback for get_orgs_list.php ;
  produces data under organizations tab ;
  calls google_visualization_chart in googleChartsAPIfunctions.js ;
  calls get_format_list.php
2013-11-11 : AJE : display_orgs_list: revised get_orgs_list.php for GOOGLE CHARTS API ; but this didn't work much: revert to CJ's
*/
function display_orgs_list(orgsJSON, textStatus) {
  //console.warn('display_orgs_list 2016-02-15 15:43:20: ', orgsJSON);
	var tempOrgInfoString = '';
	var availableOrgsString = '<div id="available_organizations" class="pub_data_content"><ul>';
	var tempOrgName = tempStartYear = tempEndYear = null;
	var tempArray = [];
	var orgIssues = [];
	var uniqueOrgs = [];
  //console.log('orgsJSON = ', orgsJSON);
	var data = JSON.parse(orgsJSON);
	orgIssues = data.organizations;

	if (orgIssues.length > 0) {
		/*
		For each organization, identify issues with first and last issue dates
		Save organization name and year in a string
		Strings will look like this:
		  org_name_1 first_year
		  org_name_1 last_year
		  org_name_2 first_year (if starting and ending years are the same)
		  org_name_3_first_year
		  org_name_3_last_year
		  Etc.
		Save these strings in a temporary array
		*/

		tempArray.push(orgIssues[0].org_name + ' ' + orgIssues[0].issue_date.substr(0,4));
/*
2015-07-07
AJE: why is the first element being processed outside the loop?

    holders_org_ids.push(orgIssues[0].org_id); // AJE for Google Charts + extra data
    holders_org_names.push(orgIssues[0].org_name); // same as abv

		for (var i=1; i < orgIssues.length; i++) { // once for every issue for all organizations, whole set
AJE: start here with element 0 instead
    for (var i=0; i < orgIssues.length-1; i++) { // once for every issue for all organizations, whole set
AJE: revert to original
*/
    holders_org_ids.push(orgIssues[0].org_id); // AJE for Google Charts + extra data
    holders_org_names.push(orgIssues[0].org_name); // same as abv

		for (var i=1; i < orgIssues.length; i++) { // once for every issue for all organizations, whole set
			if ( (orgIssues[i].org_name != orgIssues[i-1].org_name) ) { // in here once per org_name

        holders_org_ids.push(orgIssues[i].org_id); // AJE for Google Charts + extra data
        holders_org_names.push(orgIssues[i].org_name); // same as abv
        //console.info("AJE 2016-02-11 10:53:26 ("+i+")" + orgIssues[i].org_name);

        //console.info("AJE 2016-02-11 10:50:06 (i-1 = "+(i-1)+").issue_date" + orgIssues[i-1].issue_date, "\n i(", i, ").issue_date = " + orgIssues[i].issue_date);
				tempArray.push(orgIssues[i-1].org_name + ' ' + orgIssues[i-1].issue_date.substr(0,4));
				tempArray.push(orgIssues[i].org_name + ' ' + orgIssues[i].issue_date.substr(0,4));
			}//end if
		}//end for i
		tempArray.push(orgIssues[orgIssues.length-1].org_name + ' ' + orgIssues[orgIssues.length-1].issue_date.substr(0,4));
		//Use temporary array to build new strings consisting of unique repository names and year ranges
		//Save these strings to final array
		tempOrgName = tempArray[0].substr(0,tempArray[0].length-5);
		tempYear = tempArray[0].substr(tempArray[0].length-4,4);

		for (var i=1; i < tempArray.length; i++) { // in here once per org_name
			if (tempArray[i].substr(0,tempArray[i].length-5) == tempOrgName) {
				 //Same repository name as previous array element, so test whether year is different
				 if (tempArray[i].substr(tempArray[i].length-4,4) != tempYear) {
				 	//Ending year for this repository is different from starting year, so concatenate the years
					tempOrgInfoString = tempOrgName + ' [' + tempYear + '-' + tempArray[i].substr(tempArray[i].length-4,4) + ']';
				} else if (tempArray[i].substr(tempArray[i].length-4,4) == tempYear) {
					//Ending year is the same as starting year, so only show year once
					tempOrgInfoString = tempOrgName + ' [' + tempYear + ']';
				}
				uniqueOrgs.push(tempOrgInfoString);
				allOrganizationNames.push(tempOrgName);
				tempOrgName = '';
				tempYear = '';
			} else if (tempArray[i].substr(0,tempArray[i].length-5) != tempOrgName) {
				//Different organizations, so reset comparison values
				tempOrgName = tempArray[i].substr(0,tempArray[i].length-5);
				tempYear = tempArray[i].substr(tempArray[i].length-4,4);
			}
		}
		for (var i = 0; i < uniqueOrgs.length; i++) {
			//availableOrgsString += '<li>' + uniqueOrgs[i] + '</li>';// CJ original: single line
        // AJE 2014-09-11: add hard-coded version with if/else ...
        // AJE 2014-09-17: add function for all organizations that have CRL profiles
    	  availableOrgsString += '<li>' + uniqueOrgs[i] + '&nbsp;&nbsp;' + get_linked_profile_image( holders_org_ids[i], tempOrgName ) + '</li>';
		}// end CJ's for

		availableOrgsString += '</ul></div>';
		//AJE 2012-11-27: moved organizations from #sidebar to #page: next puts organizations in #sidebar
		//$(availableOrgsString).insertBefore($('h6:contains("Genealogy of paper")')[0]);
		// AJE 2012-11-27: moved organizations from #sidebar to #page
		$('#organizations_header').css('display','block');
		$('#organizations_list').html( availableOrgsString );
		$('#available_organizations ul li:odd').css('backgroundColor','#F0F0F0');
		$('#loading-organization-info').attr('class', 'loading-organization-info-invisible');
		//resetHeightsAndOffsets($('.matchingColumn')); //headTagContents.php // 2013-02-25 20:18:54 not in JHunt new version
	}//end if orgIssues



  // AJE 2013-11-12 : wanted to make display_orgs_list do this; failed.
  //    try a whole new version just for the chart: depends on display_orgs_list() having filled holders_org_ids[]
  for(r = 0; r < holders_org_ids.length; r++){
    $.get("get_org_issues_for_pub.php", { 'selectedPubId': selectedPubId, 'org_id':holders_org_ids[r], 'org_name':holders_org_names[r] }, appendOrgsArrayIssues);
  }

  // TAB CHART in calendar.php
  setTimeout(function () {
    google_visualization_chart('Issues per organization:', 'Organizations', 'Issues', 'orgsArrayIssues', 'pie', 'orgs_chart_canvas_tab'); // googleChartsAPIfunctions.js.js
    }, 500
  );

  // SIDEBAR CHART in sidebarTimeline.php
  setTimeout(function () { // chartTitle is separate for sidebar charts, send blank param
    google_visualization_chart('', 'Organizations', 'Issues', 'orgsArrayIssues', 'pie', 'orgs_chart_canvas_sidebar');
    }, 2000
  );

  $.get("get_format_list.php", { 'selectedPubId': selectedPubId }, display_formats_list);
}//end display_orgs_list ***************************************/




/*
2015-02-09 :
  display_formats_list is callback for get_format_list.php ;
  produces data under formats tab ;
  calls google_visualization_chart in googleChartsAPIfunctions.js
2013-11-11 : AJE : display_formats_list revised for GOOGLE CHARTS API; also revised get_format_list.php to get more data */
function display_formats_list(formatsJSON, textStatus) {

	if ((formatsJSON.search(/Error/i) != -1) || (formatsJSON.search(/\<b>Notice/i) != -1 )) {
		document.writeln(formatsJSON);
	} else {
		var availableFormatsString = '<div id="available_formats" class="pub_data_content"><ul>';
		//prompt("calendar_selection_functions.js display_formats_list gets formatsJSON\n" +formatsJSON, formatsJSON);
		var data = JSON.parse(formatsJSON);
		var formats = data.formatList;
		if (formats.length > 0) {

			for (var i=0; i < formats.length; i++) {
			  var thisFormatName = formats[i].formatName;
				allFormats.push(thisFormatName);
				availableFormatsString += '<li>' + thisFormatName + ': ' +formats[i].issues+ ' issues</li>';
				/* AJE 2015-02-09: here was a section of if thisFormatName ... reformatting:
				  - all has been combined into the above line
				  - update format display name values in database as needed
        */
			}//end for

			availableFormatsString += '</ul></div>';
			$('#formats_header').css('display','block');
			$('#formats_list').html( availableFormatsString );
			$('#available_formats ul li:odd').css('backgroundColor','#F0F0F0');
			$('#loading-format-info').attr('class', 'loading-format-info-invisible');
			//resetHeightsAndOffsets($('.matchingColumn')); //headTagContents.php // 2013-02-25 20:18:54 not in JHunt new version
		} // end if formats
	}// end else

    pubFormatsArray = formats;
    // TAB CHART in calendar.php
    google_visualization_chart('Issues per format', 'Formats', 'Issues', 'pubFormatsArray', 'pie', 'formats_chart_canvas_tab'); //lives in googleChartsAPIfunctions.js.js

    // SIDEBAR CHART in sidebarTimeline.php
    // chartTitle is separate for sidebar charts, send blank param
    google_visualization_chart('', 'Formats', 'Issues', 'pubFormatsArray', 'pie', 'formats_chart_canvas_sidebar'); //lives in googleChartsAPIfunctions.js.js

}//end display_formats_list ************************************/

/****************************************************************
 END functions handling ACTUAL DISPLAY of CALENDAR + TABS: the ISSUE DATA
****************************************************************/

/*******************************************************************************/









/****************************************************************
 O T H E R   F U N C T I O N S
****************************************************************/


function populateStartupMonths() {
	tempAvailableMonthsObject = new Object();
	for (var i = 0; i < monthNameArray.length; i++) {
		tempAvailableMonthsObject[i] = monthNameArray[i];
	}
} // end populateStartupMonths *********************************/


// populateIssueCountAndMinMaxYears is callback for get_issue_count_minmax_dates.php
function populateIssueCountAndMinMaxYears(countMinMaxJSON, textStatus){
  if ((countMinMaxJSON.search(/Error/i) != -1) || (countMinMaxJSON.search(/\<b>Notice/i) != -1 )) {
		document.writeln(countMinMaxJSON);
	} else {
		var data = JSON.parse(countMinMaxJSON);
		num_valid_issues = data.issue_count_valid;
		num_distinct_issues = data.issue_count_distinct; // old ; RESTORED 2015-09-15
// 2015-05-18 remove ZERO date from distinct count; 2015-09-15 REVERT: WAS:  num_distinct_issues = data.issue_count_distinct - 1;
		MINissue_date = data.MINVALIDissue_date;
		MINissue_year = MINissue_date.substr(0,4);
		MAXissue_date = data.MAXVALIDissue_date;
    //console.warn("827: MAXissue_date = ", MAXissue_date);
		MAXissue_year = MAXissue_date.substr(0,4);
  } // end else: there is good JSON data
  /* console.log('countMinMaxJSON = ', countMinMaxJSON);
  console.log('num_valid_issues=', num_valid_issues, '; num_distinct_issues=', num_distinct_issues, '; MINissue_date=', MINissue_date, '; MAXissue_date=', MAXissue_date); */

  // 2015-05-20 AJE: details under 'HOLDINGS' : number of issues, what years they come from
	holdingsInfoString = '<ul><li id="holdings_info_heading" style="font-weight: bold;">HOLDINGS:</li>';
  holdingsInfoString += '<li>Database holds <span style="font-weight: bold;">';
    holdingsInfoString += addCommasToNumString(num_valid_issues)+ '</span> ';
    if (num_valid_issues > 1){ holdingsInfoString += 'issues'; }
    else {holdingsInfoString += 'issue';}
  holdingsInfoString += '</li>';
    /* AJE 2016-02-09 this fails to be correct and is particularly bad with small runs -- just kill it
  holdingsInfoString += '<li>for <span style="font-weight: bold;">'+addCommasToNumString(num_distinct_issues)+ '</span> ';
    if (num_distinct_issues > 1){ holdingsInfoString += 'dates '; }
    else {holdingsInfoString += 'date ';}
    holdingsInfoString += ' from <span style="font-weight: bold;">' + MINissue_year + '</span>';
  */
  holdingsInfoString += '<li>from <span style="font-weight: bold;">' + MINissue_year + '</span>'; // 2016-02-09 14:30:05
	  if (MINissue_year != MAXissue_year) {
      holdingsInfoString += '-<span style="font-weight: bold;">' + MAXissue_year + '</span>';
	  }
	holdingsInfoString += '.</li><li>See timeline for details.</li></ul>';
  $('#holdings_info_container').empty();
  $('#holdings_info_container').html(holdingsInfoString);
  // end AJE 2015-05-20

} // end populateIssueCountAndMinMaxYears ***************************/




function populateAllIssues(allIssuesJSON, textStatus) { // populateAllIssues is the callback for get_all_issues.php
  /* AJE 2015-02-03 now specifying in PHP that:
      header('content-type: application/json; charset=utf-8');
    generates 'TypeError: allIssuesJSON.search is not a function so:
  allIssuesJSON = new String(allIssuesJSON); // solves error but still fails below on:
    data = JSON.parse(allIssuesJSON); // just like it did before

  console.info('populateAllIssues: ', allIssuesJSON);

  */

	if ((allIssuesJSON.search(/Error/i) != -1) || (allIssuesJSON.search(/\<b>Notice/i) != -1 )) {
		document.writeln(allIssuesJSON);
	} else {
	  var data = JSON.parse(allIssuesJSON);
		allIssues = data.allIssues;
	}

	var tmpStaticFormatObject = new Object();
	var tmpStaticConditionObject = new Object();
	var tmpStaticArchiveStatusObject = new Object();
	var tmpStaticOrganizationsObject = new Object();
	var numOrgsString = ''; //string to count number of holding orgs quickly
	var numFormatsString = ''; //string to count number of formats quickly
	for (var i = 0; i < allIssues.length; i++) {
		//console.log(allIssues[i].format_id + " " + allIssues[i].condition_id + " " + allIssues[i].archive_status_id + " " + allIssues[i].org_id);
		tmpStaticFormatObject = getObjects(staticFormats, 'format_id', allIssues[i].format_id);
		tmpStaticConditionObject = getObjects(staticConditions, 'condition_id', allIssues[i].condition_id);
		tmpStaticArchiveStatusObject = getObjects(staticArchiveStatuses, 'archive_status_id', allIssues[i].archive_status_id);
		tmpStaticOrganizationsObject = getObjects(staticOrganizations, 'org_id', allIssues[i].org_id); // AJE: save original
		allIssues[i].format_name = tmpStaticFormatObject[0].format_name;
		if ( numFormatsString.indexOf(allIssues[i].format_name) == -1 ){ // this format name not found in list
      numFormatsString += allIssues[i].format_name + '|';
      //console.log(i + ') numFormatsString = ' + numFormatsString);
		} // end if numFormatsString
		allIssues[i].condition_name = tmpStaticConditionObject[0].condition_name;
		allIssues[i].archive_status_name = tmpStaticArchiveStatusObject[0].archive_status_name;
    //console.info("for tmpStaticOrganizationsObject looks at allIssues[", i, "].org_id = ", allIssues[i].org_id);
		allIssues[i].org_name = tmpStaticOrganizationsObject[0].org_name;
    if ( numOrgsString.indexOf(allIssues[i].org_name) == -1 ){ // this org name not found in list
      numOrgsString += allIssues[i].org_name + '|';
      //console.log(i + ') numOrgsString = ' + numOrgsString);
    } // end if numOrgsString
	} // end for

	  // how many orgs and formats? use this number in updating progress messages
	var numOrgsArray = numOrgsString.split('|');
	  numOrgsString = numOrgsArray.length - 1;
//console.log('numOrgsString = ' + numOrgsString);
	var numFormatsArray = numFormatsString.split('|');
	  numFormatsString = numFormatsArray.length - 1;
//console.log('numFormatsString = ' + numFormatsString);


    // AJE 2015-02-05 updating progress messages
  var htmlString = 'Calculating ' + load_calendar_gif + '<br/>';
    htmlString+= '<span style="font-weight: bold;">' + numOrgsString + '</span> org';
    numOrgsString > 1 ? htmlString+= 's for chart' : htmlString+= ' for chart';
  $('#orgs_chart_canvas_sidebar').html( htmlString );
    // AJE 2015-02-05 updating progress messages: formats happen quickly

  htmlString = 'Calculating ' + load_calendar_gif + '<br/>';
  htmlString+= '<span style="font-weight: bold;">' + numFormatsString + '</span> format';
    numFormatsString > 1 ? htmlString+= 's for chart' : htmlString+= ' for chart';
    $('#formats_chart_canvas_sidebar').html( htmlString );


	// AJE 2015-02-03 : new location for get_orgs_list.php :
	//  briefly reinstated old location for test but may not have mattered
	$.get("get_orgs_list.php", { 'selectedPubId': selectedPubId }, display_orgs_list);

	populateIssueCounts();

} // end populateAllIssues *************************************/



/*
  2015-02-09 : AJE : see backup drive, calendar_selection_functions_init_populateFilteredIssues.js
  for orphaned populateFilteredIssues from here
*/



function populateIssueFormats(element, index, array) {
	var tmpObj = getObjects(staticFormats, 'format_name', element.format);
	element.format = tmpObj[0].format_name;
}

function populateIssueConditions(element, index, array) {
	var tmpObj = getObjects(staticConditions, 'condition_name', element.condition);
	element.condition = tmpObj[0].condition_name;
}

function populateIssueArchiveStatuses(element, index, array) {
	var tmpObj = getObjects(staticArchiveStatuses, 'archive_status_name', element.archiveStatus);
	element.archiveStatus = tmpObj[0].archive_status_name;
}

function populateIssueOrganizations(element, index, array) {
	var tmpObj = getObjects(staticOrganizations, 'org_name', element.org_name);
	element.org_name = tmpObj[0].org_name;
}


function populateIssueCounts() { // called at end of populateAllIssues
	if (allIssues[0] != null) {
		var tmpMonths = new Object();
		var tmpObject = null;
		issueCounts = new Object();
		yearCounter = 0;
		var currYr = currDate = tmpDate = currMonth = tmpMonth = null;
		var tmpCount = monthCounter = 0;
		var tmpYr = allIssues[0]['issue_date'].substr(0,4);
		var tmpFirstYear = tmpYr;
		var tmpFirstMonth = allIssues[0]['issue_date'].substr(5,2);
		for (var issue in allIssues) {
			currYr = allIssues[issue]['issue_date'].substr(0,4);
			/*
      console.log('currYr will be extracted from: ' + allIssues[issue]['issue_date']);
      console.log('extraction gets: allIssues[issue][\'issue_date\'].substr(0,4) = ' + allIssues[issue]['issue_date'].substr(0,4));
      console.log('currYr = ' + currYr);
      */
			currDate = allIssues[issue]['issue_date'];
			currMonth = allIssues[issue]['issue_date'].substr(5,2);
			if (currYr == tmpYr) {
				if (currDate != tmpDate) {
					tmpDate = currDate;
					tmpCount++;
				}
				if (currMonth != tmpMonth) {
					tmpMonths[monthCounter] = monthNameArray[parseInt(currMonth,10)-1];
					tmpMonth = currMonth;
					monthCounter++;
				}
			} else {
				tmpObject = new Object();
				tmpObject.year = tmpYr;
				tmpObject.count = tmpCount;
				tmpObject.available_months = tmpMonths;
				issueCounts[yearCounter] = tmpObject;
				tmpMonths = new Object();
				tmpDate = currDate;
				monthCounter = 0;
				tmpMonth = currMonth = allIssues[issue].issue_date.substr(5,2);
				tmpMonths[monthCounter] = monthNameArray[parseInt(currMonth,10)-1];
				tmpYr = currYr;
				yearCounter++;
				monthCounter++;
				tmpCount = 1;
			}
		}

		tmpObject = new Object();
		tmpObject.year = tmpYr;
		tmpObject.count = tmpCount;
		tmpObject.available_months = tmpMonths;
		issueCounts[yearCounter] = tmpObject;
		//Get maximum year issue count for bar height calculation
		for (var c in issueCounts) {
			if (issueCounts[c].count > maxIssueCount) {
				maxIssueCount = issueCounts[c].count;
			}
		}


		/*
		  DEVNOTE: 2015-02-09 we have new global vars available: MINissue_year + MAXissue_year
		  - could save a microsecond using them
    */

		minHoldingsYear = issueCounts[0].year;
		maxHoldingsYear = currYr;
	}
	newWin = false;
	if ( (ie == false) || (document.documentElement.className.search('ie10') != -1) ) {
		//Browser is either: (1) not IE, or (2) IE > 10
		//So display genealogy visualization
		// AJE 2014-09-24
		//  a year later going back over some of the calendar page code:
		//  we don't even need to call get_genealogy_info.php anymore: uncomment next line to restore it
		//$.get("get_genealogy_info.php?selectedPubId=" + selectedPubId, initializeGenealogyVisualization);
		// AJE 2014-09-24
		//  part of what was in initializeGenealogyVisualization() has been moved into finishInitialization(), which always gets called from this function

		// AJE 2013-11-20: test disabling genealogy if can't be high-level
		// remove the next 2 lines for normal functioning
    //$('#genealogy_tab').hide();
    //$('#tab_container').show();
    // end AJE 2013-11-20

	} else { //Browser is IE < 10 : Do not display genealogy visualization
		if (issueCounts == null) {
			$('#holdings_info_container').remove();
			$('#bib_id_holdings_row').append( no_holdings_div );
			$('#loading-calendar').html( no_issues_para );
			$('#loading-issue-info').hide();
			$('#loading-organization-info').hide();
			$('#loading-format-info').hide();
			$('#sidebar_charts').css('display', 'none');
		} else {
			$('#genealogy_tab').hide();
			$('#tab_container').show();
		}
	}
	finishInitialization();
} // end populateIssueCounts



function initializeGenealogyVisualization(genealogyJSON, textStatus) {
	if (genealogyJSON.search("No matching relationship") != -1) {
		hasGenealogy = false;
	} else {
		var data = JSON.parse(genealogyJSON);
		if (data.pub_title == null) {
			hasGenealogy = false;
		} else {
			hasGenealogy = true;
		}
	}
	if (issueCounts == null) {
		$.get("get_zero_date_issues.php", { 'selectedPubId': selectedPubId }, display_issue_info_NO_issues);
		$('#holdings_info_container').remove();
		$('#bib_id_holdings_row').append( no_holdings_div );
		$('#loading-calendar').html( no_issues_para );
		$('#loading-issue-info').hide();
		$('#loading-organization-info').hide();
		$('#loading-format-info').hide();
		$('#sidebar_charts').css('display', 'none');
		if (hasGenealogy) {
/********************************************************************************
// AJE 2014-01-14 PER AMY HIDE GENEALOGY FOR LIVE SITE
			$('#issueDateTab').removeClass('active');
			$('#issue_info_tab').removeClass('active');
			$('#issue_info_tab').hide();
			$('#organizations_tab').hide();
			$('#formats_tab').hide();
			$('#genealogyTab').addClass('active');
			$('#genealogy_tab').addClass('active');
			$('#genealogyTab').prepend('<div class="row"><div id="genealogy_new_window_link_container" class="twelve columns"><a href="genealogy.php?pub_id=' + selectedPubId + '&new_win=true" target="_blank">Open in a new window</a></div></div>');
			$('#genealogy_tab').show();
			$('#tab_container').show();
			displayGenealogyVisualization(genealogyJSON,newWin); // displayGenealogyVisualization lives in collapsible_tree_functions,js
//END HIDE GENEALOGY FOR LIVE SITE
********************************************************************************/
		} //end if hasGenealogy
	} else {
		if (hasGenealogy) {
			$('#genealogyTab').prepend('<div class="row"><div id="genealogy_new_window_link_container" class="twelve columns"><a href="genealogy.php?pub_id=' + selectedPubId + '&new_win=true" target="_blank">Open in a new window</a></div></div>');
			// AJE 2014-01-14 PER AMY HIDE GENEALOGY FOR LIVE SITE: $('#genealogy_tab').show();
			$('#tab_container').show();
			// AJE 2014-01-14 PER AMY HIDE GENEALOGY FOR LIVE SITE: displayGenealogyVisualization(genealogyJSON,newWin); // displayGenealogyVisualization lives in collapsible_tree_functions,js
		} else {
			$('#genealogy_tab').hide();
			$('#tab_container').show();
		}
		finishInitialization();
	}
} // end initializeGenealogyVisualization **********************/



function displayDecadesBarchart() {
	$('.timeline li').css('display','none');
	$('.timeline li ul').empty();
	//Display timeline only if more than one year is held
	var tempYear, tempYearDigit, tempDecadeDigits, tempBarchartAnchor, tempBarchartElement1, tempBarchartElement2, tempClass, tempBarSize;
	var tempLastDigit = tempLabel = null;
	for (var i in issueCounts) {
		tempYear = issueCounts[i].year;
		tempIssueCount = issueCounts[i].count;
		//tempBarSize = (tempIssueCount/maxIssueCount * 30);
		tempBarSize = (tempIssueCount/maxIssueCount * 100);
		//Maximum bar height is 100px
		//Internet Explorer doesn't render very small bars properly, so set minimum bar height to 1px
		if (tempBarSize < 1) {
			//tempBarSize = 1;
			tempBarSize = 2;
		}
		tempBarSize = tempBarSize + 'px';
		tempYearDigit = issueCounts[i].year.substr(3);
		tempClass = 'y' + tempYearDigit;
		tempDecadeDigits = tempYear.substring(0,3) + "0";
		tempBarchartAnchor = $('a:contains(' + tempDecadeDigits + ')');
		tempBarchartElement1 = tempBarchartAnchor[0].parentNode.parentNode.children[1];
		tempBarchartElement2 = document.createElement('li');
		tempBarchartElement1.appendChild(tempBarchartElement2);
		addClass(tempBarchartElement2,tempClass);
		tempBarchartElement1 = document.createElement('a');
		tempBarchartElement2.appendChild(tempBarchartElement1);
		tempBarchartElement2 = document.createElement('span');
		addClass(tempBarchartElement2, 'count');
		if (tempIssueCount == 1) {
			tempBarchartElement2.title = tempYear + " - " + tempIssueCount + " issue";
		} else {
			tempBarchartElement2.title = tempYear + " - " + tempIssueCount + " issues";
		}
		//tempBarchartElement2.id = tempYear;
		tempBarchartElement2.id = 'year' + tempYear;
		tempBarchartElement2.style.width = tempBarSize;
		//Add bottom border to last bar in each decade
		if (tempYear.substr(3,1) == '9') {
				tempBarchartElement2.style.borderBottom = "1px solid #A8A8A5";
		}
		tempBarchartElement1.appendChild(tempBarchartElement2);
		var firstBar = $('.count')[0];
		firstBar.style.backgroundColor = '#00224C';
	}
	//Determine which decade sections to display
	var firstYear = issueCounts[0].year;
	var lastYear = tempYear;
	var firstDecade = firstYear.substr(0,3);
	var lastDecade = lastYear.substr(0,3);
	$( "li" ).each(function() {
		tempLabel = $(this).children('span.label').children('a').text().substr(0,3);
		if (tempLabel >= firstDecade && tempLabel <= lastDecade) {
			$(this).css('display','block');
		}
	});
	$('#timeline_heading').css('display','block');
	$('#timeline_help_container').css('display','block');
	$('.timeline li li').css('display','block');
} // end displayDecadesBarchart ********************************/



function styleAvailableMonthBoxes() {
	var tempMonth = tempPubDate = tempMonthBoxId = tempMonthBox = tmpObject = null;
	availableMonths = new Object();
	tmpObject = getObjects(issueCounts, 'year', selectedYear)[0];
	//tmpObject = getObjects(issueCounts, 'year', 'year'+selectedYear)[0];
	availableMonths = tmpObject.available_months;
	for (var m in availableMonths) {
		tempMonthBoxId = availableMonths[m];
		tempMonthBox = $('#month_control_wrapper').find('#' + tempMonthBoxId);
		tempMonthBox[0].className = "month_box month_box_available";
	}
	if (startupFlag == true || changeYearFlag == true) {
		//Calendar displays first available month for selected year
		selectedMonth = getMonthNumber(availableMonths[0]);
		tempMonthBoxId = availableMonths[0];
		tempMonthBox = $('#month_control_wrapper').find('#' + tempMonthBoxId);
		tempMonthBox[0].className = "month_box month_box_available month_box_selected";
	}
	populateAvailableDays();
	displayFilteredYearDropdown();
	for (var i = 0; i < yearBox.options.length ; i++) {
		if (yearBox.options[i].text == selectedYear) {
			yearBox.options[i].selected = true ;
			break ;
		}
	}
	$('#year_option').attr('disabled', false);
} // end styleAvailableMonthBoxes  *****************************/



function populateAvailableDays() {
	availableDays = new Object();
	var tempDefaultDate = null;
	var tmpMonthYear = selectedYear + "-" + padDate(parseInt(selectedMonth+1,10));
	availableDays = getObjects(allIssues, 'issue_date', tmpMonthYear);
	if (availableDays.length == 0) {
		//There are no available issues in selected month
		//Change calendar month without populating day array
		//No date cells will contain links
		firstDay = new Date(selectedYear, selectedMonth, 1);
		selectedDate = selectedYear + '-' + padDate(parseInt(selectedMonth+1,10)) + '-01';
		$('#datepicker_container').datepicker('setDate', firstDay);
		$('#issue_date_header').html('No issues available for ' + toTitleCase(longMonthNameArray[selectedMonth]) + ', ' + selectedYear).addClass('no_issues_this_month twelve').removeClass('three').css('display','block');
		$('#pub_tabs dd a')[0].text = 'Issue Information';
		$('#loading-issue-info').hide();
		activateIssueInfoTab();
	} else {
		//There are available issues in selected month
		//Change calendar month after populating day array
		//Available date cells will contain links
		tempDefaultDate = selectedDate = availableDays[0].issue_date;
		selectedDay = tempDefaultDate.substr(tempDefaultDate.length-2,2);
		selectedDay = parseInt(selectedDay, 10);
		defaultDate = new Date(selectedYear, selectedMonth, selectedDay);
		//Test whether page load occurred
		if (startupFlag == true) {
			//Page load occurred
			//Initialize datepicker, setting calendar default date to first available day in first available month and year
			$('#datepicker_container').datepicker({ changeMonth: false,
													changeYear: false,
													defaultDate: defaultDate,
													dateFormat: 'yyyy-mm-dd',
													beforeShowDay: highlightIssueDates,
													prevText: '',
													nextText: '',
													onChangeMonthYear: function() {
														if (availableDays.length == 0) {
															$('#issue_date_header').html('No issues available for this month').css('display','block');
															$('#pub_tabs dd a')[0].text = 'Issues';
														} else {
															selectedDateFormatted = toTitleCase(monthAbbrevArray[selectedMonth]) + ' ' + parseInt(selectedDay,10) + ', ' + selectedYear;
															$('#issue_date_header').html('').css('display','none');
															$('#issue_info_tab').html('<a href="#issueDate"><span class="issues_this_date">' + selectedDateFormatted + '</span></a>');
															activateIssueInfoTab();
														}
													},
													onSelect: function(date) {
														selectedDay = date.substr(date.length-2,2);
														selectedDate = selectedYear + '-' + padDate(parseInt(selectedMonth,10)+1) + '-' + selectedDay;
														selectedDateFormatted = toTitleCase(monthAbbrevArray[selectedMonth]) + ' ' + parseInt(selectedDay,10) + ', ' + selectedYear;
														$('#issue_date_header').html('').css('display','none');
														$('#issue_info_tab').html('<a href="#issueDate"><span class="issues_this_date">' + selectedDateFormatted + '</span></a>');
														activateIssueInfoTab();
														displayFilterLinks();
													}
			});
			startupFlag = false;
			changeYearFlag = false;
			$('#loading-calendar').attr('class', 'loading-calendar-invisible');
			selectedDateFormatted = toTitleCase(monthAbbrevArray[selectedMonth]) + ' ' + parseInt(selectedDay,10) + ', ' + selectedYear;
			$('#issue_date_header').html('').css('display','block');
			//$('#issue_info_tab').html('<a href="#issueDate"><span class="issues_this_date">' + selectedDateFormatted + '</span> &nbsp;Issues</a>');
			$('#issue_info_tab').html('<a href="#issueDate"><span class="issues_this_date">' + selectedDateFormatted + '</span></a>');
			displayFilterLinks();
      $('#inner_selection_control_wrapper').show();
		} else {
			//Month or year changed in response to user selection, not page load
			//Set calendar default date to first available day in selected month and year
			$("#datepicker_container").datepicker("setDate", defaultDate);
			selectedDateFormatted = toTitleCase(monthAbbrevArray[selectedMonth]) + ' ' + parseInt(selectedDay,10) + ', ' + selectedYear;
			$('#issue_date_header').html('').css('display','none');
			//$('#issue_info_tab').html('<a href="#issueDate"><span class="issues_this_date">' + selectedDateFormatted + '</span> &nbsp;Issues</a>');
			$('#issue_info_tab').html('<a href="#issueDate"><span class="issues_this_date">' + selectedDateFormatted + '</span></a>');
			displayFilterLinks();
		}
	}
} // end populateAvailableDays *********************************/



function displayFilteredYearDropdown() {
	yearBox.options.length = 0;
	var i = 0;
	for (i in issueCounts) {
		addOption(yearBox, issueCounts[i].year, i+1);
	}
	$('option:selected').css('backgroundColor', '#00224C').css('color', '#dfe2e6');
	$('option:not(:selected)').css('backgroundColor', '#BFCCA8').css('color','#00224C');
} // end displayFilteredYearDropdown ***************************/



function highlightIssueDates(date) {
	if (availableDays.length > 0) {
		var tempDateString, tempMonth, tempDay;
		tempMonth = padDate(date.getMonth()+1);
		tempDay = padDate(date.getDate());
		tempDateString = date.getFullYear() +"-" + tempMonth + "-" + tempDay;
		var daysReturned = getObjects(availableDays, 'issue_date', tempDateString);
		if (daysReturned.length > 0) {
			if (parseInt(tempDay, 10) == selectedDay) {
				return [true, 'selected_publication_date a'];
			} else {
				return [true, 'publication_date a'];
			}
		} else {
			return [false, 'not_publication_date'];
		}
	} else {
		return [false, ''];
	}
} // end highlightIssueDates ***********************************/



function displayFilterLinks() {
	if (!(availableDays == null)) {
		if (availableDays.length == 0) {
			$('#loading-issue-info').attr('class', 'loading-issue-info-invisible');
			$('#loading-organization-info').attr('class', 'loading-organization-info-invisible');
			$('#loading-format-info').attr('class', 'loading-format-info-invisible');
			$('#inner_issue_info_display').html('').hide();
		} else {
			var tmpOrgId = null;
			var tmpSortedIssuesObject = new Object();
			var tmpObject = new Object();
			availableOrganizations = new Object();
			availableOrgsArray = [];
			//console.log("allIssues 2016-02-15 15:41:51 in displayFilterLinks:");
			//console.log(allIssues);
			var sortedIssues = allIssues.sort(compareOrganizationNamesAndUpdateDates);
			tmpSortedIssuesObject = getObjects(sortedIssues, 'issue_date', selectedDate);
			//console.log("tmpSortedIssuesObject in displayFilterLinks() [length is " + tmpSortedIssuesObject.length + "]");
			//console.log(tmpSortedIssuesObject);
			for (var i in tmpSortedIssuesObject) {
				//Create list of unique repository codes from issue records with this publication date
				if (tmpSortedIssuesObject[i].org_id != tmpOrgId) {
					tmpObject = new Object();
					tmpObject.org_name = tmpSortedIssuesObject[i].org_name;
					tmpObject.org_id = tmpSortedIssuesObject[i].org_id;
					availableOrganizations[i] = tmpObject;
					tmpOrgId = tmpSortedIssuesObject[i].org_id;
				}
			}
			for (var i in availableOrganizations) {
				availableOrgsArray.push(availableOrganizations[i].org_id);
			}


			$.get("get_filtered_org_info.php", { 'availableOrganizations[]': availableOrgsArray }, populateFilteredOrganizations);

			$('#breadcrumb_container').css('display','none');
			$('#issue_date_header').css('display','none');
			//Create filter links
			var tempContainer = tempDiv = tempLink = null;
			$('#inner_issue_info_display').html('');
			$('#inner_issue_info_display').append('<div></div>');
			$('h6:contains("Repository Information")').remove();
			$('#org_info').remove();
			tempContainer = $('#inner_issue_info_display').children('div')[0];
			tempContainer.id = 'tempContainer';
			tempContainer.className = 'link_group_container';
			// AJE 2014-09-10 rewording links
			//$('#tempContainer').append('<div>Filter issues by:</div><div><a id="filter_by_repository" href="javascript:;">Repository</a></div>');
			$('#tempContainer').append('<div>Filter issues by:</div><div><a id="filter_by_organization" href="javascript:;">Organization</a></div>');
			$('#tempContainer').append('<div><a id="filter_by_format" href="javascript:;">Format</a></div>');
			tempDiv = $('#tempContainer').children('div')[0];
			tempDiv.style.padding = '0 0 10px 0';
			tempDiv = $('#tempContainer').children('div')[1];
			tempLink = tempDiv.childNodes[0];
			tempLink.onclick = function(){
				displayOrganizationLinks();
			};
			tempDiv = $('#tempContainer').children('div')[2];
			tempLink = tempDiv.childNodes[0];
			tempLink.onclick = function(){
				var tmpFormat = null;
				var tmpObject = new Object();
				//availableFormats = new Object();
				availableFormats = [];
				tmpObject = getObjects(allIssues, 'issue_date', selectedDate);
//console.log("In displayFilterLinks at line 1394 and tmpObject.length = " + tmpObject.length);
				var sortedIssues = tmpObject.sort(compareFormats);
//console.log("In displayFilterLinks at line 1396 and sortedIssues = " + sortedIssues)
//console.log("In displayFilterLinks at line 1397 and sortedIssues[0].format_name = " + sortedIssues[0].format_name);
				//console.log("sortedIssues in displayFilterLinks():");
				//console.log(sortedIssues);
				//console.log("selectedDate in displayFilterLinks():" + selectedDate);
				//tmpObject = getObjects(sortedIssues, 'issue_date', selectedDate);
				//console.log("tmpObject in displayFilterLinks():");
				//console.log(tmpObject);
				//tmpFormat = tmpObject[0].format_name;
				tmpFormat = sortedIssues[0].format_name;
				availableFormats.push(tmpFormat);
//console.log("availableFormats.length: " + availableFormats.length);
				//for (var i in sortedIssues) {
				for (var i = 0; i < sortedIssues.length; i++) {
					//Create list of unique formats from issue records with this publication date
//console.log("sortedIssues[" + i + "].format_name: " + sortedIssues[i].format_name + " tmpFormat: " + tmpFormat);
					if (sortedIssues[i].format_name != tmpFormat) {
						//availableFormats[i] = sortedIssues[i].format_name;
						availableFormats.push(sortedIssues[i].format_name);
						tmpFormat = sortedIssues[i].format_name;
					}
				}
//console.log("availableFormats.length: " + availableFormats.length);
				for (var j = 0; j< availableFormats.length; j++) {
//console.log(j + " " + availableFormats[j]);
				}
				//alert(availableFormats.length);
				displayFormatLinks();
			};
			$('#loading-issue-info').attr('class', 'loading-issue-info-invisible');
			//$('#loading-organization-info').attr('class', 'loading-organization-info-invisible');
			//$('#loading-format-info').attr('class', 'loading-format-info-invisible');
			$('#inner_issue_info_display').show();
		}
	}
} // end displayFilterLinks ************************************/



function displayOrganizationLinks() {
	var tempContainer = tempDiv = tempElementString = orgLinks = null;
	$('h6:contains("Repository Information")').remove();
	$('#org_info').remove();
	$('#inner_issue_info_display').html('');
	$('#issue_date_header').html('').css('display','none');
	//Display 'Back to filter list' link
	$('#breadcrumb_container').css('display','block');
	//Add pagination links
	$('#page_navigation').html(navigation_html);
	//Add active_page class to the first pagination link
  $('#page_navigation .page_link:first').addClass('active_page');
  // AJE 2014-09-10 rewording links
  //$('#inner_issue_info_display').append('<p>Please select a repository to display issue information:</p>');
  $('#inner_issue_info_display').append('<p>Please select an organization to display issue information:</p>');
	//Create repository links
	$('#inner_issue_info_display').append('<div id="temp_container" class="link_group_container"></div>');
	//$('#inner_issue_info_display').append('<div id="temp_container" class="link_group_container"><p>Please select a repository to display issue information:</p></div>');
	tempContainer = $('#inner_issue_info_display').children('div')[0];
	for (var i in availableOrganizations) {
	  //AJE 2014-09-10
	  //original section just a single line:
		//tempElementString = '<div><a href="" id="' + availableOrganizations[i].repository_id + '">' + availableOrganizations[i].repository_name + '</a>';

				// AJE 2014-09-17 now with function
    //console.log('about to call: get_linked_profile_image( availableOrganizations[', i, '].org_id, availableOrganizations[', i, '].org_name ) as: get_linked_profile_image( ', availableOrganizations[i].org_id, ', ', availableOrganizations[i].org_name, ' )' );
    /*
		tempElementString = '<div>';
    tempElementString += get_linked_profile_image( availableOrganizations[i].org_id, availableOrganizations[i].org_name );
		tempElementString += '&nbsp;&nbsp;<a href="" id="' + availableOrganizations[i].org_id + '" class="issue_trigger">' + availableOrganizations[i].org_name + '</a>';
		tempElementString += '</div>';
		*/
		// AJE 2016-02-11 put the text first, then the image
		tempElementString = '<div>';
		tempElementString += '<a href="" id="' + availableOrganizations[i].org_id + '" class="issue_trigger">' + availableOrganizations[i].org_name + '</a>'
    tempElementString += '&nbsp;&nbsp;';
    tempElementString += get_linked_profile_image( availableOrganizations[i].org_id, availableOrganizations[i].org_name );
		tempElementString += '</div>';

		// end AJE

		$('#temp_container').append(tempElementString);
	} //end for availableOrganizations

	//orgLinks = $('#temp_container div a'); // CJ original
	orgLinks = $('.issue_trigger');  // AJE 2014-09-11: only trigger issue display for clicks on actual organization name, not for clicks on profile link in same div
	for (var j = 0; j < orgLinks.length; j++) {
		orgLinks[j].onclick = function(){
			selectedOrgId = this.id;
			var tmpObject = new Object();
			availableIssues = new Object();
			tmpObject = getObjects(allIssues, 'issue_date', selectedDate);
			availableIssues = getObjects(tmpObject, 'org_id', this.id);
			availableIssues = availableIssues.sort(compareFormatsAndUpdateDates);
			//console.log("In displayOrganizationLinks(), availableIssueslength = " + availableIssues.length);
			display_issue_info_by_org();
			return false;
		}
	}
} // end displayOrganizationLinks ******************************/


// 2015-05-28 [for quite some time] populateFilteredOrganizations is callback for get_filtered_org_info.php
function populateFilteredOrganizations(filteredOrgJSON, textStatus) {
	//alert('In populateFilteredOrganizations');
	if ((filteredOrgJSON.search(/Error/i) != -1) || (filteredOrgJSON.search(/\<b>Notice/i) != -1 )) {
		document.writeln(filteredOrgJSON);
	} else {
	  //console.log('filteredOrgJSON 2016-02-15 15:40:51 = ', filteredOrgJSON);
		filteredOrganizations = JSON.parse(filteredOrgJSON);
	}
} // end populateFilteredOrganizations **************************/



function displayFormatLinks() {
	//console.log("Just entered displayFormatLinks()");
	var tempContainer = tempDiv = tempElementString = formatLinks = currentRepository = null;
	$('h6:contains("Repository Information")').remove();
	$('#org_info').remove();
	$('#inner_issue_info_display').html('');
	$('#issue_date_header').html('').css('display','none');
	//Show 'Back to filter list' link
	$('#breadcrumb_container').css('display','block');
	//Create repository links
	$('#inner_issue_info_display').append('<div id="temp_container" class="link_group_container"><p>Please select a format to display issue information:</p></div>');
	tempContainer = $('#inner_issue_info_display').children('div')[1];
	for (var i in availableFormats) {
    tempElementString = '<div><a href="" id="' + availableFormats[i] + '">' + availableFormats[i] + '</a></div>';
		$('#temp_container').append(tempElementString);
		//console.log("tempElementString in displayFormatLinks(): " + tempElementString);
	}
	formatLinks = $('#temp_container div a');
//console.log("formatLinks length: " + formatLinks.length);
	for (var j = 0; j < formatLinks.length; j++) {
		formatLinks[j].onclick = function(){
			var tmpObject = new Object();
			availableIssues = new Object();
			tmpObject = getObjects(allIssues, 'issue_date', selectedDate);
			//alert(tmpObject[0].format_name);
//console.log("In displayFormatLinks(), this.id = " + this.id);
			availableIssues = getObjects(tmpObject, 'format_name', this.id);
//console.log("At line 1561 in displayFormatLinks() and availableIssues[0].format_name = " + availableIssues[0].format_name);
			availableIssues = availableIssues.sort(compareOrganizationNames);
//console.log("In displayFormatLinks(), availableIssueslength = " + availableIssues.length);
			display_issue_info_by_format();
			return false;
		}
	}
} // end displayFormatLinks ************************************/


/*
  display_issue_info_by_org is called by displayOrganizationLinks :
*/
function display_issue_info_by_org() {
	//console.log("Just entered display_issue_info_by_org()");
	var tempBackLink = null;
	var tempRow = orgInfoContainer = tempIssueInfoElement = tempContents = tempReposContents = null;
	var i = 0;
	$('#inner_issue_info_display').html('');
	$('#issue_date_header').html('').css('display','none');
	//Hide 'Back to filter list' link
	//$('#breadcrumb_container').css('display','none'); // AJE 2014-09-11 trying to fix why was it hidden
	//Create a 'Back' link to redisplay repository list
	$('#inner_issue_info_display').append('<div><a class="breadcrumb" href=""></a></div>');
	tempBackLink = $('#inner_issue_info_display div a')[0];
	tempBackLink.innerHTML = 'Back to organizations list';
	tempBackLink.onclick = function(){
		clearOrganizationInfo();
		displayOrganizationLinks();
		return false;
	};
	orgInfoContainer = document.createElement('div');
	orgInfoContainer.id = 'org_info_container';
	//Populate container with individual issue records
	if (availableIssues.length > 0) {
		for (i = 0; i < availableIssues.length; i++) {
			tempRow = document.createElement('div');
			tempRow.className = 'row';
			tempIssueInfoElement = document.createElement('div');
			//2014-09-09 CFJ - better to create element ids with issueIds, rather than index numbers,
			//because issueIds are available to provenance, reproduction, and reproducer elements
			//tempIssueInfoElement.id = 'issue_info_' + i;
			tempIssueInfoElement.id = 'issue_info_' + availableIssues[i].issue_id;
			tempIssueInfoElement.className = 'issue_info_container twelve columns';
			tempReposContents = buildOrganizationString(availableOrgsArray.indexOf(selectedOrgId));
			tempContents = build_issue_display_string(i);
			tempIssueInfoElement.innerHTML = tempReposContents + tempContents;
			tempRow.appendChild(tempIssueInfoElement);
			orgInfoContainer.appendChild(tempRow);
		}
	}
	$('#inner_issue_info_display').append(orgInfoContainer);
} // end display_issue_info_by_org **************************/


/*
  called by displayFormatLinks
*/
function display_issue_info_by_format() {
	//console.log("Just entered display_issue_info_by_format()");
	var tempBackLink = null;
	var tempRow = formatInfoContainer = tempIssueInfoElement = tempContents = tempReposContents = null;
	var tempIssueInfoTable = null;
	var i = 0;
	$('#inner_issue_info_display').html('');
	$('#issue_date_header').html('').css('display','none');
	//Create a 'Back' link to redisplay format list
	$('#inner_issue_info_display').append('<div><a class="breadcrumb" href=""></a></div>');
	tempBackLink = $('#inner_issue_info_display div a')[0];
	tempBackLink.innerHTML = 'Back to format list';
	tempBackLink.onclick = function(){
		displayFormatLinks();
		return false;
	};
	formatInfoContainer = document.createElement('div');
	formatInfoContainer.id = 'format_info_container';
	//Populate container with individual issue records
	if (availableIssues.length > 0) {
		for (i = 0; i < availableIssues.length; i++) {
//console.log("Looping through available issues in display_issue_info_by_format()");
			tempRow = document.createElement('div');
			tempRow.className = 'row';
			tempIssueInfoElement = document.createElement('div');
			//2014-09-09 CFJ - better to create element ids with issueIds, rather than index numbers,
			//because issueIds are available to provenance, reproduction, and reproducer elements
			//tempIssueInfoElement.id = 'issue_info_' + i;
			tempIssueInfoElement.id = 'issue_info_' + availableIssues[i].issue_id;
			tempIssueInfoElement.className = 'issue_info_container twelve columns';
			tempReposContents = buildOrganizationString(availableOrgsArray.indexOf(availableIssues[i].org_id));
			tempContents = build_issue_display_string(i);
			tempIssueInfoElement.innerHTML = tempReposContents + tempContents;
			tempRow.appendChild(tempIssueInfoElement);
			formatInfoContainer.appendChild(tempRow);
		}
	}
	$('#inner_issue_info_display').append(formatInfoContainer);
} // end display_issue_info_by_format ******************************/



/*
   2015-02-09 buildOrganizationIssueInfoString removed as an orphan: see file containing that name ;
   - build_issue_display_string was called build_issue_display_string is definitely live ;
*/
function build_issue_display_string(issueIndex) {
	var tempIssueId = tempPubId = tempPubDate = tempRepositoryId = tempPhysCondition = tempFormat = tempArchiveStatus = tempProvenance = tempNotes = tempUpdateDate = tempRawIssueData = null;
	//Build a string to display issue info for selected day and format
	issueInfoDisplayString = '';
	tempIssueId = availableIssues[issueIndex].issue_id;
	tempPubId = availableIssues[issueIndex].pubId;
	tempPubDate = availableIssues[issueIndex].issue_date;
	tempRepositoryId = availableIssues[issueIndex].org_Id;
	tempOrgName = availableIssues[issueIndex].org_name;
	tempPhysCondition = availableIssues[issueIndex].condition_name;
	if (tempPhysCondition == 'cccc' || tempPhysCondition == null)
		tempPhysCondition = 'Unknown';
	tempFormat = availableIssues[issueIndex].format_name;
	if (tempFormat == "format unspecified/unknown") {
		tempFormat = "Unspecified or unknown";
	} else if (tempFormat == "Digital pdf") {
		tempFormat = "Digital (pdf)";
	}
	tempArchiveStatus = availableIssues[issueIndex].archive_status_name;
	//2014-05-15 CFJ - provenance, reproduction, and reproducer info now retrieved in displayProvAndRepro() callback function
	//tempProvenance = availableIssues[issueIndex].provenance;
	tempUpdateDate = availableIssues[issueIndex].update_date;
	tempNotes = availableIssues[issueIndex].issue_note;
	tempRawIssueData = availableIssues[issueIndex].rawIssueData;
	issueInfoDisplayString = '<div class="issue_info_right seven columns">';
	//2014-09-09 CFJ - better to create element ids with issueIds, rather than index numbers,
	//because issueIds are available to provenance, reproduction, and reproducer elements
	//issueInfoDisplayString += '<table class="issue_info_table" id="issue_info_table_' + issueIndex + '">';
	issueInfoDisplayString += '<table class="issue_info_table" id="issue_info_table_' + tempIssueId + '">';
	issueInfoDisplayString += '<tr><th>FORMAT:</th><td>' + tempFormat + '</td></tr>';
  issueInfoDisplayString += '<tr><th>CONDITION:</th><td>' + tempPhysCondition + '</td></tr>';
	issueInfoDisplayString += '<tr><th>ARCHIVE STATUS:</th><td>' + tempArchiveStatus + '</td></tr>';
	if (tempRawIssueData != null && tempRawIssueData.length > 0){
			issueInfoDisplayString += '<tr><th>HOLDING STMT:</th><td>' + tempRawIssueData + '</td></tr>';
	}
	if (tempUpdateDate != '0000-00-00' && tempUpdateDate != null) {
		tempUpdateDate = toTitleCase(monthAbbrevArray[parseInt(tempUpdateDate.substr(5,2),10)-1])+ " " + parseInt((tempUpdateDate.substr(8,2)),10) + ", " + tempUpdateDate.substr(0,4);
		issueInfoDisplayString += '<tr><th>LAST UPDATED:</th><td>' + tempUpdateDate + '</td></tr>';
	}
	issueInfoDisplayString += '</table></div>';
	$.get("get_prov_and_repro.php", { 'selectedIssueId': tempIssueId }, displayProvAndRepro);
	return issueInfoDisplayString;
} // end build_issue_display_string



function displayProvAndRepro(provReproJSON, textStatus) {
	var data = JSON.parse(provReproJSON);
	var issueArray = data.issues;
	var tempIssueId = issueArray[0].issueId;
	// var tempProvId = issueArray[0].provenance; ; // AJE 2014-05-16 : field renamed
	var tempPubId = issueArray[0].pubId;
	var tempProvNote = issueArray[0].provNote;
	if (tempProvNote.search("Unknown") == -1) {
		var tempReproductionDesc = issueArray[0].reproductionDesc;
		var tempReproductionDate = issueArray[0].reproductionDate;
		var tempReproductionSeries = issueArray[0].reproductionSeries;
		var tempReproductionDatesVols = issueArray[0].reproductionDatesVols;
		var tempReproductionNote = issueArray[0].reproductionNote;
		var tempReproducerName = issueArray[0].reproducerName;
		var tempReproducerCity = issueArray[0].reproducerCity;
		var tempReproducerCountry = issueArray[0].reproducerCountry;
		var tempRow = parentTable = parentContainer = provReproContainer = provReproTable = provenanceTable = reproductionTable = tempProvLink = currentIssueId = null;
		var provReproContainer = document.createElement('div');
		var innerIssueInfoDisplay = document.getElementById("inner_issue_info_display");
		var tempString = "";

		parentTable = document.getElementById("issue_info_table_" + tempIssueId);
		parentContainer = document.getElementById("issue_info_" + tempIssueId);
		provReproContainer = document.createElement('div');
		provReproContainer.id = "prov_repro_container_" + tempIssueId;
		provReproContainer.className = 'twelve columns';
		parentContainer.appendChild(provReproContainer);
		provenanceTable = document.createElement('table');
		provenanceTable.id = 'provenance_table_' + tempIssueId;
		provenanceTable.className = "provenance_table";
		provenanceTable.innerHTML  = '<tr><th>PROVENANCE:</th><td style="min-width: 0";>' + tempProvNote + '</td></tr>';
		provenanceTable.innerHTML += '<tr><td colspan="2" style="padding-top: 5px;"><a class="prov_link" id="prov_link_' + tempIssueId + '" href="javascript:;">View reproduction information</a></td></tr>';
		provReproContainer.appendChild(provenanceTable);
		reproductionTable = document.createElement('table');
		reproductionTable.id = "reproduction_table_" + tempIssueId;
		reproductionTable.className = "reproduction_table";
		// AJE 2014-09-18 : when not all fields in the reproduction_table are filled out this looks weird no matter what
		//    even outputs the word null for such fields
    // so: tediously check each value + whether both things on a line are present before outputting or inserting separators
		tempString =  "<tr><th>REPRODUCTION</th></tr>";
		tempString += "<tr><th>DATES/VOLS:</th><td>";
  		if(tempReproductionDatesVols){ tempString += tempReproductionDatesVols; }
  		else { tempString += "[unspecified]"; }
    tempString += "</td></tr>";

    tempString += "<tr><th>SERIES:</th><td>";
      if (tempReproductionSeries){ tempString += tempReproductionSeries; }
      if (tempReproductionSeries && tempReproductionDate){ tempString += ", "; }
      if (tempReproductionDate){ tempString += tempReproductionDate; }
    tempString += "</td></tr>";

    tempString += "<tr><th>REPRODUCER:</th><td>";
      if(tempReproducerName){ tempString += tempReproducerName; }
      if(tempReproducerName && tempReproducerCity){ tempString += ", "; }
      if (tempReproducerCity){ tempString += tempReproducerCity; }
      if (tempReproducerCity && tempReproducerCountry){ tempString += ", "; }
      if (tempReproducerCountry){ tempString += tempReproducerCountry; }
    tempString += "</td></tr>";

    tempString += "<tr><th>NOTE:</th><td>";
      if (tempReproductionDesc){ tempString += tempReproductionDesc; }
      if (tempReproductionDesc && tempReproductionNote){ tempString += " ; "; }
      if (tempReproductionNote) { tempString += tempReproductionNote; }
    tempString += "</td></tr>";
    // end AJE 2014-09-18

		reproductionTable.innerHTML += tempString;
		provReproContainer.appendChild(reproductionTable);
		tempProvLink = document.getElementById("prov_link_" + tempIssueId);
		if (tempProvLink != null) {
			tempProvLink.onclick = function(){
				currentIssueId = this.id.substring(10,this.id.length);
				if (this.text == "View reproduction information") {
					this.text = "Hide reproduction information";
					document.getElementById("reproduction_table_" + currentIssueId).style.display = "block";
				} else if (this.text == "Hide reproduction information") {
					this.text = "View reproduction information";
					document.getElementById("reproduction_table_" + currentIssueId).style.display = "none";
				}
				return false;
			};
		}
	}
}



/*
  buildOrganizationString : called by display_issue_info_by_org, display_issue_info_by_format ;
    creates div with org information (name, city, state, etc)
*/
function buildOrganizationString(issueIndex) {
	var tempOrgName = tempReposType = tempReposId = tempStreet1 = tempStreet2 = tempReposCity = tempReposState = tempPostalCode = tempLastUpdated = null;
	var tempOCLCId = tempReposNote = tempHomePage = tempOpac = null;
	var orgAddressString = '';
	orgInfoDisplayString = '<div class="org_info_left five columns">';
	orgInfoDisplayString += '<div id="org_section_' + issueIndex + '"></div><ul>';
	tempOrgName = filteredOrganizations[issueIndex].org_name;
	tempReposType = filteredOrganizations[issueIndex].repositoryTypeName;
	if (filteredOrganizations[issueIndex].street1 != null && filteredOrganizations[issueIndex].street1.length > 0) {
		tempStreet1 = toTitleCase(filteredOrganizations[issueIndex].street1.toLowerCase());
	}
	if (filteredOrganizations[issueIndex].street2 != null && filteredOrganizations[issueIndex].street2.length > 0) {
		tempStreet2 = toTitleCase(filteredOrganizations[issueIndex].street2.toLowerCase());
	}
	tempReposCity = toTitleCase(filteredOrganizations[issueIndex].city.toLowerCase());
	tempReposState = filteredOrganizations[issueIndex].countryId;
	tempReposState = filteredOrganizations[issueIndex].countryId.substr(0,2).toUpperCase();
	tempPostalCode = filteredOrganizations[issueIndex].postalCode;
	tempReposId = filteredOrganizations[issueIndex].repositoryId;
	tempMarcOrgCode = filteredOrganizations[issueIndex].marcOrgCode;
	tempOCLCId = filteredOrganizations[issueIndex].OCLCId;
	tempLastUpdated = filteredOrganizations[issueIndex].reposUpdateDate;
	if (filteredOrganizations[issueIndex].repositoryNote != null) {
		tempReposNote = filteredOrganizations[issueIndex].repositoryNote;
	}
	if (filteredOrganizations[issueIndex].homeURI != null) {
		tempHomePage = filteredOrganizations[issueIndex].homeURI;
	}
	if (filteredOrganizations[issueIndex].opacURI != null) {
		tempOpac = filteredOrganizations[issueIndex].opacURI;
	}
	//Create list items to contain repository address info
  if (tempStreet1 != null && tempStreet1.length > 0) {
		orgAddressString += '<li>' + tempStreet1 + '</li>';
	}
	if (tempStreet2 != null && tempStreet2.length > 0) {
		orgAddressString += '<li>' + tempStreet2 + '</li>';
	}
	orgAddressString += '<li>' + tempReposCity + ', ' + tempReposState;
	if (tempPostalCode != null) {
		orgAddressString += ' ' + tempPostalCode;
	}
	orgAddressString += '</li>';

	//Build the rest of repository display string
	orgInfoDisplayString += '<li style="font-family: Arial;">ORGANIZATION:</li>'

	if (tempHomePage != null && tempHomePage != '') {
	  /* AJE 2014-09-10 preserving original simple code before adding link to CRL profile
		  orgInfoDisplayString += '<li><a href="' + tempHomePage + '" target="_blank">' + tempOrgName + '</a></li>';
		*/

		orgInfoDisplayString += '<li><a href="' + tempHomePage + '" target="_blank">' + tempOrgName + '</a>';
		orgInfoDisplayString += '&nbsp;' + get_linked_profile_image( tempReposId, tempOrgName ) + '</li>';

	} else if (tempOpac != null && tempOpac != '') {
		orgInfoDisplayString += '<li><a href="' + tempOpac + '" target="_blank">' + tempOrgName + '</a></li>';
	} else {
		orgInfoDisplayString += '<li>' + tempOrgName + '</li>';
	}
	orgInfoDisplayString += orgAddressString + '</ul></div></div></div>';
	return orgInfoDisplayString;

		/*
		organizations.org_note is filled in only 235 cases; usually notes like 'aka 0MQ, MQV' [for org_id ZAB].
		These tell us other codes used by same institution and are only internally useful.
		Display of org_note removed until we have a need to show.--AJE
		if (tempReposNote != null && tempReposNote != '') {
			orgInfoDisplayString += '<div class="org_note">' + tempReposNote + '</div>';
		}
	*/

} // end buildOrganizationString *******************************/



// buildZeroDateDisplay: tiny helper for display_issue_info_NO_issues()
function buildZeroDateDisplay( thisFormatName, thisRawIssueData ){
  if (thisRawIssueData.search(thisFormatName) == -1 ) { //then format is already in raw string, don't add it
    return thisFormatName +" format: "+ "&quot;" + thisRawIssueData + "&quot;";
  } else {
    return "&quot;" + thisRawIssueData + "&quot;";
  }
} //end buildZeroDateDisplay ***********************************/



/*
  CJ ca. 2014-09-10 : display_issue_info_NO_issues is the callback for get_zero_date_issues.php
	Response contains data for all zero-date issues.
	Display repository names and concatenated lists of their holding statements, or "No ICON holdings" message
*/
function display_issue_info_NO_issues(noIssueJSON, textStatus) {
	$('#holdings_info_container').remove();
	var data = JSON.parse(noIssueJSON);
	var zeroDateIssues = data.zeroDateIssues;
	var tempListItem = null;
	var rawIssueDataString = "";
	if (zeroDateIssues != null) {
		if (zeroDateIssues.length > 0) {
			$('#bib_id_holdings_row').append('<div class="holdings_heading" style="margin-top: 0px;">HOLDINGS</div>');
			if (zeroDateIssues.length == 1) {
				//Singular wording - only one repository
				$('#bib_id_holdings_row').append('<div class="holdings_heading" style="margin-bottom: 5px;">The following organization reports holding this title:</div>');
			} else {
				//Plural wording - multiple holding orgs
				$('#bib_id_holdings_row').append('<div class="holdings_heading" style="margin-bottom: 5px;">The following organizations report holding this title:</div>');
			}
			$('#bib_id_holdings_row').append('<div id="zero_date_holdings_container" class="twelve columns">' +
																			 '<ul id="zero_date_holdings_list">');


        //just to make the code more readable below
      var openListSpan =  '<li class="zero_date_org"><span class="zero_date_org_name">';

      var zeroDateDisplay = buildZeroDateDisplay(zeroDateIssues[0].format_name, zeroDateIssues[0].rawIssueData);

			for (var i = 0; i < zeroDateIssues.length; i++) {
        zeroDateDisplay = buildZeroDateDisplay( zeroDateIssues[i].format_name, zeroDateIssues[i].rawIssueData );

        var this_org_name = zeroDateIssues[i].org_name;
        var prev_org_name = "";
        var next_org_name = "";
        if (i > 0) { prev_org_name = zeroDateIssues[i-1].org_name; }
        if (i < zeroDateIssues.length-1) { next_org_name = zeroDateIssues[i+1].org_name; }

				if (this_org_name == prev_org_name) { // same as prev org
				  if (this_org_name == next_org_name){ // same as prev and next: add separator, add raw
				    $('#zero_date_holdings_list').append(zeroDateDisplay);
				  } else { // same as prev, different from next: add raw, close list

				    // 2014-09-24 AJE : there is some weirdness where this will not show up on the correct line:
				    //  spurious /LI being added in FFox and IE
				    //$('#zero_date_holdings_list').append(zeroDateDisplay /* + '</li>' */ );
				    // we want the above line but instead just force a span tag so it doesn't stand out so much
				    $('#zero_date_holdings_list').append('<span class="zero_date_org">' +zeroDateDisplay+ '</span>');
				  }
				} else { // different from prev org
				  if (this_org_name == next_org_name){ // same as next: add org, add raw, add separator
				    $('#zero_date_holdings_list').append(openListSpan + this_org_name +'</span>: ' +zeroDateDisplay + ' ; ');
				  } else { // different from prev, different from next: add org, add raw, close list
				    $('#zero_date_holdings_list').append(openListSpan + this_org_name +'</span>: ' +zeroDateDisplay + '</li>');
				  }
				}
        zeroDateDisplay = ""; //reset for next pass thru loop
			} //end for all zeroDateIssues
			tempListItem = document.getElementById('zero_date_holdings_list').lastChild;

			if (tempListItem.textContent.search(":  ; ") != -1 ) {
				tempListItem.textContent = tempListItem.textContent.replace(":  ; ",": ");
			}

		} else { // zeroDateIssues.length is == 0
			$('#bib_id_holdings_row').append('<div class="holdings_heading" style="margin-top: 0px;">NO ICON HOLDINGS</div>');
		}
		$('#bib_id_holdings_row').append('</ul>');
		$('#loading-calendar').html( no_issues_para );
		$('#loading-issue-info').hide();
		$('#loading-organization-info').hide();
		$('#loading-format-info').hide();
		$('#sidebar_charts').css('display', 'none');
		if (hasGenealogy) {
			/********************************************************************************
			// AJE 2014-01-14 PER AMY HIDE GENEALOGY FOR LIVE SITE
						$('#issueDateTab').removeClass('active');
						$('#issue_info_tab').removeClass('active');
						$('#issue_info_tab').hide();
						$('#organizations_tab').hide();
						$('#formats_tab').hide();
						$('#genealogyTab').addClass('active');
						$('#genealogy_tab').addClass('active');
						$('#genealogyTab').prepend('<div class="row"><div id="genealogy_new_window_link_container" class="twelve columns"><a href="genealogy.php?pub_id=' + selectedPubId + '&new_win=true" target="_blank">Open in a new window</a></div></div>');
						$('#genealogy_tab').show();
						$('#tab_container').show();
						displayGenealogyVisualization(noIssueJSON,newWin); // displayGenealogyVisualization lives in collapsible_tree_functions,js
			//END HIDE GENEALOGY FOR LIVE SITE
			********************************************************************************/
		} //end if hasGenealogy
	}
} // end display_issue_info_NO_issues ************************************/



function activateIssueInfoTab() {
	//If not already active, activate issue info tab whenever year, month, or day changes
	//console.info($('li.active').attr('id'));
	if ($('li.active').attr('id') != 'issueDateTab') {
		$('li.active').css('display','none');
		$('.active').removeClass('active');
		//Activate issue info tab
		$('#issue_info_tab').addClass('active');
		$('#issueDateTab').addClass('active');
		$('#issueDateTab').css('display','block');
	}
} // end activateIssueInfoTab **********************************/



function whiteOutCalendar() {
	// whiteOutCalendar simulates disabled state: For accessibility, will need to assign 'disabled' classes
	$('span.ui-state-default').css('backgroundColor', '#FFFFFF').css('color', '#FFFFFF');
	$('a.ui-state-default').css('backgroundColor', '#FFFFFF').css('color', '#FFFFFF');
	$('td.publication_date').css('backgroundColor', '#FFFFFF');
	$('td.selected_publication_date').css('backgroundColor', '#FFFFFF');
	$('td.selected_publication_date a').css('backgroundColor', '#FFFFFF');
	$('th').css('backgroundColor', '#FFFFFF').css('color', '#FFFFFF');
	$('.ui-datepicker-title').css('backgroundColor', '#FFFFFF').css('color', '#FFFFFF');
} // end whiteOutCalendar **************************************/



function clearAvailableMonths() { 	$('.month_box').attr('class', 'month_box month_box_not_available'); }
function clearOrganizationInfo() { 	$('#org_info_container').empty(); }

/*
functions previous(), next(), go_to_page(page_num) were here: moved to paginate_table_unused.js
*/


function getMonthNumber(str) {
	for (var m in tempAvailableMonthsObject) {
		if (tempAvailableMonthsObject[m] == str)
			return parseInt(m,10);
	}
}
function addOption(selectbox,text,value) {
	var optn = document.createElement("option");
	optn.text = text;
	optn.value = value;
	selectbox.options.add(optn);
}



function padDate(num) { 	return (num < 10 ? '0' : '') + num; }



function hasClass(ele,cls) { 	return ele.className.match(new RegExp('(\\s|^)'+cls+'(\\s|$)')); }



function addClass(ele,cls) { 	if (!this.hasClass(ele,cls)) ele.className += " "+cls; }



function getObjects(obj, key, val) {
	var objects = [];
	for (var i in obj) { // AJE: 2015-02-04 - frequent 'script on this page is busy' from this line
		if (!obj.hasOwnProperty(i)) continue;
			if (typeof obj[i] == 'object') {
				objects = objects.concat(getObjects(obj[i], key, val)); // AJE: 2015-02-05 - occasional 'script on this page is busy' from this line
			} else if (i == key && obj[key].search(val) != -1) { // AJE : 2016-02-09 protect original line during testing
          /*

            AJE 2016-02-09
            long-term bug? yesterday ; periodic fails for no reason where this function fails to find an org_id which is clearly present
            - changing that org_id ( DQ$ > DQdollar ) made the problem go away ;
            - tested again with sn85042113 (has H$G) and that fails too
            - tested again with sn85038687 (has C#8) and that seems to work (different error), org_id does get pushed
            - looked at other strategies, went with changing all the org_id values

            //if(obj.hasOwnProperty('org_id')) { console.warn('AJE 2016-02-09 11:21:21 pushing obj ', obj); }

          */
				objects.push(obj); // AJE: 2015-02-05 - occasional 'script on this page is busy' from this line
		}
	}
	return objects;
} // end getObjects



function compareOrganizationNames(a,b) {
	if (a.org_name.toLowerCase()>b.org_name.toLowerCase()) {
		return 1;
	} else if (b.org_name.toLowerCase()>a.org_name.toLowerCase()) {
		return -1;
	} else if (a.org_name.toLowerCase()==b.org_name.toLowerCase()) {
		return 0;
	}
}



function compareFormats(a,b) {
	if (a.format_name>b.format_name) {
		return 1;
	} else if (b.format_name>a.format_name) {
		return -1;
	} else if (a.format_name==b.format_name) {
		return 0;
	}
}



function compareFormatsAndUpdateDates(a,b) {
  var format1 = a.format;
  var format2 = b.format;
  var updateDate1 = a.updateDate;
  var updateDate2 = b.updateDate;
  if (format1 != format2) {
    if (format1 < format2) return -1;
    if (format1 > format2) return 1;
    return 0;
  }
  if (updateDate1 < updateDate2) return -1;
  if (updateDate1 > updateDate2) return 1;
  return 0;
}



function compareOrganizationNamesAndUpdateDates(a,b) {
  var org_name1 = a.org_name.toLowerCase();
  var org_name2 = b.org_name.toLowerCase();
  var updateDate1 = a.updateDate;
  var updateDate2 = b.updateDate;
  if (org_name1 != org_name2) {
    if (org_name1 < org_name2) return -1;
    if (org_name1 > org_name2) return 1;
    return 0;
  }
  if (updateDate1 < updateDate2) return -1;
  if (updateDate1 > updateDate2) return 1;
  return 0;
} // end compareOrganizationNamesAndUpdateDates ****************/



function compareOrganizationNamesAndFormats(a,b) {
  var org_name1 = a.org_name.toLowerCase();
  var org_name2 = b.org_name.toLowerCase();
  var format1 = a.format_name;
  var format2 = b.format_name;
  if (org_name1 != org_name2) {
    if (org_name1 < org_name2) return -1;
    if (org_name1 > org_name2) return 1;
    return 0;
  }
  if (format1 < format2) return -1;
  if (format1 > format2) return 1;
  return 0;
} // end compareOrganizationNamesAndFormats *******************/



function toTitleCase(str) {
  return str.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
}

/*
  addCommasToNumString also lives in statistics.js ;
  - need to create single file of these reformatting utilities, this, toTitleCase, etc
*/
function addCommasToNumString(nStr){ // after: http://www.mredkj.com/javascript/numberFormat.html
  //console.log(	'addCommasToNumString rcvd '	+ nStr);
	nStr += '';
	x = nStr.split('.');
	x1 = x[0];
	x2 = x.length > 1 ? '.' + x[1] : '';
	var rgx = /(\d+)(\d{3})/;
	while (rgx.test(x1)) {
	  x1 = x1.replace(rgx, '$1' + ',' + '$2');
	}
  //console.log(	'addCommasToNumString returns '	+ x1 + x2);
	return x1 + x2;
}//end addCommasToNumString


function addAvailableFormatsToOrganizationsList() {
	var tempFormatAbbrev = null;
	$('#available_organizations ul li').each(function(i) {
			for (var j = 0; j < allFormats.length; j++) {
				if(allOrganizationsAndFormats[i].formats[j][allFormats[j]] == 'true') {
					switch(allFormats[j]) {
						case 'unspecified/unknown':
						  tempFormatAbbrev = 'unk';
						  break;
						case 'Paper':
						  tempFormatAbbrev = 'pap';
						  break;
						case 'Original':
						  tempFormatAbbrev = 'org';
						  break;
						case 'Microfilm':
						  tempFormatAbbrev = 'mfl';
						  break;
						case 'Microfiche':
						  tempFormatAbbrev = 'mfc';
						  break;
						case 'Microopaque':
						  tempFormatAbbrev = 'mop';
						  break;
						case 'Eye-Readable Reprint':
						  tempFormatAbbrev = 'rep';
						  break;
						case 'Digital pdf':
						  tempFormatAbbrev = 'pdf';
						  break;
						case 'Facsimile':
						  tempFormatAbbrev = 'fac';
						  break;
						case 'Photomechanical copy':
						  tempFormatAbbrev = 'pho';
						  break;
						case 'Textile':
						  tempFormatAbbrev = 'ttl';
						  break;
						case 'Digital (Direct electronic)':
						  tempFormatAbbrev = 'dig';
						  break;
						case 'Digital tiff':
						  tempFormatAbbrev = 'dtf';
						  break;
						 case 'Digital (unspecified)':
						  tempFormatAbbrev = 'dun';
						  break;
						default:
						}
					$(this).append(' <span class="' + tempFormatAbbrev + ' format">' + tempFormatAbbrev.toUpperCase() + '</span>');
				}
			}
	});
} // end addAvailableFormatsToOrganizationsList ****************/


/* 2015-02-09 : AJE orphan function groupOrganizationsWithFormats() moved to groupOrganizationsWithFormats_unused.js */

function groupOrganizationsWithFormats() {
	var tempFormatsArray = [];
	var tempReposObject = tempReposObjects = tempFormatObjects = null;
	var tempFormatObject = null;
	var sortedIssues = allIssues.sort(compareOrganizationNamesAndFormats);
	/*
	Create an array of repository objects, one for each of repository holding issues for this title.
	Each repository object has a 'formats' property consisting of an array of format objects.
	There is one format object for each of the title's available formats.
	Each format object has a property name equal to one of the title's available formats,
	with a value initialized to 'false'.
	Sample format object array:
	 [ { 'Eye-Readable Reprint' : 'false' },
		 { 'Microfilm' : 'false' },
	   { 'Original' : 'false' },
	   { 'Paper' : 'false' }
	 ]
	*/
	for (var i = 0; i < allOrganizationNames.length; i++) {
		tempFormatsArray = [];
		tempReposObject = new Object();
		tempReposObject.reposName = allOrganizationNames[i];
		for (var j = 0; j < allFormats.length; j++) {
			tempFormatObject = new Object();
			tempFormatObject[allFormats[j]] = 'false'
			tempFormatsArray.push(tempFormatObject);
		}
		tempReposObject.formats = tempFormatsArray;
		allOrganizationsAndFormats.push(tempReposObject);
	}
	//For each repository object, test whether any issues actually exist for each of the possible formats
	//If so, set value of that property = 'true'
	for (var i = 0; i < allOrganizationsAndFormats.length; i++) {
		tempReposObjects = getObjects(sortedIssues,'org_name',allOrganizationNames[i]);
		for (var j = 0; j < allFormats.length; j++) {
			tempFormatObjects = getObjects(tempReposObjects,'format',allFormats[j]);
			if (tempFormatObjects.length > 0) {
				allOrganizationsAndFormats[i].formats[j][allFormats[j]] = 'true';
			}
		}
	}
	addAvailableFormatsToOrganizationsList();
} // end groupOrganizationsWithFormats **************************/




/*
  AJE 2014-01-17
    - hide sidebar charts when corresponding tabs clicked, show otherwise
    - FUTURE MAINTENANCE: CHECK FOR: "if (issueCounts == null)" TO CHANGE OTHER INSTANCES OF HIDING THESE (there, we hide the whole container)
*/
$( document ).ready(function() {
$('#issue_info_tab').click(function() {
  $('#orgs_chart_sidebar_container').css('visibility', 'visible');
  $('#formats_chart_sidebar_container').css('visibility', 'visible');
  $('.issues_this_date').removeClass('deselected');
});
$('#organizations_tab').click(function() {
  $('#orgs_chart_sidebar_container').css('visibility', 'hidden');
  $('#formats_chart_sidebar_container').css('visibility', 'visible');
  $('.issues_this_date').addClass('deselected');
});
$('#formats_tab').click(function() {
  $('#formats_chart_sidebar_container').css('visibility', 'hidden');
  $('#orgs_chart_sidebar_container').css('visibility', 'visible');
  $('.issues_this_date').addClass('deselected');
});
});// end document.ready




