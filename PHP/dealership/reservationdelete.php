<?php

include_once 'Storage.php';
$reservationStorage = new Storage(new JsonIO('reservations.json'), false);

if (isset($_GET['id'])) {
    $reservationStorage->delete($_GET['id']);
}

header('Location: profile.php');
exit();
