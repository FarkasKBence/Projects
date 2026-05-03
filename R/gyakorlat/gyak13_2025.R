##########################################
###            Regressziók             ###
##########################################

################
## Korreláció ##
################

# változók közötti lineáris kapcsolat erõsségét mérõ mennyiség

# built-in datasets
# https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/00Index.html

## cars
str(cars)
par(mfrow = c(1, 1))
plot(cars$dist, cars$speed) #
cor(cars$dist, cars$speed) #
plot(cars$speed,cars$dist, xlab="sebesség (mérföld/óra)",
     ylab="fékút (láb)",main="Cars")


## mtcars
str(mtcars)
#részletek:
#https://cran.r-project.org/web/packages/explore/vignettes/explore-mtcars.html
#válasszunk párokat, ábrázoljuk és becsüljük meg a korrelációt
#csak utána számoljuk ki
plot(mtcars$mpg, mtcars$cyl)

cor(mtcars$mpg, mtcars$cyl)

plot(mtcars$mpg, mtcars$qsec)

cor(mtcars$mpg, mtcars$qsec)


library(ggplot2)
qplot(x = hp, y = mpg, data = mtcars)  +  geom_smooth(method = "lm", se = FALSE) +
   ggtitle("Negatív korreláció")

cor(mtcars$hp, mtcars$mpg)


########################
# Lineáris regresszió: #
########################

#  1. Feladat 

# Legyenek adottak a következõ (x,y) párok:
# xi 0 1 6 5 3
# yi 4 3 0 1 2
# (a) Határozza meg és ábrázolja is az a + bx alakú regessziós egyenest!
# (b) Számolja ki a reziduálisokat és becsülje meg a hiba szórásnégyzetét!
# (c) Adjon elorejelzést x = 2-re a regressziós egyenes alapján!

x <- c(0, 1, 6, 5, 3)
y <- c(4, 3, 0, 1, 2)

plot(x,y)
cor(x,y)    # sum( (x-mean(x))*(y-mean(y)) ) / ( (length(x)-1)*sd(x)*sd(y) )

reg <- lm(y ~ x)
plot(x, y)
lines(x, reg$fitted.values, col="green")
summary(reg)

  d <- cbind(as.data.frame(x),as.data.frame(y))
  d$predicted <- predict(reg)
  d$residuals <- residuals(reg)
  library(ggplot2)
  ggplot(d, aes(x = x, y = y)) +
    geom_smooth(method = "lm", se = FALSE, color = "green") +
    geom_segment(aes(xend = x, yend = predicted), size=2, alpha = 1, color="red") + 
    geom_point() +
    geom_point(aes(y = predicted), shape = 1) +  theme_bw() # +
 #   theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())

# hiba szórásnégyzetének becslése:
mse <- sum(residuals(reg)^2) / (length(x)-2)
# hiba szórásának becslése:
sqrt(mse)     # Residual standard error

cor(x,y)^2    # Multiple R-squared (egyszerû lineáris regresszió esetén)

# reziduálisok vs. elõrejelzett értékek:  (fontos, de nem fogjuk nézni)
plot(predict(reg) , residuals(reg))

# elorejelzés x=2 esetén
reg$coefficients[1] + 2*reg$coefficients[2]


#  2. feladat

# Egy darabológép 100 cm-es rudak vágására van beállítva. A következo táblázat 
# hat véletlenszerûen kiválasztott rúd hosszát és súlyát tartalmazza:
# xi (cm) 101,3 103,7 98,6 99,9 97,2 100,1
# yi (dkg) 609 626 586 594 579 605
# (a) Határozza meg és ábrázolja is az aX + b alakú regressziós egyenest!
# (b) Számolja ki a reziduálisokat és becsülje meg a hiba szórásnégyzetét!
# (c) Adjon elõrejelzést x = 100 cm-re a regressziós egyenes alapján!
  
  
x <- c(101.3, 103.7, 98.6, 99.9, 97.2, 100.1)
y <- c(609,   626,  586,  594,  579,   605)

############# MEGOLDÁS #############
reg <- lm(y ~ x)
summary(reg) 

#a konstans nem szignifikáns, a szöveg alapján sem kell
reg <- lm(y ~ 0+x)
summary(reg) #ez jobb, nem kell a konstans tag


plot(x, y)
lines(x, reg$fitted.values, col="green")

# hiba szórásnégyzetének becslése
mse <- sum(residuals(reg)^2) / (length(x)-2); sqrt(mse)

# elorejelzés x=100 esetén
#reg$coefficients[1] + 100*reg$coefficients[2]
####################################
100*reg$coefficients[1]

# 3. feladat
# Vizsgáljuk meg az autók fékútjának függését a sebességtol
reg=lm(dist~speed, data=cars)
summary(reg)
plot(cars$speed,cars$dist)
lines(cars$speed, reg$fitted.values, col="green")
plot(predict(reg) , residuals(reg))

#hogyan tudnánk javítani?
speed2=cars$speed^2
cars=cbind(cars,speed2)
#viszont tudjuk, hogy ha a sebesség 0, akkor
#a távolság is 0, tehát nincs szükség
#konstans tagra
reg=lm(dist~speed+speed2+0, data=cars)
summary(reg)
plot(cars$speed,cars$dist)
lines(cars$speed, reg$fitted.values, col="green")
plot(predict(reg) , residuals(reg))

# 4. feladat
#Vizsgáljuk meg az autók fogyasztásának kapcsolatát
#a rendelkezésre álló magyarázó változókkal (mtcars adatokon)

# https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/00Index.html
# library(datasets)
# library(help = "datasets")

plot(mpg ~ wt, data=mtcars)
plot(mpg ~ qsec, data=mtcars)

reg <- lm(mpg ~ wt + qsec + gear, data = mtcars); summary(reg)
reg <- lm(mpg ~ wt + qsec, data = mtcars); summary(reg)
#kb ugyanolyan, de egyszerubb

# elõrejelzés wt=3, qsec=20 esetén:
reg$coefficients[1] + 3*reg$coefficients[2] + 20*reg$coefficients[3]

####
#regresszió nominális változókkal (faktorok)
####

m     <- lm(mpg ~ as.factor(cyl), data = mtcars)
summary(m)
#az egyik osztály a referencia, ahhoz viszonyítva
#adjuk meg a többi hatását (külön-külön)
#ez nem lineáris

m     <- lm(mpg ~ cyl, data = mtcars)
summary(m)
#ez lineáris (numerikus értékként tekintettük a hengerszámot)
#nem rosszabb

#kombináljuk az elozovel, javítsunk rajta
m     <- lm(mpg ~ wt+disp+carb+sqrt(wt), data = mtcars)
summary(m)
m     <- lm(mpg ~ cyl+wt+disp+carb+sqrt(wt), data = mtcars)
summary(m) #az elozo a jobb

#azok a szignifikáns változók, ahol a p érték kicsi
