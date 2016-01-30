<?

require 'db.php';

function create_juror_id_array($mysqli)
{
    $ids = array();
    $random_user_id_query = "SELECT id FROM users ORDER BY RAND() LIMIT 12";
    $rows = $mysqli->query($random_user_id_query);
    while ($row = $rows->fetch_array(MYSQLI_NUM)) {
        array_push($ids, $row[0]);
    }
    return $ids;
}

$prosecutor = $_GET['prosecutor'];
$defender = $_GET['defender'];
$title = $_GET['title'];
$description = $_GET['description'];
$active = 1;
$creator_id = $_GET['user_id'];
//$prosecutor = "prosecutor " . rand(0, 100);
//$defender = "defender " . rand(0, 100);
//$title = "title " . rand(0, 100);
//$description = "description " . rand(0, 100);
//$active = 1;
//$creator_id = rand(0, 100);

$db = new DB();
$mysqli = $db->get_mysqli();
// creating case
//print("Creating case...\n");
$case_create_query = "INSERT INTO cases (prosecutor, defender, title, description, active, creator_id) "
    . "VALUES ('$prosecutor', '$defender', '$title', '$description', '$active', '$creator_id')";
//print("$case_create_query\n");
$mysqli->query($case_create_query);
$case_id = $mysqli->insert_id;

// create verdicts
print("Creating verdicts...\n");
// create the 12 different verdict slots
$juror_ids = create_juror_id_array($mysqli);
for ($i = 0; $i < count($juror_ids); $i++) {
    $juror_id = $juror_ids[$i];
    $verdict_create_query = "INSERT INTO votes (juror_id, case_id) VALUES ('$juror_id', '$case_id')";
    print($verdict_create_query);
    $mysqli->query($verdict_create_query);
}
