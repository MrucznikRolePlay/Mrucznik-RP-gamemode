//actors.pwn
//Chwilowa opcja ³adowania actorów - w przysz³oœci przeniesiona zostanie na modu³
new valActor; 
//new actorUID[valActor];
#define ACTORS_ON_WORLD 100
enum eActors
{
	a_Skin,
	a_Name[MAX_PLAYER_NAME],
	Float:a_posX,
	Float:a_posY,
	Float:a_posZ,
	Float:a_posR,
	a_Invulnerable,
	Float:a_StreamDistance,
	a_VW,
	a_INT,
	a_Player
};
new	Float:Actors[ACTORS_ON_WORLD][eActors];
stock CreateActorEx(actorIDs, aName[MAX_PLAYER_NAME], Float:aX, Float:aY, Float:aZ, Float:aR, aInvulnerable, Float:aStreamDistance, aVW, aINT, aPlayer)
{
	Actors[valActor][a_Skin] = actorIDs;
	Actors[valActor][a_Name] = aName; 
	Actors[valActor][a_posX] = aX; 
	Actors[valActor][a_posY] = aY;
	Actors[valActor][a_posZ] = aZ; 
	Actors[valActor][a_posR] = aR; 
	Actors[valActor][a_Invulnerable] = aInvulnerable; 
	Actors[valActor][a_StreamDistance] = aStreamDistance;
	Actors[valActor][a_VW] = aVW; 
	Actors[valActor][a_INT] = aINT; 
	Actors[valActor][a_Player] = aPlayer; 
	return valActor++; 
}
stock LoadActors()
{
	for(new i; i<valActor; i++)
	{
		CreateDynamicActor(Actors[i][a_Skin],
		Actors[i][a_posX],
		Actors[i][a_posY], 
		Actors[i][a_posZ], 
		Actors[i][a_posR],
		Actors[i][a_Invulnerable],
		Actors[i][a_StreamDistance],
		Actors[i][a_VW],
		Actors[i][a_INT],
		Actors[i][a_Player]);
		if(strlen(Actors[i][a_Name]) > 3)
		{
			CreateDynamic3DTextLabel(Actors[i][a_Name], COLOR_WHITE, Actors[i][a_posX], Actors[i][a_posY], Actors[i][a_posZ]+0.3, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, Actors[i][a_VW], Actors[i][a_INT], Actors[i][a_Player]);
		}
	}
	//VINYL CLUB
	/*
	CreateDynamicActor(11, 812.7278,-1371.3988,23.6475, 267.5658, 1, 100.0, 255, -1,-1);//barman góra
	CreateDynamicActor(189,811.0535,-1350.2653,27.8413,177.3484, 1, 100.0, 255, -1,-1);//barman dó³
	CreateDynamicActor(165, 818.0769,-1376.7991,23.6475,329.0921, 1, 100.0, 255, -1,-1);//vinyl staff - drzwi
	CreateDynamicActor(217,825.0794,-1352.5493,23.6475,172.7841, 1, 100.0, 255, -1,-1);//vinyl staff - konsola
	*/ 
	return 0; 
}
