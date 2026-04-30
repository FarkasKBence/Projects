const mapEl = document.querySelector('#gameTable');
const timeOut = document.querySelector('#timeOutput');
const board = document.querySelector('#leaderboard');
const leaderlist = document.querySelector('#leaderlist');
const fromGame = document.querySelector('.fromGame');

fromGame.addEventListener("click", (event) => {
    stop_time();
    timeOut.innerHTML = 0;
})

function start_time() {
    tick = 0;
    interval = setInterval(() => { display_time() }, 1000)
}
function stop_time() {
    clearInterval(interval);
}
function display_time(){
    tick++;
    timeOut.innerHTML = tick;
}

function initMap(map){
    mapEl.innerHTML = '';
    for (let i = 0; i < map.length; i++){
        const rowEl = document.createElement('tr')
        for (let j = 0; j < map.length; j++){
            const cellEl = document.createElement('td');
            cellEl.classList.add(map[i][j][0]);
            cellEl.classList.add(map[i][j][1]);
            rowEl.append(cellEl);
        }
        mapEl.append(rowEl);
    }
    mapEl.classList = "";
    board.style.display = "none";
    start_time();
}

function delegate(parent, type, selector, handler) {
    parent.addEventListener(type, function (event) {
        const targetElement = event.target.closest(selector);
        if (this.contains(targetElement)) {
            handler.call(targetElement, event);
        }
    });
}
delegate(mapEl, 'click', 'td', (e) =>{
    const cellClicked = e.target.closest('td');
    //console.log('e', cellClicked);
    if (!mapEl.classList.contains("disabled")){
        toggle_shape(cellClicked);
        if (validate_map(mapEl)){
            stop_time();
            mapEl.classList.add("disabled");
            leaderboard();
            board.style.display = "block";
        }
    }
})

function leaderboard(){
    leaderlist.innerHTML = '';
    let loc_to_array = [];
    if (mapEl.rows.length === 5){ localStorage.setItem(localStorage.length, [nameInp.value, tick, "easy"]); }
    else{localStorage.setItem(localStorage.length, [nameInp.value, tick, "hard"]);}
    for (let i = 0; i < localStorage.length; i++){
        loc_to_array.push(localStorage.getItem(i).split(","));
    }
    if (mapEl.rows.length === 5){
        loc_to_array.filter((d) => d[2] === "easy").sort((d1,d2) => d2[1] - d1[1]).reverse().forEach(data => {
            console.log(data[0], data[1]);
            const liEl = document.createElement('li');
            liEl.innerHTML = data[0] + ":" + data[1];
            leaderlist.append(liEl);
        });
    }
    else if (mapEl.rows.length === 7){
        loc_to_array.filter((d) => d[2] === "hard").sort((d1,d2) => d2[1] - d1[1]).reverse().forEach(data => {
            console.log(data[0], data[1]);
            const liEl = document.createElement('li');
            liEl.innerHTML = data[0] + ":" + data[1];
            leaderlist.append(liEl);
        });
    }
}

function validate_map(map){
    //megszámoljuk az oázisok számát, és keresünk egy olyan mezőt, amely nem oázis
    let oasisCount = 0; let x = 0; let y = 0;
    for (let i = 0, row; row = map.rows[i]; i++) { 
        for (let j = 0, cell; cell = row.cells[j]; j++) {
            if (cell.classList.contains("oasis")){ oasisCount++; }
            else {y = i; x = j}
        }  
    }
    //összeadjuk az oázisok meg a körvasút-mezők értékét, ha egyenlő a pálya területével csak egy körvasút van
    if (oasisCount + navigate_rail(map, y,x) === map.rows.length * map.rows.length){
        return true;
    }
    return false;
}

