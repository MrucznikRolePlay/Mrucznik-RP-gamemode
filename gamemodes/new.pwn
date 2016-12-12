#include <a_samp>
#include <code-parse>
#include <YSI\YSI_Visual\y_dialog>
#include <YSI\YSI_Coding\y_inline>
#include <YSI\YSI\y_commands>


main()
{
	print("\n----------------------------------");
	print(" Blank Gamemode by your name here");
	print("----------------------------------\n");
}


public OnGameModeInit()
{
	SetGameModeText("Blank Script");
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid==15) {
		SendClientMessage(playerid, -1, "TESTNORMAL      ye boiii");
	}
	return 1;
}
CMD:testydialog(playerid, params[]) {
	inline DIALOG_LKIZ(pid, dialogid, response, listitem, string:inputtext[]) {
        #pragma unused pid, dialogid, response, listitem, inputtext
        SendClientMessage(playerid, -1, "TESTYDIALOG   ye boiii");
    }
    SendClientMessage(playerid, -1, "TESTYDIALOG   ya here?");
    Dialog_ShowCallback(playerid, using inline DIALOG_LKIZ, DIALOG_STYLE_MSGBOX, "cxzcxz", "asd", "asdas", "xzc");
    return 1;
}
CMD:testnormal(playerid, params[]) {
	SendClientMessage(playerid, -1, "TESTNORMAL      ya here?");
	ShowPlayerDialog(playerid, 15, DIALOG_STYLE_MSGBOX, "cxzcxz", "asd", "asdas", "xzc");
	return 1;
}