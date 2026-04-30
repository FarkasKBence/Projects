<?php

include_once 'Storage.php';
session_start();

$carStorage = new Storage(new JsonIO('cars.json'), false);
$userStorage = new Storage(new JsonIO('users.json'), false);

$reservationStorage = new Storage(new JsonIO('reservations.json'), false);
$reservations = $reservationStorage->findAll();

$car = $carStorage->findById($_SESSION['car_id']);
$user = $userStorage->findById($_SESSION["profile"]);

$reservationStorage->add([
    "from" => $_GET["date_from"],
    "to" => $_GET["date_to"],
    "email" => $user->email,
    "carid" => $car->id,
]);

header("Location: reservationsuccess.php?date_from=".$_GET['date_from']."&date_to=".$_GET['date_to']);
exit();
