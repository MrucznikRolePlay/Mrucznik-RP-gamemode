//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ zasady ]------------------------------------------------//
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

YCMD:zasady(playerid, params[], help)
{
    SendClientMessage(playerid,COLOR_P@,"|_________________Zasady ruletki i Black Jack'a_________________|");
	SendClientMessage(playerid,COLOR_WHITE,"Black Jack - gracz stara siê pokonac krupiera poprzez uzyskanie sumy najbli¿szej 21pkt.");
	SendClientMessage(playerid,COLOR_WHITE,"Jednak nie nale¿y przekroczyæ 21pkt gdy¿ jest to równoznaczne z przegran¹.");
	SendClientMessage(playerid,COLOR_WHITE,"W przypadku uzyskania 21 pkt gracz ma tzw. 'Oczko' i automatycznie wygrywa grê. Wszycy uczestnicy zabawy graj¹ przeciw krupierowi.");
	SendClientMessage(playerid,COLOR_WHITE,"Je¿eli gracz ma mneij ni¿ 21 pkt mo¿e w dowolnym momencie przestaæ dobierac karty (pas) i czekac na ruch krupiera.");
	SendClientMessage(playerid,COLOR_WHITE,"Za Damê (Q) Waleta (J) i Króla (K) liczymy 10pkt. As to 1pkt lub 11pkt- do wyboru. Reszta wed³ug figur.");
	SendClientMessage(playerid,COLOR_WHITE,"Ruletka- w tej grze mozna wygraæ zdecydowanie najiêksze pieni¹dze. Na ruletce mozna obstawiac wiele kombinacji, im wiêksze ryzyko tym wy¿sza wygrana:");
	SendClientMessage(playerid,COLOR_WHITE,"Zak³ady niskiego ryzka (szansa 1:2): kolory, parzyste, nieparzyste, po³ówki");
	SendClientMessage(playerid,COLOR_WHITE,"Œrednie ryzyko: tuziny, rzêdy (szansa 1:3), cztery numery (szansa 1:9), dwie linie (sznasa 1:6), pierwsze piêc numerów (sznasa 1:7)");
	SendClientMessage(playerid,COLOR_WHITE,"Wysokie ryzyko: jeden numer (szansa 1:35), dwa numery (szansa 1:17), trzy numery (szansa 1:11)");
	SendClientMessage(playerid,COLOR_P@,"|_______________________>>> $Bymber Casino$ <<<_______________________|");
	return 1;
}
