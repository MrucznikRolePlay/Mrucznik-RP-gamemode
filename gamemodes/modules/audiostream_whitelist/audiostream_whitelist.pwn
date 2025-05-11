//-----------------------------------------------<< Source >>------------------------------------------------//
//                                           audiostream_whitelist                                           //
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
// Autor: wiger
// Data utworzenia: 13.04.2025
//Opis:
/*
	Whitelista domen dla masowych audiostreamow
*/

//

//-----------------<[ Funkcje: ]>-------------------

ValidateAudioStreamURL(const url[]) {
	new schemeEnd = strfind(url, "://");
	if (schemeEnd == -1)
		return -2;
	schemeEnd += 3;
	new atSignSeen = strfind(url, "@", true, schemeEnd);
	if (atSignSeen != -1)
		return -2;
	new netlocEnd = strfind(url, ":", true, schemeEnd);
	if (netlocEnd == -1)
		netlocEnd = strfind(url, "/", true, schemeEnd);
	if (netlocEnd == -1)
		netlocEnd = strlen(url);
	new netloc[256];
	strmid(netloc, url, schemeEnd, netlocEnd);

	for (new i=0; i<sizeof(radioDomainWhitelist); i++) {
		new iLen = strlen(radioDomainWhitelist[i]);
		new netlocLen = strlen(netloc);
		if (netlocLen < iLen)
			continue;
		// if netloc is longer than i, make sure it's because of a subdomain
		if (netlocLen > iLen) {
			if (netloc[netlocLen-iLen-1] != '.')
				continue;
		}
		// netloc endswith i
		new domain[256];
		strmid(domain, netloc, netlocLen-iLen, netlocLen);
		if (!strcmp(domain, radioDomainWhitelist[i], true)) {
			return 0;
		}
	}
	return -1;
}

ValidateURLAndNotify(playerid, const url[]) {
	new ret = ValidateAudioStreamURL(url);
	switch (ret) {
		case -1: {
			MruMessageFail(playerid, "Niedozwolona domena");
		}
		case -2: {
			MruMessageFail(playerid, "Niepoprawny URL");
		}
		case 0: {
			Log(serverLog, INFO, "%s utworzy³ audiostream: [%s]", GetPlayerLogName(playerid), url);
		}
	}
	return ret;
}

//end