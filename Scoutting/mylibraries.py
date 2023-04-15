import requests
import riotwatcher as rtw
import creds
from urllib.parse import urljoin
connection = rtw.LolWatcher(creds.riot_API_Key)

def GetChampsNamesAndMasteries(lista) -> list:
    try:
        url = "https://ddragon.leagueoflegends.com/cdn/13.7.1/data/en_US/champion.json"
        response = requests.get(url)
        valor = response.json()
    except Exception:
        print(Exception)
    
    champsData = valor["data"]

    campeones = []

    for champ in lista:
        id = champ["championId"]
        infoCampeon = []
        for champData in list(champsData.keys()):
            if(champsData[champData]["key"] == str(id)):
                infoCampeon.append(champsData[champData]["id"])
                infoCampeon.append(champ["championPoints"])
                infoCampeon.append(champsData[champData]["tags"])
                break
        
        campeones.append(infoCampeon)
    return campeones

def getMatchList(puuid : str, cantidadPartidas: int = 20,queque: int = None, index : int = 0):
    partidas = []
    url = "https://americas.api.riotgames.com/lol/match/v5/matches/by-puuid/"+puuid
    i = 0
    while(i <= int(cantidadPartidas/100)):
        if(cantidadPartidas <= 100):
            parametros = "ids?start="+str(index)+"&count="+str(cantidadPartidas)+"&api_key="+creds.riot_API_Key
            url_completa = url+"/"+parametros
            response = requests.get(url_completa)
            partidas = list(response.json())
        else:
            new_index = 100*i #0-99
            if(cantidadPartidas < 100*(i+1)):
                new_cantidad = cantidadPartidas-100*(i)
            else:
                new_cantidad = 100
            parametros = "ids?start="+str(new_index)+"&count="+str(new_cantidad)+"&api_key="+creds.riot_API_Key
            url_completa = url+"/"+parametros
            response = requests.get(url_completa)
            partidasExtra = list(response.json())
            for partidaExtra in partidasExtra:
                partidas.append(partidaExtra)
        i += 1
    
    return partidas
    
def GetMatchInfo(region: str,match_id):
    region = region.lower()
    info_partida = connection.match.by_id(region = region, match_id=match_id)
    return info_partida
