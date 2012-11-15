/*-------------------------------------------------------------*/
/* J Q U E R Y   I N I T I A L I Z A T I O N   F U N C T I O N
/*-------------------------------------------------------------*/
$(function() {
	selectedPubIdWithoutSpace = unescape(selectedPubIdWithoutSpace);
	selectedPubId = selectedPubId.replace('%20', '');
	$.get("get_publication_info.php", { 'pub_id': selectedPubIdWithoutSpace }, displayTitleInfo);
	populateStartupMonths();
	//Change year via dropdown
	$('#year_option').change(function() {
		$('#issue_date_display').html('');
		$('#inner_issue_info_display').html('').hide();
		$('#loading-issue-info').attr('class', 'loading-issue-info-visible');
		clearAvailableMonths();
		clearRepositoryInfo();
		changeYearFlag = true;
		selectedYear = $('#year_option :selected').text();
		whiteOutCalendar();
		styleAvailableMonthBoxes();
	});
	$('.month_box').addClass('month_box_not_available');
	$('.month_box').click(function() {
		clearRepositoryInfo();
		//Clear and hide issue info display
		$('#issue_date_display').html('');
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
	$(".timeline").delegate('.count', 'click', function(){
		$('#issue_date_display').html('');	
		$('#inner_issue_info_display').html('').hide();
		$('#loading-issue-info').attr('class', 'loading-issue-info-visible');
		$('#year_option').attr('disabled', true);
		clearRepositoryInfo();
		clearAvailableMonths();
		changeYearFlag = true;
		selectedYear = $(this).attr('id');
		whiteOutCalendar();
		styleAvailableMonthBoxes();
	});
	$(".timeline").delegate('.count', 'mouseover', function(){
		//Bar turns light green on on mouseOver event
		$(this).css('backgroundColor', '#ADBD90');
	});
	$(".timeline").delegate('.count', 'mouseout', function(){
		//Bar returns to blue on mouseOut event
		$(this).css('backgroundColor', '#4E4F7F');
	});
});
/*-------------------------------*/
/* O T H E R   F U N C T I O N S
/*-------------------------------*/
function displayTitleInfo(results, textStatus) {
	if ((results.search(/Error/i) != -1) || (results.search(/\<b>Notice/i) != -1 )) {
		document.writeln(results);
	} else {
		var tempPubId = tempPubTitle = tempPubTitleAlt = tempPubCity = tempPubState = tempCountry = tempFrequencyIdCode = null;
		var tempPubBgnDate = tempPubEndDate = tempDate260C = tempFrequency310 = tempFormerFrequency321 = tempDate362 = null;
		var tempNumberingNote515 = tempSummary520 = tempDescriptionNote588 = null;
		var data = JSON.parse(results);
		if (data.pubTitle == "") {	
			$('#title_date_display').prepend('<div class="block"><h4>Title Information</h4></div><div class="block" id="title_info"><p>This title does not appear in ICON.</p></div>');
			$('#loading-calendar').html('<p>Sorry, there are no issues in ICON for this title.</p>');
			$('#loading-issue-info').hide();
		} else {
			tempPubId = data.pubId;
			tempMarc001 = data.marc001.replace(/\\/g,'');
			tempMarc001 = tempMarc001.replace(/^ocm/,'');
			tempPubTitle = data.pubTitle;
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
			tempFrequencyIdCode = data.frequencyIdCode;
			tempPubBgnDate = data.pubBgnDate;
			tempPubEndDate = data.pubEndDate;
			tempDate260C = data.date260C;
			tempDate260C = tempDate260C.replace(/</g,'&lt;');
			tempDate260C = tempDate260C.replace(/>/g,'&gt;');
			tempFrequency310 = data.frequency310;
			tempFrequency310 = tempFrequency310.replace(/</g,'&lt;');
			tempFrequency310 = tempFrequency310.replace(/>/g,'&gt;');
			tempFormerFrequency321 = data.formerFrequency321;
			tempFormerFrequency321 = tempFormerFrequency321.replace(/</g,'&lt;');
			tempFormerFrequency321 = tempFormerFrequency321.replace(/>/g,'&gt;');
			tempDate362 = data.date362;
			tempDate362 = tempDate362.replace(/</g,'&lt;');
			tempDate362 = tempDate362.replace(/>/g,'&gt;');
			tempNumberingNote515 = data.numberingNote515;
			tempNumberingNote515 = tempNumberingNote515.replace(/</g,'&lt;');
			tempNumberingNote515 = tempNumberingNote515.replace(/>/g,'&gt;');
			tempSummary520 = data.summary520;
			tempDescriptionNote588 = data.descriptionNote588;
			titleInfoDisplayString += '<div class="title_section_first"><b>' + tempPubTitle + '</b></div>';
			if (tempPubTitleAlt != '') {
				titleInfoDisplayString += '<div class="title_section_first">' + tempPubTitleAlt + '</div>'; 
			}		
			if (tempCountry == 'u' || tempCountry == 'c') {
				//US or Canada, so display city and state but not country name
				titleInfoDisplayString += '<div class="title_section_first">' + tempPubCity + ', ' + tempPubState + '</div>';
			} else {
				//Other country, so display city and country name, but not state
				titleInfoDisplayString += '<div class="title_section_first">' + tempPubCity + ', ' + tempCountry + '</div>';
			}
			titleInfoDisplayString += '<div class="title_section">ID: &nbsp;</span>' + tempPubId + '</div>';
			titleInfoDisplayString += '<div class="title_section">PUBLICATION:<ul>';
			if (tempFrequency310 != '') {
				titleInfoDisplayString += '<li>' + tempFrequency310 + '</li>'; 
			}
			if (tempFormerFrequency321 != '') {
				titleInfoDisplayString += '<li>' + tempFormerFrequency321 + '</li>';
			}
			//Publication dates
			if (tempDate362 != '') {
				titleInfoDisplayString += '<li>' + tempDate362 + '</li>'; 
			} else if (tempDate260C != '') {
				if (tempDate260C.search(/^-/) != -1) {
					titleInfoDisplayString += '<li>' + tempPubBgnDate + tempDate260C + '</li>';
				} else if (tempDate260C.search(/-$/) != -1){
					titleInfoDisplayString += '<li>' + tempDate260C + tempPubEndDate + '</li>';
				} else {
					titleInfoDisplayString += '<li>BEGIN: ' + tempPubBgnDate + '</li>' + 
											  '<li>END: ' + tempPubEndDate + '</li>' + 
										      '<li>DATE 260C: ' + tempDate260C + '</li>';
				}
			} else if ((tempPubBgnDate != '') || (tempPubEndDate != '')) {
				titleInfoDisplayString += '<li>BEGIN: ' + tempPubBgnDate + '</li>' + 
										  '<li>END: ' + tempPubEndDate + '</li>';
			}
			titleInfoDisplayString += '</ul></div>';
			if (tempNumberingNote515 != '' || tempSummary520 != '' || tempDescriptionNote588 != '') {
				titleInfoDisplayString += '<div class="title_section">NOTES:<ul>';
				if (tempNumberingNote515 != '') {
					titleInfoDisplayString += '<li>' + tempNumberingNote515 + '</li>'; 
				}
				if (tempSummary520 != '') {
					titleInfoDisplayString += '<li>' + tempSummary520 + '</li>'; 
				}
				if (tempDescriptionNote588 != '') {
					titleInfoDisplayString += '<li>' + tempDescriptionNote588 + '</li>'; 
				}
				titleInfoDisplayString += '</ul></div>';
			}
			if (tempMarc001 != '') {
				titleInfoDisplayString += '<!--Andy rmvd this for Amys demo to CRL Annual Meeting 17 Apr 2012';
				titleInfoDisplayString += '<span class="title_info_label">OCLC: &nbsp;</span>' + tempMarc001 + '<br />';
				titleInfoDisplayString += 'end AJE-->';
			}
			$('#title_date_display').prepend('<div class="block"><h4>Title Information</h4></div><div class="block" id="title_info"><p>' + titleInfoDisplayString + '</p></div>');
			$('#loading-calendar').html('<p>Searching for issues&nbsp; . . . &nbsp;&nbsp;<img src="loading-calendar.gif" /></p>');
			$('#loading-calendar').attr('class', 'loading-calendar-visible');
			$.get("get_all_issues.php", { 'selectedPubId': selectedPubId }, populateAllIssues);
		}
	}
}
function populateStartupMonths() {
	tempAvailableMonthsObject = new Object();
	for (var i = 0; i < monthNameArray.length; i++) {
		tempAvailableMonthsObject[i] = monthNameArray[i];
	}
}
function populateAllIssues(results, textStatus) {
	if ((results.search(/Error/i) != -1) || (results.search(/\<b>Notice/i) != -1 )) {
		document.writeln(results);
	} else {
		var data = JSON.parse(results);
		allIssues = data.allIssues;
	}
	populateIssueCounts();
}
function populateIssueCounts() {
	if (allIssues[0] != null) {
		var tmpMonths = new Object();
		var tmpObject = null;
		issueCounts = new Object();
		var currYr = currDate = tmpDate = currMonth = tmpMonth = null;
		var tmpCount = yearCounter = monthCounter = 0;
		var tmpYr = allIssues[0]['pubDate'].substr(0,4);
		var tmpFirstYear = tmpYr;
		var tmpFirstMonth = allIssues[0]['pubDate'].substr(5,2);
		for (var issue in allIssues) {
			currYr = allIssues[issue]['pubDate'].substr(0,4);
			currDate = allIssues[issue]['pubDate'];
			currMonth = allIssues[issue]['pubDate'].substr(5,2);
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
				tmpMonth = currMonth = allIssues[issue].pubDate.substr(5,2);
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
	}
	finishInitialization();
}
function finishInitialization() {
	if (issueCounts == null) {
		//$('#loading-calendar').html('No issues for ' + selectedPubIdWithoutSpace + " in database");
		$('#loading-calendar').html('<p>Sorry, there are no issues in ICON for this title.</p>');
		$('#loading-issue-info').hide();
		return false;	
	} else {
		startupFlag = true;
		yearBox = document.getElementById("year_option");
		selectedYear = issueCounts[0].year;
		//Populate barchart timeline
		displayDecadesBarchart();
		//Populate an array with available months for first available year
		//Month box and calendar controls are populated in the callback
		styleAvailableMonthBoxes();
	}
}
function displayDecadesBarchart() {
	var tempYear, tempYearDigit, tempDecadeDigits, tempBarchartAnchor, tempBarchartElement1, tempBarchartElement2, tempClass, tempBarSize;
	for (var i in issueCounts) {
		tempYear = issueCounts[i].year;
		tempIssueCount = issueCounts[i].count;
		tempBarSize = (tempIssueCount/maxIssueCount * 100) + "%";
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
		tempBarchartElement2.id = tempYear;
		tempBarchartElement2.style.height = tempBarSize;
		tempBarchartElement1.appendChild(tempBarchartElement2);
	}
}
function styleAvailableMonthBoxes() {
	var tempMonth = tempPubDate = tempMonthBoxId = tempMonthBox = tmpObject = null;
	availableMonths = new Object();
	tmpObject = getObjects(issueCounts, 'year', selectedYear)[0];
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
}
function populateAvailableDays() {
	availableDays = new Object();
	var tempDefaultDate = null;
	var tmpMonthYear = selectedYear + "-" + padDate(parseInt(selectedMonth+1,10));
	availableDays = getObjects(allIssues, 'pubDate', tmpMonthYear);
	if (availableDays.length == 0) {
		//There are no available issues in selected month
		//Change calendar month without populating day array
		//No date cells will contain links
		firstDay = new Date(selectedYear, selectedMonth, 1);
		selectedDate = selectedYear + '-' + padDate(parseInt(selectedMonth+1,10)) + '-01';
		$('#datepicker_container').datepicker('setDate', firstDay);
		$('#issue_date_display').html('No issues available for this month');
		$('#loading-issue-info').hide();
	} else {
		//There are available issues in selected month
		//Change calendar month after populating day array
		//Available date cells will contain links
		tempDefaultDate = selectedDate = availableDays[0].pubDate;
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
													onChangeMonthYear: function() {
														if (availableDays.length == 0) {
															$('#issue_date_display').html('No issues available for this month');
														} else {
															$('#issue_date_display').html('Issue date: &nbsp;' + selectedDate);
														}
													},
													onSelect: function(date) {
														selectedDay = date.substr(date.length-2,2);
														selectedDate = selectedYear + '-' + padDate(parseInt(selectedMonth,10)+1) + '-' + selectedDay;
														$('#issue_date_display').html('Issue date: &nbsp;' + selectedDate);
														displayFilterLinks();
													}
			});				
			startupFlag = false;
			changeYearFlag = false;
			$('#loading-calendar').attr('class', 'loading-calendar-invisible');
			$('#issue_date_display').html('Issue date: &nbsp;' + selectedDate);
			displayFilterLinks();
			$('#inner_selection_control_wrapper').show();
		} else {
			//Month or year changed in response to user selection, not page load
			//Set calendar default date to first available day in selected month and year
			$("#datepicker_container").datepicker("setDate", defaultDate);
			$('#issue_date_display').html('Issue date: &nbsp;' + selectedDate);
			displayFilterLinks();
		}
	}
}
function displayFilteredYearDropdown() {
	yearBox.options.length = 0;
	for (var i in issueCounts) {
		addOption(yearBox, issueCounts[i].year, i+1);
	}			
}
function highlightIssueDates(date) {
	if (availableDays.length > 0) {
		var tempDateString, tempMonth, tempDay;
		tempMonth = padDate(date.getMonth()+1);
		tempDay = padDate(date.getDate());
		tempDateString = date.getFullYear() +"-" + tempMonth + "-" + tempDay;
		var daysReturned = getObjects(availableDays, 'pubDate', tempDateString);
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
}
function displayFilterLinks() {
	if (availableDays.length == 0) {
		$('#loading-issue-info').attr('class', 'loading-issue-info-invisible');
		$('#inner_issue_info_display').html('').hide();			
	} else {
		//Create filter links
		var tempContainer = tempDiv = tempLink = null;
		$('#inner_issue_info_display').html('');
		$('#inner_issue_info_display').append('<div></div>');
		tempContainer = $('#inner_issue_info_display').children('div')[0];
		tempContainer.id = 'tempContainer';
		tempContainer.className = 'link_group_container';
		$('#tempContainer').append('<div>Filter by:</div><div><a id="Filter by Repository" href="#">Repository</a></div>');
		$('#tempContainer').append('<div><a id="Filter by Format" href="#">Format</a></div>');
		tempDiv = $('#tempContainer').children('div')[0];
		tempDiv.style.padding = '0 0 10px 0';
		tempDiv = $('#tempContainer').children('div')[1];
		tempLink = tempDiv.childNodes[0];
		tempLink.onclick = function(){
			var tmpRepId = null;
			var tmpSortedIssuesObject = new Object();
			var tmpObject = new Object();
			availableRepositories = new Object();
			var sortedIssues = allIssues.sort(compareRepositoryNames);
			tmpSortedIssuesObject = getObjects(sortedIssues, 'pubDate', selectedDate);
			for (var i in tmpSortedIssuesObject) {
				//Create list of unique repository codes from issue records with this publication date
				if (tmpSortedIssuesObject[i].repositoryId != tmpRepId) {
					tmpObject = new Object();
					tmpObject.repository_name = tmpSortedIssuesObject[i].repositoryName;
					tmpObject.repository_id = tmpSortedIssuesObject[i].repositoryId;
					availableRepositories[i] = tmpObject;
					tmpRepId = tmpSortedIssuesObject[i].repositoryId;
				}				
			}
			displayRepositoryLinks();
		};	
		tempDiv = $('#tempContainer').children('div')[2];
		tempLink = tempDiv.childNodes[0];
		tempLink.onclick = function(){
			var tmpFormat = null;
			var tmpObject = new Object();
			availableFormats = new Object();
			var sortedIssues = allIssues.sort(compareFormats);
			tmpObject = getObjects(sortedIssues, 'pubDate', selectedDate);
			tmpFormat = tmpObject[0].format;
			availableFormats[0] = tmpFormat;
			for (var i in tmpObject) {
				//Create list of unique formats from issue records with this publication date
				if (tmpObject[i].format != tmpFormat) {
					availableFormats[i] = tmpObject[i].format;
					tmpFormat = tmpObject[i].format;
				}				
			}
			displayFormatLinks();
		};
		$('#loading-issue-info').attr('class', 'loading-issue-info-invisible');
		$('#inner_issue_info_display').show();
	}
}
function displayRepositoryLinks() {
	var tempContainer = tempDiv = tempElementString = repositoryLinks = null;
	$('#inner_issue_info_display').html('');
	//Create a 'Back' link to redisplay filter list
	$('#inner_issue_info_display').append('<div><a class="breadcrumb" href="#" onclick="displayFilterLinks()">Back to filter list</a></div>');
	//Create repository links
	$('#inner_issue_info_display').append('<div id="temp_container" class="link_group_container"><p>Please select a repository to display issue information:</p></div>');
	tempContainer = $('#inner_issue_info_display').children('div')[1];
	for (var i in availableRepositories) {
		tempElementString = '<div><a href="#" id="' + availableRepositories[i].repository_id + '">' + availableRepositories[i].repository_name + '</a></div>';
		$('#temp_container').append(tempElementString);
	}
	repositoryLinks = $('#temp_container div a');
	for (var j = 0; j < repositoryLinks.length; j++) {
		repositoryLinks[j].onclick = function(){
			selectedRepositoryId = this.id;
			var tmpObject = new Object();
			availableIssues = new Object();
			tmpObject = getObjects(allIssues, 'pubDate', selectedDate);
			availableIssues = getObjects(tmpObject, 'repositoryId', this.id);
			availableIssues = availableIssues.sort(compareFormats);
			displayIssueInfoByRepository();
			$.get("get_repository_info.php", { 'selectedRepositoryId': selectedRepositoryId }, displayRepositoryInfo);
		}
	}
}
function displayFormatLinks() {
	var tempContainer = tempDiv = tempElementString = formatLinks = null;
	$('#inner_issue_info_display').html('');
	//Create a 'Back' link to redisplay filter list
	$('#inner_issue_info_display').append('<div><a class="breadcrumb" href="#" onclick="displayFilterLinks()">Back to filter list</a></div>');
	//Create repository links
	$('#inner_issue_info_display').append('<div id="temp_container" class="link_group_container"><p>Please select a format to display issue information:</p></div>');
	tempContainer = $('#inner_issue_info_display').children('div')[1];
	for (var i in availableFormats) {
		tempElementString = '<div><a href="#" id="' + availableFormats[i] + '">' + availableFormats[i] + '</a></div>';
		$('#temp_container').append(tempElementString);
	}
	formatLinks = $('#temp_container div a');
	for (var j = 0; j < formatLinks.length; j++) {
		formatLinks[j].onclick = function(){
			var tmpObject = new Object();
			availableIssues = new Object();
			tmpObject = getObjects(allIssues, 'pubDate', selectedDate);
			availableIssues = getObjects(tmpObject, 'format', this.id);
			availableIssues = availableIssues.sort(compareRepositoryNames);
			displayIssueInfoByFormat();
		}
	}
}
function displayIssueInfoByFormat() {
	var tempBackLink = null;
	$('#inner_issue_info_display').html('');
	//Create a 'Back' link to redisplay format list
	$('#inner_issue_info_display').append('<div><a class="breadcrumb" href="#"></a></div>');
	tempBackLink = $('#inner_issue_info_display div a')[0];
	tempBackLink.innerHTML = 'Back to format list';
	tempBackLink.onclick = function(){
		displayFormatLinks();
	};
	buildIssueInfoString();
	$('#inner_issue_info_display').append(issueInfoDisplayString);
}
function displayIssueInfoByRepository() {
	var tempBackLink = null;
	$('#inner_issue_info_display').html('');
	//Create a 'Back' link to redisplay repository list
	$('#inner_issue_info_display').append('<div><a class="breadcrumb" href="#"></a></div>');
	tempBackLink = $('#inner_issue_info_display div a')[0];
	tempBackLink.innerHTML = 'Back to repository list';
	tempBackLink.onclick = function(){
		clearRepositoryInfo();
		displayRepositoryLinks();
	};
	buildIssueInfoString();
	$('#inner_issue_info_display').append(issueInfoDisplayString);
}
function displayIssueInfoByFormat(results, textStatus) {
	var tempBackLink = null;
	$('#inner_issue_info_display').html('');
	//Create a 'Back' link to redisplay format list
	$('#inner_issue_info_display').append('<div><a class="breadcrumb" href="#"></a></div>');
	tempBackLink = $('#inner_issue_info_display div a')[0];
	tempBackLink.innerHTML = 'Back to format list';
	tempBackLink.onclick = function(){
		displayFormatLinks();
	};
	buildIssueInfoString();
	$('#inner_issue_info_display').append(issueInfoDisplayString);
}
function buildIssueInfoString() {
	var tempIssueId = tempPubId = tempPubDate = tempRepositoryId = tempPhysCondition = tempFormat = tempArchiveStatus = tempProvenance = tempNotes = tempUpdateDate = null;
	//Build a string to display issue info for selected day and repository or format
	issueInfoDisplayString = '';
	for (var i in availableIssues) {
		tempIssueId = availableIssues[i].issueId;
		tempPubId = availableIssues[i].pubId;
		tempPubDate = availableIssues[i].pubDate;
		tempRepositoryId = availableIssues[i].repositoryId;
		tempRepositoryName = availableIssues[i].repositoryName;
		tempPhysCondition = availableIssues[i].physCondition;
		if (tempPhysCondition == 'cccc' || tempPhysCondition == null)
			tempPhysCondition = 'Unknown';
		tempFormat = availableIssues[i].format;
		tempArchiveStatus = availableIssues[i].archiveStatus;
		/*
		//Per Andy, suppress provenance until there is meaningful field data
		tempProvenance = availableIssues[i].provenance;
		if (tempProvenance == 'pppp' || tempProvenance == null || tempProvenance == '')
			tempProvenance = 'Unknown';
		*/
		tempUpdateDate = availableIssues[i].updateDate;
		tempNotes = availableIssues[i].notes;
		issueInfoDisplayString +=   '<br /><span class="issue_info_label">ISSUE DATE: &nbsp;</span>' + tempPubDate + '<br />' +
									'<span class="issue_info_label">REPOSITORY: &nbsp;</span>' + tempRepositoryName + '<br />';
		if (tempPhysCondition == "condition unspecified/unknown") {
			issueInfoDisplayString += '<span class="issue_info_label">CONDITION: &nbsp;</span>Unspecified or unknown<br />';
		} else {
			issueInfoDisplayString += '<span class="issue_info_label">CONDITION: &nbsp;</span>' + tempPhysCondition + '<br />';
		}
		issueInfoDisplayString += '<span class="issue_info_label">FORMAT: &nbsp;</span>' + tempFormat + '<br />';
		if (tempArchiveStatus == "archive status unspecified/unknown") {
			issueInfoDisplayString += '<span class="issue_info_label">ARCHIVE STATUS: &nbsp;</span>Unspecified or unknown<br />';
		} else {
			issueInfoDisplayString += '<span class="issue_info_label">ARCHIVE STATUS: &nbsp;</span>' + tempArchiveStatus + '<br />';
		}
		if (tempNotes != null) {
			if (tempNotes.search('nnnn') == -1) {
					//Note field is populated and does not contain 'nnnn', so display it
					//issueInfoDisplayString +=	'<span class="issue_info_label">PROVENANCE: &nbsp;</span>' + tempProvenance + '<br />' +
					issueInfoDisplayString +=	'<span class="issue_info_label">NOTES: &nbsp;</span>' + tempNotes + '<br />';
			}
			/*
			//Per Andy, suppress provenance until there is meaningful field data
			else {
				//Note field contains 'nnnn', so suppress it
				issueInfoDisplayString +=	'<span class="issue_info_label">PROVENANCE: &nbsp;</span>' + tempProvenance + '<br />';
			}
		*/
		} else {
			//Note field is null, so suppress it
			issueInfoDisplayString +=	'<span class="issue_info_label">PROVENANCE: &nbsp;</span>' + tempProvenance + '<br />';
		}
		if (tempUpdateDate != null) {
			issueInfoDisplayString +=	'<span class="issue_info_label">LAST UPDATED: &nbsp;</span>' + tempUpdateDate + '<br />';
		}
	}
	issueInfoDisplayString = issueInfoDisplayString + '<br />';
}
function displayRepositoryInfo(results, textStatus) {
	var tempReposName = tempReposType = tempReposId = tempStreet1 = tempStreet2 = tempReposCity = tempReposState = tempPostalCode = tempLastUpdated = null;
	var tempReposNote = tempHomePage = tempOpac = null;
	reposInfoDisplayString = '';
	var reposAddressString = '';
	if ((results.search(/Error/i) != -1) || (results.search(/\<b>Notice/i) != -1 )) {
		document.writeln(results);
	} else {
		clearRepositoryInfo();
		var data = JSON.parse(results);
		tempReposName = data.repositoryName;
		tempReposType = data.repositoryTypeName;
		if (data.street1 != null) {
			tempStreet1 = toTitleCase(data.street1.toLowerCase());
		}
		if (data.street2 != null) {
			tempStreet2 = toTitleCase(data.street2.toLowerCase());
		}
		tempReposCity = toTitleCase(data.city.toLowerCase());
		tempReposState = data.countryId;
		tempReposState = data.countryId.substr(0,2).toUpperCase();
		tempPostalCode = data.postalCode;
		tempReposId = data.repositoryId;
		tempMarcOrgCode = data.marcOrgCode;
		tempOCLCId = data.OCLCId;
		tempLastUpdated = data.lastUpdated;
		if (data.repositoryNote != null) {
			tempReposNote = data.repositoryNote;
		}
		if (data.homeURL != null) {
			tempHomePage = data.homeURL;
		}
		if (data.opacURL != null) {
			tempOpac = data.opacURL;
		}
		//Build repository address display string
		if (tempStreet2 != '') {
			reposAddressString += tempStreet1 + '<br />' + tempStreet2 + '<br />';
		} else if (tempStreet1 != '') {
			reposAddressString += tempStreet1 + '<br />';
		}
		reposAddressString += tempReposCity + ', ' + tempReposState;
		if (tempPostalCode != null) {
			reposAddressString += ' ' + tempPostalCode + '<br />';
		} else {
			reposAddressString += '<br />';
		}
		//Build the rest of repository display string
		if (tempHomePage != null && tempHomePage != '') {
			reposInfoDisplayString = '<a href="' + tempHomePage + '" target="_blank">(' + tempReposId + ') ' + tempReposName + '</a><br />';
		} else if (tempOpac != null && tempOpac != '') {
			reposInfoDisplayString = '<a href="' + tempOpac + '" target="_blank">(' + tempReposId + ') ' + tempReposName + '</a><br />';
		} else {
			reposInfoDisplayString = '(' + tempReposId + ') ' + tempReposName + '<br />'
		}
		reposInfoDisplayString += reposAddressString;
		if (tempReposNote != null && tempReposNote != '') {
			reposInfoDisplayString += '<div class="repos_note">' + tempReposNote + '</div>';
		}
		$('#title_date_display').append('<div class="block" id="repository_info"><h4>Repository Information</h4><p>' + reposInfoDisplayString + '</p></div>');
	}
}
function whiteOutCalendar() {
	//Simulates disabled state
	//For accessibility, will need to assign 'disabled' classes
	$('span.ui-state-default').css('backgroundColor', '#FFFFFF').css('color', '#FFFFFF');
	$('a.ui-state-default').css('backgroundColor', '#FFFFFF').css('color', '#FFFFFF');
	$('td.publication_date').css('backgroundColor', '#FFFFFF');
	$('td.selected_publication_date').css('backgroundColor', '#FFFFFF');
	$('td.selected_publication_date a').css('backgroundColor', '#FFFFFF');
	$('th').css('backgroundColor', '#FFFFFF').css('color', '#FFFFFF');
	$('.ui-datepicker-title').css('backgroundColor', '#FFFFFF').css('color', '#FFFFFF');
}
function clearAvailableMonths() {
	$('.month_box').attr('class', 'month_box month_box_not_available');
}
function clearRepositoryInfo() {

	if ($('#repository_info').length != 0) {
		$('#repository_info').remove();
	}
}
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
function padDate(num) {
	return (num < 10 ? '0' : '') + num;
}
function hasClass(ele,cls) {
	return ele.className.match(new RegExp('(\\s|^)'+cls+'(\\s|$)'));
}
function addClass(ele,cls) {
	if (!this.hasClass(ele,cls)) ele.className += " "+cls;
}
function getObjects(obj, key, val) {
	var objects = [];
	for (var i in obj) {
		if (!obj.hasOwnProperty(i)) continue;
			if (typeof obj[i] == 'object') {
				objects = objects.concat(getObjects(obj[i], key, val));
			} else if (i == key && obj[key].search(val) != -1) {
				objects.push(obj);
		}
	}
	return objects;
}
function compareRepositoryIds(a,b) {
	if (a.repositoryId>b.repositoryId) {
		return 1;
	} else if (b.repositoryId>a.repositoryId) {
		return -1;
	} else if (a.repositoryId==b.repositoryId) {
		return 0;
	}
}
function compareRepositoryNames(a,b) {
	if (a.repositoryName>b.repositoryName) {
		return 1;
	} else if (b.repositoryName>a.repositoryName) {
		return -1;
	} else if (a.repositoryName==b.repositoryName) {
		return 0;
	}
}
function compareFormats(a,b) {
	if (a.format>b.format) {
		return 1;
	} else if (b.format>a.format) {
		return -1;
	} else if (a.format==b.format) {
		return 0;
	}
}
function toTitleCase(str)
{
    return str.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
}
