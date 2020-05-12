//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     ac                                                    //
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
// Data utworzenia: 16.09.2019


//

//------------------<[ Implementacja: ]>-------------------
ac_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    #pragma unused inputtext
    if(dialogid == DIALOG_AC_PANEL)
    {
        if(response)
        {
            EnableAntiCheat(listitem, !IsAntiCheatEnabled(listitem));
            ac_ShowDialog(playerid);
        }
        return 1;
    }
    return 0;
}

ac_ShowDialog(playerid)
{
    new string[70*sizeof(nexac_ac_names)];
    for(new i; i<sizeof(nexac_ac_names); i++)
    {
        if(IsAntiCheatEnabled(i)) 
        {
            strcat(string, sprintf("{00FF00}%s[%d] - ON{FFFFFF}\n", nexac_ac_names[i], i));
        }
        else
        {
            strcat(string, sprintf("{FF0000}%s[%d] - OFF{FFFFFF\n", nexac_ac_names[i], i));
        }
    }
    ShowPlayerDialogEx(playerid, DIALOG_AC_PANEL, DIALOG_STYLE_MSGBOX, "Panel Anty-Cheat'a", string, "Zmieñ", "WyjdŸ");
}

command_ac_Impl(playerid)
{
    if(PlayerInfo[playerid][pAdmin] >= 1000 || IsAScripter(playerid))
	{
        ac_ShowDialog(playerid);
	}
    return 1;
}

//end