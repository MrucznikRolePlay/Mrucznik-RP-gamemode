//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   ulecz                                                   //
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
// Autor: Mrucznik
// Data utworzenia: 07.02.2020


//

//------------------<[ Implementacja: ]>-------------------
command_ulecz_Impl(playerid, giveplayerid)
{
    if(!IsAMedyk(playerid))
    {
        sendErrorMessage(playerid, "Nie jesteœ medykiem !");
        return 1;
    }

    if (giveplayerid == playerid)
    {
        sendTipMessageEx(playerid, COLOR_GRAD1, "Nie mo¿esz uleczyæ samego siebie!");
        return 1;
    }
    
    new giveambu = GetPlayerVehicleID(giveplayerid);
    new playambu = GetPlayerVehicleID(playerid);
    if ( !(IsAnAmbulance(playambu) && playambu == giveambu) && !IsAtHealingPlace(playerid) )
    {
        sendErrorMessage(playerid, "Nie jesteœ w pojeŸdzie medycznym / Chopper / szpitalu !");
        return 1;
    }

    new Float:hp;
    GetPlayerHealth(giveplayerid, hp);
    if(hp >= 100.0)
    {
        sendTipMessageEx(playerid, TEAM_GREEN_COLOR, "Ta osoba nie potrzebuje leczenia.");
        return 1;
    }

    //body
    GameTextForPlayer(playerid, sprintf("~y~Uleczyles ~n~~w~%s", GetNick(giveplayerid)), 5000, 1);
    if(PlayerInfo[playerid][pPainPerk] > 0)
    {
        hp = 100 + 20 * PlayerInfo[playerid][pPainPerk];
    }
    else
    {
        hp = 100;
    }
    SetPlayerHealth(giveplayerid, hp);
    PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
    PlayerPlaySound(giveplayerid, 1150, 0.0, 0.0, 0.0);
    sendTipMessageEx(giveplayerid, TEAM_GREEN_COLOR, sprintf("Zosta³eœ uleczony przez medyka %s.", GetNick(playerid)));
    return 1;
}

//end