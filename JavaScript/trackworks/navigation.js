const menuDiv = document.querySelector('#menu');
const descDiv = document.querySelector('#desc');
const gameDiv = document.querySelector('#game');
const gameBtn = document.querySelector('#toGame');
const nameInp = document.querySelector('#nameInput');
const smalInp = document.querySelector('#smallInput');
const largInp = document.querySelector('#largeInput');
const nameOut = document.querySelector('#nameOutput');

//setup-olás
if (inputs_incomplete()){gameBtn.classList = "disabled";}
else{gameBtn.classList = "";}

//menűgombok
document.querySelectorAll('#toMenu').forEach((toMenu) => {
    toMenu.addEventListener("click", (event) => {
        menuDiv.style.display = "block"; descDiv.style.display = "none"; gameDiv.style.display = "none";
     })
});

document.querySelectorAll('#toDesc').forEach((toDesc) => {
    toDesc.addEventListener("click", (event) => {
        menuDiv.style.display = "none"; descDiv.style.display = "block"; gameDiv.style.display = "none";
    })
});

gameBtn.addEventListener("click", (event) => {
    if (!gameBtn.classList.contains("disabled")){
        menuDiv.style.display = "none"; descDiv.style.display = "none"; gameDiv.style.display = "block";
        nameOut.innerHTML = nameInp.value;
        if (smalInp.classList.contains("toggled")){
            initMap(easy[Math.floor(Math.random() * easy.length)]);
        }
        else{
            initMap(hard[Math.floor(Math.random() * hard.length)]);
        }
    }
});

nameInp.addEventListener("input", (event) => {
    if (inputs_incomplete()){gameBtn.classList = "disabled";}
    else{gameBtn.classList = "";}
});

smalInp.addEventListener("click", (event) => {
    if (largInp.classList.contains("toggled")){
        largInp.classList.toggle("toggled");
    }
    smalInp.classList.toggle("toggled");
    if (inputs_incomplete()){gameBtn.classList = "disabled";}
    else{gameBtn.classList = "";}
});

largInp.addEventListener("click", (event) => {
    if (smalInp.classList.contains("toggled")){
        smalInp.classList.toggle("toggled");
    }
    largInp.classList.toggle("toggled");
    if (inputs_incomplete()){gameBtn.classList = "disabled";}
    else{gameBtn.classList = "";}
});

function inputs_incomplete(){
    return (nameInp.value === "" || (!largInp.classList.contains("toggled") && !smalInp.classList.contains("toggled")));
}