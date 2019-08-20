//colorchange.pwn

//-------------------------------------------<< Filterscript >>----------------------------------------------//
//------------------------------------------[ Modu³: colorchange.pwn ]---------------------------------------------//
//Autor:
/*
	Simeone
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
#include <foreach>
#include <streamer>
//-----------------<[ Define: ]>------------------
#define COLOR_ENTER_X 13.7169
#define COLOR_ENTER_Y -1759.6519
#define COLOR_ENTER_Z 1483.9551
#define OLD_MEMBER 9999
#define COLOR_GRAD 0xC0C0C0FF
#define COLOR_GREEN 0x80FF00FF
//-----------------<[ Zmienne: ]>----------------------
new fTime;//Czas 1 rundy
new fPlayers;//Maksymalna iloœæ cz³onków
new partyStatus;//Status zabawy. 
new togParty[MAX_PLAYERS];//Wyciszenie zabawy
new partyMember[MAX_PLAYERS];//member party
new memReset[MAX_PLAYERS];//Timer odpowiadaj¹cy za mo¿liwoœæ ponownego do³¹czenia do zabawy
new timeMember[playerid];//Czas timera wy¿ej
//-----------------<[ Callback'i: ]>-------------------
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Fliterscript 'colorchange' zaladowany");
	print("--------------------------------------\n");
	tmpobjid = CreateDynamicObject(18763, 1797.428100, -1787.520019, 52.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampwhite", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, 1797.428100, -1784.520019, 52.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampred", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, 1797.428100, -1781.520019, 52.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 7650, "vgnusedcar", "lightpurple2_32", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, 1800.428100, -1787.520019, 52.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, 1800.428100, -1784.520019, 52.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14803, "bdupsnew", "Bdup2_wallpaperC", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, 1800.428100, -1781.520019, 52.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14385, "trailerkb", "tr_wood1", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, 1794.428100, -1787.520019, 52.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19267, "mapmarkers", "green-2", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, 1794.428100, -1784.520019, 52.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19607, "enexmarkers", "enexmarker1-2", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, 1794.428100, -1781.520019, 52.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "lightblue", 0x00000000);
	tmpobjid = CreateDynamicObject(18765, 1802.919189, -1778.262573, 49.428756, 0.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19071, "wssections", "wood1", 0x00000000);
	tmpobjid = CreateDynamicObject(18765, 1792.969116, -1778.262573, 49.428756, 0.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19071, "wssections", "wood1", 0x00000000);
	tmpobjid = CreateDynamicObject(18765, 1792.969116, -1788.262573, 49.428756, 0.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19071, "wssections", "wood1", 0x00000000);
	tmpobjid = CreateDynamicObject(18765, 1802.969116, -1788.262573, 49.428756, 0.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19071, "wssections", "wood1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1797.463256, -1780.134887, 54.968750, 0.000000, 0.000000, 90.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1792.802856, -1784.414672, 54.968750, 0.000000, 0.000000, 180.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1797.553344, -1789.043579, 54.968750, 0.000000, 0.000000, 270.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1801.933105, -1785.044433, 54.968750, 0.000000, 0.000000, 360.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1802.945190, -1793.675170, 54.298759, 0.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1806.797241, -1788.745605, 54.298759, 0.000000, 0.000000, 90.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1806.797241, -1778.757080, 54.298759, 0.000000, 0.000000, 90.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1793.536743, -1777.007446, 55.288730, 0.000000, 0.000000, 180.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 4829, "airport_las", "fancy_slab128", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1788.047851, -1778.947753, 54.298759, 0.000000, 0.000000, 270.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1788.047851, -1788.927856, 54.298759, 0.000000, 0.000000, 270.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1792.999267, -1793.677490, 54.298759, 0.000000, 0.000000, 360.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1803.516357, -1777.007446, 55.288730, 0.000000, 0.000000, 180.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 4829, "airport_las", "fancy_slab128", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1802.945190, -1793.675170, 59.298759, 0.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1806.797241, -1788.745605, 59.298759, 0.000000, 0.000000, 90.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1806.797241, -1778.757080, 59.298759, 0.000000, 0.000000, 90.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1788.047851, -1778.947753, 59.298759, 0.000000, 0.000000, 270.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1788.047851, -1788.927856, 59.298759, 0.000000, 0.000000, 270.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1792.999267, -1793.677490, 59.298759, 0.000000, 0.000000, 360.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1792.838134, -1773.747802, 59.298759, 0.000000, 0.000000, 360.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1802.817993, -1773.747802, 59.298759, 0.000000, 0.000000, 360.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1793.536743, -1777.007446, 50.288730, 0.000000, 0.000000, 180.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1803.516357, -1777.007446, 50.288730, 0.000000, 0.000000, 180.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1799.958129, -1777.400634, 56.788768, 0.000000, 0.000000, 90.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "safetymesh", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1790.386962, -1777.400634, 56.788768, 0.000000, 0.000000, 90.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "safetymesh", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1793.076171, -1791.114624, 61.828762, 90.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1803.076171, -1791.114624, 61.828762, 90.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1803.076171, -1786.114624, 61.828762, 90.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1803.076171, -1781.114624, 61.828762, 90.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1803.076171, -1776.114624, 61.828762, 90.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1793.076171, -1776.114624, 61.828762, 90.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1793.076171, -1781.114624, 61.828762, 90.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, 1793.076171, -1786.114624, 61.828762, 90.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3603, "bevmans01_la", "hottop5d_law", 0x00000000);
	tmpobjid = CreateDynamicObject(8615, 1805.664184, -1781.665161, 56.028705, 0.000000, 0.000000, 90.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1806.521484, -1788.500610, 52.502716, 200.000000, 90.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tmpobjid = CreateDynamicObject(10444, 1799.183471, -1785.011108, 53.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	tmpobjid = CreateDynamicObject(10444, 1784.733764, -1785.011108, 53.468750, 0.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	tmpobjid = CreateDynamicObject(18766, 1801.507202, -1773.646850, 54.298759, 0.000000, 0.000000, 180.000000, 666, 0, -1, 185.00, 185.00); 
	tmpobjid = CreateDynamicObject(18766, 1801.567871, -1774.997436, 57.298759, 90.000000, 0.000000, 180.000000, 666, 0, -1, 185.00, 185.00); 
	tmpobjid = CreateDynamicObject(18766, 1791.609252, -1774.997436, 57.298759, 90.000000, 0.000000, 180.000000, 666, 0, -1, 185.00, 185.00); 
	tmpobjid = CreateDynamicObject(10444, 1799.183471, -1785.011108, 53.268753, 0.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	tmpobjid = CreateDynamicObject(10444, 1784.733764, -1785.011108, 53.268753, 0.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	tmpobjid = CreateDynamicObject(10444, 1799.183471, -1785.011108, 53.068756, 0.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	tmpobjid = CreateDynamicObject(10444, 1784.733764, -1785.011108, 53.068756, 0.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	tmpobjid = CreateDynamicObject(10444, 1799.183471, -1785.011108, 52.868759, 0.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	tmpobjid = CreateDynamicObject(10444, 1784.733764, -1785.011108, 52.868759, 0.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	tmpobjid = CreateDynamicObject(10444, 1799.183471, -1785.011108, 52.668762, 0.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	tmpobjid = CreateDynamicObject(10444, 1784.733764, -1785.011108, 52.668762, 0.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	tmpobjid = CreateDynamicObject(-1001, 1797.202636, -1777.422241, 56.218742, 0.000000, 0.000000, 90.000000, 666, 0, -1, 185.00, 185.00); 
	tmpobjid = CreateDynamicObject(1557, 1806.364624, -1776.504516, 57.798759, 0.000000, 0.000000, 90.000000, 666, 0, -1, 185.00, 185.00); 
	tmpobjid = CreateDynamicObject(1708, 1798.418334, -1776.022460, 57.798759, 0.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	tmpobjid = CreateDynamicObject(1708, 1796.566650, -1776.022460, 57.798759, 0.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 
	tmpobjid = CreateDynamicObject(1708, 1794.666137, -1776.022460, 57.798759, 0.000000, 0.000000, 0.000000, 666, 0, -1, 185.00, 185.00); 

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
	SendClientMessage(playerid, COLOR_GREEN, "Na serwerze znajduje siê skrypt: COLOR CHANGE!");
	SendClientMessage(playerid, COLOR_GRAD, "Weso³ego 10-lecia serwera Mrucznik Role Play!"); 
	return 1;
}

//-----------------<[ Timery: ]>-------------------
forward MemberReset(playerid);
public MemberReset(playerid)
{
	timeMember[playerid]++;  
	if(timeMember[playerid] == 12)
	{
		SendClientMessage(playerid, COLOR_GRAD, "Do mo¿liwoœci ponownego do³¹czenia na ColorChange pozosta³o: 4 minut"); 
	}
	else if(timeMember[playerid] == 24)
	{
		SendClientMessage(playerid, COLOR_GRAD, "Do mo¿liwoœci ponownego do³¹czenia na ColorChange pozosta³o: 3 minuty");
	}
	else if(timeMember[playerid] == 36)
	{
		SendClientMessage(playerid, COLOR_GRAD, "Do mo¿liwoœci ponownego do³¹czenia na ColorChange pozosta³o: 2 minuty");
	}
	else if(timeMember[playerid] == 48)
	{
		SendClientMessage(playerid, COLOR_GRAD, "Do mo¿liwoœci ponownego do³¹czenia na ColorChange pozosta³o: 1 minuta");
	}
	else if(timeMember[playerid] == 60)
	{
		SendClientMessage(playerid, COLOR_GRAD, "Mo¿esaz ponownie do³¹czyæ na zabawê COLOR CHANGE"); 
		partyMember[playerid] = 0;
		timeMember[playerid]=0; 
		KillTimer(memReset[playerid]);
	}

}
//-----------------<[ Funkcje: ]>-------------------
sendPartyMess(color, const text[])
{
	foreach(new i : Player)
	{
		if(togParty[i] == 1)
		{
			SendClientMessage(i, color, text); 
		}
	}
	return 1;
}
stock GetName(playerid, rp = false)
{
	new nick[MAX_PLAYER_NAME];
 	GetPlayerName(playerid, nick, sizeof(nick));
	if(rp) {
		//return nickRP[playerid];
	}
	return nick;
}
stock RemovePlayerFromParty(playerid)
{
	SetPlayerPos(playerid, COLOR_ENTER_X, COLOR_ENTER_Y, COLOR_ENTER_Z);
	partyMember[playerid] = OLD_MEMBER;
	SendClientMessage(playerid, COLOR_GRAD, "Wychodzisz z budynku!");
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0); 
	memReset[playerid] = SetTimerEx("MemberReset", 5000, false, "d", playerid);
	return 1;
}
//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------
CMD:colorstart(playerid, params)
{
	if(partyStatus == 1)
	{
		format(string, sizeof(string), "%s wy³¹czy³(a) CC", GetName(playerid)); 
		SendClientMessage(playerid, "Zakoñczy³es zabawiê"); 
		sendPartyMess(COLOR_GREEN, "========<[ Color Challenge ]>========");
		sendPartyMess(COLOR_GRAD, string); 
		sendPartyMess(COLOR_GREEN, ">====================================<");
		partyStatus = 0; 
		foreach(new i : Player)
		{
			if(partyMember[i] == 1)
			{
				RemovePlayerFromParty(i); 
			}
		}
		return 1;
	}
	new maxPlayers, maxTime; 
	if(sscanf(params, "d<fix>d", maxPlayers, maxTime))
	{
		SendClientMessage(playerid, COLOR_GRAD, "U¿yj /colorstart [Max graczy] [Czas 1 rundy]");
		return 1;
	}
	if(maxTime <= 3 && maxTime > 10)
	{
		SendClientMessage(playerid, COLOR_GRAD, "Czas 1 rundy musi byæ wiêkszy od 3 i nie mo¿e byæ wy¿szy ni¿ 10 minut"); 
		return 1;
	}
	if(maxPlayers < 4)
	{
		SendClientMessage(playerid, COLOR_GRAD, "Iloœæ graczy od 4+");
		return 1;
	}
	fTime = maxTime;
	fPlayers = maxPlayers; 
	partyStatus = 1; 
	return 1;
}
CMD:wejdz(playerid)
{
	if(partyMember[playerid] == 1)
	{
		RemovePlayerFromParty(playerid);  
	}
	else if(IsPlayerInRangeOfPoint(playerid, 5.0, COLOR_ENTER_X, COLOR_ENTER_Y, COLOR_ENTER_Z))
	{
		if(aPartyPlayers+1 <= fPlayers)
		{
			if(partyStatus == 1)
			{
				SendClientMessage(playerid, COLOR_GRAD, "Nie mo¿esz do³¹czyæ do zabawy - trwa!"); 
				return 1;
			}
			if(partyMember == OLD_MEMBER)
			{
				SendClientMessage(playerid, COLOR_GRAD, "Nie mo¿esz do³¹czyæ do zabawy - bra³eœ ju¿ udzia³!"); 
				SendClientMessage(playerid, COLOR_GRAD, "Odczekaj 5 minut!"); 
				return 1;
			}
			SetPlayerVirtualWorld(playerid, 666);
			SetPlayerInterior(playerid, 0); 
			SendClientMessage(playerid, COLOR_GREEN, "========<[ Color Challenge ]>========");
			SendClientMessage(playerid, COLOR_GRAD, )
			SetPlayerPos(playerid, COLOR_X, COLOR_Y, COLOR_Z); 
			partyMember = 1; 
		}
		else 
		{
			SendClientMessage(playerid, COLOR_GRAD, "Nie mo¿esz do³¹czyæ do zabawy - MAX przekroczony!"); 
		}
	}

	return 1;
}
