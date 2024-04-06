//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  wezdragi                                                 //
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
// Data utworzenia: 06.04.2024


//

//------------------<[ Implementacja: ]>-------------------
command_wezdragi_Impl(playerid)
{
	if(PlayerBoxing[playerid] > 0)
	{
		MruMessageFail(playerid, "Nie mo¿esz u¿ywaæ dragów podczas walki.");
		return 1;
	}

	if(PlayerInfo[playerid][pDrugs] <= 0)
	{
		MruMessageFail(playerid, "Nie masz ju¿ wiêcej narkotyków.");
		return 1;
	}

	new Float:hpBuff = 10.0 * (PlayerInfo[playerid][pDrugPerk] + 1);
	new Float:armorBuff = 10.0 * (PlayerInfo[playerid][pDrugPerk] + 1);

	new Float:hp, Float:armor;
	GetPlayerHealth(playerid, hp);
	GetPlayerArmour(playerid, armor);

	new Float:newHp = hp + hpBuff;
	new Float:newArmor = armor + armorBuff;
	if(newHp > 100.0) newHp = 100.0;
	if(newArmor > 100.0) newArmor = 100.0;

	SetPlayerHealth(playerid, newHp);
	SetPlayerArmour(playerid, newArmor);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);

	PlayerInfo[playerid][pDrugs] -= 1;

	MruMessageGoodInfoF(playerid, "Za¿y³eœ 1 gram narkotyków, dostajesz %.0f HP i %.0f pancerza.", hpBuff, armorBuff);
	ChatMe(playerid, "za¿ywa narkotyk.");

	// efekty
	new rand = random(100);
	if(rand < 25 && IsPlayerSick(playerid, DRUG_BAD))
	{
		PlayerPlaySound(playerid, 5202, 0.0, 0.0, 0.0);
		CurePlayer(playerid, DRUG_BAD);
		MruMessageGoodInfo(playerid, "Pozby³eœ siê efektu odstawiennictwa!");
	}
	else if(rand < 30 && IsPlayerSick(playerid, DRUG_BAD))
	{
		PlayerPlaySound(playerid, 5203, 0.0, 0.0, 0.0);
		MruMessageBadInfo(playerid, "Uzale¿ni³eœ siê od narkotyków!");
		InfectPlayer(playerid, DRUG_ADDICT);
	}
	else if(rand < 87)
	{
		// good effect
		PlayerPlaySound(playerid, 5202, 0.0, 0.0, 0.0);
		InfectPlayer(playerid, DRUG_GOOD);
	}
	else if(rand < 97)
	{
		// nothing - trefny towar
		PlayerPlaySound(playerid, 5204, 0.0, 0.0, 0.0);
		MruMessageBadInfo(playerid, "Towar najprawdopodobniej by³ trefny - nie czujesz nic poza tym.");
	}
	else if(rand < 99)
	{
		// addict
		if(IsPlayerSick(playerid, DRUG_ADDICT))
		{
			// do nothing if already addicted
			PlayerPlaySound(playerid, 5204, 0.0, 0.0, 0.0);
			MruMessageBadInfo(playerid, "Towar najprawdopodobniej by³ trefny - nie czujesz nic poza tym.");
		}
		else
		{
			PlayerPlaySound(playerid, 5203, 0.0, 0.0, 0.0);
			MruMessageBadInfo(playerid, "Uzale¿ni³eœ siê od narkotyków!");
			InfectPlayer(playerid, DRUG_ADDICT);
		}
	}
	else // 1% szans na negatywne efekty
	{
		PlayerPlaySound(playerid, 5206, 0.0, 0.0, 0.0);
		if(rand < 97)
		{
			SendClientMessage(playerid, COLOR_FADE1, "Marcepan_Marks Szepcze: hera koka hasz LSD, ta zabawa po nocach siê œni... Lepiej idŸ do lekarza!");
			InfectOrDecreaseImmunity(playerid, SCHIZOFRENIA);
		}
		else if(rand < 99)
		{
			MruMessageBadInfo(playerid, "Twoja postaæ zdaje siê traciæ panowanie nad swoimi zdolnoœciami motorycznymi... Lepiej idŸ do lekarza!");
			InfectOrDecreaseImmunity(playerid, PADACZKA);
		}
		else
		{
			MruMessageBadInfo(playerid, "Zdaje siê, ¿e u¿ycie ig³y z drugiej rêki nie by³o najlepszym pomys³em... Lepiej idŸ do lekarza!");
			InfectOrDecreaseImmunity(playerid, HIV);
		}
	}
    return 1;
}

//end