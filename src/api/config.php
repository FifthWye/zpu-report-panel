<?php

$host = "31.31.196.77"; /* Host name */
$user = "u0543636_default"; /* User */
$password = "62956438Nm"; /* Password */
$dbname = "u0543636_default"; /* Database name */

$con = mysqli_connect($host, $user, $password,$dbname);
// Check connection
if (!$con) {
  die("Connection failed: " . mysqli_connect_error());
}

$con->query("SET NAMES 'utf8'"); 
$con->query("SET CHARACTER SET utf8");  
$con->query("SET SESSION collation_connection = 'utf8_unicode_ci'");