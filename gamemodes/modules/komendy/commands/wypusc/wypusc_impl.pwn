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
command_wypusc_Impl(playerid, params[256])
{
    new string[128];

    if(PlayerInfo[playerid][pJob] != 2)
    {
        sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ prawnikiem!");
        return 1;
    }
	new giveplayerid, money;
	if( sscanf(params, "k<fix>d", giveplayerid, money))
	{
		sendTipMessage(playerid, "U¿yj /uwolnij [playerid/CzêœæNicku] [Kwota]");
		return 1;
	}
	if(playerid == giveplayerid)
	{
		sendTipMessage(playerid, "Nie mo¿esz uwolniæ samego siebie!");
		return 1;
	}
	if(money > 250000)
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Nie przesadzasz troszkê? Maksymalna kwota uwolnienia to 250.000$");
		return 1;
	}
	if(money < 40000)
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Minimalna kwota uwolnienia to 40.000$"); 
		return 1;
	}
	if(ApprovedLawyer[playerid] == 0)
	{
		sendErrorMessage(playerid, "Nie masz pozwolenia prawniczego!"); 
		return 1;
	}
	if(PlayerInfo[playerid][pJailed] > 0)
	{
		sendErrorMessage(playerid, "Nie mo¿esz uwalniaæ bêdac w wiezieniu!");
		return 1;
	}
	if(IsPlayerConnected(giveplayerid))
	{
		if(giveplayerid != INVALID_PLAYER_ID)
		{
			if(PlayerInfo[giveplayerid][pJailed] == 1  && ApprovedLawyer[playerid] == 1 || PlayerInfo[giveplayerid][pJailed] == 2 && ApprovedLawyer[playerid] == 1)
			{
				if(ProxDetectorS(20.0, playerid, giveplayerid))
				{
					format(string, sizeof(string), "Prawnik %s proponuje Ci uwolnienie z wiêzienia za %d$ {AC3737}[Aby akceptowaæ wpisz /akceptuj uwolnienie]", GetNick(playerid), money);
					SendClientMessage(giveplayerid, COLOR_BLUE, string);
					
					format(string, sizeof(string), "Zaoferowa³eœ uwolnienie %s z wiêzienia za kwotê %d$ - oczekuj na akceptacjê!", GetNick(giveplayerid), money); 
					SendClientMessage(playerid, COLOR_BLUE, string);
					
					LawyerOffer[giveplayerid] = 1;
					OfferPlayer[giveplayerid] = playerid;
					OfferPrice[giveplayerid] = money;
				
				}
				else
				{
					sendErrorMessage(playerid, "Nie mo¿esz uwolniæ gracza, który nie jest przy tobie!"); 
					return 1;
				}
			
			
			}
			else
			{
				sendErrorMessage(playerid, "Nie jesteœ prawniekiem || Osoba nie jest w wiêzieniu || Nie masz pozwolenia");
				return 1;
			}
		
		
		}
		else
		{
			sendErrorMessage(playerid, "Nie mo¿esz uwolniæ samego siebie"); 
			return 1;
		}
	
	}
	else
	{
		sendErrorMessage(playerid, "Na serwerze nie ma takiego gracza!"); 
		return 1;
	}
	return 1;
}

//end
