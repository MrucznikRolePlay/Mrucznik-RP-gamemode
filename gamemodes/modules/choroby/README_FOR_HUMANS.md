# System chorób

Na serwer został wprowadzony system chorób. Umożliwia on zarażenie gracza dowolną liczbą chorób, które powodują objawy okresowe lub stałe.

## Choroby
Choroby posiadają następujące parametry:
- koszt kuracji
- czas potrzebny na przeprowadzenie kuracji i wyleczenie gracza
- lekoodporność - szansa na to, że kuracja się nie uda
- zaraźliwość [rozdziale "Zakaźność"](#zaka%c5%bano%c5%9b%c4%87)
- przenoszenie choroby poprzez kontakt (uderzenie gracza pięścią lub bronią białą)
- objawy, które wywołuje choroba

Każda choroba może wywoływać dowolną liczbę objawów. Gracz może być jednocześnie zarażony dowolną liczbą chorób. Medycy mogą leczyć tylko jedną chorobę na raz.


## Objawy chorób
Na objaw choroby składają się:
- okres czasu, co który objaw będzie wywoływany
- czy objawy choroby jest stały (nie wywołuje się okresowo, tylko aktywuje się podczas złapania choroby i dezaktywuje po jej wyleczeniu)
- odległość w którym gracze mogą zarazić się chorobą od nosiciela
- szansa na zarażenie się osób postronnych, któe są w zasięgu podczas aktywacji objawu

Są zatem dwa typy objawów: Stałe i okresowe. Okresowe są wywoływane przez cały czas trwania choroby. Stałe aktywują się po zarażeniu się a dezaktywują po wyleczeniu.
Aktywacja objawu może powodować zarażanie graczy, którzy stoją obok.


## Zakaźność
Choroby mogą być zakaźne. Mogą zarażać na 2 sposoby: poprzez kontakt fizyczny (uderzenie bronią białą bądź pięścią), bądź drogą kropelkową (zarażają osoby w danym obszarze podczas wybranego objawu).
Szansa na zarażenie się chorobą poprzez kontakt fizyczny wynosi domyślnie 10%, ale może różnić się w zależności od choroby.
Szansa na zarażenie się chorobą drogą kropelkową jest wywoływana podczas wywołania danego objawu i zależy od szans na zarażenie ustawionych w efekcie.

## Odporność
Gracz ma określoną odporność na choroby. Odporność gracza może zostać przywrócona z pomocą zastrzyku od lekarza. Po takim zastrzyku gracz będzie odporny na kilka sytuacji zakaźnych. W przypadku otrzymania od gracza zastrzyku podczas choroby, zniweluje on na jakiś czas występowanie objawów choroby.

## Kuracje
Kuracje mogą być przeprowadzane przez medyków tylko w szpitalu. Podczas kuracji gracz otrzymuje animację leżenia oraz musi znajdować się przy medyku. Po określonym czasie, zależnym od choroby, gracz dowiaduje się, czy kuracja się powiodła, czy też nie. Szanse na pozytywne zakończenie kuracji zależą od choroby. Podczas trwania kuracji objawy choroby nie są aktywowane. Koszty kuracji są zależne od choroby, medyk może pobrać dodatkową opłatę (prowizję) za kurację, które będzie jego wynagrodzeniem. Reszta opłaty trafi do sejfu SAM-ERS.

## Komendy:
- /**zaraz [id] [choroba]** *(Administracyjna)* - Zaraża gracza chorobą. Aby wyleczyć gracza należy wpisać /zaraz [id] wylecz.
- /**uleczall** *(Administracyjna)* - Leczy wszystkich graczy z wszystkich chorób na serwerze.
- /**kuracja [id] [choroba] [prowizja]** *(tylko medycy 2 ranga)* - Składa propozycje kuracji choroby gracza. Gracz może akceptować kurację za pomocą komendy /akceptuj kuracja.
- /**diagnozuj [id]** *(tylko medycy)* - Diagnozuje choroby gracza.
- /**zastrzyk [id]** *(tylko medycy 1 ranga)* - Zmieniono działanie komendy - komenda zwiększa odporność gracza, gdy ten jest zdrowy, lub usuwa na jakiś czas objawy jego choroby (gdy ten jest chory).
- /**maseczka [id] [cena]** *(tylko medycy 1 ranga)* - Oferuje graczowi sprzedaż maseczki. Maseczka ustawia odporność gracza na 10. Maseczkę może nosić tylko zdrowy gracz.


## Choroby
| Nazwa | Koszt kuracji | Czas kuracji | Lekoodporność | Zaraźliwa | Zarażanie przy kontakcie | objawy | Sposób zarażenia |
| :-----: |:-----:|:-----:| :-----:| :-----:| :-----:| :-----:| :-----:|
| Koronawirus | 1000$ | 20 sekund | 95% | tak | tak | [objawy](#objawy-koronawirusa) | 50% szans przy zjedzeniu nietoperza z Wuhan w pięciu smakach |
| Grypa | 25.000$ | 2 minuty | 0% | tak | nie | [objawy](#objawy-grypy) | Jeżeli gracz przez godzinę będzie pozostawał z HP mniejszym niż 20 |
| Zapalenie płuc | 100.000$ | 4 minuty | 30% | tak | nie | [objawy](#objawy-zapalenia-płuc) | Przy objawach grypy (kaszel) 5% |
| Zatrucie | 10.000$ | 30 sekund | 20% | tak | nie | [objawy](#objawy-zatrucia) | 5% szans na zarażenie przy /zjedz
| Padaczka | 200.000$ | 10 minut | 10% | nie | nie | [objawy](#objawy-padaczki) | Niewielka szansa (0.5%) podczas otrzymania postrzału w głowę |
| Zespół Touretta | 100.000$ | 5 minut | 50% | nie | nie | [objawy](#objawy-touretta) | Gdy gracz przekroczy licznik przekleństw na chatach IC powyżej 60 na godzinę |
| Astma | 25.000$ | 1 minuta | 40% | nie | nie | [objawy](#objawy-astmy) | Śmierć przez utopienie 50% |
| Schizofrenia paranoidalna | 300.000$ | 20 minut | 5% | nie | nie | [objawy](#objawy-schizofrenii) | 2% szans gdy gracz zażywa narkotyki |
| Epidemia zombie | 1.000$ | 30 sekund | 10% | bardzo | tak | [objawy](#objawy-zombie) | Tylko od admina |
| HIV | 100.000$ | 5 minut | 1% | tak | tak | [objawy](#objawy-zombie) | Podczas seksu bez zabezpieczeń |
| Astygmatyzm | 100.000$ | 7 minut | 45% | nie | nie | [objawy](#objawy-astygmatyzmu) | 0.01% przy strzelaniu |
| Parkinson/Niedowład rąk | 150.000$ | 10 minut | 25% | nie | nie | [objawy](#objawy-parkinsona) | 0.1% podczas dostania w rękę + 1% szans przy objawach gangreny |
| Uraz | 10.000$ | 1 minuta | 0% | nie | nie | [objawy](#objawy-urazu) | 5% szans podczas BW |
| Gangrena | 75.000$ | 2 minut | 75% | nie | tak | [objawy](#objawy-gangreny) | 5% szans podczas objawów urazu |
| PTSD | 15.000$ | 1 minut | 90% | nie | nie | [objawy](#objaw-PTSD) | Gdy gracz zabije 10 osób w ciągu 10minut ma 20% szans na PTSD |

### Objawy koronawirusa
| Nazwa objawu | Opis objawu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Wuhański kaszel | Gracz kaszle | /me zaczyna kaszleć. | 2 + 0-5 minut | duży | 50% |
| Duszności | Graczy się dusi | /me zaczyna się dusić. | 5 + 0-10 minut | mały | 50% |
| Gorączka | Utrata HP | /me ma gorączkę, poci się i czuje się słabo. | 10 + 0-20 minut | mały | 50% |
| Die potato | Gracz traci hp aż do śmierci | /do koronawirus doszczętnie wyniszczył organizm John_Mrucznik. | 20 + 0-40 minut | duży | 100% |


### Objawy grypy
| Nazwa objawu | Opis objawu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Słabość (FeelingBadEffect) | Gracz odtwarza animację zmęczenia |  /me poczuł się źle | 5 + 0-10 minut | mały | 20% |
| Kaszel (CouchingEffect) | Gracz odtwarza animację kaszlania | /me zaczyna kaszleć. | 10 + 0-20 minut  | duży | 20% |
| Utrata 10 hp (HPLossEffect) | Gracz traci 10 punktów hp bez możliwości śmierci. | /me zaczyna kaszleć krwią. | 20 + 0-40 minut | średni | 50% |

### Objawy zapalenia płuc
| Nazwa objawu | Opis objawu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Słabość (FeelingBadEffect) | Gracz odtwarza animację zmęczenia | /me poczuł się źle | 5 + 0-10 minut | mały | 20% |
| Kaszel (CouchingEffect) | Gracz odtwarza animację kaszlania | /me zaczyna kaszleć. | 10 + 0-20 minut  | duży | 30% |
| Utrata 10 hp (HPLossEffect) | Gracz traci 10 punktów hp bez możliwości śmierci. | /me zaczyna kaszleć krwią. | 20 + 0-40 minut | średni | 40% |

### Objawy zatrucia
| Nazwa objawu | Opis objawu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Afrodyzjak | Gracz brzydko pachnie | /do wokół John_Mrucznik unosi się nieprzyjemna woń przetrawionego jedzenia. | 5 + 0-10 minut  | - | - |
| Incydent kałowy | Gracz sra | /do z nogawki John_Mrucznik cieknie brązowy płyn. | 10 + 0-20 minut  | bardzo mały | 25% |
| Potężna sraczka | Gracz sra | /me nie wytrzymuje ciśnienia i zaczyna defekować się w spodnie. | 20 + 0-40 minut  | mały | 50% |
| Ból brzucha | Gracz traci hp | /me poczuł silne ukłucie w okolicach brzucha. | 20 + 0-40 minut  | - | - |
| Wymioty | Gracz wymiotuje | /me zaczyna wymiotować. | 5 + 0-10 minut | mały | 80% |

### Objawy padaczki
| Nazwa objawu | Opis objawu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Padaka | Gracz upada na ziemie i odtwarza animację padaczki, traci część HP i jest zamrożony na 1-2min | upada na ziemię i zaczyna trząść się i wykonywać niekontrolowane ruchy | 20 + 0-20 minut | - | - |

### Objawy touretta
| Nazwa objawu | Opis objawu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Losowe kurwienie | Podczas wypowiadania się na chacie IC losowo dodawane są do wypowiedzi wulgaryzmy | - | objaw stały | - | - |
| Niekontrolowane teksty | Gracz pisze na chacie IC teksty typowe dla Touretta | - | 1 + 0-5 minut  | - | - |

### Objawy astmy
| Nazwa objawu | Opis objawu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Duszenie się | Gracz odtwarza animacje duszenia i traci hp | - | 20 + 0-40 minut  | - | - |
| Wstrząs anafilaktyczny | Gracz odtwarza animacje duszenia i powoli traci hp aż do śmierci, lub gdy coś go uleczy | - | 40 + 0-80 minut  | - | - |

### Objawy schizofrenii
| Nazwa objawu | Opis objawu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Pelikany mnie gonią | Zmienia pogodę na dziwną | /me zaczyna widzieć niestworzone rzeczy. | 10 + 0-20 minut | - | - |

### Objawy zombie
| Nazwa objawu | Opis objawu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Mowa zombie | Nie gotowe. | - | 1 + 0-3 minut | - | - |
| Skin zombie | Nie gotowe. | - | objaw stały | - | - |

### Objawy HIV
| Nazwa objawu | Opis objawu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Obniżona odporność | Gracz traci odporność | /me czuje, że jego organizm ma obniżoną odporność. | 5 + 0-10 minut | - | - |
| Wyłapywanie chorób | Gracz zapada na losową chorobę | - | 60 + 0-80 minut | - | - |

### Objawy astygmatyzmu
| Nazwa objawu | Opis objawu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Celne oko | Gracz ma obniżony skill karabinów maszynowych i karabinów | - | objaw stały | - | - |

### Objawy parkinsona
| Nazwa objawu | Opis objawu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Pewna ręka | Gracz ma obniżony skill wszystkich broni | - | objaw stały | - | - |
| Drgawki | Ręce gracza zaczynają się trząść | /do ręcę John_Mrucznik zaczynają się trząść w niekontrolowany przez niego sposób | 5 + 0-10 minut | - | - |

### Objawy urazu
| Nazwa objawu | Opis objawu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Krwawienie | Gracz krwawi z rany | /do Z rany John_Mrucznik zaczyna płynąć krew. | 5 + 0-10 minut  | - | - |
| Słabość (FeelingBadEffect) | Gracz odtwarza animację zmęczenia | /me poczuł się źle | 10 + 0-20 minut | - | - |
| Omdlenie | Gracz traci na chwilę przytomność | /me omdlał. | 20 + 0-40 minut  | - | - |
| Rozwój choroby | Gracz ma szansę zarazić się gangreną | - | 10 + 0-20 minut | - | - |

### Objawy gangreny
| Nazwa objawu | Opis objawu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Ropienie | Graczowi wycieka ropa z rany, gracz traci hp. | /do z rany John_Mrucznik zaczyna wyciekać ropa. | 5 + 0-10 minut | - | - |
| Utrata hp | Gracz traci hp z możliwością śmierci. | /me gorączkuje a zjego rany wydobywa się smród zgnilizny. | 10 + 0-20 minut | - | - |
| Omdlenie | Gracz traci na chwilę przytomność | /me omdlał. | 10 + 0-20 minut  | - | - |

### Objawy PTSD
| Nazwa objawu | Opis objawu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| Strach | Gracz krzyczy i chowa obecnie trzymaną broń | /k RATUNKU, POMOCY, TO ZNOWU ONI! | 5 + 0-10 minut | - | - |
| Flashback | Gracz krzyczy i wyrzuca trzymaną broń | /me przerażony tym co zrobił, wyrzuca trzymaną broń. | 10 + 0-20 minut | - | - |
| Rozbrojenie | Gracz wyrzuca bronie | /me panikuje i pozbywa się wszelkiego uzbrojenia. | 20 + 0-40 minut | - | - |
| Stan lękowy | Gracz odtwarza animacje krycia się. | /me zaczyna odczuwać irracjonalny strach. | 5 + 0-10 minut | - | - |

### Objawy obłędu
| Nazwa objawu | Opis objawu | Akcja | Częstotliwośc występowania | Zasięg zarażania | Szansa na zarażenie [w procentach] |
| :-----: |:-----:|:-----:|:-----:|:-----:| :-----:|
| - | - | - | - | - | - |