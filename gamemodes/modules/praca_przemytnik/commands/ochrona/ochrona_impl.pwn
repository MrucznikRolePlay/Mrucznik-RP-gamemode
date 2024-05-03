//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  ochrona                                                  //
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
// Data utworzenia: 06.04.2024


//

//------------------<[ Implementacja: ]>-------------------
command_ochrona_Impl(playerid, giveplayerid, price)
{
    if(GetPlayerJob(playerid) != JOB_SMUGGLER)
    {
		MruMessageFail(playerid, "Nie jesteœ przemytnikiem.");
		return 1;
    }

    if(!ProxDetectorS(8.0, playerid, giveplayerid))
    {
        MruMessageFail(playerid, "Ten gracz nie jest przy tobie.");
        return 1;
    }

    if(GetContraband(playerid) < 1)
    {
        MruMessageFail(playerid, "Potrzebujesz 1 paczki kontrabandy by zaoferowaæ komuœ pancerz.");
        return 1;
    }

    if(gettime() < GetPVarInt(playerid, "armoryTimeLimit"))
    {
        MruMessageFail(playerid, "Mo¿esz oferowaæ pancerz co 45 sekundy");
        return 1;
    }

    if(giveplayerid == playerid)
    {
        if(gettime() < GetPVarInt(playerid, "selfArmorLimit")) 
        {
            MruMessageFail(playerid, "Mo¿esz oferowaæ pancerz samemu sobie co 15 minut.");
            return 1;
        }

        SetPVarInt(playerid, "selfArmorLimit", gettime() + 900);
        SetPlayerArmour(playerid, 100);
        TakeContraband(playerid, 1);

        MruMessageGoodInfo(playerid, "Da³eœ sobie pancerz.");
        return 1;
    }

	if(price < 0 || price > 50000) 
    { 
        MruMessageFail(playerid, "Cena od 0 do 50000!");
        return 1;
    }
    
    MruMessageGoodInfoF(playerid, "Oferujesz pancerz %s za $%d.", GetNick(giveplayerid), price);
    MruMessageGoodInfoF(giveplayerid, "Przemtynik %s oferuje ci pancerz za $%d, (wpisz /akceptuj ochrona) aby akceptowaæ", GetNick(playerid), price);
    
    GuardOffer[giveplayerid] = playerid;
    GuardPrice[giveplayerid] = price;

    SetPVarInt(playerid, "armoryTimeLimit", gettime() + 45);
    return 1;
}

command_akceptuj_pancerz(playerid)
{
    if(IsPlayerConnected(GuardOffer[playerid]))
    {
        return 1;
    }

    if(GuardOffer[playerid] >= 999)
    {
        MruMessageFail(playerid, "Nikt nie zaoferowa³ ci pancerza.");
        return 1;
    }

    if(GuardPrice[playerid] < 0 || kaska[playerid] < GuardPrice[playerid])
    {
        MruMessageFailF(playerid, "Nie staæ ciê, potrzebujesz %d$.", GuardPrice[playerid]);
        return 1;
    }

    MruMessageGoodInfoF(playerid, "Akceptowa³eœ pancerz, zap³aci³eœ $%d przemytnikowi %s.",GuardPrice[playerid],GetNick(GuardOffer[playerid]));
    MruMessageGoodInfoF(GuardOffer[playerid], "%s akceptowa³ pancerz, $%d zostanie doliczone do twojej wyp³aty.",GetNick(playerid),GuardPrice[playerid]);

    DajKase(GuardOffer[playerid], GuardPrice[playerid]);
    TakeContraband(GuardOffer[playerid], 1);

    ZabierzKase(playerid, GuardPrice[playerid]);
    SetPlayerArmour(playerid, 100);

    Log(payLog, INFO, "%s kupi³ pancerz od %s za $%d", GetPlayerLogName(playerid), GetPlayerLogName(GuardOffer[playerid]), GuardPrice[playerid]);
    GuardOffer[playerid] = 999;
    GuardPrice[playerid] = 0;
    return 1;
}

//end