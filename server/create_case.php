<?

require 'db.php';

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
$active = 0;
$creator_id = rand(0, 100);

$db = new DB();
$mysqli = $db->get_mysqli();
print("Creating case...");
// creating case
$create_query = "INSERT INTO cases (prosecutor, defender, title, description, active, creator_id) "
    . "'$prosecutor', '$defender', '$title', '$description', '$active', '$creator_id'";
print("$create_query\n");
$mysqli->query($create_query);
