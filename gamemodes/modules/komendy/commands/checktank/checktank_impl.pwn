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
command_checktank_Impl(playerid, params[256])
{
    if(IsPlayerConnected(playerid))
    {
		new giveid;
		if( sscanf(params, "k<fix>", giveid))
		{
			sendTipMessage(playerid, "U¿yj /checktank [id gracza/czêœæ nicku]");
			return 1;
		}

        if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || IsAScripter(playerid))
        {
            new carid = GetPlayerVehicleID(giveid);
            if(!carid) return sendErrorMessage(playerid, sprintf("%s [%d] musi znajdowaæ siê w pojeŸdzie!", GetNick(giveid), giveid));
            
            new Float:vhealth;
            GetVehicleHealth(carid, vhealth);
            SetVehicleHealth(carid, vhealth - 15);
            SetTimerEx("CheckTankMode", 100, false, "iiif", playerid, giveid, carid, vhealth);
        }
        else
        {
            noAccessMessage(playerid);
        }
    }
    return 1;
}

//end
