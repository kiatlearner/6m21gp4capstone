<html>
<body>

<?php echo "<h2>Add patient</h2>"; ?>

<form action="insert.php" method="post">
name: <input type="text" name="name"><br><br>
age: <input type="text" name="age"><br><br>
sex: <input type="text" name="sex"><br><br>
symptom: <input type="text" name="symptom"><br><br>
prescription: <input type="text" name="prescription"><br><br>
<input type="submit">
</form>

<br>
<form method="POST" action="home.php">
  <input type="submit"/ value="Home">
</form>

</body>
</html>
