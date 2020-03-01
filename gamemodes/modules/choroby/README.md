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

Każda choroba może wywoływać dowolną liczbę efektów. Gracz może być jednocześnie zarażony dowolną liczbą chorób. Medycy mogą leczyć tylko jedną chorobę na raz.


## Efekty chorób
Każda choroba ma swoje efekty. Tworząc chorobę możemy wykorzystać wcześniej już stworzone funkcje odpowiadające za wywołanie danych efektów, oraz określić ich ich parametry.
Na efekt choroby składają się:
- ActivateCallback - funkcja, która zostanie wywołana podczas aktywacji efektu
- DeactivateCallback - funkcja, która zostanie wywołana podczas dezaktywacji efektu
- MinTime - minimalny czas między wywołaniami efektu
- TimeRange - losowy okres czasu dodawany do MinTime, podczas określania czasu między efektami
- Pernament - czy efekty choroby jest stały (nie wywołuje się okresowo, tylko aktywuje się podczas złapania choroby i dezaktywuje po jej wyleczeniu)
- ContagiousRange - promień w którym gracze mogą zarazić się chorobą od nosiciela
- InfectionChance - szansa na zarażenie się przy aktywacji efektu
- AdditionalValue - dodatkowa wartość używana przy wywoływaniu ActivateCallback

Są zatem dwa typy efektów: Stałe i okresowe. Okresowe są wywoływane przez cały czas trwania choroby. Stałe aktywują się po zarażeniu się a dezaktywują po wyleczeniu. Okresowe wykonywane są co jakiś czas.

Efekty mogą powodować zarażenie w danym obszarze, ale nie muszą. Aby wyłączyć zarażanie w obszarze należy ustawić InfectionChance na 0.


## Zakaźność
Choroby mogą być zakaźne. Mogą zarażać na 2 sposoby: poprzez kontakt fizyczny (uderzenie bronią białą bądź pięścią), bądź drogą kropelkową (zarażają osoby w danym obszarze podczas wybranego efektu).
Szansa na zarażenie się chorobą poprzez kontakt fizyczny wynosi domyślnie 10%.
Szansa na zarażenie się chorobą drogą kropelkową jest wywoływana podczas wykonania danego efektu i zależy od ustawionych w efekcie współczynników.
Dodatkowo szanse na zarażenie mogą być modyfikowane poprzez tzw. ContagiousRatio choroby, które określa wzmocnienie/wygaszenie szans według wzoru: *[szansa na zarażenie] * ContagiousRatio*. 

## Odporność
Gracz ma określoną odporność na choroby. Odporność gracza może zostać przywrócona z pomocą zastrzyku od lekarza. Po takim zastrzyku gracz będzie odporny na kilka sytuacji zakaźnych. W przypadku otrzymania od gracza zastrzyku podczas choroby, zniweluje on na jakiś czas występowanie efektów choroby.

## Kuracje
Kuracje mogą być przeprowadzane przez medyków tylko w szpitalu. Podczas kuracji gracz nie może się ruszać oraz otrzymuje animację leżenia. Po określonym czasie, zależnym od choroby, gracz dowiaduje się, czy kuracja się powiodła, czy też nie. Szanse na pozytywne zakończenie kuracji zależą od choroby. Podczas trwania kuracji efekty choroby nie są aktywowane. Koszty kuracji są zależne od choroby, medyk może pobrać dodatkową opłatę (prowizję) za kurację, które będzie jego wynagrodzeniem. Reszta opłaty trafi do sejfu SAM-ERS.

