//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ skille ]------------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

CMD:skille(playerid)
{
    PlayerInfo[playerid][pDetSkill] = 5000;
    PlayerInfo[playerid][pLawSkill] = 5000;
    PlayerInfo[playerid][pMechSkill] = 5000;
    PlayerInfo[playerid][pNewsSkill] = 5000;
    PlayerInfo[playerid][pJackSkill] = 5000;
    PlayerInfo[playerid][pDrugsSkill] = 5000;
    PlayerInfo[playerid][pSexSkill] = 5000;
    PlayerInfo[playerid][pBoxSkill] = 5000;
    PlayerInfo[playerid][pGunSkill] = 5000;
    PlayerInfo[playerid][pFishSkill] = 5000;
    PlayerInfo[playerid][pFishSkill] = 5000;
    PlayerInfo[playerid][pTruckSkill] = 5000;

    PlayerInfo[playerid][pMats] = 50000;

    sendTipMessage(playerid, "[Dosta³eœ skille 5 w ka¿dej dziedzinie i 50000 mats]");

    return 1;
}
#endif


//PADZIOCH
/*CMD:lina(playerid, cmdtext[])
{
    if( IsACop(playerid) && GetPVarInt(playerid,"roped") == 0 && GetPlayerVehicleSeat(playerid) != 0 && IsPlayerInAnyVehicle(playerid) && IsAHeliModel(GetPlayerVehicleID(playerid)))
    {
    	GetPlayerPos(playerid,pl_pos[playerid][0],pl_pos[playerid][1],pl_pos[playerid][2]);
     	MapAndreas_FindZ_For2DCoord(pl_pos[playerid][0],pl_pos[playerid][1],pl_pos[playerid][3]);
      	pl_pos[playerid][4] = floatsub(pl_pos[playerid][2],pl_pos[playerid][3]);
       	if(pl_pos[playerid][4] >= ROPELENGTH) return SendClientMessage(playerid,0xAA3333AA,"	Jesteœ zbyt wysoko.");
        if(pl_pos[playerid][4] <= 2) return RemovePlayerFromVehicle(playerid);
        SetPVarInt(playerid,"roped",1);
        SetPlayerCheckpoint(playerid,pl_pos[playerid][0],pl_pos[playerid][1],floatsub(pl_pos[playerid][3],OFFSETZ),20);
        SetPlayerPos(playerid,pl_pos[playerid][0],pl_pos[playerid][1],floatsub(pl_pos[playerid][2],2));
        SetPlayerVelocity(playerid,0,0,0);
        for(new i=0;i!=10;i++) ApplyAnimation(playerid,"ped","abseil",4.0,0,0,0,1,0);
        for(new i=0;i<=pl_pos[playerid][4];i++)
        {
        	r0pes[playerid][i] = CreateDynamicObject(3004,pl_pos[playerid][0],pl_pos[playerid][1],floatadd(pl_pos[playerid][3],i),87.640026855469,342.13500976563, 350.07507324219);
        }
       	SetTimerEx("syncanim",DUR,0,"i",playerid);
	}
	return 1;
}*/




