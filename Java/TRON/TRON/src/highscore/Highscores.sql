/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/SQLTemplate.sql to edit this template
 */
/**
 * Author:  fbenc
 * Created: 2024. dec. 7.
 */

create database Highscores;
create table Highscores.highscores (
/*timestamp timestamp,*/
name varchar(255),
score int
);