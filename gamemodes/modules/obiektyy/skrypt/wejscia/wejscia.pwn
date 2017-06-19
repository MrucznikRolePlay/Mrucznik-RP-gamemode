//MODULE_NAME.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//---------------------------------------[ Modu³: MODULE_NAME.pwn ]------------------------------------------//
//Opis:
/*

*/
//Adnotacje:
/*JanPawe³DrugiGwa³cilMa³eDzieci

*/
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

//

//-----------------<[ Funkcje: ]>-------------------
stock DodajWejscie(Float:fx1, Float:fy1, Float:fz1, Float:fx2, Float:fy2, Float:fz2, vw1=0, int1=0, vw2=0, int2=0, nazwain[]="", nazwaout[]="")
{
	wejscia[iloscwejsc][w_x1] = fx1;
	wejscia[iloscwejsc][w_y1] = fy1;
	wejscia[iloscwejsc][w_z1] = fz1;
	wejscia[iloscwejsc][w_x2] = fx2;
	wejscia[iloscwejsc][w_y2] = fy2;
	wejscia[iloscwejsc][w_z2] = fz2;
	wejscia[iloscwejsc][w_vw1] = vw1;
	wejscia[iloscwejsc][w_int1] = int1;
	wejscia[iloscwejsc][w_vw2] = vw2;
	wejscia[iloscwejsc][w_int2] = int2;
	
	if(isnull(nazwain)) 
	{
		CreateDynamicPickup(1239, 2, fx1, fy1, fz1, vw1, int1);
	}
	else  
	{
		new Float:range = (int1 == 0 && vw1 == 0) ? EXTERIOR_3DTEXT_RANGE : INTERIOR_3DTEXT_RANGE;
		CreateDynamic3DTextLabel(nazwain, 0xC2A2DAAA, fx1, fy1, fz1, range, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, vw1, int1);
	}
	if(isnull(nazwaout)) 
	{
		CreateDynamicPickup(1239, 2, fx1, fy1, fz1, vw2, int2);
	}
	else 
	{
		new Float:range = ((int2 == 0 && vw2 == 0) ? (EXTERIOR_3DTEXT_RANGE) : (INTERIOR_3DTEXT_RANGE));
		CreateDynamic3DTextLabel(nazwaout, 0xC2A2DAAA, fx2, fy2, fz2, range, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, vw2, int2);
	}
	
	return iloscwejsc++;
}

stock SprawdzWejscia(playerid)
{
	for(new i; i<iloscwejsc; i++)
	{
		if(GetPlayerInterior(playerid) == wejscia[i][w_int1] && GetPlayerVirtualWorld(playerid) == wejscia[i][w_vw1] && IsPlayerInRangeOfPoint(playerid, 2.0, wejscia[i][w_x1],  wejscia[i][w_y1], wejscia[i][w_z1]))
		{
			SetPlayerPos(playerid,  wejscia[i][w_x2],  wejscia[i][w_y2], wejscia[i][w_z2]);
			SetPlayerInterior(playerid, wejscia[i][w_int2]);
			SetPlayerVirtualWorld(playerid, wejscia[i][w_vw2]);
			Wchodzenie(playerid);
			return 1;
		}
		else if(GetPlayerInterior(playerid) == wejscia[i][w_int2] && GetPlayerVirtualWorld(playerid) == wejscia[i][w_vw2] && IsPlayerInRangeOfPoint(playerid, 2.0, wejscia[i][w_x2],  wejscia[i][w_y2], wejscia[i][w_z2]))
		{
			SetPlayerPos(playerid,  wejscia[i][w_x1],  wejscia[i][w_y1], wejscia[i][w_z1]);
			SetPlayerInterior(playerid, wejscia[i][w_int1]);
			SetPlayerVirtualWorld(playerid, wejscia[i][w_vw1]);
			Wchodzenie(playerid);
			return 1;
		}
	}
	return 0;
}

