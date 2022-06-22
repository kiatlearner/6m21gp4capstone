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

$name = $_POST['name'];
$age = (int)$_POST['age'];
$sex = $_POST['sex'];
$symptom = $_POST['symptom'];
$prescription = $_POST['prescription'];

$sql = "INSERT INTO records (name, age, sex, symptom, prescription)
VALUES ('$name','$age','$sex','$symptom','$prescription')";

if ($conn->query($sql) === TRUE) {
  echo "New record created successfully";
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}
$conn->close();
?>
<br>
<form method="POST" action="home.php">
  <input type="submit"/ value="Home">
</form>