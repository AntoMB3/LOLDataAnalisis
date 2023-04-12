install.packages("pacman")
pacman::p_load(ggplot2)

data <- read.csv("D:/Data Analytics/LOLDataAnalisis/Scoutting/Jugadores/Antthoss.csv")
View(data)
head(data)

####Tabla de frecuencias por tipo de campeon
tabla_tipo <- table(data$Tipo)
tabla_tipo <- as.data.frame(tabla_tipo)
ggplot(tabla_tipo, aes(x = Var1, y = Freq, fill = Var1),
       col = "Blue")+
  geom_col()+
  theme(plot.background = element_rect(size = 15))+
    labs(x = "Tipos de campeon", y = "Frecuencia de campeones por tipo")

