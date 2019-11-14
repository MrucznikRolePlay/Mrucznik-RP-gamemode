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

    new str[144], akcja[144], patrolnick[MAX_PLAYER_NAME];

    if(GetPlayerFraction(playerid) == FRAC_LSPD)
    {   
        if(GetPVarInt(playerid, "patrol") != 1)
        {
            return sendErrorMessage(playerid, "Nie jesteœ na patrolu.");
        }
        else
        {
            new pat = GetPVarInt(playerid, "patrol-id");
            patrolnick = PatrolInfo[pat][patname];
            if(PDGPS == playerid)
            {
                PatrolInfo[pat][patstan] = 1;
            }
            else
            {
                PatrolInfo[pat][patstan] = 4; 
            }
        }
    }
    else
    {
        patrolnick = GetNick(playerid);   
    }

    if(PDGPS == playerid)
    {
        format(str, sizeof(str), "{FFFFFF}»»{6A5ACD} CENTRALA: {FFFFFF}%s:{FF0000} Odwo³ujê CODE RED", patrolnick);
        format(akcja,sizeof(akcja),"* %s wy³¹czy³ alert do wszystkich jednostek.",GetNick(playerid));
        GPSMode(playerid, true);
        return 1;
    }
    else
    {
        format(str, sizeof(str), "{FFFFFF}»»{6A5ACD} CENTRALA: {FFFFFF}%s:{FF0000} Potrzebne natychmiastowe wsparcie - {FFFFFF}CODE RED", patrolnick);
        format(akcja,sizeof(akcja),"* %s uruchomi³ alert do wszystkich jednostek.",GetNick(playerid));
        GPSMode(playerid, true);
    }

    SendTeamMessage(1, COLOR_ALLDEPT, str);
    SendTeamMessage(2, COLOR_ALLDEPT, str);
	SendTeamMessage(3, COLOR_ALLDEPT, str);
    ProxDetector(30.0, playerid, akcja, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

    return 1;
}
