//----------------------------------------------<< Callbacks >>----------------------------------------------//
//                                                   convoy                                                  //
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
// Data utworzenia: 20.10.2019
//Opis:
/*
	System konwojów.
*/

//

#include <YSI\y_hooks>

//-----------------<[ Callbacki: ]>-----------------
Convoy_OnPlayerDropMovable(playerid, boxid, boxType, Float:x, Float:y, Float:z, Float:angle)
{
	#pragma unused x, y, z, angle

	if(boxType != BOX_TYPE_CONVOY)
	{
		return 0;
	}

	new actorid = GetNearestConvoyActor(playerid, CONVOY_ACTOR_DELIVERY_DISTANCE);
	new Float:vx, Float:vy, Float:vz;
	GetVehiclePos(convoyCar, vx, vy, vz);
	if(IsPlayerInRangeOfPoint(playerid, 5.0, vx, vy, vz) && IsInAConvoyTeam(playerid))
	{
		ChatMe(playerid, "wrzuca dyniê spowrotem do konwojowego furgonu.");
		convoyCarHP += CONVOY_HP_PER_PACKAGE;
		SetVehicleHealth(convoyCar, convoyCarHP);
		DestroyBox(boxid);
		return 1;
	}
	else if(actorid != -1 && !IsInAConvoyTeam(playerid))
	{
		new money = Boxes[boxid][box_bonus];
		new mc = Boxes[boxid][box_bonus]/1000;
		SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("Gratulacje, dostarczy³eœ dyniê z konwoju. Otrzymujesz %d$ i %dMC.", money, mc));
		DajKase(playerid, money);
		Log(payLog, INFO, "Gracz %s otrzyma³ %d$ za dynie", 
			GetPlayerLogName(playerid), money
		);
		DajMC(playerid, mc);
		Log(premiumLog, INFO, "Gracz %s otrzyma³ %dMC za dynie", 
			GetPlayerLogName(playerid), mc
		);

		DestroyBox(boxid);
		ActorChat(actorid, CONVOY_ACTOR_NAME, "dziêki, oto twoja dzia³ka.");
		ApplyDynamicActorAnimation(actorid, "CASINO", "manwind", 4.1, 0, 1, 1, 0, 0);
	}
	else
	{
		ChatMe(playerid, "upuszcza dyniê.");
	}
	return 1;
}

Convoy_OnPlayerPickupMovable(playerid, boxid, boxType)
{
	#pragma unused boxid
	if(boxType != BOX_TYPE_CONVOY)
	{
		return 0;
	}
	
	sendTipMessage(playerid, "Podnios³eœ dyniê z narkotykami. Aby j¹ upuœciæ, naciœnij enter.");
	if(IsInAConvoyTeam(playerid)) {
		sendTipMessage(playerid, "Upuœæ paczkê przy pojeŸdzie konwojowym, aby wrzuciæ j¹ spowrotem do œrodka.");
	} else {
		sendTipMessage(playerid, "Dostarcz dyniê do upiornych handlarzy, aby otrzymaæ nagrodê.");
	}
	ChatMe(playerid, "podnosi dyniê.");
	return 1;
}


//end