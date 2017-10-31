// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT

#include <a_samp>
	#undef MAX_PLAYERS
	#define MAX_PLAYERS    	30      //Server slots
	//About pools introduced in 0.3.7
	//They are for perfect for loops (foreach vorks in similar way)
	//but we still need MAX_PLAYERS to allocate memory.

#include <crashdetect>
#include <double-o-files2>
#include <DJson>

AntiDeAMX()
{
	new a[][] =
	{
		"Unarmed (Fist)",
		"Brass K"
	};
	#pragma unused a
}


#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
    AntiDeAMX();
	print("\n--------------------------------------");
	print(" Blank Filterscript by your name here");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print(" Blank Gamemode by your name here");
	print("----------------------------------\n");
}

#endif

enum hIntInfo
{
	Float:Int_X,
	Float:Int_Y,
	Float:Int_Z,
	Int,
	Pokoje,
	Kategoria,
	Cena,
};

new IntInfo[100][hIntInfo];

LadujInteriory()
{
	//kategoria 1
    IntInfo[1][Int_X] = 244.5000;//dom 1
    IntInfo[1][Int_Y] = 305.0000;
    IntInfo[1][Int_Z] = 999.1484;
    IntInfo[1][Int] = 1;
    IntInfo[1][Kategoria] = 1;
    IntInfo[1][Pokoje] = 1;
    IntInfo[1][Cena] = 500000;
    IntInfo[2][Int_X] = 301.3000;//dom 2
    IntInfo[2][Int_Y] = 306.3000;
    IntInfo[2][Int_Z] = 1003.5391;
    IntInfo[2][Int] = 4;
    IntInfo[2][Kategoria] = 1;
    IntInfo[2][Pokoje] = 2;
    IntInfo[2][Cena] = 535000;
    IntInfo[3][Int_X] = 344.83898925781;//dom 3
    IntInfo[3][Int_Y] = 305.42208862305;
    IntInfo[3][Int_Z] = 999.1484375;
    IntInfo[3][Int] = 6;
    IntInfo[3][Kategoria] = 1;
    IntInfo[3][Pokoje] = 1;
    IntInfo[3][Cena] = 250000;
    IntInfo[4][Int_X] = -68.816932678223;//dom 4
    IntInfo[4][Int_Y] = 1354.1055908203;
    IntInfo[4][Int_Z] = 1080.2109375;
    IntInfo[4][Int] = 6;
    IntInfo[4][Kategoria] = 1;
    IntInfo[4][Pokoje] = 3;
    IntInfo[4][Cena] = 2500000;
    IntInfo[5][Int_X] = 2333.1157226563;//dom 5
    IntInfo[5][Int_Y] = -1074.7203369141;
    IntInfo[5][Int_Z] = 1049.0234375;
    IntInfo[5][Int] = 6;
    IntInfo[5][Kategoria] = 1;
    IntInfo[5][Pokoje] = 2;
    IntInfo[5][Cena] = 2000000;
    IntInfo[6][Int_X] = 1207.6346435547;//dom 6 DOMEK Z MUZYCZKĄ
    IntInfo[6][Int_Y] = -42.482707977295;
    IntInfo[6][Int_Z] = 1000.953125;
    IntInfo[6][Int] = 3;
    IntInfo[6][Kategoria] = 1;
    IntInfo[6][Pokoje] = 1;
    IntInfo[6][Cena] = 250000;
    //kategoria 2
    IntInfo[7][Int_X] = 267.1000;//dom 7 MALY JASNY DOMEK
    IntInfo[7][Int_Y] = 305.0000;
    IntInfo[7][Int_Z] = 999.1484;
    IntInfo[7][Int] = 2;
    IntInfo[7][Kategoria] = 2;
    IntInfo[7][Pokoje] = 1;
    IntInfo[7][Cena] = 500000;
    //loled
    /*IntInfo[8][Int_X] = -42.8151;//dom 8
    IntInfo[8][Int_Y] = 1408.4419;
    IntInfo[8][Int_Z] = 1084.4297;
    IntInfo[8][Int] = 8;
    IntInfo[8][Kategoria] = 1;
    IntInfo[8][Pokoje] = 3;
	IntInfo[8][Cena] = 2500000;*/
	//loled
    IntInfo[9][Int_X] = 2467.2964;//dom 9
    IntInfo[9][Int_Y] = -1698.1704;
    IntInfo[9][Int_Z] = 1013.5078;
    IntInfo[9][Int] = 2;
    IntInfo[9][Kategoria] = 2;
    IntInfo[9][Pokoje] = 3;
    IntInfo[9][Cena] = 2000000;
    IntInfo[10][Int_X] = 221.6465;//dom 10
    IntInfo[10][Int_Y] = 1148.6022;
    IntInfo[10][Int_Z] = 1082.6094;
    IntInfo[10][Int] = 4;
    IntInfo[10][Kategoria] = 2;
    IntInfo[10][Pokoje] = 3;
    IntInfo[10][Cena] = 1800000;
    IntInfo[11][Int_X] = 2254.3000;//dom 11 bug
    IntInfo[11][Int_Y] = -1140.0000;
    IntInfo[11][Int_Z] = 1050.6328;
    IntInfo[11][Int] = 9;
    IntInfo[11][Kategoria] = 2;
    IntInfo[11][Pokoje] = 3;
    IntInfo[11][Cena] = 2000000;
    IntInfo[12][Int_X] = 2261.3000;//dom 12
    IntInfo[12][Int_Y] = -1135.9000;
    IntInfo[12][Int_Z] = 1050.63280;
    IntInfo[12][Int] = 10;
    IntInfo[12][Kategoria] = 2;
    IntInfo[12][Pokoje] = 3;
    IntInfo[12][Cena] = 2000000;
    IntInfo[13][Int_X] = -42.796955108643;//dom 13 taki sam jak 8
    IntInfo[13][Int_Y] = 1407.6802978516;
    IntInfo[13][Int_Z] = 1084.4296875;
    IntInfo[13][Int] = 8;
    IntInfo[13][Kategoria] = 2;
    IntInfo[13][Pokoje] = 3;
    IntInfo[13][Cena] = 2000000;
    //loled
    /*IntInfo[14][Int_X] = -285.69171142578;//dom 14
    IntInfo[14][Int_Y] = 1471.2047119141;
    IntInfo[14][Int_Z] = 1084.3755;
    IntInfo[14][Int] = 15;
    IntInfo[14][Kategoria] = 2;
    IntInfo[14][Pokoje] = 4;
	IntInfo[14][Cena] = 1250000;*/
	//loled
    IntInfo[15][Int_X] = 2308.8254394531;//dom 15
    IntInfo[15][Int_Y] = -1211.2672119141;
    IntInfo[15][Int_Z] = 1049.0234375;
    IntInfo[15][Int] = 6;
    IntInfo[15][Kategoria] = 2;
    IntInfo[15][Pokoje] = 2;
    IntInfo[15][Cena] = 750000;
    IntInfo[16][Int_X] = 2216.4047851563;//dom 16
    IntInfo[16][Int_Y] = -1076.3693847656;
    IntInfo[16][Int_Z] = 1050.484375;
    IntInfo[16][Int] = 1;
    IntInfo[16][Kategoria] = 2;
    IntInfo[16][Pokoje] = 2;
    IntInfo[16][Cena] = 750000;
    IntInfo[17][Int_X] = 2283.1279296875;//dom 17
    IntInfo[17][Int_Y] = -1138.7651367188;
    IntInfo[17][Int_Z] = 1050.89843751;
    IntInfo[17][Int] = 11;
    IntInfo[17][Kategoria] = 2;
    IntInfo[17][Pokoje] = 3;
    IntInfo[17][Cena] = 750000;
    IntInfo[18][Int_X] = 223.14936828613;//dom 18
    IntInfo[18][Int_Y] = 1287.5688476563;
    IntInfo[18][Int_Z] = 1082.140625;
    IntInfo[18][Int] = 1;
    IntInfo[18][Kategoria] = 2;
    IntInfo[18][Pokoje] = 4;
    IntInfo[18][Cena] = 2750000;
    IntInfo[19][Int_X] = 2233.7893066406;//dom 19
    IntInfo[19][Int_Y] = -1115.1715087891;
    IntInfo[19][Int_Z] = 1050.8828125;
    IntInfo[19][Int] = 5;
    IntInfo[19][Kategoria] = 2;
    IntInfo[19][Pokoje] = 1;
    IntInfo[19][Cena] = 1250000;
    IntInfo[20][Int_X] = 443.49890136719;//dom 20 bug
    IntInfo[20][Int_Y] = 509.49703979492;
    IntInfo[20][Int_Z] = 1001.41949462892;
    IntInfo[20][Int] = 12;
    IntInfo[20][Kategoria] = 2;
    IntInfo[20][Pokoje] = 2;
    IntInfo[20][Cena] = 2500000;
    //kategoria 3
    IntInfo[21][Int_X] = 385.5547;//dom 21
    IntInfo[21][Int_Y] = 1471.6407;
    IntInfo[21][Int_Z] = 1080.1949;
    IntInfo[21][Int] = 15;
    IntInfo[21][Kategoria] = 3;
    IntInfo[21][Pokoje] = 3;
    IntInfo[21][Cena] = 7000000;
    IntInfo[22][Int_X] = 261.8072;//dom 22
    IntInfo[22][Int_Y] = 1241.7100;
    IntInfo[22][Int_Z] = 1084.2578;
    IntInfo[22][Int] = 9;
    IntInfo[22][Kategoria] = 3;
    IntInfo[22][Pokoje] = 4;
    IntInfo[22][Cena] = 9000000;
    IntInfo[23][Int_X] = 23.7709;//dom 23 taki sam jak nizej
    IntInfo[23][Int_Y] = 1341.2079;
    IntInfo[23][Int_Z] = 1084.3750;
    IntInfo[23][Int] = 10;
    IntInfo[23][Kategoria] = 3;
    IntInfo[23][Pokoje] = 4;
    IntInfo[23][Cena] = 8000000;
    /*IntInfo[24][Int_X] = 23.7709;//dom 24 taki sam jak wyzej
    IntInfo[24][Int_Y] = 1341.2079;
    IntInfo[24][Int_Z] = 1084.375010;
    IntInfo[24][Int] = 10;
    IntInfo[24][Kategoria] = 3;
    IntInfo[24][Pokoje] = 4;
	IntInfo[24][Cena] = 7000000;*/
    IntInfo[25][Int_X] = 329.1805;//dom 25
    IntInfo[25][Int_Y] = 1478.9669;
    IntInfo[25][Int_Z] = 1084.437515;
    IntInfo[25][Int] = 15;
    IntInfo[25][Kategoria] = 3;
    IntInfo[25][Pokoje] = 5;
    IntInfo[25][Cena] = 7000000;
    IntInfo[26][Int_X] = 2807.6186523438;//dom 26
    IntInfo[26][Int_Y] = -1173.2073974609;
    IntInfo[26][Int_Z] = 1025.57031258;
    IntInfo[26][Int] = 8;
    IntInfo[26][Kategoria] = 3;
    IntInfo[26][Pokoje] = 3;
    IntInfo[26][Cena] = 7000000;
    IntInfo[27][Int_X] = 2237.5952148438;//dom 27
    IntInfo[27][Int_Y] = -1079.6644287109;
    IntInfo[27][Int_Z] = 1049.02343752;
    IntInfo[27][Int] = 2;
    IntInfo[27][Kategoria] = 3;
    IntInfo[27][Pokoje] = 3;
    IntInfo[27][Cena] = 7800000;
    IntInfo[28][Int_X] = 261.16397094727;//dom 28
    IntInfo[28][Int_Y] = 1286.0953369141;
    IntInfo[28][Int_Z] = 1080.25781254;
    IntInfo[28][Int] = 4;
    IntInfo[28][Kategoria] = 3;
    IntInfo[28][Pokoje] = 4;
    IntInfo[28][Cena] = 8000000;
    IntInfo[29][Int_X] = -262.10150146484;//dom 29
    IntInfo[29][Int_Y] = 1456.7391357422;
    IntInfo[29][Int_Z] = 1084.36718754;
    IntInfo[29][Int] = 4;
    IntInfo[29][Kategoria] = 3;
    IntInfo[29][Pokoje] = 3;
    IntInfo[29][Cena] = 6000000;
    //Kategoria 4 (apartamenty)
    IntInfo[30][Int_X] = 376.3023;//dom 30
    IntInfo[30][Int_Y] = 1417.1825;
    IntInfo[30][Int_Z] = 1081.3281;
    IntInfo[30][Int] = 15;
    IntInfo[30][Kategoria] = 4;
    IntInfo[30][Pokoje] = 4;
    IntInfo[30][Cena] = 12000000;
    IntInfo[31][Int_X] = 446.5189;//dom 31
    IntInfo[31][Int_Y] = 1399.3490;
    IntInfo[31][Int_Z] = 1084.3047;
    IntInfo[31][Int] = 2;
    IntInfo[31][Kategoria] = 4;
    IntInfo[31][Pokoje] = 5;
    IntInfo[31][Cena] = 18000000;
    IntInfo[32][Int_X] = 295.4799;//dom 32
    IntInfo[32][Int_Y] = 1473.8265;
    IntInfo[32][Int_Z] = 1080.2578;
    IntInfo[32][Int] = 15;
    IntInfo[32][Kategoria] = 4;
    IntInfo[32][Pokoje] = 5;
    IntInfo[32][Cena] = 15000000;
    /*IntInfo[33][Int_X] = 2365.0375976563;//dom 33 taki sam jak 36
    IntInfo[33][Int_Y] = -1132.5759277344;
    IntInfo[33][Int_Z] = 1050.875;
    IntInfo[33][Int] = 8;
    IntInfo[33][Kategoria] = 4;
    IntInfo[33][Pokoje] = 4;
	IntInfo[33][Cena] = 19000000;*/
    IntInfo[34][Int_X] = 2195.7058105469;//dom 34
    IntInfo[34][Int_Y] = -1204.3842773438;
    IntInfo[34][Int_Z] = 1049.0234375;
    IntInfo[34][Int] = 6;
    IntInfo[34][Kategoria] = 4;
    IntInfo[34][Pokoje] = 6;
    IntInfo[34][Cena] = 19000000;
    IntInfo[35][Int_X] = 2269.0183105469;//dom 35
    IntInfo[35][Int_Y] = -1210.4658203125;
    IntInfo[35][Int_Z] = 1047.5625;
    IntInfo[35][Int] = 10;
    IntInfo[35][Kategoria] = 4;
    IntInfo[35][Pokoje] = 4;
    IntInfo[35][Cena] = 20000000;
    IntInfo[36][Int_X] = 2365.2951660156;//dom 36 taki sam jak 33
    IntInfo[36][Int_Y] = -1134.3520507813;
    IntInfo[36][Int_Z] = 1050.8990478516;
    IntInfo[36][Int] = 8;
    IntInfo[36][Kategoria] = 4;
    IntInfo[36][Pokoje] = 4;
    IntInfo[36][Cena] = 15000000;
    //Kategoria 5 (Ville)
    IntInfo[37][Int_X] = 235.5197;//dom 37
    IntInfo[37][Int_Y] = 1188.7935;
    IntInfo[37][Int_Z] = 1080.2578;
    IntInfo[37][Int] = 3;
    IntInfo[37][Kategoria] = 5;
    IntInfo[37][Pokoje] = 6;
    IntInfo[37][Cena] = 16000000;
    IntInfo[38][Int_X] = 140.50755310059;//dom 38
    IntInfo[38][Int_Y] = 1368.2507324219;
    IntInfo[38][Int_Z] = 1083.8626708984;
    IntInfo[38][Int] = 5;
    IntInfo[38][Kategoria] = 5;
    IntInfo[38][Pokoje] = 5;
    IntInfo[38][Cena] = 30000000;
    IntInfo[39][Int_X] = 83.150199890137;//dom 39
    IntInfo[39][Int_Y] = 1324.0864257813;
    IntInfo[39][Int_Z] = 1083.859375;
    IntInfo[39][Int] = 9;
    IntInfo[39][Kategoria] = 5;
    IntInfo[39][Pokoje] = 6;
    IntInfo[39][Cena] = 25000000;
    IntInfo[40][Int_X] = 231.4000;//dom 42
    IntInfo[40][Int_Y] = 1114.1000;
    IntInfo[40][Int_Z] = 1080.9922;
    IntInfo[40][Int] = 5;
    IntInfo[40][Kategoria] = 5;
    IntInfo[40][Pokoje] = 8;
    IntInfo[40][Cena] = 22500000;
    IntInfo[41][Int_X] = 225.6000;//dom 43
    IntInfo[41][Int_Y] = 1023.5000;
    IntInfo[41][Int_Z] = 1084.0117;
    IntInfo[41][Int] = 7;
    IntInfo[41][Kategoria] = 5;
    IntInfo[41][Pokoje] = 9;
    IntInfo[41][Cena] = 35000000;
    IntInfo[42][Int_X] = 2324.3999;//dom 44
    IntInfo[42][Int_Y] = -1147.5000;
    IntInfo[42][Int_Z] = 1050.7101;
    IntInfo[42][Int] = 12;
    IntInfo[42][Kategoria] = 5;
    IntInfo[42][Pokoje] = 11;
    IntInfo[42][Cena] = 40000000;
    //Kategoria 6 (pałace)
    IntInfo[43][Int_X] = 1263.1934814453;//dom 43 MADD DOG kategoria 8
    IntInfo[43][Int_Y] = -785.47039794922;
    IntInfo[43][Int_Z] = 1091.90625;
    IntInfo[43][Int] = 5;
    IntInfo[43][Kategoria] = 6;
    IntInfo[43][Pokoje] = 15;
    IntInfo[43][Cena] = 100000000;
    IntInfo[44][Int_X] = 1298.8577880859;//dom 44 MADD DOGG kategoria 8
    IntInfo[44][Int_Y] = -794.06591796875;
    IntInfo[44][Int_Z] = 1084.0078125;
    IntInfo[44][Int] = 5;
    IntInfo[44][Kategoria] = 6;
    IntInfo[44][Pokoje] = 11;
    IntInfo[44][Cena] = 100000000;
    //Kategoria 7 (Inne)
    IntInfo[45][Int_X] = 744.2455;//dom 45 PORNODOM
    IntInfo[45][Int_Y] = 1437.2065;
    IntInfo[45][Int_Z] = 1102.7031;
    IntInfo[45][Int] = 6;
    IntInfo[45][Kategoria] = 7;
    IntInfo[45][Pokoje] = 4;
    IntInfo[45][Cena] = 10000000;
    IntInfo[46][Int_X] = 2526.3950;//dom 3 ZBUGOWANY PRZESWIT
    IntInfo[46][Int_Y] = -1679.4390;
    IntInfo[46][Int_Z] = 1015.498;
    IntInfo[46][Int] = 1;
    IntInfo[46][Kategoria] = 7;
    IntInfo[46][Pokoje] = 4;
    IntInfo[46][Cena] = 5000000;

    IntInfo[47][Int_X] = 0;//dla shawna
    IntInfo[47][Int_Y] = 0;
    IntInfo[47][Int_Z] = 0;
    IntInfo[47][Int] = 0;
    IntInfo[47][Kategoria] = 7;
    IntInfo[47][Pokoje] = 10;
    IntInfo[47][Cena] = 100000000;
    return 1;
}

