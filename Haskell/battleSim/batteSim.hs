module BIV5IL_beadando where

import Data.List
import Data.Ord

fuggveny (x:_) = "egy elemu"

{- bemásolandó -}

showState a = show a
showMage a = show a
eqMage a b =  a == b
showUnit a = show a
showOneVOne a = show a

type Name = String
type Health = Integer
type Spell = (Integer -> Integer)
type Army = [Unit]
type EnemyArmy = Army
type Amount = Integer

papi = let 
    tunderpor enemyHP
        | enemyHP < 8 = 0
        | even enemyHP = div (enemyHP * 3) 4
        | otherwise = enemyHP - 3
    in Master "Papi" 126 tunderpor
java = Master "Java" 100 (\x ->  x - (mod x 9))
traktor = Master "Traktor" 20 (\x -> div (x + 10) ((mod x 4) + 1))
jani = Master "Jani" 100 (\x -> x - div x 4)
skver = Master "Skver" 100 (\x -> div (x+4) 2)
average_haskell_hater = Master "GigaChad" 6969 (\x -> x - 999999)
potionMaster = 
  let plx x
        | x > 85  = x - plx (div x 2)
        | x == 60 = 31
        | x >= 51 = 1 + mod x 30
        | otherwise = x - 7 
  in Master "PotionMaster" 170 plx

{- 1. feladat -}

data State hp = Alive hp | Dead deriving (Eq)

instance Show hp => Show (State hp) where
  show (Alive hp) = show hp
  show Dead = "Dead"

data Entity = Golem Health | HaskellElemental Health deriving (Eq, Show)

data Mage = Master String Health Spell

instance Show Mage where
  show (Master nev hp spell)
    | hp < 5 = "Wounded " ++ nev
    | otherwise = nev

instance Eq Mage where
  (Master nev1 hp1 spell1) == (Master nev2 hp2 spell2) = nev1 == nev2 && hp1 == hp2

data Unit = M (State (Mage)) | E (State (Entity)) deriving (Eq{-,Show-})

instance Show Unit where
  show (M (Dead) ) = "Dead"
  show (E (Dead) ) = "Dead"
  show (M (Alive (Master nev hp spell) ) )
    | hp < 5 = "Wounded " ++ nev {-  ++ (show hp)-}       --TESZTELÉS
    | otherwise = nev {-  ++ (show hp) -}                  --TESZTELÉS
  show (E (Alive (Golem hp) ) ) = "Golem " ++ show hp
  show (E (Alive (HaskellElemental hp) ) ) = "HaskellElemental " ++ show hp

{- 2. feladat -}

ezMi :: Unit -> String
ezMi unit = head (words ( show unit ) )

formationFix :: Army -> Army
formationFix army = aliveFix army ++ deadFix army where
  deadFix :: Army -> Army
  deadFix [] = []
  deadFix (x:xs)
    | ezMi x == "Dead" = [x] ++ deadFix xs
    | otherwise = deadFix xs

  aliveFix :: Army -> Army
  aliveFix [] = []
  aliveFix (x:xs)
    | ezMi x /= "Dead" = [x] ++ aliveFix xs
    | otherwise = aliveFix xs

{- 3. feladat -}

over :: Army -> Bool
over [] = True
over (x:xs)
  | ezMi x /= "Dead" = False
  | otherwise = over xs

{- 4. feladat -}

hitIdk :: Spell -> Unit -> Unit  --VAGY HEAL!!!!
hitIdk dmg unit
  | ezMi unit == "Dead" = unit
  | ezMi unit == "Golem" = hitGolem dmg unit
  | ezMi unit == "HaskellElemental" = hitHaskell dmg unit
  | otherwise = hitMage dmg unit

hitGolem :: Spell -> Unit -> Unit
hitGolem dmg (E (Alive (Golem hp)))
  | (($) dmg hp) > 0 = (E (Alive (Golem (($) dmg hp))))
  | otherwise = (E Dead)
