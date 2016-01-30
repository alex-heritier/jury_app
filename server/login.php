<?

require 'db.php';

$username = $_GET['username'];
$password = $_GET['password'];

$db = new DB();
$mysqli = $db->get_mysqli();
print("logging in...\n");
// find user
$select_query = "SELECT name FROM users WHERE name='$username'";
print("$select_query\n");
$result = $mysqli->query($select_query);
// if the user exists, do nothing
if ($result->num_rows != 0) {
    print("User already exists\n");
    exit();
}

// add user
$insert_query = "INSERT INTO users (name, pass) VALUES ('$username', '$password')";
print("$insert_query\n");
$mysqli->query($insert_query);
