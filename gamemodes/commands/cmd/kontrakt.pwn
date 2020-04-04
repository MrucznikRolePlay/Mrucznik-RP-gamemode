//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ kontrakt ]-----------------------------------------------//
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

YCMD:kontrakt(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
   	{
		new giveplayerid, moneys;
		if( sscanf(params, "k<fix>d", giveplayerid, moneys))
		{
			sendTipMessage(playerid, "U¿yj /kontrakt [playerid/CzêœæNicku] [kwota]");
			return 1;
		}

		if(moneys < 30000 || moneys > 1000000) { sendTipMessageEx(playerid, COLOR_GREY, "Kontrakt musi wynosiæ od $30 000, do $1 000 000!"); return 1; }
		if(PlayerInfo[playerid][pLevel] < 3)
		{
			sendTipMessageEx(playerid, COLOR_GRAD1, "Musisz mieæ 3 lvl aby podpisywaæ kontrakty.");
			return 1;
		}
		if (IsPlayerConnected(giveplayerid))
		{
			if(PlayerInfo[playerid][pMember] == 8 )
			{
				sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz podpisaæ kontraktu bêd¹c hitmanem!");
				return 1;
			}
			else if(PlayerInfo[playerid][pMember] == 8)
			{
				sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz podpisaæ kontraktu bêd¹c hitmanem!");
				return 1;
			}
			else if(PlayerInfo[giveplayerid][pMember] == 8||PlayerInfo[giveplayerid][pLider] == 8)
			{
				sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz podpisaæ kontraktu na te osobe !");
				return 1;
			}
			else if(PlayerInfo[giveplayerid][pAdmin] >= 1 || PlayerInfo[giveplayerid][pHalfAdmin] >= 1 || IsAScripter(giveplayerid))
			{
				sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz podpisaæ kontraktu na te osobe !");
				return 1;
			}
			if(PlayerInfo[giveplayerid][pLider] >= 1 && moneys < 100000)
			{
				sendTipMessageEx(playerid, COLOR_GREY, "Za g³owê lidera trzeba zap³aciæ conajmniej 100000$ !");
				return 1;
			}
			else if(IsAPolicja(giveplayerid) && moneys < 50000)
			{
				sendTipMessageEx(playerid, COLOR_GREY, "Za g³owê policjanta trzeba zap³aciæ conajmniej 50000$ !");
				return 1;
			}
			else if(PlayerInfo[giveplayerid][pMember] >= 1 && moneys < 20000)
			{
				sendTipMessageEx(playerid, COLOR_GREY, "Za g³owê cz³onka organizacji trzeba zap³aciæ conajmniej 20000$ !");
				return 1;
			}
			if(giveplayerid == playerid) { sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz daæ kontraktu na samego siebie!"); return 1; }
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new playermoney = kaska[playerid];
			if (moneys > 0 && playermoney >= moneys)
			{
				ZabierzKase(playerid, moneys);
				PlayerInfo[giveplayerid][pHeadValue]+=moneys;
				format(string, sizeof(string), "%s podpisa³ kontrakt na %s, nagroda za wykonanie $%d.",sendername, giveplayer, moneys);
				SendFamilyMessage(8, COLOR_YELLOW, string);
				format(string, sizeof(string), "* Podpisa³eœ kontrakt na %s, za $%d.",giveplayer, moneys);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			else
			{
				sendTipMessageEx(playerid, COLOR_GRAD1, "Z³a kwota.");
			}
		}
		else
		{
			format(string, sizeof(string), "   Gracz o ID %d nie istnieje.", giveplayerid);
			sendErrorMessage(playerid, string);
		}
	}
	return 1;
}
