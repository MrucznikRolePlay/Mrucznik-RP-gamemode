//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   03DL                                                    //
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
// Autor: Simeone 
// Data utworzenia: 27-07-2019
//Opis:
/*

*/

//

//-----------------<[ Callbacki: ]>-------------------
//-----------------<[ Funkcje: ]>-------------------
stock SetPlayerSkinEx(playerid, value)
{
	/*if(value > 20032)
	{
		sendErrorMessage(playerid, "B³êdny zwrot na PlayerSkin"); 
		return 1;
	}
	if(value >= 400 && value < 20000)
	{
		//SetPlayerSkin(playerid, value+19601); 
		SetSpawnInfo(playerid, PlayerInfo[playerid][pTeam], value, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z], 0.0, -1, -1, -1, -1, -1, -1);
	}
	else
	{*/
	SetPlayerSkin(playerid, value); 
	
	return 1;
}
stock skinIsLegally(skinID)
{
	//SKINY SAMP
	if(skinID == 1 || skinID == 2)
	{
		return true;
	}
	else if(skinID >= 10 && skinID < 40)
	{
		return true;
	}
	else if(skinID == 41 || skinID == 43 || skinID == 44 || skinID == 45)
	{
		return true;
	}
	else if(skinID >= 49 && skinID < 57)
	{
		return true;
	}
	else  if(skinID == 58 || skinID == 62 || skinID == 63 || skinID == 64)
	{
		return true;
	}
	else if(skinID >= 66 && skinID <= 69)
	{
		return true;
	}
	else if(skinID == 72 || skinID == 73 || (skinID >= 75 && skinID <= 85))
	{
		return true;
	}
	else if(skinID >= 87 && skinID <= 97)
	{
		return true;
	}
	else if(skinID == 99 || skinID == 254 || skinID == 264 || (skinID >= 128 && skinID <= 132) || (skinID >= 134 && skinID <= 140))
	{
		return true;
	}
	else if((skinID >= 142 && skinID <= 146) || (skinID >= 151 && skinID <= 162) || skinID == 167 || skinID ==168 || skinID ==170)
	{
		return true;
	}
	else if(skinID == 172 || skinID == 176 || (skinID >= 178 && skinID <= 185))
	{
		return true;
	}
	else if(skinID >= 193 && skinID <= 201 || skinID == 167 || (skinID >= 203 && skinID <= 205))
	{
		return true;
	}
	else if(skinID == 155 || skinID == 207 || (skinID >= 209 && skinID <= 210) || (skinID >= 212 && skinID <= 213))
	{
		return true;
	}
	else if(skinID == 215 || skinID == 216 || (skinID >= 218 && skinID <= 226) || skinID == 174 || skinID == 175 || skinID == 173)
	{
		return true;
	}
	else if((skinID >= 229 && skinID <= 233) || (skinID >= 235 && skinID <= 239) || (skinID >= 241 && skinID <= 246))
	{
		return true;
	} 
	else if(skinID == 249 || (skinID >= 251 && skinID <= 253) || (skinID >= 255 && skinID <= 263) || skinID == 256 || skinID == 100 || skinID == 248 || skinID == 247)
	{
		return true;
	}
	
	return false;
}
//-----------------<[ Timery: ]>-------------------
//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end