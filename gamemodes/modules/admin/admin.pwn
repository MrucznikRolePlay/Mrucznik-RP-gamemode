//admin.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//------------------------------------------[ Modu³: admin.pwn ]---------------------------------------------//
//Opis:
/*
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
		> karytxd - kary w txd
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
		> bwsettings - odpala ustawienia BW
		> bwtime - ustala BW time
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
		> cziterzy - pokazuje liste osób, które AC uzna³ za cziterów 
		> checkprawko - sprawdza czy gracz ma prawo jazdy
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
		
*/
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

//

//-----------------<[ Funkcje: ]>-------------------
IsAHeadAdmin(playerid)
{
	if(!IsAHeadAdmin(playerid))
	{
		return 1;
	}
	return 0;
}
IsAScripter(playerid)
{
	if(PlayerInfo[playerid][pNewAP] != 5)
	{
		return 1;
	}
	return 0;
}
stock KickPlayerTXD(playerid, adminid, reason[])
{
    //PlayerLogged[playerid]=0;
    new str[128];
    format(str, sizeof(str), "~r~Kick~w~~n~Dla: %s~n~Od: %s~n~~y~Powod: ~w~%s", GetNick(playerid), GetNick(adminid), reason);
    TextDrawSetString(Kary, str);
    TextDrawShowForAll(Kary);
	karaTimer = SetTimer("StopDraw", 15000, false);
	foreach(Player, i)
	{
		if(togADMTXD[i] == 1)
		{
			TextDrawHideForPlayer(i, Kary); 
		}
	}
    return 1;
}
stock AJPlayerTXD(playerid, adminid, reason[])
{
	new str[256];
    format(str, sizeof(str), "~r~AdminJail~w~~n~Dla: %s~n~Od: %s~n~~y~Powod: ~w~%s", GetNick(playerid), GetNick(adminid), reason);
    TextDrawSetString(Kary, str);
    TextDrawShowForAll(Kary);
	karaTimer = SetTimer("StopDraw", 15000, false);
	foreach(Player, i)
	{
		if(togADMTXD[i] == 1)
		{
			TextDrawHideForPlayer(i, Kary); 
		}
	}
	return 1;
}
stock BPPlayerTXD(playerid, adminid, timeVal, reason[])
{
	new str[256];
    format(str, sizeof(str), "~r~Blokada Pisania~w~~n~Dla: %s~n~Od: %s~n~Na: %d godzin~n~~y~Powod: ~w~%s", GetNick(playerid), GetNick(adminid), timeVal, reason);
    TextDrawSetString(Kary, str);
    TextDrawShowForAll(Kary);
	karaTimer = SetTimer("StopDraw", 15000, false);
	foreach(Player, i)
	{
		if(togADMTXD[i] == 1)
		{
			TextDrawHideForPlayer(i, Kary); 
		}
	}
	return 1;
}
stock BanPlayerTXD(playerid, adminid, reason[])
{
	new str[128];
    format(str, sizeof(str), "~r~Ban~w~~n~Dla: %s~n~Od: %s~n~~y~Powod: ~w~%s", GetNick(playerid), GetNick(adminid), reason);
    TextDrawSetString(Kary, str);
    TextDrawShowForAll(Kary);
	karaTimer = SetTimer("StopDraw", 15000, false);
	foreach(Player, i)
	{
		if(togADMTXD[i] == 1)
		{
			TextDrawHideForPlayer(i, Kary); 
		}
	}

	return 1;
}
stock WarnPlayerTXD(playerid, adminid, reason[])
{
	new str[128];
    format(str, sizeof(str), "~r~Warn~w~~n~Dla: %s~n~Od: %s~n~~y~Powod: ~w~%s", GetNick(playerid), GetNick(adminid), reason);
    TextDrawSetString(Kary, str);
    TextDrawShowForAll(Kary);
	karaTimer = SetTimer("StopDraw", 15000, false);
	foreach(Player, i)
	{
		if(togADMTXD[i] == 1)
		{
			TextDrawHideForPlayer(i, Kary); 
		}
	}
	return 1;
}
stock BlockPlayerTXD(playerid, adminid, reason[])
{
	new str[128];
    format(str, sizeof(str), "~r~Block~w~~n~Dla: %s~n~Od: %s~n~~y~Powod: ~w~%s", GetNick(playerid), GetNick(adminid), reason);
    TextDrawSetString(Kary, str);
    TextDrawShowForAll(Kary);
	karaTimer = SetTimer("StopDraw", 15000, false);
	foreach(Player, i)
	{
		if(togADMTXD[i] == 1)
		{
			TextDrawHideForPlayer(i, Kary); 
		}
	}
	return 1;
}
stock PWarnPlayerTXD(player[], adminid, result[])
{
	new str[128];
	new nickDoWarna[MAX_PLAYER_NAME]; 
	strcat(nickDoWarna, player); 
    format(str, sizeof(str), "~r~Warn Offline~w~~n~Dla: %s~n~Od: %s~n~~y~Powod: ~w~%s", nickDoWarna, GetNick(adminid), result);
    TextDrawSetString(Kary, str);
    TextDrawShowForAll(Kary);
	karaTimer = SetTimer("StopDraw", 15000, false);
	foreach(Player, i)
	{
		if(togADMTXD[i] == 1)
		{
			TextDrawHideForPlayer(i, Kary); 
		}
	}
	return 1;
}
stock GivePWarnForPlayer(player[], adminid, result[]) 
{
	new nickDoWarna[MAX_PLAYER_NAME];
	strcat(nickDoWarna, player); 
	new string[256];
	format(string, sizeof(string), "AdmCmd: Konto gracza OFFLINE %s zostalo zwarnowane przez %s, Powod: %s", nickDoWarna, GetNick(adminid), (result));
	WarnLog(string);
	MruMySQL_SetAccInt("Warnings", nickDoWarna, MruMySQL_GetAccInt("Warnings", nickDoWarna)+1);
	SetTimerEx("AntySpamTimer",5000,0,"d",adminid);
	AntySpam[adminid] = 1;
	if(GetPlayerAdminDutyStatus(adminid) == 1)
	{
		iloscWarn[adminid] = iloscWarn[adminid]+1;
	}
	else if(GetPlayerAdminDutyStatus(adminid) == 0)
	{
		sendErrorMessage(adminid, "Nie jesteœ podczas s³u¿by administratora, Warn nie zostaje zaliczony!"); 
	}
	return 1;
}
stock GiveWarnForPlayer(playerid, adminid, result[])
{
	new str[256];
	new string[256];
	PlayerInfo[playerid][pWarns] += 1;
	if(PlayerInfo[playerid][pWarns] >= 3)
	{
		SendClientMessage(playerid, COLOR_NEWS, "SprawdŸ czy otrzymana kara jest zgodna z list¹ kar i zasad, znajdziesz j¹ na www.Mrucznik-RP.pl");
		format(string, sizeof(string), "AdmCmd: %s zosta³ zbanowany przez Admina %s (3 warny), powód: %s", GetNick(playerid), GetNick(adminid), (result));
		BanLog(string);
		if(GetPlayerAdminDutyStatus(adminid) == 1)
		{
			iloscBan[adminid]++; 
		}
		//adminowe logi
		format(str, sizeof(str), "Admini/%s.ini", GetNick(adminid));
		dini_IntSet(str, "Ilosc_Warnow", dini_Int(str, "Ilosc_Warnow")+1 );
		MruMySQL_Banuj(playerid, result, adminid);
		KickEx(playerid);
		return 1;	
	}
	format(str, sizeof(str), "Dosta³eœ warna od %s, powód: %s", GetNick(adminid), (result));
	SendClientMessage(playerid, COLOR_LIGHTRED, str);
	format(string, sizeof(string), "AdmCmd: %s zosta³ zwarnowany przez Admina %s, powód: %s", GetNick(playerid), GetNick(adminid), (result));
	WarnLog(string);
	SetTimerEx("AntySpamTimer",5000,0,"d",adminid);
	AntySpam[adminid] = 1;
	KickEx(playerid);
	if(GetPlayerAdminDutyStatus(adminid) == 1)
	{
		iloscWarn[adminid] = iloscWarn[adminid]+1;
	}
	return 1;
}
stock PBlockPlayerTXD(player[], adminid, reason[])
{
	new str[128];
	new nickOdbieracza[MAX_PLAYER_NAME];
	strcat(nickOdbieracza, player); 
    format(str, sizeof(str), "~r~Block Offline~w~~n~Dla: %s~n~Od: %s~n~~y~Powod: ~w~%s", nickOdbieracza, GetNick(adminid), reason);
    TextDrawSetString(Kary, str);
    TextDrawShowForAll(Kary);
	karaTimer = SetTimer("StopDraw", 15000, false);
	foreach(Player, i)
	{
		if(togADMTXD[i] == 1)
		{
			TextDrawHideForPlayer(i, Kary); 
		}
	}
	return 1;
}
stock PBanPlayerTXD(player[], adminid, reason[])
{
	new str[128];
	new nickOdbieracza[MAX_PLAYER_NAME];
	strcat(nickOdbieracza, player); 
    format(str, sizeof(str), "~r~Ban Offline~w~~n~Dla: %s~n~Od: %s~n~~y~Powod: ~w~%s", nickOdbieracza, GetNick(adminid), reason);
    TextDrawSetString(Kary, str);
    TextDrawShowForAll(Kary);
	karaTimer = SetTimer("StopDraw", 15000, false);
	foreach(Player, i)
	{
		if(togADMTXD[i] == 1)
		{
			TextDrawHideForPlayer(i, Kary); 
		}
	}
	return 1;
}
stock PAJPlayerTXD(player[], adminid, timeVal, reason[])
{
	new nickOdbieracza[MAX_PLAYER_NAME];
	strcat(nickOdbieracza, player); 
	new str[128];
    format(str, sizeof(str), "~r~AJ Offline~w~~n~Dla: %s~n~Od: %s~n~Na %d~n~~y~Powod: ~w~%s", nickOdbieracza, GetNick(adminid), timeVal, reason);
    TextDrawSetString(Kary, str);
    TextDrawShowForAll(Kary);
	karaTimer = SetTimer("StopDraw", 15000, false);
	foreach(Player, i)
	{
		if(togADMTXD[i] == 1)
		{
			TextDrawHideForPlayer(i, Kary); 
		}
	}
	return 1;
}
stock SetPlayerPAdminJail(player[], adminid, timeVal, result[])
{
	new nickOdbieracza[MAX_PLAYER_NAME];
	strcat(nickOdbieracza, player); 
	new string[256];
	format(string, sizeof(string), "AdmCmd: Konto gracza offline %s dosta³o aj na %d od %s, Powod: %s", nickOdbieracza, timeVal, GetNick(adminid), (result));
	KickLog(string);
	if(GetPlayerAdminDutyStatus(adminid) == 1)
	{
		iloscAJ[adminid] = iloscAJ[adminid]+1;
	
	}
	MruMySQL_SetAccInt("Jailed", nickOdbieracza, 3);
	MruMySQL_SetAccInt("JailTime", nickOdbieracza, timeVal*60);
	SetTimerEx("AntySpamTimer",5000,0,"d",adminid);
	AntySpam[adminid] = 1;
	return 1;
}
stock SetPlayerAdminJail(playerid, adminid, timeVal, result[])
{
	new string[256];
	format(string, sizeof(string), "* Zosta³eœ uwieziony w Admin Jailu przez Admina %s, Czas: %d. Powod: %s", GetNick(adminid), timeVal, (result));
	SendClientMessage(playerid, COLOR_LIGHTRED, string);
	PlayerInfo[playerid][pJailed] = 3;
	PlayerInfo[playerid][pJailTime] = timeVal*60;
	SetPlayerVirtualWorld(playerid, 1000+playerid);
	PlayerInfo[playerid][pMuted] = 1;
	SetPlayerPosEx(playerid, 1481.1666259766,-1790.2204589844,156.7875213623);
	poscig[playerid] = 0;
	format(string, sizeof(string), "%s zostal uwieziony w AJ przez %s na %d powod: %s", GetNick(playerid), GetNick(adminid), timeVal, (result)); 
	KickLog(string);
	if(GetPlayerAdminDutyStatus(playerid) == 1)
	{
		iloscAJ[playerid] = iloscAJ[playerid]+1;
	}
	//adminowe logi
	format(string, sizeof(string), "Admini/%s.ini", GetNick(adminid));
	dini_IntSet(string, "Ilosc_AJ", dini_Int(string, "Ilosc_AJ")+1 );
	SendClientMessage(playerid, COLOR_NEWS, "SprawdŸ czy otrzymana kara jest zgodna z list¹ kar i zasad, znajdziesz j¹ na www.Mrucznik-RP.pl");
	Wchodzenie(playerid);		
	return 1;
}
stock GiveKickForPlayer(playerid, adminid, result[])
{
	new string[256];
	SendClientMessage(playerid, COLOR_NEWS, "SprawdŸ czy otrzymana kara jest zgodna z list¹ kar i zasad, znajdziesz j¹ na www.Mrucznik-RP.pl");
	format(string, sizeof(string), "AdmCmd: Admin %s zkickowa³ %s, Powód: %s", GetNick(adminid), GetNick(playerid), (result));
	KickLog(string);
	//adminduty
	if(GetPlayerAdminDutyStatus(playerid) == 1)
	{
		iloscKick[playerid] = iloscKick[playerid]+1;
	}

	format(string, sizeof(string), "Admini/%s.ini", GetNick(adminid));
	dini_IntSet(string, "Ilosc_Kickow", dini_Int(string, "Ilosc_Kickow")+1 );
	KickEx(playerid);
	SetTimerEx("AntySpamTimer",5000,0,"d",adminid);
	AntySpam[adminid] = 1;
	return 1;
}
stock GiveBPForPlayer(playerid, adminid, timeVal, result[])
{
	new string[256];
	PlayerInfo[playerid][pBP] = timeVal;
	SendClientMessage(playerid, COLOR_NEWS, "SprawdŸ czy otrzymana kara jest zgodna z list¹ kar i zasad, znajdziesz j¹ na www.Mrucznik-RP.pl");
	format(string, sizeof(string), "AdmCmd: %s dostal BP od %s na %d godzin, z powodem %s", GetNick(playerid), GetNick(adminid), timeVal, result);
	KickLog(string);
	//opis
	//Opis_Usun(giveplayerid);
	Update3DTextLabelText(PlayerInfo[playerid][pDescLabel], 0xBBACCFFF, "");
	PlayerInfo[playerid][pDesc][0] = EOS;
	return 1;
}
stock GiveBlockForPlayer(playerid, adminid, result[])
{
	new string[256];
	new nickDoBlocka[MAX_PLAYER_NAME];
	strcat(nickDoBlocka, GetNick(playerid)); 
	format(string, sizeof(string), "AdmCmd: Konto gracza %s zostalo zablokowane przez %s, Powod: %s", GetNick(playerid), GetNick(adminid), (result));
	BanLog(string);
	PlayerInfo[playerid][pBlock] = 1;
	KickEx(playerid);
	SetTimerEx("AntySpamTimer",5000,0,"d",adminid);
	AntySpam[adminid] = 1;
	MruMySQL_Blockuj(nickDoBlocka, adminid, (result));
	if(GetPlayerAdminDutyStatus(adminid) == 1)
	{
		iloscBan[adminid] = iloscBan[adminid]+1;
	}
	return 1;
}
stock GivePBanForPlayer(player[], adminid, result[])
{
	new nickDoBlocka[MAX_PLAYER_NAME];
	strcat(nickDoBlocka, player);
	new string[256];
	format(string, sizeof(string), "AdmCmd: Konto gracza OFFLINE %s zostalo zbanowane przez %s, Powod: %s ", nickDoBlocka, GetNick(adminid), (result));
	BanLog(string);
	MruMySQL_BanujOffline(nickDoBlocka, result, adminid);
	SetTimerEx("AntySpamTimer",5000,0,"d",adminid);
	AntySpam[adminid] = 1;
	if(GetPlayerAdminDutyStatus(adminid) == 1)
	{
		iloscBan[adminid] = iloscBan[adminid]+1;
	}
	return 1;
}	
stock GivePBlockForPlayer(player[], adminid, result[])
{
	new string[256];
	new nickDoBlocka[MAX_PLAYER_NAME];
	strcat(nickDoBlocka, player); 
	format(string, sizeof(string), "AdmCmd: Konto gracza OFFLINE %s zostalo zablokowane przez %s, Powod: %s", player, GetNick(adminid), (result));
	BanLog(string);
	MruMySQL_Blockuj(nickDoBlocka, adminid, (result));
	SetTimerEx("AntySpamTimer",5000,0,"d",adminid);
	AntySpam[adminid] = 1;
	if(GetPlayerAdminDutyStatus(adminid) == 1)
	{
		iloscBan[adminid] = iloscBan[adminid]+1;
	}

	return 1;
}
//-----------------<[ Komendy: ]>-------------------
CMD:showkary(playerid)
{
	if(IsAScripter(playerid) || PlayerInfo[playerid][pAdmin] > 4500)
	{
		if(kary_TXD_Status == 0)
		{
			sendTipMessage(playerid, "W³¹czy³eœ wyœwietlanie kar w Text Draw'ach"); 
			kary_TXD_Status = 1;
			return 1;
		}
		if(kary_TXD_Status == 1)
		{
			sendTipMessage(playerid, "Wy³¹czy³eœ wyœwietlanie kar w Text Draw'ach"); 
			kary_TXD_Status = 0;
			return 1;
		}
	}
	else
	{
		noAccessMessage(playerid); 
	}
	return 1;
}
CMD:togtxda(playerid)
{
	if(togADMTXD[playerid] == 0)
	{
		togADMTXD[playerid] =1;
		sendTipMessage(playerid, "TOG: Wy³¹czy³eœ Text'Drawy z karami"); 
	}
	else if(togADMTXD[playerid] == 1)
	{
		togADMTXD[playerid] = 0; 
		sendTipMessage(playerid, "TOG: W³¹czy³eœ Text'Drawy z karami"); 
	}
	return 1;
}
CMD:admins(playerid) return cmd_admini(playerid);
CMD:admini(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		new string[128]; 
		SendClientMessage(playerid, -1, "Lista administratorów na s³u¿bie:"); 
		SendClientMessage(playerid, -1, " "); 
		foreach(Player, i)
		{
			if(GetPlayerAdminDutyStatus(i) == 1)
			{
				GetPVarString(i, "pAdminDutyNickOff", FirstNickname, sizeof(FirstNickname)); 
				if(PlayerInfo[i][pAdmin] >= 1 && PlayerInfo[i][pAdmin] != 5000)
				{
					format(string, sizeof(string), "{FFFFFF}Administrator: {FF6A6A}%s {FFFFFF}[ID: %d] [FN: %s] [@LVL: %d]", GetNick(i), i, FirstNickname); 
				}
				else if(PlayerInfo[i][pNewAP] >= 1 && PlayerInfo[i][pNewAP] != 5)
				{
					format(string, sizeof(string), "{FFFFFF}Pó³-Admin: {00C0FF}%s {FFFFFF}[ID: %d] [FN: %s]", GetNick(i), i, FirstNickname); 
				}
				else if(PlayerInfo[i][pNewAP] == 5) 
				{
					format(string, sizeof(string), "{FFFFFF}Skrypter serwera: {747b41}%s {FFFFFF}[ID: %d] [FN: %s]", GetNick(i), i, FirstNickname);
				}
				else if(PlayerInfo[i][pAdmin] == 5000)
				{
					format(string, sizeof(string), "{FFFFFF}G³ówny administrator: {FF6A6A}%s {FFFFFF}[ID: %d] [FN: %s]", GetNick(i), i, FirstNickname);
				}
				sendTipMessage(playerid, string); 
			}
		}
		
	}
	return 1;
}
CMD:nonewbie(playerid)
{
    if(IsPlayerConnected(playerid))
    {
        new string[128];
		if (PlayerInfo[playerid][pAdmin] >= 5 && (!newbie) || IsAScripter(playerid) && (!newbie))
		{
			newbie = 1;
			BroadCast(COLOR_GRAD2, "Czat newbie zosta³ zablokowany przez Administratora!");
            format(string, 128, "CMD_Info: /nonewbie u¿yte przez %s [%d]", GetNick(playerid), playerid);
            SendCommandLogMessage(string);
            CMDLog(string);
		}
		else if (PlayerInfo[playerid][pAdmin] >= 5 && (newbie) || IsAScripter(playerid) && (newbie))
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
            format(string, 128, "CMD_Info: /nonewbie u¿yte przez %s [%d]", GetNick(playerid), playerid);
            SendCommandLogMessage(string);
            CMDLog(string);
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:check(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
		if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1)
		{
			new giveplayerid;
			if( sscanf(params, "k<fix>", giveplayerid))
			{
				sendTipMessage(playerid, "U¿yj /check [playerid/CzêœæNicku]");
				return 1;
			}


			if(IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
					ShowStats(playerid,giveplayerid);
				}
			}
			else
			{
				sendErrorMessage(playerid, "Nie ma takiego gracza");
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:dn(playerid)
{
    if(IsPlayerConnected(playerid))
    {
		if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pAdmin] == 7)
		{
			new Float:slx, Float:sly, Float:slz;
			GetPlayerPos(playerid, slx, sly, slz);
			SetPlayerPosEx(playerid, slx, sly, slz-2);
			return 1;
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}

CMD:up(playerid)
{
    if(IsPlayerConnected(playerid))
    {
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			new Float:slx, Float:sly, Float:slz;
			GetPlayerPos(playerid, slx, sly, slz);
			SetPlayerPosEx(playerid, slx, sly, slz+2);
			return 1;
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:usunpozar(playerid)
{
	if (PlayerInfo[playerid][pAdmin] >= 15 || PlayerInfo[playerid][pAdmin] == 7 || IsAScripter(playerid))
	{
	    DeleteAllFire();
	    sendTipMessage(playerid, "Usun¹³eœ aktywne po¿ary!");
	    sendTipMessage(playerid, "Aby wywo³aæ losowy po¿ar wpisz /losowypozar !");
	    
	    new string[128];
        format(string, 128, "CMD_Info: /usunpozar u¿yte przez %s [%d]", GetNick(playerid), playerid);
        SendCommandLogMessage(string);
        CMDLog(string);
	}
	else
	{
		noAccessMessage(playerid);
	}
	return 1;
}
CMD:losowypozar(playerid)
{
	if (PlayerInfo[playerid][pAdmin] >= 15 || PlayerInfo[playerid][pAdmin] == 7 || IsAScripter(playerid))
	{
	    DeleteAllFire();
	    AktywujPozar();
	    sendTipMessage(playerid, "Aktywowa³eœ losowy po¿ar dla LSFD!");
	    sendTipMessage(playerid, "Aby usun¹æ po¿ar wpisz /usunpozar !");
	    
	    new string[128];
        format(string, 128, "CMD_Info: /losowypozar u¿yte przez %s [%d]", GetNick(playerid), playerid);
        SendCommandLogMessage(string);
        CMDLog(string);
	}
	else
	{
		noAccessMessage(playerid);
	}
	return 1;
}
CMD:unblock(playerid, params[])
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj /unblock [nick]");
			return 1;
		}
        if(MruMySQL_Unblock(params, playerid))
        {
    		format(string, sizeof(string), "Administrator %s ublokowa³ %s", sendername, params);
            //SendPunishMessage(string);
            ABroadCast(COLOR_YELLOW,string,1);
            BanLog(string);
        }
	}
	return 1;
}
CMD:gotobiz(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
		new plo;
		if(sscanf(params, "d", plo)) return sendTipMessage(playerid, "U¿yj /gototbiz [ID biznesu]");
		if(plo >= 1)
		{
		    if(plo <= 100)
		    {
				if(PlayerInfo[playerid][pAdmin] >= 1)
				{
				    if(BizData[plo][eBizWejX] == 0.0 && BizData[plo][eBizWejY] == 0.0 && BizData[plo][eBizWejZ] == 0.0) return _MruAdmin(playerid, sprintf("Nie mo¿na siê teleportowaæ. Biznes %s (ID %d) nie jest aktywny.", BizData[plo][eBizName], plo));
					SetPlayerPosEx(playerid, BizData[plo][eBizWejX],BizData[plo][eBizWejY],BizData[plo][eBizWejZ]);
					SetPlayerInterior(playerid, 0);
					SetPlayerVirtualWorld(playerid, 0);
  					_MruAdmin(playerid, sprintf("Teleportowa³eœ siê do biznesu %s (ID %d)", BizData[plo][eBizName], plo));
				}
				else
				{
					noAccessMessage(playerid);
				}
			}
		}
	}
	return 1;
}

CMD:resetsejfhasla(playerid)
{
	new string[64];

	if(IsAHeadAdmin(playerid))
	{
	    new xxx[20];
        for(new i; i <= dini_Int("Domy/NRD.ini", "NrDomow"); i++)
		{
     		format(xxx, sizeof(xxx), "500500500500");
     		Dom[i][hKodSejf] = xxx;
     		ZapiszDom(i);
     		format(string, sizeof(string), "Dom %d zapisany", i);
     		SendClientMessage(playerid, COLOR_WHITE, string);
		}
		ZapiszDomy();
		SendClientMessage(playerid, COLOR_WHITE, "Wszystkie domy maj¹ teraz kod do sejfu 500500500500");
	}
	return 1;
}

CMD:zapiszdomy(playerid)
{
	if(PlayerInfo[playerid][pAdmin] >= 5000)
	{
		ZapiszDomy();
		SendClientMessage(playerid, COLOR_WHITE, "Wszystkie domy zosta³y zapisane");
	}
	return 1;
}

CMD:zapiszkonta(playerid)
{
    if(PlayerInfo[playerid][pAdmin] >= 5000)
	{
        foreach(Player, i) MruMySQL_SaveAccount(i);
    	SendClientMessageToAll(COLOR_WHITE, "Wszystkie konta zosta³y zapisane");
	}
	return 1;
}
CMD:ann(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] > 5)
	{
		new string[128];
		new sendername[MAX_PLAYER_NAME];

		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj /ann [cnn textformat ~n~=nowa linia ~r~=czerwony ~g~=zielony ~b~=niebieski ~w~=bia³y ~y~=¿ó³ty]");
			return 1;
		}
		format(string, sizeof(string), "  ~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~                         %s",params);
        if(!issafefortextdraw(string)) return sendErrorMessage(playerid, "Niekompletny tekst (tyldy etc)");
        GameTextForAll(string, 3000, 3);
		format(string, sizeof(string), "AdmCmd: %s [ID: %d] napisal cos na /ann", sendername, playerid);
		ABroadCast(COLOR_PANICRED,string,1);

        strcat(string, " - ");
        strcat(string, params);
        CMDLog(string);
	}
	else
	{
	    noAccessMessage(playerid);
	}
	return 1;
}
CMD:unspec(playerid, params[])
{
	if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || PlayerInfo[playerid][pZG] >= 3)
        {
			PlayerInfo[playerid][pInt] = Unspec[playerid][sPint];
			PlayerInfo[playerid][pLocal] = Unspec[playerid][sLocal];
			SetPlayerToTeamColor(playerid);
			MedicBill[playerid] = 0;
			SetSpawnInfo(playerid, PlayerInfo[playerid][pTeam], PlayerInfo[playerid][pModel], Unspec[playerid][Coords][0], Unspec[playerid][Coords][1], Unspec[playerid][Coords][2], 10.0, -1, -1, -1, -1, -1, -1);
			Spectate[playerid] = INVALID_PLAYER_ID;
			TogglePlayerSpectating(playerid, 0);
		}
	}
	return 0;
}

CMD:spec(playerid, params[])
{
	new string[128];
	new sendername[MAX_PLAYER_NAME+1];
	new giveplayer[MAX_PLAYER_NAME+1];

    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || PlayerInfo[playerid][pZG] >= 3)
        {
            GetPlayerName(playerid, sendername, sizeof(sendername));
            new pid;
			if(sscanf(params, "k<fix>", pid)) return sendTipMessage(playerid, "U¿yj /spec [Nick lub ID gracza] - Aby wy³¹czyæ - Klawisz skoku");
            if(pid == INVALID_PLAYER_ID) return sendErrorMessage(playerid, "Cel nie jest osiagalny.");
            if(pid == playerid) return sendErrorMessage(playerid, "Cel nie jest osiagalny.");
	        /*if(SpectateTime[playerid] >= 1)
	        {
				new Float:spectime = (SpectateTime[playerid]*2)/60;
	            if (PlayerInfo[playerid][pZG] >= 1)
			    {
			        format(string, sizeof(string), "Zaufani/%s.ini", sendername);
			        dini_FloatSet(string, "Realna_aktywnosc", dini_Float(string, "Realna_aktywnosc")+spectime);
			    }
			    else
			    {
		            format(string, sizeof(string), "Admini/%s.ini", sendername);
		        	dini_FloatSet(string, "Realna_aktywnosc", dini_Float(string, "Realna_aktywnosc")+spectime);
				}
	        	SpectateTime[playerid] = 0;
	        }*/
            if(Unspec[playerid][Coords][0] == 0.0)
            {
                GetPlayerPos(playerid, Unspec[playerid][Coords][0], Unspec[playerid][Coords][1], Unspec[playerid][Coords][2]);
                Unspec[playerid][sPint] = GetPlayerInterior(playerid);
                Unspec[playerid][sPvw] = GetPlayerVirtualWorld(playerid);
            }
		   	Spectate[playerid] = pid;
			new Float:health;
			GetPlayerHealth(pid, health);
			GetPlayerName(pid, giveplayer, sizeof(giveplayer));
			new cash =  GetPlayerMoney(pid);
			SetPlayerInterior(playerid, GetPlayerInterior(pid));
			SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(pid));
            SetPlayerColor(playerid,COLOR_SPEC);
			format(string, sizeof(string), "Podglad: %s [%d] $%d | Lvl: %d | Prawko - %s | AJ/Jail - %s",giveplayer,pid,cash,PlayerInfo[pid][pLevel],(PlayerInfo[pid][pCarLic]==1) ? ("Tak") : ("Nie"),(PlayerInfo[pid][pJailTime] > 0) ? ("Tak") : ("Nie"));
			SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
			PhoneOnline[playerid] = 1;
            TogglePlayerSpectating(playerid, 1);
            Streamer_ToggleAllItems(playerid, STREAMER_TYPE_OBJECT, 0);
            SetTimerEx("SpecToggle", 3000, false, "i", playerid);
            if(IsPlayerInAnyVehicle(pid)) PlayerSpectateVehicle(playerid, GetPlayerVehicleID(pid), SPECTATE_MODE_NORMAL), SetPVarInt(playerid, "spec-type", 2);
            else PlayerSpectatePlayer(playerid, pid, SPECTATE_MODE_NORMAL), SetPVarInt(playerid, "spec-type", 1);
        }
	}
	return 1;
}
CMD:setname(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

	new newname[MAX_PLAYER_NAME];
	if (PlayerInfo[playerid][pAdmin] >= 5000)//(Uprawnienia(playerid, ACCESS_OWNER))
	{
		new giveplayerid;
		if( sscanf(params, "k<fix>s[24]", giveplayerid, newname))
		{
			sendTipMessage(playerid, "U¿yj /setname [playerid] [nowynick]");
			return 1;
		}

		if(giveplayerid != INVALID_PLAYER_ID)
		{
		    if(PlayerInfo[giveplayerid][pDom] == 0)
		    {
		        if(PlayerInfo[giveplayerid][pPbiskey] == 255)
		        {
                    GetPlayerName(giveplayerid, giveplayer, MAX_PLAYER_NAME);
                    GetPlayerName(playerid, sendername, MAX_PLAYER_NAME);
                    if(ChangePlayerName(giveplayerid, newname))
                    {
    					format(string, sizeof(string), "Administrator %s zmieni³ nick %s[%d] - Nowy nick: %s", sendername,giveplayer,PlayerInfo[giveplayerid][pUID],newname);
    					SendClientMessageToAll(COLOR_LIGHTRED, string);
    					NickLog(string);

                        ShowPlayerDialogEx(giveplayerid, 70, DIALOG_STYLE_MSGBOX, "Zmiana nicku", "W³aœnie zmieni³eœ nick. Nastêpuj¹ce elementy zosta³y wyzerowane:\n\nPraca\nFrakcja\nWanted Level\nRodzina\nLider\nRanga\nSkin\nZaufany Gracz\n\n\nPamiêtaj, ¿e ka¿da zmiana nicku jest na wagê z³ota wiêc nie trwoñ ich pochopnie!\nJe¿eli dosz³o do b³êdnej zmiany zg³oœ ten fakt prêdko na forum w panelu strat!\nPamiêtaj: nowa postaæ = nowe ¿ycie.", "Dalej", "");

    					SetPlayerName(giveplayerid, newname);
                    }
				}
				else
				{
				    sendErrorMessage(playerid, "Ten gracz ma biznes, nie mo¿esz zmieniæ mu nicku");
				}
			}
			else
			{
			    sendErrorMessage(playerid, "Ten gracz ma dom, nie mo¿esz zmieniæ mu nicku");
			}
		}
		else if(giveplayerid == INVALID_PLAYER_ID)
		{
			format(string, sizeof(string), "%d nie jest aktywnym graczem.", giveplayerid);
			sendErrorMessage(playerid, string);
		}
	}
	return 1;
}
CMD:block(playerid, params[]) return cmd_blok(playerid, params);
CMD:blok(playerid, params[])
{
	new string[128];
    if(IsPlayerConnected(playerid))
    {
        new giveplayerid, result[128];
        if( sscanf(params, "k<fix>s[128]", giveplayerid, result))
        {
            sendTipMessage(playerid, "U¿yj /block [id/nick] [powod]");
            return 1;
        }

		if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pZG] >= 4 || PlayerInfo[playerid][pNewAP] >= 1 && PlayerInfo[playerid][pNewAP] <= 3 || IsAScripter(playerid))
		{
		    if(AntySpam[playerid] == 1)
		    {
		        SendClientMessage(playerid, COLOR_GREY, "Odczekaj 5 sekund");
		        return 1;
		    }
        	if(IsPlayerConnected(giveplayerid))
        	{
            	if(giveplayerid != INVALID_PLAYER_ID)
            	{
            	    if(PlayerInfo[giveplayerid][pAdmin] >= 1)
		            {
		                sendErrorMessage(playerid, "Nie mozesz zablokowaæ Admina !");
		                return 1;
		            }
		            if(PlayerInfo[giveplayerid][pNewAP] >= 1 && PlayerInfo[playerid][pZG] >= 4)
		            {
		                sendErrorMessage(playerid, "Nie mozesz zablokowaæ P@!");
		                return 1;
		            }
		            if(PlayerInfo[playerid][pZG] >= 4 && PlayerInfo[playerid][pZG] < 8 && PlayerInfo[giveplayerid][pLevel] > 1)
		            {
		                sendErrorMessage(playerid, "Nie mozesz zablokowaæ gracza z lvl wiekszym niz 1!");
		                return 1;
		            }
					GiveBlockForPlayer(giveplayerid, playerid, (result));
					if(kary_TXD_Status == 0)
					{
						format(string, sizeof(string), "Admin %s zablokowa³ konto gracza %s. Powód: %s", GetNick(playerid), GetNick(giveplayerid), (result)); 
						SendPunishMessage(string, giveplayerid);
					}
					else if(kary_TXD_Status == 1)
					{
						BlockPlayerTXD(giveplayerid, playerid, (result));
					}
	              
		            return 1;
	            }
   			}
  		}
  		else
	 	{
			format(string, sizeof(string), " %d nie jest aktywnym graczem.", giveplayerid);
      		sendErrorMessage(playerid, string);
		}
	}
	return 1;
}

