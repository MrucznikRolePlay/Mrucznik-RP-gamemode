#include <a_samp>
#include <core>
#include <float>


public MRP_ShowAnim(playerid)
{
	new var0[2048];
	format(var0, 2048, "@idz\n@colt\n@car\n@dance\n@rap\n@strip\n@sex\n@nies");
	format(var0, 2048, "%s\n@odbierz\n@rozlacz\n@opieraj\n@sikaj\n@wolaj\n@greet\n@stoj\n@ranny3\n@hitch\n@klepnij3\n@medyk\n@stack6\n@stack7\n@stack8\n@stack9\n@stack10\n@daj2\n@krzeslo2\n@klepni\n@pij\n@krzeslo3\n@kozak\n@wygralem\n@wygralem2\n@tak\n@pa\n@rece\n@waledochodze\n@walekonia", var0);
	format(var0, 2048, "%s\n@diler2\n@dzieki\n@tak\n@nie\n@rap4\n@komputer\n@drap\n@bomba\n@celuj\n@smiech\n@maska\n@napad\n@ramiona\n@diler3\n@diler4\n@lez \n@wymiotuj\n@zarcie\n@machaj\n@diler\n@crack\n@papieros\n@papieros2\n@siad\n@siad2\n@stack11\n@fuck\n@idiota\n@krzeslo\n@lez3", var0);
	format(var0, 2048, "%s\n@ustawka\n@ustawka2\n@ustawka3\n@ustawka5\n@czas\n@yo\n@yo2\n@yo4\n@yo5\n@yo6\n@yo7\n@placz\n@placz2\n@spij\n@spij2\n@spij3\n@spij4\n@caluj2\n@caluj3\n@caluj4\n@caluj5\n@caluj6\n@caluj7\n@caluj8\n@lokiec\n@lokiec2\n@rozciagaj\n@doping\n@wtf\n@siad3", var0);
	format(var0, 2048, "%s\n@cpun2\n@stack\n@stack2\n@stack3\n@stack5\n@zmeczony\n@wozszlug\n@napad\n@wstan\n@kosz\n@kosz2\n@kosz3\n@kosz4\n@kosz5\n@kosz6\n@box\n@przeladuj\n@bar\n@bar2\n@bar3\n@bar4\n@lez2\n@podnies2\n@odloz\n@joint\n@smierc\n@oh\n@smierc2\n@celujkarabin\n@podnies", var0);
	ShowPlayerDialog(playerid, 15621, 2, "{4876FF}Mrucznik Role Play » {FFFFFF}Animacje", var0, "Wybierz", "WyjdŸ");
	return 1;
}

