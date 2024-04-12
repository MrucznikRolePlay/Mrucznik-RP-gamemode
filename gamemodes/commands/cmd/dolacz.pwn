//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ dolacz ]------------------------------------------------//
//----------------------------------------------------*------------------------------------------------------//
//----[                                                                                                 ]----//
//----[         |||||             |||||                       ||||||||||       ||||||||||               ]----//
//----[        ||| |||           ||| |||                      |||     ||||     |||     ||||             ]----//
//----[       |||   |||         |||   |||                     |||       |||    |||       |||            ]----//
//----[       ||     ||         ||     ||                     |||       |||    |||       |||            ]----//
//----[      |||     |||       |||     |||                    |||     ||||     |||     ||||             ]----//
//----[      ||       ||       ||       ||     __________     ||||||||||       ||||||||||               ]----//
//----[     |||       |||     |||       |||                   |||    |||       |||                      ]----//
//----[     ||         ||     ||         ||                   |||     ||       |||                      ]----//
//----[    |||         |||   |||         |||                  |||     |||      |||                      ]----//
//----[    ||           ||   ||           ||                  |||      ||      |||                      ]----//
//----[   |||           ||| |||           |||                 |||      |||     |||                      ]----//
//----[  |||             |||||             |||                |||       |||    |||                      ]----//
//----[                                                                                                 ]----//
//----------------------------------------------------*------------------------------------------------------//

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

