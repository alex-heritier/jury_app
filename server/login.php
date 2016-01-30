<?

require 'db.php';

function get_user_id($user, $mysqli)
{
    $query = "SELECT id FROM users WHERE name='$user'";
    $row = $mysqli->query($query)->fetch_array(MYSQLI_NUM);
    return $row[0];
}

$username = $_GET['username'];
$password = $_GET['password'];
//$username = "username 10";
//$password = "password " . rand(0, 100);

if ($username === ''
    || $password === ''
    || $username === NULL
    || $password === NULL) {
    print(-1);  // fail if data is blank
    exit();
}

$db = new DB();
$mysqli = $db->get_mysqli();
//print("logging in...\n");
// find user
$select_query = "SELECT name, pass FROM users WHERE name='$username'";
//print("$select_query\n");
$row = $mysqli->query($select_query)->fetch_array(MYSQLI_NUM);
// if the user exists, do nothing
if ($row) {
    //print("User already exists\n");
    // if the password is correct, return the user id
    if ($row[1] === $password) {
        $user_id = get_user_id($username, $mysqli);
        print($user_id);
    } else { // else return -1
        print(-1);
    }
    exit();
}
// if the user doesn't exist
// add user
$insert_query = "INSERT INTO users (name, pass) VALUES ('$username', '$password')";
//print("$insert_query\n");
$mysqli->query($insert_query);
$user_id = get_user_id($username, $mysqli);
print($user_id);
