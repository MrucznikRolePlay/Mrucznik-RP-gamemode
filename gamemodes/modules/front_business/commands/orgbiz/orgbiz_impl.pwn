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
                if(IsPlayerOrgLeader(playerid))
                {
                    new profit, leaderProfit;
                    Redis_GetInt(RedisClient, RedisFrontBizKey(i, "profit"), profit);
                    Redis_GetInt(RedisClient, RedisFrontBizKey(i, "leaderProfit"), leaderProfit);
                    format(string, sizeof(string), "- [%d] %s | Godzina przejêcia: %02d:%02d | Wygenerowany przychód: %d$ (%d$ do sejfu)", 
                        i, FrontBusiness[i][Name], 
                        FrontBusiness[i][TakeoverHour], FrontBusiness[i][TakeoverMinute],
                        profit, leaderProfit);
                }
                else
                {
                    format(string, sizeof(string), "- [%d] %s | Godzina przejêcia: %02d:%02d", 
                        i, FrontBusiness[i][Name], 
                        FrontBusiness[i][TakeoverHour], FrontBusiness[i][TakeoverMinute]);
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
			sendTipMessage(playerid, "U¿yj /orgbiz zmienczas [id biznesu] [godzina (w przedziale "#MIN_TAKEOVER_HOUR" - "#MAX_TAKEOVER_HOUR")] [minuta]");
			sendTipMessage(playerid, "Koszt komendy: "#CHANGE_TAKEOVER_TIME_COST" kontrabandy.");
			return 1;
		}

        if(GetContraband(playerid) < CHANGE_TAKEOVER_TIME_COST)
        {
            MruMessageFail(playerid, "Koszt zmiany czasu przejêcia biznesu to "#CHANGE_TAKEOVER_TIME_COST", a Ty tyle nie masz.");
            return 1;
        }

        if(bizId < 0 || bizId >= sizeof(FrontBusiness))
        {
            MruMessageFailF(playerid, "ID biznesu od 0 do %d.", sizeof(FrontBusiness));
            return 1;
        }
        
        if(!IsFrontBusinnesOwnedByOrg(bizId, org))
        {
            MruMessageFailF(playerid, "Biznes %d (%s) nie jest posiadany przez Twoj¹ organizacjê.", bizId, FrontBusiness[bizId][Name]);
            return 1;
        }

        if(hour < MIN_TAKEOVER_HOUR || hour >= MAX_TAKEOVER_HOUR)
        {
            MruMessageFail(playerid, "Godzina musi byæ w przedziale "#MIN_TAKEOVER_HOUR" - "#MAX_TAKEOVER_HOUR".");
            return 1;
        }

        if(minute < 0 || minute > 60)
        {
            MruMessageFail(playerid, "Minuta musi byæ w przedziale 0-60.");
            return 1;
        }

        TakeContraband(playerid, CHANGE_TAKEOVER_TIME_COST);
        Redis_SetInt(RedisClient, RedisFrontBizKey(bizId, "takeoverHour"), hour);
        Redis_SetInt(RedisClient, RedisFrontBizKey(bizId, "takeoverMinute"), minute);
        FrontBusiness[bizId][TakeoverHour] = hour;
        FrontBusiness[bizId][TakeoverMinute] = minute;
    }
    return 1;
}

//end