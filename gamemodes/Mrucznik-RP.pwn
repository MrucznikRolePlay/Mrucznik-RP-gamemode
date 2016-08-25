//-----------------------------------------[Mapa Mrucznik Role Play]-----------------------------------------//
//----------------------------------------------------*------------------------------------------------------//
//---------------------------------(Stworzona na podstawie mapy The Godfather)-------------------------------//
//-------------------------------------------------(v2.5)----------------------------------------------------//
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
/*

MrucznikÆ Role Play ----> stworzy≥ Mrucznik ----> edycja Jakub 2015

    <-------------------------------------------------------->
    aktualizacja 2.5 system aut mysql, us≥ugi p≥atne
    aktualizacja 2.4.94 prace dorywcze, boomboxy
    aktualizacja 2.4.93 strefy gangÛw
    aktualizacja v 2.4.92 Kubi
    Edit by Kubi - v 2.4.8 noMysql
    <-------------------------------------------------------->
    aktualizacja 7 paüdziernika
    aktualizacja 10.08
    aktualizacja 29.X
    <-------------------------------------------------------->
	Kubi cwel
	aktualizacja 2015.11.15 kryptonim PAèDZIOCH

*/
//----------------------------------------------------*------------------------------------------------------//

//-------------------------------------------<[ Includy ]>---------------------------------------------------//
//-                                                                                                         -//
#include <a_samp>
#include <fixes>
#include <callbacks>
#include <a_http>
#include <utils>
#include <double-o-files2>
#include <foreach>
#include <zcmd>
#include <md5>
#include <nex-ac>
#include <dialogs>
#include <fadescreen>
#include <ACSBM>
#include <YSI\y_safereturn>				// By Bartekdvd & Y_Less: 		http://forum.sa-mp.com/showthread.php?t=456132

//-------<[ Pluginy ]>-------
#include <mapandreas>
#include <crashdetect>					// By Zeex, 4.15.1				https://github.com/Zeex/samp-plugin-crashdetect/releases
#include <sscanf2>						// By Y_Less, 2.8.2:			http://forum.sa-mp.com/showthread.php?t=570927
#define REGEX_ON
#if defined REGEX_ON
#include <libRegEx>						// By Koala818 v0.2				https://github.com/FF-Koala/Regular-Expressions-Plugin
#endif
#include <streamer>						// By Incognito, 2.7.7:			http://forum.sa-mp.com/showthread.php?t=102865
#include <mysql_R5>						// R5

#define VERSION "v2.5.4"

//Modu≥y mapy
#include "modules/definicje.pwn"
#include "modules/kolory.pwn"
#include "modules/forward.pwn"
#include "modules/textdraw.pwn"
#include "modules/enum.pwn"
#include "modules/NOWE_ZMIENNE.pwn"
#include "modules/mru_mysql.pwn"

//Nowe modu≥y .def:
#include "modules\new\bramy\bramy.def"
#include "modules\new\wejscia\wejscia.def"

//Nowe modu≥y .hwn:
#include "modules\new\bramy\bramy.hwn"
#include "modules\new\wejscia\wejscia.hwn"

//Nowe modu≥y .pwn:
#include "modules\new\bramy\bramy.pwn"
#include "modules\new\wejscia\wejscia.pwn"


//------------------------------------------------------------------------------------------------------
main()
{
	print("\n----------------------------------");
	print("M | --- Mrucznik Role Play --- | M");
	print("R | ---        ****        --- | R");
	print("U | ---        v2.5        --- | U");
	print("C | ---        ****        --- | C");
	print("Z | ---    by Mrucznik     --- | Z");
	print("N | ---                    --- | N");
	print("I | ---       /\\_/\\        --- | I");
	print("K | ---   ===( *.* )===    --- | K");
	print("  | ---       \\_^_/        --- |  ");
	print("R | ---         |          --- | R");
	print("P | ---         O          --- | P");
	print("----------------------------------\n");

	//exit;
	WasteDeAMXersTime();
}
//------------------------------------------------------------------------------------------------------

//Inne:
#include "modules/Inne/ibiza.inc"

//System aut
#include "modules/Inne/system_aut.pwn"

#include "modules/Inne/system_kp.pwn"

//EXTERNAL CALLS
#include "modules/Inne/external.pwn"

//Funkcje:
#include "modules/funkcje.pwn"

//Timery:
#include "modules/timery.pwn"

//Obiekty:
#include "modules/obiekty.pwn"

//Samochody/Pickupy/3DTexty:
#include "modules/pickupy.pwn"

//------------------------------------------------------------------------------------------------------

#include "modules/komendy.pwn"

public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
	#if DEBUG == 1
		printf("%s wykonal komende %s", GetNick(playerid), cmdtext);
	#endif
	return 1;
}

public OnPlayerCommandReceived(playerid, cmdtext[])
{
	#if DEBUG == 1
		printf("%s wpisal komende %s", GetNick(playerid), cmdtext);
	#endif
	if(GUIExit[playerid] != 0 || gPlayerLogged[playerid] == 0)
	{
		SendClientMessage(playerid, COLOR_WHITE, "SERWER: "SZARY"Nie jesteú zalogowany/Masz otwarte okno dialogowe!");
		return 0;
	}
    if(GetTickCount() - StaryCzas[playerid] < 100)//antyspam
	{
		SendClientMessage(playerid, COLOR_WHITE, "SERWER: "SZARY"Odczekaj chwilÍ zanim wpiszesz nastÍpnπ komende!");
		return 0;
	}
    if(IsCommandBlocked(cmdtext))
    {
        SendClientMessage(playerid, COLOR_WHITE, "SERWER: "SZARY"Komenda jest wy≥πczona.");
        return 0;
    }
	StaryCzas[playerid] = GetTickCount();
	return 1;
}

//---------------------------<[  OnDialogResponse   ]>--------------------------------------------------
#include "modules/OnDialogResponse.pwn"


public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    if(MaTazer[playerid] == 1 && (GetPlayerWeapon(playerid) == 23 || GetPlayerWeapon(playerid) == 24) && hittype != 1)
    {
    	GameTextForPlayer(playerid, "~r~NIE TRAFILES W GRACZA!~n~~w~TAZER DEZAKTYWOWANY! PRZELADUJ TAZER!", 3000, 5);
		MaTazer[playerid] = 0;
		//PlayerInfo[playerid][pGun2] = 24;
		//GivePlayerWeapon(playerid, 24, PlayerInfo[playerid][pAmmo2]);
		//RemovePlayerAttachedObject(playerid, 9);
	}
    return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	#if DEBUG == 1
		printf("%s[%d] OnPlayerClickTextDraw - begin", GetNick(playerid), playerid);
	#endif
    new str[128];
    if(clickedid == Text:INVALID_TEXT_DRAW)
    {
        if(GetPVarInt(playerid, "gatechose_active") == 1)  //Barierki
        {
            DestroySelectionMenu(playerid);
			SetPVarInt(playerid, "gatechose_active", 0);
			PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
        }
        if(GetPVarInt(playerid, "ng-gatekey") == 1) //NG keypad
        {
            SetPVarInt(playerid, "ng-gatekey", 0);
            TextDrawHideForPlayer(playerid,NG_GateTD[0]);
    		TextDrawHideForPlayer(playerid,NG_GateTD[1]);
    		TextDrawHideForPlayer(playerid,NG_GateTD[2]);
    		TextDrawHideForPlayer(playerid,NG_GateTD[3]);
    		TextDrawHideForPlayer(playerid,NG_GateTD[4]);
    		TextDrawHideForPlayer(playerid,NG_GateTD[5]);
    		TextDrawHideForPlayer(playerid,NG_GateTD[6]);
    		TextDrawHideForPlayer(playerid,NG_GateTD[7]);
            VAR_NGKeypad = false;
        }
        if(GetPVarInt(playerid, "skin-select") == 1) // skin selector
        {
            SetPVarInt(playerid, "skin-select", 0);
            CancelSelectTextDraw(playerid);
            DestroySkinSelection(playerid);
            TogglePlayerControllable(playerid, 1);
        }
    }
    if(GetPVarInt(playerid, "ng-gatekey") == 1)
    {
        new ngkey[6];

        GetPVarString(playerid, "ng-key", ngkey, 6);
        if(strlen(ngkey) < 4)
        {
            new num[2];
            format(num, 2, "%d", _:clickedid - _:NG_GateTD[1] + 1);
            strcat(ngkey, num);
            TextDrawSetString(NG_GateTD[7], ngkey);
            SetPVarString(playerid, "ng-key", ngkey);

            if(strlen(ngkey) == 4) NG_OpenGateWithKey(playerid); //apply key
        }
		#if DEBUG == 1
			printf("%s[%d] OnPlayerClickTextDraw - end", GetNick(playerid), playerid);
		#endif
        return 1;
    }

    //IBIZA
    if(clickedid==Text:INVALID_TEXT_DRAW && GetPVarInt(playerid, "IbizaKamery")) //ESC
	{
		for(new i=0; i<3; i++)
			TextDrawHideForPlayer(playerid, TDIbiza[i]);
		PlayerTextDrawHide(playerid, PlayerText:GetPVarInt(playerid, "IbizaCam"));
		new Float:x, Float:y, Float:z;
		x = GetPVarFloat(playerid, "IbizaKameraX");
		y = GetPVarFloat(playerid, "IbizaKameraY");
		z = GetPVarFloat(playerid, "IbizaKameraZ");
		SetPlayerPosEx(playerid, x, y, z);
		SetPlayerVirtualWorld(playerid, 1);
		SetCameraBehindPlayer(playerid);
        Wchodzenie(playerid);
		DeletePVar(playerid, "IbizaKamery");
		PlayerTextDrawDestroy(playerid, PlayerText:GetPVarInt(playerid, "IbizaCam"));
		DeletePVar(playerid, "IbizaCam");
		#if DEBUG == 1
			printf("%s[%d] OnPlayerClickTextDraw - end", GetNick(playerid), playerid);
		#endif
		return 1;
	}
	else
	{
		new kam = GetPVarInt(playerid, "IbizaKamery");
		if(clickedid==TDIbiza[1]) //w prawo
		{
			kam = (kam==12 ? 1 : kam+1);
			SetPVarInt(playerid, "IbizaKamery", kam);
			IbizaUstawKamere(playerid, kam-1);
		}
		if(clickedid==TDIbiza[2]) //w lewo
		{
			kam = (kam==1 ? 12 : kam-1);
			SetPVarInt(playerid, "IbizaKamery", kam);
			IbizaUstawKamere(playerid, kam-1);
		}

	}
    if(GetPVarInt(playerid, "skin-select") == 1) // skin selector
    {
        if(clickedid == SkinSelectionAccept)//zatiwerdz
        {
            if(!GetPVarInt(playerid, "skin-done"))
            {
                GameTextForPlayer(playerid, "~r~Wybierz ubranie", 1000, 5);
				#if DEBUG == 1
					printf("%s[%d] OnPlayerClickTextDraw - end", GetNick(playerid), playerid);
				#endif
                return 1;
            }
            SetPVarInt(playerid, "skin-select", 0);
            CancelSelectTextDraw(playerid);
            DestroySkinSelection(playerid);
            TogglePlayerControllable(playerid, 1);

            if(GetPVarInt(playerid, "skin-choosen") != 0)
            {
                SetPlayerSkin(playerid, GetPVarInt(playerid, "skin-choosen"));
                PlayerInfo[playerid][pSkin] = GetPVarInt(playerid, "skin-choosen");
            }
        }
        else if(clickedid == SkinSelectionDenied)//anuluj
        {
            SetPVarInt(playerid, "skin-select", 0);
            CancelSelectTextDraw(playerid);
            DestroySkinSelection(playerid);
            TogglePlayerControllable(playerid, 1);
        }
        else if(clickedid == SkinSelectionMy)//moj cywil
        {
            SetPVarInt(playerid, "skin-select", 0);
            CancelSelectTextDraw(playerid);
            DestroySkinSelection(playerid);
            TogglePlayerControllable(playerid, 1);

            PlayerInfo[playerid][pSkin] = PlayerInfo[playerid][pModel];
            SetPlayerSkin(playerid, PlayerInfo[playerid][pModel]);
        }
    }
    //Strefy
    if(clickedid == ZoneTXD[3])
    {
        cmd_atakuj(playerid, "");
    }

    if(GetPVarInt(playerid, "patrol-map") == 1 && GetPVarInt(playerid, "patrolmap") == 1)
    {
        if(_:clickedid == INVALID_TEXT_DRAW)
        {
            SendClientMessage(playerid, COLOR_PAPAYAWHIP, "Wybierz region.");
            SelectTextDraw(playerid, 0xD2691E55);
			#if DEBUG == 1
				printf("%s[%d] OnPlayerClickTextDraw - end", GetNick(playerid), playerid);
			#endif
            return 1;
        }
        else
        {
            new pat = GetPVarInt(playerid, "patrol-id"), fnick[2][MAX_PLAYER_NAME+1];
            if((clickedid == PatrolAlfa[0] || clickedid == PatrolAlfa[1]) && Patrolujacych[0] < 4)
            {
                PatrolInfo[pat][patstrefa] = 1;
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "Strefa patrolu to ALFA.{FFFFFF} Udaj siÍ w to miejsce i pamiÍtaj o kodach radiowych!");
                if(GetPVarInt(playerid, "patrol-duo") == 1) SendClientMessage(PatrolInfo[pat][patroluje][1], COLOR_LIGHTBLUE, "Strefa patrolu to ALFA.{FFFFFF} Udaj siÍ w to miejsce i pamiÍtaj o kodach radiowych!");
                Patrolujacych[0]++;
                GetPlayerName(playerid, fnick[0], MAX_PLAYER_NAME);
                GetPlayerName(PatrolInfo[pat][patroluje][1], fnick[1], MAX_PLAYER_NAME);
                format(str, 128, "{FFFFFF}ªª{6A5ACD} CENTRALA: {FFFFFF}%s{6A5ACD} 10-30 na strefÍ Alfa, sk≥ad %s %s", PatrolInfo[pat][patname], fnick[0], fnick[1]);
            }
            else if((clickedid == PatrolBeta[0] || clickedid == PatrolBeta[1]) && Patrolujacych[1] < 4)
            {
                PatrolInfo[pat][patstrefa] = 2;
                SendClientMessage(playerid, COLOR_GREEN, "Strefa patrolu to BETA.{FFFFFF} Udaj siÍ w to miejsce i pamiÍtaj o kodach radiowych!");
                if(GetPVarInt(playerid, "patrol-duo") == 1) SendClientMessage(PatrolInfo[pat][patroluje][1], COLOR_GREEN, "Strefa patrolu to BETA.{FFFFFF} Udaj siÍ w to miejsce i pamiÍtaj o kodach radiowych!");
                Patrolujacych[1]++;
                GetPlayerName(playerid, fnick[0], MAX_PLAYER_NAME);
                GetPlayerName(PatrolInfo[pat][patroluje][1], fnick[1], MAX_PLAYER_NAME);
                format(str, 128, "{FFFFFF}ªª{6A5ACD} CENTRALA: {FFFFFF}%s{6A5ACD} 10-30 na strefÍ Beta, sk≥ad %s %s", PatrolInfo[pat][patname], fnick[0], fnick[1]);
            }
            else if((clickedid == PatrolGamma[0] || clickedid == PatrolGamma[1]) && Patrolujacych[2] < 6)
            {
                PatrolInfo[pat][patstrefa] = 3;
                SendClientMessage(playerid, COLOR_RED, "Strefa patrolu to GAMMA.{FFFFFF} Udaj siÍ w to miejsce i pamiÍtaj o kodach radiowych!");
                if(GetPVarInt(playerid, "patrol-duo") == 1) SendClientMessage(PatrolInfo[pat][patroluje][1], COLOR_RED, "Strefa patrolu to GAMMA.{FFFFFF} Udaj siÍ w to miejsce i pamiÍtaj o kodach radiowych!");
                Patrolujacych[2]++;
                GetPlayerName(playerid, fnick[0], MAX_PLAYER_NAME);
                GetPlayerName(PatrolInfo[pat][patroluje][1], fnick[1], MAX_PLAYER_NAME);
                format(str, 128, "{FFFFFF}ªª{6A5ACD} CENTRALA: {FFFFFF}%s{6A5ACD} 10-30 na strefÍ Gamma, sk≥ad %s %s", PatrolInfo[pat][patname], fnick[0], fnick[1]);
            }
            else if((clickedid == PatrolDelta[0] || clickedid == PatrolDelta[1]) && Patrolujacych[3] < 6)
            {
                PatrolInfo[pat][patstrefa] = 4;
                SendClientMessage(playerid, COLOR_YELLOW, "Strefa patrolu to DELTA.{FFFFFF} Udaj siÍ w to miejsce i pamiÍtaj o kodach radiowych!");
                if(GetPVarInt(playerid, "patrol-duo") == 1) SendClientMessage(PatrolInfo[pat][patroluje][1], COLOR_YELLOW, "Strefa patrolu to DELTA.{FFFFFF} Udaj siÍ w to miejsce i pamiÍtaj o kodach radiowych!");
                Patrolujacych[3]++;
                GetPlayerName(playerid, fnick[0], MAX_PLAYER_NAME);
                GetPlayerName(PatrolInfo[pat][patroluje][1], fnick[1], MAX_PLAYER_NAME);
                format(str, 128, "{FFFFFF}ªª{6A5ACD} CENTRALA: {FFFFFF}%s:{6A5ACD} 10-30 na strefÍ Delta, sk≥ad %s %s", PatrolInfo[pat][patname], fnick[0], fnick[1]);
            }
            else SendClientMessage(playerid, COLOR_YELLOW, "Brak wolnego miejsca w tej strefie, sprÛbuj innπ.");
            if(PatrolInfo[pat][patstrefa] != 0)
            {
                PatrolInfo[pat][pataktywny] = 1;
                Patrol_HideMap(playerid);
                CancelSelectTextDraw(playerid);
                SetPVarInt(playerid, "patrol-map", 0);
                SendTeamMessage(1, COLOR_ALLDEPT, str);

                Patrol_DisplayZones(playerid);
                if(GetPVarInt(playerid, "patrol-duo") == 1) Patrol_DisplayZones(PatrolInfo[pat][patroluje][1]);
            }
        }
    }
    else if(GetPVarInt(playerid, "patrolmap") == 1)
    {
        if(_:clickedid == INVALID_TEXT_DRAW)
        {
            CancelSelectTextDraw(playerid);
            Patrol_HideMap(playerid);
			#if DEBUG == 1
				printf("%s[%d] OnPlayerClickTextDraw - end", GetNick(playerid), playerid);
			#endif
            return 1;
        }
        new stanp[32], pnick1[24], pnick2[MAX_PLAYER_NAME+1];
        for(new i=0;i<MAX_PATROLS;i++)
        {
            if(clickedid == PatrolMarker[i] && PatrolInfo[i][pataktywny] == 1)
            {
                GetPlayerName(PatrolInfo[i][patroluje][0], pnick1, MAX_PLAYER_NAME);
                GetPlayerName(PatrolInfo[i][patroluje][1], pnick2, MAX_PLAYER_NAME);
                switch(PatrolInfo[i][patstan])
                {
                    case 1: stanp="Sytuacja pod kontrolπ";
                    case 2: stanp="Potrzebne wsparcie";
                    case 3: stanp="Poúcig za podejrzanym";
                    case 4: stanp="Ranny funkcjonariusz";
                }
                format(str, 128, "Patrol %s - Funkcjonariusze: %s %s. Stan: %s", PatrolInfo[i][patname], pnick1, pnick2, stanp);
                SendClientMessage(playerid, COLOR_LIGHTGREEN, str);
                break;
            }
        }
    }
    if(clickedid == TXD_Info) //Display server info
    {
        if(strlen(ServerInfo) > 1) ShowPlayerDialogEx(playerid, D_SERVERINFO, DIALOG_STYLE_MSGBOX, "Mrucznik-RP ª Informacja", ServerInfo, "Schowaj", "Zamknij");
    }
	#if DEBUG == 1
		printf("%s[%d] OnPlayerClickTextDraw - end", GetNick(playerid), playerid);
	#endif
   	return 1;
}

public OnPlayerEnterDynamicArea(playerid, areaid)
{
	#if DEBUG == 1
		printf("%s[%d] OnPlayerEnterDynamicArea - begin", GetNick(playerid), playerid);
	#endif
    if(IsPlayerInAnyVehicle(playerid))
    {
        new kolid=-1;
        for(new i=0;i<MAX_OILS;i++)
        {
            if(OilData[i][oilArea] == areaid && areaid != 0)
            {
                kolid = i;
                break;
            }
        }
        if(kolid != -1 && OilData[kolid][oilHP] > 0)
        {
            OnPlayerEnterOilSpot(playerid);
			#if DEBUG == 1
				printf("%s[%d] OnPlayerEnterDynamicArea - end", GetNick(playerid), playerid);
			#endif
            return;
        }
        kolid = -1;
        for(new i=0;i<MAX_KOLCZATEK;i++)
        {
            if(KolArea[i] == areaid && areaid != 0)
            {
                kolid = i;
                break;
            }
        }
        if(kolid != -1)
        {
            OnPlayerEnterSpikes(playerid);
			#if DEBUG == 1
				printf("%s[%d] OnPlayerEnterDynamicArea - end", GetNick(playerid), playerid);
			#endif
            return;
        }
    }
	#if DEBUG == 1
		printf("%s[%d] OnPlayerEnterDynamicArea - end", GetNick(playerid), playerid);
	#endif
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	#if DEBUG == 1
		printf("%s[%d] OnPlayerClickPlayerTextDraw - begin", GetNick(playerid), playerid);
	#endif
	if(GetPVarInt(playerid, "gatechose_active") == 1)   //Barierki
    {
    	new curpage = GetPVarInt(playerid, "gatechose_page");

    	if(playertextid == gNextButtonTextDrawId[playerid]) {
    	    if(curpage < (GetNumberOfPages() - 1)) {
    	        SetPVarInt(playerid, "gatechose_page", curpage + 1);
    	        ShowPlayerModelPreviews(playerid);
             	UpdatePageTextDraw(playerid);
             	PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
    		} else {
    		    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
    		}
			#if DEBUG == 1
				printf("%s[%d] OnPlayerClickPlayerTextDraw - end", GetNick(playerid), playerid);
			#endif
    		return 1;
    	}
    	if(playertextid == gPrevButtonTextDrawId[playerid]) {
    	    if(curpage > 0) {
    	    	SetPVarInt(playerid, "gatechose_page", curpage - 1);
    	    	ShowPlayerModelPreviews(playerid);
    	    	UpdatePageTextDraw(playerid);
    	    	PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
    		} else {
    		    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
    		}
			#if DEBUG == 1
				printf("%s[%d] OnPlayerClickPlayerTextDraw - end", GetNick(playerid), playerid);
			#endif
    		return 1;
    	}
    	new x=0;
    	while(x != SELECTION_ITEMS) {
    	    if(playertextid == gSelectionItems[playerid][x]) {
    	        HandlePlayerItemSelection(playerid, x);
    	        PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
    	        DestroySelectionMenu(playerid);
    	        CancelSelectTextDraw(playerid);
            	SetPVarInt(playerid, "gatechose_active", 0);
				#if DEBUG == 1
					printf("%s[%d] OnPlayerClickPlayerTextDraw - end", GetNick(playerid), playerid);
				#endif
            	return 1;
    		}
    		x++;
    	}
    }
    if(SkinSelection[playerid][0] <= _:playertextid < SkinSelection[playerid][MAX_SKIN_SELECT])
    {
        new idx = _:playertextid-_:SkinSelection[playerid][0];
        if(0 <= idx <= MAX_SKIN_SELECT)
        {
            new typ = GetPVarInt(playerid, "skin-typ");
            new frac = GetPlayerFraction(playerid);
            if(frac == 0) frac = GetPlayerOrg(playerid);
            switch(typ) //switch na tablice ze skinami
            {
                case 1: PlayerTextDrawSetPreviewModel(playerid, PlayerText:SkinSelection[playerid][MAX_SKIN_SELECT], FRAC_SKINS[frac][idx]), SetPVarInt(playerid, "skin-choosen", FRAC_SKINS[frac][idx]);
                case 2: PlayerTextDrawSetPreviewModel(playerid, PlayerText:SkinSelection[playerid][MAX_SKIN_SELECT], FAM_SKINS[frac][idx]), SetPVarInt(playerid, "skin-choosen", FAM_SKINS[frac][idx]);
            }
            PlayerTextDrawShow(playerid, PlayerText:SkinSelection[playerid][MAX_SKIN_SELECT]);
            SetPVarInt(playerid, "skin-index", idx);
            SetPVarInt(playerid, "skin-done", 1);
        }
    }
	#if DEBUG == 1
		printf("%s[%d] OnPlayerClickPlayerTextDraw - end", GetNick(playerid), playerid);
	#endif
	return 1;
}

/*public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
    return 1;
} */

public OnEnterExitModShop(playerid, enterexit, interiorid)
{
	#if DEBUG == 1
		printf("%s[%d] OnEnterExitModShop - begin", GetNick(playerid), playerid);
	#endif
    if(enterexit == 0)
    {
        SendClientMessage(playerid, COLOR_WHITE, "Zap≥aci≥eú 2500$ za naprawÍ wozu.");
        DajKase(playerid, -2500);

        if(GetPlayerVehicleID(playerid) != 0)
            CarData[VehicleUID[GetPlayerVehicleID(playerid)][vUID]][c_HP] = 1000.0;
    }
	#if DEBUG == 1
		printf("%s[%d] OnEnterExitModShop - end", GetNick(playerid), playerid);
	#endif
    return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	#if DEBUG == 1
		printf("%s[%d] OnPlayerEnterVehicle - begin", GetNick(playerid), playerid);
	#endif
    if(vehicleid > MAX_VEHICLES || vehicleid < 0)
    {
        SendClientMessage(playerid, 0xA9C4E4FF, "Warning: Exceed vehicle limit");
		#if DEBUG == 1
			printf("%s[%d] OnPlayerEnterVehicle - end", GetNick(playerid), playerid);
		#endif
        return 0;
    }
    new validseat = GetVehicleMaxPassengers(GetVehicleModel(vehicleid));
    if(validseat == 0xF)
    {
        SendClientMessage(playerid, 0xA9C4E4FF, "Warning: Invalid seat");
		#if DEBUG == 1
			printf("%s[%d] OnPlayerEnterVehicle - end", GetNick(playerid), playerid);
		#endif
        return 0;
    }
    if(gPlayerLogged[playerid] == 0)
	{
        if(!IsPlayerNPC(playerid)) // znow tylko funkcja dla botow
		{
	    	SendClientMessage(playerid, COLOR_LIGHTRED, "** Musisz siÍ zalogowaÊ zanim wybierzesz skin (Zosta≥eú wyrzucony) **");
	        SetTimerEx("KickTimer",500,0,"d",playerid);
	    }
		#if DEBUG == 1
			printf("%s[%d] OnPlayerEnterVehicle - end", GetNick(playerid), playerid);
		#endif
        return 0;
 	}

	//PAèDZIOCH
	if(IsAHeliModel(GetVehicleModel(vehicleid)) && ispassenger)
 	{
  		SetPVarInt(playerid,"chop_id",GetPlayerVehicleID(playerid));
    	SetPVarInt(playerid,"roped",0);
    }
    else SetPVarInt(playerid,"chop_id",0);

    new engine, lights, alarm, doors, bonnet, boot, objective;
 	GetVehicleParamsEx(vehicleid, engine, lights ,alarm, doors, bonnet, boot, objective);
    //AT400
    if(GetVehicleModel(vehicleid) == 577 && !IsPlayerInFraction(playerid, FRAC_KT, 5000))
    {
        new Float:slx, Float:sly, Float:slz;
		GetPlayerPos(playerid, slx, sly, slz);
		SetPlayerPosEx(playerid, slx, sly, slz+0.1);
		ClearAnimations(playerid);
    }

	if(IsARower(vehicleid))
	{
	    SetVehicleParamsEx(vehicleid, 1, lights, alarm, doors, bonnet, boot, objective);
	}
	else
	{
        if(!ispassenger && !engine) MSGBOX_Show(playerid, "~k~~CONVERSATION_YES~ - odpala pojazd", MSGBOX_ICON_TYPE_OK);
    }

	if(gTeam[playerid] >= 3 || !IsACop(playerid))
	{
		if (IsACopCar(vehicleid) && !ispassenger)
		{
			if(IsACop(playerid))
			{
				SendClientMessage(playerid, COLOR_BLUE, "Po≥πczy≥eú siÍ z komputerem policyjnym, wpisz /mdc aby zobaczyÊ kartotekÍ policyjnπ");
			}
   			else
			{
				new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPosEx(playerid, slx, sly, slz+1);
				ClearAnimations(playerid);
			}
		}
		if (IsAnAmbulance(vehicleid) && !ispassenger)
		{
		    if(IsAMedyk(playerid) && JobDuty[playerid] == 0 )
			{
				SendClientMessage(playerid, COLOR_GRAD1, "Nie jesteú medykiem na s≥uøbie!");
			}
			else if(!IsAMedyk(playerid))
			{
				SendClientMessage(playerid, COLOR_GRAD1, "Nie jesteú medykiem!");
			}
		}
		if (GetVehicleModel(vehicleid) == 525)
		{
		    SendClientMessage(playerid, COLOR_BROWN, "Wsiad≥eú do holownika, naciúnij CTRL alby podholowaÊ wÛz.");
		}
	}
	#if DEBUG == 1
		printf("%s[%d] OnPlayerEnterVehicle - end", GetNick(playerid), playerid);
	#endif
	return 1;
}

//---------------------------<[  OnPlayerConnect:  ]>---------------------------
public OnPlayerConnect(playerid)
{
	#if DEBUG == 1
		printf("%s[%d] OnPlayerConnect - begin", GetNick(playerid), playerid);
	#endif
	Ac_OnPlayerConnect(playerid);
	ZerujZmienne(playerid);
	UsunObiekty(playerid);
	LoadTextDraws(playerid);
	ClearChat(playerid);

    LoadingShow(playerid);

	//Poprawny nick:
	new nick[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nick, MAX_PLAYER_NAME);
    if(IsNickCorrect(nick))
    {
        SendClientMessage(playerid, COLOR_NEWS, "SERWER: TwÛj nick jest niepoprawny! Nick musi posiadaÊ formÍ: ImiÍ_Nazwisko!");
		KickEx(playerid);
		#if DEBUG == 1
			printf("%s[%d] OnPlayerConnect - end", GetNick(playerid), playerid);
		#endif
		return 1;
    }

	//Poczπtkowe ustawienia:
    SetTimerEx("OPCLogin", 100, 0, "i", playerid);

	//system barierek by Kubi
	gHeaderTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gBackgroundTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gCurrentPageTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gNextButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gPrevButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;

    for(new x=0; x < SELECTION_ITEMS; x++) {
        gSelectionItems[playerid][x] = PlayerText:INVALID_TEXT_DRAW;
	}

	gItemAt[playerid] = 0;
	printf("Poprawnie Connect ID: %d", playerid);
	#if DEBUG == 1
		printf("%s[%d] OnPlayerConnect - end", GetNick(playerid), playerid);
	#endif
	return 1;
}

//--------------------<[  OnPlayerPause  ]>--------------------
public OnPlayerPause(playerid)
{
	if(afk_timer[playerid] == -1)
	{
		afk_timer[playerid] = SetTimerEx("PlayerAFK", 1000, false, "iii", playerid, 1, 0);
	}
	return 1;
}
//-------------------------------<[  OnPlayerDisconnect  ]>-------------------------------
public OnPlayerDisconnect(playerid, reason)
{
	//Pobieranie starej pozycji:

	#if DEBUG == 1
		printf("%s[%d] OnPlayerDisconnect - begin", GetNick(playerid), playerid);
	#endif
	GetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
	PlayerInfo[playerid][pInt] = GetPlayerInterior(playerid);

    if(GetPVarInt(playerid, "kolejka") == 1)
    {
        PlayerInfo[playerid][pPos_x] = GetPVarFloat(playerid, "kolejka-x");
        PlayerInfo[playerid][pPos_y] = GetPVarFloat(playerid, "kolejka-y");
        PlayerInfo[playerid][pPos_z] = GetPVarFloat(playerid, "kolejka-z");
        PlayerInfo[playerid][pInt] = GetPVarInt(playerid, "kolejka-int");
    }
	//AFK timer
	if(afk_timer[playerid] != -1)
	{
		KillTimer(afk_timer[playerid]);
		afk_timer[playerid] = -1;
	}
	//PAèDZIOCH - lina SWAT
	if(GetPVarInt(playerid,"roped") == 1)
 	{
  		for(new i=0;i<=ROPELENGTH;i++)
  		{
    		DestroyDynamicObject(r0pes[playerid][i]);
      	}
	}

    if(GetPVarInt(playerid, "kostka"))
    {
        new id = GetPVarInt(playerid, "kostka-player");
        Kostka_Wygrana(id, playerid, GetPVarInt(id, "kostka-cash"), true);
        SendClientMessage(id, COLOR_RED, "WspÛ≥zawodnik opÛsci≥ serwer, otrzymujesz zwrot wp≥aconej kwoty z podatkiem.");
    }
	if(pobity[playerid] == 1 || PlayerTied[playerid] >= 1 || PlayerCuffed[playerid] >= 1 || zakuty[playerid] >= 1 || poscig[playerid] == 1)
	{
    	PlayerInfo[playerid][pJailed] = 10;
	}

	if(PoziomPoszukiwania[playerid] >= 1)
	{
		new wl = PoziomPoszukiwania[playerid];
		PlayerInfo[playerid][pWL] = wl;
	}

    if(TransportDist[playerid] > 0.0 && TransportDriver[playerid] < 999)
	{
        Taxi_Pay(playerid);
	}

    //System aut
    Car_UnloadForPlayer(playerid);

	//Zapis statystyk:
    MruMySQL_SaveAccount(playerid, false, true);

    if(GetPVarInt(playerid, "active_ticket") != 0)
        Support_ClearTicket(GetPVarInt(playerid, "active_ticket")-1);

    if(GetPVarInt(playerid, "oil_clear") == 1)
    {
        Oil_UnloadPTXD(playerid);
        TextDrawShowForPlayer(playerid, OilTXD_BG[0]);
        TextDrawShowForPlayer(playerid, OilTXD_BG[1]);
    }

    if(GetPVarInt(playerid, "patrol") != 0)
    {
        cmd_patrol(playerid, "stop");
    }
    if(GetPVarInt(playerid, "patrolmap") == 1)
    {
        Patrol_HideMap(playerid);
    }
    if(GetPVarInt(playerid, "rentTimer") != 0)
    {
        UnhireRentCar(playerid, GetPVarInt(playerid, "rentCar"));
        KillTimer(GetPVarInt(playerid, "rentTimer"));
    }

    //12.06.2014  opis
    Opis_Usun(playerid);

    if(noclipdata[playerid][fireobject] != 0)
    {
        DestroyDynamicObject(noclipdata[playerid][fireobject]);
        noclipdata[playerid][fireobject] = 0;
    }

    if(GetPVarInt(playerid, "skin-select") != 0)
        DestroySkinSelection(playerid);

    //strefy
    if(ZonePlayerTimer[playerid] != 0) KillTimer(ZonePlayerTimer[playerid]);

	UnLoadTextDraws(playerid);

    INT_AirTowerLS_Exit(playerid, true, true);

    //09.06.2014 wylaczenie ng pad
    if(GetPVarInt(playerid, "ng-gatekey") == 1)
    {
        SetPVarInt(playerid, "ng-gatekey", 0);
        VAR_NGKeypad = false;
    }

	if(PDGPS == playerid) //wy≥πczenie GPS
	{
		cmd_gps(playerid);
	}

    if(ScigaSie[playerid] != 666 && IloscCH[playerid] != 0)
	{
	    new string[64];
	    new sendername[MAX_PLAYER_NAME];
	    GetPlayerName(playerid, sendername, sizeof(sendername));
	    format(string, sizeof(string), "Wyúcig: {FFFFFF}%s wyszed≥ z gry", sendername);
    	foreach(Player, i)
    	{
	    	if(ScigaSie[i] == Scigamy)
 	    	{
    			SendClientMessage(i, COLOR_YELLOW, string);
   			}
	    }
	    IloscZawodnikow --;
	    if(IloscZawodnikow <= Ukonczyl)
	    {
	        KoniecWyscigu(-1);
	    }
    }

    if(SkutyGracz[playerid] != 0)
	{
	    PDkuje[SkutyGracz[playerid]] = 0;
	    zakuty[SkutyGracz[playerid]] = 0;
	    SkutyGracz[playerid] = 0;
	}

    if(HireCar[playerid] != 0)
    {
        CarData[VehicleUID[HireCar[playerid]][vUID]][c_Rang] = 0;
    }

    new bbxid = GetPVarInt(playerid, "boomboxid");
    if(BoomBoxData[bbxid][BBD_Carried]-1 == playerid)
    {
        BoomBoxData[bbxid][BBD_Standby] = false;
        BBD_Putdown(playerid, bbxid);
    }

    TextDrawHideForPlayer(playerid, TXD_Info);

	//Komunikaty dla graczy na serwerze:
	foreach(Player, i)
	{
	    if(IsPlayerConnected(i) && i != playerid)
	    {
	        if(TaxiAccepted[i] < 500)
	        {
		        if(TaxiAccepted[i] == playerid)
		        {
		            TaxiAccepted[i] = 999;
		            GameTextForPlayer(i, "~w~Klient Taxi~n~~r~Wyszedl z gry", 5000, 1);
		            TaxiCallTime[i] = 0;
		            DisablePlayerCheckpoint(i);
		        }
	        }
	        else if(BusAccepted[i] < 500)
	        {
		        if(BusAccepted[i] == playerid)
		        {
		            BusAccepted[i] = 999;
		            GameTextForPlayer(i, "~w~Klient autobusu~n~~r~Wyszedl z gry", 5000, 1);
		            BusCallTime[i] = 0;
		            DisablePlayerCheckpoint(i);
		        }
	        }
	    }
	}
	if(GotHit[playerid] > 0)
	{
	    if(GetChased[playerid] < 500)
	    {
	        if(IsPlayerConnected(GetChased[playerid]))
	        {
	        	SendClientMessage(GetChased[playerid], COLOR_YELLOW, "TwÛj cel opuúci≥ serwer.");
	            GoChase[GetChased[playerid]] = 999;
			}
	    }
	}
	if(PlayerPaintballing[playerid] != 0)
	{
	    PaintballPlayers --;
	}
	if(PlayerKarting[playerid] > 0 && PlayerInKart[playerid] > 0)
	{
	    KartingPlayers --;
	}
	if(PlayersChannel[playerid] < 500)
	{
		IRCInfo[PlayersChannel[playerid]][iPlayers] --;
	}
	if(PlayerBoxing[playerid] > 0)
	{
	    if(Boxer1 == playerid)
	    {
	        if(IsPlayerConnected(Boxer2))
	        {
	        	PlayerBoxing[Boxer2] = 0;
	        	SetPlayerPosEx(Boxer2, 765.8433,3.2924,1000.7186);
	        	SetPlayerInterior(Boxer2, 5);
	        	GameTextForPlayer(Boxer2, "~r~Walka przerwana", 5000, 1);
			}
	    }
	    else if(Boxer2 == playerid)
	    {
	        if(IsPlayerConnected(Boxer1))
	        {
	        	PlayerBoxing[Boxer1] = 0;
	        	SetPlayerPosEx(Boxer1, 765.8433,3.2924,1000.7186);
	        	SetPlayerInterior(Boxer1, 5);
	        	GameTextForPlayer(Boxer1, "~r~Walka przerwana", 5000, 1);
			}
	    }
	    InRing = 0;
     	RoundStarted = 0;
		Boxer1 = 255;
		Boxer2 = 255;
		TBoxer = 255;
	}
    if(TransportDuty[playerid] == 1)
	{
		TaxiDrivers -= 1;
	}
    else if(TransportDuty[playerid] == 2)
	{
		BusDrivers -= 1;
	}
	if(PlayerInfo[playerid][pJob] == 11)
	{
	    if(JobDuty[playerid] == 1) { Medics -= 1; }
	}
	else if(PlayerInfo[playerid][pJob] == 7)
	{
	    if(JobDuty[playerid] == 1) { Mechanics -= 1; }
	}

    gPlayerLogged[playerid] = 0; //wylogowany
    MRP_PremiumHours[playerid] = 0;
	#if DEBUG == 1
		printf("%s[%d] OnPlayerDisconnect - end", GetNick(playerid), playerid);
	#endif
	return 1;
}
public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
    if(weaponid == WEAPON_GRENADE || weaponid == 51)
	{
		new Float:health;
		GetPlayerHealth(playerid,health);
		SetPlayerHealth(playerid, (health)-5);
	    ShowPlayerFadeScreenToBlank(playerid, 20, 255, 255, 255, 255);
		SetPlayerDrunkLevel(playerid, 3000);
	}
    else if(issuerid != INVALID_PLAYER_ID)
	{
	    
        if(MaTazer[issuerid] == 1 && (GetPlayerWeapon(issuerid) == 23 || GetPlayerWeapon(issuerid) == 24) && TazerAktywny[playerid] == 0 && GetDistanceBetweenPlayers(playerid,issuerid) < 11)
		{
		    new Float:health;
    		GetPlayerHealth(playerid,health);
		    SetPlayerHealth(playerid, health);
 		   	new giveplayer[MAX_PLAYER_NAME];
			new sendername[MAX_PLAYER_NAME];
  		  	GetPlayerName(issuerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
            TazerAktywny[playerid] = 1;
            SetTimerEx("DostalTazerem", 10000, false, "i", playerid);
            new string[128];
            GameTextForPlayer(playerid, "DOSTALES TAZEREM! ODCZEKAJ CHWILE!", 3000, 5);
            GameTextForPlayer(issuerid, "~g~TRAFILES W GRACZA!~n~~w~TAZER DEZAKTYWOWANY! PRZELADUJ TAZER!", 3000, 5);
            format(string, sizeof(string), "* %s strzela tazerem w %s.", giveplayer, sendername);
			ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			MaTazer[issuerid] = 0;
			//PlayerInfo[issuerid][pGun2] = 24;
			//GivePlayerWeapon(issuerid, 24, PlayerInfo[issuerid][pAmmo2]);
			//RemovePlayerAttachedObject(issuerid, 9);
			PlayerPlaySound(issuerid, 6300, 0.0, 0.0, 0.0);
			PlayerPlaySound(playerid, 6300, 0.0, 0.0, 0.0);
            ApplyAnimation(playerid, "CRACK","crckdeth2",4.1,0,1,1,1,1,1);
            ClearAnimations(playerid);
            ApplyAnimation(playerid, "CRACK","crckdeth2",4.1,0,1,1,1,1,1);
            TogglePlayerControllable(playerid, 0);
        }
        else if(MaTazer[issuerid] == 1 && (GetPlayerWeapon(issuerid) == 23 || GetPlayerWeapon(issuerid) == 24) && TazerAktywny[playerid] == 0 && GetDistanceBetweenPlayers(playerid,issuerid) > 10)
		{
		    new Float:health;
    		GetPlayerHealth(playerid,health);
		    SetPlayerHealth(playerid, health);
			GameTextForPlayer(issuerid, "~r~GRACZ BYL ZA DALEKO!~n~~w~TAZER DEZAKTYWOWANY! PRZELADUJ TAZER!", 3000, 5);
			MaTazer[issuerid] = 0;
			//PlayerInfo[issuerid][pGun2] = 24;
			//GivePlayerWeapon(issuerid, 24, PlayerInfo[issuerid][pAmmo2]);
			//RemovePlayerAttachedObject(issuerid, 9);
		}
    }
	switch(bodypart)
	{
	    case BODY_PART_LEFT_LEG:
	    {
	        ApplyAnimation(playerid, "ped", "DAM_LegL_frmLT", 4.1, 0, 0, 0, 0, 0, 1);
	    }
	    case BODY_PART_RIGHT_LEG:
	    {
	        ApplyAnimation(playerid, "ped", "DAM_LegR_frmBK", 4.1, 0, 0, 0, 0, 0, 1);
	    }
	    case BODY_PART_LEFT_ARM:
	    {
	        ApplyAnimation(playerid, "ped", "DAM_armL_frmBK", 4.1, 0, 0, 0, 0, 0, 1);
	    }
	    case BODY_PART_RIGHT_ARM:
	    {
	        ApplyAnimation(playerid, "ped", "DAM_armR_frmBK", 4.1, 0, 0, 0, 0, 0, 1);
	    }
	}
	return 1;
}

public StandUp(playerid)
{
    SetPVarInt(playerid, "optd-hs", 0);
    ApplyAnimation(playerid, "ped", "getup", 4.1, 0, 0, 0, 0, 0, 1);
}

public OnPlayerDeath(playerid, killerid, reason)
{
	#if DEBUG == 1
		printf("%s[%d] OnPlayerDeath - begin", GetNick(playerid), playerid);
	#endif
	new playername[MAX_PLAYER_NAME];
	new killername[MAX_PLAYER_NAME];
	new string[128];

    GetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);

    new bbxid = GetPVarInt(playerid, "boomboxid");
    if(BoomBoxData[bbxid][BBD_Carried]-1 == playerid)
    {
        BoomBoxData[bbxid][BBD_Standby] = false;
        BBD_Putdown(playerid, bbxid);
    }

    if(ZoneAttacker[playerid])
    {
        OnPlayerLeaveGangZone(playerid, GetPVarInt(playerid, "zoneid"));
    }
    else if(ZoneDefender[playerid])
    {
        OnPlayerLeaveGangZone(playerid, GetPVarInt(playerid, "zoneid"));
    }

	//PAèDZIOCH - lina SWAT
	if(GetPVarInt(playerid,"roped") == 1)
 	{
  		for(new i=0;i<=ROPELENGTH;i++)
    	{
     		DestroyDynamicObject(r0pes[playerid][i]);
       	}
        SetPVarInt(playerid,"roped",0);
        DisablePlayerCheckpoint(playerid);
	}

    //IBIZA
    if(GetPVarInt(playerid, "IbizaWejdz") || GetPVarInt(playerid, "IbizaBilet") )
	{
		DeletePVar(playerid, "IbizaWejdz");
		DeletePVar(playerid, "IbizaBilet");
		StopAudioStreamForPlayer(playerid); //POWT”RKA
	}

    //Strefy
    if(killerid != INVALID_PLAYER_ID)
    {
        new frac = GetPlayerFraction(killerid),
            fam = GetPlayerOrg(killerid);

        if(IsACop(killerid) || FRAC_GROOVE <= frac <= FRAC_VAGOS || frac == FRAC_WPS || 6 <= fam <= 10)
        {
            new bool:inzone=false;
            for(new i=0;i<MAX_ZONES;i++)
            {
                if(bInZone[playerid][i])
                {
                    if(bInZone[killerid][i])
                    {
                        inzone=true;
                        break;
                    }
                }
            }
            if(inzone)
            {
                new Float:x, Float:y, Float:z;
                GetPlayerPos(playerid, x, y, z);
                PlayerInfo[playerid][pBW] = 3*60; //czas
                SetSpawnInfo(playerid, 0, GetPlayerSkin(playerid), x, y, z, 0.0, 0, 0, 0, 0, 0, 0);
                SetPVarInt(playerid, "bw-skin",  GetPlayerSkin(playerid));
            }
        }
    }

	if(IsPlayerConnected(playerid) && playerid != INVALID_PLAYER_ID)
	{
		GetPlayerName(playerid, playername, sizeof(playername));
		GetPlayerName(killerid, killername, sizeof(killername));

		//-------<[    Zmienne    ]>---------
		StopAudioStreamForPlayer(playerid);
		gPlayerSpawned[playerid] = 0;
		PlayerInfo[playerid][pLocal] = 255;
		PlayerInfo[playerid][pDeaths] ++;


		//-------<[  Antyczity  ]>---------
		if(reason <= 54 && reason > 0)
		{
			if(IsPlayerConnected(killerid))
            {
                if(reason == 38 && GetVehicleModel(GetPlayerVehicleID(killerid)) == 425) format(string, sizeof(string), "{FF66CC}DeathWarning: {FFFFFF}%s [%d] zabi≥ %s [%d] z Huntera", killername, killerid, playername, playerid);
				else format(string, sizeof(string), "{FF66CC}DeathWarning: {FFFFFF}%s [%d] zabi≥ %s [%d] z %s", killername, killerid, playername, playerid, (reason <= 46) ? GunNames[reason] : NiggaNames[reason-46]);
            }
            else
				format(string, sizeof(string), "{FF66CC}DeathWarning: %s [%d] umar≥ (%s)", playername, playerid, (reason <= 46) ? GunNames[reason] : NiggaNames[reason-46]);
			DeWu(string, 1);
		}
		if(IsPlayerConnected(killerid) && killerid != INVALID_PLAYER_ID)
		{
			PlayerInfo[killerid][pKills] ++;
			if(gPlayerLogged[killerid] == 0)
			{
				KickEx(killerid);
				#if DEBUG == 1
					printf("%s[%d] OnPlayerDeath - end", GetNick(playerid), playerid);
				#endif
				return 1;
			}
			if(GetPlayerState(killerid) == 2)
			{
				SendClientMessage(killerid, COLOR_YELLOW, "DriveBy Jest zakazane, Robiπc DriveBy moøesz zostaÊ ukarany przez admina!");
				if(PlayerInfo[killerid][pLevel] > 1)
				{
					format(string, 128, "AdmWarning: %s[%d] zabi≥ %s[%d] bÍdπ w aucie (moøliwe DB/CK2) [Gun %d]!", killername, killerid, playername, playerid, reason);
					ABroadCast(COLOR_YELLOW,string,1);
					WarningLog(string);
				}
				else
				{
					format(string, 128, "AdmWarning: %s[%d] zabi≥ %s[%d] z DB, dosta≥ kicka !", killername, killerid, playername, playerid);
					ABroadCast(COLOR_YELLOW,string,1);
					WarningLog(string);
					SendClientMessage(killerid, COLOR_PANICRED, "Dosta≥eú kicka za Drive-By do ludzi.");
					KickEx(killerid);
					#if DEBUG == 1
						printf("%s[%d] OnPlayerDeath - end", GetNick(playerid), playerid);
					#endif
					return 1;
				}
			}
			if(reason == 38 && GetVehicleModel(GetPlayerVehicleID(killerid)) != 425)
			{
				format(string, 128, "AdmWarning: [%d]%s zabi≥ gracza %s z miniguna, podejrzane !", killerid, killername, playername);
				ABroadCast(COLOR_YELLOW,string,1);
				CzitLog(string);
			}
			if(reason == 41)
			{
				format(string, 128, "AdmWarning: [%d]%s zabi≥ gracza %s ze spreya !", killerid, killername, playername);
				ABroadCast(COLOR_YELLOW,string,1);
				WarningLog(string);
			}


			//-------<[    Inne    ]>---------
			if(PlayerPaintballing[playerid] != 0)
			{
				PlayerPaintballKills[killerid] ++;
				if(PlayerPaintballKills[killerid] > PaintballWinnerKills)
				{
					PaintballWinner = killerid;
					PaintballWinnerKills = PlayerPaintballKills[killerid];
					foreach(Player, i)
					{
						if(IsPlayerConnected(i))
						{
							if(PlayerPaintballing[i] != 0)
							{
								format(string, sizeof(string), "* %s jest na prowadzeniu z %d trafieniami.",killername,PaintballWinnerKills);
								SendClientMessage(i, COLOR_WHITE, string);
							}
						}
					}
				}
				#if DEBUG == 1
					printf("%s[%d] OnPlayerDeath - end", GetNick(playerid), playerid);
				#endif
				return 1;
			}
			if(PlayerInfo[playerid][pHeadValue] > 0)
			{
				if(IsPlayerConnected(killerid))
				{
					if(PlayerInfo[killerid][pMember] == 8 || PlayerInfo[killerid][pLider] == 8)
					{
						if(GoChase[killerid] == playerid)
						{
							ConsumingMoney[killerid] = 1;
							DajKase(killerid, PlayerInfo[playerid][pHeadValue]);
							format(string,128,"<< Hitman %s wype≥ni≥ kontrakt na: %s i zarobi≥ $%d >>",killername,playername,PlayerInfo[playerid][pHeadValue]);
							SendFamilyMessage(8, COLOR_YELLOW, string);
							PayLog(string);
							format(string,128,"NR Marcepan_Marks: Szok! Zamach na øycie %s . Zosta≥ on ciÍøko ranny i przewieziony do szpitala.  ",playername);
							SendClientMessageToAll(COLOR_NEWS, string);
							PlayerInfo[playerid][pHeadValue] = 0;
							GotHit[playerid] = 0;
							GetChased[playerid] = 999;
							GoChase[killerid] = 999;
						}
					}
				}
			}
		}//koniec killerid connected
		if (gPlayerCheckpointStatus[playerid] > 4 && gPlayerCheckpointStatus[playerid] < 11)
		{
			DisablePlayerCheckpoint(playerid);
			gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
		}
		new caller = Mobile[playerid];
		if(caller != 255)
		{
			if(caller < 255)
			{
				SendClientMessage(caller,  COLOR_GRAD2, "   Po≥πczenie zakoÒczone....");
				Callin[playerid] = 0;
				Callin[caller] = 0;
				CellTime[caller] = 0;
				CellTime[playerid] = 0;
				Mobile[caller] = 1255;
			}
			Mobile[playerid] = 1255;
			CellTime[playerid] = 0;
		}
		if(ScigaSie[playerid] != 666 && IloscCH[playerid] != 0)
		{
			format(string, sizeof(string), "Wyúcig: {FFFFFF}%s zginπ≥ jak prawdziwy úcigant [*]", playername);
			WyscigMessage(COLOR_YELLOW, string);
			IloscZawodnikow --;
			if(IloscZawodnikow <= Ukonczyl)
			{
				KoniecWyscigu(-1);
			}
		}
		if(SkutyGracz[playerid] != 0)
		{
			PDkuje[SkutyGracz[playerid]] = 0;
			zakuty[SkutyGracz[playerid]] = 0;
			SkutyGracz[playerid] = 0;
		}
		if(lowcaz[playerid] == killerid)
		{
			lowcaz[playerid] = 501;
			SendClientMessage(playerid, COLOR_YELLOW, "Zlecenie zosta≥o anulowane - nie moøesz wziaúÊ teraz zlecenia na tego samego gracza!");
		}


		//-------<[     WL      ]>---------
		if(IsPlayerConnected(killerid) && killerid != INVALID_PLAYER_ID)
		{
			if(!IsACop(killerid) && lowcaz[killerid] != playerid)
			{
				format(string, sizeof(string), "Morderstwo");
				if(IsACop(playerid))
				{
					PoziomPoszukiwania[killerid] += 2;
					strcat(string, " Policjanta");
				}
				if(lowcaz[killerid] == playerid)
					strcat(string, " £owcy NagrÛd");
				if(GetPlayerState(killerid) == PLAYER_STATE_DRIVER || GetPlayerState(killerid) == PLAYER_STATE_PASSENGER)
					strcat(string, " z okna pojazdu");

				PlayerPlaySound(killerid, 1083, 0.0, 0.0, 0.0);
				PoziomPoszukiwania[killerid] ++;
				SetPlayerCriminal(killerid, INVALID_PLAYER_ID, string);
			}
		}
	}
	SetPlayerColor(playerid,COLOR_GRAD2);
	#if DEBUG == 1
		printf("%s[%d] OnPlayerDeath - end", GetNick(playerid), playerid);
	#endif
	return 1;
}

public OnPlayerSpawn(playerid) //Przebudowany
{
	#if DEBUG == 1
		printf("%s[%d] OnPlayerSpawn - begin", GetNick(playerid), playerid);
	#endif
	//Czyszczenie zmiennych
	if(GetPVarInt(playerid, "class-sel")) DeletePVar(playerid, "class-sel");
	DeletePVar(playerid, "Vinyl-bilet");
    DeletePVar(playerid, "Vinyl-VIP");
    PlayerInfo[playerid][pMuted] = 0;
	WnetrzeWozu[playerid] = 0;
	spamwl[playerid] = 0;

	//Diler Broni
	if(PlayerInfo[playerid][pJob] == 9 && !IsADilerBroni(playerid))
	{
	    PlayerInfo[playerid][pJob] = 0;
	    SendClientMessage(playerid, COLOR_WHITE, "Zosta≥eú wyrzucony z pracy!");
	}

	//Skills'y broni
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 1);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 500);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE, 1);

    //Style walki
    if(PlayerInfo[playerid][pStylWalki] == 1) SetPlayerFightingStyle(playerid, FIGHT_STYLE_BOXING);
	else if(PlayerInfo[playerid][pStylWalki] == 2) SetPlayerFightingStyle(playerid, FIGHT_STYLE_KUNGFU);
	else if(PlayerInfo[playerid][pStylWalki] == 3) SetPlayerFightingStyle(playerid, FIGHT_STYLE_KNEEHEAD);

	//DüwiÍki
	StopAudioStreamForPlayer(playerid);
	PlayerFixRadio(playerid);

	//Kubi
	INT_AirTowerLS_Exit(playerid, false, true);

	//Inne
	if(PlayerInfo[playerid][pDom] != 0)
 		Dom[PlayerInfo[playerid][pDom]][hData_DD] = 0; //Zerowanie dni do usuniÍcia domu
	SetPlayerToTeamColor(playerid);

	//SetPlayerSpawn:
	SetPlayerSpawn(playerid);
	#if DEBUG == 1
		printf("%s[%d] OnPlayerSpawn - end", GetNick(playerid), playerid);
	#endif
	return 1;
}

SetPlayerSpawn(playerid)
{
	SetPlayerSpawnPos(playerid);
	SetPlayerSpawnSkin(playerid);
	SetPlayerSpawnWeapon(playerid);
	return 1;
}

SetPlayerSpawnPos(playerid)
{
	//Po /spec off
    if(Unspec[playerid][Coords][0] != 0.0 && Unspec[playerid][Coords][1] != 0.0 && Unspec[playerid][Coords][2] != 0.0)
    {
		if(PlayerInfo[playerid][pAdmin] > 0 || PlayerInfo[playerid][pZG] > 0 || PlayerInfo[playerid][pNewAP] >= 1)
		{
			SetPlayerPosEx(playerid, Unspec[playerid][Coords][0], Unspec[playerid][Coords][1], Unspec[playerid][Coords][2]);
			SetPlayerInterior(playerid, Unspec[playerid][sPint]);
			SetPlayerVirtualWorld(playerid, Unspec[playerid][sPvw]);
			Unspec[playerid][Coords][0] = 0.0, Unspec[playerid][Coords][1] = 0.0, Unspec[playerid][Coords][2] = 0.0;
			Spectate[playerid] = INVALID_PLAYER_ID;
			PhoneOnline[playerid] = 0;
		}
    }
    //Tutorial:
    else if(PlayerInfo[playerid][pTut] == 0)
    {
		gOoc[playerid] = 1; gNews[playerid] = 1; gFam[playerid] = 1;
		TogglePlayerControllable(playerid, 0);
		RegistrationStep[playerid] = 1;
	    SetPlayerPosEx(playerid, 1275.0283203125, -1337.3585205078, -5.0);
	    SetPlayerCameraPos(playerid, 1275.0283203125, -1337.3585205078, 10.852507591248);// kamera
		SetPlayerCameraLookAt(playerid, 1235.1977539063, -1341.1885986328, 54.349945068359);// patrz
		SendClientMessage(playerid, COLOR_YELLOW, "Witaj na Mrucznik Role Play!");
		SendClientMessage(playerid, COLOR_WHITE, "Aby zaczπÊ grÍ musisz przejúÊ procedury rejestracji.");
		ShowPlayerDialogEx(playerid, 70, DIALOG_STYLE_MSGBOX, "Witaj na Mrucznik Role Play", "Witaj na serwerze Mrucznik Role Play\nJeúli jesteú tu nowy, to przygotowaliúmy dla ciebie poradnik\nZa chwilÍ bÍdziesz mÛg≥ go obejrzeÊ, lecz najpierw bÍdziesz musia≥ opisaÊ postaÊ ktÛrπ bÍdziesz sterowa≥\nAby przejúÊ dalej wciúnij przycisk 'dalej'", "Dalej", "");
    }
    //WiÍzienie:
	else if(PlayerInfo[playerid][pJailed] == 1)
	{
		SetPlayerInterior(playerid, 0);
	    SetPlayerVirtualWorld(playerid, 1);
	    new losuj= random(sizeof(Cela));
		SetPlayerPosEx(playerid, Cela[losuj][0], Cela[losuj][1], Cela[losuj][2]);
		SendClientMessage(playerid, COLOR_LIGHTRED, "TwÛj wyrok nie dobieg≥ koÒca, wracasz do wiÍzienia.");
		TogglePlayerControllable(playerid, 0);
		Wchodzenie(playerid);
	}
	else if(PlayerInfo[playerid][pJailed] == 2)
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "TwÛj wyrok nie dobieg≥ koÒca, wracasz do wiÍzienia stanowego");
		JailDeMorgan(playerid);
	}
	else if(PlayerInfo[playerid][pJailed] == 3)
	{
	    SetPlayerInterior(playerid, 0);
		SetPlayerPosEx(playerid,1481.1666259766,-1790.2204589844,156.7875213623);
		PlayerInfo[playerid][pMuted] = 1;
		SetPlayerVirtualWorld(playerid, 1000+playerid);
		SendClientMessage(playerid, COLOR_LIGHTRED, "Gra≥eú NON-RP. Wracasz do Admin Jaila.");
	}
	else if(PlayerInfo[playerid][pJailed] == 10)
	{
	    new string[256];
	    new kaseczka = (kaska[playerid] > 0) ? (kaska[playerid]/2) : 1;
	    new sendername[MAX_PLAYER_NAME];
	    GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "* Zosta≥eú uwieziony w Admin Jailu przez Admina Marcepan_Marks. Powod: /q podczas akcji");
		SendClientMessage(playerid, COLOR_LIGHTRED, string);
		ResetPlayerWeapons(playerid);
		UsunBron(playerid);
		PlayerInfo[playerid][pJailed] = 3;
		PlayerInfo[playerid][pJailTime] = 15*60;
        SetPlayerVirtualWorld(playerid, 1000+playerid);
		PlayerInfo[playerid][pMuted] = 1;
		SetPlayerPosEx(playerid, 1481.1666259766,-1790.2204589844,156.7875213623);
		format(string, sizeof(string), "Zosta≥eú ukarany na 15 minut. Powod: /q podczas akcji");
		SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
		format(string, sizeof(string), "AdmCmd: %s zostal uwieziony w 'AJ' przez Admina Marcepan_Marks. Powod: /q podczas akcji + zabieram po≥owÍ kasy i broÒ", sendername);
		SendClientMessageToAll(COLOR_LIGHTRED, string);
		format(string, sizeof(string), "Dodatkowo zabrano z twojego portfela %d$ i wyzerowano twoje bronie oraz zabrano po≥owÍ matsÛw", kaseczka);
        SendClientMessage(playerid, COLOR_LIGHTRED, string);
        format(string, sizeof(string),"%s dal /q podczas akcji i zabrano mu %d$ i %d mats oraz bronie", sendername, kaseczka, PlayerInfo[playerid][pMats]/2);
        PayLog(string);
        ZabierzKase(playerid, kaseczka);
        PlayerInfo[playerid][pMats] = PlayerInfo[playerid][pMats]/2;
	}
	//Paintball
    else if(PlayerPaintballing[playerid] != 0)
	{
	    ResetPlayerWeapons(playerid);
  		GivePlayerWeapon(playerid, 29, 999);
	    new rand = random(sizeof(PaintballSpawns));
		SetPlayerPosEx(playerid, PaintballSpawns[rand][0], PaintballSpawns[rand][1], PaintballSpawns[rand][2]);
		SetCameraBehindPlayer(playerid);
	}
	//BW:
	else if(PlayerInfo[playerid][pBW] >= 1)
	{
		MedicBill[playerid] = 0;
		MedicTime[playerid] = 0;
		NeedMedicTime[playerid] = 0;
		SetPlayerHealth(playerid, 10.0);
		SetPlayerVirtualWorld(playerid, 0);
        SetPlayerPosEx(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
        TogglePlayerControllable(playerid, 0);
        ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4.1, 0, 0, 0, 0, 0, 1);
        GameTextForPlayer(playerid, "Zostales brutalnie pobity! (3min)", 15000, 5);
        PlayerInfo[playerid][pMuted] = 1;
        if(GetPVarInt(playerid, "bw-skin") != 0) SetPlayerSkin(playerid, GetPVarInt(playerid, "bw-skin"));
	}
    else
    {
	    //-----------------------------------[ Normalny spawn ]-----------------------------------
	    //Przywracanie do poprzedniego spawnu
		if(GetPVarInt(playerid, "spawn") == 2)
		{
			SetPlayerPosEx(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
			SetPlayerInterior(playerid, PlayerInfo[playerid][pInt]);
			SetPlayerVirtualWorld(playerid, 0);
			TogglePlayerControllable(playerid, 1);
		}
		else
		{
		    if(PlayerInfo[playerid][pSpawn] == 0) //Normalny spawn
		    {
		        SetPlayerInteriorEx(playerid, 0);
		        PlayerInfo[playerid][pLocal] = 255;
				if(GetPlayerFraction(playerid) > 0) //Spawn Frakcji
				{
				    switch(GetPlayerFraction(playerid))
				    {
						case FRAC_LSPD: //1
						{
						    new rand = random(sizeof(gCopPlayerSpawns));
							SetPlayerPosEx(playerid, gCopPlayerSpawns[rand][0], gCopPlayerSpawns[rand][1], gCopPlayerSpawns[rand][2]);
							SetPlayerFacingAngle(playerid, 270.0);
						}
						case FRAC_FBI: //2
						{
						    if(PlayerInfo[playerid][pTajniak] == 0)
						    {
                                SetPlayerPosEx(playerid, 598.2130,-1491.1135,15.1351);
								SetPlayerFacingAngle(playerid, 270.0);
		  					}
		  					else if(PlayerInfo[playerid][pTajniak] == 1)
		  					{
		  					    SetPlayerPosEx(playerid, 2495.2163,-1687.2322,13.5150);
		  					}
		  					else if(PlayerInfo[playerid][pTajniak] == 2)
		  					{
		  					    SetPlayerPosEx(playerid, 1939.1940,-1116.3353,27.0151);
		  					}
		  					else if(PlayerInfo[playerid][pTajniak] == 3)
		  					{
                                SetPlayerPosEx(playerid, 738.8827,-1429.9484,13.5234);
		  					}
         					else if(PlayerInfo[playerid][pTajniak] == 4)
		  					{
                                SetPlayerPosEx(playerid, 2801.0273,-1089.4576,30.7188);
		  					}
		  					else if(PlayerInfo[playerid][pTajniak] == 5)
		  					{
		  					    SetPlayerPosEx(playerid, 2467.5117,-1278.2054,29.9264);
							}
		  					else if(PlayerInfo[playerid][pTajniak] == 6)
		  					{
								new rand = random(sizeof(gTajniakSpawn));
								SetPlayerPosEx(playerid, gTajniakSpawn[rand][0], gTajniakSpawn[rand][1], gTajniakSpawn[rand][2]); // Warp the player
								SetPlayerFacingAngle(playerid, 270.0);
		  					}
		  					else
		  					{
                                SetPlayerPosEx(playerid, 2467.5117,-1278.2054,29.9264);
		  					}

						}
						case FRAC_NG: //3
						{
						    SetPlayerPosEx(playerid, 261.8342, 71.2429, 1003.2422);// stara: 2515.0200, -2459.5896, 13.8187
							SetPlayerInterior(playerid, 6);
							SetPlayerVirtualWorld(playerid, 88);
							Wchodzenie(playerid);
						}
						case FRAC_LSMC:  //4
						{
						    SetPlayerPosEx(playerid, 1148.4323,-1315.4225,13.9841);
		    				SetPlayerFacingAngle(playerid,358.0);
						}
						case FRAC_LCN: //5
						{
						    SetPlayerPosEx(playerid, 738.8827,-1429.9484,13.5234);
						}
						case FRAC_YKZ: //6
						{
						    SetPlayerPosEx(playerid, 738.8827,-1429.9484,13.5234);
						}
						case FRAC_BOR: //7
						{
						    SetPlayerPosEx(playerid, 1512.9001,-1471.3433,9.5000);
							//SetPlayerPosEx(playerid, 1525.9830, -1453.0792, 68.0118);
						}
						case FRAC_HA: //8
						{
						    SetPlayerPosEx(playerid, -50.400001525879,-279.20001220703,6.0999999046326);
						}
						case FRAC_SN: //9
						{
						    SetPlayerPosEx(playerid, 735.2266,-1336.5826,13.5358);
						}
						case FRAC_KT: //10
						{
						    SetPlayerPosEx(playerid, 2482.7566, -2105.6033, 32.2773);
							SetPlayerVirtualWorld(playerid,3);
							Wchodzenie(playerid);
						}
						case FRAC_GOV: //11
						{
							if(PlayerInfo[playerid][pLider] == 11)
							{
							    SetPlayerPosEx(playerid, 1473.4933,-1804.0272,163.5459);
							    SetPlayerVirtualWorld(playerid,60);
								PlayerInfo[playerid][pLocal] = 108;
			                    Wchodzenie(playerid);
							}
							else
							{
							    if(SchoolSpawn[playerid] == 0)
								{
								    SetPlayerPosEx(playerid, 1407.7435,-1788.1862,13.5469);
									SetPlayerFacingAngle(playerid, 0.0);
								}
								else
								{
								    SetPlayerPosEx(playerid, 414.4144,2531.9580,19.1565);
									SetPlayerFacingAngle(playerid, 4.6505);
								}
	   						}
						}
						case FRAC_GROOVE: //12
						{
          					SetPlayerPosEx(playerid, 2495.2163,-1687.2322,13.5150);
						}
						case FRAC_BALLAS: //13
						{
						    SetPlayerPosEx(playerid,1936.8698,-1104.7007,26.4531);
						}
						case FRAC_VAGOS: //14
						{
						    SetPlayerPosEx(playerid, 2177.1636,-984.1085,64.4688);
							SetPlayerFacingAngle(playerid, 165.360);
						}
						case FRAC_NOA: //15
						{
						    SetPlayerPosEx(playerid, 2346.1350,-1245.9335,22.5);
		    				SetPlayerFacingAngle(playerid, 90.0);
						}
						case FRAC_WPS: //16
						{
						    SetPlayerPosEx(playerid, 2508.0671,-2019.8987,13.9482);
						}
						case FRAC_LSFD: //17
						{
						    SetPlayerPosEx(playerid, 1757.6122,-1123.4604,227.8059);
				            SetPlayerVirtualWorld(playerid, 22);
						    SetPlayerFacingAngle(playerid,180.0);
						    Wchodzenie(playerid);
						}
				    }
				}
				else if(GetPlayerOrg(playerid) > 0) //Spawn Organizacji
				{
		            new org = gPlayerOrg[playerid];
		            if(OrgInfo[org][o_Spawn][0] != 0.0)
		            {
		                SetPlayerVirtualWorld(playerid, OrgInfo[org][o_VW]);
		    		    SetPlayerInteriorEx(playerid, OrgInfo[org][o_Int]);
		    		    SetPlayerPosEx(playerid, OrgInfo[org][o_Spawn][0], OrgInfo[org][o_Spawn][1], OrgInfo[org][o_Spawn][2]);
		    		    SetPlayerFacingAngle(playerid, OrgInfo[org][o_Spawn][3]);
		            }
		            else
		            {
						SendClientMessage(playerid, COLOR_YELLOW, "Twoja rodzina nie ma jeszcza spawna - spawnujesz siÍ jako cywil.");
                        new rand = random(sizeof(gRandomPlayerSpawns));
			    		SetPlayerPosEx(playerid, gRandomPlayerSpawns[rand][0], gRandomPlayerSpawns[rand][1], gRandomPlayerSpawns[rand][2]);
			    		SetPlayerFacingAngle(playerid, gRandomPlayerSpawns[rand][3]);
					}
				}
				else if(PlayerInfo[playerid][pJob] > 0) //Spawn Prac
				{
				    switch(PlayerInfo[playerid][pJob])
				    {
						case JOB_MECHANIC:
						{
						    SetPlayerPosEx(playerid,2794.5515,-1619.3689,10.9219);
		    				SetPlayerFacingAngle(playerid, 80.0);
						}
						case JOB_LAWYER:
						{
						    SetPlayerPosEx(playerid,319.72470092773, -1548.3374023438, 13.845289230347);
		    				SetPlayerFacingAngle(playerid, 230.0);
						}
						case JOB_LOWCA:
						{
						    SetPlayerPosEx(playerid,322.0553894043, 303.41961669922, 999.1484375);
		    				SetPlayerInterior(playerid,5);
						}
						case JOB_BOXER:
						{
						    SetPlayerPosEx(playerid,766.0804,14.5133,1000.7004);
		    				SetPlayerInterior(playerid, 5);
						}
						case JOB_TRUCKER:
						{
						    SetPlayerPosEx(playerid, 1751.4445, -2054.9761, 13.0593);
		    				SetPlayerFacingAngle(playerid, 180.0);
						}
						case JOB_BUSDRIVER:
						{
						    SetPlayerPosEx(playerid, 1143.0999755859,-1754.0999755859,13.60000038147);
						}
						/*case JOB_BODYGUARD:
						{
						}*/
						default:
						{
							new rand = random(sizeof(gRandomPlayerSpawns));
							SetPlayerPosEx(playerid, gRandomPlayerSpawns[rand][0], gRandomPlayerSpawns[rand][1], gRandomPlayerSpawns[rand][2]);
							SetPlayerFacingAngle(playerid, gRandomPlayerSpawns[rand][3]);
						}
				    }
				}
				else //Spawn cywila
				{
				    new rand = random(sizeof(gRandomPlayerSpawns));
		    		SetPlayerPosEx(playerid, gRandomPlayerSpawns[rand][0], gRandomPlayerSpawns[rand][1], gRandomPlayerSpawns[rand][2]);
		    		SetPlayerFacingAngle(playerid, gRandomPlayerSpawns[rand][3]);
				}
		    }
		    else if(PlayerInfo[playerid][pSpawn] == 1) //Spawn przed domem
		    {
		        new i;
                if(PlayerInfo[playerid][pDom] != 0)
           	 		i = PlayerInfo[playerid][pDom];
				else if(PlayerInfo[playerid][pWynajem] != 0)
             		i = PlayerInfo[playerid][pWynajem];
				else
				{
				    PlayerInfo[playerid][pSpawn] = 0;
					SetPlayerSpawnPos(playerid);
				    return 1;
				}
                SetPlayerPosEx(playerid, Dom[i][hWej_X], Dom[i][hWej_Y], Dom[i][hWej_Z]);
	  		}
	  		else if(PlayerInfo[playerid][pSpawn] == 2) //Spawn w úrodku domu
	  		{
	  		    new i, h, m;
                if(PlayerInfo[playerid][pDom] != 0)
           	 		i = PlayerInfo[playerid][pDom];
				else if(PlayerInfo[playerid][pWynajem] != 0)
             		i = PlayerInfo[playerid][pWynajem];
				else
				{
				    PlayerInfo[playerid][pSpawn] = 0;
					SetPlayerSpawnPos(playerid);
				    return 1;
				}
				GetPlayerTime(playerid, h, m);
   				SetPlayerTime(playerid, Dom[i][hSwiatlo], 0);
     			PlayerInfo[playerid][pDomT] = h;
                PlayerInfo[playerid][pDomWKJ] = PlayerInfo[playerid][pDom];
                SetPlayerPosEx(playerid, Dom[i][hInt_X], Dom[i][hInt_Y], Dom[i][hInt_Z]);
                SetPlayerInteriorEx(playerid, Dom[i][hInterior]);
                SetPlayerVirtualWorld(playerid, Dom[i][hVW]);
                GameTextForPlayer(playerid, "~g~Witamy w domu", 5000, 1);
	  		}
		}
	}

    //Ustawienie kamery:
    if(GetPVarInt(playerid, "spawn"))
		DeletePVar(playerid, "spawn");
    SetCameraBehindPlayer(playerid);
	return 1;
}

SetPlayerSpawnWeapon(playerid)
{
	//Resetowanie broni
    ResetPlayerWeapons(playerid);

    //Dawanie spawnowych broni
	if(GetPlayerFraction(playerid))
    	DajBronieFrakcyjne(playerid);
	if(GetPlayerOrg(playerid))
		DajBronieOganizacji(playerid);
	if(PlayerInfo[playerid][pJob])
	    DajBroniePracy(playerid);
    if(MaZapisanaBron(playerid))
		PrzywrocBron(playerid);

    //HP:
    if(IsACop(playerid) && OnDuty[playerid] == 1 && PlayerInfo[playerid][pTajniak] != 6)
    {
        SetPlayerHealth(playerid, 90);
		SetPlayerArmour(playerid, 15);
    }
    else if(IsAPrzestepca(playerid))
	{
	    SetPlayerHealth(playerid, 90);
	    SetPlayerArmour(playerid, 15);
	}
	else
	{
	    SetPlayerHealth(playerid, 90);
	}
	return 1;
}

SetPlayerSpawnSkin(playerid)
{
    if(PlayerInfo[playerid][pChar] > 0)
		PlayerInfo[playerid][pSkin] = PlayerInfo[playerid][pChar], PlayerInfo[playerid][pChar] = 0;

    if(GetPlayerFraction(playerid) == FRAC_FBI && PlayerInfo[playerid][pTajniak] != 0)
    {
        if(PlayerInfo[playerid][pRank] < 4)
            PlayerInfo[playerid][pTajniak] =0;
		else
		{
		    switch(PlayerInfo[playerid][pTajniak])
		    {
				case 1:
				{
                    SetPlayerSkin(playerid, 107);
				}
				case 2:
				{
                    SetPlayerSkin(playerid, 104);
				}
				case 3:
				{
                    SetPlayerSkin(playerid, 124);
				}
				case 4:
				{
                    SetPlayerSkin(playerid, 123);
				}
				case 5:
				{
                    SetPlayerSkin(playerid, 108);
				}
				case 6:
				{
                    SetPlayerSkin(playerid, PlayerInfo[playerid][pModel]);
				}
			}
			return 1;
		}
    }

	if(PlayerInfo[playerid][pSkin] != 0)
	{
		if(GetPlayerFraction(playerid) != 0)
		{
			if(IsACop(playerid) || GetPlayerFraction(playerid) == FRAC_LSFD || GetPlayerFraction(playerid) == FRAC_LSMC)
			{
				if(OnDuty[playerid] == 1 && OnDutyCD[playerid] == 0)
					SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
				else
					SetPlayerSkin(playerid, PlayerInfo[playerid][pModel]);
			}
			else if(GetPlayerFraction(playerid) == FRAC_SN)
			{
				if(SanDuty[playerid] == 1)
					SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
				else
					SetPlayerSkin(playerid, PlayerInfo[playerid][pModel]);
			}
			else
				SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
		}
		else if(GetPlayerOrg(playerid) != 0)
		{
 			SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
		}
		else if(JobDuty[playerid] == 1)
		{
			SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
		}
	}
    else
	{
		SetPlayerSkin(playerid, PlayerInfo[playerid][pModel]);
	}

	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	#if DEBUG == 1
		printf("%s[%d] OnPlayerEnterCheckpoint - begin", GetNick(playerid), playerid);
	#endif
	new string[128];
	new name[MAX_PLAYER_NAME];
    DisablePlayerCheckpoint(playerid);

	//PAèDZIOCH
	if(GetPVarInt(playerid,"roped") == 1)
    {
   		SetPVarInt(playerid,"roped",0);
        SetPVarInt(playerid,"chop_id",0);
        ClearAnimations(playerid);
        TogglePlayerControllable(playerid,0);
        TogglePlayerControllable(playerid,1);
        for(new i=0;i<=ROPELENGTH;i++)
        {
        	DestroyDynamicObject(r0pes[playerid][i]);
        }
	}

    TJD_CallCheckpoint(playerid, GetPlayerVehicleID(playerid));

	if(TaxiCallTime[playerid] > 0 && TaxiAccepted[playerid] < 999)
	{
	    TaxiAccepted[playerid] = 999;
		GameTextForPlayer(playerid, "~w~Dotarles do celu", 5000, 1);
		TaxiCallTime[playerid] = 0;
		DisablePlayerCheckpoint(playerid);
	}
	else if(BusCallTime[playerid] > 0 && BusAccepted[playerid] < 999)
	{
	    BusAccepted[playerid] = 999;
		GameTextForPlayer(playerid, "~w~Dotarles do celu", 5000, 1);
		BusCallTime[playerid] = 0;
		DisablePlayerCheckpoint(playerid);
	}
	if(CP[playerid]>=550 && CP[playerid]<=999)//Wywo≥uje otwieranie drzwi gdy jest w CP od 550 do 999
	{
		Otwieramdrzwibusa(playerid);
	}
	if(CP[playerid]==1200)
	{
	    SendClientMessage(playerid, COLOR_GREY, "Dojecha≥eú do zajezdni i zakoÒczy≥eú pracÍ.");
		Przystanek(playerid, COLOR_GREEN, "Korporacja Transportowa\n Wydzia≥ Komunikacji Autbusowej");
		DisablePlayerCheckpoint(playerid);
		CP[playerid] = 0;
	}
	if(CP[playerid]==1201)
	{
	    SendClientMessage(playerid, COLOR_GREY, "Dojecha≥eú do zajezdni i zakoÒczy≥eú pracÍ.");
		Przystanek(playerid, COLOR_YELLOW, "Los Santos Bus Department\n Komunikacja Miejska");
		DisablePlayerCheckpoint(playerid);
		CP[playerid] = 0;
	}
	//Linia numer 55 autobusa SYSTEM AUTOBUS”W
	if(PlayerInfo[playerid][pLinia55]==1)
	{
	if(CP[playerid]==551) //Sprawdza czy dojecha≥ do nastepnego
	{

		DisablePlayerCheckpoint(playerid); //usuwa cp i...
		SendClientMessage(playerid, COLOR_YELLOW, "|_____________Przypomnienie_____________|");
		SendClientMessage(playerid, COLOR_GREEN, "Nie zapomnij rozpoczπÊ s≥uøby!!!");
		SendClientMessage(playerid, COLOR_GREEN, "Wpisz {FFFF00}/fare [cena]");
		SendClientMessage(playerid, COLOR_GREEN, "Jezeli chcesz ruszyÊ po wjechaniu w przystanek wpisz /zd");
		SendClientMessage(playerid, COLOR_GREEN, "Jeøeli bÍdziesz chcia≥ przerwaÊ trasÍ wczeúniej wpisz /zakoncztrase");
		SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>/fare<<_____________|");
		Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \n Kierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Jefferson - Glen Park - Idlewood - El Corona - Urzπd Miasta - Downtown - Market - Rodeo\n{808080}NastÍpny przystanek: Motel Jefferson");
		ProxDetector(10.0, playerid, "Linia numer: {3333FF}55 (niebieska) {FFFF00} Kierunek ==> {3333FF}MRUCZNIK TOWER", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		SetPlayerCheckpoint(playerid, 2248.4707,-1139.6617,25.7001, 4); //... ustawia nastepnego
		CP[playerid]=552; //przypisuje id dla cp
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);

	}
	else if(CP[playerid]==552)
	{
	    ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Jefferson ñ Motel Jefferson", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 1967.2327,-1198.9353,25.2217, 4);
		CP[playerid]=553;
		Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \n Kierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Glen Park - Idlewood - El Corona - Urzπd Miasta - Downtown - Market - Rodeo\n{808080}NastÍpny przystanek: Glen Park");
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+230$");
	}
	else if(CP[playerid]==553)
	{
	    ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Glen Park", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 1844.0139,-1361.4354,12.9694, 4);
		CP[playerid]=554;
		Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \n Kierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Idlewood - El Corona - Urzπd Miasta - Downtown - Market - Rodeo\n{808080}NastÍpny przystanek: Skate Park");
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
	}
	else if(CP[playerid]==554)
	{
	    ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Idlewood ñ Skate Park", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+230$");
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 1742.6479,-1816.3966,12.9351, 4);
		CP[playerid]=555;
		Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \n Kierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: El Corona - Urzπd Miasta - Downtown - Market - Rodeo\n{808080}NastÍpny przystanek: Unity Station");
	}
	else if(CP[playerid]==555)
	{
	    ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}El Corona ñ Unity Station", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+230$");
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 1532.3134,-1648.4254,12.9485, 4); //Przystanek Komisariat
		CP[playerid]=556;
		Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \n Kierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Urzπd Miasta - Downtown - Market - Rodeo\n{808080}NastÍpny przystanek: Komisariat / Urzπd Miasta");
	}
	else if(CP[playerid]==556)
	{
	    ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Pershing Square ñ Komisariat / Urzπd Miasta", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+230$");
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 1452.3877,-1031.1976,23.2277, 4);
		CP[playerid]=557;
		Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \n Kierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Downtown - Market - Rodeo\n{808080}NastÍpny przystanek: Verte Bank ");
	}
	else if(CP[playerid]==557)
	{
	    ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Downtown ñ Bank", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+230$");
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 1008.5986,-1140.0272,23.2408, 4);
		CP[playerid]=558;
		Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \n Kierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Market - Rodeo\n{808080}NastÍpny przystanek: Bymber Casino ");
	}
	else if(CP[playerid]==558)
	{
	    ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Market ñ Bymber Casino", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+230$");
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 836.6970,-1318.8370,12.9458, 4);
		CP[playerid]=559;
		SendClientMessage(playerid, COLOR_YELLOW, "|_____________Komunikat_____________|");
		SendClientMessage(playerid, COLOR_GREEN, "Na najbliøszym skrzyøowaniu W LEWO");
		SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>LSBD GPS<<_____________|");
		Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \n Kierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Market - Rodeo\n{808080}NastÍpny przystanek: Market Station");
	}
	else if(CP[playerid]==559)
	{
	    ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Market Station", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+230$");
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 708.8574,-1391.8915,13.0002, 4);
		CP[playerid]=560;
		Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \n Kierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Rodeo\n{808080}NastÍpny przystanek: Centrala SAN");
	}
	else if(CP[playerid]==560)
	{
	    ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Rodeo- Centrala SAN", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+230$");
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 625.2355,-1470.5664,13.9573, 4);
		CP[playerid]=1008;
		Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \n Kierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Rodeo\n{808080}NastÍpny przystanek: G≥Ûwna siedziba FBI (N/Ø)");
	}
	else if(CP[playerid]==1008)
	{
	    ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Rodeo ñ G≥Ûwna siedziba FBI (N/Ø)", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+230$");
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 354.7779,-1643.9617,32.4429, 4);
		CP[playerid]=562;
		Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \n Kierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Rodeo\n{808080}NastÍpny przystanek: Molo WÍdkarskie ");
	}
	else if(CP[playerid]==562)
	{
	    ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Rodeo ñ Molo WÍdkarskie", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+230$");
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 378.3281,-1424.5344,34.2901, 4); //nawrotka CP
		CP[playerid]=1001;
		SendClientMessage(playerid, COLOR_YELLOW, "|_____________Komunikat_____________|");
		SendClientMessage(playerid, COLOR_GREEN, "Przygotuj siÍ do wykonania NAWROTU");
		SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>LSBD GPS<<_____________|");
		Przystanek(playerid, COLOR_BLUE, "Linia numer 55 \nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Rodeo\n{808080}NastÍpny przystanek: MRUCZNIK TOWER ");
	}
	else if(CP[playerid]==1001)
	{
	    ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek koÒcowy {EE82EE}Rodeo ñ Biurowiec 'Mrucznik Tower'", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+230$");
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 341.5396,-1531.1141,32.8992, 4); //CP mrucznik tower
		TogglePlayerControllable(playerid, 1);
		CP[playerid]=563;
		SendClientMessage(playerid, COLOR_YELLOW, "|_____________Komunikat_____________|");
		SendClientMessage(playerid, COLOR_GREEN, "Za chwilÍ zbliøysz siÍ do koÒca trasy! (1/2 zadania).");
		SendClientMessage(playerid, COLOR_GREEN, "Moøesz odpoczπÊ nie wjeødøajπc w kolejny checkpoint lub ruszyÊ dalej.");
		SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>LSBD GPS<<_____________|");
		Przystanek(playerid, COLOR_BLUE, "Linia nr 55 \nKierunek: KoúciÛ≥\n{778899}Trasa: Rodeo - Market - Downtown - Urzπd Miasta - El Corona - Idlewood - Glen Park - Jefferson\n{808080}Odjazd nastπpi po sygnale");
	}
	else if(CP[playerid]==563)
	{
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+230$");
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 359.0248,-1647.8008,32.3386, 4); //molo wÍdkarskie
		CP[playerid]=564;
		ProxDetector(10.0, playerid, "Linia numer: {3333FF}55 (niebieska) {FFFF00} Kierunek ==> {3333FF}KOåCI”£", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: KoúciÛ≥\n{778899}Trasa: Rodeo - Market - Downtown - Urzπd Miasta - El Corona - Idlewood - Glen Park - Jefferson\n{808080}NastÍpny przystanek: Molo WÍdkarskie");
	}
	else if(CP[playerid]==564)
	{
	    ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Rodeo ñ Molo WÍdkarskie", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+230$");
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 639.6337,-1452.6040,13.7631, 4);
		CP[playerid]=1007;
		Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: KoúciÛ≥\n{778899}Trasa: Rodeo - Market - Downtown - Urzπd Miasta - El Corona - Idlewood - Glen Park - Jefferson\n{808080}NastÍpny przystanek: G≥Ûwna siedziba FBI (N/Ø) ");
	}
	else if(CP[playerid]==1007)
	{
	    ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Rodeo ñ G≥Ûwna siedziba FBI (N/Ø)", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+230$");
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 723.2538,-1407.2189,12.9320, 4);
		CP[playerid]=566;
		Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: KoúciÛ≥\n{778899}Trasa: Rodeo - Market - Downtown - Urzπd Miasta - El Corona - Idlewood - Glen Park - Jefferson\n{808080}NastÍpny przystanek: Centrala SAN ");
	}
	else if(CP[playerid]==566)
	{
	    ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Rodeo- Centrala SAN", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+230$");
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 830.8025,-1330.0034,13.5437, 4);
		CP[playerid]=567;
		Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: KoúciÛ≥\n{778899}Trasa: Market - Downtown - Urzπd Miasta - El Corona - Idlewood - Glen Park - Jefferson\n{808080}NastÍpny przystanek: Market Station ");
	}
	else if(CP[playerid]==567)
	{
	    ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Market Station", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+230$");
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 1034.3179,-1150.8452,23.2292, 4); //Bymber Kasyno
		CP[playerid]=568;
		Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: KoúciÛ≥\n{778899}Trasa: Market - Downtown - Urzπd Miasta - El Corona - Idlewood - Glen Park - Jefferson\n{808080}NastÍpny przystanek: Bymber Casino ");
	}
	else if(CP[playerid]==568)
	{
	    ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Market ñ Bymber Casino", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+230$");
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 1449.7135,-1037.4396,23.2312, 4); //Bank
		CP[playerid]=569;
		Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: KoúciÛ≥\n{778899}Trasa: Downtown - Urzπd Miasta - El Corona - Idlewood - Glen Park - Jefferson\n{808080}NastÍpny przystanek: Verte Bank ");
	}
	else if(CP[playerid]==569)
	{
	    ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Downtown ñ Bank", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+230$");
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 1527.9624,-1695.4071,12.9535, 4); //Komisariat LS
		CP[playerid]=570;
		Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: KoúciÛ≥\n{778899}Trasa: Urzπd Miasta - El Corona - Idlewood - Glen Park - Jefferson\n{808080}NastÍpny przystanek: Komisariat / Urzπd Miasta ");
	}
	else if(CP[playerid]==570)
	{
	    ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Pershing Square ñ Komisariat", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+230$");
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 1791.1583,-1833.9706,12.9519, 4);
		CP[playerid]=571;
		Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: KoúciÛ≥\n{778899}Trasa: El Corona - Idlewood - Glen Park - Jefferson\n{808080}NastÍpny przystanek: Unity Station ");
	}
	else if(CP[playerid]==571)
	{
	    ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}El Corona ñ Unity Station", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+230$");
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 1853.2744,-1393.1622,12.9655, 4);
		CP[playerid]=572;
		Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: KoúciÛ≥\n{778899}Trasa: Idlewood - Glen Park - Jefferson\n{808080}NastÍpny przystanek: Skate Park ");
	}
	else if(CP[playerid]==572)
	{
	    ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Idlewood ñ Skate Park", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+230$");
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 1972.9082,-1198.7592,25.2214, 4);
		CP[playerid]=573;
		Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: KoúciÛ≥\n{778899}Trasa: Glen Park - Jefferson\n{808080}NastÍpny przystanek: Glen Park ");
	}
	else if(CP[playerid]==573)
	{
	    ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Glen Park", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+230$");
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 2255.2795,-1145.6331,26.0940, 4);
		CP[playerid]=574;
		Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: KoúciÛ≥\n{778899}Trasa: Jefferson\n{808080}NastÍpny przystanek: Motel Jefferson ");
	}
	else if(CP[playerid]==574)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 2210.0313,-1440.1292,23.3929, 4); //KoÒcowy CP po drugiej stronie
		CP[playerid]=575;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 55: {FFFF00}Przystanek {EE82EE}Jefferson ñ Motel Jefferson", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+230$");
		Przystanek(playerid, COLOR_BLUE, "Linia nr 55\nKierunek: KoúciÛ≥\n{778899}Trasa: Jefferson\n{808080}NastÍpny przystanek: KOåCI”£ ");
	}
	else if(CP[playerid]==575)
	{
	    if(BusCzit[playerid] == 1)
		{
		    KickEx(playerid);
		}
		else
		{
		    ProxDetector(10.0, playerid, "Przystanek koÒcowy: {EE82EE}Jefferson ñ KoúciÛ≥", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			DisablePlayerCheckpoint(playerid);
			//TogglePlayerControllable(playerid, 0);//Zamraøamy do pÛki nie odpowie co robi dalej
			//ShowPlayerDialogEx(playerid, 8888, DIALOG_STYLE_MSGBOX, "Trasa", "Zrobi≥eú pe≥nπ trasÍ. Co zamierzasz teraz zrobiÊ?\n\nWciúnij PonÛw aby wczytaÊ trasÍ jeszcze raz.\nWciúnij Innπ aby wybraÊ innπ trasÍ.", "PonÛw", "Innπ");
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________Trasa linii 55 zakoÒczona!_____________|");
			SendClientMessage(playerid, COLOR_GREEN, "Otrzymujesz 5980$ premii za dwukrotne przejechanie trasy! (26 przystankÛw)");
			SendClientMessage(playerid, COLOR_GREEN, "Moøesz znÛw rozpoczπÊ tπ lub innπ trasÍ lub zrezygnowaÊ poprzez zamkniÍcie menu wyboru.");
			SendClientMessage(playerid, COLOR_GREEN, "Jeøeli jednak chcesz zakoÒczyÊ pracÍ kieruj siÍ do zajezdni LSBD (wskazanej przez GPS).");
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>Los Santos Bus Department<<_____________|");
			SendClientMessage(playerid, COLOR_GRAD1, "Skill +2");
			PlayerInfo[playerid][pCarSkill] += 2;
            if(GetPlayerFraction(playerid) == FRAC_KT) Sejf_Add(FRAC_KT, 5980);
            else DajKase(playerid, 5980);
			CP[playerid] = 0;
			PlayerInfo[playerid][pLinia55] = 0;
			PlayerInfo[playerid][pNatrasiejest] = 0;
			ShowPlayerDialogEx(playerid, 8155, DIALOG_STYLE_LIST, "Wybierz swÛj kurs:", "Linia 55 -niebieska (230$/p , 9min, 21p, +2)\nLinia 72- pomaraÒczowa (200$/p, 6min, 15p, +1)\nLinia 96 - zielona 4s (310$/p, 8min, 24p, +1)\nLinia 82 øÛ≥ta 5s (510$/p , 11min, 18p, +3)\nLinia 85 3s (270$/p , ? min, 24p, +2)\nWycieczka 5s\nPowrÛt do bazy\nPomoc", "Wybierz", "Wyjdz");
			if(PlayerInfo[playerid][pMember] == 10 || PlayerInfo[playerid][pLider] == 10)
			{
			Przystanek(playerid, COLOR_BLUE, "Linia ZAJ\nLinia 55 do zajezdni Ocean Docks\n{778899}Trasa: Idlewood - Willowfield\n{808080}Zatrzymuje siÍ na przystankach");
			SetPlayerCheckpoint(playerid, 2431.2551,-2094.0959,13.5469, 4);
			CP[playerid]=1200;
			}
			else if(PlayerInfo[playerid][pJob] == 10)
			{
			Przystanek(playerid, COLOR_BLUE, "Linia ZAJ\nLinia 55 do zajezdni Commerce\n{778899}Trasa: Idlewood - Pershing Square - Commerce\n{808080}Zatrzymuje siÍ na przystankach");
			SetPlayerCheckpoint(playerid, 1138.5,-1738.3,13.5, 4);
			CP[playerid]=1201;
			}

		}
	}
	}
// KONIEC LINII 55 AUTOBUS”W

//Linia numer 72 autobusa SYSTEM AUTOBUS”W
	if(PlayerInfo[playerid][pLinia72]==1)
	{
	if(CP[playerid]==721) //Sprawdza czy dojecha≥ do nastepnego
	{
		DisablePlayerCheckpoint(playerid); //usuwa cp i...
		SendClientMessage(playerid, COLOR_YELLOW, "|_____________Przypomnienie_____________|");
		SendClientMessage(playerid, COLOR_GREEN, "Nie zapomnij rozpoczπÊ s≥uøby!!!");
		SendClientMessage(playerid, COLOR_GREEN, "Wpisz {FFFF00}/fare [cena]");
		SendClientMessage(playerid, COLOR_GREEN, "Jezeli chcesz ruszyÊ po wjechaniu w przystanek wpisz /zd");
		SendClientMessage(playerid, COLOR_GREEN, "Jeøeli bÍdziesz chcia≥ przerwaÊ trasÍ wczeúniej wpisz /zakoncztrase");
		SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>/fare<<_____________|");
		ProxDetector(10.0, playerid, "Linia numer: {FFA500}72 (pomaraÒczowa)  {FFFF00}Kierunek ==> {FFA500}MRUCZNIK TOWER", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		SetPlayerCheckpoint(playerid, 2572.6025,-1728.8365,13.3093, 4);
		CP[playerid]=740; //przypisuje id dla cp up
		Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Ganton - Idlewood - Urzπd Miasta - Downtown - Market - Rodeo\n{808080}NastÍpny przystanek: Groove Street");
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);//
	}
	//nowe ganton GS lewo 2471,-1735.9000244141,13.39999961853
	//nowe ganton GS prawy 2590.6999511719,-1728.8000488281,13.39999961853
	else if(CP[playerid]==740)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 2297.6785,-1655.4948,14.3767, 4);
		CP[playerid]=1009;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Ganton ñ Groove Street", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+100$");
		Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Ganton - Idlewood - Urzπd Miasta - Downtown - Market - Rodeo\n{808080}NastÍpny przystanek: Bar Ten Green Bottles (N/Ø)");
	}
	else if(CP[playerid]==1009)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 2182.5671,-1708.4637,13.4766, 4); //
		CP[playerid]=722;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Ganton ñ Bar Ten Green Bottles (N/Ø)", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+50$");
		Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Idlewood - Urzπd Miasta - Downtown - Market - Rodeo\n{808080}NastÍpny przystanek: Si≥ownia");
	}
	else if(CP[playerid]==722)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid,  1890.3834,-1749.6218,12.9520, 4);//
		CP[playerid]=723;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Idlewood ñ Si≥ownia", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+200$");
		Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Idlewood - Urzπd Miasta - Downtown - Market - Rodeo\n{808080}NastÍpny przystanek: Stacja Benzynowa");
	}
	else if(CP[playerid]==723)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 1532.3134,-1648.4254,12.9485, 4);
		CP[playerid]=724;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Idlewood ñ Stacja Benzynowa", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+200$");
		Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Urzπd Miasta - Downtown - Market - Rodeo\n{808080}NastÍpny przystanek: Komisariat / Urzπd Miasta ");
	}
	else if(CP[playerid]==724)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 1452.3877,-1031.1976,23.2277, 4);
		CP[playerid]=725;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Pershing Square ñ Komisariat / Urzπd Miasta", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+200$");
		Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Downtown - Market - Rodeo\n{808080}NastÍpny przystanek: Verte Bank (jedn.) ");
	}
	else if(CP[playerid]==725)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 1340.7183,-1346.4941,12.9510, 4); //stacja benz prawa
		CP[playerid]=726;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Downtown ñ Bank (jednokierunkowy)", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+200$");
		Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Downtown - Market - Rodeo\n{808080}NastÍpny przystanek: Ammu-Nation (jedn.)");
	}
	else if(CP[playerid]==726)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 1208.1235,-1314.7834,12.9645, 4);
		CP[playerid]=727;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Downtown - Ammu-Nation(jednokierunkowy)", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+200$");
		Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Market - Rodeo\n{808080}NastÍpny przystanek: Szpital");
	}
	else if(CP[playerid]==727)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 836.6970,-1318.8370,12.9458, 4);
		CP[playerid]=728;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Market ñ Szpital", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+200$");
		Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Market - Rodeo\n{808080}NastÍpny przystanek: Market Station ");
	}
	else if(CP[playerid]==728)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 341.5396,-1531.1141,32.8992, 4); //mrucznik tower
		CP[playerid]=729;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Market Station", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+200$");
		Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Biurowiec 'Mrucznik Tower'\n{778899}Trasa: Rodeo\n{808080}NastÍpny przystanek: MRUCZNIK TOWER ");
	}
	else if(CP[playerid]==729)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 260.5440,-1531.3761,32.1662, 4); //nawrotka przy mrucznik tower
		CP[playerid]=1003;
  		ProxDetector(10.0, playerid, "Przystanek koÒcowy: {EE82EE}Rodeo ñ Biurowiec 'Mrucznik Tower'", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
  		SendClientMessage(playerid, COLOR_YELLOW, "|_____________Komunikat_____________|");
		SendClientMessage(playerid, COLOR_GREEN, "Gratulacje! UkoÒczy≥eú trasÍ do Mrucznik Tower! (1/2 zadania). Moøesz tu odpoczπÊ.");
		SendClientMessage(playerid, COLOR_GREEN, "Jeøeli chcesz jechaÊ dalej wykonaj nawrÛt kierujπc siÍ do kolejnego checkpointu!");
		SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>LSBD GPS<<_____________|");
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+200$");
		Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Baza MechanikÛw\n{778899}Trasa: Market - Downtown - Urzπd Miasta - Idlewood - Ganton - East Los Santos\n{808080}Odjazd nastπpi po sygnale!");
	}
	else if(CP[playerid]==1003)
	{
     	TogglePlayerControllable(playerid, 1);
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 830.8025,-1330.0034,13.5437, 4);
		CP[playerid]=730;
		ProxDetector(10.0, playerid, "Linia numer: {FFA500}72 (pomaraÒczowa)  {FFFF00}Kierunek ==> {FFA500}BAZA MECHANIK”W", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+200$");
		Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Baza MechanikÛw\n{778899}Trasa: Market - Downtown - Urzπd Miasta - Idlewood - Ganton - East Los Santos\n{808080}NastÍpny przystanek: Market Station ");
	}
	else if(CP[playerid]==730)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 1193.7321,-1358.3251,12.9416, 4);
		CP[playerid]=731;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Market Station", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+200$");
		Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Baza MechanikÛw\n{778899}Trasa:  Market - Downtown - Urzπd Miasta - Idlewood - Ganton - East Los Santos\n{808080}NastÍpny przystanek: Szpital ");

	}
	else if(CP[playerid]==731)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 1527.9624,-1695.4071,12.9535, 4);//komi LS
		CP[playerid]=734;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Market - Szpital", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+200$");
		Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Baza MechanikÛw\n{778899}Trasa: Downtown - Urzπd Miasta - Idlewood - Ganton - East Los Santos\n{808080}NastÍpny przystanek: Urzπd Miasta/Komisariat ");
	}
	else if(CP[playerid]==734)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 1924.6978,-1754.4702,12.9486, 4);
		CP[playerid]=735;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Pershing Square ñ Komisariat / Urzπd Miasta", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+200$");
		Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Baza MechanikÛw\n{778899}Trasa: Idlewood - Ganton - East Los Santos\n{808080}NastÍpny przystanek: Stacja Benzynowa ");
	}
	else if(CP[playerid]==735)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 2162.4690,-1754.0964,12.9439, 4);
		CP[playerid]=736;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Idlewood ñ Stacja Benzynowa", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+200$");
		Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Baza MechanikÛw\n{778899}Trasa: Idlewood - Ganton - East Los Santos\n{808080}NastÍpny przystanek: Si≥ownia");
	}
	else if(CP[playerid]==736)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 2314.7969,-1661.7714,13.8587  , 4);
		CP[playerid]=1010;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Idlewood - Szamboa Gym", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+200$");
		Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Baza MechanikÛw\n{778899}Trasa: Ganton - East Los Santos\n{808080}NastÍpny przystanek: Bar Ten Green Bottles (N/Ø) ");
	}
	else if(CP[playerid]==1010)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 2489.3118,-1735.8690,13.3172 , 4);
		CP[playerid]=742;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Ganton - Bar Ten Green Bottles (N/Ø)", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+50$");
		Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Baza MechanikÛw\n{778899}Trasa: Ganton - East Los Santos\n{808080}NastÍpny przystanek: Groove Street ");
	}
	else if(CP[playerid]==742)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 2818.4243,-1576.9399,10.9287, 4);
		CP[playerid]=737;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 72: {FFFF00}Przystanek {EE82EE}Ganton - Groove Street", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+100$");
		Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia nr 72\nKierunek: Baza MechanikÛw\n{778899}Trasa: Ganton - East Los Santos\n{808080}NastÍpny przystanek: BAZA MECHANIK”W (pÍtla) ");
	}
	else if(CP[playerid]==737)
	{
	    if(BusCzit[playerid] == 1)
		{
		    KickEx(playerid);
		}
		else
		{
		    ProxDetector(10.0, playerid, "Przystanek koÒcowy: {EE82EE}East Los Santos - Baza MechanikÛw (pÍtla)", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			DisablePlayerCheckpoint(playerid);
			TogglePlayerControllable(playerid, 0);//Zamraøamy do pÛki nie odpowie co robi dalej
			//ShowPlayerDialogEx(playerid, 8888, DIALOG_STYLE_MSGBOX, "Trasa", "Zrobi≥eú pe≥nπ trasÍ. Co zamierzasz teraz zrobiÊ?\n\nWciúnij PonÛw aby wczytaÊ trasÍ jeszcze raz.\nWciúnij Innπ aby wybraÊ innπ trasÍ.", "PonÛw", "Innπ");
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________Trasa linii 72 zakoÒczona!_____________|");
			SendClientMessage(playerid, COLOR_GREEN, "Otrzymujesz 3300$ premii za dwukrotne przejechanie trasy! (19 przystankÛw)");
			SendClientMessage(playerid, COLOR_GREEN, "Moøesz znÛw rozpoczπÊ tπ lub innπ trasÍ lub zrezygnowaÊ poprzez zamkniÍcie menu wyboru.");
			SendClientMessage(playerid, COLOR_GREEN, "Chcπc powtÛrzyÊ tπ trasÍ zawrÛÊ wykorzystujπc parking znajdujπcy siÍ na skrzyøowaniu w w lewo.");
			SendClientMessage(playerid, COLOR_GREEN, "Jeøeli jednak chcesz zakoÒczyÊ pracÍ kieruj siÍ do zajezdni LSBD (wskazanej przez GPS).");
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>Los Santos Bus Department<<_____________|");
			SendClientMessage(playerid, COLOR_GRAD1, "Skill +1");
			PlayerInfo[playerid][pCarSkill] ++;
            if(GetPlayerFraction(playerid) == FRAC_KT) Sejf_Add(FRAC_KT, 3300);
            else DajKase(playerid, 3300);
			CP[playerid] = 0;
			PlayerInfo[playerid][pLinia72] = 0;
			PlayerInfo[playerid][pNatrasiejest] = 0;
			ShowPlayerDialogEx(playerid, 8155, DIALOG_STYLE_LIST, "Wybierz swÛj kurs:", "Linia 55 -niebieska (230$/p , 9min, 21p, +2)\nLinia 72- pomaraÒczowa (200$/p, 6min, 15p, +1)\nLinia 96 - zielona 4s (310$/p, 8min, 24p, +1)\nLinia 82 øÛ≥ta 5s (510$/p , 11min, 18p, +3)\nLinia 85 3s (270$/p , ? min, 24p, +2)\nWycieczka 5s\nPowrÛt do bazy\nPomoc", "Wybierz", "Wyjdz");
			if(PlayerInfo[playerid][pMember] == 10 || PlayerInfo[playerid][pLider] == 10)
			{
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia ZAJ\nLinia 72 do zajezdni Ocean Docks\n{778899}Trasa: Idlewood - Willowfield\n{808080}Zatrzymuje siÍ na przystankach");
			SetPlayerCheckpoint(playerid, 2431.2551,-2094.0959,13.5469, 4);
			CP[playerid]=1200;
			}
			else if(PlayerInfo[playerid][pJob] == 10)
			{
			Przystanek(playerid, 0xAFAFAFFF, "{FFA500}Linia ZAJ\nLinia 72 do zajezdni Commerce\n{778899}Trasa: Idlewood - Pershing Square - Commerce\n{808080}Zatrzymuje siÍ na przystankach");
			SetPlayerCheckpoint(playerid, 1138.5,-1738.3,13.5, 4);
			CP[playerid]=1201;
			}
		}
	}
	}
// KONIEC LINII 72 AUTOBUS”W
	//Linia numer 82 autobusa SYSTEM AUTOBUS”W
 if(PlayerInfo[playerid][pLinia82]==1)
	{
	if(CP[playerid]==821) //Sprawdza czy dojecha≥ do nastepnego
	{
		SendClientMessage(playerid, COLOR_YELLOW, "|_____________Przypomnienie_____________|");
		SendClientMessage(playerid, COLOR_GREEN, "Nie zapomnij rozpoczπÊ s≥uøby!!!");
		SendClientMessage(playerid, COLOR_GREEN, "Wpisz {FFFF00}/fare [cena]");
		SendClientMessage(playerid, COLOR_GREEN, "Jezeli chcesz ruszyÊ po wjechaniu w przystanek wpisz /zd");
		SendClientMessage(playerid, COLOR_GREEN, "Jeøeli bÍdziesz chcia≥ przerwaÊ trasÍ wczeúniej wpisz /zakoncztrase");
		SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>/fare<<_____________|");
		ProxDetector(10.0, playerid, "Linia numer: {DAA520}82 (øÛ≥ta) {FFFF00}Kierunek ==> {DAA520}BAY SIDE", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		SetPlayerCheckpoint(playerid, 1532.3134,-1648.4254,12.9485, 4); //... ustawia nastepnego KOMi (jedn)
		CP[playerid]=822; //przypisuje id dla cp up
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);//
		Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Bay Side\n{778899}Trasa: Urzπd Miasta - East Los Santos - Palomino Creek - Dillimore - Bluberry - Las Venturas\n{808080}NastÍpny przystanek: Komisariat / Urzπd Miasta ");
	}
	else if(CP[playerid]==822)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 2864.6250,-1539.0991,10.4947, 4);
		CP[playerid]=823;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}Pershing Square ñ Komisariat / Urzπd Miasta", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		SendClientMessage(playerid, COLOR_YELLOW, "|_____________Droga do MechanikÛw_____________|");
		SendClientMessage(playerid, COLOR_GREEN, "Kieruj siÍ do Alhambry, potem w LEWO.");
		SendClientMessage(playerid, COLOR_GREEN, "Wjedü na autostradÍ, nastÍpnie prosto do bazy mechanikÛw.");
		SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>LSBD GPS<<_____________|");
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+510$");
		Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Bay Side\n{778899}Trasa: East Los Santos - Palomino Creek - Dillimore - Bluberry - Las Venturas\n{808080}NastÍpny przystanek: Baza MechanikÛw ");

	}
	else if(CP[playerid]==823)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 2839.9409,-1098.3546,23.5453, 4);
		CP[playerid]=824;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}East Los Santos ñ Baza MechanikÛw", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+510$");
		Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Bay Side\n{778899}Trasa: East Los Santos - Palomino Creek - Dillimore - Bluberry - Las Venturas\n{808080}NastÍpny przystanek: Agencja Ochrony ");
	}
	else if(CP[playerid]==824)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 2339.9377,39.4851,26.3359, 4);
		CP[playerid]=825;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}East Los Santos ñ Agencja Ochrony", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
        SendClientMessage(playerid, COLOR_YELLOW, "|_____________Droga do PC_____________|");
		SendClientMessage(playerid, COLOR_GREEN, "Jedü ciπgle prosto zwyk≥π drogπ. Nie zjeødøaj na autostradÍ.");
		SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>LSBD GPS<<_____________|");
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+510$");
		Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Bay Side\n{778899}Trasa: Palomino Creek - Dillimore - Bluberry - Las Venturas\n{808080}NastÍpny przystanek: miasteczko Palomino Creek ");
	}
	else if(CP[playerid]==825)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 1051.7797,-444.1544,51.0848, 4); //Przystanek PC
		CP[playerid]=826;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}Palomino Creek", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
  		SendClientMessage(playerid, COLOR_YELLOW, "|_____________Droga do Dillimore_____________|");
		SendClientMessage(playerid, COLOR_GREEN, "Gdy przejedziesz po moúcie za 400m SKR ∆ W LEWO na most.");
		SendClientMessage(playerid, COLOR_GREEN, "PÛüneij kieruj siÍ do tunelu. Ca≥y czas prosto");
		SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>LSBD GPS<<_____________|");
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+510$");
		Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Bay Side\n{778899}Trasa: Dillimore - Bluberry - Las Venturas\n{808080}NastÍpny przystanek: Hilltop Farm ");
	}
	else if(CP[playerid]==826)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 661.4372,-597.9591,15.7536, 4);
		CP[playerid]=827;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}Dillimore ñ Hilltop Farm", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+510$");
		Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Bay Side\n{778899}Trasa: Dillimore - Bluberry - Las Venturas\n{808080}NastÍpny przystanek: miasteczko Dillimore ");
	}
	else if(CP[playerid]==827)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 235.2872,-54.7197,1.5620, 4);
		CP[playerid]=828;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}Dillimore", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		SendClientMessage(playerid, COLOR_YELLOW, "|_____________Droga do Bluberry_____________|");
		SendClientMessage(playerid, COLOR_GREEN, "Gdy miniesz komisariat SKR ∆ W LEWO.");
		SendClientMessage(playerid, COLOR_GREEN, "Jedü prosto drogπ do i SKR ∆ W LEWO do wyjazdu przy Cowboy Bar. Potem prosto.");
		SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>LSBD GPS<<_____________|");
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+510$");
		Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Bay Side\n{778899}Trasa: Bluberry - Las Venturas\n{808080}NastÍpny przystanek: miasteczko Bluberry ");
	}
	else if(CP[playerid]==828)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, -2494.9761,2333.7603,4.9693, 4);//bay side koÒcowy
		CP[playerid]=829;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}Bluberry", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		SendClientMessage(playerid, COLOR_YELLOW, "|_____________Droga do Bay Side_____________|");
		SendClientMessage(playerid, COLOR_GREEN, "Po wyjeüdzie z Bluberry SKR ∆ W LEWO");
		SendClientMessage(playerid, COLOR_GREEN, "Po przejechaniu 800m SKR ∆ W PRAWO na most");
		SendClientMessage(playerid, COLOR_GREEN, "NastÍpnie za 300m SKR ∆ W LEWO na autostrade. Dalej ca≥y czas prosto.");
		SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>LSBD GPS<<_____________|");
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+510$");
		Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Bay Side\n{778899}Trasa: Las Venturas\n{808080}NastÍpny przystanek: miasteczko Bay Side ");
	}
	else if(CP[playerid]==829)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, -2538.2993,2333.5835,4.8281, 4);
		CP[playerid]=1000;
		ProxDetector(10.0, playerid, "Przystanek koÒcowy: {EE82EE}Bay Side", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
        SendClientMessage(playerid, COLOR_YELLOW, "|_____________Komunikat_____________|");
		SendClientMessage(playerid, COLOR_GREEN, "Gratulacje! UkoÒczy≥eú trasÍ do Bay Side! (1/2 zadania)");
		SendClientMessage(playerid, COLOR_GREEN, "Moøesz chwilkÍ odpoczπÊ, wjedü w kolejny checkpoint aby ruszyÊ dalej!");
		SendClientMessage(playerid, COLOR_GREEN, "Dodatkowo otrzymujesz premiÍ paliwowπ z uwagi na utrudniony dostÍp do mechanikÛw.");
		SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>LSBD GPS<<_____________|");
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+510$");
        Gas[GetPlayerVehicleID(playerid)] = 100;
		Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Dworzec Commerce\n{778899}Trasa: Bluberry - Dillimore - Palomino Creek - East Los Santos - Commerce\n{808080}Odjazd nastπpi po sygnale ");
	}
	else if(CP[playerid]==1000)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 229.9310,-170.9327,1.0001, 4);
		CP[playerid]=830;
		ProxDetector(10.0, playerid, "Linia numer: {DAA520}82 (øÛ≥ta) {FFFF00}Kierunek ==> {DAA520}DWORZEC AUTOBUSOWY COMMERCE", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
        TogglePlayerControllable(playerid, 1);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+510$");
		Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Dworzec Autobusowy\n{778899}Trasa: Bluberry - Dillimore - Palomino Creek - East Los Santos - Commerce\n{808080}NastÍpny przystanek: miasteczko Bluberry");
	}
	else if(CP[playerid]==830)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 684.2634,-569.5635,16.3208, 4);
		CP[playerid]=831;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}Bluberry", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+510$");
		Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek:Dworzec Autobusowy\n{778899}Trasa: Dillimore - Palomino Creek - East Los Santos - Commerce\n{808080}NastÍpny przystanek: miasteczko Dillimore");
	}
	else if(CP[playerid]==831)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 1014.1871,-466.1351,50.5591, 4);
		CP[playerid]=832;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}Dillimore", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+510$");
		Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Dworzec Autobusowy\n{778899}Trasa: Dillimore - Palomino Creek - East Los Santos - Commerce\n{808080}NastÍpny przystanek: Hilltop Farm");
	}
	else if(CP[playerid]==832)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 2577.4602,39.4546,26.3359, 4); //PC prawa
		CP[playerid]=833;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}Dillimore ñ Hilltop Farm", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+510$");
		Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Dworzec Autobusowy\n{778899}Trasa: Palomino Creek - East Los Santos - Commerce\n{808080}NastÍpny przystanek: miasteczko Palomino Creek");
	}
	else if(CP[playerid]==833)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 2835.9119,-1100.0378,23.6009, 4); //nakijima prawa
		CP[playerid]=834;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}Palomino Creek", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+510$");
		Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Dworzec Autobusowy\n{778899}Trasa: East Los Santos - Commerce\n{808080}NastÍpny przystanek: Agencja Ochrony");
	}
	else if(CP[playerid]==834)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 2852.0789,-1563.2421,10.4871, 4);
		CP[playerid]=835;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}East Los Santos ñ Agencja Ochrony", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+510$");
		Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Bay Side\n{778899}Trasa: East Los Santos  - Commerce\n{808080}NastÍpny przystanek: Baza MechanikÛw");
	}
	else if(CP[playerid]==835)
	{
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpoint(playerid, 1181.8771,-1748.0386,12.9679, 4);
		CP[playerid]=836;
		ProxDetector(10.0, playerid, "{FFFFFF}Linia 82: {FFFF00}Przystanek {EE82EE}East Los Santos ñ Baza MechanikÛw", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		SendClientMessage(playerid, COLOR_YELLOW, "|_____________Droga do Dworca_____________|");
		SendClientMessage(playerid, COLOR_GREEN, "Jedü ciπgle autostradπ.");
		SendClientMessage(playerid, COLOR_GREEN, "Wyjedü na Idlewoo i kieruj siÍ ca≥y czas prosto.");
		SendClientMessage(playerid, COLOR_GREEN, "Po przejechaniu spowalniacza, SKR ∆ w LEWO i kieruj siÍ na dworzec.");
		SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>LSBD GPS<<_____________|");
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GREEN, "+510$");
		Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia nr 82\nKierunek: Bay Side\n{778899}Trasa: Commerce\n{808080}NastÍpny przystanek: Dworzec Autobusowy / Basen");
	}
	else if(CP[playerid]==836)
	{
	    if(BusCzit[playerid] == 1)
		{
		    KickEx(playerid);
		}
		else
		{
		    ProxDetector(10.0, playerid, "Przystanek koÒcowy: {EE82EE}Commerce ñ Dworzec Autobusowy / Basen", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			DisablePlayerCheckpoint(playerid);
			TogglePlayerControllable(playerid, 0);//Zamraøamy do pÛki nie odpowie co robi dalej
			//ShowPlayerDialogEx(playerid, 8888, DIALOG_STYLE_MSGBOX, "Trasa", "Zrobi≥eú pe≥nπ trasÍ. Co zamierzasz teraz zrobiÊ?\n\nWciúnij PonÛw aby wczytaÊ trasÍ jeszcze raz.\nWciúnij Innπ aby wybraÊ innπ trasÍ.", "PonÛw", "Innπ");
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________Trasa linii 82 zakoÒczona!_____________|");
			SendClientMessage(playerid, COLOR_GREEN, "Otrzymujesz 8670$ premii za dwukrotne przejechanie trasy! (17 przystankÛw)");
			SendClientMessage(playerid, COLOR_GREEN, "Moøesz znÛw rozpoczπÊ tπ lub innπ trasÍ lub zrezygnowaÊ poprzez zamkniÍcie menu wyboru.");
			SendClientMessage(playerid, COLOR_GREEN, "Jeøeli jednak chcesz zakoÒczyÊ pracÍ kieruj siÍ do zajezdni LSBD (wskazanej przez GPS).");
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>Los Santos Bus Department<<_____________|");
			SendClientMessage(playerid, COLOR_GRAD1, "Skill +3");
			PlayerInfo[playerid][pCarSkill] += 3;
            if(GetPlayerFraction(playerid) == FRAC_KT) Sejf_Add(FRAC_KT, 8670);
            else DajKase(playerid, 8670);
			CP[playerid] = 0;
			PlayerInfo[playerid][pLinia82] = 0;
			PlayerInfo[playerid][pNatrasiejest] = 0;
			ShowPlayerDialogEx(playerid, 8155, DIALOG_STYLE_LIST, "Wybierz swÛj kurs:", "Linia 55 -niebieska (230$/p , 9min, 21p, +2)\nLinia 72- pomaraÒczowa (200$/p, 6min, 15p, +1)\nLinia 96 - zielona 4s (310$/p, 8min, 24p, +1)\nLinia 82 øÛ≥ta 5s (510$/p , 11min, 18p, +3)\nLinia 85 3s (270$/p , ? min, 24p, +2)\nWycieczka 5s\nPowrÛt do bazy\nPomoc", "Wybierz", "Wyjdz");
			if(PlayerInfo[playerid][pMember] == 10 || PlayerInfo[playerid][pLider] == 10)
			{
			Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia ZAJ\nLinia 82 do zajezdni Ocean Docks\n{778899}Trasa: Pershing Square - Idlewood - Willowfield\n{808080}Zatrzymuje siÍ na przystankach");
			SetPlayerCheckpoint(playerid, 2431.2551,-2094.0959,13.5469, 4);
			CP[playerid]=1200;
			}
			else if(PlayerInfo[playerid][pJob] == 10)
			{
			Przystanek(playerid, 0xAFAFAFFF, "{DAA520}Linia ZAJ\nLinia 82 do zajezdni Commerce\n{778899}Trasa: Commerce\n{808080}Zatrzymuje siÍ na przystankach");
			SetPlayerCheckpoint(playerid, 1138.5,-1738.3,13.5, 4);
			CP[playerid]=1201;
			}
		}
	}
 	}
// KONIEC LINII 82 AUTOBUS”W system autobusÛw
    if(PlayerInfo[playerid][pLinia96]==1)
	{
		if(CP[playerid]==961) //Sprawdza czy dojecha≥ do nastepnego
		{
	        DisablePlayerCheckpoint(playerid);
			/*GetPlayerName(playerid,sendername,sizeof(sendername));
			format(string, sizeof(string), "%s rozpoczπ≥ trasÍ  na linii autobusowej numer {ADFF2F}96 Biurowiec <==> Baza Wojskowa{00D900C8}. SzczegÛ≥owe informacje o trasach na /businfo", sendername);
			OOCNews(TEAM_GROVE_COLOR,string);*/
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: Ocean Docks - Lotnisko - El Corona - Commerce - Market - Marina - Rodeo\n{808080}NastÍpny przystanek: Baza Wojskowa");
			ProxDetector(10.0, playerid, "Linia numer: {ADFF2F}96 (zielona) {FFFF00}Kierunek ==> {ADFF2F}MRUCZNIK TOWER", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			SetPlayerCheckpoint(playerid, 2512.0193,-2434.2727,13.7151, 4); //... ustawia nastepnego
			CP[playerid]=985; //przypisuje id dla cp up
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);//
		}
		else if(CP[playerid]==985)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2228.8030,-2198.2109,12.9153, 4);//uszkodzony
			CP[playerid]=962;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: Lotnisko - El Corona - Commerce - Market - Marina - Rodeo\n{808080}NastÍpny przystanek: Fabryka");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Ocean Docks ñ Baza Wosjkowa", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==962)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1992.8591,-2163.2961,13.3828, 4);//uszkodzony
			CP[playerid]=963;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: Lotnisko - El Corona - Commerce - Market - Marina - Rodeo\n{808080}NastÍpny przystanek: Pas Startowy");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Ocean Docks ñ Fabryka", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==963)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1895.3,-1935.31,13.399, 4);
			CP[playerid]=964;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: El Corona - Commerce - Market - Marina - Rodeo\n{808080}NastÍpny przystanek: Wiadukt");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Lotnisko ñ Pas Startowy", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==964)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1742.6479,-1816.3966,12.9351, 4);
			CP[playerid]=965;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: El Corona - Commerce - Market - Marina - Rodeo\n{808080}NastÍpny przystanek: Unity Station");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}El Corona ñ Wiadukt", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==965)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1463.1995,-1868.8994,13.3999, 4); //Przystanek commerce VB prawa
			CP[playerid]=966;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: Commerce - Market - Marina - Rodeo\n{808080}NastÍpny przystanek: Verdant Bluffs / Urzπd Miasta");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}El Corona ñ Unity Station", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==966)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1181.8771,-1748.0386,12.9679, 4);
			CP[playerid]=967;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: Commerce - Market - Marina - Rodeo\n{808080}NastÍpny przystanek: Zajezdnia Autobusowa");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Commerce ñ Verdant Bluffs / Urzπd Miasta", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==967)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1084.2205,-1569.8024,12.9443, 4);
			CP[playerid]=968;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: Market - Marina - Rodeo\n{808080}NastÍpny przystanek: Galerie Handlowe");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Commerce ñ Basen ÑTsunamiî / Zajezdnia Autobusowa", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==968)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 824.0928,-1624.2281,12.9477, 4);
			CP[playerid]=969;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: Marina - Rodeo\n{808080}NastÍpny przystanek: Burger Shot");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Market ñ Galerie handlowe", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==969)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 639.6337,-1452.6040,13.7631, 4);
			CP[playerid]=970;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: Rodeo\n{808080}NastÍpny przystanek: G≥Ûwna Siedziba FBI");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Marina ñ Burger Shot", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==970)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 535.0409,-1243.6492,16.0884, 4);// wypozyczalnia prawa
			CP[playerid]=971;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: Rodeo\n{808080}NastÍpny przystanek: Wypoøyczalnia Aut");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Rodeo ñ G≥Ûwna siedziba FBI", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==971)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 341.5396,-1531.1141,32.8992, 4);
			CP[playerid]=972;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: Mrucznik Tower\n{778899}Trasa: Rodeo\n{808080}NastÍpny przystanek: MRUCZNIK TOWER");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Rodeo ñ Wypoøyczalnia PojazdÛw", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==972)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 276.5778,-1575.9937,32.8686, 4); //KoÒcowy CP
			CP[playerid]=1004;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: WiÍzienie Stanowe\n{778899}Trasa: Rodeo - Marina - Market - Commerce - El Corona - Lotnisko - Ocean Docks\n{808080}Odjazd nastπpi po sygnale");
			ProxDetector(10.0, playerid, "Przystanek koÒcowy: {EE82EE}Rodeo - Mrucznik Tower", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________Komunikat_____________|");
			SendClientMessage(playerid, COLOR_GREEN, "Gratulacje! UkoÒczy≥eú trasÍ do Mrucznik Tower! (1/2 zadania). Moøesz odpoczπÊ.");
			SendClientMessage(playerid, COLOR_GREEN, "Jeøeli chcesz jechaÊ dalej wykonaj nawrÛt kierujπc siÍ do kolejnego checkpointu!");
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>LSBD GPS<<_____________|");
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==1004)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 577.4726,-1236.8068,17.0600, 4); //Druga strona ulicy CP
			CP[playerid]=973;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: WiÍzienie Stanowe\n{778899}Trasa: Rodeo - Marina - Market - Commerce - El Corona - Lotnisko - Ocean Docks\n{808080}NastÍpny przystanek: Wypoøyczalnia Aut");
			ProxDetector(10.0, playerid, "Linia numer: {ADFF2F}96 (zielona) {FFFF00}Kierunek ==> {ADFF2F}WI ZIENIE STANOWE", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
	        TogglePlayerControllable(playerid, 1);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==973)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 625.2355,-1470.5664,13.9573, 4); //Druga strona ulicy CP
			CP[playerid]=974;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: WiÍzienie Stanowe\n{778899}Trasa: Rodeo - Marina - Market - Commerce - El Corona - Lotnisko - Ocean Docks\n{808080}NastÍpny przystanek: G≥Ûwna Siedziba FBI");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Rodeo ñ Wypoøyczalnia PojazdÛw", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==974)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 840.9546,-1614.0339,12.9483, 4);
			CP[playerid]=975;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: WiÍzienie Stanowe\n{778899}Trasa: Marina - Market - Commerce - El Corona - Lotnisko - Ocean Docks\n{808080}NastÍpny przystanek: Burger Shot");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Rodeo ñ G≥Ûwna siedziba FBI", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==975)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1105.6156,-1574.0813,12.9401, 4);
			CP[playerid]=976;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: WiÍzienie Stanowe\n{778899}Trasa: Market - Commerce - El Corona - Lotnisko - Ocean Docks\n{808080}NastÍpny przystanek: Galerie Handlowe");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Marina ñ Burger Shot", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==976)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1173.1520,-1825.2843,13.1789, 4);
			CP[playerid]=977;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: WiÍzienie Stanowe\n{778899}Trasa: Commerce - El Corona - Lotnisko - Ocean Docks\n{808080}NastÍpny przystanek: Zajezdnia Autobusowa");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Market ñ Galerie handlowe", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==977)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1492,-1875.8005,13.9999, 4);
			CP[playerid]=978;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: WiÍzienie Stanowe\n{778899}Trasa: Commerce - El Corona - Lotnisko - Ocean Docks\n{808080}NastÍpny przystanek: Verdant Bluffs / Urzπd Miasta");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Commerce ñ Basen ÑTsunamiî / Zajezdnia Autobusowa", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==978)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1791.1583,-1833.9706,12.9519, 4); //wiadukt lewy
			CP[playerid]=979;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: WiÍzienie Stanowe\n{778899}Trasa: El Corona - Lotnisko - Ocean Docks\n{808080}NastÍpny przystanek: Unity Station");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Commerce ñ Verdant Bluffs", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==979)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1895.3,-1935.31,13.399, 4);
			CP[playerid]=980;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: WiÍzienie Stanowe\n{778899}Trasa: El Corona - Lotnisko - Ocean Docks\n{808080}NastÍpny przystanek: Wiadukt");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}El Corona ñ Unity Station", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==980)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1977.1256,-2168.7412,12.9419, 4);
			CP[playerid]=981;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: WiÍzienie Stanowe\n{778899}Trasa: Lotnisko - Ocean Docks\n{808080}NastÍpny przystanek: Pas Startowy");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}El Corona ñ Wiadukt", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==981)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2228.8030,-2198.2109,12.9153, 4);
			CP[playerid]=982;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: WiÍzienie Stanowe\n{778899}Trasa: Ocean Docks\n{808080}NastÍpny przystanek: Fabryka");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Lotnisko ñ Pas Startowy", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==982)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2335.9858,-2355.0427,13.3828, 4);
			CP[playerid]=1202;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: WiÍzienie Stanowe\n{778899}Trasa: Ocean Docks\n{808080}NastÍpny przystanek: Baza Wosjkowa");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Ocen Docks ñ Fabryka", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==982)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2495.6113,-2408.0415,13.5445, 4);
			CP[playerid]=983;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: WiÍzienie Stanowe\n{778899}Trasa: Ocean Docks\n{808080}NastÍpny przystanek: Baza Wosjkowa");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Ocen Docks ñ Baza Wosjkowa", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==983)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2687.6597,-2406.9775,13.6017, 4);
			CP[playerid]=984;
			Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia nr. 96\nKierunek: WiÍzienie Stanowe\n{778899}Trasa: Ocean Docks\n{808080}NastÍpny przystanek: WI ZIENIE STANOWE");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 96: {FFFF00}Przystanek {EE82EE}Ocen Docks ñ Baza Wosjkowa", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+310$");
		}
		else if(CP[playerid]==984)
		{
		    if(BusCzit[playerid] == 1)
			{
			    KickEx(playerid);
			}
			else
			{
			    ProxDetector(10.0, playerid, "Przystanek koÒcowy: {EE82EE}Ocean Docks ñ WiÍzienie Stanowe", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
	   			SendClientMessage(playerid, COLOR_YELLOW, "|_____________Trasa linii 96 zakoÒczona!_____________|");
				SendClientMessage(playerid, COLOR_GREEN, "Otrzymujesz 7440$ premii za dwukrotne przejechanie trasy! (24 przystanki)");
				SendClientMessage(playerid, COLOR_GREEN, "Moøesz znÛw rozpoczπÊ tπ lub innπ trasÍ lub zrezygnowaÊ poprzez zamkniÍcie menu wyboru.");
				SendClientMessage(playerid, COLOR_GREEN, "Jeøeli jednak chcesz zakoÒczyÊ pracÍ kieruj siÍ do zajezdni LSBD (wskazanej przez sygan≥ GPS).");
				SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>Los Santos Bus Department<<_____________|");
				SendClientMessage(playerid, COLOR_GRAD1, "Skill +1");
				PlayerInfo[playerid][pCarSkill] ++;
                if(GetPlayerFraction(playerid) == FRAC_KT) Sejf_Add(FRAC_KT, 7440);
                else DajKase(playerid, 7440);
				CP[playerid] = 0;
				PlayerInfo[playerid][pLinia96] = 0;
				PlayerInfo[playerid][pNatrasiejest] = 0;
				ShowPlayerDialogEx(playerid, 8155, DIALOG_STYLE_LIST, "Wybierz swÛj kurs:", "Linia 55 - niebieska (230$/p , 9min, 21p, +2)\nLinia 72 - pomaraÒczowa (200$/p, 6min, 15p, +1)\nLinia 96 - zielona 4s (310$/p, 8min, 24p, +1)\nLinia 82 øÛ≥ta 5s (510$/p , 11min, 18p, +3)\nLinia 85 3s (270$/p , ? min, 24p, +2)\nWycieczka 5s\nPowrÛt do bazy\nPomoc", "Wybierz", "Wyjdz");
				if(PlayerInfo[playerid][pMember] == 10 || PlayerInfo[playerid][pLider] == 10)
				{
					Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia ZAJ\nLinia 96 do zajezdni Ocean Docks\n{778899}Trasa: Ocean Docks\n{808080}Zatrzymuje siÍ na przystankach");
					SetPlayerCheckpoint(playerid, 2431.2551,-2094.0959,13.5469, 4);
					CP[playerid]=1200;
				}
				else if(PlayerInfo[playerid][pJob] == 10)
				{
					Przystanek(playerid, 0xAFAFAFFF, "{ADFF2F}Linia ZAJ\nLinia 96 do zajezdni Commerce\n{778899}Trasa: Ocean Docks - Lotnisko - El Corona - Pershing Square - Commerce\n{808080}Zatrzymuje siÍ na przystankach");
					SetPlayerCheckpoint(playerid, 1138.5,-1738.3,13.5, 4);
					CP[playerid]=1201;
    			}
			}
		}
	}
	if(PlayerInfo[playerid][pLinia85]==1)//linia 85 system autobusÛw
	{
		if(CP[playerid]==501) //Sprawdza czy dojecha≥ do nastepnego
		{
		    DisablePlayerCheckpoint(playerid);
			/*GetPlayerName(playerid,sendername,sizeof(sendername));
			format(string, sizeof(string), "%s rozpoczπ≥ trasÍ  na linii autobusowej numer {FF00FF}85 Wysypisko <==> Szpital{00D900C8}. SzczegÛ≥owe informacje o trasach na /businfo", sendername);
			OOCNews(TEAM_GROVE_COLOR,string);*/
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: Willowfield - East Los Santos - Las Colinas - Jefferson - Glen Park - Downtown - Market\n{808080}NastÍpny przystanek: Cluckin Bell");
			ProxDetector(10.0, playerid, "Linia numer: {FF00FF}85 (rÛøowa) {FFFF00}Kierunek ==> {FF00FF}SZPITAL", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			SetPlayerCheckpoint(playerid, 2415.8232,-1912.1696,12.9518, 4); //... ustawia nastepnego
			CP[playerid]=502; //przypisuje id dla cp up
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);//
		}
		else if(CP[playerid]==502)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2488.0164,-1506.9924,23.3944, 4);//uszkodzony
			CP[playerid]=503;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: East Los Santos - Las Colinas - Jefferson - Glen Park - Downtown - Market\n{808080}NastÍpny przystanek: Myjnia Samochodowa");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Willowfield ñ Cluck'in Bell", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==503)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2852.0789,-1563.2421,10.4871, 4);
			CP[playerid]=504;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: East Los Santos - Las Colinas - Jefferson - Glen Park - Downtown - Market\n{808080}NastÍpny przystanek: Baza MechanikÛw");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Willowfield ñ Myjnia Samochodowa", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==504)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2835.9119,-1100.0378,23.6009, 4);
			CP[playerid]=505;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: East Los Santos - Las Colinas - Jefferson - Glen Park - Downtown - Market\n{808080}NastÍpny przystanek: Agencja Ochrony");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}East Los Santos ñ Baza MechanikÛw", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==505)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2541.5476,-1050.6461,68.9680, 4); //Przystanek commerce VB prawa
			CP[playerid]=506;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: Las Colinas - Jefferson - Glen Park - Downtown - Market\n{808080}NastÍpny przystanek: Las Colinas 13");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}East Los Santos ñ Agencja Ochrony", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==506)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2202.1843,-1011.6302,61.2425, 4);
			CP[playerid]=507;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: Las Colinas - Jefferson - Glen Park - Downtown - Market\n{808080}NastÍpny przystanek: Las Colinas 32");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Las Colinas 13", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==507)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2248.4707,-1139.6617,25.7001, 4);
			CP[playerid]=508;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: Jefferson - Glen Park - Downtown - Market\n{808080}NastÍpny przystanek: Motel Jefferson");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Las Colinas 34", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==508)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1967.2327,-1198.9353,25.2217, 4);
			CP[playerid]=509;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: Glen Park - Downtown - Market\n{808080}NastÍpny przystanek: Glen Park");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Jefferson ñ Motel Jefferson", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==509)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1810.9371,-1181.5383,23.2077, 4);
			CP[playerid]=510;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: Downtown - Market\n{808080}NastÍpny przystanek: Mrucznikowy Gun Shop");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Glen Park", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==510)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1449.7135,-1037.4396,23.2312, 4);// wypozyczalnia prawa
			CP[playerid]=511;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: Downtown - Market\n{808080}NastÍpny przystanek: Verte Bank");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Downtown ñ Mrucznikowy Gun Shop", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==511)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1193.7321,-1358.3251,12.9416, 4);
			CP[playerid]=512;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Szpital\n{778899}Trasa: Market\n{808080}NastÍpny przystanek: SZPITAL");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Downtown ñ Bank", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==512)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1203.7321,-1358.3251,12.9416, 4); //KoÒcowy CP
			CP[playerid]=1005;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: Market - Downtown - Glen Park - Jefferson - Las Colinas - East LS - Willowfield\n{808080}Odjazd nastπpi po sygnale");
			ProxDetector(10.0, playerid, "Przystanek koÒcowy: {EE82EE}Market ñ Szpital", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________Komunikat_____________|");
			SendClientMessage(playerid, COLOR_GREEN, "Gratulacje! UkoÒczy≥eú trasÍ do Mrucznik Tower! (1/2 zadania). Moøesz odpoczπÊ.");
			SendClientMessage(playerid, COLOR_GREEN, "Jeøeli chcesz jechaÊ dalej wykonaj nawrÛt kierujπc siÍ do kolejnego checkpointu!");
			SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>LSBD GPS<<_____________|");
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==1005)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1452.3877,-1031.1976,23.2277, 4); //Druga strona ulicy CP
			CP[playerid]=513;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: Downtown - Glen Park - Jefferson - Las Colinas - East LS - Willowfield\n{808080}NastÍpny przystanek: Verte Bank");
			ProxDetector(10.0, playerid, "Linia numer: {FF00FF}85 (rÛøowa) {FF00FF}Kierunek ==> {ADFF2F}WYSYPISKO", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
	        TogglePlayerControllable(playerid, 1);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==513)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1781.2218,-1167.9779,23.2261, 4); //Druga strona ulicy CP
			CP[playerid]=514;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: Downtown - Glen Park - Jefferson - Las Colinas - East LS - Willowfield\n{808080}NastÍpny przystanek: Mrucznikowy Gun Shop");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Downtown ñ Bank", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==514)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 1972.9082,-1198.7592,25.2214, 4);
			CP[playerid]=515;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: Glen Park - Jefferson - Las Colinas - East LS - Willowfield\n{808080}NastÍpny przystanek: Glen Park");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Downtown ñ Mrucznikowy Gun Shop", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==515)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2255.2795,-1145.6331,26.0940, 4);
			CP[playerid]=516;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: Jefferson - Las Colinas - East Los Santos - Willowfield\n{808080}NastÍpny przystanek: Motel Jefferson");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Glen Park", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==516)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2193.2642,-1012.3875,61.8830, 4);
			CP[playerid]=517;
		    Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: Las Colinas - East Lost Santos - Willowfield\n{808080}NastÍpny przystanek: Las Colinas 34");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Jefferson ñ Motel Jefferson", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==517)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2520.0220,-1044.3973,68.9851, 4);
			CP[playerid]=518;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: Las Colinas - East Lost Santos - Willowfield\n{808080}NastÍpny przystanek: Las Colinas 13");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Las Colinas 34", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==518)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2839.9409,-1098.3546,23.5453, 4); //wiadukt lewy
			CP[playerid]=519;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: East Lost Santos - Willowfield\n{808080}NastÍpny przystanek: Agencja Ochrony");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Las Colinas 13", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==519)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2864.6250,-1539.0991,10.4947, 4);
			CP[playerid]=520;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: East Lost Santos - Willowfield\n{808080}NastÍpny przystanek: Baza MechanikÛw");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}East Los Santos ñ Agencja Ochrony", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==520)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2514.7009,-1501.5859,23.8281, 4);
			CP[playerid]=521;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: Willowfield\n{808080}NastÍpny przystanek: Myjnia Samochodowa");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}East Los Santos ñ Baza MechanikÛw", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==521)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2411.1692,-1908.5591,12.9485, 4);
			CP[playerid]=522;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: Willowfield\n{808080}NastÍpny przystanek: Cluckin Bell");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Willowfield ñ Myjnia", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==522)
		{
			DisablePlayerCheckpoint(playerid);
			SetPlayerCheckpoint(playerid, 2118.5024,-1891.6978,12.9058, 4);
			CP[playerid]=523;
			Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia nr. 85\nKierunek: Wysypisko\n{778899}Trasa: Willowfield\n{808080}NastÍpny przystanek: WYSYPISKO");
			ProxDetector(10.0, playerid, "{FFFFFF}Linia 85: {FFFF00}Przystanek {EE82EE}Willowfield ñ Clukin Bell", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
			PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
			SendClientMessage(playerid, COLOR_GREEN, "+270$");
		}
		else if(CP[playerid]==523)
		{
		    if(BusCzit[playerid] == 1)
			{
			    KickEx(playerid);
			}
			else
			{
			    Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia ZAJ\nLinia 85 do zajezdni Ocead Docks\n{778899}Trasa: Willowfield\n{808080}Zatrzymuje siÍ na przystankach");
			    ProxDetector(10.0, playerid, "Przystanek koÒcowy: {EE82EE}Willowfield ñ Wysypisko", COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
	   			SendClientMessage(playerid, COLOR_YELLOW, "|_____________Trasa linii 85 zakoÒczona!_____________|");
				SendClientMessage(playerid, COLOR_GREEN, "Otrzymujesz 6480$ premii za dwukrotne przejechanie trasy! (24 przystanki)");
				SendClientMessage(playerid, COLOR_GREEN, "Moøesz znÛw rozpoczπÊ tπ lub innπ trasÍ lub zrezygnowaÊ poprzez zamkniÍcie menu wyboru.");
				SendClientMessage(playerid, COLOR_GREEN, "Jeøeli jednak chcesz zakoÒczyÊ pracÍ kieruj siÍ do zajezdni LSBD (wskazanej przez GPS).");
				SendClientMessage(playerid, COLOR_YELLOW, "|_____________>>Los Santos Bus Department<<_____________|");
				SendClientMessage(playerid, COLOR_GRAD1, "Skill +2");
				PlayerInfo[playerid][pCarSkill] += 2;
                if(GetPlayerFraction(playerid) == FRAC_KT) Sejf_Add(FRAC_KT, 6480);
                else DajKase(playerid, 6480);
				CP[playerid] = 0;
				PlayerInfo[playerid][pLinia96] = 0;
				PlayerInfo[playerid][pNatrasiejest] = 0;
				ShowPlayerDialogEx(playerid, 8155, DIALOG_STYLE_LIST, "Wybierz swÛj kurs:", "Linia 55 -niebieska (230$/p , 9min, 21p, +2)\nLinia 72- pomaraÒczowa (200$/p, 6min, 15p, +1)\nLinia 96 - zielona 4s (310$/p, 8min, 24p, +1)\nLinia 82 øÛ≥ta 5s (510$/p , 11min, 18p, +3)\nLinia 85 3s (270$/p , ? min, 24p, +2)\nWycieczka 5s\nPowrÛt do bazy\nPomoc", "Wybierz", "Wyjdz");
				if(PlayerInfo[playerid][pMember] == 10 || PlayerInfo[playerid][pLider] == 10)
				{
					Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia ZAJ\nLinia 85 do zajezdni Ocean Docks\n{778899}Trasa: Willowfield - Ocean Docks\n{808080}Zatrzymuje siÍ na przystankach");
					SetPlayerCheckpoint(playerid, 2431.2551,-2094.0959,13.5469, 4);
					CP[playerid]=1200;
				}
				else if(PlayerInfo[playerid][pJob] == 10)
				{
					Przystanek(playerid, 0xAFAFAFFF, "{FF00FF}Linia ZAJ\nLinia 85 do zajezdni Commerce\n{778899}Trasa: Willowfield - Idlewood - Pershing Square - Commerce\n{808080}Zatrzymuje siÍ na przystankach");
					SetPlayerCheckpoint(playerid, 1138.5,-1738.3,13.5, 4);
					CP[playerid]=1201;
    			}
			}
		}
	}
//koniec linii 85 i system autobusÛw
	else if(CP[playerid]==1)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
		    PlayerInfo[playerid][pJackSkill] ++;
			if(PlayerInfo[playerid][pJackSkill] == 50)
			{ SendClientMessage(playerid, COLOR_YELLOW, "* TwÛj skill z≥odzieja samochodÛw wynosi teraz 2, bÍdziesz wiÍcej zarabiaÊ oraz szybciej ukraúÊ nowe auto."); }
			else if(PlayerInfo[playerid][pJackSkill] == 100)
			{ SendClientMessage(playerid, COLOR_YELLOW, "* TwÛj skill z≥odzieja samochodÛw wynosi teraz 3, bÍdziesz wiÍcej zarabiaÊ oraz szybciej ukraúÊ nowe auto."); }
			else if(PlayerInfo[playerid][pJackSkill] == 200)
			{ SendClientMessage(playerid, COLOR_YELLOW, "* TwÛj skill z≥odzieja samochodÛw wynosi teraz 4, bÍdziesz wiÍcej zarabiaÊ oraz szybciej ukraúÊ nowe auto."); }
			else if(PlayerInfo[playerid][pJackSkill] == 400)
			{ SendClientMessage(playerid, COLOR_YELLOW, "* TwÛj skill z≥odzieja samochodÛw wynosi teraz 5, bÍdziesz najwiÍcej zarabiaÊ oraz najszybciej kraúÊ auta."); }
			new level = PlayerInfo[playerid][pJackSkill];
			if(level >= 0 && level <= 50)
			{
			    new rand = random(sizeof(SELLCAR1));
			    format(string, sizeof(string), "Sprzeda≥eú pojazd za $%d, nastÍpny pojazd moøesz ukraúÊ za 20 minut.", SELLCAR1[rand]);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	  			DajKase(playerid, SELLCAR1[rand]);//moneycheat
			    PlayerInfo[playerid][pCarTime] = 1200;
			}
			else if(level >= 51 && level <= 100)
			{
			    new rand = random(sizeof(SELLCAR2));
			    format(string, sizeof(string), "Sprzeda≥eú pojazd za $%d, nastÍpny pojazd moøesz ukraúÊ za 18 minut.", SELLCAR2[rand]);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	  			DajKase(playerid, SELLCAR2[rand]);//moneycheat
			    PlayerInfo[playerid][pCarTime] = 1080;
			}
			else if(level >= 101 && level <= 200)
			{
			    new rand = random(sizeof(SELLCAR3));
			    format(string, sizeof(string), "Sprzeda≥eú pojazd za $%d, nastÍpny pojazd moøesz ukraúÊ za 16 minut.", SELLCAR3[rand]);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	  			DajKase(playerid, SELLCAR3[rand]);//moneycheat
			    PlayerInfo[playerid][pCarTime] = 960;
			}
			else if(level >= 201 && level <= 400)
			{
			    new rand = random(sizeof(SELLCAR4));
			    format(string, sizeof(string), "Sprzeda≥eú pojazd za $%d, nastÍpny pojazd moøesz ukraúÊ za 14 minut.", SELLCAR4[rand]);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	  			DajKase(playerid, SELLCAR4[rand]);//moneycheat
			    PlayerInfo[playerid][pCarTime] = 840;
			}
			else if(level >= 401)
			{
			    new money = 6000;
			    format(string, sizeof(string), "Sprzeda≥eú pojazd za $%d, nastÍpny pojazd moøesz ukraúÊ za 12 minut.", money);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	  			DajKase(playerid, money);//moneycheat
			    PlayerInfo[playerid][pCarTime] = 720;
			}
			GameTextForPlayer(playerid, "~y~Sprzedales pojazd", 2500, 1);
			CP[playerid] = 0;
		    DisablePlayerCheckpoint(playerid);
		    SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		}
		else
		{
		    GameTextForPlayer(playerid, "Nie jestes w wozie", 5000, 1);
		}
	}
	else if(CP[playerid] == 5)
	{
	    GameTextForPlayer(playerid, "~y~W punkcie misji", 2500, 1);
		CP[playerid] = 0;
	    DisablePlayerCheckpoint(playerid);
	}
	else if(CP[playerid] == 9)//Karting
	{
		GameTextForPlayer(playerid, "~r~Czekaj tutaj na wiecej gokardow", 4000, 3);
		DisablePlayerCheckpoint(playerid);
	}
	else if(CP[playerid] == 10) { CP[playerid] = 11; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2258.7874,-2402.9712,12.7035,8.0); }
	else if(CP[playerid] == 11) { CP[playerid] = 12; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2225.8755,-2461.3875,12.7190,8.0); }
	else if(CP[playerid] == 12) { CP[playerid] = 13; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2276.9983,-2662.8328,12.8580,8.0); }
	else if(CP[playerid] == 13) { CP[playerid] = 14; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2449.1399,-2663.0562,12.8138,8.0); }
	else if(CP[playerid] == 14) { CP[playerid] = 15; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2566.9814,-2504.5686,12.7692,8.0); }
	else if(CP[playerid] == 15) { CP[playerid] = 16; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2719.0520,-2503.5962,12.7706,8.0); }
	else if(CP[playerid] == 16) { CP[playerid] = 17; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2720.7881,-2405.6589,12.7441,8.0); }
	else if(CP[playerid] == 17) { CP[playerid] = 18; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2571.5195,-2401.1531,12.7528,8.0); }
	else if(CP[playerid] == 18) { CP[playerid] = 19; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2406.6995,-2423.1182,12.6641,8.0); }
	else if(CP[playerid] == 19) { CP[playerid] = 20; DisablePlayerCheckpoint(playerid); SetPlayerCheckpoint(playerid,2322.9194,-2341.5715,12.6664,8.0); }
	else if(CP[playerid] == 20)//End of Karting
	{
	    CP[playerid] = 0;
	    DisablePlayerCheckpoint(playerid);
	    GetPlayerName(playerid, name, sizeof(name));
	    if(FirstKartWinner == 999)
	    {
	        FirstKartWinner = playerid;
	        foreach(Player, i)
	        {
	            if(IsPlayerConnected(i))
	            {
		            if(PlayerKarting[i] != 0 && PlayerInKart[i] != 0)
		            {
		                format(string, sizeof(string), "* %s ukoÒczy≥eú wyúcig jako pierwszy !",name);
		                SendClientMessage(i, COLOR_WHITE, string);
		            }
				}
			}
	    }
	    else if(SecondKartWinner == 999)
	    {
	        SecondKartWinner = playerid;
	        foreach(Player, i)
	        {
	            if(IsPlayerConnected(i))
	            {
		            if(PlayerKarting[i] != 0 && PlayerInKart[i] != 0)
		            {
		                format(string, sizeof(string), "* %s ukoÒczy≥eú wyúcig jako drugi !",name);
		                SendClientMessage(i, COLOR_WHITE, string);
		            }
				}
			}
	    }
	    else if(ThirdKartWinner == 999)
	    {
	        ThirdKartWinner = playerid;
	        foreach(Player, i)
	        {
	            if(IsPlayerConnected(i))
	            {
		            if(PlayerKarting[i] != 0 && PlayerInKart[i] != 0)
		            {
		                format(string, sizeof(string), "* %s ukoÒczy≥eú wyúcig jako trzeci.",name);
		                SendClientMessage(i, COLOR_WHITE, string);
		                SendClientMessage(i, COLOR_WHITE, "** Koniec wyúcigu **");
		                CP[i] = 0;
		                DisablePlayerCheckpoint(i);
		            }
				}
	        }
	    }
	}
	else if(MissionCheckpoint[playerid] > 0 && PlayMission[kToggle] == 1)//Missions + Checkpoint on toggle
	{
        	RingTone[playerid] = 20;
		    switch(MissionCheckpoint[playerid])
		    {
	        	case 1:
		        {
					format(string, sizeof(string), "%s", PlayMission[kGText1]);
					GameTextForPlayer(playerid, string, 8000, 3);
					format(string, sizeof(string), "%s", PlayMission[kText4]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					format(string, sizeof(string), "%s", PlayMission[kText5]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					format(string, sizeof(string), "%s", PlayMission[kText6]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, PlayMission[kCP2][0], PlayMission[kCP2][1], PlayMission[kCP2][2], 8);
					MissionCheckpoint[playerid] = 2;
		        }
		        case 2:
		        {
		            format(string, sizeof(string), "%s", PlayMission[kGText2]);
					GameTextForPlayer(playerid, string, 8000, 3);
					format(string, sizeof(string), "%s", PlayMission[kText7]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					format(string, sizeof(string), "%s", PlayMission[kText8]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					format(string, sizeof(string), "%s", PlayMission[kText9]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, PlayMission[kCP3][0], PlayMission[kCP3][1], PlayMission[kCP3][2], 8);
					MissionCheckpoint[playerid] = 3;
		        }
		        case 3:
		        {
		            format(string, sizeof(string), "%s", PlayMission[kGText3]);
					GameTextForPlayer(playerid, string, 8000, 3);
					format(string, sizeof(string), "%s", PlayMission[kText10]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					format(string, sizeof(string), "%s", PlayMission[kText11]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					format(string, sizeof(string), "%s", PlayMission[kText12]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, PlayMission[kCP4][0], PlayMission[kCP4][1], PlayMission[kCP4][2], 8);
					MissionCheckpoint[playerid] = 4;
		        }
		        case 4:
		        {
		            format(string, sizeof(string), "%s", PlayMission[kGText4]);
					GameTextForPlayer(playerid, string, 8000, 3);
					format(string, sizeof(string), "%s", PlayMission[kText13]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					format(string, sizeof(string), "%s", PlayMission[kText14]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					format(string, sizeof(string), "%s", PlayMission[kText15]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, PlayMission[kCP5][0], PlayMission[kCP5][1], PlayMission[kCP5][2], 8);
					MissionCheckpoint[playerid] = 5;
		        }
		        case 5:
		        {
		            format(string, sizeof(string), "%s", PlayMission[kGText5]);
					GameTextForPlayer(playerid, string, 8000, 3);
					format(string, sizeof(string), "%s", PlayMission[kText16]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					format(string, sizeof(string), "%s", PlayMission[kText17]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					format(string, sizeof(string), "%s", PlayMission[kText18]);
					SendClientMessage(playerid, COLOR_YELLOW2, string);
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, PlayMission[kCP6][0], PlayMission[kCP6][1], PlayMission[kCP6][2], 8);
					MissionCheckpoint[playerid] = 6;
		        }
		        case 6:
		        {
		            format(string, sizeof(string), "%s", PlayMission[kGText6]);
					GameTextForPlayer(playerid, string, 8000, 3);
					format(string, sizeof(string), "..:: UkoÒczona Misje: %s | Zap≥ata: $%d ::..", PlayMission[kTitle], PlayMission[kReward]);
					SendClientMessage(playerid, COLOR_GREEN, string);
					DisablePlayerCheckpoint(playerid);
		  			DajKase(playerid, PlayMission[kReward]);//moneycheat
					PlayerInfo[playerid][pMissionNr] = PlayerOnMission[playerid];
					MissionCheckpoint[playerid] = 0;
					PlayerOnMission[playerid] = 0;
		        }
		    }
	}
	else if(zawodnik[playerid] == 1)
	{
		if(okregi[playerid] == 5)
		{
		    if(iloscwygranych == 0)
		    {
			    new sendername[MAX_PLAYER_NAME];
			    GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "Wygra≥ %s - ukoÒczy≥ wyúcig zajmujπc 1 miejsce !!!.", sendername);
				ProxDetectorW(500, -1106.9854, -966.4719, 129.1807, COLOR_WHITE, string);
				DisablePlayerCheckpoint(playerid);
		        DisablePlayerCheckpoint(playerid);
		        zawodnik[playerid] = 0;
		        okrazenia[playerid] = 0;
	   			okregi[playerid] = 0;
				iloscwygranych ++;
				SetTimerEx("TablicaWynikow",1000,0,"d",playerid);
			}
			else if(iloscwygranych == 1)
			{
			    new sendername[MAX_PLAYER_NAME];
			    GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "%s ukoÒczy≥ wyúcig zajmujπc 2 miejsce !!.", sendername);
				ProxDetectorW(500, -1106.9854, -966.4719, 129.1807, COLOR_WHITE, string);
				DisablePlayerCheckpoint(playerid);
		        DisablePlayerCheckpoint(playerid);
		        zawodnik[playerid] = 0;
		        okrazenia[playerid] = 0;
	   			okregi[playerid] = 0;
				iloscwygranych ++;
				SetTimerEx("TablicaWynikow",1000,0,"d",playerid);
			}
			else if(iloscwygranych == 2)
			{
			    new sendername[MAX_PLAYER_NAME];
			    GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "%s ukoÒczy≥ wyúcig zajmujπc 3 miejsce !.", sendername);
				ProxDetectorW(500, -1106.9854, -966.4719, 129.1807, COLOR_WHITE, string);
				DisablePlayerCheckpoint(playerid);
		        DisablePlayerCheckpoint(playerid);
		        zawodnik[playerid] = 0;
		        okrazenia[playerid] = 0;
	   			okregi[playerid] = 0;
				iloscwygranych ++;
				SetTimerEx("TablicaWynikow",1000,0,"d",playerid);
			}
			else
			{
			    iloscwygranych ++;
			    new sendername[MAX_PLAYER_NAME];
			    GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "%s ukoÒczy≥ wyúcig zajmujπc %d miejsce !.", sendername, iloscwygranych);
				ProxDetectorW(500, -1106.9854, -966.4719, 129.1807, COLOR_WHITE, string);
				DisablePlayerCheckpoint(playerid);
		        DisablePlayerCheckpoint(playerid);
		        zawodnik[playerid] = 0;
		        okrazenia[playerid] = 0;
	   			okregi[playerid] = 0;
	   			SetTimerEx("TablicaWynikow",1000,0,"d",playerid);
			}
	   	}
  		else if(okrazenia[playerid] == 0)
	    {
	        DisablePlayerCheckpoint(playerid);
	        SetPlayerCheckpoint(playerid, -1057.6370,-994.5727,128.8853, 5);
	        PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
	        okrazenia[playerid] ++;
	    }
	    else if(okrazenia[playerid] == 1)
	    {
	        DisablePlayerCheckpoint(playerid);
	        SetPlayerCheckpoint(playerid, -1083.9596,-975.8777,128.8853, 5);
	        PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
	        okrazenia[playerid] ++;
	    }
	    else if(okrazenia[playerid] == 2)
	    {
	        DisablePlayerCheckpoint(playerid);
	        SetPlayerCheckpoint(playerid, -1114.9780,-985.8290,128.8878, 5);
	        PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
	        okrazenia[playerid] ++;
	    }
	    else if(okrazenia[playerid] == 3)
	    {
	        DisablePlayerCheckpoint(playerid);
	        SetPlayerCheckpoint(playerid, -1115.5585,-987.0826,128.8878, 5);
	        PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
	        okrazenia[playerid] ++;
	    }
	    else if(okrazenia[playerid] == 4)
	    {
	        DisablePlayerCheckpoint(playerid);
	        SetPlayerCheckpoint(playerid, -1083.2609,-1006.3092,128.9274, 5);
	        PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
	        okrazenia[playerid] = 0;
	        okregi[playerid] ++;
	    }
	}
	else
	{
		switch (gPlayerCheckpointStatus[playerid])
		{
			case CHECKPOINT_HOME:
		    {
				PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
				DisablePlayerCheckpoint(playerid);
				gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
				GameTextForPlayer(playerid, "~w~Tu jest twoj~n~~y~Dom", 5000, 1);
		    }
		}
	}
	#if DEBUG == 1
		printf("%s[%d] OnPlayerEnterCheckpoint - end", GetNick(playerid), playerid);
	#endif
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	#if DEBUG == 1
		printf("%s[%d] OnPlayerEnterRaceCheckpoint - begin", GetNick(playerid), playerid);
	#endif
    TJD_CallRaceCheckpoint(playerid);
	if(ScigaSie[playerid] != 666 && IloscCH[playerid] != 0 && Scigamy != 666)
	{
	    if(!IsPlayerInAnyVehicle(playerid))
		{
			#if DEBUG == 1
				printf("%s[%d] OnPlayerEnterRaceCheckpoint - end", GetNick(playerid), playerid);
			#endif
			return 1;
	    }
	    //
	    if(IloscCH[playerid] == (Wyscig[Scigamy][wCheckpointy]-1))
	    {
            PlayerPlaySound(playerid, 1138, 0, 0, 0);
	        IloscCH[playerid] ++;
	        new ch = IloscCH[playerid];
	        if(Wyscig[Scigamy][wTypCH] == 0)
	        {
	       	 	SetPlayerRaceCheckpoint(playerid,1,wCheckpoint[Scigamy][ch][0], wCheckpoint[Scigamy][ch][1], wCheckpoint[Scigamy][ch][2],0,0,0, Wyscig[Scigamy][wRozmiarCH]);
			}
			else
			{
				SetPlayerRaceCheckpoint(playerid,4,wCheckpoint[Scigamy][ch][0], wCheckpoint[Scigamy][ch][1], wCheckpoint[Scigamy][ch][2],0,0,0, Wyscig[Scigamy][wRozmiarCH]);
			}
	    }
	    else if(IloscCH[playerid] == Wyscig[Scigamy][wCheckpointy])
	    {
	        DisablePlayerRaceCheckpoint(playerid);
	        PlayerPlaySound(playerid, 1139, 0, 0, 0);
	        new string[128];
	        //
	        if(Ukonczyl == 1)
	        {
	            SendClientMessage(playerid, COLOR_YELLOW, "|_________ GRATULACJE!!!! _________|");
        		SendClientMessage(playerid, COLOR_LIGHTGREEN, "| UkoÒczy≥eú wyúcig jako pierwszy! |");
				format(string, sizeof(string), "|   Otrzymujesz %d$ nagrody!   |", Wyscig[Scigamy][wNagroda]); SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
	        	SendClientMessage(playerid, COLOR_LIGHTGREEN, "|__________________________________|");
	        	DajKase(playerid, Wyscig[Scigamy][wNagroda]);
	        	if(Ukonczyl >= IloscZawodnikow)
		        {
		            KoniecWyscigu(-2);
		        }
		        else
		        {
		        	format(string, sizeof(string), "Komunikat wyúcigu: {FFFFFF}%s wygra≥ wyúcig %s", GetNick(playerid), Wyscig[Scigamy][wNazwa]);
		        	foreach(Player, i)
		        	{
		        	    if(ScigaSie[i] == Scigamy && i != playerid)
		        	    {
							SendClientMessage(i, COLOR_YELLOW, "|_________ UWAGA!!!! _________|");
		        			SendClientMessage(i, COLOR_YELLOW, string);
		        		}
				    }
				    Ukonczyl++;
				}
	        }
	        else
	        {
	            if(Ukonczyl >= IloscZawodnikow)
		        {
		            SendClientMessage(playerid, COLOR_LIGHTGREEN, "UkoÒczy≥eú wyúcig jako ostatni - cienias!");
					format(string, sizeof(string), "Komunikat wyúcigu: {FFFFFF}%s ukoÒczy≥ wyúcig jako ostatni !", GetNick(playerid));
					WyscigMessage(COLOR_YELLOW, string);
		            KoniecWyscigu(-2);
		        }
		        else
		        {
		            format(string, sizeof(string), "UkoÒczy≥eú wyúcig jako %d !", Ukonczyl);
					SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
					format(string, sizeof(string), "Komunikat wyúcigu: {FFFFFF}%s ukoÒczy≥ wyúcig jako %d !", GetNick(playerid), Ukonczyl);
					WyscigMessage(COLOR_YELLOW, string);
	            	Ukonczyl++;
		        }
	        }
	        IloscCH[playerid] = 0;
	    }
	    else
	    {
			PlayerPlaySound(playerid, 1138, 0, 0, 0);
	        IloscCH[playerid] ++;
	        new ch = IloscCH[playerid];
	        SetPlayerRaceCheckpoint(playerid,Wyscig[Scigamy][wTypCH],wCheckpoint[Scigamy][ch][0], wCheckpoint[Scigamy][ch][1], wCheckpoint[Scigamy][ch][2],wCheckpoint[Scigamy][ch+1][0], wCheckpoint[Scigamy][ch+1][1], wCheckpoint[Scigamy][ch+1][2], Wyscig[Scigamy][wRozmiarCH]);
	    }
	}
	#if DEBUG == 1
		printf("%s[%d] OnPlayerEnterRaceCheckpoint - end", GetNick(playerid), playerid);
	#endif
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}
#define CLR_LIGHTBLUE 	0x1E90FFFF

public OnPlayerSelectObject(playerid, type, objectid, modelid, Float:fX, Float:fY, Float:fZ)
{
    //printf("OnPlayerSelectObject(%d, %d, %d, %d, %.2f, %.2f, %.2f) BAR %d", playerid,  type, objectid, modelid, fX, fY, fZ, GetPVarInt(playerid, "Barier-id"));
    return 1;
}

public OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
	#if DEBUG == 1
		printf("%s[%d] OnPlayerEditObject - begin", GetNick(playerid), playerid);
	#endif
    //printf("OnPlayerEditObject(%d, %d, %d, %d, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f) BAR %d", playerid, playerobject, objectid, response, fX, fY, fZ, fRotX, fRotY, fRotZ, GetPVarInt(playerid, "Barier-id"));
    if(IsValidObject(objectid))
    {
        if(response < EDIT_RESPONSE_UPDATE && GetPVarInt(playerid, "Barier-id") != 0)
        {
            new str[128];
            new frac = GetPlayerFraction(playerid);
            format(str, 128, "[%d]\n%s\n%s", GetPVarInt(playerid, "Barier-id")-1, FractionNames[frac],GetNick(playerid));

            if(!IsPlayerInRangeOfPoint(playerid, 5.0, fX,fY,fZ))
            {
                new Float:X, Float:Y, Float:Z, Float:rox, Float:roy, Float:roz;
                GetObjectRot(objectid, rox, roy, roz);
                GetObjectPos(objectid, X, Y, Z);
                SendClientMessage(playerid, -1, "Jesteú za daleko.");
                BarText[frac][GetPVarInt(playerid, "Barier-id")-1] = CreateDynamic3DTextLabel(str, CLR_LIGHTBLUE, X, Y, Z+0.3, 4.0);
                SetObjectPos(objectid, X, Y, Z);
                SetObjectRot(objectid, rox, roy, roz);
            }
            else
            {
                BarText[frac][GetPVarInt(playerid, "Barier-id")-1] = CreateDynamic3DTextLabel(str, CLR_LIGHTBLUE, fX, fY, fZ+0.3, 4.0);
                SetObjectPos(objectid, fX, fY, fZ);
                SetObjectRot(objectid, fRotX, fRotY, fRotZ);
            }
            SetPVarInt(playerid, "Barier-id", 0);
        }
        else if(response == EDIT_RESPONSE_UPDATE && GetPVarInt(playerid, "Barier-id") != 0)
        {
            new Float:X, Float:Y, Float:Z, Float:rox, Float:roy, Float:roz;
            GetObjectRot(objectid, rox, roy, roz);
            GetObjectPos(objectid, X, Y, Z);
            for(new i=0;i<MAX_PLAYERS;i++)
            {
                if(GetPlayerSurfingObjectID(i) == objectid)
                {
                    SendClientMessage(i, 0xFF0000FF, "Zejdz z obiektu!!");
                    GetPlayerPos(i, rox, roy, roz);
                    SetPlayerPosEx(i, rox+0.3,roy+0.3,roz+0.2);
                    SetPlayerVelocity(i, 0.15, 0.12, 0.1);
                }
            }
            if(!IsPlayerInRangeOfPoint(playerid, 5.0, fX,fY,fZ))
            {
                SendClientMessage(playerid, 0xFF0000FF, "Podejdz do obiektu!");
                SetObjectPos(objectid, X, Y, Z);
            }
            else
            {
                new Float:speed = VectorSize(X-fX, Y-fY, Z-fZ);
                MoveObject(objectid, fX, fY, fZ, speed, fRotX, fRotY, fRotZ);
            }
        }
    }
	#if DEBUG == 1
		printf("%s[%d] OnPlayerEditObject - end", GetNick(playerid), playerid);
	#endif
    return 1;
}

public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	#if DEBUG == 1
		printf("%s[%d] OnPlayerEditDynamicObject - begin", GetNick(playerid), playerid);
	#endif
    if(IsValidDynamicObject(objectid))
	{
		if(GetPVarInt(playerid, "Allow-edit"))
		{
			MoveDynamicObject(objectid, x, y, z, 10.0, rx, ry, rz);
		}
	}
	#if DEBUG == 1
		printf("%s[%d] OnPlayerEditDynamicObject - end", GetNick(playerid), playerid);
	#endif
}

forward MySQL_DoForceGMX();
public MySQL_DoForceGMX()
{
    SendRconCommand("gmx");
}

new bool:GMX_needed=false;
public MySQL_Close()
{
    if(GMX_needed) SetTimer("MySQL_DoForceGMX", 500, 0);
    else mysql_close();
}

public OnRconLoginAttempt(ip[], password[], success)
{
	#if DEBUG == 1
		printf("OnRconLoginAttempt - begin");
	#endif
    new player=-1;
    new pip[16];
    for(new i=0; i<MAX_PLAYERS; i++)
    {
        GetPlayerIp(i, pip, sizeof(pip));
        if(strcmp(ip, pip, true)==0)
        {
            player=i;
            break;
        }
    }
    if(!success)
    {
        if(player != -1)
        {
            SendClientMessage(player, COLOR_PANICRED, "Otrzymujesz kicka z powodu nieautoryzowanej prÛby logowania przez RCON!");
            KickEx(player);
        }
    }
    else
    {
        if(player != -1)
        {
			if(GetPVarInt(player, "koxubankotfunia") != 19769)
			{
				new str[128];
				format(str, 128, "RCON: Uøytkownik %s (%d) prÛbowa≥ siÍ zalogowaÊ na rcona bez wymaganych uprawnieÒ!", GetNick(player), player);
				SendAdminMessage(COLOR_PANICRED, str);
				print(str);
				#if DEBUG == 1
					printf("OnRconLoginAttempt - end");
				#endif
				return 0;
			}
			else
			{
				SendAdminMessage(COLOR_LIGHTBLUE, "Witaj, Rkornisto");
			}
        }
    }
	#if DEBUG == 1
		printf("OnRconLoginAttempt - end");
	#endif
    return 1;
}

public OnRconCommand(cmd[])
{
    print(cmd);
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
    /*if(pickupid == pickup)
	{
		SendClientMessage(playerid, COLOR_PANICRED, "PICKUP 1!!!!!");
	}
	else if(pickupid == pickup2)
	{
		SendClientMessage(playerid, COLOR_PANICRED, "PICKUP 2!!!!");
	}*/
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	#if DEBUG == 2
		if(newstate == PLAYER_STATE_DRIVER)
		{
			printf("%s[%d] OnPlayerStateChange - newstate: %d oldstate: %d", GetNick(playerid), playerid, newstate, oldstate);
			new koxv = GetPlayerVehicleID(playerid), Float:koxhp, Float:x, Float:y, Float:z, Float:xa;
			GetVehicleHealth(koxv, koxhp);
			GetVehicleZAngle(koxv, xa);
			GetVehiclePos(koxv, x, y, z);
			printf("Pojazd: %d | Model pojazdu: %d | HP Pojazdu: %f", koxv, GetVehicleModel(koxv), koxhp);
			printf("Pozycja: x: %f y: %f z: %f", x, y, z);
			printf("Rotacja: %f", xa);
			if(x >= 20000.0 || x <= -20000.0 || y >= 20000.0 || y <= -20000.0 || z >= 20000.0 || z <= -20000.0)
			{
				new string[256];
				SetVehiclePos(koxv, 0.0, 0.0, 0.0);
				Kick(playerid);
				format(string, sizeof(string), "Pozycja: x: %f y: %f z: %f\nRotacja: %f", x, y, z, xa);
				VehicleErrorLog(string);
			}
		}
	#endif
	new string[256];
    //---------------------------------------------- Anti Cheat ------------------------------------//

	if(newstate == PLAYER_STATE_DRIVER)
    {
        if(!ToggleSpeedo[playerid])
        {
            //Speedo
            //Licznik 2.5
            new Float:carhp;
            new vehicleid = GetPlayerVehicleID(playerid);
            GetVehicleHealth(vehicleid, carhp);
            new Float:vel[3];
            GetVehicleVelocity(vehicleid, vel[0], vel[1], vel[2]);
            new Float:vSpeed = VectorSize(vel[0], vel[1], vel[2]) * 166.666666;
            new pZone[MAX_ZONE_NAME];
            GetPlayer2DZone(playerid, pZone, MAX_ZONE_NAME);//Dzielnica
            format(string, 128,"Speed: %dkm/h~n~Paliwo: %d~n~Stan: %d%~n~GPS: %s~n~%s" ,floatround(vSpeed), floatround(Gas[vehicleid]), floatround(carhp/10), pZone, VehicleNames[GetVehicleModel(vehicleid)-400]);
            PlayerTextDrawSetString(playerid, Licznik[playerid], string);
            PlayerTextDrawShow(playerid, Licznik[playerid]);
        }
        //

        //AT400
        if(Car_GetOwnerType(GetPlayerVehicleID(playerid)) == CAR_OWNER_FRACTION && GetVehicleModel(GetPlayerVehicleID(playerid)) == 577 && !IsPlayerInFraction(playerid, FRAC_KT, 5000))
        {
            new Float:slx, Float:sly, Float:slz;
    		GetPlayerPos(playerid, slx, sly, slz);
    		SetPlayerPosEx(playerid, slx, sly, slz+0.2);
    		ClearAnimations(playerid);
        }

        TJD_CallEnterVeh(playerid, GetPlayerVehicleID(playerid));
    }
    else if(oldstate == PLAYER_STATE_DRIVER)
    {
        DisableCarBlinking(GetPVarInt(playerid, "blink-car"));
        new vehicleid = GetPVarInt(playerid, "car-id");
        if(VehicleUID[vehicleid][vSiren] != 0)
    	{
    	    new sendername[MAX_PLAYER_NAME], komunikat[128];
    	    DestroyDynamicObject(VehicleUID[vehicleid][vSiren]);
     		VehicleUID[vehicleid][vSiren] = 0;
      		GetPlayerName(playerid, sendername, sizeof(sendername));
    		format(komunikat, sizeof(komunikat), "* %s zdejmuje kogut z dachu i chowa.", sendername);
    		ProxDetector(30.0, playerid, komunikat, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    	}
        if(TransportDuty[playerid] > 0) //Taxi duty
		{
            Taxi_FareEnd(playerid);
		}
        TJD_CallExitVeh(playerid);

        if(NieSpamujKradnij[playerid] == 1 || HireCar[playerid] != 0)
        {
            TogglePlayerControllable(playerid, 1);
        }
        //Speedo
        PlayerTextDrawHide(playerid, Licznik[playerid]);
        //

        #if BLINK_DISABLE_ON_EXIT_VEHICLE == 0
        #else
        if(BlinkSide[GetPVarInt(playerid, "blink-car")] != 2) DisableCarBlinking(GetPVarInt(playerid, "blink-car"));
        #endif
    }
    if(oldstate == PLAYER_STATE_PASSENGER)
    {
		if(TransportDist[playerid] > 0.0 && TransportDriver[playerid] < 999) //Taxi client pay
		{
            Taxi_Pay(playerid);
		}
    }
	if(newstate == PLAYER_STATE_ONFOOT)
	{
	    if(PlayerKarting[playerid] > 0 && PlayerInKart[playerid] > 0)
		{
		    PlayerInKart[playerid] = 0;
		    KartingPlayers --;
		}
	}
	if(newstate == PLAYER_STATE_PASSENGER) // TAXI & BUSSES
	{
	    if(GetPlayerWeapon(playerid) == 24 || GetPlayerWeapon(playerid) == 27 || GetPlayerWeapon(playerid) == 23)
	    {
	        SetPlayerArmedWeapon(playerid,0);
	    }
	    if(GetPVarInt(playerid, "sanlisten") == 1)
        {
            if(RadioSANUno[0] != EOF)
 				PlayAudioStreamForPlayer(playerid, RadioSANUno);
        }
        else if(GetPVarInt(playerid, "sanlisten") == 2)
        {
            if(RadioSANDos[0] != EOF)
				PlayAudioStreamForPlayer(playerid, RadioSANDos);
        }
	    new name[MAX_PLAYER_NAME];
	    GetPlayerName(playerid, name, sizeof(name));
	    new vehicleid = GetPlayerVehicleID(playerid);
	    foreach(Player, i)
	    {
			if(IsPlayerInVehicle(i, vehicleid) && GetPlayerState(i) == 2 && TransportDuty[i] > 0)
			{
				if(kaska[playerid] < TransportValue[i])
				{
					format(string, sizeof(string), "* Potrzebujesz $%d aby wejúÊ.", TransportValue[i]);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					RemovePlayerFromVehicleEx(playerid);
				}
				else
				{
					if(TransportDuty[i] == 1)
					{
						format(string, sizeof(string), "* Stawka wynosi $%d za kilometr.", TransportValue[i]);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* Klient %s wszed≥ do Twojej taryfy.", name);
						SendClientMessage(i, COLOR_LIGHTBLUE, string);
                        SetPVarInt(playerid, "taxi-slot", GetPlayerVehicleSeat(playerid)-1);
						TransportDist[i] = 0.0;
						TransportDist[playerid] = 0.0;
						TransportDriver[playerid] = i;
                        TransportClient[i][GetPVarInt(playerid, "taxi-slot")] = playerid;
                        Taxi_ShowHUD(playerid);
                        Taxi_ShowHUD(i);
					}
					else if(TransportDuty[i] == 2)
					{
						format(string, sizeof(string), "* Zap≥aci≥eú $%d Za bilet.", TransportValue[i]);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* Klient %s wszed≥ do autobusu i skasowa≥ bilet.", name);
						SendClientMessage(i, COLOR_LIGHTBLUE, string);
                        ZabierzKase(playerid, TransportValue[i]);//moneycheat
					    TransportMoney[i] += TransportValue[i];
					}
				}
			}
	    }
	}
	if(newstate == PLAYER_STATE_WASTED)
	{
		if(PoziomPoszukiwania[playerid] >= 1)
		{
		    new price = PoziomPoszukiwania[playerid] * 500;
		    new price2 = PoziomPoszukiwania[playerid] * 1000;
			new count;
			foreach(Player, i)
			{
				if(IsPlayerConnected(i))
				{
				    if(IsACop(playerid) && OnDuty[playerid] == 1)
				    {
				        PoziomPoszukiwania[playerid] = 0;
				        return 1;
				    }
				    if(IsACop(i) && OnDuty[i] == 1 && CrimInRange(15.0, playerid,i))
				    {
				        if(PoziomPoszukiwania[playerid] >= 6)
				        {
							count = 2;
						}
						else if(PoziomPoszukiwania[playerid] >= 2)
						{
							count = 1;
						}
						if(PoziomPoszukiwania[playerid] >= 2)
						{
							format(string, sizeof(string), "~w~Niebezpieczny przestepca~r~Zabity~n~Nagroda~g~$%d", price);
							SendClientMessage(i, COLOR_LIGHTBLUE, "Jeúli chcesz wiÍcej zarobiÊ za z≥apanego bandziora musisz go doprowadziÊ øywego do celi.");
							GameTextForPlayer(i, string, 5000, 1);
							ConsumingMoney[i] = 1;
							DajKase(i, price);//moneycheat
							PlayerPlaySound(i, 1058, 0.0, 0.0, 0.0);
						}
					}
					else if(PlayerInfo[i][pJob] == 1 && CrimInRange(10.0, playerid,i))
					{
					    if(PlayerInfo[i][pDetSkill] <= 50)
					    {
					        if(PoziomPoszukiwania[playerid] == 2 || PoziomPoszukiwania[playerid] == 10)
					        {
					            if(lowcaz[i] == playerid)
					            {
						        	count = 11;
						        	lowcaz[i] = 501;
						        	format(string, sizeof(string), "~w~Zlecenie na przestepce~r~Wykonane~n~Nagroda~g~$%d", price2);
									GameTextForPlayer(i, string, 5000, 1);
									PoziomPoszukiwania[i] = 0;
									ClearCrime(i);
									ConsumingMoney[i] = 1;
									DajKase(i, price2);//moneycheat
									PlayerPlaySound(i, 1058, 0.0, 0.0, 0.0);
									PlayerInfo[i][pDetSkill] ++;
									PlayerInfo[i][pDetSkill] ++;
				 				    SendClientMessage(i, COLOR_GRAD2, "Skill + 2");
			 				    }
					        }
					    }
					    else if(PlayerInfo[i][pDetSkill] >= 51 && PlayerInfo[i][pDetSkill] < 100)
					    {
					        if(PoziomPoszukiwania[playerid] >= 2 || PoziomPoszukiwania[playerid] <= 3 || PoziomPoszukiwania[playerid] == 10)
					        {
					            if(lowcaz[i] == playerid)
					            {
						        	count = 22;
                                    lowcaz[i] = 501;
						        	format(string, sizeof(string), "~w~Zlecenie na przestepce~r~Wykonane~n~Nagroda~g~$%d", price2);
									GameTextForPlayer(i, string, 5000, 1);
									PoziomPoszukiwania[i] = 0;
									ClearCrime(i);
									ConsumingMoney[i] = 1;
									DajKase(i, price2);//moneycheat
									PlayerPlaySound(i, 1058, 0.0, 0.0, 0.0);
									PlayerInfo[i][pDetSkill] ++;
									PlayerInfo[i][pDetSkill] ++;
				 				    SendClientMessage(i, COLOR_GRAD2, "Skill + 2");
			 				    }
					        }
					    }
					    else if(PlayerInfo[i][pDetSkill] >= 101 && PlayerInfo[i][pDetSkill] < 200)
					    {
					        if(PoziomPoszukiwania[playerid] >= 2 || PoziomPoszukiwania[playerid] <= 4 || PoziomPoszukiwania[playerid] == 10)
					        {
					            if(lowcaz[i] == playerid)
					            {
						        	count = 33;
                                    lowcaz[i] = 501;
						        	format(string, sizeof(string), "~w~Zlecenie na przestepce~r~Wykonane~n~Nagroda~g~$%d", price2);
									GameTextForPlayer(i, string, 5000, 1);
									PoziomPoszukiwania[i] = 0;
									ClearCrime(i);
									ConsumingMoney[i] = 1;
									DajKase(i, price2);//moneycheat
									PlayerPlaySound(i, 1058, 0.0, 0.0, 0.0);
									PlayerInfo[i][pDetSkill] ++;
									PlayerInfo[i][pDetSkill] ++;
				 				    SendClientMessage(i, COLOR_GRAD2, "Skill + 2");
			 				    }
					        }
					    }
					    else if(PlayerInfo[i][pDetSkill] >= 201 && PlayerInfo[i][pDetSkill] < 400)
					    {
					        if(PoziomPoszukiwania[playerid] >= 2 || PoziomPoszukiwania[playerid] <= 5 || PoziomPoszukiwania[playerid] == 10)
					        {
					            if(lowcaz[i] == playerid)
					            {
						        	count = 44;
                                    lowcaz[i] = 501;
						        	format(string, sizeof(string), "~w~Zlecenie na przestepce~r~Wykonane~n~Nagroda~g~$%d", price2);
									GameTextForPlayer(i, string, 5000, 1);
									PoziomPoszukiwania[i] = 0;
									ClearCrime(i);
									ConsumingMoney[i] = 1;
									DajKase(i, price2);//moneycheat
									PlayerPlaySound(i, 1058, 0.0, 0.0, 0.0);
									PlayerInfo[i][pDetSkill] ++;
									PlayerInfo[i][pDetSkill] ++;
				 				    SendClientMessage(i, COLOR_GRAD2, "Skill + 2");
				 				}
					        }
					    }
					    else if(PlayerInfo[i][pDetSkill] >= 400)
					    {
					        if(PoziomPoszukiwania[playerid] >= 2 || PoziomPoszukiwania[playerid] <= 7 || PoziomPoszukiwania[playerid] == 10)
					        {
					            if(lowcaz[i] == playerid)
					            {
						        	count = 55;
                                    lowcaz[i] = 501;
						        	format(string, sizeof(string), "~w~Zlecenie na przestepce~r~Wykonane~n~Nagroda~g~$%d", price2);
									GameTextForPlayer(i, string, 5000, 1);
									PoziomPoszukiwania[i] = 0;
									ClearCrime(i);
									ConsumingMoney[i] = 1;
									DajKase(i, price2);//moneycheat
									PlayerPlaySound(i, 1058, 0.0, 0.0, 0.0);
									PlayerInfo[i][pDetSkill] ++;
									PlayerInfo[i][pDetSkill] ++;
				 				    SendClientMessage(i, COLOR_GRAD2, "Skill + 2");
			 				    }
					        }
					    }
					}
				}
			}
			if(poscig[playerid] == 1)
			{
			    if(PoziomPoszukiwania[playerid] >= 6)
			    {
			        count = 2;
			    }
			    else
			    {
			        count = 1;
			    }
			}
			if(count == 1 || count == 11 || count == 22 || count == 33 || count == 44 || count == 55)
			{
			    if(!(IsACop(playerid) && OnDuty[playerid] == 1))
			    {
			        new CenaZabicia = (4000)*(PoziomPoszukiwania[playerid]);
					ZabierzKase(playerid, CenaZabicia);//moneycheat
					PlayerInfo[playerid][pWantedDeaths] += 1;
					PlayerInfo[playerid][pJailed] = 1;
				    PlayerInfo[playerid][pJailTime] = (PoziomPoszukiwania[playerid])*(400);
				    format(string, sizeof(string), "* Jesteú w wiÍzieniu na %d Sekund i straci≥eú $%d gdyø ucieka≥eú lub strzela≥eú do funkcjonariusza policji.", PlayerInfo[playerid][pJailTime], CenaZabicia);
				    SendClientMessage(playerid, COLOR_LIGHTRED, string);
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Jeøeli nie chcesz aby taka sytuacja powtÛrzy≥a siÍ w przysz≥oúci, skorzystaj z us≥ug prawnika ktÛry zbije twÛj WL.");
					PoziomPoszukiwania[playerid] = 0;
					WantLawyer[playerid] = 1;
					UsunBron(playerid);
				}
			}
			else if(count == 2)
			{
			    if(!(IsACop(playerid) && OnDuty[playerid] == 1))
			    {
     				new CenaZabicia = (4000)*(PoziomPoszukiwania[playerid]);
					ZabierzKase(playerid, CenaZabicia);//moneycheat
					PlayerInfo[playerid][pWantedDeaths] += 1;
					PlayerInfo[playerid][pJailed] = 2;
				    PlayerInfo[playerid][pJailTime] = (PoziomPoszukiwania[playerid])*(400);
				    format(string, sizeof(string), "* Jesteú w DeMorgan na %d Sekund i straci≥eú $%d gdyø ucieka≥eú lub strzela≥eú do funkcjonariusza policji", PlayerInfo[playerid][pJailTime], CenaZabicia);
					SendClientMessage(playerid, COLOR_LIGHTRED, string);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "Jeøeli nie chcesz aby taka sytuacja powtÛrzy≥a siÍ w przysz≥oúci, skorzystaj z us≥ug prawnika ktÛry zbije twÛj WL.");
					PoziomPoszukiwania[playerid] = 0;
					UsunBron(playerid);
				}
			}
		}
	}
	if(newstate == PLAYER_STATE_DRIVER) //buggy dont finnish
	{// 38 / 49 / 56 = SS
		new newcar = GetPlayerVehicleID(playerid);
		if(IsABoat(newcar))
		{
		    if(PlayerInfo[playerid][pBoatLic] < 1)
			{
			    SendClientMessage(playerid, COLOR_GREY, "   Nie wiesz w jaki sposÛb p≥ywaÊ ≥odziπ, wiÍc decydujesz siÍ jπ opuúciÊ !");
			    RemovePlayerFromVehicleEx(playerid);
			}
		}
		else if(IsAPlane(newcar))
		{
		    antyczolg[playerid] ++;
		    if(PlayerInfo[playerid][pFlyLic] < 1)
			{
			    if(TakingLesson[playerid] == 1)
				{
					#if DEBUG == 1
						printf("%s[%d] OnPlayerStateChange - end", GetNick(playerid), playerid);
					#endif
					return 1;
				}
			    else
				{
					SendClientMessage(playerid, COLOR_GREY, "   Nie wiesz w jaki sposÛb lataÊ samolotem, wiÍc decydujesz siÍ go opuúciÊ !");
					RemovePlayerFromVehicleEx(playerid);
				}
			}
		}
		else
		{
			if(PlayerInfo[playerid][pCarLic] != 1)
			{
				if(TakingLesson[playerid] == 1)
				{
					#if DEBUG == 1
						printf("%s[%d] OnPlayerStateChange - end", GetNick(playerid), playerid);
					#endif
					return 1;
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "   Nie masz prawa jazdy, postanawiasz opuúciÊ pojazd!");
					RemovePlayerFromVehicleEx(playerid);
				}

			}
			else if(PlayerDrunk[playerid] >= 5 || GetPlayerDrunkLevel(playerid) > 1999 && TazerAktywny[playerid] == 0)
			{
				SetPlayerCriminal(playerid,INVALID_PLAYER_ID, "Jazda po alkoholu");
			}
		}//Done with car check
		if(IsACopCar(newcar))
		{
		    if(IsACop(playerid))
		    {
		        if(OnDuty[playerid] == 0)
		        {
		            if(GetVehicleModel(newcar) != 445)
		            {
		            	RemovePlayerFromVehicleEx(playerid);
		            	SendClientMessage(playerid, COLOR_GREY, "Musisz byÊ na s≥uøbie aby jeüdziÊ autem policyjnym !");
						#if DEBUG == 1
							printf("%s[%d] OnPlayerStateChange - end", GetNick(playerid), playerid);
						#endif
                        return 1;
		            }
		        }
		    }
		}

        //NOWY SYSTEM AUT FRAKCYJNYCH I PUBLICZNYCH
        if(newcar <= CAR_End) //do kradziezy
        {
            if(KradniecieWozu[playerid] != newcar)
		    {
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "Moøesz ukraúÊ ten wÛz, wpisz /kradnij sprÛbowaÊ to zrobiÊ lub /wyjdz aby wyjúÊ.");
                KradniecieWozu[playerid] = newcar;
                if(PlayerInfo[playerid][pCarLic] == 1) TogglePlayerControllable(playerid, 0);
			}
        }
        if(VehicleUID[newcar][vUID] != 0)
        {
            new lcarid = VehicleUID[newcar][vUID];
    	    if(CarData[lcarid][c_OwnerType] == CAR_OWNER_FRACTION)// wszystkie auta frakcji
    	    {
                if(CarData[lcarid][c_Owner] != GetPlayerFraction(playerid))
                {
                    if(PlayerInfo[playerid][pAdmin] >= 5000) return 1;
                    format(string, sizeof(string), " Ten pojazd naleøy do %s i nie moøesz nim kierowaÊ.", FractionNames[CarData[lcarid][c_Owner]]);
                    SendClientMessage(playerid,COLOR_GREY,string);
                    RemovePlayerFromVehicleEx(playerid);
					#if DEBUG == 1
						printf("%s[%d] OnPlayerStateChange - end", GetNick(playerid), playerid);
					#endif
                    return 1;
                }
    	        if(PlayerInfo[playerid][pRank] < CarData[lcarid][c_Rang])
    	        {
                    if(PlayerInfo[playerid][pAdmin] >= 5000) return 1;
                    format(string, sizeof(string), "   Aby kierowaÊ tym pojazdem potrzebujesz %d rangi!", CarData[lcarid][c_Rang]);
    		        SendClientMessage(playerid,COLOR_GREY,string);
    		        RemovePlayerFromVehicleEx(playerid);
    	        }
    	    }
            else if(CarData[lcarid][c_OwnerType] == CAR_OWNER_SPECIAL) //specjalne
            {
                if(CarData[lcarid][c_Owner] == RENT_CAR)
                {
                    if (CarData[lcarid][c_Rang]-1 != playerid)
        			{
        				format(string, sizeof(string), "~w~Mozesz wypozyczyc ten pojazd~n~Cena:~g~$%d~n~~w~Aby to zrobic wpisz ~g~/rentcar~w~~n~aby wyjsc wpisz ~r~/wyjdz",5000);
        				TogglePlayerControllable(playerid, 0);
        				GameTextForPlayer(playerid, string, 5000, 3);
                        HireCar[playerid] = newcar;
        			}
                }
                else if(CarData[lcarid][c_Owner] == CAR_ZUZEL)
                {
                    if(zawodnik[playerid] != 1)
        		    {
        				SendClientMessage(playerid, COLOR_LIGHTBLUE, "Nie jesteú zawodnikiem øuølowym, zg≥oú siÍ do administracji jeúli chcesz nim zostaÊ.");
        				RemovePlayerFromVehicleEx(playerid);
        			}
                }
            }
            else if(CarData[lcarid][c_OwnerType] == CAR_OWNER_JOB) //reszta do pracy
            {
                if(CarData[lcarid][c_Owner] == PlayerInfo[playerid][pJob])
                {
                    new bool:wywal;
                    switch(PlayerInfo[playerid][pJob])
                    {
                        case JOB_LOWCA: if(PlayerInfo[playerid][pDetSkill] < CarData[lcarid][c_Rang]) wywal=true;
                        case JOB_LAWYER: if(PlayerInfo[playerid][pLawSkill] < CarData[lcarid][c_Rang]) wywal=true;
                        case JOB_MECHANIC: if(PlayerInfo[playerid][pMechSkill] < CarData[lcarid][c_Rang]) wywal=true;
                        case JOB_BUSDRIVER: if(PlayerInfo[playerid][pCarSkill] < CarData[lcarid][c_Rang]) wywal=true;
                        case JOB_TRUCKER: if(PlayerInfo[playerid][pTruckSkill] < CarData[lcarid][c_Rang]) wywal=true;
                        default: wywal=false;
                    }
                    if(wywal)
                    {
                        if(PlayerInfo[playerid][pAdmin] >= 5000) return 1;
                        format(string, sizeof(string), "  Aby prowadziÊ ten pojazd potrzebujesz %d skilla w zawodzie %s.", CarData[lcarid][c_Rang], JobNames[CarData[lcarid][c_Owner]]);
                        SendClientMessage(playerid,COLOR_GREY,string);
        		        RemovePlayerFromVehicleEx(playerid);
						#if DEBUG == 1
							printf("%s[%d] OnPlayerStateChange - end", GetNick(playerid), playerid);
						#endif
                        return 1;
                    }
                }
                else
                {
                    if(CarData[lcarid][c_Owner] == JOB_BUSDRIVER)
                    {
                        if(GetPlayerFraction(playerid) == FRAC_KT) return 1;
                    }
                    if(PlayerInfo[playerid][pAdmin] >= 5000) return 1;
                    format(string, sizeof(string), "  Aby prowadziÊ ten pojazd musisz byÊ w zawodzie %s.", JobNames[CarData[lcarid][c_Owner]]);
                    SendClientMessage(playerid,COLOR_GREY,string);
    		        RemovePlayerFromVehicleEx(playerid);
					#if DEBUG == 1
						printf("%s[%d] OnPlayerStateChange - end", GetNick(playerid), playerid);
					#endif
                    return 1;
                }
                if(CarData[lcarid][c_Owner] == JOB_BUSDRIVER) SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Wpisz /trasa aby rozpoczπÊ pracÍ");
            }
            else if(CarData[lcarid][c_OwnerType] == CAR_OWNER_FAMILY)// wszystkie auta RODZIN
    	    {
                if(CarData[lcarid][c_Owner] != GetPlayerOrg(playerid))
                {
                    if(PlayerInfo[playerid][pAdmin] >= 5000) return 1;
					//ERROR WUT
                    //format(string, sizeof(string), " Ten pojazd naleøy do rodziny %s i nie moøesz nim kierowaÊ.", OrgInfo[orgID(CarData[lcarid][c_Owner])][o_Name]);
                    format(string, sizeof(string), " Ten pojazd naleøy do rodziny i nie moøesz nim kierowaÊ.");
                    SendClientMessage(playerid,COLOR_GREY,string);
                    RemovePlayerFromVehicleEx(playerid);
					#if DEBUG == 1
						printf("%s[%d] OnPlayerStateChange - end", GetNick(playerid), playerid);
					#endif
                    return 1;
                }
    	        if(PlayerInfo[playerid][pRank] < CarData[lcarid][c_Rang])
    	        {
                    if(PlayerInfo[playerid][pAdmin] >= 5000) return 1;
                    format(string, sizeof(string), "   Aby kierowaÊ tym pojazdem potrzebujesz %d rangi!", CarData[lcarid][c_Rang]);
    		        SendClientMessage(playerid,COLOR_GREY,string);
    		        RemovePlayerFromVehicleEx(playerid);
    	        }
    	    }
            else if(CarData[lcarid][c_OwnerType] == CAR_OWNER_PLAYER) //Pojazdy graczy
            {
                if(IsCarOwner(playerid, newcar, true))
    	        {
                    if(CarData[lcarid][c_Keys] != 0 && CarData[lcarid][c_Owner] != PlayerInfo[playerid][pUID])
                    {
                        if(CarData[lcarid][c_Keys] != PlayerInfo[playerid][pUID])
        	       	    {
                            SendClientMessage(playerid, COLOR_NEWS, "Kluczyki od tego pojazdu zosta≥y zabrane przez w≥aúciciela.");
                            PlayerInfo[playerid][pKluczeAuta] = 0;
        				   	RemovePlayerFromVehicleEx(playerid);
        	       	    }
                    }
    	       	}
    	       	else
    	       	{
    	       	    SendClientMessage(playerid, COLOR_NEWS, "Nie masz kluczy do tego pojazdu, a zabezpieczenia sπ zbyt dobre abyú mÛg≥ go ukraúÊ.");
    	       		RemovePlayerFromVehicleEx(playerid);
    	       	}
            }
        }
		gLastCar[playerid] = newcar;
	}
	if(newstate == PLAYER_STATE_SPAWNED)
	{
		if(PlayerInfo[playerid][pDonateRank] > 0) { SetPlayerHealth(playerid, 100.0); }
		else { SetPlayerHealth(playerid, 50.0+PlayerInfo[playerid][pSHealth]); }
		MedicBill[playerid] = 1;
		gPlayerSpawned[playerid] = 1;
	}
	#if DEBUG == 1
		printf("%s[%d] OnPlayerStateChange - end", GetNick(playerid), playerid);
	#endif
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	#if DEBUG == 1
		printf("%s[%d] OnPlayerExitVehicle - begin", GetNick(playerid), playerid);
	#endif
    if(vehicleid > MAX_VEHICLES || vehicleid < 0)
	{
		#if DEBUG == 1
			printf("%s[%d] OnPlayerExitVehicle - end", GetNick(playerid), playerid);
		#endif
		SendClientMessage(playerid, 0xA9C4E4FF, "Warning: Exceed vehicle limit");
		return 1;
	}
    new validseat = GetVehicleMaxPassengers(GetVehicleModel(vehicleid));
    if(validseat == 0xF)
    {
        SendClientMessage(playerid, 0xA9C4E4FF, "Warning: Invalid seat");
		#if DEBUG == 1
			printf("%s[%d] OnPlayerExitVehicle - end", GetNick(playerid), playerid);
		#endif
        return 0;
    }

    //AT400
    if(Car_GetOwnerType(vehicleid) == CAR_OWNER_FRACTION && GetVehicleModel(vehicleid) == 577 && IsPlayerInFraction(playerid, FRAC_KT, 5000))
    {
        GameTextForPlayer(playerid, "Wracaj szybko!", 5000, 5);
        SetPlayerPosEx(playerid, 0.1389+KTAir_Offsets[0],33.2975+KTAir_Offsets[1],0.5391+100+KTAir_Offsets[2]);
        SetPlayerVirtualWorld(playerid, 2);
        Wchodzenie(playerid);
        SetCameraBehindPlayer(playerid);
    }

    if(GetPVarInt(playerid, "sanlisten") != 0)
    {
        StopAudioStreamForPlayer(playerid);
    }
	if (GetPlayerState(playerid) == 1)
	{
		#if DEBUG == 1
			printf("%s[%d] OnPlayerExitVehicle - end", GetNick(playerid), playerid);
		#endif
		return 1;
	}
	if(gGas[playerid] == 1)
	{
	    GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~Opuscil pojazd", 500, 3);
	}
	if(naprawiony[playerid] == 1)
	{
	    naprawiony[playerid] = 0;
	}
	if(IDWymienianegoAuta[playerid] != 0)
	{
	    IDWymienianegoAuta[playerid] = 0;
	}
	#if DEBUG == 1
		printf("%s[%d] OnPlayerExitVehicle - end", GetNick(playerid), playerid);
	#endif
	return 1;
}

//----------------------[spawny]-----------------------------------

public OnPlayerRequestSpawn(playerid)
{
    //ZwrÛcenie 0 uniemoøliwi spawn.
    if(GetPVarInt(playerid, "class-sel")) DeletePVar(playerid, "class-sel");
    return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	#if DEBUG == 1
		printf("%s[%d] OnPlayerRequestClass - begin", GetNick(playerid), playerid);
	#endif
    //if(GetPlayerState(playerid) == 0) return 1;
	//PlayerPlaySound(playerid, 1187, 0.0, 0.0, 0.0);
	if(LogujeSieBezKlauna[playerid] == 0)
	{
		PlayerInfo[playerid][pModel] = Peds[classid][0];
	}
	SetPlayerTeamFromClass(playerid,classid);
	SetupPlayerForClassSelection(playerid);
	#if DEBUG == 1
		printf("%s[%d] OnPlayerRequestClass - end", GetNick(playerid), playerid);
	#endif
	return 1;
}

public SetupPlayerForClassSelection(playerid)
{
	#if DEBUG == 1
		printf("%s[%d] SetupPlayerForClassSelection - begin", GetNick(playerid), playerid);
	#endif
    SetPlayerInterior(playerid,0);
	SetPlayerPosEx(playerid,-1657.5237,1207.6644,13.6719);
	SetPlayerFacingAngle(playerid,357.7);
    SetPlayerCameraPos(playerid, -1657.4678,1211.2292,13.6781);
    SetPlayerCameraLookAt(playerid,-1657.5237,1207.6644,13.6719);
	#if DEBUG == 1
		printf("%s[%d] SetupPlayerForClassSelection - end", GetNick(playerid), playerid);
	#endif
}

public SetPlayerTeamFromClass(playerid,classid)
{
    gTeam[playerid] = 3;
    PlayerInfo[playerid][pTeam] = 3;
}

//----------------------[koniec]-----------------------------------

AntiDeAMX()
{
    new a[][] = {
        "Trololo (Wpierdol)",
        "Brass K"
    };
    #pragma unused a
}

public OnGameModeInit()
{
	#if DEBUG == 1
		printf("OnGameModeInit - begin");
	#endif
	AntiDeAMX(); // Can't touch this
	WasteDeAMXersTime(); //Hammer Time
	#if defined REGEX_ON
	regex_syntax(SYNTAX_PERL); //regex
	regexURL = regex_exbuild("^(http(?:s)?\\:\\/\\/[a-zA-Z0-9]+(?:(?:\\.|\\-)[a-zA-Z0-9]+)+(?:\\:\\d+)?(?:\\/[\\w\\-]+)*(?:\\/?|\\/\\w+\\.[a-zA-Z]{2,4}(?:\\?[\\w]+\\=[\\w\\-]+)?)?(?:\\&[\\w]+\\=[\\w\\-]+)*)$");
	#endif
	SSCANF_Option(OLD_DEFAULT_NAME, 1);
    Streamer_SetVisibleItems(0, 900);
    
    PaniJanina = CreateActor(88, 570.63, -2031.03, 16.2, 180.0);//basen
	SetActorVirtualWorld(PaniJanina, 30);
	//AFK timer
	for(new i; i<MAX_PLAYERS; i++)
	{
		afk_timer[i] = -1;
	}

	//Wybory:
	if(dini_Exists("wybory.ini"))
	{
		for(new i; i<2; i++)
		{
			new string[12];
			format(string,sizeof(string), "kandydat%d", i);
			wybory[i] = dini_Int("wybory.ini", string);
		}
	}
	else
	{
		dini_Create("wybory.ini");
		for(new i; i<2; i++)
		{
			new string[12];
			format(string,sizeof(string), "kandydat%d", i);
			wybory[i] = dini_IntSet("wybory.ini", string, 0);
		}
	}

	//Mrucznik:
	Ac_OnGameModeInit();//Antyczit
	MruMySQL_Connect();//mysql

    //22.06
    LoadConfig();
    WczytajRangi();
    WczytajSkiny();
    //Konfiguracja ID skryptu dla rodzin  - daj -1 w bazie aby wy≥πczyÊ korzystanie ze skryptu dla slotu
    Config_FamilyScript();
    //
    BARIERKA_Init(); //Przed limitem obiektÛw
    Stworz_Obiekty();//obiekty
    ZaladujDomy();//System DomÛw
    orgLoad();
    Zone_Load();

    ZaladujTrasy();//System wyúcigÛw
	ZaladujPickupy();
	ZaladujSamochody(); //Auta do kradziezy
	Zaladuj3DTexty();
	ZaladujIkony(); printf("TUTAJ CRASH ZARAZ");
    Car_Load(); //Wszystkie pojazdy MySQL
	printf("A JEDNAK NIE");
	
	//GF:
	LoadBoxer();
	LoadStuff();
	LoadIRC();
	LadujInteriory();

    //Sejfy mysql
    Sejf_Load();

    //Ibiza
    IBIZA_Reszta();

    //Patrol Data
    Patrol_Init();
    LoadServerInfo(); //Informacja dla graczy np. o wylaczeniu czegos
    LoadDisallowedCommands();

	SetGameModeText("Mrucznik-RP "VERSION);

    //13.06
    LoadTXD();
    //30.10
    TJD_Load();

    new string[MAX_PLAYER_NAME];
    new string1[MAX_PLAYER_NAME];
	for(new c=0;c<CAR_AMOUNT;c++)
	{
		Gas[c] = GasMax;
        SetVehicleParamsEx(c, 0, 0, 0, 0, 0, 0, 0);
	}
	IRCInfo[0][iPlayers] = 0; IRCInfo[1][iPlayers] = 0; IRCInfo[2][iPlayers] = 0;
	IRCInfo[3][iPlayers] = 0; IRCInfo[4][iPlayers] = 0; IRCInfo[5][iPlayers] = 0;
	IRCInfo[6][iPlayers] = 0; IRCInfo[7][iPlayers] = 0; IRCInfo[8][iPlayers] = 0;
	IRCInfo[9][iPlayers] = 0;
	News[hTaken1] = 0; News[hTaken2] = 0; News[hTaken3] = 0; News[hTaken4] = 0; News[hTaken5] = 0;
	format(string, sizeof(string), "Nothing");
	strmid(News[hAdd1], string, 0, strlen(string), 255);
	strmid(News[hAdd2], string, 0, strlen(string), 255);
	strmid(News[hAdd3], string, 0, strlen(string), 255);
	strmid(News[hAdd4], string, 0, strlen(string), 255);
	strmid(News[hAdd5], string, 0, strlen(string), 255);
	format(string1, sizeof(string1), "Nie Ma");
	strmid(News[hContact1], string1, 0, strlen(string1), 255);
	strmid(News[hContact2], string1, 0, strlen(string1), 255);
	strmid(News[hContact3], string1, 0, strlen(string1), 255);
	strmid(News[hContact4], string1, 0, strlen(string1), 255);
	strmid(News[hContact5], string1, 0, strlen(string1), 255);
	PlayerHaul[78][pCapasity] = 100;
	PlayerHaul[79][pCapasity] = 100;
	PlayerHaul[80][pCapasity] = 50;
	PlayerHaul[81][pCapasity] = 50;
	PlayerHaul[128][pCapasity] = 300;
	PlayerHaul[129][pCapasity] = 300;
	PlayerHaul[130][pCapasity] = 300;

	format(motd, sizeof(motd), "Witaj na serwerze Mrucznik Role Play.");
	gettime(ghour, gminute, gsecond);
    GLOB_LastHour=ghour;
	FixHour(ghour);
	ghour = shifthour;
	if(!realtime)
	{
		SetWorldTime(wtime);
	}
    SetWeatherEx(3);
	AllowInteriorWeapons(1);
	ShowPlayerMarkers(0);
	DisableInteriorEnterExits();
	EnableStuntBonusForAll(0);
	ManualVehicleEngineAndLights();
	// CreatedCars check
	for(new i = 0; i < sizeof(CreatedCars); i++)
	{
	    CreatedCars[i] = 0;
	}

	// Skiny graczy (wybieralka)
	for(new i = 0; i <= sizeof(Peds)-1; i++)
	{
		AddPlayerClass(Peds[i][0],1958.3783,1343.1572,1100.3746,269.1425,-1,-1,-1,-1,-1,-1);
	}

	if (realtime)
	{
		new tmphour, tmpminute, tmpsecond;
		gettime(tmphour, tmpminute, tmpsecond);
		SetWorldTime(tmphour);
	}
	//timery
    SetTimer("MainTimer", 1000, true);
    //SetTimer("MySQL_Refresh", 15000, true);
	//SetTimer("JednaSekundaTimer", 1000, true);//1 sekunda timer
    //SetTimer("GangZone_Process", 1750, true);//OnPlayerEnterGangZone / OnPlayerLeaveGangZone
	//SetTimer("SyncUp", 60000, 1);//1min
	//SetTimer("SetPlayerUnjail", 1000, 1);//1sek - wywaliÊ
	//SetTimer("CarCheck", 30000, 1);//30sek - wywaliÊ
	//SetTimer("CustomPickups", 2000, 1);//2sek - wywaliÊ
	//SetTimer("Spectator", 2000, 1);//2sek - wywaliÊ
	//SetTimer("IdleKick", idletime, 1);//ildetime sek
	//SetTimer("Production", 300000, 1); //5 mins (300 000)
    //SetTimer("AccountSave", 900000, 1); //15min acc save
	//SetTimer("SaveAccounts", 1800000, 1); //30 mins every account saved
	//SetTimer("CheckGas", RunOutTime, 1);//RunOutTime sek - ???
    //SetTimer("VehicleUpdate", 3000, 1); //3s anty wybuch, plamy
    //SetTimer("BBD_Timer", 3500, 1); //Boombox system

    for(new i=0;i<MAX_VEHICLES;i++)
    {
        Blink[i][0] = -1;
        Blink[i][1] = -1;
        Blink[i][2] = -1;
        Blink[i][3] = -1;
    }
    SetTimer("B_TrailerCheck", 1000, 1);

    for(new v = 0; v < CAR_End+1; v++)
	{
		VehicleUID[v][vDist] = 500.000;
		VehicleUID[v][vUID] = 0;
		SetVehicleNumberPlate(v, "{1F9F06}M-RP");
	}
    print("GameMode init - done!");
    //SendRconCommand("reloadfs MRP/mrpshop");
    //SendRconCommand("reloadfs MRP/mrpattach");
	#if DEBUG == 1
		printf("OnGameModeInit - end");
	#endif
	return 1;
}
//koniec OnGameModeInit();

public OnGameModeExit()
{
	#if DEBUG == 1
		printf("OnGameModeExit - begin");
	#endif
	//AFK timer
	for(new i; i<MAX_PLAYERS; i++)
	{
		if(afk_timer[i] != -1)
			KillTimer(afk_timer[i]);
	}
    for(new i=0;i<MAX_ORG;i++)
    {
        orgSave(i, ORG_SAVE_TYPE_BASIC);
        orgSave(i, ORG_SAVE_TYPE_DESC);
    }
    for(new i=0;i<MAX_FRAC;i++)
    {
        Sejf_Save(i);
        if(RANG_ApplyChanges[0][i]) EDIT_SaveRangs(0, i);
    }
    for(new i=0;i<MAX_ORG;i++)
    {
        SejfR_Save(i);
        if(RANG_ApplyChanges[1][i]) EDIT_SaveRangs(1, i);
    }
    UnloadTXD();
    Patrol_Unload();
    TJD_Exit();
    for(new i=Zone_Points[0];i<=Zone_Points[1];i++)
    {
        GangZoneDestroy(i);
    }
    for(new i=0;i<MAX_VEHICLES;i++) DisableCarBlinking(i);
	for(new i = 0; i < MAX_PLAYERS; i++)
    {
        PlayerTextDrawDestroy(i, gCurrentPageTextDrawId[i]);
        PlayerTextDrawDestroy(i, gHeaderTextDrawId[i]);
        PlayerTextDrawDestroy(i, gBackgroundTextDrawId[i]);
        PlayerTextDrawDestroy(i, gNextButtonTextDrawId[i]);
        PlayerTextDrawDestroy(i, gPrevButtonTextDrawId[i]);

        INT_AirTowerLS_Exit(i, true, true);
    }
    foreach(Player, i)
    {
        if(noclipdata[i][cameramode] == CAMERA_MODE_FLY) CancelFlyMode(i);
        MruMySQL_SaveAccount(i, true, true);
    }
    GLOBAL_EXIT = true;
	DOF2_Exit();
    print("Serwer zostaje wy≥πczony.");
	#if DEBUG == 1
		printf("OnGameModeExit - end");
	#endif
	return 1;
}

PayDay()
{
	new string[128], account,interest,playername2[MAX_PLAYER_NAME],
        tmpintrate, checks, ebill;

	foreach(Player, i)
	{
		if(IsPlayerConnected(i))
		{
		    if(PlayerInfo[i][pLevel] > 0)
		    {
			    if(MoneyMessage[i]==1)
				{
				    SendClientMessage(i, COLOR_LIGHTRED, "Nie sp≥aci≥eú d≥ugu, wierzyciele nas≥ali na ciebie PolicjÍ !");
					PoziomPoszukiwania[i] += 2;
					SetPlayerCriminal(i,INVALID_PLAYER_ID, "Niesp≥acanie d≥ugu");
				}
				GetPlayerName(i, playername2, sizeof(playername2));
				account = PlayerInfo[i][pAccount];

				if (PlayerInfo[i][pDom] != 0)
				{
				    if(PlayerInfo[i][pDonateRank] > 0) { tmpintrate = intrate+4; }
					else { tmpintrate = intrate+2; }//HouseInfo[key][hLevel]
				}
				else
				{
				    if(PlayerInfo[i][pDonateRank] > 0) { tmpintrate = 3; }
					else { tmpintrate = 1; }
				}
				if(PlayerInfo[i][pPayDay] >= 5)
				{
				    if(PlayerInfo[i][pAdmin] >= 1)
				    {
				        format(string, sizeof(string), "Admini/%s.ini", playername2);
				        dini_IntSet(string, "Godziny_Online", dini_Int(string, "Godziny_Online")+1 );
				    }
				    else if (PlayerInfo[i][pZG] >= 1)
				    {
				        format(string, sizeof(string), "Zaufani/%s.ini", playername2);
				        dini_IntSet(string, "Godziny_Online", dini_Int(string, "Godziny_Online")+1 );
				    }
				    Tax += TaxValue;//Should work for every player online
				    PlayerInfo[i][pAccount] -= TaxValue;
					checks = PlayerInfo[i][pPayCheck];
				    ebill = (PlayerInfo[i][pAccount]/10000)*(PlayerInfo[i][pLevel]);
				    ConsumingMoney[i] = 1;
				    DajKase(i, checks);
				    if(PlayerInfo[i][pAccount] > 0)
				    {
				    	PlayerInfo[i][pAccount] -= ebill;
					}
					else
					{
					    ebill = 0;
					}
					interest = (PlayerInfo[i][pAccount]/1000)*(tmpintrate);
					PlayerInfo[i][pExp]++;
					PlayerPlayMusic(i);
					if(PlayerInfo[i][pAccount] <= 100000000)
					{
						PlayerInfo[i][pAccount] = account+interest;
					}
					SendClientMessage(i, COLOR_WHITE, "|___ STAN KONTA ___|");
					format(string, sizeof(string), "  Wyp≥ata: $%d   Podatek: -$%d", checks, TaxValue);
					SendClientMessage(i, COLOR_GRAD1, string);
					if(PlayerInfo[i][pDom] != 0 || PlayerInfo[i][pPbiskey] != 255)
					{
					    format(string, sizeof(string), "  Rachunek za prπd: -$%d", ebill);
						SendClientMessage(i, COLOR_GRAD1, string);
					}
					format(string, sizeof(string), "  Stan konta: $%d", account);
					SendClientMessage(i, COLOR_GRAD1, string);
					if(PlayerInfo[i][pAccount] <= 100000000)
					{
						format(string, sizeof(string), "  Odestki: 0.%d procent",tmpintrate);
						SendClientMessage(i, COLOR_GRAD2, string);
						format(string, sizeof(string), "  Zysk z odsetek $%d", interest);
						SendClientMessage(i, COLOR_GRAD3, string);
					}
					else
					{
					    format(string, sizeof(string), "  Podatek dochodowy: 0.0 procent");
						SendClientMessage(i, COLOR_GRAD2, string);
						format(string, sizeof(string), "  Strata z podatku $0");
						SendClientMessage(i, COLOR_GRAD3, string);
					}
					SendClientMessage(i, COLOR_GRAD4, "|--------------------------------------|");
					format(string, sizeof(string), "  Nowy Stan Konta: $%d", PlayerInfo[i][pAccount]);
					SendClientMessage(i, COLOR_GRAD5, string);
					format(string, sizeof(string), "  Wynajem: -$%d", Dom[PlayerInfo[i][pWynajem]][hCenaWynajmu]);
					SendClientMessage(i, COLOR_GRAD5, string);
					format(string, sizeof(string), "~y~Wyplata");
					GameTextForPlayer(i, string, 5000, 1);
					PlayerInfo[i][pPayDay] = 0;
					PlayerInfo[i][pPayCheck] = 0;
					PlayerInfo[i][pConnectTime] += 1;
                    MRP_PremiumHours[i]++;
					if(PlayerInfo[i][pBP] >= 1)
					{
					    PlayerInfo[i][pBP]--;
					}
					if(kaska[i] >= 10000000 && PlayerInfo[i][pLevel] <= 2 || PlayerInfo[i][pAccount] >= 10000000 && PlayerInfo[i][pLevel] <= 2)
					{
						MruMySQL_Banuj(i, "10MLN i 1 lvl");
						format(string, sizeof(string), "%s zostal zbanowany za 10mln i 1 lvl", playername2);
						BanLog(string);
						KickEx(i);
					}
					if(PlayerInfo[i][pDonateRank] > 0)
					{
					    PlayerInfo[i][pPayDayHad] += 1;
					    if(PlayerInfo[i][pPayDayHad] >= 5)
					    {
					        PlayerInfo[i][pExp]++;
					        PlayerInfo[i][pPayDayHad] = 0;
					    }
					}
     				if(PoziomPoszukiwania[i] >= 10)
					{
						PoziomPoszukiwania[i] = 9;
					}
					else if(PoziomPoszukiwania[i] == 0)
					{
                    	PoziomPoszukiwania[i] = 0;
                    }
                    else
					{
						PoziomPoszukiwania[i] -= 1;
						format(string, sizeof(string), "  Aktualny poziom poszukiwania to %d", PoziomPoszukiwania[i]);
						SendClientMessage(i, COLOR_WHITE, string);
					}

				}
				else
				{
				    SendClientMessage(i, COLOR_LIGHTRED, "* Nie grasz wystarczajπco d≥ugo, aby dostaÊ wyp≥atÍ.");
				}
			}
		}
	}
    printf("-> Updating GangZones");
    Zone_GangUpdate(true);
    printf("-> Removing Houses MapIcons");
	for(new i; i<=dini_Int("Domy/NRD.ini", "NrDomow"); i++)
	{
		DestroyDynamicMapIcon(Dom[i][hIkonka]);
	}
	new hour,minuite,second;
	new rand = random(80);
	gettime(hour,minuite,second);
    FixHour(hour);
	if(10 <= shifthour <= 22)
	{
	 	if(rand == 0) rand = 1;
        printf("-> Starting lotto");
	  	Lotto(rand);
	}
	SetWeatherEx(2+random(19));
  	SendClientMessageToAll(COLOR_YELLOW, "Odliczanie do respawnu rozpoczÍte");
	BroadCast(COLOR_PANICRED, "Uwaga! Za 20 sekund nastπpi respawn nieuøywanych pojazdÛw !");
    printf("-> Doing respawn");
	CountDown();
	SendRconCommand("reloadlog");
	SendRconCommand("reloadbans");
	if(shifthour == 3)
	{
	    SendClientMessageToAll(COLOR_YELLOW, "Trwa aktualizacja systemu domÛw, czas na laga");
	    for(new h; h <= dini_Int("Domy/NRD.ini", "NrDomow"); h++)
	    {
			Dom[h][hData_DD] ++;
			if(Dom[h][hData_DD] >= 30)
			{
			    new domex[128];
			    ZlomowanieDomu(9999, h);
				format(domex, sizeof(domex), "Dom nr %d zostal zezlomowany z powodu uplywu czasu");
			    PayLog(domex);
			}
	    }
		ZapiszDomy();
	}
	else if(shifthour == 4)
	{
	    foreach(Player, i)
		{
			Kick(i);
		}
	    ZapiszDomy();
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST•PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST•PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST•PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST•PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST•PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST•PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST•PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST•PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST•PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST•PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST•PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST•PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST•PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST•PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST•PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST•PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST•PI RESTART SERWERA!!!!");
	    SendClientMessageToAll(COLOR_YELLOW, "UWAGA!! ZARAZ NAST•PI RESTART SERWERA!!!!");
        SendClientMessageToAll(COLOR_YELLOW, "RESET");
        SendRconCommand("gmx");
	}
	return 1;
}

public OnPlayerUpdate(playerid)
{
	/*#if DEBUG == 1
		printf("%s[%d] OnPlayerUpdate - begin", GetNick(playerid), playerid);
	#endif*/
    if(gPlayerLogged[playerid] == 0)
    {
		printf("Problem z Update, nick: %s", GetNick(playerid));
        KickEx(playerid);
    }

	//Anty BH PAèDZIOCH
	if(GetPVarInt(playerid, "Jumping") == 1)
	{
		new Float:x, Float:y, Float:z;
		GetPlayerVelocity(playerid, x, y, z);
		if(z > 0.05)
		{
			SetPlayerVelocity(playerid, x*0.4, y*0.4, z);
			SetPVarInt(playerid, "Jumping", -1);
		}
	}

    new veh = GetPlayerVehicleID(playerid);
    if(veh != 0)
    {
        new model = GetVehicleModel(veh);
        if(model == 425 || model == 432)
        {
            new keys, ud, lr;
            GetPlayerKeys(playerid, keys, ud, lr);
            if((keys & KEY_FIRE))
			{
				#if DEBUG == 1
					printf("%s[%d] OnPlayerUpdate - end", GetNick(playerid), playerid);
				#endif
				return 0; //desycn missile
			}
        }
        else if(model == 520)
        {
            new keys, ud, lr;
            GetPlayerKeys(playerid, keys, ud, lr);
            if((keys & KEY_ACTION))
			{
				#if DEBUG == 1
					printf("%s[%d] OnPlayerUpdate - end", GetNick(playerid), playerid);
				#endif
				return 0; //desycn hydra missile
			}
        }
    }
    //
    if(noclipdata[playerid][cameramode] == CAMERA_MODE_FLY)
	{
		new keys,ud,lr;
		GetPlayerKeys(playerid,keys,ud,lr);

		if(noclipdata[playerid][mode] && (GetTickCount() - noclipdata[playerid][lastmove] > 100))
		{
		    // If the last move was > 100ms ago, process moving the object the players camera is attached to
		    MoveCamera(playerid);
		}

		// Is the players current key state different than their last keystate?
		if(noclipdata[playerid][udold] != ud || noclipdata[playerid][lrold] != lr)
		{
			if((noclipdata[playerid][udold] != 0 || noclipdata[playerid][lrold] != 0) && ud == 0 && lr == 0)
			{   // All keys have been released, stop the object the camera is attached to and reset the acceleration multiplier
				StopPlayerObject(playerid, noclipdata[playerid][flyobject]);
                if(noclipdata[playerid][fireobject] != 0) StopObject(noclipdata[playerid][fireobject]);
				noclipdata[playerid][mode]      = 0;
				noclipdata[playerid][accelmul]  = 0.0;
			}
			else
			{   // Indicates a new key has been pressed

			    // Get the direction the player wants to move as indicated by the keys
				noclipdata[playerid][mode] = GetMoveDirectionFromKeys(ud, lr);

				// Process moving the object the players camera is attached to
				MoveCamera(playerid);
			}
		}
		noclipdata[playerid][udold] = ud; noclipdata[playerid][lrold] = lr; // Store current keys pressed for comparison next update
		#if DEBUG == 1
			printf("%s[%d] OnPlayerUpdate - end", GetNick(playerid), playerid);
		#endif
		return 0;
	}
    if(GetPVarInt(playerid, "oil_clear") == 1)
    {
        new keys, ud,lr;
        GetPlayerKeys(playerid, keys, ud, lr);
        if(ud == KEY_DOWN) Oil_OnPlayerPress(playerid, KEY_DOWN);
        else if(ud == KEY_UP) Oil_OnPlayerPress(playerid, KEY_UP);
        if(lr == KEY_RIGHT) Oil_OnPlayerPress(playerid, KEY_RIGHT*2);
        else if(lr == KEY_LEFT) Oil_OnPlayerPress(playerid, KEY_LEFT*2);
    }
	/*#if DEBUG == 1
		printf("%s[%d] OnPlayerUpdate - end", GetNick(playerid), playerid);
	#endif*/
	return 1;
}

OnPlayerRegister(playerid, password[])
{
	if(IsPlayerConnected(playerid))
	{
        new string[128];
        if(CheckAlfaNumeric(password))
        {
            format(string, 128, "Twoje has≥o posiada≥o nie-alfanumeryczne znaki - nowe has≥o: %s", password);
            SendClientMessage(playerid, COLOR_PANICRED, string);
            SendClientMessage(playerid, COLOR_PANICRED, "Zalecamy zmieniÊ has≥o poprzez /zmienhaslo");
            SendClientMessage(playerid, COLOR_PANICRED, "Zalecamy zmieniÊ has≥o poprzez /zmienhaslo");
            SendClientMessage(playerid, COLOR_PANICRED, "Zalecamy zmieniÊ has≥o poprzez /zmienhaslo");
            SendClientMessage(playerid, COLOR_PANICRED, "Zalecamy zmieniÊ has≥o poprzez /zmienhaslo");
            SendClientMessage(playerid, COLOR_PANICRED, string);
            SendClientMessage(playerid, COLOR_PANICRED, "Zalecamy zmieniÊ has≥o poprzez /zmienhaslo");
        }
		MruMySQL_CreateAccount(playerid, password);
		OnPlayerLogin(playerid, password);
	}
	return 1;
}

OnPlayerLogin(playerid, password[])
{
	#if DEBUG == 1
		printf("%s[%d] OnPlayerLogin - begin", GetNick(playerid), playerid);
	#endif
    new nick[MAX_PLAYER_NAME], string[256], oldpass[64];
	GetPlayerName(playerid, nick, sizeof(nick));
    new pass[64];
    format(pass, 64, "%s", MruMySQL_ReturnPassword(nick));
    new bool:UseMYSQL=false, bool:UseDINI=false;

    if(strlen(pass) > 5) UseMYSQL=true;
    else
    {
        format(oldpass, 64, "%s", password);
        Encrypt(oldpass);

        new string2[128];
    	new playername2[MAX_PLAYER_NAME];
        GetPlayerName(playerid, playername2, sizeof(playername2));
    	format(string2, sizeof(string2), "%s.ini", playername2);
    	new File: UserFile = fopen(string2, io_read);
    	if ( UserFile )
    	{
    	    new PassData[256];
    	    new keytmp[256], valtmp[256];
    	    fread( UserFile , PassData , sizeof( PassData ) );
    	    keytmp = ini_GetKey( PassData );
    	    if( strfind( keytmp , "Key" , true ) != -1 )
    		{
    			valtmp = ini_GetValue( PassData );
                format(PlayerInfo[playerid][pKey], 32, "%s", valtmp);
                strdel(PlayerInfo[playerid][pKey], strlen(PlayerInfo[playerid][pKey])-1, strlen(PlayerInfo[playerid][pKey]));
                if(strcmp(PlayerInfo[playerid][pKey],oldpass, true ) == 0) UseDINI = true;
    		}
            fclose(UserFile);
        }
        //Koniec dini
    }
    if(UseDINI)
    {
        if(CheckAlfaNumeric(password))
        {
            format(string, 128, "Twoje has≥o posiada≥o nie-alfanumeryczne znaki - nowe has≥o: %s", password);
            SendClientMessage(playerid, COLOR_PANICRED, string);
            SendClientMessage(playerid, COLOR_PANICRED, string);
            SendClientMessage(playerid, COLOR_PANICRED, string);
            SendClientMessage(playerid, COLOR_PANICRED, string);
            SendClientMessage(playerid, COLOR_PANICRED, string);
            SendClientMessage(playerid, COLOR_PANICRED, string);
            SendClientMessage(playerid, COLOR_PANICRED, "Zalecamy zmieniÊ has≥o poprzez /zmienhaslo");
        }

        new escapepass[64];
        format(escapepass, 64, "%s", password);
        mysql_real_escape_string(password,escapepass);
        if(strcmp(password,escapepass) != 0)  //Anty non-alpha
        {
            SendClientMessage(playerid, COLOR_RED, "UWAGA! Twoje has≥o zosta≥o zmienione, gdyø zawiera≥o niepoprawne znaki!!");
            format(string, 128, "Nowe has≥o: %s", escapepass);
            SendClientMessage(playerid, COLOR_RED, string);
            SendClientMessage(playerid, COLOR_PANICRED, string);
            SendClientMessage(playerid, COLOR_PANICRED, string);
            SendClientMessage(playerid, COLOR_PANICRED, string);
            format(password, 64, "%s", escapepass);
            printf("Zmieniono has≥o dla %s", GetNick(playerid));
        }
    }
	if((UseMYSQL && strcmp(pass,MD5_Hash(password), true ) == 0) || UseDINI)
	{//poprawne has≥o
        MruMySQL_KonwertujBana(playerid);
        if(MruMySQL_SprawdzBany(playerid)) return KickEx(playerid);
		//Konwertowanie kont:
        format(PlayerInfo[playerid][pKey], 64, "%s",MD5_Hash(password));
        new result = MruMySQL_ConvertAccount(playerid);
		if( result == 1 )
		{
			SendClientMessage(playerid, COLOR_WHITE, "[SERVER] {33CCFF}Twoje konto zosta≥o pomyúlnie przekonwertowane. Øyczymy mi≥ej gry.");
            format(string, 128, "UPDATE `mru_konta` SET `FMember`=0 WHERE `Nick`='%s'", GetNick(playerid));
            mysql_query(string);
        }
        else if(result == -1)
        {
            //SendClientMessage(playerid, COLOR_WHITE, "[SERVER] {33CCFF}Twoje konto jest aktualne w MySQL.");
        }
        else if(result == -999)
		{
			SendClientMessage(playerid, COLOR_WHITE, "[SERVER] {FF0000}Sprawdü wielkosÊ znakÛw, podobny nick istnieje.");
			KickEx(playerid);
			return 1;
		}
		else if(result == 0)
		{
			SendClientMessage(playerid, COLOR_WHITE, "[SERVER] {FF0000}B≥πd przy konwersji konta! Zg≥oú okolicznoúci na forum.");
			KickEx(playerid);
			return 1;
		}

		//----------------------------
		//£adowanie konta i zmiennych:
		//----------------------------

		if( !MruMySQL_LoadAcocount(playerid) )
		{
			SendClientMessage(playerid, COLOR_WHITE, "[SERVER] {FF0000}Krytyczny b≥πd konta. Zg≥oú zaistnia≥π sytuacjÍ na forum.");
			printf("Nick %s posiada blad krytyczny konta (pusty rekord?)", nick);
			KickEx(playerid);
			return 1;
		}

		//Sprawdzanie blockÛw:
		if(PlayerInfo[playerid][pBlock] == 1)
		{
			SendClientMessage(playerid, COLOR_WHITE, "[SERVER] {FF0000}To konto jest zablokowane, nie moøesz na nim graÊ.");
			SendClientMessage(playerid, COLOR_WHITE, "[SERVER] Jeúli uwaøasz, øe konto zosta≥o zablokowane nies≥usznie napisz apelacje na: {33CCFF}www.Mrucznik-RP.pl");
			KickEx(playerid);
			return 1;
		}
        else if(PlayerInfo[playerid][pBlock] == 2 || PlayerInfo[playerid][pCK] == 1)
		{
			SendClientMessage(playerid, COLOR_WHITE, "[SERVER] {FF0000}Ta postaÊ jest uúmiercona, nie moøesz na niej graÊ.");
			KickEx(playerid);
			return 1;
		}

		//Nadawanie pieniÍdzy:
		ResetujKase(playerid);
		DajKase(playerid,PlayerInfo[playerid][pCash]);

		//Ustawianie na zalogowany:
		gPlayerLogged[playerid] = 1;

        Car_LoadForPlayer(playerid); //System aut

		//Powitanie:
		format(string, sizeof(string), "Witaj, %s!",nick);
		SendClientMessage(playerid, COLOR_WHITE,string);
		printf("%s has logged in.",nick);
		if (PlayerInfo[playerid][pDonateRank] > 0)
		{
			SendClientMessage(playerid, COLOR_WHITE,"Jesteú posiadaczem {E2BA1B}Konta Premium.");
		}
	}
	else
	{//z≥e has≥o
		SendClientMessage(playerid, COLOR_WHITE, "[SERVER] {33CCFF}Z≥e has≥o.");
		format(string, sizeof(string), "Nick %s jest zarejestrowany.\nZaloguj siÍ wpisujπc w okienko poniøej has≥o.\nJeøli nie znasz has≥a do tego konta, wejdü pod innym nickiem", nick);
		ShowPlayerDialogEx(playerid, 230, DIALOG_STYLE_PASSWORD, "Logowanie", string, "Zaloguj", "Wyjdü");
		gPlayerLogTries[playerid] += 1;
		if(gPlayerLogTries[playerid] == 3)
		{
			SendClientMessage(playerid, COLOR_WHITE, "[SERVER] {33CCFF}Z≥e has≥o. Zostajesz zkickowany.");
			ShowPlayerDialogEx(playerid, 239, DIALOG_STYLE_MSGBOX, "Kick", "{FF0000}Dosta≥eú kicka za wpisanie z≥ego has≥a 3 razy pod rzπd!", "Wyjdü", "");
			KickEx(playerid);
		}
		return 1;
	}

	//Nadawanie poczπtkowych itemÛw po rejestracji:
	if(PlayerInfo[playerid][pReg] == 0)
	{
		PlayerInfo[playerid][pLevel] = 1;
		PlayerInfo[playerid][pSHealth] = 0.0;
		PlayerInfo[playerid][pHealth] = 50.0;
		PlayerInfo[playerid][pPos_x] = 2246.6;
		PlayerInfo[playerid][pPos_y] = -1161.9;
		PlayerInfo[playerid][pPos_z] = 1029.7;
		PlayerInfo[playerid][pInt] = 0;
		PlayerInfo[playerid][pLocal] = 255;
		PlayerInfo[playerid][pTeam] = 3;
		PlayerInfo[playerid][pModel] = 136;
		PlayerInfo[playerid][pPnumber] = 0;
		PlayerInfo[playerid][pDom] = 0;
		PlayerInfo[playerid][pPbiskey] = 255;
		PlayerInfo[playerid][pAccount] = 5000;
		PlayerInfo[playerid][pReg] = 1;
		PlayerInfo[playerid][pDowod] = 0;
		DajKase(playerid, 5000);
	}

	//Filtry na konto:
	/*if(dini_Exists("Filtry.ini"))
	{
		new filtr;
		new filtr_ip[64];
		new filtr_nick[64];
		new ip[16];
		GetPlayerIp(playerid, ip, sizeof(ip));
		for(new i = 0; i < dini_Int("Filtry.ini", "Liczba"); i++)
		{
			format(filtr_ip, sizeof(filtr_ip), "IP_%d", i);
			if(strcmp(ip, dini_Get("Filtry.ini", filtr_ip), true) == 0)
			{
				format(filtr_nick, sizeof(filtr_nick), "Nick_%d", i);
				if(strcmp(nick, dini_Get("Filtry.ini", filtr_nick), true) == 0)
				{
					SendClientMessage(playerid, COLOR_WHITE,"SERVER: Jesteú posiadaczem filtru na konto.");
					filtr = 0;
					break;
				}
				else
				{
					filtr++;
				}
			}
		}
		if(filtr != 0)
		{
			SendClientMessage(playerid, COLOR_WHITE,"SERVER: Zosta≥eú zkickowany, powÛd: Filtr na konto.");
			SendClientMessage(playerid, COLOR_WHITE,"SERVER: Aby go zdjπÊ napisz na forum www.Mrucznik-RP.pl");
			KickEx(playerid);
			return 1;
		}
	}
	else
	{
		dini_Create("Filtry.ini");
		dini_IntSet("Filtry.ini", "Liczba", 0);
	}*/

    if(PlayerInfo[playerid][pBW] == 60 || PlayerInfo[playerid][pBW] == 122 || PlayerInfo[playerid][pBW] == 123 || PlayerInfo[playerid][pBW] > 600)
    {
        PlayerInfo[playerid][pBW] = 0;
    }

	//Przywracanie Poziomu Poszukiwania
        //Punkty karne
    if (PlayerInfo[playerid][pWL] >= 10000)
    {
        string="\0";
        new lPunkty[8];
        PlayerInfo[playerid][pWL]-=10000;
        valstr(string, PlayerInfo[playerid][pWL]);
        if(strlen(string) == 3) strmid(lPunkty, string, 0, 1);
        else if(strlen(string) == 4) strmid(lPunkty, string, 0, 2);
        PlayerInfo[playerid][pPK] = strval(lPunkty);
        if(strlen(string) == 3) strmid(lPunkty, string, 1, 3);
        else if(strlen(string) == 4) strmid(lPunkty, string, 2, 4);
        PlayerInfo[playerid][pWL] = strval(lPunkty);
    }

	if (PlayerInfo[playerid][pWL] >= 1)
	{
        if(PlayerInfo[playerid][pWL] > 100) PlayerInfo[playerid][pWL] = 0;
        else
        {
    		PoziomPoszukiwania[playerid] = clamp(PlayerInfo[playerid][pWL], 0, 10);
    		format(string, sizeof(string), "TwÛj poziom poszukiwania zosta≥ przywrÛcony do %d.",PlayerInfo[playerid][pWL]);
    		SendClientMessage(playerid, COLOR_WHITE,string);
        }
	}

	//Niwelacje hajsu i matsÛw w zaleønoúci od lvl:
	Niwelacje(playerid);
    if(PlayerInfo[playerid][pWarns] >= 3)
    {
        MruMySQL_Banuj(playerid, "Limit warnÛw (3)");
        KickEx(playerid);
        return 1;
    }
    else if(PlayerInfo[playerid][pWarns] < 0) PlayerInfo[playerid][pWarns] = 0;


    MRP_LoadPremium(playerid);

	//Odbugowywanie domÛw:
    if(PlayerInfo[playerid][pDom] != 0)
    {
    	NaprawSpojnoscWlascicielaDomu(playerid);
		Dom[PlayerInfo[playerid][pDom]][hData_DD] = 0;
    	if(Dom[PlayerInfo[playerid][pDom]][hPDW] < 0) Dom[PlayerInfo[playerid][pDom]][hPDW] = 0;//naprawa wynajmu
    	if(Dom[PlayerInfo[playerid][pDom]][hPW] < 0) Dom[PlayerInfo[playerid][pDom]][hPW] = 0;
	}

	//Spawnowanie gracza:
	SetTimerEx("AntySB", 5000, 0, "d", playerid); //by nie kickowa≥o timer broni
	AntySpawnBroni[playerid] = 5;
	GUIExit[playerid] = 0;
	SetPlayerVirtualWorld(playerid, 0);

    Zone_Sync(playerid);
    if(strlen(ServerInfo) > 1) TextDrawShowForPlayer(playerid, TXD_Info); //Show info

    //Sync org
    if(GetPlayerOrg(playerid) == 255) PlayerInfo[playerid][pOrg] = 0;

    //Info o rodzinie:
	if(GetPlayerOrg(playerid) != 0)
	{
        gPlayerOrg[playerid] = orgID(PlayerInfo[playerid][pOrg]);
        if(PlayerInfo[playerid][pRank] >= 1000) gPlayerOrgLeader[playerid] = true, PlayerInfo[playerid][pRank]-=1000;

        if(gPlayerOrg[playerid] == 0xFFFF) SendClientMessage(playerid, COLOR_PANICRED, "B£•D PRZYPISANIA TWOJEJ RODZINY!!!");
        else if(strlen(OrgInfo[gPlayerOrg[playerid]][o_Motd]) > 3)
        {
    		format(string, sizeof(string), "Rodzina MOTD: %s.", OrgInfo[gPlayerOrg[playerid]][o_Motd]);
    		SendClientMessage(playerid, COLOR_YELLOW, string);
        }
        if(PlayerInfo[playerid][pRank] < 0 || PlayerInfo[playerid][pRank] > 9) PlayerInfo[playerid][pRank] = 9;
	}

    //Konwersja pojazdÛw:
    CONVERT_PlayerCar(playerid);

    MRP_PlayerLog(playerid);

	//Teleportacja do poprzedniej pozycji:
	if (PlayerInfo[playerid][pTut] == 1)
	{
        if(PlayerInfo[playerid][pAdmin] > 0 || PlayerInfo[playerid][pNewAP] > 0 || PlayerInfo[playerid][pZG] > 0)
        {
            if(PlayerInfo[playerid][pZG] > 0 || PlayerInfo[playerid][pNewAP] > 0)
            {
                SetPVarInt(playerid, "support_duty", 1);
                SendClientMessage(playerid, COLOR_GREEN, "SUPPORT: {FFFFFF}Stawiasz siÍ na s≥uøbie nowym graczom. Aby sprawdziÊ zg≥oszenia wpisz {00FF00}/tickets");
            }
            ShowPlayerDialogEx(playerid, 235, DIALOG_STYLE_INPUT, "Weryfikacja", "Logujesz siÍ jako cz≥onek administracji. Zostajesz poproszony o wpisanie w\nponiøsze pole has≥a weryfikacyjnego. PamiÍtaj, aby nie podawaÊ go nikomu!", "Weryfikuj", "Wyjdü");
        }
        else if(PlayerInfo[playerid][pJailed] == 0)
        {
    		lowcap[playerid] = 1;
    		ShowPlayerDialogEx(playerid, 1, DIALOG_STYLE_MSGBOX, "Serwer", "Czy chcesz siÍ teleportowaÊ do poprzedniej pozycji?", "TAK", "NIE");
        }
        else
        {
            SetSpawnInfo(playerid, PlayerInfo[playerid][pTeam], PlayerInfo[playerid][pModel], PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z], 1.0, -1, -1, -1, -1, -1, -1);
            SpawnPlayer(playerid);
        }
	}
    else
    {
        SetSpawnInfo(playerid, PlayerInfo[playerid][pTeam], PlayerInfo[playerid][pModel], PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z], 1.0, -1, -1, -1, -1, -1, -1);
        SpawnPlayer(playerid);
    }
	#if DEBUG == 1
		printf("%s[%d] OnPlayerLogin - end", GetNick(playerid), playerid);
	#endif
	return 1;
}

public OnPlayerKeyStateChange(playerid,newkeys,oldkeys)
{
	#if DEBUG == 1
		printf("%s[%d] OnPlayerKeyStateChange - begin", GetNick(playerid), playerid);
	#endif
    //09.06.2014
    if(Teleturniejstart == 1)
	{
	    if(IsPlayerInRangeOfPoint(playerid,2,679.1998, -1336.1652, 30.3864) || IsPlayerInRangeOfPoint(playerid,2,679.9750, -1339.5018, 30.3864) || IsPlayerInRangeOfPoint(playerid,2,678.9643, -1342.8322, 30.3864))
	    {
		    if(!IsPlayerInAnyVehicle(playerid))
		    {
		        if(GetPlayerVirtualWorld(playerid) == 21)
		        {
		            if(newkeys & KEY_SPRINT)
		            {
						if(grajacy[playerid] == 1)
						{
			                new ImieGracza[MAX_PLAYER_NAME],string[64];
							GetPlayerName(playerid, ImieGracza, sizeof(ImieGracza));
							format(string, sizeof(string), "* %s naciska przycisk na stoliku",ImieGracza);
							ProxDetector(20.0, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
							Teleturniejstart = 0;
							grajacy[playerid] = 0;
							#if DEBUG == 1
								printf("%s[%d] OnPlayerKeyStateChange - end", GetNick(playerid), playerid);
							#endif
                            return 0;
						}
		            }
		        }
		    }
		}
	}
    //11.06.2014
    if(PRESSED(KEY_JUMP) && Spectate[playerid] != INVALID_PLAYER_ID)
    {
		PlayerInfo[playerid][pInt] = Unspec[playerid][sPint];
		PlayerInfo[playerid][pLocal] = Unspec[playerid][sLocal];
		SetPlayerToTeamColor(playerid);
		MedicBill[playerid] = 0;
		SetSpawnInfo(playerid, PlayerInfo[playerid][pTeam], PlayerInfo[playerid][pModel], Unspec[playerid][Coords][0], Unspec[playerid][Coords][1], Unspec[playerid][Coords][2], 10.0, -1, -1, -1, -1, -1, -1);
        Spectate[playerid] = INVALID_PLAYER_ID;
        TogglePlayerSpectating(playerid, 0);
        return 0;
    }
    //30.10
    if(HOLDING(KEY_ANALOG_UP))
    {
        new veh = GetPlayerVehicleID(playerid);
        if(veh != 0)
        {
            if(CarData[VehicleUID[veh][vUID]][c_Owner] == JOB_TRUCKER && CarData[VehicleUID[veh][vUID]][c_OwnerType] == CAR_OWNER_JOB)
            {
                if(GetVehicleModel(veh) == 530) TJD_TryPickup(playerid, veh);
            }
        }
    }
    //12.07 TRAIN HORN
    if(PRESSED(KEY_CROUCH))
    {
        if(GetPVarInt(playerid, "horn") == 0)
        {
            new veh;
            if((veh = GetPlayerVehicleID(playerid)) != 0)
            {
                if(GetVehicleModel(veh) == 538 || GetVehicleModel(veh) == 537)
                {
                    if(GetPlayerVehicleSeat(playerid) == 0)
                    {
                        SetPVarInt(playerid, "horn", 1);
                        if(TRAIN_HornTimer == 0)
                        {
                            TRAIN_HornTimer = SetTimerEx("TRAIN_DoHorn", 500, 1, "i", veh);
                            TRAIN_DoHorn(veh);
							#if DEBUG == 1
								printf("%s[%d] OnPlayerKeyStateChange - end", GetNick(playerid), playerid);
							#endif
                            return 0;
                        }
                    }
                }
            }
        }
    }
    else if(RELEASED(KEY_CROUCH))
    {
        if(GetPVarInt(playerid, "horn") == 1)
        {
            if(TRAIN_HornTimer != 0) KillTimer(TRAIN_HornTimer);
            TRAIN_HornTimer=0;
            SetPVarInt(playerid, "horn", 0);

			foreach(Player, i)
            {
                if(GetPVarInt(i, "train-horn") == 1)
                {
                    PlayerPlaySound(i, 8199, 0.0, 0.0, 0.0);
                    SetPVarInt(i, "train-horn", 0);
                }
            }
			#if DEBUG == 1
				printf("%s[%d] OnPlayerKeyStateChange - end", GetNick(playerid), playerid);
			#endif
            return 0;
        }
    }
    //BLINK
    new veh = GetPlayerVehicleID(playerid);
    if(veh != 0)
    {
        if(GetPlayerVehicleSeat(playerid) == 0)
        {
            #if BLINK_ALLOW_EMERGENCY == 1
            if(PRESSED(KEY_LOOK_BEHIND))
            {
                if(!IsCarBlinking(veh)) SetCarBlinking(veh, 2), SetPVarInt(playerid, "blink-car", veh);
    		    else DisableCarBlinking(veh);
            }
            #endif
        	if(PRESSED(KEY_LOOK_LEFT))
            {
    			if(!IsCarBlinking(veh)) SetCarBlinking(veh, 0), SetPVarInt(playerid, "blink-car", veh);
    		    else DisableCarBlinking(veh);
        	}
        	else if(PRESSED(KEY_LOOK_RIGHT))
            {
    		    if(!IsCarBlinking(veh)) SetCarBlinking(veh, 1), SetPVarInt(playerid, "blink-car", veh);
    		    else DisableCarBlinking(veh);
        	}

            if(IsCarBlinking(veh))
            {
                new Float:a, Float:b = BlinkR[veh];
                GetVehicleZAngle(veh, a);

                if(BlinkSide[veh] == 0)
                {
                    b+=BLINK_TURN_ANGLE;
                    if(b > 360.0) b -=360.0;
                    if(a < b-180) a = a+360;
                	if(b < a-180) b = b+360;

                    if(a > b) DisableCarBlinking(veh);
                }
                else if(BlinkSide[veh] == 1)
                {
                    b-=BLINK_TURN_ANGLE;
                    if(b < 0.0) b = 360.0 + b;
                    if(a < b-180) a = a+360;
                	if(b < a-180) b = b+360;

                    if(a < b) DisableCarBlinking(veh);
                }
            }
        }
    }
    //Kolczatki
    if(IsPlayerInAnyVehicle(playerid))
    {
        if(IsACop(playerid) && !KolDelay[veh])
        {
            if(IsACopCar(veh) && !IsABike(veh) && !IsAPlane(veh) && !IsABoat(veh))
            {
                if(PRESSED(KEY_ANALOG_DOWN)) //2
                {
                    new id = Kolczatka_GetID();
                    if(id != -1)
                    {
                        new Float:h, Float:a, Float:b, Float:x, Float:y, Float:z, vehid = GetPlayerVehicleID(playerid), Float:rot;
                        GetVehiclePos(vehid, x, y, z);
                        GetVehicleZAngle(vehid, rot);
                        x-=2.0*floatsin(-rot, degrees);
                        y-=2.0*floatcos(-rot, degrees);
                        GetVehicleRotation(vehid, h, a, b);
                        if(floatabs(b) > 15.0)
						{
							#if DEBUG == 1
								printf("%s[%d] OnPlayerKeyStateChange - end", GetNick(playerid), playerid);
							#endif
							return 1;
						}
                        //z -= 0.5;
                        z = (b > 0) ? (z - floatcos(b, degrees)) : (z + floatsin(b, degrees));
                        if(-10.0 <= b <= 10.0) z = (b>0) ? (z+ floatabs((b-10)/20)) : (z- ((b+10)/20));
                        KolID[id] = CreateDynamicObject(2899, x, y, z, a, b, rot-90);
                        KolTime[id] = gettime()+KOLCZATKA_CZAS;
                        KolArea[id] = CreateDynamicCylinder(x, y, z-10, z+10, 4.0);
                        KolDelay[veh] = true;
                        KolVehicle[id] = veh;
						#if DEBUG == 1
							printf("%s[%d] OnPlayerKeyStateChange - end", GetNick(playerid), playerid);
						#endif
                        return 0;
                    }
                }
            }
        }
    }

    //
	if ((newkeys==KEY_ACTION)&&(IsPlayerInAnyVehicle(playerid))&&(GetPlayerState(playerid)==PLAYER_STATE_DRIVER))
	{
		if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 525)
		{
			SendClientMessage(playerid,0x00FFFFFF, "PrÛbujesz podczepiÊ pojazd");
			new Float:pX, Float:pY, Float:pZ;
			GetPlayerPos(playerid,pX,pY,pZ);
			new Float:vX,Float:vY,Float:vZ;
			new Found=0;
			new vid=0;
			while((vid<MAX_VEHICLES)&&(!Found))
			{
				vid++;
				GetVehiclePos(vid,vX,vY,vZ);
                if(vid == 1) continue;
				if ((floatabs(pX-vX)<7.0)&&(floatabs(pY-vY)<7.0)&&(floatabs(pZ-vZ)<7.0)&&(vid!=GetPlayerVehicleID(playerid)))
				{
					Found=1;
					if (IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
						SendClientMessage(playerid,COLOR_BROWN, "Pojazd odczepiony");
                        break;
					}
					AttachTrailerToVehicle(vid,GetPlayerVehicleID(playerid));
					SendClientMessage(playerid,COLOR_BROWN, "Pojazd podczepiony");
				}
			}
			if (!Found)
			{
				SendClientMessage(playerid,COLOR_BROWN, "Nie ma w pobliøu øadnych samochodÛw.");
			}
			#if DEBUG == 1
				printf("%s[%d] OnPlayerKeyStateChange - end", GetNick(playerid), playerid);
			#endif
            return 0;
		}
	}
	if(newkeys & KEY_CROUCH && (GetPlayerState(playerid)==PLAYER_STATE_DRIVER))
	{
		if((IsACop(playerid) || IsABOR(playerid) && PlayerInfo[playerid][pRank] >= 1) && OnDuty[playerid] == 1)
		{
			veh = GetPlayerVehicleID(playerid);
			if(veh == 148 || veh == 43 || IsAKogutCar(veh))
				cmd_kogut(playerid);
		}
	}
	/*if(newkeys & KEY_NO && (GetPlayerState(playerid)==PLAYER_STATE_DRIVER))//id 131072
	{
		if(IsACop(playerid))
		{
			if(IsACopCar(GetPlayerVehicleID(playerid)))
			{
				DopalaczPD(playerid);
			}
		}
	}*/
	if(newkeys & KEY_YES && (GetPlayerState(playerid)==PLAYER_STATE_DRIVER))//id 131072
	{
		new engine, unused;
		GetVehicleParamsEx(GetPlayerVehicleID(playerid),engine , unused , unused, unused, unused, unused, unused);
		if(engine == 1)
			cmd_zgas(playerid);
		else
			cmd_odpal(playerid);
	}
	if(PRESSED(KEY_JUMP))//AntyBH
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{
		    if(AntyBH == 1)
		    {
				SetPVarInt(playerid, "Jumping", 1);
			}
		}
	}
	if(newkeys - oldkeys == 40)
	{
	    if(!IsPlayerInAnyVehicle(playerid))
	    {
		    if(WnetrzeWozu[playerid] != 0)
		    {
		        Z_WnetrzaWozu(playerid, WnetrzeWozu[playerid]);
		    }
		    else
		    {
			    for(new v; v < MAX_VEHICLES; v++)
			    {
					new model = GetVehicleModel(v);
					if(model == 484 || model == 519 || model == 553 || model == 409)
					{
		   				new Float:vehx, Float:vehy, Float:vehz;
		          		GetVehiclePos(v, vehx, vehy, vehz);
		          		if(IsPlayerInRangeOfPoint(playerid, 10.0, vehx, vehy, vehz))
		          		{
							if(VehicleUID[v][vIntLock] == 1)
			          	    {
								Do_WnetrzaWozu(playerid, v, model);
								#if DEBUG == 1
									printf("%s[%d] OnPlayerKeyStateChange - end", GetNick(playerid), playerid);
								#endif
								return 0;
							}
							else
							{
							    SendClientMessage(playerid, COLOR_GREY, "Interior jest zamkniÍty!");
								#if DEBUG == 1
									printf("%s[%d] OnPlayerKeyStateChange - end", GetNick(playerid), playerid);
								#endif
							    return 0;
							}
		          		}
					}
			    }
		   	}
		}
	}
	/*if(PRESSED(KEY_ACTION))
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
		}
	}
	if(RELEASED(KEY_ACTION))
 	{
 	    if(IsPlayerInAnyVehicle(playerid))
 	    {
 	        RemoveVehicleComponent(GetPlayerVehicleID(playerid), 1010);
 	    }
 	}*/
	if(IsPlayerInAnyVehicle(playerid))
	{
	    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	    {
		    if (newkeys & KEY_ACTION || newkeys & KEY_FIRE)
			{
			    new Vehid = GetPlayerVehicleID(playerid);
			    new ModelID[MAX_VEHICLES];
			    ModelID[Vehid] = GetVehicleModel(Vehid);
			    if( ModelID[Vehid] == 520 || ModelID[Vehid] == 432 || ModelID[Vehid] == 425)
			    {
	    			ApplyAnimation(playerid,"PED","car_hookertalk ",4.1,1,1,1,1,1,1);
	    			TogglePlayerControllable(playerid,0);
					TogglePlayerControllable(playerid,1);
				}
			}
		}
	}
    if(PRESSED(KEY_SECONDARY_ATTACK))
    {
        if(GetPlayerAnimationIndex(playerid)!=1660) SetTimerEx("VendCheck", 500, false, "d", playerid);
		#if DEBUG == 1
			printf("%s[%d] OnPlayerKeyStateChange - end", GetNick(playerid), playerid);
		#endif
        return 0;
    }
	#if DEBUG == 1
		printf("%s[%d] OnPlayerKeyStateChange - end", GetNick(playerid), playerid);
	#endif
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	#if DEBUG == 1
		printf("%s[%d] OnVehicleDeath pojazd %d - begin", GetNick(killerid), killerid, vehicleid);
	#endif
	if(GetVehicleModel(vehicleid) == 577)
	{
        foreach(Player, i)
		{
			if(PlayerInfo[i][pWsamolocieLS]==1)
			{
				SendClientMessage(i, COLOR_GREY, " Samolot rozbi≥ siÍ!");
				SetPlayerHealth(i, 0);
				PlayerInfo[i][pWsamolocieLS]=0;
				PlayerInfo[i][pWlociej]=0;
				PlayerInfo[i][pMozeskakacAT]=0;
			}
		}
		if(osoby>1)
		{
            new str[64];
            format(str, 64, "Szok! Samolot KT rozbi≥ siÍ i zginÍ≥o %d osÛb!", osoby);
			OOCNews(COLOR_LIGHTGREEN, str);
		}
	}

	//PAèDZIOCH
	if(IsAHeliModel(GetVehicleModel(vehicleid)))
	{
  		for(new i=0;i<=MAX_PLAYERS;i++)
    	{
     		if(GetPVarInt(i,"chop_id") == vehicleid && GetPVarInt(i,"roped") == 1)
       		{
         		DisablePlayerCheckpoint(i);
          		SetPVarInt(i,"roped",0);
            	DisablePlayerCheckpoint(i);
             	ClearAnimations(i);
              	TogglePlayerControllable(i,1);
               	for(new j=0;j<=ROPELENGTH;j++)
                {
                	DestroyDynamicObject(r0pes[i][j]);
                }
			}
		}
	}

    if(B_IsTrailer(vehicleid))
    {
        new veh;
        if((veh = TrailerVehicle[vehicleid]) != 0)
        {
            if(IsCarBlinking(veh))
            {
                DestroyDynamicObject(Blink[veh][1]);
                DestroyDynamicObject(Blink[veh][3]);
                Blink[veh][1] = -1;
                Blink[veh][3] = -1;
            }
        }
    }
    else DisableCarBlinking(vehicleid);

	#if DEBUG == 1
		printf("%s[%d] OnVehicleDeath pojazd %d - end", GetNick(killerid), killerid, vehicleid);
	#endif
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	#if DEBUG == 1
		printf("%d OnVehicleSpawn - begin", vehicleid);
	#endif
    if(B_IsTrailer(vehicleid))
    {
        new veh;
        if((veh = TrailerVehicle[vehicleid]) != 0)
        {
            if(IsCarBlinking(veh))
            {
                DestroyDynamicObject(Blink[veh][1]);
                DestroyDynamicObject(Blink[veh][3]);
                Blink[veh][1] = -1;
                Blink[veh][3] = -1;
            }
        }
    }
    else DisableCarBlinking(vehicleid);

    TJD_CheckForUsedBox(vehicleid);

	if(VehicleUID[vehicleid][vUID] != 0)
	{
        Car_AddTune(vehicleid);
    	SetVehicleHealth(vehicleid, CarData[VehicleUID[vehicleid][vUID]][c_HP]);
    	UpdateVehicleDamageStatus(vehicleid, 0, 0, 0, CarData[VehicleUID[vehicleid][vUID]][c_Tires]);
	}
    if(VehicleUID[vehicleid][vSiren] != 0)
	{
	    DestroyDynamicObject(VehicleUID[vehicleid][vSiren]);
	    VehicleUID[vehicleid][vSiren] = 0;
	}
	#if DEBUG == 1
		printf("%d OnVehicleSpawn - end", vehicleid);
	#endif
    return 1;
}

public OnPlayerText(playerid, text[])
{
	#if DEBUG == 1
		printf("%s[%d] OnPlayerText - begin", GetNick(playerid), playerid);
	#endif
    if(text[0] == '@') //animacja
    {
        if(strlen(text) > 31) return 0;
        new lVal = CallRemoteFunction("MRP_DoAnimation", "is[32]", playerid, text);
        if(lVal != 1) SendClientMessage(playerid, COLOR_GRAD2, "@: Nie znaleziono animacji.");
        return 0;
    }

	new giver[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
	new tmp[128];
	new string[128];
	new giveplayerid;
	if(PlayerInfo[playerid][pMuted] == 1)
	{
		SendClientMessage(playerid, TEAM_CYAN_COLOR, "Nie moøesz mÛwiÊ gdyø jesteú uciszony");
		return 0;
	}
	if(MarriageCeremoney[playerid] > 0)
	{
	    if (strcmp("tak", text, true) == 0)
		{
		    if(GotProposedBy[playerid] < 999)
		    {
			    if(IsPlayerConnected(GotProposedBy[playerid]))
				{
					GetPlayerName(playerid, sendername, sizeof(sendername));
					GetPlayerName(GotProposedBy[playerid], giveplayer, sizeof(giveplayer));
				    format(string, sizeof(string), "Ksiπdz: %s czy chcesz wziπÊ %s na swojπ øone? (wpisz 'tak', cokolwiek innego anuluje úlub).", giveplayer,sendername);
					SendClientMessage(GotProposedBy[playerid], COLOR_WHITE, string);
					MarriageCeremoney[GotProposedBy[playerid]] = 1;
					MarriageCeremoney[playerid] = 0;
					GotProposedBy[playerid] = 999;
				    return 1;
			    }
			    else
			    {
			        MarriageCeremoney[playerid] = 0;
			        GotProposedBy[playerid] = 999;
			        return 0;
			    }
			}
			else if(ProposedTo[playerid] < 999)
			{
			    if(IsPlayerConnected(ProposedTo[playerid]))
				{
					GetPlayerName(playerid, sendername, sizeof(sendername));
					GetPlayerName(ProposedTo[playerid], giveplayer, sizeof(giveplayer));
					if(PlayerInfo[playerid][pSex] == 1 && PlayerInfo[ProposedTo[playerid]][pSex] == 2)
					{
						format(string, sizeof(string), "Ksiπdz: %s i %s zostaliúcie mÍøem i øonπ, moøecie siÍ poca≥owaÊ.", sendername, giveplayer);
						SendClientMessage(playerid, COLOR_WHITE, string);
				   		format(string, sizeof(string), "Ksiπdz: %s i %s zostaliúcie mÍøem i øonπ, moøecie siÍ poca≥owaÊ.", giveplayer, sendername);
						SendClientMessage(ProposedTo[playerid], COLOR_WHITE, string);
						format(string, sizeof(string), "KoúciÛ≥: Mamy nowπ pare, %s & %s zostali zarÍczeni.", sendername, giveplayer);
						OOCNews(COLOR_WHITE, string);
					}
					else if(PlayerInfo[playerid][pSex] == 1 && PlayerInfo[ProposedTo[playerid]][pSex] == 1)
					{
					    format(string, sizeof(string), "Ksiπdz: %s i %s Zostaliúcie mÍøem i mÍøem, moøecie siÍ poca≥owaÊ.", sendername, giveplayer);
						SendClientMessage(playerid, COLOR_WHITE, string);
				   		format(string, sizeof(string), "Ksiπdz: %s i %s Zostaliúcie mÍøem i mÍøem, moøecie siÍ poca≥owaÊ.", giveplayer, sendername);
						SendClientMessage(ProposedTo[playerid], COLOR_WHITE, string);
						format(string, sizeof(string), "KoúciÛ≥: Mamy nowπ gejowskπ pare, %s & %s zostali zarÍczeni.", sendername, giveplayer);
						OOCNews(COLOR_WHITE, string);
					}
					else if(PlayerInfo[playerid][pSex] == 2 && PlayerInfo[ProposedTo[playerid]][pSex] == 2)
					{
					    format(string, sizeof(string), "Ksiπdz: %s i %s Zostaliúcie øonπ i øonπ, moøecie siÍ poca≥owaÊ.", sendername, giveplayer);
						SendClientMessage(playerid, COLOR_WHITE, string);
				   		format(string, sizeof(string), "Ksiπdz: %s i %s Zostaliúcie øonπ i øonπ, moøecie siÍ poca≥owaÊ.", giveplayer, sendername);
						SendClientMessage(ProposedTo[playerid], COLOR_WHITE, string);
						format(string, sizeof(string), "KoúciÛ≥: Mamy nowπ lesbijskπ pare, %s & %s zostali zarÍczeni.", sendername, giveplayer);
						OOCNews(COLOR_WHITE, string);
					}
					//MarriageCeremoney[ProposedTo[playerid]] = 1;
					MarriageCeremoney[ProposedTo[playerid]] = 0;
					MarriageCeremoney[playerid] = 0;
					format(PlayerInfo[ProposedTo[playerid]][pMarriedTo], 32, "%s", sendername);
                    format(PlayerInfo[playerid][pMarriedTo], 32, "%s", giveplayer);
					ZabierzKase(playerid, 100000);
					PlayerInfo[playerid][pMarried] = 1;
					PlayerInfo[ProposedTo[playerid]][pMarried] = 1;
					PlayerInfo[ProposedTo[playerid]][pPbiskey] = PlayerInfo[playerid][pPbiskey];
					ProposedTo[playerid] = 999;
					MarriageCeremoney[playerid] = 0;
				    return 1;
			    }
			    else
			    {
			        MarriageCeremoney[playerid] = 0;
			        ProposedTo[playerid] = 999;
			        return 0;
			    }
			}
		}
		else
		{
		    if(GotProposedBy[playerid] < 999)
		    {
				if(IsPlayerConnected(GotProposedBy[playerid]))
				{
					GetPlayerName(playerid, sendername, sizeof(sendername));
					GetPlayerName(GotProposedBy[playerid], giveplayer, sizeof(giveplayer));
					format(string, sizeof(string), "* Nie chcesz poúlubiÊ %s, nie powiedzia≥eú 'tak'.",giveplayer);
				    SendClientMessage(playerid, COLOR_YELLOW, string);
				    format(string, sizeof(string), "* %s nie chce ciÍ poúlubiÊ gdyø nie powiedzia≥ 'tak'.",sendername);
				    SendClientMessage(GotProposedBy[playerid], COLOR_YELLOW, string);

                    MarriageCeremoney[GotProposedBy[playerid]] = 0;
				    return 0;
			    }
			    else
			    {
			        MarriageCeremoney[playerid] = 0;
			        GotProposedBy[playerid] = 999;
			        return 0;
			    }
		    }
		    else if(ProposedTo[playerid] < 999)
			{
			    if(IsPlayerConnected(ProposedTo[playerid]))
				{
					GetPlayerName(playerid, sendername, sizeof(sendername));
					GetPlayerName(ProposedTo[playerid], giveplayer, sizeof(giveplayer));
					format(string, sizeof(string), "* Nie chcesz poúlubiÊ %s, nie powiedzia≥eú 'tak'.",giveplayer);
				    SendClientMessage(playerid, COLOR_YELLOW, string);
				    format(string, sizeof(string), "* %s nie chce ciÍ poúlubiÊ gdyø nie powiedzia≥ 'tak'.",sendername);
				    SendClientMessage(ProposedTo[playerid], COLOR_YELLOW, string);

                    GotProposedBy[ProposedTo[playerid]] = 0;
				    return 0;
			    }
			    else
			    {
			        MarriageCeremoney[playerid] = 0;
			        ProposedTo[playerid] = 999;
			        return 0;
			    }
			}
		}
	    return 0;
	}

	if(ConnectedToPC[playerid] == 255)
	{
		new idx;
	    tmp = strtok(text, idx);
	    if ((strcmp("Contracts", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("Contracts")) || (strcmp("Kontrakty", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("Kontrakty")))
		{
		    if(PlayerInfo[playerid][pRank] < 4)
		    {
		        SendClientMessage(playerid, COLOR_GREY, "   Tylko Hitmani z 4 rangπ mogπ sprawdzaÊ listÍ kontraktÛw !");
		        return 0;
		    }
		    SearchingHit(playerid);
			return 0;
		}
		else if ((strcmp("News", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("News")))
		{
		    	new x_nr[128];
				x_nr = strtok(text, idx);

				if(!strlen(x_nr)) {
					SendClientMessage(playerid, COLOR_WHITE, "|__________________ Hitman Agency News __________________|");
					SendClientMessage(playerid, COLOR_WHITE, "UØYJ: News [numer] aby skasowac 'News Delate [numer]' lub 'News delete all'");
					format(string, sizeof(string), "1: %s :: Hitman: %s", News[hAdd1], News[hContact1]);
					SendClientMessage(playerid, COLOR_GREY, string);
					format(string, sizeof(string), "2: %s :: Hitman: %s", News[hAdd2], News[hContact2]);
					SendClientMessage(playerid, COLOR_GREY, string);
					format(string, sizeof(string), "3: %s :: Hitman: %s", News[hAdd3], News[hContact3]);
					SendClientMessage(playerid, COLOR_GREY, string);
					format(string, sizeof(string), "4: %s :: Hitman: %s", News[hAdd4], News[hContact4]);
					SendClientMessage(playerid, COLOR_GREY, string);
					format(string, sizeof(string), "5: %s :: Hitman: %s", News[hAdd5], News[hContact5]);
					SendClientMessage(playerid, COLOR_GREY, string);
					SendClientMessage(playerid, COLOR_WHITE, "|________________________________________________________|");
					return 0;
				}//lets start
				if(strcmp(x_nr,"1",true) == 0)
				{
				    if(PlacedNews[playerid] == 1) { SendClientMessage(playerid, COLOR_GREY, "   Ten numer jest zajÍty, usuÒ wiadomoúÊ z tego numeru !"); return 0; }
				    if(PlayerInfo[playerid][pRank] < 3) { SendClientMessage(playerid, COLOR_GREY, "   Musisz miec 3 rangÍ aby pisaÊ newsy Hitman Agency !"); return 0; }
				    if(News[hTaken1] == 0)
				    {
				        GetPlayerName(playerid, sendername, sizeof(sendername));
				        if(strlen(text)-(strlen(x_nr)) < 9) { SendClientMessage(playerid, COLOR_GREY, "   Za krÛtki tekst newsa !"); return 0; }
						format(string, sizeof(string), "%s",right(text,strlen(text)-7)); strmid(News[hAdd1], string, 0, strlen(string));
						format(string, sizeof(string), "%s",sendername); strmid(News[hContact1], string, 0, strlen(string));
						News[hTaken1] = 1; PlacedNews[playerid] = 1;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Umieúci≥eú news na kanale Hitman Agency.");
						return 0;
				    }
				    else
				    {
				        SendClientMessage(playerid, COLOR_GREY, "   Ten numer jest zajety !");
				        return 0;
				    }
				}
				else if(strcmp(x_nr,"2",true) == 0)
				{
				    if(PlacedNews[playerid] == 1) { SendClientMessage(playerid, COLOR_GREY, "   Ten numer jest zajÍty, usuÒ wiadomoúÊ z tego numeru !"); return 0; }
				    if(PlayerInfo[playerid][pRank] < 3) { SendClientMessage(playerid, COLOR_GREY, "   Musisz mieÊ 3 rangÍ aby pisaÊ newsy na kanale Hitman Agency !"); return 0; }
				    if(News[hTaken2] == 0)
				    {
				        GetPlayerName(playerid, sendername, sizeof(sendername));
				        if(strlen(text)-(strlen(x_nr)) < 9) { SendClientMessage(playerid, COLOR_GREY, "   News jest za krÛtki !"); return 0; }
						format(string, sizeof(string), "%s",right(text,strlen(text)-7)); strmid(News[hAdd2], string, 0, strlen(string));
						format(string, sizeof(string), "%s",sendername); strmid(News[hContact2], string, 0, strlen(string));
						News[hTaken2] = 1; PlacedNews[playerid] = 1;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Umieúci≥eú news na kanale Hitman Agency.");
						return 0;
				    }
				    else
				    {
				        SendClientMessage(playerid, COLOR_GREY, "   Ten numer jest aktualnie w uøyciu !");
				        return 0;
				    }
				}
				else if(strcmp(x_nr,"3",true) == 0)
				{
				    if(PlacedNews[playerid] == 1) { SendClientMessage(playerid, COLOR_GREY, "   Ten numer jest zajÍty, usuÒ wiadomoúÊ z tego numeru !"); return 0; }
				    if(PlayerInfo[playerid][pRank] < 3) { SendClientMessage(playerid, COLOR_GREY, "   Musisz mieÊ 3 rangÍ aby pisaÊ newsy na kanale Hitman Agency !"); return 0; }
				    if(News[hTaken3] == 0)
				    {
				        GetPlayerName(playerid, sendername, sizeof(sendername));
				        if(strlen(text)-(strlen(x_nr)) < 9) { SendClientMessage(playerid, COLOR_GREY, "   News jest za krÛtki !"); return 0; }
						format(string, sizeof(string), "%s",right(text,strlen(text)-7)); strmid(News[hAdd3], string, 0, strlen(string));
						format(string, sizeof(string), "%s",sendername); strmid(News[hContact3], string, 0, strlen(string));
						News[hTaken3] = 1; PlacedNews[playerid] = 1;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Umieúci≥eú news na kanale Hitman Agency.");
						return 0;
				    }
				    else
				    {
				        SendClientMessage(playerid, COLOR_GREY, "   Ten numer jest aktualnie w uøyciu !");
				        return 0;
				    }
				}
				else if(strcmp(x_nr,"4",true) == 0)
				{
				    if(PlacedNews[playerid] == 1) { SendClientMessage(playerid, COLOR_GREY, "   Ten numer jest zajÍty, usuÒ wiadomoúÊ z tego numeru !"); return 0; }
				    if(PlayerInfo[playerid][pRank] < 3) { SendClientMessage(playerid, COLOR_GREY, "   Musisz mieÊ 3 rangÍ aby pisaÊ newsy na kanale Hitman Agency !"); return 0; }
				    if(News[hTaken4] == 0)
				    {
				        GetPlayerName(playerid, sendername, sizeof(sendername));
				        if(strlen(text)-(strlen(x_nr)) < 9) { SendClientMessage(playerid, COLOR_GREY, "   News jest za krÛtki !"); return 0; }
						format(string, sizeof(string), "%s",right(text,strlen(text)-7)); strmid(News[hAdd4], string, 0, strlen(string));
						format(string, sizeof(string), "%s",sendername); strmid(News[hContact4], string, 0, strlen(string));
						News[hTaken4] = 1; PlacedNews[playerid] = 1;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Umieúci≥eú news na kanale Hitman Agency.");
						return 0;
				    }
				    else
				    {
				        SendClientMessage(playerid, COLOR_GREY, "   Ten numer jest aktualnie w uøyciu !");
				        return 0;
				    }
				}
				else if(strcmp(x_nr,"5",true) == 0)
				{
				    if(PlacedNews[playerid] == 1) { SendClientMessage(playerid, COLOR_GREY, "   Ten numer jest zajÍty, usuÒ wiadomoúÊ z tego numeru !"); return 0; }
				    if(PlayerInfo[playerid][pRank] < 3) { SendClientMessage(playerid, COLOR_GREY, "   Musisz mieÊ 3 rangÍ aby pisaÊ newsy na kanale Hitman Agency !"); return 0; }
				    if(News[hTaken5] == 0)
				    {
				        GetPlayerName(playerid, sendername, sizeof(sendername));
				        if(strlen(text)-(strlen(x_nr)) < 9) { SendClientMessage(playerid, COLOR_GREY, "   News jest za krÛtki !"); return 0; }
						format(string, sizeof(string), "%s",right(text,strlen(text)-7)); strmid(News[hAdd5], string, 0, strlen(string));
						format(string, sizeof(string), "%s",sendername); strmid(News[hContact5], string, 0, strlen(string));
						News[hTaken5] = 1; PlacedNews[playerid] = 1;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Umieúci≥eú news na kanale Hitman Agency.");
						return 0;
				    }
				    else
				    {
				        SendClientMessage(playerid, COLOR_GREY, "   Ten numer jest aktualnie w uøyciu !");
				        return 0;
				    }
				}
				else if(strcmp(x_nr,"delete",true) == 0)
				{
				    if(PlayerInfo[playerid][pRank] < 4)
				    {
				        SendClientMessage(playerid, COLOR_GREY, "   Musisz mieÊ 4 rangÍ aby usuwaÊ newsy z kana≥u Hitman Agency !");
				        return 0;
				    }
				    new string1[MAX_PLAYER_NAME];
				    new x_tel[128];
					x_tel = strtok(text, idx);
					if(!strlen(x_tel)) {
					    SendClientMessage(playerid, COLOR_WHITE, "UØYJ: News delete [numer] lub News delete all.");
					    return 0;
					}
                    if(strcmp(x_tel,"1",true) == 0)
                    {
                        format(string, sizeof(string), "Nothing"); strmid(News[hAdd1], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact1], string1, 0, strlen(string1));
						News[hTaken1] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Skasowa≥eú newsa numer (1) Z kana≥u Hitman Agency.");
						return 0;
                    }
                    else if(strcmp(x_tel,"2",true) == 0)
                    {
                        format(string, sizeof(string), "Nothing"); strmid(News[hAdd2], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact2], string1, 0, strlen(string1));
						News[hTaken2] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Skasowa≥eú newsa numer (2) Z kana≥u Hitman Agency.");
						return 0;
                    }
                    else if(strcmp(x_tel,"3",true) == 0)
                    {
                        format(string, sizeof(string), "Nothing"); strmid(News[hAdd3], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact3], string1, 0, strlen(string1));
						News[hTaken3] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Skasowa≥eú newsa numer (3) Z kana≥u Hitman Agency.");
						return 0;
                    }
                    else if(strcmp(x_tel,"4",true) == 0)
                    {
                        format(string, sizeof(string), "Nothing"); strmid(News[hAdd4], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact4], string1, 0, strlen(string1));
						News[hTaken4] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Skasowa≥eú newsa numer (4) Z kana≥u Hitman Agency.");
						return 0;
                    }
                    else if(strcmp(x_tel,"5",true) == 0)
                    {
                        format(string, sizeof(string), "Nothing"); strmid(News[hAdd5], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact5], string1, 0, strlen(string1));
						News[hTaken5] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Skasowa≥eú newsa numer (5) Z kana≥u Hitman Agency.");
						return 0;
                    }
                    else if(strcmp(x_tel,"all",true) == 0)
                    {
                        format(string, sizeof(string), "Nothing"); strmid(News[hAdd1], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact1], string1, 0, strlen(string1));
						News[hTaken1] = 0;
						format(string, sizeof(string), "Nothing"); strmid(News[hAdd2], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact2], string1, 0, strlen(string1));
						News[hTaken2] = 0;
						format(string, sizeof(string), "Nothing"); strmid(News[hAdd3], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact3], string1, 0, strlen(string1));
						News[hTaken3] = 0;
						format(string, sizeof(string), "Nothing"); strmid(News[hAdd4], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact4], string1, 0, strlen(string1));
						News[hTaken4] = 0;
						format(string, sizeof(string), "Nothing"); strmid(News[hAdd5], string, 0, strlen(string));
						format(string1, sizeof(string1), "Nikt");	strmid(News[hContact5], string1, 0, strlen(string1));
						News[hTaken5] = 0;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Skasowa≥eú wszystkie newsy z kana≥u Hitman Agency.");
						return 0;
                    }
                    else
                    {
                        SendClientMessage(playerid, COLOR_WHITE, "UØYJ: News delete [numer] lub News delete all.");
					    return 0;
                    }
				}
				else { return 0; }
		}
		else if ((strcmp("Givehit", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("Givehit")))
		{
		    if(PlayerInfo[playerid][pRank] < 4)
		    {
		        SendClientMessage(playerid, COLOR_GREY, "   Musisz mieÊ 4 rangÍ aby dawaÊ kontrakty Hitmanom !");
		        return 0;
		    }
		    if(hitfound == 0)
		    {
		        SendClientMessage(playerid, COLOR_GREY, "   Nie sprawdzi≥eú jeszcze kontraktÛw, zrÛb to w laptopie (wpisz 'kontrakty') !");
		        return 0;
		    }
		    tmp = strtok(text, idx);
		    if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD1, "UØYJ: Givehit [playerid/CzÍúÊNicku]");
				return 0;
			}
			//giveplayerid = strval(tmp);
			giveplayerid = ReturnUser(tmp);
			if(IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
				    if(!IsAHA(giveplayerid))
				    {
				        SendClientMessage(playerid, COLOR_GREY, "   Ten gracz nie jest Hitmanem !");
						return 0;
				    }
				    if(GoChase[giveplayerid] < 999)
				    {
				        SendClientMessage(playerid, COLOR_GREY, "   Ten Hitman wykonuje juø jakieú zlecenie !");
						return 0;
				    }
				    if(IsPlayerConnected(hitmanid))
				    {
				        GetPlayerName(playerid, sendername, sizeof(sendername));
				        GetPlayerName(giveplayerid, giver, sizeof(giver));
				        GetPlayerName(hitmanid, giveplayer, sizeof(giveplayer));

		    			format(string, sizeof(string), "* Hitman %s, da≥ zlecenie %s na zabicie: %s(ID:%d), nagroda: $%d.", sendername, giver, giveplayer, hitmanid, PlayerInfo[hitmanid][pHeadValue]);
		    			SendFamilyMessage(8, COLOR_YELLOW, string);
		    			GoChase[giveplayerid] = hitmanid;
		    			GetChased[hitmanid] = giveplayerid;
		    			GotHit[hitmanid] = 1;
		    			hitmanid = 0;
		    			hitfound = 0;
				        return 0;
				    }
				    else
				    {
				        SendClientMessage(playerid, COLOR_GREY, "   Osoby, na ktÛrπ jest zlecenie, nie ma na serwerze. SprÛbuj pÛüniej !");
				        return 0;
				    }
				}
				return 0;
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GREY, "   Tego gracza nie ma na serwerze lub nie jest Hitmanem !");
			    return 0;
			}
		}
		else if ((strcmp("Ranks", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("Ranks")) || (strcmp("Rangi", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("Rangi")))
		{
			SendClientMessage(playerid, COLOR_WHITE, "|__________________ Rangi HitmanÛw __________________|");
		    foreach(Player, i)
			{
				if(IsPlayerConnected(i))
				{
				    if(PlayerInfo[i][pMember] == 8||PlayerInfo[i][pLider] == 8)
				    {
						GetPlayerName(i, giveplayer, sizeof(giveplayer));
				        format(string, sizeof(string), "* %s: Ranga %d", giveplayer,PlayerInfo[i][pRank]);
						SendClientMessage(playerid, COLOR_GREY, string);
					}
				}
			}
		}
		else if ((strcmp("Order", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("Order")))
		{
		    if(OrderReady[playerid] > 0)
		    {
		        SendClientMessage(playerid, COLOR_GREY, "   ZamÛwi≥eú juø paczki z broniπ, idü do swojej bazy aby je odebraÊ !");
		        return 0;
		    }
		    tmp = strtok(text, idx);
		    if ((strcmp("1", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("1")))
			{
			    //if(PlayerInfo[playerid][pRank] < 0) { SendClientMessage(playerid, COLOR_GREY, "   Masz zbyt niskπ rangÍ aby zamÛwiÊ tÍ paczke !"); return 0; }
			    if(kaska[playerid] > 2499)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* ZamÛwi≥eú paczkÍ numer 1 ($2500), zostanie dostarczona do drzwi Agencji.");
			        OrderReady[playerid] = 1;
			        return 0;
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_GREY,"   Nie staÊ ciÍ na to !");
			        return 0;
			    }
			}
		    else if ((strcmp("2", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("2")))
			{
			    if(PlayerInfo[playerid][pRank] < 1) { SendClientMessage(playerid, COLOR_GREY, "   Masz zbyt niskπ rangÍ aby zamÛwiÊ tÍ paczke !"); return 0; }
			    if(kaska[playerid] > 4999)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* ZamÛwi≥eú paczkÍ numer 2 ($5000), zostanie dostarczona do drzwi Agencji.");
			        OrderReady[playerid] = 2;
			        return 0;
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_GREY,"   Nie staÊ ciÍ na to !");
			        return 0;
			    }
			}
			else if ((strcmp("3", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("3")))
			{
			    if(PlayerInfo[playerid][pRank] < 2) { SendClientMessage(playerid, COLOR_GREY, "   Masz zbyt niskπ rangÍ aby zamÛwiÊ tÍ paczke !"); return 0; }
			    if(kaska[playerid] > 5999)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* ZamÛwi≥eú paczke numer 3 ($6000), Zostanie dostarczona do drzwi frontowych bazy Agencji.");
			        OrderReady[playerid] = 3;
			        return 0;
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_GREY,"   Nie staÊ ciÍ na to !");
			        return 0;
			    }
			}
			else if ((strcmp("4", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("4")))
			{
			    if(PlayerInfo[playerid][pRank] < 2) { SendClientMessage(playerid, COLOR_GREY, "   Masz zbyt niskπ rangÍ aby zamÛwiÊ tÍ paczke !"); return 0; }
			    if(kaska[playerid] > 5999)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* ZamÛwi≥eú paczke numer 4 ($6000), Zostanie dostarczona do drzwi frontowych bazy Agencji.");
			        OrderReady[playerid] = 4;
			        return 0;
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_GREY,"   Nie staÊ ciÍ na to !");
			        return 0;
			    }
			}
			else if ((strcmp("5", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("5")))
			{
			    if(PlayerInfo[playerid][pRank] < 3) { SendClientMessage(playerid, COLOR_GREY, "   Masz zbyt niskπ rangÍ aby zamÛwiÊ tÍ paczke !"); return 0; }
			    if(kaska[playerid] > 7999)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* ZamÛwi≥eú paczke numer 5 ($8000), Zostanie dostarczona do drzwi frontowych bazy Agencji.");
			        OrderReady[playerid] = 5;
			        return 0;
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_GREY,"   Nie staÊ ciÍ na to !");
			        return 0;
			    }
			}
			else if ((strcmp("6", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("6")))
			{
			    if(PlayerInfo[playerid][pRank] < 3) { SendClientMessage(playerid, COLOR_GREY, "   Masz zbyt niskπ rangÍ aby zamÛwiÊ tÍ paczke !"); return 0; }
			    if(kaska[playerid] > 7999)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* ZamÛwi≥eú paczke numer 6 ($8000), Zostanie dostarczona do drzwi frontowych bazy Agencji.");
			        OrderReady[playerid] = 6;
			        return 0;
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_GREY,"   Nie staÊ ciÍ na to !");
			        return 0;
			    }
			}
			else if ((strcmp("7", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("7")))
			{
			    if(PlayerInfo[playerid][pRank] < 4) { SendClientMessage(playerid, COLOR_GREY, "   Masz zbyt niskπ rangÍ aby zamÛwiÊ tÍ paczke !"); return 0; }
			    if(kaska[playerid] > 8499)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* ZamÛwi≥eú paczke numer 7 ($8500), Zostanie dostarczona do drzwi frontowych bazy Agencji.");
			        OrderReady[playerid] = 7;
			        return 0;
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_GREY,"   Nie staÊ ciÍ na to !");
			        return 0;
			    }
			}
			else if ((strcmp("8", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("8")))
			{
			    if(PlayerInfo[playerid][pRank] < 4) { SendClientMessage(playerid, COLOR_GREY, "   Masz zbyt niskπ rangÍ aby zamÛwiÊ tÍ paczke !"); return 0; }
			    if(kaska[playerid] > 8499)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* ZamÛwi≥eú paczke numer 8 ($8500), Zostanie dostarczona do drzwi frontowych bazy Agencji.");
			        OrderReady[playerid] = 8;
			        return 0;
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_GREY,"   Nie staÊ ciÍ na to !");
			        return 0;
			    }
			}
			else if ((strcmp("9", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("9")))
			{
			    if(PlayerInfo[playerid][pRank] < 5) { SendClientMessage(playerid, COLOR_GREY, "   Masz zbyt niskπ rangÍ aby zamÛwiÊ tÍ paczke !"); return 0; }
			    if(kaska[playerid] > 9999)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* ZamÛwi≥eú paczke numer 9 ($10000), Zostanie dostarczona do drzwi frontowych bazy Agencji.");
			        OrderReady[playerid] = 9;
			        return 0;
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_GREY,"   Nie staÊ ciÍ na to !");
			        return 0;
			    }
			}
			else if ((strcmp("10", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("10")))
			{
			    if(PlayerInfo[playerid][pRank] < 5) { SendClientMessage(playerid, COLOR_GREY, "   Masz zbyt niskπ rangÍ aby zamÛwiÊ tÍ paczke !"); return 0; }
			    if(kaska[playerid] > 9999)
			    {
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* ZamÛwi≥eú paczke numer 10 ($10000), Zostanie dostarczona do drzwi frontowych bazy Agencji.");
			        OrderReady[playerid] = 10;
			        return 0;
			    }
			    else
			    {
			        SendClientMessage(playerid, COLOR_GREY,"   Nie staÊ ciÍ na to !");
			        return 0;
			    }
			}
			else
			{
			    SendClientMessage(playerid, COLOR_WHITE, "|__________________ DostÍpne paczki __________________|");
			    if(PlayerInfo[playerid][pRank] >= 0) { SendClientMessage(playerid, COLOR_GREY, "|(1) ($2500) Ranga 0: NÛø, Desert Eagle, Shotgun, Pancerz"); }
			    if(PlayerInfo[playerid][pRank] >= 1) { SendClientMessage(playerid, COLOR_GREY, "|(2) ($5000) Ranga 1: NÛø, Desert Eagle, MP5, Shotgun, Pancerz"); }
			    if(PlayerInfo[playerid][pRank] >= 2) { SendClientMessage(playerid, COLOR_GREY, "|(3) ($6000) Ranga 2: NÛø, Desert Eagle, M4, MP5, Shotgun, Pancerz"); }
			    if(PlayerInfo[playerid][pRank] >= 2) { SendClientMessage(playerid, COLOR_GREY, "|(4) ($6000) Ranga 2: NÛø, Desert Eagle, AK47, MP5, Shotgun, Pancerz"); }
			    if(PlayerInfo[playerid][pRank] >= 3) { SendClientMessage(playerid, COLOR_GREY, "|(5) ($8000) Ranga 3: NÛø, Desert Eagle, M4, MP5, Shotgun, Snajperka, Pancerz"); }
			    if(PlayerInfo[playerid][pRank] >= 3) { SendClientMessage(playerid, COLOR_GREY, "|(6) ($8000) Ranga 3: NÛø, Desert Eagle, AK47, MP5, Shotgun, Snajperka, Pancerz"); }
			    if(PlayerInfo[playerid][pRank] >= 4) { SendClientMessage(playerid, COLOR_GREY, "|(7) ($8500) Ranga 4: NÛø, Desert Eagle, M4, MP5, Spas12, Snajperka, Pancerz"); }
			    if(PlayerInfo[playerid][pRank] >= 4) { SendClientMessage(playerid, COLOR_GREY, "|(8) ($8500) Ranga 4: NÛø, Desert Eagle, AK47, MP5, Spas12, Snajperka, Pancerz"); }
			    if(PlayerInfo[playerid][pRank] >= 5) { SendClientMessage(playerid, COLOR_GREY, "|(9) ($10000) Ranga 5-9: NÛø, Desert Eagle, M4, UZI, Spas12, Snajperka, Pancerz"); }
                if(PlayerInfo[playerid][pRank] >= 5) { SendClientMessage(playerid, COLOR_GREY, "|(10) ($10000) Ranga 5-9: NÛø, Desert Eagle, AK47, UZI, Spas12, Snajperka, Pancerz"); }
				SendClientMessage(playerid, COLOR_WHITE, "|________________________________________________________|");
			    return 0;
			}
		}
		else if ((strcmp("Logout", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("Logout")) || (strcmp("Wyloguj", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("Wyloguj")))
		{
		    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Wy≥πczy≥eú swÛj laptop i zerwa≥eú po≥πczenie z agencjπ.");
      		ConnectedToPC[playerid] = 0;
		    return 0;
		}
		else
		{
		    SendClientMessage(playerid, COLOR_WHITE, "|___ Hitman Agency ___|");
		    SendClientMessage(playerid, COLOR_YELLOW2, "| - News");
		    SendClientMessage(playerid, COLOR_YELLOW2, "| - Kontrakty");
		    SendClientMessage(playerid, COLOR_YELLOW2, "| - Givehit");
		    SendClientMessage(playerid, COLOR_YELLOW2, "| - Backup");
		    SendClientMessage(playerid, COLOR_YELLOW2, "| - Order");
		    SendClientMessage(playerid, COLOR_YELLOW2, "| - Rangi");
		    SendClientMessage(playerid, COLOR_YELLOW2, "| - Wyloguj");
		    SendClientMessage(playerid, COLOR_YELLOW2, "|");
			SendClientMessage(playerid, COLOR_WHITE, "|______________|00:00|");
		    return 0;
		}
	    return 0;
	}
	if(CallLawyer[playerid] == 111)
	{
	    new idx;
	    tmp = strtok(text, idx);
	    if ((strcmp("tak", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("tak")))
		{
		    GetPlayerName(playerid, sendername, sizeof(sendername));
		    format(string, sizeof(string), "** %s jest w wiÍzieniu i potrzebuje prawnika, jedü na komisariat.", sendername);
	    	SendJobMessage(2, TEAM_AZTECAS_COLOR, string);
	    	SendJobMessage(2, TEAM_AZTECAS_COLOR, "* Kiedy bÍdziesz juz na komisariacie, spytaj siÍ policjanta o /akceptuj prawnik.");
	    	SendClientMessage(playerid, COLOR_LIGHTRED, "Jeúli policjant siÍ zgodzi, prawnik bÍdzie mÛg≥ uwolniÊ ciÍ za op≥atπ.");
	    	WantLawyer[playerid] = 0;
			CallLawyer[playerid] = 0;
	    	return 0;
		}
		else
		{
		    SendClientMessage(playerid, COLOR_LIGHTRED, "Nie ma øadnych prawnikÛw na serwerze, czas odsiadki rozpoczÍty.");
		    WantLawyer[playerid] = 0;
			CallLawyer[playerid] = 0;
		    return 0;
		}
	}
	if(TalkingLive[playerid] != INVALID_PLAYER_ID)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(PlayerInfo[playerid][pMember] == 9 || PlayerInfo[playerid][pLider] == 9)
		{
		    format(string, sizeof(string), "Reporter %s: %s", sendername, text);
			OOCNews(COLOR_LIGHTGREEN, string);
		}
		else
		{
		    format(string, sizeof(string), "GoúÊ wywiadu %s: %s", sendername, text);
			OOCNews(COLOR_LIGHTGREEN, string);
		}
		return 0;
	}
	if(Mobile[playerid] != 1255)
	{
		new idx;
		tmp = strtok(text, idx);
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s mÛwi (telefon): %s", sendername, text);
		ProxDetector(20.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);

		if(Mobile[playerid] == 914)
		{
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, TEAM_CYAN_COLOR, "Centrala: Niestety, nie rozumiem");
				return 0;
			}
			new turner[MAX_PLAYER_NAME];
			new wanted[128];
			GetPlayerName(playerid, turner, sizeof(turner));
			SendClientMessage(playerid, TEAM_CYAN_COLOR, "Centrala: Zg≥osimy to wszystkim jednostkom w danym obszarze.");
			SendClientMessage(playerid, TEAM_CYAN_COLOR, "DziÍkujemy za zg≥oszenie");
			format(wanted, sizeof(wanted), "Centrala: Do wszystkich jednostek: Nadawca: %s",turner);
			SendTeamMessage(4, COLOR_ALLDEPT, wanted);
			format(wanted, sizeof(wanted), "Dyspozytor: Zg≥oszono: %s",text);
			SendTeamMessage(4, COLOR_ALLDEPT, wanted);
			SendClientMessage(playerid, COLOR_GRAD2, "   Rozmowa zakoÒczona...");
			Mobile[playerid] = 1255;
			return 0;
		}
        if(Mobile[playerid] == 916)
		{
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, TEAM_CYAN_COLOR, "Centrala: Niestety, nie rozumiem");
				return 0;
			}
			new turner[MAX_PLAYER_NAME];
			new wanted[128];
			GetPlayerName(playerid, turner, sizeof(turner));
			SendClientMessage(playerid, TEAM_CYAN_COLOR, "Centrala: Zg≥osimy to wszystkim jednostkom w danym obszarze.");
			SendClientMessage(playerid, TEAM_CYAN_COLOR, "DziÍkujemy za zg≥oszenie");
			format(wanted, sizeof(wanted), "Centrala: Do wszystkich jednostek: Nadawca: %s",turner);
			SendTeamMessage(17, COLOR_ALLDEPT, wanted);
			format(wanted, sizeof(wanted), "Dyspozytor: Zg≥oszono: %s",text);
			SendTeamMessage(17, COLOR_ALLDEPT, wanted);
			SendClientMessage(playerid, COLOR_GRAD2, "   Rozmowa zakoÒczona...");
			Mobile[playerid] = 1255;
			return 0;
		}
		if(Mobile[playerid] == 913)
		{
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_ALLDEPT, "Centrala: Niestety, nie rozumiem");
				return 0;
			}
			if ((strcmp("nie", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("nie")))
			{
				new turner[MAX_PLAYER_NAME];
				new wanted[128];
				GetPlayerName(playerid, turner, sizeof(turner));
				SendClientMessage(playerid, COLOR_DBLUE, "Centrala: Ostrzeøemy wszystkie jednostki w danym obszarze.");
				SendClientMessage(playerid, COLOR_DBLUE, "DziÍkujemy za zg≥oszenie przestÍpstwa");
				format(wanted, sizeof(wanted), "HQ: Do Wszystkich Jednostek: Nadawca: %s",turner);
				SendFamilyMessage(1, COLOR_DBLUE, wanted);
				format(wanted, sizeof(wanted), "HQ: Przestepstwo: %s, Poszukiwany: Nieznany",PlayerCrime[playerid][pAccusing]);
				SendFamilyMessage(1, COLOR_DBLUE, wanted);
				SendClientMessage(playerid, COLOR_GRAD2, "   Rozmowa zakoÒczona...");
				Mobile[playerid] = 1255;
				return 0;
			}
			new badguy;
			//badguy = strval(tmp);
			badguy = ReturnUser(tmp);
			if (IsPlayerConnected(badguy))
			{
			    if(badguy != INVALID_PLAYER_ID)
			    {
					if (gTeam[badguy] == 2 || gTeam[badguy] == 1)
					{
						SendClientMessage(playerid, COLOR_DBLUE, "LSPD HQ: Musisz poinformowaÊ kogoú innego. To jest linia ratunkowa");
						SendClientMessage(playerid, COLOR_GRAD2, "   Rozmowa zakoÒczona...");
						Mobile[playerid] = 1255;
						return 0;
					}
					if (PoziomPoszukiwania[badguy] > 0)
					{
						SendClientMessage(playerid, COLOR_DBLUE, "LSPD HQ: Aktualnie prowadzimy úledztwo w tej sprawie");
						SendClientMessage(playerid, COLOR_DBLUE, "DziÍkujemy za zg≥oszenie przestÍpstwa");
						SendClientMessage(playerid, COLOR_GRAD2, "   Rozmowa zakoÒczona...");
						Mobile[playerid] = 1255;
						return 0;
					}
					if (badguy == playerid)
					{
						SendClientMessage(playerid, COLOR_DBLUE, "Police HQ: Nie wyg≥upiaj siÍ, to jest linia ratunkowa!");
						SendClientMessage(playerid, COLOR_GRAD2, "   Rozmowa zakoÒczona...");
						Mobile[playerid] = 1255;
						return 0;
					}
					new guyname[MAX_PLAYER_NAME];
					new turner[MAX_PLAYER_NAME];
					new wanted[128];
					
					SendClientMessage(playerid, COLOR_DBLUE, "Police HQ: Ostrzeøemy wszystkie jednostki w danym obszarze.");
					SendClientMessage(playerid, COLOR_DBLUE, "DziÍkujemy za zg≥oszenie przestÍpstwa");
					
					GetPlayerName(badguy, guyname, sizeof(guyname));
					GetPlayerName(playerid, turner, sizeof(turner));
					format(wanted, sizeof(wanted), "HQ: Do Wszystkich Jednostek: Nadawca: %s",turner);
					SendFamilyMessage(1, COLOR_DBLUE, wanted);
					format(wanted, sizeof(wanted), "HQ: Przestepstwo: %s, Poszukiwany: %s",PlayerCrime[playerid][pAccusing],guyname);
					SendFamilyMessage(1, COLOR_DBLUE, wanted);
					
                    PlayCrimeReportForPlayer(playerid, playerid, 9);

					SetPlayerCriminal(badguy,playerid, PlayerCrime[playerid][pAccusing]);

					if(PoziomPoszukiwania[badguy] > 0) { } else { PoziomPoszukiwania[badguy] += 1; }
					Mobile[playerid] = 1255;
					return 0;
				}//invalid id
				return 0;
			}//not connected
			else
			{
				format(string, sizeof(string), "Police HQ: Nie mamy øadnych informacji o %s, czy to napewno dobre nazwisko?",tmp);
				SendClientMessage(playerid, COLOR_DBLUE, string);
				return 0;
			}
		}
		if(Mobile[playerid] == 912)
		{
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_ALLDEPT, "Centrala: Niestety, nie rozumiem");
				return 0;
			}
			strmid(PlayerCrime[playerid][pAccusing], text, 0, strlen(text), 255);
			SendClientMessage(playerid, COLOR_DBLUE, "Police HQ: Jeúli nie wiesz kto to by≥, powiedz poprostu 'nie'.");
			Mobile[playerid] = 913;
			return 0;
		}

		if(IsPlayerConnected(Mobile[playerid]))
		{
		    if(Mobile[Mobile[playerid]] == playerid)
		    {
				SendClientMessage(Mobile[playerid], COLOR_YELLOW,string);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_YELLOW,"Nikt siÍ nie odzywa");
		}
		return 0;
	}
	if (realchat)
	{
	    if(gPlayerLogged[playerid] == 0)
	    {
	        return 0;
      	}
		if(GetPlayerState(playerid) == 2 || GetPlayerState(playerid) == 3)
      	{
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "%s mÛwi (w pojeüdzie): %s", sendername, text);
			ProxDetector(10.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
			SetPlayerChatBubble(playerid,text,COLOR_FADE1,10.0,8000);
		}
		else
		{
			GetPlayerName(playerid, sendername, sizeof(sendername));
      		format(string, sizeof(string), "%s mÛwi: %s", sendername, text);
			ProxDetector(20.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
			SetPlayerChatBubble(playerid,text,COLOR_FADE1,20.0,8000);
    		ApplyAnimation(playerid,"PED","IDLE_CHAT",4.0,0,0,0,4,4);
		}
		return 0;
	}
	#if DEBUG == 1
		printf("%s[%d] OnPlayerText - end", GetNick(playerid), playerid);
	#endif
	return 1;
}//OnPlayerText

IBIZA_Reszta()
{
    IbizaDrinkiPobierz();
	mysql_query("SELECT `hajs` FROM `ibiza` WHERE `id`=2");
	mysql_store_result();
	if(mysql_num_rows())
	{
		new bufor[64];
		mysql_fetch_row_format(bufor, "|");
		sscanf(bufor, "d", IbizaBilet);
	}
	mysql_free_result();
	//TEXTDRAWY

    TDIbiza[0] = TextDrawCreate(390.00000, 21.500000, "01/01/1999  21:21");
    TextDrawFont(TDIbiza[0], 2);
    TextDrawLetterSize(TDIbiza[0], 0.599999, 2.000000);
    TextDrawColor(TDIbiza[0], 0xFFFFFFFF);
    TextDrawSetOutline(TDIbiza[0], 1);

    TDIbiza[1] = TextDrawCreate(326.000000, 373.000000, "LD_BEAT:right");
    TextDrawFont(TDIbiza[1], 4);
	TextDrawTextSize(TDIbiza[1], 40.00, 40.00);
	TextDrawSetSelectable(TDIbiza[1], 1);

    TDIbiza[2] = TextDrawCreate(261.500000, 373.000000, "LD_BEAT:left");
    TextDrawFont(TDIbiza[2], 4);
	TextDrawTextSize(TDIbiza[2], 40.00, 40.00);
	TextDrawSetSelectable(TDIbiza[2], 1);

    	//OBIEKTY INTEK IBIZA
	IbizaKafle[0] = CreateDynamicObject(19128,1936.5900000,-2482.1700000,12.5084,0.0000000,0.0000000,0.0000000, 1, 0, -1); //Object number 473
	IbizaKafle[1] = CreateDynamicObject(19128,1953.6400000,-2482.1300000,12.5084,0.0000000,0.0000000,0.0000000, 1, 0, -1); //Object number 474
	IbizaKafle[2] = CreateDynamicObject(19128,1953.6500000,-2497.4700000,12.5084,0.0000000,0.0000000,0.0000000, 1, 0, -1); //Object number 475
	IbizaKafle[3] = CreateDynamicObject(19128,1936.6100000,-2497.4700000,12.5084,0.0000000,0.0000000,0.0000000, 1, 0, -1); //Object number 476
	IbizaRuryObiekty[0] = CreateDynamicObject(3503,1936.6000, -2482.1799, 11.0000,0.0000000,0.0000000,0.0000000, 1, 0, -1); //Object number 477
	IbizaRuryObiekty[1] = CreateDynamicObject(3503,1953.6300, -2482.1299, 11.0000,0.0000000,0.0000000,0.0000000, 1, 0, -1); //Object number 478
	IbizaRuryObiekty[2] = CreateDynamicObject(3503,1936.5900, -2497.4700, 11.0000,0.0000000,0.0000000,0.0000000, 1, 0, -1); //Object number 479
	IbizaRuryObiekty[3] = CreateDynamicObject(3503,1953.6500, -2497.4600, 11.0000,0.0000000,0.0000000,0.0000000, 1, 0, -1); //Object number 480
	IbizaBarierkiObiekty[0] = CreateDynamicObject(2773,1953.8400000,-2470.7100000,14.9000000,0.0000000,0.0000000,93.1800000, 1, 0, -1); //Object number 423
	IbizaBarierkiObiekty[1] = CreateDynamicObject(2773,1951.9300000,-2470.8200000,14.9000000,0.0000000,0.0000000,93.1800000, 1, 0, -1); //Object number 424
	IbizaBarierkiObiekty[2] = CreateDynamicObject(2773,1950.0100000,-2470.8700000,14.9000000,0.0000000,0.0000000,89.7000000, 1, 0, -1); //Object number 425
	IbizaPiasek[0] = CreateDynamicObject(19377,1939.8800000,-2485.0000000,12.5500000,0.0000000,90.0000000,0.0000000, 1, 0, -1);
	IbizaPiasek[1] = CreateDynamicObject(19377,1950.3800000,-2485.0000000,12.5500000,0.0000000,90.0000000,0.0000000, 1, 0, -1);
	IbizaPiasek[2] = CreateDynamicObject(19377,1939.8800000,-2494.6300000,12.5500000,0.0000000,90.0000000,0.0000000, 1, 0, -1);
	IbizaPiasek[3] = CreateDynamicObject(19377,1950.3800000,-2494.6300000,12.5500000,0.0000000,90.0000000,0.0000000, 1, 0, -1);
	IbizaKameryObiekty[0] = CreateDynamicObject(1616,1958.9700000,-2477.3400000,21.7100000,0.0000000,0.0000000,90.7200000, 1, 0, -1); //przy scenie, paczy na VIP
	IbizaKameryObiekty[1] = CreateDynamicObject(1616,1921.0300000,-2503.7500000,22.6100000,0.0000000,0.0000000,-97.3800000, 1, 0, -1); //nad VIPEm, paczy na parkiet
	IbizaKameryObiekty[2] = CreateDynamicObject(1616,1892.9300000,-2473.6900000,21.7100000,0.0000000,0.0000000,-197.8200000, 1, 0, -1); //paczy na wejscie i bar, po lewo od prezesa
	IbizaKameryObiekty[3] = CreateDynamicObject(1616,1892.9700000,-2493.0300000,20.7300000,0.0000000,0.0000000,-114.3000000, 1, 0, -1); //nad wejúciem paczy na prezesa
	IbizaKameryObiekty[4] = CreateDynamicObject(1616,1913.9400000,-2474.1600000,21.3700000,0.0000000,0.0000000,73.5000000, 1, 0, -1); //przy prezesie prawo
	IbizaKameryObiekty[5] = CreateDynamicObject(1616,1757.2200000,-2467.5000000,24.0100000,-15.7800000,-14.4000000,40.1400000, 1, 0, -1); //przedsionek
	IbizaKameryObiekty[6] = CreateDynamicObject(1616,1533.5800000,-2558.0900000,19.00000,0.0000000,0.0000000,-118.6800000, 1, 0, -1); //kibel
	IbizaKameryObiekty[7] = CreateDynamicObject(1616,1533.5800000,-2558.0900000,19.00000,0.0000000,0.0000000,-118.6800000, 2, 0, -1); //kibel
	IbizaKanciapaObiekt = CreateDynamicObject(19302, 1902.58, -2465.68, 19.12,   0.00, 0.00, 90.00, 1, 0, -1);

	//IBIZA OBIEKTY NA ZEWN•TRZ
	IbizaKameryObiekty[8] = CreateDynamicObject(1616,386.9000000,-1808.9100000,12.9700000,0.0000000,0.0000000,20.0400000,0, 0, -1); //przy bramie
	IbizaKameryObiekty[9] = CreateDynamicObject(1616,389.5400000,-1805.8600000,12.9800000,0.0000000,0.0000000,-114.0600000,0, 0, -1); //nad wejúciem
	IbizaKameryObiekty[10] = CreateDynamicObject(1616,436.0300000,-1787.4700000,19.5600000,0.0000000,0.0000000,48.3000000,0, 0, -1); //palma bliøsza na wejúcie
	IbizaKameryObiekty[11] = CreateDynamicObject(1616,308.5300000,-1816.9700000,10.0100000,0.0000000,0.0000000,-122.2800000,0, 0, -1); //z parkingu
	IbizaBramaObiekty[0] = CreateDynamicObject(2372,420.9000000,-1783.4000000,4.3100000,0.0000000,0.0000000,0.0000000,0, 0, -1);
	IbizaBramaObiekty[1] = CreateDynamicObject(2372,358.4000000,-1783.9000000,4.2000000,0.0000000,0.0000000,0.0000000,0, 0, -1);
}

stock IBIZA_end()
{
    IbizaDrinkiZapisz();
}

public OnPlayerSelectDynamicObject(playerid, objectid, modelid, Float:x, Float:y, Float:z)
{
	#if DEBUG == 1
		printf("%s[%d] OnPlayerSelectDynamicObject - begin", GetNick(playerid), playerid);
	#endif
    if(GetPVarInt(playerid, "Allow-edit"))
    {
        EditDynamicObject(playerid, objectid);
        new lStr[32];
        format(lStr, 32, "OBJID: %d", objectid);
        SendClientMessage(playerid, -1, lStr);
    }
	#if DEBUG == 1
		printf("%s[%d] OnPlayerSelectDynamicObject - end", GetNick(playerid), playerid);
	#endif
    return 1;
}

public OnPlayerEnterGangZone(playerid, zoneid)
{
    /*new frac=GetPlayerFraction(playerid), org = GetPlayerOrg(playerid);
    if(FRAC_GROOVE <= frac <= FRAC_VAGOS || frac == FRAC_WPS || GetPlayerOrgType(playerid) == ORG_TYPE_GANG)
    {
        ZoneTXD_Show(playerid, zoneid);
        if(ZonePlayerTimer[playerid] == 0) ZonePlayerTimer[playerid] = SetTimerEx("Zone_HideInfo", 30000, 0, "i", playerid);
    }
    //Attack sync
    if(ZoneAttack[zoneid] && PlayerInfo[playerid][pBW] == 0)
    {
        if(frac == ZoneAttackData[zoneid][2] || org == ZoneAttackData[zoneid][2]) // attacker
        {
            if(!ZoneAttacker[playerid])
            {
                ZoneAttacker[playerid] = true;
                ZoneAttackData[zoneid][0]++;
            }
        }
        else if(frac == ZoneAttackData[zoneid][3] || org == ZoneAttackData[zoneid][3]) // defender
        {
            if(!ZoneDefender[playerid])
            {
                ZoneDefender[playerid] = true;
                ZoneAttackData[zoneid][1]++;
            }
        }
    }*/
}

public OnPlayerLeaveGangZone(playerid, zoneid)
{
	#if DEBUG == 1
		printf("%s[%d] OnPlayerLeaveGangZone - begin", GetNick(playerid), playerid);
	#endif
    if(zoneid < 0)
    {
        printf("Invalid zoneid (%d) for player %d", zoneid, playerid);
        return;
    }
    if(ZonePlayerTimer[playerid] != 0)
    {
        ZoneTXD_Hide(playerid);
        KillTimer(ZonePlayerTimer[playerid]);
        ZonePlayerTimer[playerid] = 0;
    }
    //Attack sync
    if(ZoneAttack[zoneid])
    {
        if(GetPlayerFraction(playerid) == ZoneAttackData[zoneid][2] || GetPlayerOrg(playerid) == ZoneAttackData[zoneid][2]) // attacker
        {
            if(ZoneAttacker[playerid])
            {
                ZoneAttacker[playerid] = false;
                ZoneAttackData[zoneid][0]--;
            }
        }
        else if(GetPlayerFraction(playerid) == ZoneAttackData[zoneid][3] || GetPlayerOrg(playerid) == ZoneAttackData[zoneid][3]) // defender
        {
            if(ZoneDefender[playerid])
            {
                ZoneDefender[playerid] = false;
                ZoneAttackData[zoneid][1]--;
            }
        }
    }
    SetPVarInt(playerid, "zoneid", -1);
	#if DEBUG == 1
		printf("%s[%d] OnPlayerLeaveGangZone - end", GetNick(playerid), playerid);
	#endif
}

stock SetPlayerPosEx(playerid,Float:X,Float:Y,Float:Z)
{
    SetPlayerPos(playerid,X,Y,Z);
}

stock PutPlayerInVehicleEx(playerid,vehicleid,seatid)
{
    PutPlayerInVehicle(playerid,vehicleid,seatid);
}

stock RemovePlayerFromVehicleEx(playerid)
{
    new veh = GetPlayerVehicleID(playerid);
    new model = GetVehicleModel(veh);
    if(model == 538 || model == 537 || model == 449)
    {
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        SetPlayerPosEx(playerid, x, y, z+0.7);
    }
    RemovePlayerFromVehicle(playerid);
}


public OnTrailerUpdate(playerid, vehicleid)
{
    return 1;
}

public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
    return 1;
}

public MRP_ChangeVehicleColor(vehicleid, color1, color2)
{
    new bool:save=false;
    if(CarData[VehicleUID[vehicleid][vUID]][c_Color][0] != color1 || CarData[VehicleUID[vehicleid][vUID]][c_Color][1] != color2)
        save = true;
    if(color1 != -1)
        CarData[VehicleUID[vehicleid][vUID]][c_Color][0] = color1;
    if(color2 != -1)
        CarData[VehicleUID[vehicleid][vUID]][c_Color][1] = color2;
    if(save)
        Car_Save(VehicleUID[vehicleid][vUID], CAR_SAVE_TUNE);
    return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
    return 1;
}

public OnDynamicObjectMoved(objectid)
{
	#if DEBUG == 1
		printf("%d OnDynamicObjectMoved - begin", objectid);
	#endif
    if(ScenaCreated)
    {
        if(objectid == ScenaScreenObject)
        {
            Scena_ScreenEffect();
            return 1;
        }
        for(new i=0;i<2;i++)
        {
            if(objectid == ScenaNeonData[SCNeonObj][i])
            {
                if(ScenaNeonData[SCNeonTyp] == 2)
                {
                    ScenaNeonData[SCNeonZderzacz]++;
                    if(ScenaNeonData[SCNeonZderzacz] == 2) Scena_NeonEffect();
                }
                else Scena_NeonEffect();
                return 1;
            }
        }
    }
	#if DEBUG == 1
		printf("%d OnDynamicObjectMoved - end", objectid);
	#endif
    return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	#if DEBUG == 1
		printf("%s[%d] OnVehicleRespray - begin", GetNick(playerid), playerid);
	#endif
    if(CarData[VehicleUID[vehicleid][vUID]][c_Color][0] != color1)
    {
        ChangeVehicleColor(vehicleid, CarData[VehicleUID[vehicleid][vUID]][c_Color][0], CarData[VehicleUID[vehicleid][vUID]][c_Color][1]);
        return 0;
    }
    if(CarData[VehicleUID[vehicleid][vUID]][c_Color][1] != color2)
    {
        ChangeVehicleColor(vehicleid, CarData[VehicleUID[vehicleid][vUID]][c_Color][0], CarData[VehicleUID[vehicleid][vUID]][c_Color][1]);
        return 0;
    }
	#if DEBUG == 1
		printf("%s[%d] OnVehicleRespray - end", GetNick(playerid), playerid);
	#endif
    return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
    if(GetPVarInt(forplayerid, "tognick") == 1)
        ShowPlayerNameTagForPlayer(forplayerid, playerid, 0);

    return 1;
}

WasteDeAMXersTime()
{
    new b;
    #emit load.pri b
    #emit stor.pri b
}

//Koniec.
