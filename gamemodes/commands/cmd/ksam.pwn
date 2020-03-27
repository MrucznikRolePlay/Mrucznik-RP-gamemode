//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ ksam ]-------------------------------------------------//
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

YCMD:ksam(playerid, params[], help)
{
    if(PlayerInfo[playerid][Admin] >=10)
	{
	    new level;
		if( sscanf(params, "d", level))
		{
			sendTipMessage(playerid, "U¿yj /ksam [kamera]");
			return 1;
		}


		TogglePlayerControllable(playerid, 0);
		if(level == 1)//dmv dó³
		{
		    SetPlayerPos(playerid, 1475.013671875, -1745.9069824219, -5.0);
		    SetPlayerCameraPos(playerid, 1533.6928710938, -1709.9449462891, 31.546875);//kamera
			SetPlayerCameraLookAt(playerid, 1475.013671875, -1745.9069824219, 13.930854797363);//patrz
		}
		else if(level == 2)//komisariat
		{
		    SetPlayerPos(playerid, 1542.4140625, -1675.5947265625, -5.0);
		    SetPlayerCameraPos(playerid, 1503.0399169922, -1689.4235839844, 42.296875);//kamera
			SetPlayerCameraLookAt(playerid, 1542.4140625, -1675.5947265625, 13.554452896118);//patrz
		}
		else if(level == 3)//24/7
		{
		    SetPlayerPos(playerid, 1352.2797851563, -1757.189453125, -5.0);
		    SetPlayerCameraPos(playerid, 1352.4576416016, -1725.1925048828, 23.291763305664);// kamera
			SetPlayerCameraLookAt(playerid, 1352.2797851563, -1757.189453125, 13.5078125);// patrz
		}
		else if(level == 4)//palmy
		{
		    SetPlayerPos(playerid, 1275.0283203125, -1337.3585205078, -5.0);
		    SetPlayerCameraPos(playerid, 1275.0283203125, -1337.3585205078, 10.852507591248);// kamera
			SetPlayerCameraLookAt(playerid, 1235.1977539063, -1341.1885986328, 54.349945068359);// patrz
		}
		else if(level == 5)//szpital
		{
		    SetPlayerPos(playerid, 1172.8602294922, -1331.978515625, -5.0);
		    SetPlayerCameraPos(playerid, 1228.7977294922, -1345.1479492188, 21.532119750977);// kamera
			SetPlayerCameraLookAt(playerid, 1172.8602294922, -1331.978515625, 14.317019462585);// patrz
		}
		else if(level == 6)//molo
		{
		    SetPlayerPos(playerid, 835.99493408203, -2028.1843261719, -5.0);
		    SetPlayerCameraPos(playerid, 836.81677246094, -2102.888671875, 30.026561737061);// kamera
			SetPlayerCameraLookAt(playerid, 835.99493408203, -2028.1843261719, 13.022017478943);// patrz
		}
		else if(level == 7)//biurowiec
		{
		    SetPlayerPos(playerid, 326.09194946289, -1521.3157958984, 20.0);
		    SetPlayerCameraPos(playerid, 398.16021728516, -1511.9237060547, 78.641815185547);// kamera
			SetPlayerCameraLookAt(playerid, 326.09194946289, -1521.3157958984, 42.154850006104);// patrz
		}
		else if(level == 8)//baba
		{
		    SetPlayerPos(playerid, 412.80743408203, -1312.4066162109, -5.0);
		    SetPlayerCameraPos(playerid, 402.2776184082, -1351.4703369141, 43.704566955566);// kamera
			SetPlayerCameraLookAt(playerid, 412.80743408203, -1312.4066162109, 39.677307128906);// patrz
		}
		else if(level == 9)//krajobraz
		{
		    SetPlayerPos(playerid, 849.62371826172, -989.92199707031, -5.0);
		    SetPlayerCameraPos(playerid, 849.62371826172, -989.92199707031, 53.211112976074);// kamera
			SetPlayerCameraLookAt(playerid, 907.40313720703, -913.14117431641, 77.788856506348);// patrz
		}
		else if(level == 10)//góra dmv
		{
		    SetPlayerPos(playerid, 1476.0841064453, -1587.5469970703, -5.0);
		    SetPlayerCameraPos(playerid, 1476.0841064453, -1587.5469970703, 94.578155517578);// kamera
			SetPlayerCameraLookAt(playerid, 1477.9970703125, -1682.9604492188, 120.3067779541);// patrz
		}
		else if(level == 11)//green bar
		{
		    SetPlayerPos(playerid, 2321.1193847656, -1644.9545898438, -5.0);
		    SetPlayerCameraPos(playerid, 2306.44921875, -1648.0637207031, 19.648511886597);// kamera
			SetPlayerCameraLookAt(playerid, 2321.1193847656, -1644.9545898438, 20.322546005249);// patrz
		}
		else if(level == 12)//pig pen
		{
		    SetPlayerPos(playerid, 2432.427734375, -1219.1400146484, -5.0);
		    SetPlayerCameraPos(playerid, 2412.5122070313, -1270.3096923828, 32.702220916748);// kamera
			SetPlayerCameraLookAt(playerid, 2432.427734375, -1219.1400146484, 27.857213973999);// patrz
		}
		else if(level == 13)//kosciol
		{
		    SetPlayerPos(playerid, 2249.8486328125, -1324.0440673828, -5.0);
		    SetPlayerCameraPos(playerid, 2290.0915527344, -1278.4261474609, 51.061328887939);// kamera
			SetPlayerCameraLookAt(playerid, 2249.8486328125, -1324.0440673828, 33.366535186768);// patrz
		}
		else if(level == 14)//salon
		{
		    SetPlayerPos(playerid, 2132.021484375, -1151.7044677734, -5.0);
		    SetPlayerCameraPos(playerid, 2135.5944824219, -1097.8615722656, 42.498329162598);// kamera
			SetPlayerCameraLookAt(playerid, 2132.021484375, -1151.7044677734, 28.347097396851);// patrz
		}
		else if(level == 15)//mechanicy
		{
		    SetPlayerPos(playerid, 2779.2543945313, -1625.6682128906, -5.0);
		    SetPlayerCameraPos(playerid, 2785.1057128906, -1593.6995849609, 17.093282699585);// kamera
			SetPlayerCameraLookAt(playerid, 2779.2543945313, -1625.6682128906, 10.921875);// patrz
		}
		else if(level == 16)//bukmacher
		{
		    SetPlayerPos(playerid, 2799.1599121094, -1087.5931396484, -5.0);
		    SetPlayerCameraPos(playerid, 2896.6389160156, -1088.0809326172, 51.550712585449);// kamera
			SetPlayerCameraLookAt(playerid, 2799.1599121094, -1087.5931396484, 32.892097473145);// patrz
		}
		else if(level == 17)//matsiarnia
		{
		    SetPlayerPos(playerid, 594.65191650391, -1244.9367675781, -5.0);
		    SetPlayerCameraPos(playerid, 581.66076660156, -1194.0218505859, 63.454399108887);// kamera
			SetPlayerCameraLookAt(playerid, 594.65191650391, -1244.9367675781, 18.101390838623);// patrz
		}
		else if(level == 18)//studio san
		{
		    SetPlayerPos(playerid, 649.64978027344, -1358.2073974609, -5.0);
		    SetPlayerCameraPos(playerid, 604.78979492188, -1357.9267578125, 32.532451629639);// kamera
			SetPlayerCameraLookAt(playerid, 649.64978027344, -1358.2073974609, 14.314910888672);// patrz
		}
		else if(level == 19)//restauracja lcn
		{
		    SetPlayerPos(playerid, 722.64001464844, -1440.8016357422, -5.0);
		    SetPlayerCameraPos(playerid, 676.10821533203, -1397.7175292969, 30.902849197388);// kamera
			SetPlayerCameraLookAt(playerid, 722.64001464844, -1440.8016357422, 13.770217895508);// patrz
		}
		else if(level == 20)//p¹czkarnia
		{
		    SetPlayerPos(playerid, 1016.9872436523, -1372.0234375, -5.0);
		    SetPlayerCameraPos(playerid, 1053.3154296875, -1326.3295898438, 28.300031661987);// kamera
			SetPlayerCameraLookAt(playerid, 1016.9872436523, -1372.0234375, 15.836219787598);// patrz
		}
		else if(level == 21)//si³ownia
		{
		    SetPlayerPos(playerid, 2231.7556152344, -1722.3572998047, -5.0);
		    SetPlayerCameraPos(playerid, 2216.4689941406, -1740.7563476563, 20.06992149353);// kamera
			SetPlayerCameraLookAt(playerid, 2231.7556152344, -1722.3572998047, 18.674905776978);// patrz
		}
		else if(level == 22)//ammu nation
		{
		    SetPlayerPos(playerid, 1365.6441650391, -1280.5021972656, -5.0);
		    SetPlayerCameraPos(playerid, 1325.3818359375, -1282.9909667969, 31.582809448242);// kamera
			SetPlayerCameraLookAt(playerid, 1365.6441650391, -1280.5021972656, 21.209575653076);// patrz
		}
		else if(level == 23)//bank
		{
		    SetPlayerPos(playerid, 1461.9548339844, -1046.5203857422, -5.0);
		    SetPlayerCameraPos(playerid, 1461.9548339844, -1046.5203857422, 26.403123855591);// kamera
			SetPlayerCameraLookAt(playerid, 1462.3500976563, -1009.8300170898, 29.108682632446);// patrz
		}
		else if(level == 24)//unity station
		{
		    SetPlayerPos(playerid, 1788.783203125, -1876.8815917969, -5.0);
		    SetPlayerCameraPos(playerid, 1838.3461914063, -1841.0067138672, 31.29806137085);// kamera
			SetPlayerCameraLookAt(playerid, 1788.783203125, -1876.8815917969, 24.951961517334);// patrz
		}
		else if(level == 25)//granica
		{
		    SetPlayerPos(playerid, 55.527679443359, -1531.3371582031, -10.0);
		    SetPlayerCameraPos(playerid, 101.52135467529, -1538.3253173828, 19.186899185181);// kamera
			SetPlayerCameraLookAt(playerid, 55.527679443359, -1531.3371582031, 5.2492713928223);// patrz
		}
		else if(level == 26)//kasyno
		{
		    SetPlayerPos(playerid, 1055.5834960938, -1154.1359863281, -5.0);
		    SetPlayerCameraPos(playerid, 1055.5834960938, -1154.1359863281, 29.209383010864);// kamera
			SetPlayerCameraLookAt(playerid, 1000.6205444336, -1121.8303222656, 31.49701499939);// patrz
		}
		else if(level == 27)//molo z ko³em ryby
		{
		    SetPlayerPos(playerid, 370.02825927734, -2083.5886230469, -10.0);
		    SetPlayerCameraPos(playerid, 340.61755371094, -2091.701171875, 22.800081253052);// kamera
			SetPlayerCameraLookAt(playerid, 370.02825927734, -2083.5886230469, 8.1386299133301);// patrz
		}
		else if(level == 28)//skok
		{
		    SetPlayerPos(playerid, 1963.5544433594, -2134.0036621094, -5.0);
		    SetPlayerCameraPos(playerid, 1962.7001953125, -2222.1535644531, 18.375);// kamera
			SetPlayerCameraLookAt(playerid, 1963.5544433594, -2134.0036621094, 13.3828125);// patrz
		}
		else if(level == 29)//domki
		{
		    SetPlayerPos(playerid, 1883.6086425781, -2081.5034179688, -5.0);
		    SetPlayerCameraPos(playerid, 1977.0340576172, -2108.5888671875, 25.407804489136);// kamera
			SetPlayerCameraLookAt(playerid, 1883.6086425781, -2081.5034179688, 17.580423355103);// patrz
		}
		else if(level == 30)
		{
		    TogglePlayerControllable(playerid, 1);
		    SetPlayerPos(playerid, 1529.6,-1691.2,13.3);
		    SetCameraBehindPlayer(playerid);
		}
		else
		{
		    TogglePlayerControllable(playerid, 1);
		    SetCameraBehindPlayer(playerid);
		    return 1;
		}
	}
	return 1;
}
