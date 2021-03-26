
class Tipper:
    def tippaldatgames(self, table:str):
        games = self.get_games(table)
        return self.calculate_tipps(games)
    
    def log_calc(self, heim_team, ausw_team, heim_quote, ausw_quote, tendenz, heim_tore, ausw_tore) -> None:
         print(f'{heim_team}:{ausw_team}; Quote: {heim_quote}:{ausw_quote}; Tendenz {tendenz}; Ergebnis: {heim_tore}:{ausw_tore}')
        
    def calculate_tipps(self,games):
        tipps= []
        for heim_team,ausw_team,heim_quote,ausw_quote in games:
            tendenz = float(heim_quote) / float(ausw_quote)
            heim_tore = 0
            ausw_tore = 0
            if tendenz > 5:
                heim_tore=0
                ausw_tore=3
               
            elif tendenz > 3:
                heim_tore= 1
                ausw_tore= 3
            
            elif tendenz > 1.2:
                heim_tore= 1
                ausw_tore= 2
            
            elif tendenz > 0.8:
                heim_tore= 1
                ausw_tore= 0
            
            elif tendenz > .35:
                heim_tore= 2
                ausw_tore= 1

            elif tendenz > 0.20:
                heim_tore= 3
                ausw_tore= 1
            elif tendenz > 0:
                heim_tore= 3
                ausw_tore= 0
            else:
                heim_tore= 1
                ausw_tore= 1

            tipps.append(heim_tore)
            tipps.append(ausw_tore)
            self.log_calc(heim_team=heim_team,ausw_team=ausw_team,heim_quote=heim_quote,ausw_quote=ausw_quote,tendenz=tendenz,heim_tore=heim_tore,ausw_tore=ausw_tore)
        
        return tipps

    def get_games(self,table):
        games = [game.split("\t") for game in table.split("\n")]
        
        return [[h,a,hq,aq] for _,h,a,_,hq,_,aq in games]

if __name__ == "__main__":
    testdata = ""
    with open("test.txt","r") as reader:
        testdata = reader.read()

    tipper = Tipper()
    tipper.tippaldatgames(testdata)