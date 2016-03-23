/*
  2015-10-15 AJE : collections.js contains scripts AJAX etc. for manipulating collections ;
  collections.js is needed for calendar.php, calendar_selection_functions.js, display_collections_by_org.php, display_publications_by_collection.php, more to come

  2014-09-17 : get_linked_profile_image: construct clickable icon to send user to eDesiderata profile for organization
  2015-10-13 : get_org_profile_image, get_org_profile_url, get_org_publications_link : new helper function broken out from above to use elsewhere
    - all these are now helpers for display_collection_info
*/
function get_org_profile_image(org_id){
  var strDebug = "enter get_org_profile_image( " + org_id + " )";
  var org_profile_image = "";
  switch(org_id){
    //DEVNOTE: 2015-10-13 org_profile_image DEFAULT SAME FOR ALL
    case "FLNEW" :
      //strDebug += "\nswitch found Readex";
      org_profile_image = '<img src="images/edesiderataProfile.png" />';
      break;
    case "PQHN" :
      //strDebug += "\nswitch found ProQuest";
      org_profile_image = '<img src="images/edesiderataProfile.png" />';
      break;
    case "MITGS" :
      //strDebug += "\nswitch found GaleCengage";
      org_profile_image = '<img src="images/edesiderataProfile.png" />';
      break;
    default:
      //strDebug += "\nswitch found something else";
      org_profile_image = '<img src="images/edesiderataProfile.png" />';
  }// end switch
  return org_profile_image;
}// end get_org_profile_image


function get_org_profile_url( org_id ){
  var strDebug = "enter get_org_profile_url( " + org_id + " )";
  var org_profile_url = "";
  switch(org_id){
    case "FLNEW" :
      //strDebug += "\nswitch found Readex";
      org_profile_url = "http://edesiderata.crl.edu/providers/readex";
      break;
    case "PQHN" :
      //strDebug += "\nswitch found ProQuest";
      org_profile_url = "http://edesiderata.crl.edu/resources/proquest-historical-newspapers";
      break;
    case "MITGS" :
      //strDebug += "\nswitch found GaleCengage";
      org_profile_url = "http://edesiderata.crl.edu/providers/gale";
      break;
    default:
      //strDebug += "\nswitch found something else";
      org_profile_url = "";
  }// end switch
  return org_profile_url;
} // end get_org_profile_url


function get_org_publications_link( org_id, org_name ) {
  // return a link to show all publications held by an organization
      var org_publications_link = '<a href="display_publications_by_org.php?org_name='+ org_name +'" ';
      org_publications_link += 'class="pb_report_header_result" ';
      org_publications_link += 'title="View ICON titles held by '+ org_name +'" ';
      org_publications_link += 'target="_blank">'+ org_name +'</a>';
      return org_publications_link;
}// end get_org_publications_link


function get_linked_profile_image( org_id, org_name ){
  var strDebug = "enter get_linked_profile_image( " + org_id + ", " +org_name+ " )";

  if (!org_name){ org_name = "this organization"; }// org_name ususally comes in blank: probably due to AJAX rendering

  var tooltip = "View CRL eDesiderata profile for " +org_name;

  // org_profile_image_link is whole thing to insert in page
  var org_profile_image_link = '<a href="'+ get_org_profile_url( org_id ) +'" title="'+ tooltip +'" ';
    //org_profile_image_link += 'class="profile_link" ';
    org_profile_image_link += 'target="_blank">' + get_org_profile_image( org_id ) +'</a>';

  switch(org_id){
    case "FLNEW" :
    case "PQHN" :
    case "MITGS" :
      break;
    default:
      strDebug += "\nswitch found something else";
      org_profile_image_link = "";
  }// end switch

  // alert(strDebug);

  return org_profile_image_link;
} // end get_linked_profile_image() ************************************/


function get_linked_profile_text( org_id, org_name ){
  var strDebug = "enter get_linked_profile_text( " + org_id + ", " +org_name+ " )";
  //console.log(strDebug);

  if (!org_name){ org_name = "this organization"; }// org_name ususally comes in blank: probably due to AJAX rendering

  var tooltip = "View CRL eDesiderata profile for " +org_name;

  // org_profile_text_link is whole thing to insert in page
  var org_profile_text_link = '<a href="'+ get_org_profile_url( org_id ) +'" title="'+ tooltip +'" ';
    org_profile_text_link += 'class="pb_report_header_result" target="_blank">' + org_name +'</a>';

  switch(org_id){
    case "FLNEW" :
    case "PQHN" :
    case "MITGS" :
      break;
    default:
      strDebug += "\nswitch found something else";
      org_profile_text_link = "";
  }// end switch

  // alert(strDebug);

  return org_profile_text_link;
} // end get_linked_profile_text() ************************************/

