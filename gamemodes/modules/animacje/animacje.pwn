//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  animacje                                                 //
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
// Autor: Sanda³
// Data utworzenia: 25.11.2019
//Opis:
/*
	Animacje dostêpne na serwerze.
*/

//

//-----------------<[ Funkcje: ]>-------------------
MRP_ShowAnim(playerid)
{
	new dialog[2048];
	format(dialog, sizeof(dialog), "{53a142}@bar[1-4]\n{53a142}@caluj[1-8]\n{53a142}@car[1-11]\n{53a142}@colt[1-7]\n{53a142}@crack[1-5]\n{53a142}@dance[1-4]\n");
	format(dialog, sizeof(dialog), "%s{53a142}@diler[1-4]\n{53a142}@idz[1-5]\n{53a142}@klepnij[1-3]\n{53a142}@krzeslo[1-3]\n", dialog);
	format(dialog, sizeof(dialog), "%s{53a142}@lez[1-3]\n{53a142}@lokiec[1-2]\n{53a142}@lowrider[1-5]\n{53a142}@nies[1-7]\n{53a142}@papieros[1-2]\n", dialog);
	format(dialog, sizeof(dialog), "%s{53a142}@placz[1-3]\n{53a142}@ranny[1-3]\n{53a142}@rap[1-4]\n{53a142}@rozmowa[1-6]\n{53a142}@sex[1-12]\n{53a142}@sklep[1-8]\n", dialog);
	format(dialog, sizeof(dialog), "%s{53a142}@smierc[1-2]\n{53a142}@spij[1-4]\n{53a142}@spray[1-2]\n{53a142}@stack[1-11]\n", dialog);
	format(dialog, sizeof(dialog), "%s{53a142}@strip[1-7]\n{53a142}@wygralem[1-2]\n{53a142}@yo[1-7]\n", dialog);
	format(dialog, sizeof(dialog), "%s{ebc034}@bomba\n{ebc034}@box\n{ebc034}@celuj\n{ebc034}@celujkarabin\n{ebc034}@crack\n{ebc034}@czas\n{ebc034}@dodge\n{ebc034}@doping\n{ebc034}@drap\n{ebc034}@dzieki\n", dialog);
	format(dialog, sizeof(dialog), "%s{ebc034}@fuck\n{ebc034}@greet\n{ebc034}@hitch\n{ebc034}@joint\n{ebc034}@karta\n{ebc034}@komputer\n{ebc034}@kozak\n{ebc034}@taichi\n{ebc034}@machaj\n{ebc034}@maska\n", dialog);
	format(dialog, sizeof(dialog), "%s{ebc034}@medyk\n{ebc034}@napad\n{ebc034}@nie\n{ebc034}@odbierz\n{ebc034}@odloz\n{ebc034}@oh\n{ebc034}@opieraj\n{ebc034}@pa\n{ebc034}@pij\n{ebc034}@placz\n", dialog);
	format(dialog, sizeof(dialog), "%s{ebc034}@przeladuj\n{ebc034}@ramiona\n{ebc034}@rozciagaj\n{ebc034}@rozlacz\n{ebc034}@siad\n{ebc034}@sikaj\n{ebc034}@smiech\n{ebc034}@stoj\n{ebc034}@tak\n{ebc034}@waledochodze\n", dialog);
	format(dialog, sizeof(dialog), "%s{ebc034}@walekonia\n{ebc034}@wolaj\n{ebc034}@wozszlug\n{ebc034}@wstan\n{ebc034}@wtf\n{ebc034}@wymiotuj\n{ebc034}@zarcie\n{ebc034}@zmeczony", dialog);
	ShowPlayerDialogEx(playerid, D_ANIMLIST, 2, "{4876FF}Mrucznik Role Play » {FFFFFF}Animacje", dialog, "Wybierz", "WyjdŸ");
	return 1;
}

