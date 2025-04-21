//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   orgbiz                                                  //
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
// Data utworzenia: 08.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_orgbiz_Impl(playerid, action[16], params[128])
{
    new org = GetPlayerOrg(playerid);
    if(org == 0)
    {
        noAccessMessage(playerid);
        return 1;
    }

    if(strcmp(action, "lista", true) == 0 || strcmp(action, "list", true) == 0)
    {
        SendClientMessage(playerid, COLOR_GREEN, "|_______________ Biznesy organizacji _______________|");
        new string[MAX_MESSAGE_LENGTH];
        for(new i; i<sizeof(FrontBusiness); i++)
        {
            if(FrontBusiness[i][Owner] == org)
            {
                new hour, minute, endHour, endMinute;
                GetOrgTakeoverTimeWindow(i, hour, minute, endHour, endMinute);
                if(IsPlayerOrgLeader(playerid))
                {
                    new profit = RedisGetInt(RedisFrontBizKey(i, "profit"));
                    new leaderProfit = RedisGetInt(RedisFrontBizKey(i, "leaderProfit"));

                    format(string, sizeof(string), "- [%d] %s | Do przej�cia w godzinach: %02d:%02d - %02d:%02d | Wygenerowany przych�d: %d$ (%d$ do sejfu)", 
                        i, FrontBusiness[i][Name], 
                        hour, minute, endHour, endMinute,
                        profit, leaderProfit);
                }
                else
                {
                    format(string, sizeof(string), "- [%d] %s | Do przej�cia w godzinach: %02d:%02d - %02d:%02d", 
                        i, FrontBusiness[i][Name], 
                        hour, minute, endHour, endMinute);
                }
                SendClientMessage(playerid, COLOR_WHITE, string);
            }
        }
    }
    else if(strcmp(action, "zmienczas", true) == 0)
    {
        if(!IsPlayerOrgLeader(playerid))
        {
            MruMessageFail(playerid, "Ta opcja jest tylko dla lidera organizacji.");
            return 1;
        }

		new bizId, hour, minute;
		if(sscanf(params, "ddd", bizId, hour, minute))
		{
			sendTipMessage(playerid, "U�yj /orgbiz zmienczas [id biznesu] [godzina (w przedziale "#MIN_TAKEOVER_HOUR" - "#MAX_TAKEOVER_HOUR")] [minuta]");
			sendTipMessage(playerid, "Koszt komendy: "#CHANGE_TAKEOVER_TIME_COST" kontrabandy.");
			return 1;
		}

        if(GetContraband(playerid) < CHANGE_TAKEOVER_TIME_COST)
        {
            MruMessageFail(playerid, "Koszt zmiany czasu przej�cia biznesu to "#CHANGE_TAKEOVER_TIME_COST", a Ty tyle nie masz.");
            return 1;
        }

        if(bizId < 0 || bizId >= sizeof(FrontBusiness))
        {
            MruMessageFailF(playerid, "ID biznesu od 0 do %d.", sizeof(FrontBusiness));
            return 1;
        }
        
        if(!IsFrontBusinnesOwnedByOrg(bizId, org))
        {
            MruMessageFailF(playerid, "Biznes %d (%s) nie jest posiadany przez Twoj� organizacj�.", bizId, FrontBusiness[bizId][Name]);
            return 1;
        }

        if(hour < MIN_TAKEOVER_HOUR || hour >= MAX_TAKEOVER_HOUR)
        {
            MruMessageFail(playerid, "Godzina musi by� w przedziale "#MIN_TAKEOVER_HOUR" - "#MAX_TAKEOVER_HOUR".");
            return 1;
        }

        if(minute < 0 || minute > 59)
        {
            MruMessageFail(playerid, "Minuta musi by� w przedziale 0-59.");
            return 1;
        }

        TakeContraband(playerid, CHANGE_TAKEOVER_TIME_COST);
        Redis_SetInt(RedisClient, RedisFrontBizKey(bizId, "takeoverHour"), hour);
        Redis_SetInt(RedisClient, RedisFrontBizKey(bizId, "takeoverMinute"), minute);
        MruMessageGoodInfo(playerid, sprintf("Zmieni�e� czas przejmowania biznesu %s na %02d:%02d. Zmiana b�dzie widoczna dopiero nast�pnego dnia.", 
            FrontBusiness[bizId][Name], hour, minute));
        Log(serverLog, INFO, "Lider %s zmieni� czas przejmowania biznesu %s na [%02d:%02d] za %d kontrabandy",
            GetPlayerLogName(playerid), GetFrontBizLogName(bizId), hour, minute, CHANGE_TAKEOVER_TIME_COST);
    }
    return 1;
}

//end