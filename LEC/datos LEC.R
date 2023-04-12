library(pacman)

pacman::p_load(rio,dplyr,ggplot2,tidyr)

path <- "D:/Proyectos/LOL Data Analisis/2023_LoL_esports_match_data_from_OraclesElixir.csv"

data <- import(path)
View(data)

##Cargar datos LEC
data_LEC <- subset(data, data$league == "LEC")
View(data_LEC)
head(data_LEC)

##Obtener nada mas el spring
data_LEC_Spring <- subset(data_LEC, data_LEC$split == "Spring")
View(data_LEC_Spring)



#######Dragones#######################################################
##Limpiar datos
data_LEC_Spring <- data_LEC_Spring[c(seq(-11,-1, by = 1))]
View(data_LEC_Spring)


#Obtener solo las filas de los dragones
data_dragons <- data_LEC_Spring[complete.cases(data_LEC_Spring$dragons),]
View(data_dragons)

equipos <- unique(data_LEC_Spring$teamname)

par(mfrow = c(1,1))
par(mfrow = c(2,5))

for(i in equipos){
  
#Obtener dragones por equipo
dragons_perTeam <- data_LEC_Spring[data_LEC_Spring$teamname == i,c(35:40)]
#View(dragons_perTeam)

#Limpiamos los NA
dragons_perTeam <- na.omit(dragons_perTeam)
#View(dragons_perTeam)


mountain <- sum(dragons_perTeam$mountains)
ocean <- sum(dragons_perTeam$oceans)
hex <- sum(dragons_perTeam$hextechs)
chem <- sum(dragons_perTeam$chemtechs)
fire <- sum(dragons_perTeam$infernals)

frecuencia = c(mountain,ocean,hex,chem,fire)

nombres_dragones = c("Montaña","Oceano","Hextech","Chemthec","Infernal")

colores = c("#594617","#0FD3F1","#0A3CDA","#09931E","#CB0918")
dataFrame_dragones <- data.frame(frecuencia, row.names = nombres_dragones)
#View(dataFrame_dragones)

#barplot(dataFrame_dragones$frecuencia, names.arg = nombres_dragones, col = colores, ylab = "Cantidad de dragones",
       # main = paste("Dragones asesinados por: ",i))

porcentajes <- round(100 * frecuencia / sum(frecuencia), 1)
pie(dataFrame_dragones$frecuencia, labels = paste(nombres_dragones,"-",porcentajes,"%"), col = colores,
    main = paste("Dragones asesinados por: ",i),
    radius = 1)

}

#################################################################################################################



#######Predecir primer dragon#######################################################
data_dragons <- data_LEC_Spring[complete.cases(data_LEC_Spring$dragons),]
View(data_dragons)

#Obtener fechas
data_first_dragon <- data_dragons[,c(8,16,41)]
View(data_first_dragon)


#Obtener fechas y dragones
fechas <- data_first_dragon[data_first_dragon$teamname == "G2 Esports",c(1,3)]
#View(fechas)

fechas2 <- data_first_dragon[data_first_dragon$teamname == "KOI",c(1,3)]

#Convertir a date
fechas$date <- as.Date(fechas$date)
fechas <- cbind(fechas, fechas2$firstdragon)
xLen <- length(fechas$date)
xLen <- seq(xLen)
fechas <- cbind(fechas, xLen)

#Regresion
modelo <- lm(firstdragon ~ xLen, data = fechas)
modelo2 <- lm(`fechas2$firstdragon` ~ xLen, data = fechas)
ggplot(fechas, aes(x = xLen)) +
  geom_line(aes(y = firstdragon),color = "black", size = 1) +
  labs(title = "Timeline de objetivos conseguidos", x = "Partida", y = "First Dragon")+
  geom_line(aes(y = fechas2$firstdragon),color = "#B40CC2", size = 1) +
  geom_smooth(aes(y = firstdragon),method = "lm", se = FALSE, color = "red") +
  geom_smooth(aes(y = fechas2$firstdragon),method = "lm", se = FALSE, color = "green")+
  labs(title = "Timeline de objetivos conseguidos con regresión lineal", x = "Fecha", y = "Cantidad")+
  labs(title = "Timeline de objetivos conseguidos", x = "Partida", y = "First Dragon")

siguiente_partida <- max(fechas$xLen)+1
nuevo_df <- data.frame(xLen = siguiente_partida)
prediccion <- predict(modelo, newdata = nuevo_df)
prediccion2 <- predict(modelo2, newdata = nuevo_df)

prediccion <- round(prediccion*100,1)
prediccion2 <- round(prediccion2*100,1)

cat(paste("Predicción de primer dragon:\n","G2 Esports: ", prediccion, "%\n","KOI: ", prediccion2, "%\n"))
