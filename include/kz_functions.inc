#include a_samp_kmod
#include kz_properties

#define KZ_VM 321

forward PRIVATE_GAMETEXT_TIMER();

enum
{
	P_GT = 1,
	P_SPEED
}

/*
native SendClientMessageForAllOthers(playerid, color, const string[])
native GameTextForAllOthers(playerid,const string[],time,style);
native GetPlayerSpeed_Kmh(playerid);
native GetPlayerSpeed_Mph(playerid);
*/
native	kz_GameTextForPlayer(playerid,const string[],time,style) = GameTextForPlayer;

//Modified dcmd
#define kcmd(%1) if((!strcmp(cmdtext,%1,true,strlen(%1)))&&(((!cmdtext[strlen(%1)])&&(k%1(playerid,"")))||((cmdtext[strlen(%1)]==32)&&(k%1(playerid,cmdtext[strlen(%1)+1])))))return 1


stock SendClientMessageForAllOthers(playerid, color, const string[])
{
	for (new i, j = GetMaxPlayers(); i < j; i++)
		if (IsPlayerConnected(i) && i != playerid)
			SendClientMessage(i, color, string)
}


stock GameTextForPlayer(playerid,const string[],time,style)
{
	if (time < 1000) time = 1000;
	SetPlayerProp_Int( playerid, P_GT, floatround(time/1000.0), KZ_VM);
	return kz_GameTextForPlayer( playerid, string, time, style);
}


stock GameTextForAll(const string[],time,style)
{
	for (new i, j = GetMaxPlayers(); i < j; i++)
		if (IsPlayerConnected(i))
			GameTextForPlayer(i,string,time,style);
}


stock GameTextForAllOthers(playerid,const string[],time,style)
{
	for (new i, j = GetMaxPlayers(); i < j; i++)
		if (IsPlayerConnected(i) && i != playerid)
			GameTextForPlayer(i,string,time,style);
}


stock GetPlayerSpeed_Kmh(playerid)
	return GetPlayerProp_Int(playerid,P_SPEED,KZ_VM);


stock GetPlayerSpeed_Mph(playerid)
	return floatround( GetPlayerProp_Int(playerid,P_SPEED,KZ_VM) / 1.6 );


public PRIVATE_GAMETEXT_TIMER()
{
	for (new i, j = GetMaxPlayers(); i < j; i++)
		if (IsPlayerConnected(i) && GetPlayerProp_Int( i, P_GT, KZ_VM ) > 0)
			SetPlayerProp_Int(i, P_GT, GetPlayerProp_Int( i, P_GT, KZ_VM) - 1, KZ_VM);
}