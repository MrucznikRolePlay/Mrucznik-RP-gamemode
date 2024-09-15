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
command_deleteobject_Impl(playerid, params[256])
{
    if(!IsAHeadAdmin(playerid)) return 1;
    new typ, data, extra;
    if(sscanf(params, "ddD(0)", typ, data, extra))
    {
        sendTipMessageEx(playerid, -1, "/deleteobject [TYP] [Data] [Extra - 0]");
        sendTipMessageEx(playerid, -1, "TYP: OBJECT - 0 | VW - 1");
        sendTipMessageEx(playerid, -1, "Data: Dla 0 [ObjectID] Dla 1 [VW]");
        sendTipMessageEx(playerid, -1, "Extra: Distance dla 1 (VW)");
        return 1;
    }
    if(typ == 0)
    {
        if(!IsValidDynamicObject(data)) return sendTipMessageEx(playerid, -1, "Niepoprawne ID obiektu");
        DestroyDynamicObject(data);
    }
    else if(typ == 1)
    {
        new count, Float:x, Float:y, Float:z;
        if(extra == 0)
        {
            for(new i=0;i<25000;i++)
            {
                if(IsValidDynamicObject(i))
                {
                    if(Streamer_GetIntData(STREAMER_TYPE_OBJECT, i, E_STREAMER_WORLD_ID) == data)
                    {
                        GetDynamicObjectPos(i, x, y, z);
                        Log(adminLog, INFO, "Admin %s usun¹³ obiekt %d - model %d at [%.1f, %.1f, %.1f]", GetPlayerLogName(playerid), i, Streamer_GetIntData(STREAMER_TYPE_OBJECT, i, E_STREAMER_MODEL_ID), x, y, z);
                        DestroyDynamicObject(i);
                        count++;
                    }
                }
            }
        }
        else
        {
            new Float:px, Float:py, Float:pz;
            GetPlayerPos(playerid, px, py, pz);
            for(new i=0;i<25000;i++)
            {
                if(IsValidDynamicObject(i))
                {
                    if(Streamer_GetIntData(STREAMER_TYPE_OBJECT, i, E_STREAMER_WORLD_ID) == data)
                    {
                        GetDynamicObjectPos(i, x, y, z);
                        if(VectorSize(x-px, y-py, z-pz) < float(extra))
                        {
                            Log(adminLog, INFO, "Admin %s usun¹³ VW.%d dist.%d object %d - model %d at [%.1f, %.1f, %.1f]", GetPlayerLogName(playerid), data, extra, i, Streamer_GetIntData(STREAMER_TYPE_OBJECT, i, E_STREAMER_MODEL_ID), x, y, z);
                            DestroyDynamicObject(i);
                            count++;

                        }
                    }
                }
            }
        }
        new dest[16];
        format(dest, 16, "Total %d", count);
        sendTipMessageEx(playerid, 0xFF0000FF, dest);
    }
    return 1;
}

//end
