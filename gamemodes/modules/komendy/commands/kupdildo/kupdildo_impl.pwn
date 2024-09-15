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
command_kupdildo_Impl(playerid, params[256])
{
    if(IsPlayerConnected(playerid))
    {
		if(PlayerToPoint(30.0, playerid, -105.0829,-10.6207,1000.7188))
		{
	        if(kaska[playerid] < 1)
			{
			    sendTipMessage(playerid, "Nie masz przy sobie wystarczaj¹co du¿o pieniêdzy!");
			    return 1;
			}
			if(GUIExit[playerid] == 0)
 	    	{
				ShowPlayerDialogEx(playerid, 81, DIALOG_STYLE_LIST, "Los Santos Sex Shop XXX- wibratory, filmy i zabawki", "Purpurowe dildo\t\t25 000$\nMa³y wibrator\t\t\t7500$\nDu¿y bia³y wibrator\t\t20 000$\nSrebrny wibrator\t\t12 000$\nLaska sado-maso\t\t1500$\nKwiaty\t\t\t\t500$\nPrezerwatywy\t\t\t50$", "Kup", "WyjdŸ");
			}
		}
		else
		{
		    sendErrorMessage(playerid,"Nie jesteœ w sex shopie");
		    return 1;
		}
	}
	return 1;
}

//end
