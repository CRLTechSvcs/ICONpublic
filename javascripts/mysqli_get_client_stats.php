<?php

/*
  2015-01-26 16:40:04 AJE
  non-essential for ICON, trying some debugging of memory trouble with large issue sets

  2015-01-26 16:48:59
  forget it : requires install of MySQL Native Driver PHP extension
  which is too much trouble at this time
*/

$link = mysqli_connect();
print_r(mysqli_get_client_stats());
?>
