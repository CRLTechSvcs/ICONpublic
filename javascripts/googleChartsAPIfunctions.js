/*
  AJE 2013-08-19 17:25:33
  this script in external file so same version can be used by
    statistics.php and statistics_live.php

  2013-11-07 17:19:47
  UPDATED TO TEST GOOGLE CHART API

  2013-11-22 13:56:52
  NOW: 1 version for calendar page and statistics pages

*/


  // Load the Visualization API and the piechart package.
  // this is the package for basic charts, Pie, Bar, Line charts, and their functionality
google.load('visualization', '1.0', {'packages':['corechart']});
//console.info("Loaded basic chart package");

  // package for map charts
//google.load('visualization', '1.0', {'packages':['geomap']});
google.load('visualization', '1', {'packages': ['geochart']});
//console.info("Loaded map chart package");

var CRLcolors = ['#2d2d4d','#8ca061', '#e97100', '#303030', '#adbd90', '#da5856', '#485b2e', '#4e4f7f'];
/*
  above set of CRLcolors is the original ;
  next is a test version based on the color scale for some of the larger maps;
    - it doesn't look bad but reverted to original anyway, that seems slightly better
var CRLcolors = ['#adbd90','#8ca061','#839c5d','#627544','#485b2e','#32401e', '#37422e', '#454a5f', '#4e4f7f','#434373','#2d2d4d','#000000'];
*/

  //NOT using a callback function: we'll explicitly call drawChart_pubsByCountries() when countriesArray is filled
//google.setOnLoadCallback(drawChart_pubsByCountries); // Set a callback to run when the Google Visualization API is loaded.


/********************************************************************************
  - some global stuf for chart options common to maps, pies, lines, bars
*/
var chartWidthStatsPage = 900; // pixels: orig 900
var chartHeightStatsPage = 500; // orig 500



/*********************************************************************************
  Google expects certain specific strings as country names, to be able to correlate data with place on map
  - set_GOOGLE_country_names gets the country name as in ICON's bibliographic version, returns name needed by Google

  renaming of some countries ('Burma' > 'Myanmar'), these countries show outside of their alpha order, so we have to fix
    https://developers.google.com/chart/interactive/docs/reference?csw=1#DataTable_sort
      To sort by the third column and then by the second column, use:
      data.sort([{column: 2}, {column: 1}]);
  This sorting is done on a case by case basis (pie charts for countries is the only one so far)

*/
function set_GOOGLE_country_names(country_name){

    switch (country_name){ //handle weird exceptions
      case "Armenia (Republic)" : country_name = "Armenia"; break;
      case "Bosnia and Hercegovina" : country_name = "Bosnia and Herzegovina"; break;
      case "Burma" : country_name = "Myanmar"; break;
      case "China (Republic : 1949- )" : country_name = "Taiwan"; break;
      case "C&ocirc;te d'Ivoire" : country_name = "Ivory Coast"; break;
      case "Congo (Brazzaville)" : country_name = "Congo - Brazzaville"; break; // MARC/ICON code: cf
      case "Congo (Democratic Republic)" : country_name = "Congo - Kinshasa"; break; // MARC/ICON code: cg
      case "Cura&ccedil;ao" : country_name = "Curacao"; break;
      case "Georgia (Republic)" : country_name = "Georgia"; break;
      case "Micronesia (Federated States)": country_name = "Micronesia, Federated States of"; break;
      case "Korea (North)": country_name = "North Korea"; break;
      case "Korea (South)": country_name = "South Korea"; break;
      case "New York (State)" : country_name = "New York"; break;

        //Google needs it as 'Quebec' to show on map; countries.country_name is: Québec (Province); see also get_statistics_countries_static.php
      case "Qu&eacute;bec" : country_name = "Quebec"; break;
      case "Qu&eacute;bec (Province)" : country_name = "Quebec"; break; // this works for display_publications_by_country.php
      case "Québec (Province)" : country_name = "Quebec"; break;

      case "R&eacute;union" : country_name = "Reunion"; break;
      case "Russia (Federation)" : country_name = "Russia"; break;
      case "Surinam" : country_name = "Suriname"; break;

      // Australia state problems:
      /*
      //  OOPS THERE ARE NO PUBS IN xoa : JUST SAVE THIS
      case "Northern Territory" :
        country_name = "AU-NT"; // only the code works, not the name
        break;
      */

    // Tasmania: for GeoMap or GeoChart, only code 'AU-TAS' works to generate data, not name: looks stupid on popup but there you are
      case "Tasmania" :
        country_name = "AU-TAS";
        break;

      case "Washington (State)" : country_name = "Washington"; break;
    }//end switch
    return country_name;

}//end set_GOOGLE_country_names




