//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 wielkanoc                                                 //
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
// Autor: gumbal
// Data utworzenia: 09.04.2020
//Opis:
/*
	Skrypty dla wielkanocy
*/

//

//-----------------<[ Funkcje: ]>-------------------
stock EasterEggs_CanUse(playerid)
{
	new year, month,day;
	getdate(year, month, day);
	if(DEVELOPMENT || (year == EASTERS_YEAR && month == EASTERS_MONTH && (day == EASTERS_DAY[0] || day == EASTERS_DAY[1] || day == EASTERS_DAY[2])))
	{
		if(IsAHeadAdmin(playerid)) return 1;
		if(IsAMCGiver(playerid)) return 1;
		for(int i=0; i<3; i++)
		{
			if(PlayerInfo[playerid][pUID] == EasterEggsAdminUID[i]) return 1;
		}
	}
	return 0;
}

EasterEggs_Exist(id)
{
	if(EasterEggs[id][egg_x_pos] != 0.0) return true;
	else return false;
}

stock EasterEggs_GetFreeID()
{
	for(int i=0; i<EASTER_MAX_EGGS; i++)
	{
		if(!EasterEggs_Exist(i))
		{
			return i;
		}
	}
	return INVALID_EGG_ID;
}

stock EasterEggs_FindNearest(playerid)
{
	for(new i; i < EASTER_MAX_EGGS; i++)
	{
		if(EasterEggs_Exist(i))
		{
			new Float:ox, Float:oy, Float:oz;
			new vw = GetPlayerVirtualWorld(playerid);
			new int = GetPlayerInterior(playerid);
			GetDynamicObjectPos(EasterEggs[i][eggID], ox, oy, oz);
			if(IsPlayerInRangeOfPoint(playerid, 1.5, ox, oy, oz) && (vw == EasterEggs[i][eggVW] && int == EasterEggs[i][eggINT]))
			{
				return i;
			}
		}
	}
	return INVALID_EGG_ID;
}
EasterEggs_Delete(playerid, egg_id)
{
	if(EasterEggs_Exist(egg_id))
	{
		EasterEggs[egg_id][egg_x_pos] = 0.0;
		DestroyDynamicObject(EasterEggs[egg_id][eggID]);
		new string[120];
		format(string, sizeof(string), "Admin %s usun¹³ jajko ID:[%d]", GetNick(playerid), egg_id);
		SendMessageToAdmin(string, COLOR_P@);
		// DODATKOWO ZEROWANIE LISTY OSÓB KTÓRE WZIE£Y TO JAJKO
	}
	else
	{
		SendClientMessage(playerid, -1, "Jajko nie istnieje.");
	}
}
stock EasterEggs_Create(playerid, Float:x, Float:y, Float:z, type)
{
	new egg_id;
	egg_id = EasterEggs_GetFreeID();
	if(egg_id == INVALID_EGG_ID) SendClientMessage(playerid, COLOR_PANICRED, "Osi¹gniêto maksymaln¹ liczbê jajek na mapie!");
	else
	{
		new model = true_random(3)+1;
		new vw, int;
		vw = GetPlayerVirtualWorld(playerid);
		int = GetPlayerInterior(playerid);
		SetPVarInt(playerid, "EGGID", egg_id);
		SetPVarInt(playerid, "CreatingEGG", 1);
		EasterEggs[egg_id][egg_x_pos] = x;
		EasterEggs[egg_id][egg_y_pos] = y;
		EasterEggs[egg_id][egg_z_pos] = z;
		EasterEggs[egg_id][eggVW] = vw;
		EasterEggs[egg_id][eggINT] = int;
		EasterEggs[egg_id][eggTYPE] = type;
		EasterEggs[egg_id][eggID] = CreateDynamicObject(EasterEggsModel[model], x, y, z, 0.0, 0.0, 0.0, vw, int, -1, 80);
		EditDynamicObject(playerid, EasterEggs[egg_id][eggID]);
	}
	return 1;
}
stock EasterEggs_CanPickup(playerid, egg_id)
{
	// SKRYPT DO SPRAWDZANIA CZY GRACZ NIE PODNIÓS£ TEGO ID JAJKA! @Mrucznik
	if(!EasterEggs_Exist(egg_id)) return 0;
	return 1;
}
stock EasterEggs_Pickup(playerid, egg_id)
{
	if(EasterEggs_Setting_Started == 0)
	{
		SendClientMessage(playerid, COLOR_GRAY, "Event siê jeszcze nie rozpocz¹³.");
		return 0;
	}
	if(EasterEggs_CanPickup(playerid, egg_id))
	{
		new string[120], type[2], quantity;
		if(EasterEggs[egg_id][eggTYPE] == 1)
		{
			format(type, sizeof(type), "$");
			quantity = EasterEggs_Setting_CASH;
			DajKase(playerid, quantity);
		}
		else if(EasterEggs[egg_id][eggTYPE] == 2)
		{
			quantity = EasterEggs_Setting_MCOINS;
			format(type, sizeof(type), "MC");
			PremiumInfo[playerid][pMC] += quantity;
			MruMySQL_SaveMc(playerid);
		}
		SendClientMessage(playerid, COLOR_LIGHTGREEN, "Podnios³eœ jajko wielkanocne!")
		format(string, sizeof(string), "Twoja nagroda to %d%s!", quantity, type);
		SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
		format(string, sizeof(string), "[EasterEggs] %s podniós³ jajko wielkanocne.", GetNick(playerid));
		SendMessageToAdmin(string, COLOR_P@);
		Log(payLog, INFO, "[EasterEggs]Gracz %s podniós³ jajko z %d%s.", GetPlayerLogName(playerid), quantity, type);

		// Skrypt do zapisu ¿eby gracz ju¿ nie podniós³ tego jajka 2gi raz.
		return 1;
	}
	else
	{
		SendClientMessage(playerid, COLOR_GRAY, "Podnios³eœ ju¿ to jajko.");
		return 0;
	}
}

//end