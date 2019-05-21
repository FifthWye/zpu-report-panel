<?php
include "../config.php";

$data = $_REQUEST;
$request = $_REQUEST['request'];

if ($request == 1) {
    $sql = "select * from reports order by reportId DESC";
    $reportsData = mysqli_query($con, $sql);
    
    $response = array();
    
    while ($report = mysqli_fetch_assoc($reportsData)) {
        $response[] = $report;
    }
    echo json_encode($response);
}
if ($request == 2) {
    $platform   = $data['platform'];
    $container1 = $data['container1'];
    $container2 = $data['container2'];
    $ZPU1       = $data['ZPU1'];
    $ZPU2       = $data['ZPU2'];
    $reportId   = $data['reportId'];
    
    $sql = "INSERT INTO rows (platform,container1,container2,ZPU1,ZPU2,reportId) VALUES('" . $platform . "','" . $container1 . "','" . $container2 . "','" . $ZPU1 . "','" . $ZPU2 . "','" . $reportId . "')";
    
    if ($con->query($sql) === TRUE) {
        echo "New record created successfully";
    } else {
        echo "Error: " . $sql . "<br>" . $con->error;
    }
}
exit;