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
    new string[128];
    if(strcmp(opcja,"sprawdz",true) == 0)
	{
        if(PlayerInfo[playerid][pAdmin] >= GRAFFITI_ADMIN)
        {
            new i = graffiti_FindNearest(playerid);
            if(i!=INVALID_GRAFID)
            {
                format(string, sizeof(string), "[ID graffiti]:{FF0000}%d", i); 
                SendClientMessage(playerid, COLOR_WHITE, string);
                format(string, sizeof(string), "[Nazwa w³aœciciela]:{FF0000}%s", GraffitiInfo[i][pOwner]);
                SendClientMessage(playerid, COLOR_WHITE, string);
            }
            else
            {
                sendTipMessage(playerid, "Nie znaleziono graffiti w pobli¿u.");
            }
        }
        else
        {
            sendTipMessage(playerid, "Komenda dostêpna tylko dla administracji.");
        }
    }
    else if(strcmp(opcja,"stworz",true) == 0)
    {
        graffiti_CountGraffs(playerid);
        if(Graffiti_Amount[playerid] >= 3)
        {
            sendTipMessage(playerid, "Wykorzystano limit graffiti(3).");
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
    return 1;
}

//end