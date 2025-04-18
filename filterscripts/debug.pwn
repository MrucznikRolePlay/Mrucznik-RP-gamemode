//-------------------------------------------<< Filterscript >>----------------------------------------------//
//------------------------------------------[ Modu³: EXAMPLE_FILTERSCRIPT.pwn ]---------------------------------------------//
//Opis:
/*
	Skrypt do debugu.
*/
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

//

#include <a_samp>

#define FILTERSCRIPT
#include <Pawn.RakNet>


public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Fliterscript -EXAMPLE_FILTERSCRIPT- zaladowany");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	print("\n--------------------------------------");
	print(" Fliterscript -EXAMPLE_FILTERSCRIPT- wylaczony");
	print("--------------------------------------\n");
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name);
	printf("OnPlayerRequestClass %d %s", playerid, name);
	return 1;
}

// public OnIncomingPacket(playerid, packetid, BitStream:bs)
// {

// }

// public OnIncomingRPC(playerid, rpcid, BitStream:bs)
// {

// }

// public OnIncomingRawPacket(playerid, packetid, BitStream:bs)
// {

// }

// public OnIncomingInternalPacket(playerid, packetid, BitStream:bs)
// {

// }


// // playerid == -1 => broadcast

// public OnOutgoingPacket(playerid, packetid, BitStream:bs)
// {

// }

// public OnOutgoingRPC(playerid, rpcid, BitStream:bs)
// {

// }

// public OnOutgoingInternalPacket(playerid, packetid, BitStream:bs)
// {

// }
