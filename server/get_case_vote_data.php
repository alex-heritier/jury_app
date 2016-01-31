<?

require 'db.php';

$case_id = $_GET['case_id'];

$db = new DB();
$mysqli = $db->get_mysqli();

// get vote data
$vote_data_query = "SELECT id, juror_id, verdict, explanation FROM votes WHERE case_id='$case_id'";
$result = $mysqli->query($vote_data_query);
//print($vote_data_query);
$case_vote_data = array();
while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
    if ($row['verdict'] == NULL) {
        $row['verdict'] = -1;
    }
    if ($row['explanation'] == NULL) {
        $row['explanation'] = "";
    }
    array_push($case_vote_data, $row);
}
print_r(json_encode($case_vote_data));
