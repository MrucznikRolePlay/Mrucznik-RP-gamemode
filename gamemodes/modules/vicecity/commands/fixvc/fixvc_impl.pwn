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

    new Float:x, Float:y, Float:z;
    new Float:collX, Float:collY, Float:collZ;
    new coll = CA_RayCastLine(x, y, z, x, y, z + 50, collX, collY, collZ);
    if(coll == WATER_OBJECT)
    {
        coll = CA_RayCastLine(x, y, z + 0.5, x, y, z + 50, collX, collY, collZ);
    }

    if(coll == WATER_OBJECT)
    {
        MruMessageFail(playerid, "Spróbuj wyp³yn¹æ na powierzchniê wody.");
        return 1;
    }

    SetPlayerPos(playerid, collX, collY, collZ + 1.5);
    GameTextForPlayer(playerid, "Naprawiles swoja pozycje!", 5000, 1);
    return 1;
}

//end