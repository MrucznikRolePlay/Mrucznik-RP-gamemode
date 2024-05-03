//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                    sila                                                   //
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
// Autor: Simeone
// Data utworzenia: 04.05.2019
//Opis:
/*
	System si³y to rewolucja na serwerze Mrucznik Role_Play. Dziêki sile mo¿emy realnie prze³o¿yæ akcje na postaæ.
	Przyk³adowo: Gracz X (200V) i policjant Y (25V) - policjant próbuje aresztowaæ gracza, gracz wyrywa siê bez wiêkszego problemu.
	RE: Ta sama sytuacja, z tym, ¿e policjant ma ju¿ 1/2 wartoœci si³y gracza - wtedy gracz ma zaledwie 25% na ucieczkê, które maleje z ka¿dym policjantem obok.
	Wnioski? Dziêki temu systemowi, gracze bêd¹ mieli realne szanse uciec z aresztowania i /przetrwaæ/, a dla PD bêdzie wyzwaniem z³apaæ 140 kilowego sku*wysyna.

	Przyk³ad drugi: Gracz X (350V) chce pobiæ gracza Y (50V) - dochodzi do pobicia bez wiêkszego oporu. Jednak, jeœli gracz Y ma o drobinê wiêksz¹ wartoœæ (ni¿ 1/7 gracza X), 
	wtedy system odpala mo¿liwoœæ /szansy/ i oblicza procentowo udzia³. 

	Si³ê mo¿emy zdobyæ poprzez 4 mo¿liwe sposoby (mo¿liwe, ¿e w przysz³oœci zwiêkszy siê ich liczba):
	>Admin mo¿e j¹ nadaæ komend¹ /setstrong
	>Biegaj¹c (skryptem do biegu)
	>Æwicz¹c na si³owni
	>P³ywaj¹c na basenie Tsunami

	Dodatkowo za¿ywanie narkotyków daje boosta (2x si³y) na okres 5 minut. Jednak, jeœli bêdziemy tego nadu¿ywaæ, skrypt odbierze nam -15V si³y :D 
*/

//

//-----------------<[ Callbacki: ]>-------------------
//-----------------<[ Funkcje: ]>-------------------
AddStrong(playerid, wartosc)
{
	if(PlayerInfo[playerid][pStrong]+wartosc <= MAX_STRONG_VALUE)
	{
		PlayerInfo[playerid][pStrong] = PlayerInfo[playerid][pStrong]+wartosc; 
		new tekststring[128];
		format(tekststring, sizeof(tekststring), "Sila +%d", wartosc);
		MSGBOX_Show(playerid, tekststring, MSGBOX_ICON_TYPE_EXPLODE, 3);
	}
	else
	{
		sendTipMessage(playerid, "Error: Nie uda³o siê zabraæ wartoœci Si³y - przekroczy 5k");
	}

	return 1;
}

stock TakeStrong(playerid, wartosc)
{
	if(PlayerInfo[playerid][pStrong] >= wartosc)
	{
		PlayerInfo[playerid][pStrong] = PlayerInfo[playerid][pStrong]-wartosc; 
		new tekststring[128];
		format(tekststring, sizeof(tekststring), "Sila -%d", wartosc);
		MSGBOX_Show(playerid, tekststring, MSGBOX_ICON_TYPE_EXPLODE, 3);
	}
	else
	{
		sendTipMessage(playerid, "Error: Nie uda³o siê zabraæ wartoœci Si³y");
	}

	return 1;
}

SetStrong(playerid, wartosc)
{
	if(wartosc <= MAX_STRONG_VALUE)
	{
		PlayerInfo[playerid][pStrong] = wartosc;
	}
	return 1;
}

