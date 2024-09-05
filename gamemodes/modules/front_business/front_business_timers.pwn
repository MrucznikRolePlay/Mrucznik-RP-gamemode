//-----------------------------------------------<< Timers >>------------------------------------------------//
//                                               front_business                                              //
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
// Data utworzenia: 05.09.2024
//Opis:
/*
	System bzinesów-przykrywek dla organizacji przestêpczych
*/

//

//-----------------<[ Timery: ]>-------------------
task BusinessTakeoverTimer[1000]()
{
	new hour, minute;
	gettime(hour, minute);
	for(new i; i<sizeof(FrontBusiness); i++)
	{
		if(!FrontBusiness[i][TakeoverActive])
		{
			if(FrontBusiness[i][TakeoverHour] == hour && FrontBusiness[i][TakeoverMinute]  == minute)
			{
				StartFrontBizTakeover(i);
			}
		}
		else
		{
			DecreaseTakeoverPoints(i);

			if(FrontBusiness[i][TakeoverStartTime] + FrontBusiness[i][TakeoverTime] < gettime())
			{
				StopFrontBizTakeover(i);
			}
		}
	}
}

DecreaseTakeoverPoints(bizId)
{
	for(new i; i<MAX_ORG; i++)
	{
		if(FrontBusiness[bizId][TakingOverScore][i] > 0)
		{
			FrontBusiness[bizId][TakingOverScore][i]--;
		}
	}
	if(FrontBusiness[bizId][CopTakingOverScore] > 0)
	{
		FrontBusiness[bizId][CopTakingOverScore]--;
	}
}

ptask TakeoverCheck[1000](playerid)
{
	new bizId = GetPVarInt(playerid, "show-takeover-info") - 1;
	if(bizId >= 0)
	{	
		new string[512];
		strcat(string, "Punkty przejecia:");
		new anyPoints;
		for(new i; i<MAX_ORG; i++)
		{
			if(FrontBusiness[bizId][TakingOverScore][i] > 0)
			{
				format(string, sizeof(string), "%s~n~%s: %d", OrgInfo[i][o_Name], FrontBusiness[bizId][TakingOverScore][i]);
				anyPoints++;
			}
		}
		if(FrontBusiness[bizId][CopTakingOverScore] > 0)
		{
			format(string, sizeof(string), "%s~n~Gliniarze: %d", FrontBusiness[bizId][CopTakingOverScore]);
			anyPoints++;
		}
		if(anyPoints > 0)
		{
			GameTextForPlayer(playerid, string, 1100, 15);
		}
	}
}

//end