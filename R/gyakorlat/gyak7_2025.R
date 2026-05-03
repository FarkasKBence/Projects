
########################
# Nagy számok törvénye #
########################


##############
# Kockadobás #
##############
kocka <- 1:6
n <- 1000   # mintanagyság: dobások száma

dobasok <- sample(kocka, size = n, replace = TRUE)
atlagok <- cumsum(dobasok) / 1:n
plot(atlagok, 
     xlab = "kockadobások száma", 
     ylab = "átlag",
     ylim = c(1,6),
     type = "l",
     main = paste("Szimulált kockadobások átlaga (", n, "dobásig )"))
abline(h = 3.5, col = "blue")


##################################
# Binomiális eloszás: Bin(n1, p) #
##################################
n1 <- 8
p <- 0.3
n <- 1000

x <- rbinom(n, n1, p)
atlagok <- cumsum(x) / 1:n
plot(atlagok,
     xlab = "kísérletek száma", 
     ylab = "átlagok",
     #ylim = c(0, 1),
     type = "l",
     main = paste("Szimulált binomiális ( Bin(",n1,",",p,") ) átlaga"))
abline(h = n1*p, col = "blue")


###################################
# Normális eloszás: ismétlés #
###################################

# Magyarországon 2017 tavaszán a 16 éves és idõsebb népességen belül a férfiak 
# átlagos magassága 176 cm, 9 cm szórással.

# a) Mennyi annak a valószínûsége, hogy egy véletlenszerûen kiválasztott férfi 
# testmagassága 165 és 185 cm közé esik?
########## MEGOLDÁS ##########
pnorm(185, mean = 176, sd = 9) - pnorm(165, mean = 176, sd = 9)
##############################

# b) Mennyi a valószínûsége, hogy egy férfi magasabb 2 méternél?
########## MEGOLDÁS ##########
1 - pnorm(200, mean = 176, sd = 9)
##############################

# c) Hány cm-es testmagasság alatt van a férfiak 90%-a? 
########## MEGOLDÁS ##########
round(qnorm(0.9, mean = 176, sd = 9), 1)
##############################

# d) Mekkora testmagasság felett van a férfiak 80%-a?
########## MEGOLDÁS ##########
round(qnorm(0.2, mean = 176, sd = 9), 1)
##############################



###########################################################
### Gyakorlat 5.7 Feladat ###

# Tegyük fel, hogy egy tábla csokoládé tömege normális eloszlású 100g várható 
# értékkel és 3g szórással. Legalább hány csokoládét csomagoljunk egy dobozba, 
# hogy a dobozban levo táblák átlagos tömege legalább 0,9 valószínûséggel nagyobb
# legyen 99,5 g-nál, ha feltételezzük, hogy az egyes táblák tömege egymástól 
# független? 

# Legyen X = egy tábla csokoládé tömege  ~ N(100, 3^2)

# X_átlag  ~ N(100, (3/sqrt(n))^2) 
# 0,9 = P(X_átlag > 99.5) = 1- P(X_átlag < 99,5) = 1 - P( std. normal < (99,5-100)/(3/sqrt(n) ) = 
# = 1 - Fi(-sqrt(n)/6) = Fi(sqrt(n)/6)) vagyis qnorm(0.9) = sqrt(n)/6

########## MEGOLDÁS ##########

ceiling( (qnorm(0.9)*6)^2 )

##############################













# 8. Feladat

# Egy scannelt kép átlagos mérete 600KB, 100KB szórással. Mi a valószínûsége, 
# hogy 80 ilyen kép együttesen 47 és 48MB közötti tárhelyet foglal el, ha feltételezzük, 
# hogy a képek mérete egymástól független?

# Legyen X = egy szkennelt kép mérete  E_X=600, sigma_X=100.


# Paraméterek
mu_image <- 600  # átlagos képméret (KB)
sigma_image <- 100  # szórás (KB)
n_images <- 80  # képek száma
lower_limit <- 47 * 1024  # 47 MB átváltva KB-ra
upper_limit <- 48 * 1024  # 48 MB átváltva KB-ra

# A teljes képek összesített mérete
mu_total <- mu_image * n_images  # összesített átlagos méret
sigma_total <- sigma_image * sqrt(n_images)  # összesített szórás

# Normális eloszlás valószínűség
probability <- pnorm(upper_limit, mean = mu_total, sd = sigma_total) - pnorm(lower_limit, mean = mu_total, sd = sigma_total)
probability
# Vizualizáció
x_vals <- seq(mu_total - 3*sigma_total, mu_total + 3*sigma_total, length.out = 1000)
y_vals <- dnorm(x_vals, mean = mu_total, sd = sigma_total)
plot(x_vals, y_vals, type = "l", main = "Normális eloszlás a képek összesített méretéhez",
     xlab = "Összesített tárolóhely (KB)", ylab = "Sűrűség")
