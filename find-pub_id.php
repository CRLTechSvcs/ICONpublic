<?php

header('content-type: application/json; charset=utf-8');
header("access-control-allow-origin: *");

/*
AJE  2013-02-20 17:25:09
	- get a candidate pub_id in request
	- look for it in, pub_id, marc001, OCLC
*/


	// GET REQUIRED INCLUDES | GET VARIABLES PASSED IN URL

		include ('config.php');
		$requestedPubID = str_replace('%20', '', $_REQUEST['pub_id']);
		$query = 'SELECT pub_id FROM publications WHERE pub_id = ?';
		$query .= ' OR INSTR(marc001, ?)';
		$query .= ' OR INSTR(OCLC, ?)';

		$statement = $conn->prepare($query);
		$statement->bind_param('sss', $requestedPubID, $requestedPubID, $requestedPubID);
		$statement->execute();
		$statement->store_result();

		if ($statement->num_rows > 0) { //found pub_id somewhere
			$statement->bind_result($pub_id);
			while ($statement->fetch()) {
				$jsonArray[] = array( 'pub_id' => trim($pub_id) );
			}//end while
		} else {
			$jsonArray[] = array( 'pub_id' => $requestedPubID . '-not found in ICON' );
		}//end if-else

		$JSONP = json_encode($jsonArray);
		echo $_GET['callback'] . '(' . $JSONP . ')';

	// CLOSE STATEMENT & DB CONNECTION
		$statement->close();
		mysqli_close($conn);

?>
