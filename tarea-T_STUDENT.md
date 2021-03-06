---
title: "tarea T-student"
output:
  html_notebook: default
  html_document:
    df_print: paged
  pdf_document: default
---
 The purpose of an investigation by Morley et al. (A-17) was to evaluate the analgesic effectiveness
of a daily dose of oral methadone in patients with chronic neuropathic pain syndromes. The
researchers used a visual analogue scale (0-100 mm, higher number indicates higher pain) ratings
for maximum pain intensity over the course of the day. Each subject took either 20 mg of
methadone or a placebo each day for 5 days. Subjects did not know which treatment they were
taking. The following table gives the mean maximum pain intensity scores for the 5 days on
methadone and the 5 days on placebo. Do these data provide sufficient evidence, at the .05 level of
significance, to indicate that in general the maximum pain intensity is lower on days when
methadone is taken?


![](imagen1.png)





## importar los datos y acomodarlos

```{r}
library(tidyverse)
datos <- read.csv("EXR_C07_S04_03.csv")
View(datos)
treatment  <- factor( c(rep(1,11),rep(2,11)),
                      labels = c("Placebo","Methadone"))
score <- c(datos$Plac,datos$Meth)
datos2 <- data.frame(treatment,score)
View(datos2)
```

## Test de varianza
```{r}
variance_test <- var.test(datos2$score[datos2$treatment=="Placebo"],datos2$score[datos2$treatment =="Methadone"])
variance_test
```
## Gr�fico

```{r}
ggplot(data = datos2,
               mapping = aes(x=treatment,y=score))+
                 geom_boxplot()+
                 geom_point()+
                 geom_jitter(height = 0.03,width = 0.03)


```
## Prueba T-student para muestras relacionadas

```{r}
comparison <- t.test(score~treatment,data = datos2,paired=T)
comparison

```

```

