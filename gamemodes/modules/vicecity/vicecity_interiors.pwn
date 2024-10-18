new VC_interiors[][E_ENEX] = {
    // {6, 3934.790283, -1232.615600, 997.025573, 0, 3937.608886, -1232.439208, 5.992897}, // Fabryka papieru, zbugowany interior
    // {6, 3832.205322, -1581.477539, 1000.401489, 0, 3832.457275, -1583.457153, 5.573801}, // Restauracja Cafe Robina, tylne wejœcie
    // {6, 3830.150146, -1559.090820, 1000.401489, 0, 5024.732421, -2309.478027, 4.420621}, // Domek, z³e wnêtrze
    // {6, 3832.205322, -1581.477539, 1000.401489, 0, 5428.371582, -344.615020, 6.659524}, // Villa z basenem pierwsze miasto, z³e wnêtrze
    {6, -3895.7812, 2137.6965, 1048.250000, 0, -4173.3071, 920.0850, 6.993324}, // Domek z pi³¹ mechaniczn¹
    {6, -3842.1997, 3374.9348, 1212.843017, 0, -3850.4785, 3373.9413, 12.077051}, // North Point Mall
    {6, -3820.1240, 3499.0170, 1213.097900, 0, -3821.2710, 3507.4120, 12.369453}, // North Point Mall
    {6, -3751.8350, 3498.7054, 1213.097900, 0, -3750.6143, 3506.8355, 12.369453}, // North Point Mall
    {6, -3829.2144, 3459.9540, 1219.599365, 0, -3835.4297, 3459.7775, 19.089639}, // North Point Mall
    {6, -3820.2139, 3253.0800, 1213.145263, 0, -3820.8535, 3244.1764, 12.290441}, // North Point Mall
    {6, -3751.5020, 3254.1497, 1214.102050, 0, -3749.9907, 3245.3864, 12.197931}, // North Point Mall
    {0, -4751.7295, 3038.0670, 91.519332, 0, -4757.4360, 3032.2449, 16.818687}, // Winda w biurowcu prawników (exterior)
    {0, -4610.4600, 3371.2569, 5.147912, 0, -4650.7520, 3377.9206, 50.723594}, // Winda na dach San News
    {0, -5030.8975, 3562.5805, 5.570487, 0, -5011.7222, 3604.2379, 60.486289}, // Winda na dach domku zapisowego Downtown
    {6, -5139.1062, 1898.2250, 987.381835, 6, -5137.9456, 1898.5248, 998.004333}, // Winda do skarbca w banku
    {0, -3724.2134, 2280.4315, 6.093046, 0, -3745.4551, 2280.2535, 28.957324}, // Villa z basenem obok Malibu (exterior)
    {0, -4328.0396, 1186.8854, 8.069411, 0, -4331.8359, 1190.1024, 77.299461}, // Wejœcie na dach budynku obok Corteza
    {0, -4154.6626, 1313.1621, 18.558944, 0, -4155.5322, 1308.9994, 4.554121}, // Schody nr 1 w centrum handlowym
    {0, -4237.6255, 1313.1930, 18.558944, 0, -4236.5581, 1308.9592, 4.554121} // Schody nr 2 w centrum handlowym
};

AddInterior(outName[], Float:outX, Float:outY, Float:outZ, outInt, outVw, inName[], Float:inX, Float:inY, Float:inZ, inInt, inVw, wejdzUID=0, playerLocal=255, bool:specialCome=false)
{
    return DodajWejscie(outX, outY, outZ, inX, inY, inZ, outVw, outInt, inVw, inInt, outName, inName,
        wejdzUID, playerLocal, specialCome);
}

