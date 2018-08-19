# Ejercicios Tidyverse

library(tidyverse)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = class, y = drv))

#  Crear una gráfica en la que el color sea la clase de auto

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))
### el tamaño de los puntos también puede estar asociado al tamaño de a letra

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))

# Tambien es posible jugar con la transparencia  y la forma de los puntos en función de la clase

# Left
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

# Right
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))

#cambiar los colores 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

## ¿ por qué los puntos no son azules
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))


### hagamos lo mismo para representar variables continuas

ggplot(data = mpg)+
geom_point(mapping = aes(x =displ , y =  hwy , color = cty))


## hacer la misma grafica pero que el tamaño de los puntos represente cty

ggplot(data = mpg)+
  geom_point(mapping = aes(x =displ , y =  hwy , size= cty))

# hacer lo mismo pero con la forma de los puntos

ggplot(data = mpg)+
  geom_point(mapping = aes(x =displ , y =  hwy , shape = cty))

## hacemos lo mismo con la transparencia

ggplot(data = mpg)+
  geom_point(mapping = aes(x =displ , y =  hwy , alfa= cty))


