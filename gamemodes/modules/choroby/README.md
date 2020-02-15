# System chorób

## Opis systemu


## Choroby
Choroby posiadają następujące parametry:
- CureCost - koszt kuracji
- CureTime - czas potrzebny na przeprowadzenie kuracji
- DrugResistance - szanse na nieudaną kurację (w procentach)
- ContagiousRatio - współczynnik zaraźliwości opisany w [rozdziale "Zakaźność"](#zaka%c5%bano%c5%9b%c4%87)
- SpreadingOnContact - czy choroba powinna być przenoszona poprzez kontakt fizyczny
- VEffects - lista efektów wywoływanych przez chorobę

Każda choroba może wywoływać dowolną liczbę efektów. Gracz może być jedocześnie zarażony dowolną liczbą chorób. Medycy mogą leczyć tylko jedną chorobę na raz.


## Efekty chorób
Każda choroba ma swoje efekty. Tworząc chorobę możemy wykorzystać wcześniej już stworzone funkcje odpowiadające za wywołanie danych efektów, oraz określich ich parametry.
Na efekt choroby składają się:
- ActivateCallback - funkcja, która zostanie wywołana podczas aktywacji efektu
- DeactivateCallback - funkcja, która zostanie wywołana podczas deaktywacji efektu
- MinTime - minimalny czas między wywołaniami efektu
- TimeRange - losowy okres czasu dodawany do MinTime, podczas określania czasu między efektami
- Pernament - czy efekty choroby jest stały (nie wywołuje się okresowo, tylko aktywuje się podczas złapania choroby i deaktywuje po jej wyleczeniu)
- ContagiousRange - promień w którym gracze mogą zarazić się chorobą od nosiciela
- InfectionChance - szansa na zarażenie się przy aktywacji efektu
- AdditionalValue - dodatkowa wartość używana przy wywoływaniu ActivateCallback

Są zatem dwa typy efektów: Stałe i okresowe. Okresowe są wywoływane przez cały czas trwania choroby. Stałe aktywują się po zarażeniu się a deaktywują po wyleczeniu. Okresowe wykonywane są co jakiś czas.

Efekty mogą powodować zarażenie w danym obszarze, ale nie muszą. Aby wyłączyć zarażanie w obszarze należy ustawić InfectionChance na 0.


## Zakaźność
Choroby mogą być zakaźne. Mogą zarażać na 2 sposoby: poprzez kontakt fizyczny (uderzenie bronią białą bądź pięścią), bądź drogą kropelkową (zarażają osoby w danym obszarze podczas wybranego efektu).
Szansa na zarażenie się chorobą poprzez kontakt fizyczny wynosi domyślnie 10%.
Szansa na zarażenie się chorobą drogą kropelkową jest wywoływana podczas wykonania danego efektu i zależy od ustawionych w efekcie współczynników.
Dodatkowo szanse na zarażenie mogą być modyfikowane poprzez tzw. ContagiousRatio choroby, które określa wzmocnienie/wygaszenie szans według wzoru: *[szansa na zarażenie] * ContagiousRatio*. 

## Odporność
Gracz ma określoną odporność na choroby. Odporność gracza może zostać przywrócona z pomocą zastrzyku od lekaża. Po takim zastrzyku gracz będzie odporny na kilka sytuacji zakaźnych. W przypadku otrzymania od gracza zastrzyku podczas choroby, zniweluje on na jakiś czas występowanie efektów choroby.

## Kuracje
Kuracje mogą być przeprowadzane przez medyków tylko w szpitalu. Podczas kuracji gracz nie może się ruszać oraz otrzymuje animację leżenia. Po określonym czasie, zależnym od choroby, gracz dowiaduje się, czy kuracja się powiodła, czy też nie. Szanse na pozytywne zakończenie kuracji zależą od choroby. Podczas trwania kuracji efekty choroby nie są aktywowane. Koszty kuracji są zależne od choroby, medyk może pobrać dodatkową opłatę (prowizję) za kurację, które będzie jego wynagrodzeniem. Reszta opłaty trafi do sejfu SAM-ERS.

## Komendy:
- /**zaraz [id] [choroba]** *(Administracyjna)* - Zaraża gracza chorbą. Aby wyleczyć gracza należy wpisać /zaraz [id] wylecz.
- /**uleczall** *(Administracyjna)* - Leczy wszystkich graczy z wszystkich chorób na serwerze.
- /**kuracja [id] [choroba] [prowizja]** *(tylko medycy)* - Składa propozycje kuracji choroby gracza. Gracz może akceptować kurację za pomocą komendy /akceptuj kuracja.
- /**diagnozuj [id]** *(tylko medycy)* - Diagnozuje choroby gracza.
- /**zastrzyk [id]** *(tylko medycy)* - Zmieniono działanie komendy - komenda zwiększa odporność gracza, gdy ten jest zdrowy, lub usuwa na jakiś czas objawy jego choroby (gdy ten jest chory).

## Dodawanie nowych chorób

Aby dodać nową chorobę należy edytować plik *choroby.hwn*:
- Dodać nowy rekord w typie wyliczeniowym eDiseases
- Dodać nowy rekord w tablicy DiseaseData
- Dodać efekty do stworzonej choroby w funkcji *choroby_InitEffects* za pomocą funkcji *AddEffect*

## Dodawanie nowych efektów
Aby dodać nowy efekt należy stworzyć publiczną funkcję o sygnaturze NazwaEfektu(playerid, disease, value). Następnie można używać nazwy tej funkcji jako callback'u podczas dodawania efektów za pomocą fukcji *AddEffect*.