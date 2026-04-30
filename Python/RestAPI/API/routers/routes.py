from schemas.schema import User, Basket, Item
from fastapi.responses import JSONResponse, RedirectResponse
from fastapi import FastAPI, HTTPException, Request, Response, Cookie
from fastapi import APIRouter

from data.filereader import (
    get_user_by_id,
    get_basket_by_user_id,
    get_all_users,
    get_total_price_of_basket
)

from data.filehandler import (
    add_user,
    add_basket,
    add_item_to_basket,
    load_json,
    save_json,
)

'''

Útmutató a fájl használatához:

- Minden route esetén adjuk meg a response_modell értékét (típus)
- Ügyeljünk a típusok megadására
- A függvények visszatérési értéke JSONResponse() legyen
- Minden függvény tartalmazzon hibakezelést, hiba esetén dobjon egy HTTPException-t
- Az adatokat a data.json fájlba kell menteni.
- A HTTP válaszok minden esetben tartalmazzák a 
  megfelelő Státus Code-ot, pl 404 - Not found, vagy 200 - OK

'''

routers = APIRouter()

@routers.post('/adduser', response_model=User)
def adduser(user: User) -> User:
    try:
        add_user(user.model_dump())
        return JSONResponse(content=user.model_dump(), status_code=200)
    except Exception as e:
        raise HTTPException(detail = str(e), status_code=404)
    

@routers.post('/addshoppingbag')
def addshoppingbag(userid: int) -> str:
    try:
        data = load_json()

        basket_userids = [it_basket["user_id"] for it_basket in data["Baskets"]]
        userids = [it_user["id"] for it_user in data["Users"]]

        if userid in basket_userids:
            raise ValueError("Ez a user már rendelkezik kosárral!")
        
        if userid not in userids:
            raise ValueError("Ez a userid nem létezik!")

        basket_ids = [it_basket["id"] for it_basket in data["Baskets"]]
        unique_id = max(basket_ids) + 1

        basket = {
            "id": unique_id,
            "user_id": userid,
            "items": []
        }

        add_basket(basket)
        return JSONResponse(content={"result": "Sikeres kosár hozzárendelés"}, status_code=200)
    except Exception as e:
        raise HTTPException(detail = str(e), status_code=404)

@routers.post('/additem', response_model=Basket)
def additem(userid: int, item: Item) -> Basket:
    try:
        add_item_to_basket(userid, item.model_dump())

        data = load_json()
        baskets = data["Baskets"]

        for basket in baskets:
            if basket["user_id"] == userid:
                return JSONResponse(content=basket, status_code=200)
    except Exception as e:
        raise HTTPException(detail = str(e), status_code=404)
    
@routers.put('/updateitem')
def updateitem(userid: int, itemid: int, updateItem: Item) -> Basket:
    try:
        data = load_json()
        baskets = data["Baskets"]

        update_basket = -1
        update_item = -1
        success = False
        for basket in baskets:
            if basket["user_id"] == userid:
                update_basket = basket
                items = basket["items"]
                for item in items:
                    if item["item_id"] == itemid:
                        success = True
                        update_item = item
        
        if success:
            update_item["name"] = updateItem.name
            update_item["price"] = updateItem.price
            update_item["brand"] = updateItem.brand
            update_item["quantity"] = updateItem.quantity
            save_json(data)
            return JSONResponse(content=update_basket, status_code=200)
        else:
            if update_basket == -1:
                raise Exception("Nincs ilyen user_id-jű kosár!")
            else:
                raise Exception("Nincs ilyen item_id-jű item a kosárban!")
    except Exception as e:
        raise HTTPException(detail = str(e), status_code=404)

@routers.delete('/deleteitem')
def deleteitem(userid: int, itemid: int) -> Basket:
    try:
        data = load_json()
        baskets = data["Baskets"]

        remove_basket = -1
        remove_item = -1
        for basket in baskets:
            if basket["user_id"] == userid:
                items = basket["items"]
                remove_basket = basket
                for item in items:
                    if item["item_id"] == itemid:
                        remove_item = item
                        break
        
        if remove_item != -1:
            remove_basket["items"].remove(remove_item)
            save_json(data)
            return JSONResponse(content=remove_basket, status_code=200)
        else:
            if remove_basket == -1:
                raise Exception("Nincs ilyen user_id-jű kosár!")
            else:
                raise Exception("Nincs ilyen item_id-jű item a kosárban!")
    except Exception as e:
        raise HTTPException(detail = str(e), status_code=404)

@routers.get('/user')
def user(userid: int) -> User:
    try:
        user = get_user_by_id(userid)
        return JSONResponse(content=user, status_code=200)
    except Exception as e:
        raise HTTPException(detail = str(e), status_code=404)

@routers.get('/users')
def users() -> list[User]:
    try:
        users = get_all_users()
        return JSONResponse(content=users, status_code=200)
    except Exception as e:
        raise HTTPException(detail = str(e), status_code=404)

@routers.get('/shoppingbag')
def shoppingbag(userid: int) -> list[Item]:
    try:
        basket = get_basket_by_user_id(userid)
        return JSONResponse(content=basket["items"], status_code=200)
    except Exception as e:
        raise HTTPException(detail = str(e), status_code=404)

@routers.get('/getusertotal')
def getusertotal(userid: int) -> float:
    try:
        sum = get_total_price_of_basket(userid)
        return JSONResponse(content=sum, status_code=200)
    except Exception as e:
        raise HTTPException(detail = str(e), status_code=404)



