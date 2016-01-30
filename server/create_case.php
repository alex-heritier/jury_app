<?

require 'db.php';

function get_last_case_id($mysqli) {
    $query = "SELECT LAST_INSERT_ID()";
    $row = $mysqli->query($query);
    print_r($row);
}

//$prosecutor = $_GET['prosecutor'];
//$defender = $_GET['defender'];
//$title = $_GET['title'];
//$description = $_GET['description'];
//$active = 0;
//$creator_id = $_GET['user_id'];
$prosecutor = "prosecutor " . rand(0, 100);
$defender = "defender " . rand(0, 100);
$title = "title " . rand(0, 100);
$description = "description " . rand(0, 100);
$active = 1;
$creator_id = rand(0, 100);

$db = new DB();
$mysqli = $db->get_mysqli();
// creating case
print("Creating case...\n");
$case_create_query = "INSERT INTO cases (prosecutor, defender, title, description, active, creator_id) "
    . "'$prosecutor', '$defender', '$title', '$description', '$active', '$creator_id'";
print("$case_create_query\n");
$mysqli->query($case_create_query);

// create verdicts
print("Creating verdicts...\n");
$juror_id = "";
$case_id = get_last_case_id($mysqli);
$verdict = "";
$explanation = "";
$verdict_create_query = "INSERT INTO votes (juror_id, case_id, verdict, explanation) "
    . "'$juror_id', '$case_id', '$verdict', '$explanation'";
print($verdict_create_query);
