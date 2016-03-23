<?php

  /*
    2013-06-17 14:47
    - get_genealogy_info.php
      - depends on family_tree.php
      - queries database for information about publications and their relationships
        - must receive pub_id corresponding to record in publications table
      - stores results in arrays of 'publication' objects (defined in family_tree.php)
      - returns a JSON object for use by collapsible_tree_functions.js
  */

  $pub_id = (string)$_REQUEST['selectedPubId']; //javascript renamed it 'selectedPubId' so fine but it's plain pub_id in this file
  include ('config.php');
  include ('family_tree.php'); //code for create/manipulate publications objects etc.
  include ('dump_table.php'); //debugger
  $strDebug = "<br/>";

  //2013-June-07: build array of pub_ids and relationships
  $pub_id_array = array(); //fill in RELATED titles' ids below
  array_push($pub_id_array, $pub_id); // THIS TITLE: pub_id for the calendar page

  //RELATED TITLES: start by just getting the pub_ids of the titles related to the requested one */
  $sql_related_title_pub_ids = 'SELECT DISTINCT relationship_to_pub_id FROM bib_relationships WHERE relationship_from_pub_id = ? ';

  // 2013-11-20 new clause testing:
  // ONLY GET THE DIRECT RELATIONSHIPS
  $sql_related_title_pub_ids .= ' AND (rel_type_id LIKE "780%" OR rel_type_id LIKE "785%") ';

  $statement_related_title_pub_ids = $conn->prepare($sql_related_title_pub_ids);
  $statement_related_title_pub_ids->bind_param('s', $pub_id);
  $statement_related_title_pub_ids->execute();
  $statement_related_title_pub_ids->store_result();
  $statement_related_title_pub_ids->bind_result( $related_pub_id );
  while ($statement_related_title_pub_ids->fetch())
  { //while there are rows: [$statement]->fetch() is what actually makes vars accessible
    array_push($pub_id_array, $related_pub_id); //add each related pub_id to the array
    $strDebug .= '<p>related_pub_id = ' . $related_pub_id . '</p>';
  }//end while
  mysqli_stmt_close($statement_related_title_pub_ids);


  /* to get details of each relationship individually in loop */
  $sql_relationship_details = 'SELECT r.relationship_from_pub_id, r.rel_type_id, r.relationship_to_pub_id, r.relationship_to_control_num, r.relationship_to_ISSN,  ';
  $sql_relationship_details .= 't.rel_type_description ';
  $sql_relationship_details .= 'FROM bib_relationships r ';
  $sql_relationship_details .= 'LEFT JOIN bib_relationship_types t ON r.rel_type_id = t.rel_type_id ';
  $sql_relationship_details .= 'WHERE relationship_from_pub_id = ? AND relationship_to_pub_id = ? ';
  //$strDebug .= '<p>' . $sql_relationship_details . '</p>';

  /* to get details of each publication from publications table, for requested title + all its relatives */
  $sql_publication_details = 'SELECT pub_title, CONCAT(marc001, "; ", OCLC) AS this_control_num, ISSN, pub_bgnDate, pub_endDate, pub_city, country_id ';
  $sql_publication_details .= 'FROM publications WHERE pub_id = ?'; // bind pub_id_array element in loop below
  //$strDebug .='<p>' . $sql_publication_details . '</p>';

  foreach($pub_id_array as $this_pub_id)
  {
    $this_publication = new publication(); // this_publication added to family_tree when created
    $this_publication->pub_id = $this_pub_id; //first will be the requested title
    $strDebug .= '<p>family_tree has '. count($family_tree) . ' elements. pub_id: ' . $this_publication->pub_id . '...';

    //publication object is created and has a pub_id; begin query publications table + get relevant fields for each */
    $statement_this_pub = $conn->prepare($sql_publication_details);
    $statement_this_pub->bind_param('s', $this_pub_id);
    $statement_this_pub->execute();
    $statement_this_pub->store_result();
    $statement_this_pub->bind_result($pub_title, $this_control_num, $ISSN, $pub_bgnDate, $pub_endDate, $pub_city, $country_id);
    //$num_rows_this_pub = $statement_this_pub->num_rows;

    while($statement_this_pub->fetch())
    { //while there are rows: [$statement]->fetch() is what actually makes vars accessible
      $strDebug .= '<p>pub_title from db = "' . $pub_title . '"; bools to "' . (boolean)($pub_title) . '" ';
      $this_publication->pub_title = $pub_title;
      $this_publication->title = $pub_title;
      $strDebug .= "; pub_title: " . $this_publication->pub_title;
      if ($this_control_num)
      {
        $this_publication->control_num = $this_control_num;
      } else
      {
        $this_publication->control_num = "control_num";
      }
      $strDebug .= "; control_num: " . $this_publication->control_num;
      if ($ISSN)
      {
        $this_publication->ISSN = $ISSN;
      } else
      {
        $this_publication->ISSN = "ISSN";
      }
      $strDebug .= "; ISSN: " . $this_publication->ISSN;
      $this_publication->pub_city     = $pub_city;
      $this_publication->country_id   = $country_id;
      $strDebug .= "; pub_city, country_id: " . $this_publication->pub_city . ", " . $this_publication->country_id;
      $this_publication->pub_bgnDate   = $pub_bgnDate;
      $this_publication->pub_endDate   = $pub_endDate;
      $strDebug .= "; dates: " . $this_publication->pub_bgnDate . "-" . $this_publication->pub_endDate;
    } //end while statement_this_pub
    mysqli_stmt_close($statement_this_pub);


    //now get the relationship properties
    if ($this_pub_id != $pub_id)
    { //don't get requestedTitle relationships with itself
      $statement_related_pub_details = $conn->prepare($sql_relationship_details);
      $statement_related_pub_details->bind_param('ss', $pub_id, $this_pub_id);
      $statement_related_pub_details->execute();
      $relatedPubDetails= $statement_related_pub_details->store_result();
      $statement_related_pub_details->bind_result( $relationship_from_pub_id, $rel_type_id, $relationship_to_pub_id,
        $relationship_to_control_num, $relationship_to_ISSN,
        $rel_type_description );
      // fetch() happens in loop below
      $numrelatedPubDetails = $statement_related_pub_details->num_rows;

      while ($statement_related_pub_details->fetch())
      {
        $this_publication->relationship_from_pub_id = $relationship_from_pub_id;
        $this_publication->rel_type_id = $rel_type_id;
        $this_publication->rel_type_description = $rel_type_description;
        $this_publication->relationship_to_pub_id = $relationship_to_pub_id;
      }//end while fetch relationship details from database
      if ($statement_related_pub_details)
      {
        mysqli_stmt_close($statement_related_pub_details);
      }
    }//end if not requested pub_id
    else
    { // fill default relationship details for the requested title
      $this_publication->relationship_from_pub_id = $pub_id;
      $this_publication->rel_type_id = "00000";
      $this_publication->rel_type_description = "self";
      $this_publication->relationship_to_pub_id = $pub_id;
    }//end getting relationship details
    $strDebug .= "; Relationships: relationship_from_pub_id: " . $this_publication->relationship_from_pub_id;
    $strDebug .= "; rel_type_id: " . $this_publication->rel_type_id;
    $strDebug .= " (" . $this_publication->rel_type_description . ") ";
    $strDebug .= " relationship_to_pub_id: " . $this_publication->relationship_to_pub_id;
    $strDebug .= '</p>';
    //echo $strDebug;
  } //end for pub_id_array: all publications and bib_relationships information is now stored in publications objects, which are in family_tree array
  $strDebug = '<br/>after bibs and rels: family_tree has '. count($family_tree) . ' elements. <br/>';
  //dump_table($family_tree, "family_tree after relationship details");


  /*
    if there is no pub_id for a given publication object,
    then there was no pub_id for that related publication in the bib_relationships table (no relationship_to_pub_id),
    BUT there is a record in bib_relationships:
    some title does have a [rel_type_id] relationship with the linked title
    (MARC record may have been like in sn97021134, where the 78X field is present with only a title, no linked record data (LCCNs, OCLCs, nothing)
    SO fill in dummy values for any parts that are empty
  */
  foreach($family_tree as $this_publication)
  {
    $strDebug .= 'pub_id: ' . $this_publication->pub_id . '...';
    //$noDataValue = "no ICON data for field";
    $noDataValue = "no ICON data for ";
    if ( ! $this_publication->pub_id) { $this_publication->pub_id = $noDataValue . "pub_id"; }
    if ( ! $this_publication->relationship_from_pub_id) { $this_publication->relationship_from_pub_id = $noDataValue . "rel_from_id"; }
    if ( ! $this_publication->rel_type_id) { $this_publication->rel_type_id = $noDataValue . "rel. type"; }
    if ( ! $this_publication->rel_type_description) { $this_publication->rel_type_description = $noDataValue . "rel. desc."; }
    if ( ! $this_publication->relationship_to_pub_id) { $this_publication->relationship_to_pub_id = $noDataValue . "rel_to_id"; }
    if ( ! $this_publication->pub_title) { $this_publication->pub_title = $noDataValue . "pub. title"; }
    if ( ! $this_publication->title) { $this_publication->title = $noDataValue . "title"; }
    if ( ! $this_publication->control_num) { $this_publication->control_num = $noDataValue . "control #"; }
    if ( ! $this_publication->ISSN) { $this_publication->ISSN = $noDataValue . "ISSN"; }
    if ( ! $this_publication->pub_city) { $this_publication->pub_city = $noDataValue . "city"; }
    if ( ! $this_publication->country_id) { $this_publication->country_id = $noDataValue . "country"; }
    if ( ! $this_publication->pub_bgnDate) { $this_publication->pub_bgnDate = $noDataValue . "start date"; }
    if ( ! $this_publication->pub_endDate) { $this_publication->pub_endDate = $noDataValue . "end date"; }
  }//end for filling in blank spots
  $strDebug .= '<br/>filled dummy values</p>';
  //echo $strDebug;
  //dump_table($family_tree, "family_tree after DUMMY pub details");
  //end dummy values



  /************ FINISHED ALL QUERIES + VARIABLE FILLING ************/
  /************------- NOW BUILD THE JSON ------------**************/
