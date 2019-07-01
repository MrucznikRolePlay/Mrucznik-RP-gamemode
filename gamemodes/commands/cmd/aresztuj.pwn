//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ aresztuj ]-----------------------------------------------//
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

YCMD:aresztuj(playerid, params[], help)
{
	new string[135];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
   	{
   	    if(IsACop(playerid))
   	    {
   	        if(PlayerToPoint(10.0, playerid, 222.6395,114.3951,999.0156) //old komi
			|| IsPlayerInRangeOfPoint(playerid, 10.0, 268.3546, 83.0229, 1001.0391)//dillimore
			|| PlayerToPoint(10.0, playerid, -2614.1667,2264.6279,8.2109 ) //bayside
			|| PlayerToPoint(5, playerid, -1681.1091,917.8300,-52.4141) )//nowe komi by dywan
			{

		   	    new playa;
				if( sscanf(params, "k<fix>", playa))
				{
					sendTipMessage(playerid, "U¿yj /aresztuj [playerid/CzêœæNicku]");
					return 1;
				}


				if(IsPlayerConnected(playa))
				{
				    if(playa != INVALID_PLAYER_ID)
				    {
				        if(ProxDetectorS(10.0, playerid, playa))
						{
						    if(playerid != playa)
						    {
						        if(PoziomPoszukiwania[playa] >= 1 && PoziomPoszukiwania[playa] <= 5)
						        {
                                    
						            new price = PoziomPoszukiwania[playa]*4000;
						            new price2 = PoziomPoszukiwania[playa]*1000;
						            new bail = PoziomPoszukiwania[playa]*16000;
						            new jt = PoziomPoszukiwania[playa]*200;
						            //DajKase(playerid, price);
								    ZabierzKase(playa, price2);
	                                GetPlayerName(playa, giveplayer, sizeof(giveplayer));
	                                GetPlayerName(playerid, sendername, sizeof(sendername));
                                    new depo2 = floatround(((price/100) * 80), floatround_round);
                                    new depo3 = floatround(((price/100) * 20), floatround_round);
                                    PoziomPoszukiwania[playa] = 0;
                                    zakuty[playa] = 0;//Kajdany
                                    uzytekajdanki[playa] = 0;
                                    PDkuje[playerid] = 0;
                                    uzytekajdanki[playerid] = 0;
                                    DajKase(playerid, depo3);
                                    Sejf_Add(PlayerInfo[playerid][pMember], depo2);
								    format(string, sizeof(string), "Uwiêzi³eœ %s, nagroda za przestêpcê: %d. Otrzymujesz $%d", giveplayer, price, depo3);
                                   // format(string, sizeof(string), "* Uwiêzi³eœ %s w Wiêzieniu, nagroda za przestêpcê: %d", giveplayer, price);
                                    //DajKase(playerid, price);
									SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
									PlayerInfo[playa][pJailed] = 1;
								    PlayerInfo[playa][pJailTime] = jt;
								    format(string, sizeof(string), "* Jesteœ w wiêzieniu na %d Sekund i otrzyma³eœ grzywnê w wysokoœci $%d, kaucja to: %d$.", PlayerInfo[playa][pJailTime], price,bail);
								    SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                                    poscig[playa] = 0;
									WantLawyer[playa] = 1;
									PlayerInfo[playa][pArrested] += 1;
									SetPlayerVirtualWorld(playa, 1);
								    new losuj= random(sizeof(Cela));
									SetPlayerPosEx(playa, Cela[losuj][0], Cela[losuj][1], Cela[losuj][2]);
									TogglePlayerControllable(playa, 0);
                                    Wchodzenie(playa);
									JailPrice[playa] = bail;
                                    SetPVarInt(playa, "kaucja-dlaKogo", PlayerInfo[playerid][pMember]);
									ClearAnimations(playa);
									SetPlayerSpecialAction(playa,SPECIAL_ACTION_NONE);
									RemovePlayerAttachedObject(playa, 0);
									SkutyGracz[playa] = 0;
									ResetPlayerWeapons(playa);
									UsunBron(playa);//usun bron

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
								}
								else
								{
									if(PoziomPoszukiwania[playa] > 1)
								    sendTipMessageEx(playerid, COLOR_GRAD3, "Ten gracz ma za du¿y WL alby wsadziæ go do zwyk³ej celi. WsadŸcie go do stanowego.");
									else
									sendTipMessageEx(playerid, COLOR_GRAD3, "Ten gracz nie ma WL.");
								}
							}
							else
							{
								sendTipMessageEx(playerid, COLOR_GRAD3, "Nie mo¿esz wsadziæ samego siebie do celi.");
							}
						}
						else
						{
							sendTipMessageEx(playerid, COLOR_GRAD3, "Gracz jest za daleko.");
						}
					}
					else
					{
						sendTipMessageEx(playerid, COLOR_GRAD3, "Nie ma takiego gracza.");
					}
				}
				else
				{
					sendErrorMessage(playerid, "Nie ma takiego gracza.");
				}
			}
			else
			{
			    sendTipMessageEx(playerid, COLOR_GREY, "   Musisz byæ przy celach aby kogoœ zaaresztowaæ !");
			    return 1;
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie jesteœ z Policji.");
		}
	}
	return 1;
}