EndRunPlayer(playerid, wartosc)
{

	DisablePlayerCheckpoint(playerid);

	sendTipMessage(playerid, "Gratulacje! Ukoñczy³eœ ca³y bieg.");
	
	SetPVarInt(playerid, "ZaliczylBaze", 0);
	SetPVarInt(playerid, "WybralBieg", 0);
	SetPVarInt(playerid, "RozpoczalBieg", 0);
	PlayerRunStat[playerid]++;
	new string[128];
	format(string, sizeof(string), "To twój %d bieg dziœ", PlayerRunStat[playerid]);
	sendTipMessage(playerid, string);
	AddStrong(playerid, wartosc);
	OszukujewBiegu[playerid] = 0;
	
	return 1;
}

GetPlayerStrong(playerid)
{
	new strongVal = PlayerInfo[playerid][pStrong];
	return strongVal; 
}

CreateNewRunCheckPoint(playerid, Float:x, Float:y, Float:z, Float:range, text[], strongValue, bool:strongadd=false, bool:sendTip=true)
{
	DisablePlayerCheckpoint(playerid);

	if(strlen(text) >= 2)
	{
		if(sendTip == true)
		{
			sendTipMessage(playerid, text);
		}
	}
	SetPlayerCheckpoint(playerid, x,y,z, range);
	bazaCheck[playerid] = SetTimerEx("BazaCheckPoint",5000,0,"d",playerid);
	bazaOszust[playerid] = SetTimerEx("BazaCheckOszust", 5000, 0, "d", playerid);
	OszukujewBiegu[playerid] = 1;
	if(strongadd == true)
	{
		AddStrong(playerid, strongValue);
	}

	return 1;
}

//-----------------<[ Timery: ]>-------------------
forward BazaCheckOszust(playerid);
public BazaCheckOszust(playerid)
{
	new timeSec[MAX_PLAYERS];
	timeSec[playerid]++;
	if(timeSec[playerid] == 2)
	{
		OszukujewBiegu[playerid] = 0;
		KillTimer(bazaOszust[playerid] );
	}
	return 1;
}

forward BazaCheckPoint(playerid);
public BazaCheckPoint(playerid)
{
	if(GetPVarInt(playerid, "ZaliczylBaze") == 0)
	{
		SetPVarInt(playerid, "ZaliczylBaze", 1);
		return KillTimer(bazaCheck[playerid]);
	}
	if(GetPVarInt(playerid, "ZaliczylBaze") == 1)
	{
		SetPVarInt(playerid, "ZaliczylBaze", 2);
		return KillTimer(bazaCheck[playerid]);
	}
	if(GetPVarInt(playerid, "ZaliczylBaze") == 2)
	{
		SetPVarInt(playerid, "ZaliczylBaze", 3);
		return KillTimer(bazaCheck[playerid]);
	}
	if(GetPVarInt(playerid, "ZaliczylBaze") == 3)
	{
		SetPVarInt(playerid, "ZaliczylBaze", 4);
		return KillTimer(bazaCheck[playerid]);
	}
	if(GetPVarInt(playerid, "ZaliczylBaze") == 4)
	{
		SetPVarInt(playerid, "ZaliczylBaze", 5);
		return KillTimer(bazaCheck[playerid]);
	}
	if(GetPVarInt(playerid, "ZaliczylBaze") == 5)
	{
		SetPVarInt(playerid, "ZaliczylBaze", 6);
		return KillTimer(bazaCheck[playerid]);
	}
	if(GetPVarInt(playerid, "ZaliczylBaze") == 6)
	{
		SetPVarInt(playerid, "ZaliczylBaze", 7);
	}
	KillTimer(bazaCheck[playerid]);

	return 1;
}

forward EfektNarkotyku(playerid);
public EfektNarkotyku(playerid)
{
	new FirstValue = GetPVarInt(playerid, "FirstValueStrong");
	efektNarkotykuMinuta[playerid]++; 
	if(efektNarkotykuMinuta[playerid] == TIME_OF_DRUG_ACTIVITY)
	{
		SetStrong(playerid, FirstValue);
		sendTipMessage(playerid, "Wartoœæ twojej si³y wróci³a do normy"); 
		KillTimer(TimerEfektNarkotyku[playerid]);
	}

	return 1;
}


//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end