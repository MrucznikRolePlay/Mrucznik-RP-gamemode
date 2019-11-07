//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ red ]--------------------------------------------------//
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

YCMD:red(playerid, params[], help)
{
    new str[128];
    if(IsACop(playerid))
	{
		if(OnDuty[playerid] == 1 || JobDuty[playerid] == 1)
		{
            if(GetPlayerFraction(playerid) == FRAC_LSPD)
            {
                if(GetPVarInt(playerid, "patrol") != 1)
                {
                    sendErrorMessage(playerid, "Nie jesteœ na patrolu.");
                    return 1;
                }
                else
                {
                    if(PDGPS == playerid)
                    {
                        new pat = GetPVarInt(playerid, "patrol-id");
                        PatrolInfo[pat][patstan] = 2;
                        format(str, 128, "{FFFFFF}»»{6A5ACD} CENTRALA: {FFFFFF}%s:{FF0000} Potrzebne natychmiastowe wsparcie - {FFFFFF}CODE RED", PatrolInfo[pat][patname]);
                        SendTeamMessage(1, COLOR_ALLDEPT, str);
                    }
                }
            }

            GPSMode(playerid, true);
		}
		else
		{
			sendErrorMessage(playerid, "Nie jesteœ na s³u¿bie.");
		}
	}
	else
	{
		sendErrorMessage(playerid, "Nie jesteœ policjantem.");
	}
    return 1;
}
