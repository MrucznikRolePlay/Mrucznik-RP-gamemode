//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  choroby                                                  //
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
// Autor: Mrucznik
// Data utworzenia: 07.02.2020
//Opis:
/*
	System chorób.
*/

//

//-----------------<[ Funkcje: ]>-------------------
//Koronawirus
public WuhanCouching(playerid, disease, value)
{
	ChatMe(playerid, "zaczyna kaszleæ.");
	ApplyAnimation(playerid, "ON_LOOKERS", "shout_01", 4.0, 0, 0, 0, 0, 0, 1);
	return 1;
}
public DusznosciEffect(playerid, disease, value)
{
	ApplyAnimation(playerid, "KNIFE", "KILL_Knife_Ped_Die", 4.0999, 0, 1, 1, 1, 1, 1);
	ChatMe(playerid, "zaczyna siê dusiæ.");
	defer LoweringHP(playerid, PlayerInfo[playerid][UID], value, true, false);
	SetPlayerDrunkLevel(playerid, 5000);
	return 1;
}
public FeverEffect(playerid, disease, value)
{
	ChatMe(playerid, "ma gor¹czkê, poci siê i czuje siê s³abo.");
	new Float:hp;
	GetPlayerHealth(playerid, hp);

	new Float:loss = value;
	SetPlayerHealth(playerid, (hp - loss <= 0) ? 1.0 : hp-loss);
	SetPlayerDrunkLevel(playerid, 5000);
	return 1;
}
public KoronawirusDeathEffect(playerid, disease, value)
{
	ChatDo(playerid, sprintf("Koronawirus doszczêtnie wyniszczy³ organizm %s", GetNick(playerid)));
	ChatMe(playerid, "upada na ziemie i zaczyna umieraæ");
	TogglePlayerControllable(playerid, 0);
	defer LoweringHP(playerid, PlayerInfo[playerid][UID], value, true, true);
	ApplyAnimation(playerid, "KNIFE", "KILL_Knife_Ped_Die", 4.0999, 0, 1, 1, 1, 1, 1);
	return 1;
}

//Grypa
public FeelingBadEffect(playerid, disease, value)
{
	ChatMe(playerid, "poczu³ siê Ÿle.");
	ApplyAnimation(playerid, "FAT", "IDLE_tired", 4.0999, 0, 0, 0, 0, 0, 1);
	SetPlayerDrunkLevel(playerid, 5000);
	return 1;
}
public CouchingEffect(playerid, disease, value)
{
	ChatMe(playerid, "zaczyna kaszleæ.");
	ApplyAnimation(playerid, "ON_LOOKERS", "shout_01", 4.0, 0, 0, 0, 0, 0, 1);

	if(random(20) == 1)//5% szans
	{
		InfectPlayer(playerid, ZAPALENIE_PLUC);
	}
	return 1;
}
public HPLossEffect(playerid, disease, value)
{
	new Float:hp;
	GetPlayerHealth(playerid, hp);

	new Float:loss = value;
	SetPlayerHealth(playerid, (hp - loss <= 0) ? 1.0 : hp-loss);
	ChatMe(playerid, "czuje siê s³abo.");
	SetPlayerDrunkLevel(playerid, 5000);
	return 1;
}

//Zapalenie p³uc
public HPLossToDeathEffect(playerid, disease, value)
{
	new Float:hp;
	GetPlayerHealth(playerid, hp);

	new Float:loss = value;
	if(hp - loss <= 0)
	{
		NadajRanny(playerid, INJURY_TIME_DISEASES);
	}
	else SetPlayerHealth(playerid, hp-loss);
	ChatMe(playerid, "poczu³ mocny ból.");
	SetPlayerDrunkLevel(playerid, 5000);
	return 1;
}

//Zatrucie
public FartEffect(playerid, disease, value)
{
	ChatDo(playerid, sprintf("wokó³ %s unosi siê nieprzyjemna woñ przetrawionego jedzenia.", GetNick(playerid)));
	return 1;
}
public DiarrheaEffect(playerid, disease, value)
{
	ChatDo(playerid, sprintf("z nogawki %s cieknie br¹zowy p³yn.", GetNick(playerid)));
	return 1;
}
public ShittingEffect(playerid, disease, value)
{
	ChatMe(playerid, "nie wytrzymuje ciœnienia i zaczyna defekowaæ siê w gacie.");
	return 1;
}
public AbdominalPainEffect(playerid, disease, value)
{
	ChatMe(playerid, "czuje ostry ból ¿o³¹dka.");
	new Float:hp;
	GetPlayerHealth(playerid, hp);

	new Float:loss = value;
	SetPlayerHealth(playerid, (hp - loss <= 0) ? 1.0 : hp-loss);
}
public VomitEffect(playerid, disease, value)
{
	ChatMe(playerid, "zaczyna wymiotowaæ.");
	ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P", 4.0999, 0, 0, 0, 0, 0, 1);
	return 1;
}

