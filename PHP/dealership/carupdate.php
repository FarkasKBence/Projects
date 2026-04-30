<?php

require_once("Storage.php");

$carStorage = new Storage(new JsonIO('cars.json'), false);

session_start();
if (isset($_SESSION['car_id'])){
    $car = $carStorage->findById($_SESSION['car_id']);
}
else {
    $_SESSION['car_id'] = $_GET['id'];
    $car = $carStorage->findById($_SESSION['car_id']);
}

#echo "  \n  ";
#echo $_SESSION['car_id'];
#echo "  \n  ";

$errors = [];

if (empty($_GET["brand"])){$errors[] = "Márka input: üres";}
else if (strlen($_GET["brand"]) < 4 || strlen($_GET["brand"]) > 25){$errors[] = "Márka input: szöveghossz-hiba";}
else if (preg_match('/[^a-zA-Z -]/', $_GET["brand"]) > 0){$errors[] = "Márka input: furcsakarakter-hiba";}
else if ($_GET["brand"] != ucfirst($_GET["brand"])){$errors[] = "Márka input: tulajdonnév";}
if (empty($_GET["model"])){$errors[] = "Modell input: üres";}
else if (strlen($_GET["model"]) < 3 || strlen($_GET["model"]) > 25){$errors[] = "Modell input: szöveghossz-hiba";}
else if (preg_match('/[^a-zA-Z0-9 -]/', $_GET["model"]) > 0){$errors[] = "Modell input: furcsakarakter-hiba";} //már lehet benne szám
else if ($_GET["model"] != ucfirst($_GET["model"])){$errors[] = "Modell input: tulajdonnév";}
if (empty($_GET["year"])){$errors[] = "Gyártási év input: üres";}
else if (!(is_numeric($_GET["year"]) && $_GET["year"] == round($_GET["year"], 0))){$errors[] = "Gyártási év input: invalid szám";}
else if ($_GET["year"] > date("Y") || $_GET["year"] < 1886){$errors[] = "Gyártási év input: törtélnemileg invalid év";} //Benz Patent-Motorwagen
if (empty($_GET["transmission"])){$errors[] = "Váltó-típus input: üres";}
else if ($_GET["transmission"] != "Manuális" && $_GET["transmission"] != "Automata"){$errors[] = "Váltó-típus input: invalid érték";}
if (empty($_GET["fuel_type"])){$errors[] = "Üzemanyag-típus input: üres";}
else if ($_GET["fuel_type"] != "Benzin" && $_GET["fuel_type"] != "Dízel" && $_GET["fuel_type"] != "Elektromos" && $_GET["fuel_type"] != "Egyéb"){$errors[] = "Üzemanyag-típus input: invalid érték";}
if (empty($_GET["passengers"])){$errors[] = "Utas input: üres";}
else if (!(is_numeric($_GET["passengers"]) && $_GET["passengers"] == round($_GET["passengers"], 0))){$errors[] = "Utas input: nem egész szám";}
else if ($_GET["passengers"] < 1 || $_GET["passengers"] > 20){$errors[] = "Utas input: érték hiba";}
if (empty($_GET["daily_price_huf"])){$errors[] = "Napi ár input: üres";}
else if (!(is_numeric($_GET["daily_price_huf"]) && $_GET["daily_price_huf"] == round($_GET["daily_price_huf"], 0))){$errors[] = "Napi ár input: nem egész szám";}
else if ($_GET["daily_price_huf"] < 5000){$errors[] = "Napi ár input: érték hiba";}
if (empty($_GET["image"])){$errors[] = "Kép fájl input: üres";}
//else if (!@exif_imagetype($_GET["image"])){$errors[] = "image input: invalid resource ";}
//else if (!file_exists($_GET["image"])){$errors[] = "image input: invalid resource ";}
//else if (@getimagesize($_GET["image"]) == false){$errors[] = "image input: resource nem kép";}

if (count($errors) == 0){
    #echo " SIKERES SZERKESZTÉS ";
    $car->brand = $_GET["brand"];
    $car->model = $_GET["model"];
    $car->year = $_GET["year"];
    $car->transmission = $_GET["transmission"];
    $car->fuel_type = $_GET["fuel_type"];
    $car->passengers = $_GET["passengers"];
    $car->daily_price_huf = $_GET["daily_price_huf"];
    $car->image = $_GET["image"];
    #echo $_SESSION['car_id'];
    $carStorage->update( $_SESSION['car_id'], $car );
    unset($_SESSION['car_id']);
    header('Location: index.php');
    exit();
}

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
    <h1>ADMIN: autó szerkestése:</h1>
        <div>
            <form novalidate action="carupdate.php" method="GET">
                <div class="input">
                <label for="brand">Márka:</label>
                    <input type="text" name="brand" id="brand" value="<?php echo isset($car->brand) ? $car->brand : '' ?>">
                </div>
                <div class="input">
                <label for="model">Modell:</label>
                    <input type="text" name="model" id="model" value="<?php echo isset($car->model) ? $car->model : '' ?>">
                </div>
                <div class="input">
                <label for="year">Gyártási év:</label>
                    <input type="number" name="year" id="year" min="0" value="<?php echo isset($car->year) ? $car->year : '' ?>">
                </div>
                <div class="input">
                <label for="passengers">Férőhely:</label>
                    <input type="number" name="passengers" id="passengers" min="0" value="<?php echo isset($car->passengers) ? $car->passengers : '' ?>">
                </div> <br>
                <div class="input">
                    <label for="transmission">Váltó típusa:</label>
                    <select name="transmission" id="transmission">
                        <option value="Automata" <?php if (isset($car->transmission) && $car->transmission =="Automata") echo "selected";?> >Automata</option>
                        <option value="Manuális" <?php if (isset($car->transmission) && $car->transmission =="Manuális") echo "selected";?> >Manuális</option>
                    </select>
                </div>
                <div class="input">
                    <label for="fuel_type">Üzemanyag:</label>
                    <select name="fuel_type" id="fuel_type">
                        <option value="Dízel" <?php if (isset($car->fuel_type) && $car->fuel_type =="Dízel") echo "selected";?> >Dízel</option>
                        <option value="Benzin" <?php if (isset($car->fuel_type) && $car->fuel_type =="Benzin") echo "selected";?> >Benzin</option>
                        <option value="Elektromos" <?php if (isset($car->fuel_type) && $car->fuel_type =="Elektromos") echo "selected";?> >Elektromos</option>
                        <option value="Egyéb" <?php if (isset($car->fuel_type) && $car->fuel_type =="Egyéb") echo "selected";?> >Egyéb</option>
                    </select>
                </div>
                <div class="input">
                    <label for="daily_price_huf">Napi ár:</label>
                    <input type="number" name="daily_price_huf" id="daily_price_huf" min="0" step="500" value="<?php echo isset($car->daily_price_huf) ? $car->daily_price_huf : '' ?>">
                </div>
                <div class="input">
                    <label for="image">Kép fájl:</label>
                    <input type="url" name="image" id="image" min="0" step="500" value="<?php echo isset($car->image) ? $car->image : '' ?>">
                </div>
                <div class="input">
                    <button type="submit">Szerkeszt</button>
                </div>
            </form>
            <?php if(count($errors) > 0): ?>
                <div class="error">
                    <ul>
                        <?php foreach($errors as $error): ?>
                        <li><?= $error ?></li>
                        <?php endforeach; ?>
                    </ul>
                </div>
             <?php endif; ?>
        </div>
    </main>
</body>

</html>