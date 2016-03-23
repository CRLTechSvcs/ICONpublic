<?php

  /* 2013-09-26 hardcoded JSON for statistics.php : 2 levels of array so same javascript can work on both */

	$formatInfo = array();
	$formatArray = array();
/***************************************************************
to get the data for this set of statistics, run:
  get_statistics_countries.php
in a COMMAND WINDOW, on AWS so numbers are live, like this:

  Thu Jan 30 21:22 [aelliott@ip-10-165-44-177:/var/www/ICON $]  php get_statistics_formats.php > /home/aelliott/got_statistics_formats.json

download it, open it, paste the results after the comment block.

Then perform the replacements below to create a good JSON file for the static statistics set.

//RETAIN THIS EXAMPLE WHEN PASTING NEW UPDATED STATS

$formatInfo = array("format_id"=>"1","format_name"=>"unspecified/unknown","format_note"=>"default","publications"=>21009,"issues"=>673420);
array_push($formatArray, $formatInfo);

UEStudio replacement, not as regex:
},{
with
);^parray_push($formatArray, $formatInfo);^p$formatInfo = array(

AND
"=>"
with
"=>"

AND then catch the numeric stuff:
"=>
with
"=>

***************************************************************/
$formatInfo = array("format_id"=>"1","format_name"=>"Unspecified or unknown","format_note"=>"default","publications"=>16758,"issues"=>1258437);
array_push($formatArray, $formatInfo);
$formatInfo = array("format_id"=>"2","format_name"=>"Paper","format_note"=>"used in MWA Clarence data","publications"=>18577,"issues"=>2514384);
array_push($formatArray, $formatInfo);
$formatInfo = array("format_id"=>"3","format_name"=>"Original","format_note"=>"used in LC Chronicling America MARCXML","publications"=>84161,"issues"=>5802496);
array_push($formatArray, $formatInfo);
$formatInfo = array("format_id"=>"4","format_name"=>"Microfilm","format_note"=>"used in LC Chronicling America MARCXML","publications"=>105745,"issues"=>27818720);
array_push($formatArray, $formatInfo);
$formatInfo = array("format_id"=>"5","format_name"=>"Microfiche","format_note"=>"used in LC Chronicling America MARCXML","publications"=>4977,"issues"=>87911);
array_push($formatArray, $formatInfo);
$formatInfo = array("format_id"=>"6","format_name"=>"Microopaque","format_note"=>"used in LC Chronicling America MARCXML. Also called microcards or microprints (cf. OCLC Bibliographic Formats and Standards 007micro)","publications"=>601,"issues"=>1427531);
array_push($formatArray, $formatInfo);
$formatInfo = array("format_id"=>"7","format_name"=>"Eye-Readable Reprint","format_note"=>"used in LC Chronicling America MARCXML. \"Regular print reproduction. Item is a reproduction in regular eye-readable print (e.g., a photocopy)\" (cf. OCLC Bibliographic Formats and Standards \"Form\")","publications"=>2162,"issues"=>36715);
array_push($formatArray, $formatInfo);
$formatInfo = array("format_id"=>"8","format_name"=>"Digital: PDF","format_note"=>"label applied to LCChronAmerica digitized records; ProQuest Historical Newspapers; NewsBank (FLNEW) issues by AJE; also 1: issue_id 37146523 had \"Online text\" from LCChronAmerica","publications"=>10624,"issues"=>8729907);
array_push($formatArray, $formatInfo);
$formatInfo = array("format_id"=>"9","format_name"=>"Facsimile","format_note"=>"used in MWA Clarence data","publications"=>91,"issues"=>257);
array_push($formatArray, $formatInfo);
$formatInfo = array("format_id"=>"10","format_name"=>"Photomechanical copy","format_note"=>"used in MWA Clarence data","publications"=>159,"issues"=>471);
array_push($formatArray, $formatInfo);
$formatInfo = array("format_id"=>"11","format_name"=>"Textile","format_note"=>"used in MWA Clarence data","publications"=>3,"issues"=>3);
array_push($formatArray, $formatInfo);
$formatInfo = array("format_id"=>"12","format_name"=>"Digital: Direct electronic","format_note"=>"008\/23 = 'q' ; \"Storage on a directly accessible tangible recording medium, e.g. disc, tape, playaway device, flashdrive, portable hard drive, etc.\" (cf. OCLC Bibliographic Formats and Standards \"Form\")","publications"=>1,"issues"=>293);
array_push($formatArray, $formatInfo);
$formatInfo = array("format_id"=>"13","format_name"=>"Microform","format_note"=>"unspecified\/unknown microform: used in data submitted by CRRA Catholic Research Resources Alliance","publications"=>339,"issues"=>27158);
array_push($formatArray, $formatInfo);
$formatInfo = array("format_id"=>"14","format_name"=>"Digital: Unspecified","format_note"=>"unspecified\/unknown digital format: used in data submitted by CRRA Catholic Research Resources Alliance","publications"=>33,"issues"=>18468);
array_push($formatArray, $formatInfo);
$formatInfo = array("format_id"=>"15","format_name"=>"Digital: TIFF","format_note"=>"Tagged Image File Format","publications"=>2,"issues"=>406);
array_push($formatArray, $formatInfo);
$formatInfo = array("format_id"=>"16","format_name"=>"Tissue paper","format_note"=>"used in AQM \/ MWA (American Antiquarian Society) Clarence data [2015-02-24]","publications"=>3,"issues"=>6);
array_push($formatArray, $formatInfo);
$formatInfo = array("format_id"=>"17","format_name"=>"Wallpaper","format_note"=>"used in AQM \/ MWA (American Antiquarian Society) Clarence data [2015-02-24]","publications"=>17,"issues"=>103);
array_push($formatArray, $formatInfo);
/***************************************************************/

// Sort the multidimensional array: solution from nick ([AT]) nickyost ([DOT]) com in the PHP manual
usort($formatArray, "custom_sort");
// Define the custom sort function
function custom_sort($a,$b) {
     return $a['format_name']>$b['format_name'];
}

$encoded = json_encode($formatArray);
die($encoded);

?>
