/**
    * This file is part of RoundAbout Creator
    *
    * @desc         
    * 
    * @author       KUBAK01
    * @link         http://mrucznik-rp.pl
*/


//------------------<< Includes >>------------------//

/**
*				a_samp
* @author		samp team
*/
#include <a_samp>

/**
*				dini2
* @author		gammix
*/
#include "dini2"

/**
*				streamer
* @author		incognito
*/
#include <streamer>

/**
*				a_samp
* @author		zeex
*/
#include <zcmd>

/**
*				sscanf2
* @author		emmet
*/
#include <sscanf2>

/**
*				foreach
* @author		y_less, kar
*/
#include <foreach>


/*===============================================
=            Variables / Definitions            =
===============================================*/


#define RoundAbout::	RoundAbout_ // i kinda like it
#define ITER_NONE -1

#define MAX_ROUNDABOUTS 20 // to be expanded, honestly i dont think we're gonna use more cuz it's just for the lolz


#define RA_TYPE_SMALL	1 // about 6.0 ingame size
#define RA_TYPE_MEDIUM	2 // 12.0 ingame size
#define RA_TYPE_BIG		3 // 24.0 ingame size this shit is pretty big, to be used nowhere but a on a big desert?


/*
	raLabel			label's id
	raCreatedBy		nickname of the author
	raType 			type of the roundabout, see RA_TYPE_*
	raCorePos 		the center of roundabout, used to make the whole thingy
	raCoreAngle 	the angle of roundabout, used to make the whole thingy
*/

enum eRoundAbout
{
	Text3D:raLabel,
	raCreatedBy[MAX_PLAYER_NAME+1],
	raType,
	Float:raCorePos[3],
	Float:raCoreAngle[3],
	raCoreObject
}

new roundAboutCache[MAX_ROUNDABOUTS][eRoundAbout]; 

// iterator
new Iterator:roundAbouts<MAX_ROUNDABOUTS>; 

new editingRoundAboutID[MAX_PLAYERS];


/*=====  End of Variables / Definitions  ======*/



/*================================
=            Commands            =
================================*/

COMMAND:aroundabout(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return 1;

	if( isnull(params) )
		return SendClientMessage(playerid, -1, "(ROUNDABOUT) Params: create delete edit");

	new subcmd[7], rest[40];

	sscanf(params, "s[7]S()[40]", subcmd, rest);

	if( !strcmp(subcmd, "create" ) )
	{
		new type[7];

		if( sscanf(rest, "s[7]", type) )
			return SendClientMessage(playerid, -1, "(ROUNDABOUT CREATE) Params: small medium big");

		if( !strcmp(type, "small") )
			RoundAbout::CreateAtPPos(playerid, RA_TYPE_SMALL);
		else if( !strcmp(type, "medium") )
			RoundAbout::CreateAtPPos(playerid, RA_TYPE_MEDIUM);
		else if( !strcmp(type, "big") )
			RoundAbout::CreateAtPPos(playerid, RA_TYPE_BIG);
		else 
			return SendClientMessage(playerid, -1, "(ROUNDABOUT CREATE) Params: small medium big");

	}

	if( !strcmp(subcmd, "delete") )
	{
		new id;

		if( sscanf(rest, "d", id) )
			return SendClientMessage(playerid, -1, "(ROUNDABOUT DELETE) Params: roundabout's id");

		if(Iter_Contains(roundAbouts, id))
		{

			RoundAbout::Remove(playerid, id);

		}
		else
			return SendClientMessage(playerid, -1, "(ROUNDABOUT DELETE) Roundabout of this id doesnt exsit");
	}

	if( !strcmp(subcmd, "edit") )
	{
		new id;

		if( sscanf(rest, "d", id) )
			return SendClientMessage(playerid, -1, "(ROUNDABOUT EDIT) Params: roundabout's id");

		if( editingRoundAboutID[playerid] != -1 ) 
			return SendClientMessage(playerid, -1, "(ROUNDABOUT EDIT) You are editing an other roundabout");

		if(Iter_Contains(roundAbouts, id))
		{

			new master = roundAboutCache[id][raCoreObject];

			EditDynamicObject(playerid, master);

			editingRoundAboutID[playerid] = id;

			return SendClientMessage(playerid, -1, "(ROUNDABOUT EDIT) Move the center of your roundabout");			
		}
		else
			return SendClientMessage(playerid, -1, "(ROUNDABOUT EDIT) Roundabout of this id doesnt exsit");
	}

	return 1;
}

