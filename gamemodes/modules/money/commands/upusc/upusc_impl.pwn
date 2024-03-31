//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   upusc                                                   //
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
// Autor: mrucznik
// Data utworzenia: 31.03.2024


//

//------------------<[ Implementacja: ]>-------------------
command_upusc_Impl(playerid, money)
{
    if(money < 1 || money > 100001)
    {
        sendTipMessage(playerid, "Kwota musi wynosiæ mniej ni¿ 100 000$ .");
        return 1;
    }
    if(money > 12500 && PlayerInfo[playerid][pLevel] < 2 && PlayerInfo[playerid][pLocal] != 108)
    {
        sendTipMessage(playerid, "Nie mo¿esz upuœciæ wiêcej niz $12 500.");
        return 1;
    }
    if(PlayerInfo[playerid][pConnectTime] == 0)
    {
        sendTipMessage(playerid, "Zanim bêdziesz móg³ upuœciæ pieni¹dze, musisz graæ przez 1 godzinê!");
        return 1;
    }
    if(AntySpam[playerid] == 1)
    {
        sendTipMessage(playerid, "Odczekaj 15 sekund - poœwiêæ ten czas na wykonanie akcji RP.");
        return 1;
    }

    new string[64];
    format(string, sizeof(string), "upuszcza %d$ na ziemiê.");
    ChatMe(playerid, string);

    ZabierzKase(playerid, money);
	Log(payLog, INFO, "%s upuszcza %d$ na ziemiê (money pickup)", GetPlayerLogName(playerid), money);

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    new int =  GetPlayerInterior(playerid);
    new vw = GetPlayerVirtualWorld(playerid);
    GetXYInFrontOfPlayer(playerid, x, y, 1.0);
    CreateMoneyPickup(x, y, z - 0.4, int, vw, money, 0, PlayerInfo[playerid][pUID]);

    AntySpam[playerid] = 1;
    return 1;
}

//end