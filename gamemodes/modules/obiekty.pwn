//obiekty.pwn
// KOLEJNOå∆: rX,rY,rZ,VirtualWorld,Interior);

//OBIEKTY
#include "modules/Obiekty/admin.pwn"
#include "modules/Obiekty/ballas.pwn"
#include "modules/Obiekty/basen.pwn"
#include "modules/Obiekty/bor.pwn"
#include "modules/Obiekty/bramy.pwn"
#include "modules/Obiekty/bs.pwn"
#include "modules/Obiekty/bus.pwn"
#include "modules/Obiekty/christmas.pwn"
#include "modules/Obiekty/dillimore.pwn"
#include "modules/Obiekty/dmv.pwn"
#include "modules/Obiekty/fbi.pwn"
#include "modules/Obiekty/fam_fdu.pwn"
#include "modules/Obiekty/grove.pwn"
#include "modules/Obiekty/ha.pwn"
#include "modules/Obiekty/ibiza.pwn"
#include "modules/Obiekty/icc.pwn"
#include "modules/Obiekty/kt.pwn"
//#include "modules/Obiekty/las.pwn"
#include "modules/Obiekty/ls_grape.pwn"
#include "modules/Obiekty/lsfd.pwn"
#include "modules/Obiekty/lsmc.pwn"
#include "modules/Obiekty/lspd.pwn"
#include "modules/Obiekty/ng.pwn"
#include "modules/Obiekty/pc.pwn"
#include "modules/Obiekty/sad.pwn"
#include "modules/Obiekty/sn.pwn"
#include "modules/Obiekty/wps.pwn"
#include "modules/Obiekty/vagos.pwn"
#include "modules/Obiekty/vinyl.pwn"
#include "modules/Obiekty/ykz.pwn"
#include "modules/Obiekty/bank.pwn"

Stworz_Obiekty()
{
	SetTimerEx("obiekty_timer", 1000,0,"d",1);
	return 1;
}

public obiekty_timer(wartosc)
{
	if(wartosc == 0) return 0;
    Bus_Stops();
    Stare_Obiekty();
	ZaladujBramy();
    BazaLSFD();
    EXT_GrapeStreet();
    EXT_BazaHA();
    PC_Ext();
    BS_Ext();
    Dillimore_Load();
    EXT_Yakuza();
    BazaNG();
	LSPDintek();
	BazaKT();
	Risto();
	LOADLSMC();
    SN_Load();
    Int_BarBallas();
    VinylClub();
    Ibiza_Club();
    JettyLounge();
    INT_AT400();
    INT_AirTowerLS();
    EXT_Dworzec();
    PC_UM();
    BOR_Load();
    Basen_Load();
    FBI_Load();
    WPS_Load();
    DMV_Load();
    KT_Lotniska();
    Load_AdminIsland();
    //Rodziny
    INT_FamilySad();
    FDU_Load();
    EXT_Grove();
    INT_VagosPub();
    INT_LSFD();
    LS_ElCorona();

    ChangeLSMCElevatorState();
	return 1;
}

UsunObiekty(playerid)
{
	SetTimerEx("usuwanie_obiektow", 1000,0,"d",playerid);
	return 1;
}

public usuwanie_obiektow(playerid)
{
	DeleteObjects(playerid);
	return 1;
}

DeleteObjects(playerid)
{
	//Z funkcji
	Dillimore_DeleteMapObjects(playerid);

    //___Obiekty usuniÍte - Osiedle Idlewood/Alhambra___
    RemoveBuildingForPlayer(playerid, 5544, 1873.7422, -1682.4766, 34.7969, 0.25);
    RemoveBuildingForPlayer(playerid, 1524, 1837.6641, -1640.3828, 13.7578, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 1855.7188, -1741.5391, 10.8047, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 1879.5078, -1741.4844, 10.8047, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 1908.2188, -1741.4844, 10.8047, 0.25);
    RemoveBuildingForPlayer(playerid, 712, 1929.5781, -1736.9063, 21.3906, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 1931.0391, -1726.3281, 10.8047, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 1832.3828, -1694.3125, 9.7188, 0.25);
    RemoveBuildingForPlayer(playerid, 1537, 1837.4375, -1683.9688, 12.3047, 0.25);
    RemoveBuildingForPlayer(playerid, 1533, 1837.4375, -1683.9531, 12.3047, 0.25);
    RemoveBuildingForPlayer(playerid, 1537, 1837.4375, -1686.9844, 12.3125, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 1832.8984, -1670.7656, 9.7188, 0.25);
    RemoveBuildingForPlayer(playerid, 1533, 1837.4375, -1677.9219, 12.2969, 0.25);
    RemoveBuildingForPlayer(playerid, 1537, 1837.4375, -1680.9531, 12.2969, 0.25);
    RemoveBuildingForPlayer(playerid, 1533, 1837.4375, -1680.9375, 12.2969, 0.25);
    RemoveBuildingForPlayer(playerid, 5408, 1873.7422, -1682.4766, 34.7969, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 1931.0391, -1702.2891, 10.8047, 0.25);
    RemoveBuildingForPlayer(playerid, 712, 1929.5781, -1694.4609, 21.3906, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 1931.0391, -1667.0313, 10.8047, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 1931.0391, -1637.8984, 10.8047, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 1855.7188, -1623.2813, 10.8047, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 1879.5078, -1623.1016, 10.8047, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 1908.2188, -1622.9844, 10.8047, 0.25);
    RemoveBuildingForPlayer(playerid, 712, 1929.5781, -1627.6250, 21.3906, 0.25);
    //VagosPub
    RemoveBuildingForPlayer(playerid, 5629, 2131.0859, -1029.3750, 50.1563, 0.25);
    //Trucker job
    RemoveBuildingForPlayer(playerid, 5464, 1902.4297, -1309.5391, 29.9141, 0.25);
    RemoveBuildingForPlayer(playerid, 3573, 1798.6484, -2057.9141, 14.9844, 0.25);
    //K.A.C.C LV bramy
    RemoveBuildingForPlayer(playerid, 985, 2497.4063, 2777.0703, 11.5313, 0.25);
    RemoveBuildingForPlayer(playerid, 986, 2497.4063, 2769.1094, 11.5313, 0.25);
    //Sπd
    RemoveBuildingForPlayer(playerid, 620, 1330.6016, -1340.9844, 6.1094, 0.25); //S•D
	RemoveBuildingForPlayer(playerid, 620, 1326.6953, -1316.0078, 8.7266, 0.25); //S•D
	RemoveBuildingForPlayer(playerid, 620, 1327.5938, -1333.6719, 6.1094, 0.25); //S•D
	RemoveBuildingForPlayer(playerid, 620, 1332.0000, -1309.4297, 8.7266, 0.25); //S•D
	RemoveBuildingForPlayer(playerid, 620, 1321.5234, -1374.4297, 12.5859, 0.25); //S•D
	RemoveBuildingForPlayer(playerid, 620, 1292.0000, -1374.2969, 12.3672, 0.25); //S•D
	RemoveBuildingForPlayer(playerid, 620, 1300.5859, -1374.2969, 12.3672, 0.25); //S•D
	RemoveBuildingForPlayer(playerid, 620, 1329.4766, -1374.4297, 12.5859, 0.25); //S•D
	RemoveBuildingForPlayer(playerid, 1312, 1307.6172, -1394.4766, 16.5000, 0.25); //S•D
	RemoveBuildingForPlayer(playerid, 1297, 1309.8984, -1390.1172, 15.6406, 0.25); //S•D

    RemoveBuildingForPlayer(playerid, 13024, -87.3047, -347.5000, 3.1719, 0.25); //HA
	RemoveBuildingForPlayer(playerid, 12932, -117.9609, -337.4531, 3.6172, 0.25); //HA
    //Dworzec glowny
    RemoveBuildingForPlayer(playerid, 5033, 1745.2031, -1882.8516, 26.1406, 0.25);
    RemoveBuildingForPlayer(playerid, 5055, 1745.2031, -1882.8516, 26.1406, 0.25);
    RemoveBuildingForPlayer(playerid, 955, 1729.7891, -1943.0469, 12.9453, 0.25);
    RemoveBuildingForPlayer(playerid, 963, 1747.0391, -1942.6641, 13.6094, 0.25);
    RemoveBuildingForPlayer(playerid, 962, 1757.1484, -1942.6563, 13.6094, 0.25);
    RemoveBuildingForPlayer(playerid, 5024, 1748.8438, -1883.0313, 14.1875, 0.25);
    RemoveBuildingForPlayer(playerid, 5083, 1748.8438, -1883.0313, 14.1875, 0.25);
    RemoveBuildingForPlayer(playerid, 1226, 1755.8203, -1859.5391, 16.3516, 0.25);
    //Grapestreet
    RemoveBuildingForPlayer(playerid, 3562, 2232.3984, -1464.7969, 25.6484, 0.25);
    RemoveBuildingForPlayer(playerid, 3562, 2247.5313, -1464.7969, 25.5469, 0.25);
    RemoveBuildingForPlayer(playerid, 3562, 2263.7188, -1464.7969, 25.4375, 0.25);
    RemoveBuildingForPlayer(playerid, 3562, 2243.7109, -1401.7813, 25.6406, 0.25);
    RemoveBuildingForPlayer(playerid, 3562, 2230.6094, -1401.7813, 25.6406, 0.25);
    RemoveBuildingForPlayer(playerid, 3562, 2256.6641, -1401.7813, 25.6406, 0.25);
    RemoveBuildingForPlayer(playerid, 673, 2229.0234, -1411.6406, 22.9609, 0.25);
    RemoveBuildingForPlayer(playerid, 1308, 2223.0938, -1410.1172, 23.3125, 0.25);
    RemoveBuildingForPlayer(playerid, 1221, 2253.2188, -1409.8906, 23.6328, 0.25);
    RemoveBuildingForPlayer(playerid, 1221, 2226.8516, -1404.7422, 23.6328, 0.25);
    RemoveBuildingForPlayer(playerid, 1220, 2222.8750, -1396.1250, 23.3047, 0.25);
    RemoveBuildingForPlayer(playerid, 3582, 2230.6094, -1401.7813, 25.6406, 0.25);
    RemoveBuildingForPlayer(playerid, 1308, 2227.8672, -1394.4141, 23.0547, 0.25);
    RemoveBuildingForPlayer(playerid, 3582, 2243.7109, -1401.7813, 25.6406, 0.25);
    RemoveBuildingForPlayer(playerid, 3582, 2256.6641, -1401.7813, 25.6406, 0.25);
    RemoveBuildingForPlayer(playerid, 1308, 2252.5859, -1394.4141, 23.0547, 0.25);
    RemoveBuildingForPlayer(playerid, 1308, 2224.4219, -1473.0391, 22.8047, 0.25);
    RemoveBuildingForPlayer(playerid, 1307, 2225.4219, -1456.3906, 23.1172, 0.25);
    RemoveBuildingForPlayer(playerid, 645, 2239.5703, -1468.8047, 22.6875, 0.25);
    RemoveBuildingForPlayer(playerid, 3582, 2232.3984, -1464.7969, 25.6484, 0.25);
    RemoveBuildingForPlayer(playerid, 673, 2241.8906, -1458.9297, 22.9609, 0.25);
    RemoveBuildingForPlayer(playerid, 1308, 2258.6328, -1473.0391, 22.8047, 0.25);
    RemoveBuildingForPlayer(playerid, 3582, 2247.5313, -1464.7969, 25.5469, 0.25);
    RemoveBuildingForPlayer(playerid, 3582, 2263.7188, -1464.7969, 25.4375, 0.25);
    RemoveBuildingForPlayer(playerid, 1307, 2272.6797, -1459.1875, 22.0547, 0.25);
    RemoveBuildingForPlayer(playerid, 1221, 2251.2891, -1461.8281, 23.6328, 0.25);
    RemoveBuildingForPlayer(playerid, 1220, 2256.6563, -1456.8984, 22.8594, 0.25);
    RemoveBuildingForPlayer(playerid, 1230, 2255.9844, -1457.9063, 22.8594, 0.25);
    RemoveBuildingForPlayer(playerid, 5682, 2241.4297, -1433.6719, 31.2813, 0.25);
    //LSMC ext
    RemoveBuildingForPlayer(playerid, 5935, 1120.1563, -1303.4531, 18.5703, 0.25);
	RemoveBuildingForPlayer(playerid, 1440, 1141.9844, -1346.1094, 13.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 1440, 1148.6797, -1385.1875, 13.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, 1115.0781, -1285.3672, 17.0781, 0.25);
	RemoveBuildingForPlayer(playerid, 5737, 1120.1563, -1303.4531, 18.5703, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, 1133.1094, -1276.7109, 17.0781, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1140.8984, -1280.1172, 15.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1161.5859, -1281.3594, 15.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1150.5078, -1269.9375, 15.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 1297, 1190.7734, -1320.8594, 15.9453, 0.25);
    //IBIZA
    RemoveBuildingForPlayer(playerid, 1215, 409.2109, -1798.3359, 7.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 625, 408.8594, -1803.4922, 7.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 1368, 378.0234, -1821.9922, 7.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 388.5859, -1795.2031, 7.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 401.2109, -1795.3125, 7.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 6287, 400.8438, -1794.5547, 5.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 395.2266, -1793.6406, 7.3750, 0.25);
    //Vinyl
    RemoveBuildingForPlayer(playerid, 1297, 828.7656, -1390.1172, 15.6406, 0.25);
    RemoveBuildingForPlayer(playerid, 1462, 826.8516, -1385.6719, 12.5078, 0.25);
    RemoveBuildingForPlayer(playerid, 1307, 807.0313, -1363.7344, 12.7813, 0.25);
    RemoveBuildingForPlayer(playerid, 6003, 954.6875, -1305.7734, 30.1406, 0.25);
    RemoveBuildingForPlayer(playerid, 1266, 875.0469, -1383.4766, 28.1641, 0.25);
    RemoveBuildingForPlayer(playerid, 1297, 868.7656, -1390.1172, 15.6406, 0.25);
    RemoveBuildingForPlayer(playerid, 5817, 848.8594, -1370.4297, 17.7969, 0.25);
    RemoveBuildingForPlayer(playerid, 1440, 857.3750, -1381.1641, 13.0469, 0.25);
    RemoveBuildingForPlayer(playerid, 1365, 861.9844, -1380.4609, 13.6250, 0.25);
    RemoveBuildingForPlayer(playerid, 1260, 875.0469, -1383.4766, 28.1641, 0.25);
    RemoveBuildingForPlayer(playerid, 1462, 853.1953, -1359.7266, 12.5547, 0.25);
    RemoveBuildingForPlayer(playerid, 1635, 860.9141, -1359.8047, 16.0859, 0.25);
    RemoveBuildingForPlayer(playerid, 5818, 954.6875, -1305.7734, 30.1406, 0.25);

    //BILBORD
	RemoveBuildingForPlayer(playerid, 4239, 1407.9063, -1407.3984, 33.9844, 0.25);
	//DOM EK
	RemoveBuildingForPlayer(playerid, 691, 375.6094, -1285.7500, 43.3281, 0.25);
	//FBI
    RemoveBuildingForPlayer(playerid, 1529, 583.4609, -1502.1094, 16.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 616.7656, -1495.7734, 14.3203, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 616.7656, -1492.0313, 14.3203, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 616.7656, -1488.4766, 14.3203, 0.25);
	//Fire
	RemoveBuildingForPlayer(playerid, 717, 1703.9922, -1150.1484, 23.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 717, 1721.2344, -1150.1484, 23.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 717, 1738.7813, -1150.1484, 23.0938, 0.25);

	RemoveBuildingForPlayer(playerid, 1412, 1917.3203, -1797.4219, 13.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, 1912.0547, -1797.4219, 13.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, 1906.7734, -1797.4219, 13.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, 1927.8516, -1797.4219, 13.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, 1922.5859, -1797.4219, 13.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, 1938.3906, -1797.4219, 13.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, 1933.1250, -1797.4219, 13.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, 1951.6094, -1821.1250, 13.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, 1951.6094, -1815.8594, 13.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, 1951.6094, -1810.5938, 13.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, 1951.6094, -1805.3281, 13.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, 1948.9844, -1797.4219, 13.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, 1943.6875, -1797.4219, 13.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, 1951.6094, -1800.0625, 13.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 545.2109, -1523.2344, 17.5000, 0.25);
	
	//Urzπd miasta PC by abram01
	RemoveBuildingForPlayer(playerid, 13374, 2241.4063, 21.4609, 33.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 781, 2253.7734, -79.5313, 25.4922, 0.25);
	RemoveBuildingForPlayer(playerid, 781, 2259.3906, -79.4141, 25.4922, 0.25);
	RemoveBuildingForPlayer(playerid, 781, 2266.0859, -79.4141, 25.4922, 0.25);
	
	//plac manewrowy w SF
    RemoveBuildingForPlayer(playerid, 11372, -2076.4375, -107.9297, 36.9688, 0.25);
 	RemoveBuildingForPlayer(playerid, 11014, -2076.4375, -107.9297, 36.9688, 0.25);
	
	//verona mall
	RemoveBuildingForPlayer(playerid, 6130, 1117.5859, -1490.0078, 32.7188, 0.25);
	RemoveBuildingForPlayer(playerid, 6255, 1117.5859, -1490.0078, 32.7188, 0.25);
	
	//dom - wygrana w konkursie
	RemoveBuildingForPlayer(playerid, 3778, 553.3516, -1875.0000, 4.7891, 0.25);
	RemoveBuildingForPlayer(playerid, 3778, 289.2266, -1875.0000, 3.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 3778, 245.5391, -1875.0000, 2.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 3615, 553.3516, -1875.0000, 4.7891, 0.25);
	RemoveBuildingForPlayer(playerid, 3615, 245.5391, -1875.0000, 2.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 3615, 289.2266, -1875.0000, 3.2031, 0.25);
	//groove street
	RemoveBuildingForPlayer(playerid, 3593, 2437.4844, -1644.1172, 12.9844, 0.25);
	//baza KT by Kubi
	RemoveBuildingForPlayer(playerid, 3682, 2673.0859, -2114.9063, 36.5469, 0.25);
    RemoveBuildingForPlayer(playerid, 3683, 2684.7656, -2088.0469, 20.1172, 0.25);
    RemoveBuildingForPlayer(playerid, 3289, 2484.4141, -2141.0078, 12.1875, 0.25);
    RemoveBuildingForPlayer(playerid, 3289, 2496.0625, -2141.0078, 12.1875, 0.25);
    RemoveBuildingForPlayer(playerid, 3289, 2679.2344, -2106.9766, 12.5391, 0.25);
    RemoveBuildingForPlayer(playerid, 3290, 2503.1250, -2073.3750, 12.4297, 0.25);
    RemoveBuildingForPlayer(playerid, 3290, 2515.4219, -2073.3750, 12.4063, 0.25);
    RemoveBuildingForPlayer(playerid, 3290, 2647.1016, -2073.3750, 12.4453, 0.25);
    RemoveBuildingForPlayer(playerid, 3290, 2658.7188, -2073.3750, 12.4453, 0.25);
    RemoveBuildingForPlayer(playerid, 3290, 2671.5000, -2073.3750, 12.4453, 0.25);
    RemoveBuildingForPlayer(playerid, 3288, 2432.7266, -2133.0234, 12.4531, 0.25);
    RemoveBuildingForPlayer(playerid, 3686, 2448.1328, -2075.6328, 16.0469, 0.25);
    RemoveBuildingForPlayer(playerid, 3745, 2475.1016, -2073.4766, 17.8203, 0.25);
    RemoveBuildingForPlayer(playerid, 3745, 2482.0234, -2073.4766, 17.8203, 0.25);
    RemoveBuildingForPlayer(playerid, 3745, 2489.1016, -2073.4766, 17.8203, 0.25);
    RemoveBuildingForPlayer(playerid, 3745, 2496.0938, -2073.4766, 17.8203, 0.25);
    RemoveBuildingForPlayer(playerid, 3290, 2452.9609, -2129.0156, 25.2734, 0.25);
    RemoveBuildingForPlayer(playerid, 3756, 2484.2344, -2118.5547, 17.7031, 0.25);
    RemoveBuildingForPlayer(playerid, 3755, 2484.2344, -2118.5547, 17.7031, 0.25);
    RemoveBuildingForPlayer(playerid, 3779, 2631.9141, -2098.5781, 20.0078, 0.25);
    RemoveBuildingForPlayer(playerid, 3779, 2653.9375, -2092.3359, 20.0078, 0.25);
    RemoveBuildingForPlayer(playerid, 3257, 2432.7266, -2133.0234, 12.4531, 0.25);
    RemoveBuildingForPlayer(playerid, 3258, 2484.4141, -2141.0078, 12.1875, 0.25);
    RemoveBuildingForPlayer(playerid, 3258, 2496.0625, -2141.0078, 12.1875, 0.25);
    RemoveBuildingForPlayer(playerid, 3256, 2452.9609, -2129.0156, 25.2734, 0.25);
    RemoveBuildingForPlayer(playerid, 3567, 2446.8281, -2075.8438, 13.2578, 0.25);
    RemoveBuildingForPlayer(playerid, 3567, 2438.3594, -2075.8438, 13.2578, 0.25);
    RemoveBuildingForPlayer(playerid, 3627, 2448.1328, -2075.6328, 16.0469, 0.25);
    RemoveBuildingForPlayer(playerid, 3643, 2489.1016, -2073.4766, 17.8203, 0.25);
    RemoveBuildingForPlayer(playerid, 3643, 2482.0234, -2073.4766, 17.8203, 0.25);
    RemoveBuildingForPlayer(playerid, 3643, 2475.1016, -2073.4766, 17.8203, 0.25);
    RemoveBuildingForPlayer(playerid, 3643, 2496.0938, -2073.4766, 17.8203, 0.25);
    RemoveBuildingForPlayer(playerid, 3256, 2515.4219, -2073.3750, 12.4063, 0.25);
    RemoveBuildingForPlayer(playerid, 3256, 2503.1250, -2073.3750, 12.4297, 0.25);
    RemoveBuildingForPlayer(playerid, 3675, 2663.0547, -2121.6563, 30.6250, 0.25);
    RemoveBuildingForPlayer(playerid, 3675, 2665.7734, -2122.5078, 22.2813, 0.25);
    RemoveBuildingForPlayer(playerid, 3675, 2667.3594, -2120.7969, 19.4297, 0.25);
    RemoveBuildingForPlayer(playerid, 3675, 2669.3359, -2120.7969, 26.9141, 0.25);
    RemoveBuildingForPlayer(playerid, 3675, 2669.3359, -2120.7969, 13.2500, 0.25);
    RemoveBuildingForPlayer(playerid, 3675, 2679.4375, -2121.6563, 21.4297, 0.25);
    RemoveBuildingForPlayer(playerid, 3675, 2675.8594, -2121.6563, 25.6016, 0.25);
    RemoveBuildingForPlayer(playerid, 3675, 2684.2031, -2122.5078, 22.8906, 0.25);
    RemoveBuildingForPlayer(playerid, 3675, 2685.0547, -2119.7891, 14.5391, 0.25);
    RemoveBuildingForPlayer(playerid, 3675, 2685.1172, -2119.1016, 19.4297, 0.25);
    RemoveBuildingForPlayer(playerid, 3637, 2631.9141, -2098.5781, 20.0078, 0.25);
    RemoveBuildingForPlayer(playerid, 3637, 2653.9375, -2092.3359, 20.0078, 0.25);
    RemoveBuildingForPlayer(playerid, 3673, 2673.0859, -2114.9063, 36.5469, 0.25);
    RemoveBuildingForPlayer(playerid, 3258, 2679.2344, -2106.9766, 12.5391, 0.25);
    RemoveBuildingForPlayer(playerid, 3674, 2682.3203, -2114.5313, 39.0313, 0.25);
    RemoveBuildingForPlayer(playerid, 3636, 2684.7656, -2088.0469, 20.1172, 0.25);
    RemoveBuildingForPlayer(playerid, 3256, 2647.1016, -2073.3750, 12.4453, 0.25);
    RemoveBuildingForPlayer(playerid, 3256, 2658.7188, -2073.3750, 12.4453, 0.25);
    RemoveBuildingForPlayer(playerid, 3256, 2671.5000, -2073.3750, 12.4453, 0.25);
	//KT SWAG
	BazaKTDestroyObjects(playerid);
	
	//baza NG by Dywan
	RemoveBuildingForPlayer(playerid, 5156, 2838.0391, -2423.8828, 10.9609, 0.25);
	RemoveBuildingForPlayer(playerid, 5159, 2838.0313, -2371.9531, 7.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 5160, 2829.9531, -2479.5703, 5.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 5161, 2838.0234, -2358.4766, 21.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 5162, 2838.0391, -2423.8828, 10.9609, 0.25);
	RemoveBuildingForPlayer(playerid, 5163, 2838.0391, -2532.7734, 17.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 5164, 2838.1406, -2447.8438, 15.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 5165, 2838.0313, -2520.1875, 18.4141, 0.25);
	RemoveBuildingForPlayer(playerid, 5166, 2829.9531, -2479.5703, 5.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 5167, 2838.0313, -2371.9531, 7.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 3689, 2685.3828, -2366.0547, 19.9531, 0.25);
	RemoveBuildingForPlayer(playerid, 3689, 2430.5859, -2583.9453, 20.5234, 0.25);
	RemoveBuildingForPlayer(playerid, 3707, 2716.2344, -2452.5938, 20.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 3707, 2720.3203, -2530.9141, 19.9766, 0.25);
	RemoveBuildingForPlayer(playerid, 3707, 2480.8594, -2460.0547, 20.4922, 0.25);
	RemoveBuildingForPlayer(playerid, 3707, 2539.1797, -2424.3594, 20.4922, 0.25);
	RemoveBuildingForPlayer(playerid, 3690, 2685.3828, -2366.0547, 19.9531, 0.25);
	RemoveBuildingForPlayer(playerid, 3690, 2430.5859, -2583.9453, 20.5234, 0.25);
	RemoveBuildingForPlayer(playerid, 3688, 2387.8047, -2580.8672, 17.7891, 0.25);
	RemoveBuildingForPlayer(playerid, 3688, 2450.8750, -2680.4531, 17.7891, 0.25);
	RemoveBuildingForPlayer(playerid, 3687, 2503.5391, -2366.5078, 16.0469, 0.25);
	RemoveBuildingForPlayer(playerid, 3687, 2475.2578, -2394.7891, 16.0469, 0.25);
	RemoveBuildingForPlayer(playerid, 3687, 2450.5078, -2419.5391, 16.0469, 0.25);
	RemoveBuildingForPlayer(playerid, 3686, 2464.3047, -2617.0156, 16.0469, 0.25);
	RemoveBuildingForPlayer(playerid, 3710, 2788.1563, -2417.7891, 16.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 3710, 2788.1563, -2455.8828, 16.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 3710, 2788.1563, -2493.9844, 16.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 3709, 2511.9609, -2608.0156, 17.0703, 0.25);
	RemoveBuildingForPlayer(playerid, 3709, 2511.9609, -2571.2422, 17.0703, 0.25);
	RemoveBuildingForPlayer(playerid, 3709, 2511.9609, -2535.4531, 17.0703, 0.25);
	RemoveBuildingForPlayer(playerid, 3709, 2660.4766, -2429.2969, 17.0703, 0.25);
	RemoveBuildingForPlayer(playerid, 3709, 2639.5469, -2429.2969, 17.0703, 0.25);
	RemoveBuildingForPlayer(playerid, 3709, 2618.8594, -2429.2969, 17.0703, 0.25);
	RemoveBuildingForPlayer(playerid, 3708, 2720.3203, -2530.9141, 19.9766, 0.25);
	RemoveBuildingForPlayer(playerid, 3708, 2716.2344, -2452.5938, 20.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 3708, 2480.8594, -2460.0547, 20.4922, 0.25);
	RemoveBuildingForPlayer(playerid, 3708, 2539.1797, -2424.3594, 20.4922, 0.25);
	RemoveBuildingForPlayer(playerid, 3710, 2415.4609, -2468.5781, 16.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 3744, 2771.0703, -2372.4453, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3744, 2789.2109, -2377.6250, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3744, 2774.7969, -2386.8516, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3744, 2771.0703, -2520.5469, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3744, 2774.7969, -2534.9531, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3744, 2437.2109, -2490.0938, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3744, 2399.4219, -2490.6797, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3744, 2391.8750, -2503.5078, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3744, 2551.5313, -2472.6953, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3709, 2544.2500, -2524.0938, 16.4453, 0.25);
	RemoveBuildingForPlayer(playerid, 3709, 2544.2500, -2548.8125, 16.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 3746, 2814.2656, -2356.5703, 25.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 3746, 2814.2656, -2521.4922, 25.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 3746, 2568.4453, -2483.3906, 25.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 3746, 2563.1563, -2563.5781, 25.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 3746, 2531.7031, -2629.2266, 25.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 3746, 2519.8047, -2701.8750, 25.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 3746, 2381.1016, -2701.8750, 25.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 3746, 2283.5625, -2601.2734, 20.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 3746, 2283.5625, -2563.2891, 20.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 3746, 2283.5625, -2494.9609, 20.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 5325, 2488.9922, -2509.2578, 18.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 3746, 2422.7031, -2411.9219, 25.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 3746, 2472.4453, -2362.9375, 25.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 3758, 2454.8281, -2702.9141, 3.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 3758, 2615.1094, -2464.6172, 3.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 3758, 2748.0156, -2571.5938, 3.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 3758, 2368.1641, -2523.8672, 3.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 3758, 2702.3984, -2324.2578, 3.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 5335, 2829.9531, -2479.5703, 5.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 5336, 2829.9531, -2479.5703, 5.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 3770, 2795.8281, -2394.2422, 14.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 3770, 2746.4063, -2453.4844, 14.0781, 0.25);
	RemoveBuildingForPlayer(playerid, 3770, 2507.3672, -2640.0703, 14.0781, 0.25);
	RemoveBuildingForPlayer(playerid, 3769, 2464.1250, -2571.6328, 15.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 3769, 2400.9063, -2577.3359, 15.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 5352, 2838.1953, -2488.6641, 29.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 3620, 2381.1016, -2701.8750, 25.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, 2406.5469, -2695.0156, 26.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 2387.0547, -2667.7422, 16.4688, 0.25);
	RemoveBuildingForPlayer(playerid, 1413, 2392.1172, -2653.5625, 13.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 1413, 2386.8438, -2653.5078, 13.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 1413, 2397.3984, -2653.6250, 13.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, 2402.6719, -2653.6406, 13.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 1413, 2407.9453, -2653.6484, 13.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 3620, 2283.5625, -2601.2734, 20.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, 2376.3281, -2630.0000, 26.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 2410.9766, -2632.8750, 16.4688, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, 2376.3281, -2575.8750, 26.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 3620, 2283.5625, -2563.2891, 20.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 3753, 2368.1641, -2523.8672, 3.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 3621, 2387.8047, -2580.8672, 17.7891, 0.25);
	RemoveBuildingForPlayer(playerid, 3574, 2391.8750, -2503.5078, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3625, 2400.9063, -2577.3359, 15.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 2410.9766, -2562.8516, 16.4688, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 2410.9766, -2535.2422, 16.4688, 0.25);
	RemoveBuildingForPlayer(playerid, 3620, 2283.5625, -2494.9609, 20.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 3574, 2399.4219, -2490.6797, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3624, 2415.4609, -2468.5781, 16.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 3753, 2454.8281, -2702.9141, 3.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 3620, 2519.8047, -2701.8750, 25.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, 2492.2031, -2695.0156, 26.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 3621, 2450.8750, -2680.4531, 17.7891, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 2424.2969, -2658.9844, 16.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 1635, 2430.5781, -2653.9453, 23.7188, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 2450.0156, -2632.7734, 16.3594, 0.25);
	RemoveBuildingForPlayer(playerid, 1306, 2469.6016, -2645.3203, 19.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 3578, 2470.1406, -2628.2656, 13.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 3626, 2507.3672, -2640.0703, 14.0781, 0.25);
	RemoveBuildingForPlayer(playerid, 3620, 2531.7031, -2629.2266, 25.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 3627, 2464.3047, -2617.0156, 16.0469, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 2450.0156, -2604.9297, 16.3594, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 2480.3281, -2588.3281, 16.3594, 0.25);
	RemoveBuildingForPlayer(playerid, 1306, 2469.6016, -2579.9844, 19.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 3625, 2464.1250, -2571.6328, 15.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 1306, 2498.3438, -2612.6563, 19.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1413, 2496.5547, -2585.1797, 13.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 1413, 2501.8359, -2585.2422, 13.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 1635, 2511.8359, -2622.6172, 17.3906, 0.25);
	RemoveBuildingForPlayer(playerid, 3623, 2511.9609, -2608.0156, 17.0703, 0.25);
	RemoveBuildingForPlayer(playerid, 3623, 2511.9609, -2571.2422, 17.0703, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 2450.0156, -2563.2188, 16.3594, 0.25);
	RemoveBuildingForPlayer(playerid, 1413, 2496.5547, -2557.3359, 13.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 1413, 2501.8359, -2557.3984, 13.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 1306, 2498.3438, -2547.3203, 19.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, 2470.2734, -2539.0234, 26.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 2450.0156, -2535.5703, 16.3594, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 2480.3281, -2536.4375, 16.3594, 0.25);
	RemoveBuildingForPlayer(playerid, 3578, 2470.1406, -2530.5547, 13.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 1306, 2469.6016, -2514.6484, 19.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 2435.8203, -2512.4844, 16.4688, 0.25);
	RemoveBuildingForPlayer(playerid, 3574, 2437.2109, -2490.0938, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 1306, 2498.3438, -2481.9766, 19.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1635, 2471.5859, -2494.0703, 15.0781, 0.25);
	RemoveBuildingForPlayer(playerid, 1306, 2444.3281, -2435.0625, 19.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 3578, 2526.4297, -2561.3047, 13.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 3623, 2544.2500, -2548.8125, 16.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 3623, 2511.9609, -2535.4531, 17.0703, 0.25);
	RemoveBuildingForPlayer(playerid, 3623, 2544.2500, -2524.0938, 16.4453, 0.25);
	RemoveBuildingForPlayer(playerid, 1306, 2533.3906, -2514.1094, 19.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, 2533.6172, -2461.6875, 26.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 3574, 2551.5313, -2472.6953, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3620, 2563.1563, -2563.5781, 25.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 3620, 2568.4453, -2483.3906, 25.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 3753, 2615.1094, -2464.6172, 3.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 2624.3281, -2452.1484, 16.4141, 0.25);
	RemoveBuildingForPlayer(playerid, 1635, 2459.3359, -2427.8281, 16.7422, 0.25);
	RemoveBuildingForPlayer(playerid, 3622, 2450.5078, -2419.5391, 16.0469, 0.25);
	RemoveBuildingForPlayer(playerid, 3578, 2468.8594, -2413.5234, 13.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 3620, 2422.7031, -2411.9219, 25.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 1635, 2483.7188, -2403.3438, 16.7422, 0.25);
	RemoveBuildingForPlayer(playerid, 1306, 2455.0703, -2399.0156, 19.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 3622, 2475.2578, -2394.7891, 16.0469, 0.25);
	RemoveBuildingForPlayer(playerid, 1306, 2491.7031, -2383.3281, 19.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 3578, 2495.8438, -2386.9375, 13.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 3620, 2472.4453, -2362.9375, 25.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 3622, 2503.5391, -2366.5078, 16.0469, 0.25);
	RemoveBuildingForPlayer(playerid, 3578, 2546.0469, -2396.5938, 13.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 1635, 2512.0078, -2375.0859, 16.7422, 0.25);
	RemoveBuildingForPlayer(playerid, 1306, 2513.0000, -2339.3281, 19.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 3578, 2571.1641, -2421.1328, 13.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, 2592.4922, -2359.4219, 26.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 3623, 2618.8594, -2429.2969, 17.0703, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 2624.3281, -2409.5625, 16.4141, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, 2626.2344, -2391.5234, 26.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2672.5938, -2506.8594, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2680.8594, -2493.0781, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1635, 2704.3672, -2487.8672, 20.5625, 0.25);
	RemoveBuildingForPlayer(playerid, 1306, 2742.2656, -2481.5156, 19.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 2696.0234, -2474.8594, 16.4141, 0.25);
	RemoveBuildingForPlayer(playerid, 5326, 2661.5156, -2465.1406, 20.1094, 0.25);
	RemoveBuildingForPlayer(playerid, 1306, 2669.9063, -2447.2891, 19.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 2696.0234, -2446.6250, 16.4141, 0.25);
	RemoveBuildingForPlayer(playerid, 3623, 2639.5469, -2429.2969, 17.0703, 0.25);
	RemoveBuildingForPlayer(playerid, 3623, 2660.4766, -2429.2969, 17.0703, 0.25);
	RemoveBuildingForPlayer(playerid, 1307, 2629.2109, -2419.6875, 12.2891, 0.25);
	RemoveBuildingForPlayer(playerid, 1307, 2649.8984, -2419.6875, 12.2891, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2686.7578, -2416.6250, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2672.5938, -2408.2500, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1306, 2742.2656, -2416.5234, 19.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 3578, 2639.1953, -2392.8203, 13.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 3578, 2663.8359, -2392.8203, 13.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 2637.1719, -2385.8672, 16.4141, 0.25);
	RemoveBuildingForPlayer(playerid, 1306, 2669.9063, -2394.5078, 19.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, 2708.4063, -2391.5234, 26.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 3753, 2748.0156, -2571.5938, 3.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 3574, 2774.7969, -2534.9531, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3574, 2771.0703, -2520.5469, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3761, 2783.7813, -2501.8359, 14.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 3624, 2788.1563, -2493.9844, 16.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 3761, 2783.7813, -2486.9609, 14.6563, 0.25);
	RemoveBuildingForPlayer(playerid, 3578, 2747.0078, -2480.2422, 13.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 3761, 2783.7813, -2463.8203, 14.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, 2773.3438, -2479.9688, 26.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 3624, 2788.1563, -2455.8828, 16.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 3626, 2746.4063, -2453.4844, 14.0781, 0.25);
	RemoveBuildingForPlayer(playerid, 3761, 2783.7813, -2448.4766, 14.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, 2773.3438, -2443.1719, 26.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 3577, 2744.5703, -2436.1875, 13.3438, 0.25);
	RemoveBuildingForPlayer(playerid, 3577, 2744.5703, -2427.3203, 13.3516, 0.25);
	RemoveBuildingForPlayer(playerid, 3761, 2783.7813, -2425.3516, 14.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 3574, 2774.7969, -2386.8516, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3574, 2771.0703, -2372.4453, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3761, 2783.7813, -2410.2109, 14.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 3624, 2788.1563, -2417.7891, 16.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 3574, 2789.2109, -2377.6250, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, 2802.4297, -2556.5234, 26.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 3761, 2791.9531, -2501.8359, 14.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 3761, 2797.5156, -2486.8281, 14.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 3761, 2791.9531, -2486.9609, 14.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 3761, 2791.9531, -2463.8203, 14.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 3761, 2797.5156, -2448.3438, 14.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 3761, 2791.9531, -2448.4766, 14.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 3761, 2791.9531, -2425.3516, 14.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 3761, 2791.9531, -2410.2109, 14.6563, 0.25);
	RemoveBuildingForPlayer(playerid, 3761, 2797.5156, -2410.0781, 14.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 3626, 2795.8281, -2394.2422, 14.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 3620, 2814.2656, -2521.4922, 25.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 5157, 2838.0391, -2532.7734, 17.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 5154, 2838.1406, -2447.8438, 15.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 3724, 2838.1953, -2488.6641, 29.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 3620, 2814.2656, -2356.5703, 25.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 5155, 2838.0234, -2358.4766, 21.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 3724, 2838.1953, -2407.1406, 29.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 3753, 2702.3984, -2324.2578, 3.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, 2762.7578, -2333.3828, 26.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, 2804.2422, -2333.3828, 26.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 5158, 2837.7734, -2334.4766, 11.9922, 0.25);
	RemoveBuildingForPlayer(playerid, 4270, 2657.0781, -2711.4531, -4.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 4404, 2657.0781, -2711.4531, -4.0000, 0.25);

    //SN
    RemoveBuildingForPlayer(playerid, 1689, 745.5859, -1381.1094, 25.8750, 0.25);
	RemoveBuildingForPlayer(playerid, 1689, 751.3359, -1368.0313, 25.8750, 0.25);
	RemoveBuildingForPlayer(playerid, 6516, 717.6875, -1357.2813, 18.0469, 0.25);
	RemoveBuildingForPlayer(playerid, 1415, 732.8516, -1332.8984, 12.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 1439, 732.7266, -1341.7734, 12.6328, 0.25);

    LoadingHide(playerid);
	return 1;
}

Stare_Obiekty()
{	
    //Budka AJ
    CreateDynamicObject(16327, 1481.20129, -1790.30566, 145.71234,   0.00000, 0.00000, 90.00000);
    //Bank LS
    CreateDynamicObject(13007,1455.47470000,-1002.07030000,27.89160000,0.00000000,0.00000000,180.00000000, 2); //nowy bank
	CreateDynamicObject(2946,1461.00660000,-1010.22960000,26.10250000,0.00000000,0.00000000,270.00000000, 2); //
	CreateDynamicObject(2946,1464.07520000,-1010.21580000,26.10250000,0.00000000,0.00000000,90.00000000, 2); //
	CreateDynamicObject(14576,1460.66560000,-995.54880000,21.62610000,0.00000000,0.00000000,270.00000000, 2); //
	CreateDynamicObject(3029,1445.92880000,-1000.56120000,21.83600000,0.00000000,0.00000000,0.00000000, 2); //
	CreateDynamicObject(2957,1443.58240000,-1001.27120000,23.15570000,0.00000000,0.00000000,0.00000000, 2); //
	CreateDynamicObject(1550,1478.84400000,-994.29050000,13.83770000,0.00000000,0.00000000,0.00000000, 2); //
	//obiekty kasyna F poczatek
	CreateDynamicObject(1550,1143.18920000,11.76900000,1000.07310000,0.00000000,0.00000000,0.00000000,-1,3); //
	CreateDynamicObject(8394,1022.57460000,-1121.07040000,36.95560000,0.00000000,0.00000000,0.00000000,-1,3); //
	CreateDynamicObject(13562,1022.79140000,-1121.47620000,52.04930000,0.00000000,0.00000000,0.00000000,-1,3); //
	CreateDynamicObject(6965,1010.19430000,-1127.36520000,21.46050000,0.00000000,0.00000000,0.00000000,-1,3); //
	CreateDynamicObject(6965,1033.25920000,-1127.46460000,21.50370000,0.00000000,0.00000000,0.00000000,-1,3); //
	CreateDynamicObject(2780,1016.24040000,-1122.48250000,25.17850000,0.00000000,0.00000000,0.00000000,-1,3); //
	CreateDynamicObject(2780,1028.63610000,-1122.48250000,25.13440000,0.00000000,0.00000000,0.00000000,-1,3); //
	CreateDynamicObject(2780,1003.29410000,-1116.80700000,26.48940000,0.00000000,0.00000000,0.00000000,-1,3); //
	CreateDynamicObject(2780,1042.35550000,-1117.28060000,25.91620000,0.00000000,0.00000000,0.00000000,-1,3); //
	CreateDynamicObject(18553,2549.45650000,-1290.49820000,1061.92910000,90.00000000,0.00000000,90.00000000,-1,3); //

	//obiekty dom Saula(mÛj)
	CreateDynamicObject(10444,714.69720459,-1052.42102051,45.46129608,0.00000000,0.00000000,330.09008789,0,0); //object(poolwater_sfs) (1)
	CreateDynamicObject(1646,723.42962646,-1041.49548340,46.01116943,0.00000000,0.00000000,314.12011719,0,0); //object(lounge_towel_up) (1)
	CreateDynamicObject(1255,716.92156982,-1064.18481445,46.24763489,0.00000000,0.00000000,111.65499878,0,0); //object(lounger) (1)
	CreateDynamicObject(1255,719.94726562,-1039.24084473,46.12262726,0.00000000,0.00000000,251.23382568,0,0); //object(lounger) (2)
	CreateDynamicObject(1255,717.99969482,-1038.09191895,46.12262726,0.00000000,0.00000000,245.27490234,0,0); //object(lounger) (3)
	CreateDynamicObject(1255,426.63616943,-1268.51391602,51.15483856,0.00000000,0.00000000,278.07507324,0,0); //object(lounger) (4)
	CreateDynamicObject(1255,424.78463745,-1269.15563965,51.15483856,0.00000000,0.00000000,309.83471680,0,0); //object(lounger) (5)
	CreateDynamicObject(1815,424.92044067,-1268.63024902,50.48268127,0.00000000,0.00000000,0.00000000,0,0); //object(coffee_low_2) (1)
	CreateDynamicObject(1455,425.29290771,-1268.55371094,51.05082321,0.00000000,0.00000000,280.24023438,0,0); //object(dyn_glass) (1)
	CreateDynamicObject(1486,425.45367432,-1267.93786621,51.12408447,0.00000000,0.00000000,0.00000000,0,0); //object(dyn_beer_1) (1)
	CreateDynamicObject(1664,425.14801025,-1268.17114258,51.14583588,0.00000000,0.00000000,0.00000000,0,0); //object(propwinebotl2) (1)
	CreateDynamicObject(1455,425.72451782,-1268.13330078,51.05082321,0.00000000,0.00000000,280.23925781,0,0); //object(dyn_glass) (2)
	CreateDynamicObject(1419,436.64221191,-1267.08349609,51.06263733,0.00000000,0.00000000,21.19000244,0,0); //object(dyn_f_iron_1) (1)
	CreateDynamicObject(1419,432.83767700,-1268.56896973,51.06263733,0.00000000,0.00000000,21.18713379,0,0); //object(dyn_f_iron_1) (4)
	CreateDynamicObject(1419,429.03393555,-1270.05395508,51.06263733,0.00000000,0.00000000,21.18713379,0,0); //object(dyn_f_iron_1) (5)
	CreateDynamicObject(1419,425.26156616,-1271.50561523,51.06263733,0.00000000,0.00000000,21.18713379,0,0); //object(dyn_f_iron_1) (6)
	CreateDynamicObject(1419,437.84967041,-1264.45593262,51.06263733,0.00000000,0.00000000,110.96228027,0,0); //object(dyn_f_iron_1) (7)
	//CreateDynamicObject(3409,429.45864868,-1260.13549805,44.96957779,5.95498657,0.00000000,17.86486816,0,0); //object(grassplant) (1) FBI spali≥o ;(
	//CreateDynamicObject(3409,431.13986206,-1264.63269043,43.89460373,5.95458984,0.00000000,21.83374023,0,0); //object(grassplant) (2) FBI spali≥o ;(
	CreateDynamicObject(3810,434.11508179,-1252.78820801,52.54722595,0.00000000,0.00000000,109.71505737,0,0); //object(sfx_plant04) (1)
	
	//DOM 0VERTE
	CreateDynamicObject(1255,1432.5000000,-893.5000000,50.2999992,0.0000000,0.0000000,250.0000000,0,0); //object(lounger) (1)
	CreateDynamicObject(1255,1430.6999512,-893.5000000,50.2999992,0.0000000,0.0000000,289.9993896,0,0); //object(lounger) (2)
	CreateDynamicObject(2725,1431.5999756,-893.0999756,50.0999985,0.0000000,0.0000000,0.0000000,0,0); //object(lm_striptable) (1)
	CreateDynamicObject(1670,1431.5999756,-893.0999756,50.5000000,0.0000000,0.0000000,0.0000000,0,0); //object(propcollecttable) (1)
	CreateDynamicObject(1419,1425.3000488,-908.4000244,50.2999992,0.0000000,0.0000000,0.0000000,0,0); //object(dyn_f_iron_1) (1)
	CreateDynamicObject(1419,1421.1999512,-908.4000244,50.2999992,0.0000000,0.0000000,0.0000000,0,0); //object(dyn_f_iron_1) (2)
	CreateDynamicObject(1419,1419.1999512,-906.2999878,50.2999992,0.0000000,0.0000000,270.0000000,0,0); //object(dyn_f_iron_1) (3)
	CreateDynamicObject(3260,1428.5000000,-907.2999878,49.7000008,270.0000000,0.0000000,0.0000000,0,0); //object(oldwoodpanel) (1)
	CreateDynamicObject(3260,1428.5000000,-904.2999878,49.7000008,270.0000000,0.0000000,0.0000000,0,0); //object(oldwoodpanel) (5)
	CreateDynamicObject(3260,1428.5000000,-901.2999878,49.7000008,270.0000000,0.0000000,0.0000000,0,0); //object(oldwoodpanel) (6)
	CreateDynamicObject(3260,1428.5000000,-898.2999878,49.7000008,270.0000000,0.0000000,0.0000000,0,0); //object(oldwoodpanel) (7)
	CreateDynamicObject(3260,1428.5000000,-907.2999878,46.4000015,270.0000000,0.0000000,0.0000000,0,0); //object(oldwoodpanel) (9)
	CreateDynamicObject(3260,1428.5000000,-904.2999878,46.4000015,270.0000000,0.0000000,0.0000000,0,0); //object(oldwoodpanel) (10)
	CreateDynamicObject(3260,1428.5000000,-901.2999878,46.4000015,270.0000000,0.0000000,0.0000000,0,0); //object(oldwoodpanel) (11)
	CreateDynamicObject(1419,1425.3000488,-908.4000244,47.0000000,0.0000000,0.0000000,0.0000000,0,0); //object(dyn_f_iron_1) (4)
	CreateDynamicObject(1419,1421.1999512,-908.4000244,47.0000000,0.0000000,0.0000000,0.0000000,0,0); //object(dyn_f_iron_1) (5)
	CreateDynamicObject(1481,1433.1999512,-890.2000122,54.2000008,0.0000000,0.0000000,230.0000000,0,0); //object(dyn_bar_b_q) (1)
	CreateDynamicObject(800,1444.6999512,-893.2000122,52.7000008,0.0000000,0.0000000,0.0000000,0,0); //object(genveg_bush07) (1)
	CreateDynamicObject(1807,1434.5999756,-887.4000244,50.2000008,0.0000000,0.0000000,0.0000000,0,0); //object(cj_mediumpots1) (1)
	CreateDynamicObject(2244,1419.8000488,-908.0999756,50.0000000,0.0000000,0.0000000,0.0000000,0,0); //object(plant_pot_9) (1)
	CreateDynamicObject(2244,1423.5999756,-908.0000000,50.0000000,0.0000000,0.0000000,0.0000000,0,0); //object(plant_pot_9) (2)
	CreateDynamicObject(2244,1427.5999756,-908.0999756,50.0000000,0.0000000,0.0000000,0.0000000,0,0); //object(plant_pot_9) (3)
	CreateDynamicObject(1419,1429.4000244,-898.2999878,50.2000008,0.0000000,0.0000000,270.0000000,0,0); //object(dyn_f_iron_1) (9)
	CreateDynamicObject(1419,1429.4000244,-902.4000244,50.2000008,0.0000000,0.0000000,270.0000000,0,0); //object(dyn_f_iron_1) (10)
	CreateDynamicObject(1419,1429.4000244,-906.0999756,50.2000008,0.0000000,0.0000000,270.0000000,0,0); //object(dyn_f_iron_1) (11)
	CreateDynamicObject(2345,1433.1999512,-886.2000122,53.0999985,0.0000000,0.0000000,180.0000000,0,0); //object(plant_pot_23) (1)
	CreateDynamicObject(8572,1435.0999756,-889.2000122,51.9000015,0.0000000,0.0000000,90.0000000,0,0); //object(vgssstairs02_lvs) (1)
	CreateDynamicObject(2345,1430.9000244,-886.2000122,53.0999985,0.0000000,0.0000000,179.9945068,0,0); //object(plant_pot_23) (2)
	CreateDynamicObject(2345,1429.1999512,-886.2000122,53.0999985,0.0000000,0.0000000,179.9945068,0,0); //object(plant_pot_23) (3)
	CreateDynamicObject(1408,1419.3000488,-884.0000000,49.9000015,1.9951172,4.0024414,89.8604431,0,0); //object(dyn_f_wood_2) (1)
	CreateDynamicObject(2195,1423.4000244,-885.9000244,50.2999992,0.0000000,0.0000000,0.0000000,0,0); //object(plant_pot_3) (1)
	CreateDynamicObject(1328,1420.6999512,-876.5999756,48.7999992,0.0000000,354.0000000,8.0000000,0,0); //object(binnt10_la) (1)
	CreateDynamicObject(3407,1421.5000000,-876.5000000,48.2000008,0.0000000,0.0000000,160.0000000,0,0); //object(ce_mailbox1) (1)
	CreateDynamicObject(3031,1423.0999756,-893.2000122,56.9000015,0.0000000,0.0000000,208.0000000,0,0); //object(wong_dish) (1)
	CreateDynamicObject(14724,1431.0999756,-890.2999878,51.7000008,0.0000000,0.0000000,91.5000000,0,0); //object(int2hoose09_bits4) (1)
	CreateDynamicObject(14726,1431.0999756,-890.2000122,51.7000008,0.0000000,0.0000000,90.0000000,0,0); //object(int2lamid01_rail3) (1)
	CreateDynamicObject(14726,1431.4000244,-885.5000000,51.5999985,0.0000000,0.0000000,90.0000000,0,0); //object(int2lamid01_rail3) (2)
	CreateDynamicObject(14726,1431.1999512,-887.7999878,51.5999985,0.0000000,0.0000000,270.0000000,0,0); //object(int2lamid01_rail3) (3)
	CreateDynamicObject(1482,1430.6999512,-888.2999878,52.0000000,0.0000000,0.0000000,90.0000000,0,0); //object(dyn_garrage1) (2)
	CreateDynamicObject(1482,1430.6999512,-889.7000122,52.0000000,0.0000000,0.0000000,90.0000000,0,0); //object(dyn_garrage1) (3)
	CreateDynamicObject(1825,1430.1999512,-889.5000000,53.4000015,0.0000000,0.0000000,0.0000000,0,0); //object(kb_table_chairs1) (1)
	CreateDynamicObject(2253,1433.5000000,-887.0999756,53.7000008,0.0000000,0.0000000,0.0000000,0,0); //object(plant_pot_22) (1)
	CreateDynamicObject(2253,1431.6999512,-887.0999756,53.7000008,0.0000000,0.0000000,0.0000000,0,0); //object(plant_pot_22) (2)
	CreateDynamicObject(2253,1429.0999756,-887.2000122,53.7000008,0.0000000,0.0000000,0.0000000,0,0); //object(plant_pot_22) (3)
	CreateDynamicObject(1408,1441.5999756,-892.7999878,50.0999985,1.9988708,359.9965820,269.9967041,0,0); //object(dyn_f_wood_2) (3)
	CreateDynamicObject(1408,1441.6999512,-887.4000244,50.0999985,1.9940186,359.9945068,269.9945068,0,0); //object(dyn_f_wood_2) (4)
	CreateDynamicObject(2011,1440.9000244,-894.7000122,49.5000000,358.0000000,0.0000000,0.0000000,0,0); //object(nu_plant2_ofc) (1)
	CreateDynamicObject(2614,1423.5000000,-886.4000244,53.7000008,0.0000000,0.0000000,180.0000000,0,0); //object(cj_us_flag) (1)
	
	//nowoczesny dom (interior) by abram01
	new home = CreateDynamicObject(15031, 1542.79736, -1145.87012, 135.10669,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(home, 7, 15041, "bigsfsave", "ah_wpaper7", 0);
	SetDynamicObjectMaterial(home, 4, 15041, "bigsfsave", "AH_wdpanscum", 0);
	SetDynamicObjectMaterial(home, 3, 15041, "bigsfsave", "mp_carter_tilewall", 0);
	SetDynamicObjectMaterial(home, 2, 15041, "bigsfsave", "AH_strntiles", 0);
	CreateDynamicObject(15042, 1542.65564, -1134.47632, 136.80769,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2575, 1539.35010, -1145.96167, 135.48489,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2136, 1546.18591, -1144.02844, 135.10381,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2139, 1548.18213, -1144.04846, 135.10381,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2305, 1549.18323, -1144.03223, 135.10381,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2137, 1549.17981, -1144.98267, 135.10381,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2140, 1549.16711, -1145.95764, 135.10381,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1726, 1549.00098, -1148.86548, 135.10580,   0.00000, 1.42800, 221.74500);
	CreateDynamicObject(1827, 1547.12292, -1148.27185, 135.01379,   0.00000, 1.42800, 221.74500);
	CreateDynamicObject(2297, 1544.29114, -1146.60645, 135.10080,   0.00000, 0.00000, 45.02500);
	CreateDynamicObject(2165, 1542.28967, -1147.43665, 135.10608,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1714, 1543.01465, -1148.74292, 135.10519,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2167, 1551.81543, -1147.45459, 135.07610,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2167, 1551.82080, -1148.38037, 135.07610,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2167, 1551.82080, -1149.30444, 135.07610,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2163, 1543.77283, -1145.45789, 135.07610,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2527, 1540.98999, -1148.41797, 135.16051,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2525, 1539.67920, -1149.86572, 135.09450,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2524, 1539.38293, -1147.44373, 135.09450,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(14684, 1538.24500, -1145.20679, 137.16789,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2011, 1549.08350, -1150.20728, 135.10616,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2010, 1539.46375, -1146.53601, 135.10620,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2253, 1547.10486, -1148.27893, 135.73689,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19173, 1543.41138, -1150.68286, 136.97749,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19174, 1541.44702, -1146.72192, 136.95551,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2828, 1543.56995, -1145.38989, 136.00011,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2824, 1543.53491, -1146.30042, 136.00011,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2822, 1549.15686, -1143.75195, 136.13210,   0.00000, 0.00000, 47.00000);
	CreateDynamicObject(2855, 1550.24475, -1149.45630, 135.12010,   0.00000, 0.00000, 47.00000);
	CreateDynamicObject(2855, 1549.89441, -1149.16455, 135.12010,   0.00000, 0.00000, 47.00000);
	CreateDynamicObject(2854, 1550.89197, -1149.53198, 135.12010,   0.00000, 0.00000, 47.00000);
	CreateDynamicObject(2865, 1549.20642, -1144.94421, 136.17610,   0.00000, 0.00000, 120.00000);
	CreateDynamicObject(2270, 1539.70679, -1145.92493, 136.89461,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2270, 1539.70679, -1144.12085, 136.89461,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2271, 1539.70679, -1145.02295, 136.89461,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2266, 1542.93274, -1147.44556, 136.74651,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2946, 1546.59583, -1152.14026, 135.09351,   0.00000, 0.00000, 90.00000);
    SetDynamicObjectMaterial(CreateDynamicObject(1492, 1541.71008, -1148.96045, 135.09180,   0.00000, 0.00000, 270.00000), 1, 19301, "mp_policesf", "mp_cop_panel", 0);
    SetDynamicObjectMaterial(CreateDynamicObject(1492, 1543.88794, -1143.28198, 134.91580,   0.00000, 0.00000, 270.00000), 1, 19301, "mp_policesf", "mp_cop_panel", 0);
    SetDynamicObjectMaterial(CreateDynamicObject(1492, 1549.55786, -1146.94031, 135.11380,   0.00000, 0.00000, 270.00000), 1, 19301, "mp_policesf", "mp_cop_panel", 0);

	//obiekty domu z konkursu by Sejciak
	CreateDynamicObject(9829, 279.67, -1945.67, -64.42,   0.00, 0.00, 92.00,0,0);
	CreateDynamicObject(11490, 270.91, -1923.17, 0.86,   0.00, 0.00, 182.00,0,0);
	CreateDynamicObject(11491, 270.57, -1912.15, 2.32,   0.12, -0.04, 181.78,0,0);
	CreateDynamicObject(11665, 273.75, -1919.22, 3.04,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1231, 285.74, -1893.61, 3.57,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1231, 277.25, -1910.25, 3.57,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(6965, 242.62, -1938.79, 4.53,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1231, 238.99, -1948.31, 3.57,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1231, 253.09, -1938.60, 3.57,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1231, 238.18, -1929.47, 3.57,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1231, 232.11, -1939.25, 3.57,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1231, 249.37, -1930.57, 3.57,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1231, 249.54, -1946.66, 3.57,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1723, 266.53, -1914.39, 2.33,   0.00, 0.00, 92.00,0,0);
	CreateDynamicObject(16151, 267.17, -1921.88, 2.68,   0.00, 0.00, 180.00,0,0);
	CreateDynamicObject(3525, 270.15, -1915.60, 1.78,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(3525, 270.93, -1915.53, 1.79,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(3604, 300.80, -1925.24, 3.43,   0.00, 0.00, 182.00,0,0);
	CreateDynamicObject(16094, 284.41, 1448.36, 9.55,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(9152, 241.89, -1937.61, 1.88,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(3509, 324.79, -1888.15, 0.92,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(0, 227.13, -1866.17, 1.72,   0.00, 0.00, 90.00,0,0);
	CreateDynamicObject(8650, 307.98, -1878.22, 1.84,   0.00, 0.00, 90.00,0,0);
	CreateDynamicObject(8650, 323.16, -1893.09, 1.82,   0.00, 1.00, 2.00,0,0);
	CreateDynamicObject(8556, 271.73, -1884.76, 5.18,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(8650, 298.97, -1878.25, 1.84,   0.00, 0.00, 90.00,0,0);
	CreateDynamicObject(2614, 271.77, -1876.51, 6.49,   0.00, 0.00, 179.00,0,0);
	CreateDynamicObject(1828, 271.70, -1922.25, 2.34,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(0, 266.54, -1927.05, 2.36,   0.00, 0.00, 127.00,0,0);
	CreateDynamicObject(2229, 275.16, -1927.26, 2.36,   0.00, 0.00, 221.00,0,0);
	CreateDynamicObject(2628, 274.63, -1925.88, 2.36,   0.00, 0.00, -87.00,0,0);
	CreateDynamicObject(748, 243.83, -1934.95, 0.83,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(14651, 270.81, -1921.96, 4.46,   0.00, 0.00, 181.00,0,0);
	CreateDynamicObject(11495, 247.32, -1972.48, -0.01,   0.00, 0.00, 93.00,0,0);
	CreateDynamicObject(11326, 291.06, -1951.66, 3.19,   0.00, 0.00, 4.00,0,0);
	CreateDynamicObject(11393, 310.90, -1948.22, 2.43,   0.00, 0.00, -87.00,0,0);
	CreateDynamicObject(14826, 320.05, -1927.87, 1.58,   0.00, 0.00, -36.00,0,0);
	CreateDynamicObject(9829, 279.67, -1945.67, -64.42,   0.00, 0.00, 92.00,0,0);
	CreateDynamicObject(11490, 270.91, -1923.17, 0.86,   0.00, 0.00, 182.00,0,0);
	CreateDynamicObject(11491, 270.57, -1912.15, 2.32,   0.12, -0.04, 181.78,0,0);
	CreateDynamicObject(11665, 273.75, -1919.22, 3.04,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1231, 257.76, -1893.09, 3.57,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1231, 277.25, -1910.25, 3.57,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1723, 266.53, -1914.39, 2.33,   0.00, 0.00, 92.00,0,0);
	CreateDynamicObject(16151, 267.17, -1921.88, 2.68,   0.00, 0.00, 180.00,0,0);
	CreateDynamicObject(3525, 270.15, -1915.60, 1.78,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(3525, 270.93, -1915.53, 1.79,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(3604, 236.58, -1902.18, 3.43,   0.00, 0.00, 93.00,0,0);
	CreateDynamicObject(16094, 284.41, 1448.36, 9.55,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(3509, 324.79, -1888.15, 0.92,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(8650, 243.65, -1878.15, 1.72,   0.00, 0.00, 90.00,0,0);
	CreateDynamicObject(8650, 307.98, -1878.22, 1.84,   0.00, 0.00, 90.00,0,0);
	CreateDynamicObject(8650, 323.16, -1893.09, 1.82,   0.00, 1.00, 2.00,0,0);
	CreateDynamicObject(8650, 298.97, -1878.25, 1.84,   0.00, 0.00, 90.00,0,0);
	CreateDynamicObject(2614, 271.77, -1876.51, 6.49,   0.00, 0.00, 179.00,0,0);
	CreateDynamicObject(1828, 271.70, -1922.25, 2.34,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(0, 266.54, -1927.05, 2.36,   0.00, 0.00, 127.00,0,0);
	CreateDynamicObject(2229, 275.16, -1927.26, 2.36,   0.00, 0.00, 221.00,0,0);
	CreateDynamicObject(11495, 247.32, -1972.48, -0.01,   0.00, 0.00, 93.00,0,0);
	CreateDynamicObject(11326, 291.06, -1951.66, 3.19,   0.00, 0.00, 4.00,0,0);
	CreateDynamicObject(11393, 310.90, -1948.22, 2.43,   0.00, 0.00, -87.00,0,0);
	CreateDynamicObject(8650, 229.35, -1893.76, 1.74,   0.00, 0.00, 2.00,0,0);
	CreateDynamicObject(9241, 276.02, -2010.12, 1.67,   0.00, 0.00, -88.00,0,0);
	CreateDynamicObject(3666, 263.26, -1998.52, 2.96,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(3666, 287.76, -1997.30, 2.98,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(3666, 288.53, -2022.26, 2.97,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(3666, 264.73, -2023.11, 2.86,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(11495, 247.42, -1974.27, -0.02,   0.00, 0.00, -87.00,0,0);
	CreateDynamicObject(1723, 271.75, -1910.99, 2.32,   0.00, 0.00, 2.00,0,0);
	CreateDynamicObject(1822, 272.60, -1913.27, 2.32,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1704, 274.96, -1913.86, 2.32,   0.00, 0.00, -142.00,0,0);
	CreateDynamicObject(1704, 270.83, -1913.11, 2.30,   0.00, 0.00, 87.00,0,0);
	CreateDynamicObject(1670, 273.05, -1912.66, 2.79,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(0, 259.72, -1884.33, 1.51,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(984, 283.41, -1885.35, 1.51,   2.00, 0.00, 0.00,0,0);
	CreateDynamicObject(984, 259.82, -1885.38, 1.41,   -1.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1419, 309.97, -1920.08, 1.40,   0.00, 0.00, -180.00,0,0);
	CreateDynamicObject(1419, 315.75, -1920.07, 1.40,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1419, 319.80, -1920.07, 1.40,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1419, 321.48, -1920.06, 1.40,   0.00, 0.00, -180.00,0,0);
	CreateDynamicObject(830, 319.36, -1881.14, 1.89,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(620, 319.82, -1883.82, -11.34,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(712, 312.42, -1882.22, 9.81,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(716, 249.32, -1952.00, 0.80,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(3505, 239.37, -1920.04, 0.62,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(740, 225.70, -1878.74, -46.41,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(640, 249.94, -1924.16, 1.52,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(810, 302.32, -1883.39, 1.08,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(869, 305.21, -1881.74, 1.63,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(869, 300.23, -1880.48, 1.66,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(869, 298.29, -1883.42, 1.50,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(869, 294.37, -1881.22, 1.55,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(831, 290.94, -1883.13, 1.85,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1364, 284.79, -1919.23, 1.63,   0.00, 0.00, -178.00,0,0);
	CreateDynamicObject(2245, 278.05, -1910.58, 1.05,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(2250, 266.84, -1925.21, 3.61,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(3532, 309.55, -1883.04, 1.56,   0.00, 0.00, 36.00,0,0);
	CreateDynamicObject(1361, 264.37, -1910.20, 1.61,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(758, 305.19, -1884.00, 1.03,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1463, 283.45, -1928.17, 1.21,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1463, 285.66, -1928.17, 1.18,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1481, 276.27, -1911.24, 2.97,   0.00, 0.00, -48.00,0,0);
	CreateDynamicObject(1231, 265.22, -1909.06, 3.54,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1231, 269.69, -1969.65, 3.54,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1231, 270.10, -1979.75, 3.54,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1231, 270.36, -1989.55, 3.54,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1231, 269.35, -1959.60, 3.54,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1231, 255.20, -1956.85, 3.54,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1231, 286.53, -1955.65, 3.54,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1231, 259.63, -1928.34, 3.54,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1231, 281.89, -1927.74, 3.54,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1231, 308.05, -1919.64, 3.54,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1231, 293.28, -1920.01, 3.54,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(1419, 291.13, -1920.92, 1.44,   0.00, 0.00, 0.00,0,0);

	//obiekty DMV (wystrÛj zewnÍtrzny)
	CreateDynamicObject(970,1476.31958008,-1719.46972656,13.34835243,0.00000000,0.00000000,0.00000000,0,0); //object(fencesmallb) (10)
	CreateDynamicObject(970,1481.92138672,-1719.46972656,13.34835243,0.00000000,0.00000000,0.00000000,0,0); //object(fencesmallb) (11)
	CreateDynamicObject(970,1487.39587402,-1719.46972656,13.44835091,0.00000000,0.00000000,0.00000000,0,0); //object(fencesmallb) (12)
	CreateDynamicObject(970,1487.59863281,-1722.47167969,13.09835625,0.00000000,0.00000000,124.99694824,0,0); //object(fencesmallb) (23)
	CreateDynamicObject(1364,1502.99597168,-1740.79809570,13.33099651,0.00000000,0.00000000,179.99450684,0,0); //object(cj_bush_prop) (1)
	CreateDynamicObject(1361,1499.93701172,-1738.57861328,13.29021835,0.00000000,0.00000000,0.00000000,0,0); //object(cj_bush_prop2) (1)
	CreateDynamicObject(1361,1505.69555664,-1738.58679199,13.29021835,0.00000000,0.00000000,0.00000000,0,0); //object(cj_bush_prop2) (2)
	CreateDynamicObject(1360,1492.89062500,-1738.48339844,13.31889629,0.00000000,0.00000000,90.00000000,0,0); //object(cj_bush_prop3) (1)
	CreateDynamicObject(1360,1485.40722656,-1738.31152344,13.31889629,0.00000000,0.00000000,90.00000000,0,0); //object(cj_bush_prop3) (3)
	CreateDynamicObject(1360,1478.47656250,-1738.41406250,13.31889629,0.00000000,0.00000000,90.00000000,0,0); //object(cj_bush_prop3) (4)
	CreateDynamicObject(1360,1471.15478516,-1738.42089844,13.31889629,0.00000000,0.00000000,90.00000000,0,0); //object(cj_bush_prop3) (5)
	CreateDynamicObject(1364,1460.31127930,-1740.78637695,13.33099651,0.00000000,0.00000000,179.99450684,0,0); //object(cj_bush_prop) (2)
	CreateDynamicObject(1361,1463.28808594,-1738.25244141,13.29021835,0.00000000,0.00000000,0.00000000,0,0); //object(cj_bush_prop2) (3)
	CreateDynamicObject(1361,1457.18481445,-1738.32336426,13.29021835,0.00000000,0.00000000,0.00000000,0,0); //object(cj_bush_prop2) (4)
	CreateDynamicObject(1364,1481.87988281,-1740.92675781,13.33099651,0.00000000,0.00000000,179.99450684,0,0); //object(cj_bush_prop) (1)
	CreateDynamicObject(1364,1489.26721191,-1740.85839844,13.33099651,0.00000000,0.00000000,179.99450684,0,0); //object(cj_bush_prop) (1)
	CreateDynamicObject(1364,1474.76379395,-1740.83984375,13.33099651,0.00000000,0.00000000,179.99450684,0,0); //object(cj_bush_prop) (1)
	CreateDynamicObject(1360,1466.97851562,-1738.46484375,13.31889629,0.00000000,0.00000000,90.00000000,0,0); //object(cj_bush_prop3) (5)
	CreateDynamicObject(1360,1496.88867188,-1738.36523438,13.31889629,0.00000000,0.00000000,90.00000000,0,0); //object(cj_bush_prop3) (1)
	CreateDynamicObject(970,1453.07812500,-1737.85229492,13.09835625,0.00000000,0.00000000,0.67541504,0,0); //object(fencesmallb) (17)
	CreateDynamicObject(970,1447.25646973,-1737.94824219,13.09835625,0.00000000,0.00000000,0.94058228,0,0); //object(fencesmallb) (17)
	CreateDynamicObject(970,1448.58911133,-1744.25927734,13.57334900,0.00000000,0.00000000,0.80029297,0,0); //object(fencesmallb) (17)
	CreateDynamicObject(970,1450.64233398,-1746.28063965,13.57334900,0.00000000,0.00000000,271.11169434,0,0); //object(fencesmallb) (17)
	CreateDynamicObject(970,1450.65783691,-1750.35339355,13.57334900,0.00000000,0.00000000,271.10961914,0,0); //object(fencesmallb) (17)
	CreateDynamicObject(970,1448.63806152,-1752.43542480,13.57334900,0.00000000,0.00000000,0.79650879,0,0); //object(fencesmallb) (17)
	CreateDynamicObject(970,1444.56433105,-1752.48303223,13.57334900,0.00000000,0.00000000,0.79650879,0,0); //object(fencesmallb) (17)
	CreateDynamicObject(970,1444.41357422,-1744.30969238,13.57334900,0.00000000,0.00000000,0.79650879,0,0); //object(fencesmallb) (17)
	CreateDynamicObject(970,1442.55480957,-1754.59045410,13.12334442,0.00000000,0.00000000,90.48147583,0,0); //object(fencesmallb) (17)
	CreateDynamicObject(8548,1445.19079590,-1738.96765137,12.39012814,178.65002441,0.00000000,0.00000000,0,0); //object(trainsign01_lvs) (1)
	CreateDynamicObject(8548,1445.19079590,-1740.31445312,12.39012814,178.64868164,0.00000000,0.00000000,0,0); //object(trainsign01_lvs) (2)
	CreateDynamicObject(8548,1445.19079590,-1741.56530762,12.39012814,178.64868164,0.00000000,0.00000000,0,0); //object(trainsign01_lvs) (3)
	CreateDynamicObject(8548,1445.19079590,-1742.64050293,12.39012814,178.64868164,0.00000000,0.00000000,0,0); //object(trainsign01_lvs) (4)
	CreateDynamicObject(8548,1445.19079590,-1743.63916016,12.39012814,178.64868164,0.00000000,0.00000000,0,0); //object(trainsign01_lvs) (5)
	CreateDynamicObject(970,1509.46228027,-1738.05615234,13.09835625,0.00000000,0.00000000,0.22485352,0,0); //object(fencesmallb) (26)
	CreateDynamicObject(970,1513.20434570,-1744.25793457,13.49835014,0.00000000,0.00000000,0.21972656,0,0); //object(fencesmallb) (26)
	CreateDynamicObject(970,1511.08032227,-1746.37207031,13.49835014,0.00000000,0.00000000,270.48986816,0,0); //object(fencesmallb) (26)
	CreateDynamicObject(970,1511.15393066,-1750.46154785,13.49835014,0.00000000,0.00000000,270.48889160,0,0); //object(fencesmallb) (26)
	CreateDynamicObject(970,1511.12365723,-1754.53771973,13.07334518,0.00000000,0.00000000,89.13424683,0,0); //object(fencesmallb) (26)
	CreateDynamicObject(8548,1510.95849609,-1743.28845215,12.39012814,178.64868164,0.00000000,0.00000000,0,0); //object(trainsign01_lvs) (6)
	CreateDynamicObject(8548,1510.95849609,-1742.30285645,12.39012814,178.64868164,0.00000000,0.00000000,0,0); //object(trainsign01_lvs) (7)
	CreateDynamicObject(8548,1510.95800781,-1741.17968750,12.39012814,178.64868164,0.00000000,0.00000000,0,0); //object(trainsign01_lvs) (8)
	CreateDynamicObject(8548,1510.95849609,-1740.12841797,12.39012814,178.64868164,0.00000000,0.00000000,0,0); //object(trainsign01_lvs) (9)
	CreateDynamicObject(8548,1510.95849609,-1739.07031250,12.39012814,178.64868164,0.00000000,0.00000000,0,0); //object(trainsign01_lvs) (10)
	CreateDynamicObject(970,1493.03283691,-1719.16455078,13.44835091,0.00000000,0.00000000,0.00000000,0,0); //object(fencesmallb) (12)
	CreateDynamicObject(970,1497.37158203,-1719.14978027,13.44835091,0.00000000,0.00000000,0.00000000,0,0); //object(fencesmallb) (12)
	CreateDynamicObject(970,1483.20361328,-1722.64367676,13.09835625,0.00000000,0.00000000,124.99697876,0,0); //object(fencesmallb) (23)
	CreateDynamicObject(970,1478.23999023,-1722.64929199,13.09835625,0.00000000,0.00000000,124.99697876,0,0); //object(fencesmallb) (23)
	CreateDynamicObject(970,1473.91284180,-1722.62475586,13.09835625,0.00000000,0.00000000,124.99697876,0,0); //object(fencesmallb) (23)
	CreateDynamicObject(970,1470.64685059,-1719.46972656,13.37335205,0.00000000,0.00000000,0.00000000,0,0); //object(fencesmallb) (8)
	CreateDynamicObject(970,1460.42663574,-1719.46972656,13.37335205,0.00000000,0.00000000,0.00000000,0,0); //object(fencesmallb) (8)
	CreateDynamicObject(970,1454.43701172,-1719.46972656,13.37335205,0.00000000,0.00000000,0.00000000,0,0); //object(fencesmallb) (8)
	CreateDynamicObject(970,1448.38220215,-1719.46972656,13.37335205,0.00000000,0.00000000,0.00000000,0,0); //object(fencesmallb) (8)
	CreateDynamicObject(970,1469.40515137,-1722.69909668,13.09835625,0.00000000,0.00000000,124.99694824,0,0); //object(fencesmallb) (23)
	CreateDynamicObject(970,1462.48608398,-1722.50988770,13.09835625,0.00000000,0.00000000,235.00299072,0,0); //object(fencesmallb) (23)
	CreateDynamicObject(970,1501.65258789,-1719.15527344,13.44835091,0.00000000,0.00000000,0.00000000,0,0); //object(fencesmallb) (12)
	CreateDynamicObject(970,1506.48925781,-1719.46972656,13.44835091,0.00000000,0.00000000,0.00000000,0,0); //object(fencesmallb) (12)
	CreateDynamicObject(970,1511.21386719,-1719.46972656,13.44835091,0.00000000,0.00000000,0.00000000,0,0); //object(fencesmallb) (12)
	CreateDynamicObject(970,1515.79003906,-1719.46972656,13.44835091,0.00000000,0.00000000,0.00000000,0,0); //object(fencesmallb) (12)
	CreateDynamicObject(970,1505.14758301,-1722.55664062,13.09835625,0.00000000,0.00000000,124.99697876,0,0); //object(fencesmallb) (26)
	CreateDynamicObject(970,1510.07971191,-1722.57641602,13.09835625,0.00000000,0.00000000,124.99694824,0,0); //object(fencesmallb) (26)
	CreateDynamicObject(970,1514.80590820,-1722.58605957,13.09835625,0.00000000,0.00000000,124.99694824,0,0); //object(fencesmallb) (26)
	CreateDynamicObject(970,1519.17150879,-1722.44165039,13.09835625,0.00000000,0.00000000,124.99694824,0,0); //object(fencesmallb) (26)
	CreateDynamicObject(970,1457.68212891,-1722.43164062,13.09835625,0.00000000,0.00000000,234.99755859,0,0); //object(fencesmallb) (23)
	CreateDynamicObject(970,1452.88452148,-1722.50561523,13.09835625,0.00000000,0.00000000,234.99755859,0,0); //object(fencesmallb) (23)
	CreateDynamicObject(970,1448.00305176,-1722.44201660,13.09835625,0.00000000,0.00000000,234.99755859,0,0); //object(fencesmallb) (23)
	CreateDynamicObject(970,1443.44519043,-1722.41931152,13.09835625,0.00000000,0.00000000,234.99755859,0,0); //object(fencesmallb) (23)
	CreateDynamicObject(970,1438.55395508,-1722.36669922,13.09835625,0.00000000,0.00000000,234.99755859,0,0); //object(fencesmallb) (23)
	CreateDynamicObject(970,1442.40625000,-1719.68652344,13.32335281,0.00000000,0.00000000,0.00000000,0,0); //object(fencesmallb) (8)
	CreateDynamicObject(1364,1465.73889160,-1721.05310059,13.25599766,0.00000000,0.00000000,359.45422363,0,0); //object(cj_bush_prop) (1)
	CreateDynamicObject(1361,1462.50317383,-1726.44067383,13.29021835,0.00000000,0.00000000,0.00000000,0,0); //object(cj_bush_prop2) (7)
	CreateDynamicObject(1361,1469.25292969,-1726.34472656,13.29021835,0.00000000,0.00000000,0.00000000,0,0); //object(cj_bush_prop2) (8)
	CreateDynamicObject(1361,1465.75292969,-1726.39355469,13.29021835,0.00000000,0.00000000,0.00000000,0,0); //object(cj_bush_prop2) (9)
	CreateDynamicObject(3810,1489.49255371,-1750.09204102,20.12534904,0.00000000,0.00000000,89.73004150,0,0); //object(sfx_plant04) (1)
	CreateDynamicObject(3810,1478.49206543,-1750.04699707,20.12534904,0.00000000,0.00000000,89.72534180,0,0); //object(sfx_plant04) (2)
	CreateDynamicObject(3802,1484.00646973,-1750.15356445,20.12534904,0.00000000,0.00000000,85.66986084,0,0); //object(sfx_plant03) (1)
	CreateDynamicObject(3802,1473.09960938,-1750.07763672,20.12534904,0.00000000,0.00000000,85.66589355,0,0); //object(sfx_plant03) (2)
	CreateDynamicObject(3851,1477.47265625,-1772.29333496,32.52981567,328.23999023,90.00000000,180.26916504,0,0); //object(carshowwin_sfsx) (5)
	CreateDynamicObject(3851,1477.43017578,-1762.41210938,33.20485687,23.82189941,90.00000000,180.26367188,0,0); //object(carshowwin_sfsx) (5)
	CreateDynamicObject(3851,1473.47741699,-1762.40759277,33.20485687,23.81835938,90.00000000,180.26367188,0,0); //object(carshowwin_sfsx) (5)
	CreateDynamicObject(3851,1469.52319336,-1762.39758301,33.20485687,23.81835938,90.00000000,180.26367188,0,0); //object(carshowwin_sfsx) (5)
	CreateDynamicObject(3851,1473.52099609,-1772.31494141,32.52981567,328.23852539,90.00000000,180.26367188,0,0); //object(carshowwin_sfsx) (5)
	CreateDynamicObject(3851,1469.54492188,-1772.32617188,32.52981567,328.23303223,90.00000000,180.26367188,0,0); //object(carshowwin_sfsx) (5)
	CreateDynamicObject(3851,1481.37939453,-1762.38720703,33.20485687,23.81835938,90.00000000,180.26367188,0,0); //object(carshowwin_sfsx) (5)
	CreateDynamicObject(3851,1485.35375977,-1762.37414551,33.20485687,23.81835938,90.00000000,180.26367188,0,0); //object(carshowwin_sfsx) (5)
	CreateDynamicObject(3851,1489.30395508,-1762.37060547,33.20485687,23.81835938,90.00000000,180.26367188,0,0); //object(carshowwin_sfsx) (5)
	CreateDynamicObject(3851,1493.22863770,-1762.38317871,33.20485687,23.81835938,90.00000000,180.26367188,0,0); //object(carshowwin_sfsx) (5)
	CreateDynamicObject(3851,1481.42822266,-1772.27551270,32.52981567,328.23852539,90.00000000,180.26367188,0,0); //object(carshowwin_sfsx) (5)
	CreateDynamicObject(3851,1485.42431641,-1772.26232910,32.52981567,328.23852539,90.00000000,180.26367188,0,0); //object(carshowwin_sfsx) (5)
	CreateDynamicObject(3851,1489.37231445,-1772.27709961,32.52981567,328.23852539,90.00000000,180.26367188,0,0); //object(carshowwin_sfsx) (5)
	CreateDynamicObject(3851,1493.34277344,-1772.25769043,32.52981567,328.23852539,90.00000000,180.26367188,0,0); //object(carshowwin_sfsx) (5)
	CreateDynamicObject(3851,1467.18652344,-1771.31518555,31.10486031,329.48327637,175.53491211,178.00952148,0,0); //object(carshowwin_sfsx) (5)
	CreateDynamicObject(1280,1503.93090820,-1723.87548828,12.94823837,0.00000000,0.00000000,34.05541992,0,0); //object(parkbench1) (1)
	CreateDynamicObject(1280,1496.25537109,-1723.99926758,13.13,0.00000000,0.00000000,127.66537476,0,0); //object(parkbench1) (2)
	CreateDynamicObject(18014,1495.55200195,-1722.51831055,13.00409317,0.00000000,0.00000000,309.37390137,0,0); //object(int_rest_veg03) (2)
	CreateDynamicObject(3515,1493.65258789,-1721.95312500,11.01708221,0.00000000,0.00000000,0.00000000,0,0); //object(vgsfountain) (1)
	CreateDynamicObject(3811,1498.55541992,-1720.27465820,13.19341660,0.00000000,0.00000000,270.26916504,0,0); //object(sfx_winplant08) (1)
	CreateDynamicObject(3811,1502.27014160,-1720.16967773,13.19341660,0.00000000,0.00000000,270.26916504,0,0); //object(sfx_winplant08) (2)
	CreateDynamicObject(18014,1504.71752930,-1723.23706055,13.00409317,0.00000000,0.00000000,35.04388428,0,0); //object(int_rest_veg03) (2)
	CreateDynamicObject(1280,1499.92724609,-1721.59985352,12.94823837,0.00000000,0.00000000,89.85708618,0,0); //object(parkbench1) (1)
	CreateDynamicObject(748,1493.59851074,-1721.61669922,12.30136299,0.00000000,0.00000000,240.36035156,0,0); //object(sm_scrb_grp1) (1)
	CreateDynamicObject(10444,1500.12707520,-1708.79248047,12.54687500,0.00000000,0.00000000,310.10510254,0,0); //object(poolwater_sfs) (1)
	CreateDynamicObject(18014,1491.83020020,-1722.14562988,12.95407867,0.00000000,0.00000000,219.64135742,0,0); //object(int_rest_veg03) (2)
	CreateDynamicObject(1361,1493.54650879,-1723.98400879,12.66522789,0.00000000,0.00000000,0.00000000,0,0); //object(cj_bush_prop2) (8)
	CreateDynamicObject(970,1491.70507812,-1722.67639160,13.09835625,0.00000000,0.00000000,129.71697998,0,0); //object(fencesmallb) (23)
	CreateDynamicObject(18014,1494.09289551,-1719.77648926,13.25407410,0.00000000,0.00000000,269.48852539,0,0); //object(int_rest_veg03) (2)
	/*CreateDynamicObject(970,1496.66162109,-1727.14648438,13.07335663,0.00000000,0.00000000,0.00000000,0,0); //object(fencesmallb) (12)
	CreateDynamicObject(970,1503.65722656,-1727.09033203,13.14835548,0.00000000,0.00000000,0.00000000,0,0); //object(fencesmallb) (12)
	CreateDynamicObject(970,1539.44897461,-1697.76147461,13.09835625,0.00000000,0.00000000,270.27026367,0,0); //object(fencesmallb) (12)
	CreateDynamicObject(970,1539.40527344,-1692.06201172,13.09835625,0.00000000,0.00000000,270.26916504,0,0); //object(fencesmallb) (12)
	CreateDynamicObject(970,1539.52880859,-1686.31152344,13.09835625,0.00000000,0.00000000,270.26916504,0,0); //object(fencesmallb) (12)
	CreateDynamicObject(970,1539.45703125,-1680.30957031,13.09835625,0.00000000,0.00000000,270.26916504,0,0); //object(fencesmallb) (12)
	CreateDynamicObject(970,1539.50756836,-1674.55957031,13.09835625,0.00000000,0.00000000,270.26916504,0,0); //object(fencesmallb) (12)
	CreateDynamicObject(970,1539.55737305,-1668.80957031,13.09835625,0.00000000,0.00000000,270.26916504,0,0); //object(fencesmallb) (12)
	CreateDynamicObject(970,1539.60937500,-1662.80957031,13.09835625,0.00000000,0.00000000,270.26916504,0,0); //object(fencesmallb) (12)
	CreateDynamicObject(970,1539.57360840,-1657.75646973,13.09835625,0.00000000,0.00000000,270.26916504,0,0); //object(fencesmallb) (12)
	CreateDynamicObject(970,1539.51342773,-1653.64013672,13.09835625,0.00000000,0.00000000,270.26916504,0,0); //object(fencesmallb) (12)
	CreateDynamicObject(970,1541.64782715,-1699.95446777,13.42335129,0.00000000,0.00000000,359.99902344,0,0); //object(fencesmallb) (12)
	CreateDynamicObject(970,1541.81164551,-1651.07336426,13.44835091,0.00000000,0.00000000,180.00000000,0,0); //object(fencesmallb) (12) */
	CreateDynamicObject(8548,1500.11645508,-1726.98425293,12.39012814,178.64868164,0.00000000,1.98498535,0,0); //object(trainsign01_lvs) (8)
	CreateDynamicObject(8548,1493.87976074,-1725.71520996,12.39012814,178.64868164,0.00000000,1.98303223,0,0); //object(trainsign01_lvs) (8)
	CreateDynamicObject(8548,1506.10546875,-1726.29418945,12.39012814,178.64868164,0.00000000,1.98303223,0,0); //object(trainsign01_lvs) (8)
	CreateDynamicObject(3851,1467.49133301,-1763.19604492,31.50485420,337.41772461,0.50000000,0.00000000,0,0); //object(carshowwin_sfsx) (5)
	CreateDynamicObject(3851,1495.30639648,-1771.20751953,31.20485878,329.48327637,175.53491211,178.00952148,0,0); //object(carshowwin_sfsx) (5)
	CreateDynamicObject(3851,1495.07421875,-1763.19519043,31.40485573,337.41772461,0.50000000,0.00000000,0,0); //object(carshowwin_sfsx) (5)
	CreateDynamicObject(970,1540.70642090,-1726.91149902,13.12335587,0.00000000,0.00000000,0.00000000,0,0); //object(fencesmallb) (12)
	CreateDynamicObject(970,1534.95812988,-1720.45520020,13.12335587,0.00000000,0.00000000,89.72534180,0,0); //object(fencesmallb) (12)
	CreateDynamicObject(970,1548.40148926,-1727.02160645,13.07335663,0.00000000,0.00000000,0.00000000,0,0); //object(fencesmallb) (12)
	CreateDynamicObject(1340,1482.27124023,-1703.64257812,14.17446136,0.00000000,0.00000000,270.36022949,0,0); //object(chillidogcart) (1)
	CreateDynamicObject(1341,1477.89270020,-1703.66552734,14.04946136,0.00000000,0.00000000,270.27026367,0,0); //object(icescart_prop) (1)
	CreateDynamicObject(1346,1454.97924805,-1755.28234863,13.89788055,0.00000000,0.00000000,180.54052734,0,0); //object(cj_phone_kiosk2) (1)
	CreateDynamicObject(1432,1476.41101074,-1708.50402832,13.04687500,0.00000000,0.00000000,0.00000000,0,0); //object(dyn_table_2) (1)
	CreateDynamicObject(1432,1482.62805176,-1706.97802734,13.04687500,0.00000000,0.00000000,0.00000000,0,0); //object(dyn_table_2) (2)
	CreateDynamicObject(1432,1480.52124023,-1710.84973145,13.04687500,0.00000000,0.00000000,0.00000000,0,0); //object(dyn_table_2) (3)*/
	//obiekty DMV wystrÛj zewnÍtrzny - znaki drogowe (by Dywan)
	CreateDynamicObject(19073, 1304.75708, -1716.70325, 11.35780,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19073, 1305.01172, -1772.52588, 11.35780,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19073, 1305.05261, -1813.29785, 11.35780,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(7615, 1304.44312, -1782.39990, 14.39020,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(7615, 1304.40710, -1665.50110, 14.39020,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(7615, 1305.61719, -1785.33350, 14.39020,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(7615, 1305.61243, -1668.46216, 14.39020,   0.00000, 0.00000, 270.00000);
	//znaki jazda tylko w prawo
	SetDynamicObjectMaterialText(CreateDynamicObject(8548, 1306.95044, -1730.01416, 13.85790,   0.00000, 0.00000, 90.00000), 0,";", 10,"Wingdings 3", 30, 0, 0xFFFFFFFF, 0xFF0000BF, 1);
	SetDynamicObjectMaterialText(CreateDynamicObject(8548, 1322.61694, -1726.89478, 13.64590,   0.00000, 0.00000, 90.00000), 0,";", 10,"Wingdings 3", 30, 0, 0xFFFFFFFF, 0xFF0000BF, 1);
	//znak National Speed Limit
	SetDynamicObjectMaterialText(CreateDynamicObject(8548, 1306.95044, -1730.01416, 13.00990,   0.00000, 0.00000, 90.00000), 0,"X", 10,"Wingdings 2", 40, 1, 0xFF000000, 0xFFFFFFFF, 1);
	SetDynamicObjectMaterialText(CreateDynamicObject(8548, 1322.61694, -1726.89478, 13.00990,   0.00000, 0.00000, 90.00000), 0,"X", 10,"Wingdings 2", 40, 1, 0xFF000000, 0xFFFFFFFF, 1);

	//obiekty pd (akademia pd)
	CreateDynamicObject(6300,790.32849121,-593.29071045,-83.28086090,0.00000000,0.00000000,0.00000000,0,16); //object(pier04_law2) (1)
	CreateDynamicObject(9339,804.23815918,-595.37579346,-74.50249481,0.00000000,0.00000000,0.00000000,0,16); //object(sfnvilla001_cm) (1)
	CreateDynamicObject(9339,804.24560547,-595.36328125,-73.14855957,0.00000000,0.00000000,0.00000000,0,16); //object(sfnvilla001_cm) (2)
	CreateDynamicObject(9339,815.96484375,-585.99804688,-74.52752686,0.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (3)
	CreateDynamicObject(9339,808.41015625,-590.35351562,-74.52752686,0.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (4)
	CreateDynamicObject(9339,793.49121094,-573.04980469,-74.52752686,0.00000000,0.00000000,0.00000000,0,16); //object(sfnvilla001_cm) (5)
	CreateDynamicObject(9339,793.49023438,-573.04296875,-73.12358856,0.00000000,0.00000000,0.00000000,0,16); //object(sfnvilla001_cm) (6)
	CreateDynamicObject(9339,815.94433594,-585.94921875,-73.12754822,0.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (7)
	CreateDynamicObject(9339,814.18261719,-590.34375000,-73.12753296,0.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (8)
	CreateDynamicObject(1649,797.97265625,-586.09863281,-74.01088715,0.00000000,0.00000000,0.00000000,0,16); //object(wglasssmash) (3)
	CreateDynamicObject(1649,798.00488281,-585.86718750,-74.05703735,0.00000000,0.00000000,179.99450684,0,16); //object(wglasssmash) (5)
	CreateDynamicObject(9339,781.61364746,-585.96057129,-73.15251923,0.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (9)
	CreateDynamicObject(2737,793.75683594,-581.89355469,-73.93692017,0.00000000,0.00000000,89.74182129,0,16); //object(police_nb_car) (2)
	CreateDynamicObject(1722,798.17462158,-580.81945801,-75.22660065,0.00000000,0.00000000,90.00000000,0,16); //object(off_chairnu) (1)
	CreateDynamicObject(1722,798.15283203,-581.42431641,-75.22660065,0.00000000,0.00000000,90.00000000,0,16); //object(off_chairnu) (2)
	CreateDynamicObject(1722,798.17242432,-582.05511475,-75.22660065,0.00000000,0.00000000,90.00000000,0,16); //object(off_chairnu) (5)
	CreateDynamicObject(1722,798.14996338,-582.66900635,-75.22660065,0.00000000,0.00000000,90.00000000,0,16); //object(off_chairnu) (6)
	CreateDynamicObject(1722,799.45837402,-581.37744141,-75.22660065,0.00000000,0.00000000,90.00000000,0,16); //object(off_chairnu) (7)
	CreateDynamicObject(1722,798.13995361,-583.27911377,-75.22660065,0.00000000,0.00000000,90.00000000,0,16); //object(off_chairnu) (8)
	CreateDynamicObject(1722,799.47851562,-581.93847656,-75.22660065,0.00000000,0.00000000,90.00000000,0,16); //object(off_chairnu) (11)
	CreateDynamicObject(9339,796.23535156,-595.53027344,-74.52752686,0.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (10)
	CreateDynamicObject(1722,799.47949219,-580.80859375,-75.22660065,0.00000000,0.00000000,90.00000000,0,16); //object(off_chairnu) (12)
	CreateDynamicObject(9339,796.53808594,-595.52636719,-73.16037750,0.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (11)
	CreateDynamicObject(9339,800.53125000,-603.41796875,-74.53955841,0.00000000,0.00000000,0.00000000,0,16); //object(sfnvilla001_cm) (12)
	CreateDynamicObject(1723,800.47851562,-585.28613281,-75.22660065,0.00000000,0.00000000,179.99450684,0,16); //object(mrk_seating1) (1)
	CreateDynamicObject(9339,800.54394531,-603.29296875,-73.13379669,0.00000000,0.00000000,0.00000000,0,16); //object(sfnvilla001_cm) (13)
	CreateDynamicObject(9339,812.15618896,-579.72222900,-74.52752686,0.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (14)
	CreateDynamicObject(9339,812.14337158,-579.74053955,-73.12725830,0.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (15)
	CreateDynamicObject(1722,799.47668457,-582.51751709,-75.22660065,0.00000000,0.00000000,90.00000000,0,16); //object(off_chairnu) (14)
	CreateDynamicObject(2184,796.63574219,-585.37109375,-75.22660065,0.00000000,0.00000000,111.99462891,0,16); //object(med_office6_desk_2) (1)
	CreateDynamicObject(1722,799.48950195,-583.05639648,-75.22660065,0.00000000,0.00000000,90.00000000,0,16); //object(off_chairnu) (16)
	CreateDynamicObject(1722,800.71484375,-580.78710938,-75.22660065,0.00000000,0.00000000,90.00000000,0,16); //object(off_chairnu) (17)
	CreateDynamicObject(1722,800.72131348,-581.35400391,-75.22660065,0.00000000,0.00000000,90.00000000,0,16); //object(off_chairnu) (18)
	CreateDynamicObject(1722,800.70324707,-581.91937256,-75.22660065,0.00000000,0.00000000,90.00000000,0,16); //object(off_chairnu) (19)
	CreateDynamicObject(1722,800.70605469,-582.46777344,-75.22660065,0.00000000,0.00000000,90.00000000,0,16); //object(off_chairnu) (20)
	CreateDynamicObject(1722,800.70037842,-583.03161621,-75.22660065,0.00000000,0.00000000,90.00000000,0,16); //object(off_chairnu) (21)
	CreateDynamicObject(1722,801.79913330,-580.83801270,-75.22660065,0.00000000,0.00000000,90.00000000,0,16); //object(off_chairnu) (22)
	CreateDynamicObject(1722,801.79687500,-581.38378906,-75.22660065,0.00000000,0.00000000,90.00000000,0,16); //object(off_chairnu) (23)
	CreateDynamicObject(1722,801.79119873,-581.91674805,-75.22660065,0.00000000,0.00000000,90.00000000,0,16); //object(off_chairnu) (24)
	CreateDynamicObject(1722,801.77978516,-582.46514893,-75.22660065,0.00000000,0.00000000,90.00000000,0,16); //object(off_chairnu) (25)
	CreateDynamicObject(1722,801.78668213,-582.99542236,-75.22660065,0.00000000,0.00000000,90.00000000,0,16); //object(off_chairnu) (26)
	CreateDynamicObject(1649,798.74261475,-590.32629395,-73.95008087,0.00000000,0.00000000,0.00000000,0,16); //object(wglasssmash) (7)
	CreateDynamicObject(1722,803.02734375,-580.82910156,-75.22660065,0.00000000,0.00000000,90.00000000,0,16); //object(off_chairnu) (27)
	CreateDynamicObject(1649,798.78186035,-590.26983643,-73.98007202,0.00000000,0.00000000,179.99450684,0,16); //object(wglasssmash) (8)
	CreateDynamicObject(1722,803.03393555,-581.39660645,-75.22660065,0.00000000,0.00000000,90.00000000,0,16); //object(off_chairnu) (28)
	CreateDynamicObject(1722,803.03808594,-581.95703125,-75.22660065,0.00000000,0.00000000,90.00000000,0,16); //object(off_chairnu) (29)
	CreateDynamicObject(1722,803.06250000,-582.52001953,-75.22660065,0.00000000,0.00000000,90.00000000,0,16); //object(off_chairnu) (30)
	CreateDynamicObject(9339,780.85449219,-590.35058594,-73.14428711,0.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (16)
	CreateDynamicObject(1722,803.07446289,-583.05798340,-75.22660065,0.00000000,0.00000000,90.00000000,0,16); //object(off_chairnu) (31)
	CreateDynamicObject(1663,794.33673096,-585.14031982,-74.76638794,0.00000000,0.00000000,130.00000000,0,16); //object(swivelchair_b) (1)
	CreateDynamicObject(638,800.50225830,-589.65557861,-74.52956390,0.00000000,0.00000000,90.00000000,0,16); //object(kb_planter_bush) (1)
	CreateDynamicObject(9339,793.44824219,-603.38305664,-74.52752686,0.00000000,0.00000000,0.00000000,0,16); //object(sfnvilla001_cm) (17)
	CreateDynamicObject(9339,793.45898438,-603.38574219,-73.11535645,0.00000000,0.00000000,0.00000000,0,16); //object(sfnvilla001_cm) (18)
	CreateDynamicObject(9339,780.84472656,-590.34472656,-74.52752686,0.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (19)
	CreateDynamicObject(9339,788.38183594,-585.97265625,-74.52752686,0.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (20)
	CreateDynamicObject(9339,800.74804688,-585.96289062,-60.89108276,90.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (21)
	CreateDynamicObject(9339,795.18261719,-585.96875000,-67.67749023,90.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (22)
	CreateDynamicObject(9339,803.58105469,-585.95703125,-74.52752686,90.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (23)
	CreateDynamicObject(9339,796.05731201,-590.36865234,-70.46508026,90.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (24)
	CreateDynamicObject(9339,796.07250977,-590.36267090,-72.54736328,90.00000000,0.00000000,270.00000000,0,16); //object(sfnvilla001_cm) (25)
	CreateDynamicObject(9339,800.36608887,-590.37268066,-74.52752686,90.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (26)
	CreateDynamicObject(9339,793.31677246,-590.30041504,-71.81593323,0.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (27)
	CreateDynamicObject(9339,782.40637207,-590.35986328,-72.12786865,0.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (28)
	CreateDynamicObject(9339,814.21081543,-585.96411133,-72.15253448,0.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (29)
	CreateDynamicObject(9339,791.44335938,-585.97070312,-71.80603790,0.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (30)
	CreateDynamicObject(9339,804.23046875,-589.13183594,-71.74462128,0.00000000,0.00000000,0.00000000,0,16); //object(sfnvilla001_cm) (31)
	CreateDynamicObject(9339,789.78967285,-590.17919922,-74.52752686,0.00000000,0.00000000,0.00000000,0,16); //object(sfnvilla001_cm) (35)
	CreateDynamicObject(9339,789.80175781,-589.73803711,-73.12358856,0.00000000,0.00000000,0.00000000,0,16); //object(sfnvilla001_cm) (37)
	CreateDynamicObject(9339,789.81835938,-588.23956299,-71.76965332,0.00000000,0.00000000,0.00000000,0,16); //object(sfnvilla001_cm) (42)
	CreateDynamicObject(1536,804.13671875,-590.20800781,-75.22660065,0.00000000,0.00000000,90.00000000,0,16); //object(gen_doorext15) (1)
	CreateDynamicObject(1536,804.09881592,-587.37884521,-75.22660065,0.00000000,0.00000000,270.00000000,0,16); //object(gen_doorext15) (2)
	CreateDynamicObject(9339,793.47509766,-603.23944092,-71.79544830,0.00000000,0.00000000,0.00000000,0,16); //object(sfnvilla001_cm) (43)
	CreateDynamicObject(9339,794.98394775,-595.51208496,-71.77745056,0.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (44)
	CreateDynamicObject(9339,800.53979492,-603.31536865,-71.85245514,0.00000000,0.00000000,0.00000000,0,16); //object(sfnvilla001_cm) (45)
	CreateDynamicObject(9339,793.50311279,-572.99432373,-71.79079437,0.00000000,0.00000000,0.00000000,0,16); //object(sfnvilla001_cm) (46)
	CreateDynamicObject(1723,791.43652344,-586.63769531,-75.22660065,0.00000000,0.00000000,0.00000000,0,16); //object(mrk_seating1) (2)
	CreateDynamicObject(2011,790.45153809,-586.74450684,-75.27651978,0.00000000,0.00000000,0.00000000,0,16); //object(nu_plant2_ofc) (1)
	CreateDynamicObject(1723,790.47229004,-589.70178223,-75.22660065,0.00000000,0.00000000,90.00000000,0,16); //object(mrk_seating1) (3)
	CreateDynamicObject(1569,794.15234375,-579.65332031,-75.22660065,0.00000000,0.00000000,0.00000000,0,16); //object(adam_v_door) (1)
	CreateDynamicObject(1651,797.91210938,-579.79003906,-73.68618011,0.00000000,0.00000000,270.00000000,0,16); //object(od_copwindows) (1)
	CreateDynamicObject(9339,796.18066406,-579.71582031,-74.52752686,90.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (34)
	CreateDynamicObject(9339,806.35156250,-579.73242188,-71.98345184,0.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (48)
	CreateDynamicObject(1649,797.99609375,-579.59960938,-73.56085968,0.00000000,0.00000000,179.99450684,0,16); //object(wglasssmash) (1)
	CreateDynamicObject(9339,808.52459717,-579.71728516,-75.47992706,0.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (49)
	CreateDynamicObject(9339,797.37402344,-575.10644531,-74.52752686,0.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (51)
	CreateDynamicObject(9339,793.56640625,-579.70410156,-73.12358856,90.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (52)
	CreateDynamicObject(9339,783.83911133,-579.66442871,-72.05237579,0.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (53)
	CreateDynamicObject(9339,799.35906982,-566.68676758,-73.52746582,0.00000000,0.00000000,0.00000000,0,16); //object(sfnvilla001_cm) (54)
	CreateDynamicObject(6300,779.54589844,-599.35546875,-63.58394623,179.99450684,0.00000000,0.00000000,0,16); //object(pier04_law2) (4)
	CreateDynamicObject(1671,798.56219482,-577.80560303,-74.76641846,0.00000000,0.00000000,0.00000000,0,16); //object(swivelchair_a) (1)
	CreateDynamicObject(1671,796.84509277,-576.90374756,-74.76641846,0.00000000,0.00000000,211.00000000,0,16); //object(swivelchair_a) (2)
	CreateDynamicObject(2606,798.15161133,-575.07366943,-72.94730377,0.00000000,0.00000000,0.00000000,0,16); //object(cj_police_counter2) (1)
	CreateDynamicObject(9339,794.97973633,-575.09509277,-73.29947662,0.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (32)
	CreateDynamicObject(9339,799.35656738,-566.71624756,-74.52755737,0.00000000,0.00000000,0.00000000,0,16); //object(sfnvilla001_cm) (33)
	CreateDynamicObject(9339,794.19860840,-575.10382080,-72.32353973,0.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (36)
	CreateDynamicObject(9339,799.35833740,-566.72644043,-72.27127075,0.00000000,0.00000000,0.00000000,0,16); //object(sfnvilla001_cm) (38)
	CreateDynamicObject(2604,797.26409912,-575.70269775,-74.42975616,0.00000000,0.00000000,0.00000000,0,16); //object(cj_police_counter) (1)
	CreateDynamicObject(11631,794.32000732,-577.41693115,-73.98072815,0.00000000,0.00000000,90.00000000,0,16); //object(ranch_desk) (1)
	CreateDynamicObject(2184,796.47308350,-594.84906006,-75.22663116,0.00000000,0.00000000,117.00000000,0,16); //object(med_office6_desk_2) (2)
	CreateDynamicObject(2356,794.55712891,-594.70996094,-75.22663116,0.00000000,0.00000000,0.00000000,0,16); //object(police_off_chair) (1)
	CreateDynamicObject(2190,795.68371582,-593.22412109,-74.45088959,0.00000000,0.00000000,285.25000000,0,16); //object(pc_1) (1)
	CreateDynamicObject(2202,796.92993164,-595.09820557,-75.20973206,0.00000000,0.00000000,0.00000000,0,16); //object(photocopier_2) (1)
	CreateDynamicObject(1723,797.86932373,-591.01928711,-75.22663116,0.00000000,0.00000000,0.00000000,0,16); //object(mrk_seating1) (4)
	CreateDynamicObject(2921,804.08599854,-585.28118896,-72.23491669,0.00000000,0.00000000,0.00000000,0,16); //object(kmb_cam) (1)
	CreateDynamicObject(9339,807.76971436,-592.29711914,-74.52709961,0.00000000,0.00000000,0.00000000,0,16); //object(sfnvilla001_cm) (40)
	CreateDynamicObject(9339,807.75573730,-589.45758057,-73.10375214,0.00000000,0.00000000,0.00000000,0,16); //object(sfnvilla001_cm) (41)
	CreateDynamicObject(14843,811.26177979,-583.04467773,-73.98740387,0.00000000,0.00000000,179.99450684,0,16); //object(int_policea01) (1)
	CreateDynamicObject(9339,807.70300293,-582.56091309,-72.04682922,0.00000000,0.00000000,0.00000000,0,16); //object(sfnvilla001_cm) (55)
	CreateDynamicObject(9339,804.26849365,-580.11346436,-73.18190765,90.00000000,0.00000000,0.00000000,0,16); //object(sfnvilla001_cm) (56)
	CreateDynamicObject(9339,804.23394775,-580.88775635,-72.03733063,0.00000000,0.00000000,0.00000000,0,16); //object(sfnvilla001_cm) (57)
	CreateDynamicObject(9339,817.17028809,-583.06158447,-72.02362823,0.00000000,0.00000000,90.00000000,0,16); //object(sfnvilla001_cm) (58)
	CreateDynamicObject(2596,799.28985596,-595.08703613,-72.48491669,0.00000000,0.00000000,180.00000000,0,16); //object(cj_sex_tv) (1)
	CreateDynamicObject(14795,807.69238281,-599.90722656,-69.91528320,0.00000000,0.00000000,0.00000000,0,16); //object(genint3_smashtv) (1)
	CreateDynamicObject(1516,792.07733154,-588.39764404,-75.19653320,0.00000000,0.00000000,0.00000000,0,16); //object(dyn_table_03) (2)
	CreateDynamicObject(2707,803.14428711,-582.28448486,-71.05766296,0.00000000,0.00000000,0.00000000,0,16); //object(cj_light_fit) (1)
	CreateDynamicObject(945,795.64752197,-581.86895752,-64.39328003,0.00000000,0.00000000,0.00000000,0,16); //object(ws_cf_lamps) (1)
	CreateDynamicObject(1494,804.20733643,-580.75689697,-75.17944336,0.00000000,0.00000000,270.00000000,0,16); //object(gen_doorint03) (1)
	CreateDynamicObject(1494,793.87030029,-590.31555176,-75.19653320,0.00000000,0.00000000,0.00000000,0,16); //object(gen_doorint03) (2)
	CreateDynamicObject(1494,801.39410400,-586.00482178,-75.32945251,0.00000000,0.00000000,359.72973633,0,16); //object(gen_doorint03) (1)
	
	//ulepszona fabryka broni
	CreateDynamicObject(958,2136.8000488,-2291.0000000,20.5000000,0.0000000,0.0000000,314.0000000,0,0); //object(cj_chip_maker) (1)
	CreateDynamicObject(958,2141.0000000,-2290.3999023,20.5000000,0.0000000,0.0000000,40.0000000,0,0); //object(cj_chip_maker) (2)
	CreateDynamicObject(959,2136.7900391,-2291.0000000,20.5000000,0.0000000,0.0000000,314.0000000,0,0); //object(cj_chip_maker_bits) (2)
	CreateDynamicObject(959,2141.0000000,-2290.3994141,20.5000000,0.0000000,0.0000000,39.9957275,0,0); //object(cj_chip_maker_bits) (3)
	CreateDynamicObject(2358,2141.3999023,-2290.1000977,21.5000000,0.0000000,0.0000000,230.0000000,0,0); //object(ammo_box_c2) (1)
	CreateDynamicObject(2358,2140.5000000,-2290.6999512,21.5000000,0.0000000,0.0000000,207.9987793,0,0); //object(ammo_box_c2) (2)
	CreateDynamicObject(2358,2140.5000000,-2290.6999512,21.7000008,0.0000000,0.0000000,207.9986572,0,0); //object(ammo_box_c2) (3)
	CreateDynamicObject(2358,2137.3999023,-2291.5000000,21.5000000,0.0000000,0.0000000,160.0000000,0,0); //object(ammo_box_c2) (5)
	CreateDynamicObject(2359,2139.8000488,-2291.8999023,19.8999996,0.0000000,0.0000000,223.9995117,0,0); //object(ammo_box_c5) (2)
	CreateDynamicObject(2358,2136.3000488,-2290.6999512,21.5000000,0.0000000,0.0000000,131.9993896,0,0); //object(ammo_box_c2) (8)
	CreateDynamicObject(2358,2136.3000488,-2290.6999512,21.7000008,0.0000000,0.0000000,131.9952393,0,0); //object(ammo_box_c2) (9)
	CreateDynamicObject(2358,2137.3000488,-2291.5000000,21.7000008,0.0000000,0.0000000,159.9993896,0,0); //object(ammo_box_c2) (10)
	CreateDynamicObject(2358,2136.3000488,-2290.6999512,21.8999996,0.0000000,0.0000000,131.9952393,0,0); //object(ammo_box_c2) (12)
	CreateDynamicObject(2041,2141.8000488,-2289.6000977,21.6000004,0.0000000,0.0000000,214.0000000,0,0); //object(ammo_box_m2) (1)
	CreateDynamicObject(2040,2137.0000000,-2290.8999023,21.5000000,0.0000000,0.0000000,0.0000000,0,0); //object(ammo_box_m1) (1)
	CreateDynamicObject(2042,2139.3000488,-2291.1999512,19.7999992,0.0000000,0.0000000,70.0000000,0,0); //object(ammo_box_m3) (1)
	CreateDynamicObject(2358,2141.3999023,-2290.0400391,21.7000008,0.0000000,0.0000000,229.9987793,0,0); //object(ammo_box_c2) (13)
	CreateDynamicObject(3015,2138.6000977,-2292.6000977,19.7000008,0.0000000,0.0000000,0.0000000,0,0); //object(cr_cratestack) (1)
	CreateDynamicObject(3014,2138.3999023,-2287.8999023,19.8999996,0.0000000,0.0000000,320.0000000,0,0); //object(cr_guncrate) (1)
	CreateDynamicObject(3015,2138.0000000,-2288.6000977,19.7000008,0.0000000,0.0000000,0.0000000,0,0); //object(cr_cratestack) (2)
	CreateDynamicObject(3013,2139.0820312,-2291.8952637,19.8137169,0.0000000,0.0000000,0.0000000,0,0); //object(cr_ammobox) (1)
	CreateDynamicObject(3014,2138.0000000,-2292.1000977,19.8999996,0.0000000,0.0000000,0.0000000,0,0); //object(cr_guncrate) (2)
	CreateDynamicObject(1558,2140.1000977,-2286.5000000,20.2999992,0.0000000,0.0000000,314.0000000,0,0); //object(cj_cardbrd_pickup) (1)
	CreateDynamicObject(1558,2140.8000488,-2287.1999512,20.2999992,0.0000000,0.0000000,315.9947510,0,0); //object(cj_cardbrd_pickup) (2)
	CreateDynamicObject(1558,2141.5000000,-2287.8000488,20.2999992,0.0000000,0.0000000,317.9942627,0,0); //object(cj_cardbrd_pickup) (3)
	CreateDynamicObject(1558,2142.1999512,-2288.3999023,20.2999992,0.0000000,0.0000000,317.9937744,0,0); //object(cj_cardbrd_pickup) (4)
	CreateDynamicObject(1558,2143.0000000,-2289.1999512,20.2000008,0.0000000,0.0000000,317.9937744,0,0); //object(cj_cardbrd_pickup) (5)
	CreateDynamicObject(5269,2146.1000977,-2285.8999023,22.0000000,0.0000000,0.0000000,136.0000000,0,0); //object(las2dkwar05) (1)
	CreateDynamicObject(5269,2151.6999512,-2280.1000977,22.0000000,0.0000000,0.0000000,135.9992676,0,0); //object(las2dkwar05) (2)
	CreateDynamicObject(1558,2141.5000000,-2287.8000488,21.2000008,0.0000000,0.0000000,317.9937744,0,0); //object(cj_cardbrd_pickup) (6)
	CreateDynamicObject(1558,2140.8000488,-2287.1999512,21.2000008,0.0000000,0.0000000,317.9937744,0,0); //object(cj_cardbrd_pickup) (7)
	CreateDynamicObject(1558,2140.1000977,-2286.5000000,21.2000008,0.0000000,0.0000000,315.7437744,0,0); //object(cj_cardbrd_pickup) (8)
	CreateDynamicObject(1558,2140.1000977,-2286.5000000,22.1000004,0.0000000,0.0000000,315.7415771,0,0); //object(cj_cardbrd_pickup) (9)
	CreateDynamicObject(1558,2140.8000488,-2287.2399902,22.1000004,0.0000000,0.0000000,317.9937744,0,0); //object(cj_cardbrd_pickup) (12)
	CreateDynamicObject(1558,2141.5000000,-2287.8999023,22.1000004,0.0000000,0.0000000,317.9937744,0,0); //object(cj_cardbrd_pickup) (13)
	CreateDynamicObject(1558,2142.1999512,-2288.3999023,21.2000008,0.0000000,0.0000000,317.9937744,0,0); //object(cj_cardbrd_pickup) (14)
	CreateDynamicObject(1558,2142.1999512,-2288.5000000,22.1000004,0.0000000,0.0000000,317.9937744,0,0); //object(cj_cardbrd_pickup) (15)
	CreateDynamicObject(1558,2141.5000000,-2287.8999023,23.0000000,0.0000000,0.0000000,317.9937744,0,0); //object(cj_cardbrd_pickup) (16)
	CreateDynamicObject(1558,2140.8000488,-2287.3000488,23.0000000,0.0000000,0.0000000,317.9937744,0,0); //object(cj_cardbrd_pickup) (17)
	CreateDynamicObject(1558,2140.1000977,-2286.5000000,23.0000000,0.0000000,0.0000000,315.7415771,0,0); //object(cj_cardbrd_pickup) (18)
	CreateDynamicObject(1558,2142.1999512,-2288.5000000,23.0000000,0.0000000,0.0000000,317.9937744,0,0); //object(cj_cardbrd_pickup) (19)
	CreateDynamicObject(1418,2139.5000000,-2286.8000488,20.3999996,0.0000000,0.0000000,316.0000000,0,0); //object(dyn_f_wood_3) (1)
	CreateDynamicObject(1418,2141.8999023,-2289.1999512,20.3999996,0.0000000,0.0000000,315.9997559,0,0); //object(dyn_f_wood_3) (3)
	CreateDynamicObject(1418,2139.5000000,-2286.8000488,21.7999992,0.0000000,0.0000000,315.9997559,0,0); //object(dyn_f_wood_3) (4)
	CreateDynamicObject(1418,2141.8999023,-2289.1999512,21.7999992,0.0000000,0.0000000,315.9997559,0,0); //object(dyn_f_wood_3) (5)
	CreateDynamicObject(1418,2141.8999023,-2289.1999512,23.0000000,0.0000000,0.0000000,315.9997559,0,0); //object(dyn_f_wood_3) (6)
	CreateDynamicObject(1418,2139.5000000,-2286.8000488,23.0000000,0.0000000,0.0000000,315.9997559,0,0); //object(dyn_f_wood_3) (7)
	CreateDynamicObject(2937,2141.1999512,-2287.3999023,22.3999996,0.0000000,0.0000000,48.0000000,0,0); //object(kmb_plank) (5)
	CreateDynamicObject(5269,2157.3000488,-2274.3000488,22.0000000,0.0000000,0.0000000,135.9942627,0,0); //object(las2dkwar05) (3)
	CreateDynamicObject(5269,2125.5000000,-2265.1999512,22.0000000,0.0000000,0.0000000,313.9997559,0,0); //object(las2dkwar05) (4)
	CreateDynamicObject(5269,2131.3999023,-2259.6000977,22.0000000,0.0000000,0.0000000,313.9947510,0,0); //object(las2dkwar05) (5)
	CreateDynamicObject(5269,2137.0000000,-2253.8999023,22.0000000,0.0000000,0.0000000,135.9892578,0,0); //object(las2dkwar05) (6)
	CreateDynamicObject(7023,2236.0000000,-2220.5000000,12.5000000,0.0000000,0.0000000,224.0000000,0,0); //object(vgngatesecurity) (1)
	//CreateDynamicObject(975,2231.5000000,-2213.6000977,14.1999998,0.0000000,0.0000000,136.0000000,0,0); //object(columbiangate) (4)
	CreateDynamicObject(3109,2119.1999512,-2275.6000977,20.8999996,0.0000000,0.0000000,44.0000000); //object(imy_la_door) (1) drzwi blokujπce skrÛt
	CreateDynamicObject(970,2233.3000488,-2218.1999512,13.1000004,0.0000000,0.0000000,43.0000000,0,0); //object(fencesmallb) (1)
	CreateDynamicObject(970,2233.1999512,-2221.1000977,13.1000004,0.0000000,0.0000000,313.0000000,0,0); //object(fencesmallb) (2)
	CreateDynamicObject(3799,2255.0000000,-2249.1000977,13.6000004,0.0000000,0.0000000,320.0000000,0,0); //object(acbox2_sfs) (1)
	CreateDynamicObject(1555,2233.5000000,-2287.5000000,13.1999998,270.5000000,269.9996948,313.9997559,0,0); //object(gen_doorext17) (1)
	CreateDynamicObject(1555,2236.6000977,-2290.6999512,13.6999998,277.6029663,170.5102539,215.0923462,0,0); //object(gen_doorext17) (2)

	//verona mall (obiekty cywilne)
	CreateDynamicObject(19322, 1117.59, -1490.01, 32.72,   0.00, 0.00, 0.00,0,0);
	CreateDynamicObject(19323, 1117.59, -1490.01, 32.72,   0.00, 0.00, 0.00,0,0);


	//Biurowiec prawnikÛw i ≥owcÛw nagrÛd
	CreateDynamicObject(14590,300.82740000,-1514.81160000,18.12210000,0.00000000,0.00000000,322.28530000,0,0); //
	CreateDynamicObject(1506,290.52650000,-1532.98510000,12.82490000,0.00000000,0.00000000,320.12010000,0,0); //
	CreateDynamicObject(14638,291.82870000,-1533.85840000,12.82240000,0.00000000,0.00000000,51.83500000,0,0); //
	CreateDynamicObject(14638,316.94960000,-1501.35730000,12.82230000,0.00000000,0.00000000,51.60970000,0,0); //
	CreateDynamicObject(1506,315.81280000,-1500.32590000,12.82180000,0.00000000,0.00000000,322.28530000,0,0); //
	CreateDynamicObject(14592,328.56490000,-1537.25730000,19.75570000,0.00000000,0.00000000,322.28530000,0,0); //
	CreateDynamicObject(1506,317.93080000,-1549.31580000,12.84160000,0.00000000,0.00000000,322.28530000,0,0); //
	CreateDynamicObject(14638,319.17600000,-1550.15700000,12.84160000,0.00000000,0.00000000,51.60970000,0,0); //
	CreateDynamicObject(14638,329.85740000,-1545.86020000,12.83340000,0.00000000,0.00000000,232.24400000,0,0); //
	CreateDynamicObject(1998,326.07030000,-1553.21510000,12.83630000,0.00000000,0.00000000,142.74020000,0,0); //
	CreateDynamicObject(1999,326.52580000,-1546.13980000,12.83840000,0.00000000,0.00000000,142.90450000,0,0); //
	CreateDynamicObject(1999,323.89390000,-1544.14840000,12.83840000,0.00000000,0.00000000,142.89920000,0,0); //
	CreateDynamicObject(16779,322.10190000,-1546.97530000,17.33040000,0.00000000,0.00000000,0.00000000,0,0); //
	CreateDynamicObject(1663,326.66150000,-1544.80900000,13.29740000,0.00000000,0.00000000,322.28530000,0,0); //
	CreateDynamicObject(1663,323.94340000,-1542.88670000,13.29740000,0.00000000,0.00000000,0.00000000,0,0); //
	CreateDynamicObject(626,320.62010000,-1539.89420000,14.88310000,0.00000000,0.00000000,0.00000000,0,0); //
	CreateDynamicObject(626,315.91800000,-1546.18950000,14.88080000,0.00000000,0.00000000,0.00000000,0,0); //
	CreateDynamicObject(1726,317.73320000,-1544.09450000,12.83200000,0.00000000,0.00000000,53.59470000,0,0); //
	CreateDynamicObject(2186,327.87050000,-1550.73170000,12.83410000,0.00000000,0.00000000,234.22900000,0,0); //
	CreateDynamicObject(2001,324.83800000,-1544.86360000,12.83450000,0.00000000,0.00000000,0.00000000,0,0); //
	CreateDynamicObject(2011,319.10100000,-1541.58310000,12.83550000,0.00000000,0.00000000,0.00000000,0,0); //
	CreateDynamicObject(2011,317.28270000,-1544.43310000,12.83550000,0.00000000,0.00000000,0.00000000,0,0); //
	CreateDynamicObject(2008,322.39870000,-1551.61910000,12.84080000,0.00000000,0.00000000,142.91950000,0,0); //
	CreateDynamicObject(1663,325.32740000,-1552.46420000,13.29480000,0.00000000,0.00000000,0.00000000,0,0); //
	CreateDynamicObject(1663,322.77150000,-1550.29430000,13.30130000,0.00000000,0.00000000,302.43540000,0,0); //
	CreateDynamicObject(1727,321.50070000,-1540.96180000,12.83560000,0.00000000,0.00000000,324.27030000,0,0); //
	CreateDynamicObject(1727,317.71390000,-1547.46500000,12.83560000,0.00000000,0.00000000,142.91630000,0,0); //
	CreateDynamicObject(633,323.52350000,-1552.50930000,13.83120000,0.00000000,0.00000000,0.00000000,0,0); //
	CreateDynamicObject(14638,322.95490000,301.91170000,998.13550000,0.00000000,0.00000000,89.05950000,0,0); //

	/////////////
	///KARETKA///
	/////////////
	//Pod≥oga
	SetDynamicObjectMaterial(CreateDynamicObject(19377, 1082.92090, -1313.85168, 20.53920,   0.00000, 90.00000, 0.00000, 32), 0, 14383, "burg_1", "wall6", 0);
	//Drzwi
	new d1 = CreateDynamicObject(3089, 1078.03735, -1309.11047, 21.84780,   0.00000, 0.00000, 0.00000, 32);
	new d2 = CreateDynamicObject(3089, 1081.02234, -1309.11047, 21.84780,   0.00000, 0.00000, 180.00000, 32);
    SetDynamicObjectMaterial(d1, 1, 2151, "cj_kitchen", "CJ_RED", 0);
    SetDynamicObjectMaterial(d2, 1, 2151, "cj_kitchen", "CJ_RED", 0);
    SetDynamicObjectMaterial(d1, 2, 14383, "burg_1", "wall6", 0);
    SetDynamicObjectMaterial(d2, 2, 14383, "burg_1", "wall6", 0);
	//åciany
	SetDynamicObjectMaterial(CreateDynamicObject(19460, 1077.93750, -1313.86328, 21.73170,   0.00000, 0.00000, 0.00000, 32), 0, 14383, "burg_1", "wall6", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19460, 1081.09180, -1313.87964, 21.73170,   0.00000, 0.00000, 0.00000, 32), 0, 14383, "burg_1", "wall6", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19460, 1079.64441, -1313.25513, 21.73170,   0.00000, 0.00000, 90.00000, 32), 0, 14383, "burg_1", "wall6", 0);
	//Akcesoria karetki
	CreateDynamicObject(1997, 1080.54089, -1311.06189, 20.32700,   0.00000, 0.00000, 180.00000, 32);
	CreateDynamicObject(2154, 1078.22253, -1310.63220, 20.51420,   0.00000, 0.00000, 90.00000, 32);
	CreateDynamicObject(2151, 1078.21399, -1311.99475, 20.51420,   0.00000, 0.00000, 90.00000, 32);
	CreateDynamicObject(2153, 1078.19128, -1312.69238, 20.51420,   0.00000, 0.00000, 90.00000, 32);
	CreateDynamicObject(2343, 1080.3702, -1312.6514, 21.2414,   0.00000, 0.00000, 180.00000, 32);
	CreateDynamicObject(2709, 1078.10339, -1312.36035, 21.68910,   0.00000, 0.00000, 0.00000, 32);
	CreateDynamicObject(2966, 1078.57813, -1312.34717, 21.59130,   0.00000, 0.00000, 90.00000, 32);
	CreateDynamicObject(2344, 1078.50500, -1312.18420, 21.56580,   0.00000, 0.00000, 90.00000, 32);
	CreateDynamicObject(2685, 1078.06531, -1310.62134, 21.86770,   0.00000, 0.00000, 90.00000, 32);
	CreateDynamicObject(2684, 1078.05981, -1311.28003, 21.80170,   0.00000, 0.00000, 90.00000, 32);
	CreateDynamicObject(2684, 1078.07336, -1311.84863, 21.86770,   0.00000, 0.00000, 90.00000, 32);
	CreateDynamicObject(2687, 1078.07739, -1311.30884, 21.83970,   0.00000, 0.00000, 90.00000, 32);
    CreateDynamicObject(3384, 1081.1053, -1311.9226, 21.9358,   0.00000, 180.00000, 180.00000, 32);
	//Boki úcian
	//SetDynamicObjectMaterial(, 0, 2151, "cj_kitchen", "CJ_RED", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(18762, 1081.49597, -1311.59766, 21.64820,   0.00000, 90.00000, 90.00000, 32), 0, 2151, "cj_kitchen", "CJ_RED", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(18762, 1079.51868, -1313.65698, 21.64820,   0.00000, 90.00000, 0.00000, 32), 0, 2151, "cj_kitchen", "CJ_RED", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(18762, 1077.54077, -1311.59753, 21.64820,   0.00000, 90.00000, 90.00000, 32), 0, 2151, "cj_kitchen", "CJ_RED", 0);
	//Monitory
	//SetDynamicObjectMaterial(, 2, 2151, "cj_kitchen", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(2775, 1078.86194, -1313.16626, 22.60070,   0.00000, 0.00000, 180.00000, 32), 2, 2151, "cj_kitchen", "CJ_WOOD5", 0);
	//Obraz
	CreateDynamicObject(19174, 1079.28503, -1309.10339, 22.29109,   0.00000, 0.00000, 0.00000, 32);
	//Sufit
    SetDynamicObjectMaterial(CreateDynamicObject(19377, 1082.92090, -1313.85168, 23.29000,   0.00000, 90.00000, 0.00000, 32), 0, 14383, "burg_1", "wall6", 0);

	//------------------------------
	//FILLING COUNTRY TOR ØUZLOWY
	//------------------------------

	CreateDynamicObject(1299,-1123.60473633,-1060.97473145,132.61489868,0.00000000,0.00000000,0.00000000,0,0); //object(smashboxpile) (1)
	CreateDynamicObject(10397,-1085.46875000,-991.07128906,132.15216064,0.00000000,0.00000000,0.00000000,0,0); //object(hc_stadlight1_sfs) (1)
	CreateDynamicObject(983,-1056.57409668,-1008.04327393,128.89547729,0.00000000,0.00000000,312.27014160,0,0); //object(fenceshit3) (1)
	CreateDynamicObject(983,-1062.15917969,-1010.52648926,128.89547729,0.00000000,0.00000000,276.63061523,0,0); //object(fenceshit3) (2)
	CreateDynamicObject(983,-1106.94824219,-1010.09082031,128.90229797,0.00000000,0.00000000,265.43518066,0,0); //object(fenceshit3) (5)
	CreateDynamicObject(983,-1052.32653809,-1003.32727051,128.90229797,0.00000000,0.00000000,324.22521973,0,0); //object(fenceshit3) (6)
	CreateDynamicObject(983,-1050.00842285,-997.60729980,128.90229797,0.00000000,0.00000000,352.06005859,0,0); //object(fenceshit3) (7)
	CreateDynamicObject(983,-1049.53588867,-991.26550293,128.90229797,0.00000000,0.00000000,0.00000000,0,0); //object(fenceshit3) (8)
	CreateDynamicObject(983,-1049.99438477,-984.95538330,128.90229797,0.00000000,0.00000000,7.93994141,0,0); //object(fenceshit3) (9)
	CreateDynamicObject(983,-1051.83801270,-978.88220215,128.90229797,0.00000000,0.00000000,25.98498535,0,0); //object(fenceshit3) (10)
	CreateDynamicObject(983,-1055.70507812,-974.13317871,128.90229797,0.00000000,0.00000000,232.42041016,0,0); //object(fenceshit3) (11)
	CreateDynamicObject(983,-1061.43347168,-971.71356201,128.90229797,0.00000000,0.00000000,262.33020020,0,0); //object(fenceshit3) (12)
	CreateDynamicObject(984,-1071.01354980,-971.19677734,128.85542297,0.00000000,0.00000000,269.27026367,0,0); //object(fenceshit2) (2)
	CreateDynamicObject(984,-1083.85681152,-971.11578369,128.85542297,0.00000000,0.00000000,269.56518555,0,0); //object(fenceshit2) (3)
	CreateDynamicObject(984,-1096.49108887,-971.07318115,128.85542297,0.00000000,0.00000000,269.77026367,0,0); //object(fenceshit2) (4)
	CreateDynamicObject(983,-1106.07604980,-971.19903564,128.90229797,0.00000000,0.00000000,272.55029297,0,0); //object(fenceshit3) (13)
	CreateDynamicObject(983,-1112.20898438,-972.52441406,128.90229797,0.00000000,0.00000000,292.28027344,0,0); //object(fenceshit3) (14)
	CreateDynamicObject(983,-1122.74877930,-987.37432861,128.90229797,0.00000000,0.00000000,352.56005859,0,0); //object(fenceshit3) (16)
	CreateDynamicObject(983,-1123.05468750,-993.71582031,128.90229797,0.00000000,0.00000000,2.48291016,0,0); //object(fenceshit3) (17)
	CreateDynamicObject(983,-1121.75830078,-999.95019531,128.90229797,0.00000000,0.00000000,20.59985352,0,0); //object(fenceshit3) (18)
	CreateDynamicObject(983,-1118.41137695,-1005.22924805,128.90229797,0.00000000,0.00000000,222.36035156,0,0); //object(fenceshit3) (19)
	CreateDynamicObject(983,-1112.73315430,-1011.90051270,128.90229797,0.00000000,0.00000000,308.29504395,0,0); //object(fenceshit3) (20)
	CreateDynamicObject(983,-1120.91906738,-981.31469727,128.90229797,0.00000000,0.00000000,333.13513184,0,0); //object(fenceshit3) (21)
	CreateDynamicObject(984,-1071.78222656,-1010.87988281,128.85542297,0.00000000,0.00000000,269.01672363,0,0); //object(fenceshit2) (5)
	CreateDynamicObject(984,-1084.58203125,-1010.70214844,128.85542297,0.00000000,0.00000000,269.47265625,0,0); //object(fenceshit2) (6)
	CreateDynamicObject(984,-1097.35534668,-1010.47167969,128.85542297,0.00000000,0.00000000,268.31518555,0,0); //object(fenceshit2) (7)
	CreateDynamicObject(983,-1117.31872559,-976.11486816,128.90229797,0.00000000,0.00000000,317.08032227,0,0); //object(fenceshit3) (22)
	CreateDynamicObject(1251,-1063.38916016,-998.04370117,128.32344055,0.00000000,0.00000000,331.03002930,0,0); //object(smashbar) (4)
	CreateDynamicObject(1251,-1061.44677734,-991.63232422,128.32344055,0.00000000,0.00000000,355.01501465,0,0); //object(smashbar) (5)
	CreateDynamicObject(1251,-1062.45739746,-985.02264404,128.32344055,0.00000000,0.00000000,23.09985352,0,0); //object(smashbar) (6)
	CreateDynamicObject(1251,-1066.95898438,-981.01269531,128.32344055,0.00000000,0.00000000,76.43188477,0,0); //object(smashbar) (7)
	CreateDynamicObject(3819,-1068.28613281,-965.78027344,129.21650696,0.00000000,0.00000000,87.78625488,0,0); //object(bleacher_sfsx) (1)
	CreateDynamicObject(3819,-1076.90576172,-965.48754883,129.21650696,0.00000000,0.00000000,88.81054688,0,0); //object(bleacher_sfsx) (2)
	CreateDynamicObject(3819,-1094.12292480,-965.56311035,129.21650696,0.00000000,0.00000000,90.31054688,0,0); //object(bleacher_sfsx) (4)
	CreateDynamicObject(3819,-1102.65466309,-965.46459961,129.21650696,0.00000000,0.00000000,90.48004150,0,0); //object(bleacher_sfsx) (5)
	CreateDynamicObject(3819,-1092.03125000,-1014.58013916,129.21650696,0.00000000,0.00000000,270.27026367,0,0); //object(bleacher_sfsx) (7)
	CreateDynamicObject(3819,-1100.68188477,-1014.64532471,129.21650696,0.00000000,0.00000000,270.27026367,0,0); //object(bleacher_sfsx) (8)
	CreateDynamicObject(3819,-1083.41015625,-1014.52539062,129.21650696,0.00000000,0.00000000,270.26916504,0,0); //object(bleacher_sfsx) (10)
	CreateDynamicObject(3819,-1074.79296875,-1014.46289062,129.21650696,0.00000000,0.00000000,270.26916504,0,0); //object(bleacher_sfsx) (11)
	CreateDynamicObject(3819,-1066.14453125,-1014.43945312,129.21650696,0.00000000,0.00000000,270.26916504,0,0); //object(bleacher_sfsx) (12)
	CreateDynamicObject(1251,-1107.46679688,-996.83007812,128.32344055,0.00000000,0.00000000,25.15869141,0,0); //object(smashbar) (14)
	CreateDynamicObject(1251,-1108.65356445,-990.34027100,128.32344055,0.00000000,0.00000000,356.03002930,0,0); //object(smashbar) (15)
	CreateDynamicObject(1251,-1101.27832031,-980.38378906,128.32344055,0.00000000,0.00000000,280.23925781,0,0); //object(smashbar) (17)
	CreateDynamicObject(1251,-1106.61401367,-983.95794678,128.32344055,0.00000000,0.00000000,328.06005859,0,0); //object(smashbar) (18)
	CreateDynamicObject(983,-1118.82678223,-1009.65332031,128.90229797,0.00000000,0.00000000,308.40002441,0,0); //object(fenceshit3) (23)
	CreateDynamicObject(991,-1112.09680176,-1014.11566162,129.43399048,0.00000000,0.00000000,0.00000000,0,0); //object(bar_barriergate1) (1)
	CreateDynamicObject(991,-1108.73974609,-1017.42529297,129.43399048,0.00000000,0.00000000,270.27026367,0,0); //object(bar_barriergate1) (2)
	CreateDynamicObject(991,-1108.66662598,-1024.04602051,129.43399048,0.00000000,0.00000000,270.27026367,0,0); //object(bar_barriergate1) (3)
	CreateDynamicObject(991,-1108.63305664,-1030.74230957,129.43399048,0.00000000,0.00000000,270.27026367,0,0); //object(bar_barriergate1) (4)
	CreateDynamicObject(991,-1111.92871094,-1034.04309082,129.43399048,0.00000000,0.00000000,0.00000000,0,0); //object(bar_barriergate1) (6)
	CreateDynamicObject(991,-1124.16711426,-1013.36389160,129.43399048,0.00000000,0.00000000,32.64498901,0,0); //object(bar_barriergate1) (7)
	CreateDynamicObject(991,-1130.28222656,-1014.88671875,129.43399048,0.00000000,0.00000000,355.53955078,0,0); //object(bar_barriergate1) (8)
	CreateDynamicObject(991,-1118.56555176,-1034.02832031,129.43399048,0.00000000,0.00000000,0.00000000,0,0); //object(bar_barriergate1) (9)
	CreateDynamicObject(991,-1125.27636719,-1034.04101562,129.43399048,0.00000000,0.00000000,350.07507324,0,0); //object(bar_barriergate1) (10)
	CreateDynamicObject(991,-1131.75317383,-1034.05834961,129.43399048,0.00000000,0.00000000,0.00000000,0,0); //object(bar_barriergate1) (11)
	CreateDynamicObject(991,-1135.04162598,-1030.71606445,129.43399048,0.00000000,0.00000000,270.27026367,0,0); //object(bar_barriergate1) (12)
	CreateDynamicObject(991,-1134.20373535,-1017.55596924,129.43399048,0.00000000,0.00000000,253.81536865,0,0); //object(bar_barriergate1) (14)
	CreateDynamicObject(997,-1112.00634766,-1017.31695557,128.21875000,0.00000000,0.00000000,0.00000000,0,0); //object(lhouse_barrier3) (2)
	CreateDynamicObject(997,-1111.96667480,-1020.73608398,128.21875000,0.00000000,0.00000000,0.00000000,0,0); //object(lhouse_barrier3) (3)
	CreateDynamicObject(997,-1111.95800781,-1024.24218750,128.21875000,0.00000000,0.00000000,0.00000000,0,0); //object(lhouse_barrier3) (4)
	CreateDynamicObject(997,-1111.90551758,-1027.45471191,128.21875000,0.00000000,0.00000000,0.00000000,0,0); //object(lhouse_barrier3) (5)
	CreateDynamicObject(997,-1111.93676758,-1030.82385254,128.21875000,0.00000000,0.00000000,0.00000000,0,0); //object(lhouse_barrier3) (6)
	CreateDynamicObject(997,-1115.15319824,-1030.75903320,128.21875000,0.00000000,0.00000000,268.28527832,0,0); //object(lhouse_barrier3) (7)
	CreateDynamicObject(997,-1118.40454102,-1030.71997070,128.21875000,0.00000000,0.00000000,268.28063965,0,0); //object(lhouse_barrier3) (8)
	CreateDynamicObject(997,-1121.81958008,-1030.74731445,128.21875000,0.00000000,0.00000000,268.28063965,0,0); //object(lhouse_barrier3) (9)
	CreateDynamicObject(997,-1125.13708496,-1030.70483398,128.21875000,0.00000000,0.00000000,268.28063965,0,0); //object(lhouse_barrier3) (10)
	CreateDynamicObject(997,-1128.43554688,-1030.74121094,128.21875000,0.00000000,0.00000000,268.27514648,0,0); //object(lhouse_barrier3) (11)
	CreateDynamicObject(997,-1131.58105469,-1030.67968750,128.21875000,0.00000000,0.00000000,268.27514648,0,0); //object(lhouse_barrier3) (12)
	CreateDynamicObject(693,-1035.12866211,-1023.35595703,133.97563171,0.00000000,0.00000000,0.00000000,0,0); //object(sm_redwood_) (1)
	CreateDynamicObject(7606,-1033.32861328,-992.90209961,133.73223877,0.00000000,0.00000000,0.00000000,0,0); //object(vegasbigsign1) (1)
	CreateDynamicObject(694,-1026.03027344,-969.11547852,130.83578491,0.00000000,0.00000000,344.12011719,0,0); //object(sm_redwoodgrp) (1)
	CreateDynamicObject(731,-1115.29394531,-957.65820312,128.21875000,0.00000000,0.00000000,0.00000000,0,0); //object(tree_hipoly09) (1)
	CreateDynamicObject(731,-1049.71362305,-960.44116211,128.21875000,0.00000000,0.00000000,0.00000000,0,0); //object(tree_hipoly09) (2)
	CreateDynamicObject(3578,-1151.46997070,-1013.28668213,128.99678040,0.00000000,0.00000000,0.00000000,0,0); //object(dockbarr1_la) (1)
	CreateDynamicObject(3578,-1146.20739746,-1017.82043457,128.99678040,0.00000000,0.00000000,270.27026367,0,0); //object(dockbarr1_la) (2)
	CreateDynamicObject(3578,-1185.52441406,-1013.23339844,128.99678040,0.00000000,0.00000000,0.00000000,0,0); //object(dockbarr1_la) (3)
	CreateDynamicObject(3578,-1171.68383789,-1060.19787598,128.99678040,0.00000000,0.00000000,0.00000000,0,0); //object(dockbarr1_la) (5)
	CreateDynamicObject(3578,-1181.91613770,-1060.18249512,128.99678040,0.00000000,0.00000000,0.00000000,0,0); //object(dockbarr1_la) (6)
	CreateDynamicObject(3578,-1161.34741211,-1060.19763184,128.99678040,0.00000000,0.00000000,0.00000000,0,0); //object(dockbarr1_la) (7)
	CreateDynamicObject(3578,-1146.18750000,-1028.09277344,128.99678040,0.00000000,0.00000000,270.26916504,0,0); //object(dockbarr1_la) (8)
	CreateDynamicObject(3578,-1146.18652344,-1038.47070312,128.99678040,0.00000000,0.00000000,270.26916504,0,0); //object(dockbarr1_la) (9)
	CreateDynamicObject(3578,-1146.12353516,-1048.77490234,128.99678040,0.00000000,0.00000000,270.77026367,0,0); //object(dockbarr1_la) (10)
	CreateDynamicObject(3578,-1146.05664062,-1056.12109375,128.99678040,0.00000000,0.00000000,270.26916504,0,0); //object(dockbarr1_la) (11)
	CreateDynamicObject(3578,-1150.99060059,-1060.17077637,128.99678040,0.00000000,0.00000000,0.00000000,0,0); //object(dockbarr1_la) (12)
	CreateDynamicObject(3578,-1175.31384277,-1013.24627686,128.99678040,0.00000000,0.00000000,359.99902344,0,0); //object(dockbarr1_la) (13)
	CreateDynamicObject(3578,-1190.25048828,-1041.23559570,128.99678040,0.00000000,0.00000000,270.26916504,0,0); //object(dockbarr1_la) (14)
	CreateDynamicObject(3578,-1190.21789551,-1049.39868164,128.99678040,0.00000000,0.00000000,270.27026367,0,0); //object(dockbarr1_la) (15)
	CreateDynamicObject(3578,-1190.18676758,-1056.04113770,128.99678040,0.00000000,0.00000000,270.26916504,0,0); //object(dockbarr1_la) (16)
	CreateDynamicObject(3578,-1185.26867676,-1060.18371582,128.99678040,0.00000000,0.00000000,0.00000000,0,0); //object(dockbarr1_la) (17)
	CreateDynamicObject(10397,-1082.81616211,-988.13104248,132.15216064,0.00000000,0.00000000,270.27026367,0,0); //object(hc_stadlight1_sfs) (2)
	CreateDynamicObject(3819,-1085.54785156,-965.52111816,129.21650696,0.00000000,0.00000000,90.79290771,0,0); //object(bleacher_sfsx) (13)
	CreateDynamicObject(16132,-1077.76855469,-1018.31054688,128.21875000,0.00000000,0.00000000,270.26916504,0,0); //object(dam_trellis01) (1)
	CreateDynamicObject(16132,-1089.08349609,-958.90325928,127.59579468,0.00000000,0.00000000,90.81036377,0,0); //object(dam_trellis01) (2)
	CreateDynamicObject(2631,-1083.51855469,-1002.90039062,128.21508789,0.00000000,0.00000000,0.00000000,0,0); //object(gym_mat1) (1)
	CreateDynamicObject(2631,-1083.54199219,-1005.14562988,128.21508789,0.00000000,0.00000000,0.00000000,0,0); //object(gym_mat1) (2)
	CreateDynamicObject(2631,-1083.54833984,-1007.26422119,128.21508789,0.00000000,0.00000000,0.00000000,0,0); //object(gym_mat1) (3)
	CreateDynamicObject(2631,-1083.53112793,-1009.58929443,128.21508789,0.00000000,0.00000000,0.00000000,0,0); //object(gym_mat1) (4)
	CreateDynamicObject(1251,-1081.56066895,-1007.43762207,128.17347717,0.00000000,0.00000000,179.73852539,0,0); //object(smashbar) (1)
	CreateDynamicObject(1251,-1081.54785156,-1005.08361816,128.17347717,0.00000000,0.00000000,179.73632812,0,0); //object(smashbar) (1)
	CreateDynamicObject(2735,-1121.29504395,-1000.82049561,128.85209656,0.00000000,0.00000000,107.07556152,0,0); //object(cj_zip_post_4) (1)
	CreateDynamicObject(2047,-1074.44445801,-1010.89733887,128.76382446,0.00000000,0.00000000,180.54052734,0,0); //object(cj_flag1) (1)
	CreateDynamicObject(2048,-1078.28479004,-971.12292480,128.98876953,0.00000000,0.00000000,0.00000000,0,0); //object(cj_flag2) (1)
	CreateDynamicObject(2641,-1123.04663086,-993.03460693,128.85115051,0.00000000,0.00000000,89.73001099,0,0); //object(cj_burger_poster) (1)
	CreateDynamicObject(2716,-1122.97290039,-996.13995361,128.84506226,0.00000000,0.00000000,272.30029297,0,0); //object(cj_don_poster3) (1)
	CreateDynamicObject(2773,-1135.20703125,-1021.75000000,128.73597717,0.00000000,0.00000000,356.02844238,0,0); //object(cj_airprt_bar) (1)
	CreateDynamicObject(2773,-1135.12463379,-1026.49157715,128.73597717,0.00000000,0.00000000,1.98339844,0,0); //object(cj_airprt_bar) (2)
	CreateDynamicObject(987,-1144.94580078,-994.91912842,128.21875000,0.00000000,0.00000000,270.01831055,0,0); //object(elecfence_bar) (5)
	CreateDynamicObject(987,-1144.79003906,-1006.08789062,128.21875000,0.00000000,0.00000000,270.01098633,0,0); //object(elecfence_bar) (6)
	CreateDynamicObject(987,-1144.67895508,-1018.13153076,128.21875000,0.00000000,0.00000000,270.01647949,0,0); //object(elecfence_bar) (7)
	CreateDynamicObject(987,-1151.73803711,-941.14221191,128.21875000,0.00000000,0.00000000,269.89550781,0,0); //object(elecfence_bar) (40)
	CreateDynamicObject(987,-1152.33007812,-965.11132812,128.21875000,0.00000000,0.00000000,247.61334229,0,0); //object(elecfence_bar) (44)
	CreateDynamicObject(987,-1151.83911133,-953.10797119,128.21875000,0.00000000,0.00000000,267.54974365,0,0); //object(elecfence_bar) (45)
	CreateDynamicObject(991,-1133.40856934,-1011.02874756,129.43399048,0.00000000,0.00000000,269.82482910,0,0); //object(bar_barriergate1) (8)
	CreateDynamicObject(991,-1133.50341797,-1004.43542480,129.43399048,0.00000000,0.00000000,269.82421875,0,0); //object(bar_barriergate1) (8)
	CreateDynamicObject(991,-1133.42578125,-997.83203125,129.43399048,0.00000000,0.00000000,269.82421875,0,0); //object(bar_barriergate1) (8)
	CreateDynamicObject(3504,-1119.95043945,-965.37548828,129.56111145,0.00000000,0.00000000,230.38879395,0,0); //object(vgsn_portaloo) (2)
	CreateDynamicObject(3504,-1120.89575195,-966.53955078,129.56111145,0.00000000,0.00000000,230.38879395,0,0); //object(vgsn_portaloo) (3)
	CreateDynamicObject(3504,-1051.36889648,-1015.51202393,129.55429077,0.00000000,0.00000000,39.83493042,0,0); //object(vgsn_portaloo) (4)
	CreateDynamicObject(3504,-1053.69360352,-1017.40051270,129.55429077,0.00000000,0.00000000,39.83093262,0,0); //object(vgsn_portaloo) (6)
	CreateDynamicObject(10401,-1137.84765625,-951.65820312,130.51011658,0.00000000,0.00000000,314.15014648,0,0); //object(hc_shed02_sfs) (1)
	CreateDynamicObject(9314,-1044.89428711,-1002.96008301,129.97892761,0.00000000,0.00000000,326.11999512,0,0); //object(advert01_sfn) (1)
	CreateDynamicObject(1482,-1111.67639160,-1032.61132812,129.65499878,0.00000000,0.00000000,89.73004150,0,0); //object(dyn_garrage1) (1)
	CreateDynamicObject(1482,-1118.33105469,-1032.57910156,129.65499878,0.00000000,0.00000000,89.72534180,0,0); //object(dyn_garrage1) (2)
	CreateDynamicObject(1482,-1125.08691406,-1032.57519531,129.65499878,0.00000000,0.00000000,89.72534180,0,0); //object(dyn_garrage1) (3)
	CreateDynamicObject(1482,-1131.71313477,-1032.53491211,129.65499878,0.00000000,0.00000000,89.72534180,0,0); //object(dyn_garrage1) (4)
	CreateDynamicObject(1482,-1110.00134277,-1030.60656738,129.65499878,0.00000000,0.00000000,179.45520020,0,0); //object(dyn_garrage1) (6)
	CreateDynamicObject(1482,-1109.95629883,-1023.91644287,129.65499878,0.00000000,0.00000000,179.45068359,0,0); //object(dyn_garrage1) (7)
	CreateDynamicObject(1482,-1109.92907715,-1017.33874512,129.65499878,0.00000000,0.00000000,179.45068359,0,0); //object(dyn_garrage1) (8)
	CreateDynamicObject(3465,-1130.93054199,-1018.36309814,129.53425598,0.00000000,0.00000000,0.00000000,0,0); //object(vegspetrolpump) (1)
	CreateDynamicObject(3350,-1106.15319824,-1010.85833740,128.21875000,0.00000000,0.00000000,170.57049561,0,0); //object(torino_mic) (1)
	CreateDynamicObject(3350,-1123.54064941,-1000.22161865,128.21875000,0.00000000,0.00000000,110.74829102,0,0); //object(torino_mic) (2)
	CreateDynamicObject(3350,-1120.96911621,-978.04821777,128.21875000,0.00000000,0.00000000,55.95776367,0,0); //object(torino_mic) (3)
	CreateDynamicObject(3350,-1124.91210938,-990.59765625,128.21875000,0.00000000,0.00000000,85.86337280,0,0); //object(torino_mic) (4)
	CreateDynamicObject(3350,-1046.73132324,-990.34191895,128.21875000,0.00000000,0.00000000,266.39831543,0,0); //object(torino_mic) (5)
	CreateDynamicObject(3350,-1051.23425293,-1006.01947021,128.21875000,0.00000000,0.00000000,226.51660156,0,0); //object(torino_mic) (6)
	CreateDynamicObject(3350,-1050.18151855,-976.01263428,128.21875000,0.00000000,0.00000000,296.30590820,0,0); //object(torino_mic) (7)
	CreateDynamicObject(3039,-1059.29077148,-967.24798584,128.21875000,0.00000000,0.00000000,326.03002930,0,0); //object(ct_stall1) (1)
	CreateDynamicObject(3039,-1059.26147461,-1014.33892822,128.21875000,0.00000000,0.00000000,357.91964722,0,0); //object(ct_stall1) (2)
	CreateDynamicObject(2914,-1064.05749512,-966.99102783,128.98071289,0.00000000,0.00000000,0.00000000,0,0); //object(kmb_rcflag) (2)
	CreateDynamicObject(2914,-1106.98535156,-966.47186279,129.18066406,0.00000000,0.00000000,0.00000000,0,0); //object(kmb_rcflag) (3)
	CreateDynamicObject(2914,-1089.83386230,-966.67657471,129.18066406,0.00000000,0.00000000,0.00000000,0,0); //object(kmb_rcflag) (5)
	CreateDynamicObject(2914,-1081.33300781,-966.77746582,129.18066406,0.00000000,0.00000000,0.00000000,0,0); //object(kmb_rcflag) (6)
	CreateDynamicObject(2993,-1070.51477051,-1014.26794434,129.63197327,0.00000000,0.00000000,0.00000000,0,0); //object(kmb_goflag) (2)
	CreateDynamicObject(2993,-1087.72668457,-1014.41497803,129.30523682,0.00000000,0.00000000,0.00000000,0,0); //object(kmb_goflag) (4)
	CreateDynamicObject(2993,-1104.90039062,-1014.55914307,129.30523682,0.00000000,0.00000000,0.00000000,0,0); //object(kmb_goflag) (6)
	CreateDynamicObject(1281,-1054.10473633,-969.53710938,129.01913452,0.00000000,0.00000000,0.00000000,0,0); //object(parktable1) (1)
	CreateDynamicObject(1281,-1112.44750977,-966.51110840,129.01913452,0.00000000,0.00000000,310.15014648,0,0); //object(parktable1) (2)
	CreateDynamicObject(1342,-1130.17187500,-982.68237305,129.25244141,0.00000000,0.00000000,170.57049561,0,0); //object(noodlecart_prop) (1)
	CreateDynamicObject(1341,-1131.11645508,-985.99792480,129.22134399,0.00000000,0.00000000,258.31518555,0,0); //object(icescart_prop) (1)
	CreateDynamicObject(8322,-1079.14929199,-1322.06884766,133.96124268,0.00000000,0.00000000,0.00000000,0,0); //object(vgsbboardsigns08) (1)
	CreateDynamicObject(8406,-1191.05834961,-1022.20489502,133.74409485,0.00000000,0.00000000,268.33032227,0,0); //object(carparksign01_lvs) (1)
	CreateDynamicObject(987,-1156.89306641,-975.92663574,128.21875000,0.00000000,0.00000000,269.44470215,0,0); //object(elecfence_bar) (44)
	CreateDynamicObject(12921,-1151.40075684,-991.49432373,131.57687378,0.00000000,0.00000000,326.25500488,0,0); //object(sw_farment01) (1)
	CreateDynamicObject(18218,-1171.30578613,-989.86785889,129.20755005,348.08996582,0.00000000,59.55001831,0,0); //object(mtbfence08) (1)
	CreateDynamicObject(18218,-1198.58618164,-995.10778809,128.70755005,346.10504150,0.00000000,53.59133911,0,0); //object(mtbfence08) (2)
	CreateDynamicObject(18218,-1225.84570312,-999.44726562,127.70755005,0.00000000,352.05688477,234.21752930,0,0); //object(mtbfence08) (3)
	CreateDynamicObject(8323,-1194.55175781,-988.29687500,133.54275513,1.98303223,0.00000000,281.86523438,0,0); //object(vgsbboardsigns09) (1)
	CreateDynamicObject(3384,-1144.03723145,-953.86999512,127.41136169,0.00000000,0.00000000,89.32434082,0,0); //object(a51_halbox_) (4)
	CreateDynamicObject(3384,-1143.08618164,-953.84838867,126.91136169,0.00000000,0.00000000,89.32434082,0,0); //object(a51_halbox_) (5)
	CreateDynamicObject(3384,-1145.08581543,-953.92108154,126.93634796,0.00000000,3.97000122,89.32434082,0,0); //object(a51_halbox_) (6)
	CreateDynamicObject(6230,-1180.82226562,-972.48242188,118.89356995,0.00000000,168.72253418,57.56286621,0,0); //object(canaljetty_law) (1)
	CreateDynamicObject(6230,-1182.22436523,-971.77612305,118.89356995,0.00000000,168.72253418,57.56286621,0,0); //object(canaljetty_law) (2)
	CreateDynamicObject(1229,-1200.42333984,-1036.42956543,129.71768188,0.00000000,0.00000000,268.68994141,0,0); //object(bussign1) (1)
	CreateDynamicObject(1368,-1200.28613281,-1038.22363281,128.90849304,0.00000000,0.00000000,275.91064453,0,0); //object(cj_blocker_bench) (1)
	CreateDynamicObject(8150,-1088.72656250,-941.37902832,128.79490662,0.00000000,0.00000000,0.00000000,0,0); //object(vgsselecfence04) (2)
	CreateDynamicObject(8150,-1025.95593262,-986.28643799,128.81983948,0.00000000,0.00000000,270.00000000,0,0); //object(vgsselecfence04) (4)
	CreateDynamicObject(8150,-1082.69775391,-1047.82531738,128.79490662,0.00000000,0.00000000,178.67504883,0,0); //object(vgsselecfence04) (7)
	CreateDynamicObject(987,-1144.66296387,-1030.06677246,128.21875000,0.00000000,0.00000000,270.01098633,0,0); //object(elecfence_bar) (6)
	CreateDynamicObject(987,-1144.66113281,-1036.09399414,128.21875000,0.00000000,0.00000000,270.01098633,0,0); //object(elecfence_bar) (6)
	CreateDynamicObject(1999,-1133.16308594,-1024.78454590,128.21875000,0.00000000,0.00000000,89.73004150,0,0); //object(officedesk2) (1)
	CreateDynamicObject(3578,-1165.52722168,-1013.26440430,128.99678040,0.00000000,0.00000000,0.04406738,0,0); //object(dockbarr1_la) (14)
	CreateDynamicObject(6230,-1189.89013672,-968.69110107,119.14358521,0.00000000,168.72253418,1.80297852,0,0); //object(canaljetty_law) (1)
	CreateDynamicObject(11479,-1078.77954102,-986.84320068,128.21875000,0.00000000,0.00000000,89.63989258,0,0); //object(des_nwtfescape) (1)
	//CreateDynamicObject(11479,-1088.07751465,-995.29974365,128.21875000,0.00000000,0.00000000,269.09729004,0,0); //object(des_nwtfescape) (2)
	CreateDynamicObject(982,-1086.96472168,-1001.17846680,128.32743835,0.00000000,0.00000000,270.27026367,0,0); //object(fenceshit) (2)
	CreateDynamicObject(982,-1085.11828613,-979.72094727,128.32743835,0.00000000,0.00000000,270.27026367,0,0); //object(fenceshit) (3)
	CreateDynamicObject(983,-1102.89099121,-1000.56329346,128.32743835,0.00000000,0.00000000,258.08776855,0,0); //object(fenceshit3) (19)
	CreateDynamicObject(983,-1107.56372070,-996.73785400,128.32743835,0.00000000,0.00000000,205.00036621,0,0); //object(fenceshit3) (19)
	CreateDynamicObject(983,-1108.65393066,-990.28405762,128.32743835,0.00000000,0.00000000,175.95959473,0,0); //object(fenceshit3) (19)
	CreateDynamicObject(983,-1106.60815430,-983.86206055,128.32743835,0.00000000,0.00000000,148.32702637,0,0); //object(fenceshit3) (19)
	CreateDynamicObject(983,-1101.35437012,-980.41247559,128.32743835,0.00000000,0.00000000,100.42153931,0,0); //object(fenceshit3) (19)
	CreateDynamicObject(1251,-1102.70031738,-1000.64776611,128.19847107,0.00000000,0.00000000,258.40441895,0,0); //object(smashbar) (17)
	CreateDynamicObject(1251,-1068.41723633,-1001.17681885,128.19847107,0.00000000,0.00000000,274.28381348,0,0); //object(smashbar) (17)
	CreateDynamicObject(983,-1068.43432617,-1001.14672852,128.32743835,0.00000000,0.00000000,274.16540527,0,0); //object(fenceshit3) (14)
	CreateDynamicObject(983,-1063.44445801,-998.07177734,128.32743835,0.00000000,0.00000000,331.09851074,0,0); //object(fenceshit3) (14)
	CreateDynamicObject(983,-1061.51220703,-991.68395996,128.32743835,0.00000000,0.00000000,353.94482422,0,0); //object(fenceshit3) (14)
	CreateDynamicObject(983,-1062.48364258,-985.00469971,128.32743835,0.00000000,0.00000000,22.98083496,0,0); //object(fenceshit3) (14)
	CreateDynamicObject(983,-1066.96740723,-981.02557373,128.32743835,0.00000000,0.00000000,75.97271729,0,0); //object(fenceshit3) (14)
	CreateDynamicObject(983,-1073.06408691,-981.19635010,128.32743835,0.00000000,0.00000000,287.14819336,0,0); //object(fenceshit3) (14)
	CreateDynamicObject(983,-1074.03808594,-999.28381348,128.32743835,0.00000000,0.00000000,228.28393555,0,0); //object(fenceshit3) (14)
	CreateDynamicObject(1427,-1072.02856445,-1001.04370117,128.76589966,0.00000000,0.00000000,312.18017578,0,0); //object(cj_roadbarrier) (1)
	CreateDynamicObject(1427,-1070.96704102,-980.38562012,128.76589966,0.00000000,0.00000000,53.90637207,0,0); //object(cj_roadbarrier) (2)

	//obikty przyczepy
	CreateDynamicObject(7657,-1.82410000,-0.60330000,999.26630000,0.00000000,0.00000000,270.36020000); //
	CreateDynamicObject(7657,-1.34500000,7.55420000,999.26630000,0.00000000,0.00000000,180.62710000); //
	CreateDynamicObject(7657,2.57110000,0.95950000,999.26630000,0.00000000,0.00000000,89.00130000); //
	CreateDynamicObject(1685,-1.67430000,6.28040000,999.17840000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(7657,4.38200000,-6.50650000,999.01630000,0.00000000,0.00000000,357.69070000); //
	CreateDynamicObject(7657,2.03510000,-6.10010000,998.36650000,270.27000000,248.16980000,246.35910000); //

	//obiekty wodnych domÛw
	CreateDynamicObject(16000,655.50292969,-2030.10449219,0.75000000,90.00000000,0.00000000,0.00000000,0,0); //object(drvin_screen) (1)
	CreateDynamicObject(16000,655.51531982,-2051.39062500,0.75000000,90.00000000,0.00000000,180.00000000,0,0); //object(drvin_screen) (2)
	CreateDynamicObject(2782,663.85253906,-2032.21374512,1.04672658,0.00000000,0.00000000,142.92004395,0,0); //object(cj_oyster_2) (1)
	CreateDynamicObject(2406,662.76452637,-2032.91369629,0.90371013,271.94494629,1.98498535,19.85000610,0,0); //object(cj_surf_board3) (1)
	CreateDynamicObject(1461,647.45159912,-2031.81103516,1.55469191,0.00000000,0.00000000,176.85498047,0,0); //object(dyn_life_p) (1)
	CreateDynamicObject(1461,663.16552734,-2049.86743164,1.55469191,0.00000000,0.00000000,359.29748535,0,0); //object(dyn_life_p) (2)
	CreateDynamicObject(1243,625.11175537,-2039.60620117,-3.00000000,0.00000000,0.00000000,0.00000000,0,0); //object(bouy) (1)
	CreateDynamicObject(6962,655.35083008,-2041.41076660,7.25963211,0.00000000,0.00000000,0.00000000,0,0); //object(vgsnwedchap1) (1)
	CreateDynamicObject(1810,647.86547852,-2045.49108887,0.75347805,0.00000000,0.00000000,324.26998901,0,0); //object(cj_foldchair) (1)
	CreateDynamicObject(1810,653.34802246,-2047.06970215,0.75347805,0.00000000,0.00000000,324.26696777,0,0); //object(cj_foldchair) (2)
	CreateDynamicObject(1810,650.87084961,-2046.01391602,0.75347805,0.00000000,0.00000000,324.26696777,0,0); //object(cj_foldchair) (3)
	CreateDynamicObject(2121,649.00921631,-2045.25927734,1.25000000,0.00000000,0.00000000,0.00000000,0,0); //object(low_din_chair_2) (1)
	CreateDynamicObject(2121,652.89611816,-2045.16345215,1.25000000,0.00000000,0.00000000,304.41998291,0,0); //object(low_din_chair_2) (2)
	CreateDynamicObject(1827,652.00640869,-2046.30017090,0.75347817,0.00000000,0.00000000,0.00000000,0,0); //object(man_sdr_tables) (1)
	CreateDynamicObject(1598,647.73352051,-2047.42053223,1.05847836,0.00000000,0.00000000,0.00000000,0,0); //object(beachball) (1)
	CreateDynamicObject(1610,649.79809570,-2048.64965820,0.75347859,0.00000000,0.00000000,0.00000000,0,0); //object(sandcastle1) (1)
	CreateDynamicObject(1611,649.14599609,-2048.80517578,0.75347859,0.00000000,0.00000000,0.00000000,0,0); //object(sandcastle2) (1)
	CreateDynamicObject(1640,646.36578369,-2047.23828125,0.75347859,0.00000000,0.00000000,158.80004883,0,0); //object(beachtowel04) (1)
	CreateDynamicObject(1641,651.46154785,-2049.78979492,0.75347877,0.00000000,0.00000000,300.40499878,0,0); //object(beachtowel03) (1)
	CreateDynamicObject(1643,647.88995361,-2049.48657227,0.75347871,0.00000000,0.00000000,27.79000854,0,0); //object(beachtowel01) (1)
	CreateDynamicObject(2404,648.74951172,-2043.92614746,2.02871013,338.16485596,0.00000000,326.25500488,0,0); //object(cj_surf_board) (1)
	CreateDynamicObject(1484,645.87872314,-2044.13159180,0.00000000,0.00000000,0.00000000,0.00000000,0,0); //object(cj_bear_bottle) (1)
	CreateDynamicObject(1544,651.96356201,-2045.82067871,1.00347805,0.00000000,0.00000000,0.00000000,0,0); //object(cj_beer_b_1) (1)
	CreateDynamicObject(1544,652.42272949,-2046.65356445,1.00347805,0.00000000,0.00000000,0.00000000,0,0); //object(cj_beer_b_1) (2)
	CreateDynamicObject(1428,644.52343750,-2040.02929688,0.00000000,0.00000000,0.00000000,270.36254883,0,0); //object(dyn_ladder) (1)
	CreateDynamicObject(1428,650.31127930,-2029.79626465,0.00000000,0.00000000,0.00000000,178.65112305,0,0); //object(dyn_ladder) (2)
	CreateDynamicObject(1428,658.45202637,-2029.80468750,0.00000000,0.00000000,0.00000000,182.61865234,0,0); //object(dyn_ladder) (3)
	CreateDynamicObject(1641,651.59802246,-2032.96533203,0.75347853,0.00000000,0.00000000,219.34002686,0,0); //object(beachtowel03) (2)
	CreateDynamicObject(3615,684.54681396,-2044.55041504,1.25000000,0.00000000,0.00000000,231.75250244,0,0); //object(sanmonbhut1_law2) (1)
	CreateDynamicObject(954,658.72137451,-2037.07409668,12.02164268,0.00000000,0.00000000,0.00000000,0,0); //object(cj_horse_shoe) (1)
	CreateDynamicObject(7096,685.36328125,-2043.97753906,4.39265156,0.00000000,2.99926758,270.00000000,0,0); //object(vrockstairs) (1)
	CreateDynamicObject(11497,675.77612305,-2046.54003906,6.11413145,0.00000000,0.00000000,0.00000000,0,0); //object(des_baitshop) (1)
	CreateDynamicObject(1637,675.36383057,-2044.94677734,0.75000000,0.00000000,0.00000000,178.86999512,0,0); //object(od_pat_hutb) (1)
	CreateDynamicObject(1645,689.77008057,-2048.87329102,4.11508226,0.00000000,0.00000000,148.87503052,0,0); //object(lounge_wood_up) (1)
	CreateDynamicObject(1950,690.57666016,-2049.63037109,3.97110200,0.00000000,0.00000000,7.94000244,0,0); //object(kb_beer) (1)
	CreateDynamicObject(1950,690.15307617,-2050.26416016,3.97110200,0.00000000,0.00000000,7.93762207,0,0); //object(kb_beer) (2)
	CreateDynamicObject(1717,681.15527344,-2049.22045898,6.62194395,0.00000000,0.00000000,131.32501221,0,0); //object(telly_low_test) (1)
	CreateDynamicObject(2096,680.37634277,-2048.28320312,6.62194395,0.00000000,0.00000000,0.00000000,0,0); //object(cj_rockingchair) (1)
	CreateDynamicObject(3599,682.97393799,-2056.73291016,2.72874451,0.00000000,0.00000000,0.00000000,0,0); //object(hillhouse02_la) (1)
	CreateDynamicObject(1598,687.25573730,-2049.13183594,4.08793449,0.00000000,0.00000000,0.00000000,0,0); //object(beachball) (2)
	CreateDynamicObject(9361,698.81188965,-2052.77661133,2.80000305,0.00000000,0.00000000,45.63891602,0,0); //object(boatoffice_sfn) (1)
	CreateDynamicObject(1428,701.32177734,-2053.50976562,-0.75000000,0.00000000,0.00000000,0.00000000,0,0); //object(dyn_ladder) (4)
	CreateDynamicObject(9362,698.23352051,-2054.74047852,1.17603445,0.00000000,0.00000000,268.46997070,0,0); //object(boatoffice2_sfn) (1)
	CreateDynamicObject(3050,697.76074219,-2057.06567383,-1.83695769,180.00000000,0.00000000,0.00000000,0,0); //object(des_quarrygate2) (1)
	CreateDynamicObject(3050,700.54150391,-2057.07666016,-1.83695769,179.99450684,0.00000000,0.00000000,0,0); //object(des_quarrygate2) (2)
	CreateDynamicObject(3050,700.59899902,-2052.46801758,-1.83695769,179.99450684,0.00000000,89.32501221,0,0); //object(des_quarrygate2) (3)
	CreateDynamicObject(3050,700.58056641,-2048.45434570,-1.83695769,179.99450684,0.00000000,89.32434082,0,0); //object(des_quarrygate2) (5)
	CreateDynamicObject(3050,696.00054932,-2048.46386719,-1.83695769,179.99450684,0.00000000,180.00000000,0,0); //object(des_quarrygate2) (6)
	CreateDynamicObject(3050,695.49444580,-2048.46191406,-1.83695769,179.99450684,0.00000000,179.99450684,0,0); //object(des_quarrygate2) (7)
	CreateDynamicObject(3050,695.47100830,-2048.45336914,-1.83695769,179.99450684,0.00000000,88.68447876,0,0); //object(des_quarrygate2) (8)
	CreateDynamicObject(3061,692.27124023,-2060.09838867,1.47188568,0.00000000,0.00000000,268.68997192,0,0); //object(ad_flatdoor) (1)
	CreateDynamicObject(3061,671.26513672,-2060.08056641,1.47188568,0.00000000,0.00000000,268.68713379,0,0); //object(ad_flatdoor) (2)
	CreateDynamicObject(1428,693.82055664,-2065.29516602,-0.80460310,0.00000000,0.00000000,0.00000000,0,0); //object(dyn_ladder) (5)
	CreateDynamicObject(1428,673.34106445,-2062.58544922,-0.16821909,0.00000000,0.00000000,0.00000000,0,0); //object(dyn_ladder) (6)
	CreateDynamicObject(1810,685.77142334,-2061.59155273,0.28293705,0.00000000,0.00000000,330.22500610,0,0); //object(cj_foldchair) (5)
	CreateDynamicObject(2121,684.13732910,-2061.24316406,0.79620671,0.00000000,0.00000000,0.00000000,0,0); //object(low_din_chair_2) (3)
	CreateDynamicObject(2121,691.79901123,-2063.55908203,0.79620671,0.00000000,0.00000000,27.79000854,0,0); //object(low_din_chair_2) (4)
	CreateDynamicObject(9583,670.43786621,-2042.48132324,6.40169573,0.00000000,180.00000000,0.00000000,0,0); //object(freight_sfw15) (1)
	CreateDynamicObject(2669,677.59436035,-2045.08618164,7.64500904,0.00000000,0.00000000,0.00000000,0,0); //object(cj_chris_crate) (1)
	CreateDynamicObject(2669,674.46148682,-2045.09277344,7.64500904,0.00000000,0.00000000,0.00000000,0,0); //object(cj_chris_crate) (2)
	CreateDynamicObject(2669,671.81561279,-2045.16589355,7.64500904,0.00000000,0.00000000,0.00000000,0,0); //object(cj_chris_crate) (3)
	CreateDynamicObject(2669,671.82666016,-2047.75109863,7.64500904,0.00000000,0.00000000,0.00000000,0,0); //object(cj_chris_crate) (4)
	CreateDynamicObject(2669,675.43157959,-2047.64965820,7.64500904,0.00000000,0.00000000,0.00000000,0,0); //object(cj_chris_crate) (5)
	CreateDynamicObject(2669,677.50292969,-2047.69848633,7.64500904,0.00000000,0.00000000,0.00000000,0,0); //object(cj_chris_crate) (6)
	CreateDynamicObject(2669,674.05444336,-2047.70202637,7.64500904,0.00000000,0.00000000,0.00000000,0,0); //object(cj_chris_crate) (7)
	CreateDynamicObject(5153,680.24603271,-2044.46582031,6.05353785,0.00000000,21.83499146,89.32501221,0,0); //object(stuntramp7_las2) (1)
	CreateDynamicObject(5153,680.15112305,-2048.28613281,6.05353785,0.00000000,21.82983398,89.32434082,0,0); //object(stuntramp7_las2) (2)
	CreateDynamicObject(9583,670.52465820,-2050.21069336,6.40169573,0.00000000,179.99450684,0.00000000,0,0); //object(freight_sfw15) (2)
	CreateDynamicObject(9583,678.51873779,-2043.77050781,6.40169573,0.00000000,179.99450684,0.00000000,0,0); //object(freight_sfw15) (3)


	//-----------------------------------------------------------------------------------------------------------------------
	//=======================================================================================================================
	//                                                      !!!!!!!!!!
	//                                                      !!!!!!!!!!
	//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-Nowe-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-Obiekty-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-Micha≥a-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	//                                                     !!!!!!!!!!!
	//                                                     !!!!!!!!!!!
	//=======================================================================================================================
	//-----------------------------------------------------------------------------------------------------------------------

	//kasyno

	CreateDynamicObject(14777,1025.09863281,-1090.54479980,-68.58067322,0.00000000,0.00000000,0.00000000,0,-1); //object(int_5weecasino)(1)
	CreateDynamicObject(1978,1038.22924805,-1090.59741211,-67.52223969,0.00000000,0.00000000,0.00000000,0,-1); //object(roulette_tbl)(1)
	CreateDynamicObject(1979,1038.03723145,-1089.24353027,-67.56449127,0.00000000,0.00000000,0.00000000,0,-1); //object(wheel_wee)(1)
	CreateDynamicObject(3441,1022.25384521,-1078.31713867,-66.89556885,0.00000000,0.00000000,0.00000000,0,-1); //object(luxorpillar02_lvs)(1)
	CreateDynamicObject(3441,1027.78942871,-1078.06701660,-66.89556885,0.00000000,0.00000000,0.00000000,0,-1); //object(luxorpillar02_lvs)(2)
	CreateDynamicObject(2188,1032.69775391,-1092.17980957,-67.58734131,0.00000000,0.00000000,0.29998779,0,-1); //object(blck_jack)(2)
	CreateDynamicObject(2188,1032.90014648,-1088.91455078,-67.58734131,0.00000000,0.00000000,182.76977539,0,-1); //object(blck_jack)(3)
	CreateDynamicObject(1940,1038.77111816,-1089.34826660,-67.62655640,0.00000000,0.00000000,0.00000000,0,-1); //object(chip_stack18)(1)
	CreateDynamicObject(14628,1022.55377197,-1123.24560547,34.72611618,0.00000000,0.00000000,180.72033691,0,-1); //object(ab_caligulasfront)(2)
	CreateDynamicObject(1824,1027.83227539,-1090.66784668,-68.06187439,0.00000000,0.00000000,270.39624023,0,-1); //object(craps_table)(1)
	CreateDynamicObject(2188,1023.03601074,-1092.15148926,-67.58734131,0.00000000,0.00000000,0.29663086,0,-1); //object(blck_jack)(4)
	CreateDynamicObject(2188,1022.98620605,-1088.74023438,-67.58734131,0.00000000,0.00000000,182.76855469,0,-1); //object(blck_jack)(5)
	CreateDynamicObject(1896,1016.93560791,-1101.91369629,-67.59101868,0.00000000,0.00000000,180.06140137,0,-1); //object(wheel_table)(1)
	CreateDynamicObject(1895,1016.82763672,-1104.35888672,-66.24333954,0.00000000,0.00000000,183.20422363,0,-1); //object(wheel_o_fortune)(2)
	CreateDynamicObject(2785,1021.37579346,-1081.06652832,-67.72838593,0.00000000,0.00000000,0.00000000,0,-1); //object(cj_slot_bank)(2)
	CreateDynamicObject(14651,1023.19293213,-1099.26379395,-64.98812103,0.00000000,0.00000000,270.39611816,0,-1); //object(trukstp05)(1)
	CreateDynamicObject(14651,1034.75598145,-1099.10900879,-64.98812103,0.00000000,0.00000000,270.39550781,0,-1); //object(trukstp05)(2)

	//Obiekty plantacji groove street

	CreateDynamicObject(3261,-1027.67187500,-2142.84082031,33.13838959,0.00000000,0.00000000,359.99450684,0,0); //object(grasshouse)(3)
	CreateDynamicObject(3261,-1027.75390625,-2145.87988281,33.13838959,0.00000000,0.00000000,359.98901367,0,0); //object(grasshouse)(6)
	CreateDynamicObject(3261,-1027.71801758,-2161.40234375,33.13838959,0.00000000,0.00000000,359.99450684,0,0); //object(grasshouse)(8)
	CreateDynamicObject(3261,-1027.75585938,-2158.36083984,33.13838959,0.00000000,0.00000000,359.99450684,0,0); //object(grasshouse)(9)
	CreateDynamicObject(3261,-1027.83410645,-2155.30957031,33.13838959,0.00000000,0.00000000,359.99450684,0,0); //object(grasshouse)(10)
	CreateDynamicObject(3171,-1006.02148438,-2149.87109375,34.17082596,0.00000000,0.00000000,133.99475098,0,0); //object(trailer5_01)(1)
	CreateDynamicObject(1765,-1003.08691406,-2150.38964844,34.33689117,0.00000000,0.00000000,0.00000000,0,0); //object(low_single_2)(1)
	CreateDynamicObject(1765,-1005.28607178,-2152.27001953,34.33689117,0.00000000,0.00000000,54.00000000,0,0); //object(low_single_2)(2)
	CreateDynamicObject(3409,-1027.60253906,-2141.62817383,33.16560364,0.00000000,0.00000000,0.00000000,0,0); //object(grassplant)(2)
	CreateDynamicObject(3409,-1027.77111816,-2146.23461914,33.14278793,0.00000000,0.00000000,0.00000000,0,0); //object(grassplant)(3)
	CreateDynamicObject(3409,-1027.77050781,-2146.23437500,33.14278793,0.00000000,0.00000000,0.00000000,0,0); //object(grassplant)(4)
	CreateDynamicObject(3261,-1027.78417969,-2148.95874023,33.19521332,0.00000000,0.00000000,0.00000000,0,0); //object(grasshouse)(1)
	CreateDynamicObject(3409,-1028.18359375,-2154.61230469,32.51389694,0.00000000,0.00000000,0.00000000,0,0); //object(grassplant)(5)
	CreateDynamicObject(3409,-1027.79736328,-2158.02465820,33.29428101,0.00000000,0.00000000,0.00000000,0,0); //object(grassplant)(6)
	CreateDynamicObject(3409,-1021.63256836,-2146.52026367,33.41906738,0.00000000,0.00000000,0.00000000,0,0); //object(grassplant)(7)
	CreateDynamicObject(3409,-1021.88287354,-2154.90698242,33.44141388,0.00000000,0.00000000,0.00000000,0,0); //object(grassplant)(9)
	CreateDynamicObject(2901,-1022.34930420,-2158.46484375,33.91813278,0.00000000,0.00000000,0.00000000,0,0); //object(kmb_marijuana)(6)
	CreateDynamicObject(2901,-1022.29565430,-2159.46386719,33.91813278,0.00000000,0.00000000,0.00000000,0,0); //object(kmb_marijuana)(7)
	CreateDynamicObject(2901,-1019.18627930,-2143.52563477,33.98569870,0.00000000,0.00000000,46.00000000,0,0); //object(kmb_marijuana)(8)
	CreateDynamicObject(2901,-1018.51147461,-2144.12353516,33.98569870,0.00000000,0.00000000,45.99975586,0,0); //object(kmb_marijuana)(9)
	CreateDynamicObject(2971,-1013.57470703,-2160.10546875,33.70969009,0.00000000,0.00000000,0.00000000,0,0); //object(k_smashboxes)(1)
	CreateDynamicObject(3262,-963.74981689,-2309.09741211,56.75573730,0.00000000,0.00000000,30.00000000,0,0); //object(privatesign1)(1)
	CreateDynamicObject(1481,-1001.14025879,-2151.65942383,34.98217010,0.00000000,0.00000000,302.00000000,0,0); //object(dyn_bar_b_q)(1)
	CreateDynamicObject(1820,-1003.27868652,-2152.59814453,34.26336670,0.00000000,0.00000000,0.00000000,0,0); //object(coffee_low_4)(1)
	CreateDynamicObject(3407,-998.21612549,-2150.77368164,34.29445648,0.00000000,0.00000000,92.00000000,0,0); //object(ce_mailbox1)(1)

	//bankomaty
	CreateDynamicObject(2942,2127.66210938,-1153.92480469,23.48433304,0.00000000,0.00000000,204.25781250,0,0); //object(kmb_atm1)(1)
	CreateDynamicObject(2942,1040.38732910,-1131.23059082,23.46322632,0.00000000,0.00000000,1.98498535,0,0); //object(kmb_atm1)(2)
	CreateDynamicObject(2942,1493.25781250,-1022.13476562,23.46905136,0.00000000,0.00000000,2.21374512,0,0); //object(kmb_atm1)(4)
	CreateDynamicObject(2942,2842.70239258,-1562.88049316,10.73664951,0.00000000,0.00000000,89.73001099,0,0); //object(kmb_atm1)(5)
	CreateDynamicObject(2942,2072.01953125,-1825.50097656,13.18977451,0.00000000,0.00000000,91.71386719,0,0); //object(kmb_atm1)(6)
	CreateDynamicObject(2942,1928.63220215,-1768.14794922,13.18977451,0.00000000,0.00000000,89.59005737,0,0); //object(kmb_atm1)(8)
	CreateDynamicObject(2942,1787.46899414,-1867.33886719,13.21315384,0.00000000,0.00000000,176.70500183,0,0); //object(kmb_atm1)(9)
	CreateDynamicObject(2942,852.48236084,-2061.84008789,12.51009178,0.00000000,0.00000000,268.64990234,0,0); //object(kmb_atm1)(10)
	CreateDynamicObject(2942,341.01486206,-1517.85717773,32.83914185,0.00000000,0.00000000,50.26000977,0,0); //object(kmb_atm1)(11)
	CreateDynamicObject(2942,2701.67407227,-2417.54223633,13.27571201,0.00000000,0.00000000,181.16995239,0,0); //object(kmb_atm1)(12)
	CreateDynamicObject(2942,1186.23657227,-1368.89025879,13.30330658,0.00000000,0.00000000,91.31002808,0,0); //object(kmb_atm1)(14)
	CreateDynamicObject(2942,1505.09997559,-1755.40002441,13.19999981,0.00000000,0.00000000,180.00000000,0,0); //object(kmb_atm1) (1) bakomat przy dmv
	CreateDynamicObject(2943,1497.40002441,-1825.40002441,12.89999962,0.00000000,86.00000000,236.00000000,0,0); //object(kmb_atm2) (1) zniszczony bankomat
		//PAèDZIOCH
	CreateDynamicObject(19324, 2423.41968, -2066.13257, 13.16730,   0.00000, 0.00000, -90.00000); // Pod KT
	CreateDynamicObject(19324, 1001.01910, -923.60107, 41.94500,   0.00000, 0.00000, -80.00000); // Stacja Temple
	CreateDynamicObject(19324, 388.61719, -1806.26758, 7.45220,   0.00000, 0.00000, -140.00000); // Pod ibizπ
	CreateDynamicObject(19324, 647.26550, -1368.86865, 13.26730,   0.00000, 0.00000, -90.00000); // Pod San News
	CreateDynamicObject(19324, 661.38593, -575.82269, 15.95790,   0.00000, 0.00000, -90.00000); // Stacja Dillmore
	CreateDynamicObject(19324, 2273.16821, -76.34060, 26.18810,   0.00000, 0.00000, 0.00000); // Urzπd PC

	//obiekrt groove (blokada groove st.)

	CreateDynamicObject(1227,2482.93310547,-1720.03381348,13.39984512,0.00000000,0.00000000,268.46545410,0,0); //object(dump1)(2)
	CreateDynamicObject(1344,2478.10180664,-1719.41088867,13.35504723,0.00000000,0.00000000,83.63983154,0,0); //object(cj_dumpster2)(1)
	CreateDynamicObject(2676,2480.53295898,-1719.32202148,12.64977169,0.00000000,0.00000000,302.25524902,0,0); //object(proc_rubbish_8)(2)
	CreateDynamicObject(1344,2478.50292969,-1716.42639160,13.35504723,0.00000000,0.00000000,89.59387207,0,0); //object(cj_dumpster2)(2)
	CreateDynamicObject(1345,2481.09301758,-1716.47033691,13.31220436,0.00000000,0.00000000,326.21008301,0,0); //object(cj_dumpster)(1)

	//obiekty molo

	CreateDynamicObject(982,840.12359619,-2067.45190430,12.56494236,0.00000000,0.00000000,270.00000000,0,0); //object(fenceshit)(1)
	CreateDynamicObject(983,822.73809814,-2067.42407227,12.55074215,0.00000000,0.00000000,90.33474731,0,0); //object(fenceshit3)(1)
	CreateDynamicObject(8373,826.53808594,-2100.70117188,-18.88339043,0.00000000,0.00000000,0.00000000,0,0); //object(vegass_jetty01)(1)
	CreateDynamicObject(8378,821.61492920,-2087.26391602,1.94726562,0.00000000,0.00000000,0.00000000,0,0); //object(vgsbighngrdoor)(1)
	CreateDynamicObject(8378,831.48651123,-2086.51586914,1.94726562,0.00000000,0.00000000,0.00000000,0,0); //object(vgsbighngrdoor)(2)
	CreateDynamicObject(3041,820.36309814,-2105.53564453,9.05418110,0.00000000,0.00000000,0.00000000,0,0); //object(ct_table)(1)
	CreateDynamicObject(1281,794.56677246,-2104.90722656,9.66595459,0.00000000,0.00000000,337.18798828,0,0); //object(parktable1)(1)
	CreateDynamicObject(738,824.31408691,-2108.08251953,9.60914040,0.00000000,0.00000000,0.00000000,0,0); //object(aw_streettree2)(1)
	CreateDynamicObject(3039,812.04772949,-2105.38256836,8.86660957,0.00000000,0.00000000,0.00000000,0,0); //object(ct_stall1)(1)
	CreateDynamicObject(1340,807.46044922,-2095.45361328,9.99315834,0.00000000,0.00000000,304.44067383,0,0); //object(chillidogcart)(1)
	CreateDynamicObject(2600,792.88513184,-2109.10034180,9.63888168,0.00000000,0.00000000,0.00000000,0,0); //object(cj_view_tele)(1)
	CreateDynamicObject(3472,833.61322021,-2123.00170898,3.02322626,0.00000000,0.00000000,57.48574829,0,0); //object(circuslampost03)(1)
	CreateDynamicObject(3877,711.74371338,-1931.74560547,0.33480635,0.00000000,0.00000000,0.00000000,0,0); //object(sf_rooflite)(1)
	CreateDynamicObject(6965,1479.84179688,-1640.89355469,15.63641930,0.00000000,0.00000000,0.00000000,0,0); //object(venefountain02)(1)
	CreateDynamicObject(2600,801.62359619,-2109.09375000,9.63888168,0.00000000,0.00000000,0.00000000,0,0); //object(cj_view_tele)(2)
	CreateDynamicObject(2600,811.87841797,-2108.97705078,9.63888168,0.00000000,0.00000000,0.00000000,0,0); //object(cj_view_tele)(3)
	CreateDynamicObject(2600,821.66955566,-2108.93847656,9.63888168,0.00000000,0.00000000,0.00000000,0,0); //object(cj_view_tele)(4)
	CreateDynamicObject(3877,736.69995117,-1920.65002441,0.33480635,0.00000000,0.00000000,0.00000000,0,0); //object(sf_rooflite)(2)
	CreateDynamicObject(3877,810.26153564,-2072.57446289,0.33480635,0.00000000,0.00000000,0.00000000,0,0); //object(sf_rooflite)(10)
	CreateDynamicObject(738,807.21148682,-2107.93432617,9.60914040,0.00000000,0.00000000,0.00000000,0,0); //object(aw_streettree2)(2)
	CreateDynamicObject(738,790.04003906,-2108.29663086,9.60914040,0.00000000,0.00000000,0.00000000,0,0); //object(aw_streettree2)(3)
	CreateDynamicObject(738,790.41381836,-2094.21508789,9.60914040,0.00000000,0.00000000,0.00000000,0,0); //object(aw_streettree2)(4)
	CreateDynamicObject(3920,794.61212158,-2092.29003906,10.90162086,0.00000000,0.00000000,0.00000000,0,0); //object(lib_veg3)(1)
	CreateDynamicObject(3920,807.23193359,-2092.26220703,10.90162086,0.00000000,0.00000000,0.00000000,0,0); //object(lib_veg3)(2)
	CreateDynamicObject(3920,816.41491699,-2092.45019531,11.00784492,0.00000000,0.00000000,0.00000000,0,0); //object(lib_veg3)(3)
	CreateDynamicObject(9833,832.48034668,-2076.20678711,15.11016273,0.00000000,0.00000000,0.00000000,0,0); //object(fountain_sfw)(2)
	CreateDynamicObject(1341,814.13012695,-2095.13720703,9.86815834,0.00000000,0.00000000,259.57727051,0,0); //object(icescart_prop)(1)
	CreateDynamicObject(1342,820.35961914,-2095.19506836,9.89926529,0.00000000,0.00000000,271.54077148,0,0); //object(noodlecart_prop)(1)
	CreateDynamicObject(1223,842.03192139,-2072.00805664,11.90567207,0.00000000,0.00000000,180.66955566,0,0); //object(lampost_coast)(1)
	CreateDynamicObject(1223,841.83288574,-2082.53906250,11.90567207,0.00000000,0.00000000,180.66467285,0,0); //object(lampost_coast)(2)
	CreateDynamicObject(1223,824.39788818,-2082.07348633,11.90567207,0.00000000,0.00000000,1.33459473,0,0); //object(lampost_coast)(3)
	CreateDynamicObject(1223,824.01208496,-2071.81298828,11.90567207,0.00000000,0.00000000,1.32934570,0,0); //object(lampost_coast)(4)
	CreateDynamicObject(1231,820.87591553,-2100.22583008,11.59700203,0.00000000,0.00000000,84.65716553,0,0); //object(streetlamp2)(1)
	CreateDynamicObject(1231,809.20397949,-2100.06054688,11.59700203,0.00000000,0.00000000,84.65515137,0,0); //object(streetlamp2)(2)
	CreateDynamicObject(1231,793.89318848,-2099.65136719,11.59700203,0.00000000,0.00000000,84.65515137,0,0); //object(streetlamp2)(3)
	CreateDynamicObject(1281,795.38616943,-2094.99804688,9.66595459,0.00000000,0.00000000,49.88061523,0,0); //object(parktable1)(3)
	CreateDynamicObject(1281,801.98254395,-2099.14257812,9.66595459,0.00000000,0.00000000,296.73376465,0,0); //object(parktable1)(4)
	CreateDynamicObject(1281,800.23498535,-2106.00659180,9.66595459,0.00000000,0.00000000,265.80700684,0,0); //object(parktable1)(5)
	CreateDynamicObject(9245,852.98632812,-2093.46777344,20.68631554,0.00000000,0.00000000,0.00000000,0,0); //object(cstguard_sfn01)(3)
	CreateDynamicObject(738,841.09716797,-2108.76928711,9.60914040,0.00000000,0.00000000,0.00000000,0,0); //object(aw_streettree2)(8)
	CreateDynamicObject(738,863.26373291,-2108.54907227,9.60914040,0.00000000,0.00000000,0.00000000,0,0); //object(aw_streettree2)(9)
	CreateDynamicObject(1280,851.13360596,-2108.22753906,9.26796532,0.00000000,0.00000000,269.66503906,0,0); //object(parkbench1)(9)
	CreateDynamicObject(1280,844.20843506,-2107.92163086,9.26796532,0.00000000,0.00000000,269.66491699,0,0); //object(parkbench1)(10)
	CreateDynamicObject(1280,859.42053223,-2108.42871094,9.26796532,0.00000000,0.00000000,269.66491699,0,0); //object(parkbench1)(11)
	CreateDynamicObject(16775,788.95831299,-2094.17260742,3.08051109,0.00000000,0.00000000,270.93249512,0,0); //object(door_savhangr2)(1)
	CreateDynamicObject(16775,864.14721680,-2093.08544922,2.44316387,0.00000000,0.00000000,270.92834473,0,0); //object(door_savhangr2)(2)
	CreateDynamicObject(3877,865.57904053,-2074.26098633,0.33480635,0.00000000,0.00000000,0.00000000,0,0); //object(sf_rooflite)(20)
	CreateDynamicObject(3877,777.82177734,-2088.44287109,0.33480635,0.00000000,0.00000000,0.00000000,0,0); //object(sf_rooflite)(21)
	CreateDynamicObject(3877,883.00384521,-2094.17993164,0.33480635,0.00000000,0.00000000,0.00000000,0,0); //object(sf_rooflite)(22)
	CreateDynamicObject(3877,892.69140625,-2108.62988281,0.33480635,0.00000000,0.00000000,0.00000000,0,0); //object(sf_rooflite)(27)
	CreateDynamicObject(1280,828.22668457,-2128.14990234,3.24452734,0.00000000,0.00000000,180.66955566,0,0); //object(parkbench1)(13)
	CreateDynamicObject(1280,828.03979492,-2118.03222656,3.24452734,0.00000000,0.00000000,180.66467285,0,0); //object(parkbench1)(14)
	CreateDynamicObject(1280,838.57507324,-2118.21923828,3.24452734,0.00000000,0.00000000,358.19165039,0,0); //object(parkbench1)(15)
	CreateDynamicObject(1280,838.80511475,-2128.42822266,3.24452734,0.00000000,0.00000000,358.18725586,0,0); //object(parkbench1)(16)
	CreateDynamicObject(738,838.85284424,-2131.09765625,3.15802383,0.00000000,0.00000000,0.00000000,0,0); //object(aw_streettree2)(10)
	CreateDynamicObject(738,828.73535156,-2130.64941406,3.15802383,0.00000000,0.00000000,0.00000000,0,0); //object(aw_streettree2)(11)
	CreateDynamicObject(738,833.56909180,-2111.10791016,3.15802383,0.00000000,0.00000000,0.00000000,0,0); //object(aw_streettree2)(12)
	CreateDynamicObject(1280,833.77484131,-2106.59619141,6.97299528,0.00000000,0.00000000,269.66516113,0,0); //object(parkbench1)(17)
	CreateDynamicObject(14387,833.55364990,-2135.43212891,1.76289868,0.00000000,0.00000000,269.66516113,0,0); //object(dr_gsnew02)(1)
	CreateDynamicObject(14387,829.16552734,-2135.40917969,1.76289868,0.00000000,0.00000000,269.66491699,0,0); //object(dr_gsnew02)(2)
	CreateDynamicObject(14387,838.01904297,-2135.47680664,1.76289868,0.00000000,0.00000000,269.66491699,0,0); //object(dr_gsnew02)(3)
	CreateDynamicObject(11495,832.77026367,-2137.77978516,0.55897182,0.00000000,0.00000000,270.27319336,0,0); //object(des_ranchjetty)(1)
	CreateDynamicObject(17068,822.59600830,-2125.93334961,0.53849792,0.00000000,0.00000000,0.55895996,0,0); //object(xjetty01)(1)
	CreateDynamicObject(17068,810.61248779,-2115.66308594,0.53849792,0.00000000,0.00000000,89.19403076,0,0); //object(xjetty01)(2)
	CreateDynamicObject(17068,788.65930176,-2115.34472656,0.53849792,0.00000000,0.00000000,89.19250488,0,0); //object(xjetty01)(3)
	CreateDynamicObject(17068,778.63751221,-2126.94580078,0.53849792,0.00000000,0.00000000,180.79467773,0,0); //object(xjetty01)(4)
	CreateDynamicObject(17068,778.91650391,-2148.85498047,0.53849792,0.00000000,0.00000000,180.79101562,0,0); //object(xjetty01)(5)
	CreateDynamicObject(17068,790.50714111,-2159.00585938,0.53849792,0.00000000,0.00000000,270.00000000,0,0); //object(xjetty01)(6)
	CreateDynamicObject(17068,812.40698242,-2159.00244141,0.53849792,0.00000000,0.00000000,270.00000000,0,0); //object(xjetty01)(7)
	CreateDynamicObject(17068,842.83630371,-2125.93945312,0.53849792,0.00000000,0.00000000,180.00000000,0,0); //object(xjetty01)(9)
	CreateDynamicObject(17068,852.93695068,-2114.06396484,0.53849792,0.00000000,0.00000000,90.00000000,0,0); //object(xjetty01)(10)
	CreateDynamicObject(17068,874.78845215,-2114.06689453,0.53849792,0.00000000,0.00000000,90.00000000,0,0); //object(xjetty01)(11)
	CreateDynamicObject(17068,884.91540527,-2125.94580078,0.53849792,0.00000000,0.00000000,0.00000000,0,0); //object(xjetty01)(12)
	CreateDynamicObject(17068,884.89398193,-2147.83129883,0.53849792,0.00000000,0.00000000,0.00000000,0,0); //object(xjetty01)(13)
	CreateDynamicObject(17068,873.00079346,-2157.89355469,0.53849792,0.00000000,0.00000000,270.27331543,0,0); //object(xjetty01)(14)
	CreateDynamicObject(17068,851.11328125,-2157.98657227,0.53849792,0.00000000,0.00000000,270.26916504,0,0); //object(xjetty01)(15)
	CreateDynamicObject(3877,895.76495361,-2135.28735352,0.33480635,0.00000000,0.00000000,0.00000000,0,0); //object(sf_rooflite)(27)
	CreateDynamicObject(3877,889.84796143,-2163.32714844,0.33480635,0.00000000,0.00000000,0.00000000,0,0); //object(sf_rooflite)(27)
	CreateDynamicObject(3877,841.03240967,-2160.87524414,0.33480635,0.00000000,0.00000000,0.00000000,0,0); //object(sf_rooflite)(27)
	CreateDynamicObject(3877,822.89782715,-2160.58544922,0.33480635,0.00000000,0.00000000,0.00000000,0,0); //object(sf_rooflite)(27)
	CreateDynamicObject(3877,771.45727539,-2157.38012695,0.33480635,0.00000000,0.00000000,0.00000000,0,0); //object(sf_rooflite)(27)
	CreateDynamicObject(3877,766.26110840,-2116.31933594,0.33480635,0.00000000,0.00000000,0.00000000,0,0); //object(sf_rooflite)(27)
	CreateDynamicObject(3715,836.16107178,-2064.19848633,20.73428535,0.00000000,0.00000000,0.00000000,0,0); //object(arch_sign)(1)
	CreateDynamicObject(17068,865.16363525,-2125.91821289,0.53849792,0.00000000,0.00000000,0.00000000,0,0); //object(xjetty01)(16)
	CreateDynamicObject(17068,801.43511963,-2126.73876953,0.53849792,0.00000000,0.00000000,0.00000000,0,0); //object(xjetty01)(17)
	CreateDynamicObject(1337,812.72753906,-2141.85937500,-12.58278275,0.00000000,0.00000000,0.00000000,0,0); //object(binnt07_la)(3)

	//obiekty cywilne (warsztaty)

	CreateDynamicObject(11326,1789.65698242,-1717.61254883,14.91790390,0.00000000,0.00000000,359.34106445,0,0); //object(sfse_hublockup)(1)
	CreateDynamicObject(11393,1809.45202637,-1714.85009766,14.48518372,0.00000000,0.00000000,270.93237305,0,0); //object(hubprops1_sfs)(1)
	CreateDynamicObject(3037,1761.05627441,-1692.06835938,14.08410358,0.00000000,0.00000000,0.00000000,0,0); //object(warehouse_door2b)(1)
	CreateDynamicObject(10281,1756.87524414,-1700.78649902,19.73297882,0.00000000,0.00000000,269.66516113,0,0); //object(michsign_sfe)(1)
	CreateDynamicObject(10282,1788.70202637,-1692.42236328,13.51686096,0.00000000,0.00000000,0.00000000,0,0); //object(mich_int_sfe)(1)
	CreateDynamicObject(3627,1778.02416992,-1694.26123047,16.31610107,0.00000000,0.00000000,269.66516113,0,0); //object(dckcanpy)(2)
	CreateDynamicObject(14826,1768.03051758,-1692.98120117,13.19375706,0.00000000,0.00000000,125.76922607,0,0); //object(int_kbsgarage2)(2)
	CreateDynamicObject(10282,1778.59985352,-1692.55981445,13.51686096,0.00000000,0.00000000,0.00000000,0,0); //object(mich_int_sfe)(2)
	CreateDynamicObject(3037,2360.56835938,-1271.53503418,24.10677338,0.00000000,0.00000000,358.73266602,0,0); //object(warehouse_door2b)(2)
	CreateDynamicObject(10281,2312.56323242,-1218.14428711,28.31151962,0.00000000,0.00000000,269.61437988,0,0); //object(michsign_sfe)(3)
	CreateDynamicObject(14796,2328.58325195,-1262.56567383,25.15226555,0.00000000,0.00000000,271.54077148,0,0); //object(int_kbsgarage05b)(2)
	CreateDynamicObject(14826,2354.82202148,-1271.86083984,22.73357391,0.00000000,0.00000000,17.08355713,0,0); //object(int_kbsgarage2)(3)
	CreateDynamicObject(11393,2341.93334961,-1218.70446777,23.02503967,0.00000000,0.00000000,88.94445801,0,0); //object(hubprops1_sfs)(3)
	CreateDynamicObject(11391,2350.85009766,-1230.74511719,22.66084480,0.00000000,0.00000000,178.13488770,0,0); //object(hubprops6_sfse)(3)
	CreateDynamicObject(10282,2346.53417969,-1263.46960449,22.51906586,0.00000000,0.00000000,272.80810547,0,0); //object(mich_int_sfe)(3)
	CreateDynamicObject(10184,2343.84252930,-1255.08679199,22.85329819,0.00000000,0.00000000,267.73889160,0,0); //object(sfcopdr)(1)
	CreateDynamicObject(1318,2325.68115234,-1224.77209473,21.61232567,0.00000000,270.01837158,274.07543945,0,0); //object(arrow)(1)
	CreateDynamicObject(1318,2326.04296875,-1252.15478516,21.61232567,0.00000000,270.01647949,290.54577637,0,0); //object(arrow)(2)
	CreateDynamicObject(1318,2328.22192383,-1221.55212402,21.61232567,0.00000000,270.01647949,331.55651855,0,0); //object(arrow)(3)
	CreateDynamicObject(1425,2362.58056641,-1272.03173828,23.37166786,0.00000000,0.00000000,95.35321045,0,0); //object(dyn_roadbarrier_3)(1)
	CreateDynamicObject(1245,2342.50683594,-1243.27001953,21.79237175,0.00000000,344.78942871,178.06091309,0,0); //object(newramp)(2)
	CreateDynamicObject(2939,2351.39379883,-1241.43127441,22.67210579,157.14923096,0.00000000,266.21728516,0,0); //object(ramp_bot)(1)
	CreateDynamicObject(2939,2351.29687500,-1251.53027344,22.67210579,157.14843750,0.00000000,266.21520996,0,0); //object(ramp_bot)(2)
	CreateDynamicObject(2939,2345.31298828,-1252.29846191,22.67099571,172.35662842,0.00000000,266.21520996,0,0); //object(ramp_bot)(3)

	//obiekty cywilne przystanek BAZA MECHANIK”W (pÍtla)
	CreateDynamicObject(1280,2821.6999512,-1578.5999756,10.5000000,0.0000000,0.0000000,344.0000000,0,0); //object(parkbench1) (1)
	CreateDynamicObject(1280,2822.1999512,-1582.4000244,10.5000000,0.0000000,0.0000000,23.9974365,0,0); //object(parkbench1) (2)
	CreateDynamicObject(1280,2824.1000977,-1575.5000000,10.5000000,0.0000000,0.0000000,303.9971924,0,0); //object(parkbench1) (3)
	CreateDynamicObject(1229,2825.1000977,-1573.0000000,11.6999998,0.0000000,0.0000000,140.0000000,0,0); //object(bussign1) (1)
	CreateDynamicObject(1229,2821.8000488,-1584.8000488,11.6999998,0.0000000,0.0000000,15.9987793,0,0); //object(bussign1) (2)
	CreateDynamicObject(2431,2820.3999023,-1579.0999756,13.3999996,346.0000000,0.0000000,71.7500000,0,0); //napis2 BM petla
	//SetDynamicObjectMaterialText(BMpetla, "Baza MechanikÛw (pÍtla)", 0, OBJECT_MATERIAL_SIZE_256x128,"Arial", 28, 1, 0xFFFFFFFF, 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
	//SetDynamicObjectMaterialText(,0,"{000000}Przystanek\nBaza MechanikÛw (pÍtla)\nKursuje linia: 72",28,"Ariel",30,0,0xFFFFFFFF,0x000000FF,0);
	//new obiekt_petla = CreateDynamicObject(19466, 2820.3999023,-1579.0999756,13.3999996,346.0000000,0.0000000,71.7500000,0);
	//SetDynamicObjectMaterialText(obiekt_petla, 0, "{000000}Przystanek\nBaza MechanikÛw (pÍtla)\nKursuje linia: 72",OBJECT_MATERIAL_SIZE_256x128, "Arial", 24, 1,0xFFFFFFFF, 0, 0);
	CreateDynamicObject(970,2834.5000000,-1580.3000488,10.6000004,0.0000000,0.0000000,58.0000000,0,0); //object(fencesmallb) (1)
	CreateDynamicObject(949,2822.5000000,-1576.8000488,10.6999998,0.0000000,0.0000000,0.0000000,0,0); //object(plant_pot_4) (1)
	CreateDynamicObject(949,2821.3999023,-1580.5000000,10.6999998,0.0000000,0.0000000,0.0000000,0,0); //object(plant_pot_4) (2)
	CreateDynamicObject(950,2826.1000977,-1585.4000244,10.5000000,0.0000000,0.0000000,333.9949951,0,0); //object(plant_pot_12) (3)
	CreateDynamicObject(970,2837.8000488,-1574.9000244,10.6000004,0.0000000,0.0000000,57.9968262,0,0); //object(fencesmallb) (2)
	CreateDynamicObject(950,2834.0000000,-1580.0000000,10.5000000,0.0000000,0.0000000,59.9873047,0,0); //object(plant_pot_12) (6)
	CreateDynamicObject(970,2834.6999512,-1573.0999756,10.6000004,0.0000000,0.0000000,359.9968262,0,0); //object(fencesmallb) (3)
	CreateDynamicObject(970,2828.5000000,-1573.0999756,10.6000004,0.0000000,0.0000000,359.9949951,0,0); //object(fencesmallb) (4)
	CreateDynamicObject(949,2838.0000000,-1573.5000000,10.6999998,0.0000000,0.0000000,0.0000000,0,0); //object(plant_pot_4) (3)
	CreateDynamicObject(950,2836.8000488,-1575.5000000,10.5000000,0.0000000,0.0000000,59.9908447,0,0); //object(plant_pot_12) (9)
	CreateDynamicObject(950,2834.8000488,-1573.6999512,10.5000000,0.0000000,0.0000000,359.9908447,0,0); //object(plant_pot_12) (10)
	CreateDynamicObject(950,2828.3999023,-1573.9000244,10.5000000,0.0000000,0.0000000,359.9908447,0,0); //object(plant_pot_12) (11)
	CreateDynamicObject(1280,2832.1999512,-1577.3000488,10.5000000,0.0000000,0.0000000,223.9971924,0,0); //object(parkbench1) (4)
	CreateDynamicObject(949,2825.8000488,-1574.3000488,10.6999998,0.0000000,0.0000000,0.0000000,0,0); //object(plant_pot_4) (4)
	CreateDynamicObject(949,2823.3000488,-1584.3000488,10.6999998,0.0000000,0.0000000,0.0000000,0,0); //object(plant_pot_4) (6)
	CreateDynamicObject(970,2825.3999023,-1586.0999756,10.6000004,0.0000000,0.0000000,331.9945068,0,0); //object(fencesmallb) (5)
	CreateDynamicObject(14467,2792.3999023,-1535.8000488,12.8000002,0.0000000,0.0000000,50.0000000,0,0); //krÛl mechanikÛw
	
	//stacja benzynowa pod paczkiem
	CreateDynamicObject(13296,1017.70147705,-1353.82678223,15.60587311,0.00000000,0.00000000,270.25000000,0,0); //object(ce_roadsidegas) (1)
	CreateDynamicObject(11393,994.86157227,-1344.06176758,13.88285255,0.00000000,0.00000000,272.00000000,0,0); //object(hubprops1_sfs) (1)
	CreateDynamicObject(11393,986.07897949,-1352.74133301,13.90785217,0.00000000,0.00000000,89.99951172,0,0); //object(hubprops1_sfs) (2)
	CreateDynamicObject(11494,992.84906006,-1343.19482422,12.33280563,0.00000000,0.00000000,316.50000000,0,0); //object(des_rnchbhous) (1)
	CreateDynamicObject(11494,993.02679443,-1353.51806641,12.40781975,0.00000000,0.00000000,135.24923706,0,0); //object(des_rnchbhous) (2)
	CreateDynamicObject(5020,992.79583740,-1348.38476562,13.21916008,0.00000000,0.00000000,90.00000000,0,0); //object(mul_las) (1)
	CreateDynamicObject(10281,989.50152588,-1337.16455078,17.57206726,0.00000000,0.00000000,180.00000000,0,0); //object(michsign_sfe) (1)
	CreateDynamicObject(1244,1012.04095459,-1351.18835449,13.38339233,0.00000000,0.00000000,0.00000000,0,0); //object(petrolpump) (1)
	CreateDynamicObject(1244,1012.04095459,-1353.13061523,13.38339233,0.00000000,0.00000000,0.00000000,0,0); //object(petrolpump) (2)
	CreateDynamicObject(1244,1012.04095459,-1355.87121582,13.38339233,0.00000000,0.00000000,0.00000000,0,0); //object(petrolpump) (3)
	CreateDynamicObject(1244,1012.04095459,-1357.87670898,13.38339233,0.00000000,0.00000000,0.00000000,0,0); //object(petrolpump) (4)
	CreateDynamicObject(1238,1012.08764648,-1360.32617188,12.67443657,0.00000000,0.00000000,0.00000000,0,0); //object(trafficcone) (1)
	CreateDynamicObject(1238,1011.94830322,-1348.52600098,12.67443657,0.00000000,0.00000000,0.00000000,0,0); //object(trafficcone) (2)

	//obiekty cywilne (warsztat Ganton)
	CreateDynamicObject(13296,2467.8994100,-1784.3994100,15.8000000,0.0000000,0.0000000,179.9950000,0,0); //object(ce_roadsidegas) (1)
	CreateDynamicObject(16004,2511.7998000,-1793.5996100,15.3000000,0.0000000,0.0000000,283.9970000,0,0); //object(des_tepeoff) (1)
	CreateDynamicObject(11431,2501.8994100,-1793.2998000,13.9000000,0.0000000,0.0000000,345.9980000,0,0); //object(des_tepeoff01) (1)
	CreateDynamicObject(11431,2494.8994100,-1789.8994100,13.9000000,0.0000000,0.0000000,319.9880000,0,0); //object(des_tepeoff01) (2)
	CreateDynamicObject(3698,2532.7998000,-1808.5996100,15.4000000,0.0000000,0.0000000,63.4900000,0,0); //object(barrio3b_lae) (1)
	CreateDynamicObject(11431,2537.0000000,-1796.7998000,13.9000000,0.0000000,0.0000000,71.9880000,0,0); //object(des_tepeoff01) (3)
	CreateDynamicObject(3174,2508.0000000,-1804.0000000,12.6000000,0.0000000,0.0000000,323.9980000,0,0); //object(sm_airstrm_sml_) (1)
	CreateDynamicObject(3174,2495.1001000,-1804.4000200,14.7000000,0.0000000,0.0000000,207.9980000,0,0); //object(sm_airstrm_sml_) (2)
	CreateDynamicObject(3175,2492.0000000,-1811.9000200,14.6000000,0.0000000,0.0000000,96.0000000,0,0); //object(sm_airstrm_med_) (1)
	CreateDynamicObject(3174,2506.5000000,-1775.5000000,12.5000000,0.0000000,0.0000000,69.9880000,0,0); //object(sm_airstrm_sml_) (3)
	CreateDynamicObject(11431,2512.5000000,-1776.2998000,13.9000000,0.0000000,0.0000000,197.9960000,0,0); //object(des_tepeoff01) (4)
	CreateDynamicObject(1413,2487.6999500,-1773.0999800,13.7000000,0.0000000,0.0000000,283.9910000,0,0); //object(dyn_mesh_3) (1)
	CreateDynamicObject(11431,2495.3994100,-1777.2998000,13.9000000,0.0000000,0.0000000,229.9880000,0,0); //object(des_tepeoff01) (5)
	CreateDynamicObject(1413,2487.0000000,-1791.6999500,13.8000000,0.0000000,0.0000000,21.9940000,0,0); //object(dyn_mesh_3) (2)
	CreateDynamicObject(1413,2490.1001000,-1788.1999500,13.8000000,0.0000000,0.0000000,253.9970000,0,0); //object(dyn_mesh_3) (4)
	CreateDynamicObject(1413,2490.0000000,-1777.6999500,13.7000000,0.0000000,0.0000000,307.9910000,0,0); //object(dyn_mesh_3) (5)
	CreateDynamicObject(1280,2473.6999500,-1784.5000000,13.0000000,0.0000000,0.0000000,270.0000000,0,0); //object(parkbench1) (1)
	CreateDynamicObject(2714,2477.6101100,-1784.8990500,15.3000000,0.0000000,0.0000000,180.0000000,0,0); //object(cj_open_sign_2) (1)
	CreateDynamicObject(1244,2464.6999500,-1778.6999500,13.6000000,0.0000000,0.0000000,272.0000000,0,0); //object(petrolpump) (1)
	CreateDynamicObject(1244,2469.2998000,-1778.5996100,13.6000000,0.0000000,0.0000000,270.0000000,0,0); //object(petrolpump) (2)
	CreateDynamicObject(1432,2488.3994100,-1788.1992200,12.7000000,0.0000000,0.0000000,1.9940000,0,0); //object(dyn_table_2) (2)
	CreateDynamicObject(1432,2484.8999000,-1788.3000500,12.7000000,0.0000000,0.0000000,41.9940000,0,0); //object(dyn_table_2) (3)
	CreateDynamicObject(2342,2488.5000000,-1788.0999800,13.5000000,0.0000000,0.0000000,0.0000000,0,0); //object(donut_disp) (1)
	CreateDynamicObject(2768,2488.1994600,-1788.1004600,13.4400000,0.0000000,0.0000000,0.0000000,0,0); //object(cj_cb_burg) (1)
	CreateDynamicObject(2823,2485.1999500,-1788.1999500,13.3000000,0.0000000,0.0000000,0.0000000,0,0); //object(gb_kitchtakeway01) (1)
	CreateDynamicObject(2838,2488.3999000,-1789.5999800,12.6000000,0.0000000,0.0000000,0.0000000,0,0); //object(gb_takeaway03) (1)
	CreateDynamicObject(2859,2488.3999000,-1788.5999800,13.3000000,0.0000000,0.0000000,0.0000000,0,0); //object(gb_kitchtakeway04) (1)
	CreateDynamicObject(1776,2479.8999000,-1785.5999800,13.7000000,0.0000000,0.0000000,88.0000000,0,0); //object(cj_candyvendor) (1)
	CreateDynamicObject(2342,2486.6001000,-1790.6999500,13.4000000,0.0000000,0.0000000,0.0000000,0,0); //object(donut_disp) (2)
	CreateDynamicObject(1432,2486.7998000,-1790.6992200,12.7000000,0.0000000,0.0000000,15.9890000,0,0); //object(dyn_table_2) (4)
	CreateDynamicObject(2823,2488.3999000,-1787.6999500,13.3000000,0.0000000,0.0000000,0.0000000,0,0); //object(gb_kitchtakeway01) (2)
	CreateDynamicObject(2837,2486.8000500,-1790.1999500,13.3000000,0.0000000,0.0000000,0.0000000,0,0); //object(gb_takeaway02) (1)
	CreateDynamicObject(3035,2486.0000000,-1766.8000500,13.3000000,0.0000000,0.0000000,272.0000000,0,0); //object(tmp_bin) (1)
	CreateDynamicObject(1442,2486.0996100,-1768.7998000,13.1000000,0.0000000,0.0000000,0.0000000,0,0); //object(dyn_firebin0) (1)
	CreateDynamicObject(1440,2483.7998000,-1764.7998000,13.1000000,0.0000000,0.0000000,87.9950000,0,0); //object(dyn_box_pile_3) (1)
	CreateDynamicObject(1328,2484.5000000,-1791.2998000,13.1000000,0.0000000,0.0000000,0.0000000,0,0); //object(binnt10_la) (1)
	CreateDynamicObject(2670,2484.8000500,-1790.5999800,12.7000000,0.0000000,0.0000000,0.0000000,0,0); //object(proc_rubbish_1) (2)
	CreateDynamicObject(2671,2487.0000000,-1788.0000000,12.6000000,0.0000000,0.0000000,270.0000000,0,0); //object(proc_rubbish_3) (1)
	CreateDynamicObject(2671,2484.3994100,-1765.2998000,12.6000000,0.0000000,0.0000000,0.0000000,0,0); //object(proc_rubbish_3) (2)
	CreateDynamicObject(2670,2484.1001000,-1763.5000000,12.6000000,0.0000000,0.0000000,342.0000000,0,0); //object(proc_rubbish_1) (3)
	CreateDynamicObject(17951,2472.4299300,-1771.5000000,14.1000000,0.0000000,0.0000000,270.0000000,0,0); //object(cjgaragedoor) (1)
	CreateDynamicObject(1499,2476.0000000,-1771.4287100,12.6000000,0.0000000,0.0000000,0.0000000,0,0); //object(gen_doorint05) (1)
	CreateDynamicObject(1768,2498.3000500,-1774.5999800,12.5000000,0.0000000,0.0000000,29.9980000,0,0); //object(low_couch_3) (1)
	CreateDynamicObject(1735,2501.6001000,-1773.9000200,12.5000000,0.0000000,0.0000000,332.0000000,0,0); //object(cj_easychair1) (1)
	CreateDynamicObject(2121,2499.3999000,-1776.5999800,13.1000000,0.0000000,0.0000000,172.0000000,0,0); //object(low_din_chair_2) (1)
	CreateDynamicObject(2115,2499.6992200,-1775.3994100,12.4000000,0.0000000,0.0000000,15.9960000,0,0); //object(low_dinning_1) (1)
	CreateDynamicObject(2121,2501.1001000,-1776.3000500,13.1000000,0.0000000,0.0000000,205.9960000,0,0); //object(low_din_chair_2) (2)
	CreateDynamicObject(1481,2503.3994100,-1775.5000000,13.3000000,0.0000000,0.0000000,301.9980000,0,0); //object(dyn_bar_b_q) (1)
	CreateDynamicObject(1280,2495.3999000,-1787.4000200,12.9000000,0.0000000,0.0000000,231.9960000,0,0); //object(parkbench1) (2)
	CreateDynamicObject(1413,2517.3000500,-1775.6999500,13.7000000,0.0000000,0.0000000,269.9960000,0,0); //object(dyn_mesh_3) (1)
	CreateDynamicObject(1413,2517.1992200,-1779.8994100,13.7000000,0.0000000,0.0000000,267.9950000,0,0); //object(dyn_mesh_3) (1)
	CreateDynamicObject(1665,2484.6001000,-1787.9000200,13.4000000,0.0000000,0.0000000,0.0000000,0,0); //object(propashtray1) (1)
	CreateDynamicObject(1551,2497.0000000,-1775.0000000,12.8000000,0.0000000,0.0000000,0.0000000,0,0); //object(dyn_wine_big) (1)
	CreateDynamicObject(1544,2497.0000000,-1775.0000000,12.4000000,0.0000000,0.0000000,0.0000000,0,0); //object(cj_beer_b_1) (1)
	CreateDynamicObject(1414,2513.5000000,-1797.0000000,13.9000000,0.0000000,0.0000000,244.0000000,0,0); //object(dyn_cor_sheet) (1)
	CreateDynamicObject(1414,2511.6001000,-1800.8000500,13.7000000,0.0000000,0.0000000,245.9950000,0,0); //object(dyn_cor_sheet) (2)
	CreateDynamicObject(1413,2481.8000500,-1792.3000500,13.8000000,0.0000000,0.0000000,351.9950000,0,0); //object(dyn_mesh_3) (2)
	CreateDynamicObject(2971,2489.1999500,-1774.4000200,12.6000000,0.0000000,0.0000000,9.9980000,0,0); //object(k_smashboxes) (1)
	CreateDynamicObject(1413,2526.8999000,-1821.0000000,13.7000000,0.0000000,0.0000000,261.9890000,0,0); //object(dyn_mesh_3) (1)
	CreateDynamicObject(1413,2528.0000000,-1815.9000200,13.7000000,0.0000000,0.0000000,253.2340000,0,0); //object(dyn_mesh_3) (1)
	CreateDynamicObject(1412,2540.6999500,-1804.6999500,13.6832200,0.0000000,0.0000000,268.7340000,0,0); //object(dyn_mesh_3) (1)
	CreateDynamicObject(1410,2534.1001000,-1823.3000500,13.2000000,0.0000000,0.0000000,1.9780000,0,0); //object(dyn_mesh_3) (1)
	CreateDynamicObject(1410,2538.3999000,-1822.0999800,13.2000000,0.0000000,0.0000000,27.9780000,0,0); //object(dyn_mesh_3) (1)
	CreateDynamicObject(1410,2540.2998000,-1818.8994100,13.2000000,0.0000000,0.0000000,87.9740000,0,0); //object(dyn_mesh_3) (1)
	CreateDynamicObject(1410,2540.3000500,-1814.5000000,13.2000000,0.0000000,0.0000000,91.9790000,0,0); //object(dyn_mesh_3) (1)
	CreateDynamicObject(1413,2540.0000000,-1799.5000000,13.7000000,0.0000000,0.0000000,287.4740000,0,0); //object(dyn_mesh_3) (1)
	CreateDynamicObject(1410,2540.5000000,-1809.9000200,13.2000000,0.0000000,0.0000000,83.9780000,0,0); //object(dyn_mesh_3) (1)
	CreateDynamicObject(3174,2536.6001000,-1821.0999800,12.4000000,0.0000000,0.0000000,297.9970000,0,0); //object(sm_airstrm_sml_) (1)
	CreateDynamicObject(1712,2539.3999000,-1816.4000200,12.3000000,0.0000000,0.0000000,257.9980000,0,0); //object(kb_couch05) (2)
	CreateDynamicObject(1768,2527.8999000,-1821.9000200,12.5000000,0.0000000,0.0000000,88.0000000,0,0); //object(low_couch_3) (2)
	CreateDynamicObject(1766,2531.0000000,-1822.5996100,12.5000000,0.0000000,0.0000000,183.9940000,0,0); //object(med_couch_1) (1)
	CreateDynamicObject(2370,2530.1999500,-1821.4000200,12.5000000,0.0000000,0.0000000,90.0000000,0,0); //object(shop_set_1_table) (1)
	CreateDynamicObject(1729,2529.3994100,-1819.2998000,12.5000000,0.0000000,0.0000000,13.9970000,0,0); //object(mrk_seating3b) (1)
	CreateDynamicObject(14861,2529.5996100,-1816.0996100,13.0000000,0.0000000,0.0000000,243.9950000,0,0); //object(choochie-bed) (1)
	CreateDynamicObject(2096,2502.1001000,-1791.0000000,12.6000000,0.0000000,0.0000000,186.0000000,0,0); //object(cj_rockingchair) (1)
	CreateDynamicObject(1421,2533.3999000,-1822.8000500,13.3000000,0.0000000,0.0000000,19.9980000,0,0); //object(dyn_boxes) (1)
	CreateDynamicObject(1481,2533.5000000,-1821.1999500,13.3000000,0.0000000,0.0000000,225.9980000,0,0); //object(dyn_bar_b_q) (1)
	CreateDynamicObject(1769,2531.1999500,-1819.6999500,12.5000000,0.0000000,0.0000000,300.0000000,0,0); //object(low_single_3) (1)
	CreateDynamicObject(1486,2529.5000000,-1821.5000000,13.5000000,0.0000000,0.0000000,0.0000000,0,0); //object(dyn_beer_1) (1)
	CreateDynamicObject(1517,2530.3999000,-1821.5999800,13.5000000,0.0000000,0.0000000,0.0000000,0,0); //object(dyn_wine_break) (1)
	CreateDynamicObject(1543,2530.6001000,-1821.1999500,13.3000000,0.0000000,0.0000000,0.0000000,0,0); //object(cj_beer_b_2) (1)
	CreateDynamicObject(1665,2529.8994100,-1821.0000000,13.4000000,0.0000000,0.0000000,0.0000000,0,0); //object(propashtray1) (2)
	CreateDynamicObject(1543,2531.5000000,-1822.9000200,12.5000000,0.0000000,0.0000000,0.0000000,0,0); //object(cj_beer_b_2) (2)
	CreateDynamicObject(1520,2531.6999500,-1822.9000200,12.5000000,0.0000000,0.0000000,0.0000000,0,0); //object(dyn_wine_bounce) (1)
	CreateDynamicObject(1517,2531.5000000,-1822.6999500,12.6000000,0.0000000,0.0000000,42.0000000,0,0); //object(dyn_wine_break) (2)
	CreateDynamicObject(2674,2529.6999500,-1821.0000000,13.3596200,0.0000000,0.0000000,14.0000000,0,0); //object(proc_rubbish_2) (1)
	CreateDynamicObject(2677,2532.1001000,-1821.5999800,12.8200000,0.0000000,0.0000000,4.0000000,0,0); //object(proc_rubbish_7) (1)
	CreateDynamicObject(2671,2531.0000000,-1819.1999500,12.6000000,0.0000000,0.0000000,56.0000000,0,0); //object(proc_rubbish_3) (3)
	CreateDynamicObject(1413,2529.1999500,-1823.5999800,13.7000000,0.0000000,0.0000000,181.4790000,0,0); //object(dyn_mesh_3) (1)
	CreateDynamicObject(2571,2509.6999500,-1789.9000200,12.6000000,0.0000000,0.0000000,192.0000000,0,0); //object(hotel_single_1) (1)
	CreateDynamicObject(1265,2533.3000500,-1815.9000200,13.0000000,0.0000000,0.0000000,0.0000000,0,0); //object(blackbag2) (1)
	CreateDynamicObject(2663,2534.3000500,-1813.6999500,13.2000000,0.0000000,0.0000000,48.0000000,0,0); //object(cj_bs_bag) (1)
	CreateDynamicObject(1357,2534.1001000,-1814.9000200,12.8000000,0.0000000,0.0000000,0.0000000,0,0); //object(cj_fruitcrate3) (2)
	CreateDynamicObject(1369,2535.3999000,-1811.8000500,13.2000000,0.0000000,0.0000000,90.0000000,0,0); //object(cj_wheelchair1) (1)
	CreateDynamicObject(2837,2536.6999500,-1808.4000200,12.9000000,0.0000000,0.0000000,24.0000000,0,0); //object(gb_takeaway02) (2)
	CreateDynamicObject(2857,2528.3000500,-1817.3000500,12.5000000,0.0000000,0.0000000,0.0000000,0,0); //object(gb_kitchtakeway02) (1)
	CreateDynamicObject(631,2539.0000000,-1818.8000500,13.4000000,0.0000000,0.0000000,0.0000000,0,0); //object(veg_palmkb9) (1)
	CreateDynamicObject(631,2527.8000500,-1822.9000200,13.4000000,0.0000000,0.0000000,0.0000000,0,0); //object(veg_palmkb9) (2)
	CreateDynamicObject(3594,2539.1001000,-1790.3000500,13.2000000,0.0000000,0.0000000,342.0000000,0,0); //object(la_fuckcar1) (1)
	CreateDynamicObject(1413,2533.3999000,-1802.5999800,13.7000000,0.0000000,0.0000000,67.4740000,0,0); //object(dyn_mesh_3) (1)
	CreateDynamicObject(2673,2538.0000000,-1817.3000500,12.6000000,0.0000000,0.0000000,58.0000000,0,0); //object(proc_rubbish_5) (1)
	CreateDynamicObject(2673,2501.1999500,-1775.1999500,12.6000000,0.0000000,0.0000000,0.0000000,0,0); //object(proc_rubbish_5) (2)
	CreateDynamicObject(2673,2506.5000000,-1791.1999500,12.6000000,0.0000000,0.0000000,8.0000000,0,0); //object(proc_rubbish_5) (3)
	CreateDynamicObject(2832,2529.6001000,-1820.6999500,13.3500000,0.0000000,0.0000000,4.0000000,0,0); //object(gb_platedirty05) (1)
	CreateDynamicObject(2827,2529.5000000,-1821.3000500,13.3000000,0.0000000,0.0000000,350.0000000,0,0); //object(gb_novels05) (1)
	CreateDynamicObject(2837,2532.1001000,-1802.1999500,12.9000000,0.0000000,0.0000000,280.0000000,0,0); //object(gb_takeaway02) (3)
	CreateDynamicObject(910,2539.6999500,-1814.0000000,13.8000000,0.0000000,0.0000000,270.0000000,0,0); //object(bust_cabinet_4) (1)
	CreateDynamicObject(1265,2539.5000000,-1812.5000000,13.0000000,0.0000000,0.0000000,0.0000000,0,0); //object(blackbag2) (2)
	CreateDynamicObject(1442,2527.8999000,-1818.6999500,13.1000000,0.0000000,0.0000000,0.0000000,0,0); //object(dyn_firebin0) (1)
	CreateDynamicObject(1211,2526.3999000,-1812.4000200,13.2000000,0.0000000,0.0000000,22.0000000,0,0); //object(fire_hydrant) (1)
	CreateDynamicObject(1257,2510.6001000,-1807.5999800,13.8000000,0.0000000,0.0000000,162.0000000,0,0); //object(bustopm) (1)
	CreateDynamicObject(1292,2509.0000000,-1810.3000500,13.1000000,0.0000000,0.0000000,22.0000000,0,0); //object(postbox1_d) (2)
	CreateDynamicObject(1441,2536.1001000,-1802.0999800,13.2000000,0.0000000,0.0000000,154.0000000,0,0); //object(dyn_box_pile_4) (1)
	CreateDynamicObject(2800,2508.3999000,-1791.0999800,12.9000000,0.0000000,0.0000000,0.0000000,0,0); //object(castable2top) (2)
	CreateDynamicObject(1280,2529.1999500,-1807.6999500,12.9000000,0.0000000,0.0000000,334.0000000,0,0); //object(parkbench1) (3)
	CreateDynamicObject(1486,2529.8000500,-1806.4000200,13.0000000,0.0000000,0.0000000,0.0000000,0,0); //object(dyn_beer_1) (2)
	CreateDynamicObject(1520,2530.0000000,-1806.4000200,12.9000000,0.0000000,0.0000000,0.0000000,0,0); //object(dyn_wine_bounce) (2)
	CreateDynamicObject(2673,2529.3999000,-1806.6999500,12.6000000,0.0000000,0.0000000,28.0000000,0,0); //object(proc_rubbish_5) (4)
	CreateDynamicObject(1357,2491.3999000,-1773.6999500,12.8000000,0.0000000,0.0000000,0.0000000,0,0); //object(cj_fruitcrate3) (3)
	CreateDynamicObject(1450,2496.3000500,-1773.5000000,13.1000000,0.0000000,0.0000000,4.0000000,0,0); //object(dyn_crate_3) (1)
	CreateDynamicObject(1486,2500.1001000,-1775.4000200,13.3000000,0.0000000,0.0000000,0.0000000,0,0); //object(dyn_beer_1) (3)
	CreateDynamicObject(1509,2499.3999000,-1775.3000500,13.4000000,0.0000000,0.0000000,0.0000000,0,0); //object(dyn_wine_3) (1)
	CreateDynamicObject(1520,2500.8000500,-1775.3000500,13.2000000,0.0000000,0.0000000,0.0000000,0,0); //object(dyn_wine_bounce) (3)
	CreateDynamicObject(2812,2500.0000000,-1775.0999800,13.2000000,0.0000000,0.0000000,0.0000000,0,0); //object(gb_platedirty01) (1)
	CreateDynamicObject(2226,2498.1001000,-1775.9000200,12.5000000,0.0000000,0.0000000,142.0000000,0,0); //object(low_hi_fi_3) (1)
	CreateDynamicObject(1486,2497.1001000,-1775.0999800,12.7000000,0.0000000,0.0000000,0.0000000,0,0); //object(dyn_beer_1) (4)
	CreateDynamicObject(1517,2496.8999000,-1774.9000200,12.7000000,0.0000000,0.0000000,0.0000000,0,0); //object(dyn_wine_break) (3)
	CreateDynamicObject(1543,2497.1001000,-1774.9000200,12.5000000,0.0000000,0.0000000,0.0000000,0,0); //object(cj_beer_b_2) (3)
	CreateDynamicObject(1544,2499.8000500,-1775.4000200,13.2000000,0.0000000,0.0000000,0.0000000,0,0); //object(cj_beer_b_1) (2)
	CreateDynamicObject(1665,2499.6999500,-1775.8000500,13.3000000,0.0000000,0.0000000,0.0000000,0,0); //object(propashtray1) (3)
	CreateDynamicObject(1669,2500.8999000,-1774.8000500,13.4000000,0.0000000,0.0000000,0.0000000,0,0); //object(propwinebotl1) (1)
	CreateDynamicObject(2671,2491.0000000,-1775.9000200,12.6000000,0.0000000,0.0000000,56.0000000,0,0); //object(proc_rubbish_3) (4)
	CreateDynamicObject(997,2457.3000500,-1791.9000200,12.4000000,0.0000000,0.0000000,0.0000000,0,0); //object(lhouse_barrier3) (1)
	CreateDynamicObject(14826,2458.3000500,-1766.0000000,13.4000000,0.0000000,0.0000000,126.0000000,0,0); //object(int_kbsgarage2) (1)
	CreateDynamicObject(17950,2444.6001000,-1762.3000500,14.8400000,0.0000000,0.0000000,180.0000000,0,0); //object(cjsaveg) (1)
	CreateDynamicObject(1327,2456.6001000,-1758.9000200,13.5000000,0.0000000,0.0000000,92.0000000,0,0); //object(junk_tyre) (1)
	CreateDynamicObject(1230,2461.8000500,-1770.0999800,13.0000000,0.0000000,0.0000000,108.0000000,0,0); //object(cardboardbox) (1)
	CreateDynamicObject(1441,2453.1999500,-1792.1999500,13.2000000,0.0000000,0.0000000,0.0000000,0,0); //object(dyn_box_pile_4) (2)
	CreateDynamicObject(1442,2461.3000500,-1769.1999500,13.2000000,0.0000000,0.0000000,6.0000000,0,0); //object(dyn_firebin0) (3)
	CreateDynamicObject(16281,2491.3000500,-1782.9000200,15.4000000,0.0000000,0.0000000,84.0000000,0,0); //object(des_fgateway01) (1)
	CreateDynamicObject(17950,2451.8000500,-1762.3000500,14.8400000,0.0000000,0.0000000,179.4990000,0,0); //object(cjsaveg) (2)
	CreateDynamicObject(10281,2448.1999500,-1767.5000000,17.9000000,0.0000000,345.0000000,0.0000000,0,0); //object(michsign_sfe) (1)
	CreateDynamicObject(1079,2442.6001000,-1758.6999500,13.8000000,0.0000000,0.0000000,272.0000000,0,0); //object(wheel_sr1) (1)
	CreateDynamicObject(1080,2443.5000000,-1758.5999800,14.4000000,0.0000000,0.0000000,272.0000000,0,0); //object(wheel_sr5) (1)
	CreateDynamicObject(1076,2444.6001000,-1758.5999800,15.0000000,0.0000000,0.0000000,270.0000000,0,0); //object(wheel_lr4) (1)
	CreateDynamicObject(1073,2445.3000500,-1758.5999800,14.1000000,0.0000000,0.0000000,272.0000000,0,0); //object(wheel_sr6) (1)
	CreateDynamicObject(942,2446.6001000,-1761.5999800,13.3000000,0.0000000,0.0000000,270.0000000,0,0); //object(cj_df_unit_2) (1)
	CreateDynamicObject(1085,2446.1999500,-1758.8000500,13.4000000,0.0000000,0.0000000,270.0000000,0,0); //object(wheel_gn2) (1)
	CreateDynamicObject(1169,2447.1001000,-1763.9000200,14.5000000,0.0000000,180.0000000,110.0000000,0,0); //object(fbmp_a_s) (1)
	CreateDynamicObject(1145,2446.6999500,-1762.9000200,14.7000000,0.0000000,0.0000000,0.0000000,0,0); //object(bntl_b_sq) (1)
	CreateDynamicObject(1133,2445.3999000,-1760.5000000,14.7000000,0.0000000,0.0000000,0.0000000,0,0); //object(wg_l_lr_sv) (1)
	CreateDynamicObject(1023,2446.1001000,-1760.8000500,14.7000000,0.0000000,0.0000000,282.0000000,0,0); //object(spl_b_bbb_m) (1)
	CreateDynamicObject(10282,2452.5000000,-1759.1999500,13.7000000,0.0000000,0.0000000,2.0000000,0,0); //object(mich_int_sfe) (1)
	CreateDynamicObject(1128,2446.8000500,-1763.9000200,14.2000000,60.0000000,0.0000000,358.0000000,0,0); //object(rf_lr_bl1) (1)
	//obiekty cywilne ( ZNISZCZONE studio tatuaøu)
	CreateDynamicObject(8231,-218.42950439,-25.94187164,1001.49285889,0.00000000,0.00000000,0.00000000,0,15); //object(vgsbikeschl05) (1)
	CreateDynamicObject(9039,-230.99691772,13.53933716,1005.83648682,0.00000000,0.00000000,0.00000000,0,15); //object(csrspalace04_lvs) (1)
	CreateDynamicObject(2296,-219.62890625,-26.70410156,999.78973389,0.00000000,0.00000000,0.00000000,0,15); //object(tv_unit_1) (1)
	CreateDynamicObject(1766,-217.99414062,-30.22949219,999.78973389,0.00000000,0.00000000,179.99450684,0,15); //object(med_couch_1) (1)
	CreateDynamicObject(1734,-218.39170837,-29.54284668,1003.16430664,0.00000000,0.00000000,0.00000000,0,15); //object(cj_mlight2) (1)
	CreateDynamicObject(2713,-216.80523682,-34.09760284,999.93597412,0.00000000,0.00000000,0.00000000,0,15); //object(cj_bucket) (1)
	CreateDynamicObject(14861,-214.88291931,-32.96072006,1000.23675537,0.00000000,0.00000000,0.00000000,0,15); //object(choochie-bed) (1)
	CreateDynamicObject(2081,-213.72824097,-34.38028717,999.78973389,0.00000000,0.00000000,0.00000000,0,15); //object(coffee_swank_3) (1)
	CreateDynamicObject(1670,-213.24475098,-33.80146790,1000.29919434,0.00000000,0.00000000,0.00000000,0,15); //object(propcollecttable) (1)
	CreateDynamicObject(1433,-210.76405334,-31.89801407,999.96942139,0.00000000,0.00000000,0.00000000,0,15); //object(dyn_table_1) (1)
	CreateDynamicObject(1575,-210.89424133,-32.14258575,999.76214600,0.00000000,0.00000000,0.00000000,0,15); //object(drug_white) (1)
	CreateDynamicObject(1810,-210.49656677,-30.49719048,999.78973389,0.00000000,0.00000000,0.00000000,0,15); //object(cj_foldchair) (1)
	CreateDynamicObject(1810,-210.97657776,-33.30371475,999.78973389,0.00000000,0.00000000,180.00000000,0,15); //object(cj_foldchair) (2)
	CreateDynamicObject(1485,-211.02813721,-31.78230095,1000.47741699,0.00000000,0.00000000,0.00000000,0,15); //object(cj_ciggy) (1)
	CreateDynamicObject(1665,-210.82849121,-31.86991501,1000.49786377,0.00000000,0.00000000,0.00000000,0,15); //object(propashtray1) (1)
	CreateDynamicObject(2901,-210.41302490,-26.80377197,1000.18652344,0.00000000,0.00000000,0.00000000,0,15); //object(kmb_marijuana) (1)
	CreateDynamicObject(2901,-210.40884399,-27.23884201,1000.18652344,0.00000000,0.00000000,0.00000000,0,15); //object(kmb_marijuana) (2)
	CreateDynamicObject(2256,-213.72306824,-26.48313522,1001.80023193,0.00000000,0.00000000,0.00000000,0,15); //object(frame_clip_3) (1)
	CreateDynamicObject(2357,-213.80706787,-26.79496765,1000.18487549,0.00000000,0.00000000,0.00000000,0,15); //object(dunc_dinning) (1)
	CreateDynamicObject(935,-209.89999390,-27.75917816,1000.35290527,0.00000000,0.00000000,0.00000000,0,15); //object(cj_drum) (1)
	CreateDynamicObject(923,-215.69982910,-30.46375465,1000.66943359,0.00000000,0.00000000,90.00000000,0,15); //object(packing_carates2) (1)
	CreateDynamicObject(1577,-214.54948425,-26.90003014,999.99212646,0.00000000,0.00000000,31.50000000,0,15); //object(drug_yellow) (1)
	CreateDynamicObject(1578,-214.86738586,-26.96183586,1000.59753418,0.00000000,0.00000000,0.00000000,0,15); //object(drug_green) (1)
	CreateDynamicObject(1579,-212.06269836,-26.91021538,1000.59753418,0.00000000,0.00000000,319.00000000,0,15); //object(drug_blue) (1)
	CreateDynamicObject(1577,-212.03099060,-27.04388809,1000.72680664,0.00000000,0.00000000,12.75000000,0,15); //object(drug_yellow) (2)
	CreateDynamicObject(1576,-213.29864502,-26.75848007,999.99212646,0.00000000,0.00000000,0.00000000,0,15); //object(drug_orange) (1)
	CreateDynamicObject(1650,-211.73072815,-27.00653458,1000.09637451,0.00000000,0.00000000,0.00000000,0,15); //object(petrolcanm) (1)
	CreateDynamicObject(1654,-212.69316101,-26.86517334,1000.81225586,0.00000000,0.00000000,0.00000000,0,15); //object(dynamite) (1)
	CreateDynamicObject(2044,-213.88601685,-26.90267563,1000.62268066,0.00000000,0.00000000,0.00000000,0,15); //object(cj_mp5k) (1)
	CreateDynamicObject(1498,-220.31260681,-34.45148468,999.78973389,0.00000000,0.00000000,0.00000000,0,15); //object(gen_doorext03) (1)

	//BARIERKI

	CreateDynamicObject(1653,355.41442871,-1726.63391113,6.50642014,0.00000000,0.00000000,356.00000000,0,0); //object(fencehaitism)(1)
	CreateDynamicObject(1653,342.59765625,-1725.74121094,6.46270370,0.00000000,0.00000000,355.98999023,0,0); //object(fencehaitism)(2)
	CreateDynamicObject(1653,329.68630981,-1724.74121094,6.46270370,0.00000000,0.00000000,355.98999023,0,0); //object(fencehaitism)(2)
	CreateDynamicObject(1653,317.23156738,-1722.99865723,6.46270370,0.00000000,0.00000000,347.98999023,0,0); //object(fencehaitism)(2)
	CreateDynamicObject(1653,304.71441650,-1720.31018066,6.61507750,0.00000000,0.00000000,347.98645020,0,0); //object(fencehaitism)(2)
	CreateDynamicObject(1653,279.79904175,-1713.67382812,7.24585533,0.00000000,2.00000000,341.98645020,0,0); //object(fencehaitism)(2)
	CreateDynamicObject(1653,292.29003906,-1717.35058594,6.80563688,0.00000000,2.00000000,345.98144531,0,0); //object(fencehaitism)(2)
	CreateDynamicObject(1653,267.72012329,-1709.67639160,7.70476627,0.00000000,358.00000000,161.98242188,0,0); //object(fencehaitism)(2)
	CreateDynamicObject(1653,256.08291626,-1704.47290039,8.28977966,0.00000000,355.99499512,151.98245239,0,0); //object(fencehaitism)(2)
	CreateDynamicObject(1653,245.03997803,-1698.20410156,8.99038315,0.00000000,357.98950195,147.97937012,0,0); //object(fencehaitism)(2)
	CreateDynamicObject(1653,234.47772217,-1690.99267578,9.77454090,0.00000000,355.98950195,141.97937012,0,0); //object(fencehaitism)(2)
	CreateDynamicObject(1653,224.73170471,-1682.80603027,10.65981674,0.00000000,355.98449707,139.97631836,0,0); //object(fencehaitism)(2)
	CreateDynamicObject(1653,159.28984070,-1604.46264648,13.37276268,0.00000000,1.98449707,127.97131348,0,0); //object(fencehaitism)(2)
	CreateDynamicObject(1653,215.62304688,-1673.93359375,11.53921032,0.00000000,355.98449707,133.96728516,0,0); //object(fencehaitism)(2)
	CreateDynamicObject(1653,207.27441406,-1664.47265625,12.45198441,0.00000000,355.98449707,129.96826172,0,0); //object(fencehaitism)(2)
	CreateDynamicObject(1653,199.03125000,-1654.64062500,13.26528645,0.00000000,355.98449707,129.96826172,0,0); //object(fencehaitism)(2)
	CreateDynamicObject(1653,190.99218750,-1644.71386719,13.90201473,0.00000000,357.98400879,127.96875000,0,0); //object(fencehaitism)(2)
	CreateDynamicObject(1653,182.98632812,-1634.51855469,14.26009083,0.00000000,359.98352051,129.96826172,0,0); //object(fencehaitism)(2)
	CreateDynamicObject(1653,175.03717041,-1624.59741211,14.29104900,0.00000000,359.98352051,127.96826172,0,0); //object(fencehaitism)(2)
	CreateDynamicObject(1653,167.14170837,-1614.56237793,13.94002628,0.00000000,1.98352051,127.96826172,0,0); //object(fencehaitism)(2)
	CreateDynamicObject(1653,151.12590027,-1594.59497070,12.62127018,0.00000000,1.98352051,131.96826172,0,0); //object(fencehaitism)(2)
	CreateDynamicObject(983,144.70730591,-1587.78784180,11.97847652,0.00000000,357.99993896,43.99996948,0,0); //object(fenceshit3)(1)
	CreateDynamicObject(2921,1761.70446777,-1867.69055176,22.45734406,0.00000000,0.00000000,0.00000000,0,0); //object(kmb_cam)(1)
	CreateDynamicObject(973,244.38476562,-1536.72265625,32.14707947,0.00000000,0.00000000,237.99133301,0,0); //object(sub_roadbarrier)(1)
	CreateDynamicObject(973,235.60317993,-1552.82568359,32.68863678,0.00000000,357.99499512,241.99584961,0,0); //object(sub_roadbarrier)(2)
	CreateDynamicObject(973,239.81587219,-1544.72705078,32.35064316,0.00000000,357.99499512,241.99584961,0,0); //object(sub_roadbarrier)(1)
	CreateDynamicObject(973,249.41796875,-1528.94238281,32.12515640,0.00000000,0.00000000,235.98632812,0,0); //object(sub_roadbarrier)(1)
	CreateDynamicObject(973,266.34133911,-1506.81848145,32.31144333,0.00000000,1.99951172,227.98278809,0,0); //object(sub_roadbarrier)(1)
	CreateDynamicObject(973,254.67773438,-1521.41699219,32.11988068,0.00000000,0.00000000,233.98132324,0,0); //object(sub_roadbarrier)(1)
	CreateDynamicObject(973,260.30273438,-1513.94238281,32.12939453,0.00000000,0.00000000,231.97631836,0,0); //object(sub_roadbarrier)(1)
	CreateDynamicObject(973,272.57174683,-1499.95629883,32.60319519,0.00000000,2.00000000,227.98280334,0,0); //object(sub_roadbarrier)(1)
	CreateDynamicObject(983,1889.29504395,-1031.21252441,23.59809494,0.00000000,0.00000000,300.00000000,0,0); //object(fenceshit3)(1)
	CreateDynamicObject(983,1857.54382324,-1067.03393555,23.51168060,0.00000000,0.00000000,347.99743652,0,0); //object(fenceshit3)(2)
	CreateDynamicObject(983,1858.88867188,-1060.80566406,23.51168060,0.00000000,0.00000000,347.99743652,0,0); //object(fenceshit3)(3)
	CreateDynamicObject(983,1861.02441406,-1054.89160156,23.51168060,0.00000000,0.00000000,331.99035645,0,0); //object(fenceshit3)(4)
	CreateDynamicObject(983,1864.20117188,-1049.36035156,23.51168060,0.00000000,0.00000000,327.99682617,0,0); //object(fenceshit3)(5)
	CreateDynamicObject(983,1867.85156250,-1044.14550781,23.51168060,0.00000000,0.00000000,321.99829102,0,0); //object(fenceshit3)(6)
	CreateDynamicObject(983,1872.39843750,-1039.89453125,23.54837418,0.00000000,0.00000000,303.99719238,0,0); //object(fenceshit3)(7)
	CreateDynamicObject(983,1877.75390625,-1036.34375000,23.61000824,0.00000000,0.00000000,303.99719238,0,0); //object(fenceshit3)(8)
	CreateDynamicObject(983,1883.47460938,-1033.68261719,23.64347458,0.00000000,0.00000000,285.99609375,0,0); //object(fenceshit3)(9)
	CreateDynamicObject(994,1896.88525391,-1033.30041504,-8.50956345,0.00000000,0.00000000,276.00000000,0,0); //object(lhouse_barrier2)(1)
	CreateDynamicObject(994,1830.66857910,-1063.11193848,23.23169708,0.00000000,0.00000000,272.00000000,0,0); //object(lhouse_barrier2)(2)
	CreateDynamicObject(994,1830.08032227,-1056.94384766,23.09533310,0.00000000,0.00000000,275.99951172,0,0); //object(lhouse_barrier2)(3)
	CreateDynamicObject(994,1829.21447754,-1044.59033203,23.15897560,0.00000000,0.00000000,273.99951172,0,0); //object(lhouse_barrier2)(4)
	CreateDynamicObject(994,1829.67773438,-1050.79394531,23.13388252,0.00000000,0.00000000,273.99902344,0,0); //object(lhouse_barrier2)(5)
	CreateDynamicObject(994,1827.54992676,-1038.67419434,23.11796188,0.00000000,0.00000000,285.99902344,0,0); //object(lhouse_barrier2)(6)
	CreateDynamicObject(994,1825.23510742,-1032.94409180,23.09960175,0.00000000,0.00000000,291.99609375,0,0); //object(lhouse_barrier2)(7)
	CreateDynamicObject(994,1822.49743652,-1027.40966797,23.11502075,0.00000000,0.00000000,295.99462891,0,0); //object(lhouse_barrier2)(8)
	CreateDynamicObject(994,1819.41870117,-1022.08013916,23.09151840,0.00000000,0.00000000,299.99365234,0,0); //object(lhouse_barrier2)(9)
	CreateDynamicObject(994,1816.36962891,-1016.64208984,23.07812500,0.00000000,0.00000000,299.99267578,0,0); //object(lhouse_barrier2)(10)
	CreateDynamicObject(970,1826.83703613,-1741.05859375,13.04051781,0.00000000,0.00000000,90.33474731,0,0); //object(fencesmallb)(1)
	CreateDynamicObject(970,1826.87255859,-1736.94677734,13.04051781,0.00000000,0.00000000,90.32958984,0,0); //object(fencesmallb)(2)
	CreateDynamicObject(970,1828.03405762,-1744.79650879,13.04051781,0.00000000,0.00000000,125.71310425,0,0); //object(fencesmallb)(3)
	CreateDynamicObject(970,1833.56958008,-1747.25927734,13.04051781,0.00000000,0.00000000,177.62097168,0,0); //object(fencesmallb)(4)
	CreateDynamicObject(970,1806.31884766,-1737.52319336,13.04051781,0.00000000,0.00000000,0.00000000,0,0); //object(fencesmallb)(5)
	CreateDynamicObject(970,1815.54858398,-1739.93884277,13.04051781,0.00000000,0.00000000,306.91882324,0,0); //object(fencesmallb)(6)
	CreateDynamicObject(970,1810.46850586,-1737.55456543,13.04051781,0.00000000,0.00000000,0.00000000,0,0); //object(fencesmallb)(7)
	CreateDynamicObject(970,1809.77612305,-1727.03686523,13.04051781,0.00000000,0.00000000,0.00000000,0,0); //object(fencesmallb)(8)
	CreateDynamicObject(970,1805.67102051,-1727.05175781,13.04051781,0.00000000,0.00000000,0.00000000,0,0); //object(fencesmallb)(9)
	CreateDynamicObject(970,1815.11547852,-1725.04614258,13.04051781,0.00000000,0.00000000,52.41641235,0,0); //object(fencesmallb)(10)
	CreateDynamicObject(970,1816.44213867,-1721.31286621,13.04051781,0.00000000,0.00000000,88.40759277,0,0); //object(fencesmallb)(11)
	CreateDynamicObject(970,1816.74609375,-1743.66442871,13.04051781,0.00000000,0.00000000,268.99560547,0,0); //object(fencesmallb)(12)
	CreateDynamicObject(984,1941.03723145,-1772.82788086,13.27730465,0.00000000,0.00000000,0.00000000,0,0); //object(fenceshit2)(1)
	CreateDynamicObject(984,1942.29785156,-1772.92016602,13.27730465,0.00000000,0.00000000,0.00000000,0,0); //object(fenceshit2)(2)

//BARIERKI POCIOGOWE
	CreateDynamicObject(7838,2286.97607422,-1302.36889648,26.06840897,0.00000000,0.00000000,90.00000000,0,0); //object(vegaswtrainfence01)(1)
	CreateDynamicObject(1374,2195.06762695,-1738.10754395,13.36900520,0.00000000,0.00000000,0.00000000,0,0); //object(traincross2)(2)
	CreateDynamicObject(1374,2194.88525391,-1725.33801270,13.36900520,0.00000000,0.00000000,180.41833496,0,0); //object(traincross2)(3)
	CreateDynamicObject(1374,2206.41015625,-1738.75219727,13.38367844,0.00000000,0.00000000,358.76269531,0,0); //object(traincross2)(4)
	CreateDynamicObject(1374,2206.38281250,-1725.79589844,13.38793468,0.00000000,0.00000000,179.39343262,0,0); //object(traincross2)(6)
	CreateDynamicObject(1374,2220.13134766,-1642.91992188,15.63966274,0.00000000,0.00000000,163.15490723,0,0); //object(traincross2)(7)
	CreateDynamicObject(1374,2209.00415039,-1639.75146484,15.63966274,0.00000000,0.00000000,164.78259277,0,0); //object(traincross2)(8)
	CreateDynamicObject(1374,2205.91040039,-1652.27905273,15.61126232,0.00000000,0.00000000,344.84667969,0,0); //object(traincross2)(9)
	CreateDynamicObject(1374,2216.94848633,-1654.75683594,15.58286190,0.00000000,0.00000000,345.62817383,0,0); //object(traincross2)(10)
	CreateDynamicObject(1374,2281.92553711,-1479.41271973,22.71518517,0.00000000,0.00000000,165.03222656,0,0); //object(traincross2)(12)
	CreateDynamicObject(1374,2268.51660156,-1488.95092773,22.75667572,0.00000000,0.00000000,347.32971191,0,0); //object(traincross2)(13)
	CreateDynamicObject(1374,2281.42700195,-1388.98840332,24.06714249,0.00000000,0.00000000,0.00000000,0,0); //object(traincross2)(14)
	CreateDynamicObject(1374,2293.19482422,-1379.29467773,24.15916634,0.00000000,0.00000000,180.00000000,0,0); //object(traincross2)(15)
	CreateDynamicObject(1374,2293.04199219,-1145.53259277,26.86474609,0.00000000,0.00000000,180.00000000,0,0); //object(traincross2)(16)
	CreateDynamicObject(1374,2281.43554688,-1154.17578125,26.69950104,0.00000000,0.00000000,0.00000000,0,0); //object(traincross2)(17)
	//CreateDynamicObject(966,2420.88623047,-2061.72167969,12.50368595,0.00000000,0.00000000,0.00000000,0,0); //object(bar_gatebar01)(1)
	//CreateDynamicObject(966,2406.75634766,-2061.72753906,12.50368595,0.00000000,0.00000000,180.00000000,0,0); //object(bar_gatebar01)(2)
	CreateDynamicObject(967,2293.75537109,-1144.58715820,25.78098297,0.00000000,0.00000000,0.00000000,0,0); //object(bar_gatebox01)(1)
	CreateDynamicObject(967,2280.51586914,-1154.88464355,25.78098297,0.00000000,0.00000000,176.25927734,0,0); //object(bar_gatebox01)(2)
	CreateDynamicObject(967,2294.03125000,-1378.36975098,23.07084656,0.00000000,0.00000000,0.00000000,0,0); //object(bar_gatebox01)(3)
	CreateDynamicObject(967,2280.40454102,-1389.73315430,23.06909180,0.00000000,0.00000000,180.06127930,0,0); //object(bar_gatebox01)(4)
	CreateDynamicObject(967,2282.98120117,-1478.75769043,21.67401886,0.00000000,0.00000000,348.59399414,0,0); //object(bar_gatebox01)(5)
	CreateDynamicObject(967,2267.43090820,-1489.65869141,21.63111496,0.00000000,0.00000000,172.45727539,0,0); //object(bar_gatebox01)(6)
	CreateDynamicObject(967,2208.30346680,-1638.77807617,14.34785938,0.00000000,0.00000000,165.51232910,0,0); //object(bar_gatebox01)(7)
	CreateDynamicObject(967,2204.77539062,-1652.17639160,14.16105652,0.00000000,0.00000000,161.10205078,0,0); //object(bar_gatebox01)(8)
	CreateDynamicObject(967,2221.17309570,-1642.49938965,14.45162582,0.00000000,0.00000000,343.57550049,0,0); //object(bar_gatebox01)(9)
	CreateDynamicObject(967,2217.73583984,-1655.21350098,14.18844891,0.00000000,0.00000000,347.32666016,0,0); //object(bar_gatebox01)(10)
	CreateDynamicObject(967,2207.31176758,-1725.11840820,12.41304779,0.00000000,0.00000000,0.00000000,0,0); //object(bar_gatebox01)(11)
	CreateDynamicObject(967,2207.32617188,-1739.17871094,12.37414265,0.00000000,0.00000000,0.00000000,0,0); //object(bar_gatebox01)(12)
	CreateDynamicObject(967,2193.87963867,-1724.62683105,12.55900574,0.00000000,0.00000000,178.13488770,0,0); //object(bar_gatebox01)(13)
	CreateDynamicObject(8673,2194.04931641,-1710.21887207,13.92850590,0.00000000,0.00000000,88.45919800,0,0); //object(csrsfence03_lvs)(1)
	CreateDynamicObject(8673,2208.80664062,-1711.76977539,13.92850590,0.00000000,0.00000000,84.65438843,0,0); //object(csrsfence03_lvs)(2)
	CreateDynamicObject(8673,2211.16552734,-1691.51940918,14.11310863,0.00000000,358.97265625,82.11730957,0,0); //object(csrsfence03_lvs)(4)
	CreateDynamicObject(8673,2215.55346680,-1671.67822266,14.78051853,0.00000000,357.46533203,73.24365234,0,0); //object(csrsfence03_lvs)(5)
	CreateDynamicObject(8673,2195.85766602,-1689.94604492,14.11310863,0.00000000,358.96728516,82.11730957,0,0); //object(csrsfence03_lvs)(6)
	CreateDynamicObject(8673,2199.37426758,-1669.84680176,14.78051853,0.00000000,357.46215820,78.30969238,0,0); //object(csrsfence03_lvs)(7)
	CreateDynamicObject(967,1955.69519043,-1949.08508301,12.68245983,0.00000000,0.00000000,90.33474731,0,0); //object(bar_gatebox01)(14)
	CreateDynamicObject(967,1967.77612305,-1963.00170898,12.68245983,0.00000000,0.00000000,270.34008789,0,0); //object(bar_gatebox01)(15)
	CreateDynamicObject(1374,1956.43090820,-1950.05187988,13.89258957,0.00000000,0.00000000,269.05688477,0,0); //object(traincross2)(1)
	CreateDynamicObject(1374,1966.93383789,-1962.11804199,13.86418915,0.00000000,0.00000000,90.00000000,0,0); //object(traincross2)(5)
	CreateDynamicObject(4853,2293.13256836,-1205.09020996,26.74056625,0.00000000,1.48498535,270.27026367,0,0); //object(traincano_las) (1)
	CreateDynamicObject(982,2281.47534180,-1240.37707520,23.68355560,0.00000000,0.00000000,0.00000000,0,0); //object(fenceshit) (1)
	CreateDynamicObject(984,2281.45336914,-1221.16271973,23.64136505,0.00000000,0.00000000,0.00000000,0,0); //object(fenceshit2) (1)
	CreateDynamicObject(982,2281.45605469,-1201.99304199,24.25854683,1.98498535,0.00000000,0.00000000,0,0); //object(fenceshit) (2)
	CreateDynamicObject(982,2281.47778320,-1176.39501953,25.40854073,2.23303223,1.98498535,0.00000000,0,0); //object(fenceshit) (3)
	CreateDynamicObject(983,2281.66870117,-1157.06872559,26.19661903,1.98498535,0.00000000,358.01501465,0,0); //object(fenceshit3) (2)
	CreateDynamicObject(983,2291.06689453,-1157.70996094,26.19661903,1.98303223,0.00000000,1.98144531,0,0); //object(fenceshit3) (3)
	CreateDynamicObject(1280,2295.24291992,-1164.68701172,25.83501816,0.00000000,0.00000000,3.96997070,0,0); //object(parkbench1) (1)
	CreateDynamicObject(1280,2295.84741211,-1170.51879883,25.58501816,0.00000000,0.00000000,356.02612305,0,0); //object(parkbench1) (2)
	CreateDynamicObject(1280,2295.38940430,-1190.64379883,24.63501358,0.00000000,0.00000000,356.02294922,0,0); //object(parkbench1) (3)
	CreateDynamicObject(1280,2294.67089844,-1184.45703125,25.01001167,0.00000000,0.00000000,3.96289062,0,0); //object(parkbench1) (4)
	CreateDynamicObject(1280,2295.43261719,-1201.42980957,23.93502426,0.00000000,0.00000000,356.02294922,0,0); //object(parkbench1) (5)
	CreateDynamicObject(1280,2295.11083984,-1208.15966797,23.85999870,0.00000000,0.00000000,9.91784668,0,0); //object(parkbench1) (6)
	CreateDynamicObject(1280,2293.45629883,-1224.58154297,23.36002922,0.00000000,0.00000000,9.91784668,0,0); //object(parkbench1) (7)
	CreateDynamicObject(1280,2294.47265625,-1240.19104004,23.33502197,0.00000000,0.00000000,354.03527832,0,0); //object(parkbench1) (8)
	CreateDynamicObject(962,2293.10327148,-1175.17761230,26.09350777,91.31002808,0.00000000,0.00000000,0,0); //object(cj_t_ticket_ped) (1)
	CreateDynamicObject(962,2293.57299805,-1192.94555664,25.19352150,91.30737305,0.00000000,89.73001099,0,0); //object(cj_t_ticket_ped) (2)
	CreateDynamicObject(962,2293.42700195,-1161.88562012,26.59350014,91.30187988,0.00000000,89.72534180,0,0); //object(cj_t_ticket_ped) (3)
	CreateDynamicObject(962,2293.80444336,-1229.51049805,24.01853943,91.30187988,0.00000000,89.72534180,0,0); //object(cj_t_ticket_ped) (4)
	CreateDynamicObject(970,825.31311035,-1337.20312500,13.09835625,0.00000000,0.00000000,0.00000000,0,0); //object(fencesmallb) (1)
	CreateDynamicObject(970,817.15106201,-1337.19714355,13.09835625,0.00000000,0.00000000,0.00000000,0,0); //object(fencesmallb) (2)
	CreateDynamicObject(970,809.56604004,-1337.51196289,13.09835625,0.00000000,0.00000000,0.00000000,0,0); //object(fencesmallb) (3)
	CreateDynamicObject(970,807.43902588,-1339.65136719,13.09835625,0.00000000,0.00000000,89.73004150,0,0); //object(fencesmallb) (4)
	CreateDynamicObject(970,807.42010498,-1347.17932129,13.09835625,0.00000000,0.00000000,89.72534180,0,0); //object(fencesmallb) (5)
	CreateDynamicObject(970,807.52294922,-1354.80822754,13.09835625,0.00000000,0.00000000,89.72534180,0,0); //object(fencesmallb) (6)
	CreateDynamicObject(949,821.20703125,-1337.30505371,13.18315887,0.00000000,0.00000000,0.00000000,0,0); //object(plant_pot_4) (1)
	CreateDynamicObject(949,813.31921387,-1337.37402344,13.18315887,0.00000000,0.00000000,0.00000000,0,0); //object(plant_pot_4) (2)
	CreateDynamicObject(949,807.60272217,-1343.43859863,13.18315887,0.00000000,0.00000000,0.00000000,0,0); //object(plant_pot_4) (3)
	CreateDynamicObject(949,807.73962402,-1351.19494629,13.18315887,0.00000000,0.00000000,0.00000000,0,0); //object(plant_pot_4) (4)
	//CreateDynamicObject(4732,847.24658203,-1400.18090820,-1.37181902,1.98498535,1.98501587,194.25103760,0,0); //object(billbrdlan2_06) (1) bilboard market
	CreateDynamicObject(984,2228.25488281,-1604.37292480,16.05785179,0.00000000,0.00000000,66.00000000,0,0); //object(fenceshit2) (1) BLOKADA TOROWA
	CreateDynamicObject(984,2198.51586914,-1921.54467773,13.05784416,0.00000000,0.00000000,65.99487305,0,0); //object(fenceshit2) (2) BLOKADA TOROWA
	CreateDynamicObject(984,2198.51586914,-1921.54467773,13.05784416,0.00000000,0.00000000,65.99487305,0,0); //object(fenceshit2) (3) BLOKADA TOROWA


	//BARIERKI PARKINGOWE
	CreateDynamicObject(970,1451.22387695,-1016.55102539,26.95459747,0.00000000,0.00000000,270.27026367,0,0); //object(fencesmallb)(1)
	CreateDynamicObject(970,1472.56433105,-1017.09344482,26.95459747,0.00000000,0.00000000,270.26916504,0,0); //object(fencesmallb)(3)
	CreateDynamicObject(982,1545.25537109,-1033.26135254,23.72661591,0.00000000,0.00000000,250.79064941,0,0); //object(fenceshit)(1)
	CreateDynamicObject(982,1565.12280273,-1042.67370605,23.72661591,0.00000000,0.00000000,226.97058105,0,0); //object(fenceshit)(3)
	CreateDynamicObject(982,1581.79162598,-1061.91210938,23.72661591,0.00000000,0.00000000,215.05664062,0,0); //object(fenceshit)(4)
	CreateDynamicObject(982,1593.77148438,-1084.28918457,23.72661591,0.00000000,0.00000000,201.15698242,0,0); //object(fenceshit)(5)
	CreateDynamicObject(982,1600.50231934,-1108.84521484,23.72661591,0.00000000,0.00000000,189.24426270,0,0); //object(fenceshit)(6)
	CreateDynamicObject(982,1604.61743164,-1134.12634277,23.72661591,0.00000000,0.00000000,189.23950195,0,0); //object(fenceshit)(7)
	CreateDynamicObject(982,1619.49658203,-1146.57202148,23.72661591,0.00000000,0.00000000,270.62390137,0,0); //object(fenceshit)(8)
	CreateDynamicObject(982,1660.43688965,-1146.75842285,23.72661591,0.00000000,0.00000000,270.62072754,0,0); //object(fenceshit)(9)
	CreateDynamicObject(982,1685.72021484,-1128.32263184,23.72661591,0.00000000,0.00000000,359.75000000,0,0); //object(fenceshit)(11)
	CreateDynamicObject(982,1685.82592773,-1107.54846191,23.72661591,0.00000000,0.00000000,359.74731445,0,0); //object(fenceshit)(13)
	CreateDynamicObject(982,1698.66943359,-1094.78527832,23.72661591,0.00000000,0.00000000,270.00000000,0,0); //object(fenceshit)(14)
	CreateDynamicObject(982,1724.29248047,-1094.76586914,23.72661591,0.00000000,0.00000000,270.00000000,0,0); //object(fenceshit)(15)
	CreateDynamicObject(982,1749.91979980,-1094.89648438,23.72661591,0.00000000,0.00000000,270.00000000,0,0); //object(fenceshit)(16)
	CreateDynamicObject(982,1775.52001953,-1094.93298340,23.72661591,0.00000000,0.00000000,270.00000000,0,0); //object(fenceshit)(17)
	CreateDynamicObject(982,1794.70410156,-1094.94787598,23.72661591,0.00000000,0.00000000,270.00000000,0,0); //object(fenceshit)(18)
	CreateDynamicObject(984,1806.45532227,-1102.65991211,23.71480560,0.00000000,0.00000000,0.00000000,0,0); //object(fenceshit2)(1)
	CreateDynamicObject(984,1806.42395020,-1134.98315430,23.71480560,0.00000000,0.00000000,0.00000000,0,0); //object(fenceshit2)(2)
	CreateDynamicObject(984,1806.35559082,-1147.95104980,23.71480560,0.00000000,0.00000000,0.00000000,0,0); //object(fenceshit2)(3)
	CreateDynamicObject(984,1674.81652832,-1146.58947754,23.68788719,0.00000000,0.00000000,270.31530762,0,0); //object(fenceshit2)(4)
	CreateDynamicObject(983,1683.56481934,-1144.03613281,23.76375580,0.00000000,0.00000000,321.13513184,0,0); //object(fenceshit3)(3)
	CreateDynamicObject(982,1538.53906250,-1017.47229004,23.72661591,0.00000000,0.00000000,155.12048340,0,0); //object(fenceshit)(19)
	CreateDynamicObject(983,1544.02014160,-1002.76580811,23.72395706,0.00000000,0.00000000,0.00000000,0,0); //object(fenceshit3)(5)

	//blokady strip domu i sweeta
	CreateDynamicObject(2591,1207.46765137,-46.08613205,1001.76159668,90.00000000,180.68768311,269.81219482); //object(ab_partition1) (6)
	CreateDynamicObject(2591,1209.71777344,-44.31640625,1001.76159668,90.00000000,180.68664551,179.80773926); //object(ab_partition1) (8)
	CreateDynamicObject(2591,1204.82031250,-44.15281677,1001.76159668,90.00000000,179.31671143,181.17762756); //object(ab_partition1) (9)
	CreateDynamicObject(1433,1205.98327637,-42.90816498,999.83251953,0.00000000,0.00000000,0.00000000); //object(dyn_table_1) (1)
	CreateDynamicObject(7914,2524.80078125,-1681.52050781,1015.37731934,0.00000000,0.00000000,179.99450684); //object(vgwestbillbrd15) (3)
//blokady przyczepy
	CreateDynamicObject(14385,2511.6440430,-1725.4372559,779.2086792,0.0000000,0.0000000,0.0000000,-1,1); //object(kb_tr_main) (1)
	CreateDynamicObject(14386,2511.6848145,-1726.3349609,779.0711670,0.0000000,0.0000000,0.0000000,-1,1); //object(kb_tr_bits) (1)
	CreateDynamicObject(6959,2509.9904785,-1725.0656738,777.6414185,0.0000000,0.0000000,0.0000000,-1,1); //object(vegasnbball1) (1)
	CreateDynamicObject(5856,2509.5332031,-1731.3901367,779.6163330,0.0000000,0.0000000,0.0000000,-1,1); //object(lawnspraydoor1) (1)
	CreateDynamicObject(5856,2509.3283691,-1728.6035156,779.6163330,0.0000000,0.0000000,0.0000000,-1,1); //object(lawnspraydoor1) (2)
	CreateDynamicObject(5856,2509.5329590,-1726.1125488,779.6163330,0.0000000,0.0000000,0.0000000,-1,1); //object(lawnspraydoor1) (4)
	CreateDynamicObject(5856,2509.5126953,-1722.1784668,779.6163330,0.0000000,0.0000000,0.0000000,-1,1); //object(lawnspraydoor1) (5)
	CreateDynamicObject(5856,2508.4736328,-1723.2641602,779.6163330,0.0000000,0.0000000,90.0000000,-1,1); //object(lawnspraydoor1) (6)
	CreateDynamicObject(5856,2511.7490234,-1732.3557129,779.6413574,0.0000000,0.0000000,90.0000000,-1,1); //object(lawnspraydoor1) (7)
	CreateDynamicObject(5856,2512.5046387,-1718.4487305,779.6163330,0.0000000,0.0000000,90.0000000,-1,1); //object(lawnspraydoor1) (8)
	CreateDynamicObject(5856,2508.4721680,-1720.5766602,779.6163330,0.0000000,0.0000000,90.0000000,-1,1); //object(lawnspraydoor1) (9)
	CreateDynamicObject(5856,2510.4992676,-1718.5354004,779.6163330,0.0000000,0.0000000,0.0000000,-1,1); //object(lawnspraydoor1) (10)
	CreateDynamicObject(5856,2513.8713379,-1722.2637939,779.6163330,0.0000000,0.0000000,0.0000000,-1,1); //object(lawnspraydoor1) (11)
	CreateDynamicObject(5856,2513.8244629,-1718.4649658,779.6163330,0.0000000,0.0000000,0.0000000,-1,1); //object(lawnspraydoor1) (12)
	CreateDynamicObject(5856,2513.8791504,-1726.2656250,779.6163330,0.0000000,0.0000000,0.0000000,-1,1); //object(lawnspraydoor1) (13)
	CreateDynamicObject(5856,2513.8591309,-1732.0061035,779.6163330,0.0000000,0.0000000,0.0000000,-1,1); //object(lawnspraydoor1) (14)
	CreateDynamicObject(1506,2513.8571777,-1728.3886719,777.6351929,0.0000000,0.0000000,270.2702637,-1,1); //object(gen_doorext08) (1)
	CreateDynamicObject(1506,2513.9123535,-1728.4082031,779.4707642,0.0000000,0.0000000,270.2691650,-1,1); //object(gen_doorext08) (3)
	CreateDynamicObject(970,2511.7482910,-1732.0765381,778.1616211,90.0000000,180.0000000,0.0000000,-1,1); //object(fencesmallb) (1)
	CreateDynamicObject(970,2509.7839355,-1732.3435059,778.1885376,90.0000000,168.4630127,281.5370178,-1,1); //object(fencesmallb) (2)
	CreateDynamicObject(970,2513.5830078,-1732.3240967,778.0884399,90.0000000,165.5224609,104.4775085,-1,1); //object(fencesmallb) (3)
	CreateDynamicObject(970,2513.5788574,-1725.8922119,778.0634155,90.0000000,191.0969391,78.8974915,-1,1); //object(fencesmallb) (4)
	CreateDynamicObject(970,2513.8769531,-1726.1137695,778.0827637,90.0000000,179.9945068,0.0000000,-1,1); //object(fencesmallb) (5)
	CreateDynamicObject(970,2509.6020508,-1728.1053467,778.7639771,90.0000000,173.2777710,276.7167969,-1,1); //object(fencesmallb) (6)
	CreateDynamicObject(1271,2510.1789551,-1723.8309326,778.1372070,0.0000000,0.0000000,0.0000000,-1,1); //object(gunbox) (2)
	CreateDynamicObject(1271,2510.1772461,-1725.7858887,778.3374023,0.0000000,0.0000000,0.0000000,-1,1); //object(gunbox) (3)
	CreateDynamicObject(1271,2510.1281738,-1724.2731934,777.9870605,0.0000000,0.0000000,0.0000000,-1,1); //object(gunbox) (4)
	CreateDynamicObject(970,2508.4267578,-1724.9364014,778.6378174,90.0000000,179.9945068,0.0000000,-1,1); //object(fencesmallb) (8)
	CreateDynamicObject(970,2508.7167969,-1726.8057861,778.1885376,0.0000000,0.0000000,0.0000000,-1,1); //object(fencesmallb) (9)
	CreateDynamicObject(970,2508.7116699,-1726.3732910,778.1885376,0.0000000,0.0000000,0.0000000,-1,1); //object(fencesmallb) (10)
	CreateDynamicObject(970,2513.8593750,-1725.2668457,778.6139526,90.0000000,179.9945068,0.0000000,-1,1); //object(fencesmallb) (11)
	CreateDynamicObject(970,2513.4030762,-1723.7486572,778.6389771,90.0000000,180.0000000,90.0000000,-1,1); //object(fencesmallb) (12)
	CreateDynamicObject(970,2513.8271484,-1725.8184814,778.1885376,0.0000000,0.0000000,0.0000000,-1,1); //object(fencesmallb) (13)
	CreateDynamicObject(1271,2509.6694336,-1727.2437744,779.7630615,0.0000000,0.0000000,0.0000000,-1,1); //object(gunbox) (7)
	CreateDynamicObject(2238,2509.9104004,-1729.9641113,779.8054810,0.0000000,0.0000000,0.0000000,-1,1); //object(cj_lava_lamp) (1)
	CreateDynamicObject(2238,2510.3613281,-1726.6191406,778.6047974,90.0000000,0.0000000,90.0000000,-1,1); //object(cj_lava_lamp) (2)
	CreateDynamicObject(970,2511.1430664,-1720.6307373,778.7891235,0.0000000,90.0000000,0.0000000,-1,1); //object(fencesmallb) (15)
	CreateDynamicObject(970,2513.4511719,-1720.5996094,778.7390747,0.0000000,90.0000000,0.0000000,-1,1); //object(fencesmallb) (16)
	CreateDynamicObject(970,2512.9206543,-1720.6281738,780.8888550,0.0000000,0.0000000,0.0000000,-1,1); //object(fencesmallb) (17)
	CreateDynamicObject(970,2510.5393066,-1721.0786133,778.1885376,0.0000000,90.0000000,269.9999695,-1,1); //object(fencesmallb) (18)
	CreateDynamicObject(970,2510.7844238,-1719.4598389,777.9633179,90.0000000,180.0054932,180.0000000,-1,1); //object(fencesmallb) (19)
	CreateDynamicObject(970,2510.7119141,-1718.8691406,778.0615234,90.0000000,179.9945068,0.0000000,-1,1); //object(fencesmallb) (20)
	CreateDynamicObject(2238,2513.5124512,-1724.4338379,779.5989380,0.0000000,0.0000000,0.0000000,-1,1); //object(cj_lava_lamp) (3)
	CreateDynamicObject(2238,2513.5400391,-1723.8822021,779.5709839,0.0000000,0.0000000,0.0000000,-1,1); //object(cj_lava_lamp) (4)
	CreateDynamicObject(2238,2513.4960938,-1722.4223633,779.6822510,0.0000000,0.0000000,0.0000000,-1,1); //object(cj_lava_lamp) (5)
	CreateDynamicObject(2238,2513.4960938,-1721.9129639,779.6298828,0.0000000,0.0000000,0.0000000,-1,1); //object(cj_lava_lamp) (6)
	CreateDynamicObject(2238,2513.5178223,-1723.0928955,779.8128052,0.0000000,90.0000000,89.9999390,-1,1); //object(cj_lava_lamp) (7)
	CreateDynamicObject(2238,2512.3391113,-1725.8925781,779.8457642,0.0000000,90.0000000,0.0000000,-1,1); //object(cj_lava_lamp) (8)
	CreateDynamicObject(2238,2513.2202148,-1725.8386230,779.8660889,0.0000000,90.0000000,0.0000000,-1,1); //object(cj_lava_lamp) (9)
	CreateDynamicObject(2238,2510.3190918,-1726.6335449,778.8257446,0.0000000,0.0000000,0.0000000,-1,1); //object(cj_lava_lamp) (10)
	CreateDynamicObject(5856,2509.5227051,-1728.5290527,782.3333740,0.0000000,0.0000000,0.0000000,-1,1); //object(lawnspraydoor1) (15)
	CreateDynamicObject(5856,2511.6645508,-1731.2861328,780.8690186,0.0000000,90.0000000,89.9999390,-1,1); //object(lawnspraydoor1) (16)
	CreateDynamicObject(1749,2509.7956543,-1725.8513184,778.6533203,0.0000000,0.0000000,89.7300415,-1,1); //object(med_tv_3) (1)
	CreateDynamicObject(5856,2511.6823730,-1727.1639404,780.8690186,0.0000000,90.0000000,89.9999390,-1,1); //object(lawnspraydoor1) (17)
	CreateDynamicObject(5856,2511.6694336,-1723.1278076,780.8690186,0.0000000,90.0000000,89.9998779,-1,1); //object(lawnspraydoor1) (18)
	CreateDynamicObject(5856,2511.6789551,-1719.7656250,780.8690186,0.0000000,90.0000000,90.0000000,-1,1); //object(lawnspraydoor1) (19)
	CreateDynamicObject(970,2510.5478516,-1721.1650391,780.8031616,0.0000000,0.0000000,90.0000000,-1,1); //object(fencesmallb) (22)
	CreateDynamicObject(3461,2510.5417480,-1722.7398682,779.8877563,0.0000000,0.0000000,0.0000000,-1,1); //object(tikitorch01_lvs) (1)
	CreateDynamicObject(3461,2510.5366211,-1723.1580811,779.9127808,0.0000000,0.0000000,0.0000000,-1,1); //object(tikitorch01_lvs) (2)

	//Wozki pod 24/7

	CreateDynamicObject(1349,1359.06616211,-1753.61254883,12.94061470,0.00000000,0.00000000,153.42980957,0,0); //object(cj_shtrolly)(1)
	CreateDynamicObject(1349,1347.25244141,-1754.01867676,12.94061470,0.00000000,0.00000000,97.84967041,0,0); //object(cj_shtrolly)(2)
	CreateDynamicObject(1349,1344.02636719,-1753.62011719,12.94061470,0.00000000,0.00000000,40.05065918,0,0); //object(cj_shtrolly)(3)
	CreateDynamicObject(1349,1339.63500977,-1749.77795410,12.94061470,0.00000000,0.00000000,16.23077393,0,0); //object(cj_shtrolly)(4)
	CreateDynamicObject(1349,1354.15039062,-1757.57519531,13.44061470,0.00000000,0.00000000,67.71423340,0,0); //object(cj_shtrolly)(5)
	//#CreateDynamicObject(1349,1831.69128418,-1845.47314453,13.14850998,0.00000000,0.00000000,129.61004639,0,0); //object(cj_shtrolly)(6)
	//#CreateDynamicObject(1349,1830.03417969,-1839.27929688,13.14850998,0.00000000,0.00000000,258.94226074,0,0); //object(cj_shtrolly)(7)

	//koúciÛ≥ + konfesjona≥
	CreateDynamicObject(9931, 1947.54004, -368.51270, 1108.01086,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(3976, 1970.65723, -341.23883, 1100.22949,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(9931, 1980.55762, -368.51563, 1108.01086,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(3976, 1962.70117, -400.46680, 1109.52942,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(11472, 1964.78711, -372.02051, 1089.22351,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(11472, 1963.28967, -372.02139, 1089.22351,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(11472, 1964.04480, -372.98050, 1089.46387,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(2896, 1959.29248, -370.91724, 1093.34314,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(11472, 1962.66919, -373.82990, 1087.66956,   90.00000, 180.00000, 270.00000,0,3); //
	CreateDynamicObject(11472, 1965.40967, -373.76257, 1087.66992,   90.00000, 179.99451, 90.00000,0,3); //
	CreateDynamicObject(970, 1970.61438, -368.20404, 1093.28040,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(970, 1968.51074, -368.20703, 1093.28040,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(970, 1957.52185, -368.25833, 1093.28040,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(970, 1959.61914, -368.25586, 1093.28040,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(6959, 1963.97839, -368.12149, 1072.75439,   90.00000, 0.00000, 0.25000,0,3); //
	CreateDynamicObject(2960, 1964.05884, -348.98987, 1101.36646,   0.00000, 90.00000, 89.99451,0,3); //
	CreateDynamicObject(2960, 1963.98291, -349.00000, 1101.70667,   90.00000, 0.00000, 179.99451,0,3); //
	CreateDynamicObject(2960, 1964.05872, -348.99045, 1100.00586,   0.00000, 90.00000, 90.00000,0,3); //
	CreateDynamicObject(3872, 1964.02686, -346.40851, 1102.33020,   0.00000, 155.25000, 90.27026,0,3); //
	CreateDynamicObject(1667, 1962.98828, -370.41272, 1093.62292,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(1664, 1962.83521, -370.42520, 1093.70105,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(2868, 1965.95605, -370.30142, 1093.53430,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(2869, 1964.02185, -373.78528, 1093.66992,   0.00000, 0.00000, 323.75000,0,3); //
	CreateDynamicObject(2870, 1965.26270, -373.64063, 1093.66992,   0.00000, 0.00000, 350.03003,0,3); //
	CreateDynamicObject(2270, 1965.47998, -352.47623, 1093.48364,   0.00000, 0.00000, 270.00000,0,3); //
	CreateDynamicObject(2257, 1964.05615, -373.94995, 1095.86133,   0.00000, 0.00000, 180.00000,0,3); //
	CreateDynamicObject(2271, 1962.60437, -352.58060, 1093.48804,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(2357, 1964.05090, -370.68906, 1093.12402,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(2808, 1956.07825, -366.98364, 1092.59192,   0.00000, 0.00000, 270.00000,0,3); //
	CreateDynamicObject(2808, 1959.68164, -364.26172, 1092.59192,   0.00000, 0.00000, 179.99451,0,3); //
	CreateDynamicObject(2808, 1968.44238, -364.26172, 1092.59192,   0.00000, 0.00000, 179.99451,0,3); //
	CreateDynamicObject(2808, 1961.85547, -364.26172, 1092.59192,   0.00000, 0.00000, 179.99451,0,3); //
	CreateDynamicObject(2808, 1966.27246, -364.26172, 1092.59192,   0.00000, 0.00000, 179.99451,0,3); //
	CreateDynamicObject(2868, 1962.14697, -370.30624, 1093.53430,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(948, 1966.09277, -374.17285, 1092.72888,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(948, 1961.96313, -374.22888, 1092.72888,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(2894, 1963.95081, -370.94278, 1093.53430,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(3462, 1959.30408, -374.06839, 1094.24255,   0.00000, 0.00000, 270.00000,0,3); //
	CreateDynamicObject(3462, 1968.78125, -374.06836, 1094.24255,   0.00000, 0.00000, 270.00000,0,3); //
	CreateDynamicObject(949, 1956.02258, -353.46194, 1095.83191,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(2946, 1965.59998, -349.25546, 1091.94543,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(2946, 1962.44141, -349.24179, 1091.94543,   0.00000, 0.00000, 270.00000,0,3); //
	CreateDynamicObject(2808, 1968.43054, -360.67249, 1092.59192,   0.00000, 0.00000, 179.99451,0,3); //
	CreateDynamicObject(2808, 1966.25378, -360.67249, 1092.59192,   0.00000, 0.00000, 179.99451,0,3); //
	CreateDynamicObject(2808, 1959.69580, -360.67249, 1092.59192,   0.00000, 0.00000, 179.99451,0,3); //
	CreateDynamicObject(2808, 1961.86865, -360.67249, 1092.59192,   0.00000, 0.00000, 179.99451,0,3); //
	CreateDynamicObject(2808, 1961.86780, -357.18195, 1092.59192,   0.00000, 0.00000, 179.99451,0,3); //
	CreateDynamicObject(2808, 1972.15234, -356.57913, 1092.59192,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(2808, 1968.43701, -357.18195, 1092.59192,   0.00000, 0.00000, 179.99451,0,3); //
	CreateDynamicObject(2808, 1966.26782, -357.18195, 1092.59192,   0.00000, 0.00000, 179.99451,0,3); //
	CreateDynamicObject(14705, 1962.68140, -373.67499, 1093.91895,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(14410, 1968.61401, -349.16000, 1092.01758,   0.00000, 0.00000, 270.00000,0,3); //
	CreateDynamicObject(11472, 1971.98047, -351.97092, 1092.19568,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(11472, 1971.98047, -353.19617, 1092.19568,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(14410, 1959.47412, -349.41287, 1092.01660,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(11472, 1956.10046, -351.96487, 1092.19568,   0.00000, 0.00000, 270.00000,0,3); //
	CreateDynamicObject(11472, 1956.10046, -353.19617, 1092.19568,   0.00000, 0.00000, 270.00000,0,3); //
	CreateDynamicObject(11472, 1965.10974, -347.94531, 1095.44092,   0.00000, 90.00000, 180.00000,0,3); //
	CreateDynamicObject(11472, 1962.98315, -347.94104, 1095.44019,   0.00000, 270.00000, 179.99451,0,3); //
	CreateDynamicObject(1698, 1962.46606, -352.53400, 1095.31421,   0.00000, 0.00000, 270.27026,0,3); //
	CreateDynamicObject(1698, 1962.87317, -352.53400, 1095.53918,   0.00000, 0.00000, 270.26917,0,3); //
	CreateDynamicObject(1698, 1963.24683, -352.53400, 1095.76416,   0.00000, 0.00000, 270.26917,0,3); //
	CreateDynamicObject(1698, 1965.60022, -352.53400, 1095.31421,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(1698, 1965.20435, -352.53400, 1095.53918,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(1698, 1964.72375, -352.53400, 1095.76416,   0.00000, 0.00000, 270.26917,0,3); //
	CreateDynamicObject(970, 1964.05688, -353.88498, 1096.74243,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(970, 1959.94470, -353.88498, 1095.74719,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(970, 1955.77246, -353.88589, 1095.74719,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(970, 1968.17297, -353.88498, 1095.74719,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(970, 1972.25000, -353.88589, 1095.74719,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(970, 1959.97607, -351.29065, 1095.74719,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(970, 1968.10303, -351.29065, 1095.74719,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(970, 1965.96204, -349.21619, 1096.74170,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(970, 1962.13757, -349.21619, 1096.74243,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(2887, 1964.04822, -349.34906, 1094.78955,   90.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(949, 1971.95068, -353.46039, 1095.83191,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(948, 1965.68555, -352.45767, 1091.94543,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(948, 1962.38428, -352.45767, 1091.94543,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(1742, 1955.84399, -353.83832, 1091.94543,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(1742, 1957.28174, -353.83832, 1091.94543,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(1742, 1958.71167, -353.83832, 1091.94543,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(1742, 1960.15112, -353.83832, 1091.94543,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(1742, 1971.77673, -353.83832, 1091.94543,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(1742, 1970.34277, -353.83832, 1091.94543,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(1742, 1968.90930, -353.83832, 1091.94543,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(1742, 1967.47534, -353.83832, 1091.94543,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(949, 1961.60730, -354.34103, 1092.58167,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(949, 1966.46326, -354.34805, 1092.58167,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(1720, 1970.09338, -373.59497, 1092.72888,   0.00000, 0.00000, 180.00000,0,3); //
	CreateDynamicObject(1720, 1970.91199, -373.58316, 1092.72888,   0.00000, 0.00000, 179.99451,0,3); //
	CreateDynamicObject(741, 1969.29675, -369.22723, 1093.71252,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(3440, 1969.29126, -370.86264, 1091.08008,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(14455, 1955.32813, -348.54144, 1096.87585,   0.00000, 0.00000, 270.00000,0,3); //
	CreateDynamicObject(14455, 1972.78357, -352.90488, 1096.86743,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(2842, 1964.51917, -365.60892, 1091.94543,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(2842, 1964.51843, -363.77881, 1091.94543,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(2842, 1964.51868, -361.94879, 1091.94543,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(2842, 1964.52173, -360.12714, 1091.94543,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(2842, 1964.52637, -358.30560, 1091.94543,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(2842, 1964.52600, -356.47940, 1091.94543,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(2842, 1964.52344, -354.64612, 1091.94543,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(2842, 1964.52136, -352.82816, 1091.94543,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(2842, 1964.51868, -350.99310, 1091.94543,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(2842, 1964.52026, -349.16046, 1091.94543,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(2833, 1963.55750, -369.65057, 1092.72888,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(2834, 1968.81580, -372.52481, 1092.72888,   0.00000, 0.00000, 0.00000,0,3); //
	CreateDynamicObject(6959, 1951.26587, -360.22650, 1095.56030,   310.00000, 180.00000, 90.00000,0,3); //
	CreateDynamicObject(6959, 1976.87695, -356.75421, 1095.51965,   310.00000, 180.00000, 270.00000,0,3); //
	CreateDynamicObject(6959, 1958.95715, -378.23306, 1096.33813,   309.99573, 179.99451, 180.00000,0,3); //
	CreateDynamicObject(1724, 1956.01160, -361.13589, 1092.02307,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(19466, 1955.25195, -359.99081, 1093.19727,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(19466, 1955.22437, -361.28000, 1093.19727,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(19466, 1972.42810, -360.00739, 1093.27734,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(19466, 1972.44006, -361.34879, 1093.31726,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(1724, 1972.15027, -360.15268, 1092.02307,   0.00000, 0.00000, 270.00000,0,3); //
	CreateDynamicObject(2808, 1956.07983, -364.84030, 1092.59192,   0.00000, 0.00000, 270.00000,0,3); //
	CreateDynamicObject(2808, 1955.90137, -356.42340, 1092.59192,   0.00000, 0.00000, 270.00000,0,3); //
	CreateDynamicObject(2808, 1959.70776, -357.18188, 1092.59192,   0.00000, 0.00000, 179.99451,0,3); //
	CreateDynamicObject(2808, 1972.07397, -367.00302, 1092.59192,   0.00000, 0.00000, 90.00000,0,3); //
	CreateDynamicObject(2808, 1972.06702, -364.84296, 1092.59192,   0.00000, 0.00000, 90.00000,0,3); //
	SetDynamicObjectMaterial(CreateDynamicObject(19435, 1955.41833, -360.62109, 1092.01904,   0.00000, 90.00000, 90.00000), 0, 2357, "cj_tables", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19435, 1955.45654, -360.62094, 1092.01099,   0.00000, 90.00000, 0.00000), 0, 2357, "cj_tables", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19435, 1955.42969, -359.97922, 1092.13696,   90.00000, 0.00000, 90.00000), 0, 2357, "cj_tables", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19435, 1955.45081, -361.27014, 1092.13696,   90.00000, 0.00000, 90.00000), 0, 2357, "cj_tables", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19435, 1955.39136, -360.63129, 1092.60498,   0.00000, 0.00000, 0.00000), 0, 2357, "cj_tables", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(18762, 1954.91235, -361.85339, 1091.87671,   0.00000, 0.00000, 0.00000), 0, 2357, "cj_tables", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(18762, 1954.91235, -359.32910, 1091.87671,   0.00000, 0.00000, 0.00000), 0, 2357, "cj_tables", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(18762, 1956.70935, -361.69144, 1091.87671,   0.00000, 0.00000, 0.00000), 0, 2357, "cj_tables", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(18762, 1956.71118, -359.55542, 1091.87671,   0.00000, 0.00000, 0.00000), 0, 2357, "cj_tables", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19435, 1955.45654, -360.62091, 1094.23730,   0.00000, 90.00000, 0.00000), 0, 2357, "cj_tables", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(kos = CreateDynamicObject(3089, 1957.14050, -361.36722, 1092.92456,   0.00000, 0.00000, 90.00000), 2, 2357, "cj_tables", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19435, 1972.32458, -360.64594, 1092.01099,   0.00000, 90.00000, 0.00000), 0, 2357, "cj_tables", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19435, 1972.33093, -361.28940, 1092.13696,   90.00000, 0.00000, 90.00000), 0, 2357, "cj_tables", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19435, 1972.33679, -360.01547, 1092.13696,   90.00000, 0.00000, 90.00000), 0, 2357, "cj_tables", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19435, 1972.19031, -360.61237, 1092.01904,   0.00000, 90.00000, 90.00000), 0, 2357, "cj_tables", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(18762, 1973.08447, -359.39017, 1091.87671,   0.00000, 0.00000, 0.00000), 0, 2357, "cj_tables", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19435, 1972.70142, -360.68124, 1092.60498,   0.00000, 0.00000, 0.00000), 0, 2357, "cj_tables", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(18762, 1973.08447, -361.99020, 1091.87671,   0.00000, 0.00000, 0.00000), 0, 2357, "cj_tables", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(18762, 1971.05664, -361.77615, 1091.87671,   0.00000, 0.00000, 0.00000), 0, 2357, "cj_tables", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(18762, 1971.04919, -359.50687, 1091.87671,   0.00000, 0.00000, 0.00000), 0, 2357, "cj_tables", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(CreateDynamicObject(19435, 1972.30188, -360.62570, 1094.27734,   0.00000, 90.00000, 0.00000), 0, 2357, "cj_tables", "CJ_WOOD5", 0);
	SetDynamicObjectMaterial(kos2 = CreateDynamicObject(3089, 1970.59631, -361.29642, 1092.92456,   0.00000, 0.00000, 90.00000), 2, 2357, "cj_tables", "CJ_WOOD5", 0);

//obiekty cywilne verona mall (okna)
	CreateDynamicObject(19323, 1117.58594, -1490.00781, 32.71880,   0.00000, 0.00000, 0.00000,0,0); //
	CreateDynamicObject(19325, 1155.38513, -1445.44116, 16.75750,   0.00000, 0.00000, 0.00000,0,0); //
	CreateDynamicObject(19325, 1155.40259, -1435.13196, 16.45850,   0.00000, 0.00000, 0.00000,0,0); //
	CreateDynamicObject(19325, 1155.36401, -1452.55566, 16.12291,   0.00000, 0.00000, -0.60000,0,0); //
	CreateDynamicObject(19325, 1157.25537, -1467.95654, 16.32620,   0.00000, 0.00000, 19.02000,0,0); //
	CreateDynamicObject(19325, 1160.74438, -1478.41711, 16.01850,   0.00000, 0.00000, 18.54000,0,0); //
	CreateDynamicObject(19325, 1159.79614, -1502.22546, 16.00987,   0.00000, 0.00000, -20.16000,0,0); //
	CreateDynamicObject(19325, 1139.23145, -1523.71106, 16.17210,   0.00000, 0.00000, -68.87999,0,0); //
	CreateDynamicObject(19325, 1116.96082, -1523.42920, 16.11658,   0.00000, 0.00000, -110.46003,0,0); //
	CreateDynamicObject(19325, 1097.11841, -1502.29968, 16.30608,   0.00000, 0.00000, 21.06001,0,0); //
	CreateDynamicObject(19325, 1096.47937, -1478.23889, 16.41375,   0.00000, 0.00000, -17.94000,0,0); //
	CreateDynamicObject(19325, 1099.58154, -1468.44226, 16.06855,   0.00000, 0.00000, -18.18001,0,0); //
	CreateDynamicObject(19325, 1101.77881, -1452.57019, 16.56231,   0.00000, 0.00000, -1.32000,0,0); //
	CreateDynamicObject(19325, 1101.77051, -1445.21570, 16.17698,   0.00000, 0.00000, 0.00000,0,0); //

// obiekty cywilne (bar) int 19

	CreateDynamicObject(6189, 2292, 49.099609375, 8000.7001953125, 0, 0, 0,0,19);
	CreateDynamicObject(5040, 2278.8994140625, 56.69921875, 8018.6000976563, 0, 0, 0,0,19);
	CreateDynamicObject(5040, 2314.1000976563, 66.699996948242, 8018.6000976563, 0, 0, 90,0,19);
	CreateDynamicObject(5040, 2289.6999511719, 55.700000762939, 8018.6000976563, 0, 0, 0,0,19);
	CreateDynamicObject(5040, 2322.8994140625, 87.099609375, 8018.6000976563, 0, 0, 90,0,19);
	CreateDynamicObject(5040, 2261.099609375, 87.099609375, 8018.6000976563, 0, 0, 270,0,19);
	CreateDynamicObject(5040, 2294.5, 118.8994140625, 8018.6000976563, 0, 0, 180,0,19);
	CreateDynamicObject(5040, 2269.19921875, 94.910003662109, 8018.6000976563, 0, 0, 270,0,19);
	CreateDynamicObject(2964, 2284.8000488281, 80, 8016.7001953125, 0, 0, 90,0,19);
	CreateDynamicObject(14874, 2290.3999023438, 82.800003051758, 8014.91015625, 0, 0, 0,0,19);
	CreateDynamicObject(5040, 2278.5, 60.700000762939, 8016.5698242188, 0, 0, 0,0,19);
	CreateDynamicObject(2432, 2287.1999511719, 81.900001525879, 8017.1000976563, 90, 180, 180,0,19);
	CreateDynamicObject(2432, 2287.1999511719, 78.599998474121, 8017.1000976563, 90, 180, 180,0,19);
	CreateDynamicObject(2432, 2287.19921875, 79.69921875, 8017.1000976563, 90, 179.99450683594, 179.99450683594,0,19);
	CreateDynamicObject(2432, 2285.599609375, 83, 8017.1000976563, 90, 179.99450683594, 179.99450683594,0,19);
	CreateDynamicObject(2432, 2287.1999511719, 80.800003051758, 8017.1000976563, 90, 180.00549316406, 179.98352050781,0,19);
	CreateDynamicObject(2432, 2284.2998046875, 81.8994140625, 8017.1000976563, 90, 179.99450683594, 179.99450683594,0,19);
	CreateDynamicObject(2432, 2285.6000976563, 84.099998474121, 8017.1000976563, 90, 179.99450683594, 179.99450683594,0,19);
	CreateDynamicObject(2432, 2284.3000488281, 79.699996948242, 8017.1000976563, 90, 179.99450683594, 179.99450683594,0,19);
	CreateDynamicObject(2432, 2284.3000488281, 78.599998474121, 8017.1000976563, 90, 180.00549316406, 179.98352050781,0,19);
	CreateDynamicObject(2432, 2284.2998046875, 80.7998046875, 8017.1000976563, 90, 179.99450683594, 179.99450683594,0,19);
	CreateDynamicObject(2432, 2282.6999511719, 83, 8017.1000976563, 90, 180.00549316406, 179.98352050781,0,19);
	CreateDynamicObject(2432, 2282.6999511719, 84.099998474121, 8017.1000976563, 90, 180.00549316406, 179.98352050781,0,19);
	CreateDynamicObject(2432, 2281.3999023438, 81.900001525879, 8017.1000976563, 90, 179.99450683594, 179.99450683594,0,19);
	CreateDynamicObject(2432, 2281.3999023438, 79.699996948242, 8017.1000976563, 90, 180.00549316406, 179.98352050781,0,19);
	CreateDynamicObject(2432, 2281.6000976563, 80.800003051758, 8017.1000976563, 90, 180.00549316406, 179.98352050781,0,19);
	CreateDynamicObject(2432, 2281.3999023438, 78.599998474121, 8017.1000976563, 90, 180.00549316406, 179.98352050781,0,19);
	CreateDynamicObject(3004, 2284.8000488281, 79.5, 8017.6000976563, 0, 0, 350.49133300781,0,19);
	CreateDynamicObject(3004, 2286.3999023438, 78, 8016.7001953125, 90, 0, 0,0,19);
	CreateDynamicObject(2965, 2284.6999511719, 79.400001525879, 8017.6000976563, 0, 0, 0,0,19);
	CreateDynamicObject(3003, 2284.5, 80.400001525879, 8017.6298828125, 0, 0, 0,0,19);
	CreateDynamicObject(3000, 2284.6000976563, 80, 8017.6298828125, 0, 0, 0,0,19);
	CreateDynamicObject(2999, 2284.6000976563, 80.199996948242, 8017.6298828125, 0, 0, 0,0,19);
	CreateDynamicObject(2998, 2284.6999511719, 79.800003051758, 8017.6298828125, 0, 0, 0,0,19);
	CreateDynamicObject(14874, 2288.8000488281, 75.199996948242, 8014.8999023438, 0, 0, 180,0,19);
	CreateDynamicObject(14399, 2298.8000488281, 89.300003051758, 8015, 0, 0, 90,0,19);
	CreateDynamicObject(18060, 2291.599609375, 92.8994140625, 8017, 0, 0, 270,0,19);
	CreateDynamicObject(5040, 2269.19921875, 94.910003662109, 8022.1000976563, 0, 0, 270,0,19);
	CreateDynamicObject(5040, 2261.1000976563, 75.400001525879, 8022.0971679688, 0, 0, 270,0,19);
	CreateDynamicObject(5040, 2278.8994140625, 56.69921875, 8022.0961914063, 0, 0, 0,0,19);
	CreateDynamicObject(2048, 2287, 83.699996948242, 8020.2998046875, 0, 0, 0,0,19);
	CreateDynamicObject(2048, 2297.3999023438, 97.699996948242, 8016.7998046875, 0, 0, 0,0,19);
	CreateDynamicObject(1486, 2296.8999023438, 81.300003051758, 8016.5, 0, 0, 0,0,19);
	CreateDynamicObject(1486, 2296.8000488281, 84.599998474121, 8016.5, 0, 0, 0,0,19);
	CreateDynamicObject(1486, 2296.8999023438, 87.400001525879, 8016.5, 0, 0, 0,0,19);
	CreateDynamicObject(1541, 2301.6799316406, 82.680000305176, 8016.7998046875, 0, 0, 90,0,19);
	CreateDynamicObject(1677, 2305, 84.3994140625, 8022.3999023438, 0, 179.99450683594, 179.99450683594,0,19);
	CreateDynamicObject(5040, 2310.8701171875, 78.099609375, 8022.0297851563, 0, 0, 90,0,19);
	CreateDynamicObject(1677, 2293.2998046875, 86.7998046875, 8024.6000976563, 0, 179.99450683594, 179.99450683594,0,19);
	CreateDynamicObject(4227, 2288.6000976563, 83.800003051758, 8018.7998046875, 0, 0, 0,0,19);
	CreateDynamicObject(14840, 2282.3000488281, 82.800003051758, 8019.1000976563, 0, 0, 0,0,19);
	CreateDynamicObject(5663, 2244.1000976563, 117.30000305176, 8019.2998046875, 0, 0, 0,0,19);
	CreateDynamicObject(5788, 2296.6000976563, 106.30000305176, 8014.2001953125, 0, 0, 90,0,19);
	CreateDynamicObject(2047, 2290.6000976563, 95.900001525879, 8017.7001953125, 0, 0, 90,0,19);
	CreateDynamicObject(2047, 2290.3999023438, 89.800003051758, 8017.7998046875, 0, 0, 90,0,19);
	CreateDynamicObject(16780, 2299.5, 82.699996948242, 8019, 0, 0, 0,0,19);
	CreateDynamicObject(14840, 2296.8000488281, 77.900001525879, 8017.3999023438, 0, 0, 90.247192382813,0,19);
	CreateDynamicObject(18061, 2290.5, 92.7998046875, 8016.1000976563, 0, 0, 270,0,19);
	CreateDynamicObject(18059, 2291.69921875, 92.8994140625, 8015.6000976563, 0, 0, 87.994995117188,0,19);
	CreateDynamicObject(16780, 2285.3999023438, 80.599998474121, 8021.1000976563, 0, 0, 0,0,19);
	CreateDynamicObject(1486, 2299.6999511719, 78.199996948242, 8016.5, 0, 0, 0,0,19);
	CreateDynamicObject(1520, 2300.3999023438, 78.199996948242, 8016.3999023438, 0, 0, 0,0,19);
	CreateDynamicObject(1520, 2301.6999511719, 78.900001525879, 8016.3999023438, 0, 0, 0,0,19);
	CreateDynamicObject(1520, 2301.5, 79, 8017.5600585938, 0, 0, 0,0,19);
	CreateDynamicObject(1520, 2301, 78.199996948242, 8017.5, 0, 0, 0,0,19);
	CreateDynamicObject(1520, 2300.6000976563, 78.190002441406, 8016.9702148438, 0, 0, 0,0,19);
	CreateDynamicObject(1520, 2301.5, 80.800003051758, 8016.9301757813, 0, 0, 0,0,19);
	CreateDynamicObject(1544, 2301.6000976563, 79.400001525879, 8016.2998046875, 0, 0, 0,0,19);
	CreateDynamicObject(1544, 2301.6000976563, 80.5, 8016.2998046875, 0, 0, 0,0,19);
	CreateDynamicObject(1544, 2301.6000976563, 79.599998474121, 8016.8999023438, 0, 0, 0,0,19);
	CreateDynamicObject(1544, 2301.6000976563, 78.300003051758, 8017.5, 0, 0, 0,0,19);
	CreateDynamicObject(1544, 2301.6000976563, 80.199996948242, 8017.5, 0, 0, 0,0,19);
	CreateDynamicObject(1546, 2297, 79.599998474121, 8016.5, 0, 0, 0,0,19);
	CreateDynamicObject(1546, 2301.5, 80.199996948242, 8016.3999023438, 0, 0, 0,0,19);
	CreateDynamicObject(1546, 2301.5, 79.699996948242, 8016.3999023438, 0, 0, 0,0,19);
	CreateDynamicObject(1546, 2301.5, 79.900001525879, 8016.3999023438, 0, 0, 0,0,19);
	CreateDynamicObject(4007, 2275.599609375, 77.3994140625, 7988.5, 90, 90, 179.99450683594,0,19);
	CreateDynamicObject(2700, 2301.3999023438, 89.900001525879, 8017.7998046875, 0, 0, 180,0,19);
	CreateDynamicObject(1501, 2292.1999511719, 76.900001525879, 8015.6000976563, 0, 0, 179.99450683594,0,19);
	CreateDynamicObject(2432, 2290.5, 77.5, 8016.0498046875, 90, 179.99450683594, 179.99450683594,0,19);
	CreateDynamicObject(14409, 2291.6000976563, 79.300003051758, 8012.3999023438, 0, 0, 0,0,19);
	CreateDynamicObject(2350, 2295.5, 79, 8015.6000976563, 0, 0, 0,0,19);
	CreateDynamicObject(2350, 2295.5, 81, 8015.6000976563, 0, 0, 0,0,19);
	CreateDynamicObject(2350, 2295.5, 83, 8015.6000976563, 0, 0, 0,0,19);
	CreateDynamicObject(2350, 2295.5, 85, 8015.6000976563, 0, 0, 0,0,19);
	CreateDynamicObject(2350, 2295.5, 87, 8015.6000976563, 0, 0, 0,0,19);
	CreateDynamicObject(18060, 2303.1000976563, 96.400001525879, 8017, 0, 0, 180,0,19);
	CreateDynamicObject(18059, 2303.1000976563, 96.400001525879, 8015.6000976563, 0, 0, 0,0,19);
	//biuro TFAT obiekty frakcyjne
	CreateDynamicObject(19378, 2308.89, -1319.03, 178.58,   0.00, 90.00, 0.00,0,4);
	CreateDynamicObject(19450, 2303.81, -1319.25, 180.17,   0.00, 0.00, 0.10,0,4);
	CreateDynamicObject(19450, 2308.40, -1320.85, 180.17,   0.00, 0.00, 90.00,0,4);
	CreateDynamicObject(19450, 2313.27, -1319.45, 180.17,   0.00, 0.00, 0.10,0,4);
	CreateDynamicObject(19450, 2308.57, -1314.96, 180.17,   0.00, 0.00, 90.00,0,4);
	CreateDynamicObject(2009, 2304.34, -1318.29, 178.60,   0.00, 0.00, -90.00,0,4);
	CreateDynamicObject(1714, 2304.14, -1319.16, 178.65,   0.00, 0.00, 90.00,0,4);
	CreateDynamicObject(2174, 2307.71, -1315.59, 178.69,   0.00, 0.00, 0.00,0,4);
	CreateDynamicObject(2193, 2304.37, -1316.55, 178.60,   0.00, 0.00, 0.00,0,4);
	CreateDynamicObject(1714, 2305.21, -1316.67, 178.65,   0.00, 0.00, 181.36,0,4);
	CreateDynamicObject(1210, 2305.43, -1319.90, 178.80,   0.00, 0.00, 0.00,0,4);
	CreateDynamicObject(630, 2312.53, -1316.28, 179.65,   0.00, 0.00, 0.00,0,4);
	CreateDynamicObject(630, 2312.57, -1319.11, 179.64,   0.00, 0.00, 0.00,0,4);
	CreateDynamicObject(631, 2306.59, -1315.81, 179.65,   0.00, 0.00, 0.00,0,4);
	CreateDynamicObject(2571, 2311.96, -1319.28, 178.71,   0.00, 0.00, 179.99,0,4);
	CreateDynamicObject(1498, 2313.16, -1317.02, 178.59,   0.00, 0.00, -90.00,0,4);
	CreateDynamicObject(18875, 2305.09, -1318.72, 179.41,   0.00, 0.00, 272.43,0,4);
	CreateDynamicObject(18870, 2305.04, -1318.92, 179.39,   0.00, 0.00, -90.00,0,4);
	CreateDynamicObject(1828, 2308.82, -1318.23, 178.74,   0.00, 0.00, 0.00,0,4);
	CreateDynamicObject(19172, 2303.89, -1319.02, 180.68,   0.00, 0.00, 90.00,0,4);
	CreateDynamicObject(19378, 2308.89, -1319.03, 182.01,   0.00, 90.00, 0.00,0,4);
	CreateDynamicObject(18608, 2304.53, -1318.15, 183.06,   0.00, 0.00, 90.00,0,4);
	CreateDynamicObject(1714, 2306.79, -1318.62, 178.65,   0.00, 0.00, 267.62,0,4);
	
	//obiekty cywilne (monopolowy na las collins)
	CreateDynamicObject(12844,2748.48022461,-1099.07812500,70.55383301,0.00000000,0.00000000,271.00000000,0,0); //object(cos_liqinside) (1)
	CreateDynamicObject(12843,2748.48217773,-1102.04003906,68.59999847,0.00000000,0.00000000,271.00000000,0,0); //object(cos_liquorshop) (1)
	CreateDynamicObject(12845,2748.80761719,-1099.15136719,70.71711731,0.00000000,0.00000000,270.99975586,0,0); //object(cos_liqinsidebits) (1)
	CreateDynamicObject(1280,2748.89526367,-1091.66589355,68.97947693,0.00000000,0.00000000,270.00000000,0,0); //object(parkbench1) (1)
	CreateDynamicObject(1280,2751.01855469,-1089.13378906,68.97947693,0.00000000,0.00000000,0.00000000,0,0); //object(parkbench1) (2)
	CreateDynamicObject(2670,2750.38208008,-1089.66979980,68.67017365,0.00000000,0.00000000,0.00000000,0,0); //object(proc_rubbish_1) (1)
	CreateDynamicObject(1572,2752.83911133,-1091.33581543,69.14875793,0.00000000,0.00000000,0.00000000,0,0); //object(cj_air_trolly) (1)
	CreateDynamicObject(1338,2749.65625000,-1093.65295410,69.29591370,0.00000000,0.00000000,0.00000000,0,0); //object(binnt08_la) (1)
	CreateDynamicObject(1280,2743.02807617,-1094.53930664,68.97947693,0.00000000,0.00000000,0.00000000,0,0); //object(parkbench1) (3)
	CreateDynamicObject(1349,2745.72363281,-1104.90600586,69.14850616,0.00000000,0.00000000,0.00000000,0,0); //object(cj_shtrolly) (1)
	CreateDynamicObject(2674,2741.74926758,-1094.22497559,68.43579865,0.00000000,0.00000000,0.00000000,0,0); //object(proc_rubbish_2) (1)
	CreateDynamicObject(1359,2743.43725586,-1091.58447266,69.27667999,0.00000000,0.00000000,0.00000000,0,0); //object(cj_bin1) (1)
	CreateDynamicObject(1415,2747.03369141,-1107.62158203,68.57812500,0.00000000,0.00000000,0.00000000,0,0); //object(dyn_dumpster) (1)
	CreateDynamicObject(1440,2749.39575195,-1107.89355469,69.09724426,0.00000000,0.00000000,0.00000000,0,0); //object(dyn_box_pile_3) (1)
	CreateDynamicObject(1370,2749.38525391,-1094.59289551,69.12820435,0.00000000,0.00000000,0.00000000,0,0); //object(cj_flame_drum) (1)
	CreateDynamicObject(1449,2747.56005859,-1108.30700684,69.09977722,0.00000000,0.00000000,0.00000000,0,0); //object(dyn_crate_2) (1)
	CreateDynamicObject(1543,2747.52734375,-1091.82739258,68.57812500,0.00000000,0.00000000,0.00000000,0,0); //object(cj_beer_b_2) (1)
	CreateDynamicObject(1543,2747.55493164,-1091.69116211,68.57812500,0.00000000,0.00000000,0.00000000,0,0); //object(cj_beer_b_2) (2)
	CreateDynamicObject(1520,2747.36474609,-1091.73132324,68.57812500,0.00000000,0.00000000,0.00000000,0,0); //object(dyn_wine_bounce) (1)
	CreateDynamicObject(1520,2750.71899414,-1087.79687500,68.57812500,0.00000000,0.00000000,0.00000000,0,0); //object(dyn_wine_bounce) (2)
	CreateDynamicObject(1517,2750.85205078,-1087.72497559,68.77787781,0.00000000,0.00000000,0.00000000,0,0); //object(dyn_wine_break) (1)
	CreateDynamicObject(1543,2743.15258789,-1095.89453125,68.57812500,0.00000000,0.00000000,0.00000000,0,0); //object(cj_beer_b_2) (3)
	CreateDynamicObject(1543,2743.20019531,-1096.07983398,68.57812500,0.00000000,0.00000000,0.00000000,0,0); //object(cj_beer_b_2) (4)
	CreateDynamicObject(1544,2743.03784180,-1096.05187988,68.57812500,0.00000000,0.00000000,0.00000000,0,0); //object(cj_beer_b_1) (1)
	CreateDynamicObject(2670,2748.88037109,-1091.24267578,68.67017365,0.00000000,0.00000000,0.00000000,0,0); //object(proc_rubbish_1) (2)
	CreateDynamicObject(2062,2755.00903320,-1105.74218750,69.14675903,0.00000000,0.00000000,0.00000000,0,0); //object(cj_oildrum2) (1)
	CreateDynamicObject(3119,2751.01806641,-1091.99426270,68.88198090,0.00000000,0.00000000,0.00000000,0,0); //object(cs_ry_props) (1)
	CreateDynamicObject(1432,2744.97778320,-1110.84985352,68.57812500,0.00000000,0.00000000,0.00000000,0,0); //object(dyn_table_2) (1)
	CreateDynamicObject(1670,2744.91870117,-1110.86535645,69.19346619,0.00000000,0.00000000,0.00000000,0,0); //object(propcollecttable) (1)
	CreateDynamicObject(1728,2753.91967773,-1101.68554688,68.57812500,0.00000000,0.00000000,90.00000000,0,0); //object(mrk_seating3) (1)
	CreateDynamicObject(2674,2754.21630859,-1099.21899414,68.59986115,0.00000000,0.00000000,0.00000000,0,0); //object(proc_rubbish_2) (2)
	CreateDynamicObject(1543,2753.68945312,-1099.26770020,68.57812500,0.00000000,0.00000000,0.00000000,0,0); //object(cj_beer_b_2) (5)
	CreateDynamicObject(1543,2753.55493164,-1099.34899902,68.57812500,0.00000000,0.00000000,0.00000000,0,0); //object(cj_beer_b_2) (6)
	CreateDynamicObject(928,2755.11230469,-1106.60510254,68.83676147,0.00000000,0.00000000,0.00000000,0,0); //object(rubbish_box1) (1)
	CreateDynamicObject(924,2754.47094727,-1106.35900879,68.75885773,0.00000000,0.00000000,0.00000000,0,0); //object(fruitcrate3) (1)
	CreateDynamicObject(2980,2743.31518555,-1106.10388184,69.36699677,0.00000000,0.00000000,270.00000000,0,0); //object(kb_bandit10) (1)
	CreateDynamicObject(2967,2749.56689453,-1099.37902832,69.53166962,0.00000000,0.00000000,0.00000000,0,0); //object(mobile1993a) (1)
	CreateDynamicObject(2966,2749.70263672,-1099.48742676,69.56139374,0.00000000,0.00000000,0.00000000,0,0); //object(mobile1993b) (1)
	CreateDynamicObject(2962,2739.52001953,-1089.03210449,68.41406250,0.00000000,0.00000000,0.00000000,0,0); //object(fire_break_glass) (1)
	CreateDynamicObject(2941,2750.57397461,-1102.72192383,69.87845612,0.00000000,0.00000000,0.00000000,0,0); //object(temp_till) (1)
	CreateDynamicObject(1616,2743.55786133,-1106.46875000,72.31855011,0.00000000,0.00000000,0.00000000,0,0); //object(nt_securecam1_01) (1)
	CreateDynamicObject(1212,2750.15551758,-1102.40759277,69.53166962,0.00000000,0.00000000,0.00000000,0,0); //object(money) (1)
	CreateDynamicObject(1212,2750.14794922,-1102.53991699,69.53166962,0.00000000,0.00000000,0.00000000,0,0); //object(money) (2)
	CreateDynamicObject(1212,2750.05908203,-1102.49719238,69.53166962,0.00000000,0.00000000,0.00000000,0,0); //object(money) (3)
	CreateDynamicObject(1550,2750.04418945,-1098.72778320,68.97794342,0.00000000,0.00000000,0.00000000,0,0); //object(cj_money_bag) (1)
	CreateDynamicObject(2057,2749.82763672,-1096.06567383,68.88486481,0.00000000,0.00000000,0.00000000,0,0); //object(flame_tins) (1)
	CreateDynamicObject(1232,2743.81835938,-1108.89575195,71.21476746,0.00000000,0.00000000,0.00000000,0,0); //object(streetlamp1) (1)
	CreateDynamicObject(1232,2743.20483398,-1090.13061523,71.21476746,0.00000000,0.00000000,0.00000000,0,0); //object(streetlamp1) (2)


	//zajezdnia autobusowa commerce (+ wystrÛj) obiekty cywilne
	CreateDynamicObject(1229,1146.40002441,-1734.80004883,14.30000019,0.00000000,0.00000000,90.00000000,0,0); //object(bussign1) (1)
	CreateDynamicObject(1257,1135.69995117,-1732.69995117,14.10000038,0.00000000,0.00000000,90.00000000,0,0); //object(bustopm) (1)
	CreateDynamicObject(1257,1142.30004883,-1732.80004883,14.10000038,0.00000000,0.00000000,90.00000000,0,0); //object(bustopm) (2)
	CreateDynamicObject(982,1085.80004883,-1722.19995117,13.30000019,0.00000000,0.00000000,90.00000000,0,0); //object(fenceshit) (1)
	CreateDynamicObject(982,1111.40002441,-1722.09997559,13.30000019,0.00000000,0.00000000,90.00000000,0,0); //object(fenceshit) (2)
	CreateDynamicObject(982,1060.19995117,-1722.19995117,13.30000019,0.00000000,0.00000000,90.00000000,0,0); //object(fenceshit) (3)
	CreateDynamicObject(982,1047.40002441,-1735.09997559,13.30000019,0.00000000,0.00000000,180.00000000,0,0); //object(fenceshit) (4)
	CreateDynamicObject(982,1047.40002441,-1760.69995117,13.30000019,0.00000000,0.00000000,179.99450684,0,0); //object(fenceshit) (5)
	CreateDynamicObject(983,1047.50000000,-1776.59997559,13.19999981,0.00000000,0.00000000,0.00000000,0,0); //object(fenceshit3) (1)
	CreateDynamicObject(982,1087.80004883,-1782.09997559,13.39999962,0.00000000,0.00000000,90.00000000,0,0); //object(fenceshit) (7)
	CreateDynamicObject(982,1066.30004883,-1782.09997559,13.30000019,0.00000000,0.00000000,90.00000000,0,0); //object(fenceshit) (8)
	CreateDynamicObject(983,1100.69995117,-1785.19995117,13.30000019,0.00000000,0.00000000,0.00000000,0,0); //object(fenceshit3) (2)
	CreateDynamicObject(792,1046.19995117,-1788.30004883,12.80000019,0.00000000,0.00000000,0.00000000,0,0); //object(aw_streettree1) (1)
	CreateDynamicObject(792,1044.69995117,-1795.80004883,12.89999962,0.00000000,0.00000000,0.00000000,0,0); //object(aw_streettree1) (2)
	CreateDynamicObject(792,1050.69995117,-1803.19995117,12.89999962,0.00000000,0.00000000,0.00000000,0,0); //object(aw_streettree1) (3)
	CreateDynamicObject(792,1056.69995117,-1810.80004883,12.89999962,0.00000000,0.00000000,0.00000000,0,0); //object(aw_streettree1) (4)
	CreateDynamicObject(792,1062.59997559,-1818.50000000,12.89999962,0.00000000,0.00000000,0.00000000,0,0); //object(aw_streettree1) (5)
	CreateDynamicObject(792,1065.69995117,-1827.40002441,12.80000019,0.00000000,0.00000000,0.00000000,0,0); //object(aw_streettree1) (6)
	CreateDynamicObject(792,1068.80004883,-1834.69995117,12.69999981,0.00000000,0.00000000,0.00000000,0,0); //object(aw_streettree1) (7)
	CreateDynamicObject(792,1071.80004883,-1840.90002441,12.69999981,0.00000000,0.00000000,0.00000000,0,0); //object(aw_streettree1) (8)
	CreateDynamicObject(792,1079.19995117,-1840.80004883,12.69999981,0.00000000,0.00000000,0.00000000,0,0); //object(aw_streettree1) (12)
	CreateDynamicObject(792,1086.69995117,-1841.09997559,12.69999981,0.00000000,0.00000000,0.00000000,0,0); //object(aw_streettree1) (13)
	CreateDynamicObject(792,1094.19995117,-1840.80004883,12.69999981,0.00000000,0.00000000,0.00000000,0,0); //object(aw_streettree1) (14)
	CreateDynamicObject(792,1101.69995117,-1840.80004883,12.69999981,0.00000000,0.00000000,0.00000000,0,0); //object(aw_streettree1) (15)
	CreateDynamicObject(792,1110.69995117,-1840.90002441,12.69999981,0.00000000,0.00000000,0.00000000,0,0); //object(aw_streettree1) (16)
	CreateDynamicObject(970,1069.30004883,-1838.09997559,13.19999981,0.00000000,0.00000000,294.00000000,0,0); //object(fencesmallb) (1)
	CreateDynamicObject(970,1066.40002441,-1831.19995117,13.19999981,0.00000000,0.00000000,293.99963379,0,0); //object(fencesmallb) (2)
	CreateDynamicObject(970,1062.80004883,-1822.69995117,13.19999981,0.00000000,0.00000000,293.99963379,0,0); //object(fencesmallb) (3)
	CreateDynamicObject(970,1058.59997559,-1815.19995117,13.19999981,0.00000000,0.00000000,305.99963379,0,0); //object(fencesmallb) (4)
	CreateDynamicObject(970,1053.30004883,-1807.50000000,13.30000019,0.00000000,0.00000000,305.99670410,0,0); //object(fencesmallb) (5)
	CreateDynamicObject(970,1046.90002441,-1800.00000000,13.30000019,0.00000000,0.00000000,311.99670410,0,0); //object(fencesmallb) (6)
	CreateDynamicObject(970,1044.40002441,-1791.69995117,13.30000019,0.00000000,0.00000000,255.99523926,0,0); //object(fencesmallb) (7)
	CreateDynamicObject(970,1046.09997559,-1784.00000000,13.30000019,0.00000000,0.00000000,259.99145508,0,0); //object(fencesmallb) (9)
	CreateDynamicObject(970,1082.90002441,-1842.50000000,13.19999981,0.00000000,0.00000000,359.99963379,0,0); //object(fencesmallb) (10)
	CreateDynamicObject(970,1090.30004883,-1842.50000000,13.19999981,0.00000000,0.00000000,359.99450684,0,0); //object(fencesmallb) (11)
	CreateDynamicObject(970,1098.00000000,-1842.50000000,13.19999981,0.00000000,0.00000000,359.99450684,0,0); //object(fencesmallb) (12)
	CreateDynamicObject(970,1105.50000000,-1842.50000000,13.19999981,0.00000000,0.00000000,359.99450684,0,0); //object(fencesmallb) (13)
	CreateDynamicObject(970,1075.40002441,-1842.50000000,13.19999981,0.00000000,0.00000000,359.99450684,0,0); //object(fencesmallb) (14)
	CreateDynamicObject(792,1047.69995117,-1780.90002441,12.80000019,0.00000000,0.00000000,0.00000000,0,0); //object(aw_streettree1) (17)
	CreateDynamicObject(983,1050.50000000,-1781.00000000,13.19999981,0.00000000,0.00000000,69.00000000,0,0); //object(fenceshit3) (3)
	CreateDynamicObject(642,1064.69995117,-1804.90002441,14.10000038,0.00000000,0.00000000,0.00000000,0,0); //object(kb_canopy_test) (1)
	CreateDynamicObject(642,1063.09997559,-1788.40002441,14.10000038,0.00000000,0.00000000,0.00000000,0,0); //object(kb_canopy_test) (2)
	CreateDynamicObject(642,1053.09997559,-1796.69995117,14.10000038,0.00000000,0.00000000,0.00000000,0,0); //object(kb_canopy_test) (3)
	CreateDynamicObject(982,1137.00000000,-1722.09997559,13.39999962,0.00000000,0.00000000,90.00000000,0,0); //object(fenceshit) (9)
	CreateDynamicObject(984,1156.19995117,-1722.09997559,13.50000000,0.00000000,0.00000000,270.00000000,0,0); //object(fenceshit2) (2)
	CreateDynamicObject(983,1165.00000000,-1725.90002441,13.60000038,0.00000000,0.00000000,0.00000000,0,0); //object(fenceshit3) (4)
	CreateDynamicObject(983,1165.50000000,-1754.00000000,13.60000038,0.00000000,0.00000000,0.00000000,0,0); //object(fenceshit3) (5)
	CreateDynamicObject(983,1165.59997559,-1760.50000000,13.60000038,0.00000000,0.00000000,0.00000000,0,0); //object(fenceshit3) (6)
	CreateDynamicObject(792,1164.19995117,-1752.69995117,12.69999981,0.00000000,0.00000000,0.00000000,0,0); //object(aw_streettree1) (18)
	CreateDynamicObject(792,1164.19995117,-1761.69995117,12.69999981,0.00000000,0.00000000,0.00000000,0,0); //object(aw_streettree1) (19)
	CreateDynamicObject(792,1164.19995117,-1770.69995117,12.69999981,0.00000000,0.00000000,0.00000000,0,0); //object(aw_streettree1) (20)
	CreateDynamicObject(792,1164.19995117,-1779.69995117,12.69999981,0.00000000,0.00000000,0.00000000,0,0); //object(aw_streettree1) (21)
	CreateDynamicObject(792,1143.19995117,-1760.19995117,12.69999981,0.00000000,0.00000000,0.00000000,0,0); //object(aw_streettree1) (22)
	CreateDynamicObject(9915,1069.09997559,-1790.90002441,13.50000000,0.00000000,0.00000000,210.00000000,0,0); //object(sfe_park) (1)
	CreateDynamicObject(4640,1108.09997559,-1748.00000000,14.19999981,0.00000000,0.00000000,2.00000000,0,0); //object(paypark_lan03) (1)
	CreateDynamicObject(3430,1164.50000000,-1731.09997559,14.19999981,0.00000000,0.00000000,110.00000000,0,0); //object(vegasbooth01) (1)
	CreateDynamicObject(3430,1164.80004883,-1749.50000000,14.19999981,0.00000000,0.00000000,180.00000000,0,0); //object(vegasbooth01) (2)
	CreateDynamicObject(2920,1164.90002441,-1748.09997559,13.30000019,25.84698486,353.33020020,184.91851807,0,0); //object(police_barrier) (2)
	CreateDynamicObject(2920,1164.59997559,-1732.50000000,13.39999962,31.97662354,357.63732910,1.24786377,0,0); //object(police_barrier) (3)
	CreateDynamicObject(984,1129.90002441,-1750.80004883,13.19999981,0.00000000,0.00000000,90.00000000,0,0); //object(fenceshit2) (3)
	CreateDynamicObject(984,1115.00000000,-1750.80004883,13.19999981,0.00000000,0.00000000,90.00000000,0,0); //object(fenceshit2) (4)
	CreateDynamicObject(8168,1138.80004883,-1754.19995117,14.39999962,0.00000000,0.00000000,106.00000000,0,0); //object(vgs_guardhouse01) (1)
	CreateDynamicObject(970,1135.09997559,-1760.00000000,13.10000038,0.00000000,0.00000000,268.00000000,0,0); //object(fencesmallb) (15)
	CreateDynamicObject(1280,1142.09997559,-1756.50000000,13.00000000,0.00000000,0.00000000,180.00000000,0,0); //object(parkbench1) (1)
	CreateDynamicObject(1280,1163.00000000,-1756.09997559,13.00000000,0.00000000,0.00000000,359.99816895,0,0); //object(parkbench1) (2)
	CreateDynamicObject(1280,1139.40002441,-1758.80004883,13.00000000,0.00000000,0.00000000,89.99450684,0,0); //object(parkbench1) (3)

	//SALA PRZERSUCHA— int 10

	CreateDynamicObject(18065,2353.54809570,591.89672852,4894.79394531,0.00000000,0.00000000,0.00000000,0,10); //object(ab_sfammumain)(1)
	CreateDynamicObject(1649,2380.29003906,588.78314209,4898.24072266,0.00000000,0.00000000,0.00000000,0,10); //object(wglasssmash)(1)
	CreateDynamicObject(1569,2370.82543945,585.66235352,4892.57861328,0.00000000,0.00000000,0.00000000,0,10); //object(adam_v_door)(1)
	CreateDynamicObject(1369,2373.31787109,596.38482666,4893.18164062,0.00000000,0.00000000,310.15014648,0,10); //object(cj_wheelchair1)(1)
	CreateDynamicObject(2205,2367.99902344,592.96575928,4892.53466797,0.00000000,0.00000000,90.00000000,0,10); //object(med_office8_desk_1)(1)
	CreateDynamicObject(2205,2368.96826172,592.96447754,4892.53466797,0.00000000,0.00000000,90.00000000,0,10); //object(med_office8_desk_1)(2)
	CreateDynamicObject(1714,2370.35205078,593.97802734,4892.55957031,0.00000000,0.00000000,288.22521973,0,10); //object(kb_swivelchair1)(1)
	CreateDynamicObject(1663,2366.65307617,593.73571777,4893.02001953,0.00000000,0.00000000,91.53479004,0,10); //object(swivelchair_b)(2)
	CreateDynamicObject(1616,2374.23583984,593.04443359,4896.63183594,0.00000000,0.00000000,0.00000000,0,10); //object(nt_securecam1_01)(2)
	CreateDynamicObject(2853,2368.93750000,594.14532471,4893.47119141,0.00000000,0.00000000,318.18023682,0,10); //object(gb_bedmags03)(1)
	
	//bariera komi
	CreateDynamicObject(16281,253.22445679,118.50680542,1006.01812744,178.87005615,0.00000000,269.17498779); //object(des_fgateway01) (1)

	//obiekty rodzinny (Anna) - kort tenisowy
	/*CreateDynamicObject(971,660.50000000,-1308.69995117,16.00000000,0.00000000,0.00000000,0.00000000,0,0); //object(subwaygate) (3)
	CreateDynamicObject(971,666.20001221,-1215.30004883,17.29999924,0.00000000,0.00000000,36.00000000,0,0); //object(subwaygate) (4)
	CreateDynamicObject(971,785.00000000,-1157.00000000,26.00000000,0.00000000,0.00000000,89.99450684,0,0); //object(subwaygate) (8)
	CreateDynamicObject(973,770.59997559,-1135.09997559,24.00000000,0.00000000,0.00000000,0.00000000,0,0); //object(sub_roadbarrier) (1)
	CreateDynamicObject(973,758.79998779,-1134.90002441,24.00000000,0.00000000,0.00000000,0.00000000,0,0); //object(sub_roadbarrier) (2)
	CreateDynamicObject(973,748.90002441,-1131.19995117,24.39999962,0.00000000,0.00000000,316.00000000,0,0); //object(sub_roadbarrier) (3)
	CreateDynamicObject(967,657.70001221,-1230.69995117,15.00000000,0.00000000,0.00000000,152.00000000,0,0); //object(bar_gatebox01) (1)
	
	CreateDynamicObject(1557,932.79998779,-917.70001221,41.59999847,0.00000000,0.00000000,272.00000000,0,0); //object(gen_doorext19) (1) anna drzwi do exclusive club
	CreateDynamicObject(1557,932.90002441,-920.70001221,41.59999847,0.00000000,0.00000000,91.99951172,0,0); //object(gen_doorext19) (2)*/

	//limuzyna by Yamato Torri
    CreateDynamicObject(8169,2984.12890625,1866.87011719,370.35998535,0.00000000,0.00000000,27.74597168); //object(vgs_guardhseflr) (1)
	CreateDynamicObject(7191,2988.03955078,1864.25878906,370.59515381,0.00000000,0.00000000,11.00000000); //object(vegasnnewfence2b) (3)
	CreateDynamicObject(7191,2978.69726562,1861.08203125,370.59890747,0.00000000,0.00000000,191.99707031); //object(vegasnnewfence2b) (4)
	CreateDynamicObject(7191,2980.81079102,1867.99035645,371.02795410,0.00000000,322.50000000,101.99710083); //object(vegasnnewfence2b) (5)
	CreateDynamicObject(8169,2977.46386719,1865.29199219,370.35998535,0.00000000,0.00000000,27.99865723); //object(vgs_guardhseflr) (2)
	CreateDynamicObject(8169,2971.91552734,1864.17834473,370.35998535,0.00000000,0.00000000,27.99865723); //object(vgs_guardhseflr) (3)
	CreateDynamicObject(7191,2977.30957031,1863.42773438,371.02276611,0.44494629,333.99536133,281.46423340); //object(vegasnnewfence2b) (6)
	CreateDynamicObject(8169,2984.01757812,1866.50195312,372.17349243,0.00000000,180.25000000,354.74853516); //object(vgs_guardhseflr) (4)
	CreateDynamicObject(8169,2978.54541016,1864.68395996,372.17349243,0.00000000,179.74719238,351.99304199); //object(vgs_guardhseflr) (5)
	CreateDynamicObject(8169,2972.34741211,1863.96374512,372.17349243,0.00000000,179.99450684,354.74304199); //object(vgs_guardhseflr) (6)
	CreateDynamicObject(1569,2983.90527344,1869.13012695,370.31533813,37.25003052,0.00000000,12.49996948); //object(adam_v_door) (2)
	CreateDynamicObject(1569,2986.52099609,1865.08056641,370.31600952,23.74874878,359.45166016,191.96574402); //object(adam_v_door) (3)
	CreateDynamicObject(1723,2986.74902344,1868.25561523,370.21807861,0.00000000,0.00000000,282.00000000); //object(mrk_seating1) (1)
	CreateDynamicObject(1723,2981.72094727,1867.52038574,370.26202393,0.00000000,0.00000000,11.74987793); //object(mrk_seating1) (2)
	CreateDynamicObject(1704,2980.33129883,1867.20935059,370.21002197,0.00000000,0.00000000,11.99707031); //object(kb_chair03) (1)
	CreateDynamicObject(1737,2982.37304688,1864.81347656,370.26000977,0.00000000,0.00000000,12.24975586); //object(med_dinning_5) (1)
	CreateDynamicObject(1737,2980.87133789,1864.50000000,370.26000977,0.00000000,0.00000000,11.74975586); //object(med_dinning_5) (2)
	CreateDynamicObject(2007,2986.91796875,1865.28491211,369.67218018,0.00000000,0.00000000,282.25000000); //object(filing_cab_nu01) (1)
	CreateDynamicObject(2007,2986.10278320,1869.05236816,369.67550659,0.00000000,0.00000000,283.74938965); //object(filing_cab_nu01) (2)
	CreateDynamicObject(18095,2974.52099609,1863.36364746,371.95678711,340.00079346,359.46795654,10.56799316); //object(barber_blinds02) (1)
	CreateDynamicObject(18095,2977.47363281,1866.62023926,372.00085449,324.75012207,359.38690186,191.89178467); //object(barber_blinds02) (2)
	CreateDynamicObject(2224,2978.09643555,1865.28344727,372.46502686,0.00000000,176.25000000,181.50000000); //object(cj_sphere_tv) (1)
	//CreateDynamicObject(1337,2986.83642578,1865.67236328,371.32656860,0.00000000,0.00000000,0.00000000); //object(1)
	CreateDynamicObject(1520,2982.98828125,1865.28686523,371.05538940,0.00000000,0.00000000,0.00000000); //object(dyn_wine_bounce) (3)
	CreateDynamicObject(1543,2983.55102539,1865.46691895,371.05538940,0.00000000,0.00000000,0.00000000); //object(cj_beer_b_2) (1)
	CreateDynamicObject(1455,2982.30737305,1865.15698242,371.12707520,0.00000000,0.00000000,0.00000000); //object(dyn_glass) (4)
	CreateDynamicObject(1455,2982.09350586,1865.01306152,371.12707520,0.00000000,0.00000000,0.00000000); //object(dyn_glass) (5)
	CreateDynamicObject(1455,2981.92724609,1864.93286133,371.12707520,0.00000000,0.00000000,0.00000000); //object(dyn_glass) (6)
	CreateDynamicObject(1455,2981.74536133,1864.93249512,371.12707520,0.00000000,0.00000000,0.00000000); //object(dyn_glass) (7)
	CreateDynamicObject(1455,2982.47656250,1865.15258789,371.12707520,0.00000000,0.00000000,0.00000000); //object(dyn_glass) (8)
	CreateDynamicObject(1455,2981.56396484,1864.92053223,371.12707520,0.00000000,0.00000000,0.00000000); //object(dyn_glass) (9)
	CreateDynamicObject(1455,2981.42138672,1864.92736816,371.12707520,0.00000000,0.00000000,0.00000000); //object(dyn_glass) (10)
	CreateDynamicObject(1487,2980.82055664,1864.77502441,371.25283813,0.00000000,0.00000000,0.00000000); //object(dyn_wine_1) (2)
	CreateDynamicObject(1544,2983.27465820,1865.21496582,371.05538940,0.00000000,0.00000000,0.00000000); //object(cj_beer_b_1) (1)
	CreateDynamicObject(1723,2977.86376953,1866.60290527,370.28500366,0.00000000,0.00000000,12.74987793); //object(mrk_seating1) (2)

	//Samolot by Kacper Monari
	CreateDynamicObject(6994,1078.03222656,-1842.84277344,10663.90234375,77.98645020,179.99450684,179.99450684); //object(vgncircus1) (4)
	CreateDynamicObject(6994,1078.05761719,-1823.79785156,10656.98632812,0.00000000,179.99450684,179.99450684); //object(vgncircus1) (5)
	CreateDynamicObject(6994,1078.00683594,-1839.69726562,10674.09960938,279.98657227,179.99450684,179.99450684); //object(vgncircus1) (9)
	CreateDynamicObject(6994,1078.05371094,-1849.25781250,10656.99609375,0.00000000,179.99450684,179.99450684); //object(vgncircus1) (12)
	CreateDynamicObject(2765,1098.11425781,-1841.06054688,10656.26562500,0.00000000,0.00000000,90.00000000); //object(cj_cb_list1) (2)
	CreateDynamicObject(2765,1098.11425781,-1841.06054688,10657.36523438,0.00000000,0.00000000,90.00000000); //object(cj_cb_list1) (3)
	CreateDynamicObject(2765,1098.11425781,-1843.94238281,10656.26562500,0.00000000,0.00000000,90.00000000); //object(cj_cb_list1) (5)
	CreateDynamicObject(2765,1098.11425781,-1846.85937500,10656.26562500,0.00000000,0.00000000,90.00000000); //object(cj_cb_list1) (6)
	CreateDynamicObject(2765,1098.11425781,-1843.94238281,10657.36523438,0.00000000,0.00000000,90.00000000); //object(cj_cb_list1) (7)
	CreateDynamicObject(2765,1098.11425781,-1846.85937500,10657.36523438,0.00000000,0.00000000,90.00000000); //object(cj_cb_list1) (8)
	CreateDynamicObject(2765,1098.11425781,-1841.06054688,10658.46582031,0.00000000,0.00000000,90.00000000); //object(cj_cb_list1) (9)
	CreateDynamicObject(2765,1098.11425781,-1843.94238281,10658.46582031,0.00000000,0.00000000,90.00000000); //object(cj_cb_list1) (10)
	CreateDynamicObject(2765,1098.11425781,-1846.85937500,10658.46582031,0.00000000,0.00000000,90.00000000); //object(cj_cb_list1) (11)
	CreateDynamicObject(2765,1098.11425781,-1841.06054688,10659.56542969,0.00000000,0.00000000,90.00000000); //object(cj_cb_list1) (12)
	CreateDynamicObject(2765,1098.11425781,-1843.94238281,10659.56542969,0.00000000,0.00000000,90.00000000); //object(cj_cb_list1) (13)
	CreateDynamicObject(2765,1098.11425781,-1846.85937500,10659.56542969,0.00000000,0.00000000,90.00000000); //object(cj_cb_list1) (14)
	CreateDynamicObject(2765,1094.22167969,-1840.55078125,10656.26562500,0.00000000,0.00000000,90.00000000); //object(cj_cb_list1) (15)
	CreateDynamicObject(2765,1094.22167969,-1840.55078125,10657.36230469,0.00000000,0.00000000,90.00000000); //object(cj_cb_list1) (16)
	CreateDynamicObject(1649,1094.66503906,-1838.80175781,10660.11328125,0.00000000,0.00000000,270.00000000); //object(wglasssmash) (1)
	CreateDynamicObject(2765,1095.12890625,-1838.57421875,10656.26562500,0.00000000,0.00000000,270.00000000); //object(cj_cb_list1) (17)
	CreateDynamicObject(2765,1095.12890625,-1838.57421875,10657.36230469,0.00000000,0.00000000,270.00000000); //object(cj_cb_list1) (18)
	CreateDynamicObject(1523,1094.62695312,-1841.01855469,10655.96582031,0.00000000,0.00000000,0.00000000); //object(gen_doorext10) (1)
	CreateDynamicObject(2765,1098.56152344,-1841.47363281,10656.26562500,0.00000000,0.00000000,179.99450684); //object(cj_cb_list1) (19)
	CreateDynamicObject(2765,1098.56152344,-1841.47363281,10657.36230469,0.00000000,0.00000000,179.99450684); //object(cj_cb_list1) (20)
	CreateDynamicObject(2765,1096.56054688,-1840.54687500,10656.26562500,0.00000000,0.00000000,0.00000000); //object(cj_cb_list1) (19)
	CreateDynamicObject(2765,1096.56054688,-1840.52636719,10657.36230469,0.00000000,0.00000000,0.00000000); //object(cj_cb_list1) (19)
	CreateDynamicObject(1649,1096.87011719,-1841.01855469,10660.11328125,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (1)
	CreateDynamicObject(2765,1091.03613281,-1841.24218750,10656.26562500,0.00000000,0.00000000,90.00000000); //object(cj_cb_list1) (7)
	CreateDynamicObject(1727,1093.38281250,-1839.44238281,10656.26562500,0.00000000,0.00000000,319.99877930); //object(mrk_seating2b) (1)
	CreateDynamicObject(14535,1096.87500000,-1843.91894531,10658.28906250,0.00000000,0.00000000,90.00000000); //object(ab_woozies03) (1)
	CreateDynamicObject(2242,1093.31054688,-1844.89160156,10656.46875000,0.00000000,0.00000000,0.00000000); //object(plant_pot_7) (1)
	CreateDynamicObject(2829,1093.79711914,-4843.28564453,10657.07421875,0.00000000,0.00000000,0.00000000); //object(gb_platedirty02) (1)
	CreateDynamicObject(1649,1091.45703125,-1839.49902344,10659.03125000,0.00000000,0.00000000,270.00000000); //object(wglasssmash) (1)
	CreateDynamicObject(1649,1091.45703125,-1839.49902344,10659.03125000,0.00000000,0.00000000,90.00000000); //object(wglasssmash) (1)
	CreateDynamicObject(2765,1091.94238281,-1839.25390625,10656.26562500,0.00000000,0.00000000,270.00000000); //object(cj_cb_list1) (7)
	CreateDynamicObject(1701,1087.80859375,-1842.74414062,10656.26562500,0.00000000,0.00000000,0.00000000); //object(kb_bed_test2) (1)
	CreateDynamicObject(2082,1089.30957031,-1840.04589844,10656.26562500,0.00000000,0.00000000,0.00000000); //object(coffee_med_3) (1)
	CreateDynamicObject(2082,1086.30664062,-1840.16015625,10656.26562500,0.00000000,0.00000000,0.00000000); //object(coffee_med_3) (2)
	CreateDynamicObject(2315,1087.47949219,-1844.52343750,10656.26562500,0.00000000,0.00000000,358.74206543); //object(cj_tv_table4) (1)
	CreateDynamicObject(1792,1088.27246094,-1844.58886719,10656.76171875,0.00000000,0.00000000,179.99450684); //object(swank_tv_1) (1)
	CreateDynamicObject(3044,1087.25292969,-4844.13964844,10656.80175781,0.00000000,0.00000000,0.00000000); //object(cigar) (1)
	CreateDynamicObject(2811,1090.56542969,-1844.22070312,10656.26562500,0.00000000,0.00000000,0.00000000); //object(gb_romanpot01) (1)
	CreateDynamicObject(2765,1084.25097656,-1845.11132812,10656.26562500,0.00000000,0.00000000,90.00000000); //object(cj_cb_list1) (7)
	CreateDynamicObject(2765,1084.25097656,-1840.71191406,10656.26562500,0.00000000,0.00000000,90.00000000); //object(cj_cb_list1) (7)
	CreateDynamicObject(1502,1084.78320312,-1842.68652344,10656.26660156,0.00000000,0.00000000,90.00000000); //object(gen_doorint04) (1)
	CreateDynamicObject(2765,1084.25097656,-1840.71191406,10657.36523438,0.00000000,0.00000000,90.00000000); //object(cj_cb_list1) (7)
	CreateDynamicObject(2765,1084.25097656,-1845.11132812,10657.36523438,0.00000000,0.00000000,90.00000000); //object(cj_cb_list1) (7)
	CreateDynamicObject(2765,1084.25097656,-1845.11132812,10658.46582031,0.00000000,0.00000000,90.00000000); //object(cj_cb_list1) (7)
	CreateDynamicObject(2765,1084.25097656,-1840.71191406,10658.46582031,0.00000000,0.00000000,90.00000000); //object(cj_cb_list1) (7)
	CreateDynamicObject(2765,1085.17773438,-1843.14257812,10656.26562500,0.00000000,0.00000000,270.00000000); //object(cj_cb_list1) (7)
	CreateDynamicObject(2765,1085.17773438,-1843.14257812,10657.36523438,0.00000000,0.00000000,270.00000000); //object(cj_cb_list1) (7)
	CreateDynamicObject(2765,1085.17773438,-1843.14257812,10658.46582031,0.00000000,0.00000000,270.00000000); //object(cj_cb_list1) (7)
	CreateDynamicObject(2765,1085.17773438,-1838.71386719,10656.26562500,0.00000000,0.00000000,270.00000000); //object(cj_cb_list1) (7)
	CreateDynamicObject(2765,1085.17773438,-1838.71386719,10657.36523438,0.00000000,0.00000000,270.00000000); //object(cj_cb_list1) (7)
	CreateDynamicObject(2765,1085.17773438,-1838.71386719,10658.46582031,0.00000000,0.00000000,270.00000000); //object(cj_cb_list1) (7)
	CreateDynamicObject(2865,1096.23132324,-4843.30810547,10657.29003906,0.00000000,0.00000000,0.00000000); //object(gb_kitchplatecln05) (1)
	CreateDynamicObject(1664,1086.52050781,-1839.36523438,10656.93261719,0.00000000,0.00000000,0.00000000); //object(propwinebotl2) (1)
	CreateDynamicObject(1665,1087.00976562,-1839.81347656,10656.79589844,0.00000000,0.00000000,0.00000000); //object(propashtray1) (1)
	CreateDynamicObject(1667,1090.04687500,-1839.79101562,10656.85449219,0.00000000,0.00000000,0.00000000); //object(propwineglass1) (1)
	CreateDynamicObject(1667,1089.98144531,-1839.68945312,10656.85449219,0.00000000,0.00000000,0.00000000); //object(propwineglass1) (2)
	CreateDynamicObject(3044,1086.94726562,-4839.58105469,10656.80566406,0.00000000,0.00000000,0.00000000); //object(cigar) (1)
	CreateDynamicObject(2332,1090.79785156,-1838.78222656,10656.72851562,0.00000000,0.00000000,0.00000000); //object(kev_safe) (1)
	CreateDynamicObject(1668,1098.30175781,-1841.16503906,10658.30957031,0.00000000,0.00000000,0.00000000); //object(propvodkabotl1) (1)
	CreateDynamicObject(1669,1098.22167969,-1841.13476562,10658.24023438,0.00000000,0.00000000,0.00000000); //object(propwinebotl1) (1)
	CreateDynamicObject(1951,1098.34960938,-1841.29296875,10658.30761719,0.00000000,0.00000000,0.00000000); //object(kb_beer01) (1)
	CreateDynamicObject(2082,1091.78417969,-1840.01464844,10656.26562500,0.00000000,0.00000000,0.00000000); //object(coffee_med_3) (1)
	CreateDynamicObject(2852,1092.28625488,-4839.56103516,10656.76562500,0.00000000,0.00000000,0.00000000); //object(gb_bedmags02) (1)
	CreateDynamicObject(3503,1080.19824219,-1842.96972656,10657.59863281,0.00000000,0.00000000,0.00000000); //object(vgsnscffple) (1)
	CreateDynamicObject(16151,1083.61523438,-1840.16894531,10656.56542969,0.00000000,0.00000000,0.00000000); //object(ufo_bar) (1)
	CreateDynamicObject(1649,1084.68945312,-1841.73437500,10660.40234375,0.00000000,0.00000000,270.00000000); //object(wglasssmash) (2)
	CreateDynamicObject(1649,1084.68945312,-1842.09667969,10660.40234375,0.00000000,0.00000000,90.00000000); //object(wglasssmash) (3)
	CreateDynamicObject(1727,1079.04492188,-1840.69921875,10656.26562500,0.00000000,0.00000000,0.00000000); //object(mrk_seating2b) (2)
	CreateDynamicObject(1727,1077.62890625,-1841.63281250,10656.26562500,0.00000000,0.00000000,44.99450684); //object(mrk_seating2b) (3)
	CreateDynamicObject(1727,1077.45019531,-1843.25878906,10656.26562500,0.00000000,0.00000000,90.00000000); //object(mrk_seating2b) (4)
	CreateDynamicObject(1668,1082.78710938,-1839.74707031,10657.33789062,0.00000000,0.00000000,0.00000000); //object(propvodkabotl1) (2)
	CreateDynamicObject(1667,1082.76367188,-1840.01562500,10657.27929688,0.00000000,0.00000000,0.00000000); //object(propwineglass1) (3)
	CreateDynamicObject(1667,1082.62500000,-1840.19042969,10657.27929688,0.00000000,0.00000000,0.00000000); //object(propwineglass1) (4)
	CreateDynamicObject(11472,1075.02148438,-1837.17578125,10659.26562500,0.00000000,180.00000000,180.00000000); //object(des_swtstairs1) (1)
	CreateDynamicObject(1502,1075.63671875,-1844.68066406,10656.26562500,0.00000000,0.00000000,90.00000000); //object(gen_doorint04) (1)
	CreateDynamicObject(11472,1068.94531250,-1844.47656250,10656.26562500,0.00000000,0.00000000,81.99645996); //object(des_swtstairs1) (2)
	CreateDynamicObject(11472,1069.61914062,-1840.03613281,10656.26562500,0.00000000,0.00000000,277.99804688); //object(des_swtstairs1) (3)
	CreateDynamicObject(11472,1071.05761719,-1844.56347656,10656.26562500,0.00000000,0.00000000,44.99450684); //object(des_swtstairs1) (4)
	CreateDynamicObject(11472,1069.98925781,-1841.17382812,10656.26562500,0.00000000,0.00000000,314.99450684); //object(des_swtstairs1) (5)
	CreateDynamicObject(11472,1069.81542969,-1843.15332031,10656.26562500,0.00000000,0.00000000,0.00000000); //object(des_swtstairs1) (6)
	CreateDynamicObject(1828,1088.67565918,-4842.82812500,10656.26562500,0.00000000,0.00000000,0.00000000); //object(man_sdr_rug) (1)
	CreateDynamicObject(2847,1079.69714355,-4843.47314453,10656.26562500,0.00000000,0.00000000,0.00000000); //object(gb_bedrug05) (1)
	CreateDynamicObject(2811,1080.81640625,-1839.76367188,10656.26562500,0.00000000,0.00000000,0.00000000); //object(gb_romanpot01) (2)
	CreateDynamicObject(2176,1077.15429688,-1840.98535156,10657.50781250,0.00000000,0.00000000,0.00000000); //object(casino_light4) (1)
	CreateDynamicObject(11472,1069.93847656,-1844.49707031,10659.06542969,10.99731445,267.99499512,270.00000000); //object(des_swtstairs1) (5)
	CreateDynamicObject(11472,1069.93908691,-1841.24218750,10658.94921875,11.00000000,267.99499512,270.00000000); //object(des_swtstairs1) (5)
	CreateDynamicObject(1791,1070.19921875,-1842.57910156,10657.64160156,0.00000000,0.00000000,90.00000000); //object(swank_tv_2) (1)
	CreateDynamicObject(1791,1070.19921875,-1841.92187500,10657.64257812,0.00000000,0.00000000,90.00000000); //object(swank_tv_2) (2)
	CreateDynamicObject(1791,1070.19824219,-1842.57910156,10657.00976562,0.00000000,0.00000000,90.00000000); //object(swank_tv_2) (3)
	CreateDynamicObject(1791,1070.19824219,-1841.92187500,10657.00976562,0.00000000,0.00000000,90.00000000); //object(swank_tv_2) (4)
	CreateDynamicObject(1791,1070.49316406,-1843.42285156,10657.64160156,0.00000000,0.49987793,135.00000000); //object(swank_tv_2) (5)
	CreateDynamicObject(1791,1070.49316406,-1843.42285156,10657.00976562,0.00000000,0.49987793,135.00000000); //object(swank_tv_2) (6)
	CreateDynamicObject(1791,1070.96386719,-1843.90820312,10657.64160156,0.00000000,0.49987793,135.00000000); //object(swank_tv_2) (7)
	CreateDynamicObject(1791,1070.96386719,-1843.90820312,10657.00976562,0.00000000,0.49987793,135.00000000); //object(swank_tv_2) (8)
	CreateDynamicObject(1562,1072.51757812,-1843.06640625,10656.92089844,0.00000000,0.00000000,270.00000000); //object(ab_jetseat) (1)
	CreateDynamicObject(2765,1070.18652344,-1843.36523438,10657.41406250,90.00000000,179.99450684,269.99450684); //object(cj_cb_list1) (1)
	CreateDynamicObject(2765,1071.98632812,-1841.76367188,10657.05175781,52.24548340,90.00000000,270.00000000); //object(cj_cb_list1) (4)
	CreateDynamicObject(1562,1072.53906250,-1841.56640625,10656.92089844,0.00000000,0.00000000,269.98901367); //object(ab_jetseat) (2)
	CreateDynamicObject(1563,1072.84375000,-1843.06738281,10657.44628906,0.00000000,0.00000000,270.00000000); //object(ab_jetseat_hrest) (1)
	CreateDynamicObject(2344,1072.33984375,-1842.70214844,10656.92578125,0.00000000,0.00000000,270.00000000); //object(cj_remote) (1)
	CreateDynamicObject(16782,1071.29980469,-1842.38964844,10655.75878906,0.00000000,0.00000000,0.00000000); //object(a51_radar_scan) (1)
	CreateDynamicObject(1749,1071.62500000,-1842.12890625,10656.21582031,307.79846191,0.00000000,90.00000000); //object(med_tv_3) (1)
	CreateDynamicObject(2528,1098.10156250,-1839.32714844,10656.26562500,0.00000000,0.00000000,270.00000000); //object(cj_toilet3) (1)
	CreateDynamicObject(2518,1098.04199219,-1839.72265625,10656.26562500,0.00000000,0.00000000,270.00000000); //object(cj_b_sink2) (1)
	CreateDynamicObject(1778,1097.33886719,-1840.56152344,10656.26562500,0.00000000,0.00000000,0.00000000); //object(cj_mop_pail) (1)
	CreateDynamicObject(13657,997.56152344,-1902.68554688,10659.50000000,0.00000000,0.00000000,0.00000000); //object(bit) (1)
	CreateDynamicObject(2071,1085.91857910,-1843.76342773,10657.78125000,0.00000000,0.00000000,90.00000000); //object(cj_mlight5) (2)
	CreateDynamicObject(2238,1089.21484375,-1844.58740234,10657.16992188,0.00000000,0.00000000,0.00000000); //object(cj_lava_lamp) (2)
	CreateDynamicObject(3044,1087.33972168,-1844.33776855,10656.80175781,0.00000000,0.00000000,0.00000000); //object(cigar) (2)
	CreateDynamicObject(3044,1086.94531250,-1839.54956055,10656.80566406,0.00000000,0.00000000,0.00000000); //object(cigar) (3)
	CreateDynamicObject(1828,1088.56213379,-1842.86840820,10656.26562500,0.00000000,0.00000000,0.00000000); //object(man_sdr_rug) (2)
	CreateDynamicObject(2261,1094.15307617,-1840.11523438,10657.48242188,0.00000000,0.25000000,270.00000000); //object(frame_slim_2) (1)
	CreateDynamicObject(2255,1076.25695801,-1842.27075195,10657.59179688,0.00000000,0.00000000,88.50000000); //object(frame_clip_2) (1)
	CreateDynamicObject(2961,1072.74108887,-1840.35485840,10657.62890625,0.00000000,0.00000000,0.00000000); //object(fire_break) (2)
	CreateDynamicObject(2961,1072.74218750,-1840.35473633,10657.78222656,0.00000000,0.00000000,0.00000000); //object(fire_break) (3)
	CreateDynamicObject(2922,1074.39562988,-1844.48547363,10657.53808594,0.00000000,0.00000000,0.00000000); //object(kmb_keypad) (2)
	CreateDynamicObject(2922,1074.39428711,-1844.48535156,10657.84667969,0.00000000,0.00000000,0.00000000); //object(kmb_keypad) (3)
	CreateDynamicObject(2690,1074.04833984,-1840.25500488,10656.62500000,0.00000000,0.00000000,0.00000000); //object(cj_fire_ext) (1)

	//Statek by Patrick Brown
    CreateDynamicObject(7658,1939.37109375,1397.42871094,12312.87597656,0.00000000,0.00000000,270.00000000); //object(vgnbuild1new) (1)
	CreateDynamicObject(7658,1950.02246094,1321.02246094,12312.87597656,0.00000000,0.00000000,90.00000000); //object(vgnbuild1new) (5)
	CreateDynamicObject(7658,1954.32617188,1381.26464844,12312.87597656,0.00000000,0.00000000,270.00000000); //object(vgnbuild1new) (4)
	CreateDynamicObject(2266,1942.20239258,1358.37292480,12316.03222656,0.00000000,0.00000000,270.00000000); //object(frame_wood_5) (1)
	CreateDynamicObject(1523,1930.46704102,1362.18774414,12312.87597656,0.00000000,0.00000000,269.98901367); //object(gen_doorext10) (1)
	CreateDynamicObject(2268,1935.66113281,1361.62011719,12315.75488281,0.00000000,0.00000000,0.00000000); //object(frame_wood_2) (1)
	CreateDynamicObject(2877,1934.96838379,1362.11987305,12314.04785156,0.00000000,0.00000000,0.00000000); //object(cj_binco_door) (3)
	CreateDynamicObject(1642,1935.67321777,1360.60913086,12312.87597656,0.00000000,0.00000000,0.00000000); //object(beachtowel02) (1)
	CreateDynamicObject(1642,1934.54602051,1360.60839844,12312.87597656,0.00000000,0.00000000,0.00000000); //object(beachtowel02) (2)
	CreateDynamicObject(1642,1936.82324219,1360.60327148,12312.87597656,0.00000000,0.00000000,0.00000000); //object(beachtowel02) (3)
	CreateDynamicObject(2404,1942.66430664,1358.91064453,12314.12011719,0.00000000,0.00000000,270.00000000); //object(cj_surf_board) (1)
	CreateDynamicObject(2404,1942.41442871,1358.89733887,12314.12011719,352.00488281,357.98034668,267.71899414); //object(cj_surf_board) (3)
	CreateDynamicObject(2404,1942.16406250,1358.89733887,12314.12011719,344.00000000,0.00000000,270.00000000); //object(cj_surf_board) (4)
	CreateDynamicObject(2406,1942.63769531,1358.06103516,12314.12011719,0.00000000,0.00000000,268.00000000); //object(cj_surf_board3) (1)
	CreateDynamicObject(2406,1942.63769531,1358.06054688,12314.12011719,0.00000000,0.00000000,268.00000000); //object(cj_surf_board3) (2)
	CreateDynamicObject(2406,1942.36108398,1358.05395508,12314.12011719,348.00000000,0.00000000,267.99499512); //object(cj_surf_board3) (3)
	CreateDynamicObject(2406,1942.14770508,1358.05993652,12314.12011719,342.00000000,0.00000000,268.00000000); //object(cj_surf_board3) (5)
	CreateDynamicObject(2405,1942.60754395,1357.18835449,12314.12011719,0.00000000,0.00000000,272.00000000); //object(cj_surf_board2) (1)
	CreateDynamicObject(2405,1942.38793945,1357.17993164,12314.12011719,350.00000000,0.00000000,271.99951172); //object(cj_surf_board2) (2)
	CreateDynamicObject(2405,1942.14038086,1357.17175293,12314.12011719,338.00000000,0.00000000,271.99951172); //object(cj_surf_board2) (3)
	CreateDynamicObject(2484,1939.39855957,1356.60498047,12315.40820312,0.00000000,0.00000000,0.00000000); //object(model_yaught) (1)
	CreateDynamicObject(14705,1938.94494629,1361.89135742,12315.16894531,0.00000000,0.00000000,0.00000000); //object(int2vase) (1)
	CreateDynamicObject(1235,1940.21728516,1361.81359863,12313.37890625,0.00000000,0.00000000,34.00000000); //object(wastebin) (1)
	CreateDynamicObject(2835,1933.54846191,1356.40637207,12312.87597656,0.00000000,0.00000000,0.00000000); //object(gb_livingrug04) (1)
	CreateDynamicObject(7658,1896.46972656,1337.12597656,12306.14160156,0.00000000,0.00000000,0.00000000); //object(vgnbuild1new) (2)
	CreateDynamicObject(14416,1927.39648438,1361.27148438,12309.70019531,0.00000000,0.00000000,269.99499512); //object(carter-stairs07) (1)
	CreateDynamicObject(6300,1899.17773438,1376.04687500,12303.82128906,0.00000000,0.00000000,0.00000000); //object(pier04_law2) (1)
	CreateDynamicObject(7658,1887.46789551,1341.53308105,12312.87597656,0.00000000,0.00000000,90.00000000); //object(vgnbuild1new) (5)
	CreateDynamicObject(7658,1922.88281250,1399.88916016,12312.87597656,0.00000000,0.00000000,270.00000000); //object(vgnbuild1new) (1)
	CreateDynamicObject(7658,1887.81542969,1367.13671875,12306.14550781,0.00000000,0.00000000,0.00000000); //object(vgnbuild1new) (2)
	CreateDynamicObject(7658,1939.37145996,1397.42871094,12306.14550781,0.00000000,0.00000000,270.00000000); //object(vgnbuild1new) (1)
	CreateDynamicObject(7658,1895.56445312,1337.12597656,12312.87597656,0.00000000,0.00000000,0.00000000); //object(vgnbuild1new) (2)
	CreateDynamicObject(7658,1923.08666992,1399.88916016,12306.14550781,0.00000000,0.00000000,270.00000000); //object(vgnbuild1new) (1)
	CreateDynamicObject(7658,1887.81542969,1367.68554688,12312.88085938,0.00000000,0.00000000,0.00000000); //object(vgnbuild1new) (2)
	CreateDynamicObject(8661,1925.73706055,1400.06262207,12331.92578125,0.00000000,180.00000000,2.00000000); //object(gnhtelgrnd_lvs) (1)
	CreateDynamicObject(6300,1959.68261719,1377.32324219,12304.82128906,0.00000000,0.00000000,0.00000000); //object(pier04_law2) (1)
	CreateDynamicObject(2523,1923.63952637,1364.05603027,12311.87597656,0.00000000,0.00000000,0.00000000); //object(cj_b_sink3) (2)
	CreateDynamicObject(2528,1926.73327637,1364.07080078,12311.87597656,0.00000000,0.00000000,0.00000000); //object(cj_toilet3) (2)
	CreateDynamicObject(2517,1924.69335938,1361.17687988,12311.87597656,0.00000000,0.00000000,90.00000000); //object(cj_shower1) (2)
	CreateDynamicObject(14684,1924.72399902,1366.30895996,12314.49902344,0.00000000,0.00000000,0.00000000); //object(int_tatooa12) (1)
	CreateDynamicObject(1744,1923.00024414,1362.70935059,12313.17480469,0.00000000,0.00000000,90.00000000); //object(med_shelf) (1)
	CreateDynamicObject(2752,1923.28613281,1363.96386719,12313.51562500,0.00000000,358.00000000,123.99996948); //object(cj_hairspray2) (1)
	CreateDynamicObject(2751,1923.34265137,1363.52282715,12313.56250000,0.00000000,0.00000000,0.00000000); //object(cj_hairscream) (1)
	CreateDynamicObject(2749,1923.30664062,1362.47705078,12313.51562500,0.00000000,0.00000000,0.00000000); //object(cj_hairspray) (1)
	CreateDynamicObject(2750,1923.23022461,1362.68420410,12313.54785156,270.00000000,180.69561768,176.69555664); //object(cj_hair_dryer) (1)
	CreateDynamicObject(1640,1926.01232910,1362.17504883,12311.87597656,0.00000000,0.00000000,0.00000000); //object(beachtowel04) (1)
	CreateDynamicObject(14866,1941.72167969,1360.83203125,12313.47167969,0.00000000,0.00000000,0.00000000); //object(bobbie-bed01) (1)
	CreateDynamicObject(2297,1940.16296387,1356.59460449,12312.87597656,0.00000000,0.50000000,134.25000000); //object(tv_unit_2) (1)
	CreateDynamicObject(2152,1931.13854980,1358.09326172,12312.87695312,0.00000000,0.00000000,90.00000000); //object(cj_k5_low_unit3) (1)
	CreateDynamicObject(2117,1933.53063965,1356.82287598,12312.87597656,0.00000000,0.00000000,0.00000000); //object(swank_dinning_5) (1)
	CreateDynamicObject(1716,1932.97473145,1357.05017090,12312.87597656,0.00000000,0.00000000,0.00000000); //object(kb_slot_stool) (1)
	CreateDynamicObject(1716,1933.97216797,1357.83642578,12312.87597656,0.00000000,0.00000000,0.00000000); //object(kb_slot_stool) (2)
	CreateDynamicObject(1716,1934.71728516,1357.84716797,12312.87597656,0.00000000,0.00000000,0.00000000); //object(kb_slot_stool) (3)
	CreateDynamicObject(1716,1935.62158203,1357.14086914,12312.87597656,0.00000000,0.00000000,0.00000000); //object(kb_slot_stool) (4)
	CreateDynamicObject(2149,1931.24780273,1358.05639648,12314.08203125,0.00000000,0.00000000,88.00000000); //object(cj_microwave1) (1)
	CreateDynamicObject(2154,1931.13073730,1359.43310547,12312.87695312,0.00000000,0.00000000,90.49438477); //object(cj_k5_low_unit1) (2)
	CreateDynamicObject(2269,1926.84509277,1361.13305664,12314.22949219,0.00000000,0.00000000,179.99993896); //object(frame_wood_4) (1)
	CreateDynamicObject(1744,1937.98181152,1362.29248047,12314.57910156,0.00000000,0.00000000,0.00000000); //object(med_shelf) (3)
	CreateDynamicObject(1598,1941.46411133,1356.70434570,12313.18066406,0.00000000,0.00000000,0.00000000); //object(beachball) (1)
	CreateDynamicObject(1598,1940.86096191,1356.68469238,12313.18066406,0.00000000,0.00000000,0.00000000); //object(beachball) (2)
	CreateDynamicObject(1598,1941.17797852,1357.17382812,12313.18066406,0.00000000,0.00000000,0.00000000); //object(beachball) (3)
	CreateDynamicObject(1598,1941.22082520,1356.79296875,12313.64453125,0.00000000,0.00000000,0.00000000); //object(beachball) (4)
	CreateDynamicObject(2277,1934.05419922,1356.85937500,12314.80371094,0.00000000,0.00000000,179.99993896); //object(frame_fab_2) (1)
	CreateDynamicObject(2330,1937.72729492,1357.80737305,12312.87597656,0.00000000,0.25000000,179.99993896); //object(cj_bedroom1_w) (1)
	CreateDynamicObject(2811,1937.99316406,1361.92578125,12314.91992188,0.00000000,0.00000000,0.00000000); //object(gb_romanpot01) (1)
	CreateDynamicObject(2069,1936.95605469,1361.86035156,12312.97558594,0.00000000,0.00000000,0.00000000); //object(cj_mlight7) (1)
	CreateDynamicObject(2103,1937.24060059,1356.75756836,12315.18066406,0.00000000,0.00000000,179.99993896); //object(low_hi_fi_1) (1)
	CreateDynamicObject(1702,1937.51647949,1361.55029297,12312.87597656,0.00000000,0.00000000,0.00000000); //object(kb_couch06) (1)
	CreateDynamicObject(1461,1934.00878906,1362.11987305,12314.66992188,0.00000000,0.00000000,0.00000000); //object(dyn_life_p) (1)
	CreateDynamicObject(1461,1933.29858398,1362.11987305,12314.69140625,0.00000000,0.00000000,0.00000000); //object(dyn_life_p) (2)
	CreateDynamicObject(1461,1932.94995117,1362.11987305,12314.09960938,0.00000000,0.00000000,0.00000000); //object(dyn_life_p) (3)
	CreateDynamicObject(1461,1932.61535645,1362.11914062,12314.66992188,0.00000000,0.00000000,0.00000000); //object(dyn_life_p) (4)
	CreateDynamicObject(1461,1933.64892578,1362.11987305,12314.09960938,0.00000000,0.00000000,0.00000000); //object(dyn_life_p) (6)
	CreateDynamicObject(2986,1930.91796875,1359.61071777,12316.97460938,0.00000000,270.00000000,0.00000000); //object(lxr_motelvent) (1)
	CreateDynamicObject(2153,1931.13854980,1356.96630859,12312.87695312,0.00000000,0.00000000,88.00000000); //object(cj_k5_unit1) (1)
	CreateDynamicObject(2153,1931.13854980,1357.38916016,12312.87695312,0.00000000,0.00000000,87.99499512); //object(cj_k5_unit1) (3)
	CreateDynamicObject(1670,1933.98718262,1356.78540039,12313.68359375,0.00000000,0.00000000,0.00000000); //object(propcollecttable) (1)
	CreateDynamicObject(632,1936.34753418,1356.14550781,12313.32226562,0.00000000,0.00000000,304.00000000); //object(veg_palmkb7) (1)
	CreateDynamicObject(1823,1938.02160645,1359.67309570,12312.87597656,0.00000000,0.00000000,0.00000000); //object(coffee_med_5) (2)
	CreateDynamicObject(2852,1938.49121094,1360.21643066,12313.37207031,0.00000000,0.00000000,266.00000000); //object(gb_bedmags02) (1)
	CreateDynamicObject(8661,1933.36901855,1364.84765625,12317.37792969,0.00000000,180.00000000,0.00000000); //object(gnhtelgrnd_lvs) (2)
	CreateDynamicObject(8661,1930.87329102,1359.51965332,12317.45117188,350.00042725,179.48681641,81.91094971); //object(gnhtelgrnd_lvs) (4)
	CreateDynamicObject(2740,1931.58947754,1359.15954590,12317.27734375,0.00000000,0.00000000,0.00000000); //object(cj_bs_light) (1)
	CreateDynamicObject(2740,1942.04699707,1359.14978027,12317.27734375,0.00000000,0.00000000,0.00000000); //object(cj_bs_light) (2)
	CreateDynamicObject(2740,1936.67309570,1359.32971191,12317.27734375,0.00000000,0.00000000,0.00000000); //object(cj_bs_light) (5)
	CreateDynamicObject(2740,1925.37158203,1362.51403809,12316.31347656,0.00000000,0.00000000,0.00000000); //object(cj_bs_light) (11)
	CreateDynamicObject(1731,1925.43212891,1364.39807129,12313.09375000,0.00000000,0.00000000,86.00000000); //object(cj_mlight3) (1)
	CreateDynamicObject(1731,1942.58093262,1360.86010742,12314.19824219,0.00000000,0.00000000,0.00000000); //object(cj_mlight3) (2)
	CreateDynamicObject(1208,1927.51538086,1363.21948242,12311.87597656,0.00000000,0.00000000,90.00000000); //object(washer) (1)


	//Rock hotel
	CreateDynamicObject(14449,2616.69995117,2440.30004883,15.10000038,0.00000000,0.00000000,0.00000000,0,0);
	CreateDynamicObject(2627,2611.19995117,2454.30004883,13.89999962,0.00000000,0.00000000,0.00000000,0,0); //bieznia1
	CreateDynamicObject(2627,2613.89990234,2454.30004883,13.89999962,0.00000000,0.00000000,0.00000000,0,0); //bieznia2
	CreateDynamicObject(2627,2616.60009766,2454.30004883,13.89999962,0.00000000,0.00000000,0.00000000,0,0); //bieznia3
	CreateDynamicObject(2627,2619.39990234,2454.30004883,13.89999962,0.00000000,0.00000000,0.00000000,0,0); //bieznia4
	CreateDynamicObject(2629,2624.80004883,2450.69995117,13.89999962,0.00000000,0.00000000,305.25000000,0,0); //sztangla1
	CreateDynamicObject(2629,2626.60009766,2448.10009766,13.89999962,0.00000000,0.00000000,305.24963379,0,0); //sztanga2
	CreateDynamicObject(2629,2628.50000000,2445.39990234,13.89999962,0.00000000,0.00000000,305.24963379,0,0); //sztlanga3
	CreateDynamicObject(2630,2625.30004883,2440.10009766,13.89999962,0.00000000,0.00000000,0.00000000,0,0); //object(gym_bike) (1)
	CreateDynamicObject(2630,2628.00000000,2440.10009766,13.89999962,0.00000000,0.00000000,0.00000000,0,0); //object(gym_bike) (2)
	CreateDynamicObject(2630,2630.89990234,2440.10009766,13.89999962,0.00000000,0.00000000,0.00000000,0,0); //object(gym_bike) (3)
	CreateDynamicObject(3072,2626.10009766,2449.69995117,13.89999962,84.00000000,180.00000000,52.00000000,0,0); //object(kmb_dumbbell_l) (1)
	CreateDynamicObject(3072,2625.80004883,2449.30004883,13.89999962,83.99597168,179.99450684,3.99829102,0,0); //object(kmb_dumbbell_l) (2)
	CreateDynamicObject(2915,2628.10009766,2446.80004883,14.00000000,0.00000000,0.00000000,0.00000000,0,0); //object(kmb_dumbbell2) (1)
	CreateDynamicObject(2913,2624.97998047,2451.39990234,14.89999962,0.00000000,90.00000000,304.99914551,0,0); //sytangla
	CreateDynamicObject(2913,2626.80004883,2448.80004883,14.89999962,0.00000000,90.00000000,304.99694824,0,0); //sytangla2
	CreateDynamicObject(2913,2628.69995117,2446.10009766,14.89999962,0.00000000,90.00000000,304.99694824,0,0); //sytangla3

	//Interior VicaForelli:
	
	//VICA FORELLI kryjowka
	CreateDynamicObject(8664,-1857.09960938,1155.50000000,6797.89990234,0.00000000,0.00000000,0.00000000,0,0); //object(casrylegrnd_lvs) (1)
	CreateDynamicObject(3943,-1828.30004883,1158.09997559,6802.39990234,0.00000000,0.00000000,90.00000000,0,0); //object(mid_staircase) (1)
	CreateDynamicObject(1508,-1825.69995117,1153.80004883,6803.60009766,0.00000000,0.00000000,0.00000000,0,0); //object(dyn_garage_door) (1)
	CreateDynamicObject(9093,-1829.69995117,1155.90002441,6799.70019531,0.00000000,0.00000000,0.00000000,0,0); //object(cmdgrgdoor_lvs) (1)
	CreateDynamicObject(9093,-1833.40002441,1152.19995117,6799.70019531,0.00000000,0.00000000,90.00000000,0,0); //object(cmdgrgdoor_lvs) (2)
	CreateDynamicObject(9093,-1837.09997559,1155.69995117,6799.70019531,0.00000000,0.00000000,0.00000000,0,0); //object(cmdgrgdoor_lvs) (4)
	CreateDynamicObject(9093,-1835.30004883,1159.30004883,6799.60009766,90.00000000,0.00000000,90.00000000,0,0); //object(cmdgrgdoor_lvs) (5)
	CreateDynamicObject(18553,-1835.19995117,1158.09997559,6801.39990234,0.00000000,90.00000000,89.99981689,0,0); //object(count_ammundoor) (1)
	CreateDynamicObject(18553,-1835.19995117,1155.50000000,6801.39990234,0.00000000,90.00000000,89.99987793,0,0); //object(count_ammundoor) (2)
	CreateDynamicObject(18553,-1835.19995117,1152.90002441,6801.39990234,0.00000000,90.00000000,89.99981689,0,0); //object(count_ammundoor) (3)
	CreateDynamicObject(18553,-1831.40002441,1152.90002441,6801.39990234,0.00000000,90.00000000,89.99981689,0,0); //object(count_ammundoor) (5)
	CreateDynamicObject(18553,-1831.40002441,1155.50000000,6801.39990234,0.00000000,90.00000000,90.00000000,0,0); //object(count_ammundoor) (6)
	CreateDynamicObject(18553,-1831.40002441,1158.09997559,6801.39990234,0.00000000,90.00000000,90.00000000,0,0); //object(count_ammundoor) (7)
	CreateDynamicObject(1778,-1836.40002441,1152.80004883,6798.00000000,0.00000000,0.00000000,0.00000000,0,0); //object(cj_mop_pail) (1)
	CreateDynamicObject(1450,-1836.19921875,1158.39941406,6798.60009766,0.00000000,0.00000000,49.99877930,0,0); //object(dyn_crate_3) (1)
	CreateDynamicObject(910,-1830.79980469,1153.39941406,6798.50000000,270.00000000,180.00000000,180.00000000,0,0); //object(bust_cabinet_4) (1)
	CreateDynamicObject(1221,-1830.43188477,1156.06176758,6798.43994141,0.00000000,0.00000000,0.00000000,0,0); //object(cardboardbox4) (1)
	CreateDynamicObject(1221,-1831.69995117,1155.69995117,6798.60009766,0.00000000,44.98901367,20.49267578,0,0); //object(cardboardbox4) (2)
	CreateDynamicObject(1812,-1834.30004883,1152.90002441,6798.10009766,10.00000000,350.00000000,270.00000000,0,0); //object(low_bed_5) (1)
	CreateDynamicObject(2827,-1835.59997559,1152.80004883,6798.00000000,0.00000000,0.00000000,0.00000000,0,0); //object(gb_novels05) (1)
	CreateDynamicObject(2827,-1836.50000000,1153.19995117,6798.00000000,0.00000000,0.00000000,0.00000000,0,0); //object(gb_novels05) (2)
	CreateDynamicObject(2827,-1836.50000000,1153.69995117,6798.00000000,0.00000000,0.00000000,180.00000000,0,0); //object(gb_novels05) (3)
	CreateDynamicObject(2854,-1836.30004883,1154.30004883,6798.00000000,0.00000000,0.00000000,0.00000000,0,0); //object(gb_bedmags04) (1)
	CreateDynamicObject(1437,-1834.69995117,1153.19995117,6796.00000000,0.00000000,0.00000000,182.25000000,0,0); //object(dyn_ladder_2) (1)
	CreateDynamicObject(9093,-1829.90002441,1159.30004883,6802.16992188,0.00000000,0.00000000,90.00000000,0,0); //object(cmdgrgdoor_lvs) (7)
	CreateDynamicObject(1492,-1833.69995117,1159.39001465,6797.89990234,0.00000000,0.00000000,0.00000000,0,0); //object(gen_doorint02) (1)
	CreateDynamicObject(9093,-1835.69995117,1165.40002441,6799.70019531,0.00000000,0.00000000,90.00000000,0,0); //object(cmdgrgdoor_lvs) (8)
	CreateDynamicObject(9093,-1832.11901855,1163.09997559,6799.70019531,0.00000000,0.00000000,0.00000000,0,0); //object(cmdgrgdoor_lvs) (11)
	CreateDynamicObject(18553,-1834.09997559,1160.59997559,6801.20019531,0.00000000,90.00000000,90.24993896,0,0); //object(count_ammundoor) (8)
	CreateDynamicObject(18553,-1834.09997559,1163.19995117,6801.20019531,0.00000000,90.00000000,90.24719238,0,0); //object(count_ammundoor) (10)
	CreateDynamicObject(18553,-1838.00000000,1160.59997559,6801.29980469,0.00000000,90.00000000,90.24993896,0,0); //object(count_ammundoor) (11)
	CreateDynamicObject(18553,-1838.00000000,1163.19995117,6801.29980469,0.00000000,90.00000000,90.24719238,0,0); //object(count_ammundoor) (12)
	CreateDynamicObject(3944,-1847.19995117,1168.19995117,6797.39990234,0.00000000,0.00000000,0.00000000,0,0); //object(bistro_blok) (1)
	CreateDynamicObject(3944,-1840.00000000,1169.89941406,6797.39990234,0.00000000,0.00000000,270.00000000,0,0); //object(bistro_blok) (2)
	CreateDynamicObject(9093,-1837.09997559,1164.50000000,6798.60009766,0.00000000,0.00000000,359.75000000,0,0); //object(cmdgrgdoor_lvs) (13)
	CreateDynamicObject(9093,-1837.09997559,1163.00000000,6802.10009766,0.00000000,0.00000000,0.00000000,0,0); //object(cmdgrgdoor_lvs) (14)
	CreateDynamicObject(18553,-1834.30004883,1165.50000000,6801.39990234,0.00000000,90.00000000,90.24719238,0,0); //object(count_ammundoor) (13)
	CreateDynamicObject(1221,-1832.50000000,1158.69995117,6798.39990234,0.00000000,0.00000000,0.00000000,0,0); //object(cardboardbox4) (1)
	CreateDynamicObject(1221,-1833.50000000,1158.59997559,6798.39990234,0.00000000,0.00000000,0.00000000,0,0); //object(cardboardbox4) (1)
	CreateDynamicObject(1221,-1833.50000000,1158.59997559,6799.29980469,0.00000000,0.00000000,0.00000000,0,0); //object(cardboardbox4) (1)
	CreateDynamicObject(1221,-1832.50000000,1158.50000000,6799.29980469,0.00000000,0.00000000,0.00000000,0,0); //object(cardboardbox4) (1)
	CreateDynamicObject(1221,-1832.69995117,1158.69995117,6800.20019531,0.00000000,0.00000000,0.00000000,0,0); //object(cardboardbox4) (1)
	CreateDynamicObject(3944,-1842.00000000,1169.89941406,6797.39990234,0.00000000,0.00000000,270.00000000,0,0); //object(bistro_blok) (2)
	CreateDynamicObject(1649,-1843.30004883,1161.09997559,6799.60009766,0.00000000,0.00000000,0.00000000,0,0); //object(wglasssmash) (1)
	CreateDynamicObject(1649,-1847.69995117,1161.09997559,6799.60009766,0.00000000,0.00000000,0.00000000,0,0); //object(wglasssmash) (2)
	CreateDynamicObject(1649,-1854.00000000,1161.09997559,6799.60009766,0.00000000,0.00000000,0.00000000,0,0); //object(wglasssmash) (3)
	CreateDynamicObject(2765,-1846.79980469,1166.09960938,6799.00000000,90.00000000,180.00549316,179.98352051,0,0); //object(cj_cb_list1) (1)
	CreateDynamicObject(2765,-1846.80004883,1167.19995117,6799.00000000,90.00000000,180.00549316,179.98352051,0,0); //object(cj_cb_list1) (2)
	CreateDynamicObject(2765,-1849.69921875,1167.19921875,6799.00000000,90.00000000,179.99450684,179.99450684,0,0); //object(cj_cb_list1) (3)
	CreateDynamicObject(2765,-1849.69921875,1166.09960938,6799.00000000,90.00000000,179.99450684,179.99450684,0,0); //object(cj_cb_list1) (4)
	CreateDynamicObject(2765,-1852.59960938,1166.09960938,6799.00000000,90.00000000,179.99450684,179.99450684,0,0); //object(cj_cb_list1) (5)
	CreateDynamicObject(2765,-1852.59960938,1167.19921875,6799.00000000,90.00000000,179.99450684,179.99450684,0,0); //object(cj_cb_list1) (6)
	CreateDynamicObject(1649,-1843.29980469,1161.00000000,6799.60009766,0.00000000,0.00000000,179.99450684,0,0); //object(wglasssmash) (4)
	CreateDynamicObject(1649,-1847.59960938,1161.00000000,6799.60009766,0.00000000,0.00000000,179.99450684,0,0); //object(wglasssmash) (5)
	CreateDynamicObject(2120,-1852.00000000,1168.19921875,6798.60009766,0.00000000,0.00000000,90.00000000,0,0); //object(med_din_chair_4) (1)
	CreateDynamicObject(2120,-1850.00000000,1168.19921875,6798.60009766,0.00000000,0.00000000,90.00000000,0,0); //object(med_din_chair_4) (2)
	CreateDynamicObject(2120,-1846.00000000,1168.19995117,6798.60009766,0.00000000,0.00000000,90.00000000,0,0); //object(med_din_chair_4) (3)
	CreateDynamicObject(2120,-1848.00000000,1168.19995117,6798.60009766,0.00000000,0.00000000,90.00000000,0,0); //object(med_din_chair_4) (4)
	CreateDynamicObject(2120,-1852.00000000,1163.90002441,6798.60009766,0.00000000,0.00000000,270.00000000,0,0); //object(med_din_chair_4) (5)
	CreateDynamicObject(2120,-1850.00000000,1163.90002441,6798.60009766,0.00000000,0.00000000,270.00000000,0,0); //object(med_din_chair_4) (6)
	CreateDynamicObject(2120,-1848.00000000,1163.89941406,6798.60009766,0.00000000,0.00000000,270.00000000,0,0); //object(med_din_chair_4) (7)
	CreateDynamicObject(2120,-1846.00000000,1163.90002441,6798.60009766,0.00000000,0.00000000,270.00000000,0,0); //object(med_din_chair_4) (8)
	CreateDynamicObject(1714,-1854.00000000,1166.09960938,6798.00000000,0.00000000,0.00000000,90.00000000,0,0); //object(kb_swivelchair1) (1)
	CreateDynamicObject(1306,-1848.80004883,1166.09997559,6791.07763672,0.00000000,179.99450684,0.00000000,0,0); //object(tlgraphpolegen) (1)
	CreateDynamicObject(2894,-1852.59997559,1166.00000000,6798.60009766,0.00000000,0.00000000,50.00000000,0,0); //object(kmb_rhymesbook) (1)
	CreateDynamicObject(3111,-1851.09997559,1166.09997559,6798.60009766,0.00000000,0.00000000,290.00000000,0,0); //object(st_arch_plan) (1)
	CreateDynamicObject(4141,-1843.29980469,1172.00000000,6775.50000000,0.00000000,90.00000000,89.99993896,0,0); //object(hotelexterior1_lan) (1)
	CreateDynamicObject(1649,-1854.00000000,1161.09997559,6799.70019531,0.00000000,0.00000000,179.99450684,0,0); //object(wglasssmash) (5)
	CreateDynamicObject(3944,-1855.29980469,1170.09960938,6797.60009766,0.00000000,0.00000000,90.00000000,0,0); //object(bistro_blok) (1)
	CreateDynamicObject(3944,-1865.19995117,1160.09997559,6797.50000000,0.00000000,0.00000000,0.50000000,0,0); //object(bistro_blok) (1)
	CreateDynamicObject(1569,-1858.89941406,1160.89941406,6797.89990234,0.00000000,0.00000000,0.00000000,0,0); //object(adam_v_door) (1)
	CreateDynamicObject(14581,-1881.80004883,1184.09997559,6800.39990234,0.00000000,0.00000000,0.00000000,0,0); //object(ab_mafiasuite01zzz) (1)
	CreateDynamicObject(3944,-1882.19995117,1190.30004883,6798.20019531,0.00000000,0.00000000,0.00000000,0,0); //object(bistro_blok) (3)
	CreateDynamicObject(3944,-1887.90002441,1183.09997559,6798.60009766,0.00000000,0.00000000,90.00000000,0,0); //object(bistro_blok) (4)
	CreateDynamicObject(3944,-1879.90002441,1177.80004883,6798.89990234,0.00000000,0.00000000,179.99450684,0,0); //object(bistro_blok) (6)
	CreateDynamicObject(3944,-1875.59997559,1183.30004883,6798.10009766,0.00000000,0.00000000,270.00000000,0,0); //object(bistro_blok) (1)
	CreateDynamicObject(3944,-1872.80004883,1178.59997559,6797.79980469,0.00000000,0.00000000,179.99450684,0,0); //object(bistro_blok) (8)
	CreateDynamicObject(9093,-1879.00000000,1192.00000000,6800.60009766,0.00000000,0.00000000,0.00000000,0,0); //object(cmdgrgdoor_lvs) (3)
	CreateDynamicObject(9093,-1879.00000000,1181.09960938,6800.79980469,0.00000000,0.00000000,0.00000000,0,0); //object(cmdgrgdoor_lvs) (6)
	CreateDynamicObject(9093,-1889.80004883,1177.50000000,6801.00000000,0.00000000,0.00000000,90.00000000,0,0); //object(cmdgrgdoor_lvs) (9)
	CreateDynamicObject(1569,-1877.80004883,1177.90002441,6798.00000000,0.00000000,0.00000000,0.00000000,0,0); //object(adam_v_door) (1)
	CreateDynamicObject(8710,-1866.89941406,1215.19921875,6825.39990234,90.00000000,180.00549316,179.98352051,0,0); //object(bnuhotel01_lvs) (2)
	CreateDynamicObject(2765,-1837.59960938,1159.80004883,6800.29980469,0.00000000,0.00000000,90.00000000,0,0); //object(cj_cb_list1) (4)
	CreateDynamicObject(3944,-1846.09960938,1158.50000000,6797.39990234,0.00000000,0.00000000,179.99450684,0,0); //object(bistro_blok) (2)
	CreateDynamicObject(5040,-1892.00000000,1119.50000000,6801.39990234,0.00000000,0.00000000,270.00000000,0,0); //object(unionliq_las) (2)
	CreateDynamicObject(3944,-1842.00000000,1169.89941406,6797.39990234,0.00000000,0.00000000,270.00000000,0,0); //object(bistro_blok) (2)
	CreateDynamicObject(3944,-1842.00000000,1169.89941406,6797.39990234,0.00000000,0.00000000,270.00000000,0,0); //object(bistro_blok) (2)
	CreateDynamicObject(3944,-1840.00000000,1169.89941406,6797.39990234,0.00000000,0.00000000,270.00000000,0,0); //object(bistro_blok) (2)
	CreateDynamicObject(3944,-1842.00000000,1169.89941406,6797.39990234,0.00000000,0.00000000,270.00000000,0,0); //object(bistro_blok) (2)
	CreateDynamicObject(3944,-1855.30004883,1170.09997559,6797.50000000,0.00000000,0.00000000,90.00000000,0,0); //object(bistro_blok) (1)
	CreateDynamicObject(8664,-1857.09960938,1155.50000000,6797.89990234,0.00000000,0.00000000,0.00000000,0,0); //object(casrylegrnd_lvs) (1)
	CreateDynamicObject(3944,-1838.00000000,1150.30004883,6797.39990234,0.00000000,0.00000000,270.00000000,0,0); //object(bistro_blok) (12)
	CreateDynamicObject(3944,-1846.09960938,1158.50000000,6797.39990234,0.00000000,0.00000000,179.99450684,0,0); //object(bistro_blok) (2)
	CreateDynamicObject(3944,-1846.09960938,1158.50000000,6797.39990234,0.00000000,0.00000000,179.99450684,0,0); //object(bistro_blok) (2)
	CreateDynamicObject(3944,-1864.19494629,1158.50000000,6797.39990234,0.00000000,0.00000000,179.99450684,0,0); //object(bistro_blok) (2)
	CreateDynamicObject(3944,-1864.30004883,1157.59997559,6797.50000000,0.00000000,0.00000000,90.00000000,0,0); //object(bistro_blok) (1)
	CreateDynamicObject(1536,-1858.90002441,1157.59997559,6797.89990234,0.00000000,0.00000000,0.00000000,0,0); //object(gen_doorext15) (1)
	CreateDynamicObject(5040,-1859.00000000,1089.30004883,6801.39990234,0.00000000,0.00000000,0.00000000,0,0); //object(unionliq_las) (2)
	CreateDynamicObject(5040,-1864.30004883,1138.30004883,6801.29980469,0.00000000,0.00000000,179.99450684,0,0); //object(unionliq_las) (2)
	CreateDynamicObject(5040,-1841.00000000,1110.30004883,6801.39990234,0.00000000,0.00000000,90.00000000,0,0); //object(unionliq_las) (2)
	CreateDynamicObject(1536,-1866.59997559,1117.09997559,6797.89990234,0.00000000,0.00000000,0.00000000,0,0); //object(gen_doorext15) (2)
	CreateDynamicObject(11666,-1862.40002441,1112.80004883,6799.70019531,0.00000000,0.00000000,96.00000000,0,0); //object(frame_wood_1ext) (1)
	CreateDynamicObject(1727,-1863.00000000,1116.09997559,6798.10009766,0.00000000,0.00000000,270.00000000,0,0); //object(mrk_seating2b) (1)
	CreateDynamicObject(1726,-1863.00000000,1114.80004883,6798.00000000,0.00000000,0.00000000,270.00000000,0,0); //object(mrk_seating2) (1)
	CreateDynamicObject(1727,-1863.00000000,1112.50000000,6798.00000000,0.00000000,0.00000000,269.99450684,0,0); //object(mrk_seating2b) (2)
	CreateDynamicObject(2315,-1864.59997559,1113.00000000,6798.10009766,0.00000000,0.00000000,90.00000000,0,0); //object(cj_tv_table4) (2)
	CreateDynamicObject(3044,-1864.69995117,1114.00000000,6798.70019531,0.00000000,0.00000000,56.00000000,0,0); //object(cigar) (1)
	CreateDynamicObject(1956,-1864.59997559,1114.00000000,6798.60009766,0.00000000,0.00000000,0.00000000,0,0); //object(turn_platerl) (1)
	CreateDynamicObject(3044,-1864.80004883,1113.80004883,6798.70019531,0.00000000,0.00000000,115.99728394,0,0); //object(cigar) (2)
	CreateDynamicObject(3044,-1864.69995117,1114.19995117,6798.70019531,0.00000000,0.00000000,339.99731445,0,0); //object(cigar) (3)
	CreateDynamicObject(1829,-1888.09997559,1190.50000000,6798.60009766,0.00000000,0.00000000,0.00000000,0,0); //object(man_safenew) (1)
	CreateDynamicObject(14806,-1870.09997559,1113.50000000,6799.20019531,0.00000000,0.00000000,90.00000000,0,0); //object(bdupshifi) (1)
	CreateDynamicObject(2169,-1862.80004883,1110.80004883,6798.10009766,0.00000000,0.00000000,0.00000000,0,0); //object(med_office3_desk_1) (1)
	CreateDynamicObject(2169,-1861.80004883,1116.80004883,6798.10009766,0.00000000,0.00000000,180.00000000,0,0); //object(med_office3_desk_1) (2)
	CreateDynamicObject(3919,-1867.30004883,1115.00000000,6798.00000000,0.00000000,0.00000000,0.00000000,0,0); //object(lib_main_bistrotop) (1)
	CreateDynamicObject(1667,-1862.80004883,1110.90002441,6799.00000000,0.00000000,0.00000000,0.00000000,0,0); //object(propwineglass1) (6)
	CreateDynamicObject(1667,-1862.69995117,1116.90002441,6799.00000000,0.00000000,0.00000000,0.00000000,0,0); //object(propwineglass1) (7)
	CreateDynamicObject(1667,-1862.59997559,1116.80004883,6799.00000000,0.00000000,0.00000000,0.00000000,0,0); //object(propwineglass1) (8)
	CreateDynamicObject(1667,-1862.50000000,1116.69995117,6799.00000000,0.00000000,0.00000000,0.00000000,0,0); //object(propwineglass1) (9)
	CreateDynamicObject(1667,-1862.90002441,1110.80004883,6799.00000000,0.00000000,0.00000000,0.00000000,0,0); //object(propwineglass1) (10)
	CreateDynamicObject(1667,-1862.69995117,1111.00000000,6799.00000000,0.00000000,0.00000000,0.00000000,0,0); //object(propwineglass1) (11)
	CreateDynamicObject(1665,-1863.09997559,1116.80004883,6798.93017578,0.00000000,0.00000000,0.00000000,0,0); //object(propashtray1) (1)
	CreateDynamicObject(1551,-1862.40002441,1116.90002441,6799.10009766,0.00000000,0.00000000,0.00000000,0,0); //object(dyn_wine_big) (1)
	CreateDynamicObject(1551,-1862.40002441,1110.59997559,6799.10009766,0.00000000,0.00000000,0.00000000,0,0); //object(dyn_wine_big) (2)
	CreateDynamicObject(8710,-1873.90002441,1132.00000000,6825.60009766,90.00000000,180.00549316,179.98352051,0,0); //object(bnuhotel01_lvs) (2)
	CreateDynamicObject(2010,-1837.50000000,1158.00000000,6798.00000000,0.00000000,0.00000000,0.00000000,0,0); //object(nu_plant3_ofc) (1)
	CreateDynamicObject(2010,-1864.80004883,1158.00000000,6798.00000000,0.00000000,0.00000000,60.00000000,0,0); //object(nu_plant3_ofc) (2)
	CreateDynamicObject(2010,-1864.80004883,1160.69995117,6798.00000000,0.00000000,0.00000000,59.99633789,0,0); //object(nu_plant3_ofc) (3)
	CreateDynamicObject(2258,-1862.69995117,1160.90002441,6800.29980469,0.00000000,0.00000000,0.00000000,0,0); //object(frame_clip_5) (1)
	CreateDynamicObject(2260,-1862.59997559,1158.11999512,6800.00000000,0.00000000,0.00000000,180.00000000,0,0); //object(frame_slim_1) (1)
	CreateDynamicObject(2270,-1846.50000000,1158.14001465,6800.00000000,0.00000000,0.00000000,180.00000000,0,0); //object(frame_wood_6) (1)
	CreateDynamicObject(2270,-1847.00000000,1158.14001465,6799.79980469,0.00000000,0.00000000,179.99450684,0,0); //object(frame_wood_6) (2)
	CreateDynamicObject(2270,-1847.50000000,1158.14001465,6799.60009766,0.00000000,0.00000000,179.99450684,0,0); //object(frame_wood_6) (3)
	CreateDynamicObject(2271,-1848.30004883,1168.56994629,6800.10009766,0.00000000,0.00000000,0.00000000,0,0); //object(frame_wood_1) (1)
	CreateDynamicObject(2261,-1855.66003418,1166.09997559,6800.00000000,0.00000000,0.00000000,90.00000000,0,0); //object(frame_slim_2) (1)
	CreateDynamicObject(1714,-1883.80004883,1189.50000000,6798.10009766,0.00000000,0.00000000,0.00000000,0,0); //object(kb_swivelchair1) (1)
	CreateDynamicObject(1714,-1885.59997559,1189.00000000,6798.10009766,0.00000000,0.00000000,36.00000000,0,0); //object(kb_swivelchair1) (1)
	CreateDynamicObject(1714,-1882.19995117,1189.09997559,6798.10009766,0.00000000,0.00000000,324.00000000,0,0); //object(kb_swivelchair1) (1)
	CreateDynamicObject(1720,-1886.59997559,1187.09997559,6798.10009766,0.00000000,0.00000000,72.00000000,0,0); //object(rest_chair) (2)
	CreateDynamicObject(1720,-1881.30004883,1187.30004883,6798.10009766,0.00000000,0.00000000,288.00109863,0,0); //object(rest_chair) (3)
	CreateDynamicObject(1720,-1881.30004883,1185.50000000,6798.10009766,0.00000000,0.00000000,251.99993896,0,0); //object(rest_chair) (4)
	CreateDynamicObject(1720,-1886.40002441,1185.40002441,6798.10009766,0.00000000,0.00000000,108.00000000,0,0); //object(rest_chair) (5)
	CreateDynamicObject(1720,-1882.30004883,1184.09997559,6798.10009766,0.00000000,0.00000000,216.00000000,0,0); //object(rest_chair) (6)
	CreateDynamicObject(1720,-1885.59997559,1184.40002441,6798.10009766,0.00000000,0.00000000,143.99993896,0,0); //object(rest_chair) (7)

	// parking kryjowki
	CreateDynamicObject(1334,-1739.80004883,1004.70001221,18.00000000,0.00000000,0.00000000,270.00000000,0,0); //object(binnt04_la) (1)
	CreateDynamicObject(967,-1772.40002441,978.79998779,22.60000038,0.00000000,0.00000000,180.00000000,0,0); //object(bar_gatebox01) (1)
	CreateDynamicObject(1886,-1740.00000000,1062.89941406,23.39999962,9.99755859,0.00000000,44.99450684,0,0); //object(shop_sec_cam) (2)
	CreateDynamicObject(1886,-1739.90002441,973.70001221,23.29999924,10.00000000,0.00000000,135.00000000,0,0); //object(shop_sec_cam) (3)
	CreateDynamicObject(1886,-1683.59997559,973.59997559,23.50000000,10.00000000,0.00000000,225.00000000,0,0); //object(shop_sec_cam) (4)
	CreateDynamicObject(1886,-1683.59997559,1062.90002441,23.60000038,10.00000000,0.00000000,315.00000000,0,0); //object(shop_sec_cam) (7)
	
	
	// g≥Ûwne vica firekku
	
	CreateDynamicObject(3944,1298.59960938,-1082.00000000,5969.89990234,0.00000000,0.00000000,0.00000000,0,0); //object(bistro_blok) (1)
	CreateDynamicObject(3944,1298.80004883,-1085.59997559,5969.70019531,0.00000000,0.00000000,179.99450684,0,0); //object(bistro_blok) (2)
	CreateDynamicObject(3944,1303.30004883,-1085.90002441,5969.89990234,0.00000000,0.00000000,270.00000000,0,0); //object(bistro_blok) (3)
	CreateDynamicObject(2765,1289.09179688,-1081.19921875,5973.39990234,0.00000000,90.00000000,89.99450684,0,0); //object(cj_cb_list1) (1)
	CreateDynamicObject(2765,1287.00000000,-1080.06933594,5973.39990234,0.00000000,90.00000000,270.00000000,0,0); //object(cj_cb_list1) (4)
	CreateDynamicObject(2765,1287.05957031,-1081.19921875,5973.39990234,270.00000000,179.99566650,179.99566650,0,0); //object(cj_cb_list1) (5)
	CreateDynamicObject(3944,1298.59997559,-1082.00000000,5973.39990234,0.00000000,0.00000000,0.00000000,0,0); //object(bistro_blok) (4)
	CreateDynamicObject(3944,1280.50976562,-1082.00000000,5973.39990234,0.00000000,0.00000000,0.00000000,0,0); //object(bistro_blok) (5)
	CreateDynamicObject(3944,1277.51953125,-1082.00000000,5969.89990234,0.00000000,0.00000000,0.00000000,0,0); //object(bistro_blok) (6)
	CreateDynamicObject(3944,1303.30004883,-1085.69995117,5973.39990234,0.00000000,0.00000000,270.00000000,0,0); //object(bistro_blok) (7)
	CreateDynamicObject(3944,1298.80004883,-1085.59997559,5973.20019531,0.00000000,0.00000000,179.99450684,0,0); //object(bistro_blok) (8)
	CreateDynamicObject(1533,1304.09997559,-1082.19995117,5971.20019531,0.00000000,0.00000000,270.00000000,0,0); //object(gen_doorext12) (1)
	CreateDynamicObject(1533,1304.09960938,-1083.69921875,5971.20019531,0.00000000,0.00000000,269.98901367,0,0); //object(gen_doorext12) (2)
	CreateDynamicObject(3944,1277.50000000,-1078.19995117,5969.89990234,0.00000000,0.00000000,179.99450684,0,0); //object(bistro_blok) (1)
	CreateDynamicObject(3944,1277.50000000,-1078.19921875,5973.39990234,0.00000000,0.00000000,179.99450684,0,0); //object(bistro_blok) (1)
	CreateDynamicObject(3944,1295.59997559,-1078.19995117,5973.39990234,0.00000000,0.00000000,179.99450684,0,0); //object(bistro_blok) (1)
	CreateDynamicObject(3944,1313.59997559,-1078.30004883,5973.39990234,0.00000000,0.00000000,179.99450684,0,0); //object(bistro_blok) (1)
	CreateDynamicObject(3944,1298.59960938,-1078.19921875,5969.89990234,0.00000000,0.00000000,179.99450684,0,0); //object(bistro_blok) (1)
	CreateDynamicObject(2765,1287.06005859,-1080.09997559,5973.39990234,270.00000000,180.00123596,180.00123596,0,0); //object(cj_cb_list1) (2)
	CreateDynamicObject(2765,1287.00000000,-1079.00000000,5973.39990234,0.00000000,90.00000000,270.00000000,0,0); //object(cj_cb_list1) (4)
	CreateDynamicObject(2765,1289.09204102,-1080.09997559,5973.39990234,0.00000000,90.00000000,89.99450684,0,0); //object(cj_cb_list1) (1)
	CreateDynamicObject(4007,1293.90002441,-1050.40002441,5948.39990234,282.99682617,90.00000000,90.00000000,0,0); //object(wellsfargo1_lan) (1)
	CreateDynamicObject(3944,1301.50000000,-1070.40002441,5969.89990234,0.00000000,0.00000000,270.00000000,0,0); //object(bistro_blok) (3)
	CreateDynamicObject(3944,1301.50000000,-1070.40002441,5973.39990234,0.00000000,0.00000000,270.00000000,0,0); //object(bistro_blok) (3)
	CreateDynamicObject(3944,1293.30004883,-1073.19995117,5969.89990234,0.00000000,0.00000000,0.00000000,0,0); //object(bistro_blok) (3)
	CreateDynamicObject(3944,1293.30004883,-1073.19995117,5973.39990234,0.00000000,0.00000000,0.00000000,0,0); //object(bistro_blok) (3)
	CreateDynamicObject(3944,1275.20996094,-1073.19995117,5969.89990234,0.00000000,0.00000000,0.00000000,0,0); //object(bistro_blok) (3)
	CreateDynamicObject(3944,1275.20996094,-1073.19995117,5973.39990234,0.00000000,0.00000000,0.00000000,0,0); //object(bistro_blok) (3)
	CreateDynamicObject(3944,1278.19921875,-1072.00000000,5969.89990234,0.00000000,0.00000000,90.00000000,0,0); //object(bistro_blok) (3)
	CreateDynamicObject(3944,1278.19995117,-1072.00000000,5973.39990234,0.00000000,0.00000000,90.00000000,0,0); //object(bistro_blok) (3)
	CreateDynamicObject(4141,1282.90002441,-1058.69995117,5999.79980469,0.00000000,90.00000000,0.00000000,0,0); //object(hotelexterior1_lan) (1)
	CreateDynamicObject(3944,1282.59997559,-1068.40002441,5968.29980469,0.00000000,0.00000000,90.00000000,0,0); //object(bistro_blok) (3)
	CreateDynamicObject(3944,1281.59997559,-1068.40002441,5968.29980469,0.00000000,0.00000000,90.00000000,0,0); //object(bistro_blok) (3)
	CreateDynamicObject(1569,1281.69995117,-1079.02001953,5971.20019531,0.00000000,0.00000000,90.00000000,0,0); //object(adam_v_door) (1)
	CreateDynamicObject(2765,1280.69995117,-1077.00000000,5972.70019531,90.00000000,180.00000000,270.00000000,0,0); //object(cj_cb_list1) (2)
	CreateDynamicObject(2765,1280.69995117,-1074.09997559,5972.70019531,90.00000000,179.99450684,269.99450684,0,0); //object(cj_cb_list1) (2)
	CreateDynamicObject(2765,1281.81994629,-1077.90002441,5971.79980469,0.00000000,90.00000000,180.00000000,0,0); //object(cj_cb_list1) (1)
	CreateDynamicObject(1649,1281.68994141,-1076.81994629,5975.37988281,0.00000000,0.00000000,90.00000000,0,0); //object(wglasssmash) (1)
	CreateDynamicObject(1649,1281.68994141,-1072.38403320,5975.37988281,0.00000000,0.00000000,90.00000000,0,0); //object(wglasssmash) (2)
	CreateDynamicObject(1649,1281.69921875,-1076.79980469,5975.39990234,0.00000000,0.00000000,270.00000000,0,0); //object(wglasssmash) (3)
	CreateDynamicObject(1649,1281.69995117,-1072.40002441,5975.39990234,0.00000000,0.00000000,270.00000000,0,0); //object(wglasssmash) (4)
	CreateDynamicObject(2190,1281.30004883,-1075.09997559,5972.29980469,0.00000000,0.00000000,270.00000000,0,0); //object(pc_1) (1)
	CreateDynamicObject(2894,1281.09997559,-1076.69995117,5972.29980469,0.00000000,0.00000000,90.00000000,0,0); //object(kmb_rhymesbook) (1)
	CreateDynamicObject(2894,1281.00000000,-1073.30004883,5972.29980469,0.00000000,0.00000000,90.00000000,0,0); //object(kmb_rhymesbook) (2)
	CreateDynamicObject(1714,1279.69995117,-1074.90002441,5971.20019531,0.00000000,0.00000000,90.00000000,0,0); //object(kb_swivelchair1) (1)
	CreateDynamicObject(1715,1279.66992188,-1076.59960938,5971.20019531,0.00000000,0.00000000,90.00000000,0,0); //object(kb_swivelchair2) (1)
	CreateDynamicObject(1715,1279.67004395,-1073.30004883,5971.20019531,0.00000000,0.00000000,90.00000000,0,0); //object(kb_swivelchair2) (2)
	CreateDynamicObject(2186,1277.80004883,-1078.50000000,5971.20019531,0.00000000,0.00000000,90.00000000,0,0); //object(photocopier_1) (1)
	CreateDynamicObject(2162,1277.45996094,-1076.67004395,5971.20019531,0.00000000,0.00000000,90.00000000,0,0); //object(med_office_unit_1) (1)
	CreateDynamicObject(2161,1277.50000000,-1074.90002441,5971.20019531,0.00000000,0.00000000,90.00000000,0,0); //object(med_office_unit_4) (1)
	CreateDynamicObject(2161,1277.50000000,-1074.90002441,5972.56005859,0.00000000,0.00000000,90.00000000,0,0); //object(med_office_unit_4) (2)
	CreateDynamicObject(2167,1277.50000000,-1073.55004883,5971.22021484,0.00000000,0.00000000,90.00000000,0,0); //object(med_office_unit_7) (1)
	CreateDynamicObject(1235,1277.90002441,-1072.69995117,5971.70019531,0.00000000,0.00000000,0.00000000,0,0); //object(wastebin) (1)
	CreateDynamicObject(1704,1299.59997559,-1072.90002441,5971.20019531,0.00000000,0.00000000,0.00000000,0,0); //object(kb_chair03) (1)
	CreateDynamicObject(1723,1301.69995117,-1074.00000000,5971.20019531,0.00000000,0.00000000,270.00000000,0,0); //object(mrk_seating1) (1)
	CreateDynamicObject(1704,1300.50000000,-1077.19995117,5971.20019531,0.00000000,0.00000000,180.00000000,0,0); //object(kb_chair03) (2)
	CreateDynamicObject(2314,1300.09997559,-1075.80004883,5971.20019531,0.00000000,0.00000000,90.00000000,0,0); //object(cj_tv_table3) (1)
	CreateDynamicObject(2826,1300.00000000,-1075.19995117,5971.70019531,0.00000000,0.00000000,0.00000000,0,0); //object(gb_novels04) (1)
	CreateDynamicObject(2248,1301.90002441,-1078.59997559,5971.79980469,0.00000000,0.00000000,0.00000000,0,0); //object(plant_pot_16) (1)
	CreateDynamicObject(2270,1295.59997559,-1072.84997559,5973.89990234,0.00000000,0.00000000,0.00000000,0,0); //object(frame_wood_6) (1)
	CreateDynamicObject(2270,1296.09997559,-1072.84997559,5973.50000000,0.00000000,0.00000000,0.00000000,0,0); //object(frame_wood_6) (2)
	CreateDynamicObject(2270,1295.09997559,-1072.84997559,5974.29980469,0.00000000,0.00000000,0.00000000,0,0); //object(frame_wood_6) (3)
	CreateDynamicObject(2282,1295.80004883,-1078.50000000,5973.79980469,0.00000000,0.00000000,180.00000000,0,0); //object(frame_thick_4) (1)
	CreateDynamicObject(3944,1279.19995117,-1085.59997559,5969.70019531,0.00000000,0.00000000,179.99450684,0,0); //object(bistro_blok) (2)
	CreateDynamicObject(1677,1291.00000000,-1101.89941406,5967.39990234,0.00000000,0.00000000,270.00000000,0,0); //object(wshxrefhse2) (1)
	CreateDynamicObject(2765,1288.69921875,-1086.45605469,5973.29980469,0.00000000,90.00000000,270.00000000,0,0); //object(cj_cb_list1) (4)
	CreateDynamicObject(2765,1289.29980469,-1087.59667969,5973.29980469,0.00000000,90.00000000,89.98895264,0,0); //object(cj_cb_list1) (1)
	CreateDynamicObject(2765,1288.09960938,-1087.59960938,5973.20019531,270.00000000,180.00122070,180.00122070,0,0); //object(cj_cb_list1) (5)
	CreateDynamicObject(3944,1298.80004883,-1089.50000000,5969.70019531,0.00000000,0.00000000,0.00000000,0,0); //object(bistro_blok) (1)
	CreateDynamicObject(3944,1298.79504395,-1089.50000000,5973.20019531,0.00000000,0.00000000,0.00000000,0,0); //object(bistro_blok) (1)
	CreateDynamicObject(3944,1279.19995117,-1089.50000000,5969.70019531,0.00000000,0.00000000,0.00000000,0,0); //object(bistro_blok) (1)
	CreateDynamicObject(3944,1280.69995117,-1085.59997559,5973.20019531,0.00000000,0.00000000,179.99450684,0,0); //object(bistro_blok) (2)
	CreateDynamicObject(3944,1280.69995117,-1089.50000000,5973.20019531,0.00000000,0.00000000,0.00000000,0,0); //object(bistro_blok) (1)
	CreateDynamicObject(3944,1287.50000000,-1097.29980469,5970.60009766,0.00000000,0.00000000,90.00000000,0,0); //object(bistro_blok) (3)
	CreateDynamicObject(3944,1292.50000000,-1094.69995117,5970.60009766,0.00000000,0.00000000,179.99450684,0,0); //object(bistro_blok) (1)
	CreateDynamicObject(3944,1300.59997559,-1095.90002441,5970.60009766,0.00000000,0.00000000,270.00000000,0,0); //object(bistro_blok) (3)
	CreateDynamicObject(8710,1259.89941406,-1122.50000000,6004.29980469,0.00000000,90.00000000,0.00000000,0,0); //object(bnuhotel01_lvs) (1)
	CreateDynamicObject(2165,1298.19921875,-1095.00000000,5971.20019531,0.00000000,0.00000000,179.99450684,0,0); //object(med_office_desk_1) (1)
	CreateDynamicObject(2165,1295.30004883,-1095.00000000,5971.20019531,0.00000000,0.00000000,180.00000000,0,0); //object(med_office_desk_1) (2)
	CreateDynamicObject(2166,1288.09960938,-1095.00000000,5971.20019531,0.00000000,0.00000000,90.00000000,0,0); //object(med_office_desk_2) (1)
	CreateDynamicObject(2174,1287.19995117,-1091.80004883,5971.20019531,0.00000000,0.00000000,90.00000000,0,0); //object(med_office4_desk_2) (1)
	CreateDynamicObject(1808,1286.89941406,-1088.89941406,5971.20019531,0.00000000,0.00000000,90.00000000,0,0); //object(cj_watercooler2) (1)
	CreateDynamicObject(2161,1295.80004883,-1088.69995117,5971.20019531,0.00000000,0.00000000,0.00000000,0,0); //object(med_office_unit_4) (3)
	CreateDynamicObject(2162,1297.15002441,-1088.69995117,5971.20019531,0.00000000,0.00000000,0.00000000,0,0); //object(med_office_unit_1) (2)
	CreateDynamicObject(16779,1293.69995117,-1092.09997559,5975.10009766,0.00000000,0.00000000,0.00000000,0,0); //object(ufo_light02) (1)
	CreateDynamicObject(2169,1299.50000000,-1092.59997559,5971.20019531,0.00000000,0.00000000,90.00000000,0,0); //object(med_office3_desk_1) (1)
	CreateDynamicObject(2894,1299.50000000,-1092.09997559,5972.00000000,0.00000000,0.00000000,301.00000000,0,0); //object(kmb_rhymesbook) (3)
	CreateDynamicObject(1667,1299.30004883,-1091.30004883,5972.10009766,0.00000000,0.00000000,15.00000000,0,0); //object(propwineglass1) (1)
	CreateDynamicObject(1714,1300.90002441,-1092.09997559,5971.20019531,0.00000000,0.00000000,272.75000000,0,0); //object(kb_swivelchair1) (2)
	CreateDynamicObject(2614,1301.40002441,-1092.00000000,5973.50000000,0.00000000,0.00000000,270.00000000,0,0); //object(cj_us_flag) (1)
	CreateDynamicObject(2986,1298.19995117,-1095.50000000,5974.00000000,90.00000000,0.00000000,0.00000000,0,0); //object(lxr_motelvent) (1)
	CreateDynamicObject(2202,1293.90002441,-1089.19995117,5971.20019531,0.00000000,0.00000000,0.00000000,0,0); //object(photocopier_2) (1)
	CreateDynamicObject(2765,1293.40002441,-1094.50000000,5972.89990234,0.00000000,90.00000000,270.00000000,0,0); //object(cj_cb_list1) (4)
	CreateDynamicObject(2765,1293.40002441,-1093.40002441,5972.89990234,0.00000000,90.00000000,270.00000000,0,0); //object(cj_cb_list1) (4)
	CreateDynamicObject(2765,1296.40002441,-1094.50000000,5972.89990234,0.00000000,90.00000000,269.99993896,0,0); //object(cj_cb_list1) (4)
	CreateDynamicObject(2765,1296.40002441,-1093.40002441,5972.89990234,0.00000000,90.00000000,270.00000000,0,0); //object(cj_cb_list1) (4)
	CreateDynamicObject(2765,1292.48999023,-1095.59997559,5972.89990234,0.00000000,90.00000000,89.99447632,0,0); //object(cj_cb_list1) (1)
	CreateDynamicObject(2765,1292.48999023,-1094.50000000,5972.89990234,0.00000000,90.00000000,89.99447632,0,0); //object(cj_cb_list1) (1)
	CreateDynamicObject(2765,1295.49597168,-1095.59997559,5972.89990234,0.00000000,90.00000000,89.99447632,0,0); //object(cj_cb_list1) (1)
	CreateDynamicObject(2765,1295.49597168,-1094.50000000,5972.89990234,0.00000000,90.00000000,89.99450684,0,0); //object(cj_cb_list1) (1)
	CreateDynamicObject(5040,1265.09997559,-1107.59997559,5974.39990234,0.00000000,0.00000000,0.00000000,0,0); //object(unionliq_las) (1)
	CreateDynamicObject(5040,1264.09997559,-1060.00000000,5974.39990234,0.00000000,0.00000000,180.00000000,0,0); //object(unionliq_las) (2)
	CreateDynamicObject(3944,1277.19995117,-1074.09997559,5970.50000000,0.00000000,0.00000000,90.00000000,0,0); //object(bistro_blok) (3)
	CreateDynamicObject(3944,1277.19995117,-1093.78002930,5974.95605469,0.00000000,180.00000000,90.00000000,0,0); //object(bistro_blok) (3)
	CreateDynamicObject(2765,1275.85998535,-1083.19995117,5973.12011719,0.00000000,90.00000000,89.99450684,0,0); //object(cj_cb_list1) (1)
	CreateDynamicObject(2765,1275.85998535,-1085.80004883,5973.12988281,0.00000000,90.00000000,89.99450684,0,0); //object(cj_cb_list1) (1)
	CreateDynamicObject(2765,1275.85998535,-1086.90002441,5973.12988281,0.00000000,90.00000000,89.99450684,0,0); //object(cj_cb_list1) (1)
	CreateDynamicObject(2765,1275.85998535,-1082.09997559,5973.12011719,0.00000000,90.00000000,89.99450684,0,0); //object(cj_cb_list1) (1)
	CreateDynamicObject(5040,1241.89941406,-1082.79980469,5974.39990234,0.00000000,0.00000000,270.00000000,0,0); //object(unionliq_las) (3)
	CreateDynamicObject(8710,1217.69995117,-1072.19995117,6003.79980469,0.00000000,90.00000000,0.00000000,0,0); //object(bnuhotel01_lvs) (1)
	CreateDynamicObject(2765,1275.85998535,-1083.19995117,5976.00000000,0.00000000,90.00000000,89.99450684,0,0); //object(cj_cb_list1) (1)
	CreateDynamicObject(2765,1275.85998535,-1082.09997559,5976.00000000,0.00000000,90.00000000,89.99450684,0,0); //object(cj_cb_list1) (1)
	CreateDynamicObject(2765,1275.85998535,-1085.80004883,5976.00000000,0.00000000,90.00000000,89.99450684,0,0); //object(cj_cb_list1) (1)
	CreateDynamicObject(2765,1275.85998535,-1086.90002441,5976.00000000,0.00000000,90.00000000,89.99450684,0,0); //object(cj_cb_list1) (1)
	CreateDynamicObject(3944,1277.19995117,-1090.09997559,5974.00000000,0.00000000,0.00000000,90.00000000,0,0); //object(bistro_blok) (3)
	CreateDynamicObject(1649,1276.30004883,-1083.90002441,5975.27001953,0.00000000,0.00000000,270.00000000,0,0); //object(wglasssmash) (3)
	CreateDynamicObject(1649,1276.30004883,-1083.90002441,5975.27001953,0.00000000,0.00000000,90.00000000,0,0); //object(wglasssmash) (3)
	CreateDynamicObject(2206,1265.59997559,-1083.19995117,5971.29980469,0.00000000,0.00000000,270.00000000,0,0); //object(med_office8_desk_02) (1)
	CreateDynamicObject(1714,1264.00000000,-1084.19995117,5971.29980469,0.00000000,0.00000000,90.00000000,0,0); //object(kb_swivelchair1) (3)
	CreateDynamicObject(2190,1265.80004883,-1084.30004883,5972.20019531,0.00000000,0.00000000,270.00000000,0,0); //object(pc_1) (2)
	CreateDynamicObject(2894,1265.59997559,-1085.00000000,5972.23486328,0.00000000,0.00000000,234.00000000,0,0); //object(kmb_rhymesbook) (4)
	CreateDynamicObject(2169,1262.19995117,-1086.19995117,5971.20019531,0.00000000,0.00000000,0.00000000,0,0); //object(med_office3_desk_1) (2)
	CreateDynamicObject(1667,1263.59997559,-1086.19995117,5972.10009766,0.00000000,0.00000000,0.00000000,0,0); //object(propwineglass1) (2)
	CreateDynamicObject(1667,1263.50000000,-1086.19995117,5972.10009766,0.00000000,0.00000000,0.00000000,0,0); //object(propwineglass1) (3)
	CreateDynamicObject(1667,1263.50000000,-1086.09997559,5972.10009766,0.00000000,0.00000000,0.00000000,0,0); //object(propwineglass1) (4)
	CreateDynamicObject(1667,1263.50000000,-1086.30004883,5972.10009766,0.00000000,0.00000000,0.00000000,0,0); //object(propwineglass1) (5)
	CreateDynamicObject(1668,1263.19995117,-1086.30004883,5972.18017578,0.00000000,0.00000000,0.00000000,0,0); //object(propvodkabotl1) (1)
	CreateDynamicObject(1668,1263.19995117,-1086.09997559,5972.18017578,0.00000000,0.00000000,0.00000000,0,0); //object(propvodkabotl1) (2)
	CreateDynamicObject(1669,1263.19995117,-1085.90002441,5972.18017578,0.00000000,0.00000000,0.00000000,0,0); //object(propwinebotl1) (1)
	CreateDynamicObject(1669,1263.40002441,-1085.90002441,5972.16015625,0.00000000,0.00000000,0.00000000,0,0); //object(propwinebotl1) (2)
	CreateDynamicObject(1792,1273.59997559,-1080.80004883,5972.89990234,0.00000000,0.00000000,0.00000000,0,0); //object(swank_tv_1) (1)
	CreateDynamicObject(1723,1274.69995117,-1085.80004883,5971.29980469,0.00000000,0.00000000,180.00000000,0,0); //object(mrk_seating1) (2)
	CreateDynamicObject(2164,1267.00000000,-1081.19995117,5971.29980469,0.00000000,0.00000000,0.00000000,0,0); //object(med_office_unit_5) (1)
	CreateDynamicObject(2161,1268.80004883,-1081.19995117,5971.29980469,0.00000000,0.00000000,0.00000000,0,0); //object(med_office_unit_4) (4)
	CreateDynamicObject(1825,1269.30004883,-1085.90002441,5971.29980469,0.00000000,0.00000000,25.50000000,0,0); //object(kb_table_chairs1) (1)
	CreateDynamicObject(8710,1260.59997559,-1095.69995117,6006.89990234,0.00000000,90.00000000,0.00000000,0,0); //object(bnuhotel01_lvs) (1)
	CreateDynamicObject(2248,1276.69995117,-1081.50000000,5971.79980469,0.00000000,0.00000000,0.00000000,0,0); //object(plant_pot_16) (2)
	CreateDynamicObject(2248,1276.69995117,-1086.19995117,5971.79980469,0.00000000,0.00000000,0.00000000,0,0); //object(plant_pot_16) (3)
	CreateDynamicObject(2248,1303.80004883,-1086.19995117,5971.79980469,0.00000000,0.00000000,0.00000000,0,0); //object(plant_pot_16) (4)
	CreateDynamicObject(2248,1303.80004883,-1081.50000000,5971.79980469,0.00000000,0.00000000,0.00000000,0,0); //object(plant_pot_16) (5)
	CreateDynamicObject(2270,1295.59960938,-1081.64257812,5973.89990234,0.00000000,0.00000000,0.00000000,0,0); //object(frame_wood_6) (4)
	CreateDynamicObject(2270,1280.89941406,-1081.64257812,5973.89990234,0.00000000,0.00000000,0.00000000,0,0); //object(frame_wood_6) (5)
	CreateDynamicObject(1723,1296.59997559,-1085.90002441,5971.20019531,0.00000000,0.00000000,179.99450684,0,0); //object(mrk_seating1) (3)
	CreateDynamicObject(1723,1281.89941406,-1085.79980469,5971.20019531,0.00000000,0.00000000,179.99450684,0,0); //object(mrk_seating1) (4)
	CreateDynamicObject(8710,1325.19995117,-1083.69995117,5941.39990234,0.00000000,270.00000000,0.00000000,0,0); //object(bnuhotel01_lvs) (1)
	CreateDynamicObject(2765,1288.69921875,-1087.56201172,5973.17675781,0.00000000,90.00000000,270.00000000,0,0); //object(cj_cb_list1) (4)
	CreateDynamicObject(2765,1289.30004883,-1088.69995117,5973.17675781,0.00000000,90.00000000,89.98901367,0,0); //object(cj_cb_list1) (1)
	CreateDynamicObject(2765,1287.80004883,-1088.65002441,5973.20019531,270.00000000,179.99450684,179.99450684,0,0); //object(cj_cb_list1) (5)
	CreateDynamicObject(4007,1293.00000000,-1057.00000000,5948.29980469,282.99682617,90.00000000,90.00000000,0,0); //object(wellsfargo1_lan) (1)
	CreateDynamicObject(1677,1261.00000000,-1085.59997559,5967.50000000,0.00000000,0.00000000,270.00000000,0,0); //object(wshxrefhse2) (1)
	CreateDynamicObject(1715,1297.69995117,-1093.80004883,5971.20019531,0.00000000,0.00000000,0.00000000,0,0); //object(kb_swivelchair2) (1)
	CreateDynamicObject(1715,1294.59997559,-1093.80004883,5971.20019531,0.00000000,0.00000000,0.00000000,0,0); //object(kb_swivelchair2) (1)
	CreateDynamicObject(1715,1288.59997559,-1091.30004883,5971.20019531,0.00000000,0.00000000,270.00000000,0,0); //object(kb_swivelchair2) (1)
	CreateDynamicObject(1715,1288.59997559,-1093.80004883,5971.20019531,0.00000000,0.00000000,270.00000000,0,0); //object(kb_swivelchair2) (1)
	CreateDynamicObject(1736,1263.40002441,-1084.19995117,5973.50000000,0.00000000,0.00000000,90.00000000,0,0); //object(cj_stags_head) (1)
	CreateDynamicObject(2270,1295.40002441,-1085.90002441,5973.89990234,0.00000000,0.00000000,180.00000000,0,0); //object(frame_wood_6) (4)
	CreateDynamicObject(2270,1280.80004883,-1085.90002441,5973.89990234,0.00000000,0.00000000,179.99450684,0,0); //object(frame_wood_6) (4)
	CreateDynamicObject(1533,1300.90002441,-1095.50000000,5971.20019531,0.00000000,0.00000000,180.00000000,0,0); //object(gen_doorext12) (2)


	//vica forelli g≥owne parking

	
	CreateDynamicObject(2765,1299.19921875,-989.09960938,37.70000076,90.00000000,179.99450684,179.99450684,0,0); //object(cj_cb_list1) (1)
    CreateDynamicObject(2765,1299.19921875,-988.00000000,37.70000076,90.00000000,179.99450684,179.99450684,0,0); //object(cj_cb_list1) (2)
    CreateDynamicObject(2765,1299.19921875,-986.89941406,37.70000076,90.00000000,179.99450684,179.99450684,0,0); //object(cj_cb_list1) (3)
    CreateDynamicObject(2765,1299.19921875,-985.79980469,37.70000076,90.00000000,180.00549316,179.98352051,0,0); //object(cj_cb_list1) (4)
    CreateDynamicObject(2765,1302.09960938,-989.09960938,37.70000076,90.00000000,180.00549316,179.98352051,0,0); //object(cj_cb_list1) (5)
    CreateDynamicObject(2765,1302.09960938,-988.00000000,37.70000076,90.00000000,179.99450684,179.99450684,0,0); //object(cj_cb_list1) (6)
    CreateDynamicObject(2765,1302.09960938,-986.89941406,37.70000076,90.00000000,179.99450684,179.99450684,0,0); //object(cj_cb_list1) (7)
    CreateDynamicObject(2765,1302.09960938,-985.79980469,37.70000076,90.00000000,179.99450684,179.99450684,0,0); //object(cj_cb_list1) (8)
    CreateDynamicObject(1533,1304.29980469,-986.59960938,37.29999924,0.00000000,0.00000000,270.00000000,0,0); //object(gen_doorext12) (1)
    CreateDynamicObject(1533,1304.30004883,-988.09997559,37.29999924,0.00000000,0.00000000,270.00000000,0,0); //object(gen_doorext12) (2)
    CreateDynamicObject(3850,1300.39941406,-990.19921875,37.79999924,0.00000000,0.00000000,90.00000000,0,0); //object(carshowbann_sfsx) (1)
    CreateDynamicObject(3850,1303.90002441,-990.20001221,37.79999924,0.00000000,0.00000000,90.00000000,0,0); //object(carshowbann_sfsx) (2)
    CreateDynamicObject(640,1301.69995117,-985.90002441,38.00000000,0.00000000,0.00000000,90.00000000,0,0); //object(kb_planter_bush2) (1)
    CreateDynamicObject(640,1304.00000000,-982.90002441,38.00000000,0.00000000,0.00000000,0.00000000,0,0); //object(kb_planter_bush2) (2)
    CreateDynamicObject(640,1304.00000000,-977.59997559,38.00000000,0.00000000,0.00000000,0.00000000,0,0); //object(kb_planter_bush2) (3)
    CreateDynamicObject(640,1304.00000000,-972.20001221,38.00000000,0.00000000,0.00000000,0.00000000,0,0); //object(kb_planter_bush2) (4)
    CreateDynamicObject(640,1304.00000000,-967.00000000,38.00000000,0.00000000,0.00000000,0.00000000,0,0); //object(kb_planter_bush2) (5)
    CreateDynamicObject(2957,1302.30004883,-990.29998779,35.70000076,0.00000000,0.00000000,0.00000000,0,0); //object(chinatgaragedoor) (1)
    CreateDynamicObject(1696,1281.00000000,-998.70001221,36.29999924,0.00000000,0.00000000,270.00000000,0,0); //object(roofstuff15) (1)
    CreateDynamicObject(1696,1281.00000000,-993.21997070,36.29999924,0.00000000,0.00000000,270.00000000,0,0); //object(roofstuff15) (2)
    CreateDynamicObject(1696,1275.19995117,-998.70001221,34.29999924,0.00000000,0.00000000,270.00000000,0,0); //object(roofstuff15) (4)
    CreateDynamicObject(1696,1275.19995117,-993.21997070,34.29999924,0.00000000,0.00000000,270.00000000,0,0); //object(roofstuff15) (5)
    CreateDynamicObject(3850,1278.19995117,-990.90002441,36.09999847,340.00000000,0.00000000,90.00000000,0,0); //object(carshowbann_sfsx) (1)
    CreateDynamicObject(3850,1281.50000000,-990.90002441,37.29999924,339.99938965,0.00000000,90.00000000,0,0); //object(carshowbann_sfsx) (1)
    CreateDynamicObject(2745,1273.59997559,-1001.90002441,35.00000000,0.00000000,0.00000000,0.00000000,0,0); //object(cj_stat_3) (1)
    CreateDynamicObject(2745,1273.09997559,-985.90002441,36.40000153,0.00000000,0.00000000,180.00000000,0,0); //object(cj_stat_3) (2)
    CreateDynamicObject(2745,1296.89941406,-990.79980469,38.59999847,0.00000000,0.00000000,270.00000000,0,0); //object(cj_stat_3) (3)
    CreateDynamicObject(2745,1296.89941406,-985.39941406,38.59999847,0.00000000,0.00000000,270.00000000,0,0); //object(cj_stat_3) (4)
    CreateDynamicObject(9833,1281.59997559,-1004.20001221,39.90000153,0.00000000,0.00000000,0.00000000,0,0); //object(fountain_sfw) (1)
    CreateDynamicObject(1251,1293.59997559,-1002.79998779,37.29999924,0.00000000,0.00000000,0.00000000,0,0); //object(smashbar) (1)
    CreateDynamicObject(1251,1290.50000000,-1002.79998779,37.29999924,0.00000000,0.00000000,0.00000000,0,0); //object(smashbar) (2)
    CreateDynamicObject(1251,1287.90002441,-1002.79998779,37.29999924,0.00000000,0.00000000,0.00000000,0,0); //object(smashbar) (3)
    CreateDynamicObject(1251,1285.40002441,-1002.79998779,37.29999924,0.00000000,0.00000000,0.00000000,0,0); //object(smashbar) (4)
    CreateDynamicObject(1251,1279.00000000,-984.20001221,37.29999924,0.00000000,0.00000000,90.00000000,0,0); //object(smashbar) (6)
    CreateDynamicObject(1251,1279.00000000,-981.20001221,37.29999924,0.00000000,0.00000000,90.00000000,0,0); //object(smashbar) (7)
    CreateDynamicObject(1251,1279.00000000,-978.40002441,37.29999924,0.00000000,0.00000000,90.00000000,0,0); //object(smashbar) (8)
    CreateDynamicObject(1251,1279.00000000,-975.59997559,37.29999924,0.00000000,0.00000000,90.00000000,0,0); //object(smashbar) (9)
    CreateDynamicObject(1251,1279.00000000,-973.09997559,37.29999924,0.00000000,0.00000000,90.00000000,0,0); //object(smashbar) (11)
    CreateDynamicObject(1251,1282.40002441,-969.79998779,37.29999924,0.00000000,0.00000000,0.00000000,0,0); //object(smashbar) (10)
    CreateDynamicObject(1251,1285.09960938,-969.79980469,37.29999924,0.00000000,0.00000000,0.00000000,0,0); //object(smashbar) (12)
    CreateDynamicObject(1251,1287.89941406,-969.79980469,37.29999924,0.00000000,0.00000000,0.00000000,0,0); //object(smashbar) (13)
    CreateDynamicObject(1251,1291.00000000,-969.79980469,37.29999924,0.00000000,0.00000000,0.00000000,0,0); //object(smashbar) (14)
    CreateDynamicObject(1251,1292.30004883,-969.50000000,37.29999924,0.00000000,0.00000000,0.00000000,0,0); //object(smashbar) (15)
    CreateDynamicObject(10671,1278.59997559,-990.79998779,33.70000076,340.00000000,0.00000000,90.00000000,0,0); //object(savehousegdoor_sfs) (1)
    CreateDynamicObject(1533,1285.00000000,-982.59997559,31.70000076,0.00000000,0.00000000,90.00000000,0,0); //object(gen_doorext12) (1)

	CreateDynamicObject(2955, 2324.40, -1263.73, 22.68, 0.00, 0.00, 0.00,0,0);//Drzwi NoA

    //Stacja paliw  idlewood
    CreateDynamicObject(970, 1942.25049, -1778.34497, 13.13570,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(970, 1942.25049, -1767.48206, 13.13570,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(970, 1942.25049, -1774.24731, 13.13570,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(970, 1942.25049, -1770.70447, 13.13570,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(970, 1941.08252, -1778.34497, 13.13570,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(970, 1941.08252, -1774.24731, 13.13570,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(970, 1941.08252, -1770.70447, 13.13570,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(970, 1941.08252, -1767.48206, 13.13570,   0.00000, 0.00000, 90.00000);
    new idleid = CreateDynamicObject(5489, 1932.59778, -1782.09766, 12.50400,   0.00000, 0.00000, 0.00000); //change
    SetDynamicObjectMaterial(idleid, 3,  9829, "hrbr_sfw", "fancy_slab128");
    SetDynamicObjectMaterial(idleid, 4, 4029, "lanriver", "ws_hextile");
    idleid = CreateDynamicObject(5397, 1866.33215, -1789.78528, 20.94930,   0.00000, 0.00000, 0.00000); //change
    SetDynamicObjectMaterial(idleid, 6, 4029, "lanriver", "ws_hextile");
    SetDynamicObjectMaterial(idleid, 4, 4029, "lanriver", "ws_hextile");
	return 1;
}

//EOF
