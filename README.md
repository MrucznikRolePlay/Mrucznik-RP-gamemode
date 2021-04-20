# Mrucznik-RP-2.6

Mapa serwera Mrucznik Role Play, jednego z największych polskich serwerów Role Play na modyfikacji San Andreas Multiplayer (SA:MP). 
Serwer istniał od września 2009 roku do października 2020 roku. W tym czasie zapewnił graczom wiele niezapomnianych akcji, mnóstwo zabawy i zgromadził wokół siebie sporą społeczność graczy.

## Od autora

Cześć. Postanowiłem wrzucić skrypt mojego serwera jako dostępny publicznie. Mam nadzieję na to, że niektóre osoby zachęci to do nauki programowania, zaspokoi ciekawość, w jaki sposób wyglądał kod serwera i może zainspiruje do stworzenia czegoś swojego. Kod i tak nie zostanie przeze mnie użyty, ponieważ zakończyłem swoją karierę z tworzeniem serwerów role play na SA:MP. Możesz używać kodu dowolnie, tworząc własne projekty bądź kopiować części skryptu do siebie. Projekt udostępniam na licencji pizza-ware. Nie zapewniam wsparcia w odpalaniu skryptu, ale jak napotkasz jakieś problemy, możesz stworzyć Issue na githubie, zapewne odpiszę w wolnej chwili ;) Jeśli masz jakieś pytania co do skryptu, najlepiej komunikować się ze mną poprzez [forum serwera](https://mrucznik-rp.pl/profile/1-mrucznik/).
Chciałbym podziękować też wszystkim skrypterom, którzy dołożyli swoją cegiełkę do tej mapy, a było ich sporo, listę znajdziecie niżej. Dzięki!

## Jak uruchomić serwer

Aby ułatwić wam obczajanie co i jak, umieszczam tutorial krok po kroku, jak uruchomić serwer.
```
# Instalujemy git'a
# https://git-scm.com/downloads

# Instalujemy dockera - potrzebny do uruchomienia bazy mysql i serwera jako kontener
# https://docs.docker.com/docker-for-windows/install/

# OK, masz już wszystkie zależności potrzebne do zbudowania projektu, lecimy dalej.

# Klonujemy projekt razem z submodułami
git clone --recurse-submodules https://github.com/Mrucznik/Mrucznik-RP-2.5
cd Mrucznik-RP-2.5

# OK, repozytorium pobrane, teraz możemy odpalić serwer
docker-compose up

# Odpalana zostaje baza danych mysql, phpmyadmin oraz serwer
# Serwer jest dostępny pod adresem localhost:7777
# Możesz wejść na konto testowe Test_Test, hasło test
# Adres phpmyadmina: http://localhost:8080/

# Jeżeli chciałbyś edytować kod, polecam zapoznać się z plikiem IDE.md, 
# który opisuje w jaki sposób skofigurować IDE takie jak Visual Studio Code, by pisać kod w Pawn.
```

## Nowsza wersja

Mapa była w trakcie przenoszenia na nową wersję MySQL + refactor, ale prace nie zostały dokończone. Zmiany możesz zobaczyć w tym pull requeście: https://github.com/Mrucznik/Mrucznik-RP-2.5/pull/286

Aby ją odpalić należy przełączyć się na brancha new_mysql: `git checkout new_mysql` a następnie odpalić kontenery: `docker-compose up`.

## Ważne adnotacje odnośnie kodu

- aby pobrać różnicę między nowym GetTickCount a starym GetTickCount, użyj funkcji GetTickDiff
- aby sprawdzić stan gotówki przy graczu porównaj value z kaska[playerid]
- aby wyświetlić dialog informacyjny użyj ShowPlayerInfoDialog(..);
- aktorów twórz tylko i wyłącznie w pliku ActorsOnWorld.pwn (github obiekty)
- do wyświetlania dialogów zawsze używaj ShowPlayerDialogEx(..);
- do pobrania nicku gracza możesz użyć GetNick(playerid);
- do pobrania ID gracza z nicku możesz użyć GetPlayerIDFromName(nick);

## Twórcy

- [Fear]? - Twórcy podstawy gamemodu - skryptu The Godfather
- [Mrucznik] Twórca modyfikacji mapy (mapa została napisana na podstawie skryptu The Godfather) i założyciel serwera Mrucznik Role Play,
- [Simeone] Developer w latach 2018 - 2019
- [Pecet] Developer w latach 2017-2019
- [Akil] Developer (brak szczegółowych danych)
- [Kubi] Developer od 2013 (?) do 2015 roku
- [Veroon] Developer (brak szczegółowych danych)
- [niceCzlowiek] Developer w latach 2017-2018
- [lukeSql] Developer w 2018
- [Creative] Developer od 6 listopada 2019
- [Sandał] Developer od 9 grudnia 2019
- [skTom] autor modułu discordowego

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

## Subrepozytoria
- https://github.com/Mrucznik/Mrucznik-RP-obiekty - obiekty serwera
- https://github.com/Mrucznik/Mrucznik-RP-Includes/ - includy serwera
