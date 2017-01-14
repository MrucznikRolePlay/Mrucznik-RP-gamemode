#include <a_samp>
#include <crashdetect>
#include <code-parse.inc>    
#include <YSI\YSI\y_inline>
#include <YSI\YSI\y_dialog>
#include <zcmd>

#define COLOR1 0xff000007
#define COLOR2 0xff00B7FF
#define COLOR3 0xff49A350
#define COLOR4 0xffF7F7F2
#define COLOR5 0xffE3D8F1

#define COLOR1_EMBED "{000007}" // granat
#define COLOR2_EMBED "{00B7FF}" // niebiedski
#define COLOR3_EMBED "{49A350}" // zielony
#define COLOR4_EMBED "{F7F7F2}" // jasny1
#define COLOR5_EMBED "{E3D8F1}" // jasny2

new premiumGlobeString[7500];

// ceny MC
#define NR_OD6DO9CYFR 	200
#define NR_OD4DO5CYFR 	400
#define NR_3CYFROWY	  	700
#define NR_2CYFROWY	  	1000
#define KP_1MIESIAC	  	425
#define KUPNO_ZN	  	375
#define UNIKATOWY_SKIN	670 

// ceny KK
#define UNIKATOWY_SKIN_KK	50000000 // 50kk
#define KUPNO_ZN_KK			35000000



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


public MRP_ShowPremiumMenu(playerid) {
	new mc = CallRemoteFunction("MRP_GetPlayerMC", "%d", playerid);
	format(premiumGlobeString, sizeof(premiumGlobeString), ""COLOR4_EMBED"Iloœæ MruCoins: \t\t"#COLOR2_EMBED"%d MC", mc);
	format(premiumGlobeString, sizeof(premiumGlobeString), "%s\n\t"COLOR5_EMBED"Kup MruCoins", premiumGlobeString);
	format(premiumGlobeString, sizeof(premiumGlobeString), "%s\n"COLOR4_EMBED"Konto Premium", premiumGlobeString);
	format(premiumGlobeString, sizeof(premiumGlobeString), "%s\n\t"COLOR5_EMBED"Kup Konto Premium", premiumGlobeString);
	format(premiumGlobeString, sizeof(premiumGlobeString), "%s\n"COLOR4_EMBED"Numer Telefonu", premiumGlobeString);
	format(premiumGlobeString, sizeof(premiumGlobeString), "%s\n\t"COLOR5_EMBED"6-9 Cyfr\t\t\t"#COLOR2_EMBED"%d MC", premiumGlobeString, NR_OD6DO9CYFR);
	format(premiumGlobeString, sizeof(premiumGlobeString), "%s\n\t"COLOR5_EMBED"4-5 Cyfr\t\t\t"#COLOR2_EMBED"%d MC", premiumGlobeString, NR_OD4DO5CYFR);
	format(premiumGlobeString, sizeof(premiumGlobeString), "%s\n\t"COLOR5_EMBED"3 Cyfry\t\t\t"#COLOR2_EMBED"%d MC", premiumGlobeString, NR_3CYFROWY);
	format(premiumGlobeString, sizeof(premiumGlobeString), "%s\n\t"COLOR5_EMBED"2 Cyfry\t\t\t"#COLOR2_EMBED"%d MC", premiumGlobeString, NR_2CYFROWY);
	format(premiumGlobeString, sizeof(premiumGlobeString), "%s\n"COLOR4_EMBED"Inne", premiumGlobeString);
	format(premiumGlobeString, sizeof(premiumGlobeString), "%s\n\t"COLOR5_EMBED"Dodatkowe ZN\t\t"#COLOR2_EMBED"%d MC", premiumGlobeString, KUPNO_ZN);
	format(premiumGlobeString, sizeof(premiumGlobeString), "%s\n\t"COLOR5_EMBED"Unikatowy Skin\t\t"#COLOR2_EMBED"%d MC", premiumGlobeString, UNIKATOWY_SKIN);
	inline DLG_PREMIUM_MAIN(playerid1, dialogid1, response1, listitem1, string:inputtext1[]) {
		#pragma unused playerid1, dialogid1, inputtext1
		if(!response1) return 1;
		switch(listitem1) {
			default: return MRP_ShowPremiumMenu(playerid);
		}

	}
	Dialog_ShowCallback(playerid, using inline DLG_PREMIUM_MAIN, DIALOG_STYLE_LIST, (""COLOR3_EMBED"PREMIUM M-RP"), premiumGlobeString, "Ok", "WyjdŸ");
	return 1;
}

CMD:premka(playerid) {
	MRP_ShowPremiumMenu(playerid);
	return 1;
}