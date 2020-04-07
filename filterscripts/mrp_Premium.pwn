#include <a_samp>
#include <crashdetect>
#include <dialogs>
#include <code-parse.inc>    
#include <YSI\YSI\y_inline>
#include <YSI\YSI\y_dialog>
#include <mselect>
#include <mysql_R5>
#include <zcmd>
//CallRemoteFunction("SEC_MyItems_HandleItems", "dddfffffffffd", playerid, model, uid, x, y, z, rx, ry, rz, sx, sy, sz, active);
enum e_itemCache {
	itemOwner,
	itemModel,
	itemUid,
	Float:itemx,	
	Float:itemy,
	Float:itemz,
	Float:itemrx,
	Float:itemry,
	Float:itemrz,
	Float:itemsx,
	Float:itemsy,
	Float:itemsz,
	itemActiveCache,
	itemActive,
	itemBone,
	itemOnSlot,
	actuallyRemoved
}
#define MAX_ITEMS 500
new dodatkow[MAX_PLAYERS];
new itemCache[MAX_PLAYERS][MAX_ITEMS][e_itemCache];

#define 				INVALID_SLOT			10
#define 				SLOT_1ST				3
#define 				SLOT_2ND				4
#define 				SLOT_3RD				5
#define 				SLOT_PREMIUM			6

#define 				COLOR1 					0xF7F7F2ff
#define 				COLOR2 					0xff00B7FF
#define 				COLOR3 					0xff49A350
#define 				COLOR4 					0xffF7F7F2
#define 				COLOR5 					0xffE3D8F1

#define 				COLOR1_EMBED 			"{F7F7F2}" // granat
#define 				COLOR2_EMBED 			"{00B7FF}" // niebiedski
#define 				COLOR3_EMBED 			"{49A350}" // zielony
#define 				COLOR4_EMBED 			"{F7F7F2}" // jasny1
#define 				COLOR5_EMBED 			"{E3D8F1}" // jasny2

new premiumGlobeString[7500];
new sukces[500];


// ceny MC
#define 				NR_OD6DO9CYFR 			200
#define 				NR_OD4DO5CYFR 			400
#define 				NR_3CYFROWY	  			700
#define 				NR_2CYFROWY	  			1000

#define 				KP_1MIESIAC	  			425

#define 				DODATKOWY_SLOT	  		500

//Limity
#define 				LIMIT_SLOTOW			10

//Inne
new NR_CENY[4] = {
	NR_OD6DO9CYFR, //od 6 do 9
	NR_OD4DO5CYFR, //od 4 do 5
	NR_3CYFROWY, //3 cyfrowy
	NR_2CYFROWY // 2 cyfrowy
};



forward MRP_ShowPremiumMenu(playerid);

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" MRP PREMIUM 1.0 INIT");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	print("\n--------------------------------------");
	print(" MRP PREMIUM 1.0 EXIT");
	print("--------------------------------------\n");
	return 1;
}

public OnPlayerConnect(playerid) {
	dodatkow[playerid] = 0;
}


stock tryingSql(str[]) {
	if (strfind(str, "%") != -1)
    {
        printf("%s probowal wyjebac serwer przez znak \"%\" a to haker");
        return 1;
    }
    return 0;
}


stock filterSqli(str[], str2[]) {
	mysql_real_escape_string(str, str2);
	return 1;
}
new scm_buf[144];
#define SendClientMessageF(%0,%1,%2,%3) \
	(format(scm_buf, sizeof scm_buf, %2,%3), SendClientMessageE(%0, %1,scm_buf))

