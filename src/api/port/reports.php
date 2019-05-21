<?php 

include "../config.php";

$data = $_REQUEST;
$request = $_REQUEST['request'];

if ($request == 1) {
    $sql = "select * from reports where reportId = (select MAX(reportId) from reports)";
    $answer = mysqli_query($con, $sql);
    
    $response = array();
    
    while ($row = mysqli_fetch_assoc($answer)) {
        $response[] = $row;
    }
    echo json_encode($response);
}
if ($request == 2) {
    $title   = $data['title'];
    $sentBy  = $data['sentBy'];
    
    $sql = "INSERT INTO reports (title,sentBy) VALUES('" . $title . "','" . $sentBy . "')";
    
    if ($con->query($sql) === TRUE) {
        echo "New record created successfully";
    } else {
        echo "Error: " . $sql . "<br>" . $con->error;
    }
}
exit;