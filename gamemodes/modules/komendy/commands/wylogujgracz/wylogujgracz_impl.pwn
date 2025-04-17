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
command_wylogujgracz_Impl(playerid, params[256])
{
    if(IsPlayerConnected(playerid))
    {
		new giveplayerid;
		if( sscanf(params, "k<fix>", giveplayerid))
		{
			sendTipMessage(playerid, "U¿yj /wylogujgracz [playerid/CzêœæNicku]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
		    if(IsPlayerConnected(giveplayerid)&&giveplayerid != INVALID_PLAYER_ID)
		    {
				Log(adminLog, INFO, "Admin %s wylogowa³ %s", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid));
                MruMySQL_SaveAccount(giveplayerid);
				gPlayerLogged[giveplayerid] = 0;
				SendClientMessage(playerid, COLOR_GRAD1, "Gracz zosta³ wylogowany.");
                new str[128];
                format(str, 128, "* Zosta³es wylogowany przez admina %s [%d].", GetNickEx(playerid), playerid);
                SendClientMessage(giveplayerid, COLOR_GRAD1,str);
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}

//end