//echo '<h3>count(family_tree) = ' . count($family_tree) . '</h3>';
  if (count($family_tree) > 1)
  {
  /*
    DETERMINE WHICH MEMBER OF childObject IS THE ROOT: for D3 plugin at
      http://bl.ocks.org/mbostock/4339083
      root needs to be earliest publication even if not the main one for calendar page

    pub_id for root_publication:
      - will be something like....
        has 780XX RELATIONSHIP
        AND/OR
        is EARLIEST pub in family_tree

        with any of the other pubs in family_tree
      - but THERE WILL BE TROUBLE HERE
        $krop = '18uu' < '1800'; //returns false: SHD BE TRUE: an unknown year in the century shd be after the first year of century
        $krop = '18??' < '1800'; //returns false: same as abv
        $krop = '1801' < '1810'; //returns true: GOOD
        var_dump($krop);
        DATES only evaluate correctly if there are 4 valid digits

      - FIRST TRY: SORT BY PUB_DATE, THEN BY REL_TYPE_ID
  */
  //dump_table($family_tree, "family_tree BEFORE sort");
  $num_family_members = count( $family_tree );
  $strDebug .= '<p> there are ' . $num_family_members . ' family members</p>';

  $rel_type_ids = array();
  $rel_from_ids = array(); //for deciding if is a grandchild
  $pub_dates = array();
  foreach($family_tree as $this_publication)
  { //fill rel_type_id and pub_bgnDate, for use with array_multisort
    array_push($rel_from_ids, $this_publication->relationship_from_pub_id);
    array_push($rel_type_ids, $this_publication->rel_type_id);
    array_push($pub_dates, $this_publication->pub_bgnDate);
  }//end foreach

    //add sorting first on pub_id, then rel_type_ids
  array_multisort($family_tree, SORT_ASC, $pub_id_array, SORT_ASC, $rel_type_ids, SORT_DESC, $pub_dates); //NEW TEST
    //first version sorted just on rel_type_ids and pub_dates, but pub_dates are not reliable (question marks and blanks)
  //array_multisort($family_tree, SORT_ASC, $rel_type_ids, SORT_ASC, $pub_dates); //ORIGINAL SORT
  //dump_table($family_tree, "family_tree AFTER sort");
  //SORTING IS FINISHED

  $i = 0;
  foreach($family_tree as $this_publication)
  { //root_publication will be the first element; can only find it now that we've sorted family_tree
    $strDebug .= '<p>rooting i = ' . $i . ')   this_publication.id = ' . $this_publication->pub_id . ' </p>';
    if ($i == 0)
    { //just loop once; horrible kludge to get the first publication after the sort
      $root_publication = $this_publication;
      break;
    }
    $i++; // shd never arrive
  }//end for
  //ROOT IS SET



  $strDebug .= '<p>bGrandchild_rel_type test: substr(' . $this_publication->rel_type_id . '->rel_type_id, 0, 3)=' . substr($this_publication->rel_type_id, 0, 3) . '</p>';
  //echo $strDebug;

  $siblings_array = array();
  $children_array = array();
  $grandchild_object = array();
  foreach($family_tree as $this_publication)
  { //all pubs EXCEPT root go into children_array
    if($this_publication->pub_id != $root_publication->pub_id) {
      $this_child_object = $this_publication;

      /* HOW TO DETERMINE IF this_child_object IS A GRANDCHILD?
          0) family_tree needs at least 3 branches for there to be grandchild: root, a child, a grandchild
            - use num_family_members for that (already defined)
          1) rel_type_id: will begin with 785 (grandchild is a continuation)
          2) relationship_from_pub_id:
            rel_type_id from step 1 will be with at least 1 other in this family_tree,
            and relationship_from_pub_id will be in $rel_from_ids */
      $bGrandchild_rel_type = ( substr($this_publication->rel_type_id, 0, 3) == "785" ); // 1) has the right rel_type_id to be a grandchild
      $bGrandchild_rel_ID = 0;
      foreach($rel_from_ids as $this_rel_from_id)
      {
        if ($this_rel_from_id == $this_publication->relationship_from_pub_id)
        { // 2) relationship is with another in family_tree: MAY TEST FALSE POSITIVE at times
          $bGrandchild_rel_ID = 1; // set true
          break; //don't check the rest
        }//end if
      }//end foreach

      if ( ($num_family_members > 2) && $bGrandchild_rel_type )
      { // MIGHT BE grandchild
        //if($this_publication->pub_id == "sn92060574") { //HARDCODE TEST
        if($bGrandchild_rel_ID)
        {
          array_push($grandchild_object, $this_child_object); // IS grandchild: attach it to this_child_object
          //dump_table($grandchild_object, "grandchild_object");
        }
        else
        { //it might have been a grandchild, but this one wasn't;
          //could do something
        } //end if IS grandchild
      }
      else
      {
          array_push($children_array, $this_child_object); // not grandchild: put it into children_array
      } //end if MIGHT BE grandchild
    } //end if NOT root_publication



/* HOW TO DETERMINE IF this_child_object IS A SIBLING?
      //$this_child_object->siblings = $root_publication; //dummy test
if ($this_publication->pub_id == "sn85038251")
{
  array_push($siblings_array, $this_publication);
}
*/

  } //end foreach
  //dump_table($children_array, "children_array");


    /*   look at each children_array to see if it's the one that gets the grandchild_object
        &$kid MUST be AS REFERENCE    */
  foreach($children_array as &$kid)
  {
    $this_pub_id = $kid->pub_id;
      //HAS grandchild
    //if($this_pub_id == 'sn92060570') //HARDCODED
    if($grandchild_object)
    {
      $kid->children = $grandchild_object; //add grandchild where it goes
    } //end if HAS grandchild
  } //end foreach



 /*   look at each children_array to see if it gets sibling_object
      &$kid MUST be AS REFERENCE
foreach($children_array as &$kid)
{
  $this_pub_id = $kid->pub_id;
if ($this_publication->pub_id == "sn84022605")//HARDCODED
{
 $kid->siblings = $siblings_array;
}//END IF GETS SIBLING
} //end foreach
*/





  //dump_table($children_array, "children_array");
  //dump_table($family_tree, "family_tree WITH CHILDREN");

  $root_publication->children = $children_array; // includes grandchild
  //dump_table($root_publication, "root_publication");



  /*
    //NOW MAKE AVAILABLE TO D3 CLIENT-SIDE CODE
    //echo json_encode($root_publication); //ORIGINAL VERSION step that pushes it to client side
    //some data is missing from MARC records, thus from icondata database
  */
  $JSON_family_tree = json_encode($root_publication);
//$missing_data_message = '":"not in ICON database","'; //$missing_data_message = '":"null","';
//$JSON_family_tree = str_replace('":null,"', $missing_data_message, $JSON_family_tree);
  echo $JSON_family_tree; //the step that pushes it to client side

  }
  else
  { //no relationship rows
    echo 'No matching relationship for title at id:"' . $pub_id . '"';
  } //end else

  mysqli_close($conn);
?>
