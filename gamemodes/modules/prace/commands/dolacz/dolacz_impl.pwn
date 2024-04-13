//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   dolacz                                                  //
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
// Autor: mrucznik
// Data utworzenia: 12.04.2024


//

//------------------<[ Implementacja: ]>-------------------
command_dolacz_Impl(playerid)
{
	if(PlayerInfo[playerid][pJob] != 0)
	{
		MruMessageFail(playerid, "Masz ju¿ pracê, wpisz /quitjob aby z niej zrezygnowaæ.");
		return 1;
	}
	
	if(PlayerInfo[playerid][pDowod] == 0)
	{
		MruMessageFail(playerid, "Nie posiadasz dowodu osobistego, wyrób go w Urzêdzie Miasta.");
		return 1;
	}

	if(GetPlayerState(playerid) != 1)
	{
		MruMessageFail(playerid, "Kontrakt podpisujemy na pieszo.");
		return 1;
	}

	new job = GetJobIfPlayerCloseEnough(playerid);
	if(!job)
	{
		MruMessageFail(playerid, "Nie znajdujesz siê w miejscu w którym mo¿na wzi¹æ prace.");
		return 1;
	}

	if(!CanPlayerTakeJob(playerid, job))
	{
		MruMessageFail(playerid, "Musisz byæ cywilem albo cz³onkiem rodziny/mafii/gangu aby wzi¹æ pracê.");
		return 1;
	}

	switch(job)
	{
		case JOB_LOWCA:
		{
			if(PlayerInfo[playerid][pGunLic] != 1)
			{
				MruMessageFail(playerid, "Do tej pracy wymagana jest licencja na broñ");
				return 1;
			}

			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Chcesz zostaæ £owc¹ Nagród, lecz najpierw musisz podpisaæ kontrakt na 5 godzin.");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Aby zrezygnowaæ z tej pracy musi min¹æ czas kontraktu, dopiero wtedy bêdziesz móg³ siê zwolniæ.");
			SendClientMessage(playerid, COLOR_P@, "   -----Informacje o pracy i warunki kontraktu-----");
			SendClientMessage(playerid, COLOR_WHITE, "   Twoje zadanie polega na œciganiu przestêpców i oferowania im poddania siê. W przypadku odmowy stosuje siê bardziej radykalne metody...");
			SendClientMessage(playerid, COLOR_WHITE, "   Wynagrodzenie zale¿y od wysokoœci WL oraz sposobu zatrzymania (za ¿ywego dostaje siê wiêcej)");
			SendClientMessage(playerid, COLOR_WHITE, "   Wy¿szy skill pozwala na d³u¿sze namierzanie, dostêp do bardziej niebezpiecznych przestêpców i lepszych pojazdów.");
			SendClientMessage(playerid, COLOR_WHITE, "   Dobry ³owca nagród mo¿e zarobiæ ponad 50k w godzinê. Pocz¹tkuj¹cy jakieœ 6k-10k. Minus koszty broni. Pieni¹dze wyp³acamy od razu.");
			SendClientMessage(playerid, COLOR_WHITE, "   Je¿eli masz trochê kasy na broñ, masz nerwy ze stali, mnóstwo sprytu i cierpliwoœci to ta wymagaj¹ca praca jest dla Ciebie.");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jeœli akceptujesz zasady kontraktu wpisz /akceptuj praca.");
		}
		case JOB_LAWYER:
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Chcesz zostaæ Prawnikiem, lecz najpierw musisz podpisaæ kontrakt na 5 godzin.");
			SendClientMessage(playerid, COLOR_P@, "   -----Informacje o pracy i warunki kontraktu-----");
			SendClientMessage(playerid, COLOR_WHITE, "   Do twoich zadañ nale¿y wyci¹ganie ludzi z wiêzienia (za kaucj¹ lub bez), czyszczenia im kartotek i obni¿ania poziomów poszukiwania");
			SendClientMessage(playerid, COLOR_WHITE, "   Praca jest legalna jednak w LS dobry prawnik to taki który zna sporo skorumpowanych gliniarzy lub ma znajomego w policji...");
			SendClientMessage(playerid, COLOR_WHITE, "   Jako pocz¹tkuj¹cy prawnik w g³ownej mierze bêdziesz zajmowa³ siê drobnymi z³odziejaszkami, zarobki równie¿ nie sa wysokie a o klienta trudno.");
			SendClientMessage(playerid, COLOR_WHITE, "   Tylko najlepsi prawnicy w mieœcie maj¹ szansê na zarobki z rzêdu 200k-300k na godzinê, wiêkszoœæ zarabia ok. 30k, pieni¹dze otrzymujesz od klientów.");
			SendClientMessage(playerid, COLOR_WHITE, "   Wy¿szy skill umo¿liwia zbijanie wy¿szych poziomów WL, uwlanianie groŸniejszych przestêpców oraz zmniejsza koszty ³apówek.");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Aby zrezygnowaæ z tej pracy musi min¹æ czas kontraktu, dopiero wtedy bêdziesz móg³ siê zwolniæ.");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jeœli akceptujesz zasady kontraktu wpisz /akceptuj praca.");
		}
		case JOB_PROSTITUTE:
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
		}
		case JOB_DRUG_DEALER:
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
		}
		case JOB_CARTHIEF:
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
		}
		case JOB_MECHANIC:
		{
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
		}
		case JOB_SMUGGLER:
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Chcesz zostaæ Ochroniarzem, lecz najpierw musisz podpisaæ kontrakt na 5 godzin.");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Aby zrezygnowaæ z tej pracy musi min¹æ czas kontraktu, dopiero wtedy bêdziesz móg³ siê zwolniæ.");
			SendClientMessage(playerid, COLOR_P@, "   -----Informacje o pracy i warunki kontraktu-----");
			SendClientMessage(playerid, COLOR_WHITE, "   Mo¿esz ochraniaæ ludzi, jednak jest to tylko przykrywka dla sprzedawania pancerzy - tym masz siê przede wszytkim zajmowaæ.");
			SendClientMessage(playerid, COLOR_WHITE, "   Praca jest doœæ monotonna gdy¿ praktycznie polega na wciskaniu wszytkim kamizelki kuloodpornej.");
			SendClientMessage(playerid, COLOR_WHITE, "   Podobno niektórzy przy du¿ym szczêœciu potrafia zarobiæ nawet 90k-130k. Jednak norm¹ jest 10k a przy du¿ym pechu 2k.");
			SendClientMessage(playerid, COLOR_WHITE, "   Praca nie posiada systemu skilla. To co zarobisz wyp³acamy co godzinê (w Pay Day).");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jeœli akceptujesz zasady kontraktu wpisz /akceptuj praca.");
		}
		case JOB_GUNDEALER:
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
		}
		case JOB_DRIVER:
		{
			if(PlayerInfo[playerid][pCarLic] != 1)
			{
				sendTipMessage(playerid, "Do tej pracy wymagane jest prawo jazdy - Kategoria B!"); 
				return 1;
			}
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Chcesz zostaæ Kierowc¹ Autobusu, lecz najpierw musisz podpisaæ kontrakt na 5 godzin.");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Aby zrezygnowaæ z tej pracy musi min¹æ czas kontraktu, dopiero wtedy bêdziesz móg³ siê zwolniæ.");
			SendClientMessage(playerid, COLOR_P@, "   -----Informacje o pracy i warunki kontraktu-----");
			SendClientMessage(playerid, COLOR_WHITE, "   Pod¹¿asz wyznaczonymi trasami, zatrzymujesz siê na przystankach i wozisz mieszkañcow Los Santos. Busy jako taksówki? Zapomnij, to tylko dla najepszych.");
			SendClientMessage(playerid, COLOR_WHITE, "   Pocz¹tkuj¹cy kierowcy maj¹ ma³y wybór tras a ich jedynym pojazdem jest Moonbeam - czyli mini bus.");
			SendClientMessage(playerid, COLOR_WHITE, "   Wy¿szy skill to  g³ównie wy¿sze zarobki, ale doœwiadczeni busiarze dzia³aj¹ tak¿e jako tanie taksówki, organizuj¹ wycieczki lub realizuj¹ kursy miêdzymiastowe.");
			SendClientMessage(playerid, COLOR_WHITE, "   Przeciêtny pracowity kierowca zarabia ok. 10k na godzinê. Najlepsi mog¹ zarobiæ nawet kilkaset tysiêcy.");
			SendClientMessage(playerid, COLOR_WHITE, "   To praca dla tych którzy lubi¹ komunikacjê publiczn¹. Inaczej stanie siê ona doœæ monotonna. P³acimy po zakoñczneniu trasy lub s³u¿by.");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jeœli akceptujesz zasady kontraktu wpisz /akceptuj praca.");
		}
		case JOB_MEDIC:
		{
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
		}
		case JOB_BOXER:
		{
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
		}
		case JOB_TRUCKER:
		{
			if(PlayerInfo[playerid][pCarLic] != 1)
			{
				sendTipMessage(playerid, "Do tej pracy wymagane jest prawo jazdy - Kategoria B!"); 
				return 1;
			}
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Chcesz zostaæ Kurierem, lecz najpierw musisz podpisaæ kontrakt na 5 godzin.");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Aby zrezygnowaæ z tej pracy musi min¹æ czas kontraktu, dopiero wtedy bêdziesz móg³ siê zwolniæ.");
			SendClientMessage(playerid, COLOR_P@, "   -----Informacje o pracy i warunki kontraktu-----");
			SendClientMessage(playerid, COLOR_WHITE, "   Praca polega na przewo¿eniu wózkiem wid³owym paczek do magazynu.");
			SendClientMessage(playerid, COLOR_WHITE, "   W niej równie¿ transportujesz towar w wyznaczone miejsca.");
			SendClientMessage(playerid, COLOR_WHITE, "   Praca nie przynosi kokosów zw³aszcza siedz¹c na wózku. Mo¿na zarobiæ 34.1k na godzinê.");
			SendClientMessage(playerid, COLOR_WHITE, "   Atutem jest zarabianie kasy do rêki, za ka¿de wykonane zlecenie.");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jeœli akceptujesz zasady kontraktu wpisz /akceptuj praca.");
		}
	}
	GettingJob[playerid] = job;
    return 1;
}

//end