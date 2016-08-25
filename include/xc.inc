#include <a_samp>

//------------------------------------------------------------------------------
// xCheckpoints

#define MAX_CHECKPOINTS 255

Float:GetPointDistanceToPoint(Float:x1,Float:y1,Float:z1,Float:x,Float:y,Float:z)
{
	return floatsqroot(floatpower(floatabs(floatsub(x,x1)),2)+floatpower(floatabs(floatsub(y,y1)),2)+floatpower(floatabs(floatsub(z,z1)),2));
}

forward CheckpointUpdate();

#define xc_x 0
#define xc_y 1
#define xc_z 2
#define xc_size 3
#define xc_dist 4

new Float:xc_Info[MAX_CHECKPOINTS][5];
new bool:xc_inuse[MAX_CHECKPOINTS];
new xc_Player[MAX_PLAYERS];
new bool:xc_playersee[MAX_PLAYERS][MAX_CHECKPOINTS];
new bool:xc_timer = false;
new bool:xc_con[MAX_PLAYERS] = false;

GetFreeCheckpoint()
{
	for(new i; i < MAX_CHECKPOINTS; i++) if(!xc_inuse[i]) return i;
	return -1;
}

AddCheckpoint(Float:x,Float:y,Float:z,Float:size,Float:dist)
{
	if(!xc_timer)
	{
	    SetTimer("CheckpointUpdate",1000,1);
	    xc_timer = true;
	    SendClientMessageToAll(0xFFFFFFAA,"started timer");
	}

    new xc_checks = GetFreeCheckpoint();
    xc_Info[xc_checks][xc_x] = x;
    xc_Info[xc_checks][xc_y] = y;
    xc_Info[xc_checks][xc_z] = z;
    xc_Info[xc_checks][xc_size] = size;
    xc_Info[xc_checks][xc_dist] = dist;
    xc_inuse[xc_checks] = true;
    for(new i; i < MAX_PLAYERS; i++) xc_playersee[i][xc_checks] = true;
    SendClientMessageToAll(0xFFFFFFAA,"added checkpoint");
    return xc_checks;
}

AddPlayerCheckpoint(Float:x,Float:y,Float:z,Float:size,Float:dist,playerid,...)
{
	if(!xc_timer)
	{
	    SetTimer("CheckpointUpdate",1000,1);
	    xc_timer = true;
	}

    new xc_checks = GetFreeCheckpoint();
    xc_Info[xc_checks][xc_x] = x;
    xc_Info[xc_checks][xc_y] = y;
    xc_Info[xc_checks][xc_z] = z;
    xc_Info[xc_checks][xc_size] = size;
    xc_Info[xc_checks][xc_dist] = dist;
    xc_inuse[xc_checks] = true;
    
    xc_playersee[playerid][xc_checks] = true;
    for(new i = 6, j = numargs(); i < j; i++)
    {
        xc_playersee[getarg(i)][xc_checks] = true;
    }
    return xc_checks;
}

TogglePlayerCheckpoints(playerid,bool:viewable,checkpointid,...)
{
    xc_playersee[playerid][checkpointid] = viewable;
    for(new i = 3, j = numargs(); i < j; i++)
    {
        xc_playersee[getarg(i)][checkpointid] = viewable;
    }
}

bool:DisableCheckpoint(checkpointid)
{
	if(xc_inuse[checkpointid])
	{
	    xc_inuse[checkpointid] = false;
	    for(new i; i < MAX_PLAYERS; i++) xc_playersee[i][xc_checks] = false;
	    return true;
	}
	return false;
}

#pragma unused GetFreeCheckpoint
#pragma unused AddCheckpoint
#pragma unused AddPlayerCheckpoint
#pragma unused DisableCheckpoint
#pragma unused TogglePlayerCheckpoints

bool:UpdatePlayerCheckpointInfo(playerid)
{
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	for(new i; i < MAX_CHECKPOINTS; i++)
	{
	    if(xc_playersee[playerid][i])
	    {
		    if(xc_inuse[i] && (GetPointDistanceToPoint(x,y,z,xc_Info[i][xc_x],xc_Info[i][xc_y],xc_Info[i][xc_z]) < xc_Info[i][xc_dist]))
		    {
		        if(xc_Player[playerid] != i)
		        {
		            xc_Player[playerid] = i;
		            SetPlayerCheckpoint(playerid,xc_Info[i][xc_x],xc_Info[i][xc_y],xc_Info[i][xc_z],xc_Info[i][xc_size]);
	                OnPlayerEnterxCheckpointArea(playerid,i);
	                SendClientMessageToAll(0xFFFFFFAA,"OnPlayerEnterxCheckpointArea");
		        }
		        return true;
		    } else if(xc_Player[playerid] == i)
		    {
		        xc_Player[playerid] = -1;
		        DisablePlayerCheckpoint(playerid);
		        return false;
		    }
	    } else if(xc_Player[playerid] == i)
	    {
	        xc_Player[playerid] = -1;
	        DisablePlayerCheckpoint(playerid);
	        return false;
	    }
	}
	return false;
}

public CheckpointUpdate()
{
	for(new i; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    if(!xc_con[i])
			{
				xc_con[i] = true;
				xc_Player[i] = -1;
			}
			UpdatePlayerCheckpointInfo(i);
		} else if(xc_con[i]) xc_con[i] = false;
	}
}

public OnPlayerEnterCheckpoint(playerid)
{
    OnPlayerEnterxCheckpoint(playerid,xc_Player[playerid]);
}

// End of xCheckpoints
//------------------------------------------------------------------------------

OnPlayerEnterxCheckpoint(playerid,checkpointid)
{
	#pragma unused checkpointid
	#pragma unused playerid
}

OnPlayerEnterxCheckpointArea(playerid,checkpointid)
{
	#pragma unused checkpointid
	#pragma unused playerid
}
