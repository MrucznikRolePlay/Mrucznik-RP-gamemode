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
	new netlocEnd = strfind(url, "/", true, schemeEnd);
	if (netlocEnd == -1)
		netlocEnd = strlen(url);
	new netloc[256];
	strmid(netloc, sizeof(netloc), schemeEnd+3, netlocEnd);
	printf("%s ==> %s", url, netloc);

	for (new i=0; i<sizeof(radioDomainWhitelist); i++) {
		// netloc.endswith(radioDomainWhitelist[i])
		new iLen = strlen(radioDomainWhitelist[i]);
		new netlocLen = strlen(netloc)
		if (netlocLen < iLen) continue;
		new domain[256];
		strmid(domain, netloc, netlocLen-iLen, netlocLen);
		printf("%s", domain);
		if (!strcmp(domain, radioDomainWhitelist[i], true))
			return 0;
	}
	return -1;
}

//end