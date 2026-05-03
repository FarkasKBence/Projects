##########################################
###          Utolsó gyakorlat          ###
##########################################


#############################################
# Hipotézisvizsgálat:                       # 
# nemparaméteres próbák: khí-négyzet próbák #
#############################################

########################
# Illeszkedésvizsgálat #
########################

### gyakorlat 1. Feladat ###

# Egy gyárban egy termék minõségét 4 elemû mintákat véve ellenõrzik, havonta 
# 300 mintavétellel. Megszámolták, hogy a legutóbbi hónapban hányszor volt 
# selejtes a minta, melynek eredményét az alábbi táblázat tartalmazza:
#   Selejtesek száma:   0   1  2  3 4
#   Darabszám:         80 113 77 27 3

selejt <- c(0, 1, 2, 3, 4)
darab <- c(80, 113, 77, 27, 3)

### Modellezhetõ a mintákban levõ selejtesek száma
### (a) (4; 0,25) paraméterû binomiális eloszlással?

# Tiszta illeszkedésvizsgálat

# H_0: X_i ~ Bin(4; 0,25)         <=> H_0: P(X_i = x_j) = p_j  j = 1,...,5
# H_1: X_i nem ilyen eloszlású        H_1: létezik legalább egy j melyre P(X_i = x_j) nem= p_j

# Határozzuk meg az egyes selejtes termékekre 
# vonatkozó valószínûségeket (elméleti valószínûségek: p_j), 
# illetve ezek alapján gyakoriságokat:

p <- dbinom(selejt, size = 4, p = 0.25); p

# feltételek ellenõrzése:
  n <- sum(darab)
  n
  n*p
  sum(n*p)
  # de nem kell külön ellenõrizni a feltételt, ha nem teljesül, akkor a 
  # chisq utasítás kiír egy "Warning message"-et
  ell <- chisq.test(darab, p = p)
  ell$expected    # elméleti gyakoriság 

# utolsó két oszlopot össze kell vonni:
darabv <- c(darab[1:3], sum(darab[4:5]))
pv <- c(p[1:3], sum(p[4:5]))
pv
n*pv


chisq.test(darabv, p = pv)