polygon(c(lower_limit, x_vals[x_vals >= lower_limit & x_vals <= upper_limit], upper_limit),
        c(0, y_vals[x_vals >= lower_limit & x_vals <= upper_limit], 0), col = "lightblue")
text(mu_total, 0.00025, paste("Valószínűség:", round(probability, 4)), pos = 4)



##################################################
#  Másik megoldás
lower_limit <- 47 * 1000  # 47 MB átváltva KB-ra
upper_limit <- 48 * 1000  # 48 MB átváltva KB-ra

# A teljes képek összesített mérete
mu_total <- mu_image * n_images  # összesített átlagos méret
sigma_total <- sigma_image * sqrt(n_images)  # összesített szórás

# Normális eloszlás valószínűség
probability <- pnorm(upper_limit, mean = mu_total, sd = sigma_total) - pnorm(lower_limit, mean = mu_total, sd = sigma_total)
probability
# Vizualizáció
x_vals <- seq(mu_total - 3*sigma_total, mu_total + 3*sigma_total, length.out = 1000)
y_vals <- dnorm(x_vals, mean = mu_total, sd = sigma_total)
plot(x_vals, y_vals, type = "l", main = "Normális eloszlás a képek összesített méretéhez",
     xlab = "Összesített tárolóhely (KB)", ylab = "Sűrűség")
polygon(c(lower_limit, x_vals[x_vals >= lower_limit & x_vals <= upper_limit], upper_limit),
        c(0, y_vals[x_vals >= lower_limit & x_vals <= upper_limit], 0), col = "lightblue")
text(mu_total, 0.00025, paste("Valószínűség:", round(probability, 4)), pos = 4)


########## MEGOLDÁS ##########

nmu <- 80*600
sqrtnszigma <- sqrt(80)*100

#használhatjuk a határeloszlás tételt, az összeg eloszlása közelíthetõ
#normálissal
pnorm(48000, mean = nmu, sd = sqrtnszigma) - pnorm(47000, mean = nmu, sd = sqrtnszigma) 

##################
















# 9. Feladat

# Egy szoftver frissítéséhez 68 file-t kell installálni, amik egymástól függetlenül 
# 10mp várható értékû és 2mp szórású ideig töltõdnek.
# a) Mi a valószínûsége, hogy a teljes frissítés lezajlik 12 percen belül?
# b) A cég a következo frissítésnél azt ígéri, hogy az már 95% valószínûséggel 10
#    percen belül betöltõdik. Hány file-ból állhat ez a frissítés?

# Legyen X = egy fájl telepítési ideje  ~ N(10, 2^2)


########## MEGOLDÁS ##########

# a) P(S_n < 12 perc) = P(S_n < 12*60 mp) = P( std. normal < (720 - n*10)/(sqrt(n)*2) )
# b) 0.95 < P(S_n < 600) = P( std. normal < (600-10n)/(2sqrt(n)) )


# Paraméterek
mu_file <- 10  # egy fájl várható telepítési ideje (mp)
sigma_file <- 2  # egy fájl szórása (mp)
n_files <- 68  # fájlok száma

# a) Mi a valószínűsége, hogy a frissítés 12 percen belül lezajlik?
mu_total_time <- mu_file * n_files  # összesített várható idő
sigma_total_time <- sigma_file * sqrt(n_files)  # összesített szórás

# 12 perc átváltva másodpercre
time_limit <- 12 * 60  # 12 perc (720 másodperc)

# Valószínűség
probability_below_12min <- pnorm(time_limit, mean = mu_total_time, sd = sigma_total_time)
cat("A teljes frissítés 12 percen belüli befejeződésének valószínűsége:", round(probability_below_12min, 4), "\n")

# Vizualizáció
x_vals_time <- seq(mu_total_time - 3*sigma_total_time, mu_total_time + 3*sigma_total_time, length.out = 1000)
y_vals_time <- dnorm(x_vals_time, mean = mu_total_time, sd = sigma_total_time)
plot(x_vals_time, y_vals_time, type = "l", main = "Normális eloszlás a frissítés idejéhez",
     xlab = "Összesített frissítési idő (másodperc)", ylab = "Sűrűség")
polygon(c(0, x_vals_time[x_vals_time <= time_limit], time_limit),
        c(0, y_vals_time[x_vals_time <= time_limit], 0), col = "lightgreen")
