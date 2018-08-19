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

codigo empleado para hacer una prueba T. 

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