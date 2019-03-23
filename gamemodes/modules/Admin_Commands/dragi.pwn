//dragi.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//------------------------------------------[ Modu³: chaty.pwn ]---------------------------------------------//
//Opis:
/*
	Zawiera skrypt narkotyków Mrucznik Role Play. 
		>By Simeone
	
*/
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

//

//-----------------<[ Funkcje: ]>-------------------


//======================================[ZA¯YWANIE NARKOTYKÓW]=========================================
stock GetPlayerStoned(playerid)
{
	new statusStoned = GetPVarInt(playerid, "playerStonedStatus"); 
	return statusStoned;
}
stock SetPlayerTextEffect(playerid, string)
{

	return 1;
}
stock PlayerStonedKill(playerid)
{
	SetPlayerHealth(playerid, 20); 
	TogglePlayerControllable(playerid, 0); 
	format(string, sizeof(string), "%s pada na ziemiê z przedawkowania, traci przytomnoœæ", GetNick(playerid, true)); 
	ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4.1, 0, 0, 0, 0, 0, 1);
	new pZone[MAX_ZONE_NAME];
    GetPlayer2DZone(playerid, pZone, MAX_ZONE_NAME);
	format(string, sizeof(string), "%s potrzebuje pomocy medyka! Jest na %s . Prawdopodobnie przedawkowa³", GetNick(playerid, true), pZone); 
	SendFamilyMessage(FRAC_MC, COLOR_YELLOW, string);
	SetTimerEx("StonedDrugPlayer", 60000, true, "i", playerid);
	return 1;
}
stock CreatePlayerDrugEffect(playerid, level)
{
	new Float:pX, Float:pY, Float:pZ;
	GetPlayerPos(playerid, pX, pY, pZ); 
	
	if(level == 0)
	{
	
	}
	if(level == 1)
	{
		SetPlayerDrunkLevel(playerid, 100); 
		drugObject[playerid] = AttachDynamicObjectToPlayer(3528, playerid, 2, 4, 2, pX, pY, pZ);
	}
	return 1;
}
stock SetPlayerStoned(playerid, timeStoned, drug)
{
	if(IsPlayerConnected(playerid))
	{
		new string[128];
		new Float:playHealth;
		if(GetPlayerStoned == 4)
		{
				new losowanie = random(2);
			if(losowanie = 1)
			{
				sendTipMessage(playerid, "Jesteœ tak naæpany, ¿e zapomnia³eœ jak tego u¿yæ!"); 
			}
			if(losowanie = 2)
			{
				PlayerStonedKill(playerid); 
			}
			return 1;
		}
		
		
		if(drug == 0)//Crack
		{
			sendTipMessage(playerid, "U¿y³eœ narkotyku: Crack"); 
			PlayerInfo[playerid][pDrug0]--;
			format(string, sizeof(string), "%s wyci¹ga z kieszeni lufkê, napycha do niej cracku i odpala.", GetNick(playerid, true));
			SetPVarInt(playerid, "playerStonedStatus", GetPlayerStoned(playerid)+1); 
			CreatePlayerDrugEffect(playerid, 1); 
		}
		if(drug == 1)
		{
			sendTipMessage(playerid, "U¿y³eœ narkotyku: Green God");
			PlayerInfo[playerid][pDrug1]--;
			format(string, sizeof(string), "%s wyci¹ga z kieszeni woreczek z zielonymi kapsu³kami, za¿ywa jedn¹", GetNick(playerid, true)); 
			SetPVarInt(playerid, "playerStonedStatus", GetPlayerStoned(playerid)+1); 
			CreatePlayerDrugEffect(playerid, 2); 
		}
		if(drug == 2)
		{
			sendTipMessage(playerid, "U¿y³eœ narkotyku: Marihuana"); 
			PlayerInfo[playerid][pDrug2]--;
			format(string, sizeof(string), "%s wyci¹ga z kiezeni skrêta, odpala go", GetNick(playerid, true)); 
			SetPVarInt(playerid, "playerStonedStatus", GetPlayerStoned(playerid)+1);
			CreatePlayerDrugEffect(playerid, 0); 			
		}
		
		ProxDetector(10.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
		SetPlayerTextEffect(playerid, "Naæpany"); 
		timeStoned = timeStoned*1000; 
		SetTimerEx("EfektNarkotyku2", timeStoned, false, "i", playerid);
		
		
		
		
		if(GetPVarInt(playerid, "ZjadlDragi") == 0)
		{
			if(PlayerInfo[playerid][pStrong] < MAX_STRONG_VALUE/2)
			{
				SetPVarInt(playerid, "ZjadlDragi", 1);
				sendTipMessageEx(playerid, COLOR_P@, "Za¿y³eœ narkotyki, twoja si³a wzros³a dwukrotnie na jakiœ czas"); 
				format(string, sizeof(string), "Mia³eœ %d , po za¿yciu 2 gram masz %d si³y.", PlayerInfo[playerid][pStrong], PlayerInfo[playerid][pStrong]*2);
				sendTipMessage(playerid, string);
				SetPVarInt(playerid, "FirstValueStrong", PlayerInfo[playerid][pStrong]);
				SetStrong(playerid, PlayerInfo[playerid][pStrong]*2);
				TimerEfektNarkotyku[playerid] = SetTimerEx("EfektNarkotyku", 60000, false, "i", playerid);
			}
			else
			{
				sendTipMessage(playerid, "Masz zbyt du¿¹ wartoœæ si³y, aby dragi Ci coœ da³y!"); 
			}
		}
		else
		{
			if(PlayerInfo[playerid][pStrong] >= 15)
			{
				sendTipMessage(playerid, "Æpun, przez twój na³óg spada Ci wartoœæ si³y!");
				MSGBOX_Show(playerid, "Sila -15", MSGBOX_ICON_TYPE_EXPLODE, 3);
				TakeStrong(playerid, 15);
				new StrongValue = GetPVarInt(playerid, "FirstValueStrong"); 
				SetPVarInt(playerid, "FirstValueStrong", StrongValue-15);
			}
			else
			{
				sendTipMessage(playerid, "Æpun, przez twój na³óg spada Ci wartoœæ si³y!");
				MSGBOX_Show(playerid, "Sila -15", MSGBOX_ICON_TYPE_EXPLODE, 3);
			}
		}

		//zabawa ¿yciem
		GetPlayerHealth(playerid, playHealth); 
		SetPlayerHealth(playerid, playHealth-5); 
		if(GetPlayerHealth(playerid, playHealth) <= 5) 
		{
			PlayerStonedKill(playerid); 
		}
	}
	return 1;
}

forward StonedDrugPlayer(playerid);
public StonedDrugPlayer(playerid)
{
	sendTipMessage(playerid, "Podnosisz siê"); 
	TogglePlayerControllable(playerid, 0); 
	ClearAnimations(playerid, 0); 
	SetPlayerTextEffect(playerid, ""); 
	DestroyObject(drugObject[playerid]); 
	return 1;
}
forward EfektNarkotyku2(playerid);
public EfektNarkotyku2(playerid)
{
	DestroyObject(drugObject[playerid]);
	sendTipMessage(playerid, "Efekt narkotyku powoli spada"); 
	SetPlayerTextEffect(playerid, ""); 
	SetPlayerDrunkLevel(playerid, 0); 
	return 1;
}

//=============================[POZYSKIWANIE NARKOTYKÓW]==============================



