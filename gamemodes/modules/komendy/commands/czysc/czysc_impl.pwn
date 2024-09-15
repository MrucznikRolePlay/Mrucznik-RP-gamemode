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
command_czysc_Impl(playerid, params[256])
{
    if(GetPlayerFraction(playerid) != FRAC_ERS && GetPlayerJob(playerid) != JOB_MEDIC) return sendTipMessageEx(playerid, COLOR_GRAD2, "Dostêpne tylko dla pracy stra¿aków.");
    if(JobDuty[playerid] == 0) return sendTipMessageEx(playerid, COLOR_GRAD2, "Nie jestes na s³u¿bie.");
    new Float:lPos[3];
    GetPlayerPos(playerid, lPos[0], lPos[1], lPos[2]);
    new lID = Oil_GetIDAtPosition(lPos[0], lPos[1], lPos[2], 2.5);
    if(lID == -1) return sendTipMessageEx(playerid, COLOR_GRAD2, "Brak plam w pobli¿u.");
    if(GetPVarInt(playerid, "oil_clear") == 0)
    {
        Oil_LoadCleanProcedure(playerid);
        SetPVarInt(playerid, "oil_clear", 1);
        SetPVarInt(playerid, "oil_id", lID);
        TogglePlayerControllable(playerid, 0);
    }
    else
    {
        Oil_UnloadPTXD(playerid);
        SetPVarInt(playerid, "oil_clear", 0);
        TogglePlayerControllable(playerid, 1);
        TextDrawShowForPlayer(playerid, OilTXD_BG[0]);
        TextDrawShowForPlayer(playerid, OilTXD_BG[1]);
    }
    return 1;
}

//end