## Komendy:
- /**zaraz [id] [choroba]** *(Administracyjna)* - Zaraża gracza chorobą. Aby wyleczyć gracza należy wpisać /zaraz [id] wylecz.
- /**uleczall** *(Administracyjna)* - Leczy wszystkich graczy z wszystkich chorób na serwerze.
- /**kuracja [id] [choroba] [prowizja]** *(tylko medycy 2 ranga)* - Składa propozycje kuracji choroby gracza. Gracz może akceptować kurację za pomocą komendy /akceptuj kuracja.
- /**diagnozuj [id]** *(tylko medycy)* - Diagnozuje choroby gracza.
- /**zastrzyk [id]** *(tylko medycy 1 ranga)* - Zmieniono działanie komendy - komenda zwiększa odporność gracza, gdy ten jest zdrowy, lub usuwa na jakiś czas objawy jego choroby (gdy ten jest chory).

## Dodawanie nowych chorób

Aby dodać nową chorobę należy edytować plik *choroby.hwn*:
- Dodać nowy rekord w typie wyliczeniowym eDiseases
- Dodać nowy rekord w tablicy DiseaseData
- Dodać efekty do stworzonej choroby w funkcji *choroby_InitEffects* za pomocą funkcji *AddEffect*

## Dodawanie nowych efektów
Aby dodać nowy efekt należy stworzyć publiczną funkcję o sygnaturze NazwaEfektu(playerid, disease, value). Następnie można używać nazwy tej funkcji jako callback'u podczas dodawania efektów za pomocą funkcji *AddEffect*.


## Zaimplementowane choroby

| Nazwa | Koszt kuracji | Czas kuracji | Zaraźliwość | Zarażanie przy kontakcie | Efekty | Sposób zarażenia |
| :-----: |:-----:|:-----:| :-----:| :-----:| :-----:| :-----:|
| Koronawirus | 25.000$ | 2 minuty | 1.0 | tak | [efekty](#efekty-koronawirusa) | Komenda /zjedz nietoperza i do ugotowania |
| Grypa | 50.000$ | 5 minut | 1.0 | nie | [efekty](#efekty-grypy) | Jeżeli gracz przez godzinę będzie pozostawał z HP mniejszym niż 10
| Zatrucie | 50.000$ | 5 minut | 1.0 | nie | [efekty](#efekty-zatrucia) | Gdy gracz zje coś nieświeżego (?) 
| Padaczka | 500.000$ | 20 minut | 0.0 | nie | [efekty](#efekty-padaczki) | Niewielka szansa podczas otrzymania postrzału w głowę |
| Zespół Touretta | 500.000$ | 20 minut | 0.0 | nie | [efekty](#efekty-touretta) | Gdy gracz przekroczy licznik przekleństw na chatach IC powyżej 30 na godzinę |
| Astma | 500.000$ | 20 minut | 0.0 | nie | [efekty](#efekty-astmy) | nie wiem |
| Schizofrenia paranoidalna | 1.500.000$ | 30 minut | 0.0 | nie | [efekty](#efekty-schizofrenii) | Gdy gracz zażywa za dużo narkotyków |
| Epidemia zombie | 1.000$ | 5 minut | 1.0 | tak | [efekty](#efekty-zombie) | Tylko od admina |
| HIV | 1.000.000$ | 30 minut | 1.0 | tak | [efekty](#efekty-zombie) | Podczas seksu bez zabezpieczeń |

### Efekty koronawirusa


### Efekty grypy
| Nazwa efektu | Opis efektu | Akcja /me | Częstotliwośc występowania | Zasięg zarażania | Szansa na infekcję |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Słabość (FeelingBadEffect) | Gracz odtwarza animację zmęczenia | Poczuł się źle | 5 ± 10 minut | - | - | - |
| Kaszel (CouchingEffect) | Gracz odtwarza animację kaszlania | Zaczyna kaszleć. | 20 ± 20 minut  | - | - | - |
| Utrata 10 hp (HPLossEffect) | Gracz traci 10 punktów hp bez możliwości śmierci. | Zaczyna kaszleć krwią. | 60 ± 120 minut | 5.0 | 10 |

### Efekty zatrucia
| Nazwa efektu | Callback | Częstotliwośc występowania | Efekt trwały | Zasięg zarażania | Szansa na infekcję | Dodatkowa wartość |
| :-----: |:-----:|:-----:| :-----:| :-----:| :-----:| :-----:|
| - | - | - | - | - | - | - |

### Efekty padaczki
| Nazwa efektu | Callback | Częstotliwośc występowania | Efekt trwały | Zasięg zarażania | Szansa na infekcję | Dodatkowa wartość |
| :-----: |:-----:|:-----:| :-----:| :-----:| :-----:| :-----:|
| - | - | - | - | - | - | - |

### Efekty touretta
| Nazwa efektu | Callback | Częstotliwośc występowania | Efekt trwały | Zasięg zarażania | Szansa na infekcję | Dodatkowa wartość |
| :-----: |:-----:|:-----:| :-----:| :-----:| :-----:| :-----:|
| - | - | - | - | - | - | - |

### Efekty astmy
| Nazwa efektu | Callback | Częstotliwośc występowania | Efekt trwały | Zasięg zarażania | Szansa na infekcję | Dodatkowa wartość |
| :-----: |:-----:|:-----:| :-----:| :-----:| :-----:| :-----:|
| - | - | - | - | - | - | - |

### Efekty schizofrenii
| Nazwa efektu | Callback | Częstotliwośc występowania | Efekt trwały | Zasięg zarażania | Szansa na infekcję | Dodatkowa wartość |
| :-----: |:-----:|:-----:| :-----:| :-----:| :-----:| :-----:|
| - | - | - | - | - | - | - |

### Efekty zombie
| Nazwa efektu | Callback | Częstotliwośc występowania | Efekt trwały | Zasięg zarażania | Szansa na infekcję | Dodatkowa wartość |
| :-----: |:-----:|:-----:| :-----:| :-----:| :-----:| :-----:|
| - | - | - | - | - | - | - |

## Zaimplementowane efekty

### FeelingBadEffect
Gracz odtwarza animację zmęczenia oraz /me poczuł się źle




