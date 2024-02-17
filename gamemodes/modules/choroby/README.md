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
- /**maseczka [id] [cena]** *(tylko medycy 1 ranga)* - Oferuje graczowi sprzedaż maseczki. Maseczka ustawia odporność gracza na 10.

## Dodawanie nowych chorób

Aby dodać nową chorobę należy edytować plik *choroby.hwn*:
- Dodać nowy rekord w typie wyliczeniowym eDiseases
- Dodać nowy rekord w tablicy DiseaseData
- Dodać efekty do stworzonej choroby w funkcji *choroby_InitEffects* za pomocą funkcji *AddEffect*

## Dodawanie nowych efektów
Aby dodać nowy efekt należy stworzyć publiczną funkcję o sygnaturze NazwaEfektu(playerid, disease, value). Następnie można używać nazwy tej funkcji jako callback'u podczas dodawania efektów za pomocą funkcji *AddEffect*.


## Choroby
| Nazwa | Koszt kuracji | Czas kuracji | Lekoodporność | Zaraźliwość | Zarażanie przy kontakcie | Efekty | Sposób zarażenia |
| :-----: |:-----:|:-----:| :-----:| :-----:| :-----:| :-----:| :-----:|
| Koronawirus | 1000$ | 20 sekund | 60% | 1.0 | tak | [efekty](#efekty-koronawirusa) | tylko przez admina |
| Grypa | 25.000$ | 2 minuty | 0% | 1.0 | nie | [efekty](#efekty-grypy) | Jeżeli gracz przez godzinę będzie pozostawał z HP mniejszym niż 20 |
| Zapalenie płuc | 100.000$ | 4 minuty | 30% | 1.0 | nie | [efekty](#efekty-zapalenia-płuc) | Przy efektach grypy (kaszel) 5% |
| Zatrucie | 10.000$ | 30 sekund | 20% | 1.0 | nie | [efekty](#efekty-zatrucia) | 5% szans na zarażenie przy /zjedz
| Padaczka | 200.000$ | 10 minut | 10% | 0.0 | nie | [efekty](#efekty-padaczki) | Niewielka szansa (0.5%) podczas otrzymania postrzału w głowę |
| Zespół Touretta | 100.000$ | 5 minut | 50% | 0.0 | nie | [efekty](#efekty-touretta) | Gdy gracz przekroczy licznik przekleństw na chatach IC powyżej 60 na godzinę |
| Astma | 25.000$ | 1 minuta | 40% | 0.0 | nie | [efekty](#efekty-astmy) | Śmierć przez utopienie 50% |
| Schizofrenia paranoidalna | 300.000$ | 20 minut | 5% | 0.0 | nie | [efekty](#efekty-schizofrenii) | 2% szans gdy gracz zażywa narkotyki |
| Epidemia zombie | 1.000$ | 30 sekund | 10% | 50.0 | tak | [efekty](#efekty-zombie) | Tylko od admina |
| HIV | 100.000$ | 5 minut | 1% | 0.3 | tak | [efekty](#efekty-zombie) | Podczas seksu bez zabezpieczeń |
| Astygmatyzm | 100.000$ | 7 minut | 45% | 0.0 | nie | [efekty](#efekty-astygmatyzmu) | 0.01% przy strzelaniu |
| Parkinson/Niedowład rąk | 150.000$ | 10 minut | 25% | 0.0 | nie | [efekty](#efekty-parkinsona) | 0.1% podczas dostania w rękę + 1% szans przy efektach gangreny |
| Uraz | 10.000$ | 1 minuta | 0% | 0.0 | nie | [efekty](#efekty-urazu) | 5% szans podczas BW |
| Gangrena | 75.000$ | 2 minut | 75% | 0.1 | tak | [efekty](#efekty-gangreny) | 5% szans podczas efektów urazu |
| PTSD | 15.000$ | 1 minut | 85% | 0.0 | nie | [efekty](#efekt-PTSD) | Gdy gracz zabije 10 osób w ciągu 10minut ma 20% szans na PTSD |
| Obłęd - TODO | 0$ | 0 minut | 0% | 0.0 | nie | [efekty](#efekt-obłędu) | TODO |

### Efekty koronawirusa
| Nazwa efektu | Opis efektu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Wuhański kaszel | Gracz kaszle | /me zaczyna kaszleć. | 2 + 0-5 minut | 10.0 | 50 |
| Duszności | Graczy się dusi | /me zaczyna się dusić. | 5 + 0-10 minut | 3.0 | 50 |
| Gorączka | Utrata HP | /me czuje się słabo. | 10 + 0-20 minut | 3.0 | 50 |
| Die potato | Gracz traci hp aż do śmierci | /do koronawirus doszczętnie wyniszczył organizm John_Mrucznik. | 20 + 0-40 minut | 10.0 | 100 |


### Efekty grypy
| Nazwa efektu | Opis efektu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Słabość (FeelingBadEffect) | Gracz odtwarza animację zmęczenia |  /me poczuł się źle | 5 + 0-10 minut | 3.0 | 20 |
| Kaszel (CouchingEffect) | Gracz odtwarza animację kaszlania | /me zaczyna kaszleć. | 10 + 0-20 minut  | 15.0 | 20 |
| Utrata 10 hp (HPLossEffect) | Gracz traci 10 punktów hp bez możliwości śmierci. | /me zaczyna kaszleć krwią. | 20 + 0-40 minut | 5.0 | 50 |

### Efekty zapalenia płuc
| Nazwa efektu | Opis efektu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Słabość (FeelingBadEffect) | Gracz odtwarza animację zmęczenia | /me poczuł się źle | 5 + 0-10 minut | 3.0 | 20 |
| Kaszel (CouchingEffect) | Gracz odtwarza animację kaszlania | /me zaczyna kaszleć. | 10 + 0-20 minut  | 15.0 | 30 |
| Utrata 10 hp (HPLossEffect) | Gracz traci 10 punktów hp bez możliwości śmierci. | /me zaczyna kaszleć krwią. | 20 + 0-40 minut | 5.0 | 40 |

### Efekty zatrucia
| Nazwa efektu | Opis efektu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Afrodyzjak | Gracz brzydko pachnie | /do wokół John_Mrucznik unosi się nieprzyjemna woń przetrawionego jedzenia. | 5 + 0-10 minut  | - | - |
| Incydent kałowy | Gracz sra | /do z nogawki John_Mrucznik cieknie brązowy płyn. | 10 + 0-20 minut  | 2.0 | 25 |
| Potężna sraczka | Gracz sra | /me nie wytrzymuje ciśnienia i zaczyna defekować się w spodnie. | 20 + 0-40 minut  | 3.0 | 50 |
| Ból brzucha | Gracz traci hp | /me poczuł silne ukłucie w okolicach brzucha. | 20 + 0-40 minut  | - | - |
| Wymioty | Gracz wymiotuje | /me zaczyna wymiotować. | 5 + 0-10 minut | 3.0 | 80 |

### Efekty padaczki
| Nazwa efektu | Opis efektu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Padaka | Gracz upada na ziemie i odtwarza animację padaczki, traci część HP i jest zamrożony na 1-2min | upada na ziemię i zaczyna trząść się i wykonywać niekontrolowane ruchy | 20 + 0-20 minut | - | - |

### Efekty touretta
| Nazwa efektu | Opis efektu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Losowe kurwienie | Podczas wypowiadania się na chacie IC losowo dodawane są do wypowiedzi wulgaryzmy | - | efekt stały | - | - |
| Niekontrolowane teksty | Gracz pisze na chacie IC teksty typowe dla Touretta | - | 1 + 0-5 minut  | - | - |

### Efekty astmy
| Nazwa efektu | Opis efektu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Duszenie się | Gracz odtwarza animacje duszenia i traci hp | - | 20 + 0-40 minut  | - | - |
| Wstrząs anafilaktyczny | Gracz odtwarza animacje duszenia i powoli traci hp aż do śmierci, lub gdy coś go uleczy | - | 40 + 0-80 minut  | - | - |

### Efekty schizofrenii
| Nazwa efektu | Opis efektu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Pelikany mnie gonią | Zmienia pogodę na dziwną | /me zaczyna widzieć niestworzone rzeczy. | 10 + 0-20 minut | - | - |

### Efekty zombie
| Nazwa efektu | Opis efektu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Mowa zombie | Zmienia wypowiedziane słowa na łee bee ree itd. | - | 1 + 0-3 minut | - | - |
| Skin zombie | Dostaje skin zombie zależny od płci | - | efekt stały | - | - |

### Efekty HIV
| Nazwa efektu | Opis efektu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Obniżona odporność | Gracz traci odporność | /me czuje, że jego organizm ma obniżoną odporność. | 5 + 0-10 minut | - | - |
| Wyłapywanie chorób | Gracz zapada na losową chorobę | - | 60 + 0-80 minut | - | - |

### Efekty astygmatyzmu
| Nazwa efektu | Opis efektu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Celne oko | Gracz ma obniżony skill karabinów maszynowych i karabinów | - | efekt stały | - | - |

### Efekty parkinsona
| Nazwa efektu | Opis efektu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Pewna ręka | Gracz ma obniżony skill wszystkich broni | - | efekt stały | - | - |
| Drgawki | Ręce gracza zaczynają się trząść | /do ręcę John_Mrucznik zaczynają się trząść w niekontrolowany przez niego sposób | 5 + 0-10 minut | - | - |

### Efekty urazu
| Nazwa efektu | Opis efektu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Krwawienie | Gracz krwawi z rany | /do Z rany John_Mrucznik zaczyna płynąć krew. | 5 + 0-10 minut  | - | - |
| Słabość (FeelingBadEffect) | Gracz odtwarza animację zmęczenia | /me poczuł się źle | 10 + 0-20 minut | - | - |
| Omdlenie | Gracz traci na chwilę przytomność | /me omdlał. | 20 + 0-40 minut  | - | - |
| Rozwój choroby | Gracz ma szansę zarazić się gangreną | - | 10 + 0-20 minut | - | - |

### Efekty gangreny
| Nazwa efektu | Opis efektu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Ropienie | Graczowi wycieka ropa z rany, gracz traci hp. | /do z rany John_Mrucznik zaczyna wyciekać ropa. | 5 + 0-10 minut | - | - |
| Utrata hp | Gracz traci hp z możliwością śmierci. | /me gorączkuje a zjego rany wydobywa się smród zgnilizny. | 10 + 0-20 minut | - | - |
| Omdlenie | Gracz traci na chwilę przytomność | /me omdlał. | 10 + 0-20 minut  | - | - |

### Efekty PTSD
| Nazwa efektu | Opis efektu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Strach | Gracz krzyczy i chowa obecnie trzymaną broń | /k RATUNKU, POMOCY, TO ZNOWU ONI! | 5 + 0-10 minut | - | - |
| Flashback | Gracz krzyczy i wyrzuca trzymaną broń | /me przerażony tym co zrobił, wyrzuca trzymaną broń. | 10 + 0-20 minut | - | - |
| Rozbrojenie | Gracz wyrzuca bronie | /me panikuje i pozbywa się wszelkiego uzbrojenia. | 20 + 0-40 minut | - | - |
| Stan lękowy | Gracz odtwarza animacje krycia się. | /me zaczyna odczuwać irracjonalny strach. | 5 + 0-10 minut | - | - |

### Efekty obłędu
| Nazwa efektu | Opis efektu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| - | - | - | - | - | - |

## Pomysły na przyszłe modyfikacje
- możliwośc opracowywania nowych chorób przez graczy na podstawie istniejących efektów
- choroby mutują i powstają nowe, z innymi efektami
- gracze mogą zarażać się strzykawką z wirusem
- medycy muszą opracowywać leki na choroby, im bardziej poznają chorobę tym bardziej zmniejsza się jej lekoodporność