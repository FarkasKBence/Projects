from pydantic import BaseModel, Field, field_validator
from typing import *
import re
'''

Útmutató a fájl használatához:

Az osztályokat a schema alapján ki kell dolgozni.

A schema.py az adatok küldésére és fogadására készített osztályokat tartalmazza.
Az osztályokban az adatok legyenek validálva.
 - az int adatok nem lehetnek negatívak.
 - az email mező csak e-mail formátumot fogadhat el.
 - Hiba esetén ValuErrort kell dobni, lehetőség szerint ezt a 
   kliens oldalon is jelezni kell.

'''

ShopName='Bolt'

class User(BaseModel):
    id : int
    name : str
    email : str
    
    @field_validator("id")
    def validate_num(num : int) -> int:
        if num < 0:
            raise ValueError("Az adott érték nem lehet nullánál kevesebb!")
        return num

    @field_validator("email")
    def validate_email(email : str) -> str:
        if not re.fullmatch("[A-Za-z0-9\._%+\-]+@[A-Za-z0-9\.\-]+\.[A-Za-z]{2,}", email):
            raise ValueError("Az adott érték legyen email!")
        return email

class Item(BaseModel):
    item_id : int
    name : str
    brand : str
    price : float
    quantity : int
    
    @field_validator("item_id", "quantity")
    def validate_num(num : int) -> int:
        if num < 0:
            raise ValueError("Az adott érték nem lehet nullánál kevesebb!")
        return num

class Basket(BaseModel):
    id : int
    user_id : int
    items : List[Item]
    
    @field_validator("id", "user_id")
    def validate_num(num : int) -> int:
        if num < 0:
            raise ValueError("Az adott érték nem lehet nullánál kevesebb!")
        return num
