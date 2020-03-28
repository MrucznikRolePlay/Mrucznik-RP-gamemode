//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  zastrzyk                                                 //
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
command_zastrzyk_Impl(playerid, giveplayerid)
{
	if ( !(IsAMedyk(playerid) && PlayerInfo[playerid][Rank] >= 1))
	{
		sendErrorMessage(playerid, "Nie masz 1 rangi lub nie jesteœ medykiem!");
        return 1;
	}
    
    if(!IsPlayerNear(playerid, giveplayerid))
    {
        sendErrorMessage(playerid, sprintf("Jesteœ zbyt daleko od gracza %s", GetNick(giveplayerid)));
        return 1;
    }

    ProxDetector(20.0, playerid, sprintf("* Lekarz %s wyci¹ga strzykawkê i wstrzykuje leki %s.", GetNick(playerid), GetNick(giveplayerid)), 
        COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE
    );
    if(IsPlayerHealthy(playerid)) 
    {
        SendClientMessage(giveplayerid, COLOR_WHITE, "Lekarz da³ ci zastrzyk i pooprawi³ Twoj¹ odpornoœæ.");
        ProxDetector(20.0, playerid, sprintf("* %s czuje siê lepiej oraz jego organizm sta³ siê bardziej odporny na choroby.", GetNick(giveplayerid)), 
            COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE
        );
    }
    else
    {
        SendClientMessage(giveplayerid, COLOR_WHITE, "Lekarz da³ ci zastrzyk i za³agodzi³ objawy choroby.");
        ProxDetector(20.0, playerid, sprintf("* %s czuje siê lepiej oraz jego organizm lepiej radzi sobie z objawami choroby.", GetNick(giveplayerid)), 
            COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE
        );
    }
    if(PlayerImmunity[giveplayerid] < 5) PlayerImmunity[giveplayerid] = 5;
    SetPlayerHealth(giveplayerid, 100);
    TogglePlayerControllable(giveplayerid, 1);
    SendClientMessage(playerid, COLOR_GREY, "Koszt zastrzyku: "INCOLOR_RED"-500$");
    ZabierzKase(playerid, 500);
    return 1;
}

//end