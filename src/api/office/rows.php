<?php
include "../config.php";

$data = $_REQUEST;
$request = $_REQUEST['request'];

if ($request == 1) {
    $reportId   = $data['reportId'];

    $sql = "select * from rows where reportId = '".$reportId."'";

    $reportData = mysqli_query($con, $sql);

    $response = array();

    while ($report = mysqli_fetch_assoc($reportData)) {
        $response[] = $report;
    }
    echo json_encode($response);
}
exit;