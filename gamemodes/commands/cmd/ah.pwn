//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ ah ]--------------------------------------------------//
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

YCMD:ah(playerid, params[], help)
{
	SendClientMessage(playerid, COLOR_GREEN,"_______________________________________");
    if(PlayerInfo[playerid][pNewAP] > 0 || PlayerInfo[playerid][pZG] > 0 || PlayerInfo[playerid][pAdmin] > 0 || IsAScripter(playerid))
	{
		SendClientMessage(playerid, COLOR_GRAD1, "* WSZYSCY *** /supportduty /tickets /login");
		SendClientMessage(playerid, COLOR_GRAD1, "{FF6A6A}* System @DUTY *** {C0C0C0}/adminduty {[NICK OOC] || /adminstats");
		
	}
	if (PlayerInfo[playerid][pNewAP] >= 1 && PlayerInfo[playerid][pNewAP] <= 3)
	{
		SendClientMessage(playerid, COLOR_GRAD1, "*1-2-3* PÓ£ADMIN *** /slap /aj /wybieralka /check /freeze /unfreeze /ucisz /kick");
        SendClientMessage(playerid, COLOR_GRAD1, "*1-2-3* PÓ£ADMIN *** /ban /goto /spec /respawn /a(dmin) chat /cmdinfo /czyjtonumer");
		SendClientMessage(playerid, COLOR_GRAD1, "*1-2-3* PÓ£ADMIN *** /zdejmijbpk /unbw /checkbw /paj /setvw /diagnoza");
    }
	if (PlayerInfo[playerid][pNewAP] == 4)
	{
		SendClientMessage(playerid, COLOR_GRAD1, "*4* PÓ£ADMIN *** /check /sban /sblock /goto /spec /a(dmin) chat");
		SendClientMessage(playerid, COLOR_GRAD1, "*4* PÓ£ADMIN *** /zdejmijbpk");
	}
    if (IsAScripter(playerid))
    {
        SendClientMessage(playerid, COLOR_GRAD1, "* SKRYPTER *** /respawn /(a) dmin chat /setint /getint /setvw /getvw");
        SendClientMessage(playerid, COLOR_GRAD1, "* SKRYPTER *** /goto /gotopos /gethere /respawnplayer");
        SendClientMessage(playerid, COLOR_GRAD1, "* SKRYPTER *** /mark /gotomark /gotocar /getcar /getposp");
        SendClientMessage(playerid, COLOR_GRAD1, "* SKRYPTER *** /gotols /gotoszpital /gotolv /gotosf /gotoin /gotostad /gotojet");
        SendClientMessage(playerid, COLOR_GRAD1, "* SKRYPTER *** /gotomechy /gotobank /gotostacja");
		SendClientMessage(playerid, COLOR_GRAD1, "* SKRYPTER *** /zdejmijbpk /dajdowozu /specshow /setdrunk");
    }
	if (PlayerInfo[playerid][pAdmin] >= 1)
	{
		SendClientMessage(playerid, COLOR_GRAD1, "*1* ADMIN *** /slap /kick /aj /bp /warn /block /ban /pblock /pban /pwarn /paj");
		SendClientMessage(playerid, COLOR_GRAD1, "*1* ADMIN *** /freeze /unfreeze /mute /kill /dpa /mark /gotomark");
		SendClientMessage(playerid, COLOR_GRAD1, "*1* ADMIN *** /setint /getint /setvw /getvw /wybieralka");
		SendClientMessage(playerid, COLOR_GRAD1, "*1* ADMIN *** /mordinfo /gotomechy /podglad /gotocar /ip");
		SendClientMessage(playerid, COLOR_GRAD1, "*1* ADMIN *** /check /pojazdygracza /sb /pokazcb");
		SendClientMessage(playerid, COLOR_GRAD1, "*1* ADMIN *** /respawn /carjump /goto /up /getcar /gethere");
		SendClientMessage(playerid, COLOR_GRAD1, "*1* ADMIN *** /cnn /cc /spec /unblock /unwarn /forum /pogoda /pogodaall");
        SendClientMessage(playerid, COLOR_GRAD1, "*1* ADMIN *** /usunopis [ID] /czity /respawnplayer /respawncar /unbw /cmdinfo");
        SendClientMessage(playerid, COLOR_GRAD1, "*1* ADMIN *** /setcarint /naprawskin /czyjtonumer /checkbw /diagnoza");
		SendClientMessage(playerid, COLOR_GRAD1, "*1* ADMIN *** /zdejmijbpk /dajdowozu /tod /agraffiti /banip /uid");
	}
	if (PlayerInfo[playerid][pAdmin] >= 5)
	{
		SendClientMessage(playerid, COLOR_GRAD4,"*5* ADMIN *** /zawodnik /dajkm /zuzel_start /zuzel_stop /rapidfly /fuelcar");
		SendClientMessage(playerid, COLOR_GRAD4,"*5* ADMIN *** /getposp /gotopos  /gotols /gotoszpital /gotolv /gotosf /gotoin /gotostad /gotojet");
        SendClientMessage(playerid, COLOR_GRAD4, "*5* ADMIN *** /gotobank /gotostacja /bw /agraffiti");
		SendClientMessage(playerid, COLOR_GRAD4,"*5* ADMIN *** /cca /ann /nonewbie /checkdom /anulujzp");
	}
	if (PlayerInfo[playerid][pAdmin] == 7)
	{
		SendClientMessage(playerid, COLOR_GRAD1, "*4* ZAS£U¯ONY *** /sban /sblock /skick /fixveh /sethp");
	}
	if (PlayerInfo[playerid][pAdmin] >= 10)
	{
		SendClientMessage(playerid, COLOR_GRAD4,"*10* ADMIN *** /fdaj /ksam /rozwiedz /setteam /entercar /sethp /setcarhp");
	}
	if (PlayerInfo[playerid][pAdmin] >= 15)
	{
		SendClientMessage(playerid, COLOR_GRAD4,"*15* ADMIN *** /jump /sn /dn /fly");
	}
	if (PlayerInfo[playerid][pAdmin] >= 20)
	{
		SendClientMessage(playerid, COLOR_GRAD4,"*20* ADMIN *** /noooc /demorgan /jail /gotoint");
	}
	if (PlayerInfo[playerid][pAdmin] >= 25)
	{
		SendClientMessage(playerid, COLOR_GRAD4,"*25* ADMIN *** /flip /snn /unaj /setfamily /forceskin /skydive");
	}
	if (PlayerInfo[playerid][pAdmin] >= 35)
	{
		SendClientMessage(playerid, COLOR_GRAD4,"*35* ADMIN *** /undemorgan /fuelcars /setchamp /logout /setdrunk");
	}
	if (PlayerInfo[playerid][pAdmin] >= 100)
	{
		SendClientMessage(playerid, COLOR_GRAD4,"*100* ADMIN *** /reloadbans /dajdzwiek /checkteam /bw /dajapteczke");
		SendClientMessage(playerid, COLOR_GRAD4,"*100* ADMIN *** /dskill /dsus /setwl /zaraz /uleczall /logoutpl");
	}
	if (PlayerInfo[playerid][pAdmin] >= 150)
	{
		SendClientMessage(playerid, COLOR_GRAD4,"*150* ADMIN *** /clearwlall");
	}
	if (PlayerInfo[playerid][pAdmin] >= 200)
	{
		SendClientMessage(playerid, COLOR_GRAD4,"*200* ADMIN *** /mole {FF0000}/scena /scenaallow /scenadisallow");
	}
	if (PlayerInfo[playerid][pAdmin] >= 1000)
	{
		SendClientMessage(playerid, COLOR_GRAD5,"*** 1000 *** /weather /weatherall /makeadmin /makeleader /tod /savemission /loadmission /startlotto");
		SendClientMessage(playerid, COLOR_GRAD5,"*** 1000 *** /barierka /usunbarier /wydaj /cela /sprzedaja /setarmor");
		SendClientMessage(playerid, COLOR_GRAD5,"*** 1000 *** /unfrakcja /makeircadmin /makemember /unmember /giverank /checkcars");
		SendClientMessage(playerid, COLOR_GRAD1, "{FF6A6A}* System @DUTY *** {C0C0C0}/checkadminstats [ID]");
	}
	if (PlayerInfo[playerid][pAdmin] >= 2000)
	{
		SendClientMessage(playerid, COLOR_GRAD5,"*** 2000 *** /hpall /killall /startlotto /skick /setcar");
	}
	if (PlayerInfo[playerid][pAdmin] >= 5000)
	{
		SendClientMessage(playerid, COLOR_GRAD6,"*** 5000 *** /sblock /sban /dodajweryfikacje /dajlicencje /givegun /cnnn");
		SendClientMessage(playerid, COLOR_GRAD6,"*** 5000 *** /KickEx_all /bdaj /starttimer /startalltimer /killtimer /killalltimer /zniszczobiekty /stworzobiekty");
		SendClientMessage(playerid, COLOR_GRAD6,"*** 5000 *** /setmats /setskin /setjob /setdom /setdomk /setwiek /setname /setstat /money /givemoney");
		SendClientMessage(playerid, COLOR_GRAD6,"*** 5000 *** /zrobdom /lzrobdom /usundom /blokujdom /resetsejfhasla /zapiszdomy /zapiszkonta");
		SendClientMessage(playerid, COLOR_GRAD6,"*** 5000 *** /rodzinalider /scena /houseowner /domint /dajskryptera /bw");
	}
	if (IsAHeadAdmin(playerid) || IsAScripter(playerid))
	{
		SendClientMessage(playerid, COLOR_WHITE,"*** Jesteœ koxem przez X ***");
        SendClientMessage(playerid, COLOR_GRAD6,"*** 5000 *** /zonedelay /gangzone /removezoneprotect /removeganglimit /clearzone /setzonecontrol");
		SendClientMessage(playerid, COLOR_GRAD6,"*** 5000 *** /agraffiti /adajrange /antybh /dajlicencje /glosowanie /gotodom");
		SendClientMessage(playerid, COLOR_GRAD6,"*** 5000 *** /makeleader /makemember /msgbox /restart /setac /setarmor /setserverpass");
		SendClientMessage(playerid, COLOR_GRAD6,"*** 5000 *** /showkary /startskinevent(!) /stworzobiekty /unfrakcja /wczytajskrypt /wlsett");
		SendClientMessage(playerid, COLOR_GRAD6,"*** 5000 *** /zmiendom /zmienprace /zniszczobiekt /setvregistration /zmienwiek /dnobiekt");
	}
    if(Uprawnienia(playerid, ACCESS_PANEL)) SendClientMessage(playerid, COLOR_GRAD1, "*** UPRAWNIENIA *** /stworz /edytuj /panel [unwarn]");
    if(Uprawnienia(playerid, ACCESS_ZG)) SendClientMessage(playerid, COLOR_GRAD1, "*** UPRAWNIENIA *** /dajzaufanego");
	if(Uprawnienia(playerid, ACCESS_MAKELEADER)) SendClientMessage(playerid, COLOR_GRAD1, "*** UPRAWNIENIA *** /makeleader /dajlideraorg /makewomanleader");
    if(Uprawnienia(playerid, ACCESS_MAKEFAMILY)) SendClientMessage(playerid, COLOR_GRAD1, "*** UPRAWNIENIA *** /edytuj /stworz /zabierzlideraorg");
	SendClientMessage(playerid, COLOR_GREEN,"_______________________________________");
	return 1;
}


