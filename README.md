# Métodos de regresión en bioestadística

Los datos para trabajar estan en linea. Los datos del libro de Vittinghoff pueden encontrarse  aquí: [Vittinghoff](http://www.biostat.ucsf.edu/vgsm)

los datos del libro de Daniel pueden encontrase aqui: [Daniel](http://bcs.wiley.com/he-bcs/Books?action=resource&bcsId=2191&itemId=0471456543&resourceId=4780)

## Estadística descriptiva

- hacer una descripción de los datos: tipo de datos, variables con las que se trabaja etc.

 *Variables:* una variable continua es real. aquella que toma unicamente valores discretos, se dice es  una variable discreta.

## Regresión

El termino regresion fue acuñado por Francis Galton para describir un fenomeno biologico. el fenomeno consiste en que la estatura de de los decedintes de gente muy alta, a la larga tendía a regresar a la estatura promedio.

```R
# Análisis exploratorio de los datos
## Estadísiticos descriptivos y graficación 

library(tidyverse)
library(Hmisc)
library(funModeling)
library(readxl)
wcgs <- read_excel("wcgs.xls")

# for a generic data glance.
# Run all the functions with the folowwinf function:

basic_eda <- function(My_data) {
  glimpse(My_data)
  df_status(My_data)
  freq(My_data)
  profiling_num(My_data)
  plot_num(My_data)
  describe(My_data)
}
basic_eda(wcgs)
#Explorar los datos con gráficas de ggplot

ggplot(data=wcgs) + geom_histogram(mapping = aes(x=sbp),binwidth = 9)
boxplot(wcgs$sbp)

## Hacer el boxplot con ggplot

ggplot(data=wcgs,aes(y = sbp))+ geom_boxplot()

#qqplot

ggplot(data = wcgs) + geom_qq(aes(sample=sbp))

#graficar el peso en función de la presion sistólica

ggplot(data=wcgs) + geom_point(mapping = aes(x= weight, y=sbp))
       
### encimar una linea suavisada
ggplot(data=wcgs) + geom_point(mapping = aes(x= weight, y=sbp)) + 
geom_smooth(mapping = aes(x=weight, y=sbp))

## describir las variables contra otra de las variables, una de las formas de hacerlo
## hacer diferentes boxplot en función de otra variable

## presión sistólica en funcion del patron de conducta
ggplot(data= wcgs) + geom_boxplot(mapping = aes(x=behpat,y=sbp))

## hacer un jitter con un boxplot

ggplot(data=wcgs,aes(x=behpat,y=sbp))+
geom_boxplot()+
geom_jitter(height = 0.05,width = 0.05)



```

# **1.2 Introducción al ANOVA y la prueba t de Student**

 ## Código empleado para hacer una prueba T. 

```R

ta
# Basic Statistical Methods
# t-Test and ANOVA
# t-Test determine if the averages of two variables are different
# One-way ANOVA of the averages of n-variables, at least two are different
#
# From Daniel Chapter 7 exercise 3.3
#
library(tidyverse)

Ex733 = read.csv(file="DataOther/EXR_C07_S03_03.csv", header=TRUE)

var.test(Ex733$Length[Ex733$Group == 2], Ex733$Length[Ex733$Group == 1])
NoOSAS = Ex733$Length[Ex733$Group == 1]
OSAS = Ex733$Length[Ex733$Group == 2]
boxplot(NoOSAS,OSAS)
#
var.test(Ex733$Length[Ex733$Group == 2], Ex733$Length[Ex733$Group == 1])
t.test(NoOSAS, OSAS, alternative="less", mu=0, var.equal = FALSE, conf.level=0.99)
#
boxplot(Length ~ Group, data=Ex733)
t.test(Length ~ Group, data=Ex733, alternative="two.sided", var.equal = FALSE, conf.level=0.99)
#
ggplot(data = Ex733, aes(y = Length, group = Group)) + geom_boxplot()

# Prob 7.4.2
#
Ex742 <- read.csv(file="DataOther/EXR_C07_S04_02.csv", header=TRUE)
#
boxplot(Ex742)
# varianzas son iguales 
t.test(Ex742$Base, Ex742$Follow, alternative="g", mu=0, paired=TRUE, var.equal=TRUE)
# ggplot(data = Ex742, mapping = aes(y=Follow, x=Base)) + geom_boxplot() 
#
hers <- read_csv("DataRegressBook/Chap3/hersdata.csv")
boxplot(glucose ~ diabetes, data=hers)
boxplot(glucose[hers$diabetes == "no"] ~ exercise[hers$diabetes == "no"], data=hers)
t.test(glucose[hers$diabetes == "no"] ~ exercise[hers$diabetes == "no"], data=hers, alternative="two.sided, mu=0, paired=FALSE, var.equal=TRUE)
#
ggplot(data = hers, mapping = aes(y=glucose, x=diabetes)) + geom_boxplot() 
ggplot(data = hers, mapping = aes(x = diabetes, y = glucose)) + geom_boxplot()+ facet_grid( . ~ exercise)
ggplot(data = hers, mapping = aes(x = diabetes, y = glucose)) + geom_boxplot()+ facet_grid( . ~ insulin)
#
# Exercise 7.44 Ex744 "DXA","ST","BR","SEX"
Ex744 <- read_csv("DataOther/REV_C07_44.csv")
boxplot(DXA ~ SEX, data=Ex744)
ggplot(data = Ex744, mapping = aes(y=DXA, group=SEX)) + geom_boxplot()



```



Tarea para la siguente clase: resolver el ejercicio 7.4.3 del daniel

## ANOVA

 ```R
# Grouping the data ready for ANOVA
Ex744 <- read_csv("DataOther/REV_C07_44_mod.csv")
ggplot(data = Ex744, mapping = aes(y=BodyFat, x=Method)) + geom_boxplot(na.rm = TRUE)
# To use Sex as color, color must be >0
Ex744$Sex <- Ex744$Sex + 1
ggplot(data = Ex744, mapping = aes(y=BodyFat, x=Method, color = Sex)) + geom_boxplot(na.rm = TRUE)
ggplot(data = Ex744, mapping = aes(y = BodyFat, x = Method)) + geom_boxplot(na.rm = TRUE) 
    + geom_jitter(height=0.2, width=0.2)
ggplot(data = Ex744, mapping = aes(y = BodyFat, x = Method)) + geom_boxplot(na.rm = TRUE) 
    + geom_jitter(height=0.05, width=0.05, color=factor(Ex744$Sex), na.rm = TRUE)
# for a one-way ANOVA example with Ex744
is.factor(Ex744$Method)
aov744 <- aov(BodyFat~Method, data = Ex744)
summary(aov744)
TukeyHSD(aov744, conf.level = 0.99)
plot(TukeyHSD(aov744, conf.level = 0.99), las=1, col = "red")
#
# Diagnostic check
par(mfrow=c(2,2))
plot(aov744)
#
# Shapiro Wilk test
uhat <- resid(aov744)
shapiro.test(uhat)

bartlett.test(BodyFat~Method, data = Ex744)
library(car)
levene.test(BodyFat~Method, data = Ex744)

# Other example Chap 8 One-Way ANOVA
Ex82 <- read_csv("DataOther/EXA_C08_S02_01.csv")
boxplot(Ex82)
Ex82.dat = stack(Ex82)
names(Ex82.dat)
# ggplot(data = Ex82.dat, mapping = aes(y=values, x=ind, color = ind)) + geom_boxplot(na.rm = TRUE) 
    + geom_jitter(height=0.1, width=0.1)
ggplot(data = Ex82.dat, mapping = aes(x = reorder(ind, values, FUN = median), y  =values, color = ind)) 
    + geom_boxplot(na.rm = TRUE) + geom_jitter(height=0.1, width=0.1)
    
# Estimating the one-way ANOVA
Ex82.aov=aov(values~ind, data=Ex82.dat)
summary(Ex82.aov)
TukeyHSD(Ex82.aov, conf.level = 0.99, ordered=TRUE)
plot(TukeyHSD(Ex82.aov, conf.level = 0.99, ordered=TRUE), color = "red")
abline(v=0, col=2)
## Testing
par(mfrow=c(2,2))
# layout(matrix(c(1, 2, 3, 4), nrow=2, ncol=2, byrow=TRUE))
plot(Ex82.aov)
#
# Shapiro Wilk test
uhat_82 <- resid(Ex82.aov)
shapiro.test(uhat_82)

bartlett.test(values~ind, data=Ex82.dat)
library(car)
levene.test(values~ind, data=Ex82.dat)

#
hers <- read_csv("DataRegressBook/Chap3/hersdata.csv")
ggplot(data = hers, mapping = aes(x = reorder(raceth, SBP, FUN = median), y=SBP, color = raceth)) + geom_boxplot(na.rm = TRUE) + geom_jitter(height=0.15, width=0.15)
SBP_race.aov=aov(SBP~raceth, data=hers)
summary(SBP_race.aov)
TukeyHSD(SBP_race.aov, conf.level = 0.99, ordered=TRUE)
plot(TukeyHSD(aov(SBP~raceth, data=hers), conf.level = 0.99, ordered=TRUE), col = "red")
par(mfrow=c(2,2))
plot(SBP_race.aov)
par(mfrow=c(1,1))
uhat_SBP <- resid(SBP_race.aov)
shapiro.test(uhat_SBP)
 ```

## Regresión lineal simple y correlación

`requiere(gmodels)`

```R
# Examples of the Chapter 3 
#
library(tidyverse)
#

hers <- read_csv("DataRegressBook/Chap3/hersdata.csv")
ggplot(data = hers, mapping = aes(x = reorder(raceth, SBP, FUN = median), y=SBP, color = raceth)) + geom_boxplot(na.rm = TRUE) + geom_jitter(height=0.15, width=0.15)
SBP_race.aov=aov(SBP~raceth, data=hers)
summary(SBP_race.aov)
TukeyHSD(SBP_race.aov, conf.level = 0.99, ordered=TRUE)
plot(TukeyHSD(aov(SBP~raceth, data=hers), conf.level = 0.99, ordered=TRUE), col = "red")
par(mfrow=c(2,2))
plot(SBP_race.aov)
par(mfrow=c(1,1))
uhat_SBP <- resid(SBP_race.aov)
shapiro.test(uhat_SBP)
#
# Simple Linear Regression Model
# SBP by age in the HERS data Y variation with a single predictor
#

# Example of simplelinear model
Exr33 <- read_csv(file="EXR_C09_S03_03.csv")
#
plot(Exr33$QTC ~ Exr33$DOSE, pch=20)
LinExr33 = lm(QTC ~ DOSE, data=Exr33)
summary(LinExr33)
abline(LinExr33, col=2)
# Res y = 559.9 + 0.139 x
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Problem 9.3.4 Hospital tests for anticoagulant
# Measures of INR (Y) from 90 subjects taking warfarin the 
# independent variable was the hospital essays (X)
library(tidyverse)
Exr3.4 <- read_csv(file="EXR_C09_S03_04.csv")
plot(Y ~ X, data=Exr3.4, pch=20)
LinExr3.4 <- lm(Y ~ X, data=Exr3.4)
abline(LinExr3.4, col=2)
# y = 0.4885 + 0.8625 x  with r^2 = 0.5067 (50 % data exp)
summary(LinExr3.4)
par(mfrow=c(2,2))
plot(LinExr3.4)
par(mfrow=c(1,1))
#
ggplot(data = Exr3.4, mapping = aes(x = X, y = Y)) + 
  geom_point(na.rm = TRUE) + geom_jitter(height=0.05, width=0.05)
#
ggplot(data = Exr3.4, mapping = aes(x = X, y = Y)) + geom_point(na.rm = TRUE) + 
  geom_abline(aes(intercept = 0.4885, slope = 0.8625, colour = "RED")) + 
  geom_jitter(height=0.05, width=0.05)
#
# Problem 9.3.7 GFR is the most importatn parameter of 
# renal function assesment in transplan, insulin is the
# gold standar of GFR. Examied inverse Cystatin C as 
# insulin GFR, use the DTPA GFR as the predictor
# of the inverse Cystatin C
Exr3.7 <- read_csv(file="EXR_C09_S03_07.csv")
plot(INVCYS ~ DTPA, data=Exr3.7, pch=20)
LinExr3.7 = lm(INVCYS ~ DTPA, data=Exr3.7)
summary(LinExr3.7)
abline(LinExr3.7, col=2)
# y = 0.1929 + 0.0063 x  with r^2 = 0.57 (57 % data exp)
par(mfrow=c(2,2))
plot(LinExr3.7)
par(mfrow=c(1,1))
#
ggplot(data = Exr3.7, mapping = aes(x = DTPA, y = INVCYS)) + geom_point(na.rm = TRUE) + 
  geom_abline(aes(intercept = 0.1929, slope = 0.0063, colour = "red")) + 
  geom_jitter(height=0.05, width=0.05)
#

# #############################################################################
# Contingency tables
# frequency variables
tab_wcgs <- table(wcgs$chd69, wcgs$arcus, dnn = c('CHD','arcus'))
ftab_wcgs <- ftable(chd69~arcus~chd69, data= wcgs, dnn = c('CHD','arcus'))
#
library(gmodels)
CrossTable(wcgs$chd69, wcgs$arcus, dnn = c('CHD','arcus'))
#
chisq.test(tab_wcgs)
# chisq.test(tab_wcgs, simulate.p.value = TRUE)
```

## Análisis de sobrevivencia

se realiza un análisis de tiempo y de eventos de manera que se hace en sustratos.

estimador de kaplan

escribir aquí código para analisis de sobrevivencia

```

```



## Regresión multiple

```
#Multiple linear linear regression
#
# Chapter 4 examples. 4.1
library(tidyverse)
library(readxl)
hers <- read_excel("hersdata.xls")
hers_nodi <- filter(hers, diabetes == "no")
# Simple linear model with HERS data for women without diebetes
ggplot(data = hers_nodi, mapping = aes(x = exercise, y = glucose)) + 
  geom_boxplot(na.rm = TRUE) + facet_grid( . ~ diabetes) + geom_jitter(height = 0.15, width = 0.15)
# The simple linear model adjust the exercise like in table 4.1
hers_nodi_Fit <- lm(glucose ~ exercise, data = hers_nodi)
summary(hers_nodi_Fit)
# and for obtaining the table 4.2 with multiple linear model
hers_nodi_Fit2 <- lm(glucose ~ exercise + age + drinkany + BMI, data = hers_nodi)
summary(hers_nodi_Fit2)
# For the amount of exercise
ggplot(data = hers_nodi, mapping = aes(x = factor(physact), y = glucose)) + geom_boxplot(na.rm = TRUE) + geom_jitter(height = 0.15, width = 0.15)
#
hers_nodi_Fit3 <- lm(glucose ~ factor(physact), data = hers_nodi)
summary(hers_nodi_Fit3)
#
# Example of multiple linear regression using the clouds data
# clouds from HSAUR
library(HSAUR2)
data(clouds)
sample_n(clouds, 5)
# looking the datafor rainfall
boxplot(rainfall~seeding, data=clouds)
boxplot(rainfall~echomotion, data=clouds)
# layout(matrix(1:2, nrow = 2))
# bxpseeding <- boxplot(rainfall ~ seeding, data = clouds, ylab = "Rainfall", xlab = "Seeding")
# bxpecho <- boxplot(rainfall ~ echomotion, data = clouds, ylab = "Rainfall", xlab = "Echo Motion")
# y = Xb+e with X the design model matrix that consis of the q continuously measured
# explanatory variables and a column of ones corresponding to the intercept term
layout(matrix(1:4, nrow = 2))
plot(rainfall ~ time, data = clouds)
plot(rainfall ~ cloudcover, data = clouds)
plot(rainfall ~ sne, data = clouds, xlab="S-Ne criterion")
plot(rainfall ~ prewetness, data = clouds)
#
clouds_formula <- rainfall ~ seeding + seeding:(sne+cloudcover+prewetness+echomotion) + time
Xstar <- model.matrix(clouds_formula, data = clouds)
attr(Xstar, "contrasts")
clouds_lm <- lm(clouds_formula, data = clouds)
summary(clouds_lm)
layout(matrix(1:1, nrow = 1))
# to list the betas* with the:
betaStar <- coef(clouds_lm)
betaStar
# to understand the relation of seeding and sne
psymb <- as.numeric(clouds$seeding)
plot(rainfall ~ sne, data = clouds, pch = psymb, xlab = "S-Ne criterion")
abline(lm(rainfall ~ sne, data = clouds, subset = seeding == "no"))
abline(lm(rainfall ~ sne, data = clouds, subset = seeding == "yes"), lty = 2)
legend("topright", legend = c("No seeding", "Seeding"), pch = 1:2, lty = 1:2, bty = "n")
#
# and the Covariant matrix Cov(beta*) with:
VbetaStar <- vcov(clouds_lm)
# Where the square roots of the diagonal elements are the standart errors 
sqrt(diag(VbetaStar))
# 
# Regression with categorical variables. Dummy Coding Essentials in R
# Examples from the STHDA
library(tidyverse)
library(car)
data(Salaries)
# Inspecting 5 lines of the Salaries database
sample_n(Salaries, 5)
# model of salary with sex
model <- lm(salary ~ sex, data = Salaries)
summary(model)$coef
# contrasts() will show the dummy coding of the sex variable of the 
# to see the way R has encoded rank head(res[, -1])
contrasts(Salaries$sex)
SalariesM <- Salaries %>%
  mutate(sex = relevel(sex, ref = "Male"))
# to change the reference dummy coding
model <- lm(salary ~ sex, data = Salaries)
summary(model)$coef
#
res <- model.matrix(~rank, data = Salaries)
head(res[, -1])
# for multiple variables with interaction
model_Salar <- lm(salary ~ yrs.service + rank + discipline + sex, data=Salaries)
summary(model_Salar)
#


```

tarea: capitulo 8 everitte