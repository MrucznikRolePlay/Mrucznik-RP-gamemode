//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 pracownicy                                                //
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
// Data utworzenia: 07.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_pracownicy_Impl(playerid)
{
    new frac = GetPlayerFraction(playerid);
	new org =  GetPlayerOrg(playerid);
	new string[64];
	if(frac != 0 && PlayerInfo[playerid][pRank] >= 1)
	{
	    SendClientMessage(playerid, COLOR_GREEN, "Pracownicy Online:");
		foreach(new i : Player)
		{
		    if(frac == GetPlayerFraction(i))
		    {
		        format(string, sizeof(string), "{%06x}%s{B4B5B7} [%d] ranga %d", (GetPlayerColor(i) >>> 8), GetNick(i), i, PlayerInfo[i][pRank]);
		        SendClientMessage(playerid, COLOR_GRAD1, string);
		    }
		}
	}
	else if(org != 0)
	{
	    SendClientMessage(playerid, COLOR_GREEN, "Cz³onkowie Online:");
		foreach(new i : Player)
		{
		    if(GetPlayerOrg(i) == org)
		    {
		        format(string, sizeof(string), "{%06x}%s{B4B5B7} [%d] ranga %d", (GetPlayerColor(i) >>> 8), GetNick(i), i, PlayerInfo[i][pRank]);
		        SendClientMessage(playerid, COLOR_GRAD1, string);
		    }
		}
	}
	else
	{
	    sendErrorMessage(playerid, "Nie jesteœ pracownikiem organizacji/frakcji lub nie masz odpowiedniej rangi (minimum 1).");
	}
	return 1;
}

//end