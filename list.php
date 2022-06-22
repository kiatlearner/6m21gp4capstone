<?php
$servername = "127.0.0.1";
$username = "emruser";
$password = "password";
$dbtable = "records";
// no need to use database, instead use table. this applies to cloud sql for mysql.

// Create connection
$conn = new mysqli($servername, $username, $password, $dbtable);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

echo "<h2>Patient Records</h2>";

$sql = "SELECT name, age, sex, symptom, prescription FROM records";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
  // output data of each row
  while($row = $result->fetch_assoc()) {
    echo "Name: " . $row["name"]. " - Age: " . $row["age"]. " - Sex: " . $row["sex"]. " - Symptom: " . $row["symptom"]. " - Prescription: " . $row["prescription"]. "<br>";
  }
} else {
  echo "0 results";
}
$conn->close();
?>
<br>
<form method="POST" action="home.php">
  <input type="submit"/ value="Home">
</form>
