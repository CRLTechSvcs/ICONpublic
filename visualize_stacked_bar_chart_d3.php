<?php
  /*

  other D3 tutorials:

  http://www.d3noob.org/p/d3noob-downloads.html
  http://alignedleft.com/tutorials/d3/adding-elements

  AJE 2015-06-12
  this is 99% a javascript file, plus a bit of HTML
    but the source of the data being loaded into the graph by D3
    via its d3.csv() method is dynamically chosen based on database field.
  Take input from database field (initially, ISSN field, to choose which CSV file to use as input

  In addition to d3.csv(), there are methods for loading other formats
    - those have not been investigated yet

  sample from http://bl.ocks.org/mbostock/3886208
  also:
  http://bost.ocks.org/mike/bar/2/

  2015-06-04:
  original sample for D3 bar chart from:
  sample from <a href="http://bl.ocks.org/mbostock/3886208" target="_blank">http://bl.ocks.org/mbostock/3886208</a>

  */

?>

<span class="row">
  <div class="d3_chart_canvas" id="d3_BAR_target">
  <!--<div class="large-11 large-offset-1 columns d3_chart_canvas" id="d3_BAR_target">-->
    <!--D3 script will append graph here ; toggled with button in header -->
  </div>
</span>


<script>

function generate_stacked_bar_chart(){

  console.log('entered generate_stacked_bar_chart');

  // clean up any old chart first whenever called, then redraw
  d3.select("#d3_BAR_target svg").remove();

  var strDebug = '';

/*
  //var margin = {top: 20, right: 20, bottom: 50, left: 40},
  var margin = {top: 10, right: 10, bottom: 45, left: 30},
      //icon_d3_chart_width = icon_d3_chart_width - margin.left - margin.right,
      //icon_d3_chart_width = screen.width - 500, // works
      //width = icon_d3_chart_width, // a bit too wide if icon_d3_chart_width = 896
      width = icon_d3_chart_width - margin.left, //
      height = 500 - margin.top - margin.bottom;
*/
// use icon_d3_chart_margin, icon_d3_chart_width, icon_d3_chart_height

  // X example used scale.ordinal() but others exist: http://alignedleft.com/tutorials/d3/scales
  // only ordinal has .rangeRoundBands()
  //console.log('bar_chart_X_scale is an ordinal rangeRoundBands scale');
  var x = d3.scale.ordinal()
      .rangeRoundBands([0, icon_d3_chart_width], .0); // 3rd parameter of 0 means bars are flush together

  // Y example used scale.linear()
  var y = d3.scale.linear()
      .rangeRound([icon_d3_chart_height, 0]);

  var color = d3.scale.ordinal()
      //.range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]);
      // above is original set from sample page ; next is CRL type
      .range(['#2d2d4d','#8ca061', '#e97100', '#303030', '#98abc5', '#da5856', '#485b2e', '#4e4f7f']);
      // realistically the original colors look better than above CRL set

/**********************************************
  - hate to do this internal function thing, but else holdingsObject not in scope...
  - som
*/
function get_org_color( holdingsObject ) {
  // finally can see the properties of the object
  var GOTD = holdingsObject;
  for (var key in GOTD) {
    if (GOTD.hasOwnProperty(key)) {
      console.warn("get_org_color GOTD[", key, "] -> ", GOTD[key]);
      /*
      no access to the Volume, but for sn84024724 in 1820:
      org_tooltip OTD[ name ] -> FLNEW
      org_tooltip OTD[ y0 ] -> 312
      org_tooltip OTD[ y1 ] -> 623
      */
    }// end if
  }// end for

return color(holdingsObject.name);
}// end get_org_color

  /******************************************************************
  // defining tooltips : one for each piece of data we want to include (DEVNOTE : Ugly Hack 2015-07-09)
  */
  var org_tooltip = d3.tip()
    .attr('class', 'd3-tip')
    .offset([-35, 0])
    .html(
      function(d, i) {
      // i parameter is from 0-number of orgs holding issues in that year
      //  add 1 for every rect from the bottom up
      //console.warn('org_tooltip has i param = ' +i+ '.');
      var this_org_id = d.name;
      //var this_org_name = get_org_name(d.name) +" ("+d.name+")"; // d.name is only a code: get library name from code, use in org_tip_text
      var this_org_name = get_org_name(this_org_id) +" ("+this_org_id+")"; // d.name is only a code: get library name from code, use in org_tip_text

//var num_issues_org_year = -1;
var I_OTD = 0;
      // finally can see the properties of the object
      var OTD = d; var strOTD = "";
      for (var key in OTD) {
        if (OTD.hasOwnProperty(key)) {
          strOTD +=  'OTD['+ key +'] -> '+ OTD[key] +' ; ';
          strOTD +=  'I_OTD = '+ I_OTD +') d.'+ key +' = '+ d.key +' ; OTD['+ key +'] = '+ OTD[key] +' ; d.name = '+ d.name +' ; key is '+ key +' <- want that to match '+ OTD[key] +'. ';
          /* no access to Volume, but for sn84024724 in 1820: it's the holdings object:
          org_tooltip OTD[ name ] -> FLNEW ; org_tooltip OTD[ y0 ] -> 312 ; org_tooltip OTD[ y1 ] -> 623 */
        }// end if
        if(I_OTD != 0 && I_OTD != OTD.length){
          if(this_org_id == OTD[key]){  strOTD +=  'FOUND this_org_id '+ this_org_id +' in OTD['+ key +'] = '+ OTD[key] +'. ';  }
          if (key =='num_issues_org_year'){
            num_issues_org_year = OTD['num_issues_org_year'];
            strOTD +=  'OTD sections SET num_issues_org_year == '+ num_issues_org_year +'. ';
          }
        }
        I_OTD++;
      }// end for
      //console.warn( strOTD );
      var org_tip_text = '<span style="background-color:'+ color(d.name) +'; color:#ffffff; padding:8px;">';
      //org_tip_text += this_org_name+ ' holds '+ num_issues_org_year +' issue';
      org_tip_text += this_org_name+ ' holds '+ num_issues_org_year[d.name] +' issue';
      if(num_issues_org_year[d.name] > 1) {
        org_tip_text += 's ';
      }
      org_tip_text += ' for the year, out of '+ d.year_total +' from all holders';
      org_tip_text += '</span>';
      //console.warn('org_tip_text = ', org_tip_text);
      return org_tip_text;
      } // end func
  ); // end org_tooltip

  var vol_tooltip = d3.tip()
    .attr('class', 'd3-tip')
    .offset([-5, 0])
    .html(
      function(d, i) { // wording complements that in org_tooltip, is 2nd part
        // finally can see the properties of the object
        var VTD = d; var strVTD = "";
        for (var key in VTD) {
          if (VTD.hasOwnProperty(key)) {
            strVTD +=  'VTD['+ key +'] -> '+ VTD[key] +' ; ';
            /*
              VTD[ Volume ] -> 1820
              VTD[ AQM ] -> 312
              VTD[ FLNEW ] -> 311
              VTD[ NPV ] -> 0
              VTD[ year_total ] -> 623
              VTD[ holdings ] -> [
                Object { name="AQM",  y0=0,  y1=312},
                Object { name="FLNEW",  y0=312,  y1=623},
                Object { name="NPV",  y0=623,  y1=623}
              ]
              VTD[ total ] -> 623
            */
          }// end if
        } // end for
        //console.info( strVTD );

        // i parameter is from 0-number of orgs holding issues in that year
        //  add 1 for every rect from the bottom up
        //console.warn('vol_tooltip has i param = ' +i+ '.');
         //var vol_tip_text = get_org_tooltip(d.holdings[i]);
        /*
        var vol_tip_text = '<span style="background-color:';
        vol_tip_text += color(d.holdings[i]);
        vol_tip_text += '; color:#ffffff; padding:8px;">';
        */
        // try just a white one, bordered
        var vol_tip_text = '<span style="background-color:#e9e6d3; color:#000000; border:2px solid #e9e6d3; padding:8px;">';
          vol_tip_text += d.Volume +': '+ d.year_total + ' issue';
        if (d.year_total > 1) {
          vol_tip_text += 's';
        }
        vol_tip_text += ' for all holders</span>';
        //console.info('vol_tip_text = ', vol_tip_text);
        return vol_tip_text;
      }
  );
  /*
  // end defining tooltip
  ******************************************************************/

  //console.warn('before append, icon_d3_chart_width = ', icon_d3_chart_width);
  //var svg = d3.select("body").append("svg")
  var svg = d3.select("#d3_BAR_target").append("svg")
      .attr("width", icon_d3_chart_width + icon_d3_chart_margin.left + icon_d3_chart_margin.right)
      .attr("height", icon_d3_chart_height + icon_d3_chart_margin.top + icon_d3_chart_margin.bottom)
    .append("g")
      .attr("transform", "translate(" + icon_d3_chart_margin.left + "," + icon_d3_chart_margin.top + ")");



  /******************************************************************/
  var datafile = 'get_data_stacked_bar_chart_d3.php?pub_id=<?php echo $pub_id; ?>'
  console.info('D3.csv() for STK BAR will use call PHP, DB: ', datafile);
  d3.csv(datafile, function(error, data) {
    //color.domain(d3.keys(data[0]).filter(function(key) { return key !== "Volume"; }));
    //console.log("AJE color.domain filter may prevent some levels from loading? seems fine.");
    color.domain(d3.keys(data[0]).filter(function(key) {
      return ( (key !== "Volume") &&  (key !== "org_id") &&  (key !== "holdings")
      &&  (key !== "year_total") && (key.indexOf("Volume") == -1) );
    }));

  freech = 0; // ticker for data.forEach
  var max_volume_total = 0;
  /* ########################################################## */
    data.forEach(function(d) {

      /*
        d
        is the single data object being iterated through ;
        data
        is the collection of data objects, of which d is part ;
        data does not directly contain the fields we have to work with

      d.Volume is here no matter what : we don't have to assign, it came from input
        but not accessible outside the freech?
      */

      //console.info('before d.holdings: d comes in as ', d, ' ; and data is : ', data);
      var y0 = 0;

        //next, associate data with color bands
      //THIS WORKS: d.holdings = color.domain().map(function(name) { return {name: name, y0: y0, y1: y0 += +d[name]}; });
      d.holdings = color.domain().map(function(name) {
        //console.warn('d.name: ', d.name); // d.name is undefined here
        //crazy: the value of d[name] is actually the issue count for that org that Volume (year)
        //console.warn('d[name]: ', d[name])
        //console.warn('d.Volume: ', d.Volume); // IS AVAILABLE HERE d[Volume] is a mistake

//var num_issues_org_year = -1;
var num_issues_org_year = [];
var I_DDD = 0;
        // finally can see the properties of the object
        var DDD = d; var strDDD = "";
        for (var key in DDD) {
          if (DDD.hasOwnProperty(key)) {
           strDDD += I_DDD + ') DDD['+ key +'] -> '+ DDD[key] + ' ; ';
          /*
          sn82014206
Volume,FLNEW,AQM,RCE,year_total
1820,9,1,0,10
1821,83,74,1,158
          DDD[ Volume ] -> 1821
          DDD[ FLNEW ] -> 83
          DDD[ AQM ] -> 74
          DDD[ RCE ] -> 1
          DDD[ year_total ] -> 158
          */
          }// end if
          if(key != "Volume" && key != "year_total"){ // then it is a count of issues for an org in a Volume (year)
            //console.warn('NUM_ISSUES_ORG_YEAR IF CLAUSE: I_DDD = ', I_DDD, ') d.', key,' = ', d.key, ' ; DDD[', key, '] = ', DDD[key]);
            num_issues_org_year[key] = DDD[key];
            //console.warn('NUM_ISSUES_ORG_YEAR FOUND: ', num_issues_org_year, ' WILL CONTINUE');
            //continue;
            //console.warn('NUM_ISSUES_ORG_YEAR[',key,'] ', num_issues_org_year[key], ' WILL CONTINUE');
            continue;
            /*
            if BREAK here: num_issues_org_year is always the FIRST ORG's count
            if CONTINUE here: num_issues_org_year is always the LAST ORG's count
            */
          }
          I_DDD++;
        } // end for
        //console.info( strDDD );

        var holdingsObject = {
          name: name,
          'Volume':d.Volume,
          'num_issues_org_year':num_issues_org_year,
          'year_total':d.year_total,
          y0: y0,
          y1: y0 += +d[name]
        };
//console.log('holdingsObject is: ', holdingsObject);
        return holdingsObject;
        /*
          2015-10-20 clarified this terrifiying single line of code:
            return {name: name, y0: y0, y1: y0 += +d[name]};  // original line
          after:
          http://stackoverflow.com/questions/13507083/identifying-the-function-used-in-this-d3-stacked-bar-chart-example
        */
      });

      // d.name is undefined ; d.Volume is correct Volume
      //console.log('after d.holdings: d.name = ', d.name, ' ; d.Volume = ', d.Volume); //

      d.total = d.year_total;

      // try to scale height of Y axis with max_volume_total
      var b_increase_max_volume_total = ( Number(max_volume_total) <  Number(d.total));
      //console.error(d.Volume, ': is max_volume_total ', max_volume_total, ' < d.total ', d.total, ' ? ', b_increase_max_volume_total);
      if(b_increase_max_volume_total){
        max_volume_total = d.year_total;
      }
      //console.warn('d.Volume ', d.Volume, ' has d.total=', d.total, ', and max_volume_total = ', max_volume_total, '.');

  freech++;
    }); // end data.forEach
  /* ########################################################## */

    //data.sort(function(a, b) { return b.total - a.total; }); // original sort function
    console.log('REMOVED data.sort 2015-06-16 ');

      // AJE 2015-06-15 - only these domains are correct
    x.domain(data.map(function(d) { return d.Volume; }));

    //y.domain([0, d3.max(data, function(d) { return d.total; })]);
    y.domain([0, d3.max(data, function(d) {
      //console.info('y.domain with d.year_total = ', d.year_total, ', but will use max_volume_total = ', max_volume_total);
      //return d.year_total;
      return max_volume_total;
      })]);

      // AJE 2015-06-17 one way to access the fields
      // bgnDate and endDate are used for the xAxis timescale
    var bgnDate, endDate;
    bgnDate = data[0].Volume + '-01-01';
    endDate = data[data.length-1].Volume + '-01-01';
    //console.log('stack bar bgnDate = ', bgnDate, ' ; endDate = ', endDate);


    // at this point, any global var set in the freech block has only the last value

    // one tooltip with information about the org
    // 2015-06-15 input must have this field, or rename it
    var Volume = svg.selectAll(".Volume")
        .data(data) // this is orig : AJE testing new below
      .enter().append("g")
        .attr("class", "g")
        .attr("transform", function(d) {
          // d.Volume exists here ; d.name does not : console.info('Volume block has d.name ? = ', d.name);
          return "translate(" + x(d.Volume) + ",0)";
        })
        // if we attach tooltip here, can get Volume but not ORG
        .on('mouseover', vol_tooltip.show)
        .on('mouseout', vol_tooltip.hide);

    svg.call(vol_tooltip); // tooltips must set up before Volume.on('mouseover') will work

    // one tooltip with information about the org
    Volume.selectAll("rect")
      .data(function(d) { // d.Volume AVAILABLE here: console.warn("ima li d.Volume tuka? : ", d.Volume);
        return d.holdings;
      })
    .enter().append("rect")
      .attr("width", x.rangeBand())
      .attr("y", function(d) { return y(d.y1); })
      .attr("height", function(d) { return y(d.y0) - y(d.y1); })
      .style("fill", function(d) { // d.Volume is undefined here: console.info("FILL is here: d.Volume = ", d.Volume) ;
        return color(d.name);
      })
      // if we attach tooltip here, can get ORG but not Volume
      .on('mouseover', org_tooltip.show)
      .on('mouseout', org_tooltip.hide)
      // 2015-07-09 fade in animation
      .style('opacity', 0)
      .transition()
        .delay(function(d, i) { return i * 1000 })
        .duration(100)
        .style('opacity', 1);

    svg.call(org_tooltip); // tooltips must set up before Volume.on('mouseover') will work

  /******************************************************************/
  // more at: http://alignedleft.com/tutorials/d3/axes/
  var timescale = d3.time.scale()
      .nice(d3.time.day)
      .domain([new Date(bgnDate), new Date(endDate)])
      .range([0, icon_d3_chart_width-1]);
  var xAxis = d3.svg.axis()
      //.scale(x) // orig
      .scale(timescale) // AJE
      .orient("bottom");
      //.tickFormat(d3.format(".2d")); // 'd' for INT ; 's' meant float (more or less)
      //.tickFormat(d3.time.year, 1); // 2015-08-04 test
      //.ticks(d3.time.year, 1) // no output at all
      ;
console.info('no tickformat on SBC X axis 2015-10-19 17:08:23');


  //console.warn('next is call(xAxis)');
    svg.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + icon_d3_chart_height + ")")
        .call(xAxis) // AJE 2015-06-10 : now append rotation code after: http://www.d3noob.org/2013/01/how-to-rotate-text-labels-for-x-axis-of.html
        .selectAll("text")
          .style("text-anchor", "end")
          .attr("dx", "-.8em")
          //.attr("dy", "15em")
          .attr("transform", function(d){
            return "rotate(-65)";
            }
          );

  /******************************************************************/
  var yAxis = d3.svg.axis()
      .scale(y)
      .orient("left")
      .ticks(5) // AJE added 2015-06-10, not show the half-ticks
      //.ticks( max_volume_total ) // AJE added 2015-07-31
      .tickFormat(d3.format(".2d")); // 'd' for INT ; 's' meant float (more or less)
      //FAIL console.info('.ticks( max_volume_total ) 2015-10-19 set for SBC yAxis');
      console.info('reverted SBC Y scale to original Y, with .tickFormat(d3.format(".2d")) 2015-10-19');

  //console.warn('next is call(yAxis)');
    svg.append("g")
        .attr("class", "y axis")
        .call(yAxis)
      .append("text")
        .attr("transform", "rotate(-90)")
        .attr("y", 6)
        //.attr("y", -15) // AJE: moves Y Axis label outside graph area
        .attr("dy", ".71em")
        .style("text-anchor", "end")
        .attr('class', 'yAxisLabel')
        .text("Issues / Year");

  /******************************************************************/
  // LEGEND
  console.log('stack bar legend disabled in tab/calendar version');
  /*
    var legend = svg.selectAll(".legend")
        .data(color.domain().slice().reverse())
      .enter().append("g")
        .attr("class", "legend")
        .attr("transform", function(d, i) { return "translate(0," + i * 20 + ")"; });

    legend.append("rect")
        .attr("x", icon_d3_chart_width - 18)
        .attr("width", 18)
        .attr("height", 18)
        .style("fill", color);

    legend.append("text")
        .attr("x", icon_d3_chart_width - 24)
        .attr("y", 9)
        .attr("dy", ".35em")
        .style("text-anchor", "end")
        .style("fill", color)
        .attr("class", "legendText")
        .text(function(d) { return d; });

  // end LEGEND
  */

  }); // end d3.csv()
} // end generate_stacked_bar_chart


</script>