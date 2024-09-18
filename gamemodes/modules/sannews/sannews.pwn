//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  sannews                                                  //
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
// Autor: Simeone
// Data utworzenia: 13.09.2019
//Opis:
/*
	Komendy, funkcje i wykorzystania frakcji San News i powi¹zanych z nimi podfrakcji (telewizja, kluby)
*/

//

//-----------------<[ Funkcje: ]>-------------------
stock IsASN(playerid)
{
	if(PlayerInfo[playerid][pMember] == FRAC_SN || PlayerInfo[playerid][pLider] == FRAC_SN)
	{
		return true;
	}
	return false; 
}
stock InTheFractionCar(playerid, frac)
{
	new carID = GetPlayerVehicleID(playerid);
	new bool:inPos=false;
	for(new i=0;i<MAX_VEHICLES;i++)
	{
		if(Car_GetOwner(i) == frac && Car_GetOwnerType(i) == CAR_OWNER_FRACTION)
		{
			if(carID == i)
			{
				inPos = true;
				break;
			}
		}
	}
	if(inPos)
	{
		return true; 
	}
	return false; 
}
stock PlayerConditionToNews(playerid)
{
	if(PlayerInfo[playerid][pMuted] == 1)
    {
        sendTipMessageEx(playerid, TEAM_CYAN_COLOR, "Nie mo¿esz mówiæ poniewa¿ zosta³eœ wyciszony");
        return false;
    }
    if(GetPlayerAdminDutyStatus(playerid) == 1)
    {
        sendErrorMessage(playerid, "Nie mo¿esz u¿ywaæ /news podczas s³u¿by administratora!"); 
        return false;
    }
	if(InTheFractionCar(playerid, FRAC_SN))
	{
		return true; 
	}
	if(GetPLocal(playerid) == PLOCAL_ORG_SN)
	{
		return true; 
	}
	return false; 
}

TalkOnNews(playerid, const text[])
{
	new string[256]; 
	format(string, sizeof(string), "Reporter %s: %s", GetNick(playerid), text); 
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(!gNews[i] && PlayerPersonalization[i][PERS_AD] == 0)
		    {
				SendClientMessage(i, COLOR_NEWS, string);
			}
		}
	}
	//Anty Spam
	SetTimerEx("AntySpamTimer",3000,0,"d",playerid);
	AntySpam[playerid] = 1;
	//Wiadomoœæ na discorda MRP
	SendDiscordMessage(DISCORD_SAN_NEWS, string);
	return 1;
}
//end