YCMD:dolacz(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
		if(PlayerInfo[playerid][pJob] == 0 )
		{
		    if(PlayerInfo[playerid][pJob] == 0 )
			{
			    if((PlayerInfo[playerid][pMember] >= 1 && PlayerInfo[playerid][pMember] <= 4) || (PlayerInfo[playerid][pMember] >= 9 && PlayerInfo[playerid][pMember] <= 11) 
					|| (PlayerInfo[playerid][pLider] >= 1 && PlayerInfo[playerid][pLider] <= 4) || (PlayerInfo[playerid][pLider] >= 9 && PlayerInfo[playerid][pLider] <= 11))
			    {
			        sendTipMessageEx(playerid, COLOR_GREY, "Musisz byæ cywilem albo cz³onkiem rodziny/mafii/gangu aby wzi¹æ pracê!");
			        return 1;
			    }
			    if (GetPlayerState(playerid) == 1 && PlayerToPoint(3.0, playerid,322.3034,317.0233,999.1484))
				{
				    if(PlayerInfo[playerid][pGunLic] == 1)
				    {
					    if(PlayerInfo[playerid][pMember] > 0 || PlayerInfo[playerid][pLider] > 0 || GetPlayerOrg(playerid) != 0) { sendTipMessageEx(playerid, COLOR_GREY, "Frakcje nie mog¹ braæ tej pracy !"); return 1; }
					    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Chcesz zostaæ £owcy¹ Nagród, lecz najpierw musisz podpisaæ kontrakt na 5 godzin.");
					    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Aby zrezygnowaæ z tej pracy musi min¹æ czas kontraktu, dopiero wtedy bêdziesz móg³ siê zwolniæ.");
					    SendClientMessage(playerid, COLOR_P@, "   -----Informacje o pracy i warunki kontraktu-----");
					    SendClientMessage(playerid, COLOR_WHITE, "   Twoje zadanie polega na œciganiu przestêpców i oferowania im poddania siê. W przypadku odmowy stosuje siê bardziej radykalne metody...");
					    SendClientMessage(playerid, COLOR_WHITE, "   Wynagrodzenie zale¿y od wysokoœci WL oraz sposobu zatrzymania (za ¿ywego dostaje siê wiêcej)");
					    SendClientMessage(playerid, COLOR_WHITE, "   Wy¿szy skill pozwala na d³u¿sze namierzanie, dostêp do bardziej niebezpiecznych przestêpców i lepszych pojazdów.");
					    SendClientMessage(playerid, COLOR_WHITE, "   Dobry ³owca nagród mo¿e zarobiæ ponad 50k w godzinê. Pocz¹tkuj¹cy jakieœ 6k-10k. Minus koszty broni. Pieni¹dze wyp³acamy od razu.");
					    SendClientMessage(playerid, COLOR_WHITE, "   Je¿eli masz trochê kasy na broñ, masz nerwy ze stali, mnóstwo sprytu i cierpliwoœci to ta wymagaj¹ca praca jest dla Ciebie.");
					    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jeœli akceptujesz zasady kontraktu wpisz /akceptuj praca.");
					    GettingJob[playerid] = 1;
					}
					else
					{
					    sendTipMessageEx(playerid, COLOR_WHITE, "Do tej pracy wymagana jest licencja na broñ");
					}
				}
				else if (GetPlayerState(playerid) == 1 && PlayerToPoint(3.0, playerid,310.3626,-1503.3282,13.8096))
				{
				    if(PlayerInfo[playerid][pMember] > 0 || PlayerInfo[playerid][pLider] > 0 || GetPlayerOrg(playerid) != 0) { sendTipMessageEx(playerid, COLOR_GREY, "Frakcje nie mog¹ braæ tej pracy !"); return 1; }
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Chcesz zostaæ Prawnikiem, lecz najpierw musisz podpisaæ kontrakt na 5 godzin.");
				    SendClientMessage(playerid, COLOR_P@, "   -----Informacje o pracy i warunki kontraktu-----");
				    SendClientMessage(playerid, COLOR_WHITE, "   Do twoich zadañ nale¿y wyci¹ganie ludzi z wiêzienia (za kaucj¹ lub bez), czyszczenia im kartotek i obni¿ania poziomów poszukiwania");
				    SendClientMessage(playerid, COLOR_WHITE, "   Praca jest legalna jednak w LS dobry prawnik to taki który zna sporo skorumpowanych gliniarzy lub ma znajomego w policji...");
				    SendClientMessage(playerid, COLOR_WHITE, "   Jako pocz¹tkuj¹cy prawnik w g³ownej mierze bêdziesz zajmowa³ siê drobnymi z³odziejaszkami, zarobki równie¿ nie sa wysokie a o klienta trudno.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Tylko najlepsi prawnicy w mieœcie maj¹ szansê na zarobki z rzêdu 200k-300k na godzinê, wiêkszoœæ zarabia ok. 30k, pieni¹dze otrzymujesz od klientów.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Wy¿szy skill umo¿liwia zbijanie wy¿szych poziomów WL, uwlanianie groŸniejszych przestêpców oraz zmniejsza koszty ³apówek.");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Aby zrezygnowaæ z tej pracy musi min¹æ czas kontraktu, dopiero wtedy bêdziesz móg³ siê zwolniæ.");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jeœli akceptujesz zasady kontraktu wpisz /akceptuj praca.");
				    GettingJob[playerid] = 2;
				}
				else if (GetPlayerState(playerid) == 1 && PlayerToPoint(3.0, playerid,1215.1304,-11.8431,1000.9219))
				{
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Chcesz zostaæ Prostytutk¹, lecz najpierw musisz podpisaæ kontrakt na 5 godzin.");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Aby zrezygnowaæ z tej pracy musi min¹æ czas kontraktu, dopiero wtedy bêdziesz móg³ siê zwolniæ.");
				    SendClientMessage(playerid, COLOR_P@, "   -----Informacje o pracy i warunki kontraktu-----");
				    SendClientMessage(playerid, COLOR_WHITE, "   Praca polega na zaspokajaniu potrzeb seksualnych mieszkañców.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Jeden z kilku wymagaj¹cyh zawodów. Nie sprowadza siê on tylko do wpisania komendy.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Tutaj najwa¿niejsze jest dobre odgrywanie na /me i /do, im bêdzie ono lepsze tym wy¿szy zarobek.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Mimo, ze praca posiada skill nie ma on tak du¿ego znaczenia. Gdy¿ nikt nie wynajmuje prostytutki aby dodaæ sobie HP.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Je¿eli potrafisz dobrze odgrywaæ akcje mo¿esz zarobiæ nawet 500k za godzinê, jednak zazwyczaj jest to 40k-70k. Pieni¹dze dostajesz od klientów.");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jeœli akceptujesz zasady kontraktu wpisz /akceptuj praca.");
				    GettingJob[playerid] = 3;
				}
				else if (GetPlayerState(playerid) == 1 && PlayerToPoint(3.0, playerid,2166.3772,-1675.3829,15.0859))
				{
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Chcesz zostaæ Dilerem Dragów, lecz najpierw musisz podpisaæ kontrakt na 5 godzin.");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Aby zrezygnowaæ z tej pracy musi min¹æ czas kontraktu, dopiero wtedy bêdziesz móg³ siê zwolniæ.");
				    SendClientMessage(playerid, COLOR_P@, "   -----Informacje o pracy i warunki kontraktu-----");
				    SendClientMessage(playerid, COLOR_WHITE, "   Masz za zadanie odbieraæ dragi z meliny i rozprowadzaæ je po ca³ym Los Santos, ty dyktujesz cenê.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Sprzedaj¹c narkotyki nie daj sie z³apac policji która tylko czeka na okazjê by przyskrzyniæ dilera.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Niestety popularnoœæ narkotyków maleje i nowy diler przy du¿ym szczêœciu zarabia ok. 7k za godzinê.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Im wy¿szy skill tym wiêcej narkotyków mo¿esz miec przy sobie, spada te¿ ich cena w melinie.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Ta praca jest najlepsza dla osób które ju¿ s¹ albo aspiruj¹ do bycia gangsterem. To co zarobisz wyp³acamy co godzinê (w Pay Day)");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jeœli akceptujesz zasady kontraktu wpisz /akceptuj praca.");
				    GettingJob[playerid] = 4;
				}
				else if (GetPlayerState(playerid) == 1 && PlayerToPoint(3.0, playerid,1109.3318,-1796.3042,16.5938))
				{
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Chcesz zostaæ Z³odziejem Aut, lecz najpierw musisz podpisaæ kontrakt na 5 godzin.");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Aby zrezygnowaæ z tej pracy musi min¹æ czas kontraktu, dopiero wtedy bêdziesz móg³ siê zwolniæ.");
				    SendClientMessage(playerid, COLOR_P@, "   -----Informacje o pracy i warunki kontraktu-----");
				    SendClientMessage(playerid, COLOR_WHITE, "   Twoje zadanie jest bardzo proste. Ukraœæ wóz i przewieœæ go w stanie nienaruszonym na statek przemytników w San Fierro.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Tylko niektóre pojazdy w Los Santos mo¿na ukraœæ. Dodatkowo przemytnicy przyjmuj¹ twoje ³upy co 20 minut.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Im wy¿szy skill tym wiêcej dostaniesz od przemytników za pojazd oraz ³atwiej bêdzie ci coœ zwêdziæ.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Warto równie¿ zaparkowaæ swój w³asny pojazd pod statkiem przemytników ¿eby mieæ czym wróciæ do Los Santos.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Zarobki to ok. 20k za godzinê, tak ma³o g³ównie dlatego ¿e to ³atwe zajêcie. To co zarobisz wyp³acamy co godzinê (w Pay Day)");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jeœli akceptujesz zasady kontraktu wpisz /akceptuj praca.");
				    GettingJob[playerid] = 5;
				}
				else if (GetPlayerState(playerid) == 1 && PlayerToPoint(3.0, playerid,-1932.3859,276.2117,41.0391) || PlayerToPoint(5.0, playerid,2769.8376,-1610.7819,10.9219))
				{
				    if(PlayerInfo[playerid][pMember] > 0 || PlayerInfo[playerid][pLider] > 0 || (GetPlayerOrg(playerid) != 0 && GetPlayerOrg(playerid) != 15)) { sendTipMessageEx(playerid, COLOR_GREY, "Frakcje nie mog¹ wzi¹c tej pracy!"); return 1; }
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Chcesz zostaæ Mechanikiem, lecz najpierw musisz podpisaæ kontrakt na 5 godzin.");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Aby zrezygnowaæ z tej pracy musi min¹æ czas kontraktu, dopiero wtedy bêdziesz móg³ siê zwolniæ.");
				    SendClientMessage(playerid, COLOR_P@, "   -----Informacje o pracy i warunki kontraktu-----");
				    SendClientMessage(playerid, COLOR_WHITE, "   Naprawiaj, tankuj, tunninguj, odbieraj zlecenia z terenu. To przede wszytkim robi mechanik.");
				    SendClientMessage(playerid, COLOR_WHITE, "   mówi¹, ¿e to najlepsza praca dla pocz¹tkuj¹cego gracza. I maj¹ racjê. Nie trzeba mieæ prawka ani doœwiadczenia. Wystarcz¹ dore chêci.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Na pocz¹tku wystarczy, ¿e pokrêcisz siê w okolicach naszej bazy lub Urzêdu Miasta oferuj¹c kierowcom tankowanie lub naprawê.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Zarobki nie s¹ na pocz¹tku osza³amiaj¹ce, jakieœ 3k-7k co godzinê. Jednak zdobywa siê je doœæ ³atwo i przyjemnie. Pracy dla mechaników nigdy nie brakuje.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Wy¿szy skill pozwala siê poruszaæ specjalnymi pojazdami oraz umo¿liwia tunningowanie pojazdów, ktore jest bardziej dochodowe ni¿ ich serwisowanie.");
				    SendClientMessage(playerid, COLOR_WHITE, "   To co zarobisz wyp³acamy co godzinê (w Pay Day). W przypadku tunningu to ty pobierasz pieni¹dze od klientów (zawsze ¿¹daj wiêcej ni¿ kosztuje us³uga).");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jeœli akceptujesz zasady kontraktu wpisz /akceptuj praca.");
				    GettingJob[playerid] = 7;
		  		}
				else if (GetPlayerState(playerid) == 1 && PlayerToPoint(3.0, playerid,2226.1716,-1718.1792,13.5165))
				{
				    if(PlayerInfo[playerid][pMember] > 0 || PlayerInfo[playerid][pLider] > 0 || GetPlayerOrg(playerid) != 0) { sendTipMessageEx(playerid, COLOR_GREY, "Frakcje nie mog¹ braæ tej pracy !"); return 1; }
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Chcesz zostaæ Ochroniarzem, lecz najpierw musisz podpisaæ kontrakt na 5 godzin.");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Aby zrezygnowaæ z tej pracy musi min¹æ czas kontraktu, dopiero wtedy bêdziesz móg³ siê zwolniæ.");
				    SendClientMessage(playerid, COLOR_P@, "   -----Informacje o pracy i warunki kontraktu-----");
				    SendClientMessage(playerid, COLOR_WHITE, "   Mo¿esz ochraniaæ ludzi, jednak jest to tylko przykrywka dla sprzedawania pancerzy - tym masz siê przede wszytkim zajmowaæ.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Praca jest doœæ monotonna gdy¿ praktycznie polega na wciskaniu wszytkim kamizelki kuloodpornej.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Podobno niektórzy przy du¿ym szczêœciu potrafia zarobiæ nawet 90k-130k. Jednak norm¹ jest 10k a przy du¿ym pechu 2k.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Praca nie posiada systemu skilla. To co zarobisz wyp³acamy co godzinê (w Pay Day).");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jeœli akceptujesz zasady kontraktu wpisz /akceptuj praca.");
				    GettingJob[playerid] = 8;
		  		}
		  		else if (GetPlayerState(playerid) == 1 && PlayerToPoint(3.0, playerid,1366.7279,-1275.4633,13.5469) && IsADilerBroni(playerid))
		  		{
		  		    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Chcesz zostaæ Dilerem Broni, lecz najpierw musisz podpisaæ kontrakt na 5 godzin.");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Aby zrezygnowaæ z tej pracy musi min¹æ czas kontraktu, dopiero wtedy bêdziesz móg³ siê zwolniæ.");
				    SendClientMessage(playerid, COLOR_P@, "   -----Informacje o pracy i warunki kontraktu-----");
				    SendClientMessage(playerid, COLOR_WHITE, "   Sprzedajesz nielegaln¹ broñ tym, którzy nie s¹ w stanie nabyæ jej w legalny sposób. Praca jest nielaglna.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Jednak zanim przyst¹pisz do sprzeda¿y musisz zdobyæ zabronione w LS materia³y. To doœæ skomplikowany proces.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Pakiet max. 10paczek odbierzesz w budynku ko³o wypo¿yczalni aut. Fabryka w Ocean Docks przerobi je na 500 materia³ów.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Dopiero z materia³ów mo¿esz wyrabiaæ broñ. Im wy¿szy skill tym lepsze broni znajd¹ sie w twojej ofercie. ");
				    SendClientMessage(playerid, COLOR_WHITE, "   Dobry diler potrafi zarobic nawet 150k w godzinê. Jednak pocz¹tkuj¹cy czêsto musz¹ dok³adaæ do interesu. Ty pobierasz pieni¹dze od klientów.");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jeœli akceptujesz zasady kontraktu wpisz /akceptuj praca.");
				    GettingJob[playerid] = 9;
		  		}
		  		else if (GetPlayerState(playerid) == 1 && PlayerToPoint(3.0, playerid,1154.2208,-1770.8203,16.5992))
		  		{
		  		    if(PlayerInfo[playerid][pCarLic] == 1)
				    {
					    if(PlayerInfo[playerid][pMember] > 0 || PlayerInfo[playerid][pLider] > 0 || GetPlayerOrg(playerid) != 0) { sendTipMessageEx(playerid, COLOR_GREY, "Frakcje nie mog¹ braæ tej pracy !"); return 1; }
					    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Chcesz zostaæ Kierowc¹ Autobusu, lecz najpierw musisz podpisaæ kontrakt na 5 godzin.");
					    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Aby zrezygnowaæ z tej pracy musi min¹æ czas kontraktu, dopiero wtedy bêdziesz móg³ siê zwolniæ.");
	 				    SendClientMessage(playerid, COLOR_P@, "   -----Informacje o pracy i warunki kontraktu-----");
					    SendClientMessage(playerid, COLOR_WHITE, "   Pod¹¿asz wyznaczonymi trasami, zatrzymujesz siê na przystankach i wozisz mieszkañcow Los Santos. Busy jako taksówki? Zapomnij, to tylko dla najepszych.");
					    SendClientMessage(playerid, COLOR_WHITE, "   Pocz¹tkuj¹cy kierowcy maj¹ ma³y wybór tras a ich jedynym pojazdem jest Moonbeam - czyli mini bus.");
					    SendClientMessage(playerid, COLOR_WHITE, "   Wy¿szy skill to  g³ównie wy¿sze zarobki, ale doœwiadczeni busiarze dzia³aj¹ tak¿e jako tanie taksówki, organizuj¹ wycieczki lub realizuj¹ kursy miêdzymiastowe.");
					    SendClientMessage(playerid, COLOR_WHITE, "   Przeciêtny pracowity kierowca zarabia ok. 10k na godzinê. Najlepsi mog¹ zarobiæ nawet kilkaset tysiêcy.");
					    SendClientMessage(playerid, COLOR_WHITE, "   To praca dla tych którzy lubi¹ komunikacjê publiczn¹. Inaczej stanie siê ona doœæ monotonna. P³acimy po zakoñczneniu trasy lub s³u¿by.");
					    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jeœli akceptujesz zasady kontraktu wpisz /akceptuj praca.");
					    GettingJob[playerid] = 10;
					}
					else
					{
					    sendTipMessageEx(playerid, COLOR_WHITE, "Do tej pracy wymagane jest prawo jazdy");
					}
		  		}
				else if(GetPlayerState(playerid) == 1 && PlayerToPoint(3.0, playerid,2029.4490,-1404.7776,17.2507))
				{
					    if(PlayerInfo[playerid][pMember] > 0 || PlayerInfo[playerid][pLider] > 0 || GetPlayerOrg(playerid) != 0) { sendTipMessageEx(playerid, COLOR_GREY, "Frakcje nie mog¹ braæ tej pracy !"); return 1; }
					    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Chcesz zostaæ Lekarzem, lecz najpierw musisz podpisaæ kontrakt na 5 godzin.");
					    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Aby zrezygnowaæ z tej pracy musi min¹æ czas kontraktu, dopiero wtedy bêdziesz móg³ siê zwolniæ.");
	 				    SendClientMessage(playerid, COLOR_P@, "   -----Informacje o pracy i warunki kontraktu-----");
					    SendClientMessage(playerid, COLOR_WHITE, "   Uzdrawiaj graczy, nieœ pomoc rannym, diagnozuj choroby i przeprowadzaj kuracje.");
						SendClientMessage(playerid, COLOR_WHITE, "   Kuracje, diagnozy oraz leczenie sprzedajesz po stawce, któr¹ sk³onny jest zap³aciæ gracz.");
						SendClientMessage(playerid, COLOR_WHITE, "   Za ka¿d¹ sprzedan¹ apteczkê zarobisz 20k.");
					    SendClientMessage(playerid, COLOR_WHITE, "   A jeœli to ciê znudzi - z³ap gaœnicê w d³oñ i gaœ po¿ary w Los Santos.");
					    SendClientMessage(playerid, COLOR_WHITE, "   Za zgaszony po¿ar dostaniesz 80 000$, po¿ary pojawiaj¹ siê co godzinê.");
					    SendClientMessage(playerid, COLOR_WHITE, "   Mo¿esz te¿ usuwaæ plamy oleju, za co dostajez 12 500$.");
					    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jeœli akceptujesz zasady kontraktu wpisz /akceptuj praca.");
					    GettingJob[playerid] = 11;
				}
		  		else if (GetPlayerState(playerid) == 1 && PlayerToPoint(3.0, playerid,766.0804,14.5133,1000.7004))
		  		{
		  		    if(PlayerInfo[playerid][pMember] > 0 || PlayerInfo[playerid][pLider] > 0 || GetPlayerOrg(playerid) != 0) { sendTipMessageEx(playerid, COLOR_GREY, "Frakcje nie mog¹ braæ tej pracy !"); return 1; }
		  		    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Chcesz zostaæ Bokserem, lecz najpierw musisz podpisaæ kontrakt na 5 godzin.");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Aby zrezygnowaæ z tej pracy musi min¹æ czas kontraktu, dopiero wtedy bêdziesz móg³ siê zwolniæ.");
				    SendClientMessage(playerid, COLOR_P@, "   -----Informacje o pracy i warunki kontraktu-----");
				    SendClientMessage(playerid, COLOR_WHITE, "   Jako bokser bierzesz udzia³ w galach boksu, toczysz za pieni¹dze sparingi z innymi i uczysz nowych technik walki.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Jednak prawda jest taka, ¿e gale s¹ bardzo rzadko, za sparingi ma³o kto chce p³aciæ i tak naprawdê pe³nisz rolê nauczyciela.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Praca posiada system skilla oraz licznik wygranych walk. Twój tytu³ bokserski zale¿y od liczby zwyciêstw. Skill zwiêksza liczbê...");
				    SendClientMessage(playerid, COLOR_WHITE, "   ...punktów HP jakie otrzymujesz na pocz¹tku walki oraz daje dostêp do nauczania lepszych stylów walki.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Zarobki s¹ bardzo zró¿nicowane i zale¿¹ od skilla. Zazwyczaj jest to ok. 30k ale nie jest to zarobek regularny.");
				    SendClientMessage(playerid, COLOR_WHITE, "   To co zarobisz za sparingi wyp³acamy co godzinê (w Pay Day). Za nauczanie pobierasz op³atê sam.");
				    SendClientMessage(playerid, COLOR_WHITE, "   Kwoty podane przy sztukach walki to pieni¹dze jakie zostan¹ ci zabrane. Podawaj zawsze wy¿sze ceny by osi¹gn¹æ zysk.");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jeœli akceptujesz zasady kontraktu wpisz /akceptuj praca.");
				    GettingJob[playerid] = 12;
		  		}
		  		else if (GetPlayerState(playerid) == 1 && PlayerToPoint(3.0, playerid,1751.4445, -2054.9761, 13.0593))//-77.7288,-1136.3896,1.0781
		  		{
                    if(PlayerInfo[playerid][pCarLic] != 1) return sendTipMessageEx(playerid, COLOR_WHITE, "Do tej pracy wymagane jest prawo jazdy");

		  		    if(PlayerInfo[playerid][pMember] > 0 || PlayerInfo[playerid][pLider] > 0 || GetPlayerOrg(playerid) != 0) { sendTipMessageEx(playerid, COLOR_GREY, "Families cannot take on this Job !"); return 1; }
		  		    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Chcesz zostaæ Truckerem, lecz najpierw musisz podpisaæ kontrakt na 5 godzin.");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Aby zrezygnowaæ z tej pracy musi min¹æ czas kontraktu, dopiero wtedy bêdziesz móg³ siê zwolniæ.");
				    SendClientMessage(playerid, COLOR_P@, "   -----Informacje o pracy i warunki kontraktu-----");
				    SendClientMessage(playerid, COLOR_WHITE, "   Praca polega na przewo¿eniu wózkiem wid³owym paczek do magazynu.");
                    SendClientMessage(playerid, COLOR_WHITE, "   W niej równie¿ transportujesz towar w wyznaczone miejsca.");
                    SendClientMessage(playerid, COLOR_WHITE, "   Praca nie przynosi kokosów zw³aszcza siedz¹c na wózku. Mo¿na zarobiæ 34.1k na godzinê.");
                    SendClientMessage(playerid, COLOR_WHITE, "   Atutem jest zarabianie kasy do rêki, za ka¿de wykonane zlecenie.");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jeœli akceptujesz zasady kontraktu wpisz /akceptuj praca.");
				    GettingJob[playerid] = 16;
				}
				else if(GetPlayerState(playerid) == 1 && PlayerToPoint(3.0, playerid, 0.0, 0.0, 0.0))
				{
					if(PlayerInfo[playerid][pCarLic] != 1)
					{
						sendTipMessage(playerid, "Do tej pracy wymagane jest prawo jazdy - Kategoria B!"); 
						return 1;
					}
					if(PlayerInfo[playerid][pMember] > 0 || PlayerInfo[playerid][pLider] > 0 || GetPlayerOrg(playerid) != 0)
					{
						sendErrorMessage(playerid, "Aby do³¹czyæ do tej pracy musisz odejœæ z obecnej! [/quitjob] [/qf]");
						return 1;
					}
				    SendClientMessage(playerid, COLOR_P@, "   -----Informacje o pracy i warunki kontraktu-----");
				    SendClientMessage(playerid, COLOR_WHITE, "   Praca polega na zbieraniu œmieci z terenów Los Santos");
                    SendClientMessage(playerid, COLOR_WHITE, "   Transporcie œmieci w wyznaczone miejsca");
                    SendClientMessage(playerid, COLOR_WHITE, "   Praca jest optymalna, przynosi w miarê dobre zyski - do 3.000$ za jeden œmietnik.");
                    SendClientMessage(playerid, COLOR_WHITE, "   Atutem jest zarabianie kasy do rêki, za odwiezienie zebranych œmieci ze œmietników. ");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jeœli akceptujesz zasady kontraktu wpisz /akceptuj praca.");
				    GettingJob[playerid] = 17;
				}
			}
			else
			{
			    sendTipMessageEx(playerid, COLOR_GREY, "Nie posiadasz dowodu osobistego, wyrób go w Urzêdzie Miasta!");
			}
		}
		else
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "Masz ju¿ pracê, wpisz /quitjob aby z niej zrezygnowaæ !");
		}
	}//not connected
    return 1;
}
