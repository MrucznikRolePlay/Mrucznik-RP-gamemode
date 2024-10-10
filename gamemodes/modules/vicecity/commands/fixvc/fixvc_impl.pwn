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
      
    new obj = CA_RayCastLine(x, y, 700.0, x, y, -1000.0, x, y, z);
    if(obj == 0)
    {
        MruMessageFail(playerid, "Niestety, nie uda³o siê naprawiæ pozycji - nie ma nad Tob¹ ¿adnego obiektu.");
        return 1;
    }
    else if(obj == WATER_OBJECT)
    {
        MruMessageFail(playerid, "Niestety, nie uda³o siê naprawiæ pozycji - wykryto tylko wodê.");
        return 1;
    }

    SetPlayerPos(playerid, x, y, z + 1.5);
    GameTextForPlayer(playerid, "Naprawiles swoja pozycje!", 5000, 1);
    return 1;
}

ptask CheckFixVc[1000](playerid)
{
    new Float:unused;
    new now = gettime();
    if(IsPlayerAtViceCity(playerid) && 
        CA_IsPlayerInWater(playerid, unused, unused) &&
        now - GetPVarInt(playerid, "fixvc-message") > 300_000) // message every 5min
    {
        new Float:x, Float:y, Float:z, Float:foundZ;
        GetPlayerPos(playerid, x, y, z);
        
        CA_FindZ_For2DCoord(x, y, foundZ);
        if(foundZ < z)
        {
            MruMessageBadInfo(playerid, "Serwer wykry³, ¿e wpad³eœ pod textury. Jeœli to prawda, wpisz /fixvc aby naprawiæ swoj¹ pozycjê.");
            SetPVarInt(playerid, "fixvc-message", now);
        }
    }
}

//end