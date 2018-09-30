CMD:ooc(playerid, params[]) return cmd_o(playerid, params);
CMD:o(playerid, params[])
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(gPlayerLogged[playerid] == 0)
        {
            return 1;
        }
		if ((noooc) && PlayerInfo[playerid][pAdmin] < 1)
		{
		    if(PlayerInfo[playerid][pNewAP] < 1)
		    {
		        if(PlayerInfo[playerid][pZG] < 5)
		        {
				    if(PlayerInfo[playerid][pDonateRank] < 3)
				    {
						sendErrorMessage(playerid, "Kana³ OOC zosta³ zablokowany przez administratora !");
						return 1;
					}
				}
			}
		}
		if(PlayerInfo[playerid][pMuted] == 1)
		{
			sendTipMessage(playerid, "Nie mo¿esz mówiæ gdy¿ zosta³eœ uciszony!", TEAM_CYAN_COLOR);
			return 1;
		}
		if(PlayerInfo[playerid][pBP] >= 1)
		{
		    format(string, sizeof(string), "Nie mo¿esz napisaæ na tym czacie, gdy¿ masz zakaz pisania na globalnych czatach! Minie on za %d godzin.", PlayerInfo[playerid][pBP]);
			sendTipMessage(playerid, string, TEAM_CYAN_COLOR);
			return 1;
		}
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj (/o)oc [ooc chat]");
			return 1;
		}
		if (strfind(params , "ip:" , true)>=0 ||strfind(params , "-roleplay" , true)>=0 || strfind(params , "Nicolson" , true)>=0 || strfind(params , "roleplay." , true)>=0  || strfind(params , " ip" , true)>=0 || strfind(params , "794" , true)>=0 || strfind(params , "772" , true)>=0 || strfind(params , "797" , true)>=0 || strfind(params , "795" , true)>=0 || strfind(params , "775" , true)>=0 || strfind(params , "91." , true)>=0 || strfind(params , "91," , true)>=0)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "NIE CHCEMY REKLAM!");
			format(string, 128, "AdmWarning: [%d] %s REKLAMA: %s.",playerid,sendername,params);
			ABroadCast(COLOR_LIGHTRED,string,1);
			CzitLog(string);
		}
		else if (strfind(params , "kurwa" , true)>=0 ||strfind(params , "huj" , true)>=0 || strfind(params , "pizda" , true)>=0 || strfind(params , "cipa" , true)>=0  || strfind(params , "n00b" , true)>=0 || strfind(params , "noob" , true)>=0 || strfind(params , "pierdole" , true)>=0 || strfind(params , "debil" , true)>=0 || strfind(params , "fiut" , true)>=0 || strfind(params , "kutas" , true)>=0 || strfind(params , "jeb" , true)>=0 || strfind(params , "ssij" , true)>=0)
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Oka¿ trochê kultury na kanale OOC! Nie przeklinaj.");
			format(string, 128, "AdmWarning: [%d] %s Przeklina: %s.",playerid,sendername,params);
			ABroadCast(COLOR_LIGHTRED,string,1);
			WarningLog(string);
		}
		else if (strfind(params , ":1" , true)>=0 || strfind(params , ":2" , true)>=0 || strfind(params , ":7" , true)>=0 || strfind(params , ":4" , true)>=0 || strfind(params , ":5" , true)>=0 || strfind(params , ":6" , true)>=0 || strfind(params , ":8" , true)>=0 || strfind(params , ":9" , true)>=0)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "NIE CHCEMY REKLAM!");
			format(string, 128, "AdmWarning: [%d] %s REKLAMA: %s.",playerid,sendername,params);
			ABroadCast(COLOR_LIGHTRED,string,1);
			CzitLog(string);
		}
		else
		{

			format(string, sizeof(string), "(( %s [%d]: %s ))", sendername, playerid, params);
			OOCOff(COLOR_OOC,string);
			printf("%s", string);
		}
	}
	return 1;
}

CMD:dopasuj(playerid, params[])
{
	new type[24];
    if(sscanf(params, "s[24]", type)) {
        return sendTipMessage(playerid, "Dostepne /dopasuj: kamizelke");
    }
    if(!strcmp(type, "kamizelke", true))
    {
    	new Float:armor;
    	GetPlayerArmour(playerid, armor);
    	if(armor < 1.0) return 1;
		//RemovePlayerAttachedObject(playerid, 7);
		SetPlayerAttachedObject(playerid, 7, 19142, 1, GetPVarFloat(playerid, "k_offsetX"), GetPVarFloat(playerid, "k_offsetY"), GetPVarFloat(playerid, "k_offsetZ"), GetPVarFloat(playerid, "k_rotX"), GetPVarFloat(playerid, "k_rotY"), GetPVarFloat(playerid, "k_rotZ"), GetPVarFloat(playerid, "k_scaleX"), GetPVarFloat(playerid, "k_scaleY"), GetPVarFloat(playerid, "k_scaleZ"));
    	EditAttachedObject(playerid, 7);
    }
    return 1;
}

CMD:przejazd(playerid, params[]) {
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
					if(IsACop(playerid) && OnDuty[playerid] == 1)
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


forward closeGate(i, j, playerid);
public closeGate(i, j, playerid)
{
    bramki_sasd_state[i] = false;
    SetPVarInt(playerid, "wybramkowany", 0);
    bramy[j][b_flaga] = true;
    MoveDynamicObject(bramy[j][b_obiekt], bramy[j][b_x2],  bramy[j][b_y2], bramy[j][b_z2], bramy[j][b_speed], bramy[j][b_rx2],  bramy[j][b_ry2], bramy[j][b_rz2]);
    return 1;
}
