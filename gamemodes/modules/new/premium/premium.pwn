//premium.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//---------------------------------------[ Modu³: premium.pwn ]------------------------------------------//
//Opis:
/*

*/
//Adnotacje:
/*

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
premium_ConvertToNewSystem(playerid)
{
	
}

DajKP(playerid)
{
	PremiumInfo[playerid][pKP] = 1;
}

DajMC(playerid, mc)
{
	if(mc <= 0)
	{
		printf("ERROR: funkcja DajMC miala ujemna wartosc dla playerid: %s[%d] Wartosc: %d", GetNick(playerid), playerid, mc);
		return;
	}
	PremiumInfo[playerid][pMC] += mc;
}

ZabierzMC(playerid, mc)
{
	if(mc <= 0)
	{
		printf("ERROR: funkcja ZabierzMC miala ujemna wartosc dla playerid: %s[%d] Wartosc: %d", GetNick(playerid), playerid, mc);
		return;
	}
	PremiumInfo[playerid][pMC] -= mc;
}

KupKP(playerid)
{
	DajKP(playerid);
	ZabierzMC(playerid, MIESIAC_KP_CENA);
	SendClientMessage(playerid, COLOR_LIGHTGREEN, "Gratulacjê! Zakupi³eœ konto premium. Od teraz masz dostêp do mo¿liwoœci premium. Dziêkujemy za wspieranie serwera!"); 
}

KupPojazdPremium(playerid, id)
{
	if(!(id < MAX_PREMIUM_VEHICLES && id >= 0))
	{
		DialogPojazdyPremium(playerid);
		return;
	}
	if(PremiumInfo[playerid][pMC] < PojazdyPremium[id][Cena])
	{
		SendClientMessage(playerid, -1, "Nie staæ ciê na ten pojazd!");
		DialogPojazdyPremium(playerid);
		return;
	}

	new string[128];
	MRP_ShopPurchaseCar(playerid, PojazdyPremium[id][Model], PojazdyPremium[id][Cena]);
	format(string, sizeof(string), "%s kupil pojazd premium %s za %d Mrucznik Coins", GetNick(playerid), VehicleNames[PojazdyPremium[id][Model]-400], PojazdyPremium[id][Cena]);
	PremiumLog(string);
}

KupSkinPremium(playerid, skin)
{
	//TODO:
}


//---< Is >---
IsPlayerSposnor(playerid)
{
	if(PremiumInfo[playerid][pSponsor] == 1)
		return 1;
	return 0;
}

IsPlayerPremium(playerid)
{
	if(PremiumInfo[playerid][pKP] == 1)
		return 1;
	return 0;
}

IsAUnikat(modelid)
{
	for(new i; i<MAX_PREMIUM_VEHICLES; i++)
		if(modelid == PojazdyPremium[i][Model])
			return 1;
	return 0;
}

//-----------------<[ Komendy: ]>-------------------
CMD:kp(playerid, params[]) return cmd_premium(playerid, params);
CMD:dotacje(playerid, params[]) return cmd_premium(playerid, params);
CMD:premium(playerid, params[])
{
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "Ju¿ wkrótce!");
	return 1;

    if(IsPlayerConnected(playerid) && gPlayerLogged[playerid] != 0)
    {
        DialogMenuDotacje(playerid);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GREY, "B³¹d!");
    }
    return 1;
}

//----- Admin -----
CMD:setmc(playerid, params[]) return cmd_dajmc(playerid, params);
CMD:dajmc(playerid, params[])
{
	return 1;
	if(PlayerInfo[playerid][pAdmin] == 5000)
	{
		new giveplayerid, value;
		if( sscanf(params, "k<fix>d", giveplayerid, value))
		{
			sendTipMessage(playerid, "U¿yj /setmc [playerid/CzêœæNicku] [mrucznik coins]");
			return 1;
		}
		
		new string[256];
		format(string, sizeof(string), "AdmCmd: %s dal %s %d mrucznik coinsow.", GetNick(playerid), GetNick(giveplayerid), value);
		CKLog(string);
		PremiumInfo[giveplayerid][pMC] = value;
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "Nie jesteœ uprawniony do u¿ywania tej komendy");
	}
	return 1;
}

CMD:setkp(playerid, params[]) return cmd_dajmc(playerid, params);
CMD:dajkp(playerid, params[])
{
	return 1;
	if(PlayerInfo[playerid][pAdmin] == 5000)
	{
		new giveplayerid, value;
		if( sscanf(params, "k<fix>d", giveplayerid, value))
		{
			sendTipMessage(playerid, "U¿yj /setkp [playerid/CzêœæNicku] [mrucznik coins]");
			return 1;
		}
		
		new string[256];
		format(string, sizeof(string), "AdmCmd: %s dal KP %d graczowi %s mrucznik coinsow.", GetNick(playerid), value, GetNick(giveplayerid));
		CKLog(string);
		PremiumInfo[giveplayerid][pKP] = value;
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "Nie jesteœ uprawniony do u¿ywania tej komendy");
	}
	return 1;
}

//end