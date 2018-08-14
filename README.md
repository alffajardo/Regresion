# Métodos de regresión en bioestadística

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

