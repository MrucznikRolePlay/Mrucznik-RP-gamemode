//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ setmc ]-------------------------------------------------//
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

YCMD:setmc(playerid, params[], help)
{
	return SendClientMessage(playerid, COLOR_GREEN, "Ju¿ wkrótce!");
/*	
	if(PlayerInfo[playerid][pAdmin] == 5000)
	{
		new giveplayerid, VARmcVal;
		if( sscanf(params, "k<fix>d", giveplayerid, VARmcVal))
		{
			sendTipMessage(playerid, "U¿yj /setmc [playerid/CzêœæNicku] [mrucznik coins]");
			return 1;
		}
		
		new string[90];

		format(string, sizeof(string), "AdmCmd: %s dal %s %d mrucznik coinsow", GetNick(playerid), GetNick(giveplayerid), VARmcVal);

		CKLog(string);

		PremiumInfo[giveplayerid][pMC] = VARmcVal;

		premium_saveMc(giveplayerid);

		_MruAdmin(playerid, sprintf("Da³eœ %d MC graczowi %s [ID: %d]", VARmcVal, GetNick(giveplayerid, true), giveplayerid));
		if(giveplayerid != playerid) _MruAdmin(giveplayerid, sprintf("Dosta³eœ %d MC od Admina %s [ID: %d]", VARmcVal, GetNick(playerid, true), playerid));

		return 1;

	}
	else return noAccessMessage(playerid);*/
}
