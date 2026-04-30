<?php
    require_once("Storage.php");

    session_start();

    $from = date_create($_GET["date_from"]);
    $to = date_create($_GET["date_to"]);
    $interval = date_diff($from, $to);
    $interval = $interval->format('%a');

    $reservationStorage = new Storage(new JsonIO('reservations.json'), false);

    $carStorage = new Storage(new JsonIO('cars.json'), false);
    $car = $carStorage->findById($_SESSION['car_id']);

    $userStorage = new Storage(new JsonIO('users.json'), false);
    if (isset($_SESSION["profile"])){
        $user = $userStorage->findById($_SESSION["profile"]);
    }

?>

<!DOCTYPE html>
<html lang="hu">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>iKarRental</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>
    <header>
        <a href="index.php"><button>iKarRental</button></a>
        <?php if (!isset($_SESSION["profile"])):?>
        <a href="login.php"><button>Bejelentkezés</button></a>
        <a href="registration.php"><button>Regisztráció</button></a>
        <?php endif; ?>
        <?php if (isset($_SESSION["profile"])):?>
        <a href="profile.php"><button>Profil</button></a>
        <a href="logout.php"><button>Kijelentkezés</button></a>
        <?php if ($user->admin):?>
        <a href="caradd.php"><button class="long admin">ADMIN: Új autó</button></a>
        <?php endif; ?>
        <?php endif; ?>
    </header>
    <main>
        <h1>Sikeres foglalás!</h1>
        <h2><?= $car->brand ?> <?= $car->model ?></h2>
        <div class="showcase">
            <img src=<?= $car->image ?> alt="autó" class="big_img"><br>
            Üzemanyag: <?= $car->fuel_type ?> <br>
            Gyártási év: <?= $car->year ?> <br>
            Váltó: <?= $car->transmission ?> <br>
            Férőhely: <?= $car->passengers ?> <br>
            Ft/nap <?= $car->daily_price_huf ?> <br>
        </div>
        <div>
            <?=$_GET['date_from']?> - <?=$_GET['date_to']?> <br>
            Végösszeg: <?php echo ($interval + 1) * $car->daily_price_huf?> Ft <br>
            Foglalásod státuszát a profiloldaladon követheted nyomon! <br>
            <a href="profile.php"><button>Profil oldal</button></a>
        </div>
    </main>
</body>

</html>