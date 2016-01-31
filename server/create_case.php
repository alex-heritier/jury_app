<?

require 'db.php';

function create_juror_id_array($mysqli, $user_id)
{
    $ids = array();
    $random_user_id_query = "SELECT id FROM users WHERE id!='$user_id' ORDER BY RAND() LIMIT 12";
    $rows = $mysqli->query($random_user_id_query);
    while ($row = $rows->fetch_array(MYSQLI_NUM)) {
        array_push($ids, $row[0]);
    }
    return $ids;
}

$db = new DB();
$mysqli = $db->get_mysqli();

$prosecutor = $mysqli->real_escape_string($_GET['prosecutor']);
$defender = $mysqli->real_escape_string($_GET['defender']);
$title = $mysqli->real_escape_string($_GET['title']);
$description = $mysqli->real_escape_string($_GET['description']);
$active = 1;
$creator_id = $mysqli->real_escape_string($_GET['user_id']);
//$prosecutor = "prosecutor " . rand(0, 100);
//$defender = "defender " . rand(0, 100);
//$title = "title " . rand(0, 100);
//$description = "description " . rand(0, 100);
//$active = 1;
//$creator_id = 74;

// creating case
//print("Creating case...\n");
$case_create_query = "INSERT INTO cases (prosecutor, defender, title, description, active, creator_id) "
    . "VALUES ('$prosecutor', '$defender', '$title', '$description', '$active', '$creator_id')";
//print("$case_create_query\n");
$mysqli->query($case_create_query);
$case_id = $mysqli->insert_id;

// create verdicts
//print("Creating verdicts...\n");
$juror_ids = create_juror_id_array($mysqli, $creator_id);
$vote_ids = array();
// create the 12 different verdict slots
for ($i = 0; $i < count($juror_ids); $i++) {
    $juror_id = $juror_ids[$i];
    $verdict_create_query = "INSERT INTO votes (juror_id, case_id) VALUES ('$juror_id', '$case_id')";
    //print($verdict_create_query);
    $mysqli->query($verdict_create_query);
    $last_vote_id = $mysqli->insert_id;
    //print($last_vote_id . " ");
    array_push($vote_ids, $last_vote_id);
}
// update the case's vote IDs to point at the new votes
$update_vote_slot_query = "UPDATE cases SET ";
for ($i = 1; $i < count($vote_ids)+1; $i++) {
    $update_vote_slot_query .= "v{$i}_id='" . $vote_ids[$i-1] . "', ";
}
$update_vote_slot_query = substr($update_vote_slot_query, 0, strlen($update_vote_slot_query)-2);
$update_vote_slot_query .= " WHERE id='$case_id'";
//print($update_vote_slot_query);
$mysqli->query($update_vote_slot_query);
