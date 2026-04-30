<?php
    require_once("Storage.php");

    session_start();
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
        <h1>Sikertelen foglalás!</h1>
        <div class="showcase">
            <img src=<?= $car->image ?> alt="autó" class="big_img"><br>
            Üzemanyag: <?= $car->fuel_type ?> <br>
            Gyártási év: <?= $car->year ?> <br>
            Váltó: <?= $car->transmission ?> <br>
            Férőhely: <?= $car->passengers ?> <br>
            Ft/nap <?= $car->daily_price_huf ?> <br>
        </div>
        <div>
            A megadott idősávban nem elérhető az autó! <br>
            Próbálj megadni egy másik intervallumot vagy keress egy másik járművet! <br>
            <a href="index.php"><button>Vissza a főmenübe</button></a>
        </div>
    </main>
</body>

</html>