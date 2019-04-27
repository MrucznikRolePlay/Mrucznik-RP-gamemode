//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ temat ]-------------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

YCMD:temat(playerid,cmdtext[], help)
{
    if(!((PlayerInfo[playerid][pMember] == 4 && PlayerInfo[playerid][pRank] >= 2) || PlayerInfo[playerid][pLider] == 4)) return SendClientMessage(playerid, COLOR_GRAD1, "   Nie nale¿ysz do LSMC albo nie masz 2 rangi.");
    if(!IsPlayerInRangeOfPoint(playerid, 5.0, 1165.83545, -1378.50378, 25.89570)) return 1;
    new tekscik[64];
    if(sscanf(cmdtext, "s[64]", tekscik)) return SendClientMessage (playerid, 0xAFAFAFAA, "Uzyj: /Temat: [Opisy]");
	if(IsValidDynamicObject(VAR_LSMCTopic)) DestroyDynamicObject(VAR_LSMCTopic);
    VAR_LSMCTopic = CreateDynamicObject(3077, 1165.83545, -1378.50378, 25.89570, 0.00000, 0.00000, 90.00000, 92);
	format (tekscik, sizeof (tekscik), "Temat: %s", tekscik);
    SetDynamicObjectMaterialText(VAR_LSMCTopic, 0, tekscik, OBJECT_MATERIAL_SIZE_512x128, "Comic Sans MS", 40, 0, 0xFF000000, 0xFFFFFFFF, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
    SetDynamicObjectMaterial(VAR_LSMCTopic,1, 8427, "vgs_shops", "vgsclubwall05_128", 0xFFFFFFFF);

   	new Float:Tx,Float:Ty,Float:Tz,ImiePisacza[MAX_PLAYER_NAME+1];
   	GetPlayerPos(playerid,Tx,Ty,Tz);
   	for(new i = 0; i < MAX_PLAYERS; i++)
    {
       	if(IsPlayerInRangeOfPoint(i,15.0,Tx,Ty,Tz))
        {
        	GetPlayerName(playerid,ImiePisacza,sizeof(ImiePisacza));
        	format(tekscik,sizeof(tekscik),"* %s zapisuje nowy temat na tablicy.",ImiePisacza);
        	SendClientMessage(i,0xC2A2DAAA,tekscik);
            Streamer_Update(i);
        }
    }
    return 1;
}
