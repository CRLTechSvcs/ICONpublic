<?php
  require_once('config.php');

  $pub_id = $_REQUEST['pub_id'];
    // fill some default pub_id if needed
  if (! $pub_id ){ $pub_id = 1; }

  //echo 'head has pub_id = "' . $pub_id . '"';
?>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

  <?php
    require_once('head_tags.html');
  ?>

</head>

<body>

  <?php
    require_once('header.php');
  ?>

<body>
<?php

  // display publication info

  $this_sql = 'SELECT p.pub_id, p.ISSN, p.OCLC, p.marc001, ';
  $this_sql .= 'p.pub_title, p.pub_title_alt, ';
  $this_sql .= 'p.pub_city, c.country_name, ';
  $this_sql .= 'p.pub_bgnDate, p.pub_endDate, p.date260C, ';
  $this_sql .= 'p.date362, p.frequency310, p.formerFrequency321, ';
  $this_sql .= 'p.numberingNote515, p.summary520, p.descriptionNote588, ';
  $this_sql .= 'p.bib_relationships, p.link856 ';
  $this_sql .= 'FROM publications p ';
  $this_sql .= 'JOIN countries c ON c.country_id = p.country_id ';
  $this_sql .= 'WHERE p.pub_id = ' . $pub_id . '';

  //echo $this_sql;

  $sql_statement = $conn->prepare($this_sql);
  $sql_statement->execute();
  $sql_statement->store_result();
  if ($sql_statement->num_rows > 0){ //got count of pubs for this org_id
    $sql_statement->bind_result(
      $pub_id, $ISSN, $OCLC, $marc001,
      $pub_title, $pub_title_alt, $pub_city, $country_name,
      $pub_bgnDate, $pub_endDate, $date260C, $date362, $frequency310, $formerFrequency321,
      $numberingNote515, $summary520, $descriptionNote588, $bib_relationships, $link856
    );
    while($sql_statement->fetch()) {
      $title_data = $pub_title;
      if($pub_title_alt) { $title_data .= ' ; also: ' . $pub_title_alt; }

      $place_fields = $pub_city . ', ' . $country_name;

      $date_fields = "";
      if($pub_bgnDate && $pub_endDate) { $date_fields = $pub_bgnDate . '-' . $pub_endDate; }
      elseif($pub_bgnDate && ! $pub_endDate) { $date_fields = $pub_bgnDate . '-????'; }
      elseif(! $pub_bgnDate && $pub_endDate) { $date_fields = '????-' . $pub_endDate; }

      $chronology = "";
      if($date362){ $chronology = $date362; }
      if($frequency310){ $chronology = $chronology . '<br/>' . $frequency310; }
      if($formerFrequency321){ $chronology = $chronology . '<br/>' . $formerFrequency321; }

      $note_fields = "";
      if($numberingNote515){ $note_fields = $numberingNote515; }
      if($summary520){ $note_fields = $note_fields . '<br/>' . $summary520; }
      if($descriptionNote588){ $note_fields = $note_fields . '<br/>' . $descriptionNote588; }
      if($bib_relationships){ $note_fields = $note_fields . '<br/>' . $bib_relationships; }
      if($link856){ $note_fields = $note_fields . '<!--' . $link856 . '-->'; }

      include('publications_fields_divs.php'); // contains Zurb Foundation divs for display
    } // end while
	} else { // there was no data: add dummy value for D3 javascript to find, display no-data message
	    $ISSN = '0000-0000';
?>
      <div class="row">
        <div class="large-6 columns">
          <div class="panel">
            <h5>No data for publication</h5>
            <p>There is no data for pub_id <span style="font-weight:bold; color:#ff0000;"><?php echo $pub_id; ?></span>.
            Please try <a href="index.php" style="text-decoration:underline;">another search</a>.
            </p>
          </div>
        </div>
      </div>
<?php
	}// end if got data

    /*
      so that was data about the publication, from the database

      - next step is loading data for D3 javascript to use
      - in v.1, has to be CSV file named same as the ISSN
      - v.2, add a new step of checking for an [ISSN].csv file,
        - if it's not found, use the dummy file '0000-0000.csv'
        - where there is no data for a pub_id, handled in ELSE block above
    */


    $filepath = dirname(__FILE__); // this works to find absolute path
    /*
    echo 'filepath = ' . $filepath . '<br/>';
      // next works but not needed
    $path_parts = explode('/', $filepath);
    $this_dir = array_pop($path_parts);
    echo 'this_dir = ' . $this_dir .'<br/>';
    */
    $filename = '/ISSNs/' . $ISSN . '.csv'; // must use separate var for javascript
    //echo 'filename = ' . $filename . '<br/>';
    if (file_exists($filepath . $filename)) {
        //echo 'Found file ' . $filepath . $filename . ', 2015-06-10 15:32:09';
        //$filename = $this_dir . $filename;
    } else {
        //echo 'The file ' . $filename . ' NOT found';
        $filename = '0000-0000.csv'; // should never hit this part
    }
?>


