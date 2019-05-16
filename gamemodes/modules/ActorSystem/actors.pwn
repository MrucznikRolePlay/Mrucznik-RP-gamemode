//-----------------------------------------------<< Source >>------------------------------------------------//
//                                              ActorSystem                                                  //
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
// Autor: Simeone
// Data utworzenia: 15.05.2019
//Opis:
/*
	Skrypt umo¿liwiaj¹cy tworzenie Actorów, ala DodajBrame. 
*/

//

//-----------------<[ Callbacki: ]>-------------------
//-----------------<[ Funkcje: ]>-------------------
CreaetDynamicActorEx(skinid, float:pX, float:pY, float:pZ, float:pRot vw, int, const text[], animation)
{
	sActors[valActors][a_skin] = skinid;
	sActors[valActors][a_vw] = vw;
	sActors[valActors][a_int] = int;
	sActors[valActors][a_x] = pX;
	sActors[valActors][a_y] = pY;
	sActors[valActors][a_z] = pZ; 
	sActors[valActors][a_rot] = pRot; 
	sActors[valActors][a_text] = text; 
	sActors[valActors][a_animation] = animation; 
	return valActors++;
}
LoadTextOnActor(Float:pX, Float:pY, Float:pZ, const text[], vw, int)
{
	CreateDynamic3DTextLabel(text, COLOR_WHITE, pX, pY, pZ, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID,  0, vw, int, -1);
	return 1; 
}
LoadActors() 
{
	for(new i; i<valActors; i++)
	{	
		new actorID[i] = CreateActor(sActors[i][a_skin], sActors[i][a_x], sActors[i][a_y], sActors[i][a_z], sActors[i][a_rot]);
		if(strlen(sActors[i][a_text] >= 3))
		{
			LoadTextOnActor(sActors[i][a_x], sActors[i][a_y], sActors[i][a_z]+0.85, sActors[i][a_text], sActors[i][a_vw], sActors[i][a_int]);
		}
	/*	if(sActors[i][a_animation] >= 1)
		{
			ApplyActorAnimation(actorID[i], animlib[], animname[], Float:fDelta, loop, lockx, locky, freeze, time) 
		}*/
	}
	return 0; 
}
//-----------------<[ Timery: ]>-------------------
//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end