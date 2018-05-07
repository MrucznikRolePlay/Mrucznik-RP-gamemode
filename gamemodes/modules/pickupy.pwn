//pickupy.pwn

ZaladujIkony()
{
	CreateDynamicMapIcon(857.3464,-2100.0881,9.8666, 9, 1, -1, -1, -1, 150.0);//≥odzie
	CreateDynamicMapIcon(-1262.5095, 40.3263, 14.1392, 5, 1, -1, -1, -1, 250.0);//samoloty
	CreateDynamicMapIcon(2132.0371, -1149.7332, 24.2372, 55, 1, -1, -1, -1, 150.0);//pojazdy
	return 1;
}

ZaladujPickupy()
{
	//Pickupy
	CreateDynamicPickup(1239, 1, 1173.2563,-1323.3102,15.3943, -1); //Hospital 1 near Ammu
	CreateDynamicPickup(1239, 0, 2029.5945,-1404.6426,17.2512, -1); //Hospital 2 near speedway
	CreateDynamicPickup(1239, 2, 1381.0413,-1088.8511,27.3906, -1); //Bill Board (old Job Department)
	
	//forelli
	CreateDynamicPickup(1239, 2, 1285.5999755859,-981.79998779297,32.700000762939, -1);
	CreateDynamicPickup(1239, 2, -1716.1999511719,1018.200012207,17.60000038147, -1);
	CreateDynamicPickup(1239, 2, 1302.8000488281,-988.20001220703,38.299999237061, -1);
	CreateDynamicPickup(1239, 2, 1300.0999755859,-1094.5999755859,5972.2001953125, -1);
	CreateDynamicPickup(1239, 2, 1301.8000488281,-1083.9000244141,5972.2001953125, -1);
	CreateDynamicPickup(1239, 2, -1865.6999511719,1116.8000488281,6799.10009765, -1);
	CreateDynamicPickup(1239, 2, -1877.1999511719,1178,6799.2998046875, -1);
	CreateDynamicPickup(1239, 2, -1837.1999511719,1160.0999755859,6799, -1);
	CreateDynamicPickup(1239, 2, -1858.3000488281,1158.3000488281,6799, -1);
	CreateDynamicPickup(1239, 2, -1858.5,1160.5999755859,6799, -1);
	CreateDynamicPickup(1239, 2, -1825.4000244141,1151.6999511719,6803.2998046875, -1);
	

	CreateDynamicPickup(371, 2, 1544.2,-1353.4,329.4, -1); //LS towertop
	CreateDynamicPickup(371, 2, 1536.0, -1360.0, 1150.0, -1); //LS towertop
	CreateDynamicPickup(1242, 2, 1527.5,-12.1,1002.0, -1); //binco armor
	CreateDynamicPickup(371, 2, 98.635467529297, 1775.6868896484, 50.96265411377, -1); //Tor treningowy spadochron
	CreateDynamicPickup(1239, 2, 608.19793701172, -1458.9837646484, 14.387271881104 , -1);//baza FBI
 	/*CreateDynamicPickup(1239, 2, 2452.005859375,-1666.1260986328,13.477073669434 , -1); // Przystanek koÒcowy: Ganton - Groove Street
	CreateDynamicPickup(1239, 2, 2163.0180664063,-1758.4976806641,13.547880172729, -1); // Idlewood - Silownia
	CreateDynamicPickup(1239, 2, 2179.3752441406,-1711.3572998047,13.526877403259, -1); // Idlewood - Silownia
	CreateDynamicPickup(1239, 2, 1890.3483886719,-1744.2761230469,13.546875, -1); // Idlewood - Stacja benzynowa
	CreateDynamicPickup(1239, 2, 1925.3206787109,1760.4560546875,13.546875, -1); // Idlewood - Stacja benzynowa
	CreateDynamicPickup(1239, 2, 1743.8525390625,-1810.5493164063,13.568388938904, -1); // El Corona - Unity Station
	CreateDynamicPickup(1239, 2, 1790.5799560547,-1839.7934570313,13.572521209717, -1); // El Corona - Unity Station
	CreateDynamicPickup(1239, 2, 1523.8828125,-1694.9890136719,13.546875, -1); // Pershing Square - Komisariat
	CreateDynamicPickup(1239, 2, 1535.2431640625,-1647.8034667969,13.546875, -1); // Pershing Square - Komisariat
	CreateDynamicPickup(1239, 2, 1363.3416748047,-1275.2260742188,13.546875, -1); // Downtown - Ammu-Nation
	CreateDynamicPickup(1239, 2, 1336.8793945313,-1348.0667724609,13.546875, -1); // Downtown - Ammu-Nation
	CreateDynamicPickup(1239, 2, 1451.1014404297,-1041.8737792969,23.828125, -1); // Downtown - Bank
	CreateDynamicPickup(1239, 2, 1451.2653808594,-1025.9205322266,23.828125, -1); // Downtown - Bank
	CreateDynamicPickup(1239, 2, 1782.1417236328,-1163.5463867188,23.828125, -1); // Downtown - Mrucznikowy Gun Shop
	CreateDynamicPickup(1239, 2, 1811.40234375,-1185.9276123047,23.828125, -1); // Downtown - Mrucznikowy Gun Shop
	CreateDynamicPickup(1239, 2, 1964.6368408203,-1201.1809082031,25.785903930664, -1); //bus glen
	CreateDynamicPickup(1239, 2, 2316.6101074219,-1665.5198974609,14.251803398132, -1); // Ganton - Bar "Ten green bottles"
	CreateDynamicPickup(1239, 2, 2296.3830566406,-1653.36328125,14.82245349884, -1); // Ganton - Bar "Ten green bottles"
	CreateDynamicPickup(1239, 2, 2226.7065429688,-2204.9982910156,13.546875, -1); // "Ocean Docks - Fabryka"
	CreateDynamicPickup(1239, 2, 2741.4299316406,-2000.4523925781,13.5546875, -1); //"Playa del Seville - Osiedle mieszkaniowe"
	CreateDynamicPickup(1239, 2, 2763.8073730469,-1937.013671875,13.539384841919, -1); //"Playa del Seville - Osiedle mieszkaniowe2"
	CreateDynamicPickup(1239, 2, 2847.9274902344,-1563.1618652344,11.093752861023, -1); //"East Beach - Baza Mechanikow"
	CreateDynamicPickup(1239, 2, 2867.8012695313,-1539.7840576172,11.093752861023, -1); //"East Beach - Baza Mechanikow2"
	CreateDynamicPickup(1239, 2, 2843.7377929688,-1097.9293212891,24.118738174438, -1); //"East Beach - Zaklad Bukmacherski"
	CreateDynamicPickup(1239, 2, 2832.1416015625,-1101.7882080078,24.260314941406, -1); //"East Beach - Zaklad Bukmacherski"
	CreateDynamicPickup(1239, 2, 2436.2917480469,-1262.3370361328,24.0, -1); //"East Los Santos - Pig Pen"
	CreateDynamicPickup(1239, 2, 2389.1911621094,-1250.794921875,23.902835845947, -1); //"East Los Santos - Pig Pen"
	CreateDynamicPickup(1239, 2, 2254.9758300781,-1151.0307617188,26.672472000122, -1); // "Jefferson - Motel Jefferson"
	CreateDynamicPickup(1239, 2, 2248.9545898438,-1132.9829101563,26.325132369995, -1); // "Jefferson - Motel Jefferson"
	CreateDynamicPickup(1239, 2, 1307.6668701172,-916.51196289063,38.873985290527, -1); //"Temple - 24/7"
	CreateDynamicPickup(1239, 2, 1318.3203125,-939.79602050781,37.822116851807, -1); //"Temple - 24/7"
	CreateDynamicPickup(1239, 2, 1036.2315673828,-1155.5111083984,23.820327758789, -1); // "Market - Kasyno"
	CreateDynamicPickup(1239, 2, 1008.0661621094,-1133.0928955078,23.828125, -1); // "Market - Kasyno2"
	CreateDynamicPickup(1239, 2, 1036.2315673828,-1155.5111083984,23.820327758789, -1); //  "Market - Kasyno2"
	CreateDynamicPickup(1239, 2, 1008.0661621094,-1133.0928955078,23.828125, -1); //  "Market - Kasyno2"
	CreateDynamicPickup(1239, 2, 911.25482177734,-1380.9995117188,13.489659309387, -1); //"Market - Cluckin&Bell"
	CreateDynamicPickup(1239, 2, 923.01147460938,-1340.8969726563,13.501903533936, -1); //"Market - Cluckin&Bell"
	CreateDynamicPickup(1239, 2, 723.23773193359,-1413.8408203125,13.51894569397, -1); // "Rodeo - Wloska Restauracja / Studio SAN"
	CreateDynamicPickup(1239, 2, 709.17822265625,-1387.4063720703,13.687715530396, -1); // "Rodeo - Wloska Restauracja / Studio SAN"
	CreateDynamicPickup(1239, 2, 359.1096496582,-1653.7490234375,32.904319763184, -1); //"Rodeo - Klub wedkarski"
	CreateDynamicPickup(1239, 2, 351.99530029297,-1636.6911621094,33.115753173828, -1); //"Rodeo - Klub wedkarski"
	CreateDynamicPickup(1239, 2, 335.34939575195,-1529.0958251953,33.285037994385, -1); //"Rodeo - Mark's Plaza"
	CreateDynamicPickup(1239, 2, 1978.0007324219,-1196.2591552734,25.851963043213, -1); //"Glen park"*/

	CreateDynamicPickup(1239, 2, 2127.66210938,-1153.92480469,23.48433304, -1);//bankomat
	CreateDynamicPickup(1239, 2, 1040.38732910,-1131.23059082,23.46322632 , -1);//bankomat
	CreateDynamicPickup(1239, 2, 1493.25781250,-1022.13476562,23.46905136 , -1);//bankomat
	CreateDynamicPickup(1239, 2, 2842.70239258,-1562.88049316, 10.73664951 , -1);//bankomat
	CreateDynamicPickup(1239, 2, 2072.01953125,-1825.50097656, 13.18, -1);//bankomat
	CreateDynamicPickup(1239, 2, 1928.63220215,-1768.14794922, 13.21 , -1);//bankomat
	CreateDynamicPickup(1239, 2, 1787.46899414,-1867.33886719,13.21315384 , -1);//bankomat
	CreateDynamicPickup(1239, 2, 852.48236084,-2061.84008789,12.51009178 , -1);//bankomat
	CreateDynamicPickup(1239, 2, 341.01486206,-1517.85717773,32.83914185 , -1);//bankomat
	CreateDynamicPickup(1239, 2, 2701.67407227,-2417.54223633,13.27571201 , -1);//bankomat
	CreateDynamicPickup(1239, 2, 1186.23657227,-1368.89025879,13.30330658 , -1);//bankomat
	CreateDynamicPickup(1239, 2, 2422.64990, -2066.10449, 13.06690, -1); //PAèDZIOCH - bankomat
	CreateDynamicPickup(1239, 2, 2273.19409, -76.92720, 26.13300, -1);//bankomat
	CreateDynamicPickup(1239, 2, 660.66510, -575.86359, 15.97310, -1);//bankomat
	CreateDynamicPickup(1239, 2, 646.56738, -1368.89001, 13.34690, -1);//bankomat
	CreateDynamicPickup(1239, 2, 388.16299, -1805.75916, 7.58990, -1);//bankomat
	CreateDynamicPickup(1239, 2, 1000.25879, -923.74335, 42.08330, -1);//bankomat
	CreateDynamicPickup(1239, 2, 2325.2957,-1264.2312,22.5070 , -1);//NoA	
	CreateDynamicPickup(1239, 2, 2137.3999023438,-2290.6000976563,20.700000762939 , -1);//maszyna do robienia materia≥Ûw	
	
	CreateDynamicPickup(1239, 2, 301.29656982422, -1515.7513427734, 13.809589385986, -1); // "i" w windzie w biurowcu
    CreateDynamicPickup(1239, 2, 319.72470092773, -1548.3374023438, 13.845289230347, -1); // "i" w kancelarii
    CreateDynamicPickup(1239, 2, 322.0553894043, 303.41961669922, 999.1484375, -1); // "i" w biurze detektywÛw
	
	return 1;
}

