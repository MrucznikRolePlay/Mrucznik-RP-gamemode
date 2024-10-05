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
    MruCreateDynamicMapIcon(-3802.7534, 1777.8750,6.5215, 30, -1, -1, -1, -1, streamDist, iconType);

    AddInterior( // Komisariat £owców nagród, Interior Los Santos Police Department
        "Biuro £owców Nagród", -5072.1455, 1566.6052, 5.6903, 0, 0,
        "Wyjœcie", 246.66, 65.80, 1003.64, 6, VCVW);
    MruCreateDynamicMapIcon(-5072.1455, 1566.6052, 5.6903, 16, -1, -1, -1, -1, streamDist, iconType);

    AddInterior( // Komisariat Downtown (FBI), Interior Las Venturas Police Department
        "Biuro FBI", -4857.0996, 3012.5998, 6.0599, 0, 0,
        "Wyjœcie", 288.47, 170.06, 1007.17, 3, VCVW);
    MruCreateDynamicMapIcon(-4857.0322, 3012.5569, 6.0599, 30, -1, -1, -1, -1, streamDist, iconType);

    AddInterior( // Baza Wojskowa, Ammu-nation 5
        "Biuro Armii", -5921.1716, 2093.6060, 9.3275, 0, 0,
        "Wyjœcie", 316.50, -167.62, 999.59, 6, VCVW);
    MruCreateDynamicMapIcon(-5921.1716, 2093.6060, 9.3275, 19, -1, -1, -1, -1, streamDist, iconType);

    // ------ [ Szpitale ] ------
    AddInterior( // Ocean Beach Hospital
        "Szpital", -4338.2310, 1268.1736, 4.9212, 0, 0,
        "Wyjœcie", 1414.5581, -26.4880, 1000.9105, 3, 7110);
    MruCreateDynamicMapIcon(-4338.2310, 1268.1736, 4.9212, 22, -1, -1, -1, -1, streamDist, iconType);

    AddInterior( // Vice Point Hospital
        "Szpital", -3702.2754, 2952.8380, 6.5608, 0, 0,
        "Wyjœcie", 1414.5581, -26.4880, 1000.9105, 3, 7111);
    MruCreateDynamicMapIcon(-3702.2754, 2952.8380, 6.5608, 22, -1, -1, -1, -1, streamDist, iconType);

    AddInterior( // Downtown Hospital
        "Szpital", -5023.0557, 3399.7706, 6.8687, 0, 0,
        "Wyjœcie", 1414.5581, -26.4880, 1000.9105, 3, 7112);
    MruCreateDynamicMapIcon(-5023.0557, 3399.7706, 6.8687, 22, -1, -1, -1, -1, streamDist, iconType);

    AddInterior( // Szpital Œrodek drugiego miasta
        "Szpital", -5086.7944, 1779.5925, 7.5683, 0, 0,
        "Wyjœcie", 1414.5581, -26.4880, 1000.9105, 3, 7113);
    MruCreateDynamicMapIcon(-5087.2378, 1779.6316, 7.5683, 22, -1, -1, -1, -1, streamDist, iconType); // Szpital


    // ------ [ Bank ] ------
    AddInterior(
        "Bank", -5095.3579, 1908.7921, 7.8773, 0, 0,
        "Wyjœcie", -5100.0000, 1908.8900, 994.0, 6, 0, // interior banku z internetu: 1387.3058,-26.9497,1000.8729
        0, 103);
    MruCreateDynamicMapIcon(-5095.3579, 1908.7921, 7.8773, 52, -1, -1, -1, -1, streamDist, iconType); // Bank Vice City


    // ------ [ Inne ] ------
    AddInterior( // hotel z basenem obok pizza washington beach
        "Wejœcie", -3668.2158, 2131.0736, 7.7963, 0, 0,
        "Wyjœcie", -3668.1479, 2113.0822, 30.8695, 0, 0);


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