/*********************************************************************************
  Google expects certain specific strings as country names, to be able to correlate data with place on map
  - set_ICON_country_names gets the country name needed by Google
  - set_ICON_country_names returns name needed for display_publications_by_country.php
*/
function set_ICON_country_names(country_name){

    switch (country_name){
      case "Armenia" : country_name = "Armenia (Republic)"; break;
      case "Bosnia and Herzegovina" : country_name = "Bosnia and Hercegovina"; break;
      case "Myanmar" : country_name = "Burma"; break;
      case "Taiwan" : country_name = "China (Republic : 1949- )"; break;
      case "Ivory Coast" : country_name = "C&ocirc;te d'Ivoire"; break;
      case "Congo - Brazzaville" : country_name = "Congo (Brazzaville)"; break; // MARC/ICON code: cf
      case "Congo - Kinshasa" : country_name = "Congo (Democratic Republic)"; break; // MARC/ICON code: cg
      case "Curacao" : country_name = "Cura&ccedil;ao"; break; // ok for display_publications_by_country.php
      case "Georgia" : country_name = "Georgia (Republic)"; break;
      case "Micronesia, Federated States of": country_name = "Micronesia (Federated States)"; break;
      case "North Korea": country_name = "Korea (North)"; break;
      case "South Korea": country_name = "Korea (South)"; break;
      case "New York" : country_name = "New York (State)"; break;

        //Google needs it as 'Quebec' to show on map; countries.country_name is: Québec (Province); see also get_statistics_countries_static.php
      case "Quebec" : country_name = "Qu&eacute;bec"; break;
      case "Quebec" : country_name = "Qu&eacute;bec (Province)"; break; // ok for display_publications_by_country.php
      case "Quebec" : country_name = "Québec (Province)"; break;

      case "Reunion" : country_name = "R&eacute;union"; break;
      case "Russia" : country_name = "Russia (Federation)"; break;
      case "Suriname" : country_name = "Surinam"; break;

      // Australia state problems:
      /*
      //  OOPS THERE ARE NO PUBS IN xoa : JUST SAVE THIS
      case "Northern Territory" :
        country_name = "AU-NT"; // only the code works, not the name
        break;
      */

      case "AU-TAS" :
        country_name = "Tasmania"; // only the code works, not the name
        break;

      case "Washington" : country_name = "Washington (State)"; break;
    }//end switch

    return country_name;

}//end set_ICON_country_names