Zaladuj3DTexty()
{
	//wybory
	//CreateDynamic3DTextLabel("Urna wyborcza", 0x33CCFFAA, 1304.1296, -1299.9874, 35.6941, 25.0);

	okienko[0] = CreateDynamic3DTextLabel("Urzπd Miasta Los Santos\n{0080FF}Okienko 1 \n {FF0000}Nieczynne",COLOR_WHITE,1090.3307,1057.3446,-15.8397,9,INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 50);
	okienko[1] = CreateDynamic3DTextLabel("Urzπd Miasta Los Santos\n{0080FF}Okienko 2 \n {FF0000}Nieczynne",COLOR_WHITE,1086.4092,1057.3446,-15.8397,9,INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 50);
	okienko[2] = CreateDynamic3DTextLabel("Urzπd Miasta Los Santos\n{0080FF}Okienko 3 \n {FF0000}Nieczynne",COLOR_WHITE,1082.3263,1057.3446,-15.8397,9,INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 50);
	okienko[3] = CreateDynamic3DTextLabel("Urzπd Miasta Los Santos\n{0080FF}Okienko 4 \n {FF0000}Nieczynne",COLOR_WHITE,1078.3583,1057.3446,-15.8397,9,INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 50);
	okienko[4] = CreateDynamic3DTextLabel("Urzπd Miasta Los Santos\n{0080FF}Okienko 5 \n {FF0000}Nieczynne",COLOR_WHITE,1078.1128,1075.3777,-15.8397,9,INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 50);
	okienko[5] = CreateDynamic3DTextLabel("Urzπd Miasta Los Santos\n{0080FF}Okienko 6 \n {FF0000}Nieczynne",COLOR_WHITE,1082.2820,1075.3777,-15.8397,9,INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 50);
	okienko[6] = CreateDynamic3DTextLabel("Urzπd Miasta Los Santos\n{0080FF}Okienko 7 \n {FF0000}Nieczynne",COLOR_WHITE,1086.3070,1075.3777,-15.8397,9,INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 50);
	okienko[7] = CreateDynamic3DTextLabel("Urzπd Miasta Los Santos\n{0080FF}Okienko 8 \n {FF0000}Nieczynne",COLOR_WHITE,1090.3898,1075.3777,-15.8397,9,INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 50);
	
    CreateDynamic3DTextLabel("Weü zlecenie - PIZZA", 0xFFA500AA, 2103.8123,-1798.7085,13.6504,30.0);//PizzaJob
	//nowe domy 3dtext biznesÛw
	CreateDynamic3DTextLabel("Oczysczanie z zarzutow", 0x33CCFFAA, 246.3568,120.3933,1003.2682, 10.0); //Clear icon in Police Station
	CreateDynamic3DTextLabel("Urzπd Miasta", 0x9ACD32AA, 1481.1531,-1770.0277,18.7958, 50.0); //City Hall
	CreateDynamic3DTextLabel("Urzπd Miasta - zaplecze", 0x9ACD32AA, 1412.3348388672, -1790.5777587891, 15.370599746704, 10.0); //City Hall
	CreateDynamic3DTextLabel("Praca £owcy NagrÛd", 0xFFA500AA, 322.3034,317.0233,999.1484, 30.0); //Detective Registration
	CreateDynamic3DTextLabel("Praca Prawnika", 0xFFA500AA, 310.3626,-1503.3282,13.8096, 30.0); //Lawyer Registration
	CreateDynamic3DTextLabel("Praca Dziwki", 0xFFA500AA, 1215.1304,-11.8431,1000.9219, 15.0); //Whore Registration
	CreateDynamic3DTextLabel("Praca Dilera Dragow", 0xFFA500AA, 2166.3772,-1675.3829,15.0859, 30.0); //DrugDealer Registration
	CreateDynamic3DTextLabel("Praca Zlodzieja Aut", 0xFFA500AA, 1109.3318,-1796.3042,16.5938, 30.0); //CarJacker Registration 7
	CreateDynamic3DTextLabel("Praca Mechanika", 0xFFA500AA, -1932.3859,276.2117,41.0391,30.0); //CarMechanic Registration
	CreateDynamic3DTextLabel("Praca Mechanika", 0xFFA500AA, 2769.8376,-1610.7819,10.9219,30.0); //CarMechanic Registration
	CreateDynamic3DTextLabel("Praca Ochroniarza", 0xFFA500AA, 2226.1716,-1718.1792,13.5165, 30.0); //BodyGuard Registration
	CreateDynamic3DTextLabel("Praca Dilera Broni", 0xFFA500AA, 1366.4325,-1275.2096,13.5469, 30.0); //ArmsDealer Registration
	//CreateDynamic3DTextLabel("Praca Dilera Aut", 0xFFA500AA, 531.7930,-1292.4044,17.2422, 30.0); //CarDealer Registration 12
	CreateDynamic3DTextLabel("Praca Boksera", 0xFFA500AA, 766.0804,14.5133,1000.7004, 30.0); //Boxer Registration
	CreateDynamic3DTextLabel("Praca Kierowcy Autobusu", 0xFFA500AA, 1154.2208,-1770.8203,16.5992, 10.0); //BusDriver Registration
	//CreateDynamic3DTextLabel("Praca TaksÛwkarza\nMoøliwoúc podjÍcia tej\npracy zosta≥a wy≥πczona\nna czas nieokreúlony.", 0xFFA500AA, 1750.7670,-1944.7601,13.5655, 20.0); //BusDriver Registration
	//CreateDynamic3DTextLabel("Praca Truckera", 0xFFA500AA, -77.7288,-1136.3896,1.0781, 30.0); //Trucker Registration
	CreateDynamic3DTextLabel("Melina Dragowa", 0xFFA500AA, 323.0342,1118.5804,1083.8828, 30.0); //Getting Drugs for DrugDealers 17
    CreateDynamic3DTextLabel("Paczka z zio≥em\n/get drugs", 0xFFA500AA, -1022.34930420,-2158.46484375,33.91813278, 30.0);
	CreateDynamic3DTextLabel("Helvetica Cargo Ltd.", 0xAA3333AA, 597.1277,-1248.6479,18.2734, 50.0);
	CreateDynamic3DTextLabel("Fabryka Broni", 0xAA3333AA, -2119.5469,-178.5679,35.3203, 50.0); //Factory SF
	CreateDynamic3DTextLabel("Baza HA", 0xAA3333AA, -50,-269,6.599999, 30.0); //Hitman Agency entrance
	CreateDynamic3DTextLabel("KoúciÛ≥", COLOR_NEWS, 2254.8652,-1334.2078,23.9922, 30.0); //KoúciÛ≥
	//CreateDynamic3DTextLabel("O≥tarz", COLOR_NEWS, 1964.2332,-369.1353,1093.7289, 10.0); //KoúciÛ≥
	CreateDynamic3DTextLabel("KosciÛ≥ w Palomino Creek [/slub]", COLOR_NEWS, 2256.8000488281,-43.900001525879,26.5, 10.0); //KoúciÛ≥
	CreateDynamic3DTextLabel("Baza Puro Cubano", COLOR_NEWS, -382.5024, -1426.3225, 26.1998, 20.0); //Baza Puro Cubano
	CreateDynamic3DTextLabel("Witamy na torze øuølowym\nWpisz /zuzel aby zobaczyc komendy", 0x0080FFFF, -1150.0270,-990.5195,130.8855, 10.0); //Tor øuølowy
	CreateDynamic3DTextLabel("Pπczkarnia u Alena", 0x0080FFFF, 1038.1452636719, -1339.3377685547,13.72, 20.0); //Pπczkarnia 26
	CreateDynamic3DTextLabel("Basen 'Tsunami'", COLOR_BLUE, 1210.552734375,-1749.1850585938,13.593885421753, 50.0);
	CreateDynamic3DTextLabel("Publiczne\nTory szkoleniowe FBI", COLOR_NEWS, 1271.0920,-1667.8794,19.7344, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 60);
    CreateDynamic3DTextLabel("Wyjúcie z toru", COLOR_NEWS, 1630.513671875,5232.2626953125,2.6707870960236, 10.0);
    CreateDynamic3DTextLabel("Wyjúcie z toru", COLOR_NEWS, -433.55599975586,-3812.8073730469,176.7035064697, 10.0);
    CreateDynamic3DTextLabel("$$ Bymber Casino $$", TEAM_GROVE_COLOR, 1022.7183837891,-1122.4310302734,23.871517181396, 50.0);
    CreateDynamic3DTextLabel("Przebieralnia", COLOR_NEWS, 988.94909667969,-3676.5551757813,1.2307510375977, 10.0);
    CreateDynamic3DTextLabel("Przebieralnia", COLOR_NEWS, 994.54052734375,-3676.474609375,1.2307510375977, 10.0);
    CreateDynamic3DTextLabel("Sala przes≥uchaÒ", COLOR_NEWS, 276.32934570313,122.20029449463,1004.1166992188, 10.0);
    CreateDynamic3DTextLabel("SAN - g≥Ûwne wejúcie", COLOR_NEWS, 646.9418,-1355.8645,13.5625, 30.0);
    CreateDynamic3DTextLabel("Dyrekcja", COLOR_BLUE, 1523.0439,-1466.9510,64.7786, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 32);
    CreateDynamic3DTextLabel("Sala posiedzeÒ", COLOR_BLUE, -778.3271484375,496.4326171875,1368.5303955078, 5.0);
    CreateDynamic3DTextLabel("Zaklad Bukmaherski", COLOR_BLUE, 1631.7883300781,-1171.4095458984,24.078125, 15.0);
    CreateDynamic3DTextLabel("Gabinet Oyabuna", COLOR_BLUE, 368.3667,193.8689,1008.3828, 5.0);
    CreateDynamic3DTextLabel("Studio tatuaøu", COLOR_BLUE, 2292.3088,-1723.3538,13.5469, 10.0);
    CreateDynamic3DTextLabel("Stare studio tatuaøu", COLOR_BLUE, 1975.9598388672,-2036.7775878906,13.546875, 5.0);
    CreateDynamic3DTextLabel("Verte Bank\nOddzia≥ Los Santos", COLOR_BLUE, 1462.395751,-1012.391174,26.843799, 10.0);
    CreateDynamic3DTextLabel("Verte Bank\nOddzia≥ Palomino Creek", COLOR_BLUE, 2302.7798,-15.9637,26.4844, 10.0);
    CreateDynamic3DTextLabel("Motel 'Dziki Tygrys'", 0xFF69B4, 1941.1919,-2115.6655,13.6953, 10.0);
    CreateDynamic3DTextLabel("Biuro\nKorporacji Transportowej", COLOR_BLUE, 2518.0, -2127.0, 13.5, 7.0);
    CreateDynamic3DTextLabel("Tylne wejúcie", COLOR_BLUE, 593.5989,-1489.5365,15.2650, 5.0);

	//--------------[Moje Pickupy i 3D moje 3d texty]---------------- {9ACD32}

	CreateDynamic3DTextLabel("Komisariat", 0x0080FFFF, 1553.3929,-1675.4796,16.1953, 40.0); //Wejúcie do komisariatu
    CreateDynamic3DTextLabel("Szpital Wszystkich SwiÍtych", 0xFF6347FF, 1173.3959,-1323.5605,15.3924, 25.0);
    CreateDynamic3DTextLabel("Jetty Lounge", 0x9ACD32AA, 725.7198,-1439.3527,13.5391, 30.0);
    CreateDynamic3DTextLabel("Taras", 0x9ACD32AA, 725.4005,-1450.4960,17.6953, 30.0);
    CreateDynamic3DTextLabel("Agencja Ochrony braci Nakajima", 0xFF0000FF, 2793.9031,-1087.2518,30.7188, 30.0);
    new str2[512];
    str2 = "{FFA500}DowÛd osobisty - {9ACD32}5000$ +akt urodz.\n{FFA500}Wydanie Prawa Jazdy - {9ACD32}20 000$ +zal. egz.\n {FFA500}Patent Øeglarski - {9ACD32}350 000$\n {FFA500}Pozwolenie na bron - {9ACD32}500 000$\n {FFA500}Licencja Pilota - {9ACD32}5 000 000$\n {FFA500}Karta wÍdkarska - {9ACD32}10 000$\n{9ACD32}Egzamin teoretyczny - 10 000${FFA500}\n{9ACD32}Egzamin praktyczny- {9ACD32} 15 000$";
    CreateDynamic3DTextLabel(str2, COLOR_NEWS, 1099.1101,1059.0592,-19.6241,12,INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 50);//Cennik DMV
    str2 = "BACZNOå∆ \n{7CFC00}By nie zostaÊ oszukanym:\n {8B0000}1. NIGDY NIE GRAJ gdy ktoú chce graÊ o wiÍcej niø ma w {FFFFFF}/sprawdzkase [ID]\n{9ACD32}Jeøeli mimo to zostaniesz oszukany NATYCHMIAST zg≥oú ten fakt na {FFFFFF}/report{9ACD32} - oszust otrzyma od razu blocka\nGdy taka osoba otrzyma blokadÍ ty masz 10min na napisanie na niego skargi\nW ten sposÛb moøesz odzyskaÊ nawet 100%% wygranej!!";
	CreateDynamic3DTextLabel(str2, COLOR_PANICRED ,1032.8098,-1091.7827,-66.5729, 20.0);
    CreateDynamic3DTextLabel("Los Santos Police Department\n{00FFCC}Zaúwiadczenia o niekaralnoúÊi\nKoszt: {9ACD32}18 000${0080FF}", COLOR_BLUE ,252.3918,117.3390,1005.2188, 2.5);//36

    CreateDynamic3DTextLabel("Taras PD", COLOR_BLUE ,214.9873,121.0619,999.0156, 2.5);//36

    CreateDynamic3DTextLabel("Biurowiec\nFederalnego Biura åledczego", COLOR_BLUE ,608.19793701172, -1458.9837646484, 14.387271881104, 30.0);
	CreateDynamic3DTextLabel("________________________\nKancelaria\n Burmistrza Los Santos \n    Carmen Delacortez     \n________________________", 0xFFA500FF, 1479.9778,-1785.5557,164.3959, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 14);//36
	CreateDynamic3DTextLabel("Toalety", COLOR_GREEN, 1067.7961,1049.3918,-15.6441, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 50);//36
	CreateDynamic3DTextLabel("Do okienek 1-4", COLOR_GREEN, 1090.6261,1051.1055,-15.6441, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 50);//36
	CreateDynamic3DTextLabel("Szatnia", COLOR_GREEN, 1060.6478,1061.0955,-15.6441, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 50);//36
	CreateDynamic3DTextLabel("Przejúcie s≥uøbowe", COLOR_GREEN, 1063.2349,1063.8685,-15.6441, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 50);//36
	CreateDynamic3DTextLabel("Toalety", COLOR_GREEN, 1051.6702,1075.4916,-15.6441, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 50);//36
	CreateDynamic3DTextLabel("Szatnia", COLOR_GREEN, 1061.0271,1073.2203,-15.6441, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 50);//36
	CreateDynamic3DTextLabel("Plac manewrowy", COLOR_GREEN, 1062.4417,1083.2163,-15.6441, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 50);//36
	CreateDynamic3DTextLabel("Toaleta publiczna", COLOR_GREEN, 1067.8160,1083.9149,-15.6441, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 50);//36
	CreateDynamic3DTextLabel("Okienka 5-8", COLOR_GREEN, 1090.4949,1081.3397,-15.6441, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 50);//36
	CreateDynamic3DTextLabel("Przejúcie s≥uøbowe", COLOR_GREEN, 1088.3507,1089.1888,-15.6441, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 50);//36
	CreateDynamic3DTextLabel("Biuro GPB", COLOR_GREEN, 1074.1942,1061.7606,-15.6441, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 50);//36
	CreateDynamic3DTextLabel("Izolatka GPB", COLOR_GREEN, 1074.3879,1071.4058,-15.6441, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 50);//36

	CreateDynamic3DTextLabel("Biuro UrzÍdnikÛw", COLOR_GREEN, 1485.7014,-1775.9730,164.3959, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 60);//36
	CreateDynamic3DTextLabel("Sanepid", COLOR_GREEN, 1474.3630,-1782.3595,164.3959, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 60);//36
	CreateDynamic3DTextLabel("Wydzia≥ Planowania", COLOR_GREEN, 1485.7137,-1782.2922,164.3959, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 60);//36
	CreateDynamic3DTextLabel("Sala obrad", COLOR_GREEN, -1817.0055,506.7179,-17.5041, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 75);//36
	CreateDynamic3DTextLabel("Duøa Sala Sπdowa", COLOR_GREEN, -1791.9020,513.7820,-18.9341, 8.0,INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 75);//36
	CreateDynamic3DTextLabel("Ma≥a Sala Sπdowa", COLOR_GREEN, -1779.0680,500.3323,-18.9341, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 75);//36
	CreateDynamic3DTextLabel("Adwokatura, Prokuratura\nGabinety SÍdziÛw", COLOR_GREEN, -1778.8135,528.1346,-18.9341, 8.0,INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 75);//36

	CreateDynamic3DTextLabel("Sex Shop", 0xFF00FFAA, 1087.7860,-922.7472,43.3906, 17.0);
	CreateDynamic3DTextLabel("Aby rozpoczπÊ zakupy wpisz /kupdildo", 0xFF00FFAA, -105.0829,-10.6207,1000.7188, 5.0);
	CreateDynamic3DTextLabel("Dystrybutor\nWpisz /tankuj", COLOR_BLUE ,-1130.3420,-1018.1770,129.2188, 10.0);
	CreateDynamic3DTextLabel("Glen Park Bar", COLOR_BLUE ,1970.8337,-1285.3256,28.4919, 15.0);
	CreateDynamic3DTextLabel("Mrucznikowy Gun Shop'", COLOR_BLUE ,1791.212036,-1164.631713,23.828100, 15.0);
	
	CreateDynamic3DTextLabel("{FFFFFF}{FF0000}J{FFFFFF}ack {FF0000}S{FFFFFF}imon\nNadwodny Arcymak Gubernatora", 0x008080FF, 1528.4802, -1458.5370, 67.3899, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 80);
 	CreateDynamic3DTextLabel("{FFFFFF}Biuro Dyrektora GPB", 0x008080FF, 1513.5140, -1467.9963, 69.3863, 5.0,INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 80);
    CreateDynamic3DTextLabel("{FFFFFF}Sala Konferencyjna", 0x008080FF, 1526.1975, -1460.5238, 69.3863, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 80);
	CreateDynamic3DTextLabel("{FFFFFF}Sala gimnastyczna", 0x008080FF, 1481.3822, -1535.7865, 71.3195, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 80);
    CreateDynamic3DTextLabel("{FFFFFF}Strzelnica", 0x008080FF, 1478.1902, -1535.7865, 71.3195, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 80);
    CreateDynamic3DTextLabel("{FFFFFF}Symulacja napadu", 0x008080FF, 1474.9702, -1535.7865, 71.3195, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 80);

//Pickup bayside

	CreateDynamic3DTextLabel("Ratusz", COLOR_BLUE ,-2474.1194,2232.1296,5.7156, 25.0);
	CreateDynamic3DTextLabel("Tu rozpoczniesz s≥uøbÍ\n i wrzucisz podejrzanego do wiÍzienia (BSPD)", COLOR_BLUE ,-2614.1667,2264.6279,8.2109, 15.0);
	CreateDynamic3DTextLabel("Komisariat Palomino Creek", COLOR_BLUE ,2425.6000976563,117.69999694824,26.5, 15.0);
	CreateDynamic3DTextLabel("KoúciÛ≥", COLOR_BLUE ,-2482.6416,2406.8088,17.1094, 25.0);
	CreateDynamic3DTextLabel("Wejúcie na balkon", COLOR_BLUE ,-2065.5505,575.6121,1173.0511, 1.0);

//3d text basen
	CreateDynamic3DTextLabel("Wpisz tu /trampolina\n aby wykonaÊ skok", COLOR_BLUE ,579.3132,-2193.8735,6.5254, 7.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 30);
	CreateDynamic3DTextLabel("Sauna", COLOR_BLUE ,570.5168,-2095.3618,2.6152, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 30);
    str2 =  "Wejúcie na p≥ywalniÍ i inne atrakcje na basenie jest p≥atne za pomocπ kredytÛw\n Zaopatrz siÍ w odpowiedniπ liczbÍ kredytÛw u pracownika Aqua Parku\n Cennik znajduje siÍ na tablicy przy kasach\n Dodatkowe kredyty moøesz dokupiÊ rÛwnieø na basenie\n Wchodzπc na basen akceptujesz regulamin p≥ywalni";
	CreateDynamic3DTextLabel(str2, COLOR_BLUE ,560.8828,-2033.8701,16.1670, 6.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 30);
    str2 = "{FFA500}Wejúcie na basen -{9ACD32}210 kredytÛw \n {FFA500}Wejúcie do Sauny - {9ACD32}75 kredytÛw \n {FFA500}Skorzystanie z szatni-{9ACD32}5 kredytÛw\n {FFA500}Trampolina úrednia - {9ACD32}10 kredytÛw\n {FFA500}Trampolina wyczynowa- {9ACD32}20 kredytÛw\n {FFA500}Wejúcie do pontonu basenowego- {9ACD32}35 kredytÛw\nCeny kredytÛw ustala dzierøawca\nPo opuszczeniu p≥ywalni kredyty przepadajπ";
    CreateDynamic3DTextLabel(str2,COLOR_NEWS,570.76820068,-2029.58264160,17.9,8.5,INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 30);
	CreateDynamic3DTextLabel("Wejscie tylko dla personelu \n(wpisz /wyjdz aby wejsc)", COLOR_BLUE ,562.2107,-2029.9917,16.1670, 2.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 30);
	CreateDynamic3DTextLabel("Trampoliny", COLOR_BLUE ,578.6193,-2195.7708,1.6288, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 30);
	CreateDynamic3DTextLabel("Uøyj: /kupkredyty", COLOR_BLUE ,570.63, -2031.03, 16.2, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 30);
//sklepy z ubraniami
	CreateDynamic3DTextLabel("Sub Urban", COLOR_BLUE ,2112.7527,-1212.0103,23.9637, 20.0);
	CreateDynamic3DTextLabel("ZIP", COLOR_BLUE ,1456.7676,-1138.7638,23.9991, 20.0);
	CreateDynamic3DTextLabel("Victim", COLOR_BLUE ,459.5163,-1501.4186,31.0371, 20.0);
	CreateDynamic3DTextLabel("Pro Laps", COLOR_BLUE ,500.1234,-1359.6345,16.2776, 20.0);
	CreateDynamic3DTextLabel("Binco", COLOR_BLUE ,2244.2336,-1665.2026,15.4766, 20.0);

//-------------------------------[Przystanki autobusowe]----------------------------------------

	CreateDynamic3DTextLabel("Przystanek \n  Ganton - Groove Street \n Kursuje linia: {FF8C00}72" /*\n {808080} WiÍcej na /businfo*/, COLOR_BLUE ,2592.8000488281,-1723.5999755859,16 ,20.0); //most
	CreateDynamic3DTextLabel("Przystanek \n  Ganton - Groove Street \n Kursuje linia: {FF8C00}72", COLOR_BLUE ,2474.3999023438,-1738.4000244141,16 ,20.0); //przy GS
	CreateDynamic3DTextLabel("Przystanek \n Idlewood - Silownia \n Kursuje linia: {FF8C00}72", COLOR_BLUE , 2163.0180664063,-1758.4976806641,16.147880172729, 20.0); // Idlewood - Silownia przy motelu

	CreateDynamic3DTextLabel("Przystanek \n Idlewood - Silownia \n Kursuje linia: {FF8C00}72", COLOR_BLUE ,2179.3752441406,-1711.3572998047,16, 20.0); // Idlewood - Silownia przy melinie
	CreateDynamic3DTextLabel("Przystanek \n Idlewood - Stacja benzynowa \n Kursuje linia: {FF8C00}72", COLOR_BLUE ,1890.3483886719,-1744.2761230469,16.146875, 20.0); // Idlewood - Stacja benzynowa
	CreateDynamic3DTextLabel("Przystanek \n Idlewood - Stacja benzynowa \n Kursuje linia: {FF8C00}72", COLOR_BLUE ,1925.3206787109,1760.4560546875,16.146875, 20.0); // Idlewood - Stacja benzynowa
	CreateDynamic3DTextLabel("Przystanek \n El Corona - Unity Station \n Kursuje linia: {4682B4}55  {008000}96", COLOR_BLUE ,1743.8525390625,-1810.5493164063,16.126877403259, 20.0); // El Corona - Unity Station
	CreateDynamic3DTextLabel("Przystanek \n El Corona - Unity Station \n Kursuje linia: {4682B4}55  {008000}96", COLOR_BLUE ,1790.5799560547,-1839.7934570313,16.126877403259, 20.0); // El Corona - Unity Station
	CreateDynamic3DTextLabel("Przystanek \n Pershing Square - Komisariat \n Kursuje linia: {4682B4}55  {FF8C00}72", COLOR_BLUE ,1523.8828125,-1694.9890136719,16.126877403259, 20.0); // Pershing Square - Komisariat
	CreateDynamic3DTextLabel("Przystanek \n Pershing Square - Komisariat \n Kursuje linia: {4682B4}55  {FF8C00}72  {FFFF00}82  {FFFF00}82A", COLOR_BLUE ,1535.2431640625,-1647.8034667969,16.126877403259, 20.0); // Pershing Square - Komisariat
	CreateDynamic3DTextLabel("Przystanek \n Downtown - Ammu-Nation \n Nie kursuje øadna linia", COLOR_BLUE ,1363.3416748047,-1275.2260742188,16.126877403259, 20.0); // Downtown - Ammu-Nation
	CreateDynamic3DTextLabel("Przystanek \n Downtown - Ammu-Nation \n Kursuje linia: {FF8C00}72(j)", COLOR_BLUE ,1336.8793945313,-1348.0667724609,16.126877403259, 20.0); // Downtown - Ammu-Nation
	CreateDynamic3DTextLabel("Przystanek \n Downtown - Bank \n Kursuje linia: {4682B4}55 {FF00FF}85", COLOR_BLUE ,1451.1014404297,-1041.8737792969,26.328125, 20.0); // Downtown - Bank
	CreateDynamic3DTextLabel("Przystanek \n Downtown - Bank \n Kursuje linia: {4682B4}55  {FF8C00}72(j) {FF00FF}85", COLOR_BLUE ,1451.2653808594,-1025.9205322266,26.328125, 20.0); //przy banku
	CreateDynamic3DTextLabel("Przystanek \n Downtown - Mrucznikowy Gun Shop \n Kursuje linia: {FF00FF}85", COLOR_BLUE ,1782.1417236328,-1163.5463867188,26.328125, 20.0); // Downtown - Mrucznikowy Gun Shop
	CreateDynamic3DTextLabel("Przystanek \n Downtown - Mrucznikowy Gun Shop \n Kursuje linia: {FF00FF}85", COLOR_BLUE ,1811.40234375,-1185.9276123047,26.328125, 20.0); // Downtown - Mrucznikowy Gun Shop
	CreateDynamic3DTextLabel("Przystanek \n Glen Park \n Kursuje linia: {4682B4}55 {FF00FF}85", COLOR_BLUE ,1964.6368408203,-1201.1809082031,27.985903930664, 20.0); //bus glen
	CreateDynamic3DTextLabel("Przystanek \n Ganton - Bar Ten green bottles N/Ø\n Kursuje linia: {FF8C00}72", COLOR_BLUE ,2316.6101074219,-1665.5198974609,16.951803398132, 20.0); // Ganton - Bar "Ten green bottles"
	CreateDynamic3DTextLabel("Przystanek \n Ganton - Bar Ten green bottles N/Ø\n Kursuje linia: {FF8C00}72", COLOR_BLUE ,2296.3830566406,-1653.36328125,16.92245349884, 20.0); // Ganton - Bar "Ten green bottles"
	CreateDynamic3DTextLabel("Przystanek koÒcowy \n Ocean Docks - Fabryka \n Kursuje linia: {008000}96", COLOR_BLUE ,2226.7065429688,-2204.9982910156,16.246875, 20.0); // Ocean Docks - Fabryka
	CreateDynamic3DTextLabel("Przystanek \n Playa del Seville - Osiedle mieszkaniowe \n Kursuje linia: 96", COLOR_BLUE ,2741.4299316406,-2000.4523925781,16.2546875, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Playa del Seville - Osiedle mieszkaniowe \n Kursuje linia: 96", COLOR_BLUE ,2763.8073730469,-1937.013671875,16.246875, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n East Beach - Baza Mechanikow \n Kursuje linia: {FFFF00}82  {FFFF00}82A {FF00FF}85", COLOR_BLUE ,2847.9274902344,-1563.1618652344,13.793752861023, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n East Beach - Baza Mechanikow \n Kursuje linia: {FFFF00}82  {FFFF00}82A {FF00FF}85", COLOR_BLUE ,2867.8012695313,-1539.7840576172,13.793752861023, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n East Beach - Baza Mechanikow \n Kursuje linia: {FFFF00}82  {FFFF00}82A {FF00FF}85", COLOR_BLUE ,2847.9274902344,-1563.1618652344,13.793752861023, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n East Beach - Agencja Ochrony braci Izumi \n Kursuje linia: {FFFF00}82  {FFFF00}82A {FF00FF}85", COLOR_BLUE ,2843.7377929688,-1097.9293212891,26.818738174438, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n East Beach - Agencja Ochrony braci Izumi \n Kursuje linia: {FFFF00}82  {FFFF00}82A {FF00FF}85", COLOR_BLUE ,2832.1416015625,-1101.7882080078,26.810314941406, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n East Los Santos - Pig Pen \n Kursuje linia: 96", COLOR_BLUE ,2436.2917480469,-1262.3370361328,26.70008, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n East Los Santos - Pig Pen \n Kursuje linia: 96", COLOR_BLUE ,2389.1911621094,-1250.794921875,26.702835845947, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Jefferson - Motel Jefferson \n Kursuje linia: {4682B4}55 {FF00FF}85", COLOR_BLUE ,2254.9758300781,-1151.0307617188,29.372472000122, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Jefferson - Motel Jefferson \n Kursuje linia: {4682B4}55 {FF00FF}85", COLOR_BLUE ,2248.9545898438,-1132.9829101563,29.025132369995, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Temple - 24/7 \n Kursuje linia: 55", COLOR_BLUE ,1307.6668701172,-916.51196289063,41.573985290527, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Temple - 24/7 \n Kursuje linia: 55", COLOR_BLUE ,1318.3203125,-939.79602050781,40.522116851807, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Market - Kasyno \n Kursuje linia: {4682B4}55", COLOR_BLUE ,1036.2315673828,-1155.5111083984,26.520327758789, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Market - Kasyno \n Kursuje linia: {4682B4}55", COLOR_BLUE ,1008.0661621094,-1133.0928955078,26.528125, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Market - Cluckin'Bell \n Kursuje linia: 55", COLOR_BLUE ,911.25482177734,-1380.9995117188,16.289659309387, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Market - Cluckin'Bell \n Kursuje linia: 55", COLOR_BLUE ,923.01147460938,-1340.8969726563,16.201903533936, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Rodeo - Jetty Lounge / Studio SAN \n Kursuje linia: {4682B4}55", COLOR_BLUE ,723.23773193359,-1413.8408203125,16.21894569397, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Rodeo - Jetty Lounge / Studio SAN \n Kursuje linia: {4682B4}55", COLOR_BLUE ,709.17822265625,-1387.4063720703,16.387715530396, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Rodeo - Klub wedkarski \n Kursuje linia: {4682B4}55", COLOR_BLUE ,359.1096496582,-1653.7490234375,35.704319763184, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Rodeo - Klub wedkarski \n Kursuje linia: {4682B4}55", COLOR_BLUE ,351.99530029297,-1636.6911621094,35.715753173828, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Glen Park \n Kursuje linia: {4682B4}55", COLOR_BLUE ,1978.0007324219,-1196.2591552734,28.55196304321, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Jefferson - KoúciÛ≥ \n Kursuje linia: {4682B4}55", COLOR_BLUE ,2204.6647949219,-1441.4039306641,23.984375, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Jefferson - KoúciÛ≥ \n Kursuje linia: {4682B4}55", COLOR_BLUE ,2220.5141601563,-1438.9367675781,24.0, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Idlewood - Skate Park \n Kursuje linia: {4682B4}55", COLOR_BLUE ,1839.6973876953,-1362.1072998047,13.5625, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Idlewood - Skate Park \n Kursuje linia: {4682B4}55", COLOR_BLUE ,1859.5150146484,-1392.0882568359,13.5625, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Market - Szpital Wszystkich Swietych \n Kursuje linia: {FF8C00}72 {FF00FF}85", COLOR_BLUE ,1213.7967529297,-1315.9571533203,16.557159423828, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Market - Szpital Wszystkich Swietych \n Kursuje linia: {FF8C00}72 {FF00FF}85", COLOR_BLUE ,1189.6943359375,-1355.6044921875,16.567205429077, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Miedzynarodowy Port Lotniczy Los Santos - Terminale \n Nie kursuje øadna linia.", COLOR_BLUE ,1692.3889160156,-2246.84375,13.539621353149, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Miedzynarodowy Port Lotniczy Los Santos - Terminale \n Nie kursuje øadna linia.", COLOR_BLUE ,1672.7529296875,-2261.7868652344,13.529561042786, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Miedzynarodowy Port Lotniczy Los Santos - Pas Startowy \n Kursuje linia: {008000}96", COLOR_BLUE ,1977.9957275391,-2174.1936035156,13.540592193604, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Miedzynarodowy Port Lotniczy Los Santos - Pas Startowy \n Kursuje linia: {008000}96", COLOR_BLUE ,1927.5277099609,-2158.7475585938,13.546875, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Marina - Molo \n Nie kursuje øadna linia.", COLOR_BLUE ,816.23620605469,-1792.2507324219,13.663411140442, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Marina - Molo \n Nie kursuje øadna linia.", COLOR_BLUE ,830.7861328125,-1761.5969238281,13.557691574097, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Rodeo - Granica \n Nie kursuje øadna linia.", COLOR_BLUE ,157.0863494873,-1599.9953613281,13.426840782166, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Rodeo - Granica \n Nie kursuje øadna linia.", COLOR_BLUE ,172.44171142578,-1569.1838378906,12.701812744141, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Rodeo - Wypozyczalnia Aut \n Kursuje linia: {008000}96", COLOR_BLUE ,579.77905273438,-1242.9088134766,17.654222488403, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Rodeo - Wypozyczalnia Aut \n Kursuje linia: {008000}96", COLOR_BLUE ,531.23394775391,-1240.2409667969,16.635330200195, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Marina - Burger Shot \n Kursuje linia: {008000}96", COLOR_BLUE ,846.78448486328,-1619.1676025391,13.546875, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Marina - Burger Shot \n Kursuje linia: {008000}96", COLOR_BLUE ,821.37451171875,-1622.2203369141,13.546875, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Las Collinas 34 \n Kursuje linia: {FF00FF}85", COLOR_BLUE ,2192.2785644531,-1016.5588989258,63.465999603271, 20.0); //
	CreateDynamic3DTextLabel("Przystanek \n Las Collinas 34 \n Kursuje linia: {FF00FF}85", COLOR_BLUE ,2203.9050292969,-1007.9483032227,61.827796936035, 20.0); //
	CreateDynamic3DTextLabel("Przystanek koÒcowy \n Rodeo - Mrucznik Tower \n Kursuje linia: {FF8C00}72 {4682B4}55  {008000}96", COLOR_BLUE ,335.34939575195,-1529.0958251953,33.285037994385, 20.0); // 96
	CreateDynamic3DTextLabel("Przystanek \nWillowfield-Culck'n bell\n Kursuje linia: {FF00FF}85", COLOR_BLUE ,2408.3994140625,-1906.9099121094,15.825965881348 , 20.0); // +1
	CreateDynamic3DTextLabel("Przystanek \nWillowfield- Culck'n bell\n Kursuje linia: {FF00FF}85", COLOR_BLUE ,2419.5556640625,-1910.5183105469,15.61351776123 , 20.0); // +2
	//CreateDynamic3DTextLabel("Ocean Docks - Zajezdnia Autobusowa", COLOR_BLUE ,22433.2265625,-2100.5439453125,15.542405128479 , 20.0); // +3
	CreateDynamic3DTextLabel("Ocean Docks - Zajezdnia Autobusowa", COLOR_BLUE ,32427.7380371094,-2100.1787109375,15.542405128479 , 20.0); // +4
	CreateDynamic3DTextLabel("Dillimore \n Kursuje linia: {FFFF00}82  {FFFF00}82A", COLOR_BLUE ,659.56359863281,-591.3818359375,18.719856262207 , 20.0); // +5
 	//CreateDynamic3DTextLabel("Dillimore \n Kursuje linia: 82 ", COLOR_BLUE ,666.42944335938,-592.18737792969,18.719856262207 , 20.0); // +6
	//CreateDynamic3DTextLabel("Dillimore \n Kursuje linia: 82 ", COLOR_BLUE ,1044.3587646484,-443.26565551758,53.460746765137 , 20.0); // +7
	CreateDynamic3DTextLabel("Dillimore \n Kursuje linia: {FFFF00}82  {FFFF00}82A ", COLOR_BLUE ,1017.0083007813,-468.32012939453,53.510246276855 , 20.0); // +8
	CreateDynamic3DTextLabel("Rodeo - Biurowiec FBI N/Ø\n Kursuje linia: {4682B4}55  {008000}96", COLOR_BLUE, 619.19805908203, -1467.7951660156, 16.544940948486, 50.0);
	CreateDynamic3DTextLabel("Rodeo - Biurowiec FBI N/Ø\n Kursuje linia: {4682B4}55  {008000}96", COLOR_BLUE, 645.48364257813, -1453.806640625, 16.544940948486, 50.0);
	CreateDynamic3DTextLabel("Przystanek \n Bluberry \n Kursuje linia: {FFFF00}82", COLOR_BLUE ,241.1724395752 ,-54.447734832764 ,4.2472524642944, 15.0); //
	CreateDynamic3DTextLabel("Przystanek \n Bluberry \n Kursuje linia: {FFFF00}82", COLOR_BLUE , 224.9140625 ,-170.3115234375 ,4.2472524642944, 15.0); //
	CreateDynamic3DTextLabel("Przystanek \n Willowfield - Wysypisko \n Kursuje linia: {FF00FF}85", COLOR_BLUE ,2117.7602539063 ,-1902.6304931641 ,15.796875, 15.0); //
	CreateDynamic3DTextLabel("Przystanek \n Willowfield - Wysypisko \n Kursuje linia: {FF00FF}85", COLOR_BLUE ,2116.009765625 ,-1888.6198730469 ,16.046875, 15.0); //
	CreateDynamic3DTextLabel("Przystanek \n East Los Santos - Myjnia Samochodowa \n Kursuje linia: {FF00FF}85", COLOR_BLUE ,2490.0166015625 ,-1509.8363037109 ,26.799991607666, 15.0); //
	CreateDynamic3DTextLabel("Przystanek \n East Los Santos - Myjnia Samochodowa \n Kursuje linia: {FF00FF}85", COLOR_BLUE ,2511.2307128906 ,-1498.5869140625 ,26.699989318848, 15.0); //
	//CreateDynamic3DTextLabel("Przystanek \n Ocean Docks - Baza Wojskowa \n Kursuje linia: {008000}96", COLOR_BLUE ,2657.4958496094 ,-2411.2084960938 ,16.296684265137, 15.0); //
	//CreateDynamic3DTextLabel("Przystanek \n Ocean Docks - Baza Wojskowa \n Kursuje linia: {008000}96", COLOR_BLUE ,2650.7568359375 ,-2397.2963867188 ,16.296684265137, 15.0); //
	//CreateDynamic3DTextLabel("Przystanek \n Market Station \n Kursuje linia: {4682B4}55", COLOR_BLUE ,804.85333251953 ,-1350.9718017578 ,15.691011428833, 15.0); //
    CreateDynamic3DTextLabel("Przystanek \n Ocean Docks - WiÍzienie Stanowe \n Kursuje linia: {008000}96", COLOR_BLUE ,2497.7761,-2411.4561 ,16.296684265137, 15.0);
    CreateDynamic3DTextLabel("Przystanek \n Market Station \n Kursuje linia: {FF8C00}72 {4682B4}55", COLOR_BLUE ,833.5,-1334.5,16.10000038147, 15.0); //market station przy martket station
	CreateDynamic3DTextLabel("Przystanek \n Market Station \n Kursuje linia: {FF8C00}72 {4682B4}55", COLOR_BLUE ,837.26153564453 ,-1312.2224121094 ,16.216003417969, 15.0); //sprawdzic
	CreateDynamic3DTextLabel("Przystanek \n Market- Galerie Handlowe \n Kursuje linia: {008000}96", COLOR_BLUE ,1084.4793701172 ,-1564.4562988281 ,16.239723205566, 15.0); //
	CreateDynamic3DTextLabel("Przystanek \n Market- Galerie Handlowe \n Kursuje linia: {008000}96", COLOR_BLUE ,1104.8861083984 ,-1580.5274658203 ,15.508214950562, 15.0); // sprawdzic
	CreateDynamic3DTextLabel("Przystanek \n Las Colinas 13\n Kursuje linia: {FF00FF}85", COLOR_BLUE ,2545.386962890,-1054.0794677734,72.065757751465, 15.0); //
	CreateDynamic3DTextLabel("Przystanek \n Las Colinas 13\n Kursuje linia: {FF00FF}85", COLOR_BLUE ,2516.0454101563,-1041.4760742188 ,72.065757751465, 15.0); //
	CreateDynamic3DTextLabel("Przystanek \n Palomino Creek\n Kursuje linia: {FFFF00}82  {FFFF00}82A", COLOR_BLUE ,2579.8977,33.2024,29.1535 , 15.0); //
	CreateDynamic3DTextLabel("Przystanek \n Palomino Creek\n Kursuje linia: {FFFF00}82 {FFFF00}82A", COLOR_BLUE ,2336.5998535156,38.69066619873,28.980960845947, 15.0); //
	CreateDynamic3DTextLabel("Przystanek \n Bay Side\n Kursuje linia: {FFFF00}82", COLOR_BLUE ,-2499.2897949219 ,2338.8022460938 ,7.6357254981995, 15.0); //
	CreateDynamic3DTextLabel("Przystanek \n Commerce - Dworzec Autobusowy\nBasen 'Tsunami'\n Kursuje linia: {FFFF00}82  {FFFF00}82A  {008000}96", COLOR_BLUE, 1167.5377197266,-1825.7144775391,15.588569641113, 20.0);
    CreateDynamic3DTextLabel("Przystanek \nCommerce - Dworzec Autobusowy\nBasen 'Tsunami'\n Kursuje linia: {FFFF00}82  {FFFF00}82A  {008000}96", COLOR_BLUE, 1186.3753662109,-1750.328125,16.239440917969, 20.0);
    CreateDynamic3DTextLabel("Los Santos Bus Department\n{FF8C00}Zajezdnia Autobusowa Commerce\n{808080}Przystanek dla wysiadajπcych!", COLOR_BLUE , 1140.800048828,-1732.9000244141,16.10000038147, 20.0);
    CreateDynamic3DTextLabel("{FFFF00}Korporacja Transportowa\n{FF8C00}Zajezdnia Autobusowa Ocean Docks\nBaza taksÛwkarska\nHangary dla helikopterÛw", COLOR_BLUE , 2424.0740,-2089.3833,16.0, 20.0);

	CreateDynamic3DTextLabel("Biurowiec\n'Mrucznik Tower'", COLOR_BROWN, 330.6893,-1513.0613,35.8672, 100.0);
    CreateDynamic3DTextLabel("Kancelaria Prawnicza", COLOR_LIGHTGREEN, 315.4501953125, -1501.822265625, 13.820824623108, 20.0);
    CreateDynamic3DTextLabel("Biuro £owcÛw NagrÛd", COLOR_LIGHTGREEN, 292.85711669922, -1530.8516845703, 13.818398475647, 20.0);//99
	
	CreateDynamic3DTextLabel("Kamera wiÍzienna", COLOR_LIGHTGREEN, 327.5762,-1546.8887,13.8364, 10.0);
    CreateDynamic3DTextLabel("Lista nagrÛd [/wanted]", COLOR_LIGHTGREEN, 325.0463,306.9240,999.1484, 5.0);

	//3d texty dynamicznych interiorÛ
	CreateDynamic3DTextLabel("Dom na Groove Street", COLOR_BLUE, 2495.576171875,-1689.9849853516,14.765625, 15.0);
	CreateDynamic3DTextLabel("Bar", COLOR_BLUE, 2309.2565917969,-1644.1251220703,14.82704348022, 15.0);
	CreateDynamic3DTextLabel("Melina", COLOR_BLUE, 2165.9409179688,-1671.8609619141,15.074726104736, 15.0);
	CreateDynamic3DTextLabel("Szamboa Gym", COLOR_BLUE, 2229.2248535156,-1721.9586181641,13.567801475525, 15.0);
	CreateDynamic3DTextLabel("Cluckin'Bell", COLOR_BLUE, 2397.3500976563,-1898.1529541016,13.546875, 15.0);
	//CreateDynamic3DTextLabel("Pizzeria", COLOR_BLUE, 2104.4970703125,-1806.3927001953,13.5546875, 15.0);
	CreateDynamic3DTextLabel("Sklep 24/7", COLOR_BLUE, 1833.1099853516,-1842.603515625,13.578125, 15.0);
	CreateDynamic3DTextLabel("Motel Jefferson", COLOR_BLUE, 2232.5,-1159.7940673828,25.890625, 15.0);
	CreateDynamic3DTextLabel("Dom na Las Collinas", COLOR_BLUE, 2351.8894042969,-1169.4614257813,28.001684188843, 15.0);
	CreateDynamic3DTextLabel("Pig Pen", COLOR_BLUE, 2421.0134277344,-1220.2153320313,25.500587463379, 15.0);
	CreateDynamic3DTextLabel("Cluckin'Bell", COLOR_BLUE, 22420.5959472656,-1508.7227783203,23.992208480835, 15.0);

	CreateDynamic3DTextLabel("{FF00FF}V{FFFFFF}inyl {FF00FF}C{FFFFFF}lub", COLOR_BLUE, 816.0999,-1386.8,13.6, 10.0);//VIP VINYL club central
	CreateDynamic3DTextLabel("{FF00FF}K{FFFFFF}rul {FF00FF}M{FFFFFF}echanikuw\n{008000}Bij Pok≥ony", COLOR_BLUE, 2792.6999511719,-1536.4000244141,10.5, 10.0);//pomnik krÛla
	//CreateDynamic3DTextLabel("{FF00FF}A{FFFFFF}lhambra {FF00FF}C{FFFFFF}lub {FF00FF}\n{008000}P≥atne wewnπtrz", 0xFFFFFF, 1836.1028,-1682.2826,13.3620, 10.0);//nowa Alhambra
	CreateDynamic3DTextLabel("{FFFFFF}Wejscie na Scene!",0xFFFFFF,481.0048,-1499.3975,41.3900,5,INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 1);
	CreateDynamic3DTextLabel("{FFFFFF}Wejscie za Bar!",0xFFFFFF,488.6343,-1520.8257,41.3900,5,INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 1);
	CreateDynamic3DTextLabel("{FFFFFF}Wejscie za Lade!",0xFFFFFF,495.5948,-1503.1011,41.3900,5,INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 1);
	CreateDynamic3DTextLabel("{FFFFFF}Tu Rozpoczniesz impreze \n {FF0000}Wpisz /konsola \n {FFFFFF}a ukaze ci sie lista streamow !",0xFFFFFF,488.2908,-1492.8959,43.6700,5,INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 1);
	CreateDynamic3DTextLabel("{FF00FF}E{FFFFFF}xclusive {FF00FF}C{FFFFFF}lub", COLOR_BLUE, 931.09,919.29,42.59, 15.0);
	CreateDynamic3DTextLabel("Sklep spoøywczy", COLOR_BLUE, 1315.1501464844,-898.62475585938,39.578125, 15.0);
	CreateDynamic3DTextLabel("Burger Shot", COLOR_BLUE, 1198.8435058594,-919.0625,43.114803314209, 15.0);
	CreateDynamic3DTextLabel("Sklepik przy stacji Xoomer", COLOR_BLUE, 999.41522216797,-920.31256103516,42.1796875, 15.0);
	CreateDynamic3DTextLabel("Muzeum sztuki wspÛ≥czesnej", COLOR_BLUE, 1698.8944091797,-1667.6840820313,20.194225311279, 15.0);
	CreateDynamic3DTextLabel("Muzeum sztuki wspÛ≥czesnej", COLOR_BLUE, 1727.1125488281,-1635.5847167969,20.216684341431, 15.0);
	CreateDynamic3DTextLabel("Sklep wielobranøowy", COLOR_BLUE, 1352.5844726563,-1758.1843261719,13.5078125, 15.0);
	CreateDynamic3DTextLabel("Carniceria Club", COLOR_NEWS, 2501.8083496094,-1494.3854980469,24.0, 15.0);
	CreateDynamic3DTextLabel("Burger Shot", COLOR_BLUE, 812.56213378906,-1616.4566650391,13.546875, 15.0);
	CreateDynamic3DTextLabel("Cluckin'Bell", COLOR_BLUE, 927.34912109375,-1352.9412841797,13.376730, 15.0);//127
	CreateDynamic3DTextLabel("Salon Aut", COLOR_BLUE, 2132.0371,-1149.7332,24.2372, 15.0);//128
	CreateDynamic3DTextLabel("Stocznia", COLOR_BLUE, 857.3464,-2100.0881,9.8666, 15.0);//UHA
    CreateDynamic3DTextLabel("Fabryka pojazdÛw latajπcych", COLOR_BLUE, -1262.5095,40.3263,14.1392, 15.0);//UHA
	CreateDynamic3DTextLabel("Naprawa ≥odzi", COLOR_BLUE, 698.51708984375 , -2050.6135253906 , 1.4432492256165, 15.0);//129
	CreateDynamic3DTextLabel("Wejúcie na dach", COLOR_BLUE, 2289.8876953125,-1206.8327636719,-18.008888244629, 15.0);//130
//3d texty wejscia
	CreateDynamic3DTextLabel("Stacja benzynowa", COLOR_BLUE, 660.12963867188,-573.84887695313,16.3359375, 15.0);//131
	//CreateDynamic3DTextLabel("Cowboy Bar", COLOR_BLUE, 682.03063964844,-473.62811279297,16.425407409668, 15.0);//132
	CreateDynamic3DTextLabel("Rada lokalna Dillimore", COLOR_BLUE, 695.07702636719,-499.34088134766,16.3359375, 15.0);//133
	CreateDynamic3DTextLabel("Solarin Indrusties", COLOR_BLUE, 854.50817871094,-603.81109619141,18.421875, 15.0);//134
	CreateDynamic3DTextLabel("Ammu-nation", COLOR_BLUE, 712.97113037109,-499.08493041992,16.3359375, 15.0);//135
	CreateDynamic3DTextLabel("Tor rowerowy masakra", COLOR_BLUE, 701.93713378906,-520.00042724609,16.336055755615, 15.0);//136
	CreateDynamic3DTextLabel("24/7", COLOR_BLUE, 691.23492431641,-546.91967773438,16.3359375, 15.0);//137
	CreateDynamic3DTextLabel("Przejúcie do cel\n Uøyj: /wejdz", COLOR_GRAD1, -1674.5769,903.1641,-48.9141, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 1);//138

	CreateDynamic3DTextLabel("Wyjúcie", COLOR_PANICRED,  -1674.4122,917.7183,-52.4141, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 1);//nowe komi
	CreateDynamic3DTextLabel("Zbrojownia LSPD \n Komendy: /kamizelka /swat /szturmowy", COLOR_LIGHTBLUE,  -1674.8365,866.0356,-52.4141, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 1);
	CreateDynamic3DTextLabel("{6699FF}Bonehead Club",0x80FF0084,2447.8284,-1963.1549,13.5469,15);

	NapislotLS1 = CreateDynamic3DTextLabel("Kasa 1\nCena biletu:\nBrak", COLOR_BLUE, 1593.3000488281,-2285.6000976563,-75, 25.0);
	NapislotLS2 = CreateDynamic3DTextLabel("Kasa 2\nCena biletu:\nBrak", COLOR_BLUE, 1593.3000488281,-2280, -75, 25.0);
	NapislotLV1 = CreateDynamic3DTextLabel("Kasa 1\nCena biletu:\nBrak", COLOR_BLUE, 1674.8, 1442.3, 14.8, 25.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 1);
	NapislotSF1 = CreateDynamic3DTextLabel("Kasa 1\nCena biletu:\nBrak", COLOR_BLUE, -1391.9,-299.8,-74.7, 25.0);
	CreateDynamic3DTextLabel("Lotnisko w Los Santos", COLOR_BLUE, 1585.2,-2286.6,13.7, 25.0);
	CreateDynamic3DTextLabel("Lotnisko w Los Santos", COLOR_BLUE, 1585.2,-2286.6,13.7, 25.0);
	CreateDynamic3DTextLabel("Lotnisko w Los Santos", COLOR_BLUE, 1886.1,-2286.4,14, 25.0);
	CreateDynamic3DTextLabel("Pas startowy w Los Santos", COLOR_BLUE, 1605,-2282.9,-74.90, 25.0);
	CreateDynamic3DTextLabel("Pas startowy", COLOR_BLUE, 1675.8, 1455.4, 14.9, 25.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 1);
	CreateDynamic3DTextLabel("Lotnisko w Las Venturas", COLOR_BLUE, 1673.3, 1447.8, 10.9, 25.0);
	CreateDynamic3DTextLabel("Lotnisko w Las Venturas", COLOR_BLUE, 1597.7, 1448.3, 10.9, 25.0);
	CreateDynamic3DTextLabel("Lotnisko w San Fierro", COLOR_BLUE, -1421.4,-287.3,14.1, 25.0);
	CreateDynamic3DTextLabel("Lotnisko w San Fierro", COLOR_BLUE, -1376.3,-261.1,14.3, 25.0);
	CreateDynamic3DTextLabel("Pas startowy", COLOR_BLUE, -1390,-294.6,-74.6, 25.0);
	
	//pc by abram01
	CreateDynamic3DTextLabel("{FFFFFF}Biuro burmistrza\n {FF0000}P{FFFFFF}alomino {FF0000}C{FFFFFF}reek", 0x008080FF, 2312.9653, -72.1337, 40.8925, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 1);
    CreateDynamic3DTextLabel("{FFFFFF}Sala konferencyjna miasta\n {FF0000}P{FFFFFF}alomino {FF0000}C{FFFFFF}reek", 0x008080FF, 2310.3062, -75.0557, 40.8925, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 1);
    CreateDynamic3DTextLabel("{FFFFFF}Okienka 1-2", 0x008080FF, 2313.0664, -77.9755, 40.8925, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 1);
    CreateDynamic3DTextLabel("{FFFFFF}Okienka 3-4", 0x008080FF, 2324.6873, -77.9382, 40.8925, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 1);
    CreateDynamic3DTextLabel("{FFFFFF}Przejúcie dla klientÛw", 0x008080FF, 2318.8750, -77.9110, 40.8925, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 1);
    CreateDynamic3DTextLabel("{FFFFFF}Plac Manewrowy\n Wejúcie tylko z instruktorem", 0x008080FF, 2327.4940, -75.0322, 41.0837, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 1);
    str2 = "{FFA500}DowÛd osobisty - {9ACD32}5000$ +akt urodz.\n{FFA500}Wydanie Prawa Jazdy - {9ACD32}12 500$ +zal. egz.\n {FFA500}Patent Øeglarski - {9ACD32}100 000$\n {FFA500}Pozwolenie na Bron - {9ACD32}37 500$\n {FFA500}Licencja Pilota - {9ACD32}5 400 000$\n {FFA500}Karty wÍdkarskie - {9ACD32}4000$\n{9ACD32}Egzamin teoretyczny - 5 000${FFA500}\n{9ACD32}Egzamin praktyczny- {9ACD32} 10 000$";
    CreateDynamic3DTextLabel(str2, 0x008080FF, 2321.0730, -78.1003, 40.5000, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 1);
    CreateDynamic3DTextLabel("{FFFFFF}Przebierlania UrzÍdnikÛw", 0x008080FF, 2318.8938, -72.1589, 41.0185, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 1);
    CreateDynamic3DTextLabel("{FFFFFF}Urzπd Miasta \n {FF0000}P{FFFFFF}alomino {FF0000}C{FFFFFF}reek", 0x008080FF,2269.6770, -73.9858, 26.2765, 10.0);
	
	CreateDynamic3DTextLabel("Verona Mall #1", 0xFFFFFFFF, 1155.1920,-1440.2554,18.8004, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	CreateDynamic3DTextLabel("Verona Mall #2", 0xFFFFFFFF, 1155.0938,-1458.1758,18.8004, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	CreateDynamic3DTextLabel("Verona Mall #3", 0xFFFFFFFF, 1159.0585,-1473.5192,18.8004, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	CreateDynamic3DTextLabel("Verona Mall #4", 0xFFFFFFFF, 1157.8987,-1506.9456,18.8004, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	CreateDynamic3DTextLabel("Verona Mall #5", 0xFFFFFFFF, 1144.2046,-1521.6428,18.8004, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	CreateDynamic3DTextLabel("Verona Mall #6", 0xFFFFFFFF, 1112.1560,-1521.3732,18.8004, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	CreateDynamic3DTextLabel("Verona Mall #7", 0xFFFFFFFF, 1099.3752,-1507.0377,18.8004, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	CreateDynamic3DTextLabel("Verona Mall #8", 0xFFFFFFFF, 1098.5304,-1473.3096,18.8004, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	CreateDynamic3DTextLabel("Verona Mall #9", 0xFFFFFFFF, 1101.7878,-1457.6602,18.8004, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	CreateDynamic3DTextLabel("Verona Mall #10", 0xFFFFFFFF, 1101.9540,-1440.1140,18.8004, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	CreateDynamic3DTextLabel("Verona Mall #11", 0xFFFFFFFF, 1162.3512,-1435.7961,25.7909, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	CreateDynamic3DTextLabel("Verona Mall #12", 0xFFFFFFFF, 1159.0237,-1522.0995,25.7456, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	CreateDynamic3DTextLabel("Verona Mall #13", 0xFFFFFFFF, 1096.8696,-1522.0790,25.7450, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	CreateDynamic3DTextLabel("Verona Mall #14", 0xFFFFFFFF, 1094.1958,-1451.0001,25.7605, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);

    CreateDynamic3DTextLabel("{333399}Tymczasowe wiÍzienie stanowe FBI\n{FFFFFF}[/stanowe]", COLOR_BLUE, NG_JAIL_X,NG_JAIL_Y,NG_JAIL_Z, 5.0);
    //SN
    CreateDynamic3DTextLabel("Dach San News", 0xFFA500FF, 721.5504,-1381.8588,25.7176, 15.0);
    CreateDynamic3DTextLabel("Zaplecze San News", 0xFFA500FF, 732.5052,-1343.5123,13.5206, 15.0);

    CreateDynamic3DTextLabel("Siedziba Sπdu Najwyøszego", COLOR_BLUE, 1310.1124,-1367.6780,13.5391, 35.0);
    CreateDynamic3DTextLabel("Wejúcie ewakuacyjne", COLOR_LIGHTBLUE, 1286.0413,-1329.2007,13.5515, 9.0);
    CreateDynamic3DTextLabel("Wyjúcie ewakuacyjne", COLOR_LIGHTBLUE, 1305.0424,-1291.6113,35.6751, 9.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 501);
    CreateDynamic3DTextLabel("Sala rozpraw", COLOR_LIGHTBLUE, 1297.2946,-1300.0739,37.9, 7.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 501);

    CreateDynamic3DTextLabel("Pub\nel'pueblo", 0xE97900FF, 2151.60083, -1013.74762, 62.23438, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
    CreateDynamic3DTextLabel("Firma kurierska\n{FFFFFF}Praca dorywcza (/{929292}dolacz{FFFFFF})", 0x99311EFF, 1751.4445, -2054.9761, 14.5, 25.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);

    //FD
    CreateDynamic3DTextLabel("Lista zas≥uøonych:\n+ Shoji Ertubo +\n+ Brayan Johnson +\n+ Jack Stanley +\n+ Raul Alvarez +\n+ Patrick Robinson +", COLOR_YELLOW, 1742.34100, -1126.92000, 229.35000, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 22, -1, -1, 10.0);
	CreateDynamic3DTextLabel("Waøne informacje:\n\nRachunki za poprzedni miesiπc do odebrania w biurze.\n\nPodsumowanie tygodnia ma miejsce w kaødy piπtek o godzinie 21:00.\n\nProsimy pamiÍtaÊ o zamykaniu swoich szafek na klucz.\n\n", COLOR_YELLOW, 1753.40393, -1121.24000, 229.00000, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 22, -1, -1, 10.0);

    return 1;
}

ZaladujSamochody()
{
    new id;
    new randa = random(sizeof(RandCars));
	randa = random(sizeof(RandCars));carselect[0] = RandCars[randa][0];
	randa = random(sizeof(RandCars));carselect[1] = RandCars[randa][0];
	randa = random(sizeof(RandCars));carselect[2] = RandCars[randa][0];
	randa = random(sizeof(RandCars));carselect[3] = RandCars[randa][0];
	randa = random(sizeof(RandCars));carselect[4] = RandCars[randa][0];
	randa = random(sizeof(RandCars));carselect[5] = RandCars[randa][0];
	randa = random(sizeof(RandCars));carselect[6] = RandCars[randa][0];
	randa = random(sizeof(RandCars));carselect[7] = RandCars[randa][0];
	randa = random(sizeof(RandCars));carselect[8] = RandCars[randa][0];
	randa = random(sizeof(RandCars));carselect[9] = RandCars[randa][0];
	randa = random(sizeof(RandCars));carselect[10] = RandCars[randa][0];
	randa = random(sizeof(RandCars));carselect[11] = RandCars[randa][0];
	randa = random(sizeof(RandCars));carselect[12] = RandCars[randa][0];
	randa = random(sizeof(RandCars));carselect[13] = RandCars[randa][0];

    for(new i = 0; i < 165; i++)
	{
        id = AddCar(i);
    }
    CAR_End = id;
    printf("Wczytano %d aut do kradzieøy", CAR_End);
	return 1;
}
