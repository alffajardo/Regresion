---
title: "R for data science: data visualization using ggplot2"
output: html_notebook
---

This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. When you execute code within the notebook, the results appear beneath the code. 

Try executing this chunk by clicking the *Run* button within the chunk or by placing your cursor inside it and pressing *Ctrl+Shift+Enter*. 

```{r}
plot(cars)
```

Add a new chunk by clicking the *Insert Chunk* button on the toolbar or by pressing *Ctrl+Alt+I*.

When you save the notebook, an HTML file containing the code and output will be saved alongside it (click the *Preview* button or press *Ctrl+Shift+K* to preview the HTML file).

The preview shows you a rendered HTML copy of the contents of the editor. Consequently, unlike *Knit*, *Preview* does not run any R code chunks. Instead, the output of the chunk when it was last run in the editor is displayed.

 primero Cargamos tydiverse
```{r}
library(tidyverse)
```
Crear una grafica del paquete mpg
```{r}
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))
```
probando hacer otra gráfica
¿ Será util esta gráfica?
```{r}
ggplot(data = mpg)+
geom_point(mapping = aes(x= cyl,y=hwy))
           
```
¿Qué pasa si hacemos una gráfica de class vs drv? ¿ Resulta útil esta gráfica?
```{r}
ggplot(data=mpg)+
  geom_point(mapping = aes(x=drv,y=class))
```
Respuesta: La gráfica no resulta de mucha utilidad puesto que estamos graficando una variable categórica en el eje y



