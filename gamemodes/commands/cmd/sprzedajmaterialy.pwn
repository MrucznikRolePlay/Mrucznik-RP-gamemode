//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------[ sprzedajmaterialy ]-------------------------------------------//
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

YCMD:sprzedajmaterialy(playerid, params[], help)
{
	new giveplayerid, moneys, kasa;
	if(sscanf(params, "k<fix>dd", giveplayerid, moneys, kasa))
	{
		sendTipMessage(playerid, "U¿yj /sprzedajmats [playerid/CzêœæNicku] [iloœæ] [cena]");
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
							if(moneys > 50000 || moneys < 5000)
							{
							    sendErrorMessage(playerid, "Zakres od 5 000 do 50 000!");
								return 1;
							}
							if(kasa > 1000000 || kasa < 1)
							{
							    sendErrorMessage(playerid, "Zakres od 1 do 1 000 000!");
								return 1;
							}
							if(IsPlayerInAnyVehicle(giveplayerid) || IsPlayerInAnyVehicle(playerid)) return sendErrorMessage(playerid, "Jeden z was znajduje siê w pojeŸdzie!");
                            if(GetPVarInt(giveplayerid, "OKupMats") == 1) return sendErrorMessage(playerid, "Gracz ma ju¿ ofertê!");
                            if(GetPVarInt(playerid, "OSprzedajMats") == 1) return sendErrorMessage(playerid, "Oferujesz ju¿ komuœ sprzeda¿!");
                          //  if(IsAGunShopBusinessOwner(playerid) && !IsAGunShopBusinessOwner(giveplayerid)) return sendErrorMessage(playerid, "Pracownik GunShopu mo¿e oferowaæ sprzeda¿ tylko innemu pracownikowi GunShopu!");

                            new string[128];
							format(string, sizeof(string),"%s oferuje %d materia³ów za %d $.", GetNick(playerid), moneys, kasa);
							ShowPlayerDialogEx(giveplayerid, 9520, DIALOG_STYLE_MSGBOX, "KUPNO MATERIA£ÓW", string, "Kup", "Odrzuæ");
                            format(string, sizeof(string), "Zaoferowa³eœ %d materia³ów za %d graczowi %s.", moneys, kasa, GetNick(giveplayerid));
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
						sendErrorMessage(playerid, "Mo¿esz daæ tylko 50 000 materia³ów na raz!");
					}
				}
				else
				{
					sendErrorMessage(playerid, "Nie masz tylu materia³ów!");
				}
			}
		}
	}
	else
	{
		sendErrorMessage(playerid, "Nie masz tylu materia³ów!");
	}
	return 1;
}