# Döntés: Elutasítjuk H0-t, azaz mondhatjuk, hogy a selejtes termékek
# száma nem Bin(4; 0,25) eloszlást követ.


  # ki lehet számolni így is:
  np <- sum(darabv)*pv
  r <- length(darabv)
  probastat <- sum( (darabv - np)^2 / np )
  kritertek <- qchisq(0.95, r- 1 )
  pertek <- 1-pchisq(probastat, r - 1 )
  
  cat('\nPróbastatisztika:', probastat,
      '\nKritikus érték', kritertek,
      '\np-érték:', pertek,
      '\nDöntés:', "Elutasítjuk H0-t, azaz mondhatjuk, hogy a selejtes termékek
  száma nem Bin(4; 0,25) eloszlást követ.")

  
### Modellezhetõ a mintákban levõ selejtesek száma
### (b) (4; p) paraméterû binomiális eloszlással (valamilyen p-re)?

### Becsléses illeszkedésvizsgálat

# H_0: X_i ~ Bin(4; p) vlamilyen p-re
# H_1: X_i nem ilyen eloszlású

# Elõször meg kell becsülni az ismeretlen p paramétert ML-módszerrel. 
# (Egy paramétert becslünk, így s = 1.) 
# A korábbi gyakorlat feladata alapján tudjuk, hogy Bin(m; p) 
# eloszlású minta esetén (m ismert) a p ML-becslése p_kalap = X_átlag/m. 

m <- 4
phat <- ( sum(selejt*darab) / sum(darab) ) / m; phat
s <- 1 # 1 paramétert becslünk

p <- dbinom(selejt, size = 4, p = phat); p

  # feltételek ellenõrzése:
  n <- sum(darab)
  n*p

# utolsó két oszlopot össze kell vonni:
darabv <- c(darab[1:3], sum(darab[4:5]))
pv <- c(p[1:3], sum(p[4:5]))
pv
n*pv


# chisq.test(darabv, p = pv) # szabadsági fok - 1 kell a becslés miatt
np <- sum(darabv)*pv
r <- length(darabv)
probastat <- sum( (darabv - np)^2 / np )
kritertek <- qchisq(0.95, r - s - 1 )
pertek <- 1-pchisq(probastat, r - s - 1 )

cat('\nPróbastatisztika:', probastat,
    '\nKritikus érték', kritertek,
    '\np-érték:', pertek,
    '\nDöntés: Nem utasítjuk el H0-t, tehát lehet a selejtes termékek 
               száma Bin(4; p) eloszlású.')



#########################
# Függetlenségvizsgálat #
#########################

### gyakorlat 2 Feladat ###

# Az alábbi kontingencia-táblázat mutatja, hogy egy 100 éves idõszakban egy adott 
# napon a csapadék mennyisége és az átlaghõmérséklet hogyan alakult:
#       Csapadék  kevés átlagos sok
# Hõmérséklet
#       hüvös        15      10   5
#     átlagos        10      10  20
#       meleg         5      20   5
# A cellákban az egyes esetek gyakoriságai találhatóak. alpha = 0,05 mellett 
# tekinthetõ-e a csapadékmennyiség és a hõmérséklet függetlennek?

# H_0: a csapadék és a hõmérséklet függetlenek
# H_1: nem függetlenek

ido <- matrix(c(15, 10, 5, 10, 10, 20, 5, 20, 5), ncol=3, byrow=TRUE)
colnames(ido) <- c("kevés", "átlagos", "sok")
rownames(ido) <- c("hüvös", "átlagos", "meleg")
ido <- as.table(ido)
ido

chisq.test(ido)

# Döntés: Elutasítjuk H_0-t, a hõmérséklet és csapadék nem függetlenek.


########################
# Homogenitásvizsgálat #
########################

### gyakorlat 3. Feladat ###

# Két dobókockával dobva az alábbi gyakoriságokat figyeltük meg:
#   Dobások 1  2  3  4  5  6
# 1. kocka 27 24 26 23 18 32
# 2. kocka 18 12 15 21 14 20
# Alpha = 0,05 mellett döntsünk arról, hogy tekinthetõ-e a két eloszlás azonosnak!

# H_0 a két eloszlás megegyezik
# H_1 a két eloszlás nem egyezik meg

kocka <- matrix(c(27, 24, 26, 23, 18, 32, 18, 12, 15, 21, 14, 20), 
                ncol=6, byrow=TRUE)
colnames(kocka) <- rep(1:6)
rownames(kocka) <- c("1. kocka", "2. kocka")
kocka <- as.table(kocka)
kocka

chisq.test(kocka)

# Döntés: nem utasítjuk el / elfogadjuk H_0-t, a két eloszlás azonosnak tekinthetõ



## További feladatok:

#  1.  A MASS csomag "survey" adatain ellenõrizzük, hogy a dohányzás és az
# edzés összefügg-e!

library(MASS)
# https://stat.ethz.ch/R-manual/R-devel/library/MASS/html/survey.html 
str(survey)

# Smoke: how much the student smokes. ("Heavy", "Regul", "Occas", "Never".)
# Exer: how often the student exercises. ("Freq", "Some", "None".)

# H_0: a dohányzás és a edzés függetlenek
# H_1: nem függetlenek

tbl <- table(survey$Smoke, survey$Exer); tbl 

############# MEGOLDÁS #############
proba <- chisq.test(tbl)  # u.az: chisq.test(survey$Smoke, survey$Exer)
proba$expected
#össze kell vonni két oszlopot
ctbl <- cbind(tbl[,"Freq"], tbl[,"None"] + tbl[,"Some"])
colnames(ctbl) <- c("Freq", "None+Some")
ctbl
chisq.test(ctbl) #nem utasítjuk el H0-t, akár független is lehet a két tulajdonság

###################################

# 2.  Az elozo feladatban szereplõ adatsoron teszteljünk más összefüggéseket is!

# W.Hnd: writing hand of student. ("Left" and "Right".)
# Clap: 'Clap your hands! Which hand is on top?' ("Right", "Left", "Neither".)

tbl2 <- table(survey$W.Hnd, survey$Clap)
tbl2
#tbl2[1,2]=7
#tbl2
proba2 <- chisq.test(tbl2)
proba2$expected

ctbl2 <-  cbind(tbl2[,"Left"] + tbl2[,"Neither"], tbl2[,"Right"])
colnames(ctbl2) <- c("Left", "Neither+Right")
ctbl2
proba2 <- chisq.test(ctbl2)
proba2$expected
proba2
#vagy:
ctbl3 <-  cbind(tbl2[,"Right"] + tbl2[,"Neither"], tbl2[,"Left"])
colnames(ctbl3) <- c("Right", "Neither+Left")
ctbl3
proba3 <- chisq.test(ctbl3)
proba3$expected
proba3 #szerencsére mindkét eset azt adja, hogy nem fogadható el a függetlenség,
#van kapcsolat a két tulajdonság között


# Clap: 'Clap your hands! Which hand is on top?' ("Right", "Left", "Neither".)
# Exer: how often the student exercises. ("Freq", "Some", "None".)

############# MEGOLDÁS #############
tbl3 <- table(survey$Clap, survey$Exer)
tbl3
proba3 <- chisq.test(tbl3)
proba3
proba3$expected

ctbl3 <- cbind(tbl3[,"Freq"], tbl3[,"None"] + tbl3[,"Some"]); ctbl3
proba3 <- chisq.test(ctbl3); proba3
###################################

# W.Hnd: writing hand of student. ("Left" and "Right".)
# Exer: how often the student exercises. ("Freq", "Some", "None".)

############# MEGOLDÁS #############
tbl4 <- table(survey$W.Hnd, survey$Exer)
tbl4
chisq.test(tbl4)

survey$Pulse2="alacsony"
survey$Pulse2[survey$Pulse>64]="közepes"
survey$Pulse2[survey$Pulse>79]="magas"
tbl5 = table(survey$Clap, survey$Pulse2)
tbl5
chisq.test(tbl5)

survey$Pulse2="alacsony"
survey$Pulse2[survey$Pulse>64]="közepes"
survey$Pulse2[survey$Pulse>79]="magas"
tbl5 = table(survey$Exer, survey$Pulse2)
tbl5
chisq.test(tbl5)
####################################

################################################################################
### Csak érdekesség, nem kell a gyakorlatra:

# University of California, Berkeley 1973. hallgatók felvétele nem szerint 
# az egyetem hat legnagyobb tanszékére
# https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/UCBAdmissions.html

require(graphics)
## Data aggregated over departments
UCBA2 <- apply(UCBAdmissions, c(1, 2), sum); UCBA2
mosaicplot(apply(UCBAdmissions, c(1, 2), sum),
           main = "Student admissions at UC Berkeley")
chisq.test(UCBA2)

## Data for individual departments
opar <- par(mfrow = c(2, 3), oma = c(0, 0, 2, 0))
for(i in 1:6)
  mosaicplot(UCBAdmissions[,,i],
             xlab = "Admit", ylab = "Sex",
             main = paste("Department", LETTERS[i]))
mtext(expression(bold("Student admissions at UC Berkeley")),
      outer = TRUE, cex = 1.5)
par(opar)
chisq.test(UCBAdmissions[,,Dept= "A"])
chisq.test(UCBAdmissions[,,Dept= "B"])
chisq.test(UCBAdmissions[,,Dept= "C"])
chisq.test(UCBAdmissions[,,Dept= "D"])
chisq.test(UCBAdmissions[,,Dept= "E"])
chisq.test(UCBAdmissions[,,Dept= "F"])
################################################################################

