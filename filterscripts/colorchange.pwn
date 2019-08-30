//colorchange.pwn

//-------------------------------------------<< Filterscript >>----------------------------------------------//
//------------------------------------------[ Modu³: cc_event.pwn ]---------------------------------------------//
//Autor:
/*
	mrN
*/
//Opis:
/*
Skrypt na 10 lecie Mrucznik Role Play
*/
//Adnotacje:
/*

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

//
//
//-----------------<[ Includes: ]>-------------------
#include <a_samp>
#include <sscanf2>
#include <zcmd>
#include <streamer>
#include <foreach>
//-----------------<[ Define: ]>------------------

#define BLOCK_CZERWONY 1
#define BLOCK_BIALY 2
#define BLOCK_FIOLET 3
#define BLOCK_CZARNY 4
#define BLOCK_POMARANCZ 5
#define BLOCK_BRAZ 6
#define BLOCK_ZIELONY 7
#define BLOCK_ZOLTY 8
#define BLOCK_NIEBIESKI 9

#define COLOR_ENTER_X 1498.4453
#define COLOR_ENTER_Y -1582.5220
#define COLOR_ENTER_Z 13.5469
#define MAX_CC_OBJECTS 9 
#define MAX_CC_EVENT_PLAYERS 20



//-----------------<[ Zmienne: ]>----------------------
enum cc_blocksInfo{
	ccIndex,
	ccColor[64],
	ccActive
}
new CC_BLOCKS[9][cc_blocksInfo];

new bool:ccEventStatus = false;
new bool:ccAdmin[MAX_PLAYERS] = false;
new bool:togCcEvent[MAX_PLAYERS] = true;
new ccEventMembers = 0;
new ccEventMaxMembers = 20;
new bool:ccEventMember[MAX_CC_EVENT_PLAYERS] = false;
new ccRoundTime = 5;

new tmpobjid;
new blokObject[9];
new randomBlock;
//new PlayerText:ccTXD[MAX_PLAYERS];


//-----------------<[ Callback'i: ]>-------------------
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Fliterscript 'colorchange' zaladowany");
	print("--------------------------------------\n");


	tmpobjid = CreateDynamicObject(18765, 1802.919189, -1778.262573, 49.428756, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19071, "wssections", "wood1", 0x00000000);
	tmpobjid = CreateDynamicObject(18765, 1792.969116, -1778.262573, 49.428756, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19071, "wssections", "wood1", 0x00000000);
	tmpobjid = CreateDynamicObject(18765, 1792.969116, -1788.262573, 49.428756, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19071, "wssections", "wood1", 0x00000000);
	tmpobjid = CreateDynamicObject(18765, 1802.969116, -1788.262573, 49.428756, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19071, "wssections", "wood1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1797.463256, -1780.134887, 54.968750, 0.000000, 0.000000, 90.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1792.802856, -1784.414672, 54.968750, 0.000000, 0.000000, 180.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1797.553344, -1789.043579, 54.968750, 0.000000, 0.000000, 270.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1801.933105, -1785.044433, 54.968750, 0.000000, 0.000000, 360.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1802.945190, -1793.675170, 54.298759, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1806.797241, -1788.745605, 54.298759, 0.000000, 0.000000, 90.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1806.797241, -1778.757080, 54.298759, 0.000000, 0.000000, 90.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1793.536743, -1777.007446, 55.288730, 0.000000, 0.000000, 180.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 4829, "airport_las", "fancy_slab128", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1788.047851, -1778.947753, 54.298759, 0.000000, 0.000000, 270.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1788.047851, -1788.927856, 54.298759, 0.000000, 0.000000, 270.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1792.999267, -1793.677490, 54.298759, 0.000000, 0.000000, 360.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1803.516357, -1777.007446, 55.288730, 0.000000, 0.000000, 180.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 4829, "airport_las", "fancy_slab128", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1802.945190, -1793.675170, 59.298759, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1806.797241, -1788.745605, 59.298759, 0.000000, 0.000000, 90.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1806.797241, -1778.757080, 59.298759, 0.000000, 0.000000, 90.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1788.047851, -1778.947753, 59.298759, 0.000000, 0.000000, 270.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1788.047851, -1788.927856, 59.298759, 0.000000, 0.000000, 270.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1792.999267, -1793.677490, 59.298759, 0.000000, 0.000000, 360.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1792.838134, -1773.747802, 59.298759, 0.000000, 0.000000, 360.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1802.817993, -1773.747802, 59.298759, 0.000000, 0.000000, 360.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1793.536743, -1777.007446, 50.288730, 0.000000, 0.000000, 180.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1803.516357, -1777.007446, 50.288730, 0.000000, 0.000000, 180.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1799.958129, -1777.400634, 56.788768, 0.000000, 0.000000, 90.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "safetymesh", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1790.386962, -1777.400634, 56.788768, 0.000000, 0.000000, 90.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "safetymesh", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1793.076171, -1791.114624, 61.828762, 90.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1803.076171, -1791.114624, 61.828762, 90.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1803.076171, -1786.114624, 61.828762, 90.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1803.076171, -1781.114624, 61.828762, 90.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1803.076171, -1776.114624, 61.828762, 90.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1793.076171, -1776.114624, 61.828762, 90.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1793.076171, -1781.114624, 61.828762, 90.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1793.076171, -1786.114624, 61.828762, 90.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(8615, 1805.664184, -1781.665161, 56.028705, 0.000000, 0.000000, 90.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1806.521484, -1788.500610, 52.502716, 200.000000, 90.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tmpobjid = CreateDynamicObject(10444, 1799.183471, -1785.011108, 53.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(10444, 1784.733764, -1785.011108, 53.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(18766, 1801.507202, -1773.646850, 54.298759, 0.000000, 0.000000, 180.000000, 666, 0, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(18766, 1801.567871, -1774.997436, 57.298759, 90.000000, 0.000000, 180.000000, 666, 0, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(18766, 1791.609252, -1774.997436, 57.298759, 90.000000, 0.000000, 180.000000, 666, 0, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(10444, 1799.183471, -1785.011108, 53.268753, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(10444, 1784.733764, -1785.011108, 53.268753, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(10444, 1799.183471, -1785.011108, 53.068756, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(10444, 1784.733764, -1785.011108, 53.068756, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(10444, 1799.183471, -1785.011108, 52.868759, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(10444, 1784.733764, -1785.011108, 52.868759, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(10444, 1799.183471, -1785.011108, 52.668762, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(10444, 1784.733764, -1785.011108, 52.668762, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	//tmpobjid = CreateDynamicObject(-1001, 1797.202636, -1777.422241, 56.218742, 0.000000, 0.000000, 90.000000, 666, 0, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1557, 1806.364624, -1776.504516, 57.798759, 0.000000, 0.000000, 90.000000, 666, 0, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1708, 1798.418334, -1776.022460, 57.798759, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1708, 1796.566650, -1776.022460, 57.798759, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1708, 1794.666137, -1776.022460, 57.798759, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);

	/*blokObject[0] = CreateDynamicObject(18763, 1797.428100, -1787.520019, 52.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(blokObject[0], 0, 18996, "mattextures", "sampwhite", 0x00000000);//Bia³y
	blokObject[1] = CreateDynamicObject(18763, 1797.428100, -1784.520019, 52.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(blokObject[1], 0, 18996, "mattextures", "sampred", 0x00000000);//Czerwony
	blokObject[2] = CreateDynamicObject(18763, 1797.428100, -1781.520019, 52.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(blokObject[2], 0, 7650, "vgnusedcar", "lightpurple2_32", 0x00000000);//fioletowy
	blokObject[3] = CreateDynamicObject(18763, 1800.428100, -1787.520019, 52.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(blokObject[3], 0, 18646, "matcolours", "grey-93-percent", 0x00000000);//Czarny
	blokObject[4] = CreateDynamicObject(18763, 1800.428100, -1784.520019, 52.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(blokObject[4], 0, 14803, "bdupsnew", "Bdup2_wallpaperC", 0x00000000);//pomarañcz
	blokObject[5] = CreateDynamicObject(18763, 1800.428100, -1781.520019, 52.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(blokObject[5], 0, 14385, "trailerkb", "tr_wood1", 0x00000000);//Br¹zowy
	blokObject[6] = CreateDynamicObject(18763, 1794.428100, -1787.520019, 52.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(blokObject[6], 0, 19267, "mapmarkers", "green-2", 0x00000000);//Zielony
	blokObject[7] = CreateDynamicObject(18763, 1794.428100, -1784.520019, 52.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(blokObject[7], 0, 19607, "enexmarkers", "enexmarker1-2", 0x00000000);//zolty
	blokObject[8] = CreateDynamicObject(18763, 1794.428100, -1781.520019, 52.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(blokObject[8], 0, 18646, "matcolours", "lightblue", 0x00000000);//Niebieski */
	ccCreateBlocks();

	format(CC_BLOCKS[0][ccColor], 64, "bia³y");
	format(CC_BLOCKS[1][ccColor], 64, "{EA4337}czerwony");
	format(CC_BLOCKS[2][ccColor], 64, "{6D0DDA}fioletowy");
	format(CC_BLOCKS[3][ccColor], 64, "{202020}czarny");
	format(CC_BLOCKS[4][ccColor], 64, "{FDAD0B}pomarañczowy");
	format(CC_BLOCKS[5][ccColor], 64, "{5B3013}br¹zowy");
	format(CC_BLOCKS[6][ccColor], 64, "{14A928}zielony");
	format(CC_BLOCKS[7][ccColor], 64, "{FFF01E}¿ó³ty");
	format(CC_BLOCKS[8][ccColor], 64, "{4528FF}niebieski");

	CC_BLOCKS[0][ccActive] = 1;
	CC_BLOCKS[1][ccActive] = 1;
	CC_BLOCKS[2][ccActive] = 1;
	CC_BLOCKS[3][ccActive] = 1;
	CC_BLOCKS[4][ccActive] = 1;
	CC_BLOCKS[5][ccActive] = 1;
	CC_BLOCKS[6][ccActive] = 1;
	CC_BLOCKS[7][ccActive] = 1;
	CC_BLOCKS[8][ccActive] = 1;
	return 1;
}

