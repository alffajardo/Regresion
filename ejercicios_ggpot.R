### ejercicios ggplot
library(tidyverse)

## Facet function to plot several graphs in un sheet

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

ggplot(data = mpg) + 
  
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)

## que pasa si usamos facet con una variable continua

ggplot(data = mpg) +
geom_point(mapping = aes(x = displ, y = hwy)) + 
 facet_wrap(~cty,nrow=2)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))
geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)


## Creating barplots
