<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Chphisher - V2</title>
  <link rel="shortcut icon" href="./assets/img/favicon.ico" type="image/x-icon">
  <link rel="stylesheet" href="./assets/css/bootstrap.min.css">
  <link rel="stylesheet" href="./assets/css/utils.css">

  <script>
$(document).on('click',function(){
$('.collapse').collapse('hide');
})
</script> 
</head>
<body>
  <nav class="shadow-header navbar navbar-expand-sm navbar-dark bg-dark">
  <div class="container-fluid">
      <a class="navbar-brand" href="<?php $actual_link = (empty($_SERVER['HTTPS']) ? 'http' : 'https') . "://$_SERVER[HTTP_HOST]";echo $actual_link;?>">
        <img src="./assets/img/fav-light.png" alt="img" width="30" height="24" class="d-inline-block align-text-top">
        Chphisher
      </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link" href="./templates/">Templates</a>
        </li>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="https://github.com/Ch4120N">Github</a>
        </li>

        <li class="nav-item">
          <a class="nav-link" href="https://t.me/Ch4120N">Telegram</a>
        </li>

        <li class="nav-item">
          <a class="nav-link" href="https://github.com/Ch4120N/Chphisher-v2/issues">Support</a>
        </li>
      </ul>
    </div>
  </div>
</nav>


  <script src="./assets/js/popper.min.js"></script>
  <script src=".assets/js/jquery.min.js"></script>
  <!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script> -->
  <script src="./assets/js/bootstrap.min.js">

// $(document).on('click','.navbar-collapse.in',function(e) {
//     if( $(e.target).is('a') ) {
//         $(this).collapse('hide');
//     }
// });
$(document).on('click','.navbar-collapse.in',function(e) {
    if( $(e.target).is('a:not(".dropdown-toggle")') ) {
        $(this).collapse('hide');
    }
});
  </script>

</body>
</html>
