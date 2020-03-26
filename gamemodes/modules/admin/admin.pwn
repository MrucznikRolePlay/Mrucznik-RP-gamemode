//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   admin                                                   //
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
// Autor: 2.5
// Data utworzenia: 04.05.2019
//Opis:
/*
	System administracji.

	Zawiera komendy administratora, wywo³ywania listy administratorów, funkcje administratorów, 
	przydzielanie administratora, zabezpieczenia. Czêœæ komend zosta³a przepisana na nowo, natomiast czêœæ 
	oczekuje dalej na przepisanie. Póki co zosta³a oddzielona od komendy.pwn i otrzyma³a swój w³asny plik.
	
	Funkcje:
		> AJPlayerTXD - TXD show za AJ
		> BanPlayerTXD - TXD show za Bana
		> KickPlayerTXD - TXD show za kica
		> WarnPlayerTXD - TXD show za warna
		> BlockPlayerTXD - TXD show za blocka
		>
	
	Komendy:
		> Admins - lista administratorów na s³u¿bie
		> Kary[i] txd - Kary[i]  w txd
		> check - sprawdza statystyki gracza (showstats) 
		> nonewbie - odpala/gasi chat newbie
		> dn & up - teleportuje gracza w górê/dó³
		> usunpozar - usuwa po¿ar z mapy
		> losowypozar - losowo startuje po¿ar
		> unblock - unblokowuje gracza o nicku (%s)
		> gotobiz - teleportuje do biznesu o ID
		> resetsejfhasla - resetuje has³a w domach (sejfy)
		> zapiszdomy - zapisuje domy
		> zapiszkonta - zapisuje konta graczy 
		> ann - gametex for all (3) 
		> setname - ustawia graczowi o ID name (%s) 
		> spec & unspec - podgl¹da gracza (kamera)
		> block - nadaje blocka dla gracza 
		> pblock - nadaje blocka offline
		> pban - nadaje bana offline
		> pwarn - nadaje warna offline
		> paj - nadaje AdminJail'a offline
		> sblock - cichy block
		> ip - sprawdza ip gracza o ID
		> czyjtonumer - sprawdza czyj to numer
		> flip - obraca pojazd do góry ko³ami :) 
		> snn  - text for all
		> cca & cc - czyœci chat dla wszystkich 
		> hpall - nadaje HP dla ka¿dego
		> killall - zabija ka¿dego
		> podglad - ustala podgl¹d dla gracza o ID
		> antybh - ustawienia antyBH
		> undemorgan - uwalnia gracza o ID z wiêzeienia
		> zaraz  zara¿a gracza chorob¹
		> kill - zabija gracza o ID
		> setwiek - ustala wiek dla gracza o ID
		> setjob -  ustala graczowi o ID pracê X
		> setslot - ustala liczbê slotów dla gracza o ID
		> pojazdygracza - sprawdza pojazdy gracza o ID
		> checkcar - sprawdza do kogo nale¿y pojazd X
		> checkcars - sprawdza auta gracza (GUI)
		> setcar - ustawia auto Y na slot X
		> setwl - ustawia graczowi o ID WL X
		> setskin - ustawia graczowi o ID skin X
		> naprawskin - naprawia graczowi o ID skin X
		> rozwiedz - rozwodzi gracza o ID
		> dskill - ustala skill dla broni
		> dnobiekt - obni¿a obiekt (?)
		> dsus - ustawia graczowi o ID WL X
		> jump - podrzuca gracza
		> sh
		> carjump - podrzuca auto
		> ksam - w³¹cza podgl¹d miejsca (jako kamera) 
		> fdaj - ustala styl dla gracza o ID
		> dajdowozu - teleportuje gracza o ID do wozu X
		> sprawdzinv - nwm
		> sprawdzin - sprawdza pozycje gracza (on foot, in car [..]) 
		> getposp - pobiera koordynaty gracza o ID
		> zniszczobiekty - usuwa wszystkie obiekty z serwera
		> stworzobiekty - tworzy obiekty
		> respawn - powoduje odliczanie do respawnu pojazów (20s)
		> dajdzwiek - odpala dŸwiêk dla gracza o ID
		> crimereport - report crime's
		> respp - respawnuje gracza o ID
		> respcar - respawnuje pojazd o ID
		> zdejmijbpk - zdejmuje blokadê pisania na chaty frakcyjne dla gracza o ID
		> dpa - degraduje pó³ admina
		> BP - nadaje blokadê pisania dla gracza o ID na czas X
		> kickallex - kickuje wszystkich graczy
		> setmats - ustawia materia³y dla gracza o ID
		> reloadbans - prze³adowuje plik z banami
		> koxubankot - nadaje administratora X dla gracza o ID
		> setcarint - ustawia pojazdowi interior (taki jaki ma obecnie gracz)
		> setcarvw - ustawia pojazdowi VirtualWorld (taki jaki ma obecnie gracz)
		> panel - panel KS
		> msgbox - wyœwietla MSG box
		> gotoczit - teleportuje na miejsce zbrodni 
		> anulujzp - anuluje zabranie prawa jazdy dla gracza o ID
		> addcar - dodaje pojazd na mapê o podanym ID
		> removecar - usuwa pojazd z mapy o podanym ID
		> setac - ustawia anty-cheat'a
		> supportduty - s³u¿ba supportera
		> ticket - teleportuje do /zapytaj
		> ticketend - przywraca star¹ pozycjê
		> stworz - tworzy organizacje, pojazd, rangê (wymaga uprawnieñ)
		> edytuj - edytuje pojazd, organizacje, rangê (wymaga uprawnieñ)
		> delete3dtext - usuwa 3dtext (nie sprawdzone)
		> deleteobject - usuwa obiekt (nie sprawdzone) 
		> scena - stawia scenê
		> scenaallow - pozwala stawiaæ scenê graczowi o ID
		> scenadisallow - zabiera pozwolenie dla gracza o ID do stawiania sceny
		> zrobkolejke - tworzy kolejkê 
		> gotoadmin - teleportuje na wyspê adminów
		> gotomechy - teleportuje do mechaników
		> gotostacja - teleportuje na stacje paliw idle
		> rapidfly - w³¹cza tryb latania dla gracza
		> removeganglimit
		> removezoneprotect
		> gangzone
		> zonedelay - usuwa strefe
		> clearzone - czyœci strefê
		> setzonecontrol - ustawia kontrolê nad stref¹ dla... 
		> unbw - zdejmuje BW graczowi o ID
		> bw - nadaje BW graczowi o ID
		> checkbw - informacja o czasie BW gracza
		> cziterzy - pokazuje liste osób, które AC uzna³ za cziterów 
		> restart - restartuje serwera
		> wczytajskrypt - wczytuje FS'a 
		> setmistrz - mianuje gracza o ID mistrzem bokserskim 
		> togadminmess - wy³¹cza wszelkie komunikaty admina
		> mole - wysy³a smsa jako marcepan
		> zg - wysy³a wiadomoœæ na chacie zaufanych
		> logout - wylogowuje gracza
		> logoutpl - wylogowuje gracza o ID
		> logoutall - wylogowuje wszystkich graczy
		> cnn - wysy³a wszystkim gametext
		> cnnn - wysy³a wszystkim gametext (2)
		> demorgan - wiêzi gracza o ID
		> unaj - usuwa adminjail dla gracza o ID
		> AJ - nadaje adminjaila dla gracza o ID
		> jail - nadaje jaila dla gracza o ID (UWAGA CZAS NIELIMITOWANY!) 
		> tod - ustawia dla wszystkich godzinê X
		> startlotto - startuje lotto 
		> setstat - ustawia graczowi o ID statystyki 
		> clearwlall - czyœci wszystkim wanted level
		> setint - nadaje graczowi o ID interior X
		> setvw - nadaje graczowi o ID virtualworld X
		> getvw - pobiera od gracza o ID virtualworld i wyœwietla adminowi
		> getint - pobiera od gracza o ID interior i wyœwietla adminowi
		> skydive - teleportuje gracza o ID w kosmos (XD)
		> dajpomocnika - nadaje pó³ administratora (1-3) dla gracza o ID
		> dajskryptera - nadaje skryptera dla gracza o ID
		> dajzaufanego - nadaje zaufanego dla gracza o ID
		> makeircadmin - nadaje administratora chatu IRC dla gracza o ID
		> forceskin - wymusza otworzenie wybiera³ki, gdy gracz o ID jest we frakcji
		> dajlideraorg - nadaje lidera organizacji (rodziny) dla gracza o ID X
		> makemember - nadaje stopieñ [0] graczowi o ID we frakcji X
		> zabierzlideraorg - zabiera lidera organizacji (rodziny) dla gracza o ID
		> makeleader - daje graczowi o ID lidera frakcji o ID X
		> makewomanleader- daje graczowi o ID ¿eñskiego lidera frakcji o ID X
		> setteam - ustala "team" graczowi (raczej ju¿ nie u¿ywane) - s¹ dwa cop, civilian. 
		> gotopos - teleportuje nas do pozycji X,Y,Z
		> gotols - teleportuje pod komisariat LS
		> gotolv - teleportuje pod lotnisko LV
		> gotosf - teleportuje pod dworzec san fierro
		> gotoszpital - teleportuje pod szpital w LS
		> gotosalon - teleportuje pod salon aut w LS
		> entercar - wsadza nas do wozu o ID
		> gotocar - teleportuje do auta o ID
		> mark - ustawia markera
		> gotomark - teleportuje do markera (którego wczeœniej ustawiliœmy poprzez CMD:mark) 
		> gotojet - teleportuje na odrzutowiec
		> gotostad - teleportuje na stadion
		> gotoin - teleportuje w .. coœ
		> goto - teleportuje nas do gracza X
		> gotoint - teleportuje nas do interioru X
		> tp - teleportuje gracza X do gracza Y
		> GetHere - teleportuje gracza o ID do nas
		> Getcar - teleportuje auto o ID do nas
		> tankujauto - tankuje pojedyñczy samochód (w którym siedzimy)
		> tankujauta - tankuje samochody
		> givegun - daje graczowi o ID broñ o ID z amunicj¹ o wartoœci X
		> sethp - ustawia graczowi o ID podan¹ wartoœæ HP
		> setarmor - ustawia graczowi o ID podan¹ wartoœæ armour 
		> fixveh - naprawia auto
		> fixallveh - naprawia wszystkim graczom auto
		> pogodaall - ustawia podan¹ pogodê dla wszystkich graczy
		> money - resetuje graczowi o ID kasê do 0 i ustawia podan¹ wartoœæ
		> dajkase - daje graczowi o ID kasê X
		> carslots - resetuje graczu sloty na [4] domyœlne
		> slap - daje klapsa w dupsko dla gracza o ID 
		> mute - ucisza gracza o ID
		> setplocal - ustawia pLOCAL dla gracza o ID
		> glosowanie - tworzy g³osowanie na X temat na Y czas
		> freeze - zamra¿a gracza o ID
		> unfreeze - odmra¿a gracza o ID
		> warn - nadaje ostrze¿enie graczowi o ID
		> unwarn - zdejmuje ostrze¿enie graczowi o ID
		> skick - kickuje (cichy kick) gracza o ID
		> sban - banuje (ukryty ban) gracza o ID
		> ban - banuje gracza o ID
		> kick - kickuje gracza o ID
		> banip - banuje gracza o ID
	Timery:
		> Brak
		
	Funkcje
		>IsAHeadAdmin
		>IsAScripter
		>AdminCommandAcces
*/

