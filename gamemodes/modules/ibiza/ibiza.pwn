//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   ibiza                                                   //
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
// Autor: Sanda³
// Data utworzenia: 01.02.2020
//Opis:
/*
	Skrypt ibizy
*/

//
#include "ibiza_dialogs.pwn"
//-----------------<[ Funkcje: ]>-------------------
ibiza_clearCache(playerid)
{
	IbizaTicket[playerid] = 0;
}
stock IbizaStrobesOn(){
	ibizaStrobe1 = CreateDynamicObject(354, 431.875701, -1841.316772, -66.600242, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaStrobe2 = CreateDynamicObject(354, 431.875701, -1849.897216, -66.600242, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaStrobe3 = CreateDynamicObject(354, 431.875701, -1841.316772, -62.600242, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaStrobe4 = CreateDynamicObject(354, 431.875701, -1849.897216, -62.600242, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaStrobes = true;
	return 1;
}
stock IbizaStrobesOff(){
	DestroyDynamicObject(ibizaStrobe1);
	DestroyDynamicObject(ibizaStrobe2);
	DestroyDynamicObject(ibizaStrobe3);
	DestroyDynamicObject(ibizaStrobe4);
	ibizaStrobes = false;
	return 1;
}
stock IbizaNeonsOn(){
	ibizaNeon1 = CreateDynamicObject(18651, 424.107177, -1859.817871, -63.150581, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaNeon2 = CreateDynamicObject(18651, 410.256896, -1859.817871, -63.150581, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaNeon3 = CreateDynamicObject(18651, 410.256896, -1830.967895, -63.150581, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaNeon4 = CreateDynamicObject(18651, 424.107177, -1830.967895, -63.150581, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaNeon5 = CreateDynamicObject(18651, 402.966705, -1852.517333, -63.150581, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaNeon6 = CreateDynamicObject(18651, 402.966705, -1837.375976, -63.150581, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaNeon7 = CreateDynamicObject(18651, 411.296813, -1839.948120, -62.930603, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaNeon8 = CreateDynamicObject(18651, 414.346588, -1839.948120, -62.930603, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaNeon9 = CreateDynamicObject(18651, 412.876586, -1839.948120, -62.930603, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaNeon10 = CreateDynamicObject(18651, 417.356689, -1839.948120, -62.930603, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaNeon11 = CreateDynamicObject(18651, 419.336639, -1839.948120, -62.930603, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	ibizaNeons = true;
	return 1;
}
stock IbizaNeonsOff(){
	DestroyDynamicObject(ibizaNeon1);
	DestroyDynamicObject(ibizaNeon2);
	DestroyDynamicObject(ibizaNeon3);
	DestroyDynamicObject(ibizaNeon4);
	DestroyDynamicObject(ibizaNeon5);
	DestroyDynamicObject(ibizaNeon6);
	DestroyDynamicObject(ibizaNeon7);
	DestroyDynamicObject(ibizaNeon8);
	DestroyDynamicObject(ibizaNeon9);
	DestroyDynamicObject(ibizaNeon10);
	DestroyDynamicObject(ibizaNeon11);
	return 1;
}
stock IbizaSmokesOn(){
	ibizaSmoke1 = CreateDynamicObject(18727, 431.738006, -1843.064208, -65.366447, -90.599967, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaSmoke2 = CreateDynamicObject(18727, 431.738006, -1848.024169, -65.366447, -90.599967, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaSmokes = true;
	return 1;
}
stock IbizaSmokesOff(){
	DestroyDynamicObject(ibizaSmoke1);
	DestroyDynamicObject(ibizaSmoke2);
	ibizaSmokes = false;
	return 1;
}
stock IbizaLightsOn(){
	ibizaLight1 = CreateDynamicObject(19608, 433.696594, -1845.469360, -68.420249, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(ibizaLight1, 2, 10765, "airportgnd_sfse", "white", 0xFF202020);
	ibizaLight2 = CreateDynamicObject(14793, 427.333282, -1845.270874, -61.115303, 0.000000, 20.499998, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(ibizaLight2, 0, 16644, "a51_detailstuff", "roucghstonebrtb", 0x00000000);
	ibizaLight3 = CreateDynamicObject(14793, 418.892333, -1845.270874, -58.963237, 0.000000, 9.699994, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(ibizaLight3, 0, 16644, "a51_detailstuff", "roucghstonebrtb", 0x00000000);
	ibizaLight4 = CreateDynamicObject(14793, 412.500732, -1845.270874, -58.641696, 0.000000, 2.499991, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(ibizaLight4, 0, 16644, "a51_detailstuff", "roucghstonebrtb", 0x00000000);
	ibizaLight5 = CreateDynamicObject(14793, 409.309570, -1845.270874, -59.566371, 0.000000, -9.600010, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(ibizaLight5, 0, 16644, "a51_detailstuff", "roucghstonebrtb", 0x00000000);
	ibizaLights = true;
	return 1;
}
stock IbizaLightsOff(){
	DestroyDynamicObject(ibizaLight1);
	DestroyDynamicObject(ibizaLight2);
	DestroyDynamicObject(ibizaLight3);
	DestroyDynamicObject(ibizaLight4);
	DestroyDynamicObject(ibizaLight5);
	ibizaLights = false;
	return 1;
}
stock ibizaTextOneOff(){
	DestroyDynamicObject(ibizaTextOneText);
	return 1;
}
stock ibizaTextTwoOff(){
	DestroyDynamicObject(ibizaTextTwoText);
	return 1;
}
stock IbizaPanelCheck(){
	new txt_ibiza_strobes[128], txt_ibiza_neons[128], txt_ibiza_lights[128], txt_ibiza_smokes[128];
	new txt_ibiza_txtOne[128], txt_ibiza_txtTwo[128];
	new txt_ibiza_normalTicketCost[128], txt_ibiza_VIPTicketCost[128];
	if(ibizaStrobes == false){
		format(txt_ibiza_strobes, 128, "{FFFFFF}Stroboskopy: \t{FF0000}Wy³¹czone\n");
	}else{
		format(txt_ibiza_strobes, 128, "{FFFFFF}Stroboskopy: \t{00FF00}W³¹czone\n");
	}
	if(ibizaNeons == false){
		format(txt_ibiza_neons, 128, "{FFFFFF}Neony: \t{FF0000}Wy³¹czone\n");
	}else{
		format(txt_ibiza_neons, 128, "{FFFFFF}Neony: \t{00FF00}W³¹czone\n");
	}
	if(ibizaLights == false){
		format(txt_ibiza_lights, 128, "{FFFFFF}Oœwietlenie: \t{FF0000}Wy³¹czone\n");
	}else{
		format(txt_ibiza_lights, 128, "{FFFFFF}Oœwietlenie: \t{00FF00}W³¹czone\n");
	}
	if(ibizaSmokes == false){
		format(txt_ibiza_smokes, 128, "{FFFFFF}Dym: \t{FF0000}Wy³¹czone\n");
	}else{
		format(txt_ibiza_smokes, 128, "{FFFFFF}Dym: \t{00FF00}W³¹czone\n");
	}
	if(ibizaTextOne == false){
		format(txt_ibiza_txtOne, 128, "{FFFFFF}Tekst #1: \t{FF0000}Wy³¹czone\n");
	}else{
		format(txt_ibiza_txtOne, 128, "{FFFFFF}Tekst #1: \t{00FF00}W³¹czone\n");
	}
	if(ibizaTextTwo == false){
		format(txt_ibiza_txtTwo, 128, "{FFFFFF}Tekst #2: \t{FF0000}Wy³¹czone\n");
	}else{
		format(txt_ibiza_txtTwo, 128, "{FFFFFF}Tekst #2: \t{00FF00}W³¹czone\n");
	}
	format(txt_ibiza_normalTicketCost, 128, "{FFFFFF}Bilet normalny: \t{00FF00}%d \n", ibiza_priceNormal);
	format(txt_ibiza_VIPTicketCost, 128, "{FFFFFF}Bilet VIP: \t{00FF00}%d", ibiza_priceVIP);
	
	format(txt_ibiza_klub, 512, "%s %s %s %s %s %s %s %s", txt_ibiza_strobes, txt_ibiza_neons, txt_ibiza_lights, txt_ibiza_smokes, txt_ibiza_txtOne, txt_ibiza_txtTwo, txt_ibiza_normalTicketCost, txt_ibiza_VIPTicketCost);
	return 1;
}
stock IbizaTicketsCostCheck(){
	format(txt_ibiza_tickets, 128, "{FFFFFF}Rodzaj\tCena\nZwyk³y\t{00FF00}%d\n{FFFFFF}VIP\t{00FF00}%d", ibiza_priceNormal, ibiza_priceVIP);
	return 1;
}

stock IbizaNadajBilet(playerid, giveplayerid, bilet)
{
	new nazwa_biletu[24];
	new var[128];
	new Float:x, Float:y, Float:z;
	GetPlayerPos(giveplayerid, x, y, z);
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, x, y, z))
	{
		sendTipMessage(playerid, "Jesteœ za daleko.");
		return 1;
	}
	if(bilet == 1) nazwa_biletu = "NORMAL";
	if(bilet == 2) nazwa_biletu = "VIP";
	if(bilet == 3) nazwa_biletu = "SUPERVIP";
	format(var, sizeof(var), "Da³eœ bilet %s dla %s", nazwa_biletu, GetNick(giveplayerid));
    sendTipMessageEx(playerid, COLOR_LIGHTBLUE, var);
    format(var, sizeof(var), "Otrzyma³eœ bilet %s od %s", nazwa_biletu, GetNick(playerid));
    sendTipMessageEx(giveplayerid, COLOR_LIGHTBLUE, var);
    format(var, sizeof(var), "** %s podaje bilet Ibiza|[%s] %s.", GetNick(playerid), nazwa_biletu, GetNick(giveplayerid));
    ProxDetector(15.0, playerid, var, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    if(bilet == 1) IbizaTicket[giveplayerid] = IBIZA_NORMAL;
	if(bilet == 2) IbizaTicket[giveplayerid] = IBIZA_VIP;
	if(bilet == 3) IbizaTicket[giveplayerid] = IBIZA_SUPERVIP;
	return 1;
}


WylaczSwiatla()
{
	for(new i =0; i<MAX_PLAYERS; i++)
	{
		if(!IsPlayerConnected(i) || !GetPVarInt(i, "IbizaWejdz") || GetPVarInt(i, "IbizaKibel")) continue;
		SetPlayerWeather(i, 24);
		SetPlayerTime(i, 6, 0);
	}
	return 1;
}
IbizaOdswiezObiekty()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(!IsPlayerConnected(i) || !GetPVarInt(i, "IbizaWejdz") || GetPVarInt(i, "IbizaKibel")) continue;
		Streamer_Update(i);
	}
	return 1;
}
WylaczSwiatlaP(playerid)
{
	SetPlayerWeather(playerid, 24); //63
	SetPlayerTime(playerid, 6, 0);
	return 1;
}

WlaczSwiatlaP(playerid)
{
	SetPlayerWeather(playerid, 1);
	SetPlayerTime(playerid, 12, 0);
	return 1;
}

IbizaDrinkiPobierz()
{
	new string[128];
	for(new i=0; i<12; i++)
	{
		format(string, sizeof string, "SELECT cena FROM ibizadrinki WHERE id=%d", i);
		mysql_query(string);
		mysql_store_result();
		if(mysql_num_rows())
		{
			mysql_fetch_row_format(string, "|");
			sscanf(string, "d", IbizaDrinkiCeny[i]);
		}
		mysql_free_result();
	}
	return 1;
}

IbizaWyjscie(playerid)
{
	new h, m, s;
	gettime(h, m, s);
	SetPlayerWeather(playerid, 4);
	SetPlayerTime(playerid, h, m);
	return 1;
}



PlayerName(playerid)
{
	new string[MAX_PLAYER_NAME+1];
	GetPlayerName(playerid, string, MAX_PLAYER_NAME);
	return string;
}



MikserDialog(playerid)
{
	ShowPlayerDialogEx(playerid, DIALOG_IBIZA_MIKSER, DIALOG_STYLE_LIST, "Konsola DJa", "Stream\nTelebim\nŒwiat³a\nStroboskopy\nMaszynka do dymu\nRury", "Wybierz", "Wyjdz");
	return 1;
}

WlaczSwiatla()
{
	for(new i =0; i<MAX_PLAYERS; i++)
	{
		if(!IsPlayerConnected(i) || !GetPVarInt(i, "IbizaWejdz")) continue;
		SetPlayerWeather(i, 1);
		SetPlayerTime(i, 12, 0);
	}
	return 1;
}

IbizaUstawKamere(playerid, index)
{
	new dd,mm,rr, g,m,s, string[64];
	format(string, sizeof string, "CAM %02d", index+1);
	PlayerTextDrawSetString(playerid, PlayerText:GetPVarInt(playerid, "IbizaCam"), string);
	new Float:x, Float:y, Float:z;
	if(index == 7 || index == 6) SetPlayerPos(playerid, 1536.3556,-2562.2925,13.5469); //kible
	else if(index > 7) SetPlayerPos(playerid, 397.1197,-1810.7117, 7.8298); //dwór
	else //intex
	{
		x = GetPVarFloat(playerid, "IbizaKameraX");
		y = GetPVarFloat(playerid, "IbizaKameraY");
		z = GetPVarFloat(playerid, "IbizaKameraZ");
		SetPlayerPos(playerid, x, y, z);
	}
	GetDynamicObjectPos(IbizaKameryObiekty[index], x, y, z);
	SetPlayerCameraPos(playerid, x, y, z);
	SetPlayerCameraLookAt(playerid, IbizaKameryLA[index][0], IbizaKameryLA[index][1], IbizaKameryLA[index][2]);
	SetPlayerVirtualWorld(playerid, IbizaKameryVW[index]);
	Streamer_UpdateEx(playerid, x, y, z, IbizaKameryVW[index]);
	gettime(g,m,s); getdate(rr,mm,dd);
	format(string, sizeof string, "%02d/%02d/%d  %02d:%02d", dd, mm, rr, g,m);
	TextDrawSetString(TDIbiza[0], string);
	return 1;
}


WlaczStream(id)
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(!IsPlayerConnected(i) || !GetPVarInt(i, "IbizaWejdz") ) continue;
		PlayAudioStreamForPlayer(i, IbizaStream[id]);
	}
	return 1;
}



public Odmrozenie(playerid) //POWTÓRKA
{
	TogglePlayerControllable(playerid, true);
	return 1;
}


public FreezeVeh(vehicleid, ddriver, repeat)
{
	SetVehicleVelocity(vehicleid, 0, 0 ,0);
	
	if(repeat < 100) 
	{
		SetTimerEx("FreezeVeh", 50, false, "ddd", vehicleid, ddriver, repeat+1);
	}
	else
	{
		TogglePlayerControllable(ddriver, true);
	}
	return 1;
}

public TelebimAnim(ile)
{
	SetDynamicObjectMaterialText(Telebim[tID], 0 , Telebim[tTekstAnim],  Telebim[tSize], Telebim[tCzcionka], Telebim[tFSize], Telebim[tBold], Telebim[tCzcionkaKolor], Telebim[tBackg], Telebim[tAli]);
	if(ile)
	{
		strdel(Telebim[tTekstAnim], 0, 1);
		strins(Telebim[tTekstAnim], " ", strlen(Telebim[tTekstAnim])-1);
		SetTimerEx("TelebimAnim", Telebim[tSzybkosc], false, "d", ile-1);
	}	
	else
	{
		if(Telebim[tRuchomy])
		{
			new dl = strlen(Telebim[tTekst]);
			format(Telebim[tTekstAnim], sizeof Telebim[tTekstAnim], "");
			for(new i; i<28+(2*dl); i++)
			{
				format(Telebim[tTekstAnim], sizeof Telebim[tTekstAnim], "%s%s", Telebim[tTekstAnim], IBIZA_WYPELNIENIE);
			}
			format(Telebim[tTekstAnim], sizeof(Telebim[tTekstAnim]), "%s%s|", Telebim[tTekstAnim], Telebim[tTekst]);
			SetDynamicObjectMaterialText(Telebim[tID], 0 , Telebim[tTekstAnim],  Telebim[tSize], Telebim[tCzcionka], Telebim[tFSize], Telebim[tBold], Telebim[tCzcionkaKolor], Telebim[tBackg], Telebim[tAli]);
			Telebim[tRuchomy] = 1;
			Telebim[tWRuchu] = 1;
			SetTimerEx("TelebimAnim", Telebim[tSzybkosc], false, "d", strlen(Telebim[tTekstAnim]));
		}
		else
		{
			SetDynamicObjectMaterialText(Telebim[tID], 0 , Telebim[tTekst],  Telebim[tSize], Telebim[tCzcionka], Telebim[tFSize], Telebim[tBold], Telebim[tCzcionkaKolor], Telebim[tBackg], Telebim[tAli]);
			Telebim[tWRuchu] = 0;
		}
	}
	return 1;
}

IBIZA_Reszta()
{
    IbizaDrinkiPobierz();
	mysql_query("SELECT `hajs` FROM `ibiza` WHERE `id`=2");
	mysql_store_result();
	if(mysql_num_rows())
	{
		new bufor[64];
		mysql_fetch_row_format(bufor, "|");
		sscanf(bufor, "d", IbizaBilet);
	}
	mysql_free_result();
	//TEXTDRAWY

    TDIbiza[0] = TextDrawCreate(390.00000, 21.500000, "01/01/1999  21:21");
    TextDrawFont(TDIbiza[0], 2);
    TextDrawLetterSize(TDIbiza[0], 0.599999, 2.000000);
    TextDrawColor(TDIbiza[0], 0xFFFFFFFF);
    TextDrawSetOutline(TDIbiza[0], 1);

    TDIbiza[1] = TextDrawCreate(326.000000, 373.000000, "LD_BEAT:right");
    TextDrawFont(TDIbiza[1], 4);
	TextDrawTextSize(TDIbiza[1], 40.00, 40.00);
	TextDrawSetSelectable(TDIbiza[1], 1);

    TDIbiza[2] = TextDrawCreate(261.500000, 373.000000, "LD_BEAT:left");
    TextDrawFont(TDIbiza[2], 4);
	TextDrawTextSize(TDIbiza[2], 40.00, 40.00);
	TextDrawSetSelectable(TDIbiza[2], 1);

    	//OBIEKTY INTEK IBIZA
	IbizaKafle[0] = CreateDynamicObject(19128,1936.5900000,-2482.1700000,12.5084,0.0000000,0.0000000,0.0000000, 1, 0, -1); //Object number 473
	IbizaKafle[1] = CreateDynamicObject(19128,1953.6400000,-2482.1300000,12.5084,0.0000000,0.0000000,0.0000000, 1, 0, -1); //Object number 474
	IbizaKafle[2] = CreateDynamicObject(19128,1953.6500000,-2497.4700000,12.5084,0.0000000,0.0000000,0.0000000, 1, 0, -1); //Object number 475
	IbizaKafle[3] = CreateDynamicObject(19128,1936.6100000,-2497.4700000,12.5084,0.0000000,0.0000000,0.0000000, 1, 0, -1); //Object number 476
	IbizaRuryObiekty[0] = CreateDynamicObject(3503,1936.6000, -2482.1799, 11.0000,0.0000000,0.0000000,0.0000000, 1, 0, -1); //Object number 477
	IbizaRuryObiekty[1] = CreateDynamicObject(3503,1953.6300, -2482.1299, 11.0000,0.0000000,0.0000000,0.0000000, 1, 0, -1); //Object number 478
	IbizaRuryObiekty[2] = CreateDynamicObject(3503,1936.5900, -2497.4700, 11.0000,0.0000000,0.0000000,0.0000000, 1, 0, -1); //Object number 479
	IbizaRuryObiekty[3] = CreateDynamicObject(3503,1953.6500, -2497.4600, 11.0000,0.0000000,0.0000000,0.0000000, 1, 0, -1); //Object number 480
	IbizaBarierkiObiekty[0] = CreateDynamicObject(2773,1953.8400000,-2470.7100000,14.9000000,0.0000000,0.0000000,93.1800000, 1, 0, -1); //Object number 423
	IbizaBarierkiObiekty[1] = CreateDynamicObject(2773,1951.9300000,-2470.8200000,14.9000000,0.0000000,0.0000000,93.1800000, 1, 0, -1); //Object number 424
	IbizaBarierkiObiekty[2] = CreateDynamicObject(2773,1950.0100000,-2470.8700000,14.9000000,0.0000000,0.0000000,89.7000000, 1, 0, -1); //Object number 425
	IbizaPiasek[0] = CreateDynamicObject(19377,1939.8800000,-2485.0000000,12.5500000,0.0000000,90.0000000,0.0000000, 1, 0, -1);
	IbizaPiasek[1] = CreateDynamicObject(19377,1950.3800000,-2485.0000000,12.5500000,0.0000000,90.0000000,0.0000000, 1, 0, -1);
	IbizaPiasek[2] = CreateDynamicObject(19377,1939.8800000,-2494.6300000,12.5500000,0.0000000,90.0000000,0.0000000, 1, 0, -1);
	IbizaPiasek[3] = CreateDynamicObject(19377,1950.3800000,-2494.6300000,12.5500000,0.0000000,90.0000000,0.0000000, 1, 0, -1);
	IbizaKameryObiekty[0] = CreateDynamicObject(1616,1958.9700000,-2477.3400000,21.7100000,0.0000000,0.0000000,90.7200000, 1, 0, -1); //przy scenie, paczy na VIP
	IbizaKameryObiekty[1] = CreateDynamicObject(1616,1921.0300000,-2503.7500000,22.6100000,0.0000000,0.0000000,-97.3800000, 1, 0, -1); //nad VIPEm, paczy na parkiet
	IbizaKameryObiekty[2] = CreateDynamicObject(1616,1892.9300000,-2473.6900000,21.7100000,0.0000000,0.0000000,-197.8200000, 1, 0, -1); //paczy na wejscie i bar, po lewo od prezesa
	IbizaKameryObiekty[3] = CreateDynamicObject(1616,1892.9700000,-2493.0300000,20.7300000,0.0000000,0.0000000,-114.3000000, 1, 0, -1); //nad wejœciem paczy na prezesa
	IbizaKameryObiekty[4] = CreateDynamicObject(1616,1913.9400000,-2474.1600000,21.3700000,0.0000000,0.0000000,73.5000000, 1, 0, -1); //przy prezesie prawo
	IbizaKameryObiekty[5] = CreateDynamicObject(1616,1757.2200000,-2467.5000000,24.0100000,-15.7800000,-14.4000000,40.1400000, 1, 0, -1); //przedsionek
	IbizaKameryObiekty[6] = CreateDynamicObject(1616,1533.5800000,-2558.0900000,19.00000,0.0000000,0.0000000,-118.6800000, 1, 0, -1); //kibel
	IbizaKameryObiekty[7] = CreateDynamicObject(1616,1533.5800000,-2558.0900000,19.00000,0.0000000,0.0000000,-118.6800000, 2, 0, -1); //kibel
	IbizaKanciapaObiekt = CreateDynamicObject(19302, 1902.58, -2465.68, 19.12,   0.00, 0.00, 90.00, 1, 0, -1);

	//IBIZA OBIEKTY NA ZEWN¥TRZ
	IbizaKameryObiekty[8] = CreateDynamicObject(1616,386.9000000,-1808.9100000,12.9700000,0.0000000,0.0000000,20.0400000,0, 0, -1); //przy bramie
	IbizaKameryObiekty[9] = CreateDynamicObject(1616,389.5400000,-1805.8600000,12.9800000,0.0000000,0.0000000,-114.0600000,0, 0, -1); //nad wejœciem
	IbizaKameryObiekty[10] = CreateDynamicObject(1616,436.0300000,-1787.4700000,19.5600000,0.0000000,0.0000000,48.3000000,0, 0, -1); //palma bli¿sza na wejœcie
	IbizaKameryObiekty[11] = CreateDynamicObject(1616,308.5300000,-1816.9700000,10.0100000,0.0000000,0.0000000,-122.2800000,0, 0, -1); //z parkingu
	IbizaBramaObiekty[0] = CreateDynamicObject(2372,420.9000000,-1783.4000000,4.3100000,0.0000000,0.0000000,0.0000000,0, 0, -1);
	IbizaBramaObiekty[1] = CreateDynamicObject(2372,358.4000000,-1783.9000000,4.2000000,0.0000000,0.0000000,0.0000000,0, 0, -1);
}

//end