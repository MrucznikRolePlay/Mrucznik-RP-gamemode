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
// Data utworzenia: 05.07.2019
//Opis:
/*
	Skrypt umo¿liwiaj¹cy tworzenie Aktorów.
	Pozwala na interakcjê z nimi inGame.

	Commands:
	>/setactoranim - pozwala na ustawienie animacji dla actora
	>/selactor - pozwala zaznaczyæ actora, wyœwietla GUI umo¿liwiaj¹ce edycje i ustalanie wartoœci [Trwaj¹ prace]

	Odwo³ania:
	>Submodule obiekty - plik ActorsOnWorld - zawiera wszystkich stworzonych actorów na potrzeby œwiata M-RP. 

*/

//

//-----------------<[ Callbacki: ]>-------------------
//-----------------<[ Funkcje: ]>-------------------
stock CreateActorEx(actorIDs, aName[MAX_PLAYER_NAME], Float:aX, Float:aY, Float:aZ, Float:aR, aInvulnerable, Float:aStreamDistance, aVW, aINT, aPlayer)
//Tworzenie nowego actora
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
stock SetAnimatiorToActorMess(playerid, qActor)
{
	new string[124]; 
	format(string, sizeof(string), "W³¹czy³eœ animacjê dla %s [%d]", Actors[qActor][a_Name], qActor);
	sendTipMessage(playerid, string); 
	format(string, sizeof(string), "Admin %s w³¹czy³ animacjê dla Actora %s [%d]", GetNick(playerid), Actors[qActor][a_Name], qActor); 
	SendMessageToAdmin(string, COLOR_RED); 
	return 1;
}
stock SetActorAnimationEx(actorIDu, alib[], aname[], loop, lockx, locky)//Ustawianie animacji dla Actora
{
	ApplyDynamicActorAnimation(actorIDu, alib, aname, 4.1, loop, lockx, locky, 0, 0);
	return 1;
}
stock RepairActors(worldID, interiorID)//Funkcja naprawiaj¹ce aktorów - gdy zgin¹ dla gracza'
{
	for(new i; i<valActor; i++)
	{
		if(Actors[i][a_VW] == worldID && Actors[i][a_INT] == interiorID)
		{
			SetDynamicActorPos(actorUID[i], Actors[i][a_posX], Actors[i][a_posY], Actors[i][a_posZ]); 
			SetDynamicActorFacingAngle(actorUID[i], Actors[i][a_posR]);
		}
	}
	return 1;
}
stock LoadActors()//Wczytywanie actorów, tworzenie textów nad g³ow¹. 
{
	for(new i; i<valActor; i++)
	{
		actorUID[i] = CreateDynamicActor(Actors[i][a_Skin],
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
			new textnamed[64];
			format(textnamed, sizeof(textnamed), "%s\n[ID: %d]", Actors[i][a_Name], i); 
			CreateDynamic3DTextLabel(textnamed, COLOR_WHITE, Actors[i][a_posX], Actors[i][a_posY], Actors[i][a_posZ]+0.98, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, Actors[i][a_VW], Actors[i][a_INT], Actors[i][a_Player]);
		}
	}
	return 0; 
}
//-----------------<[ Timery: ]>-------------------
//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end