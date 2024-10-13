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

	if(!IsAPolicja(playerid))
	{
		sendErrorMessage(playerid, "Nie jesteœ z Policji.");
		return 1;
	}
	if(!IsAtArrestPlace(playerid) && !IsAtStateArrestPlace(playerid))
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Musisz byæ przy celach/stanowym aby kogoœ zaaresztowaæ!");
		return 1;
	}

	new giveplayerid;
	if( sscanf(params, "k<fix>", giveplayerid))
	{
		sendTipMessage(playerid, "U¿yj /aresztuj [playerid/CzêœæNicku]");
		return 1;
	}

	if(!IsPlayerConnected(giveplayerid) || giveplayerid == INVALID_PLAYER_ID)
	{
		sendTipMessageEx(playerid, COLOR_GRAD3, "Nie ma takiego gracza.");
		return 1;
	}

	if(!ProxDetectorS(10.0, playerid, giveplayerid))
	{
		sendTipMessageEx(playerid, COLOR_GRAD3, "Gracz jest za daleko.");
		return 1;
	}

	if(playerid == giveplayerid)
	{
		sendTipMessageEx(playerid, COLOR_GRAD3, "Nie mo¿esz wsadziæ samego siebie do celi.");
		return 1;
	}

	if(PoziomPoszukiwania[giveplayerid] == 0)
	{
		sendTipMessageEx(playerid, COLOR_GRAD3, "Ten gracz nie ma WL.");
		return 1;
	}

	if(PoziomPoszukiwania[giveplayerid] >= 1 && PoziomPoszukiwania[giveplayerid] <= 5)
	{
		new price = PoziomPoszukiwania[giveplayerid]*4000;
		new price2 = PoziomPoszukiwania[giveplayerid]*1000;
		new bail = PoziomPoszukiwania[giveplayerid]*16000;
		new jt = PoziomPoszukiwania[giveplayerid]*200;
		
		ZabierzKase(giveplayerid, price2);
		GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		new depo2 = floatround(((price/100) * 80), floatround_round);
		new depo3 = floatround(((price/100) * 20), floatround_round);
		PoziomPoszukiwania[giveplayerid] = 0;
		SetPlayerWantedLevel(giveplayerid, 0);
		DajKase(playerid, depo3);
		new sejf = PlayerInfo[playerid][pMember] ? PlayerInfo[playerid][pMember] : PlayerInfo[playerid][pLider];
		if(sejf)
			Sejf_Add(sejf, depo2);
		format(string, sizeof(string), "Uwiêzi³eœ %s, nagroda za przestêpcê: %d. Otrzymujesz $%d", giveplayer, price, depo3);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
		PlayerInfo[giveplayerid][pJailed] = 1;
		PlayerInfo[giveplayerid][pJailTime] = jt;
		format(string, sizeof(string), "* Jesteœ w wiêzieniu na %d Sekund i otrzyma³eœ grzywnê w wysokoœci $%d, kaucja to: %d$.", PlayerInfo[giveplayerid][pJailTime], price,bail);
		SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
		poscig[giveplayerid] = 0;
		WantLawyer[giveplayerid] = 1;
		PlayerInfo[giveplayerid][pArrested] += 1;

		// kajdanki - pomijalna redundancja, by unikn¹æ bugów
		UncuffPlayer(giveplayerid);
		UncuffPlayerCuffedBy(playerid);

		ClearAnimations(giveplayerid);
		SetPlayerSpecialAction(giveplayerid,SPECIAL_ACTION_NONE);
		RemovePlayerAttachedObject(giveplayerid, 0);
		SetPlayerArrestPos(giveplayerid);
		JailPrice[giveplayerid] = bail;
		SetPVarInt(giveplayerid, "kaucja-dlaKogo", PlayerInfo[playerid][pMember]);
		RemovePlayerWeaponsTemporarity(giveplayerid);//usun bron
		SetPlayerSpawnWeapon(giveplayerid);
		SendArrestMessage(playerid, giveplayerid);
	}
	else if(PoziomPoszukiwania[giveplayerid] >= 6) //wsadzanie do stanowca
	{
		new Float:z;
		GetPlayerPos(playerid, z, z, z); // zeby nie wsadzali z recepcji
		if(!IsAtStateArrestPlace(playerid))
		{
			sendTipMessageEx(playerid, COLOR_GRAD3, "Ten gracz ma za du¿y WL alby wsadziæ go do zwyk³ej celi. WsadŸcie go do stanowego.");
		}
		else
		{
			new pricestan = PoziomPoszukiwania[giveplayerid]*2000;
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "* Uwiêzi³eœ %s w Wiêzieniu stanowym.", giveplayer);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			format(string, sizeof(string), "* %s Uwiêzi³ ciê w Wiêzieniu Stanowym i da³ grzywnê %d$, kaucji brak", sendername, pricestan);
			SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
			
			// kajdanki - pomijalna redundancja, by unikn¹æ bugów
			UncuffPlayer(giveplayerid);
			UncuffPlayerCuffedBy(playerid);
			
			JailDeMorgan(giveplayerid);
			RemovePlayerWeaponsTemporarity(giveplayerid);//usun bron
			SetPlayerSpawnWeapon(giveplayerid);

			new multiplier = PoziomPoszukiwania[giveplayerid] - 5;
			new reward = 20000 + 4000*multiplier;
			PlayerInfo[giveplayerid][pJailTime] = 1500 + 300*multiplier;
			DajKase(playerid, reward);
			SendClientMessage(playerid, COLOR_GRAD1, sprintf("Kasa +%d$", reward));
			ZabierzKase(giveplayerid, pricestan);
			PoziomPoszukiwania[giveplayerid] = 0;
			SetPlayerWantedLevel(giveplayerid, 0);
			SendArrestMessage(playerid, giveplayerid);
		}
	}
	return 1;
}

SendArrestMessage(playerid, giveplayerid)
{
	new fracName[40];
	if(GetPlayerFraction(playerid) == FRAC_LSPD) strcat(fracName, "Policjant");
	else if(GetPlayerFraction(playerid) == FRAC_FBI) strcat(fracName, "Policjant");
	else if(GetPlayerFraction(playerid) == FRAC_NG) strcat(fracName, "Policjant");
	else strcat(fracName, "Funkcjonariusz");

	OOCNews(COLOR_LIGHTRED, sprintf("<< %s %s aresztowa³ podejrzanego %s >>", 
		fracName, GetNick(playerid), GetNick(giveplayerid)));
}

//end
