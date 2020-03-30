//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   zaraz                                                   //
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
command_zaraz_Impl(playerid, giveplayerid, disease[32])
{
    if(PlayerInfo[playerid][pAdmin] < 100 && !IsAScripter(playerid))
    {
        noAccessMessage(playerid);
        return 1;
    }

    if(strcmp(disease, "wylecz", true) == 0) 
    {
        CureFromAllDiseases(giveplayerid);
        Log(adminLog, INFO, "Admin %s wyleczy³ %s z wszystkich chorób", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid));
        SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, sprintf("   Admin %s wyleczy³ Ciê ze wszystkich chorób.", GetNickEx(playerid)));
        SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("   Wyleczy³eœ gracza %s ze wszystkich chorób.", GetNick(giveplayerid)));
        return 1;
    }

    new eDiseases:diseaseID = GetDiseaseID(disease);
    if(diseaseID == eDiseases:NONE) 
    {
        ShowDiseaseList(playerid);
        SendClientMessage(playerid, COLOR_WHITE, "Lub wpisz \"/zaraz [id] wylecz\", aby wyleczyæ");
        return 1;
    }

    InfectPlayer(giveplayerid, diseaseID);
    Log(adminLog, INFO, "Admin %s zarazi³ %s chorob¹ %s", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), disease);
    SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, "   Zarazi³eœ siê chorob¹");
    SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("   Zarazi³eœ gracza %s chorob¹ %s.", GetNick(giveplayerid), disease));
    return 1;
}

//end