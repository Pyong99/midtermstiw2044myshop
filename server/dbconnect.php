<?php
$servername = "localhost";
$username   = "pyongcom_myshopadmin";
$password   = "@~V~S8vs%mJ1";
$dbname     = "pyongcom_myshopdb";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection Failed: " . $conn->connect_error);
}
?>