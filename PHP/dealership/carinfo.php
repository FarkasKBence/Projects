<?php
    require_once("Storage.php");

    $carStorage = new Storage(new JsonIO('cars.json'), false);
    $userStorage = new Storage(new JsonIO('users.json'), false);

    $reservationStorage = new Storage(new JsonIO('reservations.json'), false);
    $reservations = $reservationStorage->findAll();

    session_start();
    if (isset($_SESSION["profile"])){
        $user = $userStorage->findById($_SESSION["profile"]);
    }

    if (isset($_SESSION['car_id'])){
        $car = $carStorage->findById($_SESSION['car_id']);
    }
    else {
        $_SESSION['car_id'] = $_GET['id'];
        $car = $carStorage->findById($_SESSION['car_id']);
    }
    
    $errors = [];

    if (empty($_GET["date_from"])){$errors[] = "A foglaláshoz adjon meg egy kezdési dátumot.";}
    if (empty($_GET["date_to"])){$errors[] = "A foglaláshoz adjon meg egy befejező dátumot.";}
    if (!empty($_GET["date_to"]) && !empty($_GET["date_from"])){
        if (strcmp($_GET["date_from"],$_GET["date_to"]) > 0){$errors[] = "Ügyeljen arra, hogy a foglalás kronológialag helyes legyen.";}
    }

    function no_reservations($currcar, $cardate, $reservs){
        $reservations_w_conflict = array_filter($reservs, fn($reserv) => $reserv->carid == $currcar->id &&
                                                strcmp($reserv->from,$cardate) <= 0  && strcmp($reserv->to,$cardate) >= 0);
        return count($reservations_w_conflict) == 0;
    }

    function no_reservations_between($currcar, $from, $to, $reservs){
        $reservations_w_conflict = array_filter($reservs, fn($reserv) => $reserv->carid == $currcar->id &&
                                                strcmp($reserv->from,$from) >= 0  && strcmp($reserv->to,$to) <= 0);
        return count($reservations_w_conflict) == 0;
    }
    
    $warning = [];
    if (count($errors) == 0){
        if (no_reservations($car, $_GET["date_from"], $reservations) &&
            no_reservations($car, $_GET["date_to"], $reservations) &&
            no_reservations_between($car, $_GET["date_from"], $_GET["date_to"], $reservations)){ }
        else{
            $warning[] = "Az autó ebben az időben már foglalt.";
        }
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
        <h1><?= $car->brand ?> <?= $car->model ?></h1>
        <div class="showcase">
            <img src=<?= $car->image ?> alt="autó" class="big_img"> <br>
            Üzemanyag: <?= $car->fuel_type ?> <br>
            Gyártási év: <?= $car->year ?> <br>
            Váltó: <?= $car->transmission ?> <br>
            Férőhely: <?= $car->passengers ?> <br>
            Ft/nap <?= $car->daily_price_huf ?>
        </div>
        <div>
            <form novalidate method="GET" action="carinfo.php">
                <div class="input">
                    <input type="date" name="date_from" id="date_from" value="<?php echo isset($_GET['date_from']) ? $_GET['date_from'] : '' ?>">
                    <label for="date_from">-tól</label>
                </div>
                <div class="input">
                    <input type="date" name="date_to" id="date_to" value="<?php echo isset($_GET['date_to']) ? $_GET['date_to'] : '' ?>">
                    <label for="date_to">-ig</label>
                </div>
                <div class="input">
                    <button class="long">Dátum kiválasztása</button>
                </div>
            </form>
            <?php if(count($errors) > 0 or count($warning) > 0): ?>
                <div class="error">
                    <ul>
                        <?php foreach($errors as $error): ?>
                        <li><?= $error ?></li>
                        <?php endforeach; ?>
                        <?php foreach($warning as $msg): ?>
                        <li><?= $msg ?></li>
                        <?php endforeach; ?>
                    </ul>
                </div>
             <?php endif; ?>
            <?php if (!isset($_SESSION["profile"])):?>
            <a href="login.php"><button>Lefoglalom</button></a>
            <?php endif; ?>
            <?php if(isset($_SESSION["profile"]) && count($errors) > 0): ?>
            <a href="reservationfailure.php"><button>Lefoglalom</button></a>
            <?php endif; ?>
            <?php if(isset($_SESSION["profile"]) && count($errors) == 0): ?>
            <a href="reservationadd.php?date_from=<?=$_GET['date_from']?>&date_to=<?=$_GET['date_to']?>"><button>Lefoglalom</button></a>
            <?php endif; ?>
        </div>
    </main>
</body>

</html>