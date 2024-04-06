//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   napraw                                                  //
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
command_napraw_Impl(playerid, giveplayerid, price)
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

    if(playerid == giveplayerid) 
    { 
        MruMessageFail(playerid, "Nie mo¿esz naprawiæ wozu samemu sobie!"); 
        return 1; 
    }

    if(price < 800 || price > 4000) 
    {
        MruMessageFail(playerid, "Cena od 800$ do 4000$!"); 
        return 1;
    }

    RepairOffer[giveplayerid] = playerid;
    RepairPrice[giveplayerid] = price;

    MruMessageGoodInfoF(playerid, "Oferujesz %s naprawê wozu za $%d .", GetNick(giveplayerid), price);
    MruMessageGoodInfoF(giveplayerid, "* Mechanik %s proponuje naprawê twojego wozu za $%d, (wpisz /akceptuj naprawe) aby akceptowaæ.", GetNick(playerid), price);
    
    SpamujeMechanik[playerid] = 1;
    SetTimerEx("AntySpamMechanik",10000,0,"d", playerid);
    return 1;
}

command_napraw_accept(playerid)
{
    if(RepairOffer[playerid] < 999)
    {
        if(kaska[playerid] > RepairPrice[playerid] && RepairPrice[playerid] > 0)
        {
            if(IsPlayerInAnyVehicle(playerid))
            {
                if(IsPlayerConnected(RepairOffer[playerid]))
                {
                    if(ProxDetectorS(10.5, playerid, RepairOffer[playerid]))
                    {
                        new string[MAX_MESSAGE_LENGTH];
                        new sendername[MAX_PLAYER_NAME];
                        new giveplayer[MAX_PLAYER_NAME];
                        GetPlayerName(RepairOffer[playerid], giveplayer, sizeof(giveplayer));
                        GetPlayerName(playerid, sendername, sizeof(sendername));
                        RepairCar[playerid] = GetPlayerVehicleID(playerid);
                        SetVehicleHealth(RepairCar[playerid], 1000.0);
                        RepairVehicle(RepairCar[playerid]);

                        CarData[VehicleUID[RepairCar[playerid]][vUID]][c_Tires] = 0;
                        CarData[VehicleUID[RepairCar[playerid]][vUID]][c_HP] = 1000.0;

                        PlayerPlaySound(RepairCar[playerid], 1140, 0.0, 0.0, 0.0);
                        PlayerPlaySound(playerid, 1140, 0.0, 0.0, 0.0);
                        format(string, sizeof(string), "* Twój samochód zosta³ naprawiony za $%d przez mechanika %s.",RepairPrice[playerid],giveplayer);
                        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                        format(string, sizeof(string), "* Naprawi³eœ pojazd %s, $%d zostanie dodane do twojej wyp³aty.",giveplayer,RepairPrice[playerid]);
                        SendClientMessage(RepairOffer[playerid], COLOR_LIGHTBLUE, string);
                        format(string, sizeof(string),"* Mechanik %s wyci¹ga narzêdzia oraz naprawia %s.",giveplayer,VehicleNames[GetVehicleModel(RepairCar[playerid])-400]);
                        ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                        format(string, sizeof(string), "* Silnik pojazdu znów dzia³a jak nale¿y (( %s ))", giveplayer);
                        ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                        PlayerInfo[RepairOffer[playerid]][pMechSkill] ++;
                        ZabierzKase(playerid, RepairPrice[playerid]);
                        DajKase(RepairOffer[playerid], RepairPrice[playerid]);
                        RepairOffer[playerid] = 999;
                        RepairPrice[playerid] = 0;
                    }
                    else
                    {
                        sendErrorMessage(playerid, "Mechanik musi byæ obok Ciebie!");
                        return 1;
                    }
                    return 1;
                }
                return 1;
            }
            return 1;
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nie staæ ciê na naprawe !");
            return 1;
        }
    }
    else
    {
        SendClientMessage(playerid, COLOR_GREY, "   Nikt nie oferowa³ ci naprawy !");
        return 1;
    }
}

//end