text(mu_total_time, 0.01, paste("Valószínűség:", round(probability_below_12min, 4)), pos = 4)

# b) 95% valószínűséggel 10 percen belüli frissítés
target_time <- 10 * 60  # 10 perc (600 másodperc)

# Z-érték meghatározása 95% számára
z_score <- qnorm(0.95)

# Szükséges fájlok száma
n_files_target <- (z_score * sigma_file + mu_file * n_files) / mu_file
cat("A szükséges fájlok száma a 95%-os célhoz:", round(n_files_target), "\n")


#######################################
# Röviden:

nmu <- 680
sqrtnszigma <- sqrt(68)*2

pnorm(720, mean = nmu, sd = sqrtnszigma)

floor( ( ( -2*qnorm(0.95) + sqrt( (2*qnorm(0.95))^2 + 4*10*600 ) ) / (2*10) )^2 )

##############################







#################################
# Nagy számok törvénye, Centrális határeloszlás tétel #
# Több szimuláció
#################################

##############
# Kockadobás #
##############

# 2. CHT alapján n kockadobás átlagának eloszlása:
n <- 500
x1 <- seq(1,6,0.001)
plot(x1,dnorm(x1,mean=3.5,sd=1.707825/sqrt(n)),
     type='l', col="red", lwd=2, ylab="", xlab="",
     main='n kockadobás átlagának eloszlása a CHT alapján')
lines(x1, dnorm(x1,mean=3.5,sd=1.707825/sqrt(20)), type="l", col="green", lwd=2)
lines(x1, dnorm(x1,mean=3.5,sd=1.707825/sqrt(60)), type="l", col="yellow", lwd=2)
lines(x1, dnorm(x1,mean=3.5,sd=1.707825/sqrt(180)), type="l", col="orange", lwd=2)
legend(x='topleft',bty='n',
       legend = c(paste(c("n = 20","n = 60", "n = 180","n = 500"), sep='=')), 
       col = c("green", "yellow", "orange", "red"), lwd = 2 )
#vegyük észre, hogy egyre szukebb intervallumra koncentrálódik
#az átlag, ahogy no az n (ez a NSzT)

# szimuáció:
x <- 1:6
ndobas <- 60   # dobások száma
rep <- 1000    # ismétlések száma

A <- matrix(sample(x, ndobas*rep, replace=T), ncol=ndobas, byrow=TRUE)
xbar<-apply(A,1,mean)   # ndobas átlaga   

head(cbind(A,xbar))
tail(cbind(A,xbar))

hist(xbar, col="blue", freq=F, xlab="", ylab="sûrûség", 
     ylim=range(0,max(hist(xbar)$density, dnorm(x1,mean=3.5,sd=1.707825/sqrt(ndobas)))),
     main = paste(ndobas, "kockadobás átlaga (", rep, "- szer szimulálva )"))
lines(x1, dnorm(x1,mean=3.5,sd=1.707825/sqrt(ndobas)), type="l", col="orange", lwd=2)


par(mfrow=c(2,2)) 
hist(apply(matrix(sample(x, 5*rep, replace=T), ncol=5, byrow=T),1,mean), 
     col="blue", freq=F, xlim=c(1,6), xlab="", ylab="sûrûség",
     main = "5 kockadobás átlaga")
lines(x1, dnorm(x1,mean=3.5,sd=1.707825/sqrt(5)), type="l", col="green", lwd=2)

hist(apply(matrix(sample(x, 10*rep, replace=T), ncol=10, byrow=T),1,mean), 
     col="blue", freq=F, xlim=c(1,6), xlab="", ylab="sûrûség",
     main = "10 kockadobás átlaga")
lines(x1, dnorm(x1,mean=3.5,sd=1.707825/sqrt(10)), type="l", col="yellow", lwd=2)

hist(apply(matrix(sample(x, 30*rep, replace=T), ncol=30, byrow=T),1,mean), 
     col="blue", freq=F, xlim=c(1,6), xlab="", ylab="sûrûség",
     main = "30 kockadobás átlaga")
lines(x1, dnorm(x1,mean=3.5,sd=1.707825/sqrt(30)), type="l", col="orange", lwd=2)

hist(apply(matrix(sample(x, 100*rep, replace=T), ncol=100, byrow=T),1,mean), 
     col="blue", freq=F, xlim=c(1,6), xlab="", ylab="sûrûség",
     main = "100 kockadobás átlaga")
lines(x1, dnorm(x1,mean=3.5,sd=1.707825/sqrt(100)), type="l", col="red", lwd=2)
par(mfrow=c(1,1)) 


##################################
# Binomiális eloszás: Bin(m, p) #
##################################

