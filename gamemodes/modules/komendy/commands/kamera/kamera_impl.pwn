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
command_kamera_Impl(playerid, params[256])
{
    if(PlayerInfo[playerid][pRank] >= 6 && IsAClubBusinessOwner(playerid) && IsPlayerInRangeOfPoint(playerid, 50.0, 1896.3619,-2445.5969,18.5559) && GetPlayerVirtualWorld(playerid) == 1) //RANGA
	{
		if(GetPVarInt(playerid, "IbizaKamery")) return sendTipMessageEx(playerid, 0xB52E2BFF, "Korzystasz ju¿ z kamer");
		new Float:x, Float:y, Float:z;
		SetPVarInt(playerid, "IbizaKamery", 1);
		GetPlayerPos(playerid, x, y, z);
		SetPVarFloat(playerid, "IbizaKameraX", x);
		SetPVarFloat(playerid, "IbizaKameraY", y);
		SetPVarFloat(playerid, "IbizaKameraZ", z);
		GetDynamicObjectPos(IbizaKameryObiekty[0], x, y, z);
		SetPlayerCameraPos(playerid, x, y, z);
		SetPlayerCameraLookAt(playerid, IbizaKameryLA[0][0], IbizaKameryLA[0][1], IbizaKameryLA[0][2]);
		TogglePlayerControllable(playerid, false);
		SetPlayerVirtualWorld(playerid, IbizaKameryVW[0]);
		new dd,mm,rr, g,m,s, string[64];
		gettime(g,m,s); getdate(rr,mm,dd);
		format(string, sizeof string, "%02d/%02d/%d  %02d:%02d", dd, mm, rr, g,m);
		TextDrawSetString(TDIbiza[0], string);
		for(new i; i<3; i++)
		{
			TextDrawShowForPlayer(playerid, TDIbiza[i]);
		}
		new PlayerText:td = CreatePlayerTextDraw(playerid, 24.500000, 395.000000, "CAM 01");
		PlayerTextDrawFont(playerid, td, 1);
		PlayerTextDrawLetterSize(playerid, td, 0.800000, 3.500000);
		PlayerTextDrawColor(playerid, td, 0xFFFFFFFF);
		PlayerTextDrawSetOutline(playerid, td, 1);
		PlayerTextDrawShow(playerid, td);
		SetPVarInt(playerid, "IbizaCam", int:td);
		SelectTextDraw(playerid, 0x00FF00FF);
	}
	return 1;
}

//end
