//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ c ]---------------------------------------------------//
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

YCMD:c(playerid, params[], help)
{
    new var[64];
    if(sscanf(params, "s[64]", var)) return sendTipMessage(playerid, "U¿j /c [KOD RADIOWY]");
    new str[128];
    if(GetPVarInt(playerid, "patrol") == 1)
    {
        new pat = GetPVarInt(playerid, "patrol-id");

        if(strcmp(var, "0") == 0)
        {
            PatrolInfo[pat][patstan] = 2;
            format(str, 128, "{FFFFFF}»»{6A5ACD} CENTRALA: {FFFFFF}%s:{6A5ACD} Potrzebne natychmiastowe wsparcie - {FFFFFF}KOD 0", PatrolInfo[pat][patname]);
            SendTeamMessage(1, COLOR_ALLDEPT, str);
        }
        else if(strcmp(var, "1") == 0)
        {
            PatrolInfo[pat][patstan] = 3;
            format(str, 128, "{FFFFFF}»»{6A5ACD} CENTRALA: {FFFFFF}%s:{6A5ACD} Poœcig za podejrzanym - {FFFFFF}KOD 1", PatrolInfo[pat][patname]);
            SendTeamMessage(1, COLOR_ALLDEPT, str);
        }
        else if(strcmp(var, "2") == 0)
        {
            PatrolInfo[pat][patstan] = 4;
            format(str, 128, "{FFFFFF}»»{6A5ACD} CENTRALA: {FFFFFF}%s:{6A5ACD} Ranny funkcjonariusz - {FFFFFF}KOD 2", PatrolInfo[pat][patname]);
            SendTeamMessage(1, COLOR_ALLDEPT, str);
        }
        else if(strcmp(var, "3") == 0)
        {
            PatrolInfo[pat][patstan] = 1;
            format(str, 128, "{FFFFFF}»»{6A5ACD} CENTRALA: {FFFFFF}%s:{6A5ACD} Sytuacja pod kontrol¹ - {FFFFFF}KOD 3", PatrolInfo[pat][patname]);
            SendTeamMessage(1, COLOR_ALLDEPT, str);
        }
    }
    return 1;
}
