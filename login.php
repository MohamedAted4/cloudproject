<?php
session_start();

// Hardcoded username and password
$valid_username = "mohamed";
$valid_password = "1111";

// Define variables to store username and password from the form
$username = $password = "";

// Define variable to store error message
$error = "";

// Check if the form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Retrieve entered username and password from the form
    $username = $_POST['username'];
    $password = $_POST['password'];

    // Check if entered username and password match the hardcoded values
    if ($username === $valid_username && $password === $valid_password) {
        // If credentials are correct, start a session and store username
        $_SESSION['username'] = $username;
        header("Location: web.php"); // Redirect to main page after login
        exit(); // Terminate script execution after redirect
    } else {
        $error = "Invalid username or password";
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="login.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>

<body>
    <div class="wrapper">
        <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
            <h1>Login</h1>
            <?php if (!empty($error)) echo "<p class='error'>$error</p>"; ?>
            <div class="input-box">
                <input type="text" name="username" placeholder="Username" required value="<?php echo htmlspecialchars($username); ?>">
                <i class='bx bxs-user'></i>
            </div>
            <div class="input-box">
                <input type="password" name="password" placeholder="Password" required value="<?php echo htmlspecialchars($password); ?>">
                <i class='bx bxs-lock-alt'></i>
            </div>
            <div class="remember-forget">
                <label><input type="checkbox">Remember me</label>
                <a href="#">Forget password?</a>
            </div>
            <button type="submit" class="btn">Login</button>
            <div class="register-link">
                <p>Don't have an account? <a href="#">Register</a></p>
            </div>
        </form>
    </div>
</body>

</html>
