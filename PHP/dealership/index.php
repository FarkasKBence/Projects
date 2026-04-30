<?php
    require_once("Storage.php");

    $carStorage = new Storage(new JsonIO('cars.json'), false);
    $cars = $carStorage->findAll();

    $reservationStorage = new Storage(new JsonIO('reservations.json'), false);
    $reservations = $reservationStorage->findAll();

    $userStorage = new Storage(new JsonIO('users.json'), false);

    session_start();
    if (isset($_SESSION["car_id"])){
        unset($_SESSION["car_id"]);
    }

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
        <h1>Kölcsönözz autókat könnyedén!</h1>
        <div>
            <form novalidate method="POST">
                <div class="input">
                <label for="passengers">Férőhely:</label>
                    <input type="number" name="passengers" id="passengers" size="2" min="0" value="<?php echo isset($_POST['passengers']) ? $_POST['passengers'] : '' ?>">
                </div>
                <div class="input">
                    <label for="transmission">Váltó:</label>
                    <select name="transmission" id="transmission">
                        <option value="" <?php if (isset($_POST["transmission"]) && $_POST["transmission"] =="") echo "selected";?> >-</option>
                        <option value="Automata" <?php if (isset($_POST["transmission"]) && $_POST["transmission"] =="Automata") echo "selected";?> >Automata</option>
                        <option value="Manuális" <?php if (isset($_POST["transmission"]) && $_POST["transmission"] =="Manuális") echo "selected";?> >Manuális</option>
                    </select>
                </div>
                <div class="input">
                    <label for="date_from">Idő:</label>
                    <input type="date" name="date_from" id="date_from" value="<?php echo isset($_POST['date_from']) ? $_POST['date_from'] : '' ?>">
                    <label for="date_from">-tól</label>
                    <input type="date" name="date_to" id="date_to" value="<?php echo isset($_POST['date_to']) ? $_POST['date_to'] : '' ?>">
                    <label for="date_to">-ig</label>
                </div>
                <div class="input">
                    <label for="cost_from">Keret:</label>
                    <input type="number" name="cost_from" id="cost_from" size="6" min="0" step="500" value="<?php echo isset($_POST['cost_from']) ? $_POST['cost_from'] : '' ?>">
                    <label for="cost_to"> - </label>
                    <input type="number" name="cost_to" id="cost_to" size="6" min="0" step="500" value="<?php echo isset($_POST['cost_to']) ? $_POST['cost_to'] : '' ?>">
                    <label for="cost_to">Ft</label>
                </div>
                <div class="input">
                    <button type="submit">Szűrés</button>
                </div>
            </form>
        </div>
        <div class="showcase_holder">
            <?php

            function no_reservations($currcar, $cardate, $reservs){
                $reservations_w_conflict = array_filter($reservs, fn($reserv) => $reserv->carid == $currcar->id &&
                                                        strcmp($reserv->from,$cardate) <= 0  && strcmp($reserv->to,$cardate) >= 0);
                                                        #ha van egy foglalás, ami a kezdés előtt indul és utána zárul
                                                        #  foglalás eleje   én foglalásom     foglalás vége
                                                        # -------------X------------|---------------X--------------------------
                return count($reservations_w_conflict) == 0;
            }

            function no_reservations_between($currcar, $from, $to, $reservs){
                $reservations_w_conflict = array_filter($reservs, fn($reserv) => $reserv->carid == $currcar->id &&
                                                        strcmp($reserv->from,$from) >= 0  && strcmp($reserv->to,$to) <= 0);
                                                        #ha van egy foglalás, ami a kezdés után indul ls a végzés előtt zárul
                                                        #       enyém        másé                másé              enyém
                                                        # -------|------------X---------------------X----------------|---------
                return count($reservations_w_conflict) == 0;
            }

            if (!empty($_POST['passengers'])){
                #echo "van seat";
                $cars = array_filter($cars, fn($car) => $_POST['passengers'] <= $car->passengers);
            }
            if (!empty($_POST['date_from'])){
                #echo "van date_from";
                $cars = array_filter($cars, fn($car) => no_reservations($car, $_POST['date_from'], $reservations));
            }
            if (!empty($_POST['date_to'])){
                echo "van date_to";
                $cars = array_filter($cars, fn($car) => no_reservations($car, $_POST['date_to'], $reservations));
            }
            if (!empty($_POST['date_from']) && !empty($_POST['date_to'])){
                #echo "van date_to és date_from";
                $cars = array_filter($cars, fn($car) => no_reservations_between($car, $_POST['date_from'], $_POST['date_to'], $reservations));
            }
            if (!empty($_POST['transmission'])){
                #echo "van transmission";
                $cars = array_filter($cars, fn($car) => $_POST['transmission'] == $car->transmission);
            }
            if (!empty($_POST['cost_from'])){
                #echo "van cost_from";
                $cars = array_filter($cars, fn($car) => $_POST['cost_from'] <= $car->daily_price_huf);
            }
            if (!empty($_POST['cost_to'])){
                #echo "van cost_to";
                $cars = array_filter($cars, fn($car) => $_POST['cost_to'] >= $car->daily_price_huf);
            }
            ?>
            <?php foreach ($cars as $car): ?>
                <div class="showcase">
                    <a href="carinfo.php?id=<?= $car->id ?>"><img src=<?= $car->image ?> alt="autó" class="small_img"></a><br>
                    <?= $car->daily_price_huf ?>Ft <br>
                    <?= $car->brand ?> <?= $car->model ?> <br>
                    <?= $car->passengers ?> férőhely - <?= $car->transmission ?> <br>
                    <a href="carinfo.php?id=<?= $car->id ?>"><button>Foglalás</button></a>
                    <?php if (isset($_SESSION["profile"])):?>
                    <?php if ($user->admin):?>
                    <a href="carupdate.php?id=<?= $car->id ?>"><button class="long admin">ADMIN: szerkeszt</button></a>
                    <a href="cardelete.php?id=<?= $car->id ?>"><button class="admin">ADMIN: töröl</button><br></a>
                    <?php endif; ?>
                    <?php endif; ?>
                </div>
            <?php endforeach; ?>
        </div>
    </main>
</body>

</html>