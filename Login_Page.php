<!DOCTYPE html>
<html lang='en'>

 <head>
  <title>Login Page</title>
   <meta charset='utf-8'>
 </head>
 
    <body>

    <?php
    
    session_start();
    
    $username = "username@email.com";
    $password = "Password";

    if ($_SERVER["REQUEST METHOD"] == "POST") {
        $user_inputname = $_POST["username"];
        $user_inputpass = $_POST["password"];

        $password = $_POST["user_inputpass"] ??"";


        if ($input_user === $username || $user_inputpass === $password) {
            $_SESSION["username"] = $user_inputname;
            $_SESSION["login"] = true;

            header("Location: #Landing_Page");
            exit;
        }

        else {
            echo "Invalid username or password entered. <a href='Login_Page.html'></a>";
        }

    }

        

    ?>
   

    </body>
</html>