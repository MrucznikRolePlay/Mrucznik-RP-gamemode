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
    if(!IsACop(playerid) && GetPlayerFraction(playerid) != FRAC_LSPD)
	{
		return sendErrorMessage(playerid, "Nie jesteœ policjantem.");
	}

	if(OnDuty[playerid] != 1 && JobDuty[playerid] != 1)
	{
		return sendErrorMessage(playerid, "Nie jesteœ na s³u¿bie.");
	}

    if(GetPVarInt(playerid, "patrol") != 1)
    {
        return sendErrorMessage(playerid, "Nie jesteœ na patrolu.");
    }

    if(PDGPS == playerid)
    {
        GPSMode(playerid, true);
        return 1;
    }

    new str[144], akcja[144];
    new pat = GetPVarInt(playerid, "patrol-id");
    PatrolInfo[pat][patstan] = 2;
    format(str, sizeof(str), "{FFFFFF}»»{6A5ACD} CENTRALA: {FFFFFF}%s:{FF0000} Potrzebne natychmiastowe wsparcie - {FFFFFF}CODE RED", PatrolInfo[pat][patname]);
    SendTeamMessage(1, COLOR_ALLDEPT, str);
    format(akcja,sizeof(akcja),"* %s uruchomi³ alert do wszystkich jednostek.",GetNick(playerid));
    ProxDetector(30.0, playerid, akcja, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    GPSMode(playerid, true);

    return 1;
}
