#include <a_samp>

#define VER_SAMP0                                                             "0.3.7-R3"
#define VER_SAMP1                                                             "0.3.DL-R1"

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Check Version FS by PECET");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit() {
    return 1;
}

public OnPlayerSpawn(playerid)
{
    new version[24];
    GetPlayerVersion(playerid, version, sizeof(version));
    if(strfind(version, VER_SAMP0, true) == -1 && strfind(version, VER_SAMP1, true) == -1)
	{
	    new string[512];
        format(string, sizeof(string), "{FFFFFF}Twoja wersja klienta SA-MP: {FF0000}%s {FFFFFF}jest niezgodna z najnowsz¹ wersj¹ SA-MP wymagan¹ do gry na tym serwerze. \n\nZainstaluj wersjê {0000FF}%s {FFFFFF}lub{0000FF} %s{FFFFFF}, by kontynuowaæ grê.\n\n {00FF00}LINK DO POBRANIA: {FFFFFF}http://sa-mp.com/download.php", version, VER_SAMP0, VER_SAMP1);
        ShowPlayerDialog(playerid, 10101, DIALOG_STYLE_MSGBOX, "{FF0000}NIEPRAWID£OWA WERSJA KLIENTA SA-MP", string, "OK", "");
        SetTimerEx("KickPlayer", 1000, false, "d", playerid);
        return 1;
    }
    return 1;
}

forward KickPlayer(playerid);
public KickPlayer(playerid) return Kick(playerid);
