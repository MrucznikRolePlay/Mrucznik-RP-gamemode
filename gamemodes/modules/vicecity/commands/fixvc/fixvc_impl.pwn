//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   fixvc                                                   //
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
// Data utworzenia: 26.04.2024


//

//------------------<[ Implementacja: ]>-------------------
command_fixvc_Impl(playerid)
{
    if(GetPVarInt(playerid, "debug-objects") != 1)
    {
        if(!IsPlayerAtViceCity(playerid))
        {
            MruMessageFail(playerid, "Nie jesteœ w Vice City.");
            return 1;
        }

        new Float:unused;
        if(!CA_IsPlayerInWater(playerid, unused, unused))
        {
            MruMessageFail(playerid, "Nie wpad³eœ do wody!");
            return 1;
        }
    }

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    
    new Float:groundZ;
    CA_FindZ_For2DCoord(x, y, groundZ);

    SetPlayerPos(playerid, x, y, groundZ + 1.5);
    GameTextForPlayer(playerid, "Naprawiles swoja pozycje!", 5000, 1);
    return 1;
}

//end