//

//-----------------<[ Callbacki: ]>-------------------
//-----------------<[ Funkcje: ]>-------------------
IsAHeadAdmin(playerid)
{
	if(PlayerInfo[playerid][pAdmin] == 5000)
	{
		return 1;
	}
	return 0;
}

IsAKox(playerid)
{
	if(DEVELOPMENT) return true;
	return PlayerInfo[playerid][pUID] == 1 || PlayerInfo[playerid][pUID] == 2;
}

IsAScripter(playerid)
{
	return Uprawnienia(playerid, ACCESS_SKRYPTER);
}

SendMessageToAdmin(text[], mColor)//Wysy³a wiadomoœæ do administratora na s³u¿bie
{
	foreach(new i : Player)
	{
		if(GetPlayerAdminDutyStatus(i) == 1)
		{
			new stradm[256];
			format(stradm, sizeof(stradm), "%s", text);
			SendClientMessage(i, mColor, stradm);
		}
	}
	return 1;
}
SendMessageToAdminEx(text[], mColor, condition)//Wysy³a wiadomoœæ do administratora za spe³nieniem warunku
{
	new stradm[256];
	foreach(new i : Player)
	{
		if(PlayerInfo[i][pAdmin] > 0 || PlayerInfo[i][pNewAP] > 0 || IsAScripter(i))
		{
			if(condition == 1)//Warunek w³¹czonej widocznoœci reportów
			{
				if(PlayerPersonalization[i][PERS_REPORT] == 0)
				{
					format(stradm, sizeof(stradm), "%s", text);
					SendClientMessage(i, mColor, stradm);
				}
			}
			else if(condition == 2)//Warunek w³¹czonej widocznoœci DEATH_WARNING
			{
				if(PlayerPersonalization[i][WARNDEATH] == 0)
				{
					format(stradm, sizeof(stradm), "%s", text);
					SendClientMessage(i, mColor, stradm);
				}
			}
		}	
	}
	return 1;
}