//Padaka
public EpilepsyEffect(playerid, disease, value)
{
	ApplyAnimation(playerid, "CRACK", "crckdeth1", 4.1, 0, 1, 1, 1, 1, 1);
	ChatMe(playerid, "upada na ziemiê i zaczyna siê trz¹œæ oraz wykonywaæ niekontrolowane ruchy.");
	TogglePlayerControllable(playerid, 0); //TODO: nie odmra¿aæ gdy gracz ju¿ by³ zamro¿ony
	defer LoweringHP(playerid, PlayerInfo[playerid][UID], value, true, true);
	return 1;
}

//Tourett
public TourettShoutEffect(playerid, disease, value)
{
	//TODO:
	// static shouts[][] = {
	// 	""
	// };

	// Krzyk(playerid, shouts[random(sizeof(shouts))]);
	switch(random(4))
	{
		case 0: ChatMe(playerid, "chrz¹ka.");
		case 1: ChatMe(playerid, "wykonuje tik nerwowy.");
		case 2: ChatMe(playerid, "uderza siê d³oni¹ w g³owê.");
		case 3: ChatMe(playerid, "miauczy.");
	}
}
public TourettPermanentEffect(playerid, disease, value)
{
	TourettActive[playerid] = 1;
}
public TourettPermanentEffect_Off(playerid, disease, value)
{
	TourettActive[playerid] = 0;
}

//Astma
public AnaphylacticShock(playerid, disease, value)
{
	ApplyAnimation(playerid, "KNIFE", "KILL_Knife_Ped_Die", 4.0999, 0, 1, 1, 1, 1, 1);
	ChatMe(playerid, "nie mo¿e oddychaæ i zaczyna siê dusiæ.");
	TogglePlayerControllable(playerid, 0); //TODO: nie odmra¿aæ gdy gracz ju¿ by³ zamro¿ony
	defer LoweringHP(playerid, PlayerInfo[playerid][UID], value, true, true);
	SetPlayerDrunkLevel(playerid, 5000);
	return 1;
}

//Schizofrenia paranoidalna
//TODO: wiêcej efektów
public HallucinationsEffect(playerid, disease, value)
{
	ChatMe(playerid, "zaczyna widzieæ niestworzone rzeczy.");
	SetPlayerDrunkLevel(playerid, 8000);
	SetPlayerWeather(playerid, -66);
	defer HallucinationsOff(playerid);
	return 1;
}

//Zombie effects
public ZombieSkinEffect(playerid, disease, value)
{
	//TODO
	SetPlayerSkin(playerid, 20004+random(3));
	return 1;
}
public ZombieSkinEffect_Off(playerid, disease, value)
{
	SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
	return 1;
}
public ZombieTalkEffect(playerid, disease, value)
{
	//TODO
}

//HIV
public ReducedImmunityEffect(playerid, disease, value)
{
	ChatMe(playerid, "czuje, ¿e jego organizm ma obni¿on¹ odpornoœæ");
	PlayerImmunity[playerid] = 1;
	DecreaseImmunity(playerid);
	return 1;
}
public RandomInfectionEffect(playerid, disease, value)
{
	new rand = random(eDiseases);
	InfectPlayer(playerid, eDiseases:rand);
}

//Astygmatyzm
public AstigmatismEffect(playerid, disease, value)
{
	ChatMe(playerid, "widzi niewyraŸnie.");
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, 1);
	return 1;
}
public AstigmatismEffect_Off(playerid, disease, value)
{
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 1000);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, 1000);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, 1000);
	return 1;
}

//Parkinson/niedow³ad r¹k
public ShakingHandsEffect(playerid, disease, value)
{
	ChatDo(playerid, sprintf("rêce %s zaczynaj¹ siê trz¹œæ w niekontrolowany przez niego sposób.", GetNick(playerid)));
	return 1;
}
public ShootingSkillEffect(playerid, disease, value)
{
	ChatMe(playerid, "trzês¹ mu siê rêce.");
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, 1);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, 1);

	SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 1);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE, 1);

	return 1;
}
public ShootingSkillEffect_Off(playerid, disease, value)
{
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 1000);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, 1000);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, 1000);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, 1000);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, 1000);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 500);
	return 1;
}

