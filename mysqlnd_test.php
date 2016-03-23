<?php

/*

  2015-01-27
    http://stackoverflow.com/questions/1475701/how-to-know-if-mysqlnd-is-the-active-driver?rq=1

  - do we have the mysqlnd 'native driver' set up?
*/



$hasMySQL = false;
$hasMySQLi = false;
$withMySQLnd = false;
$sentence = '';

if (function_exists('mysql_connect')) {
    $hasMySQL = true;
    $sentence.= "(Deprecated) MySQL <b>is installed</b> ";
} else
    $sentence.= "(Deprecated) MySQL <b>is not</b> installed ";

if (function_exists('mysqli_connect')) {
    $hasMySQLi = true;
    $sentence.= "and the new (improved) MySQL <b>is installed</b>. ";
} else
    $sentence.= "and the new (improved) MySQL <b>is <u>not</u> installed</b>. ";

if (function_exists('mysqli_get_client_stats')) {
    $withMySQLnd = true;
    $sentence.= "This server is using <strong>MySQLnd</strong> as the driver.";
} else
    $sentence.= "This server is using <strong>libmysqlclient</strong> as the driver.";

echo $sentence;

?>
