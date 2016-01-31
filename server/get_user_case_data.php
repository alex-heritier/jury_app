<?

require 'db.php';

$user_id = $_GET['user_id'];
//$user_id = 69;

$db = new DB();
$mysqli = $db->get_mysqli();

// get user cases
$user_case_query = "SELECT id,prosecutor,defender,title,description,v1_id,"
    . "v2_id,v3_id,v4_id,v5_id,v6_id,v7_id,v8_id,v9_id,v10_id,v11_id,v12_id"
    . "FROM cases WHERE creator_id='$user_id'";
$result = $mysqli->query($user_case_query);
print($user_case_query);
$case_data = array();
while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
    array_push($case_data, $row);
}
$json = json_encode($case_data);
print($json);
