<?php
/*
2015-06-24 10:48:14

http://bl.ocks.org/mbostock/3887235
 mbostock's block #3887235 October 14, 2012
Pie Chart

Open in a new window.

This pie chart is constructed from a CSV file storing the populations of various age groups. The chart employs a number of D3 features:

    d3.csv - load and parse data
    d3.scale.ordinal - color encoding
    d3.svg.arc - display arcs
    d3.layout.pie - compute arc angles from data

*/
?>

<span class="row">
  <span class="d3_chart_canvas" id="d3_PIE_target">
  <!--<span class="large-11 large-offset-1 columns d3_chart_canvas" id="d3_PIE_target">-->
	<!--D3 script will append graph here ; toggled with button in header -->
	</span>
</span>


<script>
function generate_pie_chart(){

  //console.log('entered generate_pie_chart');

  // clean up any old chart first whenever called, then redraw
  d3.select("#d3_PIE_target svg").remove();
/*
  //var pie_margin = {top: 20, right: 20, bottom: 50, left: 40},
  var pie_margin = {top: 10, right: 10, bottom: 20, left: 20},
      //pie_width = screen.width - 250, // was straight 960, or 300 (no screen.width)
      //pie_width = screen.width - 500, // works
      pie_width = icon_d3_chart_width,
      pie_height =  500 - pie_margin.top - pie_margin.bottom, // was straight 500, or 300 (no margin.*)
      radius = Math.min(pie_width, pie_height) / 2;
*/
// use icon_d3_chart_margin, icon_d3_chart_width, icon_d3_chart_height
  var radius = Math.min(icon_d3_chart_width, icon_d3_chart_height) / 2;

  var color = d3.scale.ordinal()
      .range(['#2d2d4d','#8ca061', '#e97100', '#303030', '#98abc5', '#da5856', '#485b2e', '#4e4f7f']);

  var arc = d3.svg.arc()
      .outerRadius(radius - 10)
      //.outerRadius(radius - 50) //seems to just make the circle smaller?
      .innerRadius(0);

  var pie = d3.layout.pie()
      .sort(null)
      .value(function(d) { return d.org_total; });

  	// http://bl.ocks.org/Caged/6476579
  var pie_slice_tip = d3.tip()
    .attr('class', 'd3-tip')
    .offset([-10, 0])
    .html(function(d) { //  THIS SECTION ONLY TRIGGERED ON MOUSEOVER
      var pie_slice_tip_text = '<span style="background-color:'+ color(d.data.org_id) +'; color:#ffffff; padding:8px;">';
            // get_org_name(d.data.org_id) --> library name from org_id
  	    pie_slice_tip_text += get_org_name(d.data.org_id) + ': ' + d.data.org_total + ' issues</span>'; //orig
      return pie_slice_tip_text;
    });

  var pie_svg = d3.select("#d3_PIE_target").append("svg")
      .attr("width", icon_d3_chart_width)
      .attr("height", icon_d3_chart_height)
    .append("g")
      .attr("transform", "translate(" + icon_d3_chart_width / 2 + "," + icon_d3_chart_height / 2 + ")");

  pie_svg.call(pie_slice_tip);

  /******************************************************************/
  var datafile = 'get_data_pie_chart_d3.php?pub_id=<?php echo $pub_id; ?>'
  console.info('D3.csv() for PIE will use call PHP, DB: ', datafile);
  d3.csv(datafile, function(error, data) {

  data.forEach(function(d) {
    d.org_total = +d.org_total;
    //console.info('PIE freech: d.org_id: ', d.org_id, ' ; d.org_total = ', d.org_total);
  });

  var pie_g = pie_svg.selectAll(".arc")
      .data(pie(data))
    .enter().append("g")
      .attr("class", "arc") // end orig ;
      .on('mouseover', pie_slice_tip.show)
      .on('mouseout', pie_slice_tip.hide);

  pie_g.append("path")
      .attr("d", arc)
      .style("fill", function(d) { return color(d.data.org_id); })
      // 2015-07-09 fade in animation
      .style('opacity', 0)
      .transition()
        .delay(function(d, i) { return i * 1000 })
        .duration(100)
        .style('opacity', 1);

  pie_g.append("text")
      .attr("transform", function(d) {
        return "translate(" + arc.centroid(d) + ")"; // orig
      })
      .attr("dy", ".35em")
      .text(function(d) {
        return d.data.org_total; // orig
        /*
            // this works but is too long for small pie slices
          return d.data.org_id + ': ' +d.data.org_total; // AJE
        */
      })
      .attr("class", "pieSliceLabel")
      .style("color", "#ffffff") // class doesn't do the job of text color
      // 2015-07-09 fade in animation
      .style('opacity', 0)
      .transition()
        .delay(function(d, i) { return i * 1000 })
        .duration(100)
        .style('opacity', 1)
      ;

/******************************************************************
// LEGEND - 2015-07-07 not really necessary with pie_g.text showing holder code
//  and tooltip showing full name */
console.log('pie chart legend disabled in tab/calendar version');
/*
  var pie_legend = pie_svg.selectAll(".legend")
      .data(color.domain().slice().reverse())
    .enter().append("g")
      .attr("class", "legend") // barely defined and barely affects display even when filled out
      //.attr("transform", function(d, i) { return "translate(0," + i * 20 + ")"; }); // orig
        // looks like the 20 is the space required for each line of legend:
        // if change 20 to 5 or 10, lines are overlapping
        // AND: the number subtracted from i: the smaller it is, the lower the legend
      .attr("transform", function(d, i) { return "translate(0," + (i-10) * 20 + ")"; });

  pie_legend.append("rect")
      .attr("x", (icon_d3_chart_width / 2) - 18)
      .attr("width", 18)
      .attr("height", 18)
      .style("fill", color);

  pie_legend.append("text")
      .attr("x", (icon_d3_chart_width / 2) - 24)
      .attr("y", 9) // without this, text is shifted up away from its color rect
      .attr("dy", ".35em")
      .style("text-anchor", "end")
      .style("fill", color)
      .attr("class", "legendText")
      .text(function(d) { return d; });
  // end LEGEND
  */

}); // end d3.csv
} // end generate_pie_chart

</script>
