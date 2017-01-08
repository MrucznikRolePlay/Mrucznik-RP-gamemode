//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>AUTOR: KilsOn (Louis Cardenas)
//|--------------------------------------------------------------------------------------------------------------------------------------------|
//|            Obiekty zostały stworzone na potrzeby serwera Mrucznik Role Play. Zabrania się rozpowszechniania ich bez zgody autora.
//|--------------------------------------------------------------------------------------------------------------------------------------------|
//----------------------------------------------<< Source >>-------------------------------------------------//
//-----------------------------------------[ Modu³: nowe_obiekty.pwn ]--------------------------------------------//
//Opis:
/*
	>>>>>Drobne UWAGI:
	Potrzeba zaglądnąć do skryptu LSPD i zmienić im respa na ten co podałem poniżej, oraz zmiana /duty. Dodatkowo trzeba...
	...oskryptować te windy, wystarczy wziąść gotowce z kodu intku DMV, trzeba również usunąć całe OP przed komi i na...
	...parkingu, zostawić tylko obiekty które znajdują się na dachu budynku (winda, miejsce na ladowanie heli, flagi).
>>>koordynacje na /duty i SPAWN
kordy RESPAWN: 1600.1997,-1636.1149,13.3968
//
kordy /duty: 1572.1919,-1631.5922,13.3991
*/
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
//-----------------<[ G³ówne funkcje: ]>-------------------
nowyExtPd_StworzObiekty()
{
	//exampleObjects_StworzObiekty(); 
	
	CreateDynamic3DTextLabel("{0080FF}WINDA", 0xFFFFFFFF, 1576.48, -1649.20, 8.00, 15);//winda do oskryptowania (skopiowanie gotowego skryptu)
	CreateDynamic3DTextLabel("{0080FF}WINDA", 0xFFFFFFFF, 1560.1811, -1637.0171, 13.5678, 15);//winda do oskryptowania (skopiowanie gotowego skryptu)
	SetDynamicObjectMaterial(CreateDynamicObject(19381, 1583.90247, -1662.81982, 6.81460,   0.00000, 90.00000, 0.00000), 0, 8390, "vegasemulticar", "ws_carpark3", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19381, 1583.90247, -1653.18640, 6.81460,   0.00000, 90.00000, 0.00000), 0, 8390, "vegasemulticar", "ws_carpark3", 0xFFFFFFFF);
	//podstawa
	SetObjectMaterial(CreateObject(19545, 1570.76135, -1714.80066, 12.54870,   0.00000, 0.00000, 90.00000), 0, 10023, "bigwhitesfe", "ws_carpark2", 0xFFFFFFFF);
	CreateObject(19545, 1570.95691, -1627.67407, 12.34130,   0.00000, 0.00000, 90.00000);
	CreateObject(19545, 1571.35559, -1610.28540, 12.34130,   0.00000, 0.00000, 90.00000);
	    //przedkomi
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1555.24170, -1654.79492, 12.46550,   0.00000, 90.00000, 0.00000), 0, 6340, "rodeo05_law2", "badmarb1_LAn", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1555.23962, -1664.42627, 12.46550,   0.00000, 90.00000, 0.00000), 0, 6340, "rodeo05_law2", "badmarb1_LAn", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1544.74500, -1654.79492, 12.46550,   0.00000, 90.00000, 0.00000), 0, 6340, "rodeo05_law2", "badmarb1_LAn", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1555.23962, -1674.05823, 12.46550,   0.00000, 90.00000, 0.00000), 0, 6340, "rodeo05_law2", "badmarb1_LAn", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1544.74500, -1664.42627, 12.46550,   0.00000, 90.00000, 0.00000), 0, 6340, "rodeo05_law2", "badmarb1_LAn", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1544.74500, -1702.95300, 12.46550,   0.00000, 90.00000, 0.00000), 0, 6340, "rodeo05_law2", "badmarb1_LAn", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1544.74500, -1674.05823, 12.46550,   0.00000, 90.00000, 0.00000), 0, 6340, "rodeo05_law2", "badmarb1_LAn", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1555.23962, -1683.69031, 12.46550,   0.00000, 90.00000, 0.00000), 0, 6340, "rodeo05_law2", "badmarb1_LAn", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1544.74500, -1683.69031, 12.46550,   0.00000, 90.00000, 0.00000), 0, 6340, "rodeo05_law2", "badmarb1_LAn", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1555.23962, -1693.32373, 12.46550,   0.00000, 90.00000, 0.00000), 0, 6340, "rodeo05_law2", "badmarb1_LAn", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1544.74500, -1693.32373, 12.46550,   0.00000, 90.00000, 0.00000), 0, 6340, "rodeo05_law2", "badmarb1_LAn", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1555.23962, -1702.95300, 12.46550,   0.00000, 90.00000, 0.00000), 0, 6340, "rodeo05_law2", "badmarb1_LAn", 0xFFFFFFFF);
		//obokkomi
	SetDynamicObjectMaterial(CreateDynamicObject(19379, 1598.66357, -1717.49121, 12.46150,   0.00000, 90.00000, 0.00000), 0, 13691, "bevcunto2_lahills", "ws_floortiles2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19379, 1544.77014, -1717.49121, 12.46550,   0.00000, 90.00000, 0.00000), 0, 13691, "bevcunto2_lahills", "ws_floortiles2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19379, 1555.27075, -1717.49121, 12.46550,   0.00000, 90.00000, 0.00000), 0, 13691, "bevcunto2_lahills", "ws_floortiles2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19379, 1565.77234, -1717.49121, 12.46550,   0.00000, 90.00000, 0.00000), 0, 13691, "bevcunto2_lahills", "ws_floortiles2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19379, 1576.27185, -1717.49121, 12.46550,   0.00000, 90.00000, 0.00000), 0, 13691, "bevcunto2_lahills", "ws_floortiles2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19379, 1586.77344, -1717.49121, 12.46550,   0.00000, 90.00000, 0.00000), 0, 13691, "bevcunto2_lahills", "ws_floortiles2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19379, 1597.27197, -1717.49121, 12.46550,   0.00000, 90.00000, 0.00000), 0, 13691, "bevcunto2_lahills", "ws_floortiles2", 0xFFFFFFFF);
	//napis
	SetDynamicObjectMaterialText(CreateDynamicObject(19325, 1539.55115, -1615.38074, 15.34600,   0.00000, 0.00000, 0.00000), 0, "Police \n Department", 100, "Arial Black", 45, 1, 0xFF014DFE, 0, 1);
	//poprawki
	SetDynamicObjectMaterial(CreateDynamicObject(19439, 1582.19409, -1639.99841, 17.12230,   0.00000, 0.00000, 90.00000), 0, 18202, "w_towncs_t", "plaintarmac1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19439, 1584.51453, -1639.16736, 17.1203,   0.00000, 0.00000, 0.00000), 0, 18202, "w_towncs_t", "plaintarmac1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19439, 1583.79932, -1639.99841, 17.12230,   0.00000, 0.00000, 90.00000), 0, 18202, "w_towncs_t", "plaintarmac1", 0xFFFFFFFF);
    SetDynamicObjectMaterial(CreateDynamicObject(19439, 1582.7924, -1639.1687, 15.4646,   0.00000, 90.00000, 0.00000), 0, 18202, "w_towncs_t", "plaintarmac1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19427, 1582.80859, -1639.21375, 12.31250,   0.00000, 90.00000, 0.00000), 0, 8954, "vgsespras", "ws_carpark2", 0xFFFFFFFF);
	//parkinggora
	SetDynamicObjectMaterial(CreateDynamicObject(8661, 1557.23071, -1608.27197, 12.37480,   0.00000, 0.00000, -0.22890), 0, 8954, "vgsespras", "ws_carpark2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(8661, 1585.29346, -1628.10620, 12.39680,   0.00000, 0.00000, 0.00000), 0, 8954, "vgsespras", "ws_carpark2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(8661, 1557.23071, -1628.26416, 12.37480,   0.00000, 0.00000, 359.72681), 0, 8954, "vgsespras", "ws_carpark2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(8661, 1585.70447, -1608.27197, 12.3768,   0.00000, 0.00000, -0.03270), 0, 8954, "vgsespras", "ws_carpark2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(18766, 1544.5573, -1616.3284, 10.9403,   0.00000, 0.00000, 0.00000), 0, 3985, "pershingsq", "tanstucco1_LA", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(18766, 1544.5573, -1620.7356, 10.9403,   0.00000, 0.00000, 0.00000), 0, 3985, "pershingsq", "tanstucco1_LA", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(18766, 1554.5529, -1620.7356, 10.9423,   0.00000, 0.00000, 0.00000), 0, 3985, "pershingsq", "tanstucco1_LA", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(18766, 1554.5529, -1616.3284, 10.9423,   0.00000, 0.00000, 0.00000), 0, 3985, "pershingsq", "tanstucco1_LA", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(18766, 1564.5520, -1616.3284, 10.9423,   0.00000, 0.00000, 0.00000), 0, 3985, "pershingsq", "tanstucco1_LA", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(18766, 1564.5520, -1620.7356, 10.9423,   0.00000, 0.00000, 0.00000), 0, 3985, "pershingsq", "tanstucco1_LA", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(18766, 1574.5511, -1616.3284, 10.9423,   0.00000, 0.00000, 0.00000), 0, 3985, "pershingsq", "tanstucco1_LA", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(18766, 1574.5511, -1620.7356, 10.9423,   0.00000, 0.00000, 0.00000), 0, 3985, "pershingsq", "tanstucco1_LA", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(18764, 1577.05054, -1618.54358, 10.93830,   0.00000, 0.00000, 0.00000), 0, 3985, "pershingsq", "tanstucco1_LA", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19462, 1573.41370, -1618.59290, 13.03300,   0.00000, 90.00000, 90.00000), 0, 9495, "vict_sfw", "Grass_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19462, 1544.51355, -1618.59290, 13.03300,   0.00000, 90.00000, 90.00000), 0, 9495, "vict_sfw", "Grass_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19462, 1554.14624, -1618.59290, 13.03300,   0.00000, 90.00000, 90.00000), 0, 9495, "vict_sfw", "Grass_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19462, 1563.77905, -1618.59290, 13.03300,   0.00000, 90.00000, 90.00000), 0, 9495, "vict_sfw", "Grass_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(869, 1541.71387, -1618.52966, 13.61680,   0.00000, 0.00000, 0.00000), 0, 4830, "airport2", "bevflower2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(869, 1572.55884, -1618.53394, 13.61679,   0.00000, 0.00000, 0.00000), 0, 4830, "airport2", "bevflower2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(869, 1567.85645, -1618.52966, 13.61680,   0.00000, 0.00000, 0.00000), 0, 4830, "airport2", "bevflower2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(869, 1563.11511, -1618.52966, 13.61680,   0.00000, 0.00000, 0.00000), 0, 4830, "airport2", "bevflower2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(869, 1556.27087, -1618.52966, 13.61680,   0.00000, 0.00000, 0.00000), 0, 4830, "airport2", "bevflower2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(869, 1552.58142, -1618.52966, 13.61680,   0.00000, 0.00000, 0.00000), 0, 4830, "airport2", "bevflower2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(869, 1548.84656, -1618.52966, 13.61680,   0.00000, 0.00000, 0.00000), 0, 4830, "airport2", "bevflower2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(869, 1545.46338, -1618.52966, 13.61680,   0.00000, 0.00000, 0.00000), 0, 4830, "airport2", "bevflower2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(869, 1559.74890, -1618.52966, 13.61680,   0.00000, 0.00000, 0.00000), 0, 4830, "airport2", "bevflower2", 0xFFFFFFFF);
	CreateDynamicObject(634, 1568.61780, -1618.49060, 12.96630,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(634, 1543.55359, -1618.49060, 12.96630,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(634, 1556.17554, -1618.49060, 12.96630,   0.00000, 0.00000, 0.00000);
	//lampy
	CreateDynamicObject(1226, 1543.42236, -1615.15173, 15.74300,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(1226, 1572.54785, -1615.15173, 15.74300,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(1226, 1565.36768, -1615.15173, 15.74300,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(1226, 1558.18445, -1615.15173, 15.74300,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(1226, 1550.36731, -1615.15173, 15.74300,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(1226, 1578.7888, -1615.2045, 15.7430,   0.00000, 0.00000, -90.00000);
	//strzalki
    CreateDynamicObject(8843, 1561.62439, -1628.67932, 12.37990,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(8843, 1555.11633, -1623.43225, 12.39990,   0.00000, 0.00000, 90.00000);
		//sciankigora
	//SetDynamicObjectMaterial(CreateDynamicObject(19454, 1539.6462, -1636.1387, 13.9719,   90.00000, 0.00000, 0.00000), 0, 12931, "sw_brewery", "parking2plain", 0xFFFFFFFF);
	//SetDynamicObjectMaterial(CreateDynamicObject(19454, 1541.4843, -1637.8000, 13.9719,   90.00000, 0.00000, 90.00000), 0, 12931, "sw_brewery", "parking2plain", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19454, 1539.6462, -1636.1387, 13.9719, 90.0000, 0.0000, 0.0000), 0, 12931, "sw_brewery", "parking2plain", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19454, 1541.4843, -1637.8000, 13.9719, 90.0000, 0.0000, 90.0000), 0, 12931, "sw_brewery", "parking2plain", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19376, 1603.69922, -1636.03027, 13.54350,   0.00000, 0.00000, 0.00000), 0, 12931, "sw_brewery", "parking2plain", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19376, 1539.64355, -1618.05762, 13.53950,   0.00000, 0.00000, 0.00000), 0, 12931, "sw_brewery", "parking2plain", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19376, 1603.70325, -1616.76355, 13.54350,   0.00000, 0.00000, 0.00000), 0, 12931, "sw_brewery", "parking2plain", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19376, 1603.70325, -1626.39709, 13.54350,   0.00000, 0.00000, 0.00000), 0, 12931, "sw_brewery", "parking2plain", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19376, 1603.70325, -1607.13049, 13.54350,   0.00000, 0.00000, 0.00000), 0, 12931, "sw_brewery", "parking2plain", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19376, 1598.79651, -1602.40564, 13.54350,   0.00000, 0.00000, 90.00000), 0, 12931, "sw_brewery", "parking2plain", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19376, 1589.16345, -1602.40564, 13.54350,   0.00000, 0.00000, 90.00000), 0, 12931, "sw_brewery", "parking2plain", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19376, 1579.53003, -1602.40564, 13.54350,   0.00000, 0.00000, 90.00000), 0, 12931, "sw_brewery", "parking2plain", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19376, 1569.89685, -1602.40356, 13.54350,   0.00000, 0.00000, 90.00000), 0, 12931, "sw_brewery", "parking2plain", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19376, 1560.26367, -1602.40564, 13.54350,   0.00000, 0.00000, 90.00000), 0, 12931, "sw_brewery", "parking2plain", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19376, 1550.63147, -1602.40564, 13.54350,   0.00000, 0.00000, 90.00000), 0, 12931, "sw_brewery", "parking2plain", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19376, 1544.37427, -1602.40955, 13.53950,   0.00000, 0.00000, 90.00000), 0, 12931, "sw_brewery", "parking2plain", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19376, 1539.64148, -1607.31396, 13.54350,   0.00000, 0.00000, 0.00000), 0, 12931, "sw_brewery", "parking2plain", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19376, 1539.64148, -1616.94958, 13.54350,   0.00000, 0.00000, 0.00000), 0, 12931, "sw_brewery", "parking2plain", 0xFFFFFFFF);
	//parkingdol<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	//SetDynamicObjectMaterial(CreateDynamicObject(19531, 1549.61487, -1659.22034, 6.90296,   0.00000, 0.00000, 0.00000), 0, 8954, "vgsespras", "ws_carpark2", 0xFFFFFFFF);
	new obiekt = CreateObject(19531, 1549.61487, -1659.22034, 6.90296,   0.00000, 0.00000, 0.00000);
	SetObjectMaterial(obiekt, 0, 8954, "vgsespras", "ws_carpark2", 0xFFFFFFFF);
	//sufit
	SetDynamicObjectMaterial(CreateDynamicObject(18981, 1569.81763, -1657.68323, 12.49710,   0.00000, 90.00000, 0.00000), 0, 3925, "weemap", "concretenewb256", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(18981, 1589.75598, -1681.99988, 12.49110,   0.00000, 90.00000, 0.00000), 0, 3925, "weemap", "concretenewb256", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(18981, 1589.75403, -1700.46350, 12.49310,   0.00000, 90.00000, 0.00000), 0, 3925, "weemap", "concretenewb256", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(18981, 1569.75269, -1698.68164, 12.49510,   0.00000, 90.00000, 0.00000), 0, 3925, "weemap", "concretenewb256", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(18981, 1569.64539, -1673.90405, 12.49310,   0.00000, 90.00000, 0.00000), 0, 3925, "weemap", "concretenewb256", 0xFFFFFFFF);
	//filary
	SetDynamicObjectMaterial(CreateDynamicObject(2774, 1585.49390, -1684.76953, 3.88730,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(2774, 1585.49390, -1694.26917, 3.88731,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	//przejazdnadol
	new przejazd = CreateDynamicObject(18774, 1587.50134, -1639.08838, 14.89720,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(przejazd, 2, 8954, "vgsespras", "ws_carpark2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(przejazd, 0, 18202, "w_towncs_t", "plaintarmac1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(przejazd, 1, 3925, "weemap", "concretenewb256", 0xFFFFFFFF);
		//gora
	//podstawa dol
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1587.51331, -1645.08398, 11.22700,   13.00000, 90.00000, 0.00000), 0, 8954, "vgsespras", "ws_carpark2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1587.51331, -1654.49316, 9.31150,   10.00000, 90.00000, 0.00000), 0, 8954, "vgsespras", "ws_carpark2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1587.51526, -1663.80554, 7.66890,   10.00000, 90.00000, 0.00000), 0, 8954, "vgsespras", "ws_carpark2", 0xFFFFFFFF);
		//gora
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1587.51526, -1664.77356, 12.91520,   10.00000, 90.00000, 0.00000), 0, 3925, "weemap", "concretenewb256", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1587.45068, -1646.29541, 16.42540,   13.00000, 90.00000, 0.00000), 0, 3925, "weemap", "concretenewb256", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1587.51331, -1655.28516, 14.58890,   10.00000, 90.00000, 0.00000), 0, 3925, "weemap", "concretenewb256", 0xFFFFFFFF);
	//znaki drogowe
	CreateDynamicObject(19968, 1537.45532, -1681.23987, 11.70960,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19978, 1537.45532, -1681.23987, 12.30960,   0.00000, 0.00000, -90.00000);
		//przejazdscianki
	SetDynamicObjectMaterial(CreateDynamicObject(19460, 1592.68433, -1664.32336, 9.43970,   10.00000, 0.00000, 0.00000), 0, 18202, "w_towncs_t", "plaintarmac1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19460, 1592.68604, -1667.46387, 8.63250,   0.00000, 0.00000, 0.00000), 0, 18202, "w_towncs_t", "plaintarmac1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19460, 1582.34607, -1667.46387, 12.13020,   0.00000, 0.00000, 0.00000), 0, 18202, "w_towncs_t", "plaintarmac1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19460, 1582.34607, -1667.46387, 8.63250,   0.00000, 0.00000, 0.00000), 0, 18202, "w_towncs_t", "plaintarmac1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19460, 1592.68225, -1646.25745, 15.88490,   13.00000, 0.00000, 0.00000), 0, 18202, "w_towncs_t", "plaintarmac1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19460, 1582.34814, -1646.15344, 15.88490,   13.00000, 0.00000, 0.00000), 0, 18202, "w_towncs_t", "plaintarmac1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19460, 1592.67834, -1645.49353, 13.01750,   13.00000, 0.00000, 0.00000), 0, 18202, "w_towncs_t", "plaintarmac1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19460, 1582.35205, -1655.45007, 14.47200,   10.00000, 0.00000, 0.00000), 0, 18202, "w_towncs_t", "plaintarmac1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19460, 1582.35217, -1645.49353, 13.01750,   13.00000, 0.00000, 0.00000), 0, 18202, "w_towncs_t", "plaintarmac1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19460, 1592.68030, -1654.83606, 11.10870,   10.00000, 0.00000, 0.00000), 0, 18202, "w_towncs_t", "plaintarmac1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19460, 1582.34814, -1664.92932, 12.87640,   10.00000, 0.00000, 0.00000), 0, 18202, "w_towncs_t", "plaintarmac1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19460, 1592.68433, -1655.45007, 14.47200,   10.00000, 0.00000, 0.00000), 0, 18202, "w_towncs_t", "plaintarmac1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19460, 1582.35022, -1654.83606, 11.10870,   10.00000, 0.00000, 0.00000), 0, 18202, "w_towncs_t", "plaintarmac1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19460, 1582.34814, -1664.32336, 9.43970,   10.00000, 0.00000, 0.00000), 0, 18202, "w_towncs_t", "plaintarmac1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19460, 1592.68799, -1667.46387, 12.13020,   0.00000, 0.00000, 0.00000), 0, 18202, "w_towncs_t", "plaintarmac1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19460, 1592.68628, -1664.92932, 12.87640,   10.00000, 0.00000, 0.00000), 0, 18202, "w_towncs_t", "plaintarmac1", 0xFFFFFFFF);
	//sciankidolparking
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1567.02405, -1667.53687, 8.63250,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1597.44250, -1672.19128, 12.13020,   0.00000, 0.00000, 90.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1597.44250, -1672.19128, 8.63250,   0.00000, 0.00000, 90.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1602.17505, -1677.08215, 8.63250,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1602.17505, -1686.71594, 8.63250,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1602.17505, -1696.34998, 8.63250,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1602.17505, -1705.98401, 8.63250,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1597.57605, -1710.82104, 8.63250,   0.00000, 0.00000, 90.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1587.94250, -1710.82104, 8.63250,   0.00000, 0.00000, 90.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1578.30811, -1710.82104, 8.63250,   0.00000, 0.00000, 90.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1568.67419, -1710.82104, 8.63250,   0.00000, 0.00000, 90.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1567.02405, -1705.98450, 8.63250,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1567.02405, -1696.34985, 8.63250,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1567.02405, -1686.71545, 8.63250,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1567.02405, -1677.17065, 8.63250,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1602.17505, -1677.08215, 12.13020,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1602.17505, -1686.71594, 12.13020,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1602.17505, -1696.34998, 12.13020,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1602.17505, -1705.98401, 12.13020,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1597.57605, -1710.82104, 12.13020,   0.00000, 0.00000, 90.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1587.94250, -1710.82104, 12.13020,   0.00000, 0.00000, 90.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1578.30811, -1710.82104, 12.13020,   0.00000, 0.00000, 90.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1568.67419, -1710.82104, 12.13020,   0.00000, 0.00000, 90.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1567.02405, -1705.98450, 12.13020,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1567.02405, -1696.34985, 12.13020,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1567.02405, -1686.71545, 12.13020,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1567.02405, -1677.17065, 12.13020,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1567.02405, -1667.53687, 12.13020,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1577.49036, -1648.44971, 8.63250,   0.00000, 0.00000, 90.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1567.02405, -1657.90210, 12.13020,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1567.02405, -1657.90210, 8.63250,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1567.02405, -1648.26758, 12.13020,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1571.88354, -1648.45569, 12.13020,   0.00000, 0.00000, 90.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1571.88354, -1648.45569, 8.63250,   0.00000, 0.00000, 90.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1567.02405, -1648.26758, 8.63250,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1582.29810, -1648.20654, 8.63250,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1582.29810, -1667.46790, 12.13020,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1582.29810, -1667.46790, 8.63250,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1582.29810, -1657.83667, 8.63250,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1577.49036, -1648.44971, 12.13020,   0.00000, 0.00000, 90.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1582.29810, -1648.20654, 12.13020,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19445, 1582.29810, -1657.83667, 12.13020,   0.00000, 0.00000, 0.00000), 0, 6341, "rodeo03_law2", "poundwall1_sfe", 0xFFFFFFFF);
	//obiekty parking gorny dobudowka
		//podloga
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1579.30261, -1635.19666, 12.31120,   0.00000, 90.00000, 0.00000), 0, 16150, "ufo_bar", "sa_wood08_128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1573.84570, -1635.19666, 12.31320,   0.00000, 90.00000, 0.00000), 0, 16150, "ufo_bar", "sa_wood08_128", 0xFFFFFFFF);
		//sufit
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1573.84570, -1635.19666, 15.79990,   0.00000, 90.00000, 0.00000), 0, 4981, "wiresetc2_las", "lasunion7", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1579.30261, -1635.19666, 15.79790,   0.00000, 90.00000, 0.00000), 0, 4981, "wiresetc2_las", "lasunion7", 0xFFFFFFFF);
	//sciany wewnątrz
    SetDynamicObjectMaterial(CreateDynamicObject(19433, 1582.11475, -1637.83972, 14.14170,   0.00000, 0.00000, 0.00000), 0, 4821, "union_las", "easykerb", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19452, 1577.36145, -1637.12488, 14.13570,   0.00000, 0.00000, 90.00000), 0, 4821, "union_las", "easykerb", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19452, 1568.63538, -1639.92627, 14.13570,   0.00000, 0.00000, 0.00000), 0, 4821, "union_las", "easykerb", 0xFFFFFFFF);
    SetDynamicObjectMaterial(CreateDynamicObject(19391, 1568.63538, -1633.50513, 14.14170,   0.00000, 0.00000, 0.00000), 0, 4821, "union_las", "easykerb", 0xFFFFFFFF);
   	SetDynamicObjectMaterial(CreateDynamicObject(19406, 1584.51636, -1633.67261, 14.13970,   0.00000, 0.00000, 0.00000), 0, 4821, "union_las", "easykerb", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19406, 1570.15320, -1630.38269, 14.13970,   0.00000, 0.00000, 90.00000), 0, 4821, "union_las", "easykerb", 0xFFFFFFFF);
    SetDynamicObjectMaterial(CreateDynamicObject(19406, 1582.99829, -1630.38269, 14.13970,   0.00000, 0.00000, 90.00000), 0, 4821, "union_las", "easykerb", 0xFFFFFFFF);
    SetDynamicObjectMaterial(CreateDynamicObject(19433, 1568.63538, -1631.09766, 14.14170,   0.00000, 0.00000, 0.00000), 0, 4821, "union_las", "easykerb", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19433, 1584.51636, -1631.26465, 14.14170,   0.00000, 0.00000, 0.00000), 0, 4821, "union_las", "easykerb", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19433, 1584.51636, -1636.07703, 14.14170,   0.00000, 0.00000, 0.00000), 0, 4821, "union_las", "easykerb", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19452, 1576.57544, -1630.38269, 14.13970,   0.00000, 0.00000, 90.00000), 0, 4821, "union_las", "easykerb", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19452, 1573.40503, -1637.12292, 14.13570,   0.00000, 0.00000, 90.00000), 0, 4821, "union_las", "easykerb", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19433, 1584.51440, -1637.56519, 14.14170,   0.00000, 0.00000, 0.00000), 0, 4821, "union_las", "easykerb", 0xFFFFFFFF);
	    //zewnatrzsciany
    SetDynamicObjectMaterial(CreateDynamicObject(19391, 1568.63342, -1633.50708, 14.13970,   0.00000, 0.00000, 0.00000), 0, 5775, "sunset01_lawn", "comptwall30", 0xFFFFFFFF);
    //SetDynamicObjectMaterial(STREAMER_TAG_OBJECT objectid, materialindex, modelid, const txdname[], const texturename[], materialcolor = 0)
	SetDynamicObjectMaterial(CreateDynamicObject(19452, 1568.63342, -1639.92627, 14.13770,   0.00000, 0.00000, 0.00000), 0, 5775, "sunset01_lawn", "comptwall30", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19433, 1568.63342, -1631.09766, 14.14370,   0.00000, 0.00000, 0.00000), 0, 5775, "sunset01_lawn", "comptwall30", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19406, 1570.1572, -1630.3807, 14.1437,   0.00000, 0.00000, 90.00000), 0, 5775, "sunset01_lawn", "comptwall30", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19452, 1576.57544, -1630.37866, 14.14170,   0.00000, 0.00000, 90.00000), 0, 5775, "sunset01_lawn", "comptwall30", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19406, 1583.00024, -1630.37866, 14.14170,   0.00000, 0.00000, 90.00000), 0, 5775, "sunset01_lawn", "comptwall30", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19433, 1584.51843, -1631.26465, 14.14370,   0.00000, 0.00000, 0.00000), 0, 5775, "sunset01_lawn", "comptwall30", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19406, 1584.51843, -1633.67456, 14.14170,   0.00000, 0.00000, 0.00000), 0, 5775, "sunset01_lawn", "comptwall30", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19433, 1584.51843, -1636.07898, 14.14370,   0.00000, 0.00000, 0.00000), 0, 5775, "sunset01_lawn", "comptwall30", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19433, 1584.51636, -1637.56519, 14.14370,   0.00000, 0.00000, 0.00000), 0, 5775, "sunset01_lawn", "comptwall30", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1573.84570, -1635.19666, 15.80390,   0.00000, 90.00000, 0.00000), 0, 12850, "cunte_block1", "sjmbrwn3", 0xFFFFFFFF);//sufit
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1579.30261, -1635.19666, 15.80590,   0.00000, 90.00000, 0.00000), 0, 12850, "cunte_block1", "sjmbrwn3", 0xFFFFFFFF);//sufit
	CreateDynamicObject(2192, 1568.90527, -1630.47205, 15.88500,   0.00000, 0.00000, 43.93500);
	//CreateDynamicObject(19454, 1539.64624, -1616.71667, 16.16780,   0.00000, 0.00000, 0.00000);
	//CreateDynamicObject(19454, 1539.64429, -1616.72070, 14.16850,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19391, 1568.63538, -1633.50513, 14.14170,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1649, 1571.19385, -1630.38440, 13.91330,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1649, 1584.50354, -1633.70593, 13.91330,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1649, 1582.02466, -1630.38440, 13.91330,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1649, 1571.19385, -1630.38440, 13.91330,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1649, 1582.02466, -1630.38440, 13.91330,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1649, 1584.50354, -1633.70593, 13.91330,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(2606, 1575.98633, -1630.66016, 15.29220,   25.00000, 0.00000, 0.00000);
	CreateDynamicObject(2606, 1574.00623, -1630.66016, 15.29220,   25.00000, 0.00000, 0.00000);
	CreateDynamicObject(2357, 1574.46875, -1636.33105, 12.78640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2002, 1569.24951, -1635.84265, 12.40000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1808, 1568.94946, -1635.20691, 12.40000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2166, 1582.94495, -1630.94104, 12.39810,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(2165, 1583.93689, -1633.04773, 12.39830,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(11728, 1581.16736, -1637.04187, 14.07690,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19828, 1568.72156, -1632.29944, 14.12880,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19811, 1572.98523, -1636.67517, 13.25020,   0.00000, 0.00000, 353.22305);
	CreateDynamicObject(19564, 1573.01733, -1636.16565, 13.19420,   0.00000, 0.00000, 14.00000);
	CreateDynamicObject(19563, 1576.03857, -1636.80994, 13.19420,   0.00000, 0.00000, 34.00000);
	CreateDynamicObject(2223, 1574.32019, -1636.69067, 13.26090,   0.00000, 0.00000, 98.14642);
	CreateDynamicObject(2222, 1575.96448, -1636.21155, 13.26090,   0.00000, 0.00000, 80.00000);
	CreateDynamicObject(2221, 1573.37036, -1636.23657, 13.26760,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11746, 1575.02258, -1636.09521, 13.19940,   90.00000, 0.00000, 321.00000);
	CreateDynamicObject(19792, 1574.10474, -1635.91138, 13.19800,   0.00000, 0.00000, 21.00000);
	CreateDynamicObject(11749, 1575.26099, -1636.49988, 13.19740,   0.00000, 0.00000, 421.00000);
	CreateDynamicObject(19825, 1575.07324, -1637.00305, 15.23070,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(11743, 1575.65649, -1636.81006, 13.18930,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19814, 1572.64258, -1637.02454, 13.32330,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19814, 1575.07031, -1637.02454, 13.32330,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(11706, 1568.98767, -1630.99438, 12.38640,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1721, 1570.99585, -1636.77869, 12.37470,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1721, 1577.97217, -1636.77869, 12.37470,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1721, 1571.90784, -1636.77869, 12.37470,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1721, 1577.04944, -1636.77869, 12.37470,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1806, 1582.72180, -1631.70313, 12.38720,   0.00000, 0.00000, 303.72711);
	CreateDynamicObject(1806, 1582.69690, -1633.31262, 12.38720,   0.00000, 0.00000, 259.98520);
	CreateDynamicObject(2894, 1582.99304, -1630.80664, 13.19250,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2967, 1583.79236, -1631.61755, 13.18060,   0.00000, 0.00000, -80.00000);
	CreateDynamicObject(2737, 1579.32495, -1637.00000, 14.02940,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2173, 1574.56335, -1630.99072, 12.38250,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1714, 1575.0918, -1632.1963, 12.3696,   -3.00000, 0.00000, 170.00000);
	CreateDynamicObject(11730, 1572.34155, -1630.74170, 12.40080,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11729, 1571.66370, -1630.74170, 12.40080,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19893, 1575.09082, -1631.15234, 13.18010,   0.00000, 0.00000, 23.66720);
	CreateDynamicObject(19920, 1575.57178, -1631.07446, 13.19400,   2.60000, 0.00000, 327.25146);
	CreateDynamicObject(19807, 1584.03943, -1632.12988, 13.26270,   0.00000, 0.00000, 247.25999);
	CreateDynamicObject(1491, 1582.61047, -1637.96228, 12.39820,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(2609, 1584.05798, -1636.14050, 13.12690,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(2609, 1584.05798, -1635.23096, 13.12690,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(2609, 1584.05798, -1635.68506, 13.12690,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(2164, 1577.67651, -1630.52222, 12.39200,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2200, 1579.65320, -1630.63928, 12.39440,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2163, 1579.86499, -1630.53967, 14.27420,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19434, 1582.45544, -1637.94580, 15.69900,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(1893, 1580.50659, -1633.94690, 15.82740,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1893, 1572.29810, -1633.94690, 15.82740,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(4090, 1602.80652, -1608.15271, 18.78930,   0.00000, 0.00000, 0.19440);
	CreateDynamicObject(19520, 1574.50012, -1631.11755, 13.23830,   -12.00000, -90.00000, 83.01870);
	//ogrodzenie
	CreateDynamicObject(970, 1539.49084, -1653.56958, 13.06910,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(970, 1539.50562, -1659.52319, 13.06910,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(970, 1539.49084, -1665.72778, 13.06910,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(970, 1539.49084, -1671.83337, 13.06910,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(970, 1539.49084, -1678.12024, 13.06910,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(970, 1539.49084, -1684.47034, 13.06910,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(970, 1539.49084, -1690.98010, 13.06910,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(970, 1539.49084, -1697.07874, 13.06910,   0.00000, 0.00000, 90.00000);
	new niewidzialne2 =	CreateDynamicObject(970, 1541.31592, -1699.89832, 13.53710,   0.00000, 0.00000, 0.00000);
	new niewidzialne = CreateDynamicObject(970, 1541.13745, -1650.04309, 13.56710,   0.00000, 0.00000, 38.19890);
    SetDynamicObjectMaterialText(niewidzialne, 0, " ", 100, "Arial Black", 45, 1, 0xFFFFFFFF, 0, 1);//niewidzialne
    SetDynamicObjectMaterialText(niewidzialne2, 0, " ", 100, "Arial Black", 45, 1, 0xFFFFFFFF, 0, 1);//niewidzialne
    SetDynamicObjectMaterialText(niewidzialne, 1," ", 100, "Arial Black", 45, 1, 0xFFFFFFFF, 0, 1);//niewidzialne
    SetDynamicObjectMaterialText(niewidzialne2,  1," ", 100, "Arial Black", 45, 1, 0xFFFFFFFF, 0, 1);//niewidzialne

    //dalsza podstawa
    SetObjectMaterial(CreateObject(19545, 1611.21680, -1629.80457, 12.54870,   0.00000, 0.00000, 0.00000), 0, 10023, "bigwhitesfe", "ws_carpark2", 0xFFFFFFFF);
	SetObjectMaterial(CreateObject(19545, 1547.03455, -1679.64758, 12.55150,   0.00000, 0.00000, 0.00000), 0, 10023, "bigwhitesfe", "ws_carpark2", 0xFFFFFFFF);
	
	SetObjectMaterial(CreateObject(19545, 1605.59937, -1691.62256, 12.54670,   0.00000, 0.00000, 0.00000), 0, 10023, "bigwhitesfe", "ws_carpark2", 0xFFFFFFFF);
    //end dalsza podstawa

	//winda - góra
	CreateDynamicObject(18755, 1560.1951, -1639.2027, 14.3007,0.0000, 0.0000, -90.0000);
	CreateDynamicObject(18757, 1560.1442, -1635.3511, 14.3162,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18756, 1560.1372, -1635.3523, 14.3162,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19435, 1562.2673, -1637.9629, 11.4679,0.0000, 0.0000, 0.0000);
	CreateDynamicObject(19435, 1558.1049, -1637.9529, 11.4679,0.0000, 0.0000, 0.0000);
			//na dach - niewidzialne
	SetDynamicObjectMaterialText(CreateDynamicObject(19880, 1555.43152, -1677.93689, 28.4843,   0.00000, 0.00000, 90.00000),  0, " ", 100, "Arial Black", 45, 1, 0xFFFFFFFF, 0, 1);
	SetDynamicObjectMaterialText(CreateDynamicObject(19880, 1572.28467, -1638.30225, 28.4843,   0.00000, 0.00000, 0.00000),  0, " ", 100, "Arial Black", 45, 1, 0xFFFFFFFF, 0, 1);
	SetDynamicObjectMaterialText(CreateDynamicObject(19880, 1577.21326, -1675.14172, 28.4843,   0.00000, 0.00000, 90.00000),  0, " ", 100, "Arial Black", 45, 1, 0xFFFFFFFF, 0, 1);
	SetDynamicObjectMaterialText(CreateDynamicObject(19880, 1547.72705, -1638.30225, 28.4843,   0.00000, 0.00000, 0.00000),  0, " ", 100, "Arial Black", 45, 1, 0xFFFFFFFF, 0, 1);
	SetDynamicObjectMaterialText(CreateDynamicObject(19880, 1555.91577, -1638.30225, 28.4843,   0.00000, 0.00000, 0.00000),  0, " ", 100, "Arial Black", 45, 1, 0xFFFFFFFF, 0, 1);
	SetDynamicObjectMaterialText(CreateDynamicObject(19880, 1564.09351, -1638.30225, 28.4843,   0.00000, 0.00000, 0.00000),  0, " ", 100, "Arial Black", 45, 1, 0xFFFFFFFF, 0, 1);
	SetDynamicObjectMaterialText(CreateDynamicObject(19880, 1543.66577, -1645.46448, 28.4843,   0.00000, 0.00000, 90.00000),  0, " ", 100, "Arial Black", 45, 1, 0xFFFFFFFF, 0, 1);
	SetDynamicObjectMaterialText(CreateDynamicObject(19880, 1547.77942, -1649.53430, 28.4843,   0.00000, 0.00000, 0.00000),  0, " ", 100, "Arial Black", 45, 1, 0xFFFFFFFF, 0, 1);
	SetDynamicObjectMaterialText(CreateDynamicObject(19880, 1555.43152, -1653.40649, 28.4843,   0.00000, 0.00000, 90.00000),  0, " ", 100, "Arial Black", 45, 1, 0xFFFFFFFF, 0, 1);
	SetDynamicObjectMaterialText(CreateDynamicObject(19880, 1555.43152, -1661.57825, 28.4843,   0.00000, 0.00000, 90.00000),  0, " ", 100, "Arial Black", 45, 1, 0xFFFFFFFF, 0, 1);
	SetDynamicObjectMaterialText(CreateDynamicObject(19880, 1543.65894, -1642.49792, 28.4843,   0.00000, 0.00000, 90.00000),  0, " ", 100, "Arial Black", 45, 1, 0xFFFFFFFF, 0, 1);
	SetDynamicObjectMaterialText(CreateDynamicObject(19880, 1577.21326, -1642.51270, 28.4843,   0.00000, 0.00000, 90.00000),  0, " ", 100, "Arial Black", 45, 1, 0xFFFFFFFF, 0, 1);
	SetDynamicObjectMaterialText(CreateDynamicObject(19880, 1577.21326, -1650.65747, 28.4843,   0.00000, 0.00000, 90.00000),  0, " ", 100, "Arial Black", 45, 1, 0xFFFFFFFF, 0, 1);
	SetDynamicObjectMaterialText(CreateDynamicObject(19880, 1577.21326, -1658.84497, 28.4843,   0.00000, 0.00000, 90.00000),  0, " ", 100, "Arial Black", 45, 1, 0xFFFFFFFF, 0, 1);
	SetDynamicObjectMaterialText(CreateDynamicObject(19880, 1577.21326, -1667.05310, 28.4843,   0.00000, 0.00000, 90.00000),  0, " ", 100, "Arial Black", 45, 1, 0xFFFFFFFF, 0, 1);
	SetDynamicObjectMaterialText(CreateDynamicObject(19880, 1555.43152, -1669.74609, 28.4843,   0.00000, 0.00000, 90.00000),  0, " ", 100, "Arial Black", 45, 1, 0xFFFFFFFF, 0, 1);
	SetDynamicObjectMaterialText(CreateDynamicObject(19880, 1551.38635, -1649.53210, 28.4843,   0.00000, 0.00000, 0.00000),  0, " ", 100, "Arial Black", 45, 1, 0xFFFFFFFF, 0, 1);
	//przed drzwiami
	SetDynamicObjectMaterial(CreateDynamicObject(18766, 1549.75354, -1673.23315, 11.78220,   0.00000, 0.00000, 0.00000), 0, 8463, "vgseland", "luxorwall01_128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(18766, 1549.75354, -1678.17761, 11.78220,   0.00000, 0.00000, 0.00000), 0, 8463, "vgseland", "luxorwall01_128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(18766, 1556.07251, -1673.23706, 13.46050,   0.00000, 0.00000, 0.00000), 0, 8463, "vgseland", "luxorwall01_128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(18766, 1556.07751, -1678.17566, 13.46050,   0.00000, 0.00000, 0.00000), 0, 8463, "vgseland", "luxorwall01_128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(18766, 1547.60461, -1678.17358, 11.58120,   0.00000, -25.00000, 0.00000), 0, 8463, "vgseland", "luxorwall01_128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(CreateDynamicObject(18766, 1547.60461, -1673.23511, 11.58120,   0.00000, -25.00000, 0.00000), 0, 8463, "vgseland", "luxorwall01_128", 0xFFFFFFFF);
	new kolumna = CreateDynamicObject(18770, 1554.11206, -1671.78564, -82.73210,   0.00000, 0.00000, 0.00000);
	new kolumna2 = CreateDynamicObject(18770, 1554.11206, -1679.30334, -82.73210,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(kolumna, 1, 16093, "a51_ext", "concretegroundl1_256", 0xFFFFFFFF);
	SetDynamicObjectMaterial(kolumna2, 1, 16093, "a51_ext", "concretegroundl1_256", 0xFFFFFFFF);
	SetDynamicObjectMaterial(kolumna, 0, 16093, "a51_ext", "concretegroundl1_256", 0xFFFFFFFF);
	SetDynamicObjectMaterial(kolumna2, 0, 16093, "a51_ext", "concretegroundl1_256", 0xFFFFFFFF);
	SetDynamicObjectMaterial(kolumna, 2, 16093, "a51_ext", "concretegroundl1_256", 0xFFFFFFFF);
	SetDynamicObjectMaterial(kolumna2, 2, 16093, "a51_ext", "concretegroundl1_256", 0xFFFFFFFF);
	//przeddrz-inne
	CreateDynamicObject(1359, 1546.65039, -1700.57642, 13.23390,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1359, 1546.65039, -1650.78552, 13.23390,   0.00000, 0.00000, 0.00000);
	//rosliny
	CreateDynamicObject(2253, 1546.16309, -1678.17041, 14.54940,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2253, 1546.16309, -1673.25659, 14.54940,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1364, 1549.69458, -1700.33044, 13.32990,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1364, 1549.69458, -1650.86438, 13.32990,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(632, 1552.92786, -1679.65881, 12.96160,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(632, 1552.92786, -1671.87878, 12.96160,   0.00000, 0.00000, 0.00000);
	//pozostałe obiekty na parking dolny
	CreateDynamicObject(18766, 1603.29175, -1643.35791, 10.24820,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18766, 1548.21265, -1638.33325, 13.51210,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, 1598.79260, -1638.31995, 10.24820,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, 1597.64502, -1638.32153, 10.24820,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, 1577.22095, -1638.33508, 10.24820,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, 1567.22339, -1638.32922, 10.24820,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, 1557.22278, -1638.32922, 13.51210,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19436, 1539.45044, -1633.70569, 10.79680,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(14411, 1548.77869, -1675.61902, 12.06670,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(18755, 1576.47742, -1646.55054, 8.81070,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18757, 1576.48315, -1646.58142, 8.82140,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18756, 1576.47583, -1646.58142, 8.82140,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19273, 1592.7686, -1637.7179, 14.1506,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1616, 1592.20337, -1670.76099, 11.59430,   0.00000, 0.00000, 331.97067);
	CreateDynamicObject(1616, 1586.72913, -1694.29578, 11.59430,   0.00000, 0.00000, 186.64810);
	CreateDynamicObject(1616, 1581.92639, -1669.66980, 11.59430,   0.00000, 0.00000, 329.50027);
	CreateDynamicObject(1616, 1584.26013, -1694.25220, 11.59430,   0.00000, 0.00000, 2.24880);
	CreateDynamicObject(14487, 1585.53125, -1689.71448, 11.87000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1893, 1575.27222, -1668.24316, 12.12000,   0.00000, 0.00000, 89.00000);
	CreateDynamicObject(1893, 1575.27222, -1652.41492, 12.12000,   0.00000, 0.00000, 89.00000);
	
	printf("Stworzono obiekty");
	
	return 1;
}
nowyExtPd_UsunObiekty(playerid)
{
	//exampleObjects_UsunObiekty();
	RemoveBuildingForPlayer(playerid, 4063, 1578.4688, -1676.4219, 13.0703, 0.25);
	RemoveBuildingForPlayer(playerid, 1525, 1549.8906, -1714.5234, 15.1016, 0.25);
	RemoveBuildingForPlayer(playerid, 4228, 1568.2891, -1677.7813, 10.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 1266, 1538.5234, -1609.8047, 19.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1266, 1565.4141, -1722.3125, 25.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 4229, 1597.9063, -1699.7500, 30.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 4230, 1597.9063, -1699.7500, 30.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 1260, 1565.4141, -1722.3125, 25.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 646, 1545.5234, -1678.8438, 14.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 646, 1553.8672, -1677.7266, 16.4375, 0.25);
	RemoveBuildingForPlayer(playerid, 4032, 1568.2891, -1677.7813, 10.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 4232, 1568.2891, -1677.7813, 10.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 646, 1553.8672, -1673.4609, 16.4375, 0.25);
	RemoveBuildingForPlayer(playerid, 646, 1545.5625, -1672.2188, 14.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 3975, 1578.4688, -1676.4219, 13.0703, 0.25);
	RemoveBuildingForPlayer(playerid, 4192, 1591.6953, -1674.8516, 20.4922, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1541.7422, -1638.9141, 14.4375, 0.25);
	RemoveBuildingForPlayer(playerid, 1260, 1538.5234, -1609.8047, 19.8438, 0.25);
	return 1;
}