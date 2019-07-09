//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   budki                                                   //
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
// Autor: 2.5
// Data utworzenia: 04.05.2019
//Opis:
/*
	System tworzenia budek telefonicznych.
*/

//

//-----------------<[ Callbacki: ]>-------------------
//-----------------<[ Funkcje: ]>-------------------
dodajBudke(fobiekt, Float:x, Float:y, Float:z, Float: rx, Float:ry, Float: rz)
{
	#pragma unused x,y,z,rx,ry,rz,fobiekt
	budki[iloscbudek][b_model] = fobiekt;
	budki[iloscbudek][b_x] = x;
	budki[iloscbudek][b_y] = y;
	budki[iloscbudek][b_z] = z;
	budki[iloscbudek][b_rx] = rx;
	budki[iloscbudek][b_ry] = ry;
	budki[iloscbudek][b_rz] = rz;
	budki[iloscbudek][b_Id] = CreateDynamicObject(fobiekt, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz); 
	return iloscbudek++;
}
/*
jestObokBudki(playerid)
{
	for(new i; i<iloscbudek; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.5, budki[i][b_x],  budki[i][b_y], budki[i][b_z]))
		{
			return i;
		}
	}
	return 0;
}
*/

//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end