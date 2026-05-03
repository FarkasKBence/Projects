##########################################
###   4. gyakorlat gépes példák   ###
##########################################

###########################################
# Nevezetes abszolút folytonos eloszlások #
###########################################
##################################################################################
################## Abszolút folytonos valószínûségi változók #####################
##################################################################################

# Példa: egyenletes eloszlás
# Véletlenszerûen kiválasztunk egy pontot az [a,b] intervallumból.
# Annak a valószínûsége, hogy a kiválasztott pont az E része [a,b] halmazba esik:
# P(E) = E hossza / [a, b] hossza       (ha az E halmaznak van hossza)
# 
# A valószínûségeloszlás jellemezhetõ az f: R -> R, D(f) = R,
# f(x) = 1/(b-a), ha x eleme [a,b] és  
#         0,      ha x nem eleme [a,b]
# függvénnyel úgy, hogy P(E) = integral f (az E halmazon).
#
# Vagyis ha egy véges intervallumra úgy dobunk egy pontot, hogy az intervallum bármely 
# részintervallumára annak hosszával arányos valószínûséggel essen, akkor a pont 
# értéke (x-koordinátája) egyenletes eloszlású valószínûségi változó, 
# sûrûségfüggvénye a fenti f, eloszlásfüggvénye:
# F(x) =  0,          ha x<a
#        (x-a)/(b-a), ha x eleme [a,b] 
#         1,          ha x>b


# Abszolút folytonos valószínûségi változó: 
#
# Ha létezik olyan f(x) függvény, amelyre F(x) = integrál_{-Inf to x} f(t) dt.
# Ilyenkor f(x)-et sûrûségfüggvénynek hívjuk. 



#############################################################################
### Abszolút folytonos valószínûségi változók esetén az eloszlásfüggvény: ###

# p betû + valószínûségi változó neve, pl. pnorm, punif, pt, ...

############################################################################# 

##########################
## Egyenletes eloszlás: ##
## Egyenletes[a,b]      ##
##########################

# Egyenletes[1,6] eloszlásfüggvénye
xegyen <- seq(0, 7, by = 1)
yegyen <- punif(xegyen, min = 1, max = 6)
plot(yegyen, type = "l", lwd=2, col="red", xaxt = "n",
     xlab="x", ylab="F(x)",
     main="Egyenletes[1,6] eloszlásfüggvénye")
axis(1, at=1:8, labels=c(0:7))
abline(h = 0, col = "grey", lty = 2); abline(h = 1, col = "grey", lty = 2)

# Egyenletes[1,6] sûrûségfüggvénye
x <- seq(0,7,length=200)
y <- dunif(x,min=1,max=6)
plot(x,y,
     lwd=2, col="blue",
     ylim=c(0, 0.4),
     ylab="f(x)",
     main="Egyenletes[1,6] sûrûségfüggvénye")

# Egyenletes[1,6] sûrûségfüggvénye (szebb grafika)
x <- seq(1,6,length=200)
y <- dunif(x,min=1,max=6)
plot(x,y, type="l", lwd=2, col="blue",
     xlim=c(0, 7), ylim=c(0, 0.4),
     ylab="f(x)",
     main="Egyenletes[1,6] sûrûségfüggvénye")
xe <- c(seq(0,1,length=100))
ye <- seq(0,0,length=100)
lines(xe,ye,type="l",lwd=2,col="blue")
xe <- c(seq(6,7,length=100))
ye <- seq(0,0,length=100)
lines(xe,ye,type="l",lwd=2,col="blue")

# fv. alatti terület = 1
polygon(c(1,x,6),c(0,y,0),col="lightgray",border=NA)
lines(x,y,type="l",lwd=2,col="blue")

# P(1 < X < 3) = ?
polygon(c(1,x,6),c(0,y,0),col="white",border=NA)
lines(x,y,type="l",lwd=2,col="blue")
xvsz <- seq(1,3,length=100)
yvsz <- dunif(xvsz, min=1, max=6)
polygon(c(1,xvsz,3),c(0,yvsz,0),col="lightgray",border=NA)
lines(xvsz,yvsz,type="l",lwd=2,col="blue")

punif(3,  min=1,max=6)