KickPlayerTXD(playerid, adminid, reason[])
{
    //PlayerLogged[playerid]=0;
    new str[128];
    format(str, sizeof(str), "~r~Kick~n~~w~Dla: ~y~%s~n~~w~Admin: ~y~%s~n~~w~Powod: ~y~%s", GetNick(playerid), GetNickEx(adminid), Odpolszcz(reason));
	karaTimer = SetTimer("StopDraw", 15000, false);
	foreach(new i : Player)
	{
		PlayerTextDrawSetString(i, Kary[i] , str);
		PlayerTextDrawShow(i, Kary[i] ); 
		if(togADMTXD[i] == 1)
		{
			PlayerTextDrawHide(i, Kary[i] ); 
		}
	}
    return 1;
}

AJPlayerTXD(playerid, adminid, reason[], timeVal)
{
	new str[256];
    format(str, sizeof(str), "~r~AdminJail [%d minut]~n~~w~Dla: ~y~%s~n~~w~Admin: ~y~%s~n~~w~Powod: ~y~%s", timeVal, GetNick(playerid), GetNickEx(adminid), Odpolszcz(reason));
	karaTimer = SetTimer("StopDraw", 15000, false);
	foreach(new i : Player)
	{
		PlayerTextDrawSetString(i, Kary[i] , str);
		PlayerTextDrawShow(i, Kary[i] ); 
		if(togADMTXD[i] == 1)
		{
			PlayerTextDrawHide(i, Kary[i] ); 
		}
	}
	return 1;
}
BPPlayerTXD(playerid, adminid, timeVal, reason[])
{
	new str[256];
    format(str, sizeof(str), "~r~BP [%d godzin]~n~~w~Dla: ~y~%s~n~~w~Admin: ~y~%s~n~~w~Powod: ~y~%s",timeVal, GetNick(playerid), GetNickEx(adminid),Odpolszcz(reason));
	karaTimer = SetTimer("StopDraw", 15000, false);
	foreach(new i : Player)
	{
		PlayerTextDrawSetString(i, Kary[i] , str);
		PlayerTextDrawShow(i, Kary[i] ); 
		if(togADMTXD[i] == 1)
		{
			PlayerTextDrawHide(i, Kary[i] ); 
		}
	}
	return 1;
}
BanPlayerTXD(playerid, adminid, reason[])
{
	new str[128];
    format(str, sizeof(str), "~r~Banicja~n~~w~Dla: ~y~%s~n~~w~Admin: ~y~%s~n~~w~Powod: ~y~%s", GetNick(playerid), GetNickEx(adminid), Odpolszcz(reason));
	karaTimer = SetTimer("StopDraw", 15000, false);
	foreach(new i : Player)
	{
		PlayerTextDrawSetString(i, Kary[i] , str);
		PlayerTextDrawShow(i, Kary[i] ); 
		if(togADMTXD[i] == 1)
		{
			PlayerTextDrawHide(i, Kary[i] ); 
		}
	}

	return 1;
}
WarnPlayerTXD(playerid, adminid, reason[])
{
	new str[128];
    format(str, sizeof(str), "~r~Warn~n~~w~Dla: ~y~%s~n~~w~Admin: ~y~%s~n~~w~Powod: ~y~%s", GetNick(playerid), GetNickEx(adminid), Odpolszcz(reason));
	karaTimer = SetTimer("StopDraw", 15000, false);
	foreach(new i : Player)
	{
		PlayerTextDrawSetString(i, Kary[i] , str);
		PlayerTextDrawShow(i, Kary[i] ); 
		if(togADMTXD[i] == 1)
		{
			PlayerTextDrawHide(i, Kary[i] ); 
		}
	}
	return 1;
}
BlockPlayerTXD(playerid, adminid, reason[])
{
	new str[128];
    format(str, sizeof(str), "~r~Block~n~~w~Dla: ~y~%s~n~~w~Admin: ~y~%s~n~~w~Powod: ~y~%s", GetNick(playerid), GetNickEx(adminid), Odpolszcz(reason));
	karaTimer = SetTimer("StopDraw", 15000, false);
	foreach(new i : Player)
	{
		PlayerTextDrawSetString(i, Kary[i] , str);
		PlayerTextDrawShow(i, Kary[i] ); 
		if(togADMTXD[i] == 1)
		{
			PlayerTextDrawHide(i, Kary[i] ); 
		}
	}
	return 1;
}
PWarnPlayerTXD(player[], adminid, result[])
{
	new str[128];
	new nickDoWarna[MAX_PLAYER_NAME]; 
	strcat(nickDoWarna, player); 
    format(str, sizeof(str), "~r~Warn Offline~n~~w~Dla: ~y~%s~n~~w~Admin: ~y~%s~n~~w~Powod: ~y~%s", nickDoWarna, GetNickEx(adminid), Odpolszcz(result));
	karaTimer = SetTimer("StopDraw", 15000, false);
	foreach(new i : Player)
	{
		PlayerTextDrawSetString(i, Kary[i] , str);
		PlayerTextDrawShow(i, Kary[i] ); 
		if(togADMTXD[i] == 1)
		{
			PlayerTextDrawHide(i, Kary[i] ); 
		}
	}
	return 1;
}
GivePWarnForPlayer(player[], adminid, result[]) 
{
	new nickDoWarna[MAX_PLAYER_NAME];
	strcat(nickDoWarna, player); 
	new string[256];
	format(string, sizeof(string), "AdmCmd: Konto gracza OFFLINE %s zostalo zwarnowane przez %s, Powod: %s", nickDoWarna, GetNickEx(adminid), Odpolszcz(result));
	SendMessageToAdmin(string, COLOR_RED); 
	Log(punishmentLog, INFO, "Admin %s ukara³ offline %s kar¹ warna, powód: %s", 
						GetPlayerLogName(adminid),
						player,
						result);
	MruMySQL_SetAccInt("Warnings", nickDoWarna, MruMySQL_GetAccInt("Warnings", nickDoWarna)+1);
	if(strfind(result, "/q") != -1 || strfind(result, "ucieczka") != -1) MruMySQL_SetAccInt("Jailed", nickDoWarna, 0);

	SetTimerEx("AntySpamTimer",5000,0,"d",adminid);
	AntySpam[adminid] = 1;
	if(GetPlayerAdminDutyStatus(adminid) == 1)
	{
		iloscWarn[adminid] = iloscWarn[adminid]+1;
	}
	else if(GetPlayerAdminDutyStatus(adminid) == 0)
	{
		iloscPozaDuty[adminid]++; 
	}
	return 1;
}
GiveWarnForPlayer(playerid, adminid, result[])
{
	new str[256];
	new string[256];
	PlayerInfo[playerid][pWarns] += 1;
	if(PlayerInfo[playerid][pWarns] >= 3)
	{
		SendClientMessage(playerid, COLOR_NEWS, "SprawdŸ czy otrzymana kara jest zgodna z list¹ kar i zasad, znajdziesz j¹ na www.Mrucznik-RP.pl");
		format(string, sizeof(string), "AdmCmd: %s zosta³ zbanowany przez Admina %s (3 warny), powód: %s", GetNick(playerid), GetNickEx(adminid), Odpolszcz(result));
		SendMessageToAdmin(string, COLOR_RED); 
		Log(punishmentLog, INFO, "Admin %s ukara³ %s kar¹ warna (ban 3 warny), powód: %s", 
			GetPlayerLogName(adminid),
			GetPlayerLogName(playerid),
			result);
		if(GetPlayerAdminDutyStatus(adminid) == 1)
		{
			iloscBan[adminid]++; 
		}
		//adminowe logi
		format(str, sizeof(str), "Admini/%s.ini", GetNickEx(adminid));
		dini_IntSet(str, "Ilosc_Warnow", dini_Int(str, "Ilosc_Warnow")+1 );
		MruMySQL_Banuj(playerid, result, adminid);
		KickEx(playerid);
		return 1;	
	}
	else
	{
		Log(punishmentLog, INFO, "Admin %s ukara³ %s kar¹ warna, powód: %s", 
			GetPlayerLogName(adminid),
			GetPlayerLogName(playerid),
			result);
	}
	format(str, sizeof(str), "Dosta³eœ warna od %s, powód: %s", GetNickEx(adminid), (result));
	SendClientMessage(playerid, COLOR_LIGHTRED, str);
	Log(punishmentLog, INFO, "Admin %s ukara³ %s kar¹ warna, powód: %s", 
			GetPlayerLogName(adminid),
			GetPlayerLogName(playerid),
			result);
	SetTimerEx("AntySpamTimer",5000,0,"d",adminid);
	AntySpam[adminid] = 1;
	KickEx(playerid);
	if(GetPlayerAdminDutyStatus(adminid) == 1)
	{
		iloscWarn[adminid] = iloscWarn[adminid]+1;
	}
	else if(GetPlayerAdminDutyStatus(adminid) == 0)
	{
		iloscPozaDuty[adminid]++; 
	}
	return 1;
}
PBlockPlayerTXD(player[], adminid, reason[])
{
	new str[128];
	new nickOdbieracza[MAX_PLAYER_NAME];
	strcat(nickOdbieracza, player); 
    format(str, sizeof(str), "~r~Block Offline~n~~w~Dla: ~y~%s~n~~w~Admin: ~y~%s~n~~w~Powod: ~y~%s", nickOdbieracza, GetNickEx(adminid), Odpolszcz(reason));
	karaTimer = SetTimer("StopDraw", 15000, false);
	foreach(new i : Player)
	{
		PlayerTextDrawSetString(i, Kary[i] , str);
		PlayerTextDrawShow(i, Kary[i] ); 
		if(togADMTXD[i] == 1)
		{
			PlayerTextDrawHide(i, Kary[i] ); 
		}
	}
	return 1;
}
PBanPlayerTXD(player[], adminid, reason[])
{
	new str[128];
	new nickOdbieracza[MAX_PLAYER_NAME];
	strcat(nickOdbieracza, player); 
    format(str, sizeof(str), "~r~Ban Offline~n~~w~Dla: ~y~%s~n~~w~Admin: ~y~%s~n~~w~Powod: ~y~%s", nickOdbieracza, GetNickEx(adminid), Odpolszcz(reason));
	karaTimer = SetTimer("StopDraw", 15000, false);
	foreach(new i : Player)
	{
		PlayerTextDrawSetString(i, Kary[i] , str);
		PlayerTextDrawShow(i, Kary[i] ); 
		if(togADMTXD[i] == 1)
		{
			PlayerTextDrawHide(i, Kary[i] ); 
		}
	}
	return 1;
}
PAJPlayerTXD(player[], adminid, timeVal, reason[])
{
	new nickOdbieracza[MAX_PLAYER_NAME];
	strcat(nickOdbieracza, player); 
	new str[128];
    format(str, sizeof(str), "~r~O-AdminJail [%d minut]~n~~w~Dla: ~y~%s~n~~w~Admin: ~y~%s~n~~w~Powod: ~y~%s", timeVal, nickOdbieracza, GetNickEx(adminid), Odpolszcz(reason));
	karaTimer = SetTimer("StopDraw", 15000, false);
	foreach(new i : Player)
	{
		PlayerTextDrawSetString(i, Kary[i] , str);
		PlayerTextDrawShow(i, Kary[i] ); 
		if(togADMTXD[i] == 1)
		{
			PlayerTextDrawHide(i, Kary[i] ); 
		}
	}
	return 1;
}
SetPlayerPAdminJail(player[], adminid, timeVal, result[])
{
	new nickOdbieracza[MAX_PLAYER_NAME];
	strcat(nickOdbieracza, player); 
	new string[256];
	format(string, sizeof(string), "AdmCmd: Konto gracza offline %s dosta³o aj na %d od %s, Powod: %s", nickOdbieracza, timeVal, GetNickEx(adminid), (result));
	SendMessageToAdmin(string, COLOR_RED); 
	
	Log(punishmentLog, INFO, "Admin %s ukara³ offline %s kar¹ AJ %d minut, powód: %s", 
		GetPlayerLogName(adminid),
		nickOdbieracza,
		timeVal,
		result);

	if(GetPlayerAdminDutyStatus(adminid) == 1)
	{
		iloscAJ[adminid] = iloscAJ[adminid]+1;
	
	}
	else if(GetPlayerAdminDutyStatus(adminid) == 0)
	{
		iloscPozaDuty[adminid]++; 
	}
	MruMySQL_SetAccInt("Jailed", nickOdbieracza, 3);
	MruMySQL_SetAccInt("JailTime", nickOdbieracza, timeVal*60);
	MruMySQL_SetAccString("AJreason", nickOdbieracza, result);
	SetTimerEx("AntySpamTimer",5000,0,"d",adminid);
	AntySpam[adminid] = 1;
	return 1;
}
SetPlayerAdminJail(playerid, adminid, timeVal, result[])
{
	new string[256];
	format(string, sizeof(string), "* Zosta³eœ uwieziony w Admin Jailu przez Admina %s, Czas: %d. Powod: %s", GetNickEx(adminid), timeVal, (result));
	SendClientMessage(playerid, COLOR_LIGHTRED, string);
	PlayerInfo[playerid][pJailed] = 3;
	PlayerInfo[playerid][pJailTime] = timeVal*60;
	format(PlayerInfo[playerid][pAJreason], MAX_AJ_REASON, result);
	SetPlayerVirtualWorld(playerid, 1000+playerid);
	PlayerInfo[playerid][pMuted] = 1;
	SetPlayerPos(playerid, 1481.1666259766,-1790.2204589844,156.7875213623);
	poscig[playerid] = 0;
	format(string, sizeof(string), "%s zostal uwieziony w AJ przez %s na %d powod: %s", GetNick(playerid), GetNickEx(adminid), timeVal, (result)); 
	SendMessageToAdmin(string, COLOR_RED); 
	Log(punishmentLog, INFO, "Admin %s ukara³ %s kar¹ AJ %d minut, powód: %s", 
		GetPlayerLogName(adminid),
		GetPlayerLogName(playerid),
		timeVal,
		result);
	if(GetPlayerAdminDutyStatus(adminid) == 1)
	{
		iloscAJ[adminid]++; 
	}
	else if(GetPlayerAdminDutyStatus(adminid) == 0)
	{
		iloscPozaDuty[adminid]++; 
	}
	//adminowe logi
	format(string, sizeof(string), "Admini/%s.ini", GetNickEx(adminid));
	dini_IntSet(string, "Ilosc_AJ", dini_Int(string, "Ilosc_AJ")+1 );
	SendClientMessage(playerid, COLOR_NEWS, "SprawdŸ czy otrzymana kara jest zgodna z list¹ kar i zasad, znajdziesz j¹ na www.Mrucznik-RP.pl");
	Wchodzenie(playerid);		
	return 1;
}
GiveKickForPlayer(playerid, adminid, result[])//zjebane
{
	new string[256];
	SendClientMessage(playerid, COLOR_NEWS, "SprawdŸ czy otrzymana kara jest zgodna z list¹ kar i zasad, znajdziesz j¹ na www.Mrucznik-RP.pl");
	format(string, sizeof(string), "AdmCmd: Admin %s zkickowa³ %s, Powód: %s", GetNickEx(adminid), GetNick(playerid), (result));
	SendMessageToAdmin(string, COLOR_RED); 
	Log(punishmentLog, INFO, "Admin %s ukara³ %s kar¹ kick, powód: %s", 
		GetPlayerLogName(adminid),
		GetPlayerLogName(playerid),
		result);
	//adminduty
	if(GetPlayerAdminDutyStatus(adminid) == 1)
	{
		iloscKick[adminid]++;
	}
	else if(GetPlayerAdminDutyStatus(adminid) == 0)
	{
		iloscPozaDuty[adminid]++; 
	}

	format(string, sizeof(string), "Admini/%s.ini", GetNickEx(adminid));
	dini_IntSet(string, "Ilosc_Kickow", dini_Int(string, "Ilosc_Kickow")+1 );
	KickEx(playerid);
	SetTimerEx("AntySpamTimer",5000,0,"d",adminid);
	AntySpam[adminid] = 1;
	return 1;
}
GiveBPForPlayer(playerid, adminid, timeVal, result[])
{
	new string[256];
	PlayerInfo[playerid][pBP] = timeVal;
	SendClientMessage(playerid, COLOR_NEWS, "SprawdŸ czy otrzymana kara jest zgodna z list¹ kar i zasad, znajdziesz j¹ na www.Mrucznik-RP.pl");
	format(string, sizeof(string), "AdmCmd: %s dostal BP od %s na %d godzin, z powodem %s", GetNick(playerid), GetNickEx(adminid), timeVal, result);
	SendMessageToAdmin(string, COLOR_RED); 
	Log(punishmentLog, INFO, "Admin %s ukara³ %s kar¹ blokady pisania na %d godzin, powód: %s", 
		GetPlayerLogName(adminid),
		GetPlayerLogName(playerid),
		timeVal,
		result);
	//opis
	//Opis_Usun(giveplayerid);
	Update3DTextLabelText(PlayerInfo[playerid][pDescLabel], 0xBBACCFFF, "");
	PlayerInfo[playerid][pDesc][0] = EOS;
	if(GetPlayerAdminDutyStatus(adminid) == 0)
	{
		iloscPozaDuty[adminid]++; 
	}
	else if(GetPlayerAdminDutyStatus(adminid) == 1)
	{
		iloscInne[adminid]++; 
	}
	return 1;
}
GiveBlockForPlayer(playerid, adminid, result[])
{
	new string[256];
	new nickDoBlocka[MAX_PLAYER_NAME];
	strcat(nickDoBlocka, GetNick(playerid)); 
	format(string, sizeof(string), "AdmCmd: Konto gracza %s zostalo zablokowane przez %s, Powod: %s", GetNick(playerid), GetNickEx(adminid), (result));
	SendMessageToAdmin(string, COLOR_RED); 
	Log(punishmentLog, INFO, "Admin %s ukara³ %s kar¹ blocka, powód: %s", 
			GetPlayerLogName(adminid),
			GetPlayerLogName(playerid),
			result);
	PlayerInfo[playerid][pBlock] = 1;
	KickEx(playerid);
	SetTimerEx("AntySpamTimer",5000,0,"d",adminid);
	AntySpam[adminid] = 1;
	MruMySQL_Blockuj(nickDoBlocka, adminid, (result));
	if(GetPlayerAdminDutyStatus(adminid) == 1)
	{
		iloscBan[adminid] = iloscBan[adminid]+1;
	}
	else if(GetPlayerAdminDutyStatus(adminid) == 0)
	{
		iloscPozaDuty[adminid]++; 
	}
	return 1;
}
GivePBanForPlayer(player[], adminid, result[])
{
	new nickDoBlocka[MAX_PLAYER_NAME];
	strcat(nickDoBlocka, player);
	new string[256];
	format(string, sizeof(string), "AdmCmd: Konto gracza OFFLINE %s zostalo zbanowane przez %s, Powod: %s ", nickDoBlocka, GetNickEx(adminid), (result));
	SendMessageToAdmin(string, COLOR_RED); 
	Log(punishmentLog, INFO, "Admin %s ukara³ offline %s kar¹ bana, powód: %s", 
		GetPlayerLogName(adminid),
		player,
		result);
	MruMySQL_BanujOffline(nickDoBlocka, result, adminid);
	SetTimerEx("AntySpamTimer",5000,0,"d",adminid);
	AntySpam[adminid] = 1;
	if(GetPlayerAdminDutyStatus(adminid) == 1)
	{
		iloscBan[adminid] = iloscBan[adminid]+1;
	}
	else if(GetPlayerAdminDutyStatus(adminid) == 0)
	{
		iloscPozaDuty[adminid]++; 
	}
	return 1;
}	
GivePBlockForPlayer(player[], adminid, result[])
{
	new string[256];
	new nickDoBlocka[MAX_PLAYER_NAME];
	strcat(nickDoBlocka, player); 
	format(string, sizeof(string), "AdmCmd: Konto gracza OFFLINE %s zostalo zablokowane przez %s, Powod: %s", player, GetNickEx(adminid), (result));
	SendMessageToAdmin(string, COLOR_RED); 
	Log(punishmentLog, INFO, "Admin %s ukara³ offline %s kar¹ blocka, powód: %s", 
		GetPlayerLogName(adminid),
		player,
		result);
	MruMySQL_Blockuj(nickDoBlocka, adminid, (result));
	SetTimerEx("AntySpamTimer",5000,0,"d",adminid);
	AntySpam[adminid] = 1;
	if(GetPlayerAdminDutyStatus(adminid) == 1)
	{
		iloscBan[adminid] = iloscBan[adminid]+1;
	}
	else if(GetPlayerAdminDutyStatus(adminid) == 0)
	{
		iloscPozaDuty[adminid]++; 
	}
	return 1;
}


//-----------------<[ Timery: ]>-------------------

forward StopDraw();
public StopDraw()
{
	foreach(new i : Player)
	{
		PlayerTextDrawHide(i, Kary[i]); 
	}
	KillTimer(karaTimer);
	return 1;
}


//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end