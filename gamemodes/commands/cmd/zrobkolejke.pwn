//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ zrobkolejke ]----------------------------------------------//
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

YCMD:zrobkolejke(playerid, params[], help)
{
    if(PlayerInfo[playerid][pAdmin] < 5000) return 1;
    if(!VAR_Kolejka)
    {
        MoveDynamicObject(AI_SIGN[2], 3807.618408, -537.492492, 8.635930, 10.0); //text
        MoveDynamicObject(AI_MOVABLE[0], 3912.3362, -561.6449, 0.0500, 3.0, 0.000000, 0.000000, 48.0199);
        MoveDynamicObject(AI_MOVABLE[1], 3916.104736, -557.708984, -7.878650, 3.0);
        MoveDynamicObject(AI_NAPIS[0], 3843.368896, -567.393066, 1.844089, 3.0);
        MoveDynamicObject(AI_NAPIS[1], 3843.383789, -567.369018, 1.844089, 3.0); //text

        AI_PROTECT[0] = CreateDynamicObject(4735, 3906.916503, -560.902465, 6.887539, 0.000000, 0.000000, 331.760101, 5000, -1, -1, 500.0, 500.0);
        AI_PROTECT[1] = CreateDynamicObject(4735, 3906.907958, -560.920532, 1.245040, 0.000000, 0.000000, 331.760101, 5000, -1, -1, 500.0, 500.0);
        AI_PROTECT[2] = CreateDynamicObject(4735, 3906.916503, -560.902465, -2.905679, 0.000000, 0.000000, 331.760101, 5000, -1, -1, 500.0, 500.0);
        AI_PROTECT[3] = CreateDynamicObject(4735, 3914.500732, -546.748474, 1.245040, 0.000000, 0.000000, 331.760101, 5000, -1, -1, 500.0, 500.0);
        AI_PROTECT[4] = CreateDynamicObject(4735, 3914.500732, -546.748474, -3.921910, 0.000000, 0.000000, 331.760101, 5000, -1, -1, 500.0, 500.0);
        AI_PROTECT[5] = CreateDynamicObject(4735, 3899.221435, -575.369873, 6.887539, 0.000000, 0.000000, 331.760101, 5000, -1, -1, 500.0, 500.0);
        AI_PROTECT[6] = CreateDynamicObject(4735, 3899.221435, -575.369873, 1.364959, 0.000000, 0.000000, 331.760101, 5000, -1, -1, 500.0, 500.0);
        AI_PROTECT[7] = CreateDynamicObject(4735, 3907.697753, -577.399230, 7.392230, 0.000000, 0.000000, 62.899749, 5000, -1, -1, 500.0, 500.0);
        AI_PROTECT[8] = CreateDynamicObject(4735, 3917.948242, -589.035888, 7.392230, 0.000000, 0.000000, 18.559692, 5000, -1, -1, 500.0, 500.0);
        AI_PROTECT[9] = CreateDynamicObject(4735, 3919.635253, -605.333740, 7.392230, 0.000000, 0.000000, 354.439575, 5000, -1, -1, 500.0, 500.0);
        AI_PROTECT[10] = CreateDynamicObject(4735, 3919.292968, -611.443481, 3.371710, 0.000000, 0.000000, 356.959472, 5000, -1, -1, 500.0, 500.0);
        for(new i=0;i<11;i++) SetDynamicObjectMaterialText(AI_PROTECT[i], 0, "_", 90, "Arial", 36, 1, 0xFFFFFFFF, 0, 1);

        VAR_Kolejka=true;
        SendClientMessageToAll(0x75C8B7, "Administrator uruchomi³ kolejkê. Je¿eli masz jak¹œ sprawê, wpisz /kolejka");
    }
    else
    {
        MoveDynamicObject(AI_SIGN[2], 3807.618408, -537.492492, -10.0, 10.0); //text
        MoveDynamicObject(AI_MOVABLE[0], 3903.6672, -563.0015, 0.0500, 3.0, 0.000000, 0.000000, 149.9600);
        MoveDynamicObject(AI_MOVABLE[1], 3916.104736, -557.708984, -18.0, 3.0);
        MoveDynamicObject(AI_NAPIS[0], 3843.368896, -567.393066, -2.0, 3.0);
        MoveDynamicObject(AI_NAPIS[1], 3843.383789, -567.369018, -2.0, 3.0); //text

        for(new i=0;i<11;i++) DestroyDynamicObject(AI_PROTECT[i]);

        VAR_Kolejka=false;

        SendClientMessageToAll(0x75C8B7, "Administrator zakoñczy³ kolejkê.");

        for(new i=0;i<MAX_PLAYERS;i++)
        {
            if(GetPVarInt(i, "kolejka") == 1)
            {
                SetPVarInt(i, "kolejka", 0);
                SetPlayerPos(i, GetPVarFloat(i, "kolejka-x"),GetPVarFloat(i, "kolejka-y"),GetPVarFloat(i, "kolejka-z"));
                SetPlayerVirtualWorld(i, GetPVarInt(i, "kolejka-vw"));
                SetPlayerInterior(i, GetPVarInt(i, "kolejka-int"));
                Wchodzenie(i);
            }
        }
    }
    return 1;
}
