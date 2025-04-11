//-----------------------------------------------<< Source >>------------------------------------------------//
//                                              sellkontrabanda                                              //
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
// Data utworzenia: 03.05.2024


//

//------------------<[ Implementacja: ]>-------------------
command_sellkontrabanda_Impl(playerid, giveplayerid, count, price)
{
	if(count <= 0) 
	{ 
		MruMessageFail(playerid, "Liczba paczek kontrabandy musi by� wi�ksza ni� 0."); 
		return 1; 
	}

	if(price <= 0) 
	{ 
		MruMessageFail(playerid, "Cena musi by� wi�ksza od zera."); 
		return 1; 
	}

	if(count > PlayerInfo[playerid][pContraband]) 
	{ 
		MruMessageFailF(playerid, "Masz przy sobie tylko %d paczek kontrabandy!", PlayerInfo[playerid][pContraband]); 
		return 1; 
	}

	if(!IsPlayerNear(playerid, giveplayerid))
	{
		MruMessageFail(playerid, "Ten gracz nie jest przy tobie.");
		return 1;
	}

	if(giveplayerid == playerid)
	{
		MruMessageFail(playerid, "Nie mo�esz sprzeda� kontrabandy samemu sobie!");
		return 1;
	}

	ContrabandOffer[giveplayerid] = playerid;
	ContrabandPrice[giveplayerid] = price;
	ContrabandCount[giveplayerid] = count;

	MruMessageGoodInfoF(playerid, "Oferujesz %s sprzeda� %d paczek kontrabandy za $%d.", GetNick(giveplayerid), count, price);
	MruMessageGoodInfoF(giveplayerid, "Przemytnik %s oferuje sprzeda� %d paczek kontrabandy za $%d, (wpisz /akceptuj kontrabande) aby kupi�.", GetNick(playerid), count, price);
    return 1;
}

command_akceptuj_kontrabande(playerid)
{
    if(ContrabandOffer[playerid] >= 999)
    {
        MruMessageFail(playerid, "Nikt nie oferowa� Ci sprzeda�y kontrabandy.");
        return 1;
    }

    if(ContrabandPrice[playerid] <= 0 || kaska[playerid] < ContrabandPrice[playerid])
    {
        MruMessageFailF(playerid, "Nie sta� ci�, potrzebujesz %d$ a masz tylko %d$.", ContrabandPrice[playerid], kaska[playerid]);
        return 1;
    }

    new giveplayerid = ContrabandOffer[playerid];
    new price = ContrabandPrice[playerid];
    new count = ContrabandCount[playerid];
    if(!IsPlayerConnected(giveplayerid))
    {
        MruMessageFail(playerid, "Gracz, kt�ry oferowa� Ci kontraband� wyszed� z gry.");
        return 1;
    }

	if(!IsPlayerNear(playerid, giveplayerid))
	{
		MruMessageFail(playerid, "Ten gracz nie jest przy tobie.");
		return 1;
	}

    MruMessageGoodInfoF(playerid, "Kupi�e� %d paczek kontrabandy za $%d od Przemytnika %s.", count, price, GetNick(giveplayerid));
    MruMessageGoodInfoF(giveplayerid, "%s kupi� od ciebie %d paczek kontrabandy, zarobi�e� $%d.", GetNick(playerid), count, price);

    Log(payLog, INFO, "%s kupil od %s paczke %d kontrabandy za %d$", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), count, price);

    ZabierzKase(playerid, price);
    GiveContraband(playerid, count);

    DajKase(giveplayerid, price);
    TakeContraband(giveplayerid, count);

    ContrabandOffer[playerid] = 999;
    ContrabandPrice[playerid] = 0;
    ContrabandCount[playerid] = 0;
    return 1;
}

//end