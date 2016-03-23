<!--
  AJE 2013-11-11
  - new section for charts of repository and formats data to display in sidebar under timeline;
  - same data appears here as under the respective tabs
-->

<div class="twelve columns centered" id="sidebar_charts">

<br/><!--separates this from timeline, has to be in a foundation div-->

    <div class="sidebar_separator">&nbsp;</div>

    <div class="twelve columns centered chart_sidebar_container" id="orgs_chart_sidebar_container">
      <p class="chart_sidebar_caption">Organizations</p>
      <div id="orgs_chart_help_container">
      <a href="#" id="orgs_chart_help_button" class="button" data-reveal-id="selection_orgs_chart_help""><img src="images/sage_question_mark.png" /></a>
		  </div>
    	<span class="twelve columns centered" id="orgs_chart_canvas_sidebar">
    	  <!--space for Google chart : when chart is drawn, anything else in here is wiped out-->
    	  <div style="text-align:center;"><img src="images/loading_issue_info.gif" style="vertical-align: baseline;" /></div>
    	</span>
    </div><!--end orgs_chart_sidebar_container-->

    <div class="sidebar_separator">&nbsp;</div>

    <div class="twelve columns centered chart_sidebar_container" id="formats_chart_sidebar_container">
      <p class="chart_sidebar_caption">Formats</p>
      <div id="formats_chart_help_container">
      	<a href="#" id="formats_chart_help_button" class="button" data-reveal-id="selection_formats_chart_help"><img src="images/sage_question_mark.png" /></a>
		  </div>
    	<span class="twelve columns centered" id="formats_chart_canvas_sidebar">
    	  <!--space for Google chart : when chart is drawn, anything else in here is wiped out-->
    	  <div style="text-align:center;"><img src="images/loading_issue_info.gif" style="vertical-align: baseline;" /></div>
    	</span>
    </div><!--end formats_chart_sidebar_container-->

<div class="sidebar_separator">&nbsp;</div>




<div class="twelve columns centered" id="collection_sidebar_box">
<!--
  AJE 2015-10-01
  - new section for list of vendors and collections at the title level:
    per Amy, display in sidebar ABOVE timeline
    but this will be inconsistent - every title has a timeline but not necessarily a collection
-->
  <p class="chart_sidebar_caption">Collections</p>
  <div id="collection_links_help_container">
  	<a href="#" id="collection_links_help_button" class="button" data-reveal-id="selection_vendors_chart_help"><img src="images/sage_question_mark.png" /></a>
  </div>
  <span id="collections_container_sidebar">&nbsp;</span>
  <br/>
</div>

<!--end sidebarCollections-->

<!--<div class="sidebar_separator">&nbsp;</div>-->
<!--<div class="sidebar_separator">&nbsp;</div>-->



    <!--AJE 2015-08-04 link to show/hide entire box of visualizations
    <div class="twelve columns centered chart_sidebar_container">
      <p class="chart_sidebar_caption"><a href="#visualizations" id="vis_sidebar_link">Visualizations</a></p>
    </div>
    <div class="sidebar_separator">&nbsp;</div>
    -->

</div><!--end sidebar_charts-->