SendClientMessageE(playerid, color = COLOR3, string:msg[]) { //CM do sendclientmessage (:
	new _str[144];
	format(_str,144,"»» [Premium] %s", msg);
	return SendClientMessage(playerid, color, _str);
}
IsNumeric(const string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
    return 1;
}
public MRP_ShowPremiumMenu(playerid) {
	new mc = CallRemoteFunction("MRP_GetPlayerMC", "%d", playerid);
	format(premiumGlobeString, sizeof(premiumGlobeString), ""COLOR4_EMBED"Iloœæ MruCoins: \t\t"#COLOR2_EMBED"%d MC", mc);
	format(premiumGlobeString, sizeof(premiumGlobeString), "%s\n\t"COLOR5_EMBED"Kup MruCoins", premiumGlobeString);
	format(premiumGlobeString, sizeof(premiumGlobeString), "%s\n"COLOR4_EMBED"Konto Premium", premiumGlobeString);
	format(premiumGlobeString, sizeof(premiumGlobeString), "%s\n\t"COLOR5_EMBED"Kup Konto Premium", premiumGlobeString);
	format(premiumGlobeString, sizeof(premiumGlobeString), "%s\n"COLOR4_EMBED"Numer Telefonu: \t\t"#COLOR2_EMBED"%d", premiumGlobeString, CallRemoteFunction("MRP_GetPlayerPhone", "%d", playerid));
	format(premiumGlobeString, sizeof(premiumGlobeString), "%s\n\t"COLOR5_EMBED"6-9 Cyfr\t\t\t"#COLOR2_EMBED"%d MC", premiumGlobeString, NR_OD6DO9CYFR);
	format(premiumGlobeString, sizeof(premiumGlobeString), "%s\n\t"COLOR5_EMBED"4-5 Cyfr\t\t\t"#COLOR2_EMBED"%d MC", premiumGlobeString, NR_OD4DO5CYFR);
	format(premiumGlobeString, sizeof(premiumGlobeString), "%s\n\t"COLOR5_EMBED"3 Cyfry\t\t\t"#COLOR2_EMBED"%d MC", premiumGlobeString, NR_3CYFROWY);
	format(premiumGlobeString, sizeof(premiumGlobeString), "%s\n\t"COLOR5_EMBED"2 Cyfry\t\t\t"#COLOR2_EMBED"%d MC", premiumGlobeString, NR_2CYFROWY);
	format(premiumGlobeString, sizeof(premiumGlobeString), "%s\n"COLOR4_EMBED"Inne", premiumGlobeString);
	format(premiumGlobeString, sizeof(premiumGlobeString), "%s\n\t"COLOR5_EMBED"Dodatkowy Slot\t\t"#COLOR2_EMBED"%d MC", premiumGlobeString, DODATKOWY_SLOT);

	inline DLG_PREMIUM_MAIN(playerid1, dialogid1, response1, listitem1, string:inputtext1[]) {
		#pragma unused playerid1, dialogid1, inputtext1
		if(!response1) return 1;
		switch(listitem1) {
			case 3: {
				// KUP KONTO PREMIUM
				new kp = CallRemoteFunction("MRP_GetPlayerKP", "d", playerid);
				mc = CallRemoteFunction("MRP_GetPlayerMC", "d", playerid);
				if(kp>0) {
					SendClientMessageE(playerid, COLOR3, "Masz ju¿ KP. Jeœli chcesz je przed³u¿yæ, wróæ tu, gdy wygaœnie.");
					return MRP_ShowPremiumMenu(playerid);
				}
				if(mc < KP_1MIESIAC) {
					SendClientMessageE(playerid, COLOR3, "Nie staæ Ciê na zakup tej us³ugi!");
					return MRP_ShowPremiumMenu(playerid); 
				}
				format(premiumGlobeString, sizeof(premiumGlobeString), ""COLOR5_EMBED"Informacje o koncie premium");
				format(premiumGlobeString, sizeof(premiumGlobeString), "%s\n"COLOR5_EMBED"Kup Konto Premium\t\t"#COLOR2_EMBED"%d MC", premiumGlobeString, KP_1MIESIAC);
				inline DLG_PREMIUM_KPSEL(playerid4, dialogid4, response4, listitem4, string:inputtext4[]) {
					#pragma unused playerid4, dialogid4, inputtext4
					if(!response4) return MRP_ShowPremiumMenu(playerid);
					if(listitem4 == 0) {
						// Info
						new premiumString[1750];
						format(premiumString, sizeof(premiumString), ""COLOR5_EMBED"Konto Premium po zakupie aktywuje siê na koncie na pe³ny miesi¹c.");
						format(premiumString, sizeof(premiumString), "%s\n"COLOR5_EMBED"Po tym czasie wygasa i nale¿y kupiæ je na nowo.", premiumString);
						format(premiumString, sizeof(premiumString), "%s\n\n"COLOR2_EMBED"Przywileje konta premium sprawdziæ mo¿esz na Mrucznik-RP.PL w zak³adce Dotacje", premiumString);
						inline DLG_PREMIUM_NIC(playerid5, dialogid5, response5, listitem5, string:inputtext5[]) {
							#pragma unused playerid5, dialogid5, listitem5, inputtext5, response5
							Dialog_ShowCallback(playerid, using inline DLG_PREMIUM_KPSEL, DIALOG_STYLE_LIST, (""COLOR3_EMBED"Panel Premium -> Konto Premium"), premiumGlobeString, "Ok", "Wstecz");
						}
						Dialog_ShowCallback(playerid, using inline DLG_PREMIUM_NIC, DIALOG_STYLE_MSGBOX, (""COLOR3_EMBED"Panel Premium -> Konto Premium"), premiumString, "Ok"); 
					} else {
						format(premiumGlobeString, sizeof(premiumGlobeString), ""COLOR5_EMBED"Czy na pewno jesteœ zainteresowany kupnem KONTA PREMIUM?\nWa¿noœæ Konta Premium to 1 pe³ny miesi¹c od daty zakupu\n\nCena za konto premium to: "#COLOR2_EMBED"%d MruCoins", KP_1MIESIAC);
						inline DLG_PREMIUM_KPSURE(playerid6, dialogid6, response6, listitem6, string:inputtext6[]) {
							#pragma unused playerid6, dialogid6, listitem6, inputtext6
							if(!response6) return MRP_ShowPremiumMenu(playerid);
							mc = CallRemoteFunction("MRP_GetPlayerMC", "d", playerid);
							if(mc < KP_1MIESIAC) {
								SendClientMessageE(playerid, COLOR3, "Nie staæ Ciê na zakup tej us³ugi, oszukisto!");
								return MRP_ShowPremiumMenu(playerid); 
							}

							CallRemoteFunction("MRP_SetPlayerMC", "dd", playerid, mc - KP_1MIESIAC);
							CallRemoteFunction("MRP_GiveKP", "dd", playerid, gettime()+2682000);

							format(sukces, sizeof(sukces), ""COLOR5_EMBED"Dziêkujemy za zakupy! Sta³eœ siê posiadaczem Konta Premium!\nKonto Premium wygasa po jednym miesi¹cu, bêdziesz je móg³ przed³u¿yæ");
							format(sukces, sizeof(sukces), "%s\n"COLOR5_EMBED"Pomoc dot. Konta Premium uzyskaæ mo¿esz w komendzie /pomoc w nowej zak³adce na samym dole!\n\n"COLOR5_EMBED"Pobrano "#COLOR2_EMBED"%d MruCoins "#COLOR5_EMBED"z Twojego konta! Pozosta³o Ci "#COLOR2_EMBED"%d MruCoins", sukces, KP_1MIESIAC, CallRemoteFunction("MRP_GetPlayerMC", "d", playerid));
							Dialog_Show(playerid, DIALOG_STYLE_MSGBOX, (""COLOR3_EMBED"Panel Premium -> Kup Konto Premium"), sukces, "Ok", "");

							//return MRP_ShowPremiumMenu(playerid);
						}
						Dialog_ShowCallback(playerid, using inline DLG_PREMIUM_KPSURE, DIALOG_STYLE_MSGBOX, (""COLOR3_EMBED"Panel Premium -> Kup Konto Premium"), premiumGlobeString, "Kupujê", "Anuluj"); 
					}
				}
				Dialog_ShowCallback(playerid, using inline DLG_PREMIUM_KPSEL, DIALOG_STYLE_LIST, (""COLOR3_EMBED"Panel Premium -> Konto Premium"), premiumGlobeString, "Ok", "Wstecz");
			}
			case 10: {
				// DODATKOWY SLOT
				mc = CallRemoteFunction("MRP_GetPlayerMC", "%d", playerid);
				if(mc < DODATKOWY_SLOT) {
					SendClientMessageE(playerid, COLOR3, "Nie staæ Ciê na zakup tej us³ugi! ");
					return MRP_ShowPremiumMenu(playerid); 
				}
				new sloty = CallRemoteFunction("MRP_GetPlayerCarSlots", "d", playerid);
				//SendClientMessageF(playerid, COLOR3, "A %d / %d / %d", sloty, LIMIT_SLOTOW, LIMIT_SLOTOW+1);
				if(sloty == LIMIT_SLOTOW) {
					SendClientMessageE(playerid, COLOR3, "Osi¹gn¹³eœ limit slotów czyli 10!");
					return MRP_ShowPremiumMenu(playerid); 
				}
				format(premiumGlobeString, sizeof(premiumGlobeString), ""COLOR5_EMBED"Czy na pewno jesteœ zainteresowany kupnem DODATKOWEGO SLOTU NA POJAZD?\nBêdzie to Twój slot nr. %d\n\nCena za numer telefonu to: "#COLOR2_EMBED"%d MruCoins", sloty+1, DODATKOWY_SLOT);
				inline DLG_PREMIUM_SLOTIFSURE(playerid3, dialogid3, response3, listitem3, string:inputtext3[]) {
					#pragma unused playerid3, dialogid3, listitem3, inputtext3
					if(!response3) return MRP_ShowPremiumMenu(playerid);
					mc = CallRemoteFunction("MRP_GetPlayerMC", "d", playerid);
					if(mc < DODATKOWY_SLOT) {
						SendClientMessageE(playerid, COLOR3, "Nie staæ Ciê na zakup tej us³ugi, oszukisto!");
						return MRP_ShowPremiumMenu(playerid); 
					}

					sloty = CallRemoteFunction("MRP_GetPlayerCarSlots", "d", playerid);
					sloty++;

					CallRemoteFunction("MRP_SetPlayerMC", "dd", playerid, mc - DODATKOWY_SLOT);
					CallRemoteFunction("MRP_SetPlayerCarSlots", "dd", playerid, sloty);

					/*SendClientMessageF(playerid, COLOR3, "Dziêkujemy za zakupy! Posiadasz teraz %d %s", sloty, (sloty < 5) ? ("sloty") : ("slotów"));
					SendClientMessageF(playerid, COLOR3, "Pobrano %d z Twojego konta! Pozosta³o Ci %d MC.", DODATKOWY_SLOT, CallRemoteFunction("MRP_GetPlayerMC", "d", playerid)); */
					format(sukces, sizeof(sukces), ""COLOR5_EMBED"Dziêkujemy za zakupy! Dokupi³eœ sobie jeden slot!\n\nPosiadasz teraz "COLOR5_EMBED"%d "COLOR5_EMBED"%s", sloty, (sloty < 5) ? ("sloty") : ("slotów"));
					format(sukces, sizeof(sukces), "%s\n"COLOR5_EMBED"\n\n"COLOR5_EMBED"Pobrano "#COLOR2_EMBED"%d MruCoins "COLOR5_EMBED"z Twojego konta! Pozosta³o Ci "#COLOR2_EMBED"%d MruCoins", sukces, DODATKOWY_SLOT, CallRemoteFunction("MRP_GetPlayerMC", "d", playerid));
					Dialog_Show(playerid, DIALOG_STYLE_MSGBOX, (""COLOR3_EMBED"Panel Premium -> Kup Dodatkowy Slot"), sukces, "Ok", "");
					//return MRP_ShowPremiumMenu(playerid);
				}
				Dialog_ShowCallback(playerid, using inline DLG_PREMIUM_SLOTIFSURE, DIALOG_STYLE_MSGBOX, (""COLOR3_EMBED"Panel Premium -> Kup Dodatkowy Slot"), premiumGlobeString, "Kupujê", "Anuluj"); 
			}
			case 5..8: {
				// NR TEL
				new typ = listitem1-5;
				mc = CallRemoteFunction("MRP_GetPlayerMC", "d", playerid);
				if(mc < NR_CENY[typ]) {
					SendClientMessageE(playerid, COLOR3, "Nie staæ Ciê na zakup tej us³ugi! ");
					return MRP_ShowPremiumMenu(playerid); 
				}
				format(premiumGlobeString, sizeof(premiumGlobeString), ""COLOR5_EMBED"Wpisz tutaj Numer Telefonu, którego zakupem jesteœ zainteresowany.\nSystem sprawdzi, czy jest on dostêpny\n\nCena za numer telefonu to: "#COLOR2_EMBED"%d MruCoins", NR_CENY[typ]);
				inline DLG_PREMIUM_NUMBCHECK(playerid2, dialogid2, response2, listitem2, string:inputtext2[]) {
					#pragma unused playerid2, dialogid2, listitem2
					if(!response2) return MRP_ShowPremiumMenu(playerid);
					if(tryingSql(inputtext2)) return MRP_ShowPremiumMenu(playerid);
					if(!IsNumeric(inputtext2)) {
						SendClientMessageE(playerid, COLOR3, "W pole Numer Telefonu musisz wpisaæ cyfry!");
						return MRP_ShowPremiumMenu(playerid);
					}
					new nr[20];
					filterSqli(inputtext2, nr);
					new nrTele = strval(nr);
					new len = strlen(nrTele);
					if(nrTele < 0) return SendClientMessageE(playerid, COLOR3, "Numer nie mo¿e byæ na minusie!");
					if(typ == 0 && (len < 6 || len > 9)) {
						SendClientMessageE(playerid, COLOR3, "D³ugoœæ numeru nie zgadza siê z wymogami us³ugi");
						SendClientMessageE(playerid, COLOR3, "Wpisz numer o d³ugoœci od 6 do 9 cyfr");
						return Dialog_ShowCallback(playerid, using inline DLG_PREMIUM_NUMBCHECK, DIALOG_STYLE_INPUT, (""COLOR3_EMBED"Panel Premium -> Kup Nr. Telefonu"), premiumGlobeString, "Ok", "Wstecz"); 
					} else if(typ == 1 && (len < 4 ||len > 5)) {
						SendClientMessageE(playerid, COLOR3, "D³ugoœæ numeru nie zgadza siê z wymogami us³ugi");
						SendClientMessageE(playerid, COLOR3, "Wpisz numer o d³ugoœci od 4 do 5 cyfr");
						return Dialog_ShowCallback(playerid, using inline DLG_PREMIUM_NUMBCHECK, DIALOG_STYLE_INPUT, (""COLOR3_EMBED"Panel Premium -> Kup Nr. Telefonu"), premiumGlobeString, "Ok", "Wstecz"); 
					} else if(typ == 2 && (len < 3 || len > 3)) {
						SendClientMessageE(playerid, COLOR3, "D³ugoœæ numeru nie zgadza siê z wymogami us³ugi");
						SendClientMessageE(playerid, COLOR3, "Wpisz numer o d³ugoœci 3 cyfr");
						return Dialog_ShowCallback(playerid, using inline DLG_PREMIUM_NUMBCHECK, DIALOG_STYLE_INPUT, (""COLOR3_EMBED"Panel Premium -> Kup Nr. Telefonu"), premiumGlobeString, "Ok", "Wstecz"); 
					} else if(typ == 3 && (len < 2 || len > 2)) {
						SendClientMessageE(playerid, COLOR3, "D³ugoœæ numeru nie zgadza siê z wymogami us³ugi");
						SendClientMessageE(playerid, COLOR3, "Wpisz numer o 2 cyfr");
						return Dialog_ShowCallback(playerid, using inline DLG_PREMIUM_NUMBCHECK, DIALOG_STYLE_INPUT, (""COLOR3_EMBED"Panel Premium -> Kup Nr. Telefonu"), premiumGlobeString, "Ok", "Wstecz"); 
					}

					new zajety = CallRemoteFunction("MRP_IsPhoneNumberAvailable", "d", nrTele);
					if(zajety) {
						SendClientMessageE(playerid, COLOR3, "Numer jest ju¿ zajêty! Wpisz inny lub anuluj.");
						return Dialog_ShowCallback(playerid, using inline DLG_PREMIUM_NUMBCHECK, DIALOG_STYLE_INPUT, (""COLOR3_EMBED"Panel Premium -> Kup Nr. Telefonu"), premiumGlobeString, "Ok", "Wstecz"); 
					}

					mc = CallRemoteFunction("MRP_GetPlayerMC", "d", playerid);
					if(mc < NR_CENY[typ]) {
						SendClientMessageE(playerid, COLOR3, "Nie staæ Ciê na zakup tej us³ugi, oszukisto!");
						return MRP_ShowPremiumMenu(playerid); 
					}

					CallRemoteFunction("MRP_SetPlayerMC", "dd", playerid, mc-NR_CENY[typ]);
					CallRemoteFunction("MRP_SetPlayerPhone", "dd", playerid, nrTele);

					/*SendClientMessageF(playerid, COLOR3, "Dziêkujemy za zakupy! Twój nowy numer telefonu to: %d", nrTele);
					SendClientMessageF(playerid, COLOR3, "Pobrano %d z Twojego konta! Pozosta³o Ci %d MC.", NR_CENY[typ], CallRemoteFunction("MRP_GetPlayerMC", "d", playerid)); */
					format(sukces, sizeof(sukces), ""COLOR5_EMBED"Dziêkujemy za zakupy! Zakupi³eœ sobie nowy numer!\n\nTwój nowy numer telefonu: "COLOR2_EMBED"%d", nrTele);
					format(sukces, sizeof(sukces), "%s\n"COLOR5_EMBED"\n\n"COLOR5_EMBED"Pobrano "#COLOR2_EMBED"%d MruCoins "COLOR5_EMBED"z Twojego konta! Pozosta³o Ci "#COLOR2_EMBED"%d MruCoins", sukces, DODATKOWY_SLOT, CallRemoteFunction("MRP_GetPlayerMC", "d", playerid));
					//ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, (""COLOR3_EMBED"Panel Premium -> Kup Nr. Telefonu"), sukces, "Ok", "");
					Dialog_Show(playerid, DIALOG_STYLE_MSGBOX, (""COLOR3_EMBED"Panel Premium -> Kup Nr. Telefonu"), sukces, "Ok", "");

					//return MRP_ShowPremiumMenu(playerid);
				}
				Dialog_ShowCallback(playerid, using inline DLG_PREMIUM_NUMBCHECK, DIALOG_STYLE_INPUT, (""COLOR3_EMBED"Panel Premium -> Kup Nr. Telefonu"), premiumGlobeString, "Ok", "Wstecz"); 
			}
			default: return MRP_ShowPremiumMenu(playerid);
		}

	}
	Dialog_ShowCallback(playerid, using inline DLG_PREMIUM_MAIN, DIALOG_STYLE_LIST, (""COLOR3_EMBED"Mrucznik-RP -> Panel Premium"), premiumGlobeString, "Ok", "WyjdŸ");
	return 1;
}

//SEC_Dodatki_Show


#define 				TYP_CZAPKA				1
#define 				TYP_ZEGAREK				2
#define 				TYP_OKULARY				3


#define 				PRICETYPE_MC			0
#define 				PRICETYPE_KK			1


#define 				LIST_ZWYKLE				1

enum e_AddonData
{
	aCategory,
	aModel,
	aPrice,
	aPriceType,
	aBone,
	Float:aPosX,
	Float:aPosY,
	Float:aPosZ,
	Float:aRotX,
	Float:aRotY,
	Float:aRotZ
}
// TYP SKLEPU (/z /kupdodatki listitem) | Model | cena | cena typ (0 mc 1 kk) | bone | potem xyz i rotacja

new dodatki[][e_AddonData] = {
	{0, 18967, 2000000, 1, 2, 0.140852, 0.013641, 0.0, 112.626106, 95.035888, 0.0},
	{0, 18968, 2000000, 1, 2, 0.140852, 0.013641, 0.0, 112.626106, 95.035888, 0.0},
	{0, 18969, 2000000, 1, 2, 0.140852, 0.013641, 0.0, 112.626106, 95.035888, 0.0},
	{0, 19031, 2000000, 1, 2, 0.08, 0.043, 0.0, 100.0, 90.0, -10.0},
	{0, 19064, 6500000, 1, 2, 0.140852, 0.013641, 0.0, 112.626106, 95.035888, 0.0},
	{0, 18944, 2000000, 1, 2, 0.140852, 0.013641, 0.0, 112.626106, 95.035888, 0.0},
	//19047
	{0, 19046, 8500000, 1, 6, -0.032099, -0.015371, 0.009, -108.3, -114.4, 88.3},
	{0, 19047, 6000000, 1, 6, -0.032099, -0.015371, 0.009, -108.3, -114.4, 88.3}
};


getFreeSlot(playerid) {
	new kp = CallRemoteFunction("MRP_GetPlayerKP", "d", playerid);
	new j = SLOT_3RD;
	if(kp > 0) j = SLOT_PREMIUM;
	for(new i=SLOT_1ST; i<j+1; i++) {
		if(!IsPlayerAttachedObjectSlotUsed(playerid, i)) return i;
	}
	return INVALID_SLOT;
}

/*
	itemOwner,
	itemModel,
	itemUid,
	Float:itemx,	
	Float:itemy,
	Float:itemz,
	Float:itemrx,
	Float:itemry,
	Float:itemrz,
	Float:itemsx,
	Float:itemsy,
	Float:itemsz,
	itemActive
*/

////CallRemoteFunction("SEC_MyItems_HandleItems", "dddfffffffffd", playerid, model, uid, x, y, z, rx, ry, rz, sx, sy, sz, active);
forward SEC_MyItems_HandleItems(playerid, model, uid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, Float:sx, Float:sy, Float:sz, active, bone);
public SEC_MyItems_HandleItems(playerid, model, uid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, Float:sx, Float:sy, Float:sz, active, bone) {
	SendClientMessageF(playerid, COLOR5, "Wczytano na %d: %d|%d|%d|%f|%f|%f|%f|%f|%f|%f|%f|%f|%d|%d|%d", dodatkow[playerid], playerid, model, uid, x, y, z, rx, ry, rz, sx, sy, sz, active, bone);

	itemCache[playerid][dodatkow[playerid]][itemOwner] = playerid;
	itemCache[playerid][dodatkow[playerid]][itemModel] = model;
	itemCache[playerid][dodatkow[playerid]][itemUid] = uid;
	itemCache[playerid][dodatkow[playerid]][itemx] = x;
	itemCache[playerid][dodatkow[playerid]][itemy] = y;
	itemCache[playerid][dodatkow[playerid]][itemz] = z;
	itemCache[playerid][dodatkow[playerid]][itemrx] = rx;
	itemCache[playerid][dodatkow[playerid]][itemry] = ry;
	itemCache[playerid][dodatkow[playerid]][itemrz] = rz;
	itemCache[playerid][dodatkow[playerid]][itemsx] = sx;
	itemCache[playerid][dodatkow[playerid]][itemsy] = sy;
	itemCache[playerid][dodatkow[playerid]][itemsz] = sz;
	itemCache[playerid][dodatkow[playerid]][itemActive] = active;
	itemCache[playerid][dodatkow[playerid]][itemBone] = bone;
	itemCache[playerid][dodatkow[playerid]][itemActiveCache] = 0;
	itemCache[playerid][dodatkow[playerid]][actuallyRemoved] = 0;
	dodatkow[playerid]++;
}
onPlayerBoughtAddon(playerid, modelid, itemid) {
	new id = CallRemoteFunction("MRP_CreatePlayerAttachedItem", "ddffffffd", playerid, modelid, dodatki[itemid][aPosX], dodatki[itemid][aPosY], dodatki[itemid][aPosZ], dodatki[itemid][aRotX], dodatki[itemid][aRotY], dodatki[itemid][aRotZ],  dodatki[itemid][aBone]);
	SEC_MyItems_HandleItems(playerid, modelid, id, dodatki[itemid][aPosX], dodatki[itemid][aPosY], dodatki[itemid][aPosZ], dodatki[itemid][aRotX], dodatki[itemid][aRotY], dodatki[itemid][aRotZ], 1.0, 1.0, 1.0, 0, dodatki[itemid][aBone]);
}

MSelectResponse:SelectNormalnyDodatek(playerid, MSelectType:response, itemid, modelid) 
{ 
	if(GetPVarInt(playerid, "premium-wybiera")) return 1;
    if (_:response == 2 || _:response == 5) { 
        MSelect_Close(playerid); 
    } else {
    	if(_:response == _:MSelect_Item) {
    		if(GetPVarInt(playerid, "dodatki-selectDelay") > gettime()) return 1;
    		SetPVarInt(playerid, "premium-wybiera", 1);
			new string[144]; 
			format(string, sizeof(string), "ID: %d | Type: %d | Item: %d | Model: %d", playerid, _:response, itemid, modelid); 
			SendClientMessage(playerid, -1, string);  
			new typ = dodatki[itemid][aPriceType];
			new kasa;
			if(typ==1) kasa = CallRemoteFunction("MRP_GetPlayerMoney", "d", playerid);
			else kasa = CallRemoteFunction("MRP_GetPlayerMC", "d", playerid);
			new cena = dodatki[itemid][aPrice];
			new model = dodatki[itemid][aModel];
			if(kasa < cena) {
				SetPVarInt(playerid, "premium-wybiera", 0);
				return Dialog_Show(playerid, DIALOG_STYLE_MSGBOX, (""COLOR3_EMBED"Zakup Dodatku"), ""COLOR5_EMBED"Przykro nam, jednak nie staæ Ciê na ten dodatek!", "Ok", "");
			}
			format(premiumGlobeString, sizeof(premiumGlobeString), ""COLOR5_EMBED"Czy na pewno jesteœ zainteresowany kupnem tego dodatku?\nNie bêdziesz mia³ opcji jego odsprzedania, a pieni¹dze przepadn¹.\n\nCena tego dodatku to: "#COLOR2_EMBED"%d %s",(dodatki[itemid][aPrice]) ,(typ == 1) ? ("$") : ("MC"));
			inline DLG_DOD_IFSURE(playerid1, dialogid1, response1, listitem1, string:inputtext1[]) {
				#pragma unused playerid1, dialogid1, listitem1, inputtext1
				SetPVarInt(playerid, "premium-wybiera", 0);
				if(!response1) return 1;
				inline DLG_DOD_KUPIL(playerid2, dialogid2, response2, listitem2, string:inputtext2[]) {
					#pragma unused playerid2, dialogid2, listitem2, inputtext2, response2
					onPlayerBoughtAddon(playerid, model, itemid);
					CallRemoteFunction("MRP_SetPlayerMC", "dd", playerid, kasa - cena);
				}
				MSelect_Close(playerid); 
				format(premiumGlobeString, sizeof(premiumGlobeString), ""COLOR5_EMBED"Dziêkujemy za zakupy! Dokona³eœ zakupu dodatku!\n\nKorzystaj¹c z /dodatki mo¿esz teraz u¿ywaæ swojego przedmiotu!");
				format(premiumGlobeString, sizeof(premiumGlobeString), "%s\n"COLOR5_EMBED"\n\n"COLOR5_EMBED"Pobrano "#COLOR2_EMBED"%d %s "COLOR5_EMBED"z Twojego konta! Pozosta³o Ci "#COLOR2_EMBED"%d %s", premiumGlobeString, (dodatki[itemid][aPrice]) ,(typ == 1) ? ("$") : ("MC"), (typ == 1) ? (CallRemoteFunction("MRP_GetPlayerMoney", "d", playerid)) : (CallRemoteFunction("MRP_GetPlayerMC", "d", playerid)) ,(typ == 1) ? ("$") : ("MC"));
				Dialog_ShowCallback(playerid, using inline DLG_DOD_KUPIL, DIALOG_STYLE_MSGBOX, (""COLOR3_EMBED"Zakup Dodatku"), premiumGlobeString, "Okej", ""); 
			}
			Dialog_ShowCallback(playerid, using inline DLG_DOD_IFSURE, DIALOG_STYLE_MSGBOX, (""COLOR3_EMBED"Zakup Dodatku"), premiumGlobeString, "Kupujê", "Anuluj"); 
    	}
    }
    return 1; 
}  


forward SEC_Dodatki_Show(playerid, listitem);
public SEC_Dodatki_Show(playerid, listitem) {
		SendClientMessageF(playerid, COLOR5, "Wybra³eœ %d", listitem);
	//if(listitem == 0) {
		// Zwyk³e dodatkti
		new dod, modele[sizeof(dodatki)], opisy[sizeof(dodatki)][50];
		//ShowModelSelectionMenuEx(playerid, items_array[], item_amount, header_text[], extraid, Float:Xrot = 0.0, Float:Yrot = 0.0, Float:Zrot = 0.0, Float:mZoom = 1.0, dialogBGcolor = 0x4A5A6BBB, previewBGcolor = 0x88888899 , tdSelectionColor = 0xFFFF00AA)
		for(new i; i < sizeof(dodatki); i++) {
			if(dodatki[i][aCategory] == listitem) {
				dod++;
				modele[i] = dodatki[i][aModel];
				format(opisy[i], 50, "%d %s", dodatki[i][aPrice], (dodatki[i][aPriceType] == 1) ? ("$") : ("MC"));
			}
		}
		if(dod>0) {
			SetPVarInt(playerid, "dodatki-selectDelay", gettime()+1);
			MSelect_Open(playerid,MSelect:SelectNormalnyDodatek, modele, opisy, dod, .header = "WYBIERZ DODATEK");
		}		
	//}
}


CMD:dodtest(playerid, params[]) {
	SendClientMessageF(playerid, COLOR5, "Masz slota %d", dodatkow[playerid]);
	new uid = strval(params);
	new slot = getFreeSlot(playerid);
	if(slot == INVALID_SLOT) return SendClientMessage(playerid, COLOR5, "Error");
	if(uid && slot != INVALID_SLOT) return SetPlayerAttachedObject(playerid, slot, itemCache[playerid][uid][itemModel], itemCache[playerid][uid][itemBone], itemCache[playerid][uid][itemx], itemCache[playerid][uid][itemy], itemCache[playerid][uid][itemz], itemCache[playerid][uid][itemrx], itemCache[playerid][uid][itemry], itemCache[playerid][uid][itemrz], itemCache[playerid][uid][itemsx], itemCache[playerid][uid][itemsy], itemCache[playerid][uid][itemsz]);
}

CMD:zxca(playerid) {
	RemovePlayerAttachedObject(playerid, 0);
	RemovePlayerAttachedObject(playerid, 1);
	RemovePlayerAttachedObject(playerid, 2);
	RemovePlayerAttachedObject(playerid, 3);
	RemovePlayerAttachedObject(playerid, 4);
	RemovePlayerAttachedObject(playerid, 5);
	RemovePlayerAttachedObject(playerid, 6);
	RemovePlayerAttachedObject(playerid, 7);
	RemovePlayerAttachedObject(playerid, 8);
	RemovePlayerAttachedObject(playerid, 9);
}

forward SEC_MyItems_Reattach(playerid);
public SEC_MyItems_Reattach(playerid) {
	RemovePlayerAttachedObject(playerid, SLOT_1ST);
	RemovePlayerAttachedObject(playerid, SLOT_2ND);
	RemovePlayerAttachedObject(playerid, SLOT_3RD);
	RemovePlayerAttachedObject(playerid, SLOT_PREMIUM);
	for(new i=0; i<MAX_ITEMS; i++) {
		if(itemCache[playerid][i][itemModel] > 0) {
			itemCache[playerid][i][itemActiveCache] = 0;
		}
	}
	for(new i=0; i<MAX_ITEMS; i++) {
		if(itemCache[playerid][i][itemActive]) {
			new slot = getFreeSlot(playerid);
			if(slot != INVALID_SLOT) {
				SetPlayerAttachedObject(playerid, slot, itemCache[playerid][i][itemModel], itemCache[playerid][i][itemBone], itemCache[playerid][i][itemx], itemCache[playerid][i][itemy], itemCache[playerid][i][itemz], itemCache[playerid][i][itemrx], itemCache[playerid][i][itemry], itemCache[playerid][i][itemrz], itemCache[playerid][i][itemsx], itemCache[playerid][i][itemsy], itemCache[playerid][i][itemsz]);
				SendClientMessageF(playerid, COLOR5, "Przywrócono Twój dodatek o UID %d", itemCache[playerid][i][itemUid]);
				itemCache[playerid][i][itemActiveCache] = 1;
				itemCache[playerid][i][itemOnSlot] = slot;
			}
		} 
	}
}

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ) {
	new itemid = GetPVarInt(playerid, "itemId-edytuje");
	if(response) {
		itemCache[playerid][itemid][itemx] = fOffsetX;
		itemCache[playerid][itemid][itemy] = fOffsetY;
		itemCache[playerid][itemid][itemz] = fOffsetZ;
		itemCache[playerid][itemid][itemrx] = fRotX;
		itemCache[playerid][itemid][itemry] = fRotY;
		itemCache[playerid][itemid][itemrz] = fRotZ;
		itemCache[playerid][itemid][itemsx] = 1.0;
		itemCache[playerid][itemid][itemsy] = 1.0;
		itemCache[playerid][itemid][itemsz] = 1.0;
		itemCache[playerid][itemid][itemActive] = 1;
		itemCache[playerid][itemid][itemBone] = boneid;
		CallRemoteFunction("MRP_UpdateAttachedItem", "ddffffffddd", playerid, itemCache[playerid][itemid][itemModel], itemCache[playerid][itemid][itemx], itemCache[playerid][itemid][itemy], itemCache[playerid][itemid][itemz], itemCache[playerid][itemid][itemrx], itemCache[playerid][itemid][itemry], itemCache[playerid][itemid][itemrz], itemCache[playerid][itemid][itemBone], itemCache[playerid][itemid][itemActiveCache], itemCache[playerid][itemid][itemUid]);
		RemovePlayerAttachedObject(playerid, itemCache[playerid][itemid][itemOnSlot]);
		SetPlayerAttachedObject(playerid, itemCache[playerid][itemid][itemOnSlot], itemCache[playerid][itemid][itemModel], itemCache[playerid][itemid][itemBone], itemCache[playerid][itemid][itemx], itemCache[playerid][itemid][itemy], itemCache[playerid][itemid][itemz], itemCache[playerid][itemid][itemrx], itemCache[playerid][itemid][itemry], itemCache[playerid][itemid][itemrz], itemCache[playerid][itemid][itemsx], itemCache[playerid][itemid][itemsy], itemCache[playerid][itemid][itemsz]);
	} else {
		RemovePlayerAttachedObject(playerid, itemCache[playerid][itemid][itemOnSlot]);
		SetPlayerAttachedObject(playerid, itemCache[playerid][itemid][itemOnSlot], itemCache[playerid][itemid][itemModel], itemCache[playerid][itemid][itemBone], itemCache[playerid][itemid][itemx], itemCache[playerid][itemid][itemy], itemCache[playerid][itemid][itemz], itemCache[playerid][itemid][itemrx], itemCache[playerid][itemid][itemry], itemCache[playerid][itemid][itemrz], itemCache[playerid][itemid][itemsx], itemCache[playerid][itemid][itemsy], itemCache[playerid][itemid][itemsz]);
	}
}

MSelectResponse:opcjeDodatkow(playerid, MSelectType:response, itemid, modelid)  {
    if (_:response == 2 || _:response == 5) { 
        MSelect_Close(playerid); 
    } else {
    	// kod w³aœciwy
    	if(_:response == _:MSelect_Item) {
    		inline DLG_ADDONMAIN(playerid1, dialogid1, response1, listitem1, string:inputtext1[]) {
    			#pragma unused playerid1, dialogid1, inputtext1
    			/*
    			SetPlayerAttachedObject(playerid, slot, itemCache[playerid][i][itemModel], itemCache[playerid][i][itemBone], itemCache[playerid][i][itemx], itemCache[playerid][i][itemy], itemCache[playerid][i][itemz], itemCache[playerid][i][itemrx], itemCache[playerid][i][itemry], itemCache[playerid][i][itemrz], itemCache[playerid][i][itemsx], itemCache[playerid][i][itemsy], itemCache[playerid][i][itemsz]);
				SendClientMessageF(playerid, COLOR5, "Przywrócono Twój dodatek o UID %d", itemCache[playerid][i][itemUid]);
				itemCache[playerid][i][itemActiveCache] = 1;
				itemCache[playerid][i][itemOnSlot] = slot;
    			*/
				if(!response1) return 1;
				if(listitem1 == 1) {
					// edycja
					if(itemCache[playerid][itemid][actuallyRemoved] == 1) return SendClientMessageF(playerid, COLOR5, "Dodatek %d usuniêty! Po ponownym wejœciu zniknie", itemCache[playerid][itemid][itemUid]);
					if(itemCache[playerid][itemid][itemActiveCache] == 1) {
						MSelect_Close(playerid); 
						EditAttachedObject(playerid, itemCache[playerid][itemid][itemOnSlot]);
						SetPVarInt(playerid, "itemId-edytuje", itemid);
					} else {
						return SendClientMessageF(playerid, COLOR5, "Za³ó¿ dodatek %d aby móc go edytowaæ!", itemCache[playerid][itemid][itemUid]);
					}
				} else if(listitem1==2) {
					// z³omowanie dodatku
					if(itemCache[playerid][itemid][itemActiveCache] == 1) {
						SendClientMessageF(playerid, COLOR5, "Zdejmij najpierw dodatek %d, aby go usun¹æ!", itemCache[playerid][itemid][itemUid]);
					}
					itemCache[playerid][itemid][actuallyRemoved] = 1;

					if(itemCache[playerid][itemid][actuallyRemoved] == 1) return SendClientMessageF(playerid, COLOR5, "Dodatek %d usuniêty! Po ponownym wejœciu zniknie", itemCache[playerid][itemid][itemUid]);
				} else {
					if(itemCache[playerid][itemid][itemActiveCache] == 1) {
						RemovePlayerAttachedObject(playerid, itemCache[playerid][itemid][itemOnSlot]);
						SendClientMessageF(playerid, COLOR5, "Zdj¹³eœ dodatek %d", itemCache[playerid][itemid][itemUid]);
						itemCache[playerid][itemid][itemActiveCache] = 0;
						itemCache[playerid][itemid][itemOnSlot] = INVALID_SLOT;
					} else {
						if(itemCache[playerid][itemid][actuallyRemoved] == 1) return SendClientMessageF(playerid, COLOR5, "Dodatek %d usuniêty! Po ponownym wejœciu zniknie", itemCache[playerid][itemid][itemUid]);
						new slot = getFreeSlot(playerid);
						if(slot == INVALID_SLOT) {
							SendClientMessageF(playerid, COLOR5, "Brak wolnych slotów na dodatek %d, zdejmij najpierw inne!", itemCache[playerid][itemid][itemUid]);
							return 1;
						}
						SetPlayerAttachedObject(playerid, slot, itemCache[playerid][itemid][itemModel], itemCache[playerid][itemid][itemBone], itemCache[playerid][itemid][itemx], itemCache[playerid][itemid][itemy], itemCache[playerid][itemid][itemz], itemCache[playerid][itemid][itemrx], itemCache[playerid][itemid][itemry], itemCache[playerid][itemid][itemrz], itemCache[playerid][itemid][itemsx], itemCache[playerid][itemid][itemsy], itemCache[playerid][itemid][itemsz]);
						SendClientMessageF(playerid, COLOR5, "Za³o¿y³eœ dodatek %d", itemCache[playerid][itemid][itemUid]);
						itemCache[playerid][itemid][itemActiveCache] = 1;
						itemCache[playerid][itemid][itemOnSlot] = slot;
					}
					CallRemoteFunction("MRP_UpdateAttachedItem", "ddffffffddd", playerid, itemCache[playerid][itemid][itemModel], itemCache[playerid][itemid][itemx], itemCache[playerid][itemid][itemy], itemCache[playerid][itemid][itemz], itemCache[playerid][itemid][itemrx], itemCache[playerid][itemid][itemry], itemCache[playerid][itemid][itemrz], itemCache[playerid][itemid][itemBone], itemCache[playerid][itemid][itemActiveCache], itemCache[playerid][itemid][itemUid]);
					MSelect_Close(playerid);
					SEC_MyItems_Show(playerid);
				}
    		}
    		format(premiumGlobeString, sizeof(premiumGlobeString), ""COLOR4_EMBED"%s dodatek", (itemCache[playerid][itemid][itemActiveCache] == 1) ? ("Zdejmij") : ("Za³ó¿"));
    		format(premiumGlobeString, sizeof(premiumGlobeString), "%s\n"COLOR4_EMBED"Edytuj dodatek\n"COLOR4_EMBED"Z³omuj dodatek", premiumGlobeString);
    		Dialog_ShowCallback(playerid, using inline DLG_ADDONMAIN, DIALOG_STYLE_LIST, ("Zarz¹dzanie Dodatkiem"), premiumGlobeString, "Ok", "Anuluj");
    	}
    }
	return 1;
}

CMD:pdc(playerid) {
	SEC_MyItems_Reattach(playerid);
	return 1;
}

forward SEC_MyItems_Show(playerid);
public SEC_MyItems_Show(playerid) {
	new dod = 0, modele[MAX_ITEMS], opisy[MAX_ITEMS][20];
	for(new i=0; i<MAX_ITEMS; i++) {
		if(itemCache[playerid][i][itemModel] > 0) {
			modele[i] = itemCache[playerid][i][itemModel];
			format(opisy[i], 20, "");
			if(itemCache[playerid][i][itemActiveCache] == 1) {
				format(opisy[i], 20, "AKTYWNY");
			}
			dod++;
		}
	}
	//ShowPlayerPreviewModelDialog(playerid,  1274, DIALOG_STYLE_PREVMODEL, "Posiadane dodatki", modele, opisy, "Opcje", "Wyjdz");
	MSelect_Open(playerid,MSelect:opcjeDodatkow, modele, opisy, dod, .header = "TWOJE DODATKI");
}

/*
new models[] = {0, 1, 2, 3, 4, 5, 6, 7};
new labels[][] = {"CJ", "skin1", "skin2", "skin3", "skin4", "skin5", "skin6", "skin7"};

ShowPlayerPreviewModelDialog(playerid, 0, DIALOG_STYLE_PREVMODEL, "Skin selection", models, labels, "Select", "Cancel");
*/