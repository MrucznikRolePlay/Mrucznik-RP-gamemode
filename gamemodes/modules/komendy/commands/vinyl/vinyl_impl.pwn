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
command_vinyl_Impl(playerid)
{
    if(IsPlayerConnected(playerid))
    {
       	if(IsPlayerInRangeOfPoint(playerid, 300, 678.121704, -1393.385620, -21.709302))
	   	{
			if(IsFrontBusinnesOwnedByPlayerOrg(playerid, FRONTBIZ_VINYL) && PlayerInfo[playerid][pRank] >= 6)
			{
				new txt_jacuzzi[128], txt[256];
				if(!jacuzziVinyl)
				{
					format(txt_jacuzzi, 128, "{FFFFFF}\nJacuzzi: \t{FF0000}Zamkni�te");
				}
				else
				{
					format(txt_jacuzzi, 128, "{FFFFFF}\nJacuzzi: \t{00FF00}Otwarte");
				}
				format(txt, 256, "Klub \nBiuro %s", txt_jacuzzi);
				ShowPlayerDialogEx(playerid, D_VINYL, DIALOG_STYLE_TABLIST, "PANEL: {00FFFF}VinylClub", txt, "Wybierz", "Anuluj");
			}
			else
			{
				noAccessMessage(playerid); 
			}
		}
		else 
		{
			sendErrorMessage(playerid, "Nie jeste� w pobli�u klubu!"); 
			return 1;
		}
		
	}
	return 1;
}

//end
