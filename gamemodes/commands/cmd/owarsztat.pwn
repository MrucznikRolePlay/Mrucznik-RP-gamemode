//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ owarsztat ]-----------------------------------------------//
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

YCMD:owarsztat(playerid, params[], help)
{
	if(IsBusinessTypeOwnedByPlayerOrg(playerid, FRONT_BIZ_TYPE_SPRAY))
	{
		if(!openwarsztat)
		{
			new imiegracza[MAX_PLAYERS];
			new linijka[64];
			GetPlayerName(playerid,imiegracza, sizeof(imiegracza));
			SendClientMessageToAll(0xCC33FF,"|____________[ FDU ]____________|");
			format(linijka, sizeof(linijka),"%s : Warsztat Jefferson Otwarty.", imiegracza);
			SendClientMessageToAll(0xCC33FF,linijka);
			openwarsztat = true;
		}
		else
		{
			sendTipMessage(playerid,"Warsztat jest juz otwarty, uzyj /cwarsztat by go zamknac");
		}
	}
	else
	{
		sendErrorMessage(playerid,"Twoja organizacja nie posiada biznesu Pay'N'Spray.");
	}
	return 1;
}
