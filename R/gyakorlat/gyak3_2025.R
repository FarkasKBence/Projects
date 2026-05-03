##########################################
###   2. gyakorlat gépes példák   ###
##########################################


## KÍSÉRLET 1 ##

# Dobjunk fel egy szabályos érmét egymás után sokszor, és jegyezzük fel 
# a kapott fej-írás sorozatot. Például az F I I F I F F F . . . sorozatot 
# kaphatjuk. Ha n dobásból k fejet kapunk, akkor k-t a fej dobások 
# gyakoriságának, míg k/n-et a fej dobások relatív gyakoriságának nevezzük. 
# A fenti példában a relatív gyakoriságok sorozata: 
# 1/1 , 1/2 , 1/3 , 2/4 , 2/5 , 3/6 , 4/7 , 5/8 , . . . 
# Az így kapott sorozat nem "szabályos" sorozat, a hagyományos matematikai 
# értelemben (egyelore) nem állíthatjuk róla, hogy konvergens. Csupán annyi 
# látható, hogy "szabálytalan", "véletlen ingadozásokat" mutató sorozat, és 
# a kísérlet újabb végrehajtásakor egy másik "szabálytalan" sorozat jön ki. 
# Csupán annyit remélhetünk, hogy k/n valamilyen értelemben 1/2 körül 
# ingadozik (lévén az érme szabályos). A ténylegesen elvégzett kísérletek ezt 
# igazolják is (pl. Buffon 4040 dobásból 2048-szor kapott fejet (0,5069 relatív 
# gyakoriság), míg Pearson 24000 dobásból 0,5005 relatív gyakoriságot kapott). 
# (Fazekas: Valószínuségszámítás és statisztika)
# Figyelje meg az alábbi számítógépen szimulált 100 hosszúságú dobássorozat 
# lefolyását: 

ndobas <- 1000  # érmedobások száma

erme <- c('F', 'I')   # érmedobás szimuláció
dobasok <- sample(erme, size = ndobas, replace = TRUE)   #, prob=c(1, 1))

freqs <- table(dobasok)   # fejek és írások gyakorisága n dobás esetén
freqs

fejgyak <- cumsum(dobasok == 'F') / 1:ndobas  # fejek és írások  gyakorisága minden n-re

plot(fejgyak,
     type = 'l', lwd = 2, col = 'red',  
     ylim = c(0, 1),
     ylab = "fej dobások relativ gyakorisága",
     xlab = "dobások",
     main = paste(ndobas, "szabályos érme feldobása"))
abline(h = 1/2, col = 'blue')




##################################################################################
######################## Diszkrét valószínuségi változók #########################
##################################################################################


##########################
## Binomiális eloszlás: ##
## Binom(n, p)          ##
## értékei: 0,1,2,...,n ##
##########################

# Négy egyforma érmét feldobva a megfigyelheto kimenetelek: 
# 4 fej,   3 fej és 1 írás,   2 fej és 2 írás,   1 fej és 3 írás,   4 írás
# Ezek valószínusege a 16-elemu eseménytéren kombinatorikus valószínuséggel 
# számolva (az érméket képzeletben megkülönböztetve) könnyen kiszámolható:
# P(4F) = 1/16 = 0,0625
# P(3F és 1I) = 4/16= 0,25
# P(2F és 2I) = 6/16 = 0,375
# P(1F és 3I) = 4/16 = 0,25
# P(4I)=1/16 = 0,0625

dbinom(0:4, size=4, prob=0.5)
dbinom(0:6, size=6, prob=0.5)


## Bernoulli kísérlet ##

# Tfh. a vizsgált kísérletnek 2 lehetséges kimenetele van (pl. F és I),
# bekövetkezésük valószínusége p ill. 1-p. 
# Ezt a kísérletet (érmedobás) egymástól függetlenül n-szer végrehajtjuk. Ha csak F gyakoriságát 
# figyeljük (jelölje ezt X), akkor (n+1)-féle eredményt kaphatunk, amelynek valószínusége
# P(X = k) = (n alatt k) p^k (1-p)^(n-k), ahol k=0,1,...,n
# => kaptunk egy (n+1)-elemu eseményteret a fenti eloszlással: binomiális eloszlás

## Példa: n = 5, p = 0,3

# P(X = k) = ?, k = 0,1,2,3,4,5
dbinom(0, size=5, prob=0.3)     # ezek összege = 1
dbinom(1, size=5, prob=0.3)
dbinom(2, size=5, prob=0.3)
dbinom(3, size=5, prob=0.3)
dbinom(4, size=5, prob=0.3)
dbinom(5, size=5, prob=0.3)

dbinom(0:5, 5, 0.3)

plot(0:5, dbinom(0:5, 5, 0.3), 
     type = "h", col = 2, lwd = 3,
     xlab = "Érték", 
     ylab = "Valószínuség", 
     main = paste("Binomiális eloszlás (n = 5, p = 0,3)"))
  abline(h = 0, col = 3)

barplot(dbinom(0:5, 5, 0.3), 
        col="red",
        xlab = "Érték", 
        ylab = "Valószínuség", 
        main="Binomiális eloszlás (n = 5, p = 0,3)",
        names.arg = 0:5)

# P(2 < X < 5) = P(3 <= X <= 4) = ?
sum(dbinom(3:4, 5, 0.3))

# P(X <= k) = ?, k = 0,1,2,3,4,5
pbinom(0, size=5, prob=0.3)   # = dbinom(0, size=5, prob=0.3)
pbinom(1, size=5, prob=0.3)   # = dbinom(0, size=5, prob=0.3) + dbinom(1, size=5, prob=0.3)
pbinom(2, size=5, prob=0.3)   
pbinom(3, size=5, prob=0.3)   
pbinom(4, size=5, prob=0.3)   
pbinom(5, size=5, prob=0.3)   # = 1

