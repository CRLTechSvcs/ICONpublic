
  /* AJE 2015-08-04: this depends on orgsArrayIssues, filled in the course of determining data for calendars and charts
  // in visualizations subfolder/project, this block was in its own file */
function get_org_name( target_org_id ){ // find org_name in orgsArrayIssues that has org_id
  var strDebug = 'get_org_name( ' +target_org_id+ ') ; ';
  var this_org_name = target_org_id;
  for (var i = 0; i < orgsArrayIssues.length - 1; i++){
    //console.log(i, ') orgsArrayIssues[i][0]["org_id"] = ', orgsArrayIssues[i][0]["org_id"], ' ; orgsArrayIssues[i][0]["org_name"] = ', orgsArrayIssues[i][0]["org_name"]);
    if (orgsArrayIssues[i][0]["org_id"] == target_org_id) {
      this_org_name = orgsArrayIssues[i][0]["org_name"];
      break;
    }//end if
  }// end for
  //console.warn(strDebug, ' ; will return this_org_name = ', this_org_name);
  return this_org_name;
}// end get_org_name


/* activateVisualizationTab etc copied < calendar_selection_functions.js > activateIssueInfoTab() ******/
function activateVisualizationTab( tab_id, tab_canvas_id ) {

  var strDebug = 'activateVisualizationTab( '+ tab_id +', '+ tab_canvas_id +') begin\n';
  strDebug += 'li.active.attr("id")= '+ $('li.active').attr('id');
  console.log(strDebug);

	//if ($('li.active').attr('id') != 'issueDateTab') {
	if ($('li.active').attr('id') != tab_id.replace('#', '') ) {
    //console.log('IF li.active in activateVisualizationTab with tab_id = ', tab_id, ' ; replace = ', tab_id.replace('#', ''));

		$('li.active').css('display','none');
		$('.active').addClass('deselected');
		$('.active').removeClass('active');
      // previous line disables the whole visualizations block, so
		$('#visualizations_tab').addClass('active');
		/* $('#visualizations_tab').css('display','block'); */
		$('#visualizations_canvas').addClass('active');
		$('#visualizations_canvas').css('display','block');

		//Activate specific tab
		//$('#issue_info_tab').addClass('active');
		$(tab_id).addClass('active');
		$(tab_id).css('display','block');
		$(tab_canvas_id).addClass('active');
		$(tab_canvas_id).css('display','block');
	}
} // end activateVisualizationTab **********************************/




function visualization_triggers(){
  console.log('visualization_triggers shows #visualization_container when "visualization": ', location.href.indexOf("visualization"), ' or "calendar": ', location.href.indexOf("calendar"));

  // on load, do the same thing as when BAR chart trigger clicked
	$("#d3_LINE_target").hide("fast");
	$("#d3_PIE_target").hide("fast");
	$("#d3_BAR_target").show("fast");

/*
	$("#pie_trigger_tab").removeClass('active');
	$("#pie_chart_canvas").removeClass('active');
	$("#line_trigger_tab").removeClass('active');
	$("#line_chart_canvas").removeClass('active');
*/
	activateVisualizationTab( '#bar_trigger_tab', '#bar_chart_canvas' );
	//activateVisualizationSubTab( '#bar_trigger_tab', '#bar_chart_canvas' );
	$("#bar_trigger_tab").addClass('active');
	$("#bar_chart_canvas").addClass('active');

  generate_stacked_bar_chart();
  // end on load

  if (
    (location.href.indexOf("calendar") != -1)
    ||
    (location.href.indexOf("visualization") != -1)
  )
    {
    /* 2015-08-03 hide the calendars and tabs:
    $("#inner_selection_control_wrapper").hide("fast"); //gets reset elsewhere and re-shown
    // solution: modified calendar_selection_functions, using the same IF statement as above */

    $("#visualization_container").show("fast");
    	// triggers show/hide divs
    //$( "#bar_trigger_tab" ).click(function() {
    $( "#barTrigger" ).click(function() {
    	$("#d3_LINE_target").hide("fast");
  		$("#d3_PIE_target").hide("fast");
    	$("#d3_BAR_target").show("fast");

      activateVisualizationTab( '#bar_trigger_tab', '#bar_chart_canvas' );
    	generate_stacked_bar_chart();
    });
    //$( "#pie_trigger_tab" ).click(function() {
    $( "#pieTrigger" ).click(function() {
    	$("#d3_BAR_target").hide("fast");
    	$("#d3_LINE_target").hide("fast");
    	$("#d3_PIE_target").show("fast");

      activateVisualizationTab( '#pie_trigger_tab', '#pie_chart_canvas' );
    	generate_pie_chart();
    });
    //$( "#line_trigger_tab" ).click(function() {
    $( "#lineTrigger" ).click(function() {
    	$("#d3_BAR_target").hide("fast");
  		$("#d3_PIE_target").hide("fast");
    	$("#d3_LINE_target").show("fast");

      activateVisualizationTab( '#line_trigger_tab', '#line_chart_canvas' );
    	generate_line_chart();
    });
  }
}// end visualization_triggers


  // AJE new 2015-07-31 10:08:58
$( document ).ready(function() { // set global vars for all the D3 charts here
  icon_d3_chart_margin = {top: 10, right: 10, bottom: 45, left: 45}; // all 3 charts will use this object

  //icon_d3_chart_width = $("#visualization_container").width() - (icon_d3_chart_margin.left * 2);
  icon_d3_chart_width = $("#visualizations_canvas").width() * 5; // all 3 charts will use this value
//console.info('icon_d3_chart_WIDTH set once in doc.ready as hard code ', icon_d3_chart_width);

  //icon_d3_chart_height = $("#visualization_container").height() - (icon_d3_chart_margin.bottom);  // all 3 charts will use this value
  icon_d3_chart_height = $("#visualizations_canvas").height() * 5;  // all 3 charts will use this value
//console.info('icon_d3_chart_HEIGHT set once in doc.ready as hard code ', icon_d3_chart_height);

  //$('#vis_sidebar_link').click(function() {
  $('#visualizations_tab_link').click(function() {
    visualization_triggers(); // provides links to D3 functions
  });

  $('#visualizations_tab').click(function() {
    $('#visualizations_tab').addClass('selected');
    $('#visualizations_canvas').css('visibility', 'visible');

    $('#issue_info_tab').removeClass('selected');
    $('#issue_info_tab').addClass('deselected');

    $('#organizations_tab').removeClass('selected');
    $('#organizations_tab').addClass('deselected');

    $('#formats_tab').removeClass('selected');
    $('#formats_tab').addClass('deselected');

  });

}); // end doc.ready
