pacman::p_load(ggplot2,patchwork)
data <- read.csv("D:/Proyectos/LOLDataAnalisis/Scoutting/Jugadores/AntthossMatches.csv")
View(data)

data$X <- factor(data$X)
barplot(data$X, data$Veces.jugadas)

par(mfrow=c(3,1))

p1 <- ggplot(data, aes(x = X, y = Veces.jugadas),
       col = "blue")+
  geom_col()+
  theme(plot.background = element_rect(size = 15))+
  labs(x = "Campeones", y = "Veces jugadas")


p2 <- ggplot(data, aes(x = X, y = DMG.partida),
       col = "red")+
  geom_col()+
  theme(plot.background = element_rect(size = 15))+
  labs(x = "Campeones", y = "Danio partida")

p3 <- ggplot(data, aes(x = X, y = kill.partida),
       col = "yellow")+
  geom_col()+
  theme(plot.background = element_rect(size = 15))+
  labs(x = "Campeones", y = "Kills")

p1 + p2 + p3
