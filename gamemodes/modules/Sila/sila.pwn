//sila.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//------------------------------------------[ Modu³: sila.pwn ]---------------------------------------------//
//Opis:
/*
//Odnosi siê do komend: /wezdragi;
//Autor: Simeone
//Data: 26-02-2019
//Opis: 
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
stock AddStrong(playerid, wartosc)
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
stock SetStrong(playerid, wartosc)
{
	if(wartosc <= MAX_STRONG_VALUE)
	{
		PlayerInfo[playerid][pStrong] = wartosc;
	}
	return 1;
}
stock EndRunPlayer(playerid, wartosc)
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
stock GetPlayerStrong(playerid)
{
	new strongVal = PlayerInfo[playerid][pStrong];
	return strongVal; 
}
stock CreateNewRunCheckPoint(playerid, Float:x, Float:y, Float:z, Float:range, text[], strongValue, bool:strongadd=false, bool:sendTip=true)
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


//-----------------<[ Komendy: ]>-------------------
CMD:setstrong(playerid, params[])
{
	new valueStrong, giveplayerid;
	new string[128];
	if( sscanf(params, "k<fix>d", giveplayerid, valueStrong))
	{
		sendTipMessage(playerid, "U¿yj /setstrong [ID] [Wartoœæ] ");
		return 1;
	}
	if(valueStrong >= MAX_STRONG_VALUE)
	{
		format(string, sizeof(string), "Nie mo¿esz ustaliæ wartoœci wiêkszej jak %d", MAX_STRONG_VALUE);
		sendTipMessage(playerid, string); 
		return 1;
	}
	if(IsPlayerConnected(playerid) && IsPlayerConnected(giveplayerid))
	{
		if(PlayerInfo[giveplayerid][pStrong] != MAX_STRONG_VALUE)
		{
			if(PlayerInfo[playerid][pAdmin] >= 3500 || PlayerInfo[playerid][pNewAP] == 5)
			{
				format(string, sizeof(string), "Administrator %s ustali³ Ci wartoœæ si³y na %d [Poprzednia wartoœæ %d]", GetNick(playerid), valueStrong, PlayerInfo[giveplayerid][pStrong]);
				sendTipMessageEx(giveplayerid, COLOR_P@, string);
				format(string, sizeof(string), "Ustali³eœ wartoœæ si³y %s na %d - jego poprzednia wartoœæ to %d", GetNick(giveplayerid), valueStrong, PlayerInfo[giveplayerid][pStrong]); 
				sendTipMessageEx(playerid, COLOR_P@, string); 
				PlayerInfo[giveplayerid][pStrong] = valueStrong;
			}
			else
			{
				sendTipMessage(playerid, "Brak wystarczaj¹cych uprawnieñ"); 
				return 1;
			}
		}
		else
		{
			sendTipMessage(playerid, "Ten gracz ma ju¿ maksymaln¹ wartoœæ si³y!"); 
			return 1;
		}
	
	}
	else
	{
		sendTipMessage(playerid, "Gracz nie jest pod³¹czony"); 
	}
	return 1;
}
//=================> Zdobywanie punktów si³y poprzez bieg
CMD:trasybiegu(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(GetPVarInt(playerid, "RozpoczalBieg") == 1)
		{
			sendTipMessage(playerid, "Aktualnie jesteœ podczas biegu, ukoñcz go!"); 
			return 1;
		}
		ShowPlayerDialogEx(playerid, 1012, DIALOG_STYLE_TABLIST_HEADERS, "Mrucznik Role Play","Numer Trasy:\tMinimalny LVL:\tBieg doda:\n\
		Trasa [1]\t[0V_LVL]\t[+15V]\n\
		Trasa [2]\t[0V_LVL]\t[+20V]\n\
		Trasa [3]\t[100V_LVL]\t[+25V]\n\
		Trasa [4]\t[100V_LVL]\t[+25V]\n\
		Trasa [5]\t[400V_LVL]\t[+30V]",
		"ProwadŸ", "Odrzuæ");
	
		return 1;
	}
	return 1;
}
CMD:biegnij(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pAdmin] >= 2000)//chwilowa blokada
		{
			if(GetPlayerStrong(playerid) <= 980)
			{
				if(!IsPlayerInAnyVehicle(playerid))
				{
					if(GetPVarInt(playerid, "RozpoczalBieg") == 1)
					{
						sendErrorMessage(playerid, "Rozpocz¹³eœ ju¿ bieg! Najpierw go ukoñcz"); 
						return 1;
					}
					if(PlayerRunStat[playerid] == 3)
					{
						sendTipMessage(playerid, "Wykona³eœ dziœ 3 biegi! Mo¿e wystarczy?");
						return 1;
					}
					if(IsPlayerInRangeOfPoint(playerid, 10, 2005.9244,-1442.3917,13.5631))//Od szpitala Jeff do Placu
					{
						SetPVarInt(playerid, "ZaliczylBaze", 0);
						SetPVarInt(playerid, "WybralBieg", 1);
						SetPVarInt(playerid, "RozpoczalBieg", 1);
						if(GetPVarInt(playerid, "ZaliczylBaze") == 0)
						{
							SetPlayerCheckpoint(playerid, 1861.5981,-1453.0206,13.5625, 5);
							sendTipMessage(playerid, "Rozpoczynasz bieg, zdob¹dŸ pierwszy checkpoint!");
							sendTipMessageEx(playerid, COLOR_NEWS, "Cel: Plac Manewrowy Los Santos"); 
						}
					}
					else if(IsPlayerInRangeOfPoint(playerid, 10, 806.4952,-1334.9512,13.5469))//Od dworca Market do Pos¹gu ILOVELS
					{
						SetPVarInt(playerid, "ZaliczylBaze", 0);
						SetPVarInt(playerid, "WybralBieg", 2);
						SetPVarInt(playerid, "RozpoczalBieg", 1);
						if(GetPVarInt(playerid, "ZaliczylBaze") == 0)
						{
							sendTipMessage(playerid, "Rozpoczynasz bieg, zdob¹dŸ pierwszy checkpoint!");
							sendTipMessageEx(playerid, COLOR_NEWS, "Cel: Pos¹g I_LOVE_LS"); 
							SetPlayerCheckpoint(playerid, 645.5999,-1327.7279,13.5522, 3);
						}
					}
					else
					{
						sendTipMessage(playerid, "Nie jesteœ na jednym z mo¿liwych torów biegu"); 
						return 1;
					}
				}
				else
				{
					sendTipMessage(playerid, "Najpierw wyjdŸ z pojazdu"); 
				}
			}
			else
			{
				sendTipMessage(playerid, "Jesteœ ju¿ maksymalnie wysportowany! Bieg Ci nic nie da"); 
			}
		}
	}
	return 1;
}
CMD:stopbieg(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(GetPVarInt(playerid, "RozpoczalBieg") == 1)
		{
			SetPVarInt(playerid, "RozpoczalBieg", 0);
			SetPVarInt(playerid, "ZaliczylBaze", 0);
			DisablePlayerCheckpoint(playerid);
		}
		else
		{
			sendTipMessage(playerid, "Nie rozpocz¹³eœ biegu");
		}
	
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

//end