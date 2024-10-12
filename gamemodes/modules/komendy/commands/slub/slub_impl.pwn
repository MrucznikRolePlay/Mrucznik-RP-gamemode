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
command_slub_Impl(playerid, params[256])
{
    new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(kaska[playerid] < 100000)
        {
            sendTipMessageEx(playerid, COLOR_GREY, "Œlub z weselem kosztuje $100 000 !");
            return 1;
        }
        if(PlayerInfo[playerid][pMarried] > 0)
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "Jesteœ ju¿ w zwi¹zku ma³¿eñskim !");
			return 1;
        }
        new giveplayerid;
		if( sscanf(params, "k<fix>", giveplayerid))
		{
			sendTipMessage(playerid, "U¿yj /slub [playerid/CzêœæNicku]");
			return 1;
		}

	    if(IsPlayerConnected(giveplayerid))
		{
		    if(giveplayerid != INVALID_PLAYER_ID)
		    {
		        if(PlayerInfo[giveplayerid][pMarried] > 0)
		        {
		            sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz jest ju¿ w zwi¹zku ma³¿eñskim !");
		            return 1;
		        }
		        if (ProxDetectorS(8.0, playerid, giveplayerid))
				{
				    if(giveplayerid == playerid) { sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz wzi¹æ œlubu sam ze sob¹!"); return 1; }
				    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "* Oœwiadczy³eœ siê %s.", giveplayer);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "* %s chcê wzi¹æ z tob¹ œlub (wpisz /akceptuj slub) aby zaakceptowaæ.", sendername);
					SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
			        ProposeOffer[giveplayerid] = playerid;
				}
				else
				{
					sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest przy tobie !");
					return 1;
				}
		    }
		}
		else
		{
		    sendErrorMessage(playerid, "Nie ma takiego gracza!");
		    return 1;
		}
    }
    return 1;
}

//end
