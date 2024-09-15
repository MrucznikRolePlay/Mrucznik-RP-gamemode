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
command_przejazd_Impl(playerid)
{
    if(!gPlayerLogged[playerid]) return sendErrorMessage(playerid, "Nope!");
	if(GetPVarInt(playerid, "wybramkowany") == 1) return sendErrorMessage(playerid, "Poczekaj na zamkniêcie siê poprzedniej bramki!");
	for(new i; i < sizeof(bramki_sasd); i++)
	{
		new Float:x,Float:y,Float:z;
		GetDynamicObjectPos(bramki_sasd[i], x, y, z);
		if(IsPlayerInRangeOfPoint(playerid, 7.4, x,y,z))
		{
			if(bramki_sasd_state[i] == true) return sendErrorMessage(playerid, "Ta bramka jest aktualnie w u¿yciu");
			for(new j; j<iloscbram; j++)
			{
				if(bramy[j][b_obiekt] == bramki_sasd[i])
				{
					MoveDynamicObject(bramy[j][b_obiekt], bramy[j][b_x1],  bramy[j][b_y1], bramy[j][b_z1], bramy[j][b_speed], bramy[j][b_rx1],  bramy[j][b_ry1], bramy[j][b_rz1]);
					bramy[j][b_flaga] = false;
					SetTimerEx("closeGate", 5000, false, "iii", i, j, playerid);
					bramki_sasd_state[i] = true;
					if(IsAPolicja(playerid) && OnDuty[playerid] == 1)
					{
						sendTipMessage(playerid, "Jesteœ funkcjonariuszem na s³u¿bie. Twój przejazd jest darmowy!");
					}
					else
					{
						ZabierzKase(playerid, 1750);
						Sejf_Add(FRAC_NG, 1750);
					}
					bramy[j][b_flaga] = false;
					SetPVarInt(playerid, "wybramkowany", 1);
					return showTimedMsgBox(playerid, 6, "~y~~h~Oplata pobrana~n~~y~~h~Masz~r~ 5s ~n~~y~~h~na przejazd");
				}
			}
		}
	}
	return 1;
}

//end
