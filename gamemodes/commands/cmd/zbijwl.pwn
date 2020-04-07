//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ zbijwl ]------------------------------------------------//
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

YCMD:zbijwl(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		if(PlayerInfo[playerid][pJob] == 2)
	 	{
	 	    new playa;
			if( sscanf(params, "k<fix>", playa))
			{
				sendTipMessage(playerid, "U¿yj /zbijwl [Nick/ID]");
				SendClientMessage(playerid, COLOR_GRAD3, "INFORMACJA: Komenda s³uzy do zbicia WL graczowi do 0");
				SendClientMessage(playerid, COLOR_RED, "WA¯NE: Koszt ponoszony podczas zbijania WL to [WL gracza * 700] - [skill * 100]");
				return 1;
			}


			if(IsPlayerConnected(playa))
		    {
   				if(playa != INVALID_PLAYER_ID)
			    {
				    if(GetDistanceBetweenPlayers(playerid,playa) < 10)
					{
					    if(PoziomPoszukiwania[playa] >= 1)
					    {
						    new koszt = PoziomPoszukiwania[playa] * 700;
						    new skill;
						    if(kaska[playerid] > koszt)
	   						{
	   						    if(playa != playerid)
								{
								    if(!PolicjantWStrefie(30.0, playa))
								    {
			   						    if(PlayerInfo[playerid][pLawSkill] <= 50)
			   						    {
			   						        skill = 0;
			   						        if(PoziomPoszukiwania[playa] > 3)
			   						        {
			   						            sendTipMessage(playerid, "Przestêpstwa powy¿ej 3 WL mog¹ zbijaæ bardziej doœwiadczeni prawnicy (2 skill)", COLOR_LIGHTBLUE);
			   						            return 1;
			   						        }
			   						    }
			   						    else if(PlayerInfo[playerid][pLawSkill] >= 51 && PlayerInfo[playerid][pLawSkill] <= 99)
			   						    {
			   						        skill = 200;
			   						        if(PoziomPoszukiwania[playa] > 5)
			   						        {
			   						            sendTipMessage(playerid, "Przestêpstwa federalne (powy¿ej 6 WL) mog¹ zbijaæ bardziej doœwiadczeni prawnicy (3 skill)", COLOR_LIGHTBLUE);
			   						            return 1;
			   						        }
			   						    }
			   						    else if(PlayerInfo[playerid][pLawSkill] >= 100 && PlayerInfo[playerid][pLawSkill] <= 199)
			   						    {
			   						        skill = 300;
			   						        skill = 200;
			   						        if(PoziomPoszukiwania[playa] > 7)
			   						        {
			   						            sendTipMessage(playerid, "Powa¿ne przestêpstwa federalne (powy¿ej 8 WL) mog¹ zbijaæ bardziej doœwiadczeni prawnicy (4 skill)", COLOR_LIGHTBLUE);
			   						            return 1;
			   						        }
			   						    }
			   						    else if(PlayerInfo[playerid][pLawSkill] >= 200 && PlayerInfo[playerid][pLawSkill] <= 399)
			   						    {
			   						        skill = 400;
			   						    }
			   						    else if(PlayerInfo[playerid][pLawSkill] >= 400 && PlayerInfo[playerid][pLawSkill] <= 999)
			   						    {
			   						        skill = 500;
			   						    }
			   						    else if(PlayerInfo[playerid][pLawSkill] >= 1000)
			   						    {
			   						        skill = 600;
			   						    }
			   						    PoziomPoszukiwania[playa] = 0;
										SetPlayerWantedLevel(playa, 0);
			   						    GetPlayerName(playerid, sendername, sizeof(sendername));
					        			GetPlayerName(playa, giveplayer, sizeof(giveplayer));
					        			new kosztskill = koszt-skill;
					        			format(string, sizeof(string), "* Zbi³eœ WL gracza %s do 0, koszt ³apówek dla PD: %d$",giveplayer, kosztskill);
									    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
								        format(string, sizeof(string), "* Prawnik %s zniwelowa³ twój Poziom Poszukiwania do 0", sendername);
								        SendClientMessage(playa, COLOR_LIGHTBLUE, string);
								        format(string, sizeof(string),"* %s wykonuje parê telefonów i obni¿a WL %s.", sendername, giveplayer);
										ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
										ZabierzKase(playerid, kosztskill);
										format(string, sizeof(string), "~r~-$%d", kosztskill);
										GameTextForPlayer(playerid, string, 5000, 1);
										format(string, sizeof(string), "~g~WL = 0");
										GameTextForPlayer(playa, string, 5000, 1);
										PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
										PlayerInfo[playerid][pLawSkill] ++;
										SendClientMessage(playerid, COLOR_GRAD2, "Skill +1");
										PlayerPlaySound(playa, 1150, 0.0, 0.0, 0.0);
									/*	if(hunterSeeMe[playa] > 0)
										{
											format(string, sizeof(string), "Poszukiwany %s przez lewiznê Policjantów zosta³ oczyszczony z zarzutów ((prawnik))", GetNick(playa));
											sendTipMessageEx(hunterSeeMe[playa], COLOR_RED, string);
											DestroyDynamicCP(chpIDHunter[playa]); 
										}*/
									}
									else
									{
									    sendErrorMessage(playerid, "Jesteœ zbyt blisko policjanta aby zbiæ komuœ WL!");
									}
								}
								else
								{
								    sendErrorMessage(playerid, "Nie mo¿esz zbiæ WL samemu sobie");
								}
							}
							else
							{
								format(string, sizeof(string), "Nie staæ ciê na to, potrzebujesz %d !", koszt);
						        sendErrorMessage(playerid, string);
						    }
						}
						else
						{
						    sendErrorMessage(playerid, "Ten gracz ma 0 poziom poszuiwania");
						}
					}
					else
					{
					    sendErrorMessage(playerid, "Gracz jest za daleko");
					}
				}
				else
				{
				    sendErrorMessage(playerid, "Nie ma takiego gracza");
				}
			}
	 	}
	 	else
	 	{
	 		sendErrorMessage(playerid, "Nie jesteœ prawnikiem");
		}
	}
	return 1;
}
