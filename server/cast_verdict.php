<?

require 'db.php';

$vote_id = $_GET['vote_id'];
$case_id = $_GET['case_id'];
$verdict = $_GET['verdict'];
$comment = $_GET['comment'];
//$vote_id = 433;
//$case_id = 112;
//$verdict = rand(0, 100);
//$comment = "An employee gave me head in the bathroom.";

$db = new DB();
$mysqli = $db->get_mysqli();

// update the vote
$vote_update_query = "UPDATE votes SET verdict='$verdict', explanation='$comment' WHERE id='$vote_id'";
//print($vote_update_query);
$mysqli->query($vote_update_query);

// check if all of case's votes haves verdicts
$check_case_query = "SELECT id FROM cases WHERE id='$case_id' AND v1_id!='NULL'"
    . " AND v2_id!='NULL'"
    . " AND v3_id!='NULL'"
    . " AND v4_id!='NULL'"
    . " AND v5_id!='NULL'"
    . " AND v6_id!='NULL'"
    . " AND v7_id!='NULL'"
    . " AND v8_id!='NULL'"
    . " AND v9_id!='NULL'"
    . " AND v10_id!='NULL'"
    . " AND v11_id!='NULL'"
    . " AND v12_id!='NULL'";
//print($check_case_query);
$result = $mysqli->query($check_case_query);
if ($result->num_rows != 0) {
    // set case to inactive
    $deactivate_case_query = "UPDATE cases SET active=0 WHERE id='$case_id'";
    print($deactivate_case_query);
    $mysqli->query($deactivate_case_query);
}