public MRP_DoAnimation(playerid, arg1[])
{
	new var0 = 0;
	if(strcmp(arg1, "@rece", true) == 0)
	{
		SetPlayerSpecialAction(playerid, 10);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@stopanim", true) == 0)
	{
		ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@dance", true, 6) == 0)
	{
		strmid(arg1, arg1, 6, 8, 32);
		var0 = strval(arg1);
		if(var0 == 0 || var0 == 1)
		{
			SetPlayerSpecialAction(playerid, 5);
		}
		else if(var0 == 2)
		{
			SetPlayerSpecialAction(playerid, 6);
		}
		else if(var0 == 3)
		{
			SetPlayerSpecialAction(playerid, 7);
		}
		else if(var0 == 4)
		{
			SetPlayerSpecialAction(playerid, 8);
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
	if(strcmp(arg1, "@rap", true, 4) == 0)
	{
		strmid(arg1, arg1, 4, 6, 32);
		var0 = strval(arg1);
		if(var0 == 0 || var0 == 1)
		{
			ApplyAnimation(playerid, "RAPPING", "RAP_A_Loop", 4.0999, 1, 0, 0, 0, 0, 0);
		}
		else if(var0 == 2)
		{
			ApplyAnimation(playerid, "RAPPING", "RAP_B_Loop", 4.0999, 1, 0, 0, 0, 0, 0);
		}
		else if(var0 == 3)
		{
			ApplyAnimation(playerid, "RAPPING", "RAP_C_Loop", 4.0999, 1, 0, 0, 0, 0, 0);
		}
		else if(var0 == 4)
		{
			ApplyAnimation(playerid, "GYMNASIUM", "gym_tread_celebrate", 4.0999, 1, 0, 0, 0, 0, 0);
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
	if(strcmp(arg1, "@waledochodze", true) == 0)
	{
		ApplyAnimation(playerid, "PAULNMAC", "wank_out", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@walekonia", true) == 0)
	{
		ApplyAnimation(playerid, "PAULNMAC", "wank_loop", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@strip", true, 6) == 0)
	{
		strmid(arg1, arg1, 6, 8, 32);
		var0 = strval(arg1);
		if(var0 == 0 || var0 == 1)
		{
			ApplyAnimation(playerid, "STRIP", "strip_A", 4.0999, 1, 0, 0, 0, 0, 0);
		}
		else if(var0 == 2)
		{
			ApplyAnimation(playerid, "STRIP", "strip_B", 4.0999, 1, 0, 0, 0, 0, 0);
		}
		else if(var0 == 3)
		{
			ApplyAnimation(playerid, "STRIP", "strip_C", 4.0999, 1, 0, 0, 0, 0, 0);
		}
		else if(var0 == 4)
		{
			ApplyAnimation(playerid, "STRIP", "strip_D", 4.0999, 1, 0, 0, 0, 0, 0);
		}
		else if(var0 == 5)
		{
			ApplyAnimation(playerid, "STRIP", "strip_E", 4.0999, 1, 0, 0, 0, 0, 0);
		}
		else if(var0 == 6)
		{
			ApplyAnimation(playerid, "STRIP", "strip_F", 4.0999, 1, 0, 0, 0, 0, 0);
		}
		else if(var0 == 7)
		{
			ApplyAnimation(playerid, "STRIP", "strip_G", 4.0999, 1, 0, 0, 0, 0, 0);
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
	if(strcmp(arg1, "@sex", true, 4) == 0)
	{
		strmid(arg1, arg1, 4, 7, 32);
		var0 = strval(arg1);
		if(var0 == 0 || var0 == 1)
		{
			ApplyAnimation(playerid, "SNM", "SPANKING_IDLEW", 4.0999, 0, 0, 0, 1, 0, 0);
		}
		else if(var0 == 2)
		{
			ApplyAnimation(playerid, "SNM", "SPANKING_IDLEP", 4.0999, 0, 1, 1, 1, 0, 1);
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
			ApplyAnimation(playerid, "SNM", "SPANKING_ENDW", 4.0999, 0, 1, 1, 1, 0, 1);
		}
		else if(var0 == 8)
		{
			ApplyAnimation(playerid, "SNM", "SPANKING_ENDP", 4.0999, 0, 0, 0, 1, 0, 1);
		}
		else if(var0 == 9)
		{
			ApplyAnimation(playerid, "SNM", "SPANKING_IDLEP", 4.0999, 0, 1, 1, 1, 0, 1);
		}
		else if(var0 == 10)
		{
			ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_START_P", 4.0999, 0, 1, 1, 1, 0, 1);
		}
		else if(var0 == 11)
		{
			ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_P", 4.0999, 0, 1, 1, 1, 0, 1);
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
	if(strcmp(arg1, "@idz", true, 4) == 0)
	{
		strmid(arg1, arg1, 4, 6, 32);
		var0 = strval(arg1);
		if(var0 == 0 || var0 == 1)
		{
			ApplyAnimation(playerid, "PED", "WALK_gang1", 4.0999, 1, 1, 1, 1, 1, 0);
		}
		else if(var0 == 2)
		{
			ApplyAnimation(playerid, "PED", "WALK_gang2", 4.0999, 1, 1, 1, 1, 1, 0);
		}
		else if(var0 == 3)
		{
			ApplyAnimation(playerid, "ped", "WALK_player", 4.0999, 1, 1, 1, 1, 1, 0);
		}
		else if(var0 == 4)
		{
			ApplyAnimation(playerid, "ped", "WOMAN_walksexy", 4.0999, 1, 1, 1, 1, 1, 0);
		}
		else if(var0 == 5)
		{
			ApplyAnimation(playerid, "PED", "WALK_old", 4.0999, 1, 1, 1, 1, 1, 0);
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
	if(strcmp(arg1, "@nies", true, 5) == 0)
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
	if(strcmp(arg1, "@odbierz", true) == 0)
	{
		SetPlayerSpecialAction(playerid, 11);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@rozlacz", true) == 0)
	{
		SetPlayerSpecialAction(playerid, 13);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@opieraj", true) == 0)
	{
		ApplyAnimation(playerid, "GANGS", "leanIDLE", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@sikaj", true) == 0)
	{
		SetPlayerSpecialAction(playerid, 68);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@wolaj", true) == 0)
	{
		ApplyAnimation(playerid, "WUZI", "Wuzi_follow", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@greet", true) == 0)
	{
		ApplyAnimation(playerid, "WUZI", "Wuzi_Greet_Wuzi", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@stoj", true) == 0)
	{
		ApplyAnimation(playerid, "WUZI", "Wuzi_stand_loop", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@ranny3", true) == 0)
	{
		ApplyAnimation(playerid, "SWAT", "gnstwall_injurd", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@hitch", true) == 0)
	{
		ApplyAnimation(playerid, "MISC", "Hiker_Pose", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@klepnij3", true) == 0)
	{
		ApplyAnimation(playerid, "MISC", "bitchslap", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@medyk", true) == 0)
	{
		ApplyAnimation(playerid, "MEDIC", "CPR", 4.0999, 0, 1, 1, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@stack6", true) == 0)
	{
		ApplyAnimation(playerid, "GHANDS", "gsign1", 4.0999, 0, 0, 0, 1, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@stack7", true) == 0)
	{
		ApplyAnimation(playerid, "GHANDS", "gsign2", 4.0999, 0, 0, 0, 1, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@stack8", true) == 0)
	{
		ApplyAnimation(playerid, "GHANDS", "gsign3", 4.0999, 0, 0, 0, 1, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@stack9", true) == 0)
	{
		ApplyAnimation(playerid, "GHANDS", "gsign4", 4.0999, 0, 0, 0, 1, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@stack10", true) == 0)
	{
		ApplyAnimation(playerid, "GHANDS", "gsign5", 4.0999, 0, 0, 0, 1, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@daj2", true) == 0)
	{
		ApplyAnimation(playerid, "KISSING", "gift_give", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@krzeslo", true) == 0)
	{
		ApplyAnimation(playerid, "PED", "SEAT_idle", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@ranny2", true) == 0)
	{
		ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@klepnij2", true) == 0)
	{
		ApplyAnimation(playerid, "SWEET", "ho_ass_slapped", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@klepnij", true) == 0)
	{
		ApplyAnimation(playerid, "SWEET", "sweet_ass_slap", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@pij", true) == 0)
	{
		ApplyAnimation(playerid, "PED", "WALK_DRUNK", 4.0999, 1, 1, 1, 1, 1, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@rolki", true) == 0)
	{
		GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~r~Wylaczone", 1500, 3);
		return 1;
	}
	if(strcmp(arg1, "@krzeslo3", true) == 0)
	{
		ApplyAnimation(playerid, "FOOD", "FF_Sit_Loop", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@kozak", true) == 0)
	{
		ApplyAnimation(playerid, "benchpress", "gym_bp_celebrate", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@wygralem", true) == 0)
	{
		ApplyAnimation(playerid, "CASINO", "cards_win", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@wygralem2", true) == 0)
	{
		ApplyAnimation(playerid, "CASINO", "Roulette_win", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@diler2", true) == 0)
	{
		ApplyAnimation(playerid, "DEALER", "DRUGS_BUY", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@dzieki", true) == 0)
	{
		ApplyAnimation(playerid, "FOOD", "SHP_Thank", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@tak", true) == 0)
	{
		ApplyAnimation(playerid, "GANGS", "Invite_Yes", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@nie", true) == 0)
	{
		ApplyAnimation(playerid, "GANGS", "Invite_No", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@komputer", true) == 0)
	{
		ApplyAnimation(playerid, "INT_OFFICE", "OFF_Sit_Type_Loop", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@drap", true) == 0)
	{
		ApplyAnimation(playerid, "MISC", "Scratchballs_01", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp("@bomba", arg1, true) == 0)
	{
		ClearAnimations(playerid, 0);
		ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp("@celuj", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "ped", "ARRESTgun", 4.0999, 0, 1, 1, 1, 1, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp("@smiech", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "RAPPING", "Laugh_01", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp("@maska", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "SHOP", "ROB_Shifty", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp("@napad", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "SHOP", "ROB_Loop_Threat", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp("@ramiona", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp("@diler3", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "DEALER", "DEALER_IDLE", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp("@pa", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "PED", "endchat_03", 4.0999, 0, 1, 1, 1, 1, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp("@diler4", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "DEALER", "DEALER_IDLE_01", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp("@lez", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "BEACH", "bather", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp("@wymiotuj", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp("@zarcie", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp("@machaj", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "ON_LOOKERS", "wave_loop", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp("@diler", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "DEALER", "DEALER_DEAL", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp("@crack", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp("@papieros", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "SMOKING", "M_smklean_loop", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp("@papieros2", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "SMOKING", "F_smklean_loop", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp("@siad", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "BEACH", "ParkSit_M_loop", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp("@siad2", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "BEACH", "ParkSit_W_loop", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp("@rolki", arg1, true) == 0)
	{
		/*ApplyAnimation(playerid, "SKATE", "skate_sprint", 4.0999, 1, 1, 1, 1, 1, 1);
		SetPVarInt(playerid, "anim_do", 1);*/
		SendClientMessage(playerid, -1, "Ta animacja zosta³a wy³¹czona na czas tworzenia systemu przedmiotów!");
		return 1;
	}
	if(strcmp("@siad4", arg1, true) == 0)
	{
		ApplyAnimation(playerid, "JST_BUISNESS", "girl_02", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@stack11", true) == 0)
	{
		ApplyAnimation(playerid, "PED", "IDLE_CHAT", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@fuck", true) == 0)
	{
		ApplyAnimation(playerid, "PED", "fucku", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@idiota", true) == 0)
	{
		ApplyAnimation(playerid, "PARK", "Tai_Chi_Loop", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@krzeslo2", true) == 0)
	{
		ApplyAnimation(playerid, "BAR", "dnk_stndF_loop", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@lez3", true) == 0)
	{
		ApplyAnimation(playerid, "BEACH", "Lay_Bac_Loop", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@ustawka", true) == 0)
	{
		ApplyAnimation(playerid, "BASEBALL", "Bat_IDLE", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@ustawka2", true) == 0)
	{
		ApplyAnimation(playerid, "BASEBALL", "Bat_M", 4.0999, 1, 1, 1, 1, 1, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@ustawka3", true) == 0)
	{
		ApplyAnimation(playerid, "BASEBALL", "BAT_PART", 4.0999, 1, 1, 1, 1, 1, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@ustawka4", true) == 0)
	{
		ApplyAnimation(playerid, "CRACK", "Bbalbat_Idle_01", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@ustawka5", true) == 0)
	{
		ApplyAnimation(playerid, "CRACK", "Bbalbat_Idle_02", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@czas", true) == 0)
	{
		ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_nod", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@yo", true) == 0)
	{
		ApplyAnimation(playerid, "GANGS", "hndshkaa", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@yo2", true) == 0)
	{
		ApplyAnimation(playerid, "GANGS", "hndshkba", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@yo3", true) == 0)
	{
		ApplyAnimation(playerid, "GANGS", "hndshkca", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@yo4", true) == 0)
	{
		ApplyAnimation(playerid, "GANGS", "hndshkcb", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@yo5", true) == 0)
	{
		ApplyAnimation(playerid, "GANGS", "hndshkda", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@yo6", true) == 0)
	{
		ApplyAnimation(playerid, "GANGS", "hndshkea", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@yo7", true) == 0)
	{
		ApplyAnimation(playerid, "GANGS", "hndshkfa", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@placz", true) == 0)
	{
		ApplyAnimation(playerid, "GRAVEYARD", "mrnF_loop", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@placz2", true) == 0)
	{
		ApplyAnimation(playerid, "GRAVEYARD", "mrnM_loop", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@spij", true) == 0)
	{
		ApplyAnimation(playerid, "INT_HOUSE", "BED_In_L", 4.0999, 0, 1, 1, 1, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@spij2", true) == 0)
	{
		ApplyAnimation(playerid, "INT_HOUSE", "BED_In_R", 4.0999, 0, 1, 1, 1, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@spij3", true) == 0)
	{
		ApplyAnimation(playerid, "INT_HOUSE", "BED_Loop_L", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@spij4", true) == 0)
	{
		ApplyAnimation(playerid, "INT_HOUSE", "BED_Loop_R", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@caluj2", true) == 0)
	{
		ApplyAnimation(playerid, "BD_FIRE", "Grlfrd_Kiss_03", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@caluj3", true) == 0)
	{
		ApplyAnimation(playerid, "KISSING", "Grlfrd_Kiss_01", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@caluj4", true) == 0)
	{
		ApplyAnimation(playerid, "KISSING", "Grlfrd_Kiss_02", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@caluj5", true) == 0)
	{
		ApplyAnimation(playerid, "KISSING", "Grlfrd_Kiss_03", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@caluj6", true) == 0)
	{
		ApplyAnimation(playerid, "KISSING", "Playa_Kiss_01", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@caluj7", true) == 0)
	{
		ApplyAnimation(playerid, "KISSING", "Playa_Kiss_02", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@caluj8", true) == 0)
	{
		ApplyAnimation(playerid, "KISSING", "Playa_Kiss_03", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@lokiec", true) == 0)
	{
		ApplyAnimation(playerid, "CAR", "Tap_hand", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@lokiec2", true) == 0)
	{
		ApplyAnimation(playerid, "LOWRIDER", "Sit_relaxed", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@rozciagaj", true) == 0)
	{
		ApplyAnimation(playerid, "PLAYIDLES", "stretch", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@doping", true) == 0)
	{
		ApplyAnimation(playerid, "RIOT", "RIOT_CHANT", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@wtf", true) == 0)
	{
		ApplyAnimation(playerid, "RIOT", "RIOT_ANGRY", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp("@cpun2", arg1, true, 6) == 0)
	{
		ApplyAnimation(playerid, "CRACK", "crckidle2", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@stack", true) == 0)
	{
		ApplyAnimation(playerid, "GHANDS", "gsign1LH", 4.0999, 0, 1, 1, 1, 1, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@stack2", true) == 0)
	{
		ApplyAnimation(playerid, "GHANDS", "gsign2LH", 4.0999, 0, 1, 1, 1, 1, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@stack3", true) == 0)
	{
		ApplyAnimation(playerid, "GHANDS", "gsign3LH", 4.0999, 0, 1, 1, 1, 1, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@stack4", true) == 0)
	{
		ApplyAnimation(playerid, "GHANDS", "gsign4LH", 4.0999, 0, 1, 1, 1, 1, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@stack5", true) == 0)
	{
		ApplyAnimation(playerid, "GHANDS", "gsign5LH", 4.0999, 0, 1, 1, 1, 1, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@zmeczony", true) == 0)
	{
		ApplyAnimation(playerid, "FAT", "IDLE_tired", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@wozszlug", true) == 0)
	{
		ApplyAnimation(playerid, "PED", "Smoke_in_car", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@napad", true) == 0)
	{
		ApplyAnimation(playerid, "PED", "gang_gunstand", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@wstan", true) == 0)
	{
		ApplyAnimation(playerid, "PED", "getup", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@kosz", true) == 0)
	{
		ApplyAnimation(playerid, "BSKTBALL", "BBALL_def_loop", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@kosz2", true) == 0)
	{
		ApplyAnimation(playerid, "BSKTBALL", "BBALL_idleloop", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@kosz3", true) == 0)
	{
		ApplyAnimation(playerid, "BSKTBALL", "BBALL_pickup", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@kosz4", true) == 0)
	{
		ApplyAnimation(playerid, "BSKTBALL", "BBALL_Jump_Shot", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@kosz5", true) == 0)
	{
		ApplyAnimation(playerid, "BSKTBALL", "BBALL_Dnk", 4.0999, 0, 1, 1, 1, 1, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@kosz6", true) == 0)
	{
		ApplyAnimation(playerid, "BSKTBALL", "BBALL_run", 4.0999, 1, 1, 1, 1, 1, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@walnij", true) == 0)
	{
		ApplyAnimation(playerid, "FIGHT_E", "FightKick", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@box", true) == 0)
	{
		ApplyAnimation(playerid, "GYMNASIUM", "gym_shadowbox", 4.0999, 1, 1, 1, 1, 1, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@przeladuj", true) == 0)
	{
		ApplyAnimation(playerid, "SILENCED", "Silence_reload", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@bar1", true) == 0)
	{
		ApplyAnimation(playerid, "BAR", "Barcustom_get", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@bar2", true) == 0)
	{
		ApplyAnimation(playerid, "BAR", "Barcustom_order", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@bar3", true) == 0)
	{
		ApplyAnimation(playerid, "BAR", "Barserve_give", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@bar4", true) == 0)
	{
		ApplyAnimation(playerid, "BAR", "Barserve_glass", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp("@lez2", arg1, true, 6) == 0)
	{
		ApplyAnimation(playerid, "BEACH", "SitnWait_loop_W", 4.0999, 1, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@podnies2", true) == 0)
	{
		ApplyAnimation(playerid, "CARRY", "liftup", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@odloz", true) == 0)
	{
		ApplyAnimation(playerid, "CARRY", "putdwn", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@joint", true) == 0)
	{
		ApplyAnimation(playerid, "GANGS", "smkcig_prtl", 4.0999, 0, 1, 1, 1, 1, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@smierc", true) == 0)
	{
		ApplyAnimation(playerid, "KNIFE", "KILL_Knife_Ped_Die", 4.0999, 0, 1, 1, 1, 1, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@oh", true) == 0)
	{
		ApplyAnimation(playerid, "MISC", "plyr_shkhead", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@smierc2", true) == 0)
	{
		ApplyAnimation(playerid, "PARACHUTE", "FALL_skyDive_DIE", 4.0999, 0, 1, 1, 1, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@celujkarabin", true) == 0)
	{
		ApplyAnimation(playerid, "SHOP", "SHP_Gun_Aim", 4.0999, 0, 1, 1, 1, 1, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@podnies", true) == 0)
	{
		ApplyAnimation(playerid, "BAR", "Barserve_bottle", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@karta", true) == 0)
	{
		ApplyAnimation(playerid, "GRAFFITI", "graffiti_Chkout", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@dodge", true) == 0)
	{
		ApplyAnimation(playerid, "DODGE", "Crush_Jump", 4.0999, 0, 1, 1, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 1);
		return 1;
	}
	if(strcmp(arg1, "@colt", true, 5) == 0)
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
	if(strcmp(arg1, "@car", true, 4) == 0)
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

public OnFilterScriptInit()
{
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == 15621)
	{
		if(!response)
		{
			return 1;
		}
		if(GetPVarInt(playerid, "calledthis") == 0)
		{
			return 1;
		}
		if(strlen(inputtext) > 31)
		{
			return 1;
		}
		new var0 = CallLocalFunction("MRP_DoAnimation", "is[32]", playerid, inputtext);
		if(var0 != 1)
		{
			GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~Brak animacji", 1500, 3);
		}
		SetPVarInt(playerid, "calledthis", 0);
		return 1;
	}
	return 0;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & 4 && GetPVarInt(playerid, "anim_do") == 1)
	{
		if(GetPlayerSpecialAction(playerid) != 0)
		{
			SetPlayerSpecialAction(playerid, 0);
		}
		ClearAnimations(playerid, 0);
		ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0999, 0, 0, 0, 0, 0, 0);
		SetPVarInt(playerid, "anim_do", 0);
		return 0;
	}
	return 1;
}

