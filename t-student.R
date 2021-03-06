#Basic Statistical Methods
# t-Test and ANOVA
# t-Test determine if the averages of two variables are different
# One-way ANOVA of the averages of n-variables, at least two are different
#
# From Daniel Chapter 7 exercise 3.3
#
library(tidyverse)

Ex733 = read.csv(file="EXR_C07_S03_03.csv", header=TRUE)

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
Ex742 <- read.csv(file="EXR_C07_S04_02.csv", header=TRUE)
#
boxplot(Ex742)
# varianzas son iguales 
t.test(Ex742$Base, Ex742$Follow, alternative="g", mu=0, paired=TRUE, var.equal=TRUE)
# ggplot(data = Ex742, mapping = aes(y=Follow, x=Base)) + geom_boxplot() 
#
hers <- read_csv("DataRegressBook/Chap3/hersdata.csv")boxplot(glucose[hers$diabetes == "no"] ~ exercise[hers$diabetes == "no"], data=hers)
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
