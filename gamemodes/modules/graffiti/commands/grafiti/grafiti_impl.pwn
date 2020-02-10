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
    if(strcmp(opcja,"sprawdz",true) == 0)
	{
        new string[128];
        new i = graffiti_FindNearest(playerid);
        if(i!=INVALID_GRAFID)
        {
            format(string, sizeof(string), "[ID]:{FF0000}%d", i); 
            SendClientMessage(playerid, COLOR_WHITE, string);
            format(string, sizeof(string), "[Nazwa w³aœciciela]:{FF0000}%s", GraffitiInfo[i][pOwner]);
            SendClientMessage(playerid, COLOR_WHITE, string);
        }
        else
        {
            sendTipMessage(playerid, "Nie znaleziono graffiti w pobli¿u.");
        }
    }
    else if(strcmp(opcja,"stworz",true) == 0)
    {
        graffiti_ShowCreationDialog(playerid);
    }
    return 1;
}

//end