<?php
    require_once("Storage.php");

    $userStorage = new Storage(new JsonIO('users.json'), false);
    $users = $userStorage->findAll();

    session_start();
    if (isset($_SESSION["profile"])){
        $user = $userStorage->findById($_SESSION["profile"]);
    }

    $errors = [];
    /*
    if (preg_match("/(^[A-ZÁÉÍÓÖŐÚÜŰ]{1}[a-záéíóöőúüű]+ )+/", "Kalács Fa")) {
        echo "A match was found.";
    } else {
        echo "A match was not found.";
    }
    */
    if (empty($_GET["name"])){$errors[] = "Kérem adja meg a teljes nevét.";}
    else if (!preg_match("/(^[A-ZÁÉÍÓÖŐÚÜŰ]{1}[a-záéíóöőúüű]+ )+/", $_GET["name"])){$errors[] = "Ügyeljen a nagybetűkre és kerülje a speciális karaktereket.";}
    if (empty($_GET["email"])){$errors[] = "Kérem adja meg az e-mail címét.";}
    else if (!filter_var($_GET['email'], FILTER_VALIDATE_EMAIL)){$errors[] = "E-mail nem megfelelő. Biztos jól írta le?";}
    if (empty($_GET["password"])){$errors[] = "Kérem adjon meg egy biztonságos jelszavat.";}
    else if (empty($_GET["password_again"])){$errors[] = "Kérem ismételje meg a jelszavat.";}
    else if ($_GET["password_again"] != $_GET["password"]){$errors[] = "HIBA: a két jelszó nem egyezik.";}
    //else if (strlen($_GET["password"]) < 6){$errors[] = "password input: túl rövid (legalább 6 legyen)!";}
    //else if (preg_match('/[A-Z]/', $_GET["password"]) == 0){$errors[] = "password input: jelszó tartalmazzon nagybetűket!";}
    //else if (preg_match('/[^a-zA-Z0-9]/', $_GET["password"]) == 0){$errors[] = "password input: jelszó tartalmazzon speciális karaktereket!";}

    if (count($errors) == 0){
        $matchingUser = $userStorage->findOne([
            "email"=>$_GET["email"]
        ]);
        if (empty($matchingUser)){
            $userStorage->add([
                "name" => $_GET["name"],
                "email" => $_GET["email"],
                "password" => $_GET["password"],
                "admin" => false,
            ]);
            header('Location: login.php');
            exit();
        }
        else{
            $errors[] = "HIBA: ez az e-mail már használatban van.";
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
        <h1>Regisztráció</h1>
        <div>
            <form novalidate action="registration.php" method="GET">
                <div class="input">
                    <label for="name">Teljes név:</label>
                    <input type="text" name="name" id="name" value="<?php echo isset($_GET['name']) ? $_GET['name'] : '' ?>">
                </div>
                <div class="input">
                    <label for="email">E-mail:</label>
                    <input type="email" name="email" id="email" value="<?php echo isset($_GET['email']) ? $_GET['email'] : '' ?>">
                </div>
                <div class="input">
                    <label for="password">Jelszó:</label>
                    <input type="password" name="password" id="password">
                </div>
                <div class="input">
                    <label for="password_again">Jelszó mégegyszer:</label>
                    <input type="password" name="password_again" id="password_again">
                </div>
                <div class="input">
                    <button type="submit">Regisztráció</button>
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