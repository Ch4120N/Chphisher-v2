<?php
session_start();

include "../include/config.php";

if(isset($_SESSION['IAm-logined'])){
  // echo 
  // sleep(5);
  header('location: ../Panel.php');
  // echo '<script>location.href="panel.php"</script>';
  exit;
}

// $referer = isset($_SERVER['HTTP_REFERER']) ? $_SERVER['HTTP_REFERER'] : 'Direct access';
// print_r($referer);
// echo $referer;
// echo 'You came from: ' . $referer;
// sleep(10);


$errors = [];
if($_SERVER['REQUEST_METHOD'] == 'POST'){
    if(isset($_POST['username']) && isset($_POST['password'])){
        $username = $_POST['username'];
        $password = $_POST['password'];

        if($username == username && $password == password){
            $_SESSION['IAm-logined'] = $username;

            header('location: ../Panel.php');
            // echo '<script>location.href="panel.php"</script>';
            exit;
            
        }
        if (empty($username)){
            array_push($errors, "The Username field is required");
        }
        if (empty($password)){
            array_push($errors, "The Password field is required");

        }
        if (empty($username) && empty($password)){

        } else {
          if ($username != username && $password != password){
              array_push($errors, "Username or password is incorrenct!");
              // echo '<p style="color:red" ><br>Username or password is incorrenct!</p>';
          }
        }

    }
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <meta http-equiv="x-ua-compatible" content="ie=edge" />
  <title>SIGN IN</title>
  <!-- MDB icon -->
  <link rel="icon" href="img/mdb-favicon.ico" type="image/x-icon" />
  <!-- Font Awesome -->
  <!-- <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.2/css/all.css" /> -->
  <link rel="stylesheet" href="../assets/css/all.css" />
  <!-- Google Fonts Roboto -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700;900&display=swap" />
  <!-- MDB -->
  <link rel="stylesheet" href="../assets/css/bootstrap-login-form.min.css" />
</head>

<body>
  <!-- Start your project here-->
  <style>
    .gradient-custom {
      /* fallback for old browsers */
      background: #6a11cb;

      /* Chrome 10-25, Safari 5.1-6 */
      background: -webkit-linear-gradient(to right, rgba(106, 17, 203, 1), rgba(37, 117, 252, 1));

      /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
      background: linear-gradient(to right, rgba(106, 17, 203, 1), rgba(37, 117, 252, 1))
    }
  </style>
  <section class="vh-100 gradient-custom">
    <div class="container py-5 h-100">
      <div class="row d-flex justify-content-center align-items-center h-100">
        <div class="col-12 col-md-8 col-lg-6 col-xl-5">
          <div class="card bg-dark text-white" style="border-radius: 1rem;">
            <div class="card-body p-5 text-center">

              <form class="mb-md-5 mt-md-4 pb-5" method="post" action="">

                <h2 class="fw-bold mb-2 text-uppercase">Login</h2>
                <p class="text-white-50 mb-5">Please enter your login and password!</p>

                <div>
                <?php if (!empty($errors)):?>
                  <!-- <div class="Error-Login "> -->
                    <?php foreach ($errors as $error):?>
                      <?php if ($error == "Username or password is incorrenct!"):?>
                          <p class="text-danger text-center  h-100"><?= $error ?></p>
                        <?php endif?>
                      <?php endforeach ?>
                  <!-- </div> -->
                  <?php endif?>
                </div>
                <div>
                  <div class="form-outline form-white mb-4">
                    <input type="text" class="form-control form-control-lg" name="username"/>
                    <label class="form-label">Username</label>
                  </div>
                  <?php if (!empty($errors)):?>
                  <!-- <div class="Error-Login "> -->
                    <?php foreach ($errors as $error):?>
                      <?php if ($error == "The Username field is required"):?>
                          <p class="text-danger text-start"><?= $error ?></p>
                        <?php endif?>
                      <?php endforeach ?>
                  <!-- </div> -->
                  <?php endif?>
                </div>

                <div>
                  <div class="form-outline form-white mb-4">
                    <input type="password" id="typePasswordX" class="form-control form-control-lg" name="password"/>
                    <label class="form-label" for="typePasswordX">Password</label>
                  </div>

                  <?php if (!empty($errors)):?>
                  <!-- <div class="Error-Login "> -->
                    <?php foreach ($errors as $error):?>
                      <?php if ($error == "The Password field is required"):?>
                          <p class="text-danger text-start"><?= $error ?></p>
                        <?php endif?>
                      <?php endforeach ?>
                  <!-- </div> -->
                  <?php endif?>
                </div>


                <button class="btn btn-outline-light btn-lg px-5" type="submit" name="Login">Login</button>

              </form>


            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- End your project here-->
    <!-- <div class="main">
        <h3>Enter your login credentials</h3><br>
        <form action="" class="form-container form-singin justify-content-center" method="post" role="form">
            <input type="text" class="form-control" name="username" placeholder="Enter your Username" >
            <input type="password" class="form-control" name="password" placeholder="Enter your Password" >
            <button class="btn btn-primary btn-block" type="submit">Login</button>
            <div >
            </div>
        </form>
    </div> -->
  <!-- MDB -->
  <script type="text/javascript" src="../assets/js/mdb.min.js"></script>
  <!-- Custom scripts -->
  <script type="text/javascript"></script>
</body>

</html>