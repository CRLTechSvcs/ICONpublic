<?php

$dbhost	= "127.0.0.1";
$dbuser	= "webuser";
$dbpass	= "w3bus3r";
$dbname	= "icondata";

$conn = @new mysqli($dbhost, $dbuser, $dbpass, $dbname);
if ($conn->connect_error) {
	die('Connect Error: ' . $conn->connect_error);
}

//mysql_select_db($dbname);
?>