hitGolem dmg (E Dead) = (E Dead)

hitHaskell :: Spell -> Unit -> Unit
hitHaskell dmg (E (Alive (HaskellElemental hp)))
  | (($) dmg hp) > 0 = (E (Alive (HaskellElemental (($) dmg hp))))
  | otherwise = (E Dead)
hitHaskell dmg (E Dead) = (E Dead)

hitMage :: Spell -> Unit -> Unit
hitMage dmg (M (Alive (Master nev hp spell)))
  | (($) dmg hp) > 0 = (M (Alive (Master nev (($) dmg hp) spell)))
  | otherwise = (M Dead)
hitMage dmg (M Dead) = (M Dead)

atkMage :: Unit -> Spell
atkMage (M (Alive (Master nev hp spell))) = spell

comboAtk :: Spell -> Army -> Army
comboAtk spell [] = [] 
comboAtk spell army@(x:xs) = [hitIdk spell x] ++ comboAtk spell xs

fight :: EnemyArmy -> Army -> Army
fight _ [] = []
fight [] enyem = enyem
fight (x:xs) (y:ys)
  | ezMi x == "Dead" || ezMi y == "Dead" = [y] ++ fight xs ys
  | ezMi x == "Golem" = [hitIdk (\x -> x - 1) y] ++ fight xs ys
  | ezMi x == "HaskellElemental" = [hitIdk (\x -> x - 3) y] ++ fight xs ys
  | otherwise = [hitIdk (atkMage x) y] ++ fight xs (comboAtk (atkMage x) ys)

{- 5. feladat -}

healthIdk :: Unit -> Health
healthIdk unit
  | ezMi unit == "Dead" = 0
  | ezMi unit == "Golem" = healthGolem unit
  | ezMi unit == "HaskellElemental" = healthHaskell unit
  | otherwise = healthMage unit

healthGolem :: Unit -> Health
healthGolem (E (Alive (Golem hp))) = hp

healthHaskell :: Unit -> Health
healthHaskell (E (Alive (HaskellElemental hp))) = hp

healthMage :: Unit -> Health
healthMage (M (Alive (Master nev hp spell))) = hp

minPazar :: Army -> Int
minPazar army = snd (maximumBy (comparing fst) (reverse ( zip ( pazarOtos army) [0..] ))) where
  pazarOtos army = [ pazar (army !! i) + pazar (army !! (i+1)) + pazar (army !! (i+2)) + pazar (army !! (i+3)) + pazar (army !! (i+4)) | i <-[0..((length army)-5)]] where
    pazar unit
      | ezMi unit == "Dead" = - 5
      | healthIdk unit >= 5 = 0
      | otherwise = healthIdk unit - 5

haskellBlast :: Army -> Army
haskellBlast [] = [] --0 fő
haskellBlast army@(a:b:c:d:e:f:fs) = [(army !! i) | i <- [0..((minPazar army)-1)] ] ++ [hitIdk (\x -> x - 5) (army !! i) | i <- [(minPazar army)..((minPazar army)+4)] ] ++ [(army !! i) | i <- [((minPazar army)+5)..((length army)-1)] ]  --6+ fő
haskellBlast army = [hitIdk (\x -> x - 5) (army !! i) | i <- [0..((length army)-1)] ] --1-től 5-főig

{- 6. feladat -}

healTurnArmy :: Health -> Army -> Army
healTurnArmy hp [] = []
healTurnArmy 0 army = army
healTurnArmy hp army@(x:xs)
  | ezMi x == "Dead" = x : healTurnArmy hp xs
  | otherwise = hitIdk (\x -> x + 1) x : healTurnArmy (hp - 1) xs

healTurnHp :: Health -> Army -> Health
healTurnHp hp [] = hp
healTurnHp 0 army = 0
healTurnHp hp army@(x:xs)
  | ezMi x == "Dead" = healTurnHp hp xs
  | otherwise = healTurnHp (hp - 1) xs

