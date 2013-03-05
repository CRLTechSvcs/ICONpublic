/*-------------------------------------------------------*/
/* I N I T I A L I Z E   G L O B A L   V A R I A B L E S
/*-------------------------------------------------------*/
var selectedPubId = null;
var selectedPubIdWithoutSpace = null;
var selectedRepositoryId = null;
var changeYearFlag = null;
var startupFlag = null;
var selectedYear = null;
var selectedMonth = null;
var selectedDate = null;
var selectedDay = null;

var selectedDateFormatted = null;

var availableMonths = null;
var availableDays = null;
var availableRepositories = null;
var availableFormats = null;
var monthNameArray =  new Array('jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec');
var monthAbbrevArray =  new Array('Jan.', 'Feb.', 'Mar.', 'Apr.', 'May', 'Jun.', 'Jul.', 'Aug.', 'Sep.', 'Oct.', 'Nov.', 'Dec.');
var allIssues = null;
var issueCounts = null;
var maxIssueCount = 0;
var yearBox = null;
var firstDay = null;
var defaultDate = null;
var issueInfoDisplayString = "";
var titleInfoDisplayString = "";

var tempRecordId = tempBibId = tempFirstDate = null;
var availableIssues = null;
var barchartElements = null;

var tempAvailableMonthsObject = null;

/*-------------------------------------------------------*/
/* P A G I N A T I O N   V A R I A B L E S
/*-------------------------------------------------------*/
//Number of repository or format links to show per page
var show_per_page = 5; 
//Current numer of links displayed 
var number_of_items = 0;
//Total number of pages
var number_of_pages = 0;  
//Page number corresponding to current pagination link
var current_link = 0;
var navigation_html = '';
