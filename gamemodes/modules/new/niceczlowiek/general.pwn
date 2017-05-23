/**
    * This file is part of Mrucznik-RP 2.6
    *
    * @desc         misc stuff
    * 
    * @author       Mrucznik
    * @author       PECET
    * @author       NiceCzlowiek
    * @link         http://mrucznik-rp.pl
    */

/* struktura mrp_vcard 

uid
contact_number
contact_name
contact_owner

*/

enum offerEnum
{
	offerCustomerID,
	offerType,
	
	offerName[45],
	offerValue,
	offerPrice,
	
	offerPayType
}
new offerData[MAX_PLAYERS][offerEnum];

stock zerujZmienne_offerSystem(playerid) {
	offerData[playerid][offerCustomerID] 			= INVALID_PLAYER_ID;
	offerData[playerid][offerType] 					= 0;
	offerData[playerid][offerValue] 				= 0;
	offerData[playerid][offerPrice] 				= 0;

	PlayerInfo[playerid][pOfferedTo] 				= INVALID_PLAYER_ID;

	//offerData[playerid][offerPayType]			   	= PAYBY_ERROR;
}


// Typy ofert

#define OFFER_ERROR		0
#define OFFER_REFUEL 	1
#define OFFER_CARFIX 	2
//#define OFFER_CARTUNE	3
#define OFFER_ITEM 		4
#define OFFER_SERVICE  	5
#define OFFER_FOOD		6
#define OFFER_TICKET	7
#define OFFER_DOCUMENT	8
#define OFFER_ZDERZAK 	9
#define OFFER_FELGA 	10
#define OFFER_PAINJOTB	11
#define OFFER_SPOILER	12
#define OFFER_NITRO 	13
#define OFFER_OCHRONA	14
#define OFFER_VEHICLE	15
#define OFFER_MANDAT	16
#define OFFER_ROZWOD 	17
#define OFFER_SLUB 		18
#define OFFER_SWIADEK 	19
#define OFFER_VCARD		20

// Typy zapĹ‚aty

#define PAYBY_ERROR     0
#define PAYBY_WALLET	1
#define PAYBY_BANKACC   2


stock guiMsg(playerid, title[80], str[])
{
	new final_title[80];
	format(final_title, sizeof(final_title), "{49A350}Mrucznik » {FFFFFF}%s", title);
	Dialog_Show(playerid, DIALOG_STYLE_MSGBOX, final_title, str, "Ok", "");
	return 1;
}


stock getUnknownString(playerid) {
	new str[32];
	new uid =  PlayerInfo[playerid][pUID];
	format(str, sizeof(str), "%x", uid);
	return str;
}

stock getStringFromUnknown(hex) {

	new uid = hex >> 8;
	return uid;
}




//Tu wpisz~n~~n~~r~tekst~n~~n~~y~~h~wincyj teksta
stock showTimedMsgBox(playerid, delay, text[]) {
	CzasInformacyjnego[playerid] = delay;
	PlayerTextDrawHide(playerid, TextInformacyjny[playerid]);
	PlayerTextDrawSetString(playerid, TextInformacyjny[playerid], text);
	PlayerTextDrawShow(playerid, TextInformacyjny[playerid]);
	return true;
}


stock przeliczBogactwo(vehModel) {
	new cena = VehiclePrice[vehModel-400];
	return (floatround(((cena/1000) * 1), floatround_round));
}


stock znaCzyNie(playerid, playerid2)
{
	
}