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
command_cwarsztat_Impl(playerid)
{
    if(IsBusinessTypeOwnedByPlayerOrg(playerid, FRONT_BIZ_TYPE_SPRAY))
	{
		if(openwarsztat)
		{
			new imiegracza[MAX_PLAYERS];
			new linijka[64];
			GetPlayerName(playerid,imiegracza, sizeof(imiegracza));
			SendClientMessageToAll(0x9933FF,"|____________[ FDU ]____________|");
			format(linijka, sizeof(linijka),"%s : Warsztat Jefferson Zamkniety", imiegracza);
			SendClientMessageToAll(0x9933FF,linijka);
			openwarsztat = false;
		}
		else
		{
			sendTipMessage(playerid,"Warsztat jest zamkniety!! uzyj /owarsztat by go otworzyc.");
		}
	}
	else
	{
		sendErrorMessage(playerid,"Twoja organizacja nie posiada biznesu Pay'N'Spray.");
	}
	return 1;
}

//end