# P(3 < X < 4.5) = ?
polygon(c(1,xvsz,3),c(0,yvsz,0),col="white",border=NA)
lines(x,y,type="l",lwd=2,col="blue")
xvsz <- seq(3,4.5,length=100)
yvsz <- dunif(xvsz,min=1, max=6)
polygon(c(3,xvsz,4.5),c(0,yvsz,0),col="lightgray",border=NA)
lines(x,y,type="l",lwd=2,col="blue")

punif(4.5,  min=1,max=6) - punif(3, min=1, max=6)


#############################
## Exponenciális eloszlás: ##
## Exp(lambda)             ##
#############################
# lambda>0 paraméterû exponenciális eloszlás
# sûrûségfüggvénye: f(x) = lambda*e^{-lambda*x} ha x > 0 és
#                           0       különben
# pl. radioaktív részecske bomlási ideje, élettarmtam, várakozási idõ
?pexp


##########################
## Normális eloszlás:   ##
## N(mu, szigma)        ##
##########################
# m várható értékû, szigma szórású normális eloszlás
# sûrûségfüggvénye: f(x) = 1/(sqrt(2Pi)*szigma) e^(-(x-mu)^2/2*szigma^2)
# Pl. testmértékek, terméshozam, IQ score
# https://en.wikipedia.org/wiki/Intelligence_quotient
# 0 várható értékû, szigma=1 szórású normális eloszlás = standard normális eloszlás,
# eloszlásfüggvénye Fi(x) = integrál_(-Inf to x) f(x)  nem elemi fv.

# 3.  # set.seed(2)
xseq <- seq(-4,4, 0.01)

# a) Ábrázolja a standard normáls eloszlásfüggvényétgvényét!
# X ~ N(0, 1) eloszlásfüggvénye: Fi(x) = P(X < x) = pnorm(x)

plot(xseq, pnorm(xseq, 0, 1), col="red", type="l",lwd=2,
     xlab="x", ylab="Fi(x)", 
     main="Standard normális eloszlásfüggvénye\n (értéke pl. 1-ben: Fi(1) = P(X < 1) =\n pnorm(1) = 0.8413447)")
abline(h = c(0,1), lty = 2)

abline(v = 1, lty = 3)
abline(h = pnorm(1), lty = 3)



# b) Ábrázolja a standard normáls sûrûségfüggvényét!

suruseg <- dnorm(xseq, 0,1)
plot(xseq, suruseg, type="l",lwd=2, col="blue", # cex.axis=0.8,
     xlab="x", ylab="f(x)",  
     main="Standard normális sûrûségfüggvénye")

# c) Normális(mu, szigma) eloszlás sûrûségfüggvénye

x <- seq(-6,6,1/1000)
dnorm <- dnorm(x)

plot(x, dnorm, type="l", col="green", lwd=2, ylab='', xlab='', 
     main = "Normális eloszlás sûrûségfüggvénye")
legend(x='topleft', bty='n', 
       legend = c("N(0,1)", "N(2,1)", "N(0,2)", "N(0,3)"),
       col = c("green","yellow", "blue","red"), lwd = 2 )

lines(x, dnorm, type="l", col="black", lty=2)

dn2 <- dnorm(x, mean = 2, sd = 1)
lines(x, dn2, type="l", col="yellow", lwd=2)

dn3 <- dnorm(x, mean = 0, sd = 2)
lines(x, dn3, type="l", col="blue", lwd=2)

dn4 <- dnorm(x, mean = 0, sd = 3)
lines(x, dn4,type="l", col="red", lwd=2)


# d) Szinumláljon adatokat standard normális eloszlásból, majd ábrázolja hisztogrammal.
# Rajzolja fel a standard normális sûrûségfüggvényt is az ábrára!

szim <- rnorm(10000, 0, 1)
hist(szim, freq=FALSE,
     xlab=" ", 
     ylab="sûrûség", 
     main="Standard normális szimuláció")
curve(dnorm(x, 0, 1), add=TRUE, col="blue", lwd=2)
# curve(dnorm(x, mean(szim), sd(szim)), add=TRUE, col="darkblue", lwd=2)


##

## Egyenletes eloszlás / Egyenletes[a, b] /

x <- seq(1,6,length=200)
y <- dunif(x,min=1,max=6)
plot(x,y, type="l", lwd=2, col="blue",
     xlim=c(0, 7), ylim=c(0, 0.4),
     ylab="f(x)",
     main="Egyenletes[1,6] sûrûségfüggvénye")