/*********************************************************************************
  AJE new 2015-09-30 :
  - per Bernie, vendor collections on calendar page
  - doable now that we have FLNEW data
  - get_collection_list.php with callback display_collection_info
  - called before display_title_info
  -
*/
function display_collection_info(collJSON, textStatus){
    // if fail, then bail
  if ((collJSON.search(/Error/i) != -1) || (collJSON.search(/\<b>Notice/i) != -1 )) {
		document.writeln(collJSON);
		return false;
	}

  //console.log('into display_collection_info with collJSON = ', collJSON);

  var collections = JSON.parse(collJSON);
  var num_collections = collections.collectionList.length;

  if ( ! num_collections > 0){ return false; }

  var collection_list = '<ul class="edesiderata">';

  for(var i=0; i < collections.collectionList.length; i++){
      if (collections.collectionList[i].collection_id != 1){ // not the default collection, which is no collection at all
        var coll_id         = collections.collectionList[i].collection_id;
        var coll_org_id     = collections.collectionList[i].collection_org_id;
        var coll_org_name   = collections.collectionList[i].collection_org_name;
        var coll_org_title  = collections.collectionList[i].collection_org_title;
        var coll_title_one  = collections.collectionList[i].collection_title_one;
        var coll_title_two  = collections.collectionList[i].collection_title_two;

        var org_profile_image_link = get_linked_profile_image( coll_org_id, coll_org_name );
        var org_profile_text_link = get_linked_profile_text( coll_org_id, coll_org_name );

        //var org_collections_link = '<a href="display_publications_by_org.php?org_name='+ coll_org_name +'" ';
        var org_collections_link = '<a href="display_collections_by_org.php?org_id='+ coll_org_id +'" ';
          //org_collections_link += 'class="profile_link" ';
          //org_collections_link += 'title="View ICON titles held by '+ coll_org_name +'" ';
          org_collections_link += 'title="View collections compiled by '+ coll_org_name +'" ';
          org_collections_link += 'target="_blank">'+ coll_org_title +'</a>';

        var this_collection_link = '<br/><a href="display_publications_by_collection.php?collection_id='+ coll_id +'" ';
            this_collection_link += 'class="collection_title" ';
            if (coll_title_one != coll_title_two){
              this_collection_link += 'title="View titles in '+ coll_title_one +', also known as '+ coll_title_two +'" ';
            } else {
              this_collection_link += 'title="View titles in '+ coll_title_one +'" ';
            }
            this_collection_link += 'target="_blank">'+ coll_title_one +'</a>';

        collection_list += '<li>'+ org_collections_link +'&nbsp;&nbsp;'+ org_profile_image_link +':&nbsp;';
        //collection_list += '<span class="collection_title" title="'+ coll_title_two +'">'+ coll_title_one +'</span></li>';
        collection_list += this_collection_link;
        collection_list += '</li>';
      }//end if: is meaningful collection
  }//end for
  collection_list += '</ul>';

  //console.warn('display_collection_info returns collection_list as\n', collection_list);

  $('#pub_info_first_list').after('<ul><li>Vendor collections: '+ collection_list +'</li></ul>');
  //$('#collections_container_sidebar').append(collection_list);
  $('#collections_chart_canvas_tab').html(collection_list);
  $('#collection_links_help_container').after(collection_list);
  $('#collection_sidebar_box').show(); // hidden by default
  //console.info('now, collection_sidebar_box has VIS: ', $('#collection_sidebar_box').css('visibility') ,' ; collection_sidebar_box has DISPLAY: ', $('#collection_sidebar_box').css('display'));



  return collection_list;

}// end display_collection_info

/*******************************************************************
  2015-10-16
  functions originally from
    display_publications_by_collection, display_collections_by_org
*/

function set_title_count( title_count ){
  $("#pbheader_title_count").text( title_count );
  $("#pbheader_title_count").addClass('pb_report_header_result');
}

function set_collection_name( collNameJSON ){
  var strDebug = 'set_collection_name( collNameJSON ) has collNameJSON = \n';
  //console.log(strDebug, collNameJSON);

  var parsedJSON = JSON.parse(collNameJSON);

  var coll_title_one = parsedJSON[0].collection_title_one;
  var coll_title_two = parsedJSON[0].collection_title_two;
  if(coll_title_one != coll_title_two){
    collection_name = '<a href="javascript:return false;" class="pb_report_header_result" ';
    collection_name += 'title="also known as: '+ coll_title_two +'">'+ coll_title_one +'</a>';
    // title attribute is the only reason to use an href here
  } else {
    collection_name = coll_title_one;
  }

  //console.log('set_collection_name exiting with collection_name = ', collection_name);
  $("#pbheader_collection_name").html(collection_name);
  $("#pbheader_collection_name").addClass('pb_report_header_result');

} // end set_collection_name

function set_org_name( collOrgJSON ){
  var strDebug = 'set_org_name( collOrgJSON ) has collOrgJSON = \n';
  //console.log(strDebug, collOrgJSON);

  var parsedJSON = JSON.parse(collOrgJSON);

  org_id    = parsedJSON[0].collection_org_id;
  org_name  = parsedJSON[0].collection_org_name;

  var org_profile_link = '';
  var org_publications_link = get_org_publications_link( org_id, org_name );

  //console.log('set_org_name exiting with org_id = ', org_id, ' ; org_name = ', org_name);
  var CRL_profile_url   = get_org_profile_url( org_id );
  var CRL_profile_image = '';

  if(CRL_profile_url){
    //console.log('have CRL profile: profile text: ', get_linked_profile_text( org_id, org_name ));
    org_profile_link = get_linked_profile_text( org_id, org_name );
    org_profile_link += get_linked_profile_image( org_id, org_name );
  } else { // no CRL profile, use link to all pubs
    org_profile_link = org_publications_link;
  }
  $("#pbheader_this_org_profile").html( org_profile_link );
  $("#pbheader_this_org_profile").addClass('pb_report_header_result');
/*
      console.log('org_publications_link = ', org_publications_link);
      console.log('org_name_output = ', org_name_output);
*/

  $("#pbheader_this_org_pubs").html( org_publications_link );
  $("#pbheader_this_org_pubs").addClass('pb_report_header_result');


} // end set_org_name