multiHeal :: Health -> Army -> Army
multiHeal hp [] = []
multiHeal hp army@(x:xs)
  | ezMi x == "Dead" = x : multiHeal hp xs
  | hp > 0 = multiHeal (healTurnHp hp army) (healTurnArmy hp army)
  | otherwise = army

{- SZORGALMIKA -}

{- 7. feladat  -}

battle :: Army -> EnemyArmy -> Maybe Army {- vagy EnemyArmy lesz az eredmény. -}
battle enyem enemy
  | over enyem && over enemy = Nothing
  | not (over enyem) && over enemy = Just enyem
  | over enyem && not (over enemy) = Just enemy
  | otherwise = battle (formationFix(harcNekem enyem enemy)) (formationFix(fight enyem enemy))

{- 8. feladat  -}

--halottnál nem csökken az Amount
--akkor állunk meg, ha egy olyanhoz érünk, amelyen már nem tudunk léptetni

healEzt :: Int -> Int -> Amount -> Army -> Army
healEzt _ _ _ [] = []
healEzt itt cél pt army@(x:xs)
  | itt == cél = [hitIdk (\x -> x + pt) x] ++ xs
  | otherwise = [x] ++ healEzt (itt+1) cél pt xs

hitEzt :: Int -> Int -> Amount -> Army -> Army
hitEzt _ _ _ [] = []
hitEzt itt cél pt army@(x:xs)
  | itt == cél = [hitIdk (\x -> x - pt) x] ++ xs
  | otherwise = [x] ++ hitEzt (itt+1) cél pt xs

longerThan :: Army -> Int -> Bool  --6. házi feladatból
longerThan [] i = i <= 0
longerThan (x:xs) i = i < 1 || longerThan xs (i-1)

chainOkos :: Int -> Amount -> (Army, EnemyArmy) -> (Army, EnemyArmy)
chainOkos hinta pt ([],[]) = ([],[])
chainOkos hinta pt (enyem,[])
  | pt <= 0 = (enyem,[])
  | otherwise = (healEzt 0 (div hinta 2) pt enyem, [])
chainOkos hinta pt ([],enemy) = ([],enemy)
chainOkos hinta pt (enyem@(x:xs),enemy@(y:ys))
  | pt <= 0 = (enyem, enemy)
  | rem hinta 2 == 0 && not (longerThan xs (div hinta 2) )      = (enyem, enemy) --not (longerThan enyem (div hinta 2) )   
  | rem hinta 2 == 1 && not (longerThan ys (div hinta 2) )      = (enyem, enemy) --not (longerThan enemy (div hinta 2) )   
  | rem hinta 2 == 0 && ezMi (enyem !! (div hinta 2)) /= "Dead" = chainOkos (hinta + 1) (pt - 1) (healEzt 0 (div hinta 2) pt enyem, enemy)
  | rem hinta 2 == 0                                            = chainOkos (hinta + 1) pt       (healEzt 0 (div hinta 2) pt enyem, enemy)
  | rem hinta 2 == 1 && ezMi (enemy !! (div hinta 2)) /= "Dead" = chainOkos (hinta + 1) (pt - 1) (enyem, hitEzt 0 (div hinta 2) pt enemy)
  | rem hinta 2 == 1                                            = chainOkos (hinta + 1) pt       (enyem, hitEzt 0 (div hinta 2) pt enemy)
  | otherwise = (enyem, enemy)

chain :: Amount -> (Army, EnemyArmy) -> (Army, EnemyArmy)
chain pt tuplika = chainOkos 0 pt tuplika

{- 9. feladat  -}

harcNekem :: Army -> Army -> Army
harcNekem enyem enemy = multiHeal 20(haskellBlast(fight enemy enyem))

