//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ przebierz ]-----------------------------------------------//
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

YCMD:przebierz(playerid, params[], help)
{
    if(IsPlayerInRangeOfPoint(playerid, 2.5, 1212.3590,-1796.6627,70.0682) || IsPlayerInRangeOfPoint(playerid, 2.5, 1211.8776,-1803.4086,70.0682) || IsPlayerInRangeOfPoint(playerid, 2.5, 1222.4368,-1803.4390,70.0682))
    {
        if(Kredyty[playerid] >= 5)
        {
		    if(PlayerInfo[playerid][pGender] == 1)
		    {
		        new rand = random(5);
		        if(rand == 1)
				{
					SetPlayerSkin(playerid, 97);
				}
				else if(rand == 2)
				{
					SetPlayerSkin(playerid, 45);
				}
				else if(rand == 3)
				{
					SetPlayerSkin(playerid, 18);
				}
				else if(rand == 4)
				{
					SetPlayerSkin(playerid, 146);
				}
				else if(rand == 5)
				{
					SetPlayerSkin(playerid, 154);
				}
		    }
		    else
		    {
				new rand = random(6);
				if(rand == 1)
				{
					SetPlayerSkin(playerid, 138);
				}
				else if(rand == 2)
				{
					SetPlayerSkin(playerid, 139);
				}
				else if(rand == 3)
				{
					SetPlayerSkin(playerid, 140);
				}
				else if(rand == 4)
				{
					SetPlayerSkin(playerid, 145);
				}
				else if(rand == 5)
				{
					SetPlayerSkin(playerid, 251);
				}
				else if(rand == 6)
				{
					SetPlayerSkin(playerid, 92);
				}
		    }
			new string[128];
		    Kredyty[playerid] -= 50;
			sendTipMessage(playerid, "Pobrano 50 kredytów za szafkê!"); 
			format(string, sizeof(string), "Aktualny stan kredytów to %d", Kredyty[playerid]);
			sendTipMessage(playerid, string);
		}
		else
		{
			sendTipMessageEx(playerid, COLOR_GREY, "Nie masz wystarczaj¹cej iloœci kredytów.");
		    return 1;
		}
	}
    if(GetPlayerOrg(playerid) == FAMILY_FDU)
    {
        if(IsPlayerInRangeOfPoint(playerid, 10.0, 1102.9858, -1227.3788, 14.8155)) ShowPlayerDialogEx(playerid, D_PRZEBIERZ_FDU, DIALOG_STYLE_LIST, "{FFFFFF}Uniform rodziny » Wybierz ubranie", "{C0FF9C}Kobieta w czerwonej sukience\n{C0FF9C}Mechanik\n{C0FF9C}Kobieta w czarnej bluzce\n{C0FF9C}Ryder\n{C0FF9C}Ziomek z niebiesk¹ CapBack\n{C0FF9C}Japoñczyk z czarn¹ chust¹\n{C0FF9C}Sweet", "Ubierz", "Anuluj");
    }
	return 1;
}
