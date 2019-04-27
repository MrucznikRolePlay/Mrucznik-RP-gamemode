//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ dskill ]------------------------------------------------//
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

YCMD:dskill(playerid, params[], help)
{
    if(PlayerInfo[playerid][pAdmin] >=100)
	{
	    new giveplayerid, idskill, level;
		if( sscanf(params, "k<fix>dd", giveplayerid, idskill, level))
		{
			sendTipMessage(playerid, "/dskill [id gracza] [id skilla] [level]");
			return 1;
		}

		if(PlayerInfo[playerid][pLevel] >= 1)
		{
		    if(idskill < 11 && idskill >= 0)
			{
			    SetPlayerSkillLevel(giveplayerid, idskill, level);
			    if(idskill == 0)
			    {
			        SendClientMessage(playerid, COLOR_RED, "WEAPONSKILL_PISTOL");
			    }
			    else if(idskill == 1)
			    {
			        SendClientMessage(playerid, COLOR_RED, "WEAPONSKILL_PISTOL_SILENCED");
			    }
			    else if(idskill == 2)
			    {
			        SendClientMessage(playerid, COLOR_RED, "WEAPONSKILL_DESERT_EAGLE");
			    }
			    else if(idskill == 3)
			    {
			        SendClientMessage(playerid, COLOR_RED, "WEAPONSKILL_SHOTGUN");
			    }
			    else if(idskill == 4)
			    {
			        SendClientMessage(playerid, COLOR_RED, "WEAPONSKILL_SAWNOFF_SHOTGUN");
			    }
			    else if(idskill == 5)
			    {
			        SendClientMessage(playerid, COLOR_RED, "WEAPONSKILL_SPAS12_SHOTGUN");
			    }
			    else if(idskill == 6)
			    {
			        SendClientMessage(playerid, COLOR_RED, "WEAPONSKILL_MICRO_UZI");
			    }
			    else if(idskill == 7)
			    {
			        SendClientMessage(playerid, COLOR_RED, "WEAPONSKILL_MP5");
			    }
			    else if(idskill == 8)
			    {
			        SendClientMessage(playerid, COLOR_RED, "WEAPONSKILL_AK47");
			    }
			    else if(idskill == 9)
			    {
			        SendClientMessage(playerid, COLOR_RED, "WEAPONSKILL_M4");
			    }
			    else if(idskill == 10)
			    {
			        SendClientMessage(playerid, COLOR_RED, "WEAPONSKILL_SNIPERRIFLE");
			    }
			}
		}
	}
	return 1;
}