n <- 100
m <- 10
p <- 0.3
x1 <- seq(0,10,0.001)
plot(x1,dnorm(x1,mean=m*p,sd=sqrt(m*p*(1-p))/sqrt(n)),
     type='l', col="red", lwd=2, ylab="", xlab="",
     main='n Binom(10, 0.3) átlagának eloszlása a CHT alapján')
lines(x1, dnorm(x1,mean=m*p,sd=sqrt(m*p*(1-p))/sqrt(5)), type="l", col="green", lwd=2)
lines(x1, dnorm(x1,mean=m*p,sd=sqrt(m*p*(1-p))/sqrt(10)), type="l", col="yellow", lwd=2)
lines(x1, dnorm(x1,mean=m*p,sd=sqrt(m*p*(1-p))/sqrt(30)), type="l", col="orange", lwd=2)
legend(x='topright',bty='n',
       legend = c(paste(c("n = 5","n = 10", "n = 30","n = 100"), sep='=')), 
       col = c("green", "yellow", "orange", "red"), lwd = 2 )

# szimuáció:
n <- 30
m <- 10
p <- 0.3
rep <- 1000    # ismétlések száma

A <- matrix(rbinom(n*rep,m,p), ncol=n, byrow=TRUE)
xbar<-apply(A,1,mean)   # n db átlaga   

head(cbind(A,xbar))
tail(cbind(A,xbar))

hist(xbar, col="blue", freq=F, xlab="", ylab="sûrûség", 
     main = paste(n, "Binom(10, 0.3) átlaga (", rep, "- szer szimulálva )"))
lines(x1, dnorm(x1,mean=m*p,sd=sqrt(m*p*(1-p))/sqrt(n)), type="l", col="orange", lwd=2)


par(mfrow=c(2,2)) 
hist(apply(matrix(rbinom(n*rep,m,p), ncol=5, byrow=T),1,mean), 
     col="blue", freq=F, xlim=c(1,6), xlab="", ylab="sûrûség",
     main = "5 Binom(10, 0.3) átlaga")
lines(x1, dnorm(x1,mean=m*p,sd=sqrt(m*p*(1-p))/sqrt(5)), type="l", col="green", lwd=2)

hist(apply(matrix(rbinom(n*rep,m,p), ncol=10, byrow=T),1,mean), 
     col="blue", freq=F, xlim=c(1,6), xlab="", ylab="sûrûség",
     main = "10 Binom(10, 0.3) átlaga")
lines(x1, dnorm(x1,mean=m*p,sd=sqrt(m*p*(1-p))/sqrt(10)), type="l", col="yellow", lwd=2)

hist(apply(matrix(rbinom(n*rep,m,p), ncol=30, byrow=T),1,mean), 
     col="blue", freq=F, xlim=c(1,6), xlab="", ylab="sûrûség",
     main = "30 Binom(10, 0.3) átlaga")
lines(x1, dnorm(x1,mean=m*p,sd=sqrt(m*p*(1-p))/sqrt(30)), type="l", col="orange", lwd=2)

hist(apply(matrix(rbinom(n*rep,m,p), ncol=100, byrow=T),1,mean), 
     col="blue", freq=F, xlim=c(1,6), xlab="", ylab="sûrûség",
     main = "100 Binom(10, 0.3) átlaga")
lines(x1, dnorm(x1,mean=m*p,sd=sqrt(m*p*(1-p))/sqrt(100)), type="l", col="red", lwd=2)
par(mfrow=c(1,1)) 

#hisztogram helyett az eloszlásfüggvényeket is 
#nézhetjük (pontosabb)
n=100
p=0.3
m=10
rep=10000
x1 <- seq(1,6,0.001)

#binom
plot(ecdf(apply(matrix(rbinom(n*rep,m,p), ncol=100, byrow=T),1,mean)),pch=20,main = "100 Binom(10, 0.3) átlaga")
lines(x1, pnorm(x1,mean=m*p,sd=sqrt(m*p*(1-p))/sqrt(100)), type="l", col="red", lwd=1.2)

###
#ellenorizzük más, "vastag szélu" eloszlásra is  (pl. exp, t)
##

n=100
rep=1000
x1 <- seq(0,6,0.001)

plot(ecdf(apply(matrix(rexp(n*rep,rate=1), ncol=n, byrow=T),1,mean)),pch=20,main = paste(n, " exp(1) átlaga",sep=""))
lines(x1, pnorm(x1,mean=1,sd=sqrt(1)/sqrt(n)), type="l", col="red", lwd=1.2)

#####
#5.10. feladat, exponenciális eloszlás esete:
####

1-pexp(13,rate=1/3)
