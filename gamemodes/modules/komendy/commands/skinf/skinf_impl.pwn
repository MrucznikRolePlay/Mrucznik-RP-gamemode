//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     a                                                     //
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
// Data utworzenia: 15.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_skinf_Impl(playerid)
{
    if(!IsPlayerConnected(playerid) || !gPlayerLogged[playerid]) return 1;
    if(GetPlayerFraction(playerid) == 0 && GetPlayerOrg(playerid) == 0) return sendErrorMessage(playerid, "Nie jeste� we frakcji/organizacji!");
    if(GetPVarInt(playerid, "IsAGetInTheCar") == 1)
    {
        sendErrorMessage(playerid, "Jeste� podczas wsiadania - odczekaj chwile. Nie mo�esz znajdowa� si� w poje�dzie.");
        return 1;
    }
	if(GetPlayerVehicleID(playerid) != 0) return sendErrorMessage(playerid, "Nie mo�esz znajdowa� si� w poje�dzie!");
    if(GetPVarInt(playerid, "skinF") == 0)
    {
        if(PlayerInfo[playerid][pUniform] == 0)
        {
            sendErrorMessage(playerid, "Nie posiadasz �adnego uniformu!"); 
            return 1;
        }
        SetPVarInt(playerid, "skinF", 1);
        sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Przebra�e� si� w str�j frakcyjny");
        SetPlayerSkinEx(playerid, PlayerInfo[playerid][pUniform]);
    }
    else
    {
        SetPVarInt(playerid, "skinF", 0);
        sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Przebra�e� si� w str�j cywilny");
        SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
    }
    return 1;
}

//end
