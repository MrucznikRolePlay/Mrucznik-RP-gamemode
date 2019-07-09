# Mrucznik-RP-2.6
Mapa serwera Mrucznik Role Play

## Ważne adnotacje odnośnie kodu
- aby pobrać różnicę między nowym GetTickCount a starym GetTickCount, użyj funkcji GetTickDiff
- aby sprawdzić stan gotówki przy graczu porównaj value z kaska[playerid]
- aby wyświetlić dialog informacyjny użyj ShowPlayerInfoDialog(..); 
- aktorów twórz tylko i wyłącznie w pliku ActorsOnWorld.pwn (github obiekty) 
- do wyświetlania dialogów zawsze używaj ShowPlayerDialogEx(..); 
- do pobrania nicku gracza możesz użyć GetNick(playerid);
- do pobrania ID gracza z nicku możesz użyć GetPlayerIDFromName(nick); 

## [Edytory do PAWN](IDE.md)

## Kompilacja
Gamemod Mrucznika jest przystosowany do [sampctl](https://github.com/Southclaws/sampctl).
Aby skompilować gamemode z użyciem sampctl, należy [zainstalować sampctl](https://github.com/Southclaws/sampctl/wiki/Windows) a następnie wpisać następujące polecenia:
- sampctl package ensure
- sampctl package build