battleWithChain :: Army -> EnemyArmy -> Maybe Army {- vagy Maybe EnemyArmy -}
battleWithChain enyem enemy
  | over enyem && over enemy = Nothing
  | not (over enyem) && over enemy = Just enyem
  | over enyem && not (over enemy) = Just enemy
  | otherwise = battleWithChain (formationFix(fst(chain 5 (harcNekem enyem enemy,fight enyem enemy) ))) (formationFix(snd(chain 5 (harcNekem enyem enemy,fight enyem enemy) )))

{- 10. feladat -}

data OneVOne = Winner String | You Health OneVOne | HaskellMage Health OneVOne deriving Eq

instance Show OneVOne where
  show eztszöveggé = "<" ++ showSegély eztszöveggé 

showSegély :: OneVOne -> String
showSegély (Winner nyero) = "|| Winner " ++ nyero ++ " ||>"
showSegély (You hp xs) = "You " ++ (show hp) ++ "; " ++ showSegély xs
showSegély (HaskellMage hp xs) = "HaskellMage " ++ (show hp) ++ "; " ++ showSegély xs

{- 11. feladat -}

finalBattleSegély :: Int -> Health -> Health -> OneVOne
finalBattleSegély hinta mágus én
  | mágus <= 0 = HaskellMage 0 (Winner "You")
  | én <= 0 = You 0 (Winner "HaskellMage")
  | rem hinta 2 == 0 && mágus < 4  = HaskellMage mágus (finalBattleSegély (hinta+1) (mágus*4)         (div én 2))
  | rem hinta 2 == 0 && én > 20    = HaskellMage mágus (finalBattleSegély (hinta+1) (mágus)           (div (én*3) 4))
  | rem hinta 2 == 0               = HaskellMage mágus (finalBattleSegély (hinta+1) (mágus)           (én-11))
  | rem hinta 2 == 1 && én < 4     = You én            (finalBattleSegély (hinta+1) (mágus)           (én*4))
  | rem hinta 2 == 1 && mágus > 15 = You én            (finalBattleSegély (hinta+1) (div (mágus*3) 5) (én))
  | rem hinta 2 == 1               = You én            (finalBattleSegély (hinta+1) (mágus-9)         (én))

finalBattle :: Health -> Health -> OneVOne
finalBattle én mágus = finalBattleSegély 0 mágus én

{- A KÓDTEMETŐ -}