/**********************************************************************************

NOTE: GeoMap, GeoChart, and Map are different visualizations;
not all region codes work in both; old versions used GeoMap, now GeoChart [2014-10-16] which is better

permitted region codes, see:
    https://developers.google.com/chart/interactive/docs/gallery/geochart
    https://google-developers.appspot.com/chart/interactive/docs/gallery/geomap
    http://en.wikipedia.org/wiki/UN_M.49
    https://groups.google.com/forum/#!topic/google-analytics-data-export-api/HiqZqaYqL7w
    http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2

*/
function google_visualization_map( mapRegionOption, targetCanvasID ){

    // Create the data table.
  var googleMapData = new google.visualization.DataTable();
  /*
  var googleMapData = google.visualization.arrayToDataTable(
  [ ['Country', 'Popularity'] ]);
  */
  googleMapData.addColumn('string', 'Country');
  googleMapData.addColumn('number', 'Publications');

  var mapDataArray = countriesArray;
  switch(mapRegionOption){ // may use other arrays
    case "US" : mapDataArray = USstatesArray; break;
    case "us_metro" : mapDataArray = USstatesArray; break;
    // Canada and Great Britain maps are showing their separate components without any trouble, but Australia...
    case "053" : mapDataArray = AustralianStatesArray; break; // Australia
    case "AU" : mapDataArray = AustralianStatesArray; break;
  } //end switch
  switch(targetCanvasID){ // may use other arrays
    case "language_map_canvas_world" : mapDataArray = language_countries; break;
    case "language_map_canvas_USA" :
      mapDataArray = language_countries;
      mapRegionOption = "US";
      break;
    case "language_map_canvas_Canada" :
      mapDataArray = language_countries;
      mapRegionOption = "CA";
      break;

  } //end switch

  for (var i = 0; i < mapDataArray.length; i++) {
    var country_name = mapDataArray[i].country_name;
    var country_pubs = mapDataArray[i].country_pubs;

    country_name = set_GOOGLE_country_names(country_name);

    googleMapData.addRows([
        [country_name, country_pubs]
      ]);
  }//end for


  var options = { // options here are common to all GEOCHART
  'dataMode':'regions',
  'region':mapRegionOption,
/*
  'sort':'enable',
  'sortAscending':true,
  'sortColumn':0,
*/
  'showLegend':true,
  'title':'Number of publications in country',  // this is actually not in GeoChart documentation, seems to be ignored
  'width':chartWidthStatsPage, // globals
  'height':chartHeightStatsPage,

'tooltip':{
  showColorCode:true,
  textStyle:{color:'#2d2d4d', fontName:'Arial', fontSize:'14', bold:true}
},

  'backgroundColor':'#d7f7f4',
  'datalessRegionColor':'#f7f6f0' //'#f7f6f0'; //
  }; // end options object
  options.colorAxis={
    minValue:'#e9e6d3',
    values:[       10,       20,            30,          50,      100,      200,      300,     400,       500,       750,       900,      1000,     1200,    2000,     9000],
    colors:['#e9e6d3',  '#d5d8db',   '#c1cba6',   '#adbd90','#8ca061','#839c5d','#627544','#485b2e','#32401e', '#37422e', '#454a5f', '#4e4f7f','#434373','#2d2d4d','#000000'],
    maxValue:'#000000'
  };


    // some countries contains provinces that we want to break out for subtotals
  if (mapRegionOption == 'US' || mapRegionOption == 'CA' || mapRegionOption == 'GB' || mapRegionOption == 'AU'){
      options.resolution = 'provinces';
  }

  switch(mapRegionOption){
    /*
      on the detailed maps, there is more variation in number of pubs than there is on the scale of the whole world
        - set options.ColorAxis values to differentiate countries better in the detailed maps
        - this section will bear adjusting as we get more from other countries
    */
    case 'US' :
      options.colorAxis={
        minValue:'#e9e6d3',
        values:[       300,       600,       1100,        1500,     1700,    2000,      2700,     3500,     3800,      3900,      6000,       7000,    8000,     9000,     10000],
        colors:['#e9e6d3',  '#d5d8db',   '#c1cba6',   '#adbd90','#8ca061','#839c5d','#627544','#485b2e','#32401e', '#37422e', '#454a5f', '#4e4f7f','#434373','#2d2d4d','#000000'],
        maxValue:'#000000'
      };
      break;
    case 'CA' :
      options.colorAxis={
        minValue:'#e9e6d3',
        values:[       1,       10,      30,      60,      80,      100,      200,      300,     800,         1000,  /* 10000 */ ],
        colors:['#e9e6d3','#adbd90','#8ca061','#839c5d','#627544','#485b2e','#32401e','#4e4f7f','#434373','#2d2d4d', /*'#000000'*/ ],
        maxValue:'#2d2d4d'
      };
      break;
    case 'GB' :
      options.colorAxis={
        minValue:'#e9e6d3',
        values:[      10,        20,       80,      1000],
        colors:['#e9e6d3','#839c5d','#32401e','#4e4f7f',],
        maxValue:'#2d2d4d'
      };
      break;
    case 'AU' :
      options.colorAxis={
        minValue:'#e9e6d3',
        values:[      2,      3,      4,      5,      10,      32,     135],
        colors:['#e9e6d3','#8ca061','#627544','#485b2e','#32401e','#4e4f7f','#2d2d4d'],
        maxValue:'#2d2d4d'
      };
      break;
    case '029' : // Caribbean
      options.colorAxis={
        minValue:'#e9e6d3',
        values:[      1,          2,        3,        5,        8,       15,       20,       50,      100,      500],
        colors:['#e9e6d3','#adbd90','#8ca061','#839c5d','#627544','#485b2e','#32401e','#4e4f7f','#434373','#2d2d4d'],
        maxValue:'#2d2d4d'
      };
      break;
    case '005' : // South America
      options.colorAxis={
        minValue:'#e9e6d3',
        values:[      3,          8,       40,       49,       85,     133,      137,       155,      184,      320,      400],
        colors:['#e9e6d3','#adbd90','#8ca061','#839c5d','#627544','#485b2e','#32401e','#4e4f7f','#434373','#2d2d4d', '#000000'],
        maxValue:'#000000'
      };
      break;
    case '150' : // AllEurope
      options.colorAxis={
        minValue:'#e9e6d3',
/*
        values:[       2,       25,      60,      115,      120,      144,      150,      163,     314,     317,     1000],
        colors:['#e9e6d3','#adbd90','#8ca061','#839c5d','#627544','#485b2e','#32401e','#4e4f7f','#434373','#2d2d4d','#000000'],
*/
        values:[       2,          10,         13,          20,        51,       64,      113,      120,      145,       149,       160,     316,     1022,     1287,     1370],
        colors:['#e9e6d3',  '#d5d8db',   '#c1cba6',   '#adbd90','#8ca061','#839c5d','#627544','#485b2e','#32401e', '#37422e', '#454a5f', '#4e4f7f','#434373','#2d2d4d','#000000'],
        maxValue:'#000000'
      };
      break;
    case '002' : // Africa
      options.colorAxis={
        minValue:'#e9e6d3',
        values:[       1,          2,         4,              5,       10,      15,        17,       53,       85,       105,       124,       129,          142,      295,     328,     359],
        colors:['#e9e6d3',  '#d5d8db',   '#c1cba6',   '#adbd90','#8ca061','#839c5d','#627544','#485b2e','#32401e', '#37422e', '#454a5f', '#4e4f7f', '#484979', '#434373','#2d2d4d','#000000'],
        maxValue:'#2d2d4d'
      };
      break;
    case '145' : // Middle East
      options.colorAxis={
        minValue:'#e9e6d3',
        values:[       5,          7,        13,       18,       20,       22,       36,       90,      300],
        colors:['#e9e6d3',  '#d5d8db','#8ca061','#839c5d','#627544','#485b2e','#37422e','#434373', '#2d2d4d'],
        maxValue:'#2d2d4d'
      };
      break;
    case '142' : // AllAsia
      options.colorAxis={
        minValue:'#e9e6d3',
        values:[       5,          14,         22,          31,        32,       43,       81,       94,       97,       168,       258,       310,      334,       431,       945 ],
        colors:['#e9e6d3',  '#d5d8db',   '#c1cba6',   '#adbd90','#8ca061','#839c5d','#627544','#485b2e','#32401e', '#37422e', '#454a5f', '#4e4f7f','#434373', '#383860', '#2d2d4d'],
        maxValue:'#2d2d4d'
      };
      break;
    case '009' : // Australia/Oceania
      options.colorAxis={
        minValue:'#e9e6d3',
        values:[       2,         9,       30,      124,      190],
        colors:['#8ca061','#627544','#485b2e','#434373', '#2d2d4d'],
        values:[       2,          3,        4,       9,       33,       120,       190],
        colors:['#e9e6d3',  '#d5d8db','#8ca061','#839c5d','#627544','#485b2e','#434373'],
        maxValue:'#434373'
      };
      break;
  }//end switch for colorAxis based on mapRegionOption
  // BUT SEE BELOW TOO 2015-07-29 16:21:36
  if (targetCanvasID.indexOf("language_map") != -1){
      options.colorAxis={
        minValue:'#e9e6d3',
        values:[       5,          10,        15,       25,       50,       100,       200],
        colors:['#e9e6d3',  '#d5d8db','#8ca061','#839c5d','#627544','#485b2e','#434373'],
        maxValue:'#434373'
      };
  }// end if




  var container = document.getElementById( targetCanvasID );
  var geochart    = new google.visualization.GeoChart(container);

    // do something when user clicks country on map
  function geochartSelectHandler(){   //  addListener is done after geochart.draw()
    countryMapDebug = "geochartSelectHandler";
    var selectedItem = geochart.getSelection()[0];
    if (selectedItem) {
      //var country_name = googleMapData.getValue(selectedItem.row, 0); // WORKS: gets the country_name in first test
      var country_name = set_ICON_country_names(googleMapData.getValue(selectedItem.row, 0));
      countryMapDebug += '\ncountry_name selected ' + country_name;
      var country_pubs = googleMapData.getValue(selectedItem.row, 1); // WORKS
      countryMapDebug += country_name+ ' has # publications: ' + country_pubs;
      var url_parameter = escape(country_name);
      location.href = "display_publications_by_country.php?country_name=" +url_parameter;
    } else {
      countryMapDebug += '\nSadly, no selection was found';
    }
  }// end geochartSelectHandler


  //geochart.draw(data, options);
  geochart.draw(googleMapData, options);

  google.visualization.events.addListener(geochart, 'select', geochartSelectHandler);


}//end google_visualization_map/************************************************/