CMD:sblock(playerid, params[]) return cmd_sblok(playerid, params);
CMD:sblok(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        new giveplayerid, result[64];
        if( sscanf(params, "k<fix>s[64]", giveplayerid, result))
        {
            sendTipMessage(playerid, "U¿yj /sblock [id/nick] [powod]");
            return 1;
        }

		if (PlayerInfo[playerid][pAdmin] >= 5000 || PlayerInfo[playerid][pNewAP] == 4)
		{
		    if(AntySpam[playerid] == 1)
		    {
		        SendClientMessage(playerid, COLOR_GREY, "Odczekaj 5 sekund");
		        return 1;
		    }
        	if(IsPlayerConnected(giveplayerid))
        	{
            	if(giveplayerid != INVALID_PLAYER_ID)
            	{
            	    if(PlayerInfo[giveplayerid][pAdmin] >= 1)
		            {
		                sendErrorMessage(playerid, "Nie mozesz zablokowaæ Admina !");
		                return 1;
		            }
	                GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
	                GetPlayerName(playerid, sendername, sizeof(sendername));
		            format(string, sizeof(string), "AdmCmd: Konto gracza %s zostalo sblock przez %s, Powod: %s", giveplayer, sendername, (result));
		            //PlayerInfo[giveplayerid][pCK] = 2;
		            BanLog(string);
		            PlayerInfo[playerid][pBlock] = 1;
					SendClientMessage(giveplayerid, COLOR_NEWS, "Twoje konto zosta³o zablokowane za z³y nick. Jeœli block jest nies³uszny wejdŸ na www.Mrucznik-RP.pl i napiœ proœbê o UN BLOCK");
					KickEx(giveplayerid);
					SetTimerEx("AntySpamTimer",5000,0,"d",playerid);
	    			AntySpam[playerid] = 1;
					if(GetPlayerAdminDutyStatus(playerid) == 1)
					{
						iloscBan[playerid] = iloscBan[playerid]+1;
					}
		            return 1;
	            }
   			}
  		}
  		else
	 	{
			format(string, sizeof(string), " %d nie jest aktywnym graczem.", giveplayerid);
      		sendErrorMessage(playerid, string);
		}
	}
	return 1;
}
CMD:pblock(playerid, params[]) return cmd_pblok(playerid, params);
CMD:pblok(playerid, params[])
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
		if (PlayerInfo[playerid][pAdmin] >= 1  || IsAScripter(playerid))
		{
		    if(AntySpam[playerid] == 1)
		    {
		        SendClientMessage(playerid, COLOR_GREY, "Odczekaj 5 sekund");
		        return 1;
		    }
	   		new nick[MAX_PLAYER_NAME], result[128];
			if( sscanf(params, "s[24] s[128]", nick, result))
			{
				sendTipMessage(playerid, "U¿yj /pblock [NICK GRACZA OFFLINE] [powod]");
				return 1;
			}

			new giveplayerid;
			sscanf(nick, "k<fix>", giveplayerid);
            if(IsPlayerConnected(giveplayerid))
			{
			    sendErrorMessage(playerid, "Nie mo¿esz zablokowaæ tego gracza (jest online (na serwerze))");
				return 1;
			}

			if(MruMySQL_DoesAccountExist(nick) != -1)
			{
				sendErrorMessage(playerid, "Brak gracza w bazie, nie mo¿na zablokowaæ (konto nie istnieje).");
				return 1;
			}
			GivePBlockForPlayer((nick), playerid, (result));
			if(kary_TXD_Status == 1)
			{
				PBlockPlayerTXD((nick), playerid, (result));
            }
			else if(kary_TXD_Status == 0)
			{
				format(string, sizeof(string), "Admin %s zablokowa³ (offline) konto gracza %s. Powód: %s", GetNick(playerid), nick, result);
				SendPunishMessage(string, playerid); 
			}
		}
	}
	return 1;
}
CMD:pban(playerid, params[])
{
	new string[128];
    if(IsPlayerConnected(playerid))
    {
        if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
		{
		    if(AntySpam[playerid] == 1)
		    {
		        SendClientMessage(playerid, COLOR_GREY, "Odczekaj 5 sekund");
		        return 1;
		    }

	   		new nick[MAX_PLAYER_NAME], result[128];
			if( sscanf(params, "s[21]s[128]", nick, result))
			{
                sendTipMessage(playerid, "U¿yj /pban [NICK GRACZA OFFLINE] [powod]");
                return 1;
            }
            new giveplayerid;
			sscanf(nick, "k<fix>", giveplayerid);
            if(IsPlayerConnected(giveplayerid))
			{
			    sendErrorMessage(playerid, "Nie mo¿esz zablokowaæ tego gracza (jest online (na serwerze))");
				return 1;
			}
            if(MruMySQL_DoesAccountExist(nick) != -1)
			{
				sendErrorMessage(playerid, "Brak pliku gracza, nie mo¿na zbanowaæ (konto nie istnieje).");
				return 1;
			}
			GivePBanForPlayer(nick, playerid, result);
			if(kary_TXD_Status == 1)
			{
				PBanPlayerTXD(nick, playerid, result);
            }
			else if(kary_TXD_Status == 0)
			{
				format(string, sizeof(string), "Admin %s zablokowa³ %s (Offline). Powód: %s", GetNick(playerid), nick, result);
				SendPunishMessage(string, playerid); 
			}
		}
    }
	return 1;
}

CMD:pwarn(playerid, params[])
{
	new string[128];
    if(IsPlayerConnected(playerid))
    {
        if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1)
		{
		    if(AntySpam[playerid] == 1)
		    {
		        SendClientMessage(playerid, COLOR_GREY, "Odczekaj 5 sekund");
		        return 1;
		    }

	   		new nick[MAX_PLAYER_NAME], result[64];
			if( sscanf(params, "s[21]s[64]", nick, result))
			{
                sendTipMessage(playerid, "U¿yj /pwarn [NICK GRACZA OFFLINE] [powod]");
                return 1;
            }
			new giveplayerid;
			sscanf(nick, "k<fix>", giveplayerid);
            if(IsPlayerConnected(giveplayerid))
			{
			    sendErrorMessage(playerid, "Nie mo¿esz zablokowaæ tego gracza (jest online (na serwerze))");
				return 1;
			}

			if(!MruMySQL_DoesAccountExist(nick))
			{
				sendErrorMessage(playerid, "Brak pliku gracza, nie mo¿na zwarnowaæ (konto nie istnieje).");
				return 1;
			}
			GivePWarnForPlayer(nick, playerid, result);
			if(kary_TXD_Status == 1)
			{
				PWarnPlayerTXD(nick, playerid, result);
			}
			else if(kary_TXD_Status == 0)
			{
				format(string, sizeof(string), "Admin %s nada³ warna (offline) dla %s. Powód: %s", GetNick(playerid), nick, result);
				SendPunishMessage(string, playerid);
			}
        
		}
    }
	return 1;
}

CMD:paj(playerid, params[])
{
	new string[128];
    if(IsPlayerConnected(playerid))
    {
        if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
		{
		    if(AntySpam[playerid] == 1)
		    {
		        SendClientMessage(playerid, COLOR_GREY, "Odczekaj 5 sekund");
		        return 1;
		    }

	   		new nick[MAX_PLAYER_NAME], czas, result[64];
			if( sscanf(params, "s[21]ds[64]", nick, czas, result))
			{
                sendTipMessage(playerid, "U¿yj /paj [NICK GRACZA OFFLINE] [czas] [powod]"); //
                return 1;
            }
            new giveplayerid;
			sscanf(nick, "k<fix>", giveplayerid);
            if(IsPlayerConnected(giveplayerid))
			{
			    sendErrorMessage(playerid, "Nie mo¿esz zablokowaæ tego gracza (jest online (na serwerze))");
				return 1;
			}

			if(!MruMySQL_DoesAccountExist(nick))
			{
				sendErrorMessage(playerid, "Brak pliku gracza, nie mo¿na zAJotowaæ (konto nie istnieje).");
				return 1;
			}
			SetPlayerPAdminJail(nick, playerid, czas, result);
			
			if(kary_TXD_Status == 1)
			{
				PAJPlayerTXD(nick, playerid, czas, result); 
			}
			else if(kary_TXD_Status == 0)
			{
				format(string, sizeof(string), "AdmCmd: Konto gracza offline %s dosta³o aj na %d od %s, Powod: %s", nick, czas, GetNick(playerid), (result));
				SendPunishMessage(string, playerid);
			}
		}
    }
	return 1;
}
CMD:snn(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 25)
	{
	    noAccessMessage(playerid);
	    return 1;
	}

	new string[128];
	new sendername[MAX_PLAYER_NAME];

	GetPlayerName(playerid, sendername, sizeof(sendername));

	if(isnull(params))
	{
		sendTipMessage(playerid, "U¿yj /snn [cnn textformat ~n~=nowa linia ~r~=czerwony ~g~=zielony ~b~=niebieski ~w~=bia³y ~y~=¿ó³ty]");
		return 1;
	}
	format(string, sizeof(string), "  ~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~                         %s",params);
    if(!issafefortextdraw(string)) return sendErrorMessage(playerid, "Niekompletny tekst (tyldy etc)");
    GameTextForAll(string, 3000, 1);
	format(string, sizeof(string), "AdmCmd: %s [ID: %d] napisal cos na /snn", sendername, playerid);
	ABroadCast(COLOR_PANICRED,string,1);

    strcat(string, " - ");
    strcat(string, params);
    CMDLog(string);
	return 1;
}
CMD:ip(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];

	if (PlayerInfo[playerid][pAdmin] >= 1)
	{
		new giveplayerid;
		if( sscanf(params, "k<fix>", giveplayerid))
		{
			sendTipMessage(playerid, "U¿yj /ip [playerid]");
			sendTipMessage(playerid, "FUNKCJA: Pokazuje IP wybranego gracza.");
			return 1;
		}
		if(IsPlayerConnected(giveplayerid))
		{
			if(IsAFakeKonto(giveplayerid))
			{
				format(string, sizeof(string), "-| %s IP: 62.87.184.91 |-", GetNick(giveplayerid));
				SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
				return 1;
			}
			new ip[32];
			GetPlayerIp(giveplayerid,ip,32);
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			format(string, sizeof(string), "-| %s IP: %s |-", giveplayer,ip);
			SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
            format(string, sizeof(string), "CMD_Info: %s uzyl /ip na %s", GetNick(playerid), GetNick(giveplayerid));
            CMDLog(string);
		}
		else
		{
			format(string, sizeof(string), "Nie znaleziono gracza o nicku/id %s", params);
			sendErrorMessage(playerid, string);
		}
	}
	else
	{
		noAccessMessage(playerid);
  	}
	return 1;
}

CMD:czyjtonumer(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1)
	{
		new number, offline, string[128];
		if( sscanf(params, "dD(0)", number, offline))
		{
			sendTipMessage(playerid, "U¿yj /czyjtonumer [numer] (0 - gracze online, 1 - wszystkie konta)");
			sendTipMessage(playerid, "FUNKCJA: Pokazuje do kogo nale¿y numer telefonu.");
			return 1;
		}
		
		if(number <= 0)
		{
			sendErrorMessage(playerid, "Numer telefonu musi byæ wiêkszy ni¿ 0!");
			return 1;
		}
		
		if(number == 555)
		{
			format(string, sizeof(string), "Osoby z numerem %d:", number);
			SendClientMessage(playerid, COLOR_WHITE, string);
			SendClientMessage(playerid, COLOR_WHITE, "Marcepan_Marks");
			return 1;
		}
		
		if(offline)
		{
			format(string, sizeof(string), "Osoby z numerem %d:", number);
			SendClientMessage(playerid, COLOR_WHITE, string);
			
			format(string, sizeof(string), "SELECT `Nick` FROM mru_konta WHERE `PhoneNr`='%d'", number);
			mysql_query(string);
			mysql_store_result();
			if(mysql_num_rows())
			{
				while(mysql_fetch_row_format(string, "|"))
				{
					new nick[MAX_PLAYER_NAME];
					sscanf(string, "p<|>s[24]", nick);
					SendClientMessage(playerid, COLOR_WHITE, nick);
				}
			}
			mysql_free_result();
		}
		else
		{
			foreach(Player, i)
			{
				if(PlayerInfo[i][pPnumber] == number)
				{
					SendClientMessage(playerid, COLOR_WHITE, GetNick(i));
				}
			}
		}
	}
	else
	{
		noAccessMessage(playerid);
  	}
	return 1;
}

CMD:flip(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pAdmin] < 1  && PlayerInfo[playerid][pAdmin] != 7)
		{
		    noAccessMessage(playerid);
		    return 1;
		}
		new giveplayerid;
		if( sscanf(params, "k<fix>", giveplayerid))
		{
		    sendTipMessage(playerid, "U¿yj /flip [id Gracza]");
		}
		else
		{
			if(!IsPlayerConnected(giveplayerid))
			{
				sendErrorMessage(playerid, "Nie ma takiego gracza");
				return 1;
			}
	  		new VehicleID, Float:X, Float:Y, Float:Z;
	  		GetPlayerPos(giveplayerid, X, Y, Z);
	  		VehicleID = GetPlayerVehicleID(giveplayerid);
	  		SetVehiclePos(VehicleID, X, Y, Z);
	  		SetVehicleZAngle(VehicleID, 0);

            _MruAdmin(playerid, sprintf("Postawi³eœ na ko³ach %s [ID: %d]", GetNick(giveplayerid, true), giveplayerid));
            if(giveplayerid != playerid) _MruAdmin(giveplayerid, sprintf("Admin %s [ID: %d] postawi³ Ciê na ko³ach", GetNick(playerid, true), playerid));
		}
	}
	return 1;
}
CMD:cca(playerid)
{
	new string[64];
	new sendername[MAX_PLAYER_NAME];

	if(PlayerInfo[playerid][pAdmin] >= 5 || IsAScripter(playerid))
	{
		for(new i = 0; i<200; i++)
			SendClientMessageToAll(COLOR_GREY," ");
        SendClientMessageToAll(COLOR_LIGHTRED,"=== Czat zosta³ wyczyszczony ===");
        GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s [ID: %d] uzyl /cca", sendername, playerid);
		ABroadCast(COLOR_PANICRED,string,1);
        SendCommandLogMessage(string);
		printf(string);
	}
	return 1;
}

CMD:cc(playerid)
{

	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1)
	{
		return cmd_cca(playerid);
	}
	return 1;
}
CMD:hpall(playerid)
{
	new string[64];
	new sendername[MAX_PLAYER_NAME];

    GetPlayerName(playerid, sendername, sizeof(sendername));

    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pAdmin] >= 2000)
        {
        	format(string, sizeof(string), "Administrator %s uleczyl wszystkich.", sendername);
    		SendClientMessageToAll(COLOR_LIGHTGREEN, string);
            foreach(Player, i)
			{
			    if(IsPlayerConnected(i))
			    {
				    SetPlayerHealth(i, 100);
				}
			}
		}
		else
		{
		    noAccessMessage(playerid);
		}
	}
	return 1;
}

