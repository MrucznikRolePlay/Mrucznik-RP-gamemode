//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                sprzedajneon                                               //
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
// Data utworzenia: 02.06.2020


//

//------------------<[ Implementacja: ]>-------------------
sprzedajneon_akceptuj(playerid)
{
    new giveplayerid = GetPVarInt(playerid, "neon-mechid");
    new uid = GetPVarInt(playerid, "neon-uid");
    new cost = GetPVarInt(playerid, "neon-cost");
    new commission = GetPVarInt(playerid, "neon-commission");
    new vuid = GetPVarInt(playerid, "neon-vuid");

    if(uid == 0)
    {
        sendErrorMessage(playerid, "Nikt nie oferowa³ Ci neonu.");
        return 1;
    }

    if(giveplayerid == INVALID_PLAYER_ID || !IsPlayerConnected(giveplayerid))
    {
        SendClientMessage(playerid, COLOR_GREY, "   Gracz, który oferowa³ Ci neon, wyszed³ z gry.");
        return 1;
    }

    if(uid != PlayerInfo[giveplayerid][pUID]) 
    {
        SendClientMessage(playerid, COLOR_GREY, "   Gracz, który oferowa³ Ci neon, wyszed³ z gry.");
        SetPVarInt(playerid, "neon-uid", 0);
        return 1;
    }

    if(!IsAtWarsztat(playerid)) 
    {
        sendErrorMessage(playerid, "Nie jesteœ w warsztacie, w którym mo¿na montowaæ tuning.");
        return 1;
    }

    if(!IsPlayerNear(playerid, giveplayerid))
    {
        sendErrorMessage(playerid, sprintf("Jesteœ zbyt daleko od gracza %s", GetNick(giveplayerid)));
        return 1;
    }

    new pojazd = GetPlayerVehicleID(playerid);
    if(pojazd == INVALID_VEHICLE_ID)
    {
        sendErrorMessage(playerid, "Nie znajdujesz siê w pojeŸdzie.");
        return 1;
    }

    if(!IsCarOwner(playerid, pojazd))
    {
        sendErrorMessage(playerid, "Ten pojazd nie nale¿y do Ciebie.");
        return 1;
    }

    if(vuid != VehicleUID[pojazd][vUID])
    {
        sendErrorMessage(playerid, "Nie jesteœ w pojeŸdzie dla którego oferowano Ci montowanie neonu.");
        return 1;
    }

    if(IsABoat(pojazd) || IsAPlane(pojazd) || IsABike(pojazd))
    {
        sendErrorMessage(playerid, "W helikoptrze/samolocie/³odzi/motorze nie mo¿na zamontowaæ neonów.");
        return  1;
    }
    new model = GetVehicleModel(pojazd);

    if(kaska[playerid] < cost)
    {
        sendErrorMessage(playerid, "Nie staæ Ciê na neon!");
        return 1;
    }

    //body
    SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("* Akceptowa³eœ kupno neonów, koszt %d$.", cost));
    SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, sprintf("* Gracz %s akceptowa³ kupno neonów, koszt %d$.", GetNick(playerid), cost));

    ZabierzKase(playerid, cost);
    DajKase(giveplayerid, commission);
    Log(payLog, INFO, "%s kupi³ od %s neony za $%d (prowizja $%d) w pojeŸdzie %s", 
        GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), cost, commission, GetVehicleLogName(pojazd)
    );

    IloscAut[playerid] = VehicleUID[pojazd][vUID];
    ChatMe(giveplayerid, sprintf("montuje neony w %s.", GetNick(playerid), VehicleNames[model-400]));
    if(IsPlayerPremiumOld(playerid))
    {
        ShowPlayerDialogEx(playerid, 1401, DIALOG_STYLE_LIST, "Wybierz kolor neonu", "{FFFFFF}Bia³y\n{DAA520}¯ó³ty\n{9ACD32}Zielony\n{0000FF}Niebieski\n{FF0000}Czerwony\n{C2A2DA}Ró¿owy", "Wybierz", "");
    }
    else
    {
        ShowPlayerDialogEx(playerid, 1401, DIALOG_STYLE_LIST, "Wybierz kolor neonu", "{FFFFFF}Bia³y", "Wybierz", "");
    }

    SetPVarInt(playerid, "neon-uid", 0);
    return 1;
}

command_sprzedajneon_Impl(playerid, giveplayerid, commission)
{
    if(!IsAMechazordWarsztatowy(playerid)) 
    {
        sendErrorMessage(playerid, "Nie jesteœ mechanikiem warsztatowym, nie mo¿esz sprzedawaæ neonów.");
        return 1;
    }

    if(!IsAtWarsztat(playerid)) 
    {
        sendErrorMessage(playerid, "Nie jesteœ w warsztacie, w którym mo¿na montowaæ tuning.");
        return 1;
    }

    if(!IsPlayerNear(playerid, giveplayerid))
    {
        sendErrorMessage(playerid, sprintf("Jesteœ zbyt daleko od gracza %s", GetNick(giveplayerid)));
        return 1;
    }
    
    new pojazd = GetPlayerVehicleID(giveplayerid);
    if(pojazd == INVALID_VEHICLE_ID)
    {
        sendErrorMessage(playerid, "Nie znajdujesz siê w pojeŸdzie.");
        return 1;
    }

    if(!IsCarOwner(giveplayerid, pojazd))
    {
        sendErrorMessage(playerid, "Ten pojazd nie nale¿y do tego gracza.");
        return 1;
    }

    if(IsABoat(pojazd) || IsAPlane(pojazd) || IsABike(pojazd))
    {
        sendErrorMessage(playerid, "W helikoptrze/samolocie/³odzi/motorze nie mo¿na zamontowaæ neonów.");
        return  1;
    }

    if(commission < 0) 
    {
        sendErrorMessage(playerid, "Prowizja musi byæ wiêksza ni¿ 0.");
        return 1;
    }

    new cost;
    if(CarData[VehicleUID[pojazd][vUID]][c_Neon] == 0)
    {
        cost = 3000000 + commission; // nie ma neonu
    }
    else
    {
        cost = 1000000 + commission; // ma neon
    }

    SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("* Oferujesz %s monta¿ neonu za $%d$ (prowizja %d$).", 
        GetNick(giveplayerid), cost, commission
    ));
    SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, sprintf("* %s oferuje monta¿ neonu za %d$.", GetNick(playerid), cost));
    SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, "* Wpisz /akceptuj neon aby siê zgodziæ.");


    SetPVarInt(giveplayerid, "neon-mechid", playerid);
    SetPVarInt(giveplayerid, "neon-uid", PlayerInfo[playerid][pUID]);
    SetPVarInt(giveplayerid, "neon-cost", cost);
    SetPVarInt(giveplayerid, "neon-commission", commission);
    SetPVarInt(giveplayerid, "neon-vuid", VehicleUID[pojazd][vUID]);
    return 1;
}

//end