public OnFilterScriptExit()
{
	print("\n--------------------------------------");
	print(" Fliterscript 'colorchange' wylaczony");
	print("--------------------------------------\n");
	return 1;
}
public OnPlayerConnect(playerid)
{
	SendClientMessage(playerid, -1, "Na serwerze znajduje siê skrypt: COLOR CHALLANGE!");
	SendClientMessage(playerid, -1, "Weso³ego 10-lecia serwera Mrucznik Role Play!");
	//ccTXD[playerid] = CreatePlayerTextDraw(playerid, 320.0, 240.0, "GRACZE: ?/20");
	//PlayerTextDrawShow(playerid, ccTXD[playerid]);
	return 1;
}
public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
	if(ccEventMember[playerid] == true)
	{
		if(playerid != damagedid)
		{
			SendClientMessage(playerid, -1, "Za DM zostajesz wyrzucony z zabawy!"); 
			ccEventMember[playerid] = false;
			ccRemoveFromEvent(playerid);
		}
	}

	return 0; 
}
public OnPlayerDisconnect(playerid, reason){
	if(ccEventMember[playerid] == true){
		ccEventMembers--;
		ccEventMember[playerid] = false;
	}
	//PlayerTextDrawDestroy(playerid, ccTXD[playerid]);
	return 1;
}
CMD:cc_dajlider(playerid, params[]){
	if(IsPlayerAdmin(playerid)){
		new przywilejowany;
		if(sscanf(params, "d", przywilejowany)){
			SendClientMessage(playerid, -1, "U¿yj: /cc_dajlider [ID]");
		}else{
			ccAdmin[przywilejowany] = true;
			SendClientMessage(przywilejowany, -1, "Gratulacjê, otrzyma³eœ uprawnienia zarz¹dzania Color Challange'm");
		}
	}
	return 1;
}
CMD:cc_zabierzlider(playerid, params[]){
	if(IsPlayerAdmin(playerid)){
		new unprzywilejowany;
		if(sscanf(params, "d", unprzywilejowany)){
			SendClientMessage(playerid, -1, "U¿yj: /cc_zabierzlider [ID]");
		}else{
			ccAdmin[unprzywilejowany] = false;
			SendClientMessage(unprzywilejowany, -1, "Niestety odebrano Ci uprawnienia zarz¹dzania Color Challange'm");
		}
	}
	return 1;
}
CMD:cc(playerid, params[]){
	if(IsPlayerInRangeOfPoint(playerid, 5.0, COLOR_ENTER_X, COLOR_ENTER_Y, COLOR_ENTER_Z)){
		if(ccEventStatus == true)
		{
			SendClientMessage(playerid, -1, "Nie mo¿esz do³¹czyæ do zabawy - aktualnie trwa!");
			
		}else{
			if(ccEventMember[playerid] == true){
				SendClientMessage(playerid, -1, "Uczestniczysz ju¿ w zabawie");
				SetPlayerVirtualWorld(playerid, 666);
				SetPlayerInterior(playerid, 0);
				SetPlayerPos(playerid, 1797.428100, -1787.520019, 55.468750);
				SetTimerEx("FreezePlayer", 3500, false, "i", playerid);
				TogglePlayerControllable(playerid, 0);
			}else{
				if(ccEventMembers <= ccEventMaxMembers){
					SetPlayerVirtualWorld(playerid, 666);
					SetPlayerInterior(playerid, 0);
					SendClientMessage(playerid, -1, "========<[ COLOR CHALLANGE ]>========");
					SendClientMessage(playerid, -1, "Do³¹czy³eœ do zabawy");
					SetPlayerPos(playerid, 1797.428100, -1787.520019, 58.468750);
					SetTimerEx("FreezePlayer", 3500, false, "i", playerid);
					TogglePlayerControllable(playerid, 0);
					ccEventMember[playerid] = true;
					ccEventMembers++;
					//ccActiveMembers();

				}else{
					SendClientMessage(playerid, -1, "Nie mo¿esz do³¹czyæ do zabawy - maksymalna liczba graczy!");
				
				}
			}

		}	

	}
	return 1;
}
CMD:cc_start(playerid, params[]){
	if(ccAdmin[playerid] == true){
		if(ccEventStatus == false){
			ccEventStatus = true;
			SendClientMessage(playerid, -1, "W³¹czy³eœ(aœ) zabawê COLOR CHALLANGE");
			new time = ccRoundTime;
			SetTimerEx("ccRandomTimer", time, false, "i", playerid);
		}else{
			ccEventStatus = false;
			SendClientMessage(playerid, -1, "Wy³¹czy³eœ(aœ) zabawê COLOR CHALLANGE");
			ccRestart();
			foreach(new i : Player){
				if(ccEventMember[i] == true){
					ccRemoveFromEvent(i);
				}
			}
		}
	}else{
		SendClientMessage(playerid, -1, "Niestety nie posiadasz uprawnieñ do u¿ycia tej komendy");
	}

	return 1;
}
CMD:cc_tog(playerid, params[]){
	if(togCcEvent[playerid] == true){
		togCcEvent[playerid] = false;
		SendClientMessage(playerid, -1, "Wy³¹czy³eœ widocznoœæ wiadomoœci Color Challang'u");
	}else{
		togCcEvent[playerid] = true;
		SendClientMessage(playerid, -1, "W³¹czy³eœ widocznoœæ wiadomoœci Color Challang'u");
	}
	return 1;
}
CMD:cc_restart(playerid, params[]){
	if(ccAdmin[playerid] == true){
		SendCcEventMessage(-1, "Color Challange zrestartowany! Zapraszam do zapisów");
		ccRestart();
	}else{
		SendClientMessage(playerid, -1, "Niestety nie posiadasz uprawnieñ do u¿ycia tej komendy");
	}
	return 1;
}
CMD:cc_odrzut(playerid, params[]){
	ccRemoveMember();
	return 1;
}
CMD:chujcipa123strefa(playerid, params[]){
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerPos(playerid, COLOR_ENTER_X, COLOR_ENTER_Y, COLOR_ENTER_Z);
	return 1;
}
forward FreezePlayer(playerid);
public FreezePlayer(playerid){
	TogglePlayerControllable(playerid, 1);
	return 1;
}
forward ccRandomTimer(playerid);
public ccRandomTimer(playerid){
	ccRandom();
	return 1;
}
stock ccRandom(){
	randomBlock = random(8);
	if(CC_BLOCKS[randomBlock][ccActive] == 1){
		new txt_cc[128];
		format(txt_cc, 128, "Za 3 sekundy zostanie sam blok %s ", CC_BLOCKS[randomBlock][ccColor]);
		SendClientMessageToAll(-1, txt_cc);
		SetTimer("ccMoveBlocksDown", 3000, false);

	}else{
		ccRandom();
	}
	return 1;
}
stock ccRestart(){
	for(new i; i<9; i++){
		if(CC_BLOCKS[i][ccActive] == 0){
			new Float:Pos[3];
			GetDynamicObjectPos(blokObject[i], Pos[0], Pos[1], Pos[2]);
			MoveDynamicObject(blokObject[i], Pos[0], Pos[1], Pos[2]+8.0, 5, 0.0, 0.0, 0.0);
			CC_BLOCKS[i][ccActive] = 1;
		}
	}
	return 1;
}
stock ccCreateBlocks(){
	blokObject[0] = CreateDynamicObject(18763, 1797.428100, -1787.520019, 55.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(blokObject[0], 0, 18996, "mattextures", "sampwhite", 0x00000000);//Bia³y
	blokObject[1] = CreateDynamicObject(18763, 1797.428100, -1784.520019, 55.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(blokObject[1], 0, 18996, "mattextures", "sampred", 0x00000000);//Czerwony
	blokObject[2] = CreateDynamicObject(18763, 1797.428100, -1781.520019, 55.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(blokObject[2], 0, 7650, "vgnusedcar", "lightpurple2_32", 0x00000000);//fioletowy
	blokObject[3] = CreateDynamicObject(18763, 1800.428100, -1787.520019, 55.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(blokObject[3], 0, 18646, "matcolours", "grey-93-percent", 0x00000000);//Czarny
	blokObject[4] = CreateDynamicObject(18763, 1800.428100, -1784.520019, 55.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(blokObject[4], 0, 14803, "bdupsnew", "Bdup2_wallpaperC", 0x00000000);//pomarañcz
	blokObject[5] = CreateDynamicObject(18763, 1800.428100, -1781.520019, 55.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(blokObject[5], 0, 14385, "trailerkb", "tr_wood1", 0x00000000);//Br¹zowy
	blokObject[6] = CreateDynamicObject(18763, 1794.428100, -1787.520019, 55.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(blokObject[6], 0, 19267, "mapmarkers", "green-2", 0x00000000);//Zielony
	blokObject[7] = CreateDynamicObject(18763, 1794.428100, -1784.520019, 55.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(blokObject[7], 0, 19607, "enexmarkers", "enexmarker1-2", 0x00000000);//zolty
	blokObject[8] = CreateDynamicObject(18763, 1794.428100, -1781.520019, 55.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(blokObject[8], 0, 18646, "matcolours", "lightblue", 0x00000000);//Niebieski
	return 1;
}
stock SendCcEventMessage(color, const text[]){
	foreach(new i : Player){
		if(togCcEvent[i] == true){
			SendClientMessage(i, color, text);
		}
	}
	return 1;
}
stock ccActiveMembers(){
	new txt_members[128];
	format(txt_members, 128, "Aktualnie graczy %d/%d", ccEventMembers, ccEventMaxMembers);
	SendCcEventMessage(-1, txt_members);
	return 1;
}
stock ccRemoveMember(){
	foreach(new i : Player){
	    if(ccEventMember[i] == true){
			new Float:Pos[3];
			GetPlayerPos(i, Pos[0], Pos[1], Pos[2]);
			new Float:ccHeight = 58.9688;
			new Float:ccDistance;
			if(Pos[2] >= ccHeight){
				ccDistance = floatsub(Pos[2], ccHeight);
			}else{
				ccDistance = floatsub(ccHeight, Pos[2]);
			}
			new txt[32];
			format(txt, 32, "Dystans to: %f ", ccDistance);
			SendClientMessage(i, -1, txt);
			if(ccDistance > 0.3){
			    SendClientMessage(i, -1, "Odpadasz z zabawy!");
			    ccEventMember[i] = false;
			    //ccEventMembers--;
			    ccRemoveFromEvent(i);
			}else{
				SendClientMessage(i, -1, "Grasz dalej");
			}
	    }
	}
	return 1;
}
CMD:cc_widz(playerid, params[]){
	if(ccAdmin[playerid] == true){
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 666);
	SetPlayerPos(playerid, 1801.6967, -1775.4634, 58.7988);
	}else{
		SendClientMessage(playerid, -1, "Nie masz uprawnieñ do u¿ywania tej komendy");
	}
	return 1;
}
CMD:pos(playerid, params[]){
	new Float:Pos[3], aha[128];
	GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
	format(aha, 128, "Postaæ: %f %f %f", Pos[0], Pos[1], Pos[2]);
	SendClientMessageToAll(-1, aha);
	return 1;
}
stock ccRemoveFromEvent(playerid)
{
	SetPlayerPos(playerid, COLOR_ENTER_X, COLOR_ENTER_Y, COLOR_ENTER_Z);
	ccEventMember[playerid] = false;
	SendClientMessage(playerid, -1, "Wychodzisz z budynku!");
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	ccEventMembers--;
	return 1;
}
forward ccMoveBlocksDown();
public ccMoveBlocksDown(){
	for(new i = 0; i < 9; i++){
		if(i != randomBlock){
		new Float:Pos[3];
		GetDynamicObjectPos(blokObject[i], Pos[0], Pos[1], Pos[2]);
		MoveDynamicObject(blokObject[i], Pos[0], Pos[1], Pos[2]-8.0, 5, 0.0, 0.0, 0.0);
		CC_BLOCKS[i][ccActive] = 0;
		}
	}
	SetTimer("RemoveMembers", 8000, false);
	SetTimer("CheckMembers", 4000, false);
	return 1;
}
forward RemoveMembers();
public RemoveMembers(){
	ccRemoveMember();
	return 1;
}
forward CheckMembers();
public CheckMembers(){
	if(ccEventMembers == 1){

		SendCcEventMessage(-1, "Zosta³ jeden gracz - jest on zwyciêzc¹");
	}else if(ccEventMembers == 0){
		SendCcEventMessage(-1, "Nie ma ani jednego gracza");
	}else{
		// SetTimer("PlayersMessage", 3000, false);
		/*new txt[128];
		format(txt, 128, "Po rundzie zosta³o %d graczy", ccEventMembers);
		SendCcEventMessage(-1, txt);*/
		SendCcEventMessage(-1, "Za 10 sekund zacznie siê kolejna runda");
		SetTimer("NextRound", 10000, false);
		SetTimer("RoundReset", 8000, false);
	}
	return 1;
}
forward RoundReset();
public RoundReset(){
	ccRestart();
	//SetTimer("NextRound", 3000, false);
	return 1;
}
forward NextRound();
public NextRound(){
	ccRandom();
	/*foreach(new i : Player){
		UpdateCcTextdraw(i);
	}*/
	return 1;
}
stock UpdateCcTextdraw(playerid){
	new txt[32];
	format(txt, 32, "GRACZE: %d/20", ccEventMembers);
	PlayerTextDrawSetString(playerid, ccTXD[playerid], txt);
	return 1;
}