{-
healEzt :: Int -> Int -> Amount -> Army -> Army
healEzt _ _ _ [] = []
healEzt itt cél pt army@(x:xs)
  | itt == cél = [hitIdk (\x -> x + pt) x] ++ xs
  | otherwise = [x] ++ healEzt (itt+1) cél pt xs

hitEzt :: Int -> Int -> Amount -> Army -> Army
hitEzt _ _ _ [] = []
hitEzt itt cél pt army@(x:xs)
  | itt == cél = [hitIdk (\x -> x - pt) x] ++ xs
  | otherwise = [x] ++ hitEzt (itt+1) cél pt xs

chainOkos :: Int -> Amount -> (Army, EnemyArmy) -> (Army, EnemyArmy)
chainOkos hinta pt ([],[]) = ([],[])
chainOkos hinta pt (enyem@(x:xs),enemy@(y:ys))
  | pt == 0 = (enyem, enemy)
  | rem hinta 2 == 0 && (div hinta 2) > ((length enyem) - 1)    = (enyem, enemy)
  | rem hinta 2 == 1 && (div hinta 2) > ((length enemy) - 1)    = (enyem, enemy)
  | rem hinta 2 == 0 && ezMi (enyem !! (div hinta 2)) /= "Dead" = chainOkos (hinta + 1) (pt - 1) (healEzt 0 (div hinta 2) pt enyem, enemy)
  | rem hinta 2 == 0                                            = chainOkos (hinta + 1) pt       (healEzt 0 (div hinta 2) pt enyem, enemy)
  | rem hinta 2 == 1 && ezMi (enemy !! (div hinta 2)) /= "Dead" = chainOkos (hinta + 1) (pt - 1) (enyem, hitEzt 0 (div hinta 2) pt enemy)
  | rem hinta 2 == 1                                            = chainOkos (hinta + 1) pt       (enyem, hitEzt 0 (div hinta 2) pt enemy)
  | otherwise = (enyem, enemy)

chain :: Amount -> (Army, EnemyArmy) -> (Army, EnemyArmy)
chain pt tuplika = chainOkos 0 pt tuplika

multiHealExp :: Health -> Army -> Army
multiHealExp hp army = until (> healTurnHp) (healTurnHp ) hp

multiHealdd :: Health -> Army -> Health
multiHealdd hp army = healTurnHp hp army

nullainator :: a -> Health
nullainator a = 0

healFeltétel :: Health -> (Health -> Health)-> (Health -> Bool) -> [Health] -> [Health]
healFeltétel hp fv con [] = []
healFeltétel hp fv con (x:xs)
 | con x && hp > 0 = ([fv x] ++ healFeltétel (hp-1) fv con xs)
 | otherwise = ([0] ++ healFeltétel hp fv con xs)

healKezdet :: Health -> [Health] -> [Health]
healKezdet hp armyHP@(x:xs) = healFeltétel hp (\x -> 1) (\x -> x > 0) armyHP

--healFeltételR :: Health -> (Health -> Health)-> (Health -> Bool) -> [Health] -> [Health]
--healFeltételR hp fv con [] = []
--healFeltételR hp fv con (x:xs)
-- | con x && hp > 0 = fv x : healFeltételR (hp-1) fv con xs
-- | otherwise = x : healFeltételR hp fv con xs
--
--healRekurz :: Health -> [Health] -> [Health]
--healRekurz 0 hpk@(x:xs) = hpk
--healRekurz hp hpk@(x:xs) = healRekurz (hp - (sum hpk) ) (healFeltételR (hp - (sum hpk) ) (\x -> x + 1) (\x -> x > 0) hpk)

armyToHealth :: Army -> [Health]
armyToHealth army = map (\x -> healthIdk x) army

--healEddig :: Health -> [Health] -> [Health]

butaHeal :: Health -> Army -> Army
butaHeal _ [] = []
butaHeal 0 army@(x:xs) = army
butaHeal hp army@(x:xs) = army


multiHeal :: Health -> Army -> Army
multiHeal hp [] = []
multiHeal hp army@(x:xs)
  | hp < 0 = army
  | ezMi x == "Dead" = [x] ++ multiHeal hp xs
  | otherwise = [hitIdk (\x -> x + head (healEnnyit hp army)) x] ++ multiHeal (hp - head (healEnnyit hp army)) xs


healEnnyit :: Health -> Army -> [Health]
healEnnyit hp army = take (maradek) (repeat (felosztva+1) ) ++ take (hossz-maradek) (repeat felosztva)
  where
    hossz = length (filter (\x -> ezMi x /= "Dead") army)
    felosztva = div hp (fromIntegral hossz)
    maradek = rem (fromIntegral hp) hossz
-}
multiHeal' :: Health -> Army -> Army
multiHeal' hp [] = []
multiHeal' hp army@(x:xs)
  | hp < 0 = army
  | ezMi x == "Dead" = [x] ++ multiHeal' hp xs
  | otherwise = [hitIdk (\x -> x + head (healEnnyit' hp army)) x] ++ multiHeal' (hp - head (healEnnyit' hp army)) xs


healEnnyit' :: Health -> Army -> [Health]
healEnnyit' hp army = take (maradek) (repeat (felosztva+1) ) ++ take (hossz-maradek) (repeat felosztva)
  where
    hossz = length (filter (\x -> ezMi x /= "Dead") army)
    felosztva = div hp (fromIntegral hossz)
    maradek = rem (fromIntegral hp) hossz
	
seged :: [Int] -> [Int]
seged (a : l@(b : c : d : e : fs)) = l