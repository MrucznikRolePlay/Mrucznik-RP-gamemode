//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 tankowanie                                                //
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
// Data utworzenia: 01.04.2024


//

//------------------<[ Implementacja: ]>-------------------
command_tankowanie_Impl(playerid, giveplayerid, price)
{
	if(!IsAMechazordWarsztatowy(playerid) && PlayerInfo[playerid][pJob] != 7)
    {
        MruMessageFail(playerid, "Nie jesteœ mechanikiem lub pracownikiem warsztatu.");
        return 1;
    }

    if(GetDistanceBetweenPlayers(playerid, giveplayerid) > 8)
    {
        MruMessageFail(playerid, "Gracz jest za daleko.");
        return 1;
    }

    if(!IsPlayerInAnyVehicle(giveplayerid))
    {
        MruMessageFail(playerid, "Gracz nie jest w samochodzie.");
        return 1;
    }

    if(SpamujeMechanik[playerid] != 0)
    {
        MruMessageFail(playerid, "Poczekaj 10 sekund przed ponownym u¿yciem komendy.");
        return 1;
    }

    if(price < 300 || price > 2500) 
    {
        MruMessageFail(playerid, "Cena od 300$ do 2500$!"); 
        return 1;
    }

    // offer
    RefillOffer[giveplayerid] = playerid;
    RefillPrice[giveplayerid] = price;

    // message
    MruMessageGoodInfoF(playerid, "Oferujesz %s zatankowanie jego auta za $%d .", GetNick(giveplayerid), price);
    MruMessageGoodInfoF(giveplayerid, "Mechanik %s proponuje ci dotankowanie twojego auta za $%d, (wpisz /akceptuj tankowanie) aby akceptowaæ.", GetNick(playerid), price);

    // anty-spam
    SpamujeMechanik[playerid] = 1;
    SetTimerEx("AntySpamMechanik",10000,0,"d", playerid);
    return 1;
}

command_tankowanie_accept(playerid)
{
    if(RefillOffer[playerid] < 999)
    {
        if(IsPlayerConnected(RefillOffer[playerid]) && IsPlayerInAnyVehicle(playerid))
        {
            if(kaska[playerid] > RefillPrice[playerid] && RefillPrice[playerid] > 0)
            {
                new string[MAX_MESSAGE_LENGTH];
                new sendername[MAX_PLAYER_NAME];
                new giveplayer[MAX_PLAYER_NAME];
                GetPlayerName(RefillOffer[playerid], giveplayer, sizeof(giveplayer));
                GetPlayerName(playerid, sendername, sizeof(sendername));
                new fuel;
                new vehicleid = GetPlayerVehicleID(playerid);
                if(RefillOffer[playerid] != playerid)
                {
                    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
                    PlayerPlaySound(RefillOffer[playerid], 1085, 0.0, 0.0, 0.0);
                    PlayerInfo[RefillOffer[playerid]][pMechSkill] ++;
                    SendClientMessage(RefillOffer[playerid], COLOR_GREY, "Skill +1");
                    if(PlayerInfo[RefillOffer[playerid]][pMechSkill] == 50)
                    { SendClientMessage(RefillOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci Mechanika wynosz¹ 2, Mo¿esz teraz tankowaæ graczom wiêcej paliwa za jednym razem."); }
                    else if(PlayerInfo[RefillOffer[playerid]][pMechSkill] == 100)
                    { SendClientMessage(RefillOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci Mechanika wynosz¹ 3, Mo¿esz teraz tankowaæ graczom wiêcej paliwa za jednym razem."); }
                    else if(PlayerInfo[RefillOffer[playerid]][pMechSkill] == 200)
                    { SendClientMessage(RefillOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci Mechanika wynosz¹ 4, Mo¿esz teraz tankowaæ graczom wiêcej paliwa za jednym razem."); }
                    else if(PlayerInfo[RefillOffer[playerid]][pMechSkill] == 400)
                    { SendClientMessage(RefillOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci Mechanika wynosz¹ 5, Mo¿esz teraz tankowaæ graczom wiêcej paliwa za jednym razem."); }
                }
                new level = PlayerInfo[RefillOffer[playerid]][pMechSkill];
                if(level >= 0 && level <= 50)
                { fuel = 15; }
                else if(level >= 51 && level <= 100)
                { fuel = 40; }
                else if(level >= 101 && level <= 200)
                { fuel = 60; }
                else if(level >= 201 && level <= 400)
                { fuel = 80; }
                else if(level >= 401)
                { fuel = 100; }
                format(string, sizeof(string), "* Twój pojazd zosta³ dotankowany o %d% przez mechanika %s, koszt $%d.",fuel,giveplayer,RefillPrice[playerid]);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                format(string, sizeof(string), "* Zatankowa³eœ pojazd %s o %d% paliwa, doliczono ci $%d do wyp³aty.",sendername,fuel,RefillPrice[playerid]);
                SendClientMessage(RefillOffer[playerid], COLOR_LIGHTBLUE, string);
                format(string, sizeof(string),"* Mechanik %s wyci¹ga kanister i dotankowuje auto %s.",giveplayer,VehicleNames[GetVehicleModel(vehicleid)-400]);
                ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                format(string, sizeof(string), "* Bak nape³niony o %d jednostek paliwa (( %s ))", fuel, giveplayer);
                ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                ZabierzKase(playerid, RefillPrice[playerid]);
                DajKase(RefillOffer[playerid], RefillPrice[playerid]);
                if(Gas[vehicleid] < 110)
                {
                    Gas[vehicleid] += fuel;
                }
                RefillOffer[playerid] = 999;
                RefillPrice[playerid] = 0;
                return 1;
            }
            else
            {
                SendClientMessage(playerid, COLOR_GREY, "   Nie mo¿esz akceptowaæ tankowania !");
                return 1;
            }
        }
    }
    else
    {
        SendClientMessage(playerid, COLOR_GREY, "   Nikt nie oferowa³ ci tankowania !");
        return 1;
    }
    return 1;
}

//end