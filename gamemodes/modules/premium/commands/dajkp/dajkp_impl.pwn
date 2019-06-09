//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   dajkp                                                   //
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
// Data utworzenia: 09.06.2019


//

//------------------<[ Implementacja: ]>-------------------
command_dajkp_Impl(playerid, giveplayerid)
{
    if(IsAKox(playerid))
	{
		new giveplayerid, givetime;

		if(sscanf(params, "k<fix>d", giveplayerid, givetime))
		{
			sendTipMessage(playerid, "U¿yj /dajkp [playerid/CzêœæNicku] [Czas kp w sekundach (0=Na zawsze)]");
			return 1;
		}

		new string[90];

		format(string, sizeof(string), "AdmCmd: %s dal %s KP na %d", GetNick(playerid), GetNick(giveplayerid), givetime);
		Log(ckLog, INFO, string);

		if(givetime == 0)
		{
			DajKP(giveplayerid, 0, true);
		}
		else
		{
			DajKP(giveplayerid, gettime()+givetime, true);
		}

		_MruAdmin(playerid, sprintf("Da³eœ KP graczowi %s [ID: %d] na czas %d.", GetNick(giveplayerid, true), giveplayerid, givetime));
		if(giveplayerid != playerid) _MruAdmin(giveplayerid, sprintf("Dosta³eœ KP od Admina %s [ID: %d]", GetNick(playerid, true), playerid));
		return 1;
	}
	else return noAccessMessage(playerid);
}


//end