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
command_gotoint_Impl(playerid, params[256])
{
    new string[128];

    if(IsPlayerConnected(playerid))
    {
		new plo;
		if( sscanf(params, "d", plo))
		{
			sendTipMessage(playerid, "U�yj /gototint [nr inta]");
			return 1;
		}


		if(plo >= 1)
		{
		    if(plo <= 100)
		    {
				if (PlayerInfo[playerid][pAdmin] >= 20)
				{
					SetPlayerInterior(playerid, IntInfo[plo][Int]);
					SetPlayerPos(playerid, IntInfo[plo][Int_X], IntInfo[plo][Int_Y], IntInfo[plo][Int_Z]);
  					format(string, sizeof(string), "Dom %d, dane: Interior %d, Kategoria %d, Ilo�� pokoi %d", plo, IntInfo[plo][Int], IntInfo[plo][Kategoria], IntInfo[plo][Pokoje]);
	    			SendClientMessage(playerid, COLOR_GREY, string);
				}
				else
				{
					noAccessMessage(playerid);
				}
			}
		}
	}
	return 1;
}

//end
