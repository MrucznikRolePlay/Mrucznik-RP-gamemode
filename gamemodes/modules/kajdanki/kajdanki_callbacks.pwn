//----------------------------------------------<< Callbacks >>----------------------------------------------//
//                                                  kajdanki                                                 //
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
// Autor: NikodemBanan
// Data utworzenia: 01.03.2024
//Opis:
/*
	Uporz¹dkowany system kajdanek.
*/

//

#include <YSI\y_hooks>

//-----------------<[ Callbacki: ]>-----------------

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == CUFFING_DIALOG_ID)
	{
		new proxMessage[256];
		new copplayerid = whoIsCuffing[playerid];
		new cuffingCopsCount = 0;
		
		if(response)
		{
			format(proxMessage, sizeof(proxMessage), "* %s nie stawia oporu i daje siê skuæ %s.", GetNick(playerid), GetNick(copplayerid));
			CuffedAction(copplayerid, playerid);
		}
		else
		{
			foreach(new p : Player)
			{
				if((IsAPolicja(p) || IsABOR(p)) && ProxDetectorS(8.0, p, playerid))
				{
					cuffingCopsCount++;
				}
			}

			if(cuffingCopsCount >= 3 || (cuffingCopsCount == 2 && random(100) < 50))
			{
				format(proxMessage, sizeof(proxMessage), "* %s wyrywa siê i ucieka lecz policjanci powstrzymuj¹ go i skuwaj¹ go si³¹.", GetNick(playerid));
				CuffedAction(copplayerid, playerid);
			}
			else
			{
				format(proxMessage, sizeof(proxMessage), "* %s wyrywa siê z ca³ej si³y i ucieka.", GetNick(playerid));
				TogglePlayerControllable(playerid, 1);
				
				whoIsCuffing[playerid] = INVALID_PLAYER_ID;
			}
			
			PoziomPoszukiwania[playerid] += 1;
			SetPlayerCriminal(playerid, 255, "Stawianie oporu podczas aresztowania");
		}

		ProxDetector(30.0, playerid, proxMessage, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}

	return Y_HOOKS_CONTINUE_RETURN_0;
}

//end