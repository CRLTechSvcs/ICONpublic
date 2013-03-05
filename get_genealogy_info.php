<?php

/*
2012-10-08 16:03:41
	copy of get-publication_info.php
	modified for testing--AJE
*/

	// GET REQUIRED INCLUDES | GET VARIABLES PASSED IN URL

		include ('config.php');
		$pub_id = str_replace('%20', '', $_REQUEST['pub_id']);

	// QUERY DATABASE FOR RELATIONSHIP DATA

		//order by pub_bgnDate
		$query = 'SELECT r.relationship_from_pub_id, r.rel_type_id, t.rel_type_description, r.relationship_to_title, r.relationship_to_pub_id, r.relationship_to_control_num, r.relationship_to_ISSN FROM bib_relationships r, bib_relationship_types t, publications p WHERE r.rel_type_id = t.rel_type_id AND r.relationship_to_pub_id = p.pub_id AND (r.relationship_from_pub_id = ? OR r.relationship_to_pub_id = ?) ORDER BY p.pub_bgnDate';

		//order by relationship_from:
		// ok but really want to work in genealogy_functions.js to highlight the requested pub_id first
		//$query = 'SELECT r.relationship_from, r.rel_type_id, t.rel_type_description, r.relationship_to_title, r.relationship_to_pub_id, r.relationship_to_control_num, r.relationship_to_ISSN FROM bib_relationships r, bib_relationship_types t, publications p WHERE r.rel_type_id = t.rel_type_id AND r.relationship_to_pub_id = p.pub_id AND (r.relationship_from = ? OR r.relationship_to_pub_id = ?) ORDER BY r.relationship_from';

		$statement = $conn->prepare($query);
		$statement->bind_param('ss', $pub_id, $pub_id);
		$statement->execute();
		$statement->store_result();

	// EXTRACT RESULTS
	// BUILD ARRAY TO BE JSON ENCODED
	// DISPLAY JSON DATA

		if ($statement->num_rows == 0) {echo '';}
		else
		{
			$statement->bind_result($relationship_from, $rel_type_id, $rel_type_description, $relationship_to_title, $relationship_to_pub_id, $relationship_to_control_num, $relationship_to_ISSN);

			while ($statement->fetch())
			{
				$jsonArray[] = array
				(
					'relationshipFrom'            => trim($relationship_from),
					'rel_type_id'                 => trim($rel_type_id),
					'rel_type_description'        => trim($rel_type_description),
					'relationship_to_title'       => trim($relationship_to_title),
					'relationship_to_pub_id'      => trim($relationship_to_pub_id),
					'relationship_to_control_num' => trim($relationship_to_control_num),
					'relationship_to_ISSN'        => trim($relationship_to_ISSN)
				);
			}

			echo json_encode($jsonArray);
		}

	// CLOSE STATEMENT & DB CONNECTION

		$statement->close();
		mysqli_close($conn);

?>
