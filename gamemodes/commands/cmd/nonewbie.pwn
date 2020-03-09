//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ nonewbie ]-----------------------------------------------//
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

YCMD:nonewbie(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
        new string[128];
		if (PlayerInfo[playerid][pAdmin] >= 5 || IsAScripter(playerid) )
		{
			if(!newbie)
			{
				newbie = 1;
				BroadCast(COLOR_GRAD2, "Czat newbie zosta³ zablokowany przez Administratora!");
			}
			else
			{
				newbie = 0;
				SendClientMessageToAll(COLOR_P@,"|_________________________Rada dnia: czat /n(ewbie)_________________________|");
				SendClientMessageToAll(COLOR_WHITE,"Czat {ADFF2F}/n{FFFFFF} jest przeznaczony g³ównie dla newbie - czyli nowych graczy.");
				SendClientMessageToAll(COLOR_WHITE,"Je¿eli jesteœ nowym graczem i masz jakieœ pytanie nie krêpuj siê i zadaj je na /n [pytanie] !");
				SendClientMessageToAll(COLOR_WHITE,"Gdy jednak pocz¹tki gry masz ju¿ za sob¹, nie zadawaj pytañ a jedynie udzielaj odpowiedzi :)");
				SendClientMessageToAll(COLOR_WHITE,"Obowi¹zuj¹ jednak pewne {FFA500}zasady{FFFFFF} dot. tego czatu których trzeba przestrzegaæ:");
				SendClientMessageToAll(COLOR_WHITE,"1. Czat s³u¿y tylko do zadawania pytañ i odpowiedzi!");
				SendClientMessageToAll(COLOR_WHITE,"2. Na czacie nie witamy siê || 3. Nie udzielamy odpowiedzi na /w - wszytkie odpowiedzi udzielamy na /n )");
				SendClientMessageToAll(COLOR_WHITE,"4. Je¿eli chcesz og³osiæ, ¿e 'pomagasz  w RP' to nie tutaj, gdy¿ to w³asnie na tym czacie tej pomocy udzielamy! )");
				SendClientMessageToAll(COLOR_WHITE,"Je¿eli nie chcesz widzieæ tego czatu, mozesz go wy³¹czyæ komend¹ {CD5C5C}/togn");
				SendClientMessageToAll(COLOR_P@,"|________________________>>> Mrucznik-RP.pl <<<________________________|");
				BroadCast(COLOR_GRAD2, "Czat newbie zosta³ odblokowany przez Administratora !");
			}
			
			format(string, 128, "CMD_Info: /nonewbie u¿yte przez %s [%d]", GetNickEx(playerid), playerid);
			SendCommandLogMessage(string);
			Log(adminLog, INFO, "Admin %s u¿y³ /nonewbie", GetPlayerLogName(playerid));
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
