//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 selldrugs                                                 //
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
// Data utworzenia: 06.04.2024


//

//------------------<[ Implementacja: ]>-------------------
command_selldrugs_Impl(playerid, giveplayerid, weight, price)
{
	if(GetPlayerJob(playerid) != JOB_DRUG_DEALER)
	{
		MruMessageFail(playerid, "Nie jesteœ dilerem narkotyków!");
		return 1;
	}

	if(GetPVarInt(playerid, "wydragowany") > 0) 
	{
		MruMessageFail(playerid, "Narkotyki mo¿esz sprzedawaæ raz na 10 sekund!");
		return 1;
	}

	if(weight < 1 || weight > 60) 
	{ 
		MruMessageFail(playerid, "Liczba gram od 1 do 60!"); 
		return 1; 
	}

	if(price < 1000 || price > 20000) 
	{ 
		MruMessageFail(playerid, "Cena od 1000 do 20000!"); 
		return 1; 
	}

	if(weight > PlayerInfo[playerid][pDrugs]) 
	{ 
		MruMessageFailF(playerid, "Masz przy sobie tylko %d narkotyków!", PlayerInfo[playerid][pDrugs]); 
		return 1; 
	}

	if(!IsPlayerNear(playerid, giveplayerid))
	{
		MruMessageFail(playerid, "Ten gracz nie jest przy tobie !");
		return 1;
	}

	if(giveplayerid == playerid)
	{
		MruMessageFail(playerid, "Nie mo¿esz sprzedaæ dragów samemu sobie!");
		return 1;
	}

	DrugOffer[giveplayerid] = playerid;
	DrugPrice[giveplayerid] = price;
	DrugGram[giveplayerid] = weight;

	MruMessageGoodInfoF(playerid, "* Oferujesz %s sprzeda¿ %d gram za $%d .", GetNick(giveplayerid), weight, price);
	MruMessageGoodInfoF(giveplayerid, "* Diler Dragów %s oferuje sprzeda¿ %d gram narkotyków za $%d, (wpisz /akceptuj dragi) aby kupiæ.", GetNick(playerid), weight, price);
	return 1;
}

command_akceptuj_drugs(playerid)
{
	if(DrugOffer[playerid] < 999)
	{
		if(kaska[playerid] > DrugPrice[playerid] && DrugPrice[playerid] > 0)
		{
			if(PlayerInfo[playerid][pDrugs] < 10)
			{
				if(IsPlayerConnected(DrugOffer[playerid]))
				{
					if(PlayerInfo[playerid][pDrugs] + DrugGram[playerid] > 10)
					{
						DrugGram[playerid] = 10 - PlayerInfo[playerid][pDrugs];
					}

					MruMessageGoodInfoF(playerid, "* Kupi³eœ %d gram za $%d od Dilera Dragów %s. Aby je wzi¹æ wpisz /wezdragi.",DrugGram[playerid],DrugPrice[playerid], GetNick(DrugOffer[playerid]));
					MruMessageGoodInfoF(DrugOffer[playerid], "* %s kupi³ od ciebie %d gram, $%d zostanie dodane do twojej wyp³aty.",GetNick(playerid),DrugGram[playerid],DrugPrice[playerid]);
					SetPVarInt(DrugOffer[playerid], "wydragowany", 10);
					
					Log(payLog, INFO, "%s kupi³ od %s paczkê %d narkotyków za %d$", GetPlayerLogName(playerid), GetPlayerLogName(DrugOffer[playerid]), DrugGram[playerid], DrugPrice[playerid]);
					//
					PlayerInfo[DrugOffer[playerid]][pPayCheck] += DrugPrice[playerid];
					PlayerInfo[DrugOffer[playerid]][pDrugsSkill] ++;
					ZabierzKase(playerid, DrugPrice[playerid]);
					PlayerInfo[playerid][pDrugs] += DrugGram[playerid];
					PlayerInfo[DrugOffer[playerid]][pDrugs] -= DrugGram[playerid];
					if(PlayerInfo[DrugOffer[playerid]][pDrugsSkill] == 50)
					{ SendClientMessage(DrugOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci dilera dragów wynosz¹ teraz 2, mo¿esz kupowac wiêcej dragów w melinie."); }
					else if(PlayerInfo[DrugOffer[playerid]][pDrugsSkill] == 100)
					{ SendClientMessage(DrugOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci dilera dragów wynosz¹ teraz 3, mo¿esz kupowac wiêcej dragów w melinie."); }
					else if(PlayerInfo[DrugOffer[playerid]][pDrugsSkill] == 200)
					{ SendClientMessage(DrugOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci dilera dragów wynosz¹ teraz 4, mo¿esz kupowac wiêcej dragów w melinie."); }
					else if(PlayerInfo[DrugOffer[playerid]][pDrugsSkill] == 400)
					{ SendClientMessage(DrugOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci dilera dragów wynosz¹ teraz 5, mo¿esz kupowac wiêcej dragów w melinie."); }
					DrugOffer[playerid] = 999;
					DrugPrice[playerid] = 0;
					DrugGram[playerid] = 0;
					return 1;
				}
				return 1;
			}
			else
			{
				sendTipMessageEx(playerid, COLOR_GREY, "Masz ju¿ za du¿o narkotyków, u¿yj ich najpierw !");
				return 1;
			}
		}
		else
		{
			sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz zakupiæ narkotyków !");
			return 1;
		}
	}
	else
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Nikt nie oferowa³ ci sprzeda¿y narkotyków !");
		return 1;
	}
}

//end