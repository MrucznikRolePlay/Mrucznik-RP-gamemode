//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ cziterzy ]-----------------------------------------------//
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

YCMD:cziterzy(playerid, params[], help)
{
    new czity = 0;
    new string[1500];
    if(PlayerInfo[playerid][Admin] >= 1 || PlayerInfo[playerid][HalfAdmin] >= 1 || IsAScripter(playerid)) {
        foreach(new i : Player) {
            if(GetPVarInt(i, "AC-warn") > 1) {
                format(string, sizeof(string), "%s[AC] %s (ID: %d)\n", string, GetNick(i), i);
                czity++;
            } else if(GetPVarInt(i, "AC_oznaczony") == 1) {
                format(string, sizeof(string), "%s[S0BEIT] %s (ID: %d)\n", string, GetNick(i), i);
                czity++;
            } 
        }
    }

    if(czity == 0) {
        sendTipMessage(playerid, "Nie wykryto ¿adnych potencjalnych cziterów");
    }
    ShowPlayerDialogEx(playerid, 0, DIALOG_STYLE_LIST, "Lista Potencjalnych Cziterów", string, "Ok", "");
    return 1;
}