/***********************************************
function google_visualization_chart: configurable generic chart, pass in options
    Set chart options: https://google-developers.appspot.com/chart/interactive/docs/customizing_charts
    https://google-developers.appspot.com/chart/interactive/docs/gallery/piechart
*/
function google_visualization_chart( chartTitle, stringColumn, numericColumn, arrayName, chartType, targetCanvasID ){
  var strDebug = 'google_visualization_chart( chartTitle=' + chartTitle+', ';
    strDebug += 'stringColumn=' +stringColumn+', numericColumn='+numericColumn+', ';
    strDebug += 'arrayName='+arrayName+', chartType='+chartType+', ';
    strDebug += 'targetCanvasID=' +targetCanvasID;
    //strDebug += ', ' +arrayName+ ' has ' +arrayName.length+ ' elements';
  //console.info(strDebug);
  var chart_canvas = document.getElementById(targetCanvasID);

    //DEVNOTE: decide what the colors should be, based on targetCanvasID that tells where chart will be drawn
    // CRLcolors is global; can be changed in the switch statements
  var chartBGcolor = '#e9e6d3';
  var chartBorderColor = '#00ff00';
  var chartBorderWidth = 5;

  var titleTextStyle = {color:'#2b2a45', fontName:'Georgia', fontSize:'20'};
  var titleTextStyleCalTab = {color:'#00224C', fontName:'Arial', fontSize:'14', bold:true}; /* calendar pg tab */
  var titleTextStyleSidebar = {color:'#ff00ff', fontName:'Arial', fontSize:'14', bold:true}; /* calendar pg sidebar */
  var pieSliceText = 'percentage'; // changes in switch statements
  //var pieSliceTextStyle={color:'#ff00ff', fontName:'Arial', fontSize:'40'};
  var pieSliceTextStyle={color:'#2d2d4d', fontName:'Georgia', fontSize:'12', bold:true};
  var sliceVisibilityThreshold = 1/10000; // less than this = not displayed ; default = 1/720
  var pieResidueSliceColor = '#e9e6d3'; // all slices below sliceVisibilityThreshold
  var legendTextStyle  =  {color:'#2d2d4d', fontName:'Arial', fontSize:'14', bold:true};
  var tooltipTextStyle =  {color:'#2d2d4d', fontName:'Arial', fontSize:'14', bold:true};

  /*
    in Google Charts API options{} object (defined later below),
      values of 'width' + 'height' are used for the whole container;
      values of chartArea':{width:##,height:##,...} are used for the area of the chart as drawn within the container
  */
  var chartWidthCalendarTab = 625;//320; //pixel size; for charts under Organizations and Formats tabs
  var chartHeightCalendarTab = 300;
  var chartWidthCalendarSidebar = 150; // charts under the timeline: started with 150
  var chartHeightCalendarSidebar = 150;

  var chartAreaLeft = 10; // pixels: how far off the edge of the ?container element? or ?chartArea?
  var chartAreaTop = 35;
  var chartAreaWidth = '100%'; // how much of the container is used for the actual chart
  var chartAreaHeight = '90%';
  var chartAreaWidthSidebar = '90%';
  var chartAreaHeightSidebar = '90%';
  if (chartType == 'line'){
    chartAreaWidth = '100%';
    chartAreaHeight = '80%';
  }//end line chart options

  var legendPosition = '';
  switch (arrayName){
    case 'orgsArray' : /* from STATISTICS page */
      chartWidth = chartWidthStatsPage; // these are global now, shared with GeoChart
      chartHeight = chartHeightStatsPage;
      legendPosition = 'left'; // 2014-09-23: tried 'labeled', almost crashes Firefox
      break;
    case 'countriesArray' : /* from STATISTICS page */
    case 'USstatesArray' :
    case 'otherCountriesArray' :
    case 'languagesArray' :
      chartWidth = chartWidthStatsPage;
      chartHeight = chartHeightStatsPage;
      legendPosition = 'left'; // top + bottom don't work ; labeled has no scrolling (too many slices, can't get to them all)
      break;
    case 'yearsArray' : /* from STATISTICS page */
      chartWidth = chartWidthStatsPage;
      chartHeight = chartHeightStatsPage;
      legendPosition = 'left';
      break;
    case 'formatsArray' : /* from STATISTICS page */
      chartWidth = chartWidthStatsPage;
      chartHeight = chartHeightStatsPage;
      legendPosition = 'labeled';
      break;
    /*********************************************************/
    case 'orgsArrayIssues' : /* from CALENDAR page tab */
      chartWidth = chartWidthCalendarTab;
      chartHeight = chartHeightCalendarTab;
      legendPosition = 'labeled'; // until 2014-09-23: was 'left'
      CRLcolors = [ /*'#2d2d4d',*/ '#8ca061', '#e97100', /* '#303030', */ '#adbd90', '#da5856', '#485b2e', '#4e4f7f'];
      pieResidueSliceColor = '#2d2d4d';
      break;
    case 'pubFormatsArray' : /* from CALENDAR page tab */
      chartWidth = chartWidthCalendarTab;
      chartHeight = chartHeightCalendarTab;
      legendPosition = 'labeled';
      break;
  }//end switch options on arrayName



  switch (targetCanvasID){ /* choose options depending canvas div the chart is being displayed on */
    case 'orgs_chart_canvas_tab' :
    case 'formats_chart_canvas_tab' :
      chartBGcolor = '#ffffff';
      /* titleTextStyle = {color:'#00224C', fontName:'Arial', fontSize:'16', bold:true}; */
      titleTextStyle = titleTextStyleCalTab;
      pieSliceText = 'none';
      chartAreaLeft    = 25;
      //chartAreaTop    = -20;
      break;
    case 'orgs_chart_canvas_sidebar' :
    case 'formats_chart_canvas_sidebar' :
      chartBGcolor = '#f3f7f6'; /* blank is ok but imperfect */
      chartWidth = chartWidthCalendarSidebar;
      chartHeight = chartHeightCalendarSidebar;
      legendPosition = 'bottom'; /* so it doesn't actually show ; appears at right if left blank */
      titleTextStyle = titleTextStyleSidebar;
      //chartAreaLeft   = 5;
      chartAreaTop    = -50;
      chartAreaWidth  = chartAreaWidthSidebar;
      chartAreaHeight = chartAreaHeightSidebar;
      break;
  }//end switch options on targetCanvasID


  var options = { // Set chart options: many values set in switch statements
    'colors':CRLcolors,
    'backgroundColor':chartBGcolor, /* sometimes this is set to an empty string */
    'backgroundColor.stroke':chartBorderColor, /* */
    'backgroundColor.strokeWidth':chartBorderWidth, /* */

    'title':chartTitle,
    'titleTextStyle':titleTextStyle,

    'width':chartWidth, 'height':chartHeight,
    'chartArea':{
        left:chartAreaLeft,top:chartAreaTop,width:chartAreaWidth,height:chartAreaHeight
    },

    'legend':{
      position: legendPosition,
      textStyle:legendTextStyle
     },

     'tooltip':{
        showColorCode:true,
        textStyle:tooltipTextStyle
     },

    'pieSliceText':pieSliceText,
    'pieSliceTextStyle':pieSliceTextStyle,
    'sliceVisibilityThreshold':sliceVisibilityThreshold,
    'pieResidueSliceColor':pieResidueSliceColor,

    'axisTitlesPosition':'in', // line charts only
    'hAxis':{title: 'Years'},
    'vAxis':{title: 'Publications', textPosition:'in'},


    'is3D':true
  }; //end options object

    // Create the data table.
  var thisChartData = new google.visualization.DataTable();
  thisChartData.addColumn('string', stringColumn);
  thisChartData.addColumn('number', numericColumn);


  switch(arrayName){ // which array of JSON data do we use to fill the chart?
      //group of array names for STATISTICS page charts
    case "orgsArray" :
      for (var i = 0; i < orgsArray.length; i++) {
        thisChartData.addRows([
            [orgsArray[i].org_name, orgsArray[i].publications]
          ]);
      }
      break; //end organizations
    case "countriesArray":
      for (var i = 0; i < countriesArray.length; i++) {
        var country_name = set_GOOGLE_country_names(countriesArray[i].country_name);
        thisChartData.addRows([
             [country_name, countriesArray[i].country_pubs]
          ]);
      }
      thisChartData.sort([{column: 0}]); // see note before set_GOOGLE_country_names for why we sort here
      break; //end ALL countries
    case "otherCountriesArray":
      for (var i = 0; i < otherCountriesArray.length; i++) {
        var country_name = set_GOOGLE_country_names(otherCountriesArray[i].country_name);
        thisChartData.addRows([
             [country_name, otherCountriesArray[i].country_pubs]
          ]);
      }
      thisChartData.sort([{column: 0}]); // see note before set_GOOGLE_country_names for why we sort here
      break; //end all countries EXCEPT UNITED STATES
    case "USstatesArray":
      for (var i = 0; i < USstatesArray.length; i++) {
        var country_name = set_GOOGLE_country_names(USstatesArray[i].country_name);
        thisChartData.addRows([
            [country_name, USstatesArray[i].country_pubs]
          ]);
      }
      thisChartData.sort([{column: 0}]); // see note before set_GOOGLE_country_names for why we sort here
      break; //end only United States
    case "formatsArray" :
      for (var i = 0; i < formatsArray.length; i++) {
        thisChartData.addRows([
            [formatsArray[i].format_name, formatsArray[i].issues]
          ]);
      }
      break; //end formats
    case "yearsArray" :
      for (var i = 0; i < yearsArray.length; i++) {
        //strDebug += ' ' +yearsArray[i].this_year;
        thisChartData.addRows([
            //[yearsArray[i].this_year, yearsArray[i].year_pubs, yearsArray[i].year_issues]
            [yearsArray[i].this_year, yearsArray[i].year_pubs]
          ]);
      }
      break; //end years
    case "languagesArray" :
      for (var i = 0; i < languagesArray.length; i++) {
        thisChartData.addRows([
            //[languagesArray[i].language_name, languagesArray[i].language_pubs]
            // 2015-07-24 above is basic syntax, first try: note this data required parseInt() below
            [languagesArray[i].language_name, parseInt(languagesArray[i].language_pubs)]
          ]);
      }
      break; //end languages
      //end STATISTICS page charts
      //group of array names for CALENDAR page charts
    case "orgsArrayIssues" :
      for (var i = 0; i < orgsArrayIssues.length; i++) {
        thisChartData.addRows([
            [orgsArrayIssues[i][0].org_name, orgsArrayIssues[i][0].issues]
          ]);
      }
      break; //end organizations
    case "pubFormatsArray" :
      for (var i = 0; i < pubFormatsArray.length; i++) {
        //alert('sveshto je dobro');
        thisChartData.addRows([
            [pubFormatsArray[i].format_name, pubFormatsArray[i].issues]
          ]);
      }
      break; //end formats
      //end CALENDAR page charts
  }//end switch

  switch( chartType ){
    case "pie" :
      var thisChart = new google.visualization.PieChart(chart_canvas);
      break;
    case "bar" :
      var thisChart = new google.visualization.BarChart(chart_canvas);
      break;
    case "line" :
      var thisChart = new google.visualization.LineChart(chart_canvas);
      break;
  }//end switch


  // bgn embedded functions used by chart Listeners*******************************************/
  function handle_chart_select_country() { // gets name of selected country when chart item is clicked, builds URL, redirects
    country_selector_debug = 'handle_chart_select_country; ';
    var selectedItem = thisChart.getSelection()[0]; // Call chart's getSelection() method
    if (selectedItem) {
      //var country_name = thisChartData.getValue(selectedItem.row, 0); // WORKS: gets the country_name
      var country_name = set_ICON_country_names(thisChartData.getValue(selectedItem.row, 0));
      country_selector_debug += 'country_name selected ' + country_name + '; ';
      var country_pubs = thisChartData.getValue(selectedItem.row, 1); // WORKS
      country_selector_debug += 'has # publications: ' + country_pubs + '; ';

      var url_parameter = escape(country_name);
      location.href = "display_publications_by_country.php?country_name=" +url_parameter;
    } else {
      country_selector_debug += '\nSadly, no selection was found';
    }
  } //end handle_chart_select_country


  function handle_chart_select_organization() { // gets name of selected org when chart item is clicked, builds URL, redirects
    var org_selector_debug = 'handle_chart_select_organization\n';
    var selectedItem = thisChart.getSelection()[0];
    if (selectedItem) {
      var org_name = thisChartData.getValue(selectedItem.row, 0);
      org_selector_debug += '\norg_name selected ' + org_name;
      var org_pubs = thisChartData.getValue(selectedItem.row, 1);
      org_selector_debug += '\norg has # publications: ' + org_pubs;
      var url_parameter = escape(org_name);
      location.href = "display_publications_by_org.php?org_name=" +url_parameter;
    } else {
      org_selector_debug += '\nSadly, no selection was found';
    }
  } //end handle_chart_select_organization


  function handle_chart_select_language() { // gets name of selected country when chart item is clicked, builds URL, redirects
    language_selector_debug = 'handle_chart_select_language; ';
    var selectedItem = thisChart.getSelection()[0]; // Call chart's getSelection() method
    if (selectedItem) {
      //var language_name = thisChartData.getValue(selectedItem.row, 0); // WORKS: gets the language_name
      var language_name = thisChartData.getValue(selectedItem.row, 0);
      language_selector_debug += 'language_name selected ' + language_name + '; ';
      var language_pubs = thisChartData.getValue(selectedItem.row, 1); // WORKS
      language_selector_debug += 'has # publications: ' + language_pubs + '; ';

      var url_parameter = escape(language_name);
      language_selector_debug += 'url_parameter: ', url_parameter;
      location.href = "display_publications_by_language.php?language_name=" +url_parameter;

    } else {
      language_selector_debug += '\nSadly, no selection was found';
    }

    console.info(language_selector_debug);

  } //end handle_chart_select_language


  // end embedded functions used by chart Listeners*******************************************/

    // first draw chart, then addListener
  thisChart.draw(thisChartData, options);
    // charts can be clickable links to full listings of publications by parameter
  if (arrayName == 'countriesArray' || arrayName == 'otherCountriesArray' || arrayName == 'USstatesArray'
      || arrayName == 'CanadianProvincesArray' || arrayName == 'UKcountriesArray' || arrayName == 'AustralianStatesArray'){
    google.visualization.events.addListener(thisChart, 'select', handle_chart_select_country);
  } else if (arrayName == 'orgsArray'){
    google.visualization.events.addListener(thisChart, 'select', handle_chart_select_organization);
  } else if (arrayName == 'languagesArray'){
    google.visualization.events.addListener(thisChart, 'select', handle_chart_select_language);
  } // end if-else for handling clicks on chart data


  //$("rect[fill]").css( "background", "url(../ICON/images/main_gradient.png)" ); //subtle but works
  //$("#statistics_chart_canvas").show(); // statistics page only

  /*
    2014-08-29: this works ...
      $(chart_canvas).show(); // statistics or calendar page
    ...but showing the chart is now handled by function chartDisplay in statistics.js,
    since all charts are prepared (but hidden) once the JSON is ready: no longer calling google_visualization_chart in response to click on triggers.
    On calendar.php, displayOrgsList and displayFormatList could be affected by this change but are still working;
      there must be something in Google's draw() method?
  */
}//end google_visualization_chart/***************************************************/


