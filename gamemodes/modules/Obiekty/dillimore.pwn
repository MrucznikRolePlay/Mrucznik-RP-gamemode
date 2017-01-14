stock DodajWejscia_Dillimore()
{
	DodajWejscie(246.6199,63.3594,1003.6406, 627.8462,-571.6732,17.5113, 88, 6, 0, 0, "", "Posterunek");
	DodajWejscie(236.1267,71.6366,1005.0391, 236.1212,68.5662,1005.0391, 88, 6, 88, 6, "", "");
	DodajWejscie(246.4406,87.1606,1003.6406, 606.1909,-571.7484,19.1921, 88, 6, 0, 0, "Parking", "Posterunek");
	DodajWejscie(247.2509,81.4765,1003.6406, 621.4407,-569.5487,26.1432, 88, 6, 0, 0, "Dach", "Posterunek");
	DodajWejscie(243.0992,66.2829,1003.6406, 795.0273, -580.6437,-74.1979, 88, 6, 0, 16, "Akademia policyjna", "Posterunek");
	DodajWejscie(611.0284,-583.8448,18.0515, 803.0414,-588.9749,-74.1955, 0, 0, 0, 16, "Akademia policyjna", "");
}

stock Bramy_Dillimore()
{
	//intek SASP
	DodajBrame(CreateDynamicObject(1569, 222.16035, 68.89352, 1004.04041,   0.00000, 0.00000, 90.00000), 
		222.16035, 68.89352, 1004.04041,   0.00000, 0.00000, 90.00000,
		222.16035, 67.7135, 1004.04041,   0.00000, 0.00000, 90.00000,
		1, 2.0, BRAMA_UPR_TYPE_FRACTION, FRAC_NG); 
	DodajBrame(CreateDynamicObject(19302, 266.35931, 85.70960, 1001.29022,   0.00000, 0.00000, 90.00000), 
		266.35931, 85.70960, 1001.29022,   0.00000, 0.00000, 90.00000,
		267.13681, 85.22551, 1001.29022,   0.00000, 0.00000, 25.00000,
		1, 2.0, BRAMA_UPR_TYPE_FRACTION, FRAC_NG); 
	DodajBrame(CreateDynamicObject(19302, 266.35931, 81.20890, 1001.29022,   0.00000, 0.00000, 90.00000),
		266.35931, 81.20890, 1001.29022,   0.00000, 0.00000, 90.00000,
		267.13681, 80.72890, 1001.29022,   0.00000, 0.00000, 25.00000,
		1, 2.0, BRAMA_UPR_TYPE_FRACTION, FRAC_NG);
	DodajBrame(CreateDynamicObject(19302, 266.35931, 76.70890, 1001.29022,   0.00000, 0.00000, 90.00000),
		266.35931, 76.70890, 1001.29022,   0.00000, 0.00000, 90.00000,
		267.13681, 76.22890, 1001.29022,   0.00000, 0.00000, 25.00000,
		1, 2.0, BRAMA_UPR_TYPE_FRACTION, FRAC_NG);
	DodajBrame(CreateDynamicObject(19302, 258.93069, 90.96210, 1002.68958,   0.00000, 0.00000, 270.00000),
		258.93069, 90.96210, 1002.68958,   0.00000, 0.00000, 270.00000,
		258.93069, 92.3021, 1002.68958,   0.00000, 0.00000, 270.00000,
		1, 2.0, BRAMA_UPR_TYPE_FRACTION, FRAC_NG);
	DodajBrame(CreateDynamicObject(1569, 250.53391, 62.42270, 1002.64038,   0.00000, 0.00000, 90.00000),
		250.53391, 62.42270, 1002.64038,   0.00000, 0.00000, 90.00000,
		250.53391, 61.2527, 1002.64038,   0.00000, 0.00000, 90.00000,
		1, 2.0, BRAMA_UPR_TYPE_FRACTION, FRAC_NG);
	DodajBrame(CreateDynamicObject(1569, 245.49270, 72.53520, 1002.64069,   0.00000, 0.00000, 0.00000),
		245.49270, 72.53520, 1002.64069,   0.00000, 0.00000, 0.00000,
		244.3127, 72.53520, 1002.64069,   0.00000, 0.00000, 0.00000,
		1, 2.0, BRAMA_UPR_TYPE_FRACTION, FRAC_NG); 
	DodajBrame(CreateDynamicObject(1569, 248.12000, 76.75250, 1002.64069,   0.00000, 0.00000, 270.00000),
		248.12000, 76.75250, 1002.64069,   0.00000, 0.00000, 270.00000,
		248.12000, 77.9225, 1002.64069,   0.00000, 0.00000, 270.00000,
		1, 2.0, BRAMA_UPR_TYPE_FRACTION, FRAC_NG);
	
	//brama komi
	DodajBrame(CreateDynamicObject(968, 633.10651, -597.23071, 16.15150,   0.00000, -90.00000, -78.50000),
		633.10651, -597.23071, 16.15150,   0.00000, -90.00000, -78.50000,
		633.10651, -597.23071, 16.15150,   0.00000, -5.00000, -78.00000,
		1, 10.0, BRAMA_UPR_TYPE_FRACTION, FRAC_NG);
	
	//bramka LS-LV
	DodajBrame(CreateDynamicObject(968, 1682.49878, 416.69019, 30.57900,   0.00000, 0.00000, -20.00000),
		1682.49878, 416.69019, 30.57900,   0.00000, 0.00000, -20.00000,
		1682.49878, 416.69019, 30.57900,   0.00000, 90.00000, -20.00000,
		1, 7.0, BRAMA_UPR_TYPE_FRACTION, FRAC_NG); 
	DodajBrame(CreateDynamicObject(968, 1698.69885, 410.88089, 30.57900,   0.00000, 0.00000, 160.00000),
		1698.69885, 410.88089, 30.57900,   0.00000, 0.00000, 160.00000,
		1698.69885, 410.88089, 30.57900,   0.00000, 90.00000, 160.00000,
		1, 7.0, BRAMA_UPR_TYPE_FRACTION, FRAC_NG);
	DodajBrame(CreateDynamicObject(968, 1718.32532, 414.82669, 30.61900,   0.00000, 0.00000, 160.00000),
		1718.32532, 414.82669, 30.61900,   0.00000, 0.00000, 160.00000,
		1718.32532, 414.82669, 30.61900,   0.00000, 90.00000, 160.00000,
		1, 7.0, BRAMA_UPR_TYPE_FRACTION, FRAC_NG); 
	DodajBrame(CreateDynamicObject(968, 1703.68982, 420.09259, 30.61900,   0.00000, 0.00000, -20.00000),
		1703.68982, 420.09259, 30.61900,   0.00000, 0.00000, -20.00000,
		1703.68982, 420.09259, 30.61900,   0.00000, 90.00000, -20.00000,
		1, 7.0, BRAMA_UPR_TYPE_FRACTION, FRAC_NG);

	//bramka na mostku
	DodajBrame(CreateDynamicObject(968, 526.94672, 475.95499, 18.80680,   0.00000, 0.00000, 35.04000),
		526.94672, 475.95499, 18.80680,   0.00000, 0.00000, 35.04000,
		526.94672, 475.95499, 18.80680,   0.00000, -90.00000, 35.04000,
		1, 7.0, BRAMA_UPR_TYPE_FRACTION, FRAC_NG);
	DodajBrame(CreateDynamicObject(968, 515.19238, 467.72159, 18.86680,   0.00000, 0.00000, 35.04000),
		515.19238, 467.72159, 18.86680,   0.00000, 0.00000, 35.04000,
		515.19238, 467.72159, 18.86680,   0.00000, 90.00000, 35.04000,
		1, 7.0, BRAMA_UPR_TYPE_FRACTION, FRAC_NG);

	//bramka na mostku 2
	DodajBrame(CreateDynamicObject(968, -161.60710, 363.50439, 11.99300,   0.00000, 0.00000, -14.00000),
		-161.60710, 363.50439, 11.99300,   0.00000, 0.00000, -14.00000,
		-161.60710, 363.50439, 11.99300,   0.00000, -90.00000, -14.00000,
		1, 7.0, BRAMA_UPR_TYPE_FRACTION, FRAC_NG);
	DodajBrame(CreateDynamicObject(968, -175.44040, 367.09341, 11.99300,   0.00000, 0.00000, 165.00000),
		-175.44040, 367.09341, 11.99300,   0.00000, 0.00000, 165.00000,
		-175.44040, 367.09341, 11.99300,   0.00000, -90.00000, 165.00000,
		1, 7.0, BRAMA_UPR_TYPE_FRACTION, FRAC_NG);

	//bramka na mostku 3
	DodajBrame(CreateDynamicObject(968, -974.08752, -339.83640, 36.27580,   0.00000, 0.00000, -11.00000),
		-974.08752, -339.83640, 36.27580,   0.00000, 0.00000, -11.00000,
		-974.08752, -339.83640, 36.27580,   0.00000, 90.00000, -11.00000,
		1, 7.0, BRAMA_UPR_TYPE_FRACTION, FRAC_NG); 
	DodajBrame(CreateDynamicObject(968, -960.05786, -342.55597, 36.21580,   0.00000, 0.00000, -11.00000),
		-960.05786, -342.55597, 36.21580,   0.00000, 0.00000, -11.00000,
		-960.05786, -342.55597, 36.21580,   0.00000, -90.00000, -11.00000,
		1, 7.0, BRAMA_UPR_TYPE_FRACTION, FRAC_NG);

	//tunel
	DodajBrame(CreateDynamicObject(968, -1225.51465, -783.38373, 63.89480,   0.00000, 0.32000, 42.00000),
		-1225.51465, -783.38373, 63.89480,   0.00000, 0.32000, 42.00000,
		-1225.51465, -783.38373, 63.89480,   0.00000, 90.32000, 42.00000,
		1, 7.0, BRAMA_UPR_TYPE_FRACTION, FRAC_NG); 
	DodajBrame(CreateDynamicObject(968, -1215.10303, -773.57288, 63.79480,   0.00000, 0.00000, 45.00000),
		-1215.10303, -773.57288, 63.79480,   0.00000, 0.00000, 45.00000,
		-1215.10303, -773.57288, 63.79480,   0.00000, -90.00000, 45.00000,
		1, 7.0, BRAMA_UPR_TYPE_FRACTION, FRAC_NG);

	//tunel 2
	DodajBrame(CreateDynamicObject(968, -20.38480, -1329.73218, 10.88180,   0.00000, 0.50000, -51.40000),
		-20.38480, -1329.73218, 10.88180,   0.00000, 0.50000, -51.40000,
		-20.38480, -1329.73218, 10.88180,   0.00000, 89.50000, -51.40000,
		1, 7.0, BRAMA_UPR_TYPE_FRACTION, FRAC_NG);
	DodajBrame(CreateDynamicObject(968, -11.48793, -1340.80090, 10.90180,   0.00000, 0.22000, -51.40000),
		-11.48793, -1340.80090, 10.90180,   0.00000, 0.22000, -51.40000,
		-11.48793, -1340.80090, 10.90180,   0.00000, -90.22000, -51.40000,
		1, 7.0, BRAMA_UPR_TYPE_FRACTION, FRAC_NG);
	DodajBrame(CreateDynamicObject(968, 18.04645, -1335.45569, 10.02170,   0.00000, 0.00000, -52.00000),
		18.04645, -1335.45569, 10.02170,   0.00000, 0.00000, -52.00000,
		18.04645, -1335.45569, 10.02170,   0.00000, 91.00000, -52.00000,
		1, 7.0, BRAMA_UPR_TYPE_FRACTION, FRAC_NG);
	DodajBrame(CreateDynamicObject(968, 26.81360, -1346.70227, 9.96170,   0.00000, 0.00000, -52.00000),
		26.81360, -1346.70227, 9.96170,   0.00000, 0.00000, -52.00000,
		26.81360, -1346.70227, 9.96170,   0.00000, -91.00000, -52.00000,
		1, 7.0, BRAMA_UPR_TYPE_FRACTION, FRAC_NG);
}

stock Dillimore_DeleteMapObjects(playerid)
{
	//Dillimore
	RemoveBuildingForPlayer(playerid, 1446, 741.6328, -517.7656, 16.3438, 0.25);
	RemoveBuildingForPlayer(playerid, 1446, 741.6328, -513.0703, 16.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 1410, 731.8594, -595.0547, 16.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 1410, 731.8594, -599.7266, 16.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 1440, 642.7188, -511.0547, 15.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 1410, 739.3750, -540.3438, 16.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 1410, 734.7109, -540.3438, 16.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 1446, 756.6953, -561.1094, 18.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 1446, 756.6953, -565.8906, 18.1094, 0.25);
	RemoveBuildingForPlayer(playerid, 1446, 756.6953, -551.7891, 17.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 1446, 756.6953, -556.4453, 17.9453, 0.25);
	RemoveBuildingForPlayer(playerid, 1446, 756.6953, -542.4844, 17.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 1446, 756.6953, -547.1406, 17.4375, 0.25);
	RemoveBuildingForPlayer(playerid, 1410, 778.8750, -519.9844, 16.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 1410, 774.2109, -519.9844, 16.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 1410, 809.3672, -520.0234, 16.0625, 0.25);
	RemoveBuildingForPlayer(playerid, 1410, 814.0391, -520.0234, 16.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1410, 824.2188, -517.7813, 16.1250, 0.25);
	RemoveBuildingForPlayer(playerid, 1410, 824.2188, -513.1016, 16.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 1410, 824.2188, -508.4219, 16.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 1410, 824.2188, -503.7422, 16.8672, 0.25);
	RemoveBuildingForPlayer(playerid, 1503, 638.8359, -517.4766, 15.5469, 0.25);

	//intek sasp
	RemoveBuildingForPlayer(playerid, 1535, 245.2891, 61.9063, 1002.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 1535, 248.3125, 61.9375, 1002.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 14843, 266.3516, 81.1953, 1001.2813, 0.25);
	RemoveBuildingForPlayer(playerid, 2610, 236.3594, 70.7188, 1004.8984, 0.25);
	RemoveBuildingForPlayer(playerid, 2610, 237.3047, 70.7188, 1004.8984, 0.25);
	RemoveBuildingForPlayer(playerid, 2605, 232.1172, 65.0625, 1004.4609, 0.25);
}

