//----------------------------------------------<< Callbacks >>----------------------------------------------//
//                                                    sila                                                   //
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
// Data utworzenia: 04.05.2019
//Opis:
/*
	System siÅ‚y.
*/

//

#include <YSI\y_hooks>

//-----------------<[ Callbacki: ]>-----------------
Sila_OnPlayerEnterCheckpoint(playerid)
{
	if(GetPVarInt(playerid, "RozpoczalBieg") == 1)
	{
		if(GetPVarInt(playerid, "WybralBieg") == 1)
		{
			if(OszukujewBiegu[playerid] == 0)
			{
				if(GetPVarInt(playerid, "ZaliczylBaze") == 0)
				{
					CreateNewRunCheckPoint(playerid, 1709.3523,-1461.3938,13.5469, 3, "Zaliczy³eœ pierwszy przystanek, kolejny jest ju¿ oznaczony!", 0, true);
				}
				if(GetPVarInt(playerid, "ZaliczylBaze") == 1)
				{
					CreateNewRunCheckPoint(playerid, 1707.8762,-1584.3118,13.5453, 3, "Zaliczy³eœ drugi przystanek, kolejny jest ju¿ oznaczony!", 0, true); 
				}
				if(GetPVarInt(playerid, "ZaliczylBaze") == 2)
				{
					CreateNewRunCheckPoint(playerid, 1625.7415,-1608.9004,13.7188, 3, "Zaliczy³eœ trzeci przystanek, kolejny jest ju¿ oznaczony!", 5,true); 
				}
				if(GetPVarInt(playerid, "ZaliczylBaze") == 3)
				{
					CreateNewRunCheckPoint(playerid, 1538.9513,-1724.1267,13.5469, 3, "Zaliczy³eœ czwarty przystanek, kolejny jest ju¿ oznaczony!", 0, true); 
				}
				if(GetPVarInt(playerid, "ZaliczylBaze") == 4)
				{
					CreateNewRunCheckPoint(playerid, 1322.6306,-1724.9469,13.5469, 3, "Zaliczy³eœ pi¹ty przystanek, kolejny jest ju¿ oznaczony!", 0, true); 
				}
				if(GetPVarInt(playerid, "ZaliczylBaze") == 5)
				{
					CreateNewRunCheckPoint(playerid, 1318.4052,-1841.7726,13.5469, 3, "Zaliczy³eœ szósty przystanek, kolejny jest ju¿ oznaczony!", 0, true); 
				}
				if(GetPVarInt(playerid, "ZaliczylBaze") == 6)
				{
					CreateNewRunCheckPoint(playerid,  1382.2340,-1811.7761,13.5469, 3, "Zaliczy³eœ siódmy (przedostatni) przystanek, kolejny jest ju¿ oznaczony!", 0, true); 
				}
				if(GetPVarInt(playerid, "ZaliczylBaze") == 7)//Ostatni
				{
					EndRunPlayer(playerid, 10);
				}
			}
			else
			{
				sendTipMessageEx(playerid, COLOR_RED, "WYKRYTO OSZUSTWO! TWÓJ BIEG ZOSTAJE PRZERWANY"); 
				DisablePlayerCheckpoint(playerid);
				SetPVarInt(playerid, "ZaliczylBaze", 0);
				SetPVarInt(playerid, "WybralBieg", 0);
				SetPVarInt(playerid, "RozpoczalBieg", 0);
			}
		}
		else if(GetPVarInt(playerid, "WybralBieg") == 2)
		{
			if(GetPVarInt(playerid, "ZaliczylBaze") == 0)
			{
				CreateNewRunCheckPoint(playerid,  535.0668,-1364.9790,15.8432, 2, "Zaliczy³eœ pierwszy checkpoint! Nastêpny zosta³ ju¿ oznaczony", 0, true); 
			}
			if(GetPVarInt(playerid, "ZaliczylBaze") == 1)
			{
				CreateNewRunCheckPoint(playerid,  339.2540,-1526.9476,33.3757, 2, "Zaliczy³eœ drugi checkpoint! Nastêpny zosta³ oznaczony", 0, true); 
			}
			if(GetPVarInt(playerid, "ZaliczylBaze") == 2)
			{
				CreateNewRunCheckPoint(playerid,  317.4830,-1632.8326,33.3125, 2, "Zaliczy³eœ trzeci checkpoint! Nastêpny zosta³ oznaczony, a ty siê nie poddajesz!", 5, true); 
			}
			if(GetPVarInt(playerid, "ZaliczylBaze") == 3)
			{
				CreateNewRunCheckPoint(playerid,  364.1078,-1805.8809,7.8380, 2, "Zaliczy³eœ czwarty checkpoint! Pi¹ty jest ju¿ oznaczony!", 0, true); 
			}
			if(GetPVarInt(playerid, "ZaliczylBaze") == 4)
			{
				CreateNewRunCheckPoint(playerid,  664.4612,-1859.3246,5.4609, 2, "Zaliczy³eœ Pi¹ty checkpoint! Zosta³y jeszcze dwa!", 5, true); 
			}
			if(GetPVarInt(playerid, "ZaliczylBaze") == 5)
			{
				CreateNewRunCheckPoint(playerid,  966.9481,-1834.9043,12.6000, 2, "Szósty przystanek zaliczony! Biegnij do kolejnego", 0, true); 

			}
			if(GetPVarInt(playerid, "ZaliczylBaze") == 6)
			{
				CreateNewRunCheckPoint(playerid,  1000.8669,-1857.4419,12.8146, 2, "Zaliczy³eœ siódmy checkpoint! Ju¿ widaæ ostatni", 5, true); 
			}
			if(GetPVarInt(playerid, "ZaliczylBaze") == 7)//Ostatni
			{
				EndRunPlayer(playerid, 5);
			}
		}
		else//Jeœli wybra³ dialog do pokazania punktu startowego trasy
		{
			DisablePlayerCheckpoint(playerid);
			sendTipMessageEx(playerid, COLOR_P@, "Aby rozpocz¹æ bieg wpisz w tym miejscu [/biegnij]"); 
			SetPVarInt(playerid, "RozpoczalBieg", 0);
		}
		return 1;
	}
	return 0; // continue
}

//end