ViceCityInteriors()
{
    new VCVW = 7110; // vice city standard interiors virtual world
    new iconType = MAPICON_GLOBAL;
    new Float:streamDist = 2000.0;

    // ------ [ Rz¹d ] ------
    AddInterior( // Ratusz Downtown, Interior Planning Department (DMV GF)
        "Ratusz", -4897.7461, 2953.5726, 6.5759, 0, 0,
        "Wyjœcie", 386.52, 173.63, 1008.38, 3, VCVW);
    MruCreateDynamicMapIcon(-4897.7461, 2953.5726, 6.5759, 34, -1, -1, -1, -1, streamDist, iconType); // Ratusz

    // ------ [ Komisariaty ] ------
    AddInterior( // Komisariat 1 Miasto, Interior San Fierro Police Department
        "Komisariat", -3802.7534, 1777.8750, 6.5215, 0, 0,
        "Wyjœcie", 246.06, 108.97, 1003.21, 10, VCVW);
    AddInterior( // Komisariat 1 Miasto, Interior San Fierro Police Department - Tylne wejœcie
        "Komisariat", -3802.7534, 1777.8750, 6.5215, 0, 0,
        "Wyjœcie", 246.06, 108.97, 1003.21, 10, VCVW);
    MruCreateDynamicMapIcon(-3802.7534, 1777.8750,6.5215, 30, -1, -1, -1, -1, streamDist, iconType);

    AddInterior( // Komisariat £owców nagród, Interior Los Santos Police Department
        "Biuro £owców Nagród", -5072.1455, 1566.6052, 5.6903, 0, 0,
        "Wyjœcie", 246.66, 65.80, 1003.64, 6, VCVW);
    MruCreateDynamicMapIcon(-5072.1455, 1566.6052, 5.6903, 16, -1, -1, -1, -1, streamDist, iconType);

    AddInterior( // Komisariat Downtown (FBI), Interior Las Venturas Police Department
        "Biuro FBI", -4857.0996, 3012.5998, 6.0599, 0, 0,
        "Wyjœcie", 288.47, 170.06, 1007.17, 3, VCVW);
    AddInterior( // Komisariat Downtown (FBI), Interior Las Venturas Police Department - Tylne wyjœcie
        "Biuro FBI - Tylne wejœcie", -4803.4712,3029.7275,6.0562, 0, 0,
        "Wyjœcie", 238.6436,139.6419,1003.0234, 3, VCVW);
    MruCreateDynamicMapIcon(-4857.0322, 3012.5569, 6.0599, 30, -1, -1, -1, -1, streamDist, iconType);

    AddInterior( // Baza Wojskowa, Ammu-nation 5
        "Biuro Armii", -5921.1716, 2093.6060, 9.3275, 0, 0,
        "Wyjœcie", 316.50, -167.62, 999.59, 6, VCVW);
    MruCreateDynamicMapIcon(-5921.1716, 2093.6060, 9.3275, 19, -1, -1, -1, -1, streamDist, iconType);

    // ------ [ Szpitale ] ------
    AddInterior( // Ocean Beach Hospital
        "Szpital", -4338.2310, 1268.1736, 4.9212, 0, 0,
        "Wyjœcie", 1390.5581, -26.4880, 1000.9105, 3, 7110);
    MruCreateDynamicMapIcon(-4338.2310, 1268.1736, 4.9212, 22, -1, -1, -1, -1, streamDist, iconType);

    AddInterior( // Vice Point Hospital
        "Szpital", -3702.2754, 2952.8380, 6.5608, 0, 0,
        "Wyjœcie", 1390.5581, -26.4880, 1000.9105, 3, 7111);
    MruCreateDynamicMapIcon(-3702.2754, 2952.8380, 6.5608, 22, -1, -1, -1, -1, streamDist, iconType);

    AddInterior( // Downtown Hospital
        "Szpital", -5023.0557, 3399.7706, 6.8687, 0, 0,
        "Wyjœcie", 1390.5581, -26.4880, 1000.9105, 3, 7112);
    MruCreateDynamicMapIcon(-5023.0557, 3399.7706, 6.8687, 22, -1, -1, -1, -1, streamDist, iconType);

    AddInterior( // Szpital Œrodek drugiego miasta
        "Szpital", -5086.7944, 1779.5925, 7.5683, 0, 0,
        "Wyjœcie", 1390.5581, -26.4880, 1000.9105, 3, 7113);
    MruCreateDynamicMapIcon(-5087.2378, 1779.6316, 7.5683, 22, -1, -1, -1, -1, streamDist, iconType); // Szpital


    // ------ [ Bank ] ------
    AddInterior(
        "Bank", -5095.3579, 1908.7921, 7.8773, 0, 0,
        "Wyjœcie", -5100.0000, 1908.8900, 994.0, 6, VCVW, // interior banku z internetu: 1387.3058,-26.9497,1000.8729
        0, 103);
    MruCreateDynamicMapIcon(-5095.3579, 1908.7921, 7.8773, 52, -1, -1, -1, -1, streamDist, iconType); // Bank Vice City


    // ------ [ Inne ] ------
    AddInterior( // hotel z basenem obok pizza washington beach
        "Wejœcie", -3668.2158, 2131.0736, 7.7963, 0, 0,
        "Wyjœcie", -3668.1479, 2113.0822, 30.8695, 0, 0);

    AddInterior( // Si³ownia
        "Si³ownia", -5314.5696, 1553.3948, 6.2530, 0, 0,
        "Wyjœcie", 773.73, -74.69, 1000.65, 7, 0);

    // AddInterior(
    //     "Wejœcie", XYZ, int, vw, // pozycja po /wyjdz
    //     "Wyjœcie", XYZ, int, vw); // pozycja po /wejdz


    // Add vice city interiors from Vice City Map
    for(new i = 0, k = sizeof(VC_interiors); i < k; i++)
    {
        AddInterior(
            sprintf("Wejœcie %d", i), VC_interiors[i][enexX2], VC_interiors[i][enexY2], VC_interiors[i][enexZ2] + 0.5, VC_interiors[i][enexInt2], 0,
            sprintf("Wyjœcie %d", i), VC_interiors[i][enexX1], VC_interiors[i][enexY1], VC_interiors[i][enexZ1] + 0.5, VC_interiors[i][enexInt1], 0
        );
    }
}

