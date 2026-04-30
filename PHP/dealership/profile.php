<?php
    require_once("Storage.php");
    session_start();

    $carStorage = new Storage(new JsonIO('cars.json'), false);

    $userStorage = new Storage(new JsonIO('users.json'), false);
    $user = $userStorage->findById($_SESSION['profile']);

    $reservationStorage = new Storage(new JsonIO('reservations.json'), false);
    $reservations = $reservationStorage->findAll();
    if ($user->admin == false){
        $reservations = array_filter($reservations, fn($reservation) => $reservation->email == $user->email);
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
        <h1><?= $user->name ?></h3>
        <h2>Foglalásaim:</h2>
        <div class="showcase_holder">
            <?php foreach ($reservations as $reservation): ?>
                <?php
                $car = $carStorage->findById($reservation->carid);
                ?>
                <div class="showcase">
                    <img src=<?= $car->image ?> alt="autó" class="small_img"><br>
                    <?= $car->brand ?> <?= $car->model ?> <br>
                    <?= $reservation->from ?> - <?= $reservation->to ?> <br>
                    <?= $car->passengers ?> férőhely - <?= $car->transmission ?> <br>
                    <?php if ($user->admin):?>
                    <?= $reservation->email ?> <br>
                    <a href="reservationdelete.php?id=<?= $reservation->id ?>"><button class="admin">ADMIN: töröl</button><br></a>
                    <?php endif; ?>
                </div>
            <?php endforeach; ?>
        </div>
    </main>
</body>

</html>