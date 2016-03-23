/*********************************************************
  I N I T I A L I Z E   G L O B A L   V A R I A B L E S

  2014-04-07: loaded by footer_script_tags.php:
    commonly included after footerCRL.php, no need to duplicate

**********************************************************/
var selectedPubId = null;
var selectedPubIdWithoutSpace = null;
var selectedOrgId = null;
var changeYearFlag = null;
var startupFlag = null;
var selectedYear = null;
var selectedMonth = null;
var selectedDate = null;
var selectedDay = null;

var selectedDateFormatted = null;

var availableMonths = null;
var availableDays = null;
var availableOrganizations = null;
var availableOrgsArray = [];
var availableFormats = null;
var monthNameArray =  new Array('jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec');
var monthAbbrevArray =  new Array('Jan.', 'Feb.', 'Mar.', 'Apr.', 'May', 'Jun.', 'Jul.', 'Aug.', 'Sep.', 'Oct.', 'Nov.', 'Dec.');
var longMonthNameArray =  new Array('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December');
var allIssues = null;
var issueCounts = null;
var maxIssueCount = 0;
var minHoldingsYear = maxHoldingsYear = null;
var yearBox = null;
var firstDay = null;
var defaultDate = null;
var issueInfoDisplayString = "";
var titleLocationString = "";
var publicationInformationString = "";
var holdingsInfoString = "";
var bibIdString = "";
var titleInfoDisplayString = "";  //Obsolete - delete this line when old_calendar.php is no longer needed.  CFJ

var tempRecordId = tempBibId = tempFirstDate = null;
var availableIssues = null;
var barchartElements = null;
var yearCounter = 0;

var tempAvailableMonthsObject = null;
var search_type = 0;
var searchterm_entered = false;
var title_sort_type = 'title';
var title_sort_order = 'ascending';
var from_year_sort_order = 'descending';
var to_year_sort_order = 'descending';
var sorting = false;
var parentCount = 0;
var hasGenealogy = false;
var newWin = false;
var lastSQLquery = null;
var allOrganizationNames = [];
var allFormats = [];
var allOrganizationsAndFormats = [];
var filteredOrganizations = [];
var startupAjaxLoad = true;
var formatFilterOn = false;
var ie = null;

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
