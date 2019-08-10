//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ fracinfo ]------------------------------------------------//
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

YCMD:fracinfo(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
		new valueFrac, string[256];
		if( sscanf(params, "d", valueFrac))
		{
			sendTipMessage(playerid, "U¿yj /fracinfo [ID FRAKCJI]");
			return 1;
		}
		if(valueFrac <= 0 || valueFrac > MAX_FRAC)
		{
			sendErrorMessage(playerid, "Nieprawid³owe ID frakcji!"); 
			return 1;
		}
		new countWorkers;
		foreach(new i : Player)
		{
			if(PlayerInfo[i][pMember] == valueFrac)
			{
				countWorkers++; 
			}
		}
		format(string, sizeof(string), "{FFFFFF}Name: {AA3333}%s\n{FFFFFF}Slot: {AA3333}%d\n{FFFFFF}Liderów: {AA3333}%d\n{FFFFFF}Pracowników [On-Line]: {AA3333}%d", FractionNames[valueFrac], valueFrac, LeadersValue[LEADER_FRAC][valueFrac], countWorkers);
		ShowPlayerInfoDialog(playerid, "Mrucznik Role Play", string, false);
		countWorkers=0;
	}
	return 1;
}