CMD:killall(playerid)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    GetPlayerName(playerid, sendername, sizeof(sendername));

    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pAdmin] >= 2000)
        {
            format(string, 128, "Administrator %s [ID: %d] zabi³ wszystkich graczy.", sendername, playerid);
            foreach(Player, i)
			{
			    if(IsPlayerConnected(i))
			    {
				    SetPlayerHealth(i, 0);
                    _MruAdmin(i, string);
				}
			}
		}
		else
		{
		    noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:podglad(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1;
		if( sscanf(params, "k<fix>", para1))
		{
			sendTipMessage(playerid, "U¿yj /podglad [playerid/CzêœæNicku]");
			return 1;
		}


		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
		    if(IsPlayerConnected(para1))
		    {
		        if(para1 != INVALID_PLAYER_ID)
		        {
		            GetPlayerName(para1, giveplayer, sizeof(giveplayer));
		            if(PlayerInfo[para1][pPodPW] == 0)
					{
                        SendCommandLogMessage(sprintf("Admin %s [%d] w³¹czy³ podgl¹d dla %s [%d]", GetNick(playerid), playerid, GetNick(para1), para1));

						PlayerInfo[para1][pPodPW] = 1;

                        format(string, sizeof(string), "AdmCmd: %s wlaczyl podglad PW %s",GetNick(playerid) ,giveplayer);
                        CMDLog(string);
					}
					else
					{
                        SendCommandLogMessage(sprintf("Admin %s [%d] wy³¹czy³ podgl¹d dla %s [%d]", GetNick(playerid), playerid, GetNick(para1), para1));
						PlayerInfo[para1][pPodPW] = 0;
					}
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:antybh(playerid, params[])
{
	new string[64];

    if(IsPlayerConnected(playerid))
    {
		new bh;
		if( sscanf(params, "d", bh))
		{
			sendTipMessage(playerid, "U¿yj /antybh [0-off, 1-on]");
			return 1;
		}


		if (IsAHeadAdmin(playerid) || IsAScripter(playerid))
		{
	 		if(bh == 0 || bh == 1)
 			{
 			    if(bh != AntyBH)
 			    {
		            AntyBH = bh;
		            format(string, sizeof(string), "Anty BH = %d", bh);
    				SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
				}
				else
				{
					new txtbh[20];
				    if(AntyBH == 0)
				    {
						txtbh = "wy³¹czony";
				    }
				    else if(AntyBH == 1)
				    {
				        txtbh = "w³¹czony";
				    }
				    format(string, sizeof(string), "Anty BH ju¿ jest %s!", txtbh);
    				SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
    			}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:prisonoff(playerid, params[]) return cmd_undemorgan(playerid, params);
CMD:unprison(playerid, params[]) return cmd_undemorgan(playerid, params);
CMD:undemorgan(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pAdmin] >= 35 || IsAScripter(playerid))
        {
            
        
			new giveplayerid;
			if( sscanf(params, "k<fix>", giveplayerid))
			{
				sendTipMessage(playerid, "U¿yj /prisonoff [id/nick]");
				return 1;
			}

			if(IsPlayerConnected(giveplayerid))
			{
				if(giveplayerid != INVALID_PLAYER_ID)
				{
					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "* Uwolni³eœ %s z Fortu DeMorgan.", giveplayer);
					SendClientMessage(playerid, COLOR_LIGHTRED, string);
					format(string, sizeof(string), "* Zosta³eœ uwolniony z DeMorgan przez admina %s.", sendername);
					SendClientMessage(giveplayerid, COLOR_LIGHTRED, string);
					format(string, sizeof(string), "* %s zosta³ uwolniony z DeMorgan przez admina %s.",giveplayer, sendername);
					SendPunishMessage(string, giveplayerid);
					UnJailDeMorgan(giveplayerid);
					poscig[giveplayerid] = 0;
				}
			}
			else
			{
				sendErrorMessage(playerid, "Ten gracz jest offline!");
				return 1;
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
    }
    return 1;
}
CMD:kill(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];
	

    if(IsPlayerConnected(playerid))
    {
		new playa;
		if( sscanf(params, "k<fix>", playa))
		{
			sendTipMessage(playerid, "U¿yj /kill [ID/Imie_Nazwisko]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {
					GetPVarString(playerid, "pAdminDutyNickOn", AdminName, sizeof(AdminName)); 
		
					if(GetPlayerAdminDutyStatus(playerid) == 0)
					{
						GetPlayerName(playa, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						SetPlayerHealth(playa, 0);
						format(string, sizeof(string), "AdmCmd: %s Zabi³ adminem %s",sendername,  giveplayer);
						printf("%s",string);

						_MruAdmin(playerid, sprintf("Zabi³eœ gracza %s [%d] za pomoc¹ komendy", GetNick(playa, true), playa));
						if(playerid != playa) _MruAdmin(playa, sprintf("Zosta³eœ zabity przez admina %s [%d]", GetNick(playerid, true), playerid));

						SendCommandLogMessage(sprintf("Admin %s [%d] da³ /kill graczowi %s [%d]", GetNick(playerid, true), playerid, GetNick(playa, true), playa));
					}
					else
					{
						GetPlayerName(playa, giveplayer, sizeof(giveplayer));
						SetPlayerHealth(playa, 0);
						format(string, sizeof(string), "AdmCmd: %s Zabi³ adminem %s",AdminName,  giveplayer);
						printf("%s",string);

						_MruAdmin(playerid, sprintf("Zabi³eœ gracza %s [%d] za pomoc¹ komendy", GetNick(playa, true), playa));
						if(playerid != playa) _MruAdmin(playa, sprintf("Zosta³eœ zabity przez admina %s [%d]", AdminName, playerid));

						SendCommandLogMessage(sprintf("Admin %s [%d] da³ /kill graczowi %s [%d]", AdminName, playerid, GetNick(playa, true), playa));
					
					}
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:setstd(playerid, params[]) return cmd_choroba(playerid, params);
CMD:zaraz(playerid, params[]) return cmd_choroba(playerid, params);
CMD:choroba(playerid, params[])
{
	new string[64];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1, level;
		if( sscanf(params, "k<fix>d", para1, level))
		{
			sendTipMessage(playerid, "U¿yj /setstd [playerid/CzêœæNicku] [id choroby] (4 - grypa, 5 - sepsa)");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 100)
		{
		    if(IsPlayerConnected(para1))
		    {
		    	if(para1 != INVALID_PLAYER_ID)
	        	{
					GetPlayerName(para1, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					STDPlayer[para1] = level;
					printf("AdmCmd: %s zmieni³ chorobê %s na %d.", sendername, giveplayer, level);
					format(string, sizeof(string), "   Zarazi³eœ siê chorob¹");
					SendClientMessage(para1, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "   Zmieni³eœ chorobê graczowi %s na pracê %d.", giveplayer,level);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:setwiek(playerid, params[]) return cmd_zmienwiek(playerid, params);
CMD:setage(playerid, params[]) return cmd_zmienwiek(playerid, params);
CMD:zmienwiek(playerid, params[])
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1, level;
		if( sscanf(params, "k<fix>d", para1, level))
		{
			sendTipMessage(playerid, "U¿yj /setwiek [playerid/CzêœæNicku] [wiek]");
			return 1;
		}


		if (PlayerInfo[playerid][pAdmin] >= 5000 || IsAScripter(playerid))
		{
		    if(IsPlayerConnected(para1))
		    {
		    	if(para1 != INVALID_PLAYER_ID)
	        	{
					GetPlayerName(para1, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					PlayerInfo[para1][pAge] = level;
					printf("AdmCmd: %s zmieni³ wiek %s na %d.", sendername, giveplayer, level);
					format(string, sizeof(string), "   Twój wiek zosta³ zmieniony na %d lat przez %s", level, sendername);
					SendClientMessage(para1, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "   Zmieni³eœ wiek graczowi %s na %d lat.", giveplayer,level);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:setjob(playerid, params[]) return cmd_zmienprace(playerid, params);
CMD:zmienjob(playerid, params[]) return cmd_zmienprace(playerid, params);
CMD:zmienprace(playerid, params[])
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1, level;
		if( sscanf(params, "k<fix>d", para1, level))
		{
			sendTipMessage(playerid, "U¿yj /setjob [playerid/CzêœæNicku] [id pracy]");
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] >= 5000 || IsAScripter(playerid))
		{
		    if(IsPlayerConnected(para1))
		    {
		    	if(para1 != INVALID_PLAYER_ID)
	        	{
                    if(!(0 <= level <= 17)) return 1;
					GetPlayerName(para1, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					PlayerInfo[para1][pJob] = level;
					printf("AdmCmd: %s zmieni³ pracê %s na %d.", sendername, giveplayer, level);
					format(string, sizeof(string), "   Twoja praca zosta³a zmieniona na %d przez %s", level, sendername);
					SendClientMessage(para1, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "   Zmieni³eœ pracê graczowi %s na pracê %d.", giveplayer,level);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:setslot(playerid, params[])
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1, level;
		if( sscanf(params, "k<fix>d", para1, level))
		{
			sendTipMessage(playerid, "U¿yj /setslot [playerid/CzêœæNicku] [liczba slotów]");
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] >= 5000 || IsAScripter(playerid))
		{
		    if(IsPlayerConnected(para1))
		    {
		    	if(para1 != INVALID_PLAYER_ID)
	        	{
                    if(!(0 <= level <= 12)) return 1;
					GetPlayerName(para1, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					PlayerInfo[para1][pCarSlots] = level;
					printf("AdmCmd: %s sloty %s na %d.", sendername, giveplayer, level);
					format(string, sizeof(string), "   Liczba slotow zostala zmieniona %d przez %s", level, sendername);
					SendClientMessage(para1, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "   Zmieni³eœ sloty graczowi %s na %d.", giveplayer,level);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:pojazdygracza(playerid, params[])
{
	new string[256];
    if(IsPlayerConnected(playerid))
    {
		new para1;
		if( sscanf(params, "k<fix>", para1))
		{
			sendTipMessage(playerid, "U¿yj /pojazdygracza [playerid/CzêœæNicku]");
			return 1;
		}


		if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || Uprawnienia(playerid, ACCESS_PANEL))
		{
            format(string, sizeof(string), "|---------- Auta %s ----------|",GetNick(para1, true));
    		SendClientMessage(playerid, COLOR_GREEN, string);
            new lUID, lPID = PlayerInfo[para1][pUID];
            for(new i=0;i<MAX_CAR_SLOT;i++)
            {
                if((lUID = PlayerInfo[para1][pCars][i]) != 0)
                {
                    if(CarData[lUID][c_Owner] == lPID)
                    {
                        if(CarData[lUID][c_ID] == 0) format(string, sizeof(string), "Auto %d: Marka %s, UID %d (unspawnowane)", i+1, VehicleNames[CarData[lUID][c_Model]-400], CarData[lUID][c_UID]);
                        else format(string, sizeof(string), "Auto %d: Marka %s, UID %d (SA-MP ID %d)", i+1, VehicleNames[CarData[lUID][c_Model]-400], CarData[lUID][c_UID], CarData[lUID][c_ID]);
    				    SendClientMessage(playerid, COLOR_YELLOW, string);
                    }
                }
            }
            new day, month, year, hour, minuite, second;
            getdate(year, month, day);
            gettime(hour, minuite, second);
            format(string, sizeof(string), "%d/%d/%d %d:%d:%d", day, month, year, hour, minuite, second);
    		SendClientMessage(playerid, COLOR_GREY, string);
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}

CMD:checkcar(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || Uprawnienia(playerid, ACCESS_PANEL)  || PlayerInfo[playerid][pAdmin] == 7 || IsAKO(playerid))
	{
        new vehid;
		if( sscanf(params, "d", vehid))
		{
			sendTipMessage(playerid, "U¿yj /checkcar [Vehicle ID]");
			return 1;
		}
        if(vehid < 1 || vehid >= MAX_VEHICLES)
            return sendErrorMessage(playerid, "Niepoprawne ID pojazdu.");
        if(GetVehicleModel(vehid) == 0)
            return sendErrorMessage(playerid, "Taki pojazd nie istnieje.");
        new uid = VehicleUID[vehid][vUID];
        if(uid == 0)
            return sendErrorMessage(playerid, "Pojazd nie nale¿y do systemu.");
        new str[128];
        format(str, 128, "System: Pojazd nale¿y do %s - %s (UID: %d)", CarOwnerNames[CarData[uid][c_OwnerType]], Car_PrintOwner(uid), CarData[uid][c_UID]);
        SendClientMessage(playerid, COLOR_GREEN, str);
	}
	else
	{
		noAccessMessage(playerid);
	}
	return 1;
}
CMD:checkcars(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
		new para1;
		if( sscanf(params, "k<fix>", para1))
		{
			SendClientMessage(playerid, COLOR_GRAD2, "U¿yj /checkcars [playerid/CzêœæNicku]");
			return 1;
		}


		if (PlayerInfo[playerid][pAdmin] >= 1000)
		{
            ShowCarsForPlayer(para1, playerid);
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:setauto(playerid, params[]) return cmd_setveh(playerid, params);
CMD:zmienauto(playerid, params[]) return cmd_setveh(playerid, params);
CMD:setcar(playerid, params[]) return cmd_setveh(playerid, params);
CMD:setveh(playerid, params[])
{
	new string[256];

    if(IsPlayerConnected(playerid))
    {
		new para1, nrcar, level;
		if( sscanf(params, "k<fix>dd", para1, nrcar, level))
		{
			sendTipMessage(playerid, "U¿yj /zmienauto [playerid/CzêœæNicku] [Nr. z listy (nie UID!)] [UID pojazdu]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 2000)
		{
		    if(IsPlayerConnected(para1))
		    {
		        if(para1 != INVALID_PLAYER_ID)
		        {
		            if(nrcar >= 1 && nrcar <= MAX_CAR_SLOT)
					{
                        new lID = -1;
                        if(level != 0)
                        {
                            lID = Car_GetIDXFromUID(level);
                            if(lID == -1)
                            {
                                sendTipMessage(playerid, "Pojazd nie by³ wczytany do systemu, inicjalizacja ...", COLOR_GRAD2);
                                lID = Car_LoadEx(level);
                                if(lID == -1) return SendClientMessage(playerid, COLOR_GRAD2, "... brak pojazdu w bazie.");
                            }
                        }
                        if(PlayerInfo[para1][pCars][nrcar-1] != 0)
                        {
                            format(string, 256, "Gracz posiada³ auto (UID: %d) na slocie %d. Pojazd zostaje bez w³asciciela.", CarData[PlayerInfo[para1][pCars][nrcar-1]][c_UID], nrcar);
                            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                            format(string, 256, "Admin %s zmieni³ Ci auto (UID: %d) na slocie %d. Pojazd zostaje bez w³asciciela.", GetNick(playerid), CarData[PlayerInfo[para1][pCars][nrcar-1]][c_UID], nrcar);
                            SendClientMessage(para1, COLOR_LIGHTBLUE, string);

                            CarData[PlayerInfo[para1][pCars][nrcar-1]][c_OwnerType] = INVALID_CAR_OWNER;
                            Car_Save(PlayerInfo[para1][pCars][nrcar-1], CAR_SAVE_OWNER);
                        }

                        if(PlayerInfo[para1][pCars][nrcar-1] != 0)
                        {
                            format(string, 256, "Gracz posiada³ auto (UID: %d) na slocie %d. Pojazd zostaje bez w³asciciela.", CarData[PlayerInfo[para1][pCars][nrcar-1]][c_UID], nrcar);
                            StatsLog(string);
                        }

                        if(level != 0)
                        {
    						format(string, sizeof(string), " Ustawiono pojazd %s (%d) graczowi %s.", VehicleNames[CarData[lID][c_Model]-400],level,GetNick(para1));
    						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
    						format(string, sizeof(string), "%s dal %s auto %s UID %d na slot %d /setcar", GetNick(playerid), GetNick(para1), VehicleNames[CarData[lID][c_Model]-400], level, nrcar);
    						StatsLog(string);

                            PlayerInfo[para1][pCars][nrcar-1] = lID;

                            //Car_SortPlayerCars(para1);

                            CarData[lID][c_OwnerType] = CAR_OWNER_PLAYER;
                            CarData[lID][c_Owner] = PlayerInfo[para1][pUID];
                            Car_Save(lID, CAR_SAVE_OWNER);
                        }
                        else
                        {
                            format(string, sizeof(string), " Usuniêto pojazd ze slotu %d graczowi %s.", nrcar, GetNick(para1));
    						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
    						format(string, sizeof(string), "%s usun¹³ pojazd %s ze slotu %d /setcar", GetNick(playerid), GetNick(para1), nrcar);
    						StatsLog(string);

                            PlayerInfo[para1][pCars][nrcar-1] = 0;

                            //Car_SortPlayerCars(para1);
                        }
					}
					else
					{
					    sendTipMessage(playerid, "Numer pojazdu od 1!");
					}
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:setwl(playerid, params[]) return cmd_zmienwl(playerid, params);
CMD:zmienwl(playerid, params[])
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1, level;
		if( sscanf(params, "k<fix>d", para1, level))
		{
			sendTipMessage(playerid, "U¿yj /setwl [playerid/CzêœæNicku] [iloœæ wl]");
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] >= 100)
		{
		    if(IsPlayerConnected(para1))
		    {
		        if(level > 10 || level < 0)
				{
					sendTipMessage(playerid, "Numer WL od 0 do 10!"); return 1;
				}
		        if(para1 != INVALID_PLAYER_ID)
		        {
					GetPlayerName(para1, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					PoziomPoszukiwania[para1] = level;
					printf("AdmCmd: %s zmieni³ wanted level gracza %s na wartoœæ %d.", sendername, giveplayer, level);
					format(string, sizeof(string), "   Twój Poziom Poszukiwania zosta³ zmieniony na %d przez admina %s", level, sendername);
					SendClientMessage(para1, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "   Zmieni³eœ poziom poszukiwania %s na %d.", giveplayer,level);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:rozwiedz(playerid, params[])
{
	new string[64];

    if(IsPlayerConnected(playerid))
    {
		new para1;
		if( sscanf(params, "k<fix>", para1))
		{
			sendTipMessage(playerid, "U¿yj /rozwiedz [playerid/CzêœæNicku]");
			return 1;
		}


		if (PlayerInfo[playerid][pAdmin] >= 10 || IsAScripter(playerid))
		{
		    if(IsPlayerConnected(para1))
		    {
		        if(para1 != INVALID_PLAYER_ID)
		        {
					ClearMarriage(para1);
					format(string, sizeof(string), "Gracz o ID: [%d] nie ma teraz œlubu", para1);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:setskin(playerid, params[])
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1, level;
		if( sscanf(params, "k<fix>d", para1, level))
		{
			sendTipMessage(playerid, "U¿yj /setskin [playerid/CzêœæNicku] [id skinu]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 5000)
		{
		    if(IsPlayerConnected(para1))
		    {
		        if(level > 311)
				{
					sendTipMessage(playerid, "Numer skinu od 0 do 311!");
					if(PlayerInfo[playerid][pAdmin] != 12345)
					{
						return 1;
					}
				}
		        if(para1 != INVALID_PLAYER_ID)
		        {
                    if(GetPlayerState(para1) != PLAYER_STATE_ONFOOT) return sendTipMessage(playerid, "Aby nadaæ skina gracz musi byæ pieszo!");
					GetPlayerName(para1, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					SetPlayerSkin(para1, level);
					PlayerInfo[para1][pModel] = level;
					PlayerInfo[para1][pSkin] = level;
					printf("AdmCmd: %s zmieni³ skin gracza %s na %d.", sendername, giveplayer, level);
					format(string, sizeof(string), "   Twój skin zosta³ zmieniony na %d przez %s", level, sendername);
					SendClientMessage(para1, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "   Zmieni³eœ skin graczowi %s na %d.", giveplayer,level);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				}
			}
		}
		else if (PlayerInfo[playerid][pAdmin] >= 3 && para1 == playerid)
		{
		    if(IsPlayerConnected(para1))
		    {
		        if(level > 311)
				{
					sendTipMessage(playerid, "Numer skinu od 0 do 311!");
					if(PlayerInfo[playerid][pAdmin] != 12345)
					{
						return 1;
					}
				}
		        if(para1 != INVALID_PLAYER_ID)
		        {
                    if(GetPlayerState(para1) != PLAYER_STATE_ONFOOT) return sendTipMessage(playerid, "Aby nadaæ skina gracz musi byæ pieszo!");
					GetPlayerName(para1, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					SetPlayerSkin(para1, level);
					PlayerInfo[para1][pModel] = level;
					printf("AdmCmd: %s zmieni³ skin gracza %s na %d.", sendername, giveplayer, level);
					format(string, sizeof(string), "   Twój skin zosta³ zmieniony na %d przez %s", level, sendername);
					SendClientMessage(para1, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "   Zmieni³eœ skin graczowi %s na %d.", giveplayer,level);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:naprawskin(playerid, params[])
{
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1;
		if( sscanf(params, "k<fix>", para1))
		{
			sendTipMessage(playerid, "U¿yj /naprawskin [playerid/CzêœæNicku]");
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] >= 10)
		{
		    if(IsPlayerConnected(para1))
		    {
		        if(para1 != INVALID_PLAYER_ID)
		        {
					if(GetPlayerState(para1) != PLAYER_STATE_ONFOOT) return sendTipMessage(playerid, "Aby naprawiæ skin gracz musi byæ pieszo!");
					GetPlayerName(para1, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					printf("AdmCmd: %s naprawi³ skin gracza %s.", sendername, giveplayer);
					
					new level = PlayerInfo[para1][pModel];
					SetPlayerSkin(para1, level);
					PlayerInfo[para1][pSkin] = level;

					_MruAdmin(playerid, sprintf("Naprawi³eœ skin graczowi %s [%d] za pomoc¹ komendy.", GetNick(para1), para1));
                    _MruAdmin(para1, sprintf("Twój skin zosta³ naprawiony przez %s [%d].", GetNick(playerid), playerid));
					SendCommandLogMessage(sprintf("Admin %s [%d] naprawi³ skin graczowi %s [%d].", GetNick(playerid), playerid, GetNick(para1), para1));
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:dnobiekt(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 5000 || IsAScripter(playerid))
	{
	    new Float:oX;
	    new Float:oY;
	    new Float:oZ;
	    new Float:roX;
	    new Float:roY;
	    new Float:roZ;
	    new Float:soX;
	    new Float:soY;
	    new Float:soZ;
        new giveplayerid, index, obikt, kosc;
		if(sscanf(params, "k<fix>dddfffffffff", giveplayerid, index, obikt, kosc, oX, oY, oZ, roX, roY, roZ, soX, soY, soZ)) return 1;
		SetPlayerAttachedObject(giveplayerid,index,obikt, kosc, oX, oY, oZ, roX, roY, roZ, soX, soY, soZ); //kox
	}
	return 1;
}

CMD:dsus(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >=100)
	{
	    new giveplayerid, przestepca;
		if( sscanf(params, "k<fix>d", giveplayerid, przestepca))
		{
			sendTipMessage(playerid, "U¿yj /dsus [id gracza] [id wl]");
			return 1;
		}
		if(przestepca >= 3 && przestepca <= 22)
		{
		    PlayCrimeReportForPlayer(playerid,giveplayerid,przestepca);
        }
    }
	return 1;
}

CMD:jump(playerid)
{
    if(PlayerInfo[playerid][pAdmin] >= 15)
    {
		OddajZycie(playerid, 3, "Oddano Ci ¿ycie", true);
	    new Float:x,Float:y,Float:z;
	    GetPlayerVelocity(playerid,x,y,z);
		SetPlayerVelocity(playerid,1.2,1.2,10.9); //Forces the player to jump
		return 1;
	}
	return 1;
}

CMD:sh(playerid)
{
    if(PlayerInfo[playerid][pAdmin] >= 15)
    {
		OddajZycie(playerid, 3, "Zresetowano HP", true);
	    new Float:x,Float:y,Float:z;
	    GetPlayerVelocity(playerid,x,y,z);
		SetPlayerVelocity(playerid,1.2,1.2,-0.5); //Forces the player to sink
		return 1;
	}
	return 1;
}
CMD:carjump(playerid)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
	    if(PlayerInfo[playerid][pAdmin] >= 1)
    	{
	        SetVehicleVelocity(GetPlayerVehicleID(playerid), 0.0, 0.0, 0.2);
			return 1;
		}
	}
	return 1;
}
CMD:dskill(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >=100)
	{
	    new giveplayerid, idskill, level;
		if( sscanf(params, "k<fix>dd", giveplayerid, idskill, level))
		{
			sendTipMessage(playerid, "/dskill [id gracza] [id skilla] [level]");
			return 1;
		}

		if(PlayerInfo[playerid][pLevel] >= 1)
		{
		    if(idskill < 11 && idskill >= 0)
			{
			    SetPlayerSkillLevel(giveplayerid, idskill, level);
			    if(idskill == 0)
			    {
			        SendClientMessage(playerid, COLOR_RED, "WEAPONSKILL_PISTOL");
			    }
			    else if(idskill == 1)
			    {
			        SendClientMessage(playerid, COLOR_RED, "WEAPONSKILL_PISTOL_SILENCED");
			    }
			    else if(idskill == 2)
			    {
			        SendClientMessage(playerid, COLOR_RED, "WEAPONSKILL_DESERT_EAGLE");
			    }
			    else if(idskill == 3)
			    {
			        SendClientMessage(playerid, COLOR_RED, "WEAPONSKILL_SHOTGUN");
			    }
			    else if(idskill == 4)
			    {
			        SendClientMessage(playerid, COLOR_RED, "WEAPONSKILL_SAWNOFF_SHOTGUN");
			    }
			    else if(idskill == 5)
			    {
			        SendClientMessage(playerid, COLOR_RED, "WEAPONSKILL_SPAS12_SHOTGUN");
			    }
			    else if(idskill == 6)
			    {
			        SendClientMessage(playerid, COLOR_RED, "WEAPONSKILL_MICRO_UZI");
			    }
			    else if(idskill == 7)
			    {
			        SendClientMessage(playerid, COLOR_RED, "WEAPONSKILL_MP5");
			    }
			    else if(idskill == 8)
			    {
			        SendClientMessage(playerid, COLOR_RED, "WEAPONSKILL_AK47");
			    }
			    else if(idskill == 9)
			    {
			        SendClientMessage(playerid, COLOR_RED, "WEAPONSKILL_M4");
			    }
			    else if(idskill == 10)
			    {
			        SendClientMessage(playerid, COLOR_RED, "WEAPONSKILL_SNIPERRIFLE");
			    }
			}
		}
	}
	return 1;
}
CMD:ksam(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >=10)
	{
	    new level;
		if( sscanf(params, "d", level))
		{
			sendTipMessage(playerid, "U¿yj /ksam [kamera]");
			return 1;
		}


		TogglePlayerControllable(playerid, 0);
		if(level == 1)//dmv dó³
		{
		    SetPlayerPosEx(playerid, 1475.013671875, -1745.9069824219, -5.0);
		    SetPlayerCameraPos(playerid, 1533.6928710938, -1709.9449462891, 31.546875);//kamera
			SetPlayerCameraLookAt(playerid, 1475.013671875, -1745.9069824219, 13.930854797363);//patrz
		}
		else if(level == 2)//komisariat
		{
		    SetPlayerPosEx(playerid, 1542.4140625, -1675.5947265625, -5.0);
		    SetPlayerCameraPos(playerid, 1503.0399169922, -1689.4235839844, 42.296875);//kamera
			SetPlayerCameraLookAt(playerid, 1542.4140625, -1675.5947265625, 13.554452896118);//patrz
		}
		else if(level == 3)//24/7
		{
		    SetPlayerPosEx(playerid, 1352.2797851563, -1757.189453125, -5.0);
		    SetPlayerCameraPos(playerid, 1352.4576416016, -1725.1925048828, 23.291763305664);// kamera
			SetPlayerCameraLookAt(playerid, 1352.2797851563, -1757.189453125, 13.5078125);// patrz
		}
		else if(level == 4)//palmy
		{
		    SetPlayerPosEx(playerid, 1275.0283203125, -1337.3585205078, -5.0);
		    SetPlayerCameraPos(playerid, 1275.0283203125, -1337.3585205078, 10.852507591248);// kamera
			SetPlayerCameraLookAt(playerid, 1235.1977539063, -1341.1885986328, 54.349945068359);// patrz
		}
		else if(level == 5)//szpital
		{
		    SetPlayerPosEx(playerid, 1172.8602294922, -1331.978515625, -5.0);
		    SetPlayerCameraPos(playerid, 1228.7977294922, -1345.1479492188, 21.532119750977);// kamera
			SetPlayerCameraLookAt(playerid, 1172.8602294922, -1331.978515625, 14.317019462585);// patrz
		}
		else if(level == 6)//molo
		{
		    SetPlayerPosEx(playerid, 835.99493408203, -2028.1843261719, -5.0);
		    SetPlayerCameraPos(playerid, 836.81677246094, -2102.888671875, 30.026561737061);// kamera
			SetPlayerCameraLookAt(playerid, 835.99493408203, -2028.1843261719, 13.022017478943);// patrz
		}
		else if(level == 7)//biurowiec
		{
		    SetPlayerPosEx(playerid, 326.09194946289, -1521.3157958984, 20.0);
		    SetPlayerCameraPos(playerid, 398.16021728516, -1511.9237060547, 78.641815185547);// kamera
			SetPlayerCameraLookAt(playerid, 326.09194946289, -1521.3157958984, 42.154850006104);// patrz
		}
		else if(level == 8)//baba
		{
		    SetPlayerPosEx(playerid, 412.80743408203, -1312.4066162109, -5.0);
		    SetPlayerCameraPos(playerid, 402.2776184082, -1351.4703369141, 43.704566955566);// kamera
			SetPlayerCameraLookAt(playerid, 412.80743408203, -1312.4066162109, 39.677307128906);// patrz
		}
		else if(level == 9)//krajobraz
		{
		    SetPlayerPosEx(playerid, 849.62371826172, -989.92199707031, -5.0);
		    SetPlayerCameraPos(playerid, 849.62371826172, -989.92199707031, 53.211112976074);// kamera
			SetPlayerCameraLookAt(playerid, 907.40313720703, -913.14117431641, 77.788856506348);// patrz
		}
		else if(level == 10)//góra dmv
		{
		    SetPlayerPosEx(playerid, 1476.0841064453, -1587.5469970703, -5.0);
		    SetPlayerCameraPos(playerid, 1476.0841064453, -1587.5469970703, 94.578155517578);// kamera
			SetPlayerCameraLookAt(playerid, 1477.9970703125, -1682.9604492188, 120.3067779541);// patrz
		}
		else if(level == 11)//green bar
		{
		    SetPlayerPosEx(playerid, 2321.1193847656, -1644.9545898438, -5.0);
		    SetPlayerCameraPos(playerid, 2306.44921875, -1648.0637207031, 19.648511886597);// kamera
			SetPlayerCameraLookAt(playerid, 2321.1193847656, -1644.9545898438, 20.322546005249);// patrz
		}
		else if(level == 12)//pig pen
		{
		    SetPlayerPosEx(playerid, 2432.427734375, -1219.1400146484, -5.0);
		    SetPlayerCameraPos(playerid, 2412.5122070313, -1270.3096923828, 32.702220916748);// kamera
			SetPlayerCameraLookAt(playerid, 2432.427734375, -1219.1400146484, 27.857213973999);// patrz
		}
		else if(level == 13)//kosciol
		{
		    SetPlayerPosEx(playerid, 2249.8486328125, -1324.0440673828, -5.0);
		    SetPlayerCameraPos(playerid, 2290.0915527344, -1278.4261474609, 51.061328887939);// kamera
			SetPlayerCameraLookAt(playerid, 2249.8486328125, -1324.0440673828, 33.366535186768);// patrz
		}
		else if(level == 14)//salon
		{
		    SetPlayerPosEx(playerid, 2132.021484375, -1151.7044677734, -5.0);
		    SetPlayerCameraPos(playerid, 2135.5944824219, -1097.8615722656, 42.498329162598);// kamera
			SetPlayerCameraLookAt(playerid, 2132.021484375, -1151.7044677734, 28.347097396851);// patrz
		}
		else if(level == 15)//mechanicy
		{
		    SetPlayerPosEx(playerid, 2779.2543945313, -1625.6682128906, -5.0);
		    SetPlayerCameraPos(playerid, 2785.1057128906, -1593.6995849609, 17.093282699585);// kamera
			SetPlayerCameraLookAt(playerid, 2779.2543945313, -1625.6682128906, 10.921875);// patrz
		}
		else if(level == 16)//bukmacher
		{
		    SetPlayerPosEx(playerid, 2799.1599121094, -1087.5931396484, -5.0);
		    SetPlayerCameraPos(playerid, 2896.6389160156, -1088.0809326172, 51.550712585449);// kamera
			SetPlayerCameraLookAt(playerid, 2799.1599121094, -1087.5931396484, 32.892097473145);// patrz
		}
		else if(level == 17)//matsiarnia
		{
		    SetPlayerPosEx(playerid, 594.65191650391, -1244.9367675781, -5.0);
		    SetPlayerCameraPos(playerid, 581.66076660156, -1194.0218505859, 63.454399108887);// kamera
			SetPlayerCameraLookAt(playerid, 594.65191650391, -1244.9367675781, 18.101390838623);// patrz
		}
		else if(level == 18)//studio san
		{
		    SetPlayerPosEx(playerid, 649.64978027344, -1358.2073974609, -5.0);
		    SetPlayerCameraPos(playerid, 604.78979492188, -1357.9267578125, 32.532451629639);// kamera
			SetPlayerCameraLookAt(playerid, 649.64978027344, -1358.2073974609, 14.314910888672);// patrz
		}
		else if(level == 19)//restauracja lcn
		{
		    SetPlayerPosEx(playerid, 722.64001464844, -1440.8016357422, -5.0);
		    SetPlayerCameraPos(playerid, 676.10821533203, -1397.7175292969, 30.902849197388);// kamera
			SetPlayerCameraLookAt(playerid, 722.64001464844, -1440.8016357422, 13.770217895508);// patrz
		}
		else if(level == 20)//p¹czkarnia
		{
		    SetPlayerPosEx(playerid, 1016.9872436523, -1372.0234375, -5.0);
		    SetPlayerCameraPos(playerid, 1053.3154296875, -1326.3295898438, 28.300031661987);// kamera
			SetPlayerCameraLookAt(playerid, 1016.9872436523, -1372.0234375, 15.836219787598);// patrz
		}
		else if(level == 21)//si³ownia
		{
		    SetPlayerPosEx(playerid, 2231.7556152344, -1722.3572998047, -5.0);
		    SetPlayerCameraPos(playerid, 2216.4689941406, -1740.7563476563, 20.06992149353);// kamera
			SetPlayerCameraLookAt(playerid, 2231.7556152344, -1722.3572998047, 18.674905776978);// patrz
		}
		else if(level == 22)//ammu nation
		{
		    SetPlayerPosEx(playerid, 1365.6441650391, -1280.5021972656, -5.0);
		    SetPlayerCameraPos(playerid, 1325.3818359375, -1282.9909667969, 31.582809448242);// kamera
			SetPlayerCameraLookAt(playerid, 1365.6441650391, -1280.5021972656, 21.209575653076);// patrz
		}
		else if(level == 23)//bank
		{
		    SetPlayerPosEx(playerid, 1461.9548339844, -1046.5203857422, -5.0);
		    SetPlayerCameraPos(playerid, 1461.9548339844, -1046.5203857422, 26.403123855591);// kamera
			SetPlayerCameraLookAt(playerid, 1462.3500976563, -1009.8300170898, 29.108682632446);// patrz
		}
		else if(level == 24)//unity station
		{
		    SetPlayerPosEx(playerid, 1788.783203125, -1876.8815917969, -5.0);
		    SetPlayerCameraPos(playerid, 1838.3461914063, -1841.0067138672, 31.29806137085);// kamera
			SetPlayerCameraLookAt(playerid, 1788.783203125, -1876.8815917969, 24.951961517334);// patrz
		}
		else if(level == 25)//granica
		{
		    SetPlayerPosEx(playerid, 55.527679443359, -1531.3371582031, -10.0);
		    SetPlayerCameraPos(playerid, 101.52135467529, -1538.3253173828, 19.186899185181);// kamera
			SetPlayerCameraLookAt(playerid, 55.527679443359, -1531.3371582031, 5.2492713928223);// patrz
		}
		else if(level == 26)//kasyno
		{
		    SetPlayerPosEx(playerid, 1055.5834960938, -1154.1359863281, -5.0);
		    SetPlayerCameraPos(playerid, 1055.5834960938, -1154.1359863281, 29.209383010864);// kamera
			SetPlayerCameraLookAt(playerid, 1000.6205444336, -1121.8303222656, 31.49701499939);// patrz
		}
		else if(level == 27)//molo z ko³em ryby
		{
		    SetPlayerPosEx(playerid, 370.02825927734, -2083.5886230469, -10.0);
		    SetPlayerCameraPos(playerid, 340.61755371094, -2091.701171875, 22.800081253052);// kamera
			SetPlayerCameraLookAt(playerid, 370.02825927734, -2083.5886230469, 8.1386299133301);// patrz
		}
		else if(level == 28)//skok
		{
		    SetPlayerPosEx(playerid, 1963.5544433594, -2134.0036621094, -5.0);
		    SetPlayerCameraPos(playerid, 1962.7001953125, -2222.1535644531, 18.375);// kamera
			SetPlayerCameraLookAt(playerid, 1963.5544433594, -2134.0036621094, 13.3828125);// patrz
		}
		else if(level == 29)//domki
		{
		    SetPlayerPosEx(playerid, 1883.6086425781, -2081.5034179688, -5.0);
		    SetPlayerCameraPos(playerid, 1977.0340576172, -2108.5888671875, 25.407804489136);// kamera
			SetPlayerCameraLookAt(playerid, 1883.6086425781, -2081.5034179688, 17.580423355103);// patrz
		}
		else if(level == 30)
		{
		    TogglePlayerControllable(playerid, 1);
		    SetPlayerPosEx(playerid, 1529.6,-1691.2,13.3);
		    SetCameraBehindPlayer(playerid);
		}
		else
		{
		    TogglePlayerControllable(playerid, 1);
		    SetCameraBehindPlayer(playerid);
		    return 1;
		}
	}
	return 1;
}
CMD:fdaj(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >=10 || IsAScripter(playerid))
	{
	    new giveplayerid, level;
		if( sscanf(params, "k<fix>d", giveplayerid, level))
		{
			sendTipMessage(playerid, "U¿yj /fdaj [id gracza] [id stylu]");
			return 1;
		}

		if(PlayerInfo[playerid][pLevel] >= 1)
		{
		    SetPlayerFightingStyle(playerid, level);
		}
	}
	return 1;
}

CMD:dajdowozu(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >=5 || IsAScripter(playerid))
	{
	    new giveplayerid, level;
		if( sscanf(params, "k<fix>d", giveplayerid, level))
		{
			sendTipMessage(playerid, "U¿yj /dajdowozu [id gracza] [id wozu]");
			return 1;
		}

		if(PlayerInfo[playerid][pLevel] >= 1)
		{
		    PutPlayerInVehicleEx(giveplayerid, level, 0);
			new string[128];
			format(string, 128, "CMD_Info: /dajdowozu u¿yte przez %s na %s", GetNick(playerid), GetNick(giveplayerid));
			CMDLog(string);
		}
	}
	return 1;
}
CMD:sprawdzinv(playerid, params[])
{
	new string[64];

    if(PlayerInfo[playerid][pAdmin] >= 5 || IsAScripter(playerid))
	{
	    new giveplayerid;
		if( sscanf(params, "k<fix>", giveplayerid))
		{
			sendTipMessage(playerid, "U¿yj /sprawdzinv [id gracza]");
			return 1;
		}

		new Float:gx, Float:gy, Float:gz;
		GetPlayerPos(giveplayerid, gx, gy, gz);
		format(string, sizeof(string), "Pozycja: %.2f, %.2f, %.2f", gx, gy, gz);
		SendClientMessage(playerid, COLOR_WHITE, string);
		format(string, sizeof(string), "State %d .",GetPlayerState(giveplayerid));
		SendClientMessage(playerid, COLOR_WHITE, string);
	}
	return 1;
}
CMD:sprawdzin(playerid, params[])
{
	new string[128];
	new giveplayerid;
	if( sscanf(params, "k<fix>", giveplayerid))
	{
		SendClientMessage(playerid, -1, "U¿yj /sprawdzin [playerid/CzêœæNicku]");
		return 1;
	}
	if(GetPlayerState(giveplayerid) == PLAYER_STATE_NONE) // If the killer was in a vehicle
    {
		SendClientMessage(playerid, -1, "Gracz is none.");
    	new Float:gx, Float:gy, Float:gz;
		GetPlayerPos(giveplayerid, gx, gy, gz);
		format(string, sizeof(string), "Pozycja: %.2f, %.2f, %.2f", gx, gy, gz);
		SendClientMessage(playerid, -1, string);
		return 1;
    }
    if(GetPlayerState(giveplayerid) == PLAYER_STATE_ONFOOT) // If the killer was in a vehicle
    {
		SendClientMessage(playerid, -1, "Gracz is foot.");
    	new Float:gx, Float:gy, Float:gz;
		GetPlayerPos(giveplayerid, gx, gy, gz);
		format(string, sizeof(string), "Pozycja: %.2f, %.2f, %.2f", gx, gy, gz);
		SendClientMessage(playerid, -1, string);
		return 1;
    }
    if(GetPlayerState(giveplayerid) == PLAYER_STATE_DRIVER) // If the killer was in a vehicle
    {
		SendClientMessage(playerid, -1, "Gracz is driver.");
    	new Float:gx, Float:gy, Float:gz;
		GetPlayerPos(giveplayerid, gx, gy, gz);
		format(string, sizeof(string), "Pozycja: %.2f, %.2f, %.2f", gx, gy, gz);
		SendClientMessage(playerid, -1, string);
		return 1;
    }
    if(GetPlayerState(giveplayerid) == PLAYER_STATE_SPAWNED) // If the killer was in a vehicle
    {
		SendClientMessage(playerid, -1, "Gracz is spawn.");
    	new Float:gx, Float:gy, Float:gz;
		GetPlayerPos(giveplayerid, gx, gy, gz);
		format(string, sizeof(string), "Pozycja: %.2f, %.2f, %.2f", gx, gy, gz);
		SendClientMessage(playerid, -1, string);
		return 1;
    }
    if(GetPlayerState(giveplayerid) == PLAYER_STATE_SPECTATING) // If the killer was in a vehicle
    {
		SendClientMessage(playerid, -1, "Gracz is spec.");
    	new Float:gx, Float:gy, Float:gz;
		GetPlayerPos(giveplayerid, gx, gy, gz);
		format(string, sizeof(string), "Pozycja: %.2f, %.2f, %.2f", gx, gy, gz);
		SendClientMessage(playerid, -1, string);
		return 1;
    }
    if(GetPlayerState(giveplayerid) == PLAYER_STATE_PASSENGER) // If the killer was in a vehicle
    {
		SendClientMessage(playerid, -1, "Gracz is passenger.");
    	new Float:gx, Float:gy, Float:gz;
		GetPlayerPos(giveplayerid, gx, gy, gz);
		format(string, sizeof(string), "Pozycja: %.2f, %.2f, %.2f", gx, gy, gz);
		SendClientMessage(playerid, -1, string);
		return 1;
    }
	return 1;
}
CMD:getposp(playerid, params[])
{
	new string[64];

    if(PlayerInfo[playerid][pAdmin] >= 5 || IsAScripter(playerid))
	{
	    new giveplayerid;
		if( sscanf(params, "k<fix>", giveplayerid))
		{
			sendTipMessage(playerid, "U¿yj /getposp [id gracza]");
			return 1;
		}

		new Float:gx, Float:gy, Float:gz;
		GetPlayerPos(giveplayerid, gx, gy, gz);
		format(string, sizeof(string), "Pozycja: %.2f, %.2f, %.2f", gx, gy, gz);
		SendClientMessage(playerid, COLOR_WHITE, string);
	}
	return 1;
}
CMD:zniszczobiekty(playerid)
{
    if(IsAHeadAdmin(playerid) || IsAScripter(playerid))
    {
        DestroyAllDynamicObjects();
	    SendClientMessage(playerid, COLOR_PANICRED, "Wszystkie obiekty zniszczone!");
        new string[128];
        format(string, 128, "CMD_Info: /zniszczobiekty u¿yte przez %s [%d]", GetNick(playerid), playerid);
        SendCommandLogMessage(string);
        CMDLog(string);
    }
	return 1;
}

CMD:stworzobiekty(playerid)
{
    if(IsAHeadAdmin(playerid) || IsAScripter(playerid))
    {
        Stworz_Obiekty();
	    SendClientMessage(playerid, COLOR_PANICRED, "Wszystkie obiekty stworzone!");
        new string[128];
        format(string, 128, "CMD_Info: /stworzobiekty u¿yte przez %s [%d]", GetNick(playerid), playerid);
        SendCommandLogMessage(string);
        CMDLog(string);
    }
	return 1;
}
CMD:dajdzwiek(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
		if(PlayerInfo[playerid][pAdmin] >= 100)
		{
            new giveplayerid, level;
			if( sscanf(params, "k<fix>d", giveplayerid, level))
			{
				sendTipMessage(playerid, "U¿yj /dajdzwiek [id gracza] [id dzwieku]");
				return 1;
			}
			PlayerPlaySound(giveplayerid, level, 0.0, 0.0, 0.0);
		}
    }
	return 1;
}

CMD:crimereport(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
		if(PlayerInfo[playerid][pAdmin] >= 1000)
		{
            new giveplayerid, level;
			if( sscanf(params, "k<fix>d", giveplayerid, level))
			{
				sendTipMessage(playerid, "U¿yj /crimereport [id gracza] [id przestepstwa]");
				return 1;
			}
			PlayCrimeReportForPlayer(playerid, giveplayerid, level);
		}
    }
	return 1;
}
CMD:respawn(playerid)
{
	new string[128];
	
	
	if(Count >= 20)
	{
		if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 && PlayerInfo[playerid][pNewAP] <= 3 || IsAScripter(playerid))
		{
			GetPVarString(playerid, "pAdminDutyNickOn", AdminName, sizeof(AdminName)); 
		
			if(GetPlayerAdminDutyStatus(playerid) == 0)
			{
				SendClientMessage(playerid,COLOR_YELLOW, "Odliczanie rozpoczête");
				BroadCast(COLOR_PANICRED, "Uwaga! Za 20 sekund nast¹pi respawn nieu¿ywanych pojazdów !");
				format(string, sizeof(string), "AdmCmd: %s [ID: %d] rozpocz¹³ odliczanie do Respawnu Aut !", GetNick(playerid, true), playerid);
				ABroadCast(COLOR_PANICRED,string,1);
				CountDown();
			}
			else
			{
				SendClientMessage(playerid,COLOR_YELLOW, "Odliczanie rozpoczête");
				BroadCast(COLOR_PANICRED, "Uwaga! Za 20 sekund nast¹pi respawn nieu¿ywanych pojazdów !");
				format(string, sizeof(string), "AdmCmd: %s [ID: %d] rozpocz¹³ odliczanie do Respawnu Aut !", AdminName, playerid);
				ABroadCast(COLOR_PANICRED,string,1);
				CountDown();
			
			}
		}
		else
		{
			sendErrorMessage(playerid, "Poczekaj a¿ skoñczy siê to odliczanie!!!");
		}
	}
	return 1;
}

CMD:respp(playerid, params[]) return cmd_respawnplayer(playerid, params);
CMD:respawnplayer(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pNewAP] < 1) return 1;
    new v;
    if(sscanf(params, "k<fix>", v)) return sendTipMessage(playerid, "U¿yj /respawnplayer [ID/Nick]");
    if(!IsPlayerConnected(v)) return sendErrorMessage(playerid, "Niepoprawne ID gracza.");
    new pstate = GetPlayerState(v);
    if((pstate == 0 || pstate == 7 || pstate == 9) && PlayerInfo[playerid][pAdmin] < 5000) return sendErrorMessage(playerid, "Nie mo¿esz go teraz zrespawnowaæ!");
    new str[128];
    format(str, 128, "$System$ » Zosta³eœ zrespawnowany przez admina %s", GetNick(playerid));
    SendClientMessage(v, COLOR_LIGHTGREEN, str);
    format(str, 128, "$System$ » Zrespawnowa³eœ gracza o nicku %s", GetNick(v));
    SendClientMessage(playerid, COLOR_LIGHTGREEN, str);

    SpawnPlayer(v);
    return 1;
}

CMD:respcar(playerid, params[]) return cmd_respawncar(playerid, params);
CMD:respawncar(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pNewAP] < 1) return 1;
    new v;
    if(sscanf(params, "d", v)) return sendTipMessage(playerid, "U¿yj /respawncar [ID pojazdu]");
    if(!(0 < v < MAX_VEHICLES)) return 1;
    if(GetVehicleModel(v) == 0) return sendErrorMessage(playerid, "Niepoprawne ID pojazdu.");
    new bool:used=false;
    foreach(Player, p)
	{
		if(GetPlayerVehicleID(p) == v)
		{
            used=true;
            break;
		}
	}
    if(used) return sendErrorMessage(playerid, "Pojazd nie jest pusty");
    else
    {
        SetVehicleToRespawn(v);
	    if(Car_GetOwnerType(v) == CAR_OWNER_PLAYER)
	    {
            Car_Unspawn(v);
        }
    }
    printf("[RESPAWN] Pojazd %d unspawnowany przez %s", v, GetNick(playerid));
    return 1;
}
CMD:zdejmijbpk(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1)
	{
		new giveplayerid; 
		if(sscanf(params, "k<fix>", giveplayerid))
		{
			sendTipMessage(playerid, "U¿yj /zdejmijbpk [ID GRACZA]"); 
			return 1;
		}
		if(!IsPlayerConnected(giveplayerid))
		{
			sendErrorMessage(playerid, "Nie ma takiego gracza"); 
			return 1;
		}
		new string[128];
		format(string, sizeof(string), "null");
		SetPVarString(giveplayerid, "trescOgloszenia", string);			
		PlayerInfo[giveplayerid][pBlokadaPisaniaFrakcjaCzas] = 0;
		KillTimer(komunikatTime[giveplayerid]);
		format(string, sizeof(string), "Administrator %s zdj¹³ Ci blokadê pisania na komunikatach frakcyjnych", GetNick(playerid));
		sendTipMessageEx(playerid, COLOR_P@, string);
		format(string, sizeof(string), "Administrator %s zdj¹³ blokadê dla %s. Mo¿e on teraz swobodnie pisaæ komunikat frakcyjny", GetNick(playerid), GetNick(giveplayerid));
		SendAdminMessage(COLOR_RED, string);
		
	}
	else
	{
		sendErrorMessage(playerid, "Brak uprawnieñ"); 
	}
	return 1;
}
CMD:dpa(playerid, params[])
{
	new para1;
	if(sscanf(params, "k<fix>", para1))
	{
		sendTipMessage(playerid, "U¿yj /dpa [playerid/CzêœæNicku]");
		return 1;
	}
	if (PlayerInfo[playerid][pAdmin] >= 1)
	{
		if(IsPlayerConnected(para1))
		{
			if(para1 != INVALID_PLAYER_ID)
			{
				if(PlayerInfo[para1][pNewAP] >= 1 && PlayerInfo[para1][pNewAP] <= 3)
				{
					new string[128], sendername[MAX_PLAYER_NAME], giveplayer[MAX_PLAYER_NAME];
					PlayerInfo[para1][pNewAP] -= 1;
					new level = PlayerInfo[para1][pNewAP];
					GetPlayerName(para1, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "   Zosta³eœ zdegradowany przez admina %s, masz teraz %d rangê pó³admina", sendername, level);
					SendClientMessage(para1, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "   Zdegradowa³eœ gracza %s, ma teraz %d rangê pó³admina.", giveplayer, level);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				}
				else
				{
					sendErrorMessage(playerid, "Ten gracz nie jest pó³adminem!");
				}
			}
		}
	}
	else
	{
		noAccessMessage(playerid);
	}
	return 1;
}
CMD:bp(playerid, params[])//blokada pisania
{
	new giveplayerid, czas, text[32], string[256];
	if(sscanf(params, "k<fix>ds[32]", giveplayerid, czas, text))
	{
		sendTipMessage(playerid, "U¿yj /bp [ID gracza] [czas (w gozinach)] [nazwa chatu]");
		return 1;
	}
	if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
	{
		if(IsPlayerConnected(giveplayerid))
		{
			if(giveplayerid != INVALID_PLAYER_ID)
			{
				if(czas <= 8 && czas >= 0)
				{
					GiveBPForPlayer(giveplayerid, playerid, czas, text);
					if(kary_TXD_Status == 1)
					{
						BPPlayerTXD(giveplayerid, playerid, czas, text);
					}
					else if(kary_TXD_Status == 0)
					{
						format(string, sizeof(string), "AdmCmd: %s dosta³ Blokadê Pisania od %s na %d godzin. Powód: %s", GetNick(giveplayerid), GetNick(playerid), czas, text);
						SendPunishMessage(string, playerid);
					}
					return 1;
				}
				else
				{
					sendTipMessage(playerid, "Czas od 0 do 8");
				}
			}
		}
	}
	else
	{
		format(string, sizeof(string), "%d jest nieaktywny.", giveplayerid);
		sendErrorMessage(playerid, string);
	}
	return 1;
}

CMD:KickEx_all(playerid)
{
	if(IsAHeadAdmin(playerid))
	{
		new string[64], sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid,sendername,sizeof(sendername));
		format(string, sizeof(string), "Admin %s (id:%d) zkickowal wszystkich graczy",sendername, playerid);
		SendClientMessageToAll(COLOR_RED, string);
		printf(string);

		foreach(Player, i)
		{
			SendClientMessage(playerid, COLOR_WHITE,"*$AdmCmd$*: zkickowales wszystkich graczy!");
			KickEx(i);
		}
	}
    return 1;
}
CMD:setmats(playerid, params[])
{
	if (IsAHeadAdmin(playerid))
	{
		new gracz, wartosc;
		if(sscanf(params, "k<fix>d", gracz, wartosc))
		{
			sendTipMessage(playerid, "U¿yj /setmats [playerid/CzêœæNicku] [iloœæ matsów]");
			return 1;
		}

		if(IsPlayerConnected(gracz))
		{
			new sendername[MAX_PLAYER_NAME], giveplayer[MAX_PLAYER_NAME], string[128];
			GetPlayerName(gracz, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			PlayerInfo[gracz][pMats] = wartosc;
			format(string, sizeof(string),"AdmCmd: %s dal %d matsow graczowi %s.", sendername, wartosc, giveplayer);
            StatsLog(string);

            _MruAdmin(playerid, sprintf("Da³eœ %d materia³ów graczowi %s [ID: %d]", wartosc, GetNick(gracz, true), gracz));
            if(gracz != playerid) _MruAdmin(gracz, sprintf("Dosta³eœ %d materia³ów od admina %s [ID: %d]", wartosc, GetNick(playerid, true), playerid));


		}
		else
		{
			sendErrorMessage(playerid, "Ten gracz jest offline!");
		}

	}
	else
	{
		noAccessMessage(playerid);
	}
	return 1;
}
CMD:reloadbans(playerid)
{
	if(PlayerInfo[playerid][pAdmin] >= 100)
	{
	    SendClientMessage(playerid, COLOR_GRAD6,"Trwa prze³adowywanie pliku samp.ban...");
	    SendRconCommand("reloadbans");
	    SendClientMessage(playerid, COLOR_GREEN,"Bany prze³adowane!");
	}
	else
	{
	    noAccessMessage(playerid);
	}
	return 1;
}
CMD:koxubankot(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1, level;
		if( sscanf(params, "k<fix>d", para1, level))
		{
			sendTipMessage(playerid, "U¿yj /koxubankot [playerid/CzêœæNicku] [level(1-5000) - level 0 zabiera admina]");
			return 1;
		}

		if(IsPlayerAdmin(playerid))
		{
            if(Uprawnienia(playerid, ACCESS_OWNER))
			{
				if(IsPlayerConnected(para1))
				{
					if(para1 != INVALID_PLAYER_ID)
					{
						GetPlayerName(para1, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						PlayerInfo[para1][pAdmin] = level;
						format(string, sizeof(string), "AdmCmd: %s mianowa³ %s na %d level admina.", sendername, giveplayer, level);
						StatsLog(string);
						format(string, sizeof(string), "   Zosta³eœ mianowany na %d level admina przez %s", level, sendername);
						SendClientMessage(para1, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "   Da³eœ %s admina o levelu %d.", giveplayer,level);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					}
				}
				
			}
			else if(PlayerInfo[playerid][pUID] == 6480)//Pluszak
			{
				if(IsPlayerConnected(para1))
				{
					if(para1 != INVALID_PLAYER_ID)
					{
						GetPlayerName(para1, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						PlayerInfo[para1][pAdmin] = level;
						format(string, sizeof(string), "AdmCmd: %s mianowa³ %s na %d level admina.", sendername, giveplayer, level);
						StatsLog(string);
						format(string, sizeof(string), "   Zosta³eœ mianowany na %d level admina przez %s", level, sendername);
						SendClientMessage(para1, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "   Da³eœ %s admina o levelu %d.", giveplayer,level);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					}
				}
			
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:setcarint(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
        new plo;
        if( sscanf(params, "d", plo))
        {
            sendTipMessage(playerid, "U¿yj /setcarint [carid]");
            return 1;
        }
        if (PlayerInfo[playerid][pAdmin] >= 1 || Uprawnienia(playerid, ACCESS_PANEL) || IsAKO(playerid) || IsAScripter(playerid))
        {
            LinkVehicleToInterior(plo, GetPlayerInterior(playerid));

            _MruAdmin(playerid, sprintf("Ustawi³eœ interior auta %d na %d", plo, GetPlayerInterior(playerid)));

        }
        else
        {
            noAccessMessage(playerid);
        }
    }
    else
    {
        SendClientMessage(playerid, COLOR_GREY, "B³¹d!");
    }
    return 1;
}
CMD:setcarvw(playerid, params[])
{
	new valueCAR, valueVW;
	if(sscanf(params, "k<fix>d", valueCAR, valueVW))
	{
		sendTipMessage(playerid, "U¿yj /setcarvw [carid] [VW]");
		return 1;
	}
	if(PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
	{
		SetVehicleVirtualWorld(valueCAR, valueVW);
		sendTipMessageEx(playerid, COLOR_RED, "Ustawi³eœ nowy VW dla pojazdu"); 
	}
	return 1;
}
CMD:panel(playerid, params[])
{
    if(!Uprawnienia(playerid, ACCESS_PANEL)) return noAccessMessage(playerid);
    new str[256];
    if(isnull(params))
    {
        new kary;
        if(Uprawnienia(playerid, ACCESS_KARY)) kary=0b10;
        SetPVarInt(playerid, "panel-upr", kary);
        DeletePVar(playerid, "panel-kary-continue");
        DeletePVar(playerid, "panel-powod");
        format(str, sizeof(str), "{FFFFFF}» PANEL KAR (%s{FFFFFF})\n{FFFFFF}» SprawdŸ konto gracza", (kary & 0b10) ? ("{00FF00}Uprawnienia") : ("{FF0000}Brak upr."));
        ShowPlayerDialogEx(playerid, D_PANEL_ADMINA, DIALOG_STYLE_LIST, "M-RP » Panel administracyjny", str, "Wybierz", "WyjdŸ");
    }
    else
    {
        new var[32], sub[32], powod[64];
        if(sscanf(params, "s[32]s[32]S()[64]", sub, var, powod)) return SendClientMessage(playerid, COLOR_GRAD2, "Parametry: unban [nick] | unbanip [IP] | ban [nick] [powód] | banip [IP] [powód] | unwarn [nick]");
        if(strcmp(sub, "unban", true) == 0)
        {
            if(!Uprawnienia(playerid, ACCESS_KARY_UNBAN))
            {
                sendErrorMessage(playerid, "Uprawnienia: Nie posiadasz wystarczaj¹cych uprawnieñ.");
                return 1;
            }
            if(strlen(var) < 1 || strlen(var) > MAX_PLAYER_NAME)
            {
                sendErrorMessage(playerid, "Niepoprawna d³ugosc!");
                return 1;
            }
            if(!MruMySQL_Odbanuj(var, "nieznane", playerid))
            {
                sendErrorMessage(playerid, "Nie mo¿na by³o wykonaæ zapytania do bazy!");
                return 1;
            }

            format(str, sizeof(str), "ADM: %s - odblokowano nick: %s", GetNick(playerid), var);
            SendClientMessage(playerid, COLOR_LIGHTRED, str);
            BanLog(str);
            return 1;
        }
        else if(strcmp(sub, "unbanip", true) == 0)
        {
            if(!Uprawnienia(playerid, ACCESS_KARY_UNBAN))
            {
                sendErrorMessage(playerid, "Uprawnienia: Nie posiadasz wystarczaj¹cych uprawnieñ.");
                return 1;
            }
            if(strlen(var) < 7 || strlen(var) > 16)
            {
                sendErrorMessage(playerid, "Niepoprawna d³ugosc IP!");
                return 1;
            }
            new count, cpos=0;
            while((cpos = strfind(var, ".", false, cpos)) != -1)
            {
                count++;
                cpos++;
            }
            if(count != 3)
            {
                sendErrorMessage(playerid, "Niepoprawny adres IP (dots)!");
                return 1;
            }
            if(!MruMySQL_Odbanuj("Brak", var, playerid))
            {
                sendErrorMessage(playerid, "Nie mo¿na by³o wykonaæ zapytania do bazy!");
                return 1;
            }

            format(str, sizeof(str), "ADM: %s - odblokowano IP: %s", GetNick(playerid), var);
            SendClientMessage(playerid, COLOR_LIGHTRED, str);
            BanLog(str);
            return 1;
        }
        else if(strcmp(sub, "ban", true) == 0)
        {
            if(!Uprawnienia(playerid, ACCESS_KARY_BAN))
            {
                sendErrorMessage(playerid, "Uprawnienia: Nie posiadasz wystarczaj¹cych uprawnieñ.");
                return 1;
            }
            if(strlen(var) < 1 || strlen(var) > MAX_PLAYER_NAME)
            {
                sendErrorMessage(playerid, "Niepoprawna d³ugosc!");
                return 1;
            }
            if(strlen(powod) < 1)
            {
                sendErrorMessage(playerid, "Podaj powód.");
                return 1;
            }
            MruMySQL_BanujOffline(var, powod, playerid);

            format(str, sizeof(str), "ADM: %s - zablokowano nick: %s powód: %s", GetNick(playerid), var, powod);
            SendClientMessage(playerid, COLOR_LIGHTRED, str);
            BanLog(str);
            return 1;
        }
        else if(strcmp(sub, "banip", true) == 0)
        {
            if(!Uprawnienia(playerid, ACCESS_KARY_BAN))
            {
                sendErrorMessage(playerid, "Uprawnienia: Nie posiadasz wystarczaj¹cych uprawnieñ.");
                return 1;
            }
            if(strlen(var) < 7 || strlen(var) > 16)
            {
                sendErrorMessage(playerid, "Niepoprawna d³ugosc IP!");
                return 1;
            }
            new count, cpos;
            while((cpos = strfind(var, ".", false, cpos)) != -1)
            {
                count++;
                cpos++;
            }
            if(count != 3)
            {
                sendErrorMessage(playerid, "Niepoprawny adres IP (dots)!");
                return 1;
            }
            MruMySQL_BanujOffline("Brak", powod, playerid, var);

            format(str, sizeof(str), "ADM: %s - zablokowano IP: %s powód: %s", GetNick(playerid), var, powod);
            SendClientMessage(playerid, COLOR_LIGHTRED, str);
            BanLog(str);
            return 1;
        }
        else if(strcmp(sub, "unwarn", true) == 0)
        {
            if(strlen(var) < 1 || strlen(var) > MAX_PLAYER_NAME)
            {
                SendClientMessage(playerid, COLOR_RED, "Niepoprawna d³ugosc!");
                return 1;
            }
			
			new id;
			if(!sscanf(var, "k<fix>", id) && id != INVALID_PLAYER_ID)
			{
                SendClientMessage(playerid, COLOR_RED, "Gracz jest online, u¿ywam komendy /unwarn");
				
				new txt[64];
				format(txt, sizeof(txt), "%d Panel /unwarn", id);
				cmd_unwarn(playerid, txt);
				return 1;
			}
			
            new warny = MruMySQL_GetAccInt("Warnings", var);
            if(warny > 0)
            {
				new escaped_nick[MAX_PLAYER_NAME];
				mysql_real_escape_string(var, escaped_nick);
                format(str, sizeof(str), "UPDATE `mru_konta` SET `Warnings` = `Warnings`-1 WHERE `Nick` = '%s'", escaped_nick);
    	        mysql_query(str);

                format(str, sizeof(str), "AdmCmd: Konto gracza %s zosta³o unwarnowane przez %s.", var, GetNick(playerid));
                ABroadCast(COLOR_YELLOW,str,1);
			/*	if(!IsPlayerAdmin(playerid))
				{
					SendClientMessage(playerid, COLOR_YELLOW, str);
				}*/
                WarnLog(str);
            }
            else sendTipMessage(playerid, "Gracz nie posiada warnów");
            return 1;
        }
    }
    return 1;
}
CMD:msgbox(playerid, params[])
{
    if(IsAHeadAdmin(playerid) || IsAScripter(playerid))
    {
        new forplayer=-1, title[64], icon, time;
        if(sscanf(params, "ds[64]dd", forplayer, title, icon, time))
        {
            SendClientMessage(playerid, COLOR_GRAD2, "Sk³adnia: [Gracz lub -1 dla wszystkich] [Tytu³ (64)] [Ikona] [Czas (sek)]");
            SendClientMessage(playerid, COLOR_GRAD1, "MSGBOX_ICON_TYPE_OK         0");
            SendClientMessage(playerid, COLOR_GRAD1, "MSGBOX_ICON_TYPE_ERROR      1");
            SendClientMessage(playerid, COLOR_GRAD1, "MSGBOX_ICON_TYPE_SMILE      2");
            SendClientMessage(playerid, COLOR_GRAD1, "MSGBOX_ICON_TYPE_WARNING    3");
            SendClientMessage(playerid, COLOR_GRAD1, "MSGBOX_ICON_TYPE_EXPLODE    4");
            SendClientMessage(playerid, COLOR_GRAD1, "MSGBOX_ICON_TYPE_WAIT       5");
            SendClientMessage(playerid, COLOR_GRAD1, "MSGBOX_ICON_TYPE_FLOWER     6");
            SendClientMessage(playerid, COLOR_GRAD1, "MSGBOX_ICON_TYPE_POLICE     7");
            SendClientMessage(playerid, COLOR_GRAD1, "MSGBOX_ICON_TYPE_FIST       8");
            SendClientMessage(playerid, COLOR_GRAD1, "MSGBOX_ICON_TYPE_ARROW      9");
            return 1;
        }
        if(!(0 <= icon <= 9)) return SendClientMessage(playerid, COLOR_GRAD1, " Ikony od 0 do 9");
        if(!(0 < time < 60)) return SendClientMessage(playerid, COLOR_GRAD1, " Czas od 1 do 60s");
        if(forplayer == -1)
        {
            foreach(Player, i) MSGBOX_Show(i, title, icon, time, true);
        }
        else MSGBOX_Show(forplayer, title, icon, time, true);
    }
    return 1;
}
CMD:gotoczit(playerid)
{
    if(PlayerInfo[playerid][pAdmin] > 1 || IsAScripter(playerid))
    {
        SetPlayerPos(playerid, czitX, czitY, czitZ);
        SetPlayerVirtualWorld(playerid, 0);
        SetPlayerInterior(playerid, 0);
        SendClientMessage(playerid, -1, "Teleportowa³eœ siê na miejsce zbrodni");
    }
    return 1;
}
CMD:anulujzp(playerid, params[]) 
{
    if(PlayerInfo[playerid][pAdmin] >= 5) 
	{
        new giveid, adminnick[MAX_PLAYER_NAME], gracznick[MAX_PLAYER_NAME];
		
        if(sscanf(params, "k<fix>", giveid)) 
			return sendTipMessage(playerid, "U¿yj /anulujzp [czêœæ nicku/id]"); 
			
        if(PlayerInfo[giveid][pCarLic] == 0 || PlayerInfo[giveid][pCarLic] == 1) 
		{
            return sendErrorMessage(playerid, "Ten gracz nie posiada zabranego prawa jazdy!");
        }
        PlayerInfo[giveid][pPK] = 0;
        PlayerInfo[giveid][pCarLic] = 0;
        GetPlayerName(playerid, adminnick, MAX_PLAYER_NAME);
        GetPlayerName(giveid, gracznick, MAX_PLAYER_NAME);
        new string[128];
        format(string, sizeof(string), "Admin %s zlikwidowa³ Twoj¹ blokadê na prawo jazdy!", adminnick);
        sendTipMessage(giveid, string, COLOR_LIGHTBLUE);
        format(string, sizeof(string), "Zlikwidowa³eœ %s blokadê na prawo jazdy!", gracznick);
        sendTipMessage(playerid, string, COLOR_LIGHTBLUE);
    } 
	else 
	{
        noAccessMessage(playerid);
    }
    return 1;
}

CMD:bwsettings(playerid, params[]) {
    if(Uprawnienia(playerid, ACCESS_PANEL) || PlayerInfo[playerid][pAdmin] >= 1000 || IsAScripter(playerid)) {
        new ust = GetSVarInt("BW_OnlyGangZones");
        SetSVarInt("BW_OnlyGangZones", !ust);
        dini_IntSet("Settings.ini", "OnlyGangZones", !ust);
        new string[70];
        format(string, sizeof(string), "Od teraz BW nadawane bêdzie %s", (ust == 1) ? ("tylko w obrêbie stref") : ("w ca³ym San Andreas"));
        sendTipMessage(playerid, string);
    } else {
        return noAccessMessage(playerid);
    }
    return 1;
}
CMD:bwtime(playerid, params[]) {
    if(Uprawnienia(playerid, ACCESS_PANEL) || PlayerInfo[playerid][pAdmin] >= 5000 || IsAScripter(playerid)) {
        new ust;
        if(sscanf(params, "d", ust)) return sendTipMessage(playerid, "U¿yj /bwtime [Czas BW w Sekundach]");
        dini_IntSet("Settings.ini", "Time", ust);
        SetSVarInt("BW_Time", ust);
		new string[70];
		format(string, sizeof(string), "Od teraz BW trwaæ bêdzie %ds", ust);
		sendTipMessage(playerid, string);
    } else {
        return noAccessMessage(playerid);
    }
    return 1;
}
CMD:setac(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1000 || IsAScripter(playerid))
	{
		new string[128];
		new ac_option;
		new onoff;
		
		if(sscanf(params, "dD(-1)", ac_option, onoff)) 
		{
			sendTipMessage(playerid, "U¿yj /setac [id opcji] (on = 1, off = 0, -1/nic - status)");
			return 1; 
		}
		
		if(ac_option == -1)
		{
			for(new i; i<sizeof(nexac_ac_names); i++)
			{
				format(string, sizeof(string), "AC: %s = %s", nexac_ac_names[i], (IsAntiCheatEnabled(i)) ? "true" : "false");
				SendClientMessage(playerid, -1, string);
			}
			return 1;
		}
		if(ac_option >= sizeof(nexac_ac_names) || ac_option < 0)
		{
			SendClientMessage(playerid, -1, "Nie ma takiej opcji");
			return 1;
		}
		
		//panel ac
		if(onoff == -1)
		{
			format(string, sizeof(string), "AC set: %s = %s", nexac_ac_names[ac_option], (IsAntiCheatEnabled(ac_option)) ? "true" : "false");
			SendClientMessage(playerid, -1, string);
		}
		else if(onoff == 0 || onoff == 1)
		{
			EnableAntiCheat(ac_option, onoff);
			format(string, sizeof(string), "AC set: %s = %s", nexac_ac_names[ac_option], (IsAntiCheatEnabled(ac_option)) ? "true" : "false");
			SendClientMessage(playerid, -1, string);
		}
		else
		{
			SendClientMessage(playerid, -1, "1 - on, 0 - off, -1 - status");
			return 1; 
		}
	}
	return 1;
}
CMD:addcar(playerid, p[])
{
    if(!Uprawnienia(playerid, ACCESS_EDITCAR)) return 1;
    new model, color1, color2;
    if(sscanf(p, "ddd", model, color1, color2)) return sendTipMessage(playerid, "U¿yj /addcar [Model] [Kolor] [Kolor]");
    new Float:x, Float:y, Float:z, Float:a;
    GetPlayerPos(playerid, x ,y ,z);
    GetPlayerFacingAngle(playerid, a);
    x+=floatsin(-a, degrees);
    y+=floatcos(-a, degrees);
    SetPlayerPosEx(playerid, x, y, z+0.5);
    new id = Car_Create(model, x,y,z,a, color1, color2);
    if(id == -1) return SendClientMessage(playerid, COLOR_GRAD2, "Brak wolnego miejsca?");
    new str[128];
    format(str, 128, "[CAR] Stworzono pojazd (UID: %d) model: %d przez %s", CarData[id][c_UID], model, GetNick(playerid));
	SendClientMessage(playerid, COLOR_GRAD2, str);
    ActionLog(str);
    return 1;
}

CMD:removecar(playerid, p[])
{
    if(!Uprawnienia(playerid, ACCESS_EDITCAR)) return 1;
    new car;
    if(sscanf(p, "d", car)) return sendTipMessage(playerid, "U¿yj /removecar [Car UID]");

    new uid = Car_GetIDXFromUID(car);
    if(uid == -1)
    {
        sendTipMessageEx(playerid, COLOR_GRAD2, "Pojazd nie by³ wczytany do systemu, inicjalizacja ...");
        uid = Car_LoadEx(car);
        if(uid == -1) return sendTipMessageEx(playerid, COLOR_GRAD2, "... brak pojazdu w bazie.");
    }
    new str[128];
    format(str, 128, "[CAR] Usuniêto pojazd (UID: %d) przez %s", CarData[uid][c_UID], GetNick(playerid));
	SendClientMessage(playerid, COLOR_GRAD2, str);
    ActionLog(str);
    Car_Destroy(uid);

    return 1;
}
CMD:supportduty(playerid)
{
    if(PlayerInfo[playerid][pZG] == 0 && PlayerInfo[playerid][pNewAP] == 0 && PlayerInfo[playerid][pAdmin] == 0) return 1;
    if(GetPVarInt(playerid, "support_duty") == 0)
    {
        SetPVarInt(playerid, "support_duty", 1);
        sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Jestes teraz na s³u¿bie pomocy nowym graczom.");
    }
    else
    {
        SetPVarInt(playerid, "support_duty", 0);
        sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Schodzisz ze s³u¿bie pomocy nowym graczom.");
    }
    return 1;
}

CMD:tickets(playerid)
{
    if(PlayerInfo[playerid][pZG] == 0 && PlayerInfo[playerid][pNewAP] == 0 && PlayerInfo[playerid][pAdmin] == 0) return 1;
    Support_ShowTickets(playerid);
    return 1;
}

CMD:ticketend(playerid)
{
    if(PlayerInfo[playerid][pZG] == 0 && PlayerInfo[playerid][pNewAP] == 0 && PlayerInfo[playerid][pAdmin] == 0) return 1;
    if(GetPVarInt(playerid, "validticket") != 1) return 1;
    SetPVarInt(playerid, "validticket", 0);
    if(Unspec[playerid][Coords][0] != 0)
    {
        PlayerInfo[playerid][pInt] = Unspec[playerid][sPint];
    	PlayerInfo[playerid][pLocal] = Unspec[playerid][sLocal];
        SetPlayerInterior(playerid, Unspec[playerid][sPint]);
        SetPlayerVirtualWorld(playerid, Unspec[playerid][sPvw]);
    	SetPlayerPosEx(playerid, Unspec[playerid][Coords][0], Unspec[playerid][Coords][1], Unspec[playerid][Coords][2]);
        Wchodzenie(playerid);
    }
    else
        SpawnPlayer(playerid);
    return 1;
}
CMD:stworz(playerid)
{
    if(!Uprawnienia(playerid, ACCESS_PANEL)) return 1;
    ShowPlayerDialogEx(playerid, D_CREATE, DIALOG_STYLE_LIST, "Panel Boga", "Wybierz co chcesz stworzyæ:\n1.\tOrganizacja", "Wybierz", "WyjdŸ");
    return 1;
}

CMD:edytuj(playerid)
{
    if(!Uprawnienia(playerid, ACCESS_PANEL)) return 1;
    ShowPlayerDialogEx(playerid, D_EDIT, DIALOG_STYLE_LIST, "Panel Boga", "Wybierz co chcesz edytowaæ:\n1.\tOrganizacja\n2.\tPojazd\n3.\tNazwy rang", "Wybierz", "WyjdŸ");
    return 1;
}
CMD:scena(playerid, params[])
{
    if(GetPlayerFraction(playerid) == FRAC_SN && PlayerInfo[playerid][pAdmin] < 200)
    {
        if(GetPVarInt(playerid, "scena-allow") != 1)
        {
            if(PlayerInfo[playerid][pRank] < 4) return sendTipMessageEx(playerid, COLOR_GRAD2, "Scena dostêpna za pozwoleniem adminów i od 4 rangi!");
            else
            {
                if(GetPVarInt(playerid, "scena-req") == 1)
                {
                    new str[128];
                    format(str, 128, "××× Gracz %s (ID: %d) prosi o pozwolenie na zarz¹dzanie scen¹.", GetNick(playerid), playerid);
                    SendAdminMessage(COLOR_PANICRED, str);
                    SetPVarInt(playerid, "scena-req", 2);
                }
                else if(GetPVarInt(playerid, "scena-req") == 0)
                {
                    SendClientMessage(playerid, COLOR_RED, "Mo¿esz tworzyæ scenê za pozwoleniem administracji. Aby wys³aæ zapytanie wpisz ponownie /scena");
                    SetPVarInt(playerid, "scena-req", 1);
                }
                else
                {
                    sendTipMessageEx(playerid, COLOR_RED, "Czekaj na akceptacjê administracji!");
                }
            }
        }
    }
    if(PlayerInfo[playerid][pAdmin] < 200 && GetPVarInt(playerid, "scena-allow") != 1) return 1;
    ShowPlayerDialogEx(playerid, SCENA_DIALOG_MAIN, DIALOG_STYLE_LIST, "Zarz¹dzanie scen¹", "Zbuduj scenê » Zniszcz scenê\nZarz¹dzanie ekranem\nZarz¹dzanie neonami\nDodatkowe efekty\nAudio URL\nMaszyny do dymu", "Wybierz", "Wyjdz");
    return 1;
}
CMD:scenaallow(playerid, p[])
{
    if(PlayerInfo[playerid][pAdmin] < 200 || IsAKO(playerid)) return 1;
    new id;
    if(sscanf(p, "k<fix>", id)) return sendTipMessage(playerid, "U¿yj /scenaallow [Nick/ID]");
    if(GetPVarInt(id, "scena-req") != 2 && PlayerInfo[playerid][pAdmin] < 1) return sendTipMessageEx(playerid, COLOR_GRAD2, "Ten gracz nie prosi³ o to.");
    new str[128];
    format(str, 128, "× Admin %s (ID: %d) nada³ Ci pozwolenie na zarz¹dzanie scen¹.", GetNick(playerid), playerid);
    SendClientMessage(id, COLOR_LIGHTBLUE,  str);
    format(str, 128, "× Daleœ %s (ID: %d) mo¿liwoœæ kontrolowania sceny. Aby zabraæ (/scenadisallow)", GetNick(id), id);
    SendClientMessage(playerid, COLOR_LIGHTBLUE,  str);
    SetPVarInt(id, "scena-allow", 1);
    return 1;
}

CMD:scenadisallow(playerid, p[])
{
    if(PlayerInfo[playerid][pAdmin] < 200 ) return 1;
    new id;
    if(sscanf(p, "k<fix>", id)) return sendTipMessage(playerid, "U¿yj /scenadisallow [Nick/ID]");
    if(GetPVarInt(id, "scena-allow") != 1) return sendTipMessageEx(playerid, COLOR_GRAD2, "Ten gracz nie ma takiego pozwolenia.");
    new str[128];
    format(str, 128, "× Admin %s (ID: %d) zabra³ Ci pozwolenie na zarz¹dzanie scen¹.", GetNick(playerid), playerid);
    SendClientMessage(id, COLOR_LIGHTRED,  str);
    format(str, 128, "× Zabra³eœ %s (ID: %d) mo¿liwoœæ kontrolowania sceny.", GetNick(id), id);
    SendClientMessage(playerid, COLOR_LIGHTRED,  str);
    SetPVarInt(id, "scena-allow", 0);
    return 1;
}
CMD:delete3dtext(playerid, p[])
{
    if(!IsAHeadAdmin(playerid)) return 1;

    new typ, Text3D:data, extra;
    if(sscanf(p, "ddD(0)", typ, _:data, extra))
    {
        sendTipMessageEx(playerid, -1, "/delete3dtext [TYP] [Data] [Extra - 0]");
        sendTipMessageEx(playerid, -1, "TYP: TextID - 0 | VW - 1");
        sendTipMessageEx(playerid, -1, "Data: Dla 0 [TextID] Dla 1 [VW]");
        sendTipMessageEx(playerid, -1, "Extra: Distance dla 1 (VW)");
        return 1;
    }
    if(typ == 0)
    {
        if(!IsValidDynamic3DTextLabel(data)) return sendTipMessageEx(playerid, -1, "Niepoprawne ID 3Dtextu");
        DestroyDynamic3DTextLabel(data);
    }
    else if(typ == 1)
    {
        new count, Float:x, Float:y, Float:z;
        if(extra == 0)
        {
            for(new i=0;i<20000;i++)
            {
                if(IsValidDynamic3DTextLabel(Text3D:i))
                {
                    if(Streamer_GetIntData(STREAMER_TYPE_3D_TEXT_LABEL, Text3D:i, E_STREAMER_WORLD_ID) == _:data)
                    {
                        Streamer_GetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, Text3D:i, E_STREAMER_X, x);
                        Streamer_GetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, Text3D:i, E_STREAMER_Y, y);
                        Streamer_GetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, Text3D:i, E_STREAMER_Z, z);
                        printf("Delete 3DText %d - at [%.1f, %.1f, %.1f]", i, x, y, z);
                        DestroyDynamic3DTextLabel(Text3D:i);
                        count++;
                    }
                }
            }
        }
        else
        {
            new Float:px, Float:py, Float:pz;
            GetPlayerPos(playerid, px, py, pz);
            for(new i=0;i<20000;i++)
            {
                if(IsValidDynamic3DTextLabel(Text3D:i))
                {
                    if(Streamer_GetIntData(STREAMER_TYPE_3D_TEXT_LABEL, Text3D:i, E_STREAMER_WORLD_ID) == _:data)
                    {
                        Streamer_GetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, Text3D:i, E_STREAMER_X, x);
                        Streamer_GetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, Text3D:i, E_STREAMER_Y, y);
                        Streamer_GetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, Text3D:i, E_STREAMER_Z, z);
                        if(VectorSize(x-px, y-py, z-pz) < float(extra))
                        {
                            printf("Delete VW.%d dist.%d Text3D %d - at [%.1f, %.1f, %.1f]", _:data, extra, i, x, y, z);
                            DestroyDynamic3DTextLabel(Text3D:i);
                            count++;

                        }
                    }
                }
            }
        }
        new dest[16];
        format(dest, 16, "Total %d", count);
        sendTipMessageEx(playerid, 0xFF0000FF, dest);
    }

    return 1;
}

CMD:deleteobject(playerid, p[])
{
    if(!IsAHeadAdmin(playerid)) return 1;
    new typ, data, extra;
    if(sscanf(p, "ddD(0)", typ, data, extra))
    {
        sendTipMessageEx(playerid, -1, "/deleteobject [TYP] [Data] [Extra - 0]");
        sendTipMessageEx(playerid, -1, "TYP: OBJECT - 0 | VW - 1");
        sendTipMessageEx(playerid, -1, "Data: Dla 0 [ObjectID] Dla 1 [VW]");
        sendTipMessageEx(playerid, -1, "Extra: Distance dla 1 (VW)");
        return 1;
    }
    if(typ == 0)
    {
        if(!IsValidDynamicObject(data)) return sendTipMessageEx(playerid, -1, "Niepoprawne ID obiektu");
        DestroyDynamicObject(data);
    }
    else if(typ == 1)
    {
        new count, Float:x, Float:y, Float:z;
        if(extra == 0)
        {
            for(new i=0;i<25000;i++)
            {
                if(IsValidDynamicObject(i))
                {
                    if(Streamer_GetIntData(STREAMER_TYPE_OBJECT, i, E_STREAMER_WORLD_ID) == data)
                    {
                        GetDynamicObjectPos(i, x, y, z);
                        printf("Delete object %d - model %d at [%.1f, %.1f, %.1f]", i, Streamer_GetIntData(STREAMER_TYPE_OBJECT, i, E_STREAMER_MODEL_ID), x, y, z);
                        DestroyDynamicObject(i);
                        count++;
                    }
                }
            }
        }
        else
        {
            new Float:px, Float:py, Float:pz;
            GetPlayerPos(playerid, px, py, pz);
            for(new i=0;i<25000;i++)
            {
                if(IsValidDynamicObject(i))
                {
                    if(Streamer_GetIntData(STREAMER_TYPE_OBJECT, i, E_STREAMER_WORLD_ID) == data)
                    {
                        GetDynamicObjectPos(i, x, y, z);
                        if(VectorSize(x-px, y-py, z-pz) < float(extra))
                        {
                            printf("Delete VW.%d dist.%d object %d - model %d at [%.1f, %.1f, %.1f]", data, extra, i, Streamer_GetIntData(STREAMER_TYPE_OBJECT, i, E_STREAMER_MODEL_ID), x, y, z);
                            DestroyDynamicObject(i);
                            count++;

                        }
                    }
                }
            }
        }
        new dest[16];
        format(dest, 16, "Total %d", count);
        sendTipMessageEx(playerid, 0xFF0000FF, dest);
    }
    return 1;
}
CMD:rapidfly(playerid, p[])
{
    if(PlayerInfo[playerid][pAdmin] >= 5 || IsAScripter(playerid))
    {
        new typ;
        sscanf(p, "D(0)", typ);
    	if(GetPVarType(playerid, "FlyMode")) CancelFlyMode(playerid);
    	else FlyMode(playerid, typ);
    }
    return 1;
}
CMD:zrobkolejke(playerid)
{
    if(PlayerInfo[playerid][pAdmin] < 5000) return 1;
    if(!VAR_Kolejka)
    {
        MoveDynamicObject(AI_SIGN[2], 3807.618408, -537.492492, 8.635930, 10.0); //text
        MoveDynamicObject(AI_MOVABLE[0], 3912.3362, -561.6449, 0.0500, 3.0, 0.000000, 0.000000, 48.0199);
        MoveDynamicObject(AI_MOVABLE[1], 3916.104736, -557.708984, -7.878650, 3.0);
        MoveDynamicObject(AI_NAPIS[0], 3843.368896, -567.393066, 1.844089, 3.0);
        MoveDynamicObject(AI_NAPIS[1], 3843.383789, -567.369018, 1.844089, 3.0); //text

        AI_PROTECT[0] = CreateDynamicObject(4735, 3906.916503, -560.902465, 6.887539, 0.000000, 0.000000, 331.760101, 5000, -1, -1, 500.0, 500.0);
        AI_PROTECT[1] = CreateDynamicObject(4735, 3906.907958, -560.920532, 1.245040, 0.000000, 0.000000, 331.760101, 5000, -1, -1, 500.0, 500.0);
        AI_PROTECT[2] = CreateDynamicObject(4735, 3906.916503, -560.902465, -2.905679, 0.000000, 0.000000, 331.760101, 5000, -1, -1, 500.0, 500.0);
        AI_PROTECT[3] = CreateDynamicObject(4735, 3914.500732, -546.748474, 1.245040, 0.000000, 0.000000, 331.760101, 5000, -1, -1, 500.0, 500.0);
        AI_PROTECT[4] = CreateDynamicObject(4735, 3914.500732, -546.748474, -3.921910, 0.000000, 0.000000, 331.760101, 5000, -1, -1, 500.0, 500.0);
        AI_PROTECT[5] = CreateDynamicObject(4735, 3899.221435, -575.369873, 6.887539, 0.000000, 0.000000, 331.760101, 5000, -1, -1, 500.0, 500.0);
        AI_PROTECT[6] = CreateDynamicObject(4735, 3899.221435, -575.369873, 1.364959, 0.000000, 0.000000, 331.760101, 5000, -1, -1, 500.0, 500.0);
        AI_PROTECT[7] = CreateDynamicObject(4735, 3907.697753, -577.399230, 7.392230, 0.000000, 0.000000, 62.899749, 5000, -1, -1, 500.0, 500.0);
        AI_PROTECT[8] = CreateDynamicObject(4735, 3917.948242, -589.035888, 7.392230, 0.000000, 0.000000, 18.559692, 5000, -1, -1, 500.0, 500.0);
        AI_PROTECT[9] = CreateDynamicObject(4735, 3919.635253, -605.333740, 7.392230, 0.000000, 0.000000, 354.439575, 5000, -1, -1, 500.0, 500.0);
        AI_PROTECT[10] = CreateDynamicObject(4735, 3919.292968, -611.443481, 3.371710, 0.000000, 0.000000, 356.959472, 5000, -1, -1, 500.0, 500.0);
        for(new i=0;i<11;i++) SetDynamicObjectMaterialText(AI_PROTECT[i], 0, "_", 90, "Arial", 36, 1, 0xFFFFFFFF, 0, 1);

        VAR_Kolejka=true;
        SendClientMessageToAll(0x75C8B7, "Administrator uruchomi³ kolejkê. Je¿eli masz jak¹œ sprawê, wpisz /kolejka");
    }
    else
    {
        MoveDynamicObject(AI_SIGN[2], 3807.618408, -537.492492, -10.0, 10.0); //text
        MoveDynamicObject(AI_MOVABLE[0], 3903.6672, -563.0015, 0.0500, 3.0, 0.000000, 0.000000, 149.9600);
        MoveDynamicObject(AI_MOVABLE[1], 3916.104736, -557.708984, -18.0, 3.0);
        MoveDynamicObject(AI_NAPIS[0], 3843.368896, -567.393066, -2.0, 3.0);
        MoveDynamicObject(AI_NAPIS[1], 3843.383789, -567.369018, -2.0, 3.0); //text

        for(new i=0;i<11;i++) DestroyDynamicObject(AI_PROTECT[i]);

        VAR_Kolejka=false;

        SendClientMessageToAll(0x75C8B7, "Administrator zakoñczy³ kolejkê.");

        for(new i=0;i<MAX_PLAYERS;i++)
        {
            if(GetPVarInt(i, "kolejka") == 1)
            {
                SetPVarInt(i, "kolejka", 0);
                SetPlayerPosEx(i, GetPVarFloat(i, "kolejka-x"),GetPVarFloat(i, "kolejka-y"),GetPVarFloat(i, "kolejka-z"));
                SetPlayerVirtualWorld(i, GetPVarInt(i, "kolejka-vw"));
                SetPlayerInterior(i, GetPVarInt(i, "kolejka-int"));
                Wchodzenie(i);
            }
        }
    }
    return 1;
}
CMD:gotoadmin(playerid)
{
    if(PlayerInfo[playerid][pAdmin] < 1) return 1;
    SetPlayerVirtualWorld(playerid, 5000);
	SetPlayerPosEx(playerid, 3524.550292, -236.021621, 35.619190);
	
    Wchodzenie(playerid);
    return 1;
}

CMD:gotomechy(playerid)
{
    if(PlayerInfo[playerid][pAdmin] > 0 || IsAScripter(playerid)) {
		
		if (GetPlayerState(playerid) == 2)
		{
			SetVehiclePos(GetPlayerVehicleID(playerid), 2778.0833, -1612.0159, 10.9219);

		}
		else
		{
			SetPlayerPosEx(playerid, 2778.0833,-1612.0159,10.9219);
		}
        SetPlayerVirtualWorld(playerid, 0);
        sendTipMessageEx(playerid, COLOR_GRAD1, "Zosta³eœ teleportowany na bazê mechaników, ³opata w d³oñ! ");
        SetPlayerInterior(playerid,0);
        PlayerInfo[playerid][pInt] = 0;
    }
    return 1;
}

CMD:gotobank(playerid)
{
    if(PlayerInfo[playerid][pAdmin] >= 5 || IsAScripter(playerid)) {
        
        if (GetPlayerState(playerid) == 2)
        {
            SetVehiclePos(GetPlayerVehicleID(playerid), 1464.0021,-1033.3855,23.6563);

        }
        else
        {
            SetPlayerPosEx(playerid, 1464.0021,-1033.3855,23.6563);
        }
        SetPlayerVirtualWorld(playerid, 0);
        sendTipMessageEx(playerid, COLOR_GRAD1, "Zosta³eœ teleportowany ");
        SetPlayerInterior(playerid, 0);
        PlayerInfo[playerid][pInt] = 0;
    }
    return 1;

}

CMD:gotostacja(playerid)
{
    if(PlayerInfo[playerid][pAdmin] >= 5 || IsAScripter(playerid)) {
        
        if (GetPlayerState(playerid) == 2)
        {
            SetVehiclePos(GetPlayerVehicleID(playerid), 1931.9171,-1807.5239,13.5728);
        }
        else
        {
            SetPlayerPosEx(playerid, 1931.9171,-1807.5239,13.5728);
        }
        SetPlayerVirtualWorld(playerid, 0);
        sendTipMessageEx(playerid, COLOR_GRAD1, "Zosta³eœ teleportowany ");
        SetPlayerInterior(playerid, 0);
        PlayerInfo[playerid][pInt] = 0;
    }
    return 1;

}
CMD:removeganglimit(playerid, p[])
{
    if(IsAHeadAdmin(playerid) || IsAScripter(playerid)) {
        new id;
        if(sscanf(p, "d", id)) return sendTipMessage(playerid, "U¿yj /removeganglimit [ID frakcji]");
        ZoneGangLimit[id] = true;
        sendTipMessageEx(playerid, COLOR_GRAD2, "Removed");
    }
    return 1;
}

CMD:removezoneprotect(playerid, p[])
{
    if(IsAHeadAdmin(playerid) || IsAScripter(playerid)) {
        new id;
        if(sscanf(p, "d", id)) return sendTipMessage(playerid, "U¿yj /removezoneprotect [ID strefy]");
        ZoneProtect[id] = false;
        sendTipMessageEx(playerid, COLOR_GRAD2, "Removed");
    }
    return 1;
}

CMD:gangzone(playerid, p[])
{
    if(IsAHeadAdmin(playerid) || IsAScripter(playerid)) {
        new id;
        if(sscanf(p, "d", id)) return sendTipMessage(playerid, "U¿yj /gangzone [0/1]");
        if(id < 0 || id > 1) return 1;
        ZONE_DISABLED = id;
        new str[64];
        format(str, 64, "UPDATE `mru_config` SET `gangzone`='%d'", id);
        mysql_query(str);

        sendTipMessageEx(playerid, COLOR_GRAD2, "OK");
    }
    return 1;
}

CMD:zonedelay(playerid, p[])
{
    if(IsAHeadAdmin(playerid) || IsAScripter(playerid)) {
        new id;
        new str[64];
        if(sscanf(p, "d", id)) {
            sendTipMessage(playerid, "U¿yj /zonedelay [Czas w sekundach]");
            format(str,64,"Aktualnie: %d sek", ZONE_DEF_TIME);
            sendTipMessage(playerid, str);
        } 
        if(id < 60 || id > 900) return sendTipMessageEx(playerid, COLOR_GRAD2, "Czas od 60 do 900s!");
        ZONE_DEF_TIME = id;
        format(str, 64, "UPDATE `mru_config` SET `gangtimedelay`='%d'", id);
        mysql_query(str);

        sendTipMessageEx(playerid, COLOR_GRAD2, "OK");
        return 1;
    }
    return 1;
}

CMD:clearzone(playerid, p[])
{
    if(IsAHeadAdmin(playerid) || IsAScripter(playerid)) {
        new id;
        if(sscanf(p, "d", id)) return sendTipMessage(playerid, "U¿yj /clearzone [ID]");
        if(id < 0) return sendTipMessageEx(playerid, COLOR_GRAD2, "Numer od 0");
        ZoneControl[id] = 0;
        ZoneProtect[id] = 0;
        new str[64];
        format(str, 64, "UPDATE `mru_strefy` SET `gang`='0' WHERE `id`='%d'", id);
        mysql_query(str);
        foreach(Player, i)
        {
            GangZoneHideForPlayer(i, id);
            GangZoneShowForPlayer(i, id, 0xC6E2F144);
        }
        sendTipMessageEx(playerid, COLOR_GRAD2, "OK");
    }
    return 1;
}

CMD:setzonecontrol(playerid, p[])
{
    if(IsAHeadAdmin(playerid) || IsAScripter(playerid)) {
        new id, frac;
        if(sscanf(p, "dd", id, frac)) return sendTipMessage(playerid, "U¿yj /setzonecontrol [ZoneID] [Owner]");
        if(id < 0) return sendTipMessageEx(playerid, COLOR_GRAD2, "Numer od 0");
        ZoneControl[id] = frac;
        new str[128];
        format(str, 128, "UPDATE `mru_strefy` SET `gang`='%d' WHERE `id`='%d'", frac, id);
        mysql_query(str);

        new org;
        if(frac > 100) org = orgID(frac-100);

        foreach(Player, i)
        {
            if(frac == FRAC_GROOVE)
            {
                GangZoneHideForPlayer(i, id);
                GangZoneShowForPlayer(i, id, ZONE_COLOR_GROOVE | 0x44);
            }
            else if(frac == FRAC_BALLAS)
            {
                GangZoneHideForPlayer(i, id);
                GangZoneShowForPlayer(i, id, ZONE_COLOR_BALLAZ | 0x44);
            }
            else if(frac == FRAC_VAGOS)
            {
                GangZoneHideForPlayer(i, id);
                GangZoneShowForPlayer(i, id, ZONE_COLOR_VAGOS | 0x44);
            }
            else if(frac == FRAC_WPS)
            {
                GangZoneHideForPlayer(i, id);
                GangZoneShowForPlayer(i, id, ZONE_COLOR_WPS | 0x44);
            }
            else
            {
                if(frac > 100)
                {
                    GangZoneHideForPlayer(i, id);
                    GangZoneShowForPlayer(i, id, OrgInfo[org][o_Color] | 0x44);
                }
            }
        }

        SendClientMessage(playerid, COLOR_GRAD2, "SET.");
    }
    return 1;

}

CMD:unbw(playerid, p[])
{
    if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1)
	{
		new id;
		if(sscanf(p, "k<fix>", id)) return sendTipMessage(playerid, "U¿yj /unbw [ID]");
		if(PlayerInfo[id][pBW] == 0) return sendTipMessageEx(playerid, COLOR_GRAD2, "Ten gracz nie ma BW.");
		PlayerInfo[id][pBW] = 2;
		SendClientMessage(playerid, COLOR_GRAD2, "Zdjêto BW");
	}
	else
	{
		sendErrorMessage(playerid, "Nie masz uprawnieñ.");
	}
    return 1;
}
CMD:czity(playerid, params[]) return cmd_cziterzy(playerid, params);
CMD:cziterzy(playerid, params[])
{
    /*if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1)//if(PlayerInfo[playerid][pAdmin] < 1) return 1;
    {
    	new str[128];
    	SendClientMessage(playerid, -1, "Potencjalna lista cziterów:");
    	foreach(Player, i)
    	{
        	if(GetPVarInt(i, "AC-warn") > 1)
        	{
            	if(PlayerInfo[i][pLevel] <= 3)
            	{
                	format(str, 128, "= %s (%d) LVL [%d], AC sprawdzenia: %d", GetNick(i), i, PlayerInfo[i][pLevel], GetPVarInt(i, "AC-warn"));
                	SendClientMessage(playerid, -1, str);
            	}
        	}
    	}

		ListaCziterow(playerid);
	} */
    new czity = 0;
    new string[1500];
    if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1) {
        foreach(Player, i) {
            if(GetPVarInt(i, "AC-warn") > 1) {
                format(string, sizeof(string), "%s[AC] %s (ID: %d)\n", string, GetNick(i), i);
                czity++;
            } else if(GetPVarInt(i, "AC_oznaczony") == 1) {
                format(string, sizeof(string), "%s[S0BEIT] %s (ID: %d)\n", string, GetNick(i), i);
                czity++;
            } 
        }
    }

    if(czity == 0) {
        sendTipMessage(playerid, "Nie wykryto ¿adnych potencjalnych cziterów");
    }
    ShowPlayerDialogEx(playerid, 0, DIALOG_STYLE_LIST, "Lista Potencjalnych Cziterów", string, "Ok", "");
    return 1;
}

CMD:checkprawko(playerid, params[]) return cmd_zobp(playerid, params);
CMD:zobaczprawko(playerid, params[]) return cmd_zobp(playerid, params);
CMD:zobp(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        new giveplayerid;
		if( sscanf(params, "k<fix>", giveplayerid))
		{
			sendTipMessage(playerid, "U¿yj /zobp(pokazlicencje) [playerid/CzêœæNicku]");
			return 1;
		}

		if(IsPlayerConnected(giveplayerid))
		{
		    if(PlayerInfo[playerid][pZG] >=5 || PlayerInfo[playerid][pAdmin] >=1 )
		    {
				if(giveplayerid != INVALID_PLAYER_ID)
				{
    				if(giveplayerid == playerid) { sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz pokazaæ licencji samemu sobie, u¿yj /licencje!"); return 1; }
				    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
	    			new text1[8];
					if(PlayerInfo[giveplayerid][pCarLic] == 1) { text1 = "Tak"; } else { text1 = "Brak"; }
  					format(string, sizeof(string), "|__________ %s __________|", giveplayer);
		        	SendClientMessage(playerid, COLOR_WHITE, string);
			        format(string, sizeof(string), "** Prawo jazdy: %s.", text1);
        			SendClientMessage(playerid, COLOR_WHITE, string);
				}
			}
			else
	        {
	            noAccessMessage(playerid);
	            return 1;
	        }
		}
        else
        {
            sendErrorMessage(playerid, "Nie ma takiego gracza !");
            return 1;
        }
	}
    return 1;
}
CMD:restart(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if (PlayerInfo[playerid][pAdmin] >= 5000 || IsAScripter(playerid))
		{
			new string[128];
			new playerNick[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playerNick, sizeof(playerNick));
			format(string, sizeof(string), "%s zarz¹dzi³ restart serwera! Trwa próba ponownego po³¹czenia", playerNick);
			foreach(Player, i)
			{
				sendErrorMessage(i, string);
			}
			SendRconCommand("gmx");
		}
		else
		{
			sendErrorMessage(playerid, "BRAK UPRAWNIEÑ!");
			return 1;
		}
	}
	return 1;
}
CMD:wczytajskrypt(playerid, params[])
{
	new string[128];
	if(IsPlayerConnected(playerid))
	{
		if(isnull(params))
		{
			sendTipMessage(playerid, "/wczytajskrypt [nazwa fs]");
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] >= 5000 || IsAScripter(playerid))
		{
			format(string, sizeof(string), "loadfs %s", params);
			SendRconCommand(string);
		}
		else
		{
			sendErrorMessage(playerid, "BRAK UPRAWNIEÑ!");
			return 1;
		}
	}
	return 1;
}
CMD:setchamp(playerid, params[]) return cmd_ustawmistrz(playerid, params);
CMD:setmistrz(playerid, params[]) return cmd_ustawmistrz(playerid, params);
CMD:ustawmistrz(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pAdmin] >= 50)
        {
            new  giveplayerid;
			if( sscanf(params, "k<fix>", giveplayerid))
			{
				sendTipMessage(playerid, "U¿yj /ustawmistrz [playerid/CzêœæNicku]");
				return 1;
			}


	        if(IsPlayerConnected(giveplayerid))
	        {
	            if(giveplayerid != INVALID_PLAYER_ID)
	            {
	                GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
	                new nstring[MAX_PLAYER_NAME];
					format(nstring, sizeof(nstring), "%s", giveplayer);
					strmid(Titel[TitelName], nstring, 0, strlen(nstring));
					Titel[TitelWins] = PlayerInfo[giveplayerid][pWins];
					Titel[TitelLoses] = PlayerInfo[giveplayerid][pLoses];
					SaveBoxer();
					format(string, sizeof(string), "* Mianowa³eœ %s nowym mistrzem bokserskim.", giveplayer);
					sendTipMessageEx(playerid, COLOR_LIGHTBLUE, string);
	            }
	        }
	        else
	        {
	            sendTipMessageEx(playerid, COLOR_GREY, "Nie ma takiego gracza !");
	            return 1;
	        }
        }
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:togadminmess(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
		{
			sendTipMessage(playerid, "Nie s³yszysz ju¿ nic! Nie widzisz ju¿ nic! Taki z ciebie admin"); 
			DeathWarning[playerid] = 0;
			TogPodglad[playerid] = 1;
			gOoc[playerid] = 1;
			SetPVarInt(playerid, "togadmincmd", 1);
			SetPVarInt(playerid, "togcmdlog", 1);
		}
	}
	return 1;
}
CMD:mole(playerid, params[])
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(PlayerInfo[playerid][pAdmin] >= 100)
    {
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj /mole [mole text]");
			return 1;
		}
		
        format(string, sizeof(string), "CMD_Info: /mole u¿yte przez %s [%d] - %s", GetNick(playerid), playerid, params);
        CMDLog(string);
		SendCommandLogMessage(string);
		
		SendSMSMessageToAll(555, params); //mole
	}
	return 1;
}
CMD:zg(playerid, params[]) return cmd_zaufanyggracz(playerid, params);
CMD:zaufanyggracz(playerid, params[])
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj /zg [admin chat]");
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1)
		{
			sendTipMessage(playerid, "Zaufani nie istniej¹! PogódŸ siê z tym."); 
			return 1;
		}
		if(PlayerInfo[playerid][pZG] == 1)
		{
			format(string, sizeof(string), "*%d Opiekun IC %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			SendZGMessage(0x7AA1C9FF/*COLOR_BROWN*/, string);
			printf("Zaufany Gracz %s: %s", sendername, params);
		}
		if(PlayerInfo[playerid][pZG] == 2)
		{
			format(string, sizeof(string), "*%d Prawie ZG %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			SendZGMessage(0x7AA1C9FF/*COLOR_BROWN*/, string);
			printf("Zaufany Gracz %s: %s", sendername, params);
		}
		if(PlayerInfo[playerid][pZG] == 3)
		{
			format(string, sizeof(string), "*%d Nowy ZG %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			SendZGMessage(0x7AA1C9FF/*COLOR_BROWN*/, string);
			printf("Zaufany Gracz %s: %s", sendername, params);
		}
		if(PlayerInfo[playerid][pZG] == 4)
		{
			format(string, sizeof(string), "*%d Zaufany Gracz %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			SendZGMessage(0x7AA1C9FF/*COLOR_BROWN*/, string);
			printf("Zaufany Gracz %s: %s", sendername, params);
		}
		if(PlayerInfo[playerid][pZG] == 5)
		{
			format(string, sizeof(string), "*%d Przyzwoity ZG %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			SendZGMessage(0x7AA1C9FF/*COLOR_BROWN*/, string);
			printf("Zaufany Gracz %s: %s", sendername, params);
		}
		if(PlayerInfo[playerid][pZG] == 6)
		{
			format(string, sizeof(string), "*%d Dobry ZG %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			SendZGMessage(0x7AA1C9FF/*COLOR_BROWN*/, string);
			printf("Zaufany Gracz %s: %s", sendername, params);
		}
		if(PlayerInfo[playerid][pZG] == 7)
		{
			format(string, sizeof(string), "*%d Bardzo Dobry ZG %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			SendZGMessage(0x7AA1C9FF/*COLOR_BROWN*/, string);
			printf("Zaufany Gracz %s: %s", sendername, params);
		}
		if(PlayerInfo[playerid][pZG] == 8)
		{
			format(string, sizeof(string), "*%d Œwietny ZG %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			SendZGMessage(0x7AA1C9FF/*COLOR_BROWN*/, string);
			printf("Zaufany Gracz %s: %s", sendername, params);
		}
		if(PlayerInfo[playerid][pZG] == 9)
		{
			format(string, sizeof(string), "*%d Znakomity ZG %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			SendZGMessage(0x7AA1C9FF/*COLOR_BROWN*/, string);
			printf("Zaufany Gracz %s: %s", sendername, params);
		}
		if(PlayerInfo[playerid][pZG] == 10)
		{
			format(string, sizeof(string), "*%d Æwieræ admin %s: %s",PlayerInfo[playerid][pZG], sendername, params);
			SendZGMessage(0x7AA1C9FF/*COLOR_BROWN*/, string);
			printf("Zaufany Gracz %s: %s", sendername, params);
		}

	}
	return 1;
}
CMD:logout(playerid) return cmd_wyloguj(playerid);
CMD:wyloguj(playerid)
{
    if(IsPlayerConnected(playerid))
    {
		if (PlayerInfo[playerid][pAdmin] >= 35)
		{
            MruMySQL_SaveAccount(playerid);
			gPlayerLogged[playerid] = 0;
			sendTipMessageEx(playerid, COLOR_GRAD1, "Wylogowa³eœ siê.");
            new str[128];
            format(str, 128, "* Admin %s wylogowa³ siê.", GetNick(playerid));
            StatsLog(str);
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}

CMD:logoutpl(playerid, params[]) return cmd_wylogujgracz(playerid, params);
CMD:wylogujgracz(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
		new giveplayerid;
		if( sscanf(params, "k<fix>", giveplayerid))
		{
			sendTipMessage(playerid, "U¿yj /wylogujgracz [playerid/CzêœæNicku]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 100)
		{
		    if(IsPlayerConnected(giveplayerid)&&giveplayerid != INVALID_PLAYER_ID)
		    {
                MruMySQL_SaveAccount(giveplayerid);
				gPlayerLogged[giveplayerid] = 0;
				SendClientMessage(playerid, COLOR_GRAD1, "Gracz zosta³ wylogowany.");
                new str[128];
                format(str, 128, "* Zosta³es wylogowany przez admina %s [%d].", GetNick(playerid), playerid);
                SendClientMessage(giveplayerid, COLOR_GRAD1,str);
                format(str, 128, "* Admin %s wylogowa³ %s", GetNick(playerid), GetNick(giveplayerid));
                StatsLog(str);
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}

CMD:logoutall(playerid) return cmd_wylogujall(playerid);
CMD:wylogujall(playerid)
{
    if(IsPlayerConnected(playerid))
    {
		if (IsAHeadAdmin(playerid))
		{
            new str[128];
            format(str, 128, "* Admin %s wylogowa³ WSZYSTKICH!!", GetNick(playerid));
            StatsLog(str);
            foreach(Player, i)
            {
    			if(IsPlayerConnected(i))
    			{
                    if(i == playerid) continue;
                    MruMySQL_SaveAccount(i);
    				gPlayerLogged[i] = 0;
    			}
    			sendTipMessageEx(i, COLOR_GRAD1, "Wszyscy gracze zostali wylogowani, zaloguj siê.");
            }
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:cnn(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
	{
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj /cnn [cnn formattextu ~n~=Nowalinia ~r~=Czerwony ~g~=Zielony ~b~=Niebieski ~w~=Bia³y ~y~=¯ó³ty]");
			return 1;
		}
		new string[128];
		new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		//
		format(string, sizeof(string), "~b~%s: ~w~%s",sendername,params);
        if(!issafefortextdraw(string)) return sendErrorMessage(playerid, "Niekompletny tekst (tyldy etc)");
		foreach(Player, i)
		{
			if(IsPlayerConnected(i))
			{
				GameTextForPlayer(i, string, 5000, 6);
			}
		}
        CMDLog(string);
		return 1;
	}
	else
	{
		noAccessMessage(playerid);
		return 1;
	}
}

CMD:cnnn(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] >= 5000)
	{
		new txtid, result[128];
		if( sscanf(params, "ds[128]", txtid, result))
		{
			sendTipMessage(playerid, "U¿yj /cnnn <typ> [cnnn formattextu ~n~=Nowalinia ~r~=Czerwony ~g~=Zielony ~b~=Niebieski ~w~=Bia³y ~y~=¯ó³ty]");
			return 1;
		}

		if(txtid == 2)
		{
			sendTipMessageEx(playerid, COLOR_GRAD2, "2 jest niedostêpna");
			return 1;
		}
		new string[128];
		format(string, sizeof(string), "~w~%s",result);
        if(!issafefortextdraw(string)) return sendErrorMessage(playerid, "Niekompletny tekst (tyldy etc)");
		foreach(Player, i)
		{
			if(IsPlayerConnected(i) == 1)
			{
				GameTextForPlayer(i, string, 5000, txtid);
			}
		}
		return 1;
	}
	else
	{
		noAccessMessage(playerid);
		return 1;
	}
}
CMD:prison(playerid, params[]) return cmd_demorgan(playerid, params);
CMD:demorgan(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pAdmin] < 20)
        {
            noAccessMessage(playerid);
            return 1;
        }
        new giveplayerid;
		if( sscanf(params, "k<fix>", giveplayerid))
		{
			sendTipMessage(playerid, "U¿yj /demorgan [playerid/CzêœæNicku]");
			return 1;
		}

	    if(IsPlayerConnected(giveplayerid))
	    {
	        if(giveplayerid != INVALID_PLAYER_ID)
	        {
	            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "* Uwiêzi³eœ %s w Fort DeMorgan.", giveplayer);
				SendClientMessage(playerid, COLOR_LIGHTRED, string);
				format(string, sizeof(string), "* Zosta³eœ uwiêziony w Forcie DeMorgan przez Administratora %s.", sendername);
				SendClientMessage(giveplayerid, COLOR_LIGHTRED, string);
				GameTextForPlayer(giveplayerid, "~w~Witamy w ~n~~r~Fort DeMorgan", 5000, 3);
				PoziomPoszukiwania[giveplayerid] = 0;
				PlayerInfo[giveplayerid][pJailed] = 2;
				PlayerInfo[giveplayerid][pJailTime] = 3600;
				ResetPlayerWeapons(giveplayerid);
				UsunBron(giveplayerid);

                format(string, sizeof(string), "CMD_Info: /demorgan u¿yte przez %s [%d]", GetNick(playerid), playerid);
                SendCommandLogMessage(string);
                CMDLog(string);
				JailDeMorgan(giveplayerid);
	        }
		}
		else
		{
		    sendErrorMessage(playerid, "Nie ma takiego gracza !");
		    return 1;
		}
    }
    return 1;
}
CMD:unaj(playerid, params[]) return cmd_unjail(playerid, params);
CMD:unjail(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new playa;
		if( sscanf(params, "k<fix>", playa))
		{
			sendTipMessage(playerid, "U¿yj /unaj [ID gracza]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {
		            if(PlayerInfo[playa][pJailed] == 3)
		            {
				        GetPlayerName(playa, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						format(string, sizeof(string), "* Uwolni³eœ %s.", giveplayer);
						_MruAdmin(playerid, string);
						format(string, sizeof(string), "* Zosta³eœ uwolniony przez %s.", sendername);
						_MruAdmin(playa, string);
						format(string, sizeof(string), "ADMCMD: Administrator %s uwolni³ %s z AJ", sendername, giveplayer);
						SendAdminMessage(COLOR_RED, string);
						format(string, sizeof(string), "ADMCMD: Administrator %s uwolnil %s z AJ", sendername, giveplayer);
                        KickLog(string);

						PlayerInfo[playa][pJailed] = 0;
						PlayerInfo[playa][pJailTime] = 0;
						PlayerInfo[playa][pMuted] = 0;
						SetPlayerInterior(playa, 0);
						SetPVarInt(playerid, "DostalDM2", 0);
						SetPlayerPosEx(playa,-1677.0605,917.2449,-52.4141);
						SetPlayerVirtualWorld(playa, 1);
                        Wchodzenie(playa);
						PlayerPlaySound(playa, 0, 0.0, 0.0, 0.0);
						StopAudioStreamForPlayer(playa);
						if(GetPlayerAdminDutyStatus(playerid) == 1)
						{
							iloscAJ[playerid] = iloscAJ[playerid]+1;
						}

					}
					else
					{
					    sendTipMessageEx(playerid, COLOR_GRAD1, "Ten gracz nie jest w AJ !");
					}
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:aj(playerid, params[]) return cmd_adminajail(playerid, params);
CMD:adminajail(playerid, params[])
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
		new playa, money, result[64];
		if( sscanf(params, "k<fix>ds[64]", playa, money, result))
		{
			sendTipMessage(playerid, "U¿yj /aj [id/nick] [czas(w minutach)] [powod]");
			return 1;
		}
		if(IsPlayerConnected(playa) && playa != INVALID_PLAYER_ID)
		{
			if (PlayerInfo[playa][pJailed] == 0)
			{
				if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pZG] >= 6 || PlayerInfo[playerid][pNewAP] >= 1 && PlayerInfo[playerid][pNewAP] <= 3 || IsAScripter(playerid))
				{
					if (PlayerInfo[playerid][pZG] >= 6 && PlayerInfo[playerid][pZG] < 8 && money > 7)
					{
						sendTipMessageEx(playerid, COLOR_GRAD2, "Mozesz dac tylko do 7 minut AJ!");
						return 1;
					}
					if (PlayerInfo[playerid][pZG] >= 8 && PlayerInfo[playerid][pZG] < 9 && money > 12)
					{
						sendTipMessageEx(playerid, COLOR_GRAD2, "Mozesz dac tylko do 12 minut AJ!");
						return 1;
					}
					if (PlayerInfo[playerid][pZG] >= 9 && money > 17)
					{
						sendTipMessageEx(playerid, COLOR_GRAD2, "Mozesz dac tylko do 17 minut AJ!");
						return 1;
					}
					if(OnDuty[playa] == 1 || OnDutyCD[playa] == 1)
					{
					    OnDuty[playa] = 0;
					    OnDutyCD[playa] = 0;
					}
					//Wykonanie:
					if(strfind((result), "DM2", true) == -1
					&& strfind((result), "Death Match 2", true) == -1)
					{
						SetPlayerAdminJail(playa, playerid, money, result);
						if(kary_TXD_Status == 1)
						{
							AJPlayerTXD(playa, playerid, (result)); 
						}
						else if(kary_TXD_Status == 0)
						{
							format(string, sizeof(string), "AdmCmd: %s zostal uwieziony w 'AJ' przez Admina %s. Czas: %d min Powod: %s.", GetNick(playa, true), GetNick(playerid), money, (result));
							SendPunishMessage(string, playa);
						}
						return 1;
					}
			
					
					//CZYNNOŒCI - GDY NADA£ Dm2
					SetPVarInt(playerid, "DostalDM2", 1);
					sendTipMessage(playa, "Marcepan Marks mówi: Otrzyma³eœ AJ'ota z powodem DM2, za karê zabiorê twoj¹ broñ!"); 
					PlayerInfo[playa][pJailed] = 3;
					PlayerInfo[playa][pJailTime] = money*60;
					SetPlayerVirtualWorld(playa, 1000+playa);
					PlayerInfo[playa][pMuted] = 1;
					SetPlayerPosEx(playa, 1481.1666259766,-1790.2204589844,156.7875213623);
					poscig[playa] = 0;
					KickLog(string);
					//Admin stats - /adminduty
					if(GetPlayerAdminDutyStatus(playerid) == 1)
					{
						iloscAJ[playerid] = iloscAJ[playerid]+1;
					}
					if(kary_TXD_Status == 1)
					{
						AJPlayerTXD(playa, playerid, (result)); 
					}
					else if(kary_TXD_Status == 0)
					{
						format(string, sizeof(string), "AdmCmd: %s zostal uwieziony w 'AJ' przez Admina %s. Czas: %d min Powod: %s.", GetNick(playa, true), GetNick(playerid), money, (result));
						SendPunishMessage(string, playa);
					}
					//adminowe logi
					format(string, sizeof(string), "Admini/%s.ini", GetNick(playerid));
					dini_IntSet(string, "Ilosc_AJ", dini_Int(string, "Ilosc_AJ")+1 );
					SendClientMessage(playa, COLOR_NEWS, "SprawdŸ czy otrzymana kara jest zgodna z list¹ kar i zasad, znajdziesz j¹ na www.Mrucznik-RP.pl");
					Wchodzenie(playa);
					
					//inne
					PlayerPlaySound(playa, 1076, 0.0, 0.0, 0.0);
				
				}
				else
				{
					noAccessMessage(playerid);
				}
			}
			else
			{
				sendErrorMessage(playerid, "Ten gracz ju¿ siedzi w wiêzieniu !");
			}
		}
		else
		{
		    sendErrorMessage(playerid, "Nie ma takiego gracza !");
			return 1;
		}
	}
	return 1;
}

CMD:jail(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new playa, money;
		if( sscanf(params, "k<fix>d", playa, money))
		{
			sendTipMessage(playerid, "U¿yj /jail [playerid/CzêœæNicku] [czas(minuty)]");
			return 1;
		}


		if (PlayerInfo[playerid][pAdmin] >= 20)
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {
			        GetPlayerName(playa, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "* Uwiêzi³eœ %s.", giveplayer);
					SendClientMessage(playerid, COLOR_LIGHTRED, string);
					format(string, sizeof(string), "* Zosta³eœ uwiêziony przez Admina %s.", sendername);
					SendClientMessage(playa, COLOR_LIGHTRED, string);
					format(string, sizeof(string), "* %s zosta³ uwiêziony w wiêzieniu na %d sekund przez admina %s.",giveplayer, money, sendername);
					SendPunishMessage(string, playa);
					ResetPlayerWeapons(playa);
					PoziomPoszukiwania[playa] = 0;
					PlayerInfo[playa][pJailed] = 1;
					PlayerInfo[playa][pJailTime] = money*60;
				    SetPlayerInterior(playa, 0);
                    SetPlayerVirtualWorld(playa, 1);
				    new losuj= random(sizeof(Cela));
					SetPlayerPosEx(playa, Cela[losuj][0], Cela[losuj][1], Cela[losuj][2]);
					format(string, sizeof(string), "Zosta³eœ uwiêziony na %s minut.   Kaucja: Niedostêpna", money);
					SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                    Wchodzenie(playa);
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}

CMD:tod(playerid, params[])
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
		new hour;
		if( sscanf(params, "d", hour))
		{
			sendTipMessage(playerid, "U¿yj /tod [czas] (0-23)");
			return 1;
		}


		if (PlayerInfo[playerid][pAdmin] >= 5 || IsAScripter(playerid))
		{
            SetWorldTime(hour);
            ServerTime = hour;
			
			format(string, sizeof(string), "Czas zmieniony na %d Godzine.", hour);
			BroadCast(COLOR_GRAD1, string);

            format(string, sizeof(string), "CMD_Info: /tod u¿yte przez %s [%d]", GetNick(playerid), playerid);
            SendCommandLogMessage(string);
            CMDLog(string);
			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				iloscInne[playerid] = iloscInne[playerid]+1;
			}
			foreach(Player, i)//Je¿eli gracze s¹ w intkach 
			{
				if(GetPlayerVirtualWorld(i) != 0 || GetPlayerInterior(i) != 0)
				{
					SetInteriorTimeAndWeather(i);
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}

CMD:startlotto(playerid)
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pAdmin] >= 2000)
        {
            format(string, sizeof(string), "Nowoœci lotto: Losowanie rozpoczête.");
            OOCOff(COLOR_WHITE, string);
            new rand = true_random(80);
            if(rand < 77) { rand += 3; }
            Lotto(rand);

            format(string, sizeof(string), "CMD_Info: /startlotto u¿yte przez %s [%d]", GetNick(playerid), playerid);
            SendCommandLogMessage(string);
            CMDLog(string);
        }
        else
        {
            noAccessMessage(playerid);
            return 1;
        }
    }
	return 1;
}
CMD:setstat(playerid, params[])
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
		new giveplayerid, stat, amount;
		if( sscanf(params, "k<fix>dd", giveplayerid, stat, amount))
		{
			sendTipMessage(playerid, "U¿yj /setstat [playerid/CzêœæNicku] [statcode] [amount]");
			SendClientMessage(playerid, COLOR_GRAD4, "|1 Level |2 SpawnHealth |3 UpgradePoints |4 Skin ");
			SendClientMessage(playerid, COLOR_GRAD3, "|5 KontoBankowe |6 NumerTelefonu |7 PunktyRespektu ");
			SendClientMessage(playerid, COLOR_GRAD2, "|8 KluczDomowy |9 KluczBiznesu |10 KontoPremium |11 Rodzina");
			SendClientMessage(playerid, COLOR_GRAD2, "|12 £owca Nagród |13 Prawnik |14 Mechanik |15 Reporter |16 ZlodziejAut |17 Diler Zio³a");
            SendClientMessage(playerid, COLOR_GRAD2, "|18 Prostututka |19 Bokser |20 Diler Broni |21 Rybak |22 Busiarz |23 Kurier | 24 Praca | 25 Czas Kontraktu");
			return 1;
		}

        if(IsPlayerConnected(giveplayerid))
    	{
    	    if(giveplayerid != INVALID_PLAYER_ID)
    	    {
				if (PlayerInfo[playerid][pAdmin] >= 5000)
				{
					switch (stat)
					{
						case 1:
						{
							PlayerInfo[giveplayerid][pLevel] = amount;
							format(string, sizeof(string), "Level gracza zmieniony na %d", amount);
						}
						case 2:
						{
							PlayerInfo[giveplayerid][pSHealth] = amount;
							format(string, sizeof(string), "¯ycie na spawnie gracza wynosi teraz %d ", amount);
						}
						case 3:
						{
							PlayerInfo[giveplayerid][gPupgrade] = amount;
							format(string, sizeof(string), "Punkty Ulepszenia gracza zmienione na %d", amount);
						}
						case 4:
						{
							PlayerInfo[giveplayerid][pModel] = amount;
							format(string, sizeof(string), "Skin gracza zmieniony na %d", amount);
						}
						case 5:
						{
						    if(IsAHeadAdmin(playerid))
						    {
								PlayerInfo[giveplayerid][pAccount] = amount;
								format(string, sizeof(string), "Kwota w Koncie Bankowym gracza zmieniona na $%d", amount);
							}
							else
							{
							    SendClientMessage(playerid, COLOR_GRAD1, "Nie ma");
							    return 1;
							}
						}
						case 6:
						{
							PlayerInfo[giveplayerid][pPnumber] = amount;
							format(string, sizeof(string), "Numer telefonu gracza zmieniony na %d", amount);
						}
						case 7:
						{
							PlayerInfo[giveplayerid][pExp] = amount;
							format(string, sizeof(string), "Punkty respektu gracza zmienione na %d", amount);
						}
						case 8:
						{
							PlayerInfo[giveplayerid][pDom] = amount;
							format(string, sizeof(string), "Klucz domowy gracza zmieniony na %d", amount);
						}
						case 9:
						{
							PlayerInfo[giveplayerid][pPbiskey] = amount;
							format(string, sizeof(string), "Klucz do biznesu gracza zmieniony na %d", amount);
						}
						case 10:
						{
							PlayerInfo[giveplayerid][pDonateRank] = amount;
							format(string, sizeof(string), "Konto premium gracza zmienione na %d", amount);
						}
						case 11:
						{
                            orgInvitePlayer(giveplayerid, amount);
							format(string, sizeof(string), "Rodzina gracza zmieniono na %d", amount);
						}
						case 12:
						{
							PlayerInfo[giveplayerid][pDetSkill] = amount;
							format(string, sizeof(string), "Skill £owcy Nagród gracza zmieniony na %d", amount);
						}
						case 13:
						{
							PlayerInfo[giveplayerid][pLawSkill] = amount;
							format(string, sizeof(string), "Skill prawnika gracza zmieniony na %d", amount);
						}
						case 14:
						{
							PlayerInfo[giveplayerid][pMechSkill] = amount;
							format(string, sizeof(string), "Skill mechanika gracza zmieniony na %d", amount);
						}
						case 15:
						{
							PlayerInfo[giveplayerid][pNewsSkill] = amount;
							format(string, sizeof(string), "Skill reportera gracza zmieniony na %d", amount);
						}
						case 16:
						{
							PlayerInfo[giveplayerid][pJackSkill] = amount;
							format(string, sizeof(string), "Skill z³odzieja samochodów gracza zmieniony na %d", amount);
						}
						case 17:
						{
							PlayerInfo[giveplayerid][pDrugsSkill] = amount;
							format(string, sizeof(string), "Skill Dilera Zio³a gracza zmieniony na %d", amount);
						}
						case 18:
						{
							PlayerInfo[giveplayerid][pSexSkill] = amount;
							format(string, sizeof(string), "Skill prostytutki gracza zmieniony na %d", amount);
						}
						case 19:
						{
							PlayerInfo[giveplayerid][pBoxSkill] = amount;
							format(string, sizeof(string), "Skill Boksera gracza zmieniony na %d", amount);
						}
						case 20:
						{
							PlayerInfo[giveplayerid][pGunSkill] = amount;
							format(string, sizeof(string), "Skill Dilera Broni gracza zmieniony na %d", amount);
						}
						case 21:
						{
							PlayerInfo[giveplayerid][pFishSkill] = amount;
							format(string, sizeof(string), "Skill Rybaka gracza zmieniony na %d", amount);
						}
						case 22:
						{
							PlayerInfo[giveplayerid][pCarSkill] = amount;
							format(string, sizeof(string), "Skill Busiarza gracza zmieniony na %d", amount);
						}
                        case 23:
						{
							PlayerInfo[giveplayerid][pTruckSkill] = amount;
							format(string, sizeof(string), "Skill kuriera gracza zmieniony na %d", amount);
						}
						case 24:
						{
							PlayerInfo[giveplayerid][pJob] = amount;
							format(string, sizeof(string), "Praca gracza zmieniona na %d", amount);
						}
						case 25:
						{
							PlayerInfo[giveplayerid][pContractTime] = amount;
							format(string, sizeof(string), "Czas kontraktu gracza zmieniony na %d", amount);
						}
						case 1337:
						{
							PlayerInfo[giveplayerid][pConnectTime] = amount;
							format(string, sizeof(string), "Czas gry gracza zmieniony na %d", amount);
						}
						default:
						{
							format(string, sizeof(string), "Z³y kod statystyk", amount);
						}

					}
					SendClientMessage(playerid, COLOR_GRAD1, string);
					format(string, sizeof(string), "%s da³ %s: %s", GetNick(playerid), GetNick(giveplayerid), string);
					StatsLog(string);
				}
				else
				{
					noAccessMessage(playerid);
				}
			}//not valid id
		}//not connected
	}
	return 1;
}

CMD:clearwlall(playerid)
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			foreach(Player, i)
			{
				PoziomPoszukiwania[i] = 0;
				PlayerInfo[i][pWL] = 0;
			}
			format(string, sizeof(string), "Admin %s wyczyœci³ wszystkim wanted level", GetNick(playerid));
			SendClientMessageToAll(COLOR_LIGHTBLUE, string);
			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				iloscInne[playerid] = iloscInne[playerid]+1;
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:setint(playerid, params[])
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
		new gracz, intid;
		if( sscanf(params, "k<fix>d", gracz, intid))
		{
			sendTipMessage(playerid, "U¿yj /setint [nick/id] [interiorid]");
			return 1;
		}

		if(!IsPlayerConnected(gracz))
		{
			sendErrorMessage(playerid, "Nie ma takiego gracza.");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
		{
			SetPlayerInterior(gracz,intid);
			PlayerInfo[gracz][pInt] = intid;
			format(string, sizeof(string), "Ustawi³eœ %s interior nr %d.", GetNick(gracz), intid);
			SendClientMessage(playerid, COLOR_GRAD1, string);
			format(string, sizeof(string), "Admin %s ustawi³ ci interior nr %d.", GetNick(playerid), intid);
			SendClientMessage(gracz, COLOR_LIGHTBLUE, string);
			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				iloscInne[playerid] = iloscInne[playerid]+1;
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}

CMD:setvw(playerid, params[])
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
		new gracz, intid;
		if( sscanf(params, "k<fix>d", gracz, intid))
		{
			sendTipMessage(playerid, "U¿yj /setvw [nick/id] [virtualworld]");
			return 1;
		}

		if(!IsPlayerConnected(gracz))
		{
			sendErrorMessage(playerid, "Nie ma takiego gracza.");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
		{
			SetPlayerVirtualWorld(gracz, intid);
			format(string, sizeof(string), "Ustawi³eœ %s virtualworld nr %d.", GetNick(gracz), intid);
			SendClientMessage(playerid, COLOR_GRAD1, string);
			format(string, sizeof(string), "Admin %s ustawi³ ci virtualworld nr %d.", GetNick(playerid), intid);
			SendClientMessage(gracz, COLOR_LIGHTBLUE, string);
			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				iloscInne[playerid] = iloscInne[playerid]+1;
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}

CMD:getint(playerid, params[])
{
	new gracz, string[64];
	if( sscanf(params, "k<fix>", gracz))
	{
		sendTipMessage(playerid, "U¿yj /getint [nick/id]");
		return 1;
	}

	if(!IsPlayerConnected(gracz))
	{
		sendErrorMessage(playerid, "Nie ma takiego gracza.");
		return 1;
	}

	if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
	{
		format(string, sizeof(string), "Interior gracza %s to %d.", GetNick(gracz), GetPlayerInterior(gracz));
		SendClientMessage(playerid, COLOR_GRAD1, string);
	}
	else
	{
		noAccessMessage(playerid);
	}
	return 1;
}

CMD:getvw(playerid, params[])
{
	new gracz, string[64];
	if( sscanf(params, "k<fix>", gracz))
	{
		sendTipMessage(playerid, "U¿yj /getvw [nick/id]");
		return 1;
	}

	if(!IsPlayerConnected(gracz))
	{
		sendErrorMessage(playerid, "Nie ma takiego gracza.");
		return 1;
	}

	if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
	{
		format(string, sizeof(string), "VirutalWorld gracza %s to %d.", GetNick(gracz), GetPlayerVirtualWorld(gracz));
		SendClientMessage(playerid, COLOR_GRAD1, string);
	}
	else
	{
		noAccessMessage(playerid);
	}
	return 1;
}

CMD:skydive(playerid)
{
    if(IsPlayerConnected(playerid))
    {
		if (PlayerInfo[playerid][pAdmin] >= 25)
		{
            new Float:rx, Float:ry, Float:rz;
            GetPlayerPos(playerid, rx, ry, rz);
            if(IsPlayerConnected(playerid))
            {
                GivePlayerWeapon(playerid, 46, 1);
                SetPlayerPos(playerid,rx, ry, rz+1500);
                SendClientMessage(playerid, COLOR_WHITE, "GO!! GO!! GO!!");
            }
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:dajpomocnika(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

	new para1, level;
	if( sscanf(params, "k<fix>d", para1, level))
	{
		sendTipMessage(playerid, "U¿yj /dajpomocnika [playerid/CzêœæNicku] [level(1-3)]");
		return 1;
	}

	GetPlayerName(para1, giveplayer, sizeof(giveplayer));
	GetPlayerName(playerid, sendername, sizeof(sendername));
    if(!Uprawnienia(playerid, ACCESS_GIVEHALF)) return noAccessMessage(playerid);
    if(IsPlayerConnected(para1))
    {
        if(para1 != INVALID_PLAYER_ID)
        {
            if(level == 0 || level == 1 || level == 2 || level == 3 || level == 4)
            {

				PlayerInfo[para1][pNewAP] = level;
				format(string, sizeof(string), "AdmCmd: %s mianowal %s na %d level poladmina.", sendername, giveplayer, level);
				CKLog(string);
				format(string, sizeof(string), "Zosta³eœ mianowany na %d level pó³admina przez %s", level, sendername);
				SendClientMessage(para1, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string), "Da³eœ %s pó³admina o levelu %d.", giveplayer,level);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            }
			else
			{
				sendTipMessageEx(playerid, COLOR_NEWS, "Level od 1 do 4!");
			}
		}
	}
	return 1;
}
CMD:dajskryptera(playerid, params[])
{
    new string[128];
    new giveplayer[MAX_PLAYER_NAME];
    new sendername[MAX_PLAYER_NAME];

    new para1;
    if( sscanf(params, "k<fix>d", para1))
    {
        sendTipMessage(playerid, "U¿yj /dajskryptera [playerid/CzêœæNicku]");
        return 1;
    }

    GetPlayerName(para1, giveplayer, sizeof(giveplayer));
    GetPlayerName(playerid, sendername, sizeof(sendername));
    if(!Uprawnienia(playerid, ACCESS_OWNER)) return noAccessMessage(playerid);
    if(IsPlayerConnected(para1))
    {
        if(para1 != INVALID_PLAYER_ID)
        {
            PlayerInfo[para1][pNewAP] = 5;
            format(string, sizeof(string), "AdmCmd: %s mianowal %s na skryptera.", sendername, giveplayer);
            CKLog(string);
            format(string, sizeof(string), "Zosta³eœ mianowany na skryptera przez %s", sendername);
            SendClientMessage(para1, COLOR_LIGHTBLUE, string);
            format(string, sizeof(string), "Da³eœ %s skryptera.", giveplayer);
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
        }
    }
    return 1;
}
CMD:dajzaufanego(playerid, params[])
{
    if(Uprawnienia(playerid, ACCESS_ZG))
    {
		new para1, level;
        new string[128];
    	new giveplayer[MAX_PLAYER_NAME];
    	new sendername[MAX_PLAYER_NAME];
		if( sscanf(params, "k<fix>d", para1, level))
		{
			sendTipMessage(playerid, "U¿yj /dajzaufanego [playerid/CzêœæNicku] [1- 10]");
			return 1;
		}
	    if(IsPlayerConnected(para1))
	    {
            if(level >= 0 && level <= 10)
            {
                GetPlayerName(para1, giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "AdmCmd: %s mianowa³ %s na %d level zaufanego.", sendername, giveplayer, level);
				CKLog(string);
				format(string, sizeof(string), "Zosta³eœ mianowany na %d level zaufanego gracza przez %s", level, sendername);
				SendClientMessage(para1, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string), "Da³eœ %s zaufanego o levelu %d.", giveplayer,level);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);

                PlayerInfo[para1][pZG] = level;
            }
			else
			{
				sendTipMessageEx(playerid, COLOR_NEWS, "Level od 1 do 10 !");
			}
		}
	}
	return 1;
}


CMD:makeircadmin(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new giveplayerid, channel;
		if( sscanf(params, "k<fix>d", giveplayerid, channel))
		{
			sendTipMessage(playerid, "U¿yj /makeircadmin [playerid/CzêœæNicku] [NrKana³u]");
			return 1;
		}

		if(channel > 10 || channel < 0) { sendTipMessage(playerid, "Numer nie mo¿e wynosiæ 0, albo wiêcej ni¿ 10!"); return 1; }
		if (PlayerInfo[playerid][pAdmin] >= 1000)
		{
		    if(IsPlayerConnected(giveplayerid))
		    {
		        if(giveplayerid != INVALID_PLAYER_ID)
		        {
					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "* Da³eœ %s admina kana³u IRC nr %d.", giveplayer, channel);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "* %s Mianowa³ ciê administratorem kana³u IRC nr %d.", sendername, channel);
					SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "%s", giveplayer);
					switch(channel)
					{
					    case 1:
					    {
					        strmid(IRCInfo[0][iAdmin], string, 0, strlen(string));
					        IRCInfo[0][iNeedPass] = 0; IRCInfo[0][iLock] = 0;
					    }
					    case 2:
					    {
					        strmid(IRCInfo[1][iAdmin], string, 0, strlen(string));
					        IRCInfo[1][iNeedPass] = 0; IRCInfo[1][iLock] = 0;
					    }
					    case 3:
					    {
					        strmid(IRCInfo[2][iAdmin], string, 0, strlen(string));
					        IRCInfo[2][iNeedPass] = 0; IRCInfo[2][iLock] = 0;
					    }
					    case 4:
					    {
					        strmid(IRCInfo[3][iAdmin], string, 0, strlen(string));
					        IRCInfo[3][iNeedPass] = 0; IRCInfo[3][iLock] = 0;
					    }
					    case 5:
					    {
					        strmid(IRCInfo[4][iAdmin], string, 0, strlen(string));
					        IRCInfo[4][iNeedPass] = 0; IRCInfo[4][iLock] = 0;
					    }
					    case 6:
					    {
					        strmid(IRCInfo[5][iAdmin], string, 0, strlen(string));
					        IRCInfo[5][iNeedPass] = 0; IRCInfo[5][iLock] = 0;
					    }
					    case 7:
					    {
					        strmid(IRCInfo[6][iAdmin], string, 0, strlen(string));
					        IRCInfo[6][iNeedPass] = 0; IRCInfo[6][iLock] = 0;
					    }
					    case 8:
					    {
					        strmid(IRCInfo[7][iAdmin], string, 0, strlen(string));
					        IRCInfo[7][iNeedPass] = 0; IRCInfo[7][iLock] = 0;
					    }
					    case 9:
					    {
					        strmid(IRCInfo[8][iAdmin], string, 0, strlen(string));
					        IRCInfo[8][iNeedPass] = 0; IRCInfo[8][iLock] = 0;
					    }
					    case 10:
					    {
					        strmid(IRCInfo[9][iAdmin], string, 0, strlen(string));
					        IRCInfo[9][iNeedPass] = 0; IRCInfo[9][iLock] = 0;
					    }
					}
					SaveIRC();
				}
			}
			else
			{
			    sendErrorMessage(playerid, "Nie ma takiego gracza !");
			    return 1;
			}
		}
		else
		{
		    noAccessMessage(playerid);
		    return 1;
		}
	}
	return 1;
}
CMD:forceskin(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1;
		if( sscanf(params, "k<fix>", para1))
		{
			sendTipMessage(playerid, "U¿yj /forceskin [playerid/CzêœæNicku]");
			return 1;
		}


		if (PlayerInfo[playerid][pAdmin] >= 25)
		{
		    if(IsPlayerConnected(para1))
		    {
		        if(para1 != INVALID_PLAYER_ID)
		        {
			        if(PlayerInfo[para1][pMember] < 1)
			        {
			            sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest we frakcji !");
			            return 1;
			        }
					GetPlayerName(para1, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "* Zosta³eœ wybrany do zmiany skinu przez Administratora %s.", sendername);
					SendClientMessage(para1, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "* Wymusi³eœ zmiane skinu na %s.", giveplayer);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					NowaWybieralka::Setup(para1);
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:dajlideraorg(playerid, params[])
{
    if(!Uprawnienia(playerid, ACCESS_MAKELEADER)) return 1;
    new id=-1, family;
	if( sscanf(params, "dK<fix>(-1)", family, id)) return sendTipMessage(playerid, "U¿yj /dajlideraorg [ORG ID] [ID/Nick]");
    if(family < 0 || family > MAX_ORG-1) return 1;
    if(id != -1)
    {
        if(!IsPlayerConnected(id)) return sendErrorMessage(playerid, "Brak takiego gracza!");
        if(GetPlayerFraction(id) != 0 || GetPlayerOrg(id) != 0) return sendTipMessageEx(playerid, COLOR_GRAD2, "Ten gracz ma frakcje lub rodzine!");
        orgInvitePlayer(id, family);
        gPlayerOrgLeader[id] = true;
    }
    new str[128];
    if(id != -1)
    {
		new orgUID = orgID(family);
		if(orgUID != 0xFFFF)
		{
			format(str, sizeof(str), "Admin %s da³ Tobie kontrolê nad rodzin¹ %s (%d) - /pr", GetNick(playerid), OrgInfo[orgUID][o_Name], family);
			SendClientMessage(id, COLOR_LIGHTBLUE, str);
			format(str, sizeof(str), "Da³eœ kontrolê nad rodzin¹ %s (%d) graczowi %s", OrgInfo[orgUID][o_Name], family, GetNick(id));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, str);
			
			//logi
			format(str, sizeof(str), "%s dal kontrole nad rodzina %d graczowi %s", GetNick(playerid), family, GetNick(id));
			ActionLog(str);
			
			PlayerInfo[id][pTeam] = 5;
			gTeam[id] = 5;
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, "ERROR! Wyst¹pi³ b³¹d, zg³oœ okolicznoœci do Mrucznika na slacku.");
		}
    }
    else
    {
        SendClientMessage(playerid, COLOR_RED, "================ LISTA LIDERÓW ================");
        format(str, 128, "SELECT `Nick` FROM `mru_konta` WHERE `FMember`='%d' AND `Rank`>1000", family);
        mysql_query(str);
        mysql_store_result();
        new nick[24];
        while(mysql_fetch_row_format(str, "|"))
        {
            sscanf(str, "p<|>s[24]", nick);
            SendClientMessage(playerid, -1, nick);
        }
        SendClientMessage(playerid, COLOR_RED, "================ KONIEC ================");
    }
    return 1;
}
CMD:zabierzlideraorg(playerid, params[])
{
    if(!Uprawnienia(playerid, ACCESS_MAKEFAMILY)) return 1;
    new id=-1;
	if( sscanf(params, "k<fix>", id)) return sendTipMessage(playerid, "U¿yj /zabierzlideraorg [ID/Nick]");
	if(id != -1)
    {
        if(!IsPlayerConnected(id)) return sendErrorMessage(playerid, "Brak takiego gracza!");
        if(!gPlayerOrgLeader[id]) return sendTipMessageEx(playerid, COLOR_GRAD2, "Ten gracz nie ma lidera rodziny!");
        orgGivePlayerRank(id, INVALID_PLAYER_ID, PlayerInfo[id][pRank]);
        gPlayerOrgLeader[id] = false;
    }
    new str[128];
    if(id != -1)
    {
        format(str, 128, "Admin %s odebra³ Tobie kontrolê nad rodzin¹ %s", GetNick(playerid), OrgInfo[gPlayerOrg[id]][o_Name]);
        SendClientMessage(id, COLOR_LIGHTBLUE, str);
        format(str, 128, "Odebra³eœ kontrolê nad rodzin¹ %s graczowi %s", OrgInfo[gPlayerOrg[id]][o_Name], GetNick(id));
        SendClientMessage(playerid, COLOR_LIGHTBLUE, str);
		
		//logi
		format(str, sizeof(str), "%s odebral kontrole nad rodzina %d graczowi %s", GetNick(playerid), gPlayerOrg[id], GetNick(id));
		ActionLog(str);
    }
    return 1;
}

CMD:makeleader(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1, level;
		if( sscanf(params, "k<fix>d", para1, level))
		{
			sendTipMessage(playerid, "U¿yj /makeleader [playerid/CzêœæNicku] [Number(1-17)]");
			return 1;
		}

		if(level > 17 || level < 0) { sendTipMessageEx(playerid, COLOR_GREY, "Numer lidera od 1 do 17!"); return 1; }
		if(Uprawnienia(playerid, ACCESS_MAKELEADER) || IsAScripter(playerid))
		{
		    if(IsPlayerConnected(para1))
		    {
		        if(para1 != INVALID_PLAYER_ID)
		        {
                    if(level != 0)
                    {
    		            if(PlayerInfo[para1][pMember] > 0 || GetPlayerOrg(para1) != 0)
    		            {
    		                sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz jest we frakcji jako cz³onek lub w rodzinie !");
    		                return 1;
    		            }
                    }
					GetPlayerName(para1, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					PlayerInfo[para1][pLider] = level;
                    PlayerInfo[para1][pMember] = level;
                    MruMySQL_SetAccInt("Member", giveplayer, level);
                    MruMySQL_SetAccInt("Lider", giveplayer, level);
					format(string, sizeof(string), "Zosta³eœ mianowany liderem frakcji przez %s", sendername);
					SendClientMessage(para1, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "Da³eœ graczowi %s kontrolê nad frakcj¹ numer %d.", giveplayer,level);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					
					//logi
					format(string, sizeof(string), "%s dal kontrole nad frakcja numer %d graczowi %s", sendername, level, giveplayer);
					ActionLog(string);
					if(GetPlayerAdminDutyStatus(playerid) == 1)
					{
						iloscInne[playerid] = iloscInne[playerid]+1;
					}
					
					if(level == 0) { PlayerInfo[para1][pSkin] = 0; }
					else if(level == 1) { PlayerInfo[para1][pSkin] = 288; } //Police Force
					else if(level == 2) { PlayerInfo[para1][pSkin] = 295; } //FBI/ATF
					else if(level == 3) { PlayerInfo[para1][pSkin] = 287; } //National Guard
					else if(level == 4) { PlayerInfo[para1][pSkin] = 228; } //Fire/Ambulance
					else if(level == 5) { PlayerInfo[para1][pSkin] = 113; } //La Cosa Nostra
					else if(level == 6) { PlayerInfo[para1][pSkin] = 208; } //Yakuza
					else if(level == 7) { PlayerInfo[para1][pSkin] = 57; } //BOR
					else if(level == 8) { PlayerInfo[para1][pSkin] = 294; } //Hitmans
					else if(level == 9) { PlayerInfo[para1][pSkin] = 227; } //News Reporters
					else if(level == 10) { PlayerInfo[para1][pSkin] = 61; } //Taxi Cab Company
					else if(level == 11) { PlayerInfo[para1][pSkin] = 147; } //Burmistrz
					else if(level == 12) { PlayerInfo[para1][pSkin] = 270; } //Grove Street
					else if(level == 13) { PlayerInfo[para1][pSkin] = 103; } //Ballas
					else if(level == 14) { PlayerInfo[para1][pSkin] = 109; } //Vagos
					else if(level == 15) { PlayerInfo[para1][pSkin] = 60; } //NoA
					else if(level == 16) { PlayerInfo[para1][pSkin] = 112; } //Dziady
                    else if(level == 17) { PlayerInfo[para1][pSkin] = 279; } //LSFD
				    if(level != 0)
                    {
                        gTeam[para1] = 11;
    				    PlayerInfo[para1][pTeam] = 11;
                        PlayerInfo[para1][pRank] = 6;
                    }
                    if(PlayerInfo[para1][pSkin] != 0) SetPlayerSkin(para1, PlayerInfo[para1][pSkin]);
                    else SetPlayerSkin(para1, PlayerInfo[para1][pModel]);
				}
			}//not connected
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}

CMD:makewomanleader(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1, level;
		if( sscanf(params, "k<fix>d", para1, level))
		{
			sendTipMessage(playerid, "U¿yj /makewomanleader [ID gracza] [Numer (1-17)]");
			return 1;
		}

		if(level > 17 || level < 0) { sendTipMessageEx(playerid, COLOR_GREY, "Od 0 do 17 !"); return 1; }
		if (Uprawnienia(playerid, ACCESS_MAKELEADER))
		{
		    if(IsPlayerConnected(para1))
		    {
		        if(para1 != INVALID_PLAYER_ID)
		        {
                    if(level != 0)
                    {
    		            if(PlayerInfo[playerid][pMember] > 0 || GetPlayerOrg(para1) != 0)
    		            {
    		                sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz jest we frakcji jako cz³oenk lub w rodzinie !");
    		                return 1;
    		            }
                    }
					GetPlayerName(para1, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					PlayerInfo[para1][pLider] = level;
					format(string, sizeof(string), "Zosta³eœ mianowany liderem frakcji przez Administratora: %s", sendername);
					SendClientMessage(para1, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "Da³eœ kontrolê graczowi %s nad frakcj¹ numer %d.", giveplayer,level);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					
					//logi
					format(string, sizeof(string), "%s dal kontrole nad frakcja numer %d graczowi %s", sendername, level, giveplayer);
					ActionLog(string);
					if(GetPlayerAdminDutyStatus(playerid) == 1)
					{
						iloscInne[playerid] = iloscInne[playerid]+1;
					}
					
					if(level == 0) { PlayerInfo[para1][pSkin] = 0; }
					else if(level == 1) { PlayerInfo[para1][pSkin] = 93; } //Police Force
					else if(level == 2) { PlayerInfo[para1][pSkin] = 193; } //FBI/ATF
					else if(level == 3) { PlayerInfo[para1][pSkin] = 191; } //National Guard
					else if(level == 4) { PlayerInfo[para1][pSkin] = 69; } //Fire/Ambulance
					else if(level == 5) { PlayerInfo[para1][pSkin] = 211; } //La Cosa Nostra
					else if(level == 6) { PlayerInfo[para1][pSkin] = 169; } //Yakuza
					else if(level == 7) { PlayerInfo[para1][pSkin] = 141; } //Mayor
					else if(level == 8) { PlayerInfo[para1][pSkin] = 219; } //Hitman Agency
					else if(level == 9) { PlayerInfo[para1][pSkin] = 141; } //News Reporters
					else if(level == 10) { PlayerInfo[para1][pSkin] = 192; } //Taxi Cab Company
					else if(level == 11) { PlayerInfo[para1][pSkin] = 150; } //Driving/Flying School
					else if(level == 12) { PlayerInfo[para1][pSkin] = 237; } //Mafia so³ncewska
					else if(level == 13) { PlayerInfo[para1][pSkin] = 195; } //Grove Street
					else if(level == 14) { PlayerInfo[para1][pSkin] = 13; } //Ballas
					else if(level == 15) { PlayerInfo[para1][pSkin] = 192; } //NoA
					else if(level == 16) { PlayerInfo[para1][pSkin] = 129; } //WPS
                    else if(level == 17) { PlayerInfo[para1][pSkin] = 278; } //WPS
				    gTeam[para1] = 19;
				    PlayerInfo[para1][pTeam] = 19;
                    PlayerInfo[para1][pRank] = 6;
                    if(PlayerInfo[para1][pSkin] != 0) SetPlayerSkin(para1, PlayerInfo[para1][pSkin]);
                    else SetPlayerSkin(para1, PlayerInfo[para1][pModel]);
				}
			}//not connected
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:makemember(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1, level;
		if( sscanf(params, "k<fix>d", para1, level))
		{
			sendTipMessage(playerid, "U¿yj /makemember [ID gracza] [Numer (1-17)]");
			return 1;
		}

		if(level > 17 || level < 0) { SendClientMessage(playerid, COLOR_GREY, "Od 0 do 17 !"); return 1; }
		if (PlayerInfo[playerid][pAdmin] >= 1000 || Uprawnienia(playerid, ACCESS_MAKELEADER || IsAScripter(playerid)))
		{
		    if(IsPlayerConnected(para1))
		    {
		        if(para1 != INVALID_PLAYER_ID)
		        {
		            if(GetPlayerFraction(para1) > 0 || GetPlayerOrg(para1) != 0)
		            {
		                sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz ma ju¿ prace !");
		                return 1;
		            }
					GetPlayerName(para1, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					PlayerInfo[para1][pMember] = level;
					format(string, sizeof(string), "Zosta³eœ mianowany pracownikiem frakcji numer %d przez Administratora: %s", level,sendername);
					SendClientMessage(para1, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "Da³eœ membera graczowi %s nad frakcj¹ numer %d.", giveplayer,level);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					
					//logi
					format(string, sizeof(string), "%s mianowal na czlonka frakcji numer %d gracza %s", sendername, level, giveplayer);
					ActionLog(string);
					if(GetPlayerAdminDutyStatus(playerid) == 1)
					{
						iloscInne[playerid] = iloscInne[playerid]+1;
					}
					
					if(level == 0) { PlayerInfo[para1][pSkin] = 0; }
					else if(level == 1) { PlayerInfo[para1][pSkin] = 280; } //Police Force
					else if(level == 2) { PlayerInfo[para1][pSkin] = 285; } //FBI/ATF
					else if(level == 3) { PlayerInfo[para1][pSkin] = 287; } //National Guard
					else if(level == 4) { PlayerInfo[para1][pSkin] = 70; } //Fire/Ambulance
					else if(level == 5) { PlayerInfo[para1][pSkin] = 258; } //La Cosa Nostra
					else if(level == 6) { PlayerInfo[para1][pSkin] = 120; } //Yakuza
					else if(level == 7) { PlayerInfo[para1][pSkin] = 240; } //Mayor
					else if(level == 8) { PlayerInfo[para1][pSkin] = 127; } //Hitman Agency
					else if(level == 9) { PlayerInfo[para1][pSkin] = 148; } //News Reporters
					else if(level == 10) { PlayerInfo[para1][pSkin] = 255; } //Taxi Cab Company
					else if(level == 11) { PlayerInfo[para1][pSkin] = 59; } //Driving/Flying School
					else if(level == 12) { PlayerInfo[para1][pSkin] = 270; } //Grove Street
					else if(level == 13) { PlayerInfo[para1][pSkin] = 103; } //Ballas
					else if(level == 14) { PlayerInfo[para1][pSkin] = 108; } //Vagos
					else if(level == 15) { PlayerInfo[para1][pSkin] = 8; } //NoA
                    else if(level == 17) PlayerInfo[para1][pSkin] = 277; //NoA
				    gTeam[para1] = 19;
				    PlayerInfo[para1][pTeam] = 19;

                    MruMySQL_SetAccInt("Member", giveplayer, level);
                    MruMySQL_SetAccInt("Rank", giveplayer, 0);

                    PlayerInfo[para1][pRank] = 0;

				    if(PlayerInfo[para1][pSkin] != 0) SetPlayerSkin(para1, PlayerInfo[para1][pSkin]);
                    else SetPlayerSkin(para1, PlayerInfo[para1][pModel]);
				}
			}//not connected
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:setteam(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1, level;
		if( sscanf(params, "k<fix>d", para1, level))
		{
			sendTipMessage(playerid, "U¿yj /setteam [playerid/CzêœæNicku] [team 1(civ) - 2(cop)]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 10)
		{
		    if(IsPlayerConnected(para1))
		    {
		        if(para1 != INVALID_PLAYER_ID)
		        {
					GetPlayerName(para1, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					PlayerInfo[para1][pTeam] = level;
					gTeam[para1] = level;
					//SetPlayerWeapons(para1);
					SetPlayerSpawn(para1);
					printf("AdmCmd: %s zmienil druzyne %s na %d.", sendername, giveplayer, level);
					format(string, sizeof(string), "Twoja dru¿yna zosta³a zmieniona na %d przez %s", level, sendername);
					SendClientMessage(para1, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "Zmieni³eœ dru¿ynê graczowi %s na %d.", giveplayer,level);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:gotopos(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
		if(PlayerInfo[playerid][pAdmin] >= 5 || IsAScripter(playerid))
		{
		    new Float:x, Float:y, Float:z;
			if( sscanf(params, "fff", x,y,z))
			{
				sendTipMessage(playerid, "U¿yj /gotopos [x] [y] [z]");
				return 1;
			}

			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, x, y, z);
			}
			else
			{
				SetPlayerPosEx(playerid, x, y, z);
			}
			_MruAdmin(playerid, "Zosta³eœ teleportowany");
			//SetPlayerInterior(playerid,0);
			//PlayerInfo[playerid][pInt] = 0;
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}

CMD:gotols(playerid)
{
    if(IsPlayerConnected(playerid))
    {
		if(PlayerInfo[playerid][pAdmin] >= 5 || IsAScripter(playerid))
		{
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, 1529.6,-1691.2,13.3);
			}
			else
			{
				SetPlayerPosEx(playerid, 1529.6,-1691.2,13.3);
			}
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
			sendTipMessageEx(playerid, COLOR_GRAD1, "Zosta³eœ teleportowany !");
			SetPlayerInterior(playerid,0);
			PlayerInfo[playerid][pInt] = 0;
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}

CMD:gotoszpital(playerid)
{
    if(IsPlayerConnected(playerid))
    {
		if(PlayerInfo[playerid][pAdmin] >= 5 || IsAScripter(playerid))
		{
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, 1177.5322,-1323.6294,14.0753);
			}
			else
			{
				SetPlayerPosEx(playerid, 1177.5322,-1323.6294,14.0753);
			}
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
			sendTipMessageEx(playerid, COLOR_GRAD1, "Zosta³eœ teleportowany!");
			SetPlayerInterior(playerid,0);
			PlayerInfo[playerid][pInt] = 0;
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}

CMD:gotolv(playerid)
{
    if(IsPlayerConnected(playerid))
    {
		if (PlayerInfo[playerid][pAdmin] >= 5 || IsAScripter(playerid))
		{
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, 1699.2, 1435.1, 10.7);
			}
			else
			{
				SetPlayerPosEx(playerid, 1699.2,1435.1, 10.7);
			}
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
			sendTipMessageEx(playerid, COLOR_GRAD1, "Zosta³eœ teleportowany!");
			SetPlayerInterior(playerid,0);
			PlayerInfo[playerid][pInt] = 0;
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}

CMD:gotosf(playerid)
{
    if(IsPlayerConnected(playerid))
    {
		if (PlayerInfo[playerid][pAdmin] >= 5 || IsAScripter(playerid))
		{
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, -1417.0,-295.8,14.1);
			}
			else
			{
				SetPlayerPosEx(playerid, -1417.0,-295.8,14.1);
			}
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
			sendTipMessageEx(playerid, COLOR_GRAD1, "Zosta³eœ teleportowany!");
			SetPlayerInterior(playerid,0);
			PlayerInfo[playerid][pInt] = 0;
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}

CMD:gotosalon(playerid)
{
    if(IsPlayerConnected(playerid))
    {
		if (PlayerInfo[playerid][pAdmin] >= 5 || IsAScripter(playerid))
		{
            	SetPlayerInterior(playerid, 0);
    			SetPlayerVirtualWorld(playerid, 0);
				if (GetPlayerState(playerid) == 2)
				{
					SetVehiclePos(GetPlayerVehicleID(playerid), 2129.2078,-1129.9963,25.5823);
				}
				else
				{
					SetPlayerPosEx(playerid, 2129.2078,-1129.9963,25.5823);
				}
   				sendTipMessage(playerid, "[Teleportowa³eœ siê do salonu]");
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
    return 1;
}
CMD:entercar(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
		new testcar;
		if( sscanf(params, "d", testcar))
		{
			sendTipMessage(playerid, "U¿yj /entercar [carid]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 10 || IsAScripter(playerid))
		{
			PutPlayerInVehicleEx(playerid, testcar, 1);
			sendTipMessageEx(playerid, COLOR_GRAD1, "Zosta³eœ teleportowany!");
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:gotocar(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
		new testcar;
		if( sscanf(params, "d", testcar))
		{
			sendTipMessage(playerid, "U¿yj /gotocar [carid]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 1 || IsAKO(playerid) || IsAScripter(playerid))
		{
			new Float:cwx2,Float:cwy2,Float:cwz2;
			GetVehiclePos(testcar, cwx2, cwy2, cwz2);
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, cwx2, cwy2, cwz2);
			}
			else
			{
				SetPlayerPosEx(playerid, cwx2, cwy2, cwz2);
			}
			sendTipMessageEx(playerid, COLOR_GRAD1, "Zosta³eœ teleportowany!");
			SetPlayerInterior(playerid,0);
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}

CMD:mark(playerid)
{
    if(IsPlayerConnected(playerid))
    {
		if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
		{
			GetPlayerPos(playerid, TeleportDest[playerid][0],TeleportDest[playerid][1],TeleportDest[playerid][2]);
			sendTipMessageEx(playerid, COLOR_GRAD1, "Miejsce teleportu zmienione");
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:gotomark(playerid)
{
    if(IsPlayerConnected(playerid))
    {
		if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
		{
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, TeleportDest[playerid][0],TeleportDest[playerid][1],TeleportDest[playerid][2]);
			}
			else
			{
				SetPlayerPosEx(playerid, TeleportDest[playerid][0],TeleportDest[playerid][1],TeleportDest[playerid][2]);
			}
			sendTipMessageEx(playerid, COLOR_GRAD1, "Zosta³eœ teleportowany!");
			SetPlayerInterior(playerid,0);
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}

CMD:gotoin(playerid)
{
    if(IsPlayerConnected(playerid))
    {
		if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
		{
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, 1416.107000,0.268620,1000.926000);
			}
			else
			{
				SetPlayerPosEx(playerid, 1416.107000,0.268620,1000.926000);
			}
			sendTipMessageEx(playerid, COLOR_GRAD1, "Zosta³eœ teleportowany!");
			SetPlayerInterior(playerid,1);
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}

CMD:gotostad(playerid)
{
    if(IsPlayerConnected(playerid))
    {
		if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
		{
			SetPlayerPosEx(playerid, -1435.75, -652.664, 1054.94);
			SetPlayerInterior(playerid,4);
			sendTipMessageEx(playerid, COLOR_GRAD1, "Zosta³eœ teleportowany!");
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}

CMD:gotojet(playerid)
{
    if(IsPlayerConnected(playerid))
    {
		if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
		{
			SetPlayerPosEx(playerid, 1.71875, 30.4062, 1200.34);
			SetPlayerInterior(playerid,1);
			sendTipMessageEx(playerid, COLOR_GRAD1, "Zosta³eœ teleportowany!");
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:tp(playerid, params[])
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer01[MAX_PLAYER_NAME];
	new giveplayer02[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        new plo, plo1;
		if( sscanf(params, "k<fix>d", plo1, plo))
		{
			sendTipMessage(playerid, "U¿yj /tp [playerid/CzêœæNicku] [playerid/CzêœæNicku]");
			return 1;
		}
		new Float:plocx,Float:plocy,Float:plocz;

		if (IsPlayerConnected(plo) && IsPlayerConnected(plo1))
		{
		    if(plo != INVALID_PLAYER_ID && plo1 != INVALID_PLAYER_ID)
		    {
				GetPlayerName(playerid, sendername, sizeof(sendername));
				GetPlayerName(plo1, giveplayer01, sizeof(giveplayer01));
				GetPlayerName(plo, giveplayer02, sizeof(giveplayer02));
				
				if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || PlayerInfo[playerid][pZG]==10 || Uprawnienia(playerid, ACCESS_PANEL))
				{
					new bool:liczydelko=false;
					foreach(Player, i)
					{
						if(IsPlayerConnected(i))
						{
							if(PlayerInfo[i][pAdmin] >= 1 || (PlayerInfo[i][pNewAP] >= 1 && PlayerInfo[i][pNewAP] < 5))
							{
								liczydelko=true;
								break;
							}
						}
					}
					if(liczydelko==true && PlayerInfo[playerid][pZG]==10)
					{
						sendTipMessageEx(playerid, COLOR_GRAD1, "Na serwerze s¹ admini, nie mo¿esz u¿yæ tej komendy");
						return 1;
					}
					if(Spectate[playerid] != INVALID_PLAYER_ID)
					{
						Spectate[playerid] = INVALID_PLAYER_ID;
					}
					GetPlayerPos(plo, plocx, plocy, plocz);
					SetPlayerInterior(plo1, GetPlayerInterior(plo));
					SetPlayerVirtualWorld(plo1, GetPlayerVirtualWorld(plo));
					format(string, sizeof(string), "Zosta³eœ teleportowany do %s (ID: %d) przez Admina %s.", giveplayer02, plo, sendername);
					SendClientMessage(plo1, COLOR_GRAD1, string);
					format(string, sizeof(string), "Teleportowano tutaj %s (ID: %d) przez Admina %s.", giveplayer01, plo1, sendername);
					SendClientMessage(plo, COLOR_GRAD1, string);
					format(string, sizeof(string), "Teleportowano %s (ID: %d) do %s (ID: %d).", giveplayer01, plo1, giveplayer02, plo);
					SendClientMessage(playerid, COLOR_GRAD1, string);
					if(GetPlayerAdminDutyStatus(playerid) == 1)
					{
						iloscInne[playerid] = iloscInne[playerid]+1;
					}
					if(PlayerInfo[plo][pInt] > 0)
					{
						PlayerInfo[plo1][pInt] = PlayerInfo[plo][pInt];
						PlayerInfo[plo1][pLocal] = PlayerInfo[plo][pLocal];
					}
					if(plocz > 530.0 && PlayerInfo[plo][pInt] == 0) //the highest land point in sa = 526.8
					{
						//SetPlayerInterior(playerid,1);
						PlayerInfo[plo1][pInt] = 1;
					}
					if (GetPlayerState(plo1) == 2)
					{
						new tmpcar = GetPlayerVehicleID(plo1);
						SetVehiclePos(tmpcar, plocx, plocy+4, plocz);
					}
					else
					{
						SetPlayerPosEx(plo1,plocx,plocy+2, plocz);
					}
				}
				else
				{
					noAccessMessage(playerid);
				}
			}
		}
		else
		{
			format(string, sizeof(string), "%d lub %d nie jest aktywnym graczem.", plo, plo1);
			sendErrorMessage(playerid, string);
		}
	}
	return 1;
}

CMD:goto(playerid, params[])
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new plo;
		if( sscanf(params, "k<fix>", plo))
		{
			sendTipMessage(playerid, "U¿yj /goto [playerid/CzêœæNicku]");
			return 1;
		}
		new Float:plocx,Float:plocy,Float:plocz;

		if (IsPlayerConnected(plo))
		{
		    if(plo != INVALID_PLAYER_ID)
		    {
				GetPlayerName(playerid, sendername, sizeof(sendername));
				if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || PlayerInfo[playerid][pZG]==10 || Uprawnienia(playerid, ACCESS_PANEL) || IsAKO(playerid) || IsAScripter(playerid))
				{
					//SZUKANIE ADMINOW I P@ na serwerze

					new bool:liczydelko=false;
					foreach(Player, i)
					{
						if(IsPlayerConnected(i))
						{
							if(PlayerInfo[i][pAdmin] >= 1 || (PlayerInfo[i][pNewAP] >= 1 && PlayerInfo[i][pNewAP] < 5))
							{
								liczydelko=true;
								break;
							}
						}
					}
					//koniec szukania adminkow
					if(liczydelko==true && PlayerInfo[playerid][pZG]==10)
					{
						sendTipMessageEx(playerid, COLOR_GRAD1, "Na serwerze s¹ admini, nie mo¿esz u¿yæ tej komendy!");
						return 1;
					}
					if(Spectate[playerid] != INVALID_PLAYER_ID)
					{
						Spectate[playerid] = INVALID_PLAYER_ID;
					}
					GetPlayerPos(plo, plocx, plocy, plocz);
					SetPlayerInterior(playerid, GetPlayerInterior(plo));
					SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(plo));
					if(PlayerInfo[plo][pInt] > 0)
					{
						PlayerInfo[playerid][pInt] = PlayerInfo[plo][pInt];
						PlayerInfo[playerid][pLocal] = PlayerInfo[plo][pLocal];
					}
					if(plocz > 530.0 && PlayerInfo[plo][pInt] == 0) //the highest land point in sa = 526.8
					{
						//SetPlayerInterior(playerid,1);
						PlayerInfo[playerid][pInt] = 1;
					}
					if (GetPlayerState(playerid) == 2)
					{
						new tmpcar = GetPlayerVehicleID(playerid);
						SetVehiclePos(tmpcar, plocx, plocy+4, plocz);
					}
					else
					{
						SetPlayerPosEx(playerid,plocx,plocy+2, plocz);
					}
					_MruAdmin(playerid, "Zosta³eœ teleportowany!");
				}
				else
				{
					noAccessMessage(playerid);
				}
			}
		}
		else
		{
			format(string, sizeof(string), "%d nie jest aktywnym graczem.", plo);
			sendErrorMessage(playerid, string);
		}
	}
	return 1;
}

CMD:gotoint(playerid, params[])
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
		new plo;
		if( sscanf(params, "d", plo))
		{
			sendTipMessage(playerid, "U¿yj /gototint [nr inta]");
			return 1;
		}


		if(plo >= 1)
		{
		    if(plo <= 100)
		    {
				if (PlayerInfo[playerid][pAdmin] >= 20)
				{
					SetPlayerPosEx(playerid, IntInfo[plo][Int_X], IntInfo[plo][Int_Y], IntInfo[plo][Int_Z]);
					SetPlayerInterior(playerid, IntInfo[plo][Int]);
  					format(string, sizeof(string), "Dom %d, dane: Interior %d, Kategoria %d, Iloœæ pokoi %d", plo, IntInfo[plo][Int], IntInfo[plo][Kategoria], IntInfo[plo][Pokoje]);
	    			SendClientMessage(playerid, COLOR_GREY, string);
				}
				else
				{
					noAccessMessage(playerid);
				}
			}
		}
	}
	return 1;
}
CMD:gethere(playerid, params[])
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
		new plo;
		if( sscanf(params, "k<fix>", plo))
		{
			sendTipMessage(playerid, "U¿yj /gethere [playerid/CzêœæNicku]");
			return 1;
		}
		new Float:plocx,Float:plocy,Float:plocz;


		if (IsPlayerConnected(plo))
		{
		    if(plo != INVALID_PLAYER_ID)
		    {
				if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
				{
					GetPlayerPos(playerid, plocx, plocy, plocz);
					if(PlayerInfo[playerid][pInt] > 0)
					{
						SetPlayerInterior(plo,PlayerInfo[playerid][pInt]);
						PlayerInfo[plo][pInt] = PlayerInfo[playerid][pInt];
						PlayerInfo[plo][pLocal] = PlayerInfo[playerid][pLocal];
					}
					if(PlayerInfo[playerid][pInt] == 0)
					{
						SetPlayerInterior(plo,0);
					}
					if(plocz > 930.0 && PlayerInfo[playerid][pInt] == 0) //the highest land point in sa = 526.8
					{
						SetPlayerInterior(plo,1);
						PlayerInfo[plo][pInt] = 1;
					}
					if (GetPlayerState(plo) == 2)
					{
						new tmpcar = GetPlayerVehicleID(plo);
						SetVehiclePos(tmpcar, plocx, plocy+4, plocz);
					}
					else
					{
						SetPlayerPosEx(plo,plocx,plocy+2, plocz);
					}
                    SetPlayerInterior(plo, GetPlayerInterior(playerid));
					SetPlayerVirtualWorld(plo, GetPlayerVirtualWorld(playerid));
					sendTipMessageEx(plo, COLOR_GRAD1, "Zosta³eœ teleportowany");
					if(GetPlayerAdminDutyStatus(playerid) == 1)
					{
						iloscInne[playerid] = iloscInne[playerid]+1;
					}
				}
				else
				{
					noAccessMessage(playerid);
				}
			}
		}
		else
		{
			format(string, sizeof(string), "%d nie jest aktywnym graczem.", plo);
			sendErrorMessage(playerid, string);
		}
	}
	return 1;
}

CMD:getcar(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
		new plo;
		if( sscanf(params, "d", plo))
		{
			sendTipMessage(playerid, "U¿yj /getcar [carid]");
			return 1;
		}
		new Float:plocx,Float:plocy,Float:plocz;


		if (PlayerInfo[playerid][pAdmin] >= 1 || Uprawnienia(playerid, ACCESS_PANEL) || IsAKO(playerid) || IsAScripter(playerid))
		{
			GetPlayerPos(playerid, plocx, plocy, plocz);
			SetVehiclePos(plo,plocx,plocy+4, plocz);
            SetVehicleVirtualWorld(plo, GetPlayerVirtualWorld(playerid));
			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				iloscInne[playerid] = iloscInne[playerid]+1;
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "B³¹d!");
	}
	return 1;
}
CMD:fuelcar(playerid) return cmd_tankveh(playerid);
CMD:tankujauto(playerid) return cmd_tankveh(playerid);
CMD:tankveh(playerid)
{
    if(IsPlayerConnected(playerid))
    {
        if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_GREY, "»» Nie jesteœ w pojeŸdzie!");
        if(IsPlayerInAnyVehicle(playerid)) {
            new string[128];
            if (PlayerInfo[playerid][pAdmin] >= 5)
            {
				new vehicleid = GetPlayerVehicleID(playerid);
				new vuid = VehicleUID[vehicleid][vUID];
                Gas[vehicleid] = 100;
                format(string, sizeof(string), " »» Pojazd o ID (%d) zosta³ dotankowany", vehicleid);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string); 
				
				format(string, sizeof(string), "AdmCmd: %s zatankowa³ auto %s (%d)[%d].", GetNick(playerid), VehicleNames[GetVehicleModel(vehicleid)-400], vehicleid, vuid);
				SendPunishMessage(string, playerid);
				KickLog(string);
				if(GetPlayerAdminDutyStatus(playerid) == 1)
				{
					iloscInne[playerid] = iloscInne[playerid]+1;
				}
            }
            else
            {
                noAccessMessage(playerid);
            }
        }
    }
    return 1;
}

CMD:fuelcars(playerid) return cmd_tankujauta(playerid);
CMD:tankujauta(playerid)
{
    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pAdmin] >= 35)
        {
            for(new c=0;c<CAR_AMOUNT;c++)
			{
				Gas[c] = GasMax;
			}
			
			new string[64];
			format(string, sizeof(string), "AdmCmd: %s zatankowa³ wszystkie pojazdy.", GetNick(playerid));
			SendPunishMessage(string, playerid);
			KickLog(string);
			SendClientMessage(playerid, COLOR_GREY, "Wszystkie pojazdy zatankowane ! ");
			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				iloscInne[playerid] = iloscInne[playerid]+1;
			}
        }
        else
        {
            noAccessMessage(playerid);
            return 1;
        }
    }
    return 1;
}
CMD:givegun(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
		new playa, gun, ammo;
		new string[128];
		if( sscanf(params, "k<fix>dd", playa, gun, ammo))
		{
			sendTipMessage(playerid, "U¿yj /givegun [ID gracza] [Broñ] [Amunicja]");
			SendClientMessage(playerid, COLOR_GRAD4, "3(Club) 4(knife) 5(bat) 6(Shovel) 7(Cue) 8(Katana) 10-13(Dildo) 14(Flowers) 15(Grenades) 16(Tear) 17(Molotovs) 22(Pistol) 23(SPistol)");
			SendClientMessage(playerid, COLOR_GRAD3, "24(Eagle) 25(shotgun) 29(MP5) 30(AK47) 31(M4) 33(Rifle) 34(Sniper) 37(Flamethrower) 41(spray) 42(exting) 43(Camera) 46(Parachute)");
			return 1;
		}

		if(gun < 1||gun > 46)
		{ sendTipMessageEx(playerid, COLOR_GRAD1, "B³êdne ID broni!"); return 1; }

		if(ammo <1||ammo > 99999)
		{ sendTipMessageEx(playerid, COLOR_GRAD1, "Amunicja mo¿e byæ od 1 do 99999 !"); return 1; }
		if (PlayerInfo[playerid][pAdmin] >= 5000 )
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {
		            if(gun == 1)
		            {
		            	PlayerInfo[playa][pGun0] = gun;
		            	PlayerInfo[playa][pAmmo0] = ammo;
						GivePlayerWeapon(playa, gun, ammo);
						//logi broñ
						format(string, sizeof(string), "Admin %s dal bron (ID:[%d], AMMO:[%d]) graczowi %s.", GetNick(playerid), gun, ammo, GetNick(playa));
						WeapLog(string);
						SendCommandLogMessage(string);
					}
		            if(gun >= 2 && gun <= 9)
		            {
		            	PlayerInfo[playa][pGun1] = gun;
		            	PlayerInfo[playa][pAmmo1] = ammo;
						GivePlayerWeapon(playa, gun, ammo);
						format(string, sizeof(string), "Admin %s dal bron (ID:[%d], AMMO:[%d]) graczowi %s.", GetNick(playerid), gun, ammo, GetNick(playa));
						WeapLog(string);
						SendCommandLogMessage(string);
					}
					else if(gun >= 10 && gun <= 15)
					{
					    PlayerInfo[playa][pGun10] = gun;
		            	PlayerInfo[playa][pAmmo10] = ammo;
						GivePlayerWeapon(playa, gun, ammo);
						format(string, sizeof(string), "Admin %s dal bron (ID:[%d], AMMO:[%d]) graczowi %s.", GetNick(playerid), gun, ammo, GetNick(playa));
						WeapLog(string);
						SendCommandLogMessage(string);
					}
					else if(gun >= 16 && gun <= 18)
					{
					    PlayerInfo[playa][pGun8] = gun;
		            	PlayerInfo[playa][pAmmo8] = ammo;
						GivePlayerWeapon(playa, gun, ammo);
						format(string, sizeof(string), "Admin %s dal bron (ID:[%d], AMMO:[%d]) graczowi %s.", GetNick(playerid), gun, ammo, GetNick(playa));
						WeapLog(string);
						SendCommandLogMessage(string);
					}
					else if(gun >= 19 && gun <= 21)
					{
      					SendClientMessage(playerid, COLOR_GREY, "Na tym slocie nie ma broni !");
					}
					else if(gun >= 22 && gun <= 24)
					{
					    PlayerInfo[playa][pGun2] = gun;
		            	PlayerInfo[playa][pAmmo2] = ammo;
						GivePlayerWeapon(playa, gun, ammo);
						format(string, sizeof(string), "Admin %s dal bron (ID:[%d], AMMO:[%d]) graczowi %s.", GetNick(playerid), gun, ammo, GetNick(playa));
						WeapLog(string);
						SendCommandLogMessage(string);
					}
					else if(gun >= 25 && gun <= 27)
					{
					    PlayerInfo[playa][pGun3] = gun;
		            	PlayerInfo[playa][pAmmo3] = ammo;
						GivePlayerWeapon(playa, gun, ammo);
						format(string, sizeof(string), "Admin %s dal bron (ID:[%d], AMMO:[%d]) graczowi %s.", GetNick(playerid), gun, ammo, GetNick(playa));
						WeapLog(string);
						SendCommandLogMessage(string);
					}
					else if(gun == 28 || gun == 29 || gun == 32)
					{
					    PlayerInfo[playa][pGun4] = gun;
		            	PlayerInfo[playa][pAmmo4] = ammo;
						GivePlayerWeapon(playa, gun, ammo);
						format(string, sizeof(string), "Admin %s dal bron (ID:[%d], AMMO:[%d]) graczowi %s.", GetNick(playerid), gun, ammo, GetNick(playa));
						WeapLog(string);
						SendCommandLogMessage(string);
					}
					else if(gun == 30 || gun == 31)
					{
					    PlayerInfo[playa][pGun5] = gun;
		            	PlayerInfo[playa][pAmmo5] = ammo;
						GivePlayerWeapon(playa, gun, ammo);
						format(string, sizeof(string), "Admin %s dal bron (ID:[%d], AMMO:[%d]) graczowi %s.", GetNick(playerid), gun, ammo, GetNick(playa));
						WeapLog(string);
					}
					else if(gun == 33 || gun == 34)
					{
					    PlayerInfo[playa][pGun6] = gun;
		            	PlayerInfo[playa][pAmmo6] = ammo;
						GivePlayerWeapon(playa, gun, ammo);
						format(string, sizeof(string), "Admin %s dal bron (ID:[%d], AMMO:[%d]) graczowi %s.", GetNick(playerid), gun, ammo, GetNick(playa));
						WeapLog(string);
						SendCommandLogMessage(string);
					}
					else if( gun == 39)
					{
					    PlayerInfo[playa][pGun8] = gun;
		            	PlayerInfo[playa][pAmmo8] = ammo;
		            	PlayerInfo[playa][pGun12] = 1;
		            	PlayerInfo[playa][pAmmo12] = 1;
						GivePlayerWeapon(playa, gun, ammo);
						GivePlayerWeapon(playa, 40, 1);
						format(string, sizeof(string), "Admin %s dal bron (ID:[%d], AMMO:[%d]) graczowi %s.", GetNick(playerid), gun, ammo, GetNick(playa));
						WeapLog(string);
						SendCommandLogMessage(string);
					}
					else if( gun >= 35 || gun <= 38)
					{
					    PlayerInfo[playa][pGun7] = gun;
		            	PlayerInfo[playa][pAmmo7] = ammo;
						GivePlayerWeapon(playa, gun, ammo);
						format(string, sizeof(string), "Admin %s dal bron (ID:[%d], AMMO:[%d]) graczowi %s.", GetNick(playerid), gun, ammo, GetNick(playa));
						WeapLog(string);
						SendCommandLogMessage(string);
					}
					else if( gun >= 41 || gun <= 43)
					{
					    PlayerInfo[playa][pGun9] = gun;
		            	PlayerInfo[playa][pAmmo9] = ammo;
						GivePlayerWeapon(playa, gun, ammo);
						format(string, sizeof(string), "Admin %s dal bron (ID:[%d], AMMO:[%d]) graczowi %s.", GetNick(playerid), gun, ammo, GetNick(playa));
						WeapLog(string);
						SendCommandLogMessage(string);
					}
					else if( gun == 46)
					{
					    PlayerInfo[playa][pGun11] = gun;
		            	PlayerInfo[playa][pAmmo11] = ammo;
						GivePlayerWeapon(playa, gun, ammo);
						format(string, sizeof(string), "Admin %s dal bron (ID:[%d], AMMO:[%d]) graczowi %s.", GetNick(playerid), gun, ammo, GetNick(playa));
						WeapLog(string);
						SendCommandLogMessage(string);
					}
					else
					{
					    SendClientMessage(playerid, COLOR_GREY, "Broñ zablokowana lub nie istnieje !");
					    return 1;
					}
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:sethp(playerid, params[]) return cmd_zmienhp(playerid, params);
CMD:zmienhp(playerid, params[])
{
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new playa, health;
		if( sscanf(params, "k<fix>D(0)", playa, health))
		{
			sendTipMessage(playerid, "U¿yj /sethp [playerid/CzêœæNicku] [health]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 10 || PlayerInfo[playerid][pAdmin] == 7 || IsAScripter(playerid))
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {
					SetPlayerHealth(playa, health);
					if(IsPlayerInAnyVehicle(playerid))
					{
					    GetPlayerName(playa, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						printf("SETHP: AdmCmd: %s da³ %d hp %s", sendername, health,  giveplayer);
					    SetVehicleHealth(GetPlayerVehicleID(playa), health);
                        CarData[VehicleUID[GetPlayerVehicleID(playa)][vUID]][c_HP] = 1000.0;
						if(GetPlayerAdminDutyStatus(playerid) == 1)
						{
							iloscInne[playerid] = iloscInne[playerid]+1;
						}
					}
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}

CMD:setarmor(playerid, params[])
{
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new playa, health;
		if( sscanf(params, "k<fix>d", playa, health))
		{
			sendTipMessage(playerid, "U¿yj /setarmor [playerid/CzêœæNicku] [armor]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 5000 || IsAScripter(playerid))
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {
		            GetPlayerName(playa, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					new string[128];
					format(string, sizeof(string), "AdmCmd: %s da³ $d armora %s", sendername, health,  giveplayer);
					StatsLog(string);
					SetPlayerArmour(playa, health);
					if(GetPlayerAdminDutyStatus(playerid) == 1)
					{
						iloscInne[playerid] = iloscInne[playerid]+1;
					}
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:fixveh(playerid)
{
    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pAdmin] < 10 ||  PlayerInfo[playerid][pAdmin] == 7 || IsAScripter(playerid))
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				new vuid = VehicleUID[vehicleid][vUID];
				SetVehicleHealth(GetPlayerVehicleID(playerid), 1000.0);
				RepairVehicle(GetPlayerVehicleID(playerid));
				CarData[vuid][c_HP] = 1000.0;
				
				new string[128];
				format(string, sizeof(string), "AdmCmd: %s naprawi³ auto %s (%d)[%d].", GetNick(playerid), VehicleNames[GetVehicleModel(vehicleid)-400], vehicleid, vuid);
				SendPunishMessage(string, playerid);
				KickLog(string);
				if(GetPlayerAdminDutyStatus(playerid) == 1)
				{
					iloscInne[playerid] = iloscInne[playerid]+1;
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}

CMD:fixallveh(playerid)
{
    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pAdmin] < 1000)
        {
            noAccessMessage(playerid);
            return 1;
        }
        foreach(Player, i)
        {
            if(IsPlayerInAnyVehicle(playerid))
            {
                SetVehicleHealth(GetPlayerVehicleID(playerid), 1000.0);
                RepairVehicle(GetPlayerVehicleID(playerid));
                CarData[VehicleUID[GetPlayerVehicleID(playerid)][vUID]][c_HP] = 1000.0;
            }
        }
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			iloscInne[playerid] = iloscInne[playerid]+1;
		}
        new string[128];
        format(string, sizeof(string), "Admin %s naprawi³ wszystkim graczom pojazdy", GetNick(playerid, true));
        SendClientMessageToAll(COLOR_LIGHTBLUE, string);
		KickLog(string);
    }
    return 1;
}
CMD:weatherall(playerid, params[]) return cmd_pogodaall(playerid, params);
CMD:pogodaall(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || PlayerInfo[playerid][pZG] >= 7)
		{
			new weather;
			if( sscanf(params, "d", weather))
			{
			    sendTipMessage(playerid, "U¿yj: /pogodaall [pogodaid]");
			    return 1;
			}


			if(weather < 2||weather > 20) { sendTipMessageEx(playerid, COLOR_GREY, "Id pogody od 2 do 20 !"); return 1; }
			SetWeatherEx(weather);
			sendTipMessageEx(playerid, COLOR_GREY, "Pogoda zmieniona dla wszystkich !");
            new string[128];
            format(string, 128, "CMD_Info: /pogodaall u¿yte przez %s [%d]", GetNick(playerid), playerid);
            SendCommandLogMessage(string);
            CMDLog(string);
			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				iloscInne[playerid] = iloscInne[playerid]+1;
			}
			foreach(Player, i)//Je¿eli gracze s¹ w intkach 
			{
				if(GetPlayerVirtualWorld(i) != 0 || GetPlayerInterior(i) != 0)
				{
					SetInteriorTimeAndWeather(i);
				}
			}
		}
		else
		{
		    noAccessMessage(playerid);
		    return 1;
		}
	}
	return 1;
}
CMD:money(playerid, params[]) return cmd_kasa(playerid, params);
CMD:kasa(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
		new playa, money;
		if( sscanf(params, "k<fix>d", playa, money))
		{
			sendTipMessage(playerid, "U¿yj /kasa [playerid/CzêœæNicku] [money]");
			return 1;
		}

		if (IsAHeadAdmin(playerid))
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {
					ResetujKase(playa);
					PlayerInfo[playa][pCash] = 0;
					DajKase(playa, money);
					new string[128];
					format(string, sizeof(string), "%s dal %s: %d$ /money", GetNick(playerid), GetNick(playa), money);
					StatsLog(string);
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:givemoney(playerid, params[]) return cmd_dajkase(playerid, params);
CMD:dajkase(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
		new playa, money;
		if( sscanf(params, "k<fix>d", playa, money))
		{
			sendTipMessage(playerid, "U¿yj /dajkase [playerid/CzêœæNicku] [kasa]");
			return 1;
		}

		if (IsAHeadAdmin(playerid))
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {
					DajKase(playa, money);
					new string[128];
					format(string, sizeof(string), "%s dal %s: %d$ /givemoney", GetNick(playerid), GetNick(playa), money);
					StatsLog(string);
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:carslot(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new playa;
		if( sscanf(params, "k<fix>", playa))
		{
			sendTipMessage(playerid, "U¿yj /carslot [playerid/CzêœæNicku]");
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] >=1000)
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {
			        GetPlayerName(playa, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					PlayerInfo[playa][pCarSlots] = 4;
					printf("AdmCmd: %s nada³ sloty %s",sendername,  giveplayer);
					format(string, sizeof(string), "AdmCmd: %s nada³ sloty %s",sendername, giveplayer);
					ABroadCast(COLOR_LIGHTRED,string,1);
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:slap(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new playa;
		if( sscanf(params, "k<fix>", playa))
		{
			sendTipMessage(playerid, "U¿yj /slap [playerid/CzêœæNicku]");
			return 1;
		}

		new Float:shealth;
		new Float:slx, Float:sly, Float:slz;

		if (PlayerInfo[playerid][pAdmin] >=1 || PlayerInfo[playerid][pNewAP] >= 1 && PlayerInfo[playerid][pNewAP] <= 3 || PlayerInfo[playerid][pZG] >= 2
            || IsAScripter(playerid))
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {
			        GetPlayerName(playa, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					GetPlayerHealth(playa, shealth);
					SetPlayerHealth(playa, shealth-5);
					GetPlayerPos(playa, slx, sly, slz);
					SetPlayerPosEx(playa, slx, sly, slz+5);
					PlayerPlaySound(playa, 1130, slx, sly, slz+5);
					printf("AdmCmd: %s da³ klaspa w dupsko %s",sendername,  giveplayer);
					format(string, sizeof(string), "AdmCmd: %s da³ klapsa w dupsko %s",sendername, giveplayer);
					ABroadCast(COLOR_LIGHTRED,string,1);
					format(string, sizeof(string), "Dosta³eœ klapsa w dupsko od administratora %s, widocznie zrobi³eœ coœ z³ego :)", sendername);
					SendClientMessage(playa, COLOR_PANICRED, string);
					if(GetPlayerAdminDutyStatus(playerid) == 1)
					{
						iloscInne[playerid] = iloscInne[playerid]+1;
					}
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:mute(playerid, params[]) return cmd_ucisz(playerid, params);
CMD:unmute(playerid, params[]) return cmd_ucisz(playerid, params);
CMD:ucisz(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new playa;
		if( sscanf(params, "k<fix>", playa))
		{
			sendTipMessage(playerid, "U¿yj /ucisz [playerid/CzêœæNicku]");
			return 1;
		}


		if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 && PlayerInfo[playerid][pNewAP] <= 5)
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {
				    GetPlayerName(playa, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					if(PlayerInfo[playa][pMuted] == 0)
					{
						PlayerInfo[playa][pMuted] = 1;
						printf("AdmCmd: %s uciszyl %s",sendername,  giveplayer);
						format(string, sizeof(string), "AdmCmd: %s uciszyl %s",sendername, giveplayer);
						ABroadCast(COLOR_LIGHTRED,string,1);
						format(string, sizeof(string), "Zosta³eœ uciszony przez administratora %s, widocznie powiedzia³eœ coœ z³ego :)", sendername);
						SendClientMessage(playa, COLOR_PANICRED, string);
					}
					else
					{
						PlayerInfo[playa][pMuted] = 0;
						printf("AdmCmd: %s odciszy³ %s",sendername,  giveplayer);
						format(string, sizeof(string), "AdmCmd: %s odciszy³ %s",sendername, giveplayer);
						ABroadCast(COLOR_LIGHTRED,string,1);
						format(string, sizeof(string), "Zosta³eœ odciszony przez administratora %s, popraw siê :)", sendername);
						SendClientMessage(playa, COLOR_PANICRED, string);
					}
					if(GetPlayerAdminDutyStatus(playerid) == 1)
					{
						iloscInne[playerid] = iloscInne[playerid]+1;
					}
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:setplocal(playerid, params[])
{
	new giveplayerid, wartosc, string[128];
	if(IsPlayerConnected(playerid))
	{
		if(sscanf(params, "k<fix>d", giveplayerid, wartosc))
		{
			sendTipMessage(playerid, "U¿yj /setplocal [id] [wartosc]");
			return 1;
		}
		if(!IsPlayerConnected(giveplayerid))
		{
			sendTipMessage(playerid, "Nie ma takiego gracza"); 
			return 1;
		}
		if(!IsAScripter(playerid) || PlayerInfo[playerid][pAdmin] <= 200)
		{
			sendTipMessage(playerid, "Brak uprawnieñ"); 
			return 1;
		}
		format(string, sizeof(string), "PLocal gracza %s zosta³ zmieniony przez admina %s na %d", GetNick(giveplayerid), GetNick(playerid), wartosc);
		SendPunishMessage(string, giveplayerid);
		SetPLocal(giveplayerid, wartosc);
	}
	return 1;
}
CMD:glosowanie(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		new timeValue;
		new result[128];
		new string[256];
		if(sscanf(params, "ds[128]", timeValue, result))
		{
			sendTipMessage(playerid, "U¿yj /glosowanie [czas_trwania_w_minutach] [temat]");
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] >= 200 || IsAScripter(playerid))
		{
			if(strlen(result) > 120)
			{
				sendErrorMessage(playerid, "Za d³ugi temat"); 
				return 1;
			}
			if(glosowanie_admina_status == 1)
			{
				sendTipMessage(playerid, "Aktualnie trwa g³osowanie"); 
				return 1;
			}	
			//_____WYKONUJEMY KOD____
			
			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				iloscInne[playerid]++; 
			}
			format(string, sizeof(string), "Admin %s rozpocz¹³ ankietê na temat:{C0C0C0}%s", GetNick(playerid), result);
			SendClientMessageToAll(COLOR_RED, string);
			SendClientMessageToAll(COLOR_WHITE,  "Aby zag³osowaæ wpisz /glosuja");
			format(string, sizeof(string), "G³osowanie potrwa %d minut", timeValue); 
			SendClientMessageToAll(COLOR_WHITE, string);
			glosowanie_admina_status = 1;
			glosowanie_admina_tak = 0;
			glosowanie_admina_nie = 0;
			format(string, sizeof(string), "Zmienna po przeliczeniu to %d", (timeValue*60000));
			sendTipMessage(playerid, string); 
			SetTimer("glosuj_admin_ankieta", (timeValue*60000), false);
			foreach(Player, i)
			{
				SetPVarInt(i, "glosowal_w_ankiecie", 0);
			}
		}
		else
		{
			noAccessMessage(playerid);
			return 1;
		}
	}
	return 1;
}
CMD:freeze(playerid, params[]) return cmd_zamroz(playerid, params);
CMD:zamroz(playerid, params[])
{
	new string[128];
    if(IsPlayerConnected(playerid))
    {
		new playa;
		if( sscanf(params, "k<fix>", playa))
		{
			sendTipMessage(playerid, "U¿yj /freeze [playerid/CzêœæNicku]");
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || PlayerInfo[playerid][pZG] >= 7)
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {
					TogglePlayerControllable(playa, 0);
					format(string, sizeof(string), "AdmCmd: %s zamrozi³ %s", GetNick(playerid),  GetNick(playa));
					printf("%s",string);
					format(string, sizeof(string), "AdmCmd: %s zosta³ zamro¿ony przez %s", GetNick(playa), GetNick(playerid));
					ABroadCast(COLOR_LIGHTRED,string,1);
					if(GetPlayerAdminDutyStatus(playerid) == 1)
					{
						iloscInne[playerid] = iloscInne[playerid]+1;
					}
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}

CMD:unfreeze(playerid, params[]) return cmd_odmroz(playerid, params);
CMD:odmroz(playerid, params[])
{
	new string[128];
    if(IsPlayerConnected(playerid))
    {
		new playa;
		if( sscanf(params, "k<fix>", playa))
		{
			sendTipMessage(playerid, "U¿yj /unfreeze [playerid]");
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || PlayerInfo[playerid][pZG] >= 6)
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {
					TogglePlayerControllable(playa, 1);
					format(string, sizeof(string), "AdmCmd: %s odmrozi³ %s", GetNick(playerid),  GetNick(playa));
					printf("%s",string);
					format(string, sizeof(string), "AdmCmd: %s zosta³ odmro¿ony przez %s", GetNick(playa), GetNick(playerid));
					ABroadCast(COLOR_LIGHTRED,string,1);
					if(GetPlayerAdminDutyStatus(playerid) == 1)
					{
						iloscInne[playerid] = iloscInne[playerid]+1;
					}
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
CMD:warn(playerid, params[])
{
	new string[256];
    if(IsPlayerConnected(playerid))
    {
    	new giveplayerid, result[64];
		if( sscanf(params, "k<fix>s[64]", giveplayerid, result))
		{
			sendTipMessage(playerid, "U¿yj /warn [playerid/CzêœæNicku] [reason]");
			return 1;
		}
		if(giveplayerid == 65535)
		{
			if(sscanf(params, "ds[64]", giveplayerid, result)) 
			{
				sendTipMessageEx(playerid, COLOR_GRAD2, "Ten gracz ma zbugowane ID. Wpisz jego ID zamiast nicku aby go zbanowaæ.");
				return 1;
			}
		}

		if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1)
		{
            if(AntySpam[playerid] == 1)
		    {
		        sendTipMessageEx(playerid, COLOR_GREY, "Odczekaj 5 sekund");
		        return 1;
		    }
		    if(IsPlayerConnected(giveplayerid) || true)//bug z id
		    {
		        if(giveplayerid != INVALID_PLAYER_ID)
		        {
		            if(PlayerInfo[giveplayerid][pAdmin] >= 1)
		            {
		                sendTipMessageEx(playerid, COLOR_WHITE, "Nie mozesz zwarnowaæ Admina !");
		                return 1;
		            }
                    if(gPlayerLogged[giveplayerid] == 0)
                    {
                        sendTipMessageEx(playerid, COLOR_WHITE, " Gracz nie jest zalogowany, u¿yj kicka.");
						return 1;
                    }
					GiveWarnForPlayer(giveplayerid, playerid, result);
					if(kary_TXD_Status == 1)
					{
						if(PlayerInfo[giveplayerid][pWarns] >= 3)
						{
							format(string, sizeof(string), "%s (3 Warny)", result);
							BanPlayerTXD(giveplayerid, playerid, string); 
							return 1;
						}
						WarnPlayerTXD(giveplayerid, playerid, result);
						
					}
					else if(kary_TXD_Status == 0)
					{
						if(PlayerInfo[giveplayerid][pWarns] >= 3)
						{
							format(string, sizeof(string), "AdmCmd: %s zosta³ zbanowany przez admina %s, powód: %s (3 warny)", GetNick(giveplayerid), GetNick(playerid), result); 
						}
						else 
						{
							format(string, sizeof(string), "AdmCmd: %s zosta³ zwarnowany przez admina %s, powód: %s", GetNick(giveplayerid), GetNick(playerid), result);
						}
						SendPunishMessage(string, playerid); 
					}
				  
					return 1;
				}
			}//not connected
            else
            {
                format(string, sizeof(string), "Gracz o ID %d nie jest po³aczony.", giveplayerid);
			    sendErrorMessage(playerid, string);
            }
		}
        else {
            return noAccessMessage(playerid);
        }
		/*else
		{
			format(string, sizeof(string), "   Gracz o ID %d nie istnieje.", giveplayerid);
			SendClientMessage(playerid, COLOR_GRAD1, string);
		}*/
	}
	return 1;
} 


CMD:unwarn(playerid, params[])
{
	new string[256];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
    	new giveplayerid, result[64];
		if( sscanf(params, "k<fix>s[64]", giveplayerid, result))
		{
			sendTipMessage(playerid, "U¿yj /unwarn [playerid/CzêœæNicku] [reason]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 1 || Uprawnienia(playerid, ACCESS_PANEL))
		{
		    if(IsPlayerConnected(giveplayerid))
		    {
		        if(giveplayerid != INVALID_PLAYER_ID)
		        {
                    if(PlayerInfo[giveplayerid][pWarns] <= 0) return sendTipMessageEx(playerid, COLOR_GRAD1, "Ten gracz nie ma warnów!");
					new str[128];
				    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					PlayerInfo[giveplayerid][pWarns] -= 1;
					format(str, sizeof(str), "Da³eœ UN-warna %s, powód: %s", giveplayer, (result));
					SendClientMessage(playerid, COLOR_LIGHTRED, str);
					format(str, sizeof(str), "Dosta³eœ UN-warna od %s, powód: %s", sendername, (result));
					SendClientMessage(giveplayerid, COLOR_LIGHTRED, str);
					format(string, sizeof(string), "AdmCmd: %s zosta³ UN-warnowany przez Admina %s, powód: %s", giveplayer, sendername, (result));
					ABroadCast(COLOR_YELLOW,string,1);
					/*if(!IsPlayerAdmin(playerid))
					{
						SendClientMessage(playerid, COLOR_YELLOW, string);
					}*/
                    WarnLog(string);
					if(GetPlayerAdminDutyStatus(playerid) == 1)
					{
						iloscWarn[playerid] = iloscWarn[playerid]+1;
					}
					return 1;
				}
			}//not connected
		}
		else
		{
			format(string, sizeof(string), "Gracz o ID %d nie istnieje.", giveplayerid);
			sendErrorMessage(playerid, string);
		}
	}
	return 1;
}

CMD:skick(playerid, params[])
{
	new string[256];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
    	new giveplayerid;
		if( sscanf(params, "k<fix>", giveplayerid))
		{
			sendTipMessage(playerid, "U¿yj /skick [playerid/CzêœæNicku]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 5000 || PlayerInfo[playerid][pNewAP] == 4 || PlayerInfo[playerid][pAdmin] == 7)
		{
		    if(AntySpam[playerid] == 1)
		    {
		        sendTipMessageEx(playerid, COLOR_GREY, "Odczekaj 5 sekund");
		        return 1;
		    }
			if(IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
			        if(PlayerInfo[giveplayerid][pAdmin] >= 1 || PlayerInfo[giveplayerid][pNewAP] >= 1 || PlayerInfo[giveplayerid][pZG] >= 4)
		            {
		                sendTipMessageEx(playerid, COLOR_WHITE, "Nie mozesz zkickowaæ Admina !");
		                return 1;
		            }
			        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "AdmCmd: Admin %s was kicked by admin %s, Powód: CICHY kick", giveplayer, sendername);
					KickLog(string);
					KickEx(giveplayerid);
					SetTimerEx("AntySpamTimer",5000,0,"d",playerid);
					AntySpam[playerid] = 1;
			    }
			}
		}
		else
		{
			format(string, sizeof(string), "   Gracz o ID %d nie istnieje.", giveplayerid);
			sendErrorMessage(playerid, string);
		}
	}
	return 1;
}

CMD:sban(playerid, params[])
{
	new string[256];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
    	new giveplayerid, result[128];
		if( sscanf(params, "k<fix>s[128]", giveplayerid, result))
		{
			sendTipMessage(playerid, "U¿yj /sban [playerid/CzêœæNicku] [reason]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 5000 || PlayerInfo[playerid][pNewAP] == 4 || PlayerInfo[playerid][pAdmin] == 7)
		{
		    if(AntySpam[playerid] == 1)
		    {
		        sendTipMessageEx(playerid, COLOR_GREY, "Odczekaj 5 sekund");
		        return 1;
		    }
		    if(IsPlayerConnected(giveplayerid))
		    {
		        if(giveplayerid != INVALID_PLAYER_ID)
		        {
					if(PlayerInfo[giveplayerid][pAdmin] >= 1)
					{
						sendTipMessageEx(playerid, COLOR_WHITE, "Nie mozesz zabanowaæ Admina!");
						return 1;
					}
					
					format(string, sizeof(string), "AdmCmd: Ukryty (/sban) Admin %s zbanowal %s, powód: %s",  sendername, giveplayer, result);
					BanLog(string);
				    MruMySQL_Banuj(giveplayerid, result, playerid);
					KickEx(giveplayerid);
					SetTimerEx("AntySpamTimer",5000,0,"d",playerid);
					AntySpam[playerid] = 1;
					return 1;
				}
			}//not connected
		}
		else
		{
			format(string, sizeof(string), "   Gracz o ID %d nie istnieje.", giveplayerid);
			sendErrorMessage(playerid, string);
		}
	}
	return 1;
}

CMD:ban(playerid, params[])
{
	new string[256];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid)) 
    {
    	new giveplayerid, result[64];
		if( sscanf(params, "k<fix>s[64]", giveplayerid, result))
		{
			sendTipMessage(playerid, "U¿yj /ban [playerid/CzêœæNicku] [powód]");
			return 1;
		}
		
	    if(AntySpam[playerid] == 1)
	    {
	        sendTipMessageEx(playerid, COLOR_GREY, "Odczekaj 5 sekund");
	        return 1;
	    }
	    if(IsPlayerConnected(giveplayerid))//bug z id
	    {
	        if(giveplayerid != INVALID_PLAYER_ID)
	        {
	            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));
				new str[128];
	            if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pZG] >= 4 || IsAScripter(playerid))
	            {
					if(IsPlayerAdmin(giveplayerid) || Uprawnienia(giveplayerid, ACCESS_OWNER))
					{
						sendTipMessageEx(playerid, COLOR_WHITE, "Nie mozesz zabanowaæ Head Admina !");
						return 1;
					}
					if( (PlayerInfo[giveplayerid][pAdmin] >= 1 || PlayerInfo[giveplayerid][pNewAP] >= 1 || PlayerInfo[giveplayerid][pZG] >= 4) && PlayerInfo[playerid][pZG] >= 4)
					{
						sendTipMessageEx(playerid, COLOR_WHITE, "Nie mozesz zabanowaæ Admina, P@ i ZG!");
						return 1;
					}
					if(PlayerInfo[giveplayerid][pLevel] > 1 && PlayerInfo[playerid][pZG] >= 4 && PlayerInfo[playerid][pZG] < 6)
					{
						sendTipMessageEx(playerid, COLOR_WHITE, "Nie mozesz zabanowaæ gracza z levelem wiekszym niz 1!");
						return 1;
					}
					if(PlayerInfo[giveplayerid][pDonateRank] > 1 && PlayerInfo[playerid][pZG] >= 6)
					{
						sendTipMessageEx(playerid, COLOR_WHITE, "Nie mozesz zabanowaæ gracza z KP!");
						return 1;
					}
                    if(gPlayerLogged[giveplayerid] == 0)
                    {
                        sendTipMessageEx(playerid, COLOR_WHITE, " Gracz nie jest zalogowany, u¿yj kicka.");
						return 1;
                    }
					SendClientMessage(giveplayerid, COLOR_NEWS, "Jeœli uwa¿asz ze ban jest nies³uszny wejdŸ na www.Mrucznik-RP.pl i z³ó¿ prosbê o UN-BAN");
					format(string, sizeof(string), "AdmCmd: Admin %s zbanowal %s, powód: %s",  sendername, giveplayer, result);
					BanLog(string);
					if(kary_TXD_Status == 0)
					{
						format(string, sizeof(string), "AdmCmd: Admin %s zbanowa³ %s, powód: %s",  sendername, giveplayer, result);
						SendPunishMessage(string, giveplayerid);
					}
					if(kary_TXD_Status == 1)
					{
						BanPlayerTXD(giveplayerid, playerid, result);
					}
					//adminowe logi
			        format(str, sizeof(str), "Admini/%s.ini", sendername);
			        dini_IntSet(str, "Ilosc_Banow", dini_Int(str, "Ilosc_Banow")+1 );
					format(str,sizeof(str),"~y~Ban Info:~n~~r~Osoba zbanowana: ~w~%s~n~~r~Powod: ~w~%s~n~~r~Nalozyl: ~w~%s", giveplayer ,result, sendername);
					MruMySQL_Banuj(giveplayerid, result, playerid);
					KickEx(giveplayerid);
					if(PlayerInfo[giveplayerid][pAdmin] >= 1)
					{
					    MruMySQL_Banuj(playerid, result, giveplayerid);
						format(str, sizeof(str), "%s zostal zbanowany za zbanowanie admina /ban",sendername);
						BanLog(str);
					    KickEx(playerid);
						//adminduty
						if(GetPlayerAdminDutyStatus(playerid) == 1)
						{
							iloscBan[playerid] = iloscBan[playerid]+1;
							
						}
					}
					else
					{
					    SetTimerEx("AntySpamTimer",5000,0,"d",playerid);
					    AntySpam[playerid] = 1;
					}
					return 1;
			  	}
				else
				{
				    if(PlayerInfo[playerid][pNewAP] >= 1 && PlayerInfo[playerid][pNewAP] <= 3)
				    {
                        if(IsPlayerAdmin(giveplayerid) || Uprawnienia(giveplayerid, ACCESS_OWNER))
    					{
    						sendTipMessageEx(playerid, COLOR_WHITE, "Nie mozesz zabanowaæ Head Admina !");
    						return 1;
    					}
						if(PlayerInfo[giveplayerid][pAdmin] >= 1)
						{
							sendTipMessageEx(playerid, COLOR_WHITE, "Nie mozesz zabanowaæ Admina !");
							return 1;
						}
                        if(gPlayerLogged[giveplayerid] == 0)
                        {
                            sendTipMessageEx(playerid, COLOR_WHITE, " Gracz nie jest zalogowany, u¿yj kicka.");
							return 1;
                        }
						SendClientMessage(giveplayerid, COLOR_NEWS, "Jeœli uwa¿asz ze ban jest nies³uszny wejdŸ na www.Mrucznik-RP.pl i z³ó¿ prosbê o UN-BAN");
						format(string, sizeof(string), "AdmCmd: Pó³Admin %s zbanowa³ %s, powód: %s",  sendername, giveplayer, (result));
						BanLog(string);
                        SendPunishMessage(string, giveplayerid);
						format(str,sizeof(str),"~y~Ban Info:~n~~r~Osoba zbanowana: ~w~%s~n~~r~Powod: ~w~%s~n~~r~Nalozyl: ~w~%s", giveplayer ,(result), sendername);
						MruMySQL_Banuj(giveplayerid, result, playerid);
						KickEx(giveplayerid);
						return 1;
					}
					else
					{
					    noAccessMessage(playerid);
					}
				}
			}//not connected
		}
		else
		{
			format(string, sizeof(string), "   Gracz o ID %d nie istnieje.", giveplayerid);
			sendErrorMessage(playerid, string);
		}
	}
	return 1;
}

CMD:kick(playerid, params[])
{
	new string[256];

    if(IsPlayerConnected(playerid))
    {
    	new giveplayerid, result[128];
		if( sscanf(params, "k<fix>s[128]", giveplayerid, result))
		{
			sendTipMessage(playerid, "U¿yj /kick [playerid/CzêœæNicku] [reason]");
			return 1;
		}
		if(giveplayerid == 65535)
		{
			if(sscanf(params, "ds[64]", giveplayerid, result)) 
			{
				sendTipMessageEx(playerid, COLOR_GRAD2, "Ten gracz ma zbugowane ID. Wpisz jego ID zamiast nicku aby go zbanowaæ.");
				return 1;
			}
		}
		if(!IsPlayerConnected(giveplayerid))
		{
			sendErrorMessage(playerid, "B³êdne ID gracza!"); 
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || PlayerInfo[playerid][pZG] >= 1)
		{
		    if(AntySpam[playerid] == 1)
		    {
		        sendTipMessageEx(playerid, COLOR_GREY, "Odczekaj 5 sekund");
		        return 1;
		    }
			if(IsPlayerConnected(giveplayerid) || true)//bug z id
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
                    if(PlayerInfo[giveplayerid][pAdmin] >= 1) return sendTipMessageEx(playerid, COLOR_WHITE, "Nie mozesz zkickowaæ Admina !");
  					if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pZG] >= 2 || PlayerInfo[playerid][pNewAP] >= 1)
  					{
      					GiveKickForPlayer(giveplayerid, playerid, (result));
						if(kary_TXD_Status == 1)
						{
							KickPlayerTXD(giveplayerid, playerid, (result));
						}
						else if(kary_TXD_Status == 0)
						{
							format(string, sizeof(string), "Admin %s zkickowa³ %s. Powód: %s", GetNick(playerid), GetNick(giveplayerid), (result));
							SendPunishMessage(string, giveplayerid); 
						}
						return 1;
					}
				}
			}
		}
		else
		{
			format(string, sizeof(string), "Gracz o ID %d nie istnieje.", giveplayerid);
			sendErrorMessage(playerid, string);
		}
	}
	return 1;
}


CMD:banip(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
    	new var[32];
    	new powod[32];
    	if(sscanf(params, "s[32]s[32]", var, powod))
		{
			sendTipMessage(playerid, "U¿yj /banip [ip] [powod]");
			return 1;
		}
	    if(AntySpam[playerid] == 1)
	    {
	        sendTipMessageEx(playerid, COLOR_GREY, "Odczekaj 5 sekund");
	        return 1;
	    }
		new str[128];
	    if(PlayerInfo[playerid][pAdmin] >= 1)
        {
            if(strlen(var) < 7 || strlen(var) > 16)
            {
                sendErrorMessage(playerid, "Niepoprawna d³ugosc IP!");
                return 1;
            }
            new count, cpos;
            while((cpos = strfind(var, ".", false, cpos)) != -1)
            {
                count++;
                cpos++;
            }
            if(count != 3)
            {
                sendErrorMessage(playerid, "Niepoprawny adres IP (dots)!");
                return 1;
            }
            format(str, sizeof(str), "ADM: %s - zablokowal IP: %s powód: %s", GetNick(playerid), var, powod);
            SendCommandLogMessage(str);
            MruMySQL_BanujOffline("Brak", powod, playerid, var);
            format(str, sizeof(str), "ADM: %s - zablokowano IP: %s powód: %s", GetNick(playerid), var, powod);
            SendClientMessage(playerid, COLOR_LIGHTRED, str);
			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				iloscBan[playerid] = iloscBan[playerid]+1;
				
			}
            BanLog(str);
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}



//-----------------<[ Timery: ]>-------------------

forward StopDraw();
public StopDraw()
{
	TextDrawHideForAll(Kary); 
	KillTimer(karaTimer);
	return 1;
}

//end