//Uraz
public BleedingEffect(playerid, disease, value)
{
	ChatDo(playerid, sprintf("Z rany %s zaczyna p³yn¹æ krew.", GetNick(playerid)));
	defer LoweringHP(playerid, PlayerInfo[playerid][UID], value, false, false);
	return 1;
}
public GetGangreneEffect(playerid, disease, value)
{
	if(random(20) == 1) //5% szans
	{
		InfectPlayer(playerid, GANGRENA);
	}
	return 1;
}
public FaintEffect(playerid, disease, value)
{
	ApplyAnimation(playerid, "KNIFE", "KILL_Knife_Ped_Die", 4.0999, 0, 1, 1, 1, 1, 1);
	ChatMe(playerid, "omdla³.");
	SetPlayerDrunkLevel(playerid, 5000);
	return 1;
}

//Gangrena
public PurulenceEffect(playerid, disease, value)
{
	ChatDo(playerid, sprintf("Z rany %s zaczyna wyciekaæ ropa.", GetNick(playerid)));
	defer LoweringHP(playerid, PlayerInfo[playerid][UID], value, true, false);

	if(random(20) == 0)
	{
		InfectPlayer(playerid, PARKINSON);
	}
	return 1;
}
public RottenFleshEffect(playerid, disease, value)
{
	ChatMe(playerid, "gor¹czkuje, a z jego rany wydobywa siê smród zgnilizny.");
	defer LoweringHP(playerid, PlayerInfo[playerid][UID], value, false, false);
	SetPlayerDrunkLevel(playerid, 5000);
	return 1;
}

//PTSD
public HideWeaponEffect(playerid, disease, value)
{
	SetPlayerArmedWeapon(playerid, 0);
	ChatMe(playerid, "jest wyraŸnie zestresowany");
	Krzyk(playerid, "RATUNKU, POMOCY! To znowu Oni!");
	return 1;
}
public ThrowWeaponEffect(playerid, disease, value)
{
	new weapon = GetPlayerWeapon(playerid);
	ChatMe(playerid, "przera¿ony powracaj¹cymi wspomnieniami w postaci halucynacji, wyrzuca trzyman¹ broñ.");
	RemoveWeaponFromSlot(playerid, GetWeaponSlot(weapon));
	return 1;
}
public ThrowAllWeaponsEffect(playerid, disease, value)
{
	ChatMe(playerid, "panikuje i pozbywa siê wszelkiego uzbrojenia.");
	Command_ReProcess(playerid, "wyrzucbronie", false);
	return 1;
}
public FearEffect(playerid, disease, value)
{
	ChatMe(playerid, "zaczyna odczuwaæ irracjonalny strach.");
	ApplyAnimation(playerid, "ped", "cower", 3.0, 1, 0, 0, 0, 0, 1);
	return 1;
}

//others
public BlackoutEffect(playerid, disease, value)
{
	ShowPlayerFadeScreenToBlank(playerid, 20, 255, 255, 255, 255);
	SetPlayerDrunkLevel(playerid, 3000);
	return 1;
}
public DeathEffect(playerid, disease, value)
{
	ChatMe(playerid, "umar³ na skutek choroby.");
	NadajBW(playerid, INJURY_TIME_DISEASES);
	ZespawnujGraczaSzpitalBW(playerid);
	return 1;
}


//effects timers
timer LoweringHP[500](playerid, uid, hpLoss, bool:death, bool:freeze)
{
	if(!IsPlayerConnected(playerid) || uid != PlayerInfo[playerid][UID]) 
		return;

	if(hpLoss <= 0) 
	{
		if(freeze) TogglePlayerControllable(playerid, 1);
		return;
	}

	new Float:hp;
	GetPlayerHealth(playerid, hp);
	if(hp <= 2)
	{
		if(death)
		{
			ChatMe(playerid, "umar³ na skutek choroby");
			NadajBW(playerid, INJURY_TIME_DISEASES);
			ZespawnujGraczaSzpitalBW(playerid);
		}
		return;
	}
	SetPlayerHealth(playerid, hp-1);

	if(PlayerImmunity[playerid] <= 0)
		defer LoweringHP(playerid, uid, hpLoss-1, death, freeze);
}

timer HallucinationsOff[60000](playerid)
{
	SetPlayerWeather(playerid, ServerWeather);
}
