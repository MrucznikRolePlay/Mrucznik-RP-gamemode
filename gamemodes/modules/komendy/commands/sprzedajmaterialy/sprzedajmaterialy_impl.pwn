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
command_sprzedajmaterialy_Impl(playerid, params[256])
{
    new giveplayerid, moneys, kasa;
	if(sscanf(params, "k<fix>dd", giveplayerid, moneys, kasa))
	{
		sendTipMessage(playerid, "U�yj /sprzedajmats [playerid/Cz��Nicku] [ilo��] [cena]");
		return 1;
	}

	if (PlayerInfo[playerid][pMats] > 0)
	{
		if(IsPlayerConnected(giveplayerid))
		{
			if(giveplayerid != INVALID_PLAYER_ID && playerid != giveplayerid)
			{
				if(PlayerInfo[playerid][pMats] >= moneys)
				{
					if(moneys <= 50000)
					{
						if(ProxDetectorS(5.0, playerid, giveplayerid))
						{
							if(moneys > 50000 || moneys < 1)
							{
							    sendErrorMessage(playerid, "Ilo�� od 1 do 50 000!");
								return 1;
							}
							if(kasa > 1000000 || kasa < 1)
							{
							    sendErrorMessage(playerid, "Cena od 1 do 1 000 000!");
								return 1;
							}
							if(IsPlayerInAnyVehicle(giveplayerid) || IsPlayerInAnyVehicle(playerid)) return sendErrorMessage(playerid, "Jeden z was znajduje si� w poje�dzie!");
                            if(GetPVarInt(giveplayerid, "OKupMats") == 1) return sendErrorMessage(playerid, "Gracz ma ju� ofert�!");
                            if(GetPVarInt(playerid, "OSprzedajMats") == 1) return sendErrorMessage(playerid, "Oferujesz ju� komu� sprzeda�!");

                            new string[128];
							format(string, sizeof(string),"%s oferuje %d materia��w za %d $.", GetNick(playerid), moneys, kasa);
							ShowPlayerDialogEx(giveplayerid, 9520, DIALOG_STYLE_MSGBOX, "KUPNO MATERIA��W", string, "Kup", "Odrzu�");
                            format(string, sizeof(string), "Zaoferowa�e� %d materia��w za %d graczowi %s.", moneys, kasa, GetNick(giveplayerid));
							SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
							
							SetPVarInt(giveplayerid, "OKupMats", 1);
							SetPVarInt(playerid, "OSprzedajMats", 1);
                            SetPVarInt(giveplayerid, "Mats-id", playerid);
                            SetPVarInt(giveplayerid, "Mats-kasa", kasa);
                            SetPVarInt(giveplayerid, "Mats-mats", moneys);
                            SetTimerEx("SprzedajMatsTimer", 20000, false, "ii", playerid, giveplayerid);
						}
						else
						{
							sendErrorMessage(playerid, "Gracz jest za daleko!");
						}
					}
					else
					{
						sendErrorMessage(playerid, "Mo�esz da� tylko 50 000 materia��w na raz!");
					}
				}
				else
				{
					sendErrorMessage(playerid, "Nie masz tylu materia��w!");
				}
			}
		}
	}
	else
	{
		sendErrorMessage(playerid, "Nie masz tylu materia��w!");
	}
	return 1;
}

//end
