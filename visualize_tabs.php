<!--
  visualize_tabs.php :
    link in
      - calendar.php (developed in calendar_visualization_first.php)
      - or commented out earlier dev: sidebarCharts.php
      will show/hide this div
-->

<!--<div class="row contentArea" id="visualization_container">-->

	<!--div class="twelve columns"-->
<!--AJE 2014-01-17 vis_tabs elements get click functions in document.ready() function-->
	<dl id="vis_tabs" class="tabs three-up contained">
		<dd id="bar_trigger_tab" class="active"><a href="#bar_chart" id="barTrigger">Issues/year/org.</a></dd>
		<dd id="pie_trigger_tab"><a href="#pie_chart" id="pieTrigger">Issues/org.</a></dd>
		<dd id="line_trigger_tab"><a href="#line_chart" id="lineTrigger">Issues/Year</a></dd>
		<dd id="available_chart_tab"><!--<a href="#another_chart">Another chart</a>--></dd>
	</dl>
<!--<div class="contentArea" id="visualization_container">-->
	<ul class="tabs-content contained">
<!-- barTrigger tab -->
		<li id="bar_chart_canvas" class="active">
			<div class="row">
			  <?php
			    include "visualize_stacked_bar_chart_d3.php";
			  ?>
			</div>
		</li>
<!-- pieTrigger TAB -->
		<li id="pie_chart_canvas">
				<div>
			  <?php
			    include "visualize_pie_chart_d3.php";
			  ?>
			</div>
		</li>
<!-- lineTrigger TAB -->
		<li id="line_chart_canvas">
				<div>
			  <?php
			    include "visualize_line_chart_d3.php";
			  ?>
			</div>
		</li>
	</ul>
	<!--/div-->
<!--</div><!--end visualization_container-->
