<?php
$servername = "127.0.0.1";
$username = "emruser";
$password = "password";

// Create connection
$conn = new mysqli($servername, $username, $password);

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}
echo "Connected successfully";
?>

<br><br>
<form method="POST" action="home.php">
  <input type="submit"/ value="Home">
</form>
