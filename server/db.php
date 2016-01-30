<?

class DB {
    private $hostname = 'jury.db';
    private $username = 'aheritier';
    private $password = 'oobkuh';
    private $database = 'jury';
    private $mysqli;

    // creates the mysqli database connection
    public function __construct()
    {
        print("constructing...\n");
        $this->mysqli = new mysqli($this->hostname,
            $this->username,
            $this->password,
            $this->database);
        /* check connection */
        if (mysqli_connect_errno()) {
            printf("Connect failed: %s\n", mysqli_connect_error());
            exit();
        }
    }

    // return the mysqli connection
    public function get_mysqli()
    {
        return $this->mysqli;
    }
}
