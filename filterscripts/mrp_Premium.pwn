#include <a_samp>
#include <crashdetect>
#include <code-parse.inc>    
#include <YSI\YSI\y_inline>
#include <YSI\YSI\y_dialog>
#include <mysql_R5>
#include <zcmd>

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

							//SendClientMessageF(playerid, COLOR3, "Dziêkujemy za zakupy! Posiadasz teraz %d %s", sloty, (sloty < 5) ? ("sloty") : ("slotów"));
							SendClientMessageF(playerid, COLOR3, "Pobrano %d z Twojego konta! Pozosta³o Ci %d MC.", KP_1MIESIAC, CallRemoteFunction("MRP_GetPlayerMC", "d", playerid));

							return MRP_ShowPremiumMenu(playerid);
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

					SendClientMessageF(playerid, COLOR3, "Dziêkujemy za zakupy! Posiadasz teraz %d %s", sloty, (sloty < 5) ? ("sloty") : ("slotów"));
					SendClientMessageF(playerid, COLOR3, "Pobrano %d z Twojego konta! Pozosta³o Ci %d MC.", DODATKOWY_SLOT, CallRemoteFunction("MRP_GetPlayerMC", "d", playerid));

					return MRP_ShowPremiumMenu(playerid);
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
					new len = strlen(nr);
					new nrTele = strval(nr);
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

					SendClientMessageF(playerid, COLOR3, "Dziêkujemy za zakupy! Twój nowy numer telefonu to: %d", nrTele);
					SendClientMessageF(playerid, COLOR3, "Pobrano %d z Twojego konta! Pozosta³o Ci %d MC.", NR_CENY[typ], CallRemoteFunction("MRP_GetPlayerMC", "d", playerid));

					return MRP_ShowPremiumMenu(playerid);
				}
				Dialog_ShowCallback(playerid, using inline DLG_PREMIUM_NUMBCHECK, DIALOG_STYLE_INPUT, (""COLOR3_EMBED"Panel Premium -> Kup Nr. Telefonu"), premiumGlobeString, "Ok", "Wstecz"); 
			}
			default: return MRP_ShowPremiumMenu(playerid);
		}

	}
	Dialog_ShowCallback(playerid, using inline DLG_PREMIUM_MAIN, DIALOG_STYLE_LIST, (""COLOR3_EMBED"Mrucznik-RP -> Panel Premium"), premiumGlobeString, "Ok", "WyjdŸ");
	return 1;
}

CMD:premka(playerid) {
	MRP_ShowPremiumMenu(playerid);
	return 1;
}
