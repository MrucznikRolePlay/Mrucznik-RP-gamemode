

SprawdzAktywacjeMC(playerid, email[], kod[])
{
	if(regex_match(email, "^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$") <= 0)
    {
        DialogAktywujMC_Fail(playerid, "Niepoprawny format adresu e-mail.");
        return;
    }

	if(regex_match(kod, "^([a-zA-Z0-9]{4}-){4}[a-zA-Z0-9]{4}$") <= 0)
    {
        DialogAktywujMC_Fail(playerid, "Niepoprawny format kluczu licencyjnego.");
        return;
    }

	_MruGracz(playerid, "Trwa aktywacja Mrucznik Coinów...");

	// send request, response handler: OnMCInfoCompleted
	new query[1024];
	format(query, sizeof(query), "?info&key=%s&identifier=%s", kod, email);
	print(query);
	new Request:id = RequestJSON(PremiumRequestClient, query, HTTP_METHOD_POST, "OnMCInfoCompleted", JsonObject(), .headers = RequestHeaders());

	// pass playerid to request handling
	MAP_insert_val_val(PremiumRequestToPlayerID, _:id, playerid);
	SetPVarInt(playerid, "mc_request", _:id);
    return;
}

AktywujMC(playerid, email[], kod[], mc)
{
	_MruGracz(playerid, "Znaleziono Paczkê MC, trwa aktywacja...");

	// send request, response handler: OnMCActivationCompleted
	new query[1024];
	format(query, sizeof(query), "?activate&key=%s&identifier=%s&setIdentifier=0&extra=%%7B%%22UID%%22%%3A%d%%2C%%22Nick%%22%%3A%%22%s%%22%%7D",
		kod, email, PlayerInfo[playerid][pUID], GetNick(playerid));
	print(query);
	new Request:id = RequestJSON(PremiumRequestClient, query, HTTP_METHOD_POST, "OnMCActivationCompleted", JsonObject(), .headers = RequestHeaders());

	// pass playerid & mc to request handling
	MAP_insert_val_val(PremiumRequestToPlayerID, _:id, playerid);
	SetPVarInt(playerid, "mc_request", _:id);
	SetPVarInt(playerid, "mc_request_amount", mc);
}

forward OnMCInfoCompleted(Request:id, E_HTTP_STATUS:status, Node:node);
public OnMCInfoCompleted(Request:id, E_HTTP_STATUS:status, Node:node)
{
	new playerid = MAP_get_val_val(PremiumRequestToPlayerID, _:id);
    MAP_remove_val(PremiumRequestToPlayerID, _:id);

    if(status == HTTP_STATUS_OK) 
	{
		new playerRequestID = GetPVarInt(playerid, "mc_request");
		if(playerRequestID != _:id)
		{
			DialogAktywujMC_Fail(playerid, "Brak spójnoœci ID.");
			return;
		}

		new pack_id;
    	new err = JsonGetInt(node, "purchase_pkg", pack_id);
		if(err)
		{
			DialogAktywujMC_Fail(playerid, "Nie uda³o siê odczytaæ odpowiedzi systemu sprawdzania paczki.");
			return;
		}

		new mc = PobierzMcPaczki(pack_id);
		if(mc <= 0)
		{
			DialogAktywujMC_Fail(playerid, "Ten klucz licencyjny nie aktywuje paczki Mrucznik Coinów.");
			return;
		}

		new email[256], kod[64];
		GetPVarString(playerid, "mc_email", email, 256);
		GetPVarString(playerid, "mc_kod", kod, 64);

		// send request, handler: OnMCActivationCompleted
		AktywujMC(playerid, email, kod, mc);
	}
	else
	{
		DialogAktywujMC_Fail(playerid, "Niepoprawna odpowiedŸ systemu sprawdzania paczki.");
	}
	return;
}

forward OnMCActivationCompleted(Request:id, E_HTTP_STATUS:status, Node:node);
public OnMCActivationCompleted(Request:id, E_HTTP_STATUS:status, Node:node) 
{
	new playerid = MAP_get_val_val(PremiumRequestToPlayerID, _:id);
    MAP_remove_val(PremiumRequestToPlayerID, _:id);

    if(status == HTTP_STATUS_OK) 
	{
		new playerRequestID = GetPVarInt(playerid, "mc_request");
		if(playerRequestID != _:id)
		{
			DialogAktywujMC_Fail(playerid, "Brak spójnoœci ID.");
			return;
		}

		new response[64];
	    new err = JsonGetString(node, "response", response);
		if(err) 
		{
			DialogAktywujMC_Fail(playerid, "Nie uda³o siê odczytaæ odpowiedzi systemu aktywacji paczki.");
			return;
		}

		if(strcmp(response, "OKAY", true) != 0)
		{
			DialogAktywujMC_Fail(playerid, "System aktywacji paczki nie odpowiedzia³ OK.");
			return;
		}

		new mc = GetPVarInt(playerid, "mc_request_amount");
		if(mc <= 0)
		{
			DialogAktywujMC_Fail(playerid, "System aktywacji paczki nie otrzyma³ poprawnej iloœci Mrucznik Coinów.");
			return;
		}

		// nadaj MC
		DajMC(playerid, mc);
		Log(premiumLog, INFO, "%s aktywowa³ paczkê z %d Mrucznik Coinami", GetPlayerLogName(playerid), mc);

		// komunikat
		new string[64];
		format(string, sizeof(string),"Paczka %d Mrucznik Coinów aktywowana!", mc);
		_MruGracz(playerid, string);
		DialogAktywujMC_Success(playerid, mc);

		// muzyka mission passed
		PlayerPlaySound(playerid, 183, 0.0, 0.0, 0.0);
		SetTimerEx("StopPlayerSound", 8200, false, "%d", playerid);
    }
	else if(status == HTTP_STATUS_BAD_REQUEST)
	{
		new errorCode[64];
		JsonGetString(node, "errorCode", errorCode, sizeof(errorCode));

		if(strcmp(errorCode, "MAX_USES", true) == 0)
		{
			DialogAktywujMC_Fail(playerid, "Ten kod by³ ju¿ aktywowany wczeœniej.");
			return;
		}
		
		DialogAktywujMC_Fail(playerid, "Niepoprawna odpowiedŸ systemu aktywacji paczki.");
	}
	else
	{
		DialogAktywujMC_Fail(playerid, "Nierozpoznana odpowiedŸ systemu aktywacji paczki.");
	}
	return;
}
