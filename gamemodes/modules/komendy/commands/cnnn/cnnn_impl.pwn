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
command_cnnn_Impl(playerid, params[256])
{
    if (PlayerInfo[playerid][pAdmin] >= 5000)
	{
		new txtid, result[128];
		if( sscanf(params, "ds[128]", txtid, result))
		{
			sendTipMessage(playerid, "U¿yj /cnnn <typ> [cnnn formattextu ~n~=Nowalinia ~r~=Czerwony ~g~=Zielony ~b~=Niebieski ~w~=Bia³y ~y~=¯ó³ty]");
			return 1;
		}

		if(txtid == 2)
		{
			sendTipMessageEx(playerid, COLOR_GRAD2, "2 jest niedostêpna");
			return 1;
		}
		new string[128];
		format(string, sizeof(string), "~w~%s",result);
        if(!issafefortextdraw(string)) return sendErrorMessage(playerid, "Niekompletny tekst (tyldy etc)");
		foreach(new i : Player)
		{
			if(IsPlayerConnected(i) == 1)
			{
				GameTextForPlayer(i, string, 5000, txtid);
			}
		}
		return 1;
	}
	else
	{
		noAccessMessage(playerid);
		return 1;
	}
}

//end