xe <- c(seq(0,1,length=100))
ye <- seq(0,0,length=100)
lines(xe,ye,type="l",lwd=2,col="blue")
xe <- c(seq(6,7,length=100))
ye <- seq(0,0,length=100)
lines(xe,ye,type="l",lwd=2,col="blue")

polygon(c(1,x,6),c(0,y,0),col="white",border=NA)
lines(x,y,type="l",lwd=2,col="blue")
xvsz <- seq(1,3,length=100)
yvsz <- dunif(xvsz, min=1, max=6)
polygon(c(1,xvsz,3),c(0,yvsz,0),col="lightgray",border=NA)
lines(xvsz,yvsz,type="l",lwd=2,col="blue")


## Stadard normális eloszlás / N(0, 1) /

xseq <- seq(-4,4, 0.01)
plot(xseq, dnorm(xseq, 0,1), 
     type = "l",
     lwd = 2, 
     col = "blue", 
     #cex.axis = 0.8,
     xlab = "x", 
     ylab = "f(x)",  
     main = "Standard normális sûrûségfüggvénye")
text(-2.5, 0.3, expression(f(x) == 
                             paste(frac(1, sqrt(2*pi)*sigma)," ",e^{frac(-(x - mu)^2, 2 * sigma^2)})), 
     cex = 1.2)
# curve(dnorm, from=-4, to=4, n=41000, main="Standard normális sûrûségfüggvénye")


## Normális eloszlás / N(m, szigma) /

x <- seq(-6,6,1/1000)

plot(x, dnorm(x), type="l", col="yellow", lwd=2, ylab='', xlab='', 
     main = "Normális eloszlás sûrûségfüggvénye")
lines(x, dnorm(x), type="l", col="black", lty=2)    # N(m = 0, szigma = 1)

dn2 <- dnorm(x, mean = 2, sd = 1)
lines(x, dn2, type="l", col="purple", lwd=2)     # N(m = 2, szigma = 1)

dn3 <- dnorm(x, mean = 0, sd = 2)
lines(x, dn3, type="l", col="blue", lwd=2)       # N(m = 0, szigma = 2)

dn4 <- dnorm(x, mean = 0, sd = 3)
lines(x, dn4,type="l", col="red", lwd=2)         # N(m = 0, szigma = 3)

legend(x='topleft',bty='n',
       legend = c(paste( 
         c("N(0, 1)","N(2, 1)", "N(0, 2^2)","N(0, 3^2)"), sep='=')), 
       col = c("yellow", "purple", "blue", "red"), lwd = 2 )


## Normális valószínûségi változó standardizálása
# X ~ N(m, szigma)  =>  (X - m)/szigma ~ N(0, 1)
x <- rnorm(1000, mean = 5, sd = 3)
hist(x, freq=FALSE)
curve(dnorm(x, 5, 3), add=TRUE, col="blue", lwd=2)

nx <- ( x - 5 ) / 3
hist(nx, freq=FALSE)
curve(dnorm(x, 0, 1), add=TRUE, col="blue", lwd=2)

# Példa:
# X ~ N(3,2^2)
# P(X < 4) = P(X-3 < 4-3) = P((x-3)/2 < (4-3)/2)
pnorm(4, mean = 3, sd = 2) == pnorm(1/2)

# 1. Feladat:  Legyen X ~ N(7, 3^2) valószínûségi változó.  Számolja ki 
# P(X > 8) - at standardizálással is!

1 - pnorm(8, mean = 7, sd = 3)
# vagy   
pnorm(8, mean = 7, sd = 3, lower.tail = FALSE)

1 - pnorm((8-7)/3)
# vagy   
pnorm((8-7)/3, lower.tail = FALSE)


## Függvény alatti terület: 
x <- seq(-4, 4,length=200)
y <- dnorm(x, mean=0, sd=1)
plot(x,y,type="l",lwd=3,col="black", 
     main = "Standard normális")
x <- seq(-4, -1, length=100)
y <- dnorm(x, mean=0, sd=1)
polygon(c(-4, x, -1),c(0,y,0),col="red")


## t eloszlás / t_n / 

x <- seq(-6,6,1/1000)

dt4 <- dt(x, 30)
plot(x, dt4, type="l", col="yellow", lwd=2, ylab='', xlab='', 
     main = "t eloszlás sûrûségfüggvénye")

