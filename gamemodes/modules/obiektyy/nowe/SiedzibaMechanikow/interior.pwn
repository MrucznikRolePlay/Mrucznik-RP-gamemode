//interior.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//----------------------------------------[ Obiekty: interior.pwn ]------------------------------------------//
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

//

//-----------------<[ G³ówne funkcje: ]>-------------------
SiedzibaMechanikow::interior_Init()
{
	StworzObiekty();
	StworzBudynki();
	return 1;
}

//-----------------<[ Funkcje: ]>-------------------
static StworzObiekty()
{
	CreateDynamicObject(19376,2788.9484900,-1624.7471900,14.8805000,0.0000000,90.0000000,0.0000000,16); //Object number 0
	CreateDynamicObject(19376,2778.4567900,-1624.7450000,14.8805000,0.0000000,90.0000000,0.0000000,16); //Object number 1
	CreateDynamicObject(19445,2774.9052700,-1624.7603800,16.6262100,0.0000000,0.0000000,0.0000000,16); //Object number 2 t
	CreateDynamicObject(19445,2793.3864700,-1624.8079800,16.6468000,0.0000000,0.0000000,0.0000000,16); //Object number 3 t
	CreateDynamicObject(19445,2779.5976600,-1626.6534400,16.6262000,0.0000000,0.0000000,90.0000000,16); //Object number 4 t
	CreateDynamicObject(19445,2789.1992200,-1626.6525900,16.6262000,0.0000000,0.0000000,90.0000000,16); //Object number 5 t
	CreateDynamicObject(19376,2788.9484900,-1624.7471900,18.3025300,0.0000000,90.0000000,0.0000000,16); //Object number 6
	CreateDynamicObject(19376,2778.4567900,-1624.7450000,18.3016000,0.0000000,90.0000000,0.0000000,16); //Object number 7
	CreateDynamicObject(1723,2775.5212400,-1624.1479500,14.9683000,0.0000000,0.0000000,90.0000000,16); //Object number 8
	CreateDynamicObject(2614,2783.4116200,-1626.5235600,17.1244000,0.0000000,0.0000000,180.0000000,16); //Object number 9
	CreateDynamicObject(2207,2784.2954100,-1624.3625500,14.9679000,0.0000000,0.0000000,180.0000000,16); //Object number 10
	CreateDynamicObject(1722,2783.3012700,-1626.3111600,14.9688600,0.0000000,0.0000000,0.0000000,16); //Object number 11
	CreateDynamicObject(2200,2790.7939500,-1626.5301500,14.9662800,0.0000000,0.0000000,180.0000000,16); //Object number 12
	CreateDynamicObject(2231,2793.0632300,-1626.6855500,14.9679800,0.0000000,0.0000000,-136.3200100,16); //Object number 13
	CreateDynamicObject(2231,2793.3781700,-1620.2835700,14.9688200,0.0000000,0.0000000,-45.2399900,16); //Object number 14
	CreateDynamicObject(19893,2782.8205600,-1624.8956300,15.7446700,0.0000000,0.0000000,43.3800000,16); //Object number 15
	CreateDynamicObject(11725,2778.9873000,-1626.3391100,15.3414800,0.0000000,0.0000000,178.5601000,16); //Object number 16
	CreateDynamicObject(1811,2783.4155300,-1623.0056200,15.4617100,0.0000000,0.0000000,88.6799600,16); //Object number 17
	CreateDynamicObject(1811,2782.5014600,-1623.0306400,15.4617100,0.0000000,0.0000000,89.2800000,16); //Object number 18
	CreateDynamicObject(1811,2784.1960400,-1623.0122100,15.4617000,0.0000000,0.0000000,88.6800000,16); //Object number 19
	CreateDynamicObject(1536,2793.3461900,-1624.0228300,14.9102600,0.0000000,0.0000000,90.0000000,16); //Object number 20
	CreateDynamicObject(1536,2793.3022500,-1621.0109900,14.9103000,0.0000000,0.0000000,990.0000000,16); //Object number 21
	CreateDynamicObject(19823,2784.2609900,-1625.0601800,15.7447400,0.0000000,0.0000000,0.0000000,16); //Object number 22
	CreateDynamicObject(2195,2775.6088900,-1625.5426000,15.5806900,0.0000000,0.0000000,0.0000000,16); //Object number 23
	CreateDynamicObject(2195,2775.5053700,-1620.7784400,15.5806900,0.0000000,0.0000000,0.0000000,16); //Object number 24
	CreateDynamicObject(19632,2783.6879900,-1624.3851300,9.9200700,0.0000000,0.0000000,0.0000000,16); //Object number 25
	CreateDynamicObject(2164,2787.4177200,-1626.5673800,14.9603300,0.0000000,0.0000000,180.0000000,16); //Object number 26
	CreateDynamicObject(1536,2776.3405800,-1626.6352500,14.9128000,0.0000000,0.0000000,0.0000000,16); //Object number 27
	CreateDynamicObject(19819,2784.1975100,-1624.7371800,15.8235800,0.0000000,0.0000000,0.0000000,16); //Object number 28
	CreateDynamicObject(2737,2793.2573200,-1625.3422900,16.6107000,0.0000000,0.0000000,-89.8800000,16); //Object number 29
	CreateDynamicObject(19325,2777.8320300,-1619.9520300,16.5714000,0.0000000,0.0000000,90.0000000,16); //Object number 30
	CreateDynamicObject(19325,2784.4746100,-1619.9499500,16.5714000,0.0000000,0.0000000,90.0000000,16); //Object number 31
	CreateDynamicObject(19325,2791.1001000,-1619.9418900,16.5714000,0.0000000,0.0000000,90.0000000,16); //Object number 32
	CreateDynamicObject(19445, 2779.39746, -1619.89429, 14.23540,   0.00000, 0.00000, 90.00000, 16);
	CreateDynamicObject(19445, 2788.95044, -1619.90015, 14.23540,   0.00000, 0.00000, 90.00000, 16);
	CreateDynamicObject(19445, 2798.55176, -1619.91089, 14.23540,   0.00000, 0.00000, 90.00000, 16);
	CreateDynamicObject(19445, 2779.39746, -1619.89429, 19.45445,   0.00000, 0.00000, 90.00000, 16);
	CreateDynamicObject(19445, 2788.95044, -1619.90015, 19.45070,   0.00000, 0.00000, 90.00000, 16);
	CreateDynamicObject(19445, 2798.55176, -1619.91089, 19.45150,   0.00000, 0.00000, 90.00000, 16);
	
	new mechu =	CreateDynamicObject(19445,2774.9052700,-1624.7603800,16.6262100,0.0000000,0.0000000,0.0000000,16); //Object number 2 t
	SetDynamicObjectMaterial(mechu, 0, 10444, "hotelbackpool_sfs", "ws_hotel7", 0xFFFFFFFF);
	
	mechu =	CreateDynamicObject(19445,2793.3864700,-1624.8079800,16.6468000,0.0000000,0.0000000,0.0000000,16); //Object number 3 t
	SetDynamicObjectMaterial(mechu, 0, 10444, "hotelbackpool_sfs", "ws_hotel7", 0xFFFFFFFF);
	
	mechu =	CreateDynamicObject(19445,2779.5976600,-1626.6534400,16.6262000,0.0000000,0.0000000,90.0000000,16); //Object number 4 t
	SetDynamicObjectMaterial(mechu, 0, 10444, "hotelbackpool_sfs", "ws_hotel7", 0xFFFFFFFF);
	
	mechu =	CreateDynamicObject(19445,2789.1992200,-1626.6525900,16.6262000,0.0000000,0.0000000,90.0000000,16); //Object number 5 t
	SetDynamicObjectMaterial(mechu, 0, 10444, "hotelbackpool_sfs", "ws_hotel7", 0xFFFFFFFF);
	
	mechu =	CreateDynamicObject(19445, 2779.39746, -1619.89429, 14.23540,   0.00000, 0.00000, 90.00000, 16);
	SetDynamicObjectMaterial(mechu, 0, 10444, "hotelbackpool_sfs", "ws_hotel7", 0xFFFFFFFF);
	
	mechu =	CreateDynamicObject(19445, 2788.95044, -1619.90015, 14.23540,   0.00000, 0.00000, 90.00000, 16);
	SetDynamicObjectMaterial(mechu, 0, 10444, "hotelbackpool_sfs", "ws_hotel7", 0xFFFFFFFF);
	
	mechu =	CreateDynamicObject(19445, 2798.55176, -1619.91089, 14.23540,   0.00000, 0.00000, 90.00000, 16);
	SetDynamicObjectMaterial(mechu, 0, 10444, "hotelbackpool_sfs", "ws_hotel7", 0xFFFFFFFF);
	
	mechu =	CreateDynamicObject(19445, 2779.39746, -1619.89429, 19.45445,   0.00000, 0.00000, 90.00000, 16);
	SetDynamicObjectMaterial(mechu, 0, 10444, "hotelbackpool_sfs", "ws_hotel7", 0xFFFFFFFF);
	
	mechu =	CreateDynamicObject(19445, 2788.95044, -1619.90015, 19.45070,   0.00000, 0.00000, 90.00000, 16);
	SetDynamicObjectMaterial(mechu, 0, 10444, "hotelbackpool_sfs", "ws_hotel7", 0xFFFFFFFF);
	
	mechu =	CreateDynamicObject(19445, 2798.55176, -1619.91089, 19.45150,   0.00000, 0.00000, 90.00000, 16);
	SetDynamicObjectMaterial(mechu, 0, 10444, "hotelbackpool_sfs", "ws_hotel7", 0xFFFFFFFF);
	return 1;
}

static StworzBudynki()
{
	DodajWejscie(2770.8071, -1628.0632, 12.7701, 2792.6665, -1622.5383, 15.9749, 0, 0, 16, 0, "Siedziba Mechaników", "Wyjœcie");
	return 1;
}