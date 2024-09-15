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
command_aresztuj_Impl(playerid, params[256])
{
    new string[135];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
   	{
   	    if(IsAPolicja(playerid))
   	    {
   	        if(PlayerToPoint(10.0, playerid, 222.6395,114.3951,999.0156) //old komi
			|| IsPlayerInRangeOfPoint(playerid, 10.0, 268.3546, 83.0229, 1001.0391)//dillimore
			|| PlayerToPoint(10.0, playerid, -2614.1667,2264.6279,8.2109 ) //bayside
			|| PlayerToPoint(5, playerid, 1560.0333,-1638.6797,28.4881)//nowe komi 1
			|| PlayerToPoint(5, playerid, 1559.8517,-1646.9373,28.4881)//nowe komi 2
			|| PlayerToPoint(20.0,playerid,NG_JAIL_X, NG_JAIL_Y, NG_JAIL_Z) // stanowe
			|| PlayerToPoint(20.0,playerid,599.1960,-1489.5380,82.1648) // areszt fbi
			|| PlayerToPoint(10.0,playerid,194.6258,158.0858,1003.0234) // komi las venturas interior
			|| PlayerToPoint(10.0,playerid,193.9191,179.0882,1003.0234)) // komi las venturas interior
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
								if(PoziomPoszukiwania[playa] == 0)
								{
									sendTipMessageEx(playerid, COLOR_GRAD3, "Ten gracz nie ma WL.");
								}
						        else if(PoziomPoszukiwania[playa] >= 1 && PoziomPoszukiwania[playa] <= 5)
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
									SetPlayerWantedLevel(playa, 0);
                                    DajKase(playerid, depo3);
                                    new sejf = PlayerInfo[playerid][pMember] ? PlayerInfo[playerid][pMember] : PlayerInfo[playerid][pLider];
                                    if(sejf)
                                        Sejf_Add(sejf, depo2);
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

									// kajdanki - pomijalna redundancja, by unikn¹æ bugów
									UncuffPlayer(playa);
									UncuffPlayerCuffedBy(playerid);

									ClearAnimations(playa);
									SetPlayerSpecialAction(playa,SPECIAL_ACTION_NONE);
									RemovePlayerAttachedObject(playa, 0);
									Wchodzenie(playa);
									SetPlayerVirtualWorld(playa, 29);
								    new losuj= random(sizeof(Cela));
									SetPlayerPos(playa, Cela[losuj][0], Cela[losuj][1], Cela[losuj][2]);
									TogglePlayerControllable(playa, 0);
                                    Wchodzenie(playa);
									JailPrice[playa] = bail;
                                    SetPVarInt(playa, "kaucja-dlaKogo", PlayerInfo[playerid][pMember]);
									RemovePlayerWeaponsTemporarity(playa);//usun bron
									SetPlayerSpawnWeapon(playa);
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
								else if(PoziomPoszukiwania[playa] >= 6) //wsadzanie do stanowca
								{
									new Float:z;
									GetPlayerPos(playerid, z, z, z); // zeby nie wsadzali z recepcji
									if(!PlayerToPoint(20.0,playerid,NG_JAIL_X, NG_JAIL_Y, NG_JAIL_Z) && !(PlayerToPoint(20.0,playerid,599.1960,-1489.5380,82.1648) && z < 84) && !
									(PlayerToPoint(10.0,playerid,194.6258,158.0858,1003.0234) // komi las venturas interior
									|| PlayerToPoint(10.0,playerid,193.9191,179.0882,1003.0234))) // komi las venturas interior)
									{
								    	sendTipMessageEx(playerid, COLOR_GRAD3, "Ten gracz ma za du¿y WL alby wsadziæ go do zwyk³ej celi. WsadŸcie go do stanowego.");
									}
									else
									{
										new giveplayerid = playa;
										if(ProxDetectorS(10.0, playerid, giveplayerid))
										{
											new pricestan = PoziomPoszukiwania[giveplayerid]*2000;
											GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
											GetPlayerName(playerid, sendername, sizeof(sendername));
											format(string, sizeof(string), "* Uwiêzi³eœ %s w Wiêzieniu stanowym.", giveplayer);
											SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
											format(string, sizeof(string), "* %s Uwiêzi³ ciê w Wiêzieniu Stanowym i da³ grzywnê %d$, kaucji brak", sendername, pricestan/*PoziomPoszukiwania[giveplayerid]*50000*/);
											SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
											
											// kajdanki - pomijalna redundancja, by unikn¹æ bugów
											UncuffPlayer(playa);
											UncuffPlayerCuffedBy(playerid);
											
											JailDeMorgan(giveplayerid);
											RemovePlayerWeaponsTemporarity(playa);//usun bron
											SetPlayerSpawnWeapon(playa);
											if(PoziomPoszukiwania[giveplayerid] == 5)
											{
												PlayerInfo[giveplayerid][pJailTime] = 1500;
												DajKase(playerid, 20000);
												SendClientMessage(playerid, COLOR_GRAD1, "Kasa +20000");
											}
											else if(PoziomPoszukiwania[giveplayerid] == 6)
											{
												PlayerInfo[giveplayerid][pJailTime] = 1800;
												DajKase(playerid, 24000);
												SendClientMessage(playerid, COLOR_GRAD1, "Kasa +24000");
											}
											else if(PoziomPoszukiwania[giveplayerid] == 7)
											{
												PlayerInfo[giveplayerid][pJailTime] = 2100;
												DajKase(playerid, 28000);
												SendClientMessage(playerid, COLOR_GRAD1, "Kasa +28000");
											}
											else if(PoziomPoszukiwania[giveplayerid] == 8)
											{
												PlayerInfo[giveplayerid][pJailTime] = 2400;
												DajKase(playerid, 32000);
												SendClientMessage(playerid, COLOR_GRAD1, "Kasa +32000");
											}
											else if(PoziomPoszukiwania[giveplayerid] == 9)
											{
												PlayerInfo[giveplayerid][pJailTime] = 2700;
												DajKase(playerid, 36000);
												SendClientMessage(playerid, COLOR_GRAD1, "Kasa +36000");
											}
											else if(PoziomPoszukiwania[giveplayerid] == 10)
											{
												PlayerInfo[giveplayerid][pJailTime] = 3000;
												DajKase(playerid, 40000);
												SendClientMessage(playerid, COLOR_GRAD1, "Kasa +40000");
											}
											ZabierzKase(giveplayerid, pricestan);
											PoziomPoszukiwania[giveplayerid] = 0;
											SetPlayerWantedLevel(giveplayerid, 0);
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
											sendTipMessageEx(playerid, COLOR_GRAD3, "Ten gracz nie jest przy tobie.");
										}
									}
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
			    sendTipMessageEx(playerid, COLOR_GREY, "Musisz byæ przy celach/stanowym aby kogoœ zaaresztowaæ!");
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

//end
