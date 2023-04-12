import requests
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
                break
        
        campeones.append(infoCampeon)
    return campeones
