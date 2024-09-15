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
command_delete3dtext_Impl(playerid, params[256])
{
    if(!IsAHeadAdmin(playerid)) return 1;

    new typ, Text3D:data, extra;
    if(sscanf(params, "ddD(0)", typ, _:data, extra))
    {
        sendTipMessageEx(playerid, -1, "/delete3dtext [TYP] [Data] [Extra - 0]");
        sendTipMessageEx(playerid, -1, "TYP: TextID - 0 | VW - 1");
        sendTipMessageEx(playerid, -1, "Data: Dla 0 [TextID] Dla 1 [VW]");
        sendTipMessageEx(playerid, -1, "Extra: Distance dla 1 (VW)");
        return 1;
    }
    if(typ == 0)
    {
        if(!IsValidDynamic3DTextLabel(data)) return sendTipMessageEx(playerid, -1, "Niepoprawne ID 3Dtextu");
        DestroyDynamic3DTextLabel(data);
    }
    else if(typ == 1)
    {
        new count, Float:x, Float:y, Float:z;
        if(extra == 0)
        {
            for(new i=0;i<20000;i++)
            {
                if(IsValidDynamic3DTextLabel(Text3D:i))
                {
                    if(Streamer_GetIntData(STREAMER_TYPE_3D_TEXT_LABEL, Text3D:i, E_STREAMER_WORLD_ID) == _:data)
                    {
                        Streamer_GetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, Text3D:i, E_STREAMER_X, x);
                        Streamer_GetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, Text3D:i, E_STREAMER_Y, y);
                        Streamer_GetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, Text3D:i, E_STREAMER_Z, z);
                        Log(adminLog, INFO, "Admin %s usun¹³ 3DText %d - at [%.1f, %.1f, %.1f]", GetPlayerLogName(playerid), i, x, y, z);
                        DestroyDynamic3DTextLabel(Text3D:i);
                        count++;
                    }
                }
            }
        }
        else
        {
            new Float:px, Float:py, Float:pz;
            GetPlayerPos(playerid, px, py, pz);
            for(new i=0;i<20000;i++)
            {
                if(IsValidDynamic3DTextLabel(Text3D:i))
                {
                    if(Streamer_GetIntData(STREAMER_TYPE_3D_TEXT_LABEL, Text3D:i, E_STREAMER_WORLD_ID) == _:data)
                    {
                        Streamer_GetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, Text3D:i, E_STREAMER_X, x);
                        Streamer_GetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, Text3D:i, E_STREAMER_Y, y);
                        Streamer_GetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, Text3D:i, E_STREAMER_Z, z);
                        if(VectorSize(x-px, y-py, z-pz) < float(extra))
                        {
                            Log(adminLog, INFO, "Admin %s usun¹³ VW VW.%d dist.%d Text3D %d - at [%.1f, %.1f, %.1f]",  GetPlayerLogName(playerid), _:data, extra, i, x, y, z);
                            DestroyDynamic3DTextLabel(Text3D:i);
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
