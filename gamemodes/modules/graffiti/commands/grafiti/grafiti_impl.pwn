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
// Autor: Sanda³
// Data utworzenia: 02.02.2020


//

//------------------<[ Implementacja: ]>-------------------
command_grafiti_Impl(playerid, opcja[24])
{
    new frac = GetPlayerFraction(playerid);
    if(FRAC_GROOVE <= frac <= FRAC_VAGOS || frac == FRAC_WPS || GetPlayerOrgType(playerid) == ORG_TYPE_GANG)
    {
        if(strcmp(opcja,"stworz",true) == 0)
        {
            graffiti_CountGraffs(playerid);
            if(Graffiti_Amount[playerid] >= 3)
            {
                sendTipMessage(playerid, "Wykorzystano limit graffiti(3).");
                return 1;
            }
            if(GetPVarInt(playerid, "zoneid") == -1) 
            {
                sendTipMessageEx(playerid, -1, "Nie jestes na strefie.");
                return 1;
            }
            if(GetPlayerVirtualWorld(playerid) != 0 || GetPlayerInterior(playerid) != 0) 
            {
                sendTipMessageEx(playerid, -1, "Musisz byæ na zewn¹rz.");
                return 1;
            }
            graffiti_ShowCreationDialog(playerid);
        }
        else if(strcmp(opcja,"usun",true) == 0)
        {
            new i = graffiti_FindNearest(playerid);
            if(i!=INVALID_GRAFID)
            {
                if(strcmp(GraffitiInfo[i][pOwner],GetNick(playerid),true) == 0 || PlayerInfo[playerid][pAdmin] >= GRAFFITI_ADMIN)
                {
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
                if(strcmp(GraffitiInfo[i][pOwner],GetNick(playerid),true) == 0)
                {
                    graffiti_ShowEditTextDialog(playerid, i);
                }
                else
                {
                    sendTipMessage(playerid, "Graffiti nie nale¿y do ciebie.");
                }
            }
            else
            {
                sendTipMessage(playerid, "Nie znaleziono graffiti w pobli¿u.");
            }
        }
    }
    else
    {
        sendTipMessage(playerid, "Komenda dostêpna tylko dla gangów.");
        return 1;
    }
    
    return 1;
}

//end