forward Wchodzenie(playerid);
public Wchodzenie(playerid) //Zmiana na inteligentny system odmra¿ania
{
    if(GetPVarInt(playerid, "enter-check") == 0)
    {
        TogglePlayerControllable(playerid, 0);
        SetPVarInt(playerid, "enter-check", 1);
        SetPVarInt(playerid, "enter-nowobj", 0);
        SetPVarInt(playerid, "enter-stuffobj", 0);
        SetPVarInt(playerid, "enter-stuff", 0);
        SetPVarInt(playerid, "enter-oldvw", GetPVarInt(playerid, "enter-vw"));
        SetPVarInt(playerid, "enter-vw", GetPlayerVirtualWorld(playerid));
        SetPVarInt(playerid, "enter-time", gettime());
    }
    else
    {
        new count = Streamer_CountVisibleItems(playerid, STREAMER_TYPE_OBJECT);
        if( ((count >= GetPVarInt(playerid, "enter-nowobj")) && GetPVarInt(playerid, "enter-nowobj") != 0) || (count > 0 && GetPVarInt(playerid, "enter-oldvw") == GetPVarInt(playerid, "enter-vw")) || (GetPVarInt(playerid, "enter-nowobj") >= count)) //obj wczytane
        {
            TogglePlayerControllable(playerid, 1);
            SetPVarInt(playerid, "enter-check", 0);
            if(GetPVarInt(playerid, "enter-stuff") != 0) DestroyDynamicObject(GetPVarInt(playerid, "enter-stuffobj"));
            return 1;
        }
        else if(GetPVarInt(playerid, "enter-nowobj") == 0) //check lag
        {
            if(GetPVarInt(playerid, "enter-stuff") == 0)
            {
                new Float:x, Float:y, Float:z;
                GetPlayerPos(playerid, x, y, z);
                SetPVarInt(playerid, "enter-stuffobj", CreateDynamicObject(19300, x, y, z, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), playerid));
                SetPVarInt(playerid, "enter-stuff", 1);
                Streamer_Update(playerid);
            }
        }
        else
        {
            TogglePlayerControllable(playerid, 1);
            SetPVarInt(playerid, "enter-check", 0);
            new str[128];
            SendClientMessage(playerid, -1, "(OBJ LOADER Inteligencja) - B³¹d z wczytaniem obiektów, nie mo¿na dodaæ nowych - zg³os to z debugiem:");
            format(str, 128, "CHK |%d| NowOBJ |%d| Stuff |%d:%d| VW.o |%d| VW.n |%d| T |%d| T.n |%d| T.s |%d| Count |%d|", GetPVarInt(playerid, "enter-check"),GetPVarInt(playerid, "enter-nowobj"),GetPVarInt(playerid, "enter-stuffobj"),GetPVarInt(playerid, "enter-stuff"),GetPVarInt(playerid, "enter-oldvw"),GetPVarInt(playerid, "enter-vw"),GetPVarInt(playerid, "enter-time"), gettime(), gettime()-GetPVarInt(playerid, "enter-time"),count);
            SendClientMessage(playerid, -1, str);
            printf("(OBJ LOADER Inteligencja) FAIL [%d]! CHK |%d| NowOBJ |%d| Stuff |%d:%d| VW.o |%d| VW.n |%d| T |%d| T.n |%d| T.s |%d| Count |%d|", playerid, GetPVarInt(playerid, "enter-check"),GetPVarInt(playerid, "enter-nowobj"),GetPVarInt(playerid, "enter-stuffobj"),GetPVarInt(playerid, "enter-stuff"),GetPVarInt(playerid, "enter-oldvw"),GetPVarInt(playerid, "enter-vw"),GetPVarInt(playerid, "enter-time"), gettime(), gettime()-GetPVarInt(playerid, "enter-time"),count);
            if(GetPVarInt(playerid, "enter-stuff") != 0) DestroyDynamicObject(GetPVarInt(playerid, "enter-stuffobj"));
        }
        SetPVarInt(playerid, "enter-nowobj", count);
    }
    SetTimerEx("Wchodzenie", 1000, 0, "i", playerid);
    return 1;
}

//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end