public OnGameModeInit()
{

	djson_GameModeInit(); // <-- this must be called _before_ you can use any djson function!!

    AntiDeAMX();

	// Don't use these lines if it's a filterscript
	SetGameModeText("Blank Script");
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);

	LadujInteriory();

	new file[64], pos[200];
	new File:fhandle;
	new Float:X, Float:Y;

	/*for(new i; i<2000; i++)
	{
		format(file, sizeof file, "Domy/Dom%i.ini", i);

		if(dini_Exists(file))
		{
			// nice kurwa

			X = dini_Float(file, "Wej_X");
			Y = dini_Float(file, "Wej_Y");

			format(pos, sizeof pos, "%f,%f", X, Y);

			format(file, sizeof file, "domky/%d.dom", i);

			fhandle = fopen(file,io_write);

			fwrite(fhandle, pos);

			printf("gowno dupa sraka domek nr %d x %f y %f", i, X, Y);
		}
	} */

	new string[500];
	new typ;
	new cena;

	if(dini_Exists("Domy/NRD.ini"))
	{

	    for(new i = 0; i < 1900; i++)
	    {
	        format(string, sizeof(string), "Domy/Dom%d.ini", i);
	        if(dini_Exists(string))
	        {
				X = dini_Float(string, "Wej_X");
				Y = dini_Float(string, "Wej_Y");
				typ = dini_Int(string, "DomNr");
				cena = dini_Int(string, "Cena");


				printf("gowno dupa sraka domek nr %d x %f y %f gwiazdki %d", i, X, Y, IntInfo[typ][Kategoria]);

				/*format(pos, sizeof pos, "%f,%f,%d,%d", X, Y, IntInfo[typ][Kategoria], cena);

				format(file, sizeof file, "domky/%d.dom", i);

				fhandle = fopen(file,io_write);

				fwrite(fhandle, pos);

				fclose(fhandle);*/

				format(file, sizeof file, "domky/dom_%d.json", i);

				djSetFloat(file, "pos/x", X);
				djSetFloat(file, "pos/y", Y);
				djSetInt(file, "info/luksus", IntInfo[typ][Kategoria]);
				djSetInt(file, "info/sys", cena);

	        }
	    }
	}

	return 1;
}

