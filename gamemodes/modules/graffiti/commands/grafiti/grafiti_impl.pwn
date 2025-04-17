//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  grafiti                                                  //
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
// Autor: Sanda≥
// Data utworzenia: 02.02.2020


//

//------------------<[ Implementacja: ]>-------------------
command_grafiti_Impl(playerid, opcja[24])
{
    new frac = GetPlayerFraction(playerid);

    if(GetPlayerOrg(playerid) == 0) return sendTipMessageEx(playerid, COLOR_GRAD2, "Graffiti tylko dla gangÛw!");
    if(frac == 0 && !IsAPrzestepca(playerid)) return sendTipMessageEx(playerid, COLOR_GRAD2, "Graffiti tylko dla organizacji typu gang!");
    if(strcmp(opcja,"stworz",true) == 0)
    {
        graffiti_CountGraffs(playerid);
        if(Graffiti_Amount[playerid] >= 3)
        {
            sendTipMessage(playerid, "Wykorzystano limit graffiti(3).");
            return 1;
        }
        if(GetPVarInt(playerid, "zoneid") == -1 || (ZoneControl[GetPVarInt(playerid, "zoneid")] != frac && ZoneControl[GetPVarInt(playerid, "zoneid")]-100 != GetPlayerOrg(playerid)))
        {                
            sendTipMessageEx(playerid, -1, "Nie jestes na swojej strefie.");
            return 1;
        }
        if(GetPlayerVirtualWorld(playerid) != 0 || GetPlayerInterior(playerid) != 0) 
        {
            sendTipMessageEx(playerid, -1, "Musisz byÊ na zewnπrz.");
            return 1;
        }
        graffiti_ShowCreationDialog(playerid);
    }
    else if(strcmp(opcja,"usun",true) == 0)
    {
        new i = graffiti_FindNearest(playerid);
        if(i!=INVALID_GRAFID)
        {
            if(strcmp(GraffitiInfo[i][pOwner],GetNickEx(playerid),true) == 0 || PlayerInfo[playerid][pAdmin] >= GRAFFITI_ADMIN)
            {
                Log(serverLog, INFO, "%s usunπ≥ graffiti %s", GetPlayerLogName(playerid), GetGraffitiLogText(i));
                graffiti_DeleteMySQL(i);
                graffiti_Zeruj(i);
                GameTextForPlayer(playerid, "~r~Usunieto!",2000, 5);
            }
            else
            {
                sendTipMessage(playerid, "To nie jest twoje graffiti!");
            }
        }
        else
        {
            sendTipMessage(playerid, "Nie znaleziono graffiti w pobliøu. (podejdü bliøej)");
        }
    }
    else if(strcmp(opcja,"lista", true) == 0)
    {
        graffiti_ShowListDialog(playerid);
    }
    else if(strcmp(opcja,"edytuj", true) == 0)
    {
        new i = graffiti_FindNearest(playerid);
        if(i!=INVALID_GRAFID)
        {
            if(strcmp(GraffitiInfo[i][pOwner],GetNickEx(playerid),true) == 0)
            {
                graffiti_ShowEditTextDialog(playerid, i);
            }
            else
            {
                sendTipMessage(playerid, "Graffiti nie naleøy do ciebie.");
            }
        }
        else
        {
            sendTipMessage(playerid, "Nie znaleziono graffiti w pobliøu.");
        }
    }
    return 1;
}

//end