function navigate_rail(map, y, x){
    let stepCount = 0; let currX = x; let currY = y; let lastStep = "";
    let currentCell = map.rows[currY].cells[currX];
    let endings = cell_endings(currentCell);
    if (!validate_cell(endings, map, currY,currX)){
        return 0;
    }
    if (endings.includes("up")){ currY--; lastStep = "up"; }
    else if (endings.includes("right")){ currX++; lastStep = "right"; }
    else if (endings.includes("down")){ currY++; lastStep = "down"; }
    else if (endings.includes("left")){ currX--; lastStep = "left"; }
    stepCount++;
    while (currX != x || currY != y){
        currentCell = map.rows[currY].cells[currX];
        endings = cell_endings(currentCell);
        if (!validate_cell(endings, map, currY,currX)){
            return 0;
        }
        if (endings.includes("up") && lastStep != "down"){ currY--;  lastStep = "up"; }
        else if (endings.includes("right") && lastStep != "left"){ currX++; lastStep = "right"; }
        else if (endings.includes("down") && lastStep != "up"){ currY++; lastStep = "down"; }
        else if (endings.includes("left") && lastStep != "right"){ currX--; lastStep = "left"; }
        stepCount++;
    }
    return stepCount;
}

function validate_cell(directions, map, y, x){
    let size = map.rows.length;
    if (!map.rows[y].cells[x].classList.contains("oasis") && map.rows[y].cells[x].innerHTML === ''){
        return false;
    }
    for (let i = 0; i < directions.length; i++){
        switch(directions[i]){
            case "up":
                if (y === 0 || !cell_endings(map.rows[y-1].cells[x]).includes("down")){
                    return false;
                } break;
            case "down":
                if (y === size-1 || !cell_endings(map.rows[y+1].cells[x]).includes("up")){
                    return false;
                } break;
            case "left":
                if (x === 0 || !cell_endings(map.rows[y].cells[x-1]).includes("right")){
                    return false;
                } break;
            case "right":
                if (x === size-1 || !cell_endings(map.rows[y].cells[x+1]).includes("left")){
                    return false;
                } break;
        }
    }
    return true;
}

function cell_endings(cell){   
    switch(cell.innerHTML){
        case '<img src="tiles/straight_rail_o.png">':
            switch(cell.classList[1]) {
                case "rot0": return ["up", "down"];
                case "rot1": return ["left", "right"];
                default: error(cell, "hibás rotation")
            } break;
        case '<img src="tiles/curve_rail_o.png">':
            switch(cell.classList[1]) {
                case "rot0": return ["down", "right"];
                case "rot1": return ["down", "left"];
                case "rot2": return ["up", "left"];
                case "rot3": return ["up", "right"];
                default: error(cell, "hibás rotation")
            } break;
        default: return [];
    }
}

function toggle_shape(cell){
    switch(cell.classList[0]) {
        case "mount":
            switch(cell.innerHTML){
                case '<img src="tiles/curve_rail_o.png">': cell.innerHTML = ''; break;
                default: cell.innerHTML = '<img src="tiles/curve_rail_o.png">';
            } break;
        case "bridge":
            switch(cell.innerHTML){
                case '<img src="tiles/straight_rail_o.png">': cell.innerHTML = ''; break;
                default: cell.innerHTML = '<img src="tiles/straight_rail_o.png">';
            } break;
        case "empty":
            switch(cell.innerHTML){
                case '<img src="tiles/straight_rail_o.png">':
                    switch(cell.classList[1]){
                        case "rot0": cell.classList = "empty rot1"; break;
                        default:
                            cell.classList = "empty rot0";
                            cell.innerHTML = '<img src="tiles/curve_rail_o.png">';
                    } break;
                case '<img src="tiles/curve_rail_o.png">':
                    switch(cell.classList[1]){
                        case "rot0": cell.classList = "empty rot1"; break;
                        case "rot1": cell.classList = "empty rot2"; break;
                        case "rot2": cell.classList = "empty rot3"; break;
                        default:
                            cell.classList = "empty rot0";
                            cell.innerHTML = '';
                    } break;
                default: cell.innerHTML = '<img src="tiles/straight_rail_o.png">';
            }
    }
}