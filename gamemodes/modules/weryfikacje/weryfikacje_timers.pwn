//-----------------------------------------------<< Timers >>------------------------------------------------//
//                                                weryfikacje                                                //
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
// Autor: Sandal
// Data utworzenia: 01.02.2024
//Opis:
/*
	System lockdown dla administracji
*/

//

//-----------------<[ Timery: ]>-------------------
forward ALockdown_Timer(playerid);
public ALockdown_Timer(playerid)
{
	if(ALockdown_Check(playerid) == true)
	{
		if(GetPlayerVirtualWorld(playerid) != Lockdown_assignedVW[playerid])
		{
			Lockdown_Warning_Counter[playerid]++;
			if(Lockdown_Warning_Counter[playerid] >= 5)
			{
				ALockdown_Notify(playerid, LOCKDOWN_MSG_RULEBREAK);
				KickEx(playerid, "lockdown");
				ALockdown_DestroyData(playerid);
			}
			ALockdown_SetLockdownVW(playerid);
		}
		Lockdown_MSGCounter[playerid]++;
		if(Lockdown_MSGCounter[playerid] >= 270)
		{
			ALockdown_Notify(playerid, LOCKDOWN_MSG_PENDING);
			Lockdown_MSGCounter[playerid] = 0;
		}
		else if(Lockdown_MSGCounter[playerid] == 160)
			ALockdown_Notify(playerid, LOCKDOWN_MSG_REMINDER);
		else if(Lockdown_MSGCounter[playerid] == 70)
			ALockdown_Notify(playerid, LOCKDOWN_MSG_REMINDER);
	}
	else
		ALockdown_DestroyData(playerid);
}
//end