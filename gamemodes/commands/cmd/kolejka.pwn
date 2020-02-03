//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ kolejka ]------------------------------------------------//
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

YCMD:kolejka(playerid, params[], help)
{
    if(VAR_Kolejka)
    {
        if(GetPVarInt(playerid, "kolejka") == 0)
        {
            //Save last pos
            new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x, y, z);
            SetPVarFloat(playerid, "kolejka-x", x);
            SetPVarFloat(playerid, "kolejka-y", y);
            SetPVarFloat(playerid, "kolejka-z", z);
            SetPVarInt(playerid, "kolejka-int", GetPlayerInterior(playerid));
            SetPVarInt(playerid, "kolejka-vw", GetPlayerVirtualWorld(playerid));
            //And teleport
            SetPVarInt(playerid, "kolejka", 1);
            SetPlayerVirtualWorld(playerid, 5000);
            SetPlayerPos(playerid,3841.4478, -562.6168, 2.7752);
            sendTipMessageEx(playerid, 0x75C8B7FF, "Witamy! Proszê ustawiæ siê w kolejce. Aby wyjœæ wpisz ponownie /kolejka");
            Wchodzenie(playerid);
        }
        else
        {
            SetPVarInt(playerid, "kolejka", 0);
            SetPlayerPos(playerid, GetPVarFloat(playerid, "kolejka-x"),GetPVarFloat(playerid, "kolejka-y"),GetPVarFloat(playerid, "kolejka-z"));
            SetPlayerVirtualWorld(playerid, GetPVarInt(playerid, "kolejka-vw"));
            SetPlayerInterior(playerid, GetPVarInt(playerid, "kolejka-int"));
            Wchodzenie(playerid);
        }
    }
    else
    {
        sendTipMessageEx(playerid, 0x75C8B7FF, "Aktualnie nie ma kolejki na serwerze.");
    }
    return 1;
}