public OnGameModeExit()
{
	djson_GameModeExit(); // <-- when you exit the gamemode, after that you can't run any djson function anymore!
	return 1;
}

public OnIncomingConnection(playerid, ip_address[], port)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	//if(newkeys == KEY_FIRE)  --->>> Wrong!
	//if(newkeys & KEY_FIRE)    --->>> Right...
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

//Only works in filterscripts but not in a gamemode...
public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

//In case you are using ZCMD/YCMD (Or anything like them) these is not called
public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/mycommand", cmdtext, true, 10) == 0)
	{
		// Do something here
		return 1;
	}
	return 0;
}

//==============================================================================
//--->>> ZCMD/YCMD (Uncomment if you use it)
//==============================================================================
/*
public OnPlayerCommandReceived(playerid, cmdtext[])
{
	return 1;
}

public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
	return 1;
}
*/
//==============================================================================
public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnActorStreamIn(actorid, forplayerid)
{
	return 1;
}

public OnActorStreamOut(actorid, forplayerid)
{
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
	return 1;
}

public OnPlayerGiveDamageActor(playerid, damaged_actorid, Float:amount, weaponid, bodypart)
{
	return 1;
}
//==============================================================================
//--->>> Object,picup,checkpoint (Dont use with streamer)
//==============================================================================
public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerEditObject( playerid, playerobject, objectid, response,
Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ )
{
	return 1;
}

