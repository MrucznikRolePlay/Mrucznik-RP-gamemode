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
command_kupbiletpociag_Impl(playerid)
{
    if(IsPlayerConnected(playerid))
	{
		if(IsAtTicketMachine(playerid))
		{
			if(PlayerInfo[playerid][pBiletpociag] == 1)
			{
				//zmienne:
				new string[128];
				//Komunikaty:
				sendErrorMessage(playerid, "Posiadasz ju¿ bilet do poci¹gu!");
				format(string, sizeof(string), "* %s mruczy (jak Mrucznik) na bilet, który ju¿ posiada.", GetNick(playerid));//ciekawostka - mrucznik
				ProxDetector(10.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
				return 1;
			}
			else if(PlayerInfo[playerid][pBiletpociag] == 0)
			{
				//zmienne
				new fracgracza = GetPlayerFraction(playerid);
				new string[256];
				new giveplayer[MAX_PLAYER_NAME];
				GetPlayerName(playerid, giveplayer, sizeof(giveplayer));
				//czynnoœci:
				format(string, sizeof(string), "{FFFF00}Korporacja Transportowa\n{FFFFFF}Cena: {00FF00}%d$\n{FFFFFF}Imiê_Nazwisko: {00FF00}%s\n{FFFFFF}Twoja organizacja: {AA3333}%s\n{FFFFFF}Zni¿ka dla twojej organizacji: {00FF00}0$\n{FFFFFF}Ulga: {00FF00}0$", CenaBiletuPociag, giveplayer, FractionNames[fracgracza]);//Skrypt na zni¿ki i ulgi w trakcie pisania, celowo ie ma tutaj wartoœci
				ShowPlayerDialogEx(playerid, 1090, DIALOG_STYLE_MSGBOX, "Maszyna do biletów", string, "Zakup", "OdejdŸ");
				//komunikaty:
				format(string, sizeof(string), "* %s wstukuje w maszynê UID dowodu osobistego, wybiera trasê i ulgê.", GetNick(playerid));
				ProxDetector(10.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie jesteœ przy maszynie do kupna biletów!"); 
			return 1;
		}
	}
	return 1;
}

//end