stock Dillimore_Load() 
{
	//³adowanie bram:
	Bramy_Dillimore();
	//³adowanie wejœæ:
	DodajWejscia_Dillimore();
	
	//intek SASP
	SetDynamicObjectMaterial(CreateDynamicObject(1491, 226.23210, 72.71840, 1004.04053,   0.00000, 0.00000, 270.00000), 0, 1569, "adam_v_doort", "ws_guardhousedoor", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(1491, 226.23210, 74.89560, 1004.04053,   0.00000, 0.00000, 90.00000), 0, 1569, "adam_v_doort", "ws_guardhousedoor", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(1491, 222.21159, 78.91710, 1004.04053,   0.00000, 0.00000, 90.00000), 0, 1569, "adam_v_doort", "ws_guardhousedoor", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(1491, 252.08179, 72.90366, 1002.64050,   0.00000, 0.00000, 90.00000), 0, 1569, "adam_v_doort", "ws_guardhousedoor", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(1491, 259.47366, 72.83719, 1002.64050,   0.00000, 0.00000, 90.00000), 0, 1649, "wglass", "carshowwin2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(1569, 259.46371, 74.34350, 1002.64093,   0.00000, 0.00000, 90.00000), 0, 1649, "wglass", "carshowwin2", 0xFFFFFFFF);
	CreateDynamicObject(1569, 246.98380, 72.53520, 1002.64069,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1569, 222.15651, 70.35696, 1004.04041,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1569, 226.23210, 71.20850, 1004.04041,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(19303, 266.35931, 87.45140, 1001.29022,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19303, 266.35931, 82.95680, 1001.29022,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19303, 266.35931, 78.46470, 1001.29022,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1771, 263.72931, 87.91010, 1000.67059,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1771, 263.85574, 83.35513, 1000.67059,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1771, 263.85031, 78.79002, 1000.67059,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19303, 258.93069, 89.23220, 1002.68958,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(348, 253.80769, 73.19850, 1003.73297,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(1569, 245.30280, 61.89270, 1002.64038,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1569, 248.29601, 61.89270, 1002.64038,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1569, 226.23210, 76.39510, 1004.04041,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1569, 222.21159, 80.42630, 1004.04041,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1569, 250.53391, 63.91270, 1002.64038,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19380, 237.24580, 65.40560, 1004.03918,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19380, 226.97639, 65.42230, 1004.03918,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19380, 231.95520, 64.07220, 1004.03918,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(19447, 237.14740, 69.93010, 1004.04077,   90.00000, 90.00000, 0.00000);
	CreateDynamicObject(19447, 232.12970, 69.93470, 1003.48602,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19447, 232.12970, 69.93470, 1008.29602,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19325, 232.45261, 70.10230, 1005.23962,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19273, 247.67140, 72.42100, 1004.0613,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19273, 250.81551, 64.82580, 1004.03497,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19325, 250.61070, 68.14340, 1006.25671,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(321, 261.51129, 70.38320, 1002.24127,   90.00000, -103.00000, 0.00000);
	CreateDynamicObject(322, 254.10146, 73.25883, 1003.22272,   90.00000, -47.00000, 0.00000);
	CreateDynamicObject(18636, 253.49686, 73.22023, 1004.27588,   0.00000, 90.00000, 126.00000);
	CreateDynamicObject(334, 253.93657, 80.70556, 1003.14093,   90.00000, -62.00000, 0.00000);
	CreateDynamicObject(18637, 258.82077, 78.72878, 1003.17590,   105.00000, -180.00000, 90.00000);
	CreateDynamicObject(2206, 218.91655, 70.79005, 1004.04028,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2190, 219.37866, 70.42716, 1004.97491,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(19808, 218.66820, 70.22630, 1004.99579,   0.00000, 0.00000, 287.00000);
	CreateDynamicObject(1671, 220.26675, 70.31686, 1004.48102,   0.00000, 0.00000, -55.00000);
	CreateDynamicObject(1714, 217.38445, 69.89870, 1004.02100,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19807, 218.85291, 69.04620, 1005.05560,   0.00000, 0.00000, -98.00000);
	CreateDynamicObject(2255, 217.37250, 69.18670, 1006.00452,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2612, 221.86031, 67.28660, 1005.75732,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2605, 223.83514, 71.84997, 1004.44110,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2356, 222.72321, 72.48440, 1004.03998,   0.00000, 0.00000, -149.00000);
	CreateDynamicObject(19807, 223.96791, 71.29570, 1004.91779,   0.00000, 0.00000, -91.00000);
	CreateDynamicObject(2610, 217.32104, 66.51542, 1004.87012,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2610, 217.32100, 67.00890, 1004.87012,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1569, 248.12000, 75.25200, 1002.64069,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1569, 252.07179, 74.40640, 1002.64093,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19437, 228.58681, 69.93430, 1005.79340,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19437, 227.69850, 69.93290, 1005.79340,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2911, 236.67580, 70.31050, 1004.04779,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2911, 236.67580, 69.87050, 1004.04779,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2008, 251.43085, 68.26211, 1002.63489,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2356, 252.40752, 69.42122, 1002.64001,   0.00000, 0.00000, -229.00000);
	CreateDynamicObject(2356, 256.99597, 69.71844, 1002.64001,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2310, 242.83162, 68.57943, 1003.13959,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2310, 242.83160, 69.35940, 1003.13959,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2310, 242.83160, 70.11940, 1003.13959,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2310, 242.83160, 70.87940, 1003.13959,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2611, 248.97000, 72.29260, 1004.37323,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2615, 242.44460, 63.74080, 1004.20251,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19942, 251.44250, 68.73598, 1003.54572,   0.00000, 0.00000, 84.00000);
	CreateDynamicObject(2606, 250.96440, 67.66730, 1005.87378,   18.00000, 0.00000, 90.00000);
	CreateDynamicObject(2606, 227.14830, 66.00940, 1006.90009,   25.00000, 0.00000, 90.00000);
	CreateDynamicObject(2606, 227.14830, 67.98940, 1006.90009,   25.00000, 0.00000, 90.00000);
	CreateDynamicObject(1518, 226.95450, 65.38530, 1006.16022,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19786, 227.02209, 66.96650, 1005.87988,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1518, 226.95450, 65.38530, 1005.58020,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1518, 226.95450, 68.56530, 1006.16022,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1518, 226.95450, 68.56530, 1005.58020,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19165, 237.14980, 66.96310, 1006.24060,   90.00000, 90.00000, 180.00000);
	CreateDynamicObject(14532, 227.92487, 69.19360, 1005.01849,   0.00000, 0.00000, -113.00000);
	CreateDynamicObject(2605, 229.94820, 65.19969, 1004.43921,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2605, 229.94820, 68.80690, 1004.43921,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2605, 232.14819, 65.19970, 1004.43921,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2605, 232.14819, 68.80690, 1004.43921,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2605, 234.22820, 68.80690, 1004.43921,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2605, 234.22820, 65.19970, 1004.43921,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2356, 231.31296, 64.66663, 1004.04059,   0.00000, 0.00000, 55.00000);
	CreateDynamicObject(2356, 233.37239, 64.70709, 1004.04059,   0.00000, 0.00000, 55.00000);
	CreateDynamicObject(2356, 235.50862, 64.75301, 1004.04059,   0.00000, 0.00000, 55.00000);
	CreateDynamicObject(2356, 231.20183, 69.38299, 1004.04059,   0.00000, 0.00000, -229.00000);
	CreateDynamicObject(2356, 233.52278, 69.50469, 1004.04059,   0.00000, 0.00000, -229.00000);
	CreateDynamicObject(2356, 235.30788, 69.47223, 1004.04059,   0.00000, 0.00000, -229.00000);
	CreateDynamicObject(1775, 222.91760, 76.70300, 1005.13391,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2641, 221.85980, 78.21490, 1005.88922,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(19916, 217.13490, 74.35580, 1004.03192,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2339, 218.04761, 74.36090, 1004.11737,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1679, 215.64030, 80.89886, 1004.52051,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1679, 215.68436, 77.01719, 1004.52051,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1679, 220.16624, 77.05414, 1004.52051,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2149, 218.05029, 74.30890, 1005.31897,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2415, 218.88730, 74.52490, 1004.04010,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1998, 257.09714, 88.21230, 1001.43945,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2356, 258.58810, 87.96306, 1001.44049,   0.00000, 0.00000, -287.00000);
	CreateDynamicObject(2063, 258.56201, 84.98910, 1002.35931,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(11749, 257.48459, 89.09960, 1002.25140,   0.00000, 0.00000, -98.00000);
	CreateDynamicObject(11750, 257.66711, 89.30910, 1002.26141,   0.00000, 0.00000, -40.00000);
	CreateDynamicObject(2610, 236.77490, 65.10200, 1004.87061,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2610, 236.77490, 65.59400, 1004.87061,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2173, 252.01414, 83.81405, 1001.43958,   0.00000, 0.00000, 324.00000);
	CreateDynamicObject(1721, 253.59959, 84.04593, 1001.44092,   0.00000, 0.00000, 76.00000);
	CreateDynamicObject(1671, 251.80542, 82.60175, 1001.89093,   0.00000, 0.00000, -215.00000);
	CreateDynamicObject(2196, 252.48236, 83.07852, 1002.23969,   0.00000, 0.00000, 164.00000);
	CreateDynamicObject(19807, 251.92192, 83.90334, 1002.32013,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11749, 252.60130, 83.33320, 1002.24011,   0.00000, 0.00000, -142.00000);
	CreateDynamicObject(11749, 253.67320, 84.32720, 1001.89038,   -84.00000, 98.00000, 0.00000);
	CreateDynamicObject(19380, 232.40581, 65.14140, 1003.94702,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(1535, 247.91830, 82.29800, 1002.63788,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(11746, 253.54500, 73.14540, 1004.39551,   0.00000, 0.00000, 126.00000);
	CreateDynamicObject(11746, 257.57999, 88.94090, 1002.25153,   90.00000, 0.00000, -25.00000);
	CreateDynamicObject(18885, 255.99519, 82.25970, 1002.54150,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2587, 254.69031, 80.77440, 1004.74121,   0.00000, 0.00000, 0.00000);

	//Dillimore komi exterior
	SetDynamicObjectMaterial(CreateDynamicObject(19463, 612.17810, -591.78021, 17.10700,   12.00000, 90.00000, 90.00000), 0, 12855, "cunte_cop", "sw_PDground", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19463, 612.16589, -588.53137, 17.10700,   12.00000, 90.00000, 90.00000), 0, 12855, "cunte_cop", "sw_PDground", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19447, 611.90503, -586.86639, 15.29880,   12.00000, 180.00000, 90.00000), 0, 12855, "cunte_cop", "sw_PDground", 0xFFFFFFFF);
	CreateDynamicObject(970, 609.62079, -586.80353, 18.28270,   0.00000, 12.00000, 0.00000);
	CreateDynamicObject(970, 613.66931, -586.80353, 17.42270,   0.00000, 12.00000, 0.00000);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 607.30859, -574.62152, 18.05780,   0.00000, 0.00000, 0.00000), 0, 12855, "cunte_cop", "sw_PDground", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 607.30859, -577.82373, 18.05780,   0.00000, 0.00000, 0.00000), 0, 12855, "cunte_cop", "sw_PDground", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 607.30859, -568.96167, 18.05780,   0.00000, 0.00000, 0.00000), 0, 12855, "cunte_cop", "sw_PDground", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 607.30859, -565.75519, 18.05780,   0.00000, 0.00000, 0.00000), 0, 12855, "cunte_cop", "sw_PDground", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19440, 607.30859, -563.35553, 18.05780,   0.00000, 0.00000, 0.00000), 0, 12855, "cunte_cop", "sw_PDground", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19440, 607.30859, -580.22449, 18.05780,   0.00000, 0.00000, 0.00000), 0, 12855, "cunte_cop", "sw_PDground", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(3628, 600.48499, -602.26001, 14.19880,   0.00000, 0.00000, 180.06200), 5, 12855, "cunte_cop", "sw_PDground", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(3628, 600.46198, -581.18201, 14.19880,   0.00000, 0.00000, 180.06200), 5, 12855, "cunte_cop", "sw_PDground", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(3628, 600.43213, -560.10498, 14.1888,   0.00000, 0.00000, 180.06200), 5, 12855, "cunte_cop", "sw_PDground", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(3628, 605.12891, -555.37988, 14.20880,   0.00000, 0.00000, 270.06201), 5, 12855, "cunte_cop", "sw_PDground", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(3628, 592.77655, -560.12152, 14.19880,   0.00000, 0.00000, 180.06200), 5, 12855, "cunte_cop", "sw_PDground", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(3628, 592.83588, -581.13184, 14.17880,   0.00000, 0.00000, 180.06200), 5, 12855, "cunte_cop", "sw_PDground", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(3628, 592.85754, -602.20984, 14.17880,   0.00000, 0.00000, 180.06200), 5, 12855, "cunte_cop", "sw_PDground", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19456, 602.42432, -611.52002, 18.00000,   0.00000, 0.00000, 90.00000), 0, 12855, "cunte_cop", "sw_brick05", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19456, 598.28198, -611.52899, 18.00000,   0.00000, 0.00000, 90.00000), 0, 12855, "cunte_cop", "sw_brick05", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19456, 598.22192, -548.45178, 18.00000,   0.00000, 0.00000, 90.06000), 0, 12855, "cunte_cop", "sw_brick05", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19456, 607.84332, -548.43378, 14.54790,   0.00000, 0.00000, 90.06000), 0, 12855, "cunte_cop", "sw_brick05", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19456, 607.56262, -581.98187, 18.00000,   0.00000, 0.00000, 0.04000), 0, 12855, "cunte_cop", "sw_brick05", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19456, 590.62799, -611.52808, 18.00000,   0.00000, 0.00000, 90.00000), 0, 12855, "cunte_cop", "sw_brick05", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19456, 590.53662, -548.45691, 18.00000,   0.00000, 0.00000, 90.06000), 0, 12855, "cunte_cop", "sw_brick05", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19456, 585.81897, -553.20837, 18.00000,   0.00000, 0.00000, 0.10000), 0, 12855, "cunte_cop", "sw_brick05", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19456, 585.82617, -562.83801, 18.00000,   0.00000, 0.00000, 0.06000), 0, 12855, "cunte_cop", "sw_brick05", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19456, 585.83698, -572.45270, 18.00000,   0.00000, 0.00000, 0.10000), 0, 12855, "cunte_cop", "sw_brick05", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19456, 585.85718, -582.06769, 18.00000,   0.00000, 0.00000, 0.10000), 0, 12855, "cunte_cop", "sw_brick05", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19456, 585.87311, -591.67688, 18.00000,   0.00000, 0.00000, 0.10000), 0, 12855, "cunte_cop", "sw_brick05", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19456, 585.88800, -601.29272, 18.00000,   0.00000, 0.00000, 0.04000), 0, 12855, "cunte_cop", "sw_brick05", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19456, 585.89392, -606.71289, 18.00000,   0.00000, 0.00000, 0.04000), 0, 12855, "cunte_cop", "sw_brick05", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19456, 607.84332, -548.43323, 18.00000,   0.00000, 0.00000, 90.06000), 0, 12855, "cunte_cop", "sw_brick05", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19456, 598.23718, -548.46338, 14.54790,   0.00000, 0.00000, 90.06000), 0, 12855, "cunte_cop", "sw_brick05", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19456, 602.42432, -611.52002, 14.56950,   0.00000, 0.00000, 90.00000), 0, 12855, "cunte_cop", "sw_brick05", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 643.96698, -611.91217, 15.07350,   0.00000, 0.00000, 0.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 643.79279, -611.91333, 15.07350,   0.00000, 0.00000, 0.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 643.96887, -610.20343, 15.07350,   0.00000, 0.00000, 0.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 643.79633, -610.20142, 15.07350,   0.00000, 0.00000, 0.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 642.66943, -607.77686, 15.07350,   0.00000, 0.00000, 56.50000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 642.57001, -607.92499, 15.07350,   0.00000, 0.00000, 56.50000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 639.99628, -606.00525, 15.07350,   0.00000, 0.00000, 56.50000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 638.84619, -605.24597, 15.07350,   0.00000, 0.00000, 56.50000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 636.66681, -603.05389, 15.07350,   0.00000, 0.00000, 33.50000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 636.51947, -603.15009, 15.07350,   0.00000, 0.00000, 33.50000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 634.90216, -600.38477, 15.07350,   0.00000, 0.00000, 33.50000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 634.09167, -599.16101, 15.07350,   0.00000, 0.00000, 33.50000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 639.94086, -606.18665, 15.07350,   0.00000, 0.00000, 56.50000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 638.70325, -605.36273, 15.07350,   0.00000, 0.00000, 56.50000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 634.75385, -600.48694, 15.07350,   0.00000, 0.00000, 33.50000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 633.94391, -599.26373, 15.07350,   0.00000, 0.00000, 33.50000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 631.63129, -588.49719, 15.07350,   0.00000, 0.00000, 0.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 631.63342, -585.74628, 15.07350,   0.00000, 0.00000, 0.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 631.45172, -588.49597, 15.07350,   0.00000, 0.00000, 0.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 631.45581, -585.74512, 15.07350,   0.00000, 0.00000, 0.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 631.63342, -585.74628, 15.07350,   0.00000, 0.00000, 0.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 631.45172, -588.49597, 15.07350,   0.00000, 0.00000, 0.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 631.45581, -585.74512, 15.07350,   0.00000, 0.00000, 0.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 631.63000, -582.54132, 15.07350,   0.00000, 0.00000, 0.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 631.62915, -579.34088, 15.07350,   0.00000, 0.00000, 0.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 631.62903, -576.13879, 15.07350,   0.00000, 0.00000, 0.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 630.11047, -573.56281, 15.07350,   0.00000, 0.00000, 90.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 630.11029, -573.70251, 15.07350,   0.00000, 0.00000, 90.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 631.62842, -575.07843, 15.07350,   0.00000, 0.00000, 0.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 631.45892, -582.53632, 15.07350,   0.00000, 0.00000, 0.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 631.46002, -579.33112, 15.07350,   0.00000, 0.00000, 0.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 631.46002, -576.12720, 15.07350,   0.00000, 0.00000, 0.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 631.46008, -575.12482, 15.07350,   0.00000, 0.00000, 0.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 609.54559, -548.34918, 15.45900,   0.00000, 0.00000, 90.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 608.75488, -548.34900, 15.45900,   0.00000, 0.00000, 90.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19367, 604.04871, -548.34900, 15.45900,   0.00000, 0.00000, 90.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19459, 597.63470, -548.34900, 15.45900,   0.00000, 0.00000, 90.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19459, 588.00262, -548.34900, 15.45900,   0.00000, 0.00000, 90.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19459, 585.76630, -591.05731, 15.45900,   0.00000, 0.00000, 0.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19459, 585.76471, -600.67206, 15.45900,   0.00000, 0.00000, 0.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19459, 602.34741, -611.64539, 15.45900,   0.00000, 0.00000, 90.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19459, 592.72327, -611.64301, 15.45900,   0.00000, 0.00000, 90.00000), 0, 12855, "cunte_cop", "ws_bigstones", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(8615, 606.26398, -605.67987, 19.99030,   0.00000, 0.00000, 270.00000), 1, 8615, "vgssstairs1", "gridchev_64HV", 0xFFFFFFFF);
	CreateDynamicObject(966, 633.09253, -597.23779, 15.33030,   0.00000, 0.00000, -78.50000);
	CreateDynamicObject(19967, 631.92249, -589.86713, 15.32800,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1535, 607.28027, -572.49280, 18.18610,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1535, 620.53430, -568.63568, 25.12130,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19124, 618.52032, -571.78693, 24.67420,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19124, 618.46527, -578.67963, 24.67420,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19124, 610.84039, -571.80542, 24.67420,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19124, 610.79688, -578.67499, 24.67420,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19876, 666.71948, -565.11841, 17.33400,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1569, 626.59003, -573.30670, 16.90920,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1569, 626.59003, -570.32129, 16.90920,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1535, 605.63623, -548.41302, 15.55880,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3626, 608.76538, -554.46753, 19.67320,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1238, 636.32654, -573.37927, 15.66260,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1238, 636.34125, -570.29871, 15.66260,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1238, 636.35712, -567.49078, 15.66260,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1238, 636.33752, -575.97644, 15.66260,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(983, 601.88910, -611.52161, 20.41960,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(983, 595.48553, -611.52136, 20.41960,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(983, 589.08350, -611.52887, 20.41960,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(983, 608.28882, -611.51642, 20.41960,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(982, 585.86932, -598.70007, 20.41960,   0.00000, 0.00000, 0.10000);
	CreateDynamicObject(982, 585.80841, -573.08795, 20.41960,   0.00000, 0.00000, 0.10000);
	CreateDynamicObject(983, 585.80499, -551.65051, 20.41960,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(983, 585.79010, -558.03339, 20.40960,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(982, 598.60260, -548.47931, 20.41960,   0.00000, 0.00000, 90.10000);
	CreateDynamicObject(970, 631.71436, -563.48926, 15.88000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(970, 631.70538, -559.34967, 15.88000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(970, 631.69714, -555.20990, 15.88000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(970, 631.70770, -551.09027, 15.88000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(970, 631.69812, -546.97009, 15.88000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2921, 611.26764, -547.93256, 18.99260,   0.00000, 0.00000, 11.00000);
	CreateDynamicObject(11245, 630.95117, -571.85486, 20.66030,   0.00000, 0.00000, -1.50000);
	CreateDynamicObject(2047, 628.23523, -574.53430, 18.89830,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2048, 628.23523, -568.90308, 18.89830,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(970, 631.71442, -567.61011, 15.88000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(970, 618.34302, -595.59778, 22.16150,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(970, 618.33728, -599.71472, 22.16150,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(970, 618.34399, -611.91418, 22.16150,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(970, 618.34052, -607.79279, 22.16150,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(970, 616.25140, -593.52869, 22.16150,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 612.13776, -593.53320, 22.16150,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 609.24658, -593.53992, 22.16150,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 607.17456, -595.60962, 22.16150,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(970, 607.17767, -599.74219, 22.16150,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(970, 607.17615, -603.86298, 22.16150,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(970, 616.26672, -613.98383, 22.16150,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 612.15668, -613.98438, 22.16150,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 609.26099, -613.97522, 22.16150,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 607.19342, -611.91040, 22.16150,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(970, 607.17358, -605.56299, 22.16150,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(3934, 612.96191, -597.85541, 21.71690,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3934, 612.90540, -609.52570, 21.71690,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3934, 614.74408, -575.14911, 25.12820,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19978, 633.67151, -598.40015, 13.57930,   0.00000, 0.00000, 123.50000);

	//Dillimore ori obiekty + warsztat nowy

	CreateDynamicObject(3172, 760.97302, -621.90448, 14.35400,   0.00000, 0.00000, 273.00000);
	CreateDynamicObject(3168, 744.24841, -620.34210, 14.12540,   0.00000, 0.00000, -98.00000);
	CreateDynamicObject(3171, 728.41718, -615.94421, 14.74680,   -2.00000, 0.00000, -113.00000);
	CreateDynamicObject(3172, 743.78119, -610.13599, 14.36200,   0.00000, 0.00000, 84.00000);
	CreateDynamicObject(3171, 761.03967, -611.06677, 14.35150,   0.00000, 0.00000, 98.00000);
	CreateDynamicObject(12843, 661.80762, -615.11731, 15.32690,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(12844, 664.78497, -615.12372, 17.31310,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(12845, 664.67883, -615.42078, 17.42320,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1514, 662.87622, -616.42407, 16.47620,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1496, 659.08917, -610.44202, 14.99190,   0.00000, 0.00000, -98.00000);
	CreateDynamicObject(1496, 660.59027, -610.44092, 14.99190,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2911, 670.89130, -619.95532, 15.33490,   0.00000, 0.00000, 91.00000);
	CreateDynamicObject(1688, 662.48383, -617.28607, 20.64340,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1691, 667.73389, -614.26062, 20.04420,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 646.35358, -624.00549, 15.89151,   0.00000, 358.75000, 261.24390);
	CreateDynamicObject(970, 645.39966, -628.01910, 15.99151,   0.00000, 357.99756, 252.48840);
	dodajBudke(1346, 669.06531, -578.51605, 16.68690,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1366, 669.10449, -451.33594, 15.87443,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1367, 632.08533, -568.30798, 15.93089,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(983, 654.76001, -560.56744, 16.01949,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(983, 656.51099, -560.57556, 16.01949,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(983, 654.75427, -569.44574, 16.01949,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(983, 656.50439, -569.46112, 16.01949,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 669.48309, -590.13104, 15.83742,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 665.35132, -590.13751, 15.83742,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 651.71454, -542.21039, 15.83742,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(970, 653.79504, -540.13232, 15.83742,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2656, 662.83984, -577.65137, 17.14565,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18066, 655.93896, -571.22992, 17.85139,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18066, 655.96631, -569.62903, 17.85139,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18066, 655.35455, -569.58771, 17.85139,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(18066, 655.36548, -571.16895, 17.85139,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2656, 655.64880, -571.84943, 16.62066,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2456, 661.48743, -551.87683, 15.33594,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2714, 655.70508, -576.34668, 20.25476,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3467, 655.41589, -539.90564, 16.03875,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(3467, 663.71973, -590.41113, 16.02536,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2657, 655.67279, -558.30487, 16.63619,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(848, 653.19342, -639.49213, 17.06846,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1359, 685.96466, -475.80988, 15.95950,   0.00000, 0.00000, 0.00000);
	dodajBudke(1363, 671.38098, -474.01807, 16.29730,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(6299, 702.11133, -445.31055, 17.30633,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1776, 689.16309, -470.21024, 16.58569,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3057, 710.62372, -469.70047, 16.48033,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3948, 774.40698, -425.51099, 25.47232,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18269, 685.00378, -418.68073, 41.18134,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1238, 712.02179, -475.10861, 15.66188,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1342, 691.65808, -474.43195, 16.54463,   0.00000, 0.00000, 90.00000);
	dodajBudke(1346, 651.05078, -436.92383, 16.68694,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2837, 656.01355, -440.28470, 15.33594,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2860, 655.19885, -440.31714, 15.33594,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(924, 652.71332, -467.39441, 16.01703,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1359, 677.08582, -475.62445, 15.95950,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3302, 663.04688, -441.69531, 15.81969,   27.48230, 1.97205, 0.33508);
	CreateDynamicObject(3035, 663.16406, -439.50781, 16.10607,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3006, 718.18365, -438.88284, 15.33594,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2971, 665.47852, -439.53693, 15.33594,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2907, 662.02502, -438.86050, 15.49597,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3006, 662.70831, -440.22168, 15.03594,   0.00000, 0.00000, 92.00000);
	CreateDynamicObject(2890, 674.10742, -447.14529, 15.31094,   0.00000, 0.00000, 272.00000);
	CreateDynamicObject(2900, 725.94922, -438.59122, 15.33594,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2953, 715.25513, -472.54434, 15.34743,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2840, 725.28094, -464.37375, 15.33594,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(970, 651.73846, -440.00952, 15.86242,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(970, 651.73438, -444.13477, 15.86242,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(970, 651.73212, -448.28644, 15.86242,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(970, 651.72906, -452.43793, 15.86242,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(970, 651.72559, -456.56412, 15.86242,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(970, 651.74915, -460.73929, 15.86242,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(970, 651.72247, -464.91672, 15.86242,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1238, 726.41016, -475.28906, 15.65412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1238, 714.64160, -475.15430, 15.66188,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1238, 724.08868, -475.20511, 15.65412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1280, 657.14496, -472.29327, 15.73729,   0.00000, 0.00000, 260.00000);
	CreateDynamicObject(1280, 654.28546, -469.43292, 15.76229,   0.00000, 0.00000, 177.99695);
	CreateDynamicObject(1280, 714.86829, -452.74292, 15.73729,   0.00000, 0.00000, 355.49463);
	CreateDynamicObject(1280, 672.50995, -457.45828, 15.93765,   0.00000, 0.00000, 79.49463);
	CreateDynamicObject(1280, 656.50580, -475.51657, 15.73729,   0.00000, 0.00000, 91.49158);
	CreateDynamicObject(1280, 689.45819, -475.60629, 15.73729,   0.00000, 0.00000, 91.48865);
	CreateDynamicObject(1280, 725.98340, -470.86133, 15.73729,   0.00000, 0.00000, 3.48816);
	CreateDynamicObject(3497, 645.13605, -520.58362, 19.40104,   0.00000, 0.00000, 182.00000);
	CreateDynamicObject(3861, 723.91895, -444.12207, 16.50827,   0.00000, 0.00000, 179.99451);
	CreateDynamicObject(3861, 715.75378, -439.44589, 16.50827,   0.00000, 0.00000, 1.99451);
	CreateDynamicObject(3006, 660.65137, -439.17578, 15.33594,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3006, 713.52954, -441.03360, 15.33594,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3006, 721.15143, -444.78250, 15.33594,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1238, 711.61682, -452.31143, 15.65412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1375, 688.37128, -614.05072, 17.02595,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1887, 801.78387, -716.01434, 78.52293,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(918, 805.21216, -612.54596, 15.70747,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1361, 692.79785, -589.57520, 21.07964,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1280, 810.97461, -605.54669, 15.73729,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1280, 806.78027, -605.29962, 15.74460,   0.00000, 0.00000, 268.00000);
	CreateDynamicObject(1526, 811.52393, -614.12878, 16.61320,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1258, 802.44867, -605.80585, 16.00496,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2900, 835.38403, -605.78662, 15.33594,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1449, 802.33826, -613.86743, 15.85759,   0.00000, 0.00000, 178.00000);
	CreateDynamicObject(1372, 835.40137, -614.72119, 15.34324,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1358, 834.62036, -608.66107, 16.53948,   0.00000, 0.00000, 274.00000);
	CreateDynamicObject(1338, 833.12256, -605.22626, 16.04725,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1224, 835.50201, -611.67365, 15.95085,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1265, 833.91730, -607.99725, 17.40753,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1300, 808.84351, -605.82690, 15.70585,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2670, 811.87726, -605.22455, 15.49514,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1428, 824.49335, -613.27930, 16.90379,   0.00000, 0.00000, 184.00000);
	CreateDynamicObject(1345, 785.99219, -612.45117, 16.10607,   0.00000, 0.00000, 181.99951);
	CreateDynamicObject(1224, 780.34564, -596.68341, 15.95085,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1355, 781.20044, -593.23065, 15.53290,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1300, 784.97168, -543.55469, 15.70585,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1236, 794.00378, -612.70233, 16.00597,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1441, 867.44342, -587.26331, 17.68738,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3273, 863.68652, -579.75586, 17.07030,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3273, 859.60938, -579.71777, 17.07030,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3273, 855.38965, -579.61133, 17.07030,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3287, 867.21252, -585.10059, 21.83553,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3643, 839.99243, -610.59137, 22.99385,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3675, 864.54510, -584.27063, 18.73555,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(3675, 864.54590, -585.22461, 18.73555,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(920, 850.23535, -581.01563, 17.69602,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(929, 848.85449, -580.00586, 18.20067,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1353, 848.86133, -582.79785, 17.83169,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1420, 848.70148, -583.96411, 17.12841,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1687, 850.05566, -585.09961, 17.90790,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1688, 863.42871, -582.78418, 18.18431,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3259, 872.81683, -613.30902, 17.42188,   0.00000, 0.00000, 88.00000);
	CreateDynamicObject(12957, 814.79028, -564.84790, 16.21416,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1230, 814.71362, -564.34473, 16.55625,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2671, 816.85077, -564.85352, 15.61017,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1526, 690.93982, -456.46127, 16.39889,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1255, 739.04614, -487.50693, 16.59260,   0.00000, 0.00000, 329.99817);
	CreateDynamicObject(1255, 739.87891, -485.90802, 16.59260,   0.00000, 0.00000, 329.99634);
	CreateDynamicObject(1255, 777.20813, -517.20032, 16.11760,   0.00000, 0.00000, 239.99631);
	CreateDynamicObject(1446, 809.50623, -520.03369, 16.07030,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1446, 814.18549, -520.03802, 16.07030,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1446, 824.33722, -517.79419, 16.20070,   0.00000, -3.00000, 91.00000);
	CreateDynamicObject(1446, 824.25720, -513.09412, 16.45070,   0.00000, -3.00000, 91.00000);
	CreateDynamicObject(1446, 824.17719, -508.39941, 16.69070,   0.00000, -3.00000, 91.00000);
	CreateDynamicObject(1446, 824.10718, -503.70959, 16.93070,   0.00000, -3.00000, 91.00000);
	CreateDynamicObject(1446, 769.03418, -589.67169, 18.13050,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1446, 731.81647, -599.57678, 16.08000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1446, 731.82208, -594.89307, 16.08000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1446, 778.72827, -520.00555, 16.08000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1446, 774.03931, -520.00562, 16.08000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1255, 804.07422, -516.90723, 16.16760,   -4.00000, 4.00000, 240.00000);
	CreateDynamicObject(1481, 796.12952, -494.11169, 17.71970,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1481, 742.24298, -497.51810, 17.71080,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1255, 803.16779, -515.07660, 16.31760,   -4.00000, 4.00000, 240.00000);
	CreateDynamicObject(1446, 734.61377, -540.27295, 16.07030,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1446, 739.29407, -540.27643, 16.07030,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19815, 785.46832, -485.09299, 17.99890,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1499, 638.74847, -495.23230, 15.33310,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8948, 644.81567, -495.22672, 18.88160,   0.00000, 98.00000, 270.00000);
	CreateDynamicObject(10281, 644.91089, -494.34619, 21.03220,   0.00000, 0.00000, -180.00000);
	CreateDynamicObject(19817, 648.53619, -505.28769, 14.78190,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19325, 636.82452, -519.56207, 17.31970,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19815, 636.70959, -501.40210, 17.20000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19903, 646.13660, -510.67258, 15.33270,   0.00000, 0.00000, 116.00000);
	CreateDynamicObject(19899, 637.17633, -497.62378, 15.33231,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19899, 643.61414, -511.35022, 15.33320,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19897, 642.63000, -511.03711, 16.59550,   0.00000, 0.00000, 200.00000);
	CreateDynamicObject(2525, 632.22418, -506.87189, 15.33430,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2739, 633.23822, -505.24295, 15.33433,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1502, 635.67957, -507.91220, 15.33310,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1502, 637.10931, -510.14200, 15.33340,   0.00000, 0.00000, -48.00000);
	CreateDynamicObject(2685, 633.98163, -504.80710, 16.78870,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2520, 635.84906, -506.25858, 15.33467,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1083, 636.84967, -499.62219, 15.80510,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19308, 644.40601, -511.32321, 17.07670,   0.00000, 0.00000, 55.00000);
	CreateDynamicObject(18635, 643.20667, -511.32480, 16.58430,   90.00000, 105.00000, 0.00000);
	CreateDynamicObject(1663, 636.91730, -516.64032, 15.79340,   0.00000, 0.00000, 84.00000);
	CreateDynamicObject(1714, 639.85229, -517.14453, 15.33400,   0.00000, 0.00000, -105.00000);
	CreateDynamicObject(1728, 632.36774, -514.83594, 15.33350,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1729, 633.91461, -515.77588, 15.33360,   0.00000, 0.00000, 149.00000);
	CreateDynamicObject(1516, 635.34448, -513.82495, 15.50340,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1791, 635.63171, -513.82520, 16.02790,   0.00000, 0.00000, -76.00000);
	CreateDynamicObject(2008, 638.29712, -517.51166, 15.33160,   0.00000, 0.00000, 69.00000);
	CreateDynamicObject(1893, 644.11584, -503.02936, 19.91422,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(CreateDynamicObject(19380, 646.46930, -499.96680, 20.00740,   0.00000, 90.00000, 0.00000), 0, 12862, "sw_block03", "desgrns256", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19380, 646.46930, -509.58051, 20.00740,   0.00000, 90.00000, 0.00000), 0, 12862, "sw_block03", "desgrns256", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19380, 636.49780, -514.84998, 20.00750,   0.00000, 90.00000, 0.00000), 0, 12862, "sw_block03", "desgrns256", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19380, 636.49780, -499.96680, 20.00740,   0.00000, 90.00000, 0.00000), 0, 12862, "sw_block03", "desgrns256", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19380, 636.49780, -508.33289, 20.00750,   0.00000, 90.00000, 0.00000), 0, 12862, "sw_block03", "desgrns256", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19805, 637.62738, -510.72839, 18.50300,   0.00000, -180.00000, -229.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19805, 634.90314, -507.91986, 18.50300,   0.00000, -180.00000, 0.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19805, 639.79822, -495.24771, 18.49300,   0.00000, -180.00000, 180.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19363, 650.11218, -495.22220, 18.17420,   0.00000, 0.00000, 90.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19363, 641.80402, -518.05389, 14.67240,   0.00000, 0.00000, 0.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19363, 641.80402, -515.00128, 14.67240,   0.00000, 0.00000, 0.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19436, 641.80402, -512.60211, 14.67240,   0.00000, 0.00000, 0.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19363, 641.80402, -518.05389, 18.17420,   0.00000, 0.00000, 0.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19363, 641.80402, -515.00128, 18.17420,   0.00000, 0.00000, 0.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19436, 641.80402, -512.60211, 18.17420,   0.00000, 0.00000, 0.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19363, 635.10950, -504.69031, 18.17420,   0.00000, 0.00000, 90.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19436, 631.30487, -519.57269, 14.67240,   0.00000, 0.00000, 90.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19409, 634.44061, -519.57257, 18.17420,   0.00000, 0.00000, 90.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19392, 639.52972, -495.22220, 18.17420,   0.00000, 0.00000, 90.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19455, 636.92188, -519.57269, 14.67240,   0.00000, 0.00000, 90.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19409, 639.24408, -519.57257, 18.17420,   0.00000, 0.00000, 90.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19436, 641.64398, -519.57257, 18.17420,   0.00000, 0.00000, 90.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19436, 632.03998, -519.57257, 18.17420,   0.00000, 0.00000, 90.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19436, 636.84058, -519.57257, 18.17420,   0.00000, 0.00000, 90.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19455, 631.32458, -514.66687, 18.17420,   0.00000, 0.00000, 0.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19455, 631.32458, -505.03241, 18.17420,   0.00000, 0.00000, 0.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19455, 631.63483, -514.67078, 18.17420,   0.00000, 0.00000, 0.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19455, 631.63483, -505.03900, 14.67240,   0.00000, 0.00000, 0.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19455, 631.64911, -514.65680, 14.67240,   0.00000, 0.00000, 0.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19455, 631.63483, -505.03900, 18.17420,   0.00000, 0.00000, 0.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19455, 646.52850, -511.86890, 14.67240,   0.00000, 0.00000, 90.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19455, 646.52850, -511.86890, 18.17420,   0.00000, 0.00000, 90.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19436, 652.14807, -511.86890, 14.67240,   0.00000, 0.00000, 90.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19436, 652.14807, -511.86890, 18.17420,   0.00000, 0.00000, 90.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19436, 637.12280, -495.22220, 14.67240,   0.00000, 0.00000, 90.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19455, 631.89728, -504.68509, 14.67240,   0.00000, 0.00000, 90.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19455, 636.64038, -499.95941, 14.67240,   0.00000, 0.00000, 0.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19455, 636.64038, -499.95941, 18.17420,   0.00000, 0.00000, 0.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19363, 632.86951, -504.69019, 18.17420,   0.00000, 0.00000, 90.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19455, 651.63770, -499.95099, 14.67240,   0.00000, 0.00000, 0.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19455, 651.63770, -509.58151, 14.67240,   0.00000, 0.00000, 0.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19455, 651.63770, -509.58151, 18.17420,   0.00000, 0.00000, 0.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19455, 651.63770, -499.95099, 18.17420,   0.00000, 0.00000, 0.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19363, 650.11218, -495.22220, 14.67240,   0.00000, 0.00000, 90.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19436, 637.12280, -495.22220, 18.17420,   0.00000, 0.00000, 90.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19392, 639.52972, -495.22220, 14.67240,   180.00000, 0.00000, 270.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19363, 636.64038, -506.37460, 14.67240,   0.00000, 0.00000, 0.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19392, 637.66309, -510.70477, 14.67240,   180.00000, 0.00000, 221.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19363, 640.26074, -511.87955, 14.67240,   0.00000, 0.00000, 90.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19436, 636.64038, -508.77740, 14.67240,   0.00000, 0.00000, 0.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19392, 637.66309, -510.70480, 18.17420,   0.00000, 0.00000, 41.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19363, 640.26068, -511.87949, 18.17420,   0.00000, 0.00000, 90.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19363, 636.64038, -506.37460, 18.17420,   0.00000, 0.00000, 0.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19436, 636.64038, -508.77740, 18.17420,   0.00000, 0.00000, 0.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19392, 634.92755, -507.95728, 14.67240,   180.00000, 0.00000, 270.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19392, 634.92761, -507.95731, 18.17420,   0.00000, 0.00000, 90.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19363, 631.71777, -507.95731, 14.67240,   0.00000, 0.00000, 90.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19363, 631.71777, -507.95731, 18.17420,   0.00000, 0.00000, 90.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19455, 644.86450, -495.23181, 20.67270,   180.00000, 0.00000, 270.00000), 0, 12862, "sw_block03", "sw_wall03", 0xFFFFFFFF);

	//bramka LS-LV
	CreateDynamicObject(9623, 1700.67847, 415.62292, 32.45000,   -0.70000, 0.00000, 160.88310);
	CreateDynamicObject(19124, 1704.91785, 402.90421, 30.03000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19425, 1703.72119, 409.86484, 29.65380,   -1.00000, 0.00000, 160.00000);
	CreateDynamicObject(19425, 1698.30432, 421.14938, 29.79210,   0.00000, 0.00000, 160.00000);
	CreateDynamicObject(19425, 1712.31775, 406.83768, 29.65380,   -1.00000, 0.00000, 160.00000);
	CreateDynamicObject(19425, 1688.75378, 424.60980, 29.81210,   0.00000, -1.00000, 160.00000);
	CreateDynamicObject(963, 1709.99280, 413.14929, 31.63300,   90.00000, 71.26000, 0.00000);
	CreateDynamicObject(963, 1701.86975, 415.94562, 31.63300,   89.58000, 71.26000, 0.00000);
	CreateDynamicObject(963, 1700.44861, 414.94760, 31.61300,   90.00000, -109.20000, 0.00000);
	CreateDynamicObject(963, 1691.52979, 418.04034, 31.61300,   90.00000, -109.20000, 0.00000);
	CreateDynamicObject(7415, 1792.48169, 722.42346, 22.75190,   0.00000, 0.00000, 110.00000);
	CreateDynamicObject(3578, 1700.33887, 413.11960, 29.63810,   0.00000, 0.00000, 71.00000);
	CreateDynamicObject(966, 1682.57898, 416.67038, 29.59280,   0.00000, 0.00000, 5200.00000);
	CreateDynamicObject(966, 1698.59839, 410.91818, 29.59280,   0.00000, 0.00000, 340.00000);
	CreateDynamicObject(966, 1703.75867, 420.08932, 29.59280,   0.00000, 0.00000, 520.00000);
	CreateDynamicObject(966, 1718.24146, 414.86954, 29.59280,   0.00000, 0.00000, 340.00000);
	CreateDynamicObject(19966, 1707.67712, 408.05740, 29.90130,   0.00000, 0.00000, 340.00000);
	CreateDynamicObject(19966, 1693.80286, 423.23169, 29.90130,   0.00000, 0.00000, 160.00000);
	CreateDynamicObject(984, 1718.47156, 414.78619, 30.61740,   1.08000, 0.00000, -19.00000);
	CreateDynamicObject(984, 1714.27209, 402.68610, 30.35740,   1.08000, 0.00000, -19.00000);
	CreateDynamicObject(984, 1711.10071, 390.33719, 30.01740,   2.00000, 0.00000, -10.00000);
	CreateDynamicObject(984, 1723.84949, 426.35001, 30.69740,   -0.34000, -0.30000, -31.00000);
	CreateDynamicObject(984, 1682.32361, 416.75189, 30.39930,   0.84000, 0.00000, -19.84000);
	CreateDynamicObject(983, 1678.89343, 407.78680, 30.25280,   1.62000, 0.00000, -23.06000);
	CreateDynamicObject(984, 1686.66528, 428.79489, 30.57930,   0.84000, 0.00000, -19.84000);
	CreateDynamicObject(984, 1689.89600, 441.09741, 30.71930,   0.34000, 0.00000, -9.78000);
	CreateDynamicObject(19124, 1706.74585, 402.32761, 30.03000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19124, 1705.39038, 401.21518, 29.99000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19124, 1696.57642, 427.89606, 30.39000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19124, 1694.59277, 428.56610, 30.39000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19124, 1696.08496, 429.66446, 30.37000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2921, 1711.05334, 414.81812, 33.35170,   0.00000, 0.00000, -236.00000);
	CreateDynamicObject(2921, 1702.93457, 417.67300, 33.35170,   0.00000, 0.00000, -236.00000);
	CreateDynamicObject(2921, 1699.28894, 413.16400, 33.35170,   0.00000, 0.00000, -55.00000);
	CreateDynamicObject(2921, 1690.35742, 416.26501, 33.35170,   0.00000, 0.00000, -55.00000);
	CreateDynamicObject(1290, 1702.73132, 420.37283, 30.99820,   0.00000, 0.00000, -19.00000);
	CreateDynamicObject(1290, 1699.46692, 410.66641, 30.99820,   0.00000, 0.00000, -19.00000);

	//bramka na mostku
	CreateDynamicObject(966, 526.86566, 475.89520, 17.92650,   0.00000, 0.00000, 35.00000);
	CreateDynamicObject(966, 515.28510, 467.78699, 17.92650,   0.00000, 0.00000, -145.00000);
	CreateDynamicObject(16003, 522.11023, 470.30200, 19.38860,   0.00000, 0.00000, 124.50000);
	CreateDynamicObject(16003, 519.97809, 473.41461, 19.38860,   0.00000, 0.00000, -54.50000);
	CreateDynamicObject(19124, 522.60223, 468.16452, 18.50750,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19124, 523.91473, 469.07925, 18.50750,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19124, 523.98309, 467.63699, 18.50750,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19124, 518.05383, 474.66306, 18.50750,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19124, 519.33832, 475.58423, 18.50750,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19124, 518.13879, 475.97781, 18.50750,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19966, 518.78986, 475.08939, 17.92710,   0.00000, 0.00000, -144.00000);
	CreateDynamicObject(19966, 523.32788, 468.61636, 17.92710,   0.00000, 0.00000, 36.00000);
	CreateDynamicObject(963, 523.47748, 469.87521, 18.96950,   91.00000, 0.00000, -236.00000);
	CreateDynamicObject(963, 518.60059, 473.81635, 18.96950,   91.00000, 0.00000, -55.00000);
	CreateDynamicObject(2921, 525.49121, 480.11371, 20.70210,   0.00000, 0.00000, 127.00000);
	CreateDynamicObject(2921, 516.54395, 463.74863, 20.70210,   0.00000, 0.00000, -55.00000);

	//bramka na mostku 2

	CreateDynamicObject(966, -161.65366, 363.51865, 11.07200,   0.00000, 0.00000, -14.10000);
	CreateDynamicObject(966, -175.38094, 367.07813, 11.07200,   0.00000, 0.00000, 165.10001);
	CreateDynamicObject(16003, -169.04900, 363.39331, 12.50970,   0.00000, 0.00000, 75.50000);
	CreateDynamicObject(16003, -168.03951, 367.09109, 12.50970,   0.00000, 0.00000, -104.50000);
	CreateDynamicObject(19966, -169.52684, 361.44318, 11.07530,   0.00000, 0.00000, -14.00000);
	CreateDynamicObject(19966, -167.54770, 369.04947, 11.07530,   0.00000, 0.00000, -193.00000);
	CreateDynamicObject(19124, -166.74754, 368.79623, 11.57450,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19124, -168.38210, 369.24054, 11.57450,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19124, -167.30669, 369.97318, 11.57450,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19124, -170.36810, 361.64166, 11.57450,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19124, -168.75243, 361.24225, 11.57450,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19124, -169.88586, 360.26483, 11.57450,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(963, -168.43980, 362.07431, 12.13580,   91.00000, 76.00000, 0.00000);
	CreateDynamicObject(963, -168.63217, 368.41190, 12.13580,   91.00000, 76.00000, -180.00000);
	CreateDynamicObject(2921, -160.33311, 363.04166, 16.18030,   0.00000, 0.00000, 62.00000);
	CreateDynamicObject(2921, -176.36461, 367.78964, 16.18030,   0.00000, 0.00000, -113.00000);

	//bramka na mostku 3

	CreateDynamicObject(966, -960.20862, -342.53021, 35.27810,   0.00000, 0.00000, -11.00000);
	CreateDynamicObject(966, -973.93781, -339.85959, 35.27810,   0.00000, 0.00000, -191.00000);
	CreateDynamicObject(967, -973.59680, -338.73865, 35.77270,   0.00000, 0.00000, -280.00000);
	CreateDynamicObject(967, -960.49591, -343.72879, 35.39270,   0.00000, 0.00000, -101.00000);
	CreateDynamicObject(963, -967.79590, -344.15698, 36.33110,   91.00000, 0.00000, 79.00000);
	CreateDynamicObject(963, -966.42505, -338.49707, 36.33110,   91.00000, 0.00000, -101.00000);
	CreateDynamicObject(19124, -966.31183, -337.18256, 35.84060,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19124, -967.95770, -345.63037, 35.84060,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19870, -979.04089, -338.97461, 35.11800,   0.00000, 0.00000, -11.00000);
	CreateDynamicObject(19870, -975.82458, -339.60440, 35.11800,   0.00000, 0.00000, -191.00000);
	CreateDynamicObject(19870, -959.87341, -342.57401, 34.95800,   0.00000, 0.00000, -11.00000);
	CreateDynamicObject(1223, -967.43262, -342.97061, 35.28120,   0.00000, 0.00000, -11.00000);
	CreateDynamicObject(1223, -966.80621, -339.73047, 35.28120,   0.00000, 0.00000, -193.00000);
	CreateDynamicObject(1294, -968.99402, -339.53409, 394921.00000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2921, -979.37262, -341.93469, 39.13860,   0.00000, 0.00000, -142.00000);
	CreateDynamicObject(2921, -956.18170, -339.76587, 39.54350,   0.00000, 0.00000, 40.00000);

	//tunel

	CreateDynamicObject(966, -1225.40222, -783.32697, 62.90020,   0.00000, 0.00000, 222.00000);
	CreateDynamicObject(966, -1215.18701, -773.66797, 62.90020,   0.00000, 0.00000, 45.00000);
	CreateDynamicObject(963, -1221.87708, -776.40302, 63.96360,   91.00000, -3.00000, -47.00000);
	CreateDynamicObject(963, -1218.24756, -780.76978, 63.96360,   91.00000, -3.00000, 137.00000);
	CreateDynamicObject(19124, -1222.70862, -775.66168, 63.44290,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19124, -1217.37451, -781.50177, 63.54290,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1290, -1219.86743, -778.91980, 64.34730,   0.00000, 0.00000, 42.00000);
	CreateDynamicObject(19966, -1216.95007, -781.96417, 63.02060,   0.00000, 0.00000, 55.00000);
	CreateDynamicObject(19966, -1223.05139, -775.24927, 62.88660,   0.00000, 0.00000, 251.00000);
	CreateDynamicObject(2921, -1224.84888, -783.42230, 66.74380,   0.00000, 0.00000, -47.00000);
	CreateDynamicObject(2921, -1219.83459, -778.90045, 66.74380,   0.00000, 0.00000, 193.00000);

	//tunel 2

	CreateDynamicObject(18452, -11.44068, -1335.23279, 12.96710,   0.00000, 0.00000, 39.00000);
	CreateDynamicObject(18452, -15.00210, -1330.85693, 12.96720,   0.00000, 0.00000, 39.00000);
	CreateDynamicObject(19425, -8.96410, -1333.19055, 10.07680,   0.00000, 0.00000, 128.50000);
	CreateDynamicObject(19425, -12.50500, -1328.74500, 10.07680,   0.00000, 0.00000, 128.50000);
	CreateDynamicObject(966, -11.57243, -1340.70703, 9.98560,   0.00000, 0.00000, -51.00000);
	CreateDynamicObject(966, -20.29900, -1329.81616, 9.98560,   0.00000, 0.00000, 128.39999);
	CreateDynamicObject(963, -13.22130, -1333.08704, 11.25640,   91.00000, 0.00000, -141.50000);
	CreateDynamicObject(963, -9.67255, -1337.54431, 11.25640,   91.00000, 0.00000, -141.50000);
	CreateDynamicObject(8674, -7.59040, -1336.24524, 10.21320,   0.00000, 0.00000, 39.50000);
	CreateDynamicObject(8674, -15.17082, -1326.89124, 10.21320,   0.00000, 0.00000, 39.30000);
	CreateDynamicObject(8674, 1.01842, -1330.69324, 10.21320,   0.00000, 0.00000, 26.00000);
	CreateDynamicObject(8674, -8.04594, -1319.50195, 10.21320,   0.00000, 0.00000, 53.00000);
	CreateDynamicObject(2921, -11.69689, -1339.00903, 13.50840,   0.00000, 0.00000, -76.00000);
	CreateDynamicObject(2921, -15.20977, -1334.60083, 13.50840,   0.00000, 0.00000, -76.00000);
	CreateDynamicObject(19124, -10.77120, -1331.04895, 10.72360,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19124, -7.19430, -1335.42456, 10.72360,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19124, -14.37601, -1326.66675, 10.72360,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19966, -10.93470, -1331.18799, 10.10250,   0.00000, 0.00000, 129.00000);
	CreateDynamicObject(1294, -10.42800, -1336.55688, 10.59240,   0.00000, 0.00000, -50.00000);
	CreateDynamicObject(1294, -13.98330, -1332.10632, 10.59240,   0.00000, 0.00000, -50.00000);
	CreateDynamicObject(18452, 17.66410, -1341.25195, 11.94710,   0.00000, 1.30000, 39.00000);
	CreateDynamicObject(18452, 21.23414, -1345.62598, 11.94710,   0.00000, 1.30000, 39.00000);
	CreateDynamicObject(19425, 18.66861, -1347.69543, 9.10720,   0.00000, 0.00000, -51.00000);
	CreateDynamicObject(19425, 15.16863, -1343.32141, 9.10720,   0.00000, 0.00000, -51.00000);
	CreateDynamicObject(963, 15.88277, -1338.96082, 10.23640,   91.00000, 0.00000, 40.00000);
	CreateDynamicObject(963, 19.49687, -1343.33484, 10.23640,   91.00000, 0.00000, 40.00000);
	CreateDynamicObject(19966, 17.11130, -1345.33167, 9.27190,   0.00000, 0.00000, -51.00000);
	CreateDynamicObject(1294, 16.65530, -1339.92004, 9.53060,   0.00000, 0.00000, 129.00000);
	CreateDynamicObject(1294, 20.24140, -1344.34387, 9.53060,   0.00000, 0.00000, 129.00000);
	CreateDynamicObject(966, 18.13322, -1335.57751, 9.02570,   0.00000, 0.00000, 128.00000);
	CreateDynamicObject(966, 26.72598, -1346.60254, 9.02570,   0.00000, 0.00000, -52.00000);
	CreateDynamicObject(2921, 17.96230, -1337.44128, 12.74650,   0.00000, 0.00000, 98.00000);
	CreateDynamicObject(2921, 21.52854, -1341.85144, 12.74650,   0.00000, 0.00000, 98.00000);
	CreateDynamicObject(13677, 92.21875, -1291.65625, 14.11719,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8674, 13.79352, -1340.17395, 9.22080,   0.00000, 0.00000, 39.00000);
	CreateDynamicObject(8674, 5.12582, -1345.59473, 9.22080,   0.00000, 0.00000, 25.00000);
	CreateDynamicObject(8674, 21.39732, -1349.56360, 9.22080,   0.00000, 0.00000, 39.00000);
	CreateDynamicObject(8674, 14.22279, -1356.86035, 9.22080,   0.00000, 0.00000, 52.00000);
	CreateDynamicObject(19124, 16.88520, -1345.49231, 9.78990,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19124, 13.34975, -1341.08533, 9.78990,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19124, 20.39497, -1349.91016, 9.78990,   0.00000, 0.00000, 0.00000);
}

/* Stare obiekty dillimore

stock Dillimore_Load() 
{
	//z bus.pwn (sklep monopolowy)
	CreateDynamicObject(3171,762.48890000,-611.13370000,13.99870000,0.00000000,0.00000000,105.54280000,0,0); //
	CreateDynamicObject(12844,664.86690000,-614.59920000,17.37890000,0.00000000,0.00000000,180.00000000,0,0); //
	CreateDynamicObject(12843,661.94280000,-614.55990000,15.33590000,0.00000000,0.00000000,180.00000000,0,0); //
	CreateDynamicObject(12845,664.83970000,-614.25170000,17.58480000,0.00000000,0.00000000,180.00000000,0,0); //
	CreateDynamicObject(1447,671.51060000,-622.12400000,16.61540000,0.00000000,0.00000000,269.66520000,0,0); //
	CreateDynamicObject(11470,666.67040000,-513.92070000,26.20260000,0.00000000,0.00000000,221.07190000,0,0); //
	CreateDynamicObject(3252,753.64060000,-611.00230000,14.48640000,0.00000000,0.00000000,0.00000000,0,0); //
	CreateDynamicObject(7908,681.11520000,-451.23800000,-23.58640000,0.00000000,0.00000000,178.31900000,0,0); //
	CreateDynamicObject(14593,687.50330000,-555.92430000,-77.70900000,0.00000000,0.00000000,0.00000000,0,0); //
	CreateDynamicObject(1506,693.45140000,-569.72480000,-80.00870000,0.00000000,0.00000000,0.00000000,0,0); //
	CreateDynamicObject(1491,693.49360000,-563.55780000,-80.03710000,0.00000000,0.00000000,0.00000000,0,0); //
	CreateDynamicObject(986,694.17180000,-569.99520000,-79.25740000,0.00000000,0.00000000,0.00000000,0,0); //
	CreateDynamicObject(14598,692.38090000,-585.77250000,-64.48600000,0.00000000,0.00000000,0.00000000,0,0); //
	CreateDynamicObject(7921,696.11260000,-544.02750000,-78.63970000,0.00000000,0.00000000,271.54080000,0,0); //
	CreateDynamicObject(7921,694.09680000,-544.12240000,-78.63970000,0.00000000,0.00000000,272.80540000,0,0); //
	CreateDynamicObject(7921,691.07900000,-562.11490000,-78.63970000,0.00000000,0.00000000,272.80150000,0,0); //
	CreateDynamicObject(16780,687.00040000,-552.82120000,-75.31610000,0.00000000,0.00000000,0.00000000,0,0); //
	CreateDynamicObject(1453,695.89520000,-565.75290000,-79.46860000,0.00000000,0.00000000,0.00000000,0,0); //
	CreateDynamicObject(2205,689.29320000,-555.91230000,-80.03220000,0.00000000,0.00000000,0.00000000,0,0); //
	CreateDynamicObject(2205,690.65150000,-550.04760000,-80.03220000,0.00000000,0.00000000,180.00000000,0,0); //
	CreateDynamicObject(2205,688.63480000,-550.24710000,-80.03220000,0.00000000,0.00000000,210.41050000,0,0); //
	CreateDynamicObject(2205,687.45000000,-555.02530000,-80.03220000,0.00000000,0.00000000,329.64400000,0,0); //
	CreateDynamicObject(2207,688.26310000,-553.92590000,-80.05370000,0.00000000,0.00000000,89.72650000,0,0); //
	CreateDynamicObject(2637,683.27490000,-547.48580000,-79.63230000,0.00000000,0.00000000,90.21200000,0,0); //
	CreateDynamicObject(2637,684.50890000,-547.47950000,-79.63230000,0.00000000,0.00000000,90.20870000,0,0); //
	CreateDynamicObject(2637,684.51390000,-549.54160000,-79.63230000,0.00000000,0.00000000,90.20870000,0,0); //
	CreateDynamicObject(2637,683.28440000,-549.55510000,-79.63230000,0.00000000,0.00000000,90.20870000,0,0); //
	CreateDynamicObject(1663,686.01100000,-546.90100000,-79.48730000,0.00000000,0.00000000,269.66500000,0,0); //
	CreateDynamicObject(1663,685.93180000,-548.20570000,-79.48730000,0.00000000,0.00000000,269.66490000,0,0); //
	CreateDynamicObject(1663,685.87130000,-549.59250000,-79.48730000,0.00000000,0.00000000,269.66490000,0,0); //
	CreateDynamicObject(1663,681.82690000,-550.01300000,-79.48730000,0.00000000,0.00000000,89.06460000,0,0); //
	CreateDynamicObject(1663,681.77480000,-548.45040000,-79.48730000,0.00000000,0.00000000,89.06070000,0,0); //
	CreateDynamicObject(1663,681.66670000,-546.93840000,-79.48730000,0.00000000,0.00000000,89.06070000,0,0); //
	CreateDynamicObject(1671,683.97830000,-551.33530000,-79.59350000,0.00000000,0.00000000,180.59740000,0,0); //
	CreateDynamicObject(14532,683.74510000,-545.61960000,-79.05440000,0.00000000,0.00000000,180.74760000,0,0); //
	CreateDynamicObject(2251,686.87990000,-551.59360000,-79.10260000,0.00000000,0.00000000,0.00000000,0,0); //
	CreateDynamicObject(2253,687.48850000,-553.78200000,-78.99590000,0.00000000,0.00000000,0.00000000,0,0); //
	CreateDynamicObject(2811,683.83670000,-548.54930000,-79.22300000,0.00000000,0.00000000,0.00000000,0,0); //
	CreateDynamicObject(2853,683.26450000,-549.93820000,-79.22300000,0.00000000,0.00000000,0.00000000,0,0); //
	CreateDynamicObject(2855,684.55350000,-549.54910000,-79.22300000,0.00000000,0.00000000,0.00000000,0,0); //
	CreateDynamicObject(2854,683.17900000,-548.77300000,-79.22300000,0.00000000,0.00000000,0.00000000,0,0); //
	CreateDynamicObject(2826,684.34210000,-547.63530000,-79.11680000,0.00000000,0.00000000,0.00000000,0,0); //
	CreateDynamicObject(2190,688.15780000,-552.28360000,-79.27630000,0.00000000,0.00000000,294.30200000,0,0); //
	CreateDynamicObject(2190,690.18510000,-550.30790000,-79.06390000,0.00000000,0.00000000,183.74040000,0,0); //
	CreateDynamicObject(2190,689.25630000,-555.66430000,-79.06390000,0.00000000,0.00000000,306.91930000,0,0); //
	CreateDynamicObject(2202,681.69210000,-555.89430000,-80.03710000,0.00000000,0.00000000,90.33470000,0,0); //
	CreateDynamicObject(2202,691.39260000,-559.87650000,-80.03710000,0.00000000,0.00000000,180.66430000,0,0); //
	CreateDynamicObject(2002,685.09030000,-559.93350000,-79.94750000,0.00000000,0.00000000,185.61610000,0,0); //
	CreateDynamicObject(14565,677.08690000,-555.58470000,-75.56120000,0.00000000,0.00000000,0.00000000,0,0); //
	CreateDynamicObject(14666,691.08630000,-562.11250000,-78.96550000,0.00000000,0.00000000,269.66520000,0,0); //
	CreateDynamicObject(14784,868.72520000,-644.19510000,-22.56450000,0.00000000,0.00000000,0.00000000,0,0); //
	CreateDynamicObject(4732,664.59210000,-565.32040000,8.84390000,325.78160000,90.00000000,1.10210000,0,0); //
	CreateDynamicObject(4732,668.79390000,-565.16910000,8.90070000,325.78160000,90.00000000,1.10210000,0,0); //
	CreateDynamicObject(4732,670.33360000,-568.20090000,8.90070000,145.77760000,90.00000000,109.35830000,0,0); //
	CreateDynamicObject(1280,630.98230000,-588.26280000,15.87730000,0.00000000,0.00000000,182.59590000,0,0); //
	CreateDynamicObject(1280,628.50070000,-590.22780000,15.87730000,0.00000000,0.00000000,93.47450000,0,0); //
	CreateDynamicObject(1280,626.45680000,-588.09790000,16.19600000,0.00000000,8.87140000,1.81880000,0,0); //
	CreateDynamicObject(738,628.21210000,-587.99040000,15.70210000,358.73260000,6.33680000,0.00000000,0,0); //
	CreateDynamicObject(1503,-1102.10820000,1058.99680000,1341.24440000,0.00000000,0.00000000,243.10190000,0,0); //
	CreateDynamicObject(1503,-1081.08870000,1065.97940000,1340.92580000,0.00000000,0.00000000,67.06540000,0,0); //
	CreateDynamicObject(5153,-1054.04370000,1090.60080000,1342.82750000,0.00000000,0.00000000,348.59400000,0,0); //
	CreateDynamicObject(5153,-1032.62430000,1086.27430000,1342.88560000,0.00000000,0.00000000,157.95910000,0,0); //
	
	//rada lokalna dillimore (miasteczko) obiekty dillimore

	CreateDynamicObject(1280,696.94738770,-499.21337891,15.73729324,0.00000000,0.00000000,0.00000000,35,0); //object(parkbench1) (1)
	CreateDynamicObject(10994,694.86816406,-508.66992188,13.93142605,270.00000000,179.99450684,179.99450684,35,0); //object(shoppie6_sfs02) (1)
	CreateDynamicObject(5040,700.45117188,-528.11718750,25.79909325,0.00000000,0.00000000,0.00000000,35,0); //object(unionliq_las) (1)
	CreateDynamicObject(5040,690.46582031,-485.12011719,25.79909325,0.00000000,0.00000000,270.00000000,35,0); //object(unionliq_las) (2)
	CreateDynamicObject(5040,678.60839844,-507.91894531,25.79909325,0.00000000,0.00000000,270.00000000,35,0); //object(unionliq_las) (3)
	CreateDynamicObject(2617,701.27343750,-499.97363281,23.14048195,0.00000000,0.00000000,86.99523926,35,0); //object(hotel_single_3) (1)
	CreateDynamicObject(3051,699.77868652,-501.92752075,23.87768555,0.00000000,0.00000000,46.29998779,35,0); //object(lift_dr) (2)
	CreateDynamicObject(3051,699.80328369,-503.07369995,23.87768745,0.00000000,0.00000000,226.29089355,35,0); //object(lift_dr) (3)
	CreateDynamicObject(2922,699.77789307,-501.05386353,23.88330841,0.00000000,0.00000000,268.74755859,35,0); //object(kmb_keypad) (1)
	CreateDynamicObject(2445,700.25671387,-504.19610596,22.51548386,0.00000000,0.00000000,180.00000000,35,0); //object(cj_ff_conter_4d) (1)
	CreateDynamicObject(2445,701.24737549,-504.19610596,22.51548386,0.00000000,0.00000000,179.99450684,35,0); //object(cj_ff_conter_4d) (2)
	CreateDynamicObject(2445,702.23822021,-504.19610596,22.51548386,0.00000000,0.00000000,179.99450684,35,0); //object(cj_ff_conter_4d) (3)
	CreateDynamicObject(2445,703.22839355,-504.19610596,22.51548386,0.00000000,0.00000000,179.99450684,35,0); //object(cj_ff_conter_4d) (4)
	CreateDynamicObject(2445,704.19531250,-504.19610596,22.51548386,0.00000000,0.00000000,179.99450684,35,0); //object(cj_ff_conter_4d) (5)
	CreateDynamicObject(2445,705.18554688,-504.19531250,22.51548386,0.00000000,0.00000000,179.99450684,35,0); //object(cj_ff_conter_4d) (6)
	CreateDynamicObject(2167,710.07635498,-506.92810059,22.51548386,0.00000000,0.00000000,180.00000000,35,0); //object(med_office_unit_7) (1)
	CreateDynamicObject(2164,709.15441895,-506.92214966,22.51548386,0.00000000,0.00000000,180.00000000,35,0); //object(med_office_unit_5) (1)
	CreateDynamicObject(2190,701.85699463,-503.98406982,23.57105255,0.00000000,0.00000000,0.00000000,35,0); //object(pc_1) (1)
	CreateDynamicObject(2190,704.49975586,-503.96795654,23.57105255,0.00000000,0.00000000,0.00000000,35,0); //object(pc_1) (2)
	CreateDynamicObject(2186,700.23168945,-506.29263306,22.51548386,0.00000000,0.00000000,90.00000000,35,0); //object(photocopier_1) (1)
	CreateDynamicObject(1210,700.23724365,-504.84298706,22.66392136,0.00000000,0.00000000,0.00000000,35,0); //object(briefcase) (1)
	CreateDynamicObject(1210,700.24096680,-504.76675415,22.66392136,0.00000000,0.00000000,0.00000000,35,0); //object(briefcase) (2)
	CreateDynamicObject(1649,711.62695312,-505.29125977,24.18122673,0.00000000,0.00000000,270.00000000,35,0); //object(wglasssmash) (3)
	CreateDynamicObject(1649,711.62695312,-500.94421387,24.18122292,0.00000000,0.00000000,270.00000000,35,0); //object(wglasssmash) (3)
	CreateDynamicObject(1649,711.62695312,-496.58032227,24.18122292,0.00000000,0.00000000,270.00000000,35,0); //object(wglasssmash) (3)
	CreateDynamicObject(2207,706.08612061,-499.16632080,22.51548004,0.00000000,0.00000000,0.00000000,35,0); //object(med_office7_desk_1) (1)
	CreateDynamicObject(1455,709.95642090,-496.77615356,23.29361725,0.00000000,0.00000000,0.00000000,35,0); //object(dyn_glass) (1)
	CreateDynamicObject(1808,709.89404297,-496.63778687,22.51548004,0.00000000,0.00000000,0.00000000,35,0); //object(cj_watercooler2) (1)
	CreateDynamicObject(1455,707.69812012,-498.88366699,23.36454010,0.00000000,0.00000000,0.00000000,35,0); //object(dyn_glass) (2)
	CreateDynamicObject(2953,707.69573975,-498.57510376,23.29658318,0.00000000,0.00000000,0.00000000,35,0); //object(kmb_paper_code) (1)
	CreateDynamicObject(1549,711.12615967,-506.69580078,22.51548386,0.00000000,0.00000000,0.00000000,35,0); //object(cj_ashtray_b) (1)
	CreateDynamicObject(2961,701.12341309,-504.54119873,23.42509842,0.00000000,0.00000000,0.00000000,35,0); //object(fire_break) (1)
	CreateDynamicObject(2961,703.98614502,-504.54119873,23.40600777,0.00000000,0.00000000,0.00000000,35,0); //object(fire_break) (2)
	CreateDynamicObject(2894,706.08618164,-498.49221802,23.29285240,0.00000000,0.00000000,0.00000000,35,0); //object(kmb_rhymesbook) (1)
	CreateDynamicObject(2811,710.98266602,-501.42218018,22.51548004,0.00000000,0.00000000,0.00000000,35,0); //object(gb_romanpot01) (1)
	CreateDynamicObject(10994,698.22167969,-525.29785156,18.28788757,270.00000000,179.99450684,90.00000000,35,0); //object(shoppie6_sfs02) (1)
	CreateDynamicObject(1649,711.57385254,-509.79022217,28.53307533,0.00000000,0.00000000,270.00000000,35,0); //object(wglasssmash) (3)
	CreateDynamicObject(1649,711.57324219,-514.14257812,28.53307533,0.00000000,0.00000000,270.00000000,35,0); //object(wglasssmash) (3)
	CreateDynamicObject(5040,690.46710205,-496.42459106,29.97636604,0.00000000,0.00000000,270.00000000,35,0); //object(unionliq_las) (2)
	CreateDynamicObject(3051,706.28259277,-507.63003540,28.23414612,0.00000000,0.00000000,135.75000000,35,0); //object(lift_dr) (1)
	CreateDynamicObject(3051,707.45239258,-507.64093018,28.23414612,0.00000000,0.00000000,316.29089355,35,0); //object(lift_dr) (4)
	CreateDynamicObject(5040,682.83300781,-519.47753906,29.97636604,0.00000000,0.00000000,270.00000000,35,0); //object(unionliq_las) (2)
	CreateDynamicObject(2131,704.51074219,-509.13281250,26.87194252,0.00000000,0.00000000,90.00000000,35,0); //object(cj_kitch2_fridge) (1)
	CreateDynamicObject(2340,704.48974609,-510.16210938,26.87194443,0.00000000,0.00000000,90.00000000,35,0); //object(cj_kitch2_washer) (1)
	CreateDynamicObject(2339,704.48907471,-511.14431763,26.87194443,0.00000000,0.00000000,90.00000000,35,0); //object(cj_kitch2_cooker) (1)
	CreateDynamicObject(2149,704.34722900,-511.29962158,28.07655716,0.00000000,0.00000000,90.00000000,35,0); //object(cj_microwave1) (1)
	CreateDynamicObject(2500,703.99328613,-510.36245728,27.92520142,0.00000000,0.00000000,90.00000000,35,0); //object(cj_ff_coffee) (1)
	CreateDynamicObject(1649,711.57324219,-518.48535156,28.53307533,0.00000000,0.00000000,270.00000000,35,0); //object(wglasssmash) (3)
	CreateDynamicObject(1649,711.57324219,-522.85449219,28.53307533,0.00000000,0.00000000,270.00000000,35,0); //object(wglasssmash) (3)
	CreateDynamicObject(1510,704.56433105,-510.91168213,27.95020103,0.00000000,0.00000000,0.00000000,35,0); //object(dyn_ashtry) (1)
	CreateDynamicObject(5040,700.40429688,-546.16699219,29.97636604,0.00000000,0.00000000,0.00000000,35,0); //object(unionliq_las) (2)
	CreateDynamicObject(2239,704.70697021,-524.31896973,26.87194443,0.00000000,0.00000000,0.00000000,35,0); //object(cj_mlight16) (1)
	CreateDynamicObject(2568,704.49176025,-521.30584717,26.87194443,0.00000000,0.00000000,90.00000000,35,0); //object(hotel_dresser_3) (1)
	CreateDynamicObject(1726,707.84497070,-516.33160400,26.87194061,0.00000000,0.00000000,90.00000000,35,0); //object(mrk_seating2) (1)
	CreateDynamicObject(1727,708.97662354,-512.79785156,26.87194061,0.00000000,0.00000000,0.00000000,35,0); //object(mrk_seating2b) (1)
	CreateDynamicObject(1727,709.97088623,-517.59539795,26.87194061,0.00000000,0.00000000,180.00000000,35,0); //object(mrk_seating2b) (2)
	CreateDynamicObject(1823,708.99041748,-515.73242188,26.87194061,0.00000000,0.00000000,0.00000000,35,0); //object(coffee_med_5) (1)
	CreateDynamicObject(2194,709.42083740,-515.29089355,27.69854164,0.00000000,0.00000000,0.00000000,35,0); //object(plant_pot_2) (1)
	CreateDynamicObject(2816,709.38513184,-515.41363525,27.36757278,0.00000000,0.00000000,0.00000000,35,0); //object(gb_bedmags01) (2)
	CreateDynamicObject(10994,693.30859375,-519.06542969,38.56707382,90.00000000,180.00549316,359.98901367,35,0); //object(shoppie6_sfs02) (1)
	CreateDynamicObject(10994,698.30371094,-488.30566406,34.36515808,90.00000000,179.99450684,270.00000000,35,0); //object(shoppie6_sfs02) (1)
	CreateDynamicObject(1337,694.99908447,-500.12564087,15.98516273,0.00000000,0.00000000,0.00000000,35,0); //object(binnt07_la) (3)
	CreateDynamicObject(13028,618.02203369,-596.99511719,18.15020561,0.00000000,0.00000000,180.00000000,35,0); //object(ce_spraydoor1) (1)
	CreateDynamicObject(13028,618.02203369,-601.47198486,18.15020561,0.00000000,0.00000000,179.99450684,35,0); //object(ce_spraydoor1) (2)
	CreateDynamicObject(13028,616.94299316,-601.47882080,19.82229805,0.00000000,80.00000000,179.99450684,35,0); //object(ce_spraydoor1) (3)
	CreateDynamicObject(13028,616.94299316,-596.94097900,19.82229805,0.00000000,79.99694824,179.99450684,35,0); //object(ce_spraydoor1) (4)
	CreateDynamicObject(1649,709.36053467,-518.64208984,28.53307533,0.00000000,0.00000000,180.00000000,35,0); //object(wglasssmash) (3)
	CreateDynamicObject(1649,709.36035156,-518.64160156,28.53307533,0.00000000,0.00000000,0.00000000,35,0); //object(wglasssmash) (3)
	CreateDynamicObject(1721,707.54583740,-520.24456787,26.87194061,0.00000000,0.00000000,178.00000000,35,0); //object(est_chair1) (1)
	CreateDynamicObject(1721,708.83160400,-520.13226318,26.87194633,0.00000000,0.00000000,177.99499512,35,0); //object(est_chair1) (2)
	CreateDynamicObject(1721,710.06378174,-520.17877197,26.87194633,0.00000000,0.00000000,177.99499512,35,0); //object(est_chair1) (3)
	CreateDynamicObject(1721,710.50848389,-521.33612061,26.87194633,0.00000000,0.00000000,177.99499512,35,0); //object(est_chair1) (4)
	CreateDynamicObject(1721,709.26910400,-521.34808350,26.87194633,0.00000000,0.00000000,177.99499512,35,0); //object(est_chair1) (5)
	CreateDynamicObject(1721,708.01055908,-521.37530518,26.87194633,0.00000000,0.00000000,177.99499512,35,0); //object(est_chair1) (6)
	CreateDynamicObject(2491,708.95544434,-523.31878662,26.11733627,0.00000000,0.00000000,0.00000000,35,0); //object(model_stand) (1)
	CreateDynamicObject(2811,707.50396729,-518.93536377,26.79694748,0.00000000,0.00000000,0.00000000,35,0); //object(gb_romanpot01) (2)
	CreateDynamicObject(2811,711.06909180,-518.99615479,26.87194633,0.00000000,0.00000000,0.00000000,35,0); //object(gb_romanpot01) (3)
	CreateDynamicObject(2011,708.39813232,-519.40765381,26.87208748,0.00000000,0.00000000,0.00000000,35,0); //object(nu_plant2_ofc) (1)
	CreateDynamicObject(2001,709.45648193,-519.23510742,26.84694290,0.00000000,0.00000000,0.00000000,35,0); //object(nu_plant_ofc) (1)
	CreateDynamicObject(2011,710.25372314,-519.04913330,26.84708786,0.00000000,0.00000000,0.00000000,35,0); //object(nu_plant2_ofc) (3)
	CreateDynamicObject(2248,710.96997070,-517.61859131,27.44926262,0.00000000,0.00000000,0.00000000,35,0); //object(plant_pot_16) (1)
	CreateDynamicObject(2251,707.85742188,-523.59887695,27.71479416,0.00000000,0.00000000,0.00000000,35,0); //object(plant_pot_20) (1)
	CreateDynamicObject(1297,711.57324219,-522.05273438,29.62748146,0.00000000,0.00000000,0.00000000,35,0); //object(lamppost1) (1)
	CreateDynamicObject(2765,707.62036133,-518.63488770,27.32194138,90.00000000,179.59350586,180.40100098,35,0); //object(cj_cb_list1) (2)
	CreateDynamicObject(1721,711.06835938,-520.17431641,26.87194633,0.00000000,0.00000000,177.99499512,35,0); //object(est_chair1) (7)
	CreateDynamicObject(2765,709.13354492,-518.63720703,27.32194138,90.00000000,179.59350586,180.40100098,35,0); //object(cj_cb_list1) (3)
	CreateDynamicObject(2765,709.10394287,-518.10894775,28.84615517,0.00000000,0.00000000,0.00000000,35,0); //object(cj_cb_list1) (4)
	CreateDynamicObject(2765,707.67333984,-518.12170410,28.84615517,0.00000000,0.00000000,0.00000000,35,0); //object(cj_cb_list1) (5)
	CreateDynamicObject(2765,711.07952881,-519.11016846,28.84615517,0.00000000,0.00000000,180.00000000,35,0); //object(cj_cb_list1) (6)
	CreateDynamicObject(2765,709.63958740,-519.12707520,28.84615517,0.00000000,0.00000000,179.99450684,35,0); //object(cj_cb_list1) (7)
	CreateDynamicObject(1569,702.86456299,-496.26995850,22.49048424,0.00000000,0.00000000,0.00000000,35,0); //object(adam_v_door) (1)

	// obiekty dillimore - wystrój
	CreateDynamicObject(970,642.45928955,-608.86254883,15.84150887,0.00000000,0.00000000,292.49169922,0,0); //convertffs(13)
	CreateDynamicObject(970,639.89239502,-605.82647705,15.84150887,0.00000000,0.00000000,326.23974609,0,0); //convertffs(14)
	CreateDynamicObject(970,636.93688965,-603.02392578,15.84150887,0.00000000,0.00000000,306.73901367,0,0); //convertffs(15)
	CreateDynamicObject(970,634.51873779,-599.64855957,15.84150887,0.00000000,0.00000000,303.98828125,0,0); //convertffs(16)
	CreateDynamicObject(966,633.11163330,-597.51135254,15.31093788,0.00000000,0.00000000,280.75000000,0,0); //convertffs(17)
	CreateDynamicObject(970,631.72851562,-588.28125000,15.84150887,0.00000000,0.00000000,269.73083496,0,0); //convertffs(18)
	CreateDynamicObject(970,631.74896240,-584.15484619,15.84150887,0.00000000,0.00000000,269.73083496,0,0); //convertffs(19)
	CreateDynamicObject(970,631.76660156,-579.99902344,15.84150887,0.00000000,0.00000000,269.73083496,0,0); //convertffs(20)
	CreateDynamicObject(970,631.78521729,-575.84436035,15.84150887,0.00000000,0.00000000,269.73083496,0,0); //convertffs(21)
	CreateDynamicObject(970,629.72900391,-573.81823730,15.84150887,0.00000000,0.00000000,181.73083496,0,0); //convertffs(22)
	CreateDynamicObject(970,631.69531250,-567.61328125,15.84150887,0.00000000,0.00000000,269.73083496,0,0); //convertffs(23)
	CreateDynamicObject(970,629.60656738,-569.69403076,15.84150887,0.00000000,0.00000000,180.48034668,0,0); //convertffs(24)
	CreateDynamicObject(970,631.70520020,-563.45977783,15.84150887,0.00000000,0.00000000,269.73083496,0,0); //convertffs(25)
	CreateDynamicObject(970,631.73956299,-559.30413818,15.84150887,0.00000000,0.00000000,269.73083496,0,0); //convertffs(26)
	CreateDynamicObject(970,631.72436523,-555.15136719,15.84150887,0.00000000,0.00000000,269.73083496,0,0); //convertffs(27)
	CreateDynamicObject(970,631.73406982,-550.99841309,15.84150887,0.00000000,0.00000000,269.73083496,0,0); //convertffs(28)
	CreateDynamicObject(970,631.74444580,-546.86968994,15.84150887,0.00000000,0.00000000,269.73083496,0,0); //convertffs(29)
	CreateDynamicObject(970,629.60839844,-540.14843750,15.84150887,0.00000000,0.00000000,0.00000000,0,0); //convertffs(30)
	CreateDynamicObject(970,625.46234131,-540.14593506,15.84150887,0.00000000,0.00000000,0.00000000,0,0); //convertffs(31)
	CreateDynamicObject(970,631.66510010,-540.70538330,14.31653214,0.00000000,90.00000000,269.73083496,0,0); //convertffs(32)
	CreateDynamicObject(970,631.64929199,-541.28131104,14.31653214,0.00000000,90.00000000,269.73083496,0,0); //convertffs(33)
	CreateDynamicObject(970,631.65527344,-542.15527344,15.89151573,0.00000000,90.00000000,90.00000000,0,0); //convertffs(34)
	CreateDynamicObject(970,631.73925781,-544.90722656,15.89151573,0.00000000,90.00000000,270.00000000,0,0); //convertffs(35)
	CreateDynamicObject(970,643.32537842,-612.86157227,15.84150887,0.00000000,0.00000000,271.24633789,0,0); //convertffs(37)
	CreateDynamicObject(970,646.35357666,-624.00549316,15.89150810,0.00000000,358.75000000,261.24389648,0,0); //convertffs(38)
	CreateDynamicObject(970,645.39965820,-628.01910400,15.99150658,0.00000000,357.99755859,252.48840332,0,0); //convertffs(39)
	CreateDynamicObject(1346,632.47045898,-575.59820557,16.68694305,0.00000000,0.00000000,90.00000000,0,0); //convertffs(54)
	CreateDynamicObject(1366,669.10449219,-451.33593750,15.87443066,0.00000000,0.00000000,0.00000000,0,0); //convertffs(55)
	CreateDynamicObject(1366,629.89746094,-584.11230469,15.79943180,0.00000000,0.00000000,0.00000000,0,0); //convertffs(56)
	CreateDynamicObject(1367,632.08532715,-568.30798340,15.93088818,0.00000000,0.00000000,90.00000000,0,0); //convertffs(57)
	CreateDynamicObject(983,654.76000977,-560.56744385,16.01949310,0.00000000,0.00000000,0.00000000,0,0); //convertffs(58)
	CreateDynamicObject(983,656.51098633,-560.57556152,16.01949310,0.00000000,0.00000000,0.00000000,0,0); //convertffs(59)
	CreateDynamicObject(983,654.75427246,-569.44573975,16.01949310,0.00000000,0.00000000,0.00000000,0,0); //convertffs(60)
	CreateDynamicObject(983,656.50439453,-569.46112061,16.01949310,0.00000000,0.00000000,0.00000000,0,0); //convertffs(61)
	CreateDynamicObject(970,669.48309326,-590.13104248,15.83741951,0.00000000,0.00000000,0.00000000,0,0); //convertffs(65)
	CreateDynamicObject(970,665.35131836,-590.13751221,15.83741951,0.00000000,0.00000000,0.00000000,0,0); //convertffs(66)
	CreateDynamicObject(970,651.71453857,-542.21038818,15.83741951,0.00000000,0.00000000,90.00000000,0,0); //convertffs(79)
	CreateDynamicObject(970,653.79504395,-540.13232422,15.83741951,0.00000000,0.00000000,0.00000000,0,0); //convertffs(80)
	CreateDynamicObject(2656,662.83984375,-577.65136719,17.14564896,0.00000000,0.00000000,0.00000000,0,0); //convertffs(81)
	CreateDynamicObject(18066,655.93896484,-571.22991943,17.85138512,0.00000000,0.00000000,90.00000000,0,0); //convertffs(82)
	CreateDynamicObject(18066,655.96630859,-569.62902832,17.85138512,0.00000000,0.00000000,90.00000000,0,0); //convertffs(83)
	CreateDynamicObject(18066,655.35455322,-569.58770752,17.85138512,0.00000000,0.00000000,270.00000000,0,0); //convertffs(84)
	CreateDynamicObject(18066,655.36547852,-571.16894531,17.85138512,0.00000000,0.00000000,270.00000000,0,0); //convertffs(85)
	CreateDynamicObject(2656,655.64880371,-571.84942627,16.62065697,0.00000000,0.00000000,0.00000000,0,0); //convertffs(86)
	CreateDynamicObject(2456,661.48742676,-551.87683105,15.33593750,0.00000000,0.00000000,0.00000000,0,0); //convertffs(87)
	CreateDynamicObject(2714,655.70507812,-576.34667969,20.25476074,0.00000000,0.00000000,0.00000000,0,0); //convertffs(88)
	CreateDynamicObject(3467,655.41589355,-539.90563965,16.03874969,0.00000000,0.00000000,180.00000000,0,0); //convertffs(89)
	CreateDynamicObject(3467,663.71972656,-590.41113281,16.02536201,0.00000000,0.00000000,0.00000000,0,0); //convertffs(90)
	CreateDynamicObject(2657,655.67279053,-558.30487061,16.63619423,0.00000000,0.00000000,180.00000000,0,0); //convertffs(91)
	CreateDynamicObject(848,653.19342041,-639.49212646,17.06845665,0.00000000,0.00000000,0.00000000,0,0); //convertffs(105)
	CreateDynamicObject(1186,616.23229980,-520.17968750,17.28946877,354.52038574,24.11715698,2.44787598,0,0); //convertffs(107)
	CreateDynamicObject(1359,685.96466064,-475.80987549,15.95949554,0.00000000,0.00000000,0.00000000,0,0); //convertffs(108)
	CreateDynamicObject(1363,671.38098145,-474.01806641,16.29729843,0.00000000,0.00000000,0.00000000,0,0); //convertffs(109)
	CreateDynamicObject(6299,702.11132812,-445.31054688,17.30632973,0.00000000,0.00000000,90.00000000,0,0); //convertffs(110)
	CreateDynamicObject(1111,636.75268555,-496.66479492,15.33593750,0.00000000,0.00000000,0.00000000,0,0); //convertffs(111)
	CreateDynamicObject(970,638.77929688,-495.15234375,15.88741875,0.00000000,0.00000000,0.00000000,0,0); //convertffs(112)
	CreateDynamicObject(970,649.62866211,-495.14364624,15.88741875,0.00000000,0.00000000,0.00000000,0,0); //convertffs(113)
	CreateDynamicObject(1096,636.89373779,-496.08251953,15.82801914,0.00000000,0.00000000,0.00000000,0,0); //convertffs(114)
	CreateDynamicObject(1081,636.84649658,-502.53735352,15.82807159,0.00000000,0.00000000,0.00000000,0,0); //convertffs(115)
	CreateDynamicObject(1081,636.80627441,-503.48663330,15.82807159,0.00000000,0.00000000,0.00000000,0,0); //convertffs(116)
	CreateDynamicObject(1081,637.06286621,-503.01510620,15.82807159,0.00000000,0.00000000,0.00000000,0,0); //convertffs(117)
	CreateDynamicObject(1776,689.16308594,-470.21023560,16.58568954,0.00000000,0.00000000,90.00000000,0,0); //convertffs(118)
	CreateDynamicObject(1034,637.13769531,-502.12207031,15.86359692,0.00000000,0.00000000,0.00000000,0,0); //convertffs(119)
	CreateDynamicObject(7520,614.22210693,-504.07592773,9.08593369,0.00000000,0.00000000,0.00000000,0,0); //convertffs(121)
	CreateDynamicObject(9321,654.40899658,-507.92065430,16.79626465,0.00000000,0.00000000,180.00000000,0,0); //convertffs(122)
	CreateDynamicObject(3057,710.62371826,-469.70046997,16.48032761,0.00000000,0.00000000,0.00000000,0,0); //convertffs(123)
	CreateDynamicObject(11391,647.15197754,-510.90640259,16.55105972,0.00000000,0.00000000,89.75000000,0,0); //convertffs(125)
	CreateDynamicObject(11392,642.58483887,-507.76223755,15.33593750,0.00000000,0.00000000,0.00000000,0,0); //convertffs(127)
	CreateDynamicObject(14826,649.48242188,-499.43945312,16.10031700,0.00000000,0.00000000,90.00000000,0,0); //convertffs(128)
	CreateDynamicObject(3948,774.40698242,-425.51098633,25.47232437,0.00000000,0.00000000,0.00000000,0,0); //convertffs(129)
	CreateDynamicObject(18269,685.00378418,-418.68072510,41.18134308,0.00000000,0.00000000,0.00000000,0,0); //convertffs(130)
	CreateDynamicObject(18452,644.13897705,-498.07876587,17.95967293,0.00000000,0.00000000,270.25000000,0,0); //convertffs(131)
	CreateDynamicObject(18452,644.09570312,-506.42968750,17.95967293,0.00000000,0.00000000,270.24719238,0,0); //convertffs(132)
	CreateDynamicObject(1238,712.02178955,-475.10861206,15.66188431,0.00000000,0.00000000,0.00000000,0,0); //convertffs(135)
	CreateDynamicObject(1342,691.65808105,-474.43194580,16.54462814,0.00000000,0.00000000,90.00000000,0,0); //convertffs(136)
	CreateDynamicObject(1346,651.05078125,-436.92382812,16.68694305,0.00000000,0.00000000,270.00000000,0,0); //convertffs(137)
	CreateDynamicObject(2837,656.01354980,-440.28469849,15.33593750,0.00000000,0.00000000,0.00000000,0,0); //convertffs(138)
	CreateDynamicObject(2860,655.19885254,-440.31713867,15.33593750,0.00000000,0.00000000,0.00000000,0,0); //convertffs(139)
	CreateDynamicObject(924,652.71331787,-467.39440918,16.01703072,0.00000000,0.00000000,0.00000000,0,0); //convertffs(140)
	CreateDynamicObject(1359,677.08581543,-475.62445068,15.95949554,0.00000000,0.00000000,0.00000000,0,0); //convertffs(141)
	CreateDynamicObject(3302,663.04687500,-441.69531250,15.81969452,27.48229980,1.97204590,0.33508301,0,0); //convertffs(144)
	CreateDynamicObject(3035,663.16406250,-439.50781250,16.10607338,0.00000000,0.00000000,0.00000000,0,0); //convertffs(145)
	CreateDynamicObject(3006,718.18365479,-438.88284302,15.33593750,0.00000000,0.00000000,0.00000000,0,0); //convertffs(146)
	CreateDynamicObject(2971,665.47851562,-439.53692627,15.33593750,0.00000000,0.00000000,0.00000000,0,0); //convertffs(147)
	CreateDynamicObject(2907,662.02502441,-438.86050415,15.49597359,0.00000000,0.00000000,0.00000000,0,0); //convertffs(148)
	CreateDynamicObject(3006,662.70831299,-440.22167969,15.03594208,0.00000000,0.00000000,92.00000000,0,0); //convertffs(149)
	CreateDynamicObject(2890,674.10742188,-447.14529419,15.31093788,0.00000000,0.00000000,272.00000000,0,0); //convertffs(150)
	CreateDynamicObject(2900,725.94921875,-438.59121704,15.33593750,0.00000000,0.00000000,0.00000000,0,0); //convertffs(152)
	CreateDynamicObject(2953,715.25512695,-472.54434204,15.34743500,0.00000000,0.00000000,0.00000000,0,0); //convertffs(153)
	CreateDynamicObject(18452,719.94665527,-466.94808960,17.76744270,0.00000000,1.75000000,90.00000000,0,0); //convertffs(154)
	CreateDynamicObject(2840,725.28094482,-464.37374878,15.33593750,0.00000000,0.00000000,0.00000000,0,0); //convertffs(156)
	CreateDynamicObject(970,651.73846436,-440.00952148,15.86241913,0.00000000,0.00000000,90.00000000,0,0); //convertffs(157)
	CreateDynamicObject(970,651.73437500,-444.13476562,15.86241913,0.00000000,0.00000000,90.00000000,0,0); //convertffs(158)
	CreateDynamicObject(970,651.73211670,-448.28643799,15.86241913,0.00000000,0.00000000,90.00000000,0,0); //convertffs(159)
	CreateDynamicObject(970,651.72906494,-452.43792725,15.86241913,0.00000000,0.00000000,90.00000000,0,0); //convertffs(160)
	CreateDynamicObject(970,651.72558594,-456.56411743,15.86241913,0.00000000,0.00000000,90.00000000,0,0); //convertffs(161)
	CreateDynamicObject(970,651.74914551,-460.73928833,15.86241913,0.00000000,0.00000000,90.00000000,0,0); //convertffs(162)
	CreateDynamicObject(970,651.72247314,-464.91671753,15.86241913,0.00000000,0.00000000,90.00000000,0,0); //convertffs(163)
	CreateDynamicObject(1238,726.41015625,-475.28906250,15.65411758,0.00000000,0.00000000,0.00000000,0,0); //convertffs(165)
	CreateDynamicObject(1238,714.64160156,-475.15429688,15.66188431,0.00000000,0.00000000,0.00000000,0,0); //convertffs(166)
	CreateDynamicObject(1238,724.08868408,-475.20510864,15.65411758,0.00000000,0.00000000,0.00000000,0,0); //convertffs(167)
	CreateDynamicObject(1280,657.14495850,-472.29327393,15.73729324,0.00000000,0.00000000,260.00000000,0,0); //convertffs(179)
	CreateDynamicObject(1280,654.28546143,-469.43292236,15.76229286,0.00000000,0.00000000,177.99694824,0,0); //convertffs(180)
	CreateDynamicObject(1280,714.86828613,-452.74291992,15.73729324,0.00000000,0.00000000,355.49462891,0,0); //convertffs(184)
	CreateDynamicObject(1280,672.50994873,-457.45828247,15.93765163,0.00000000,0.00000000,79.49462891,0,0); //convertffs(185)
	CreateDynamicObject(1280,656.50579834,-475.51657104,15.73729324,0.00000000,0.00000000,91.49157715,0,0); //convertffs(186)
	CreateDynamicObject(1280,689.45819092,-475.60629272,15.73729324,0.00000000,0.00000000,91.48864746,0,0); //convertffs(187)
	CreateDynamicObject(1280,725.98339844,-470.86132812,15.73729324,0.00000000,0.00000000,3.48815918,0,0); //convertffs(188)
	CreateDynamicObject(3497,645.13604736,-520.58361816,19.40104103,0.00000000,0.00000000,182.00000000,0,0); //convertffs(189)
	CreateDynamicObject(3861,723.91894531,-444.12207031,16.50826836,0.00000000,0.00000000,179.99450684,0,0); //convertffs(191)
	CreateDynamicObject(3861,715.75378418,-439.44589233,16.50826836,0.00000000,0.00000000,1.99450684,0,0); //convertffs(192)
	CreateDynamicObject(3006,660.65136719,-439.17578125,15.33593750,0.00000000,0.00000000,0.00000000,0,0); //convertffs(194)
	CreateDynamicObject(7091,621.98767090,-566.69592285,26.90094757,0.00546265,271.24975586,356.24993896,0,0); //convertffs(195)
	CreateDynamicObject(3006,713.52954102,-441.03359985,15.33593750,0.00000000,0.00000000,0.00000000,0,0); //convertffs(196)
	CreateDynamicObject(3006,721.15142822,-444.78250122,15.33593750,0.00000000,0.00000000,0.00000000,0,0); //convertffs(197)
	CreateDynamicObject(1238,711.61682129,-452.31143188,15.65411758,0.00000000,0.00000000,0.00000000,0,0); //convertffs(198)
	CreateDynamicObject(1375,688.37127686,-614.05072021,17.02594757,0.00000000,0.00000000,0.00000000,0,0); //convertffs(200)
	CreateDynamicObject(14409,713.78228760,-575.69641113,17.12000084,0.00000000,0.00000000,180.00000000,0,0); //convertffs(201)
	CreateDynamicObject(1361,712.48706055,-565.62390137,21.02964211,0.00000000,0.00000000,0.00000000,0,0); //convertffs(202)
	CreateDynamicObject(3944,716.66894531,-579.05371094,11.91638565,0.00000000,325.22827148,89.92309570,0,0); //convertffs(203)
	CreateDynamicObject(3944,706.80914307,-569.55767822,16.34139442,0.00000000,0.00000000,180.00000000,0,0); //convertffs(204)
	CreateDynamicObject(3944,706.79785156,-571.31738281,12.89139366,0.00000000,0.00000000,179.99450684,0,0); //convertffs(205)
	CreateDynamicObject(3944,716.67675781,-574.34960938,11.24139595,0.00000000,90.00000000,89.92309570,0,0); //convertffs(206)
	CreateDynamicObject(3944,706.80859375,-569.55761719,12.89141655,0.00000000,0.00000000,179.99450684,0,0); //convertffs(207)
	CreateDynamicObject(3944,716.64489746,-579.06060791,9.41638565,0.00000000,325.22277832,89.92309570,0,0); //convertffs(208)
	CreateDynamicObject(14409,713.78076172,-563.23260498,17.10283470,0.00000000,0.00000000,0.00000000,0,0); //convertffs(209)
	CreateDynamicObject(3944,716.68090820,-559.93566895,11.91638565,0.00000000,34.72827148,90.17309570,0,0); //convertffs(210)
	CreateDynamicObject(3944,716.68017578,-560.10021973,9.91638565,0.00000000,34.72778320,90.17028809,0,0); //convertffs(211)
	CreateDynamicObject(3944,716.68359375,-570.98144531,11.26639557,0.00000000,90.00000000,89.92309570,0,0); //convertffs(212)
	CreateDynamicObject(3944,716.70214844,-569.08984375,11.26639557,0.00000000,90.00000000,89.92309570,0,0); //convertffs(213)
	CreateDynamicObject(1361,712.26092529,-573.34136963,21.05464172,0.00000000,0.00000000,0.00000000,0,0); //convertffs(214)
	CreateDynamicObject(1361,715.21832275,-565.64813232,21.02964211,0.00000000,0.00000000,0.00000000,0,0); //convertffs(215)
	CreateDynamicObject(1361,715.22961426,-573.30084229,21.02964211,0.00000000,0.00000000,0.00000000,0,0); //convertffs(216)
	CreateDynamicObject(1887,801.78387451,-716.01434326,78.52292633,0.00000000,0.00000000,0.00000000,0,0); //convertffs(217)
	CreateDynamicObject(1360,712.33081055,-569.40112305,21.10831833,0.00000000,0.00000000,0.00000000,0,0); //convertffs(218)
	CreateDynamicObject(1360,705.20214844,-588.57128906,21.10831642,0.00000000,0.00000000,0.00000000,0,0); //convertffs(219)
	CreateDynamicObject(1360,698.80017090,-588.64788818,21.10831642,0.00000000,0.00000000,0.00000000,0,0); //convertffs(220)
	CreateDynamicObject(1360,693.72723389,-584.32470703,21.10831642,0.00000000,0.00000000,90.00000000,0,0); //convertffs(221)
	CreateDynamicObject(1360,710.28906250,-584.20959473,21.10831642,0.00000000,0.00000000,90.00000000,0,0); //convertffs(222)
	CreateDynamicObject(918,805.21215820,-612.54595947,15.70746613,0.00000000,0.00000000,0.00000000,0,0); //convertffs(223)
	CreateDynamicObject(1360,710.25482178,-546.63751221,21.10831642,0.00000000,0.00000000,90.00000000,0,0); //convertffs(224)
	CreateDynamicObject(1360,693.67602539,-546.64398193,21.10831642,0.00000000,0.00000000,90.00000000,0,0); //convertffs(225)
	CreateDynamicObject(1360,698.69506836,-541.20678711,21.10831642,0.00000000,0.00000000,0.00000000,0,0); //convertffs(226)
	CreateDynamicObject(1360,705.13934326,-542.36285400,21.10831642,0.00000000,0.00000000,0.00000000,0,0); //convertffs(227)
	CreateDynamicObject(1364,695.76165771,-540.40588379,21.12041855,0.00000000,0.00000000,0.00000000,0,0); //convertffs(228)
	CreateDynamicObject(1364,710.70013428,-544.05316162,21.12041855,0.00000000,0.00000000,270.00000000,0,0); //convertffs(229)
	CreateDynamicObject(1361,710.62231445,-541.62701416,21.07963943,0.00000000,0.00000000,0.00000000,0,0); //convertffs(231)
	CreateDynamicObject(1361,711.02520752,-589.49627686,21.07963943,0.00000000,0.00000000,0.00000000,0,0); //convertffs(232)
	CreateDynamicObject(1361,692.70800781,-540.31835938,21.07963943,0.00000000,0.00000000,0.00000000,0,0); //convertffs(233)
	CreateDynamicObject(1361,692.79785156,-589.57519531,21.07963943,0.00000000,0.00000000,0.00000000,0,0); //convertffs(234)
	CreateDynamicObject(1364,707.74511719,-541.72460938,21.12041855,0.00000000,0.00000000,0.00000000,0,0); //convertffs(235)
	CreateDynamicObject(1364,710.97827148,-586.79748535,21.12041855,0.00000000,0.00000000,270.00000000,0,0); //convertffs(236)
	CreateDynamicObject(1364,708.06365967,-589.27630615,21.12041855,0.00000000,0.00000000,180.00000000,0,0); //convertffs(237)
	CreateDynamicObject(1364,693.01562500,-586.99707031,21.12041855,0.00000000,0.00000000,90.00000000,0,0); //convertffs(238)
	CreateDynamicObject(1364,693.11621094,-543.63769531,21.12041855,0.00000000,0.00000000,90.00000000,0,0); //convertffs(239)
	CreateDynamicObject(1364,696.01336670,-589.28143311,21.12041855,0.00000000,0.00000000,179.99450684,0,0); //convertffs(240)
	CreateDynamicObject(1597,710.52343750,-552.01953125,22.94367981,0.00000000,0.00000000,0.00000000,0,0); //convertffs(241)
	CreateDynamicObject(1597,710.51660156,-578.75585938,22.91868019,0.00000000,0.00000000,0.00000000,0,0); //convertffs(242)
	CreateDynamicObject(1597,710.51855469,-559.95019531,22.94367981,0.00000000,0.00000000,0.00000000,0,0); //convertffs(243)
	CreateDynamicObject(1280,810.97460938,-605.54669189,15.73729324,0.00000000,0.00000000,270.00000000,0,0); //convertffs(244)
	CreateDynamicObject(1597,692.96386719,-578.94531250,22.99367905,0.00000000,0.00000000,0.00000000,0,0); //convertffs(245)
	CreateDynamicObject(1597,693.15625000,-552.01562500,22.99367905,0.00000000,0.00000000,0.00000000,0,0); //convertffs(246)
	CreateDynamicObject(1597,693.16503906,-560.65332031,22.99367905,0.00000000,0.00000000,0.00000000,0,0); //convertffs(247)
	CreateDynamicObject(1597,693.04547119,-569.80395508,22.99367905,0.00000000,0.00000000,0.00000000,0,0); //convertffs(248)
	CreateDynamicObject(2241,706.40673828,-576.06951904,22.45627785,0.00000000,0.00000000,0.00000000,0,0); //convertffs(249)
	CreateDynamicObject(2244,703.86297607,-576.27307129,22.62911606,0.00000000,0.00000000,0.00000000,0,0); //convertffs(250)
	CreateDynamicObject(1280,806.78027344,-605.29962158,15.74460030,0.00000000,0.00000000,268.00000000,0,0); //convertffs(251)
	CreateDynamicObject(2245,694.32434082,-569.84338379,22.02801895,0.00000000,0.00000000,0.00000000,0,0); //convertffs(252)
	CreateDynamicObject(2252,694.24407959,-573.10321045,22.04168510,0.00000000,0.00000000,0.00000000,0,0); //convertffs(253)
	CreateDynamicObject(1526,811.52392578,-614.12878418,16.61319542,0.00000000,0.00000000,270.00000000,0,0); //convertffs(254)
	CreateDynamicObject(2253,700.86322021,-546.24475098,21.99965286,0.00000000,0.00000000,0.00000000,0,0); //convertffs(255)
	CreateDynamicObject(2345,715.92382812,-571.82128906,20.19150925,0.00000000,0.00000000,90.00000000,0,0); //convertffs(256)
	CreateDynamicObject(2345,715.90820312,-569.62011719,20.19150925,0.00000000,0.00000000,90.00000000,0,0); //convertffs(257)
	CreateDynamicObject(1258,802.44866943,-605.80584717,16.00496483,0.00000000,0.00000000,0.00000000,0,0); //convertffs(258)
	CreateDynamicObject(2345,715.89257812,-567.46972656,20.19150925,0.00000000,0.00000000,90.00000000,0,0); //convertffs(259)
	CreateDynamicObject(2345,715.94244385,-564.30249023,19.51651955,359.79583740,35.25024414,90.14428711,0,0); //convertffs(260)
	CreateDynamicObject(2345,715.94555664,-562.55041504,18.29153824,359.79125977,35.24963379,90.14282227,0,0); //convertffs(262)
	CreateDynamicObject(2345,715.94567871,-560.73712158,17.04155731,359.79125977,35.24963379,90.14282227,0,0); //convertffs(263)
	CreateDynamicObject(2345,715.93774414,-558.97979736,15.81656075,359.79125977,35.24963379,90.14282227,0,0); //convertffs(264)
	CreateDynamicObject(2345,715.92559814,-566.01202393,20.19150925,0.00000000,0.00000000,90.00000000,0,0); //convertffs(265)
	CreateDynamicObject(2345,716.06604004,-572.96350098,20.19150925,0.00000000,0.00000000,90.00000000,0,0); //convertffs(267)
	CreateDynamicObject(2345,715.94744873,-574.56359863,19.61651802,0.00000000,320.00000000,90.00000000,0,0); //convertffs(268)
	CreateDynamicObject(1346,813.45208740,-613.10845947,16.68694305,0.00000000,0.00000000,270.00000000,0,0); //convertffs(269)
	CreateDynamicObject(2345,716.01251221,-576.19726562,18.54153442,0.00000000,319.99877930,90.00000000,0,0); //convertffs(270)
	CreateDynamicObject(2345,715.95611572,-577.81103516,17.31655312,0.00000000,319.99877930,90.00000000,0,0); //convertffs(271)
	CreateDynamicObject(2345,715.99096680,-579.51953125,16.16657066,0.00000000,322.24880981,90.00000000,0,0); //convertffs(272)
	CreateDynamicObject(2900,835.38403320,-605.78662109,15.33593750,0.00000000,0.00000000,0.00000000,0,0); //convertffs(274)
	CreateDynamicObject(3439,702.71484375,-566.32910156,24.44964600,0.00000000,0.00000000,0.00000000,0,0); //convertffs(275)
	CreateDynamicObject(1449,802.33825684,-613.86743164,15.85759163,0.00000000,0.00000000,178.00000000,0,0); //convertffs(276)
	CreateDynamicObject(1372,835.40136719,-614.72119141,15.34324455,0.00000000,0.00000000,180.00000000,0,0); //convertffs(278)
	CreateDynamicObject(1594,702.69738770,-564.14221191,20.81328773,0.00000000,0.00000000,0.00000000,0,0); //convertffs(280)
	CreateDynamicObject(1594,700.66406250,-566.30877686,20.81328773,0.00000000,0.00000000,0.00000000,0,0); //convertffs(281)
	CreateDynamicObject(1358,834.62036133,-608.66107178,16.53948402,0.00000000,0.00000000,274.00000000,0,0); //convertffs(282)
	CreateDynamicObject(1280,709.28723145,-549.40106201,20.73765182,0.00000000,0.00000000,0.00000000,0,0); //convertffs(283)
	CreateDynamicObject(1280,709.29235840,-554.22503662,20.73765182,0.00000000,0.00000000,0.00000000,0,0); //convertffs(284)
	CreateDynamicObject(1338,833.12255859,-605.22625732,16.04724693,0.00000000,0.00000000,0.00000000,0,0); //convertffs(285)
	CreateDynamicObject(1280,709.27844238,-559.10131836,20.73765182,0.00000000,0.00000000,0.00000000,0,0); //convertffs(286)
	CreateDynamicObject(1280,709.28393555,-563.67346191,20.73765182,0.00000000,0.00000000,0.00000000,0,0); //convertffs(287)
	CreateDynamicObject(1280,709.27404785,-575.83459473,20.73765182,0.00000000,0.00000000,0.00000000,0,0); //convertffs(288)
	CreateDynamicObject(1224,835.50201416,-611.67364502,15.95085144,0.00000000,0.00000000,0.00000000,0,0); //convertffs(289)
	CreateDynamicObject(1280,709.26916504,-581.31201172,20.73765182,0.00000000,0.00000000,0.00000000,0,0); //convertffs(290)
	CreateDynamicObject(1280,694.49359131,-581.83862305,20.73765182,0.00000000,0.00000000,180.00000000,0,0); //convertffs(291)
	CreateDynamicObject(1280,694.44458008,-576.17016602,20.73765182,0.00000000,0.00000000,179.99450684,0,0); //convertffs(292)
	CreateDynamicObject(1280,694.54827881,-566.92852783,20.73765182,0.00000000,0.00000000,179.99450684,0,0); //convertffs(293)
	CreateDynamicObject(1280,694.71289062,-562.12597656,20.73765182,0.00000000,0.00000000,179.99450684,0,0); //convertffs(294)
	CreateDynamicObject(1280,694.60644531,-556.20214844,20.73765182,0.00000000,0.00000000,179.99450684,0,0); //convertffs(295)
	CreateDynamicObject(1280,694.78808594,-550.44921875,20.73765182,0.00000000,0.00000000,179.99450684,0,0); //convertffs(296)
	CreateDynamicObject(1265,833.91729736,-607.99725342,17.40752792,0.00000000,0.00000000,0.00000000,0,0); //convertffs(297)
	CreateDynamicObject(1594,702.23254395,-549.79779053,20.81328773,0.00000000,0.00000000,0.00000000,0,0); //convertffs(299)
	CreateDynamicObject(1594,702.84960938,-574.82031250,20.81328773,0.00000000,0.00000000,0.00000000,0,0); //convertffs(300)
	CreateDynamicObject(1300,808.84350586,-605.82690430,15.70585346,0.00000000,0.00000000,0.00000000,0,0); //convertffs(301)
	CreateDynamicObject(2670,811.87725830,-605.22454834,15.49513721,0.00000000,0.00000000,0.00000000,0,0); //convertffs(303)
	CreateDynamicObject(1428,824.49334717,-613.27929688,16.90379333,0.00000000,0.00000000,184.00000000,0,0); //convertffs(304)
	CreateDynamicObject(1345,785.99218750,-612.45117188,16.10607338,0.00000000,0.00000000,181.99951172,0,0); //convertffs(311)
	CreateDynamicObject(1224,780.34564209,-596.68341064,15.95085144,0.00000000,0.00000000,0.00000000,0,0); //convertffs(316)
	CreateDynamicObject(1355,781.20043945,-593.23065186,15.53290462,0.00000000,0.00000000,0.00000000,0,0); //convertffs(318)
	CreateDynamicObject(1300,784.97167969,-543.55468750,15.70585346,0.00000000,0.00000000,0.00000000,0,0); //convertffs(319)
	CreateDynamicObject(1236,794.00378418,-612.70233154,16.00597000,0.00000000,0.00000000,0.00000000,0,0); //convertffs(321)
	CreateDynamicObject(1441,867.44342041,-587.26330566,17.68738365,0.00000000,0.00000000,0.00000000,0,0); //convertffs(327)
	CreateDynamicObject(3273,863.68652344,-579.75585938,17.07030487,0.00000000,0.00000000,0.00000000,0,0); //convertffs(328)
	CreateDynamicObject(3273,859.60937500,-579.71777344,17.07030487,0.00000000,0.00000000,0.00000000,0,0); //convertffs(329)
	CreateDynamicObject(3273,855.38964844,-579.61132812,17.07030487,0.00000000,0.00000000,0.00000000,0,0); //convertffs(330)
	CreateDynamicObject(3287,867.21252441,-585.10058594,21.83553123,0.00000000,0.00000000,0.00000000,0,0); //convertffs(331)
	CreateDynamicObject(3643,839.99243164,-610.59136963,22.99384689,0.00000000,0.00000000,0.00000000,0,0); //convertffs(332)
	CreateDynamicObject(3675,864.54510498,-584.27062988,18.73554611,0.00000000,0.00000000,270.00000000,0,0); //convertffs(333)
	CreateDynamicObject(3675,864.54589844,-585.22460938,18.73554611,0.00000000,0.00000000,270.00000000,0,0); //convertffs(334)
	CreateDynamicObject(920,850.23535156,-581.01562500,17.69601631,0.00000000,0.00000000,0.00000000,0,0); //convertffs(335)
	CreateDynamicObject(929,848.85449219,-580.00585938,18.20067406,0.00000000,0.00000000,0.00000000,0,0); //convertffs(336)
	CreateDynamicObject(1353,848.86132812,-582.79785156,17.83168983,0.00000000,0.00000000,0.00000000,0,0); //convertffs(337)
	CreateDynamicObject(1420,848.70147705,-583.96411133,17.12840652,0.00000000,0.00000000,0.00000000,0,0); //convertffs(338)
	CreateDynamicObject(1687,850.05566406,-585.09960938,17.90790367,0.00000000,0.00000000,0.00000000,0,0); //convertffs(339)
	CreateDynamicObject(1688,863.42871094,-582.78417969,18.18431091,0.00000000,0.00000000,0.00000000,0,0); //convertffs(340)
	CreateDynamicObject(3259,872.81683350,-613.30902100,17.42187500,0.00000000,0.00000000,88.00000000,0,0); //convertffs(341)
	CreateDynamicObject(12957,814.79028320,-564.84790039,16.21415520,0.00000000,0.00000000,270.00000000,0,0); //convertffs(342)
	CreateDynamicObject(1230,814.71362305,-564.34472656,16.55625153,0.00000000,0.00000000,0.00000000,0,0); //convertffs(343)
	CreateDynamicObject(2671,816.85076904,-564.85351562,15.61017323,0.00000000,0.00000000,0.00000000,0,0); //convertffs(344)
	CreateDynamicObject(1526,690.93981934,-456.46127319,16.39889145,0.00000000,0.00000000,90.00000000,0,0); //convertffs(346)
	CreateDynamicObject(3944,711.84320068,-571.01605225,11.26640701,0.00000000,270.00000000,180.00000000,0,0); //convertffs(347)
	CreateDynamicObject(3944,711.84277344,-569.00000000,11.26640701,0.00000000,270.00000000,179.99450684,0,0); //convertffs(348)
	CreateDynamicObject(3944,711.84277344,-566.99987793,11.26640701,0.00000000,270.00000000,179.99450684,0,0); //convertffs(349)
	CreateDynamicObject(3944,711.84277344,-564.99987793,11.26640701,0.00000000,270.00000000,179.99450684,0,0); //convertffs(350)
	CreateDynamicObject(3944,711.84277344,-564.21002197,11.23600006,0.00000000,270.00000000,179.99450684,0,0); //convertffs(351)
	CreateDynamicObject(1432,702.93444824,-568.66546631,20.33629608,0.00000000,0.00000000,56.00000000,0,0); //object(dyn_table_2) (1)
	CreateDynamicObject(1432,705.01245117,-566.46917725,20.33629608,0.00000000,0.00000000,115.99728394,0,0); //object(dyn_table_2) (2)
	CreateDynamicObject(1432,702.94232178,-582.87921143,20.33629608,0.00000000,0.00000000,55.99731445,0,0); //object(dyn_table_2) (3)
	CreateDynamicObject(1432,703.06433105,-556.77160645,20.33629608,0.00000000,0.00000000,115.99365234,0,0); //object(dyn_table_2) (4)
	CreateDynamicObject(1255,739.04614258,-487.50692749,16.59259987,0.00000000,0.00000000,329.99816895,0,0); //convertffs(168)
	CreateDynamicObject(1255,739.87890625,-485.90802002,16.59259987,0.00000000,0.00000000,329.99633789,0,0); //convertffs(168)
	CreateDynamicObject(1255,777.20806885,-517.20031738,16.11760712,0.00000000,0.00000000,239.99633789,0,0); //convertffs(168)

}//
*/