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
	if (!IsAMedyk(playerid))
	{
		sendErrorMessage(playerid, "Nie jeste� medykiem!");
        return 1;
	}
    
    if(!IsPlayerNear(playerid, giveplayerid))
    {
        sendErrorMessage(playerid, sprintf("Jeste� zbyt daleko od gracza %s", GetNick(giveplayerid)));
        return 1;
    }

    ProxDetector(20.0, playerid, sprintf("* Lekarz %s wyci�ga strzykawk� i wstrzykuje leki %s.", GetNick(playerid), GetNick(giveplayerid)), 
        COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE
    );
    if(IsPlayerHealthy(playerid)) 
    {
        SendClientMessage(giveplayerid, COLOR_WHITE, "Lekarz da� ci zastrzyk i pooprawi� Twoj� odporno��.");
        ProxDetector(20.0, playerid, sprintf("* %s czuje si� lepiej oraz jego organizm sta� si� bardziej odporny na choroby.", GetNick(giveplayerid)), 
            COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE
        );
    }
    else
    {
        SendClientMessage(giveplayerid, COLOR_WHITE, "Lekarz da� ci zastrzyk i za�agodzi� objawy choroby.");
        ProxDetector(20.0, playerid, sprintf("* %s czuje si� lepiej oraz jego organizm lepiej radzi sobie z objawami choroby.", GetNick(giveplayerid)), 
            COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE
        );
    }
    SetPlayerImmunity(giveplayerid, MAX_PLAYER_IMMUNITY);
    SetPlayerHealth(giveplayerid, 100);
    TogglePlayerControllable(giveplayerid, 1);
    SendClientMessage(playerid, COLOR_GREY, "Koszt zastrzyku: "INCOLOR_RED"-500$");
    ZabierzKase(playerid, 500);
    return 1;
}

//end