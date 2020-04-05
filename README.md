# Mrucznik-RP-2.6

Mapa serwera Mrucznik Role Play, kreowana od 2009 roku.

## Ważne adnotacje odnośnie kodu

- aby pobrać różnicę między nowym GetTickCount a starym GetTickCount, użyj funkcji GetTickDiff
- aby sprawdzić stan gotówki przy graczu porównaj value z kaska[playerid]
- aby wyświetlić dialog informacyjny użyj ShowPlayerInfoDialog(..);
- aktorów twórz tylko i wyłącznie w pliku ActorsOnWorld.pwn (github obiekty)
- do wyświetlania dialogów zawsze używaj ShowPlayerDialogEx(..);
- do pobrania nicku gracza możesz użyć GetNick(playerid);
- do pobrania ID gracza z nicku możesz użyć GetPlayerIDFromName(nick);

## Twórcy

- [Mrucznik] Twórca mapy i założyciel serwera Mrucznik Role Play,
- [Simeone] Developer od 2018 roku
- [Pecet] Developer w latach 2017-2019
- [Akil] Developer (brak szczegółowych danych)
- [Kubi] Developer do 2015 roku
- [Veroon] Developer (brak szczegółowych danych)
- [niceCzlowiek] Developer w latach 2017-2018
- [lukeSql] Developer w 2018
- [Creative] Developer od 6 listopada 2019
- [Sandał] Developer od 9 grudnia 2019

## [Edytory do PAWN](IDE.md)

## Konfiguracja repozytorium

- `git clone  https://github.com/Mrucznik/Mrucznik-RP-2.5`
- `cd Mrucznik-RP-2.5`
- `git submodule init`
- `git submodule update` - w razie problemów z uprawnieniami edytuj plik .git/config podmieniając ścieżki submodułów z protokołu git na https

## Kompilacja

Gamemod Mrucznika jest przystosowany do [sampctl](https://github.com/Southclaws/sampctl).
Aby skompilować gamemode z użyciem sampctl, należy [zainstalować sampctl](https://github.com/Southclaws/sampctl/wiki/Windows) a następnie wpisać następujące polecenia:

- `sampctl package ensure`
- `sampctl package build`

## Uruchamianie serwera testowego
- Na swoim systemie: `sampctl package run`
- Z użyciem dockera: `docker build . -t mrucznik/mrucznik-rp:v2.6` `docker run -e "SAMP_DISCORD_BOT_TOKEN=[token]" mrucznik/mrucznik-rp:v2.6`
- Z użyciem docker-compose: `docker-compose up` (razem z developersą bazą mysql!)

## Inne repozytoria
