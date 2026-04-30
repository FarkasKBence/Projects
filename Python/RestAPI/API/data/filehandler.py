import json
from typing import Dict, Any

'''
Útmutató a fájl függvényeinek a használatához

Új felhasználó hozzáadása:

new_user = {
    "id": 4,  # Egyedi felhasználó azonosító
    "name": "Szilvás Szabolcs",
    "email": "szabolcs@plumworld.com"
}

Felhasználó hozzáadása a JSON fájlhoz:

add_user(new_user)

Hozzáadunk egy új kosarat egy meglévő felhasználóhoz:

new_basket = {
    "id": 104,  # Egyedi kosár azonosító
    "user_id": 2,  # Az a felhasználó, akihez a kosár tartozik
    "items": []  # Kezdetben üres kosár
}

add_basket(new_basket)

Új termék hozzáadása egy felhasználó kosarához:

user_id = 2
new_item = {
    "item_id": 205,
    "name": "Szilva",
    "brand": "Stanley",
    "price": 7.99,
    "quantity": 3
}

Termék hozzáadása a kosárhoz:

add_item_to_basket(user_id, new_item)

Hogyan használd a fájlt?

Importáld a függvényeket a filehandler.py modulból:

from filehandler import (
    add_user,
    add_basket,
    add_item_to_basket,
)

 - Hiba esetén ValuErrort kell dobni, lehetőség szerint ezt a 
   kliens oldalon is jelezni kell.
'''

class NotFoundException(Exception):
    pass

class NotUniqueException(Exception):
    pass

# A JSON fájl elérési útja
JSON_FILE_PATH = "./data/data.json"

def load_json() -> Dict[str, Any]:
    try:
        with open(JSON_FILE_PATH, "r", encoding="utf-8") as file:
            data = json.load(file)
            return data
    except Exception as ex:
        raise Exception("Hiba történt a fájlbeolvasásnál!")

def save_json(data: Dict[str, Any]) -> None:
    try:
        with open(JSON_FILE_PATH, "w", encoding="utf-8") as file:
            json.dump(data, file, indent=4)
    except Exception:
        raise Exception("Hiba történt a fájlírásnál!")

def add_user(user: Dict[str, Any]) -> None:
    try:
        data = load_json()
        user_ids = [it_user["id"] for it_user in data["Users"]]

        if user["id"] in user_ids:
            raise NotUniqueException("Ez az id már foglalt!")
        
        data["Users"].append(user)
        save_json(data)
    except Exception as ex:
        raise Exception(str(ex))

def add_basket(basket: Dict[str, Any]) -> None:
    try:
        data = load_json()
        basket_ids = [it_basket["id"] for it_basket in data["Baskets"]]

        if basket["id"] in basket_ids:
            raise NotUniqueException("Ez az id már foglalt!")

        data["Baskets"].append(basket)
        save_json(data)
    except Exception as ex:
        raise Exception(str(ex))

def add_item_to_basket(user_id: int, item: Dict[str, Any]) -> None:
    try:
        data = load_json()
        baskets = data["Baskets"]

        for basket in baskets:
            if basket["user_id"] == user_id:
                item_ids = [it_item["item_id"] for it_item in basket["items"]]
                
                if item["item_id"] in item_ids:
                    raise NotUniqueException("Ez az item_id már foglalt!")
                
                basket["items"].append(item)
                save_json(data)
                return
        raise NotFoundException("Nincs ilyen id-jű kosár!")
    except Exception as ex:
        raise Exception(ex)