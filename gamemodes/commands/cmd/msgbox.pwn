//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ msgbox ]------------------------------------------------//
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

YCMD:msgbox(playerid, params[], help)
{
    if(IsAHeadAdmin(playerid) || IsAScripter(playerid))
    {
        new forplayer=-1, title[64], icon, time;
        if(sscanf(params, "ds[64]dd", forplayer, title, icon, time))
        {
            SendClientMessage(playerid, COLOR_GRAD2, "Sk³adnia: [Gracz lub -1 dla wszystkich] [Tytu³ (64)] [Ikona] [Czas (sek)]");
            SendClientMessage(playerid, COLOR_GRAD1, "MSGBOX_ICON_TYPE_OK         0");
            SendClientMessage(playerid, COLOR_GRAD1, "MSGBOX_ICON_TYPE_ERROR      1");
            SendClientMessage(playerid, COLOR_GRAD1, "MSGBOX_ICON_TYPE_SMILE      2");
            SendClientMessage(playerid, COLOR_GRAD1, "MSGBOX_ICON_TYPE_WARNING    3");
            SendClientMessage(playerid, COLOR_GRAD1, "MSGBOX_ICON_TYPE_EXPLODE    4");
            SendClientMessage(playerid, COLOR_GRAD1, "MSGBOX_ICON_TYPE_WAIT       5");
            SendClientMessage(playerid, COLOR_GRAD1, "MSGBOX_ICON_TYPE_FLOWER     6");
            SendClientMessage(playerid, COLOR_GRAD1, "MSGBOX_ICON_TYPE_POLICE     7");
            SendClientMessage(playerid, COLOR_GRAD1, "MSGBOX_ICON_TYPE_FIST       8");
            SendClientMessage(playerid, COLOR_GRAD1, "MSGBOX_ICON_TYPE_ARROW      9");
            return 1;
        }
        if(!(0 <= icon <= 9)) return SendClientMessage(playerid, COLOR_GRAD1, " Ikony od 0 do 9");
        if(!(0 < time < 60)) return SendClientMessage(playerid, COLOR_GRAD1, " Czas od 1 do 60s");
        if(forplayer == -1)
        {
            foreach(new i : Player) MSGBOX_Show(i, title, icon, time, true);
        }
        else MSGBOX_Show(forplayer, title, icon, time, true);
    }
    return 1;
}
