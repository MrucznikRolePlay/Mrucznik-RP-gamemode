//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   03DL                                                    //
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
// Autor: Simeone 
// Data utworzenia: 27-07-2019
//Opis:
/*

*/

//

//-----------------<[ Callbacki: ]>-------------------
//-----------------<[ Funkcje: ]>-------------------
SprawdzSkin(dlaCzego, skinID)
{
	for(new i; i<=LOADED_SKINS; i++)
	{
		if(dlaCzego == 1)
		{
			if(skinsToEvent[i][Model] == skinID)
			{
				if(eventForSkin[i] == 0)
				{
					break;
				}
				return true;
			}
		}
		else if(dlaCzego == 2)
		{
			if(skinsToPremium[i][Model] == skinID)
			{
				break;
			}
		}
	}
	return false;
}
/*stock GiveMeSkin(playerid, value, money, durability)
{
	if(value >= DL_SKIN_START)
	{
		if(value > LOADED_SKINS)
		{
			sendErrorMessage(playerid, "B³¹d! Nie ma takiego skina"); 
			return 1;
		}	
		if(PlayerInfo[playerid][pAdmin] == 5000 || IsAScripter(playerid))//Omijanie sprawdzania dostêpnoœci 
		{
			SetPlayerSkin(playerid, value+19601); 
		}
		else//Sprawdza dostêpnoœæ skina
		{
			if(SprawdzSkin(1, value))
			{
				if(SprawdzSkin(2, value))
				{
					if(money > 0)
					{
						if(kaska[playerid] < money)
						{
							sendErrorMessage(playerid, "Nie posiadasz odpowiedniej iloœci gotówki!"); 
							return 1;
						}
						ZabierzKase(playerid, money); 
					}
					SetPlayerSkin(playerid, value+19601);
					if(durability == 0)
					{
						PlayerInfo[playerid][pModel] = value+19601;
					}
					else if(durability == 1)
					{
						PlayerInfo[playerid][pSkin] = value+19601;
					} 
					sendTipMessage(playerid, "Pomyœlnie zmieniono Ci skin"); 
				}
				else
				{
					sendErrorMessage(playerid, "Ten skin jest dostêpny tylko za MrucznikCoins'y!"); 
					return 1;
				}
			}
			else
			{
				sendErrorMessage(playerid, "Ten skin jest tylko na eventy!"); 
			}
		}
	}
	else if(value > 0 && value < 311)
	{
		new dobrze;
		if(SprawdzSkin(1, value))
		{
			for(new skin = 0; skin<194; skin++)
			{
				if(value == Przebierz[skin][0])
				{
					dobrze = 1;
				}
			}
			if(dobrze == 1)
			{
				if(money > 0)
				{
					if(kaska[playerid] < money)
					{
						sendErrorMessage(playerid, "Nie posiadasz odpowiedniej iloœci gotówki!"); 
						return 1;
					}
					ZabierzKase(playerid, money); 
				}
				SetPlayerSkin(playerid, value);
				if(durability == 0)
				{
					PlayerInfo[playerid][pModel] = value+19601;
				}
				else if(durability == 1)
				{
					PlayerInfo[playerid][pSkin] = value+19601;
				} 
			}
			else{
				sendErrorMessage(playerid, "Tego skina nie mo¿esz wybraæ!"); 
				return 1;
			}
		}
		else
		{
			sendErrorMessage(playerid, "Ten skin jest dostêpny tylko na eventy!"); 
		}
	}
	return 1;
}*/
stock SetPlayerSkinEx(playerid, value)
{
	if(value >= 400)
	{
		SetPlayerSkin(playerid, value+19601); 
		return 1;
	}
	SetPlayerSkin(playerid, value); 
	return 1;
}
//-----------------<[ Timery: ]>-------------------
//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end