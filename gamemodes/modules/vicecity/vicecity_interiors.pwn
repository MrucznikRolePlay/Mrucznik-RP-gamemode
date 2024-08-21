new VC_interiors[][E_ENEX] = {
    // {6, 3934.790283, -1232.615600, 1002.025573, 0, 3937.608886, -1232.439208, 10.492897}, // Fabryka papieru, zbugowany interior
    {6, 3830.150146, -1559.090820, 1005.401489, 0, 3829.733886, -1557.256713, 10.073801}, // Restauracja Cafe Robina, g³ówne wejœcie
    // {6, 3832.205322, -1581.477539, 1005.401489, 0, 3832.457275, -1583.457153, 10.073801}, // Restauracja Cafe Robina, tylne wejœcie
    // {6, 3830.150146, -1559.090820, 1005.401489, 0, 5024.732421, -2309.478027, 8.920621}, // Domek, z³e wnêtrze
    // {6, 3832.205322, -1581.477539, 1005.401489, 0, 5428.371582, -344.615020, 11.159524}, // Villa z basenem pierwsze miasto, z³e wnêtrze
    {6, 4033.094238, -1645.181884, 998.463928, 0, 4031.399902, -1637.788330, 9.799711}, // Sklep z narzêdziami
    {6, 4033.094238, -1645.181884, 998.463928, 0, 5532.618164, -180.268325, 9.652462}, // Burger Shot
    {6, 5304.218750, -1062.303466, 1052.750000, 0, 5026.692871, -2279.915039, 11.493324}, // Domek z pi³¹ mechaniczn¹
    {6, 5488.395507, -1026.718627, 1002.500000, 0, 5491.511230, -1027.829467, 10.055270}, // Malibu Club
    {6, 5488.395507, -1026.718627, 1002.500000, 0, 5489.314941, -1029.859130, 10.055270}, // Malibu Club
    {6, 5096.011718, -2404.743408, 1002.000000, 0, 5096.764648, -2420.861572, 8.846032}, // Pole Postion Club
    {6, 5357.800292, 174.934799, 1217.343017, 0, 5349.521484, 173.941299, 16.577051}, // North Point Mall
    {6, 5379.875976, 299.017028, 1217.597900, 0, 5378.729003, 307.412017, 16.869453}, // North Point Mall
    {6, 5448.165039, 298.705444, 1217.597900, 0, 5449.385742, 306.835540, 16.869453}, // North Point Mall
    {6, 5370.785644, 259.954010, 1224.099365, 0, 5364.570312, 259.777496, 23.589639}, // North Point Mall
    {6, 5379.786132, 53.080009, 1217.645263, 0, 5379.146484, 44.176437, 16.790441}, // North Point Mall
    {6, 5448.498046, 54.149711, 1217.602050, 0, 5450.009277, 45.386402, 16.697931}, // North Point Mall
    {6, 4402.812500, -299.663452, 1000.150878, 0, 4124.1523, 209.3812, 10.6841}, // Bar Love Fist w VCTR
    {0, 4448.270507, -161.933013, 96.019332, 0, 4442.563964, -167.755050, 21.318687}, // Winda w biurowcu prawników (exterior)
    {0, 4589.540039, 171.256866, 9.647912, 0, 4549.248046, 177.920639, 55.223594}, // Winda na dach San News
    {0, 4169.102539, 362.580505, 10.070487, 0, 4188.277832, 404.237854, 64.986289}, // Winda na dach domku zapisowego Downtown
    {6, 4060.893798, -1301.775024, 991.881835, 6, 4062.054443, -1301.475219, 1002.504333}, // Winda do skarbca w banku
    {0, 5475.786621, -919.568481, 10.593046, 0, 5454.544921, -919.746459, 33.457324}, // Villa z basenem obok Malibu (exterior)
    {0, 4871.960449, -2013.114624, 12.569411, 0, 4868.164062, -2009.897583, 86.799461}, // Wejœcie na dach budynku obok Corteza
    {0, 5044.467773, -1891.000610, 9.054121, 0, 5045.337402, -1886.837890, 23.058944}, // Schody nr 1 w centrum handlowym
    {0, 4962.374511, -1886.807006, 23.058944, 0, 4963.441894, -1891.040771, 9.054121} // Schody nr 2 w centrum handlowym
};