/*=====  End of Commands  ======*/


/*=================================
=            Callbacks            =
=================================*/

public OnPlayerEditDynamicObject(playerid, STREAMER_TAG_OBJECT objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{

	if(editingRoundAboutID[playerid] != -1)
	{
		switch(response)
		{
			case EDIT_RESPONSE_FINAL:
			{
				new id = editingRoundAboutID[playerid];
				new tmpType = RoundAbout::GetType(id);

				if(!Iter_Contains(roundAbouts, id))
					return SendClientMessage(playerid, -1, "(ROUNDABOUT EDIT) Roundabout was deleted when you were editing it");

				new pName[MAX_PLAYER_NAME+1];
				GetPlayerName(playerid, pName, MAX_PLAYER_NAME+1);

				RoundAbout::Remove(INVALID_PLAYER_ID, id);

				if(tmpType == RA_TYPE_SMALL)
				{
					RoundAbout::CreateSmallRA(pName, x, y, z, rx, ry, rz);
				}
				else if(tmpType == RA_TYPE_MEDIUM)
				{
					RoundAbout::CreateMediumRA(pName, x, y, z, rx, ry, rz);	
				}
				else if(tmpType == RA_TYPE_BIG)
				{
					RoundAbout::CreateBigRA(pName, x, y, z, rx, ry, rz);		
				}

				roundAboutCache[id][raCorePos][0] = x;
				roundAboutCache[id][raCorePos][1] = y;
				roundAboutCache[id][raCorePos][2] = z;

				roundAboutCache[id][raCoreAngle][0] = rx;
				roundAboutCache[id][raCoreAngle][1] = ry;
				roundAboutCache[id][raCoreAngle][2] = rz;

				editingRoundAboutID[playerid] = -1;

				RoundAbout::Save(id);
			}

			case EDIT_RESPONSE_CANCEL:
			{

				editingRoundAboutID[playerid] = -1;

			}
		}
	}

	return 1;
}

/*=====  End of Callbacks  ======*/



/*=================================
=            Functions            =
=================================*/

RoundAbout::CreateAtPPos(playerid, type=RA_TYPE_SMALL)
{

	new id = Iter_Free(roundAbouts);

	if(id == ITER_NONE)
	{
		SendClientMessage(playerid, -1, "(ROUNDABOUT CREATE) No free roundabout slots");
		SendClientMessage(playerid, -1, "(ROUNDABOUT CREATE) Increase #MAX_ROUNDABOUTS or delete one of existing roundabouts");
		return 1;
	}

	new Float:pPos[3], Float:null;
	GetPlayerPos(playerid, null, null, pPos[2]);
	GetXYInFrontOfPlayer(playerid, pPos[0], pPos[1], 2.0);

	new pName[MAX_PLAYER_NAME+1];
	GetPlayerName(playerid, pName, MAX_PLAYER_NAME+1);

	new result = -1;

	if(type == RA_TYPE_SMALL)
	{

		SendClientMessage(playerid, -1, "(SMALL ROUNDABOUT) Trying to create a roundabout at your current position");

		result = RoundAbout::CreateSmallRA(pName, pPos[0]+5.0, pPos[1], pPos[2]+0.25, 0.0, 0.0, 0.0);

		if(result == -1)
			return SendClientMessage(playerid, -1, "(SMALL ROUNDABOUT) There was an error trying to create your roundabout");

	}
	else if(type == RA_TYPE_MEDIUM)
	{

		SendClientMessage(playerid, -1, "(MEDIUM ROUNDABOUT) Trying to create a roundabout at your current position");

		result = RoundAbout::CreateMediumRA(pName, pPos[0]+5.0, pPos[1], pPos[2]+0.25, 0.0, 0.0, 0.0);

		if(result == -1)
			return SendClientMessage(playerid, -1, "(MEDIUM ROUNDABOUT) There was an error trying to create your roundabout");
	}
	else if(type == RA_TYPE_BIG)
	{

		SendClientMessage(playerid, -1, "(BIG ROUNDABOUT) Trying to create a roundabout at your current position");

		result = RoundAbout::CreateBigRA(pName, pPos[0]+5.0, pPos[1], pPos[2]+0.25, 0.0, 0.0, 0.0);

		if(result == -1)
			return SendClientMessage(playerid, -1, "(BIG ROUNDABOUT) There was an error trying to create your roundabout");

	}
	else
	{
		return SendClientMessage(playerid, -1, "(ROUNDABOUT CREATE) Invalid type specified");
	}

	roundAboutCache[result][raCorePos][0] = pPos[0]+5.0;
	roundAboutCache[result][raCorePos][1] = pPos[1];
	roundAboutCache[result][raCorePos][2] = pPos[2]+0.25;

	roundAboutCache[result][raCoreAngle][0] = 0.0;
	roundAboutCache[result][raCoreAngle][1] = 0.0;
	roundAboutCache[result][raCoreAngle][2] = 0.0;
	
	RoundAbout::Save(result);

	return 1;
}

RoundAbout::Remove(playerid = INVALID_PLAYER_ID, id)
{
	new master = roundAboutCache[id][raCoreObject];
	new bool:deleted=false;

	new objectscount = CountDynamicObjects();
	new i = 0;
	while(objectscount > 0)
	{
	    if(IsValidDynamicObject(i))
	   	{
	    	if(Streamer_GetIntData(STREAMER_TYPE_OBJECT, i, E_STREAMER_EXTRA_ID) == master)
	    	{
	    		DestroyDynamicObject(i);
	    		deleted = true;
	    	}

	        objectscount--;
	    }
	    i++;
	}
	if(deleted)
	{
		DestroyDynamicObject(master);
		DestroyDynamic3DTextLabel(roundAboutCache[id][raLabel]);

		Iter_Remove(roundAbouts, id);

		SendClientMessage(playerid, -1, "(ROUNDABOUT DELETE) Successfully deleted this roundabout");

		new fileName[22];
		format(fileName, sizeof fileName, "roundabouts/%i.ini", id); 
		if(dini_Exists(fileName))
		{
			dini_Remove(fileName);
		}
	}

	return 1;
}

RoundAbout::GetType(id)
{
	return roundAboutCache[id][raType];
}

RoundAbout::Save(id)
{
	new fileName[22];
	format(fileName, sizeof fileName, "roundabouts/%i.ini", id); 
	
	if(dini_Exists(fileName))
	{
		dini_Create(fileName);
	}
	
	dini_IntSet(fileName, "id", id); 
	dini_IntSet(fileName, "type", roundAboutCache[id][raType]);

	new compress[64];

	format(compress, sizeof compress, "%f|%f|%f", roundAboutCache[id][raCorePos][0], roundAboutCache[id][raCorePos][1], roundAboutCache[id][raCorePos][2]);
	dini_Set(fileName, "corePos", compress);

	format(compress, sizeof compress, "%f|%f|%f", roundAboutCache[id][raCoreAngle][0], roundAboutCache[id][raCoreAngle][1], roundAboutCache[id][raCoreAngle][2]);
	dini_Set(fileName, "coreAngle", compress);

	dini_Set(fileName, "author", roundAboutCache[id][raCreatedBy]);

	return 1;
}

RoundAbout::CreateSmallRA(author[], Float:coreX, Float:coreY, Float:coreZ, Float:coreRX, Float:coreRY, Float:coreRZ)
{
	new id = -1;


	/**
	 *
	 * This is where things get little tricky xD
	 * See object ID 14467? That is our CORE object for this roundabout
	 *
	 * So every other object position
	 * will be set corresponding to this object
	 *
	 * aye advanced maths 'n stuff
	 *
	 */

	id = Iter_Free(roundAbouts);

	if(id == -1) return -1;

	new obj;
	
	roundAboutCache[id][raCoreObject] = CreateDynamicObject(14467, coreX, coreY, coreZ, coreRX, coreRY, coreRZ); // Core

	obj = CreateDynamicObject(970, coreX+2.839970, coreY+0.300050, coreZ-2.202200, coreRX+0.000000, coreRX+0.000000, coreRX+90.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(970, coreX+0.279910, coreY+2.859980, coreZ-2.202200, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(970, coreX-2.333980, coreY+0.300050, coreZ-2.202200, coreRX+0.000000, coreRX+0.000000, coreRX+90.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(970, coreX+0.279910, coreY-2.279910, coreZ-2.202200, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(14467, coreX+0.000000, coreY+0.000000, coreZ+0.000000, coreRX+0.000000, coreRX+0.000000, coreRX-90.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(19121, coreX-2.072750, coreY+2.622190, coreZ-2.182200, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(19121, coreX+2.587040, coreY+2.622190, coreZ-2.182200, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(19121, coreX+2.587040, coreY-2.054810, coreZ-2.182200, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(19121, coreX-2.072750, coreY-2.054810, coreZ-2.182200, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);

	roundAboutCache[id][raCreatedBy][0] = EOS;
	strcat(roundAboutCache[id][raCreatedBy], author);

	new label[128];
	format(label, sizeof label, "{FFFFFF}Roundabout of an id {DAFC10}%d\n{FFFFFF}Created by {DAFC10}%s", id, author);
	roundAboutCache[id][raLabel] = CreateDynamic3DTextLabel(label, 0xFFFFFFFF, coreX, coreY, coreZ, 200.0);

	roundAboutCache[id][raType] = RA_TYPE_SMALL;

	Iter_Add(roundAbouts, id);

	return id;
}

RoundAbout::CreateMediumRA(author[], Float:coreX, Float:coreY, Float:coreZ, Float:coreRX, Float:coreRY, Float:coreRZ)
{
	new id = -1;

	/**
	 *
	 * This is where things get little tricky xD
	 * See object ID 3515? That is our CORE object for this roundabout
	 *
	 * So every other object position
	 * will be set corresponding to this object
	 *
	 * aye advanced maths 'n stuff
	 *
	 */

	id = Iter_Free(roundAbouts);

	if(id == -1) return -1;

	new obj;

	roundAboutCache[id][raCoreObject] = CreateDynamicObject(3515, coreX,coreY,coreZ,coreRX, coreRY, coreRZ); // CORE

	obj = CreateDynamicObject(7933, coreX-0.219970, coreY-4.804450, coreZ+0.551200, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(19869, coreX-5.559940, coreY+0.000000, coreZ-1.208800, coreRX+0.000000, coreRX+0.000000, coreRX+90.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(7933, coreX-0.219970, coreY+4.851560, coreZ+0.551200, coreRX+0.000000, coreRX+0.000000, coreRX+180.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(737, coreX+3.074830, coreY-3.594730, coreZ+0.551200, coreRX+0.000000, coreRX+0.000000, coreRX+55.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(737, coreX-2.845220, coreY-3.594730, coreZ+0.551200, coreRX+0.000000, coreRX+0.000000, coreRX+55.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(737, coreX-2.845220, coreY+3.705320, coreZ+0.551200, coreRX+0.000000, coreRX+0.000000, coreRX+55.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(737, coreX+3.074830, coreY+3.705320, coreZ+0.551200, coreRX+0.000000, coreRX+0.000000, coreRX+55.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(19122, coreX-5.549320, coreY-2.854860, coreZ+0.551200, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(19869, coreX+5.199340, coreY+0.000000, coreZ-1.208800, coreRX+0.000000, coreRX+0.000000, coreRX+90.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(19122, coreX+5.172610, coreY+2.847040, coreZ+0.551200, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(19122, coreX+5.172610, coreY-2.814940, coreZ+0.551200, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(19122, coreX-5.549320, coreY+2.847040, coreZ+0.551200, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);

	roundAboutCache[id][raCreatedBy][0] = EOS;
	strcat(roundAboutCache[id][raCreatedBy], author);

	new label[128];
	format(label, sizeof label, "{FFFFFF}Roundabout of an id {DAFC10}%d\n{FFFFFF}Created by {DAFC10}%s", id, author);
	roundAboutCache[id][raLabel] = CreateDynamic3DTextLabel(label, 0xFFFFFFFF, coreX, coreY, coreZ, 200.0);

	roundAboutCache[id][raType] = RA_TYPE_MEDIUM;

	Iter_Add(roundAbouts, id);

	return id;
}

RoundAbout::CreateBigRA(author[], Float:coreX, Float:coreY, Float:coreZ, Float:coreRX, Float:coreRY, Float:coreRZ)
{
	new id = -1;

	/**
	 *
	 * This is where things get little tricky xD
	 * See object ID 6965? That is our CORE for this roundabout
	 *
	 * So every other object position
	 * will be set corresponding to this object
	 *
	 * aye advanced maths 'n stuff
	 *
	 */

	id = Iter_Free(roundAbouts);

	if(id == -1) return -1;

	new obj;

	roundAboutCache[id][raCoreObject] = CreateDynamicObject(6965, coreX,coreY,coreZ,coreRX, coreRY, coreRZ); // Core

	obj = CreateDynamicObject(970, coreX-0.113280, coreY+6.196170, coreZ-0.869700, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(970, coreX+4.046750, coreY+6.196170, coreZ-0.869700, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(970, coreX-4.273250, coreY+6.196170, coreZ-0.869700, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(970, coreX-6.359860, coreY+4.160040, coreZ-0.869700, coreRX+0.000000, coreRX+0.000000, coreRX+90.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(970, coreX-6.359860, coreY+0.000000, coreZ-0.869700, coreRX+0.000000, coreRX+0.000000, coreRX+90.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(970, coreX-6.359860, coreY-4.160030, coreZ-0.869700, coreRX+0.000000, coreRX+0.000000, coreRX+90.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(970, coreX-4.273250, coreY-6.231200, coreZ-0.869700, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(970, coreX-0.113280, coreY-6.231200, coreZ-0.869700, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(970, coreX+4.046750, coreY-6.231200, coreZ-0.869700, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(970, coreX+6.117310, coreY-4.160030, coreZ-0.869700, coreRX+0.000000, coreRX+0.000000, coreRX+90.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(970, coreX+6.117310, coreY+0.000000, coreZ-0.869700, coreRX+0.000000, coreRX+0.000000, coreRX+90.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(970, coreX+6.117310, coreY+4.160040, coreZ-0.869700, coreRX+0.000000, coreRX+0.000000, coreRX+90.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(6324, coreX-1.082400, coreY-44.745360, coreZ-0.058800, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(2011, coreX+1.435850, coreY-0.321530, coreZ-1.380200, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(2011, coreX-0.006280, coreY-1.367060, coreZ-1.380200, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(2011, coreX-1.304200, coreY-0.161620, coreZ-1.380200, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(2011, coreX-0.006280, coreY+1.372930, coreZ-1.380200, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(1361, coreX-0.923220, coreY-1.114620, coreZ-0.734500, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(1361, coreX-1.302850, coreY+0.964360, coreZ-0.734500, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(1361, coreX+1.253600, coreY+0.757940, coreZ-0.734500, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(1361, coreX+0.755620, coreY-1.427240, coreZ-0.734500, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(14400, coreX-0.134640, coreY-0.253660, coreZ-1.439830, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(14400, coreX+0.437930, coreY-0.098380, coreZ-1.439800, coreRX+0.000000, coreRX+0.000000, coreRX+90.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(14400, coreX+0.437930, coreY-0.098380, coreZ-1.439800, coreRX+0.000000, coreRX+0.000000, coreRX+45.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(14400, coreX+0.437930, coreY-0.098380, coreZ-1.439800, coreRX+0.000000, coreRX+0.000000, coreRX-45.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(1215, coreX-6.356200, coreY-6.240720, coreZ-1.059800, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(1215, coreX-6.356200, coreY+6.179330, coreZ-1.059800, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(1215, coreX+6.083800, coreY+6.179330, coreZ-1.059800, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(1215, coreX+6.083800, coreY-6.220700, coreZ-1.059800, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(737, coreX+5.487920, coreY-5.560300, coreZ-0.914500, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(737, coreX+5.487920, coreY+5.559330, coreZ-0.914500, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(737, coreX-5.716180, coreY+5.539310, coreZ-0.914500, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);
	obj = CreateDynamicObject(737, coreX-5.715940, coreY-5.560300, coreZ-0.914500, coreRX+0.000000, coreRX+0.000000, coreRX+0.000000);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID, roundAboutCache[id][raCoreObject]);

	roundAboutCache[id][raCreatedBy][0] = EOS;
	strcat(roundAboutCache[id][raCreatedBy], author);

	new label[128];
	format(label, sizeof label, "{FFFFFF}Roundabout of an id {DAFC10}%d\n{FFFFFF}Created by {DAFC10}%s", id, author);
	roundAboutCache[id][raLabel] = CreateDynamic3DTextLabel(label, 0xFFFFFFFF, coreX, coreY, coreZ, 200.0);

	roundAboutCache[id][raType] = RA_TYPE_BIG;

	Iter_Add(roundAbouts, id);

	return id;
}

RoundAbout::OnInit()
{
	new count = 0, fileName[22], Float:pos[3], Float:angle[3], compressed[64];

	for(new i; i<MAX_ROUNDABOUTS; i++)
	{
		format(fileName, sizeof fileName, "roundabouts/%i.ini", i);

		if(dini_Exists(fileName))
		{
			new type = dini_Int(fileName, "type");

			compressed[0] = EOS;
			strcat(compressed, dini_Get(fileName, "corePos"));
			sscanf(compressed, "p<|>fff", pos[0], pos[1], pos[2]);

			compressed[0] = EOS;
			strcat(compressed, dini_Get(fileName, "coreAngle"));
			sscanf(compressed, "p<|>fff", angle[0], angle[1], angle[2]);


			if(type == RA_TYPE_SMALL)
			{
				RoundAbout::CreateSmallRA(dini_Get(fileName, "author"), pos[0], pos[1], pos[2], angle[0], angle[1], angle[2]);
			}
			else if(type == RA_TYPE_MEDIUM)
			{
				RoundAbout::CreateMediumRA(dini_Get(fileName, "author"), pos[0], pos[1], pos[2], angle[0], angle[1], angle[2]);
			}
			else if(type == RA_TYPE_BIG)
			{
				RoundAbout::CreateBigRA(dini_Get(fileName, "author"), pos[0], pos[1], pos[2], angle[0], angle[1], angle[2]);
			}

			count++;
		}
	}

	printf("Loaded %d roundabout(s)", count);
}

stock GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	// Created by Y_Less

	new Float:a;

	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);

	if (GetPlayerVehicleID(playerid)) {
	    GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}

	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}

/*=====  End of Functions  ======*/



public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" ROUNDABOUT CREATOR R1 BY KUBAK01 @ SA-MP.COM ");
	print("--------------------------------------\n");

	RoundAbout::OnInit();

	foreach(Player, i)
	{
		OnPlayerConnect(i);
	}	

	return 1;
}

public OnFilterScriptExit()
{
	Iter_Clear(roundAbouts);
	return 1;
}

public OnPlayerConnect(playerid)
{
	editingRoundAboutID[playerid] = -1;
}