dt1 <- dt(x, 0.5)
lines(x, dt1, type="l", col="cyan", lwd=2)

dt2 <- dt(x, 1.5)
lines(x, dt2, type="l", col="purple", lwd=2)

dt3 <- dt(x, 5)
lines(x, dt3, type="l", col="red", lwd=2)

dnorm <- dnorm(x)
lines(x, dnorm ,type="l", col="black", lty=2)

legend(x='topleft',bty='n',
       legend = c(paste('sz.f.',
                        c(0.5, 1.5, 5, 30), sep='=')), 
       col = c("cyan", "purple", "red", "yellow"), lwd = 2 )

legend(x='topright',bty='n',
       legend = c(paste('N(0,1)', sep='=')), 
       col = c("black"), lwd = 2, lty = 3)


## Exponenciális / Exp(lambda) / eloszlás

x <- seq(0, 1, 1/1000)

dt1 <-  dexp(x, rate = 2.5)
plot(x, dt1, type="l", col="red", lwd=2, ylab='', xlab='', 
     main = "Exponenciális eloszlás sûrûségfüggvénye")

dt2 <-  dexp(x, rate = 2)
lines(x, dt2, type="l", col="purple", lwd=2)

dt3 <-  dexp(x, rate = 1)
lines(x, dt3, type="l", col="blue", lwd=2)

de4 <- dexp(x, rate = 1/2)
lines(x, de4, type="l", col="orange", lwd=2)

legend(x='topright',bty='n',
       legend = c(paste('lambda', c(2.5, 2, 1, 1/2),sep='=')), 
       col = c("red", "purple", "blue", "orange"), lwd = 2 )


## Khí-négyzet / Chi-square(df) / eloszlás 

x <- seq(0, 15, 1/1000)

dchisq1 <-  dchisq(x, df = 2)
plot(x, dchisq1, type="l", col="red", lwd=2, ylab='', xlab='', 
     main = "Khí-négyzet eloszlás sûrûségfüggvénye")

dchisq2 <-  dchisq(x, df = 3)
lines(x, dchisq2, type="l", col="purple", lwd=2)

dchisq3 <-  dchisq(x, df = 4)
lines(x, dchisq3, type="l", col="blue", lwd=2)

dchisq4 <-  dchisq(x, df = 5)
lines(x, dchisq4, type="l", col="orange", lwd=2)

legend(x='topright',bty='n',
       legend = c(paste('df', c(2, 3, 4, 5),sep='=')), 
       col = c("red", "purple", "blue", "orange"), lwd = 2 )


## F / F(df1,df2) / eloszlás 

x <- seq(0, 5, 1/1000)

df1 <-  df(x, df1 = 2, df2=1)
plot(x, df1, type="l", col="red", lwd=2, ylab='', xlab='', 
     main = "F eloszlás sûrûségfüggvénye")

df2 <-  df(x, df1 = 5, df2=2)
lines(x, df2, type="l", col="purple", lwd=2)

df3 <-  df(x, df1 = 5, df2=5)
lines(x, df3, type="l", col="blue", lwd=2)

df4 <-  df(x, df1 = 20, df2=20)
lines(x, df4, type="l", col="orange", lwd=2)

legend(x='topright',bty='n',
       legend = c(paste('df1, df2', c("2, 1", "5, 2", "5, 5", "20, 20"),sep=' = ')), 
       col = c("red", "purple", "blue", "orange"), lwd = 2 )



## Nevezetes abszolút folytonos eloszlásfüggvények

par(mfrow=c(2,2))
x_sample <- seq(-3.2, 3.2, 0.001)

plot(x_sample, pnorm(x_sample), 
     type="l", col="red", lwd=2, main="Eloszlásfüggvény: N(0,1)", ylab='', xlab='')
plot(x_sample, pt(x_sample, 5),
     type="l", col="red", lwd=2, main="t_5", ylab='', xlab='')
plot(x_sample, pexp(x_sample, 5),
     type="l", col="red", lwd=2, main="Exp(5)", ylab='', xlab='')
plot(x_sample, punif(x_sample, -2,2),
     type="l", col="red", lwd=2, main="Egyenletes[-2,2]", ylab='', xlab='')
par(mfrow=c(1,1))


## Nevezetes abszolút folytonos sûrûségfüggvények

