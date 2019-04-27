//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ stanowe ]------------------------------------------------//
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

YCMD:stanowe(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(IsACop(playerid) && PlayerInfo[playerid][pRank] >= 0)
        {
            if(!PlayerToPoint(20.0,playerid,NG_JAIL_X, NG_JAIL_Y, NG_JAIL_Z))//nowe stanowe
			{
			    sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ przy celach FBI");
			    return 1;
			}
			new giveplayerid;
			if( sscanf(params, "k<fix>", giveplayerid))
			{
				sendTipMessage(playerid, "U¿yj /stanowe [playerid/CzêœæNicku]");
				return 1;
			}

			if (IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
			        if(giveplayerid == playerid) { sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz wsadziæ samego siebie do demorgan !"); return 1; }
			        if(PoziomPoszukiwania[giveplayerid] < 5) { sendTipMessageEx(playerid, COLOR_GREY, "Gracz musi mieæ przynajmniej 5 Wanted Level aby mo¿na by³o go wsadziæ do Fort DeMorgan !"); return 1; }
			        if(PlayerInfo[giveplayerid][pLider] == 2 || PlayerInfo[giveplayerid][pMember] == 2) { return 1; }
					if(ProxDetectorS(10.0, playerid, giveplayerid))
					{
					    new pricestan = PoziomPoszukiwania[giveplayerid]*2000;
						GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						format(string, sizeof(string), "* Uwiêzi³eœ %s w Wiêzieniu stanowym.", giveplayer);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* %s Uwiêzi³ ciê w Wiêzieniu Stanowym i da³ grzywnê %d$, kaucji brak", sendername, pricestan/*PoziomPoszukiwania[giveplayerid]*50000*/);
						SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
						JailDeMorgan(giveplayerid);
						ResetPlayerWeapons(giveplayerid);
						UsunBron(giveplayerid);//usun bron
						//JailPrice[giveplayerid] = PoziomPoszukiwania[giveplayerid]*50000;  
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
                        DajKase(giveplayerid, -pricestan);
                        PoziomPoszukiwania[giveplayerid] = 0;
					}
				}
				else
				{
				    sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest przy tobie !");
			    	return 1;
				}
			}
			else
			{
			    sendErrorMessage(playerid, "   Nie ma takiego gracza !");
			    return 1;
			}
		}
		else
		{
		    sendErrorMessage(playerid, "Nie jesteœ policjantem/nie masz 1 rangi !");
            return 1;
		}
	}
	return 1;
}
