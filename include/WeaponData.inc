/*==============================================================================

	Southclaw's Advanced Weapon Damage Library

	With this you can finely tune weapon damage based on distance.
	Using min/max range values, a weapon's damage varies depending on the
	distance between the shooter and the target.

	The values below for damage and magsize are NOT real game data values but
	custom values based on feedback about weapon balancing from the Scavenge
	and Survive community. All other data is factual.

	Do what you want with it, but keep my name on it :)

==============================================================================*/


#define MAX_WEAPONS	 (50)
#define MAX_WEAPON_NAME (15)


enum
{
	WEAPON_VEHICLE_BULLET = WEAPON_PARACHUTE + 1,
	WEAPON_VEHICLE_EXPLOSIVE,
	WEAPON_VEHICLE_COLLISION
}

enum E_WEAPON_DATA
{
		weapon_name[MAX_WEAPON_NAME],	// A
		weapon_model,					// B
		weapon_magSize,					// C
		weapon_slot,					// D
Float:	weapon_minDmg,					// E
Float:	weapon_maxDmg,					// F
Float:	weapon_minRange,				// G
Float:	weapon_maxRange,				// H
		weapon_shotInterval,			// I
Float:	weapon_rangeCap					// J
}


stock const WeaponData[MAX_WEAPONS][E_WEAPON_DATA]=
{
//	A					B		C		D		E		F		G		H			I			J
	{"Fist",			000,	1,		0,		0.1,	1.0,	0.0,	2.0,		0,			1.6},		// 0
	{"Knuckle Duster",	331,	1,		1,		1.5,	2.0,	0.0,	2.0,		0,			1.6},		// 1
	{"Golf Club",		333,	1,		1,		1.5,	2.0,	0.0,	2.0,		0,			1.6},		// 2
	{"Baton",			334,	1,		1,		1.5,	2.0,	0.0,	2.0,		0,			1.6},		// 3
	{"Knife",			335,	1,		1,		26.0,	26.0,	0.0,	1.6,		0,			1.6},		// 4
	{"Baseball Bat",	336,	1,		1,		1.5,	2.0,	0.0,	2.0,		0,			1.6},		// 5
	{"Spade",			337,	1,		1,		1.5,	2.0,	0.0,	2.0,		0,			1.6},		// 6
	{"Pool Cue",		338,	1,		1,		1.5,	2.0,	0.0,	2.0,		0,			1.6},		// 7
	{"Sword",			339,	1,		1,		24.0,	31.5,	0.0,	2.0,		0,			1.6},		// 8
	{"Chainsaw",		341,	1,		1,		24.5,	50.0,	0.0,	2.0,		0,			1.6},		// 9

//	A					B		C		D		E		F		G		H			I			J
	{"Dildo",			321,	1,		10,		0.5,	1.0,	0.0,	2.0,		0,			1.6},		// 10
	{"Dildo",			322,	1,		10,		0.5,	1.0,	0.0,	2.0,		0,			1.6},		// 11
	{"Dildo",			323,	1,		10,		0.5,	1.0,	0.0,	2.0,		0,			1.6},		// 12
	{"Dildo",			324,	1,		10,		0.5,	1.0,	0.0,	2.0,		0,			1.6},		// 13
	{"Flowers",			325,	1,		10,		0.5,	1.0,	0.0,	2.0,		0,			1.6},		// 14
	{"Cane",			326,	1,		10,		0.5,	1.0,	0.0,	2.0,		0,			1.6},		// 15

//	A					B		C		D		E		F		G		H			I			J
	{"Grenade",			342,	1,		8,		50.0,	100.0,	0.0,	2.0,		0,			40.0},		// 16
	{"Teargas",			343,	1,		8,		0.0,	0.0,	0.0,	2.0,		0,			40.0},		// 17
	{"Molotov",			344,	1,		8,		0.01,	0.01,	0.0,	0.0,		0,			40.0},		// 18

	{"<null>",			000,	0,		0,		0.0,	0.0,	0.0,	2.0,		0,			0.0},		// 19
	{"<null>",			000,	0,		0,		0.0,	0.0,	0.0,	2.0,		0,			0.0},		// 20
	{"<null>",			000,	0,		0,		0.0,	0.0,	0.0,	2.0,		0,			0.0},		// 21

//	A					B		C		D		E		F		G		H			I			J
	{"M9",				346,	10,		2,		21.0,	24.0,	10.0,	30.0,		300,		35.0},		// 22
	{"M9 SD",			347,	10,		2,		25.0,	26.0,	10.0,	25.0,		400,		35.0},		// 23
	{"Desert Eagle",	348,	7,		2,		20.0,	30.0,	12.0,	35.0,		800,		35.0},		// 24

//	A					B		C		D		E		F		G		H			I			J
	{"Shotgun",			349,	6,		3,		15.0,	54.0,	11.0,	35.0,		1060,		40.0},		// 25
	{"Sawnoff",			350,	2,		3,		5.0,	48.0,	5.0,	24.0,		300,		35.0},		// 26
	{"Spas 12",			351,	7,		3,		16.0,	31.0,	14.0,	40.0,		320,		40.0},		// 27

//	A					B		C		D		E		F		G		H			I			J
	{"Mac 10",			352,	36,		4,		12.0,	20.0,	10.0,	35.0,		120,		35.0},		// 28
	{"MP5",				353,	30,		4,		12.0,	24.0,	9.0,	38.0,		100,		45.0},		// 29
	{"AK-47",			355,	30,		5,		18.0,	24.0,	11.0,	39.0,		120,		70.0},		// 30
	{"M16",				356,	30,		5,		16.0,	24.0,	13.0,	46.0,		120,		90.0},		// 31
	{"Tec 9",			372,	30,		4,		10.0,	20.0,	10.0,	25.0,		120,		35.0},		// 32

//	A					B		C		D		E		F		G		H			I			J
	{"Rifle",			357,	5,		6,		45.0,	60.0,	30.0,	100.0,		1060,		100.0},		// 33
	{"Sniper",			358,	5,		6,		45.0,	60.0,	30.0,	100.0,		1060,		100.0},		// 34

//	A					B		C		D		E		F		G		H			I			J
	{"RPG",				359,	1,		7,		100.0,	100.0,	1.0,	30.0,		0,			55.0},		// 35
	{"Heatseeker",		360,	1,		7,		100.0,	100.0,	1.0,	30.0,		0,			55.0},		// 36
	{"Flamer",			361,	100,	7,		10.1,	15.1,	1.0,	5.0,		0,			5.1},		// 37
	{"Minigun",			362,	100,	7,		1.1,	2.0,	1.0,	60.0,		20,			75.0},		// 38

//	A					B		C		D		E		F		G		H			I			J
	{"Remote Bomb",		363,	1,		8,		5.0,	20.0,	10.0,	50.0,		0,			40.0},		// 39
	{"Detonator",		364,	1,		12,		0.0,	0.0,	0.0,	0.0,		0,			25.0},		// 40
	{"Spray Paint",		365,	500,	9,		0.0,	0.1,	0.0,	2.0,		0,			6.1},		// 41
	{"Extinguisher",	366,	500,	9,		0.0,	0.0,	0.0,	2.0,		0,			10.1},		// 42
	{"Camera",			367,	36,		9,		0.0,	0.0,	0.0,	0.0,		0,			100.0},		// 43
	{"Night Vision",	000,	1,		11,		0.0,	0.0,	0.0,	0.0,		0,			100.0},		// 44
	{"Thermal Vision",	000,	1,		11,		0.0,	0.0,	0.0,	0.0,		0,			100.0},		// 45
	{"Parachute",		371,	1,		11,		0.0,	0.0,	0.0,	0.0,		0,			50.0},		// 46

//	A					B		C		D		E		F		G		H			I			J
	{"Vehicle Gun",		000,	0,		0,		3.0,	7.0,	0.0,	50.0,		0,			50.0},		// 47
	{"Vehicle Bomb",	000,	0,		0,		50.0,	50.0,	0.0,	50.0,		0,			50.0},		// 48
	{"Vehicle",			000,	0,		0,		20.0,	30.0,	0.0,	10.0,		0,			25.0}		// 49 Should be scripted to be based on velocity.
};