pbinom(0:5, 5, 0.3)
#2.2 feladat
1-pbinom(3.5,10,0.2)

plot(0:5, pbinom(0:5, 5, 0.3), 
     type = "s", col = 2, lwd = 3,
     xlab = "Érték", ylim = c(0, 1),
     ylab = "Kumulált valószínuség", 
     main = paste("Binomiális eloszlás (n = 5, p = 0,3)"))
  lines(0:5, pbinom(0:5, 5, 0.3), type = "h", col = 2, lwd = 3)
  abline(h = 0, col = 3)

barplot(pbinom(0:5, 5, 0.3), 
        col="red",
        xlab = "Érték",
        ylab = "Kumulált valószínuség", 
        main="Binomiális eloszlás (n = 5, p = 0,3)",
        names.arg = 0:5)

# Generáljunk binomiális (n = 5, p = 0,3) eloszlásból 10 értéket:
rbinom(10, 5, 0.3)

# Példa: n, p
n = 200
p = 0.3
barplot(dbinom(0:n, n, p), 
        col="red",
        xlab = "Érték", 
        ylab = "Valószínuség", 
        main= paste("Binomiális eloszlás ( n = ", n,", p =", p, ")"),
        names.arg = 0:n)
  abline(h = 0, col = 3)


## Speciális eset: n = 1
##########################
## Indikátor eloszlás:  ##
##########################
# bináris események jellemzésére 
# ksíérlet: érmedobás, fejek ill. írások valószínusége
# P(X = 1) = p, P(X = 0) = 1 - p 


##########################
## Poisson eloszlás:    ##
## Poisson(lambda)      ##
## értékei: 0,1,2,...   ##
##########################
lambda = 2.5
vmeddig = 10

# P(X = k) = ?, k = 0,1.... (most csak vmeddig)
barplot(dpois(0:vmeddig,lambda),
        col="blue",
        xlab="érték",
        ylab="Valószínuség",
        main="Poisson eloszlás",
        names.arg=0:vmeddig)

#######################################
## Binomiális közelítése Poissonnal: ##
## (ha n elég nagy)                  ##
#######################################
vmeddig = 10
lambda = 2
n = 100
p = lambda/n

vszbin = dbinom(0:vmeddig, n, p)
vszpoi = dpois(0:vmeddig, lambda)

egyutt = rbind(vszbin[1:(vmeddig+1)],vszpoi)
rownames(egyutt)=c("Binomiális","Poisson")

barplot(egyutt, 
        col = c("red","blue"),
        xlab = "Érték",
        ylab = "Valószínuség",
        main = "Binomiális vs Poisson eloszlás",
        legend = rownames(egyutt), 
        beside = TRUE,
        names.arg = 0:vmeddig)

###############################
## Hipergeometriai eloszlás: ##
## Hipergeometriai(M, N, n)  ##
## értékei: 0,1,2,....,n     ##
###############################
N = 30
M = 25
n = 10

dhyper(0:n, M, N-M, n)

barplot(dhyper(0:n, M, N-M, n),
        col = "green",
        xlab = "érték",
        ylab = "Valószínuség",
        main = "Hipergeometriai eloszlás",
        names.arg = 0:n)

#készítsünk az elozo ábrához hasonlót, ahol a binomiálist
#és a hipergeometriait hasonlítjuk össze
n=10
N=1000
M=200
vmeddig = 5*n
p = M/N

vszbin = dbinom(0:vmeddig, 5*n, p)
vszhip = dhyper((0:(5*n)), M, N-M, 5*n)

egyutt = rbind(vszbin[1:(vmeddig+1)],vszhip)
rownames(egyutt)=c("Binomiális","Hip.geo")

barplot(egyutt, 
        col = c("red","blue"),
        xlab = "Érték",
        ylab = "Valószínuség",
        main = "Binomiális vs hip.geom eloszlás",
    #    legend("topleft", col=c("red","blue"),rownames(egyutt)), 
        beside = TRUE,
        names.arg = 0:vmeddig)

##################################################################################
################################### FELADATOK ####################################
##################################################################################


1. ### 2.2 Feladat ###

# Tegyük fel, hogy az új internet-elofizetok véletlenszeruen választott 20%-a 
# speciális kedvezményt kap. Mi a valószínusége, hogy 10 ismerosünk közül, 
# akik most fizettek elo, legalább négyen részesülnek a kedvezményben?

n = 10
p = 0.2

# X ~ Binom(n = 10, p = 0.20), P( X >= 4 ) = ?


########## MEGOLDÁS ##########
sum(dbinom(4:n, n, p))

# vagy

1-pbinom(3.5, n, p)
##############################



# 3.5. feladat 
# Egy bükkösben a bükkmagoncok négyzetméterenkénti száma Poisson-eloszlású, 
# lambda = 2,5 db / m^2 paraméterrel.
# Mi a valószínusége annak, hogy egy 1 m^2-es mintában
# a) legfeljebb egy ill.
# b) több, mint három magoncot találunk?

# X ~ Poisson(lambda=2.5)
lambda = 2.5

# a)

########## MEGOLDÁS ##########
sum(dpois(0:1, lambda))

# vagy

ppois(1, lambda)
ppois(1.5, lambda)
##############################

# b)

########## MEGOLDÁS ##########
1 - sum(dpois(0:3, lambda))

# vagy

1 - ppois(3.5, lambda)
##############################


