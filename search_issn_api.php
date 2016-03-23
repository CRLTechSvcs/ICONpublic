<?php


error_reporting(0); // AJE 2013-07-09 11:30:26


//===========================================================================
//Use this expression in an xPath query to return everything in the document:
//node() | //@* | //namespace::*
//===========================================================================
$ISSN_array = $_REQUEST['issns']; //AJE: this seems not to be a named var
//$ISSN_array = array("0584-8539");
//$ISSN_array = array("1234-5678");

/*
  http://xissn.worldcat.org/xissnadmin/index.htm
  xISSN (Web service)
  Use this Web service to retrieve a list of International Standard Serial Numbers (ISSNs)
    associated with a submitted ISSN, based on WorldCat information.
*/
$url_start = "http://xissn.worldcat.org/webservices/xid/issn/";
$url_end = "?method=getHistory&format=xml&ai=conjur";
//$url_end = "?method=getHistory&format=xml";


$issnInfoArray = array();
$groupArray = array();
$outerArray = array();
$relationshipTypes780 = array("Continues", "Continues in part", "Supersedes", "Supersedes in part", "Formed by the union of ...", "Absorbed", "Absorbed in part", "Separated from");
$relationshipTypes785 = array("Is continued by", "Is continued in part by", "Was superseded by", "Was superseded in part by", "Was absorbed by", "Was absorbed in part by", "Split into ... and ...", "Merged with ... to form ...", "Changed back to");

foreach ($ISSN_array as $temp_issn) {
		$request_url = $url_start . $temp_issn . $url_end;
		//$request_url = "http://ec2-54-225-226-125.compute-1.amazonaws.com/WorldCat%20API/0584-8539.xml";
		//$request_url = "http://ec2-54-225-226-125.compute-1.amazonaws.com/WorldCat%20API/1234-5678.xml";
		$headers = @get_headers($request_url);
		if (preg_match("|200|", $headers[0])) {
			$request_string = file_get_contents($request_url);
			$doc = new DOMDocument;
			$doc->preserveWhiteSpace = false;
			@$doc->loadHTML($request_string);
			$xpath = new DOMXpath($doc);
			//Check for "Invalid ID" response status
			$start_nodes = $xpath->query('//node()');
			$response_node = $start_nodes->item(3);
			$response_status = $response_node->getAttribute('stat');
			if ($response_status != "invalidId") {
				$group_count = $xpath->query('//group')->length;
				for ($i = 0; $i < $group_count; $i++) {
					
					$temp_reltype = "This title";
					
					$temp_group = $xpath->query('//group')->item($i);
					$temp_group_attributes = $temp_group->attributes;
					foreach ($temp_group_attributes as $index=>$attr){
						$temp_group_attribute_name = $attr->name;
						if ($temp_group_attribute_name == "rel") {
							$temp_relationship = $attr->value;
							$temp_relationship = ucfirst($temp_relationship);
						} elseif ($temp_group_attribute_name == "marccode") {
							$temp_marccode = $attr->value;
							$temp_marccode = ucfirst($temp_marccode);
						} elseif ($temp_group_attribute_name == "subrel") {
							$temp_index = $attr->value;
							if ($temp_marccode == "780") {
								$temp_reltype = $relationshipTypes780[$temp_index];
							} elseif ($temp_marccode == "785") {
								$temp_reltype = $relationshipTypes785[$temp_index];
							}
						}
					}
					$temp_issns = $temp_group->childNodes;
					$temp_issn_count = $temp_issns->length;
					$issnInfoArray = array();
					for ($j = 0; $j < $temp_issn_count; $j++) {
						$temp_issn_node = $temp_issns->item($j);
						$temp_issn_value = $temp_issn_node->nodeValue;
						$temp_form = $temp_issn_node->getAttribute('form');
						$temp_oclcnums = $temp_issn_node->getAttribute('oclcnum');
						$temp_raw_coverage = $temp_issn_node->getAttribute('rawcoverage');
						$temp_title = $temp_issn_node->getAttribute('title');
						$temp_publisher = $temp_issn_node->getAttribute('publisher');
						$temp_peerreview = $temp_issn_node->getAttribute('peerreview');
						$temp_issnl = $temp_issn_node->getAttribute('issnl');
						$temp_rssurl = $temp_issn_node->getAttribute('rssurl');
						$innerArray = array("ISSN" => $temp_issn_value, "form" => $temp_form, "OCLCnumbers" => $temp_oclcnums, "rawCoverage" => $temp_raw_coverage, "title" => $temp_title, "publisher" => $temp_publisher, "peerReview" => $temp_peerreview, "ISSNL" => $temp_issnl, "rssURL" => $temp_rssurl);
						array_push($issnInfoArray, $innerArray);
					}
					$innerGroup = array("relationship" => $temp_relationship, "marccode" => $temp_marccode, "reltype" => $temp_reltype, "ISSNs" => $issnInfoArray);
					array_push($groupArray,$innerGroup);
				}
				$outerArray = array("groups" => $groupArray);
			} else {
				$innerArray = array("ISSN" => "INVALID ISSN", "form" => null, "OCLCnumbers" => null, "rawCoverage" => null, "title" => null, "publisher" => null, "peerReview" => null, "ISSNL" => null, "rssURL" => null);
				array_push($issnInfoArray, $innerArray);
				$innerGroup = array("relationship" => "This", "marccode" => null, "reltype" => null, "ISSNs" => $issnInfoArray);
				array_push($groupArray,$innerGroup);
				$outerArray = array("groups" => $groupArray);
			}
		}
}
$json = array("issnInfo" => $outerArray);
$encoded = json_encode($json);
die($encoded);
?>