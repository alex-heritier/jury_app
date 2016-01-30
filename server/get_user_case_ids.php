<?

require 'db.php';

$user_id = $_GET['user_id'];
//$user_id = 69;

$db = new DB();
$mysqli = $db->get_mysqli();

// get user cases
$user_case_query = "SELECT id FROM cases WHERE creator_id='$user_id'";
$result = $mysqli->query($user_case_query);
$case_ids = array();
while ($case_id = $result->fetch_array(MYSQLI_NUM)[0]) {
    array_push($case_ids, $case_id);
}
$json = json_encode($case_ids);
print($json);
