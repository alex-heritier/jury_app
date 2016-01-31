<?

require 'db.php';

$vote_id = $_GET['vote_id'];
$case_id = $_GET['case_id'];
$verdict = $_GET['verdict'];
$comment = $_GET['comment'];
//$vote_id = 542;
//$case_id = 122;
//$verdict = rand(0, 100);
//$comment = "An employee gave me head in the bathroom.";

$db = new DB();
$mysqli = $db->get_mysqli();

// update the vote
$vote_update_query = "UPDATE votes SET verdict='$verdict', explanation='$comment' WHERE id='$vote_id'";
//print($vote_update_query);
$mysqli->query($vote_update_query);

// increment case's vote count
$get_vote_count_query = "SELECT vote_count FROM cases WHERE id='$case_id'";
$vote_count = $mysqli->query($get_vote_count_query)->fetch_array(MYSQLI_NUM)[0];
$vote_count++;
//print($vote_count);
if ($vote_count >= 12) { // if vote_count is at 12 (the max)
    // set case to inactive
    $deactivate_case_query = "UPDATE cases SET active=0, vote_count='$vote_count' WHERE id='$case_id'";
    //print($deactivate_case_query);
    $mysqli->query($deactivate_case_query);
    // set associated votes to inactive
    $deactivate_votes_query = "UPDATE votes SET active=0 WHERE case_id='$case_id'";
    //print($deactivate_votes_query);
    $mysqli->query($deactivate_votes_query);
} else {
    // increment vote_count
    $increment_vote_count_query = "UPDATE cases SET vote_count='$vote_count' WHERE id='$case_id'";
    $mysqli->query($increment_vote_count_query);
}
