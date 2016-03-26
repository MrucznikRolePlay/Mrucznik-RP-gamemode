//
// Admin player netstats display
// Using NetStats_* functions.
//
// -Rcon login admin then:
// /pnetstats2 (playerid)
//

#include <a_samp>
#include "../include/gl_common.inc"

#define ADMINFS_MESSAGE_COLOR 0xFF444499
#define ADMIN_NETSTATS_DIALOGID 12899

new gNetStatsPlayerId = INVALID_PLAYER_ID;
new gNetStatsDisplayId = INVALID_PLAYER_ID;

new gNetStatsTimerId = 0;

forward NetStatsDisplay();

//------------------------------------------------

public OnFilterScriptInit()
{
	print("\n--Admin Netstats FS loaded.\n");
	return 1;
}

//------------------------------------------------

BuildPlayerNetstatString(playerid, ret_str[], ret_str_len)
{
	new szPlayerIpPort[64+1];
	NetStats_GetIpPort(playerid, szPlayerIpPort, 64);
	
	format(ret_str, ret_str_len, "IP_Port: %s\nConnected Time (ms): %d\nConnection Status: %d\nPacket Loss: %.2f\nMessages Recv: %d\nMessages Sent: %d\nMessages/sec: %d",
	        szPlayerIpPort,
	        NetStats_GetConnectedTime(playerid),
	        NetStats_ConnectionStatus(playerid),
	        NetStats_PacketLossPercent(playerid),
	        NetStats_MessagesReceived(playerid),
	        NetStats_MessagesSent(playerid),
	        NetStats_MessagesRecvPerSecond(playerid));
}

//------------------------------------------------

public NetStatsDisplay()
{
	new netstats_str[1024+1];
	BuildPlayerNetstatString(gNetStatsDisplayId, netstats_str, 1024);
	ShowPlayerDialog(gNetStatsPlayerId, ADMIN_NETSTATS_DIALOGID, DIALOG_STYLE_MSGBOX, "Player NetStats", netstats_str, "Ok", "");
}

//------------------------------------------------

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(!IsPlayerAdmin(playerid)) return 0; // this is an admin only script

	if(dialogid == ADMIN_NETSTATS_DIALOGID) {
		KillTimer(gNetStatsTimerId);
		gNetStatsPlayerId = INVALID_PLAYER_ID;
		return 1;
	}
	
	return  0;
}

//------------------------------------------------

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256+1];
	new	idx;

	if(!IsPlayerAdmin(playerid)) return 0;
	
	cmd = strtok(cmdtext, idx);
	
    // netstats command
	if(strcmp("/pnetstats2", cmd, true) == 0)
	{
	    new tmp[128];
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) { return 1; }
		 
	    gNetStatsPlayerId = playerid;
	    gNetStatsDisplayId = strval(tmp);
	    
	    NetStatsDisplay();
	    gNetStatsTimerId = SetTimer("NetStatsDisplay", 3000, true); // this will refresh the display every 3 seconds
	    return 1;
	}
	
	return 0;
}
//------------------------------------------------
