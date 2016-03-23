<?php
/*
2015-06-24 12:09:03

http://bl.ocks.org/mbostock/3883245
 mbostock’s block #3883245 October 13, 2012
Line Chart
This simple line chart is constructed from a TSV file storing the closing value of AAPL stock over the last few years. The chart employs conventional margins and a number of D3 features:

    d3.tsv - load and parse data
    d3.time.format - parse dates
    d3.time.scale - x-position encoding
    d3.scale.linear - y-position encoding
    d3.extent - compute domains
    d3.svg.axis - display axes
    d3.svg.line - display line shape
*/
?>


<span class="row">
  <span class="d3_chart_canvas" id="d3_LINE_target">
  <!--<span class="large-11 large-offset-1 columns d3_chart_canvas" id="d3_LINE_target">-->

		<!--D3 script will append graph here ; toggled with button in header -->
	</span>
</span>


<script>
function generate_line_chart(){

  //console.log('entered generate_line_chart');

  // clean up any old chart first whenever called, then redraw
  d3.select("#d3_LINE_target svg").remove();


/*
  //var line_margin = {top: 20, right: 20, bottom: 50, left: 40},
  var line_margin = {top: 10, right: 10, bottom: 45, left: 30},
      //line_width = screen.width - 500, // works
      //line_width = icon_d3_chart_width, // a bit too wide if icon_d3_chart_width = 896
      line_width = icon_d3_chart_width - line_margin.left, //
      //line_height = 500 - line_margin.top - line_margin.bottom;
      line_height = 500 - line_margin.top - line_margin.bottom;
*/
//use same size as stacked bar graph
// use icon_d3_chart_margin, icon_d3_chart_width, icon_d3_chart_height


  var parseDate = d3.time.format("%Y-%m-%d").parse;

  var line_chart_X_scale = d3.scale.ordinal()
      .rangeRoundBands([0, icon_d3_chart_width], .0);

  var line_chart_Y_scale = d3.scale.linear()
      .rangeRound([icon_d3_chart_height, 0]);

  var line = d3.svg.line()
      .x(function(d) { return line_chart_X_scale(d.Volume); })
      .y(function(d) { return line_chart_Y_scale(d.year_total); });

  var area = d3.svg.area()
      .x(function(d) { return line_chart_X_scale(d.Volume); })
      .y0(icon_d3_chart_height)
      .y1(function(d) { return line_chart_Y_scale(d.year_total); });

  var line_svg = d3.select("#d3_LINE_target").append("svg")
      .attr("width", icon_d3_chart_width + icon_d3_chart_margin.left + icon_d3_chart_margin.right)
      .attr("height", icon_d3_chart_height + icon_d3_chart_margin.top + icon_d3_chart_margin.bottom)
    .append("g")
      .attr("transform", "translate(" + icon_d3_chart_margin.left + "," + icon_d3_chart_margin.top + ")");

  /******************************************************************/

  var datafile = 'get_data_stacked_bar_chart_d3.php?pub_id=<?php echo $pub_id; ?>'
  console.info('D3.csv() for LINE will call SAME PHP, DB as stk bar: ', datafile);
  d3.csv(datafile, function(error, data) {

    if (error) throw error;

    data.forEach(function(d) {
      d.year_total = +d.year_total;
      //console.log('LINE freech: strDate = ', strDate, ' ; d.date = ', d.date, ' ; d.Volume = ', d.Volume, ' ; d.year_total = ', d.year_total); //
    });

    line_chart_X_scale.domain(data.map(function(d) { return d.Volume; }));
    line_chart_Y_scale.domain([0, d3.max(data, function(d) { return d.year_total; })]);

      // AJE 2015-07-10: bgnDate and endDate are used for the xAxis timescale
    var bgnDate, endDate;
    bgnDate = data[0].Volume;
    endDate = data[data.length-1].Volume;

  /******************************************************************/
  // draw data line
    line_svg.append("path")
        .datum(data)
        .attr("class", "line_chart_line")
        .attr("d", line)
      // 2015-07-09 fade in animation
      .style('opacity', 0)
      .transition()
        .delay(850)
        .duration(1000)
        .style('opacity', 1)
        ;

  /******************************************************************/
  // fill in area under line
    line_svg.append("path")
            .datum(data)
            .attr("class", "line_chart_area")
            .attr("d", area)
      // 2015-07-09 fade in animation
      .style('opacity', 0)
      .transition()
        .delay(1500)
        .duration(2000)
        .style('opacity', 1)
            ;

  /******************************************************************/
  // x axis
    var line_chart_timescale = d3.time.scale()
      .nice(d3.time.day)
      .domain([new Date(bgnDate), new Date(endDate)])
      .range([0, icon_d3_chart_width-1]);
    var line_chart_X_axis = d3.svg.axis()
        .scale(line_chart_timescale)
        .orient("bottom");

    line_svg.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + icon_d3_chart_height + ")")
        .call(line_chart_X_axis) // end orig ; add rotation of labels
        .selectAll("text")
          .style("text-anchor", "end")
          .attr("dx", "-.8em")
          //.attr("dy", "15em")
          .attr("transform", function(d){
            return "rotate(-65)";
            }
          );

  /******************************************************************
  // y axis
    do everthing else before the Y axis and the label will go above the data
    - z-index not honored by svg.text element */
  var line_chart_Y_axis = d3.svg.axis()
      .scale(line_chart_Y_scale)
      .orient("left")
      .ticks(5) // AJE added 2015-06-10, not show the half-ticks
      .tickFormat(d3.format(".2d")); // 'd' for INT ; 's' meant float (more or less)

    line_svg.append("g")
        .attr("class", "y axis")
        .call(line_chart_Y_axis)
      .append("text")
        .attr("transform", "rotate(-90)")
        .attr("y", 6)
        .attr("dy", ".71em")
        .style("text-anchor", "end")
        .attr("class", "yAxisLabel")
        .text("Issues / Year");

}); // end d3.csv
} // end generate_line_chart


</script>