#define GetWeaponName GetWeaponName_New
stock GetWeaponName_New(weaponid, string[])
{
	if(!(0 <= weaponid < MAX_WEAPONS))
		return 0;

	string[0] = EOS;
	strcat(string, WeaponData[weaponid][weapon_name], MAX_WEAPON_NAME);

	return 1;
}

stock GetWeaponModel(weaponid)
{
	if(!(0 <= weaponid < MAX_WEAPONS))
		return 0;

	return WeaponData[weaponid][weapon_model];
}

stock GetWeaponMagSize(weaponid)
{
	if(!(0 <= weaponid < MAX_WEAPONS))
		return 0;

	return WeaponData[weaponid][weapon_magSize];
}

stock GetWeaponSlot(weaponid)
{
	if(!(0 <= weaponid < MAX_WEAPONS))
		return 0;

	return WeaponData[weaponid][weapon_slot];
}

stock Float:GetWeaponMinDamage(weaponid)
{
	if(!(0 <= weaponid < MAX_WEAPONS))
		return 0.0;

	return WeaponData[weaponid][weapon_minDmg];
}

stock Float:GetWeaponMaxDamage(weaponid)
{
	if(!(0 <= weaponid < MAX_WEAPONS))
		return 0.0;

	return WeaponData[weaponid][weapon_maxDmg];
}

stock Float:GetWeaponMinRange(weaponid)
{
	if(!(0 <= weaponid < MAX_WEAPONS))
		return 0.0;

	return WeaponData[weaponid][weapon_minRange];
}

stock Float:GetWeaponMaxRange(weaponid)
{
	if(!(0 <= weaponid < MAX_WEAPONS))
		return 0.0;

	return WeaponData[weaponid][weapon_maxRange];
}

stock GetWeaponShotInterval(weaponid)
{
	if(!(0 <= weaponid < MAX_WEAPONS))
		return 0;

	return WeaponData[weaponid][weapon_shotInterval];
}

stock Float:GetWeaponRateOfFire(weaponid)
{
	if(!(0 <= weaponid < MAX_WEAPONS))
		return 0.0;

	return ((1000 / WeaponData[weaponid][weapon_shotInterval]) * 60); // RPM
}

stock Float:GetWeaponRangeCap(weaponid)
{
	if(!(0 <= weaponid < MAX_WEAPONS))
		return 0.0;

	return WeaponData[weaponid][weapon_rangeCap];
}

stock Float:GetWeaponDamageFromDistance(weaponid, Float:distance)
{
	if(distance < WeaponData[weaponid][weapon_minRange])
		return WeaponData[weaponid][weapon_maxDmg];
	
	if(distance > WeaponData[weaponid][weapon_maxRange])
		return WeaponData[weaponid][weapon_minDmg];

	return ((WeaponData[weaponid][weapon_minDmg]-WeaponData[weaponid][weapon_maxDmg]) / (WeaponData[weaponid][weapon_maxRange]-WeaponData[weaponid][weapon_minRange])) * (distance - WeaponData[weaponid][weapon_maxRange]) + WeaponData[weaponid][weapon_minDmg];
}
