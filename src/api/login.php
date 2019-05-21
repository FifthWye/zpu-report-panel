<?php 

include "config.php";

$data = $_REQUEST;
$request = $_REQUEST['request'];

if ($request == 1) {
    $email = $data['email'];
    $password = $data['password'];
    $sql = 'select * from users where email =  "'.$email.'" and password = "'.$password.'"';
    $answer = mysqli_query($con, $sql);

    $row = mysqli_fetch_assoc($answer);
    unset($row["email"]);
    unset($row["password"]);
    $response[] = $row;

    echo json_encode($row);
}
exit;