AddInterior(outName[], Float:outX, Float:outY, Float:outZ, outInt, outVw, inName[], Float:inX, Float:inY, Float:inZ, inInt, inVw, wejdzUID=0, playerLocal=255, bool:specialCome=false)
{
    return DodajWejscie(outX, outY, outZ, inX, inY, inZ, outVw, outInt, inVw, inInt, outName, inName,
        wejdzUID, playerLocal, specialCome);
}

ViceCityInteriors()
{
    new VCVW = 7110; // vice city standard interiors virtual world

    // ------ [ Rz¹d ] ------
    AddInterior( // Ratusz Downtown, Interior Planning Department (DMV GF)
        "Ratusz", 4302.2539, -246.4274, 11.5759, 0, 0,
        "Wyjœcie", 386.52, 173.63, 1008.38, 3, VCVW);


    // ------ [ Komisariaty ] ------
    AddInterior( // Komisariat 1 Miasto, Interior San Fierro Police Department
        "Komisariat", 5397.2466, -1422.1250, 11.5215, 0, 0,
        "Wyjœcie", 246.06, 108.97, 1003.21, 10, VCVW);

    AddInterior( // Komisariat £owców nagród, Interior Los Santos Police Department
        "Biuro £owców Nagród", 4127.8545, -1633.3948, 10.6903, 0, 0,
        "Wyjœcie", 246.66, 65.80, 1003.64, 6, VCVW);

    AddInterior( // Komisariat Downtown (FBI), Interior Las Venturas Police Department
        "Biuro FBI", 4342.9004, -187.4002, 11.0599, 0, 0,
        "Wyjœcie", 288.47, 170.06, 1007.17, 3, VCVW);

    AddInterior( // Baza Wojskowa, Ammu-nation 5
        "Biuro Armii", 3278.8284, -1106.3940, 14.3275, 0, 0,
        "Wyjœcie", 316.50, -167.62, 999.59, 6, VCVW);


    // ------ [ Szpitale ] ------
    AddInterior( // Ocean Beach Hospital
        "Szpital", 4861.7690, -1931.8264, 9.9212, 0, 0,
        "Wyjœcie", 1402.5581, -26.4880, 1000.9105, 3, 7110);

    AddInterior( // Vice Point Hospital
        "Szpital", 5497.7246, -247.1620, 11.5608, 0, 0,
        "Wyjœcie", 1402.5581,-26.4880,1000.9105, 3, 7111);

    AddInterior( // Downtown Hospital
        "Szpital", 4176.9443, 199.7706, 11.8687, 0, 0,
        "Wyjœcie", 1402.5581,-26.4880,1000.9105, 3, 7112);

    AddInterior( // Szpital Å›rodek drugiego miasta
        "Szpital", 4113.2056, -1420.4075, 12.5683, 0, 0,
        "Wyjœcie", 1402.5581,-26.4880,1000.9105, 3, 7113);


    // ------ [ Bank ] ------
    AddInterior(
        "Bank", 4104.6421, -1291.2079, 12.8773, 0, 0,
        "Wyjœcie", 1387.3058,-26.9497,1000.8729, 2, VCVW,
        0, 103);


    // ------ [ Inne ] ------
    AddInterior( // hotel z basenem obok pizza washington beach
        "Wejœcie", 5531.7842,-1068.9264,12.7963, 0, 0,
        "Wyjœcie", 5531.8521,-1086.9178,35.8695, 0, 0);


    // AddInterior(
    //     "", XYZ, int, vw,
    //     "WyjÅ›cie", XYZ, int, vw);


    // Add vice city interiors from Vice City Map
    for(new i = 0, k = sizeof(VC_interiors); i < k; i++)
    {
        AddInterior(
            sprintf("Wejœcie %d", i), VC_interiors[i][enexX2], VC_interiors[i][enexY2], VC_interiors[i][enexZ2] + 0.5, VC_interiors[i][enexInt2], 0,
            sprintf("Wyjœcie %d", i), VC_interiors[i][enexX1], VC_interiors[i][enexY1], VC_interiors[i][enexZ1] + 0.5, VC_interiors[i][enexInt1], 0
        );
    }
}