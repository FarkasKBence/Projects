<?php

include_once 'Storage.php';
$carStorage = new Storage(new JsonIO('cars.json'), false);

$reservationStorage = new Storage(new JsonIO('reservations.json'), false);
$reservations = $reservationStorage->findAll();

if (isset($_GET['id'])) {
    $carStorage->delete($_GET['id']);
}

foreach ($reservations as $reservation){
    if ($reservation->carid == $_GET['id']){
        $reservationStorage->delete($reservation->id);
    }
}

header('Location: index.php');
exit();
