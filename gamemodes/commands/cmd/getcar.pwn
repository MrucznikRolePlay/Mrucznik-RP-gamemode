//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ getcar ]------------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

YCMD:getcar(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
		new plo;
		if( sscanf(params, "d", plo))
		{
			sendTipMessage(playerid, "U¿yj /getcar [carid]");
			return 1;
		}
		new Float:plocx,Float:plocy,Float:plocz;


		if (PlayerInfo[playerid][pAdmin] >= 1 || Uprawnienia(playerid, ACCESS_PANEL) || IsAScripter(playerid))
		{
			GetPlayerPos(playerid, plocx, plocy, plocz);
			SetVehiclePos(plo,plocx,plocy+4, plocz);
            SetVehicleVirtualWorld(plo, GetPlayerVirtualWorld(playerid));
			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				iloscInne[playerid] = iloscInne[playerid]+1;
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "B³¹d!");
	}
	return 1;
}
