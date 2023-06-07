# Proyecto de análisis de LOL
En este proyecto se realizaron actividades de webscrapping, procesesamiento de datos y tratamiento de la información para gráficas dinámicas.
Se requiere tener acceso a la API oficial de RIOT para poder obtener la información de un jugador. Debido a las limitantes de la propia API solo se pueden hacer 100 llamadas por cada 2 min.

A través de un script de python obtenemos toda la información necesaria y la escribimos en un .CSV para posteriormente pasarlo a R para su análisis y ploteo.
En R creamos una ShinyAPP para poder observar mejor las estadísticas.

Pueden probar la ShinyApp -> https://uanvni-antonio-munoz.shinyapps.io/LolScoutting/
Utilizar el CSV de prueba incluido en el repositorio!

![1](https://user-images.githubusercontent.com/56263378/234063452-d123e067-2bf7-47bf-8daf-01bf6fed5058.png)

![2](https://user-images.githubusercontent.com/56263378/234062359-82b38382-1972-4830-bff9-801d92702bb6.png)