ViceCityGates()
{
    // FBI bramy do wiêzieñ, interior komisariatu LV
    DodajBrame(968, 
        209.142471, 180.683502, 1004.601684, 0.000000, 0.000000, 0.000000, // open
        209.127639, 179.046417, 1004.591735, 0.000000, 0.000000, 0.000000, // closed
         1.0, 5.0, 1, 2);
    DodajBrame(968, 
        209.134201, 159.911682, 1004.583679, 0.000000, 0.000000, 0.000000, // open
        209.145187, 158.192550, 1004.590576, 0.000000, 0.000000, 0.000000, // closed
         1.0, 5.0, 1, 2);

    // NG base gate
    DodajBrame(968, 
        -5922.489257, 1957.911376, 9.327517, 0.000000, 0.370376, -0.009465, // closed
        -5924.960937, 1956.847900, 9.327548, 0.000000, 13.199999, 0.000000, // open
         0.1, 15.0, 1, 3);
}

ViceCityAdditionalObjects()
{
    // Wêdki na molo
    CreateDynamicObject(18632, -5005.314941, 1928.301879, 1.831475, 0.000000, 132.699813, -95.999946, 0, 0); // 
    CreateDynamicObject(18632, -5002.642089, 1924.755859, 1.846351, 0.000000, -44.199977, 11.800019, 0, 0); // 
    CreateDynamicObject(18632, -5002.605957, 1917.961181, 1.825904, 0.000000, -59.600204, -5.900003, 0, 0); // 
    CreateDynamicObject(18632, -5002.551269, 1910.996948, 1.839071, 0.000000, -58.099975, 4.499995, 0, 0); // 
    CreateDynamicObject(18632, -5002.376953, 1903.742919, 1.810747, 0.000000, -62.000015, -1.999924, 0, 0); // 
    CreateDynamicObject(18632, -5002.381835, 1896.991699, 1.811476, 0.000000, -62.000000, -1.999899, 0, 0); // 
    CreateDynamicObject(18632, -5002.285644, 1890.164428, 1.824781, 0.000000, -62.000000, -1.999899, 0, 0); // 
    CreateDynamicObject(18632, -5005.778320, 1886.935546, 1.905731, 0.000000, -57.199974, -103.299957, 0, 0); // 
    CreateDynamicObject(18632, -4573.683593, 2028.193725, 2.686140, 0.000000, 142.000274, -81.700004, 0, 0); // 
    CreateDynamicObject(18632, -3953.458007, 2545.846191, 2.583276, 0.000000, 123.199966, 57.599987, 0, 0); // 
    CreateDynamicObject(18632, -3956.103515, 2546.998535, 2.407925, 0.000000, 123.199897, 57.599899, 0, 0); // 
    CreateDynamicObject(18632, -3950.623779, 2552.627441, 2.654365, 0.000000, -54.700298, 60.899803, 0, 0); // 
    CreateDynamicObject(18632, -3952.902587, 2553.484375, 2.381979, 0.000000, -54.700199, 60.899799, 0, 0); // 
    CreateDynamicObject(18632, -3954.486572, 2552.611572, 1.749744, 0.000000, -61.100177, 148.099716, 0, 0); // 
    CreateDynamicObject(18632, -3956.051513, 2548.870361, 1.813331, 0.000000, -61.100101, 148.099700, 0, 0); // 
    CreateDynamicObject(18632, -3862.843994, 2824.273437, 3.353658, 0.000000, -60.100040, 101.700012, 0, 0); // 
    CreateDynamicObject(18632, -3865.256103, 2824.185546, 2.905717, 0.000000, -60.099998, 101.699996, 0, 0); // 
    CreateDynamicObject(18632, -3862.580078, 2816.789550, 3.577418, 0.000000, -58.100120, -94.800003, 0, 0); // 
    CreateDynamicObject(18632, -3865.555664, 2816.622314, 2.923991, 0.000000, -58.100101, -94.800003, 0, 0); // 
    CreateDynamicObject(18632, -3866.792968, 2817.701171, 1.918685, 0.000000, -48.799842, -178.699890, 0, 0); // 
    CreateDynamicObject(18632, -3866.351074, 2823.047607, 1.993808, 0.000000, -48.799800, -178.699798, 0, 0); // 
    CreateDynamicObject(18632, -3877.325195, 550.881103, 3.528148, 0.000000, 117.499992, -94.300071, 0, 0); // 
    CreateDynamicObject(18632, -3886.370117, 550.593811, 3.551032, 0.000000, 117.499900, -94.300003, 0, 0); // 
    CreateDynamicObject(18632, -3880.750000, 546.422790, 3.574229, 0.000000, -62.599987, -89.200050, 0, 0); // 
    CreateDynamicObject(18632, -3886.184814, 546.219787, 3.572278, 0.000000, 121.599975, 96.300018, 0, 0); // 
    CreateDynamicObject(18632, -3891.696289, 550.400756, 3.592147, 0.000000, 115.399940, -87.800010, 0, 0); // 
    CreateDynamicObject(18632, -3894.657470, 545.999755, 3.595981, 0.000000, 109.400009, 106.700019, 0, 0); // 
    CreateDynamicObject(18632, -3900.114746, 550.281066, 3.573229, 0.000000, 121.799957, -87.900062, 0, 0); // 
    CreateDynamicObject(18632, -3902.621093, 545.873901, 3.525425, 0.000000, 106.500022, 93.399993, 0, 0); // 
    CreateDynamicObject(18632, -3908.373046, 550.189575, 3.512947, 0.000000, 114.299942, -83.599822, 0, 0); // 
    CreateDynamicObject(18632, -3913.562011, 545.746765, 3.511688, 0.000000, 128.400009, 92.800086, 0, 0); // 
    CreateDynamicObject(18632, -3919.358398, 550.065612, 3.544980, 0.000000, 112.099952, -93.299835, 0, 0); // 
    CreateDynamicObject(18632, -3924.547119, 545.720397, 3.573942, 0.000000, 122.199996, 90.700042, 0, 0); // 
    CreateDynamicObject(18632, -3930.624023, 549.983886, 3.573483, 0.000000, 120.300018, -87.299957, 0, 0); // 
    CreateDynamicObject(18632, -3872.498535, 547.295043, 3.601641, 0.000000, 120.199989, 95.199996, 0, 0); // 

    // Obiekty stacji benzynowej przy mechach
    CreateDynamicObject(1676, -5174.161621, 1384.292846, 8.073135, 0.000000, 0.000000, -40.013149, 0, 0); // 
    CreateDynamicObject(1676, -5181.365722, 1390.772949, 6.635695, 0.000000, 0.000000, 336.933776, 0, 0); // dystrybutor do stacja2
    CreateDynamicObject(1211, -5733.719726, 1457.479980, 8.770298, 0.000000, 0.000000, -46.500022, 0, 0); // 
    CreateDynamicObject(19836, -5208.281738, 1353.104248, 6.349887, 0.000000, 0.000000, 263.482482, 0, 0); // krul mechow
    CreateDynamicObject(10282, -5190.334960, 1356.503051, 6.510725, 0.000000, 0.000000, -24.820432, 0, 0); // 
    CreateDynamicObject(10282, -5211.518554, 1404.540893, 6.545200, 0.000000, 0.000000, 98.976737, 0, 0); // stacje2
    CreateDynamicObject(10282, -5207.295898, 1395.431030, 6.545200, 0.000000, 0.000000, 115.270233, 0, 0); // stacje2
    CreateDynamicObject(10282, -5201.802246, 1387.669677, 6.545200, 0.000000, 0.000000, 137.203765, 0, 0); // stacje2
    CreateDynamicObject(10282, -5195.728027, 1403.699096, 6.545200, 0.000000, 0.000000, 353.382446, 0, 0); // stacje2
    CreateDynamicObject(1676, -5179.400390, 1388.822509, 8.120162, 0.000000, 0.000000, -40.786441, 0, 0); // 
    CreateDynamicObject(1676, -5176.128906, 1386.160156, 8.090709, 0.000000, 0.000000, -38.786560, 0, 0); // 
    CreateDynamicObject(14467, -5207.322265, 1353.718872, 9.039885, 0.000000, 0.000000, 268.416259, 0, 0); // 
    CreateDynamicObject(19836, -5209.291503, 1353.712524, 6.349887, 0.000000, 0.000000, 285.729339, 0, 0); // krul mechow
    CreateDynamicObject(19836, -5207.050781, 1355.926147, 6.349887, 0.000000, 0.000000, 303.902862, 0, 0); // krul mechow
    CreateDynamicObject(19836, -5207.088378, 1355.870117, 6.349887, 0.000000, 0.000000, 303.902862, 0, 0); // krul mechow
    CreateDynamicObject(19836, -5208.615234, 1354.331054, 6.349887, 0.000000, 0.000000, 293.876068, 0, 0); // krul mechow
    CreateDynamicObject(19836, -5209.072753, 1355.023315, 6.349887, 0.000000, 0.000000, 301.396148, 0, 0); // krul mechow
    CreateDynamicObject(19836, -5210.206054, 1355.251342, 6.349887, 0.000000, 0.000000, 324.896362, 0, 0); // krul mechow
    CreateDynamicObject(19836, -5211.170898, 1354.987060, 6.349887, 0.000000, 0.000000, 3.750088, 0, 0); // krul mechow
    CreateDynamicObject(19836, -5211.715820, 1354.695312, 6.349887, 0.000000, 0.000000, 33.830356, 0, 0); // krul mechow
    CreateDynamicObject(19836, -5212.280273, 1356.442626, 6.349887, 0.000000, 0.000000, 29.443643, 0, 0); // krul mechow
    CreateDynamicObject(19836, -5205.579101, 1365.415405, 6.357654, 0.000000, 0.000000, 339.623168, 0, 0); // krul mechow
    CreateDynamicObject(19836, -5207.783691, 1356.299804, 6.349887, 0.000000, 0.000000, 315.182952, 0, 0); // krul mechow
    CreateDynamicObject(19836, -5209.405761, 1354.593261, 6.349887, 0.000000, 0.000000, 307.662872, 0, 0); // krul mechow
    CreateDynamicObject(19836, -5209.748535, 1354.475463, 6.349887, 0.000000, 0.000000, 311.422912, 0, 0); // krul mechow
    CreateDynamicObject(19836, -5209.846679, 1353.610351, 6.349887, 0.000000, 0.000000, 292.936065, 0, 0); // krul mechow
    CreateDynamicObject(19836, -5210.259277, 1352.807373, 6.349887, 0.000000, 0.000000, 255.962387, 0, 0); // krul mechow
    CreateDynamicObject(19836, -5210.188476, 1352.125366, 6.349887, 0.000000, 0.000000, 241.235565, 0, 0); // krul mechow
    CreateDynamicObject(19836, -5209.297851, 1349.539184, 6.349887, 0.000000, 0.000000, 212.721954, 0, 0); // krul mechow
    CreateDynamicObject(19836, -5206.918945, 1349.521484, 6.349887, 0.000000, 0.000000, 227.762100, 0, 0); // krul mechow
    CreateDynamicObject(19836, -5207.833007, 1353.261108, 6.779627, 0.000000, 0.000000, 255.962387, 0, 0); // krul mechow
    CreateDynamicObject(19836, -5207.825195, 1353.543090, 6.749790, 0.000000, 0.000000, 275.702545, 0, 0); // krul mechow
    CreateDynamicObject(19836, -5207.823730, 1353.597534, 6.784367, 0.000000, 0.000000, 275.702545, 0, 0); // krul mechow
    CreateDynamicObject(19836, -5206.770507, 1351.552856, 6.349887, 0.000000, 0.000000, 295.185516, 0, 0); // krul mechow
    CreateDynamicObject(19836, -5208.749511, 1351.419067, 6.349887, 0.000000, 0.000000, 299.572235, 0, 0); // krul mechow
    CreateDynamicObject(19836, -5209.775390, 1351.413696, 6.349887, 0.000000, 0.000000, 319.312408, 0, 0); // krul mechow
}