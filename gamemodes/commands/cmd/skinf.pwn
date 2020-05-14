//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ skinf ]-------------------------------------------------//
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

YCMD:skinf(playerid, params[], help)
{
    if(!IsPlayerConnected(playerid) || !gPlayerLogged[playerid]) return 1;
    if(GetPlayerFraction(playerid) == 0) return sendErrorMessage(playerid, "Nie jesteœ we frakcji!");
    if(GetPVarInt(playerid, "IsAGetInTheCar") == 1)
    {
        sendErrorMessage(playerid, "Jesteœ podczas wsiadania - odczekaj chwile. Nie mo¿esz znajdowaæ siê w pojeŸdzie.");
        return 1;
    }
	if(GetPlayerVehicleID(playerid) != 0) return sendErrorMessage(playerid, "Nie mo¿esz znajdowaæ siê w pojeŸdzie!");
    if(GetPVarInt(playerid, "skinF") == 0)
    {
        if(PlayerInfo[playerid][pUniform] == 0)
        {
            sendErrorMessage(playerid, "Nie posiadasz ¿adnego uniformu!"); 
            return 1;
        }
        SetPVarInt(playerid, "skinF", 1);
        sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Przebra³eœ siê w strój frakcyjny");
        SetPlayerSkinEx(playerid, PlayerInfo[playerid][pUniform]);
    }
    else
    {
        SetPVarInt(playerid, "skinF", 0);
        sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Przebra³eœ siê w strój cywilny");
        SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
    }
    return 1;
}
