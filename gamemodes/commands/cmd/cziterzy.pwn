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

CMD:cziterzy(playerid, params[])
{
    /*if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1)//if(PlayerInfo[playerid][pAdmin] < 1) return 1;
    {
    	new str[128];
    	SendClientMessage(playerid, -1, "Potencjalna lista cziterów:");
    	foreach(new i : Player)
    	{
        	if(GetPVarInt(i, "AC-warn") > 1)
        	{
            	if(PlayerInfo[i][pLevel] <= 3)
            	{
                	format(str, 128, "= %s (%d) LVL [%d], AC sprawdzenia: %d", GetNick(i), i, PlayerInfo[i][pLevel], GetPVarInt(i, "AC-warn"));
                	SendClientMessage(playerid, -1, str);
            	}
        	}
    	}

		ListaCziterow(playerid);
	} */
    new czity = 0;
    new string[1500];
    if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1) {
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