par(mfrow=c(2,2))
x_sample <- seq(-3.2, 3.2, 0.001)

plot(x_sample, dnorm(x_sample), 
     type="l", col="blue", lwd=2, main="Sûrûségfüggvény: N(0,1)", ylab='', xlab='')

plot(x_sample, dt(x_sample, 5),
     type="l", col="blue", lwd=2, main="t_5", ylab='', xlab='')

x_sample <- c(seq(0.01,1.5, 0.001))
plot(x_sample, dexp(x_sample, 5), xlim=c(-0.5, 1.5),
     type="l", col="blue", lwd=2, main="Exp(5)", ylab='', xlab='')
xe <- c(seq(-3,0,length=100))
ye <- seq(0,0,length=100)
lines(xe,ye,type="l",lwd=2,col="blue")

x <- seq(1,6,length=200)
y <- dunif(x,min=1,max=6)
plot(x,y, type="l", lwd=2, col="blue", main="Egyenletes[1,6]",
     xlim=c(0, 7), ylim=c(0, 0.4), ylab='', xlab='')
xe <- c(seq(0,1,length=100))
ye <- seq(0,0,length=100)
lines(xe,ye,type="l",lwd=2,col="blue")
xe <- c(seq(6,7,length=100))
ye <- seq(0,0,length=100)
lines(xe,ye,type="l",lwd=2,col="blue")
par(mfrow=c(1,1))


# 2. Feladat: Mit rajzol ki az alábbi program? Mutassa meg, hogy az alábbi függvény sûrûségfüggvény!
# Mit jelöl a besatírozott terület? Számolja ki és ábrázolja az eloszlásfüggvényt!

x <- seq(0, 2, 1/100);  y <- 1/4*(2-x)^3 

xa <- seq(-1, 0, 1/100);  ya <- rep(0,length(xa))
xb <- seq( 2, 3, 1/100);  yb <- rep(0,length(xb))

plot(x, y, type="l", col="black", lwd=3, ylab='', xlab='', xlim=c(-0.5,2.5), xaxt = "n", main = " ")
axis(1, cex.axis = 1.5)
lines(xb, yb, type="l", col="black", lwd=3)
lines(xa, ya, type="l", col="black", lwd=3)
abline(h = 0, lty = 2)
x1 <- seq(0, 0.5, 1/100)
y1 <- 1/4*(2-x1)^3
polygon(c(0,x1,0.5),c(0,y1,0),col="yellow")


########## MEGOLDÁS ##########

# sûrûségfv: nemnegatív és integrál_{0-tól 3-ig} 1/4*(2-x)^3 = 1
# besatírozott terület: P(0 < X < 0.5)
# eloszlásfv: 0, ha x<=0; 
#             integrál_{0-tól x-ig}  1/4*(2-x)^3 = 1-(2-x)^4/16, ha 0<x<=2
#             1, ha x>2

x <- seq(0, 2, 1/100);  y <- 1-(2-x)^4/16 

xa <- seq(-1, 0, 1/100);  ya <- rep(0,length(xa))
xb <- seq( 2, 3, 1/100);  yb <- rep(1,length(xb))

plot(x, y, type="l", col="black", lwd=3, ylab='', xlab='', xlim=c(-0.5,2.5), xaxt = "n", main = " ")
axis(1, cex.axis = 1.5)
lines(xb, yb, type="l", col="black", lwd=3)
lines(xa, ya, type="l", col="black", lwd=3)
abline(h = 0, lty = 2)

x<- 0.5
y <- 1-(2-x)^4/16
y # a keresett vszg
##############################



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
# Normális eloszás: N(mu, szigma) #
###################################
mu <- 46
szigma <- 2
n <- 1000

x <- rnorm(n, mu, szigma)
atlagok <- cumsum(x) / 1:n
plot(atlagok,
     xlab = "kísérletek száma", 
     ylab = "átlagok",
     #ylim = c(mu-2*szigma, mu+2*szigma),
     type = "l",
     main = paste("Szimulált normális ( N(",mu,",",szigma,"^2) ) átlaga"))
abline(h = mu, col = "blue")

# plot(x, pch = ".")
# points(1:n, atlagok, type = "l", col = "red")

#
#3.13. feladat
pexp(4000,rate=1/6000)
1-pexp(6500,rate=1/6000)