<!--
sample from <a href="http://bl.ocks.org/mbostock/3886208" target="_blank">http://bl.ocks.org/mbostock/3886208</a>
Take input from query string to choose which CSV file to use as input:

<br/>

pub_id = '<?php  echo $pub_id; ?>'
<hr/>

2015-06-04:
original sample for D3 bar chart from:
sample from <a href="http://bl.ocks.org/mbostock/3886208" target="_blank">http://bl.ocks.org/mbostock/3886208</a>

-->



<script>
//var margin = {top: 20, right: 20, bottom: 30, left: 40},
var margin = {top: 20, right: 20, bottom: 50, left: 40},
    //width = 960 - margin.left - margin.right,
    width = screen.width - margin.left - margin.right,
    height = 500 - margin.top - margin.bottom;

var x = d3.scale.ordinal()
    //.rangeRoundBands([0, width], .1); // the .1 = ? amount of separation between bars ?
    //.rangeRoundBands([0, width], .5);
    .rangeRoundBands([0, width], .0); // 3rd parameter of 0 means bars are flush together

var y = d3.scale.linear()
    .rangeRound([height, 0]);

var color = d3.scale.ordinal()
    //.range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]);
    // above is original set from sample page
    //.range(['#2d2d4d','#8ca061', '#e97100', '#303030', '#adbd90', '#da5856', '#485b2e', '#4e4f7f']);
    // realistically the original colors look better than above CRL set
    // next is shades of CRL green
    //.range(['#adbd90','#8ca061','#839c5d','#627544','#485b2e','#32401e', '#37422e', '#454a5f', '#4e4f7f','#434373','#2d2d4d','#000000']);
    //revert to original
    .range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]);


/* original
var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom");
*/
var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom");

/* original
var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left")
    .tickFormat(d3.format(".2s")); */
var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left")
    .ticks(5) // AJE added 2015-06-10, not show the half-ticks
    .tickFormat(d3.format(".2d")); // 'd' for INT ; 's' meant float (more or less)

/* original
var svg = d3.select("body").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")"); */
var svg = d3.select("body").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");




//console.log('USING JUNK.CSV FOR TEST');
/*
d3.csv("<?php  echo $pub_id; ?>.csv", function(error, data) {
d3.csv("junk.csv", function(error, data) {
d3.csv("<?php  echo $ISSN; ?>.csv", function(error, data) {
*/
console.info("D3.csv() will use file: <?php  echo './' . $filename; ?>");
d3.csv("<?php  echo './' . $filename; ?>", function(error, data) {

  color.domain(d3.keys(data[0]).filter(function(key) { return key !== "Volume"; }));

  data.forEach(function(d) {
    var y0 = 0;
    d.ages = color.domain().map(function(name) { return {name: name, y0: y0, y1: y0 += +d[name]}; });
    d.total = d.ages[d.ages.length - 1].y1;
  });

  //data.sort(function(a, b) { return b.total - a.total; });
  console.log('removed data.sort in test 10');
  console.log('with data.sort, bars sorted in order of the value contained in the columns');
  console.log('if remove data.sort, bars sorted by first column in data file');

  x.domain(data.map(function(d) { return d.Volume; }));
  y.domain([0, d3.max(data, function(d) { return d.total; })]);

  svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      //.call(xAxis); // AJE 2015-06-10 : add rotation code after: http://www.d3noob.org/2013/01/how-to-rotate-text-labels-for-x-axis-of.html
      .call(xAxis)
      .selectAll("text")
        .style("text-anchor", "end")
        .attr("dx", "-.8em")
        //.attr("dy", "15em")
        .attr("transform", function(d){
          return "rotate(-65)";
          }
        );

  svg.append("g")
      .attr("class", "y axis")
      .call(yAxis)
    .append("text")
      .attr("transform", "rotate(-90)")
      .attr("y", 6)
      .attr("dy", ".71em")
      .style("text-anchor", "end")
      .text("Copies Held");

  var Volume = svg.selectAll(".Volume")
      .data(data)
    .enter().append("g")
      .attr("class", "g")
      .attr("transform", function(d) { return "translate(" + x(d.Volume) + ",0)"; });

  Volume.selectAll("rect")
      .data(function(d) { return d.ages; })
    .enter().append("rect")
      .attr("width", x.rangeBand())
      .attr("y", function(d) { return y(d.y1); })
      .attr("height", function(d) { return y(d.y0) - y(d.y1); })
      .style("fill", function(d) { return color(d.name); });

  var legend = svg.selectAll(".legend")
      .data(color.domain().slice().reverse())
    .enter().append("g")
      .attr("class", "legend")
      .attr("transform", function(d, i) { return "translate(0," + i * 20 + ")"; });

  legend.append("rect")
      .attr("x", width - 18)
      .attr("width", 18)
      .attr("height", 18)
      .style("fill", color);

  legend.append("text")
      .attr("x", width - 24)
      .attr("y", 9)
      .attr("dy", ".35em")
      .style("text-anchor", "end")
      .text(function(d) { return d; });

});

</script>

<!-- FOOTER -->
<?php include("footerCRL.html"); ?>

<?php mysqli_close($conn); ?>

</body>
</html>