MRP_DoAnimation(playerid, arg1[])
{
	new var0 = 0;
	if(strcmp(arg1, "@rece", true) == 0 || strcmp(arg1, "@rece1", true) == 0)
	{
		SetPlayerSpecialAction(playerid, 10);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@dance", true, 6) == 0)
	{
		strmid(arg1, arg1, 6, 8, 32);
		var0 = strval(arg1);


		if(var0 == 0 || var0 == 1)
		{
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE1);
		}
		else if(var0 == 2)
		{
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE2);
		}
		else if(var0 == 3)
		{
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE3);
		}
		else if(var0 == 4)
		{
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE4);
		}
		if(var0 >= 0 && var0 < 5)
		{
			SetPVarInt(playerid, "anim_do", 1);
		}
		else
		{
			GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~1 - 4", 1500, 3);
		}
		return 1;
	}
	else if(strcmp(arg1, "@rap", true, 4) == 0)
	{
		strmid(arg1, arg1, 4, 6, 32);
		var0 = strval(arg1);
		if(var0 == 0 || var0 == 1)
		{
			ApplyAnimation(playerid, "RAPPING", "RAP_A_Loop", 4.0999, 1, 0, 0, 1, 0, 1);
		}
		else if(var0 == 2)
		{
			ApplyAnimation(playerid, "RAPPING", "RAP_B_Loop", 4.0999, 1, 0, 0, 1, 0, 1);
		}
		else if(var0 == 3)
		{
			ApplyAnimation(playerid, "RAPPING", "RAP_C_Loop", 4.0999, 1, 0, 0, 1, 0, 1);
		}
		else if(var0 == 4)
		{
			ApplyAnimation(playerid, "GYMNASIUM", "gym_tread_celebrate", 4.0999, 1, 0, 0, 1, 0, 1);
		}
		if(var0 >= 0 && var0 <= 4)
		{
			SetPVarInt(playerid, "anim_do", 1);
		}
		else
		{
			GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~1 - 4", 1500, 3);
		}
		return 1;
	}
	else if(strcmp(arg1, "@waledochodze", true) == 0)
	{
		ApplyAnimation(playerid, "PAULNMAC", "wank_out", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@walekonia", true) == 0)
	{
		ApplyAnimation(playerid, "PAULNMAC", "wank_loop", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@strip", true, 6) == 0)
	{
		strmid(arg1, arg1, 6, 8, 32);
		var0 = strval(arg1);
		if(var0 == 0 || var0 == 1)
		{
			ApplyAnimation(playerid, "STRIP", "strip_A", 4.0999, 1, 0, 0, 1, 0, 1);
		}
		else if(var0 == 2)
		{
			ApplyAnimation(playerid, "STRIP", "strip_B", 4.0999, 1, 0, 0, 1, 0, 1);
		}
		else if(var0 == 3)
		{
			ApplyAnimation(playerid, "STRIP", "strip_C", 4.0999, 1, 0, 0, 1, 0, 1);
		}
		else if(var0 == 4)
		{
			ApplyAnimation(playerid, "STRIP", "strip_D", 4.0999, 1, 0, 0, 1, 0, 1);
		}
		else if(var0 == 5)
		{
			ApplyAnimation(playerid, "STRIP", "strip_E", 4.0999, 1, 0, 0, 1, 0, 1);
		}
		else if(var0 == 6)
		{
			ApplyAnimation(playerid, "STRIP", "strip_F", 4.0999, 1, 0, 0, 1, 0, 1);
		}
		else if(var0 == 7)
		{
			ApplyAnimation(playerid, "STRIP", "strip_G", 4.0999, 1, 0, 0, 1, 0, 1);
		}
		if(var0 >= 0 && var0 <= 7)
		{
			SetPVarInt(playerid, "anim_do", 1);
		}
		else
		{
			GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~1 - 7", 1500, 3);
		}
		return 1;
	}
	else if(strcmp(arg1, "@sex", true, 4) == 0)
	{
		strmid(arg1, arg1, 4, 7, 32);
		var0 = strval(arg1);
		if(var0 == 0 || var0 == 1)
		{
			ApplyAnimation(playerid, "SNM", "SPANKING_IDLEW", 4.0999, 0, 0, 0, 1, 0, 1);
		}
		else if(var0 == 2)
		{
			ApplyAnimation(playerid, "SNM", "SPANKING_IDLEP", 4.0999, 0, 0, 0, 1, 0, 1);
		}
		else if(var0 == 3)
		{
			ApplyAnimation(playerid, "SNM", "SPANKINGW", 4.0999, 1, 1, 1, 1, 0, 1);
		}
		else if(var0 == 4)
		{
			ApplyAnimation(playerid, "SNM", "SPANKINGP", 4.0999, 1, 0, 0, 1, 0, 1);
		}
		else if(var0 == 5)
		{
			ApplyAnimation(playerid, "SNM", "SPANKEDW", 4.0999, 1, 0, 0, 1, 0, 1);
		}
		else if(var0 == 6)
		{
			ApplyAnimation(playerid, "SNM", "SPANKEDP", 4.0999, 1, 0, 0, 1, 0, 1);
		}
		else if(var0 == 7)
		{
			ApplyAnimation(playerid, "SNM", "SPANKING_ENDW", 4.0999, 0, 0, 0, 1, 0, 1);
		}
		else if(var0 == 8)
		{
			ApplyAnimation(playerid, "SNM", "SPANKING_ENDP", 4.0999, 0, 0, 0, 1, 0, 1);
		}
		else if(var0 == 9)
		{
			ApplyAnimation(playerid, "SNM", "SPANKING_IDLEP", 4.0999, 0, 0, 0, 1, 0, 1);
		}
		else if(var0 == 10)
		{
			ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_START_P", 4.0999, 0, 0, 0, 1, 0, 1);
		}
		else if(var0 == 11)
		{
			ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_P", 4.0999, 0, 0, 0, 1, 0, 1);
		}
		else if(var0 == 12)
		{
			ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_W", 4.0999, 1, 0, 0, 1, 0, 1);
		}
		if(var0 >= 0 && var0 <= 12)
		{
			SetPVarInt(playerid, "anim_do", 1);
		}
		else
		{
			GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~1 - 12", 1500, 3);
		}
		return 1;
	}
	else if(strcmp(arg1, "@idz", true, 4) == 0)
	{
		strmid(arg1, arg1, 4, 6, 32);
		var0 = strval(arg1);
		if(var0 == 0 || var0 == 1)
		{
			ApplyAnimation(playerid, "PED", "WALK_gang1", 4.0999, 1, 0, 0, 1, 0, 1);
		}
		else if(var0 == 2)
		{
			ApplyAnimation(playerid, "PED", "WALK_gang2", 4.0999, 1, 0, 0, 1, 0, 1);
		}
		else if(var0 == 3)
		{
			ApplyAnimation(playerid, "ped", "WALK_player", 4.0999, 1, 0, 0, 1, 0, 1);
		}
		else if(var0 == 4)
		{
			ApplyAnimation(playerid, "ped", "WOMAN_walksexy", 4.0999, 1, 0, 0, 1, 0, 1);
		}
		else if(var0 == 5)
		{
			ApplyAnimation(playerid, "PED", "WALK_old", 4.0999, 1, 0, 0, 1, 0, 1);
		}
		if(var0 >= 0 && var0 <= 5)
		{
			SetPVarInt(playerid, "anim_do", 1);
		}
		else
		{
			GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~1 - 5", 1500, 3);
		}
		return 1;
	}
	else if(strcmp(arg1, "@nies", true, 5) == 0)
	{
		strmid(arg1, arg1, 5, 7, 32);
		var0 = strval(arg1);
		if(var0 == 0 || var0 == 1)
		{
			ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0999, 0, 1, 1, 1, 1, 1);
		}
		else if(var0 == 2)
		{
			ApplyAnimation(playerid, "CARRY", "liftup", 4.0999, 0, 1, 1, 1, 1, 1);
		}
		else if(var0 == 3)
		{
			ApplyAnimation(playerid, "CARRY", "liftup05", 4.0999, 0, 1, 1, 1, 1, 1);
		}
		else if(var0 == 4)
		{
			ApplyAnimation(playerid, "CARRY", "liftup105", 4.0999, 0, 1, 1, 1, 1, 1);
		}
		else if(var0 == 5)
		{
			ApplyAnimation(playerid, "CARRY", "putdwn", 4.0999, 0, 1, 1, 1, 1, 1);
		}
		else if(var0 == 6)
		{
			ApplyAnimation(playerid, "CARRY", "putdwn05", 4.0999, 0, 1, 1, 1, 1, 1);
		}
		else if(var0 == 7)
		{
			ApplyAnimation(playerid, "CARRY", "putdwn105", 4.0999, 0, 1, 1, 1, 1, 1);
		}
		if(var0 >= 0 && var0 <= 7)
		{
			SetPVarInt(playerid, "anim_do", 1);
		}
		else
		{
			GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~1 - 7", 1500, 3);
		}
		return 1;
	}
	else if(strcmp(arg1, "@odbierz", true) == 0)
	{
		SetPlayerSpecialAction(playerid, 11);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@rozlacz", true) == 0)
	{
		SetPlayerSpecialAction(playerid, 13);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@opieraj", true) == 0)
	{
		ApplyAnimation(playerid, "GANGS", "leanIDLE", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@sikaj", true) == 0)
	{
		SetPlayerSpecialAction(playerid, 68);
		SetPVarInt(playerid, "anim_do", 1);
		PlayerPlaySound(playerid, 14200, 0.0, 0.0, 0.0);
		return 1;
	}
	else if(strcmp(arg1, "@wolaj", true) == 0)
	{
		ApplyAnimation(playerid, "WUZI", "Wuzi_follow", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@greet", true) == 0)
	{
		ApplyAnimation(playerid, "WUZI", "Wuzi_Greet_Wuzi", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@stoj", true) == 0)
	{
		ApplyAnimation(playerid, "WUZI", "Wuzi_stand_loop", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@ranny3", true) == 0)
	{
		ApplyAnimation(playerid, "SWAT", "gnstwall_injurd", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@hitch", true) == 0)
	{
		ApplyAnimation(playerid, "MISC", "Hiker_Pose", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@rece2", true) == 0)
	{
		ApplyAnimation(playerid,"POLICE","crm_drgbst_01",4.1,0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@klepnij3", true) == 0)
	{
		ApplyAnimation(playerid, "MISC", "bitchslap", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@medyk", true) == 0)
	{
		ApplyAnimation(playerid, "MEDIC", "CPR", 4.0999, 0, 1, 1, 0, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@stack6", true) == 0)
	{
		ApplyAnimation(playerid, "GHANDS", "gsign1", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@stack7", true) == 0)
	{
		ApplyAnimation(playerid, "GHANDS", "gsign2", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@stack8", true) == 0)
	{
		ApplyAnimation(playerid, "GHANDS", "gsign3", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@stack9", true) == 0)
	{
		ApplyAnimation(playerid, "GHANDS", "gsign4", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@stack10", true) == 0)
	{
		ApplyAnimation(playerid, "GHANDS", "gsign5", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@daj2", true) == 0)
	{
		ApplyAnimation(playerid, "KISSING", "gift_give", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@krzeslo", true) == 0 || strcmp(arg1, "@krzeslo1", true) == 0)
	{
		ApplyAnimation(playerid, "PED", "SEAT_idle", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@ranny", true) == 0 || strcmp(arg1, "@ranny1", true) == 0)
	{
		ApplyAnimation(playerid,"CRACK","crckidle1",4.1,0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@ranny2", true) == 0)
	{
		ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@ranny3", true) == 0)
	{
		ApplyAnimation(playerid,"CRACK","crckidle2",4.1,0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}

	else if(strcmp(arg1, "@klepnij2", true) == 0)
	{
		ApplyAnimation(playerid, "SWEET", "ho_ass_slapped", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@klepnij", true) == 0 || strcmp(arg1, "@klepnij1", true) == 0)
	{
		ApplyAnimation(playerid, "SWEET", "sweet_ass_slap", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@pij", true) == 0)
	{
		ApplyAnimation(playerid, "PED", "WALK_DRUNK", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@krzeslo3", true) == 0)
	{
		ApplyAnimation(playerid, "FOOD", "FF_Sit_Loop", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@kozak", true) == 0)
	{
		ApplyAnimation(playerid, "benchpress", "gym_bp_celebrate", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@wygralem", true) == 0 || strcmp(arg1, "@wygralem1", true) == 0)
	{
		ApplyAnimation(playerid, "CASINO", "manwinb", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@wygralem2", true) == 0)
	{
		ApplyAnimation(playerid, "CASINO", "Slot_win_out", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@diler2", true) == 0)
	{
		ApplyAnimation(playerid, "DEALER", "DRUGS_BUY", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@dzieki", true) == 0)
	{
		ApplyAnimation(playerid, "FOOD", "SHP_Thank", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@tak", true) == 0)
	{
		ApplyAnimation(playerid, "GANGS", "Invite_Yes", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@nie", true) == 0)
	{
		ApplyAnimation(playerid, "GANGS", "Invite_No", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@komputer", true) == 0)
	{
		ApplyAnimation(playerid, "INT_OFFICE", "OFF_Sit_Type_Loop", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@drap", true) == 0)
	{
		ApplyAnimation(playerid, "MISC", "Scratchballs_01", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp("@bomba", arg1, true) == 0)
	{
		ClearAnimations(playerid, 1);
		ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp("@celuj", arg1, true) == 0)
	{
		ApplyAnimation(playerid,"POLICE","COP_getoutcar_LHS",4.1,0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp("@smiech", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "RAPPING", "Laugh_01", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp("@maska", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "SHOP", "ROB_Shifty", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp("@napad", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "SHOP", "ROB_Loop_Threat", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp("@ramiona", arg1, true) == 0)
	{
		ApplyAnimation(playerid,"COP_AMBIENT","Coplook_loop",4.0999,0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp("@diler3", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "DEALER", "DEALER_IDLE", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp("@pa", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "PED", "endchat_03", 4.0999, 0, 1, 1, 1, 1, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp("@diler4", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "DEALER", "DEALER_IDLE_01", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp("@lez", arg1, true) == 0 || strcmp(arg1, "@lez1", true) == 0)
	{
		ApplyAnimation(playerid, "BEACH", "bather", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp("@wymiotuj", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp("@zarcie", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp("@machaj", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "ON_LOOKERS", "wave_loop", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp("@diler", arg1, true) == 0 || strcmp(arg1, "@diler1", true) == 0)
	{
		ApplyAnimation(playerid, "DEALER", "DEALER_DEAL", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp("@crack", arg1, true) == 0 || strcmp(arg1, "@cpun1", true) == 0)
	{
		ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp("@crack2", arg1, true) == 0)
	{
		ApplyAnimation(playerid,"CRACK","crckdeth1",4.1,0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp("@crack3", arg1, true) == 0)
	{
		ApplyAnimation(playerid,"CRACK","crckdeth3",4.1,0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp("@crack4", arg1, true) == 0)
	{
		ApplyAnimation(playerid,"CRACK","crckdeth4",4.1,0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp("@crack5", arg1, true) == 0)
	{
		ApplyAnimation(playerid,"CRACK","crckidle3",4.1,0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp("spray", arg1, true) == 0 || strcmp("spray1", arg1, true) == 0)
	{
		ApplyAnimation(playerid,"SPRAYCAN","spraycan_fire",4.1,0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp("spray2", arg1, true) == 0)
	{
		ApplyAnimation(playerid,"SPRAYCAN","spraycan_full",4.1,0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp("@papieros", arg1, true) == 0 || strcmp(arg1, "@papieros1", true) == 0)
	{
		ApplyAnimation(playerid, "SMOKING", "M_smklean_loop", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp("@papieros2", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "SMOKING", "F_smklean_loop", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp("@siad", arg1, true) == 0 || strcmp(arg1, "@siad1", true) == 0)
	{
		ApplyAnimation(playerid, "BEACH", "ParkSit_M_loop", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp("@siad2", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "BEACH", "ParkSit_W_loop", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp("@rolki", arg1, true) == 0)
	{
		/*ApplyAnimation(playerid, "SKATE", "skate_sprint", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);*/
		SendClientMessage(playerid, -1, "Ta animacja zostaÂ³a wyÂ³Â¹czona na czas tworzenia systemu przedmiotÃ³w!");
		return 1;
	}
	else if(strcmp("@siad4", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "JST_BUISNESS", "girl_02", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@stack11", true) == 0)
	{
		ApplyAnimation(playerid, "PED", "IDLE_CHAT", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@fuck", true) == 0)
	{
		ApplyAnimation(playerid, "PED", "fucku", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@kungfu", true) == 0 || strcmp(arg1, "@taichi", true) == 0)
	{
		ApplyAnimation(playerid, "PARK", "Tai_Chi_Loop", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@krzeslo2", true) == 0)
	{
		ApplyAnimation(playerid, "BAR", "dnk_stndF_loop", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@lez3", true) == 0)
	{
		ApplyAnimation(playerid, "BEACH", "Lay_Bac_Loop", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@baseball", true) == 0 || strcmp(arg1, "@baseball1", true) == 0)
	{
		ApplyAnimation(playerid, "BASEBALL", "Bat_IDLE", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@baseball2", true) == 0)
	{
		ApplyAnimation(playerid, "BASEBALL", "Bat_M", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@baseball3", true) == 0)
	{
		ApplyAnimation(playerid, "BASEBALL", "BAT_PART", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@baseball4", true) == 0)
	{
		ApplyAnimation(playerid, "CRACK", "Bbalbat_Idle_01", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@baseball5", true) == 0)
	{
		ApplyAnimation(playerid, "CRACK", "Bbalbat_Idle_02", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@czas", true) == 0)
	{
		ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_nod", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@yo", true) == 0 || strcmp(arg1, "@yo1", true) == 0)
	{
		ApplyAnimation(playerid, "GANGS", "hndshkaa", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@yo2", true) == 0)
	{
		ApplyAnimation(playerid, "GANGS", "hndshkba", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@yo3", true) == 0)
	{
		ApplyAnimation(playerid, "GANGS", "hndshkca", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@yo4", true) == 0)
	{
		ApplyAnimation(playerid, "GANGS", "hndshkcb", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@yo5", true) == 0)
	{
		ApplyAnimation(playerid, "GANGS", "hndshkda", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@yo6", true) == 0)
	{
		ApplyAnimation(playerid, "GANGS", "hndshkea", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@yo7", true) == 0)
	{
		ApplyAnimation(playerid, "GANGS", "hndshkfa", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@placz", true) == 0 || strcmp(arg1, "@placz1", true) == 0)
	{
		ApplyAnimation(playerid, "GRAVEYARD", "mrnF_loop", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@placz2", true) == 0)
	{
		ApplyAnimation(playerid, "GRAVEYARD", "mrnM_loop", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@placz3", true) == 0)
	{
		ApplyAnimation(playerid,"CASINO","cards_in",4.1, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
 	}
	else if(strcmp(arg1, "@spij", true) == 0 || strcmp(arg1, "@spij1", true) == 0)
	{
		ApplyAnimation(playerid, "INT_HOUSE", "BED_In_L", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@spij2", true) == 0)
	{
		ApplyAnimation(playerid, "INT_HOUSE", "BED_In_R", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@spij3", true) == 0)
	{
		ApplyAnimation(playerid, "INT_HOUSE", "BED_Loop_L", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@spij4", true) == 0)
	{
		ApplyAnimation(playerid, "INT_HOUSE", "BED_Loop_R", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@caluj2", true) == 0)
	{
		ApplyAnimation(playerid, "BD_FIRE", "Grlfrd_Kiss_03", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@caluj3", true) == 0)
	{
		ApplyAnimation(playerid, "KISSING", "Grlfrd_Kiss_01", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@caluj4", true) == 0)
	{
		ApplyAnimation(playerid, "KISSING", "Grlfrd_Kiss_02", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@caluj5", true) == 0)
	{
		ApplyAnimation(playerid, "KISSING", "Grlfrd_Kiss_03", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@caluj6", true) == 0)
	{
		ApplyAnimation(playerid, "KISSING", "Playa_Kiss_01", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@caluj7", true) == 0)
	{
		ApplyAnimation(playerid, "KISSING", "Playa_Kiss_02", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@caluj8", true) == 0)
	{
		ApplyAnimation(playerid, "KISSING", "Playa_Kiss_03", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@lokiec", true) == 0 || strcmp(arg1, "@lokiec1", true) == 0)
	{
		ApplyAnimation(playerid, "CAR", "Tap_hand", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@lokiec2", true) == 0)
	{
		ApplyAnimation(playerid, "LOWRIDER", "Sit_relaxed", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@rozciagaj", true) == 0)
	{
		ApplyAnimation(playerid, "PLAYIDLES", "stretch", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@doping", true) == 0)
	{
		ApplyAnimation(playerid, "RIOT", "RIOT_CHANT", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@wtf", true) == 0)
	{
		ApplyAnimation(playerid, "RIOT", "RIOT_ANGRY", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@stack", true) == 0 || strcmp(arg1, "@stack1", true) == 0)
	{
		ApplyAnimation(playerid, "GHANDS", "gsign1LH", 4.0999, 0, 1, 1, 1, 1, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@stack2", true) == 0)
	{
		ApplyAnimation(playerid, "GHANDS", "gsign2LH", 4.0999, 0, 1, 1, 1, 1, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@stack3", true) == 0)
	{
		ApplyAnimation(playerid, "GHANDS", "gsign3LH", 4.0999, 0, 1, 1, 1, 1, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@stack4", true) == 0)
	{
		ApplyAnimation(playerid, "GHANDS", "gsign4LH", 4.0999, 0, 1, 1, 1, 1, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@stack5", true) == 0)
	{
		ApplyAnimation(playerid, "GHANDS", "gsign5LH", 4.0999, 0, 1, 1, 1, 1, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@zmeczony", true) == 0)
	{
		ApplyAnimation(playerid, "FAT", "IDLE_tired", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@wozszlug", true) == 0)
	{
		ApplyAnimation(playerid, "PED", "Smoke_in_car", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@napad", true) == 0)
	{
		ApplyAnimation(playerid, "PED", "gang_gunstand", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@wstan", true) == 0)
	{
		ApplyAnimation(playerid, "PED", "getup", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@kosz", true) == 0 || strcmp(arg1, "@kosz1", true) == 0)
	{
		ApplyAnimation(playerid, "BSKTBALL", "BBALL_def_loop", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@kosz2", true) == 0)
	{
		ApplyAnimation(playerid, "BSKTBALL", "BBALL_idleloop", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@kosz3", true) == 0)
	{
		ApplyAnimation(playerid, "BSKTBALL", "BBALL_pickup", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@kosz4", true) == 0)
	{
		ApplyAnimation(playerid, "BSKTBALL", "BBALL_Jump_Shot", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@kosz5", true) == 0)
	{
		ApplyAnimation(playerid, "BSKTBALL", "BBALL_Dnk", 4.0999, 0, 1, 1, 1, 1, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@kosz6", true) == 0)
	{
		ApplyAnimation(playerid, "BSKTBALL", "BBALL_run", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@walnij", true) == 0)
	{
		ApplyAnimation(playerid, "FIGHT_E", "FightKick", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@box", true) == 0)
	{
		ApplyAnimation(playerid, "GYMNASIUM", "gym_shadowbox", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@przeladuj", true) == 0)
	{
		ApplyAnimation(playerid, "SILENCED", "Silence_reload", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@bar1", true) == 0 || strcmp(arg1, "@bar", true) == 0)
	{
		ApplyAnimation(playerid, "BAR", "Barcustom_get", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@bar2", true) == 0)
	{
		ApplyAnimation(playerid, "BAR", "Barcustom_order", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@bar3", true) == 0)
	{
		ApplyAnimation(playerid, "BAR", "Barserve_give", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@bar4", true) == 0)
	{
		ApplyAnimation(playerid, "BAR", "Barserve_glass", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp("@lez2", arg1, true, 6) == 0)
	{
		ApplyAnimation(playerid, "BEACH", "SitnWait_loop_W", 4.0999, 1, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@podnies2", true) == 0)
	{
		ApplyAnimation(playerid, "CARRY", "liftup", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@odloz", true) == 0)
	{
		ApplyAnimation(playerid, "CARRY", "putdwn", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@joint", true) == 0)
	{
		ApplyAnimation(playerid, "GANGS", "smkcig_prtl", 4.0999, 0, 1, 1, 1, 1, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@smierc", true) == 0 || strcmp(arg1, "@smierc1", true) == 0)
	{
		ApplyAnimation(playerid, "KNIFE", "KILL_Knife_Ped_Die", 4.0999, 0, 1, 1, 1, 1, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@oh", true) == 0)
	{
		ApplyAnimation(playerid, "MISC", "plyr_shkhead", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@smierc2", true) == 0)
	{
		ApplyAnimation(playerid, "PARACHUTE", "FALL_skyDive_DIE", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@celujkarabin", true) == 0)
	{
		ApplyAnimation(playerid, "SHOP", "SHP_Gun_Aim", 4.0999, 0, 1, 1, 1, 1, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@podnies", true) == 0)
	{
		ApplyAnimation(playerid, "BAR", "Barserve_bottle", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@karta", true) == 0)
	{
		ApplyAnimation(playerid, "GRAFFITI", "graffiti_Chkout", 4.0999, 0, 0, 0, 1, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@dodge", true) == 0)
	{
		ApplyAnimation(playerid, "DODGE", "Crush_Jump", 4.0999, 0, 1, 1, 0, 0, 1);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	else if(strcmp(arg1, "@colt", true, 5) == 0)
	{
		strmid(arg1, arg1, 5, 7, 32);
		var0 = strval(arg1);
		if(var0 == 1)
		{
			ApplyAnimation(playerid, "COLT45", "2guns_crouchfire", 4.0999, 0, 1, 1, 1, 1, 1);
		}
		else if(var0 == 2)
		{
			ApplyAnimation(playerid, "COLT45", "colt45_crouchfire", 4.0999, 0, 1, 1, 1, 1, 1);
		}
		else if(var0 == 3)
		{
			ApplyAnimation(playerid, "COLT45", "colt45_crouchreload", 4.0999, 0, 1, 1, 1, 1, 1);
		}
		else if(var0 == 4)
		{
			ApplyAnimation(playerid, "COLT45", "colt45_fire", 4.0999, 0, 1, 1, 1, 1, 1);
		}
		else if(var0 == 5)
		{
			ApplyAnimation(playerid, "COLT45", "colt45_fire_2hands", 4.0999, 0, 1, 1, 1, 1, 1);
		}
		else if(var0 == 6)
		{
			ApplyAnimation(playerid, "COLT45", "colt45_reload", 4.0999, 0, 1, 1, 1, 1, 1);
		}
		else if(var0 == 7)
		{
			ApplyAnimation(playerid, "COLT45", "sawnoff_reload", 4.0999, 0, 1, 1, 1, 1, 1);
		}
		if(var0 > 0 && var0 < 8)
		{
			SetPVarInt(playerid, "anim_do", 1);
		}
		else
		{
			GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~1 - 7", 1500, 3);
		}
		return 1;
	}
	else if(strcmp(arg1, "@lowrider", true, 5) == 0)
	{
		strmid(arg1, arg1, 9, 7, 32);
		var0 = strval(arg1);
		if(var0 == 1)
		{
			ApplyAnimation(playerid,"LOWRIDER","lrgirl_idleloop",4.1,0, 0, 0, 1, 0, 1);
		}
		else if(var0 == 2)
		{
			ApplyAnimation(playerid,"LOWRIDER","lrgirl_idle_to_l0",4.1,0, 0, 0, 1, 0, 1);
		}
		else if(var0 == 3)
		{
			ApplyAnimation(playerid,"LOWRIDER","lrgirl_l1_bnce",4.1,0, 0, 0, 1, 0, 1);
		}
		else if(var0 == 4)
		{
			ApplyAnimation(playerid,"LOWRIDER","lrgirl_l2_to_l3",4.1,0, 0, 0, 1, 0, 1);
		}
		else if(var0 == 5)
		{
			ApplyAnimation(playerid,"LOWRIDER","lrgirl_l5_bnce",4.1,0, 0, 0, 1, 0, 1);
		}
		if(var0 > 0 && var0 < 6)
		{
			SetPVarInt(playerid, "anim_do", 1);
		}
		else
		{
			GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~1 - 5", 1500, 3);
		}
		return 1;
	}
	else if(strcmp(arg1, "@sklep", true, 5) == 0)
	{
		strmid(arg1, arg1, 6, 7, 32);
		var0 = strval(arg1);
		if(var0 == 1)
		{
			ApplyAnimation(playerid,"INT_SHOP","shop_cashier",4.1,0, 0, 0, 1, 0, 1);
		}
		else if(var0 == 2)
		{
			ApplyAnimation(playerid,"INT_SHOP","shop_in",4.1,0, 0, 0, 1, 0, 1);
		}
		else if(var0 == 3)
		{
			ApplyAnimation(playerid,"INT_SHOP","shop_lookA",4.1,0, 0, 0, 1, 0, 1);
		}
		else if(var0 == 4)
		{
			ApplyAnimation(playerid,"INT_SHOP","shop_lookB",4.1,0, 0, 0, 1, 0, 1);
		}
		else if(var0 == 5)
		{
			ApplyAnimation(playerid,"INT_SHOP","shop_loop",4.1,0, 0, 0, 1, 0, 1);
		}
		else if(var0 == 6)
		{
			ApplyAnimation(playerid,"INT_SHOP","shop_out",4.1,0, 0, 0, 1, 0, 1);
		}
		else if(var0 == 7)
		{
			ApplyAnimation(playerid,"INT_SHOP","shop_pay",4.1,0, 0, 0, 1, 0, 1);
		}
		else if(var0 == 8)
		{
			ApplyAnimation(playerid,"INT_SHOP","shop_shelf",4.1,0, 0, 0, 1, 0, 1);
		}
		if(var0 > 0 && var0 < 9)
		{
			SetPVarInt(playerid, "anim_do", 1);
		}
		else
		{
			GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~1 - 8", 1500, 3);
		}
		return 1;
	}
	else if(strcmp(arg1, "@rozmowa", true, 5) == 0)
	{
		strmid(arg1, arg1, 5, 7, 32);
		var0 = strval(arg1);
		if(var0 == 1)
		{
			ApplyAnimation(playerid, "GANGS", "prtial_gngtlkA", 4.1,0, 0, 0, 1, 0, 1);
		}
		else if(var0 == 2)
		{
			ApplyAnimation(playerid, "GANGS", "prtial_gngtlkB", 4.1,0, 0, 0, 1, 0, 1);
		}
		else if(var0 == 3)
		{
			ApplyAnimation(playerid,"GANGS","prtial_gngtlkD",4.1,0, 0, 0, 1, 0, 1);
		}
		else if(var0 == 4)
		{
			ApplyAnimation(playerid,"LOWRIDER","prtial_gngtlkD",4.1,0, 0, 0, 1, 0, 1);
		}
		else if(var0 == 5)
		{
   			ApplyAnimation(playerid,"LOWRIDER","prtial_gngtlkH",4.1,0, 0, 0, 1, 0, 1);
		}
		else if(var0 == 6)
		{
			ApplyAnimation(playerid,"LOWRIDER","prtial_gngtlkE",4.1,0, 0, 0, 1, 0, 1);
		}
		if(var0 > 0 && var0 < 7)
		{
			SetPVarInt(playerid, "anim_do", 1);
		}
		else
		{
			GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~1 - 6", 1500, 3);
		}
		return 1;
	}
	else if(strcmp(arg1, "@car", true, 4) == 0)
	{
		strmid(arg1, arg1, 4, 7, 32);
		var0 = strval(arg1);
		if(var0 == 1)
		{
			ApplyAnimation(playerid, "CAR", "Fixn_Car_Loop", 4.0999, 0, 1, 1, 1, 1, 1);
		}
		else if(var0 == 2)
		{
			ApplyAnimation(playerid, "CAR", "Fixn_Car_Out", 4.0999, 0, 1, 1, 1, 1, 1);
		}
		else if(var0 == 3)
		{
			ApplyAnimation(playerid, "CAR", "flag_drop", 4.0999, 0, 1, 1, 1, 1, 1);
		}
		else if(var0 == 4)
		{
			ApplyAnimation(playerid, "CAR", "Sit_relaxed", 4.0999, 0, 1, 1, 1, 1, 1);
		}
		else if(var0 == 5)
		{
			ApplyAnimation(playerid, "CAR", "Tap_hand", 4.0999, 0, 1, 1, 1, 1, 1);
		}
		else if(var0 == 6)
		{
			ApplyAnimation(playerid, "CAR", "Tyd2car_bump", 4.0999, 0, 1, 1, 1, 1, 1);
		}
		else if(var0 == 7)
		{
			ApplyAnimation(playerid, "CAR", "Tyd2car_high", 4.0999, 0, 1, 1, 1, 1, 1);
		}
		else if(var0 == 8)
		{
			ApplyAnimation(playerid, "CAR", "Tyd2car_low", 4.0999, 0, 1, 1, 1, 1, 1);
		}
		else if(var0 == 9)
		{
			ApplyAnimation(playerid, "CAR", "Tyd2car_med", 4.0999, 0, 1, 1, 1, 1, 1);
		}
		else if(var0 == 10)
		{
			ApplyAnimation(playerid, "CAR", "Tyd2car_TurnL", 4.0999, 0, 1, 1, 1, 1, 1);
		}
		else if(var0 == 11)
		{
			ApplyAnimation(playerid, "CAR", "Tyd2car_TurnR", 4.0999, 0, 1, 1, 1, 1, 1);
		}
		if(var0 > 0 && var0 < 12)
		{
			SetPVarInt(playerid, "anim_do", 1);
		}
		else
		{
			GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~1 - 11", 1500, 3);
		}
	}
	return 0;
}
//end