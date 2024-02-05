//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ zablokujw ]-----------------------------------------------//
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

YCMD:zablokujw(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
        if(IsAScripter(playerid) || IsPlayerPremiumOld(playerid) || PlayerInfo[playerid][pAdmin] >= 1)
        {
			if (!HidePM[playerid])
			{
				HidePM[playerid] = 1;
                MSGBOX_Show(playerid, "Prywatne wiadomosci ~r~OFF", MSGBOX_ICON_TYPE_OK);
			}
			else if (HidePM[playerid])
			{
				HidePM[playerid] = 0;
                MSGBOX_Show(playerid, "Prywatne wiadomosci ~g~ON", MSGBOX_ICON_TYPE_OK);
			}
		}
		else
		{
            sendTipMessage(playerid, "Aby skorzystaæ z tej komendy zakup konto premium!");
		    noAccessMessage(playerid);
            return 1;
		}
	}
	return 1;
}
