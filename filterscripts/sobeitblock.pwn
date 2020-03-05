#include <a_samp>
#include <foreach>

#define OznaczCzitera(%0) CallRemoteFunction("OznaczCzitera","i", %0)
 
native SendClientCheck(clientid, actionid, arg1= 0x00000000, arg2= 0x0000, bytes= 0x0004); // int32, int8, int32, int16, int16
forward OnClientCheckResponse(clientid, actionid, checksum, crc);
 
new
	bool: pPlayerSpawned[MAX_PLAYERS] = false, // blokada przed timerem CheckSobeitPlayers jeœli gracz siê nie zespawnowa³
	bool: pHaveSobeit[MAX_PLAYERS] = false, // czy znalaz³o soba
	bool: pAFKK[MAX_PLAYERS] = false;

new pCountCheck[MAX_PLAYERS]; // maksymalna iloœæ sprawdzeñ soba (timer Check, max. 3 próby)

new File:fSobeitLog;
new fSobeitBuff;
new string[256];

public OnFilterScriptInit()
{
	new y, m, d;
	getdate(y, m, d);
	format(string, 64, "sobeitlog/%d_%d_%d.txt", y, m, d);
	fSobeitLog = fopen(string, io_append);

	SetTimer("CheckSobeitPlayers", 10000, true);
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	SendClientCheck(playerid, 0x47);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	pHaveSobeit[playerid]    = false;
	pPlayerSpawned[playerid] = false;
	if(pAFKK[playerid]) pAFKK[playerid] = false;
	return 1;
}

public OnPlayerSpawn(playerid)
{
	/*
	Tutaj trzeba wykonaæ ponowne sprawdzenie akcji, poniewa¿ po do³¹czniu do serwera i wy³¹czeniem
	sobieta klawiszem F12 przed wykonaniem OnPlayerConnect i SendClientCheck w nim zawartym OnClientCheckResponse
	omija sprawdzanie. Mo¿na go te¿ omin¹æ poprzez wykonywanie siê tego callbacka (o ile jest ktoœ kumaty i ma trochê wiedzy na tematy)*/

	SendClientCheck(playerid, 0x47); // musi byæ ze wzglêdu, ¿e w timerze nie wy³apuje zazwyczaj w checksumie 30 i nie ³apie sobieta tylko w onplayerspawn (reszty nie sprawdza³em)
	pPlayerSpawned[playerid] = true;
	return 1;
}
 
public OnClientCheckResponse(clientid, actionid, checksum, crc)
{
	switch(actionid)
	{
        case 0x47: SendClientCheck(clientid, 0x02);
        case 0x02:
        {
			if(pAFKK[clientid]) pAFKK[clientid] = false;

			if(checksum & 0x00ff0000 == 0x00300000)
			{
				pHaveSobeit[clientid] = true;
				pCountCheck[clientid] = 0;
				OznaczCzitera(clientid);
				//kickPlayerForSobeit(clientid, 1);
				
			}
			else if(checksum & 0x00ff0000 == 0x00CC0000)
			{
				pHaveSobeit[clientid] = true;
				pCountCheck[clientid] = 0;
				OznaczCzitera(clientid);
				//kickPlayerForSobeit(clientid, 2);
			}
			else if(checksum & 0x00ff0000 == 0x00FC0000)
			{
				pCountCheck[clientid] = 0;
				pAFKK[clientid] = true;
			}
			else
			{
				SetTimerEx("Check", 1000, false, "d", clientid);// timer jest dlatego, ¿e pierwsze wykonanie akcji za poœrednictwem onplayerconnect nie jest prawdziwe i bezu¿yteczne, dla pewnoœci robiê prawdziwe 3 próby
			}
        }
	}

	//printf("clientid: %d, actionid: 0x%02x, checksum: 0x%08x, crc: %d", clientid,actionid,checksum,crc);    
}

forward Check(playerid);
public Check(playerid)
{
	if(!pHaveSobeit[playerid])
	{
			if(pCountCheck[playerid] < 3) // tak na prawdê wykonaj¹ siê 4 próby sprawdzenia, lecz pierwsza próba jest bezu¿yteczna i jej nie uwzglêdniam, kolejne wyniki s¹ prawid³owe                                                            
			{
				SendClientCheck(playerid, 0x02); // ponowne wywo³anie akcji 0x02 w celu ponownego sprawdzenia
				pCountCheck[playerid] ++; // inkrementacja zmiennej (iloœci sprawdzeñ soba)
			}
			else pCountCheck[playerid] = 0;
	}
	return 1;
}

forward CheckSobeitPlayers();
public CheckSobeitPlayers()
{
	foreach(new i : Player)
	{
			pCountCheck[i] = 0;
			SendClientCheck(i, 0x02);
	}
	return 1;
}

stock GetNick(playerid)
{
	new nick[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nick, sizeof(nick));
	return nick;
}

stock GetNickEx(playerid, withmask = false)
{
	new nick[MAX_PLAYER_NAME];
 	GetPlayerName(playerid, nick, sizeof(nick));
	if(withmask)
	{
		return nick;
	}
	else
	{
		new nick2[24];
		if(GetPVarString(playerid, "maska_nick", nick2, 24))
		{
			return nick2;
		}
	}
	return nick;
}

stock GetIp(playerid)
{
	new ip[16];
	GetPlayerIp(playerid, ip, sizeof(ip));
	return ip;
}

stock kickPlayerForSobeit(playerid, reason)
{
	switch(reason)
	{
		case 1:
		{
			SendClientMessage(playerid, -1, "{FF0000} Wykryto niedozwolone programy, zostajesz wyrzucony.");

			format(string, 256, "Gracz %s IP (%s) zostal wyrzucony przez AC. Powod: Sobeit", GetNickEx(playerid), GetIp(playerid));
			AddPlayerToLog(string);
		}
		case 2:
		{
			SendClientMessage(playerid, -1, "{FF0000} Wykryto niedozwolone programy, zostajesz wyrzucony.");
			
			format(string, 256, "Gracz %s IP (%s) zostal wyrzucony przez AC. Powod: Health Hack", GetNickEx(playerid), GetIp(playerid));
			AddPlayerToLog(string);
		}
	}

	SetTimerEx("kickPlayer", 1000, false, "d", playerid);
	return 1;
}

forward kickPlayer(playerid);
public kickPlayer(playerid)
{
	Kick(playerid);
	return 1;
}

stock AddPlayerToLog(str[])
{
	static datehours[6];
	getdate(datehours[0], datehours[1], datehours[2]);
	gettime(datehours[3], datehours[4], datehours[5]);

	format(string, 256, "%02d:%02d:%02d %s\r\n", datehours[3], datehours[4], datehours[5], str);
	fwrite(fSobeitLog, string);
	if(++fSobeitBuff > 10)
	{
		fSobeitBuff = 0;
		fclose(fSobeitLog);
		format(string, 64, "sobeitlog/%d_%d_%d.txt", datehours[2], datehours[1], datehours[0]);
		fSobeitLog = fopen(string, io_append);
	}
}