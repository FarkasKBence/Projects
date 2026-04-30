<?php

session_start();
if (isset($_SESSION['profile'])) {
    unset($_SESSION['profile']);
}

header('Location: index.php');
exit();