public OnPlayerEditAttachedObject( playerid, response, index, modelid, boneid,
Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ,
Float:fRotX, Float:fRotY, Float:fRotZ,
Float:fScaleX, Float:fScaleY, Float:fScaleZ )
{
	return 1;
}

public OnPlayerSelectObject(playerid, type, objectid, modelid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}
//==============================================================================
public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}
//==============================================================================
public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}
//==============================================================================
//--->>> Vehicles...
//==============================================================================
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnEnterExitModShop(playerid, enterexit, interiorid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	return 1;
}

public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}
//==============================================================================
//--->>> Menu
//==============================================================================
public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 0;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	return 0;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	return 0;
}

//==============================================================================
//--->>> Streamer plugin
//==============================================================================
//Streamer include is not like others, but we still can use its defines :P
#if defined STREAMER_TYPE_OBJECT
public OnDynamicObjectMoved(objectid)
{
	return 1;
}

public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	return 1;
}

public OnPlayerSelectDynamicObject(playerid, objectid, modelid, Float:x, Float:y, Float:z)
{
	return 1;
}

public OnPlayerShootDynamicObject(playerid, weaponid, objectid, Float:x, Float:y, Float:z)
{
	return 1;
}

public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
	return 1;
}

public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	return 1;
}

public OnPlayerLeaveDynamicCP(playerid, checkpointid)
{
	return 1;
}

public OnPlayerEnterDynamicRaceCP(playerid, checkpointid)
{
	return 1;
}

public OnPlayerLeaveDynamicRaceCP(playerid, checkpointid)
{
	return 1;
}

public OnPlayerEnterDynamicArea(playerid, areaid)
{
	return 1;
}

public OnPlayerLeaveDynamicArea(playerid, areaid)
{
	return 1;
}

//Enabled with native Streamer_ToggleErrorCallback(toggle);
public Streamer_OnPluginError(error[])
{
	return 1;
}
#endif