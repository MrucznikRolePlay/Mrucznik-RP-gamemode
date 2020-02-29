//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ worek ]-------------------------------------------------//
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
	Creative 27 luty 2020
*/


// Notatki skryptera:
/*
	
*/

YCMD:worek(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		if(IsAPrzestepca(playerid))
		{
		    new giveplayerid;
			if( sscanf(params, "k<fix>", giveplayerid))
			{
				sendTipMessage(playerid, "U¿yj /worek [playerid/CzêœæNicku]");
				return 1;
			}

			if(giveplayerid == playerid) { sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz za³o¿yæ samemu sobie worka!"); return 1; }

		    if(IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
					if(!ProxDetectorS(8.0, playerid, giveplayerid))
					{
						sendTipMessageEx(playerid, COLOR_GREY, "U¿yj /worek [playerid/CzêœæNicku] bêd¹c w pobli¿u ofiary !");
						return 1;
					}

					if(GetPVarInt(giveplayerid, "ma_worek"))
				    {
						GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						format(string, sizeof(string), "* %s œci¹gn¹³ Ci worek z g³owy, odzyska³eœ orientacjê w terenie.", sendername);
						SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* Œci¹gn¹³eœ %s worek z g³owy.", giveplayer);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* %s œci¹ga %s worek z g³owy.", sendername ,giveplayer);
						ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						
						DeletePVar(GetPVarInt(giveplayerid, "ma_worek"), "uzyl_worek");
						DeletePVar(giveplayerid, "ma_worek");
						UnHave_Worek(giveplayerid);
					}
					else
					{	
						if(GetPVarInt(playerid, "uzyl_worek"))
						{
							sendTipMessageEx(playerid, COLOR_GREY, "Masz tylko jeden worek, zdejmij go poprzedniej osobie !");
							return 1;
						}
						else
						{
							GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
							GetPlayerName(playerid, sendername, sizeof(sendername));
					        format(string, sizeof(string), "* %s za³o¿y³ Ci worek na g³owê, straci³eœ orientacjê w terenie.", sendername);
							SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string), "* Za³o¿y³eœ %s worek na g³owê.", giveplayer);
							SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string), "* %s zak³ada %s worek na g³owê.", sendername ,giveplayer);
							ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

							SetPVarInt(playerid, "uzyl_worek", giveplayerid);
							SetPVarInt(giveplayerid, "ma_worek", playerid);
							Have_Worek(giveplayerid);

							//SetTimerEx("timer_MaWorek",2000,0,"d",giveplayerid);
							//todo timer:
							//osoba musi byc ranna/pobita, jezeli zakladajacy worek oddali sie na ~50 metrow lub wyjdzie z gry lub pojdzie afk dluzej niz 2 minuty worek zostanie zdjety
						}
					}
				}
			}
			else
			{
			    sendErrorMessage(playerid, "Nie ma takiego gracza !");
			    return 1;
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
