<?

require 'db.php';

<<<<<<< HEAD
$user_id = $_GET['user_id'];
//$user_id = 80;
=======
//$user_id = $_GET['user_id'];
$user_id = 79;
>>>>>>> trying to fix master

$db = new DB();
$mysqli = $db->get_mysqli();

// find votes assigned to $user_id
$vote_ids = array();
<<<<<<< HEAD
$get_case_ids_query = "SELECT id, case_id FROM votes WHERE juror_id='$user_id' AND active=1";
=======
$get_case_ids_query = "SELECT id, case_id FROM votes WHERE juror_id='$user_id'";
>>>>>>> trying to fix master
//print($get_case_ids_query);
$case_id_result = $mysqli->query($get_case_ids_query);  // get the vote IDs assigned to $user_id
// build the $get_case_data_query to look for the cases with the case IDs
$get_case_data_query = "SELECT id, prosecutor, defender, description, creator_id FROM cases WHERE active='1' AND (";
while ($row = $case_id_result->fetch_array(MYSQLI_ASSOC)) {
    $case_id = $row['case_id'];
    $vote_id = $row['id'];
    array_push($vote_ids, $vote_id);
    $get_case_data_query .= "id='$case_id' OR ";
}
<<<<<<< HEAD
//print_r($vote_ids);
=======
print_r($vote_ids);
>>>>>>> trying to fix master
$get_case_data_query = substr($get_case_data_query, 0, strlen($get_case_data_query)-4) . ")"; // cut off extra OR
//print($get_case_data_query);
$case_data_result = $mysqli->query($get_case_data_query);
$result_as_array = array();
$i = 0;
<<<<<<< HEAD
if ($case_data_result) {
    while ($row = $case_data_result->fetch_array(MYSQLI_ASSOC)) {
        $row['vote_id'] = $vote_ids[$i];
        //print_r($row);
        array_push($result_as_array, $row);
        $i++;
    }
    $json = json_encode($result_as_array);
    print($json);
} else {
    $json = json_encode("[{}]");
    print(json);
=======
while ($row = $case_data_result->fetch_array(MYSQLI_ASSOC)) {
    $row['vote_id'] = $vote_ids[$i];
    array_push($result_as_array, $row);
    $i++;
>>>>>>> trying to fix master
}
