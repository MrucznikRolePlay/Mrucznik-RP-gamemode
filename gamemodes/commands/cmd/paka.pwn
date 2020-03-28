//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ paka ]-------------------------------------------------//
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

YCMD:paka(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
   	{
		if(IsAPolicja(playerid) && PlayerInfo[playerid][Rank] >= 3)
		{
			if(OnDuty[playerid] != 1 && IsAPolicja(playerid))
			{
			    sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ na s³u¿bie!");
			    return 1;
			}
            //267.8893,86.0968,1001.0391,172.1598,0,0,0,0,0,0); // kajdlsajdsa
	        if(!PlayerToPoint(10.0, playerid, 222.6395,114.3951,999.0156) && !IsPlayerInRangeOfPoint(playerid, 10.0, -1680.1337,920.8787,-52.4141))
			{// Jail spot
			    sendTipMessageEx(playerid, COLOR_GREY, "Musisz byæ przy celach aby kogoœ zaaresztowaæ !");
			    return 1;
			}
			new moneys, time, bail, bailprice;
			if( sscanf(params, "dddd", moneys, time, bail, bailprice))
			{
				sendTipMessage(playerid, "U¿yj /paka [grzywna] [czas (minuty)] [kaucja (0=nie 1=tak)] [koszt kaucji]");
				return 1;
			}

			if(moneys < 1000 || moneys > 10001) { sendTipMessageEx(playerid, COLOR_GREY, "Grzywna od 1000 do 10000!"); return 1; }
			if(time < 1 || time > 20) { sendTipMessageEx(playerid, COLOR_GREY, "Czas wiêzienia od 1 do 20 minut (jeœli chcesz wiêksz to do De Morgan) !"); return 1; }
			if(bail < 0 || bail > 1) { sendTipMessageEx(playerid, COLOR_GREY, "Kaucja musi byæ 1(=nie) lub 2(=tak) !"); return 1; }
			if(bailprice < 0 || bailprice > 3000000) { sendTipMessageEx(playerid, COLOR_GREY, "Koszt Kaucji od 1$ do $3000000 !"); return 1; }
			new suspect = GetClosestPlayer(playerid);
			if(IsPlayerConnected(suspect))
			{
				if(GetDistanceBetweenPlayers(playerid,suspect) < 5)
				{
					GetPlayerName(suspect, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					if(PoziomPoszukiwania[suspect] < 1)
					{
					    sendTipMessageEx(playerid, COLOR_GREY, "Gracz musi byæ poszukiwany (u¿yj na nim /su) !");
					    return 1;
					}
					//format(string, sizeof(string), "* Aresztowany %s !", giveplayer);
					//SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                    new depo2 = floatround(((moneys/100) * 80), floatround_round); // sejf
                    new depo3 = floatround(((moneys/100) * 20), floatround_round); //pd
                    DajKase(playerid, depo3);
                    Sejf_Add(PlayerInfo[playerid][pMember], depo2);
                    format(string, sizeof(string), "Uwiêzi³eœ %s, nagroda za przestêpcê: %d. Otrzymujesz $%d", giveplayer, moneys, depo3);
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					ZabierzKase(suspect, moneys);
                    poscig[suspect] = 0;
					format(string, sizeof(string), "Aresztowany przez %s ~n~    grzywna $%d", sendername, moneys);
					GameTextForPlayer(suspect, string, 5000, 5);
					RemovePlayerWeaponsTemporarity(suspect);
					if(PlayerInfo[playerid][pMember]==1||PlayerInfo[playerid][pLider]==1)
					{
						format(string, sizeof(string), "<< Policjant %s aresztowa³ podejrzanego %s >>", sendername, giveplayer);
						OOCNews(COLOR_LIGHTRED, string);
					}
					else if(PlayerInfo[playerid][pMember]==2||PlayerInfo[playerid][pLider]==2)
					{
						format(string, sizeof(string), "<< Agent FBI %s aresztowa³ podejrzanego %s >>", sendername, giveplayer);
						OOCNews(COLOR_LIGHTRED, string);
					}
					else if(PlayerInfo[playerid][pMember]==3||PlayerInfo[playerid][pLider]==3)
					{
						format(string, sizeof(string), "<< Funkcjonariusz %s aresztowa³ podejrzanego %s >>", sendername, giveplayer);
						OOCNews(COLOR_LIGHTRED, string);
					}
					Kajdanki_JestemSkuty[suspect] = 0;//Kajdany
					Kajdanki_Uzyte[suspect] = 0;
					Kajdanki_PDkuje[playerid] = 0;
					Kajdanki_Uzyte[playerid] = 0;
					ClearAnimations(suspect);
					SetPlayerSpecialAction(suspect,SPECIAL_ACTION_NONE);
					RemovePlayerAttachedObject(suspect, 0);
					Kajdanki_PDkuje[suspect] = 0;
									
					SetPlayerInterior(suspect, 10);
				    new losuj= random(sizeof(Cela));
					SetPlayerPos(suspect, Cela[losuj][0], Cela[losuj][1], Cela[losuj][2]);
					PlayerInfo[suspect][pJailTime] = time * 60;
					if(bail == 1)
					{
						JailPrice[suspect] = bailprice;
                        SetPVarInt(suspect, "kaucja-dlaKogo", PlayerInfo[playerid][pMember]);
						format(string, sizeof(string), "Zosta³eœ uwiêziony na %d sekund.   Kaucja: $%d", PlayerInfo[suspect][pJailTime], JailPrice[suspect]);
						SendClientMessage(suspect, COLOR_LIGHTBLUE, string);
					}
					else
					{
					    JailPrice[suspect] = 0;
						format(string, sizeof(string), "Zosta³eœ uwiêziony na %d sekund.   Kaucja: Niedostêpna", PlayerInfo[suspect][pJailTime]);
						SendClientMessage(suspect, COLOR_LIGHTBLUE, string);
					}
					PlayerInfo[suspect][pJailed] = 1;
			        PlayerInfo[suspect][pArrested] += 1;
					PoziomPoszukiwania[suspect] = 0;
					SetPlayerWantedLevel(suspect, 0);
					WantLawyer[suspect] = 1;
				}//distance
			}//not connected
			else
			{
			    sendTipMessageEx(playerid, COLOR_GREY, "Nikt nie jest wystarczaj¹co blisko ciebie abyœ móg³ kogoœ aresztowaæ.");
			    return 1;
			}
		}
		else
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "Nie masz 3 rangi / nie jesteœ z PD/FBI/NG !");
		    return 1;
		}
	}//not connected
	return 1;
}
