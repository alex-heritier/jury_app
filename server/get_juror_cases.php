<?

require 'db.php';

//$user_id = $_GET['user_id'];
$user_id = 71;

$db = new DB();
$mysqli = $db->get_mysqli();

// find votes assigned to $user_id
$case_ids = array();
$get_case_ids_query = "SELECT case_id FROM votes WHERE juror_id='$user_id'";
//print($get_case_ids_query);
$result = $mysqli->query($get_case_ids_query);
$get_case_data_query = "SELECT prosecutor, defender, description, creator_id FROM cases WHERE active='1' AND (";
while ($case_id = $result->fetch_array(MYSQLI_NUM)[0]) {
    array_push($case_ids, $case_id);
    $get_case_data_query .= "id='$case_id' OR ";
}
$get_case_data_query = substr($get_case_data_query, 0, strlen($get_case_data_query)-4) . ")"; // cut off extra OR
//print($get_case_data_query);
$result = $mysqli->query($get_case_data_query);
$result_as_array = array();
while ($row = $result->fetch_array(MYSQLI_NUM)) {
    array_push($result_as_array, $row);
}
$json = json_encode($result_as_array);
print($json);
