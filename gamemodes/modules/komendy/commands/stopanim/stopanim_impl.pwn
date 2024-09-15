//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     a                                                     //
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
// Data utworzenia: 15.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_stopanim_Impl(playerid)
{
    if(IsPlayerConnected(playerid))
    {
        new Float:Velocity[3];
		GetPlayerVelocity(playerid, Velocity[0], Velocity[1], Velocity[2]);
        if( (!IsPlayerInAnyVehicle(playerid) && Velocity[2] == 0) && (!IsPlayerCarryingBox(playerid)))
        {
			if(PlayerInfo[playerid][pInjury] > 0 || PlayerInfo[playerid][pBW] > 0)
			{
				return ShowPlayerInfoDialog(playerid, "Mrucznik Role Play", "{FF542E}Jesteœ ranny!\n{FFFFFF}Nie mo¿esz zatrzymaæ animacji.");
			}
	        ClearAnimations(playerid);
	        SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
	    }
	    else
	    {
	        sendTipMessageEx(playerid, COLOR_WHITE, "Nie mo¿esz zatrzymaæ animacji");
	    }
    }
    return 1;
}

//end
