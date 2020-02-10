/*

iPhone S by adri1 (http://forum.sa-mp.com/member.php?u=106967)

Test: adri1 & Alex15 (http://forum.sa-mp.com/member.php?u=207755)

*/

#include <a_samp>


#define loop(%0,%1,%2) for(new %2 = %0; %2 < %1; %2++)

new Text:TD_iPhone[26];
new Text:TD_iPhone_Clock[2];
new Text:TD_iPhone_Gallery;
new Text:TD_iPhone_Time[3];
new PlayerText:PTD_iPhone_Gallery[MAX_PLAYERS];
new PlayerText:PTD_iPhone[37][MAX_PLAYERS];
new Text:TD_iPhone_GPS;
new PlayerText:PTD_iPhone_GPS[MAX_PLAYERS];
new Text:TD_iPhone_Radio[2];
new Text:TD_iPhone_Music[2];
new Text:TD_iPhone_Map;
new Text:TD_iPhone_Internet[2];
new Text:TD_iPhone_Calculator[16];
new PlayerText:PTD_iPhone_Calculator[MAX_PLAYERS];
new Text:TD_iPhone_Call[13];
new PlayerText:PTD_iPhone_Call[MAX_PLAYERS];
new Text:TD_iPhone_CallYesNo[2];

new var1[MAX_PLAYERS][11];
new var2[MAX_PLAYERS][11];
new called[MAX_PLAYERS][11];
new callto[MAX_PLAYERS];

new firstperson[MAX_PLAYERS];
new iPhone_CC[4][MAX_PLAYERS];
new iPhoneStatus[MAX_PLAYERS];
new iPhoneCallStatus[MAX_PLAYERS];
new MenuX[MAX_PLAYERS];
new MenuY[MAX_PLAYERS];
new UpdateIPHONETimer;

enum pInfo
{
	PhoneNumber
}

new PlayerInfo[MAX_PLAYERS][pInfo];

new Gallery[][] =
{
        "loadsc1:loadsc1",
        "loadsc2:loadsc2",
        "loadsc3:loadsc3",
        "loadsc4:loadsc4",
        "loadsc5:loadsc5",
        "loadsc6:loadsc6",
        "loadsc7:loadsc7",
        "loadsc8:loadsc8",
        "loadsc9:loadsc9",
        "loadsc10:loadsc10",
        "loadsc11:loadsc11",
        "loadsc12:loadsc12",
        "loadsc13:loadsc13",
        "loadsc14:loadsc14"

};

new Radio[][] =
{
        "http://somafm.com/tags.pls",
		"http://bbc.co.uk/radio/listen/live/r1.asx",
		"http://www.listenlive.eu/cadenacope.m3u",
		"http://onair-ha1.krone.at/kronehit-dance.mp3.m3u",
		"http://www.m2radio.fr/pls/m2club.m3u",
		"http://mp3.kataweb.it:8000/M2O.m3u",
		"http://www.listenlive.eu/vrtklara-low.m3u",
		"http://icecast4.play.cz/evropa2-64.mp3.m3u",
		"http://broadcast.infomaniak.net/nrj-low.mp3.m3u"

};

new Music[][] =
{
        "https://dl.dropboxusercontent.com/s/nqxrnokp4zspsw5/Basto%20-%20Again%20and%20Again%20%28Original%20Mix%29.mp3",
		"https://dl.dropboxusercontent.com/s/ln10micl32ys6yj/Blasterjaxx%20%26amp%3B%20Badd%20Dimes%20-%20Titan%20%28Original%20Mix%29.mp3",
		"https://dl.dropboxusercontent.com/s/pj21s5kz5ad5k3d/DVBBS%20%26amp%3B%20Tony%20Junior%20-%20Immortal%20%28Original%20Mix%29.mp3",
		"https://dl.dropboxusercontent.com/s/g1iuqoot6z7qfn7/Martin%20Garrix%20-%20Proxy%20%28FREE%20DOWNLOAD%29.mp3",
		"https://dl.dropboxusercontent.com/s/68htnt08uzgceqr/Martin%20Garrix%20-%20Animals%20%28Original%20Mix%29.mp3",
		"https://dl.dropboxusercontent.com/s/nvzyebx9ydow2ow/Starkillers%20%26%20DJ%20BL3ND%20-%20Xception%20%28Official%20Music%20Video%29.mp3",
		"https://dl.dropboxusercontent.com/s/0iof8iei1qxdc4f/Starkillers%20%26amp%3B%20Inpetto%20-%20Game%20Over%20%28Original%20Mix%29.mp3"

};

enum zoneinfo
{
	zone_name[32],
    Float:zone_minx,
    Float:zone_miny,
    Float:zone_minz,
    Float:zone_maxx,
    Float:zone_maxy,
    Float:zone_maxz
}
new zones[][zoneinfo] = {
{ "Los Santos",                     44.60, -2892.90,  -242.90,  2997.00,  -768.00,   900.00},
{ "Las Venturas",                  869.40,   596.30,  -242.90,  2997.00,  2993.80,   900.00},
{ "Bone County",                  -480.50,   596.30,  -242.90,   869.40,  2993.80,   900.00},
{ "Tierra Robada",               -2997.40,  1659.60,  -242.90,  -480.50,  2993.80,   900.00},
{ "Tierra Robada",               -1213.90,   596.30,  -242.90,  -480.50,  1659.60,   900.00},
{ "San Fierro",                  -2997.40, -1115.50,  -242.90, -1213.90,  1659.60,   900.00},
{ "Red County",                  -1213.90,  -768.00,  -242.90,  2997.00,   596.30,   900.00},
{ "Flint County",                -1213.90, -2892.90,  -242.90,    44.60,  -768.00,   900.00},
{ "Whetstone",                   -2997.40, -2892.90,  -242.90, -1213.90, -1115.50,   900.00}
};

forward UpdateIphone();

public OnFilterScriptInit()
{
	TD_iPhone[0] = TextDrawCreate(507.000183, 195.792556, "ld_pool:ball");
	TextDrawLetterSize(TD_iPhone[0], 0.000000, 0.000000);
	TextDrawTextSize(TD_iPhone[0], 16.000000, 16.000000);
	TextDrawAlignment(TD_iPhone[0], 1);
	TextDrawColor(TD_iPhone[0], -2139062017);
	TextDrawSetShadow(TD_iPhone[0], 0);
	TextDrawSetOutline(TD_iPhone[0], 0);
	TextDrawFont(TD_iPhone[0], 4);

	TD_iPhone[1] = TextDrawCreate(506.666839, 404.199951, "ld_pool:ball");
	TextDrawLetterSize(TD_iPhone[1], 0.000000, 0.000000);
	TextDrawTextSize(TD_iPhone[1], 16.000000, -16.000000);
	TextDrawAlignment(TD_iPhone[1], 1);
	TextDrawColor(TD_iPhone[1], -2139062017);
	TextDrawSetShadow(TD_iPhone[1], 0);
	TextDrawSetOutline(TD_iPhone[1], 0);
	TextDrawFont(TD_iPhone[1], 4);

	TD_iPhone[2] = TextDrawCreate(578.666870, 404.199951, "ld_pool:ball");
	TextDrawLetterSize(TD_iPhone[2], 0.000000, 0.000000);
	TextDrawTextSize(TD_iPhone[2], 16.000000, -16.000000);
	TextDrawAlignment(TD_iPhone[2], 1);
	TextDrawColor(TD_iPhone[2], -2139062017);
	TextDrawSetShadow(TD_iPhone[2], 0);
	TextDrawSetOutline(TD_iPhone[2], 0);
	TextDrawFont(TD_iPhone[2], 4);

	TD_iPhone[3] = TextDrawCreate(578.666870, 195.792541, "ld_pool:ball");
	TextDrawLetterSize(TD_iPhone[3], 0.000000, 0.000000);
	TextDrawTextSize(TD_iPhone[3], 16.000000, 16.000000);
	TextDrawAlignment(TD_iPhone[3], 1);
	TextDrawColor(TD_iPhone[3], -2139062017);
	TextDrawSetShadow(TD_iPhone[3], 0);
	TextDrawSetOutline(TD_iPhone[3], 0);
	TextDrawFont(TD_iPhone[3], 4);

	TD_iPhone[4] = TextDrawCreate(507.000061, 202.844375, "LD_SPAC:white");
	TextDrawLetterSize(TD_iPhone[4], 0.000000, 0.000000);
	TextDrawTextSize(TD_iPhone[4], 87.666656, 194.962951);
	TextDrawAlignment(TD_iPhone[4], 1);
	TextDrawColor(TD_iPhone[4], -2139062017);
	TextDrawSetShadow(TD_iPhone[4], 0);
	TextDrawSetOutline(TD_iPhone[4], 0);
	TextDrawFont(TD_iPhone[4], 4);

	TD_iPhone[5] = TextDrawCreate(513.666564, 195.548095, "LD_SPAC:white");
	TextDrawLetterSize(TD_iPhone[5], 0.000000, 0.000000);
	TextDrawTextSize(TD_iPhone[5], 74.666641, 208.651809);
	TextDrawAlignment(TD_iPhone[5], 1);
	TextDrawColor(TD_iPhone[5], -2139062017);
	TextDrawSetShadow(TD_iPhone[5], 0);
	TextDrawSetOutline(TD_iPhone[5], 0);
	TextDrawFont(TD_iPhone[5], 4);

	TD_iPhone[6] = TextDrawCreate(507.333496, 196.377746, "ld_pool:ball");
	TextDrawLetterSize(TD_iPhone[6], 0.000000, 0.000000);
	TextDrawTextSize(TD_iPhone[6], 16.000000, 16.000000);
	TextDrawAlignment(TD_iPhone[6], 1);
	TextDrawColor(TD_iPhone[6], 255);
	TextDrawSetShadow(TD_iPhone[6], 0);
	TextDrawSetOutline(TD_iPhone[6], 0);
	TextDrawFont(TD_iPhone[6], 4);

	TD_iPhone[7] = TextDrawCreate(507.333496, 403.540649, "ld_pool:ball");
	TextDrawLetterSize(TD_iPhone[7], 0.000000, 0.000000);
	TextDrawTextSize(TD_iPhone[7], 16.000000, -16.000000);
	TextDrawAlignment(TD_iPhone[7], 1);
	TextDrawColor(TD_iPhone[7], 255);
	TextDrawSetShadow(TD_iPhone[7], 0);
	TextDrawSetOutline(TD_iPhone[7], 0);
	TextDrawFont(TD_iPhone[7], 4);

	TD_iPhone[8] = TextDrawCreate(578.000244, 403.540649, "ld_pool:ball");
	TextDrawLetterSize(TD_iPhone[8], 0.000000, 0.000000);
	TextDrawTextSize(TD_iPhone[8], 16.000000, -16.000000);
	TextDrawAlignment(TD_iPhone[8], 1);
	TextDrawColor(TD_iPhone[8], 255);
	TextDrawSetShadow(TD_iPhone[8], 0);
	TextDrawSetOutline(TD_iPhone[8], 0);
	TextDrawFont(TD_iPhone[8], 4);

	TD_iPhone[9] = TextDrawCreate(578.000305, 196.377746, "ld_pool:ball");
	TextDrawLetterSize(TD_iPhone[9], 0.000000, 0.000000);
	TextDrawTextSize(TD_iPhone[9], 16.000000, 16.000000);
	TextDrawAlignment(TD_iPhone[9], 1);
	TextDrawColor(TD_iPhone[9], 255);
	TextDrawSetShadow(TD_iPhone[9], 0);
	TextDrawSetOutline(TD_iPhone[9], 0);
	TextDrawFont(TD_iPhone[9], 4);

	TD_iPhone[10] = TextDrawCreate(514.666809, 196.622222, "LD_SPAC:white");
	TextDrawLetterSize(TD_iPhone[10], 0.000000, 0.000000);
	TextDrawTextSize(TD_iPhone[10], 72.000022, 206.992568);
	TextDrawAlignment(TD_iPhone[10], 1);
	TextDrawColor(TD_iPhone[10], 255);
	TextDrawSetShadow(TD_iPhone[10], 0);
	TextDrawSetOutline(TD_iPhone[10], 0);
	TextDrawFont(TD_iPhone[10], 4);

	TD_iPhone[11] = TextDrawCreate(507.666656, 204.674133, "LD_SPAC:white");
	TextDrawLetterSize(TD_iPhone[11], 0.000000, 0.000000);
	TextDrawTextSize(TD_iPhone[11], 86.333419, 191.229660);
	TextDrawAlignment(TD_iPhone[11], 1);
	TextDrawColor(TD_iPhone[11], 255);
	TextDrawSetShadow(TD_iPhone[11], 0);
	TextDrawSetOutline(TD_iPhone[11], 0);
	TextDrawFont(TD_iPhone[11], 4);

	TD_iPhone[12] = TextDrawCreate(511.333435, 221.925933, "LD_otb:blue");
	TextDrawLetterSize(TD_iPhone[12], 0.000000, 0.000000);
	TextDrawTextSize(TD_iPhone[12], 78.666633, 155.140731);
	TextDrawAlignment(TD_iPhone[12], 1);
	TextDrawColor(TD_iPhone[12], -1768515841);
	TextDrawSetShadow(TD_iPhone[12], 0);
	TextDrawSetOutline(TD_iPhone[12], 0);
	TextDrawFont(TD_iPhone[12], 4);

	TD_iPhone[13] = TextDrawCreate(549.666809, 201.599945, "ld_pool:ball");
	TextDrawLetterSize(TD_iPhone[13], 0.000000, 0.000000);
	TextDrawTextSize(TD_iPhone[13], 3.333292, 4.148138);
	TextDrawAlignment(TD_iPhone[13], 1);
	TextDrawColor(TD_iPhone[13], -2139062142);
	TextDrawSetShadow(TD_iPhone[13], 0);
	TextDrawSetOutline(TD_iPhone[13], 0);
	TextDrawFont(TD_iPhone[13], 4);

	TD_iPhone[14] = TextDrawCreate(544.999877, 209.896240, "ld_poke:cd1d");
	TextDrawLetterSize(TD_iPhone[14], 0.000000, 0.000000);
	TextDrawTextSize(TD_iPhone[14], 12.333331, 2.074084);
	TextDrawAlignment(TD_iPhone[14], 1);
	TextDrawColor(TD_iPhone[14], -2139062142);
	TextDrawSetShadow(TD_iPhone[14], 0);
	TextDrawSetOutline(TD_iPhone[14], 0);
	TextDrawFont(TD_iPhone[14], 4);

	TD_iPhone[15] = TextDrawCreate(541.000366, 210.066589, "ld_pool:ball");
	TextDrawLetterSize(TD_iPhone[15], 0.000000, 0.000000);
	TextDrawTextSize(TD_iPhone[15], 1.333292, 1.244433);
	TextDrawAlignment(TD_iPhone[15], 1);
	TextDrawColor(TD_iPhone[15], -2139062142);
	TextDrawSetShadow(TD_iPhone[15], 0);
	TextDrawSetOutline(TD_iPhone[15], 0);
	TextDrawFont(TD_iPhone[15], 4);

	TD_iPhone[16] = TextDrawCreate(543.333618, 380.311004, "ld_pool:ball");
	TextDrawLetterSize(TD_iPhone[16], 0.000000, 0.000000);
	TextDrawTextSize(TD_iPhone[16], 16.333269, 18.251844);
	TextDrawAlignment(TD_iPhone[16], 1);
	TextDrawColor(TD_iPhone[16], -1061109690);
	TextDrawSetShadow(TD_iPhone[16], 0);
	TextDrawSetOutline(TD_iPhone[16], 0);
	TextDrawFont(TD_iPhone[16], 4);

	TD_iPhone[17] = TextDrawCreate(511.333496, 221.925994, "ld_plan:tvbase");
	TextDrawLetterSize(TD_iPhone[17], 0.000000, 0.000000);
	TextDrawTextSize(TD_iPhone[17], 78.666702, 9.540740);
	TextDrawAlignment(TD_iPhone[17], 1);
	TextDrawColor(TD_iPhone[17], -1);
	TextDrawSetShadow(TD_iPhone[17], 0);
	TextDrawSetOutline(TD_iPhone[17], 0);
	TextDrawFont(TD_iPhone[17], 4);

	TD_iPhone[18] = TextDrawCreate(550.666687, 221.925918, "4G________________00:00");
	TextDrawLetterSize(TD_iPhone[18], 0.194333, 0.865778);
	TextDrawAlignment(TD_iPhone[18], 2);
	TextDrawColor(TD_iPhone[18], -1);
	TextDrawSetShadow(TD_iPhone[18], 0);
	TextDrawSetOutline(TD_iPhone[18], 0);
	TextDrawBackgroundColor(TD_iPhone[18], 51);
	TextDrawFont(TD_iPhone[18], 1);
	TextDrawSetProportional(TD_iPhone[18], 1);

	TD_iPhone[19] = TextDrawCreate(549.999450, 233.125991, "00:00");
	TextDrawLetterSize(TD_iPhone[19], 0.460333, 2.666073);
	TextDrawAlignment(TD_iPhone[19], 2);
	TextDrawColor(TD_iPhone[19], -1);
	TextDrawSetShadow(TD_iPhone[19], 0);
	TextDrawSetOutline(TD_iPhone[19], 0);
	TextDrawBackgroundColor(TD_iPhone[19], 51);
	TextDrawFont(TD_iPhone[19], 2);
	TextDrawSetProportional(TD_iPhone[19], 1);

	TD_iPhone[20] = TextDrawCreate(549.332702, 254.866653, "1 de enero");
	TextDrawLetterSize(TD_iPhone[20], 0.124999, 0.803554);
	TextDrawAlignment(TD_iPhone[20], 2);
	TextDrawColor(TD_iPhone[20], -1);
	TextDrawSetShadow(TD_iPhone[20], 0);
	TextDrawSetOutline(TD_iPhone[20], 0);
	TextDrawBackgroundColor(TD_iPhone[20], 51);
	TextDrawFont(TD_iPhone[20], 1);
	TextDrawSetProportional(TD_iPhone[20], 1);

	TD_iPhone[21] = TextDrawCreate(549.999572, 342.148040, "Presiona ~g~Y ~w~para~n~desbloquear");
	TextDrawLetterSize(TD_iPhone[21], 0.257666, 1.276443);
	TextDrawAlignment(TD_iPhone[21], 2);
	TextDrawColor(TD_iPhone[21], -1);
	TextDrawSetShadow(TD_iPhone[21], 0);
	TextDrawSetOutline(TD_iPhone[21], 0);
	TextDrawBackgroundColor(TD_iPhone[21], 51);
	TextDrawFont(TD_iPhone[21], 1);
	TextDrawSetProportional(TD_iPhone[21], 1);

	TD_iPhone[22] = TextDrawCreate(511.333282, 231.466659, "ld_plan:tvbase");
	TextDrawLetterSize(TD_iPhone[22], 0.000000, 0.000000);
	TextDrawTextSize(TD_iPhone[22], 78.666664, 16.177804);
	TextDrawAlignment(TD_iPhone[22], 1);
	TextDrawColor(TD_iPhone[22], 8388863);
	TextDrawSetShadow(TD_iPhone[22], 0);
	TextDrawSetOutline(TD_iPhone[22], 0);
	TextDrawFont(TD_iPhone[22], 4);

	TD_iPhone[23] = TextDrawCreate(511.333282, 231.466705, "LD_SPAC:white");
	TextDrawLetterSize(TD_iPhone[23], 0.000000, 0.000000);
	TextDrawTextSize(TD_iPhone[23], 78.666656, 1.659255);
	TextDrawAlignment(TD_iPhone[23], 1);
	TextDrawColor(TD_iPhone[23], 16777215);
	TextDrawSetShadow(TD_iPhone[23], 0);
	TextDrawSetOutline(TD_iPhone[23], 0);
	TextDrawFont(TD_iPhone[23], 4);

	TD_iPhone[24] = TextDrawCreate(511.333282, 247.814788, "LD_SPAC:white");
	TextDrawLetterSize(TD_iPhone[24], 0.000000, 0.000000);
	TextDrawTextSize(TD_iPhone[24], 78.666656, 1.659255);
	TextDrawAlignment(TD_iPhone[24], 1);
	TextDrawColor(TD_iPhone[24], 16777215);
	TextDrawSetShadow(TD_iPhone[24], 0);
	TextDrawSetOutline(TD_iPhone[24], 0);
	TextDrawFont(TD_iPhone[24], 4);

	TD_iPhone[25] = TextDrawCreate(511.666900, 344.296508, "ld_plan:tvbase");
	TextDrawLetterSize(TD_iPhone[25], 0.000000, 0.000000);
	TextDrawTextSize(TD_iPhone[25], 78.333389, 33.185237);
	TextDrawAlignment(TD_iPhone[25], 1);
	TextDrawColor(TD_iPhone[25], -1);
	TextDrawSetShadow(TD_iPhone[25], 0);
	TextDrawSetOutline(TD_iPhone[25], 0);
	TextDrawFont(TD_iPhone[25], 4);

	//Clock
	TD_iPhone_Clock[0] = TextDrawCreate(549.633178, 252.551788, "00:00");
	TextDrawLetterSize(TD_iPhone_Clock[0], 0.499667, 2.861037);
	TextDrawAlignment(TD_iPhone_Clock[0], 2);
	TextDrawColor(TD_iPhone_Clock[0], -1);
	TextDrawSetShadow(TD_iPhone_Clock[0], 0);
	TextDrawSetOutline(TD_iPhone_Clock[0], 0);
	TextDrawBackgroundColor(TD_iPhone_Clock[0], 51);
	TextDrawFont(TD_iPhone_Clock[0], 2);
	TextDrawSetProportional(TD_iPhone_Clock[0], 1);

	TD_iPhone_Clock[1] = TextDrawCreate(549.066528, 277.052032, "1 de enero de 1999");
	TextDrawLetterSize(TD_iPhone_Clock[1], 0.124999, 0.803554);
	TextDrawAlignment(TD_iPhone_Clock[1], 2);
	TextDrawColor(TD_iPhone_Clock[1], -1);
	TextDrawSetShadow(TD_iPhone_Clock[1], 0);
	TextDrawSetOutline(TD_iPhone_Clock[1], 0);
	TextDrawBackgroundColor(TD_iPhone_Clock[1], 51);
	TextDrawFont(TD_iPhone_Clock[1], 1);
	TextDrawSetProportional(TD_iPhone_Clock[1], 1);

	//Galeria
	TD_iPhone_Gallery = TextDrawCreate(542.000122, 340.977722, "~<~_Sin titulo.png_~>~");
	TextDrawLetterSize(TD_iPhone_Gallery, 0.202333, 1.069037);
	TextDrawAlignment(TD_iPhone_Gallery, 2);
	TextDrawColor(TD_iPhone_Gallery, -1);
	TextDrawSetShadow(TD_iPhone_Gallery, 0);
	TextDrawSetOutline(TD_iPhone_Gallery, 1);
	TextDrawBackgroundColor(TD_iPhone_Gallery, 255);
	TextDrawFont(TD_iPhone_Gallery, 1);
	TextDrawSetProportional(TD_iPhone_Gallery, 1);

	//Clima
	TD_iPhone_Time[0] = TextDrawCreate(582.999938, 335.585296, "Soleado");
	TextDrawLetterSize(TD_iPhone_Time[0], 0.236999, 0.998518);
	TextDrawAlignment(TD_iPhone_Time[0], 3);
	TextDrawColor(TD_iPhone_Time[0], -1);
	TextDrawSetShadow(TD_iPhone_Time[0], 0);
	TextDrawSetOutline(TD_iPhone_Time[0], 1);
	TextDrawBackgroundColor(TD_iPhone_Time[0], 255);
	TextDrawFont(TD_iPhone_Time[0], 1);
	TextDrawSetProportional(TD_iPhone_Time[0], 1);

	TD_iPhone_Time[1] = TextDrawCreate(518.333312, 258.844390, "LD_SPAC:white");
	TextDrawLetterSize(TD_iPhone_Time[1], 0.000000, 0.000000);
	TextDrawTextSize(TD_iPhone_Time[1], 64.666687, 72.177795);
	TextDrawAlignment(TD_iPhone_Time[1], 1);
	TextDrawColor(TD_iPhone_Time[1], -1);
	TextDrawSetShadow(TD_iPhone_Time[1], 0);
	TextDrawSetOutline(TD_iPhone_Time[1], 0);
	TextDrawFont(TD_iPhone_Time[1], 4);

	TD_iPhone_Time[2] = TextDrawCreate(555.000000, 323.140777, "wheater.com");
	TextDrawLetterSize(TD_iPhone_Time[2], 0.127999, 0.687407);
	TextDrawAlignment(TD_iPhone_Time[2], 1);
	TextDrawColor(TD_iPhone_Time[2], 255);
	TextDrawSetShadow(TD_iPhone_Time[2], 0);
	TextDrawSetOutline(TD_iPhone_Time[2], 0);
	TextDrawBackgroundColor(TD_iPhone_Time[2], 51);
	TextDrawFont(TD_iPhone_Time[2], 1);
	TextDrawSetProportional(TD_iPhone_Time[2], 1);

	//GPS
	TD_iPhone_GPS = TextDrawCreate(547.666870, 253.036956, "Te encuentras en:");
	TextDrawLetterSize(TD_iPhone_GPS, 0.188666, 0.944592);
	TextDrawAlignment(TD_iPhone_GPS, 2);
	TextDrawColor(TD_iPhone_GPS, -1);
	TextDrawSetShadow(TD_iPhone_GPS, 0);
	TextDrawSetOutline(TD_iPhone_GPS, 1);
	TextDrawBackgroundColor(TD_iPhone_GPS, 255);
	TextDrawFont(TD_iPhone_GPS, 1);
	TextDrawSetProportional(TD_iPhone_GPS, 1);

	//Radio
	TD_iPhone_Radio[0] = TextDrawCreate(542.333251, 258.844360, "~<~ EMISORA ~>~");
	TextDrawLetterSize(TD_iPhone_Radio[0], 0.265333, 1.085629);
	TextDrawAlignment(TD_iPhone_Radio[0], 2);
	TextDrawColor(TD_iPhone_Radio[0], -1);
	TextDrawSetShadow(TD_iPhone_Radio[0], 0);
	TextDrawSetOutline(TD_iPhone_Radio[0], 0);
	TextDrawBackgroundColor(TD_iPhone_Radio[0], 51);
	TextDrawFont(TD_iPhone_Radio[0], 1);
	TextDrawSetProportional(TD_iPhone_Radio[0], 1);

	TD_iPhone_Radio[1] = TextDrawCreate(550.999938, 353.592559, "Usa ~g~Y~w~ para apagar");
	TextDrawLetterSize(TD_iPhone_Radio[1], 0.227000, 1.006814);
	TextDrawAlignment(TD_iPhone_Radio[1], 2);
	TextDrawColor(TD_iPhone_Radio[1], -1);
	TextDrawSetShadow(TD_iPhone_Radio[1], 0);
	TextDrawSetOutline(TD_iPhone_Radio[1], 0);
	TextDrawBackgroundColor(TD_iPhone_Radio[1], 51);
	TextDrawFont(TD_iPhone_Radio[1], 1);
	TextDrawSetProportional(TD_iPhone_Radio[1], 1);

	//Musica
	TD_iPhone_Music[0] = TextDrawCreate(542.333251, 258.844360, "~<~ MUSICA ~>~");
	TextDrawLetterSize(TD_iPhone_Music[0], 0.265333, 1.085629);
	TextDrawAlignment(TD_iPhone_Music[0], 2);
	TextDrawColor(TD_iPhone_Music[0], -1);
	TextDrawSetShadow(TD_iPhone_Music[0], 0);
	TextDrawSetOutline(TD_iPhone_Music[0], 0);
	TextDrawBackgroundColor(TD_iPhone_Music[0], 51);
	TextDrawFont(TD_iPhone_Music[0], 1);
	TextDrawSetProportional(TD_iPhone_Music[0], 1);

	TD_iPhone_Music[1] = TextDrawCreate(550.999938, 353.592559, "Usa ~g~Y~w~ para parar");
	TextDrawLetterSize(TD_iPhone_Music[1], 0.227000, 1.006814);
	TextDrawAlignment(TD_iPhone_Music[1], 2);
	TextDrawColor(TD_iPhone_Music[1], -1);
	TextDrawSetShadow(TD_iPhone_Music[1], 0);
	TextDrawSetOutline(TD_iPhone_Music[1], 0);
	TextDrawBackgroundColor(TD_iPhone_Music[1], 51);
	TextDrawFont(TD_iPhone_Music[1], 1);
	TextDrawSetProportional(TD_iPhone_Music[1], 1);

	//Mapa
	TD_iPhone_Map = TextDrawCreate(511.266815, 249.548080, "samaps:map");
	TextDrawLetterSize(TD_iPhone_Map, 0.000000, 0.000000);
	TextDrawTextSize(TD_iPhone_Map, 78.666656, 126.518585);
	TextDrawAlignment(TD_iPhone_Map, 1);
	TextDrawColor(TD_iPhone_Map, -1);
	TextDrawSetShadow(TD_iPhone_Map, 0);
	TextDrawSetOutline(TD_iPhone_Map, 0);
	TextDrawFont(TD_iPhone_Map, 4);

	//Internet
	TD_iPhone_Internet[0] = TextDrawCreate(550.666748, 326.459228, "Servicio en mantenimiento...~n~Disculpe las moletias");
	TextDrawLetterSize(TD_iPhone_Internet[0], 0.151000, 0.836741);
	TextDrawAlignment(TD_iPhone_Internet[0], 2);
	TextDrawColor(TD_iPhone_Internet[0], -1);
	TextDrawSetShadow(TD_iPhone_Internet[0], 0);
	TextDrawSetOutline(TD_iPhone_Internet[0], 1);
	TextDrawBackgroundColor(TD_iPhone_Internet[0], 255);
	TextDrawFont(TD_iPhone_Internet[0], 1);
	TextDrawSetProportional(TD_iPhone_Internet[0], 1);

	TD_iPhone_Internet[1] = TextDrawCreate(515.333374, 261.748046, "404");
	TextDrawLetterSize(TD_iPhone_Internet[1], 0.858666, 7.237334);
	TextDrawAlignment(TD_iPhone_Internet[1], 1);
	TextDrawColor(TD_iPhone_Internet[1], -1);
	TextDrawSetShadow(TD_iPhone_Internet[1], 0);
	TextDrawSetOutline(TD_iPhone_Internet[1], 0);
	TextDrawBackgroundColor(TD_iPhone_Internet[1], 51);
	TextDrawFont(TD_iPhone_Internet[1], 2);
	TextDrawSetProportional(TD_iPhone_Internet[1], 1);

	//Calculadora
	TD_iPhone_Calculator[0] = TextDrawCreate(522.900268, 354.604370, "0");
	TextDrawLetterSize(TD_iPhone_Calculator[0], 0.271333, 1.359405);
	TextDrawTextSize(TD_iPhone_Calculator[0], 10.0, 10.370368);
	TextDrawAlignment(TD_iPhone_Calculator[0], 2);
	TextDrawColor(TD_iPhone_Calculator[0], -1);
	TextDrawUseBox(TD_iPhone_Calculator[0], true);
	TextDrawBoxColor(TD_iPhone_Calculator[0], -2139062017);
	TextDrawSetShadow(TD_iPhone_Calculator[0], 0);
	TextDrawSetOutline(TD_iPhone_Calculator[0], 0);
	TextDrawBackgroundColor(TD_iPhone_Calculator[0], 51);
	TextDrawFont(TD_iPhone_Calculator[0], 1);
	TextDrawSetProportional(TD_iPhone_Calculator[0], 1);
	TextDrawSetSelectable(TD_iPhone_Calculator[0], true);

	TD_iPhone_Calculator[1] = TextDrawCreate(549.300354, 354.604370, "=");
	TextDrawLetterSize(TD_iPhone_Calculator[1], 0.271333, 1.359405);
	TextDrawTextSize(TD_iPhone_Calculator[1], 51.000000, 29.037044);
	TextDrawAlignment(TD_iPhone_Calculator[1], 2);
	TextDrawColor(TD_iPhone_Calculator[1], -1);
	TextDrawUseBox(TD_iPhone_Calculator[1], true);
	TextDrawBoxColor(TD_iPhone_Calculator[1], -2139062017);
	TextDrawSetShadow(TD_iPhone_Calculator[1], 0);
	TextDrawSetOutline(TD_iPhone_Calculator[1], 0);
	TextDrawBackgroundColor(TD_iPhone_Calculator[1], 51);
	TextDrawFont(TD_iPhone_Calculator[1], 1);
	TextDrawSetProportional(TD_iPhone_Calculator[1], 1);
	TextDrawSetSelectable(TD_iPhone_Calculator[1], true);

	TD_iPhone_Calculator[2] = TextDrawCreate(522.900268, 333.204071, "1");
	TextDrawLetterSize(TD_iPhone_Calculator[2], 0.271333, 1.359405);
	TextDrawTextSize(TD_iPhone_Calculator[2], 10.0, 10.370368);
	TextDrawAlignment(TD_iPhone_Calculator[2], 2);
	TextDrawColor(TD_iPhone_Calculator[2], -1);
	TextDrawUseBox(TD_iPhone_Calculator[2], true);
	TextDrawBoxColor(TD_iPhone_Calculator[2], -2139062017);
	TextDrawSetShadow(TD_iPhone_Calculator[2], 0);
	TextDrawSetOutline(TD_iPhone_Calculator[2], 0);
	TextDrawBackgroundColor(TD_iPhone_Calculator[2], 51);
	TextDrawFont(TD_iPhone_Calculator[2], 1);
	TextDrawSetProportional(TD_iPhone_Calculator[2], 1);
	TextDrawSetSelectable(TD_iPhone_Calculator[2], true);

	TD_iPhone_Calculator[3] = TextDrawCreate(540.233581, 333.204071, "2");
	TextDrawLetterSize(TD_iPhone_Calculator[3], 0.271333, 1.359405);
	TextDrawTextSize(TD_iPhone_Calculator[3], 10.0, 10.370368);
	TextDrawAlignment(TD_iPhone_Calculator[3], 2);
	TextDrawColor(TD_iPhone_Calculator[3], -1);
	TextDrawUseBox(TD_iPhone_Calculator[3], true);
	TextDrawBoxColor(TD_iPhone_Calculator[3], -2139062017);
	TextDrawSetShadow(TD_iPhone_Calculator[3], 0);
	TextDrawSetOutline(TD_iPhone_Calculator[3], 0);
	TextDrawBackgroundColor(TD_iPhone_Calculator[3], 51);
	TextDrawFont(TD_iPhone_Calculator[3], 1);
	TextDrawSetProportional(TD_iPhone_Calculator[3], 1);
	TextDrawSetSelectable(TD_iPhone_Calculator[3], true);

	TD_iPhone_Calculator[4] = TextDrawCreate(557.900207, 333.204071, "3");
	TextDrawLetterSize(TD_iPhone_Calculator[4], 0.271333, 1.359405);
	TextDrawTextSize(TD_iPhone_Calculator[4], 10.0, 10.370368);
	TextDrawAlignment(TD_iPhone_Calculator[4], 2);
	TextDrawColor(TD_iPhone_Calculator[4], -1);
	TextDrawUseBox(TD_iPhone_Calculator[4], true);
	TextDrawBoxColor(TD_iPhone_Calculator[4], -2139062017);
	TextDrawSetShadow(TD_iPhone_Calculator[4], 0);
	TextDrawSetOutline(TD_iPhone_Calculator[4], 0);
	TextDrawBackgroundColor(TD_iPhone_Calculator[4], 51);
	TextDrawFont(TD_iPhone_Calculator[4], 1);
	TextDrawSetProportional(TD_iPhone_Calculator[4], 1);
	TextDrawSetSelectable(TD_iPhone_Calculator[4], true);

	TD_iPhone_Calculator[5] = TextDrawCreate(522.900268, 311.803771, "4");
	TextDrawLetterSize(TD_iPhone_Calculator[5], 0.271333, 1.359405);
	TextDrawTextSize(TD_iPhone_Calculator[5], 10.0, 10.370368);
	TextDrawAlignment(TD_iPhone_Calculator[5], 2);
	TextDrawColor(TD_iPhone_Calculator[5], -1);
	TextDrawUseBox(TD_iPhone_Calculator[5], true);
	TextDrawBoxColor(TD_iPhone_Calculator[5], -2139062017);
	TextDrawSetShadow(TD_iPhone_Calculator[5], 0);
	TextDrawSetOutline(TD_iPhone_Calculator[5], 0);
	TextDrawBackgroundColor(TD_iPhone_Calculator[5], 51);
	TextDrawFont(TD_iPhone_Calculator[5], 1);
	TextDrawSetProportional(TD_iPhone_Calculator[5], 1);
	TextDrawSetSelectable(TD_iPhone_Calculator[5], true);

	TD_iPhone_Calculator[6] = TextDrawCreate(540.233581, 311.803771, "5");
	TextDrawLetterSize(TD_iPhone_Calculator[6], 0.271333, 1.359405);
	TextDrawTextSize(TD_iPhone_Calculator[6], 10.0, 10.370368);
	TextDrawAlignment(TD_iPhone_Calculator[6], 2);
	TextDrawColor(TD_iPhone_Calculator[6], -1);
	TextDrawUseBox(TD_iPhone_Calculator[6], true);
	TextDrawBoxColor(TD_iPhone_Calculator[6], -2139062017);
	TextDrawSetShadow(TD_iPhone_Calculator[6], 0);
	TextDrawSetOutline(TD_iPhone_Calculator[6], 0);
	TextDrawBackgroundColor(TD_iPhone_Calculator[6], 51);
	TextDrawFont(TD_iPhone_Calculator[6], 1);
	TextDrawSetProportional(TD_iPhone_Calculator[6], 1);
	TextDrawSetSelectable(TD_iPhone_Calculator[6], true);

	TD_iPhone_Calculator[7] = TextDrawCreate(557.900207, 311.803771, "6");
	TextDrawLetterSize(TD_iPhone_Calculator[7], 0.271333, 1.359405);
	TextDrawTextSize(TD_iPhone_Calculator[7], 10.0, 10.370368);
	TextDrawAlignment(TD_iPhone_Calculator[7], 2);
	TextDrawColor(TD_iPhone_Calculator[7], -1);
	TextDrawUseBox(TD_iPhone_Calculator[7], true);
	TextDrawBoxColor(TD_iPhone_Calculator[7], -2139062017);
	TextDrawSetShadow(TD_iPhone_Calculator[7], 0);
	TextDrawSetOutline(TD_iPhone_Calculator[7], 0);
	TextDrawBackgroundColor(TD_iPhone_Calculator[7], 51);
	TextDrawFont(TD_iPhone_Calculator[7], 1);
	TextDrawSetProportional(TD_iPhone_Calculator[7], 1);
	TextDrawSetSelectable(TD_iPhone_Calculator[7], true);

	TD_iPhone_Calculator[8] = TextDrawCreate(522.900268, 290.403472, "7");
	TextDrawLetterSize(TD_iPhone_Calculator[8], 0.271333, 1.359405);
	TextDrawTextSize(TD_iPhone_Calculator[8], 10.0, 10.370368);
	TextDrawAlignment(TD_iPhone_Calculator[8], 2);
	TextDrawColor(TD_iPhone_Calculator[8], -1);
	TextDrawUseBox(TD_iPhone_Calculator[8], true);
	TextDrawBoxColor(TD_iPhone_Calculator[8], -2139062017);
	TextDrawSetShadow(TD_iPhone_Calculator[8], 0);
	TextDrawSetOutline(TD_iPhone_Calculator[8], 0);
	TextDrawBackgroundColor(TD_iPhone_Calculator[8], 51);
	TextDrawFont(TD_iPhone_Calculator[8], 1);
	TextDrawSetProportional(TD_iPhone_Calculator[8], 1);
	TextDrawSetSelectable(TD_iPhone_Calculator[8], true);

	TD_iPhone_Calculator[9] = TextDrawCreate(540.233581, 290.403472, "8");
	TextDrawLetterSize(TD_iPhone_Calculator[9], 0.271333, 1.359405);
	TextDrawTextSize(TD_iPhone_Calculator[9], 10.0, 10.370368);
	TextDrawAlignment(TD_iPhone_Calculator[9], 2);
	TextDrawColor(TD_iPhone_Calculator[9], -1);
	TextDrawUseBox(TD_iPhone_Calculator[9], true);
	TextDrawBoxColor(TD_iPhone_Calculator[9], -2139062017);
	TextDrawSetShadow(TD_iPhone_Calculator[9], 0);
	TextDrawSetOutline(TD_iPhone_Calculator[9], 0);
	TextDrawBackgroundColor(TD_iPhone_Calculator[9], 51);
	TextDrawFont(TD_iPhone_Calculator[9], 1);
	TextDrawSetProportional(TD_iPhone_Calculator[9], 1);
	TextDrawSetSelectable(TD_iPhone_Calculator[9], true);

	TD_iPhone_Calculator[10] = TextDrawCreate(557.900207, 290.403472, "9");
	TextDrawLetterSize(TD_iPhone_Calculator[10], 0.271333, 1.359405);
	TextDrawTextSize(TD_iPhone_Calculator[10], 10.0, 10.370368);
	TextDrawAlignment(TD_iPhone_Calculator[10], 2);
	TextDrawColor(TD_iPhone_Calculator[10], -1);
	TextDrawUseBox(TD_iPhone_Calculator[10], true);
	TextDrawBoxColor(TD_iPhone_Calculator[10], -2139062017);
	TextDrawSetShadow(TD_iPhone_Calculator[10], 0);
	TextDrawSetOutline(TD_iPhone_Calculator[10], 0);
	TextDrawBackgroundColor(TD_iPhone_Calculator[10], 51);
	TextDrawFont(TD_iPhone_Calculator[10], 1);
	TextDrawSetProportional(TD_iPhone_Calculator[10], 1);
	TextDrawSetSelectable(TD_iPhone_Calculator[10], true);

	TD_iPhone_Calculator[11] = TextDrawCreate(577.899597, 290.403472, "/");
	TextDrawLetterSize(TD_iPhone_Calculator[11], 0.271333, 1.359405);
	TextDrawTextSize(TD_iPhone_Calculator[11], 10.0, 10.370368);
	TextDrawAlignment(TD_iPhone_Calculator[11], 2);
	TextDrawColor(TD_iPhone_Calculator[11], -1);
	TextDrawUseBox(TD_iPhone_Calculator[11], true);
	TextDrawBoxColor(TD_iPhone_Calculator[11], -2139062017);
	TextDrawSetShadow(TD_iPhone_Calculator[11], 0);
	TextDrawSetOutline(TD_iPhone_Calculator[11], 0);
	TextDrawBackgroundColor(TD_iPhone_Calculator[11], 51);
	TextDrawFont(TD_iPhone_Calculator[11], 1);
	TextDrawSetProportional(TD_iPhone_Calculator[11], 1);
	TextDrawSetSelectable(TD_iPhone_Calculator[11], true);

	TD_iPhone_Calculator[12] = TextDrawCreate(577.899597, 311.803771, "x");
	TextDrawLetterSize(TD_iPhone_Calculator[12], 0.271333, 1.359405);
	TextDrawTextSize(TD_iPhone_Calculator[12], 10.0, 10.370368);
	TextDrawAlignment(TD_iPhone_Calculator[12], 2);
	TextDrawColor(TD_iPhone_Calculator[12], -1);
	TextDrawUseBox(TD_iPhone_Calculator[12], true);
	TextDrawBoxColor(TD_iPhone_Calculator[12], -2139062017);
	TextDrawSetShadow(TD_iPhone_Calculator[12], 0);
	TextDrawSetOutline(TD_iPhone_Calculator[12], 0);
	TextDrawBackgroundColor(TD_iPhone_Calculator[12], 51);
	TextDrawFont(TD_iPhone_Calculator[12], 1);
	TextDrawSetProportional(TD_iPhone_Calculator[12], 1);
	TextDrawSetSelectable(TD_iPhone_Calculator[12], true);

	TD_iPhone_Calculator[13] = TextDrawCreate(577.899597, 333.204071, "-");
	TextDrawLetterSize(TD_iPhone_Calculator[13], 0.271333, 1.359405);
	TextDrawTextSize(TD_iPhone_Calculator[13], 10.0, 10.370368);
	TextDrawAlignment(TD_iPhone_Calculator[13], 2);
	TextDrawColor(TD_iPhone_Calculator[13], -1);
	TextDrawUseBox(TD_iPhone_Calculator[13], true);
	TextDrawBoxColor(TD_iPhone_Calculator[13], -2139062017);
	TextDrawSetShadow(TD_iPhone_Calculator[13], 0);
	TextDrawSetOutline(TD_iPhone_Calculator[13], 0);
	TextDrawBackgroundColor(TD_iPhone_Calculator[13], 51);
	TextDrawFont(TD_iPhone_Calculator[13], 1);
	TextDrawSetProportional(TD_iPhone_Calculator[13], 1);
	TextDrawSetSelectable(TD_iPhone_Calculator[13], true);

	TD_iPhone_Calculator[14] = TextDrawCreate(577.899597, 354.604370, "+");
	TextDrawLetterSize(TD_iPhone_Calculator[14], 0.271333, 1.359405);
	TextDrawTextSize(TD_iPhone_Calculator[14], 10.0, 10.370368);
	TextDrawAlignment(TD_iPhone_Calculator[14], 2);
	TextDrawColor(TD_iPhone_Calculator[14], -1);
	TextDrawUseBox(TD_iPhone_Calculator[14], true);
	TextDrawBoxColor(TD_iPhone_Calculator[14], -2139062017);
	TextDrawSetShadow(TD_iPhone_Calculator[14], 0);
	TextDrawSetOutline(TD_iPhone_Calculator[14], 0);
	TextDrawBackgroundColor(TD_iPhone_Calculator[14], 51);
	TextDrawFont(TD_iPhone_Calculator[14], 1);
	TextDrawSetProportional(TD_iPhone_Calculator[14], 1);
	TextDrawSetSelectable(TD_iPhone_Calculator[14], true);

	TD_iPhone_Calculator[15] = TextDrawCreate(516.666625, 255.940597, "LD_SPAC:white");
	TextDrawLetterSize(TD_iPhone_Calculator[15], 0.000000, 0.000000);
	TextDrawTextSize(TD_iPhone_Calculator[15], 67.999954, 26.962947);
	TextDrawAlignment(TD_iPhone_Calculator[15], 1);
	TextDrawColor(TD_iPhone_Calculator[15], -2139062017);
	TextDrawSetShadow(TD_iPhone_Calculator[15], 0);
	TextDrawSetOutline(TD_iPhone_Calculator[15], 0);
	TextDrawFont(TD_iPhone_Calculator[15], 4);

	//Call
	TD_iPhone_Call[0] = TextDrawCreate(511.333312, 278.755523, "LD_SPAC:white");
	TextDrawLetterSize(TD_iPhone_Call[0], 0.000000, 0.000000);
	TextDrawTextSize(TD_iPhone_Call[0], 78.333259, 98.725921);
	TextDrawAlignment(TD_iPhone_Call[0], 1);
	TextDrawColor(TD_iPhone_Call[0], -2041184257);
	TextDrawSetShadow(TD_iPhone_Call[0], 0);
	TextDrawSetOutline(TD_iPhone_Call[0], 0);
	TextDrawFont(TD_iPhone_Call[0], 4);

	TD_iPhone_Call[1] = TextDrawCreate(524.999877, 282.488739, "1");
	TextDrawLetterSize(TD_iPhone_Call[1], 0.449999, 1.600000);
	TextDrawTextSize(TD_iPhone_Call[1], 10.0, 22.399999);
	TextDrawAlignment(TD_iPhone_Call[1], 2);
	TextDrawColor(TD_iPhone_Call[1], -1);
	TextDrawUseBox(TD_iPhone_Call[1], true);
	TextDrawBoxColor(TD_iPhone_Call[1], 0);
	TextDrawSetShadow(TD_iPhone_Call[1], 0);
	TextDrawSetOutline(TD_iPhone_Call[1], 0);
	TextDrawBackgroundColor(TD_iPhone_Call[1], 51);
	TextDrawFont(TD_iPhone_Call[1], 1);
	TextDrawSetProportional(TD_iPhone_Call[1], 1);
    TextDrawSetSelectable(TD_iPhone_Call[1], true);

	TD_iPhone_Call[2] = TextDrawCreate(549.999328, 282.244262, "2");
	TextDrawLetterSize(TD_iPhone_Call[2], 0.449999, 1.600000);
	TextDrawTextSize(TD_iPhone_Call[2], 10.0, 22.399999);
	TextDrawAlignment(TD_iPhone_Call[2], 2);
	TextDrawColor(TD_iPhone_Call[2], -1);
	TextDrawUseBox(TD_iPhone_Call[2], true);
	TextDrawBoxColor(TD_iPhone_Call[2], 0);
	TextDrawSetShadow(TD_iPhone_Call[2], 0);
	TextDrawSetOutline(TD_iPhone_Call[2], 0);
	TextDrawBackgroundColor(TD_iPhone_Call[2], 51);
	TextDrawFont(TD_iPhone_Call[2], 1);
	TextDrawSetProportional(TD_iPhone_Call[2], 1);
    TextDrawSetSelectable(TD_iPhone_Call[2], true);

	TD_iPhone_Call[3] = TextDrawCreate(574.999084, 282.414581, "3");
	TextDrawLetterSize(TD_iPhone_Call[3], 0.449999, 1.600000);
	TextDrawTextSize(TD_iPhone_Call[3], 10.0, 22.399999);
	TextDrawAlignment(TD_iPhone_Call[3], 2);
	TextDrawColor(TD_iPhone_Call[3], -1);
	TextDrawUseBox(TD_iPhone_Call[3], true);
	TextDrawBoxColor(TD_iPhone_Call[3], 0);
	TextDrawSetShadow(TD_iPhone_Call[3], 0);
	TextDrawSetOutline(TD_iPhone_Call[3], 0);
	TextDrawBackgroundColor(TD_iPhone_Call[3], 51);
	TextDrawFont(TD_iPhone_Call[3], 1);
	TextDrawSetProportional(TD_iPhone_Call[3], 1);
    TextDrawSetSelectable(TD_iPhone_Call[3], true);

	TD_iPhone_Call[4] = TextDrawCreate(524.999877, 304.229614, "4");
	TextDrawLetterSize(TD_iPhone_Call[4], 0.449999, 1.600000);
	TextDrawTextSize(TD_iPhone_Call[4], 10.0, 22.399999);
	TextDrawAlignment(TD_iPhone_Call[4], 2);
	TextDrawColor(TD_iPhone_Call[4], -1);
	TextDrawUseBox(TD_iPhone_Call[4], true);
	TextDrawBoxColor(TD_iPhone_Call[4], 0);
	TextDrawSetShadow(TD_iPhone_Call[4], 0);
	TextDrawSetOutline(TD_iPhone_Call[4], 0);
	TextDrawBackgroundColor(TD_iPhone_Call[4], 51);
	TextDrawFont(TD_iPhone_Call[4], 1);
	TextDrawSetProportional(TD_iPhone_Call[4], 1);
	TextDrawSetSelectable(TD_iPhone_Call[4], true);

	TD_iPhone_Call[5] = TextDrawCreate(549.999328, 304.229614, "5");
	TextDrawLetterSize(TD_iPhone_Call[5], 0.449999, 1.600000);
	TextDrawTextSize(TD_iPhone_Call[5], 10.0, 22.399999);
	TextDrawAlignment(TD_iPhone_Call[5], 2);
	TextDrawColor(TD_iPhone_Call[5], -1);
	TextDrawUseBox(TD_iPhone_Call[5], true);
	TextDrawBoxColor(TD_iPhone_Call[5], 0);
	TextDrawSetShadow(TD_iPhone_Call[5], 0);
	TextDrawSetOutline(TD_iPhone_Call[5], 0);
	TextDrawBackgroundColor(TD_iPhone_Call[5], 51);
	TextDrawFont(TD_iPhone_Call[5], 1);
	TextDrawSetProportional(TD_iPhone_Call[5], 1);
	TextDrawSetSelectable(TD_iPhone_Call[5], true);

	TD_iPhone_Call[6] = TextDrawCreate(574.999084, 304.229614, "6");
	TextDrawLetterSize(TD_iPhone_Call[6], 0.449999, 1.600000);
	TextDrawTextSize(TD_iPhone_Call[6], 10.0, 22.399999);
	TextDrawAlignment(TD_iPhone_Call[6], 2);
	TextDrawColor(TD_iPhone_Call[6], -1);
	TextDrawUseBox(TD_iPhone_Call[6], true);
	TextDrawBoxColor(TD_iPhone_Call[6], 0);
	TextDrawSetShadow(TD_iPhone_Call[6], 0);
	TextDrawSetOutline(TD_iPhone_Call[6], 0);
	TextDrawBackgroundColor(TD_iPhone_Call[6], 51);
	TextDrawFont(TD_iPhone_Call[6], 1);
	TextDrawSetProportional(TD_iPhone_Call[6], 1);
	TextDrawSetSelectable(TD_iPhone_Call[6], true);

	TD_iPhone_Call[7] = TextDrawCreate(524.999877, 326.800170, "7");
	TextDrawLetterSize(TD_iPhone_Call[7], 0.449999, 1.600000);
	TextDrawTextSize(TD_iPhone_Call[7], 10.0, 22.399999);
	TextDrawAlignment(TD_iPhone_Call[7], 2);
	TextDrawColor(TD_iPhone_Call[7], -1);
	TextDrawUseBox(TD_iPhone_Call[7], true);
	TextDrawBoxColor(TD_iPhone_Call[7], 0);
	TextDrawSetShadow(TD_iPhone_Call[7], 0);
	TextDrawSetOutline(TD_iPhone_Call[7], 0);
	TextDrawBackgroundColor(TD_iPhone_Call[7], 51);
	TextDrawFont(TD_iPhone_Call[7], 1);
	TextDrawSetProportional(TD_iPhone_Call[7], 1);
	TextDrawSetSelectable(TD_iPhone_Call[7], true);

	TD_iPhone_Call[8] = TextDrawCreate(549.999328, 326.800170, "8");
	TextDrawLetterSize(TD_iPhone_Call[8], 0.449999, 1.600000);
	TextDrawTextSize(TD_iPhone_Call[8], 10.0, 22.399999);
	TextDrawAlignment(TD_iPhone_Call[8], 2);
	TextDrawColor(TD_iPhone_Call[8], -1);
	TextDrawUseBox(TD_iPhone_Call[8], true);
	TextDrawBoxColor(TD_iPhone_Call[8], 0);
	TextDrawSetShadow(TD_iPhone_Call[8], 0);
	TextDrawSetOutline(TD_iPhone_Call[8], 0);
	TextDrawBackgroundColor(TD_iPhone_Call[8], 51);
	TextDrawFont(TD_iPhone_Call[8], 1);
	TextDrawSetProportional(TD_iPhone_Call[8], 1);
	TextDrawSetSelectable(TD_iPhone_Call[8], true);

	TD_iPhone_Call[9] = TextDrawCreate(574.999084, 326.800170, "9");
	TextDrawLetterSize(TD_iPhone_Call[9], 0.449999, 1.600000);
	TextDrawTextSize(TD_iPhone_Call[9], 10.0, 22.399999);
	TextDrawAlignment(TD_iPhone_Call[9], 2);
	TextDrawColor(TD_iPhone_Call[9], -1);
	TextDrawUseBox(TD_iPhone_Call[9], true);
	TextDrawBoxColor(TD_iPhone_Call[9], 0);
	TextDrawSetShadow(TD_iPhone_Call[9], 0);
	TextDrawSetOutline(TD_iPhone_Call[9], 0);
	TextDrawBackgroundColor(TD_iPhone_Call[9], 51);
	TextDrawFont(TD_iPhone_Call[9], 1);
	TextDrawSetProportional(TD_iPhone_Call[9], 1);
	TextDrawSetSelectable(TD_iPhone_Call[9], true);

	TD_iPhone_Call[10] = TextDrawCreate(549.999328, 349.370727, "0");
	TextDrawLetterSize(TD_iPhone_Call[10], 0.449999, 1.600000);
	TextDrawTextSize(TD_iPhone_Call[10], 10.0, 22.399999);
	TextDrawAlignment(TD_iPhone_Call[10], 2);
	TextDrawColor(TD_iPhone_Call[10], -1);
	TextDrawUseBox(TD_iPhone_Call[10], true);
	TextDrawBoxColor(TD_iPhone_Call[10], 0);
	TextDrawSetShadow(TD_iPhone_Call[10], 0);
	TextDrawSetOutline(TD_iPhone_Call[10], 0);
	TextDrawBackgroundColor(TD_iPhone_Call[10], 51);
	TextDrawFont(TD_iPhone_Call[10], 1);
	TextDrawSetProportional(TD_iPhone_Call[10], 1);
	TextDrawSetSelectable(TD_iPhone_Call[10], true);

	TD_iPhone_Call[11] = TextDrawCreate(524.999877, 349.370727, "C");
	TextDrawLetterSize(TD_iPhone_Call[11], 0.449999, 1.600000);
	TextDrawTextSize(TD_iPhone_Call[11], 10.0, 22.399999);
	TextDrawAlignment(TD_iPhone_Call[11], 2);
	TextDrawColor(TD_iPhone_Call[11], -1);
	TextDrawUseBox(TD_iPhone_Call[11], true);
	TextDrawBoxColor(TD_iPhone_Call[11], 0);
	TextDrawSetShadow(TD_iPhone_Call[11], 0);
	TextDrawSetOutline(TD_iPhone_Call[11], 0);
	TextDrawBackgroundColor(TD_iPhone_Call[11], 51);
	TextDrawFont(TD_iPhone_Call[11], 1);
	TextDrawSetProportional(TD_iPhone_Call[11], 1);
	TextDrawSetSelectable(TD_iPhone_Call[11], true);

	TD_iPhone_Call[12] = TextDrawCreate(574.999084, 349.370727, "D");
	TextDrawLetterSize(TD_iPhone_Call[12], 0.449999, 1.600000);
	TextDrawTextSize(TD_iPhone_Call[12], 10.0, 22.399999);
	TextDrawAlignment(TD_iPhone_Call[12], 2);
	TextDrawColor(TD_iPhone_Call[12], -1);
	TextDrawUseBox(TD_iPhone_Call[12], true);
	TextDrawBoxColor(TD_iPhone_Call[12], 0);
	TextDrawSetShadow(TD_iPhone_Call[12], 0);
	TextDrawSetOutline(TD_iPhone_Call[12], 0);
	TextDrawBackgroundColor(TD_iPhone_Call[12], 51);
	TextDrawFont(TD_iPhone_Call[12], 1);
	TextDrawSetProportional(TD_iPhone_Call[12], 1);
	TextDrawSetSelectable(TD_iPhone_Call[12], true);

	//Call YES/NO
	TD_iPhone_CallYesNo[0] = TextDrawCreate(534.333129, 320.651794, "N");
	TextDrawLetterSize(TD_iPhone_CallYesNo[0], 0.449999, 1.600000);
	TextDrawTextSize(TD_iPhone_CallYesNo[0], 5.000000, 20.325927);
	TextDrawAlignment(TD_iPhone_CallYesNo[0], 2);
	TextDrawColor(TD_iPhone_CallYesNo[0], -1);
	TextDrawUseBox(TD_iPhone_CallYesNo[0], true);
	TextDrawBoxColor(TD_iPhone_CallYesNo[0], 2080375039);
	TextDrawSetShadow(TD_iPhone_CallYesNo[0], 0);
	TextDrawSetOutline(TD_iPhone_CallYesNo[0], 0);
	TextDrawBackgroundColor(TD_iPhone_CallYesNo[0], 51);
	TextDrawFont(TD_iPhone_CallYesNo[0], 1);
	TextDrawSetProportional(TD_iPhone_CallYesNo[0], 1);

	TD_iPhone_CallYesNo[1] = TextDrawCreate(563.666198, 320.651794, "Y");
	TextDrawLetterSize(TD_iPhone_CallYesNo[1], 0.449999, 1.600000);
	TextDrawTextSize(TD_iPhone_CallYesNo[1], 5.000000, 20.325927);
	TextDrawAlignment(TD_iPhone_CallYesNo[1], 2);
	TextDrawColor(TD_iPhone_CallYesNo[1], -1);
	TextDrawUseBox(TD_iPhone_CallYesNo[1], true);
	TextDrawBoxColor(TD_iPhone_CallYesNo[1], 8388863);
	TextDrawSetShadow(TD_iPhone_CallYesNo[1], 0);
	TextDrawSetOutline(TD_iPhone_CallYesNo[1], 0);
	TextDrawBackgroundColor(TD_iPhone_CallYesNo[1], 51);
	TextDrawFont(TD_iPhone_CallYesNo[1], 1);
	TextDrawSetProportional(TD_iPhone_CallYesNo[1], 1);

	UpdateIphone();
	UpdateIPHONETimer = SetTimer("UpdateIphone", 60000, true);
	return 1;
}

#pragma unused UpdateIPHONETimer
/*
public OnFilterScriptExit()
{
	for(new i = 0; i != MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        MenuX[i] = 1;
    		MenuY[i] = 1;
            iPhoneStatus[i] = 0;
            iPhone_CC[0][i] = 0;
			iPhone_CC[1][i] = 0;
			iPhone_CC[2][i] = 0;
			iPhone_CC[3][i] = 0;
			var1[i] = "";
    		var2[i] = "";
    		called[i] = "";
            DeletePVar(i,"tovar");
	        DestroyPlayerIphone(i);
	    }
	}
	loop(0, sizeof(TD_iPhone), PHONE) TextDrawDestroy(TD_iPhone[PHONE]);
	KillTimer(UpdateIPHONETimer);
	return 1;
}
*/

public UpdateIphone()
{
	new Hour, Minute;
	gettime(Hour, Minute);
	new str[64];
	format(str,sizeof(str),"4G________________%02d:%02d",Hour,Minute);
	TextDrawSetString(TD_iPhone[18], str);
	format(str,sizeof(str),"%02d:%02d",Hour,Minute);
	TextDrawSetString(TD_iPhone_Clock[0], str);
	TextDrawSetString(TD_iPhone[19], str);

	new Year, Month, Day;
	getdate(Year, Month, Day);
	format(str,sizeof(str),"%02d de %s de %d",Day, GetMonth(Month), Year);
	TextDrawSetString(TD_iPhone[20], str);
	TextDrawSetString(TD_iPhone_Clock[1], str);
	ActualizarTiempo();
	return 1;
}

stock ActualizarTiempo()
{
 	new weather[64],idwea;
	GetServerVarAsString("weather", weather, sizeof(weather));
	idwea = strval(weather);
	if(idwea >= 0 && idwea <= 7) TextDrawSetString(TD_iPhone_Time[0],"Soleado");
	else if(idwea == 8) TextDrawSetString(TD_iPhone_Time[0],"Tormentoso");
	else if(idwea == 9) TextDrawSetString(TD_iPhone_Time[0],"Niebla");
	else if(idwea == 10) TextDrawSetString(TD_iPhone_Time[0],"Soleado");
	else if(idwea == 11) TextDrawSetString(TD_iPhone_Time[0],"Caluroso");
	else if(idwea >= 12 && idwea <= 15) TextDrawSetString(TD_iPhone_Time[0],"Aburro");
	else if(idwea == 16) TextDrawSetString(TD_iPhone_Time[0],"Lluvia");
	else if(idwea >= 17 && idwea <= 18) TextDrawSetString(TD_iPhone_Time[0],"Caluroso");
	else if(idwea == 19) TextDrawSetString(TD_iPhone_Time[0],"Arena");
	else if(idwea == 20) TextDrawSetString(TD_iPhone_Time[0],"Niebla");
	else if(idwea == 21) TextDrawSetString(TD_iPhone_Time[0],"Muy oscuro");
	else if(idwea == 22) TextDrawSetString(TD_iPhone_Time[0],"Muy oscuro");
	else if(idwea >= 23 && idwea <= 26) TextDrawSetString(TD_iPhone_Time[0],"Naranja");
	else if(idwea >= 27 && idwea <= 29) TextDrawSetString(TD_iPhone_Time[0],"Soleado");
	else if(idwea >= 30 && idwea <= 32) TextDrawSetString(TD_iPhone_Time[0],"Oscuro");
	else if(idwea == 33) TextDrawSetString(TD_iPhone_Time[0],"Oscuro");
	else if(idwea == 34) TextDrawSetString(TD_iPhone_Time[0],"Azul");
	else if(idwea == 35) TextDrawSetString(TD_iPhone_Time[0],"Marron");
	else if(idwea >= 36 && idwea <= 38) TextDrawSetString(TD_iPhone_Time[0],"Brillante");
	else if(idwea == 39) TextDrawSetString(TD_iPhone_Time[0],"Muy Brillante");
	else if(idwea >= 40 && idwea <= 42) TextDrawSetString(TD_iPhone_Time[0],"Azul/Morado");
	else if(idwea == 43) TextDrawSetString(TD_iPhone_Time[0],"Toxico");
	else if(idwea == 44) TextDrawSetString(TD_iPhone_Time[0],"Negro");
	else if(idwea == 45) TextDrawSetString(TD_iPhone_Time[0],"Negro");
	return 1;
}

stock GetMonth(Month)
{
    new MonthStr[15];
    switch(Month)
    {
        case 1:  MonthStr = "Enero";
        case 2:  MonthStr = "Febrero";
        case 3:  MonthStr = "Marzo";
        case 4:  MonthStr = "Abril";
        case 5:  MonthStr = "Mayo";
        case 6:  MonthStr = "Junio";
        case 7:  MonthStr = "Julio";
        case 8:  MonthStr = "Agosto";
        case 9:  MonthStr = "Septiembre";
        case 10: MonthStr = "Octubre";
        case 11: MonthStr = "Noviembre";
        case 12: MonthStr = "Diciembre";
    }
    return MonthStr;
}

public OnPlayerConnect(playerid)
{
	new number = random(9999);
    PlayerInfo[playerid][PhoneNumber] = number;
	new str[64]; format(str, 64, "Your iPhone phone number is {FFFF00}%d", number);
	SendClientMessage(playerid, -1, str);
    MenuX[playerid] = 1;
    MenuY[playerid] = 1;
	CreatePlayerIphone(playerid);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(iPhoneCallStatus[playerid] == 2)
	{
	    iPhoneCallStatus[callto[playerid]] = 0;
        iPhoneStatus[callto[playerid]] = 0;

		loop(0, sizeof(TD_iPhone), PHONE) TextDrawHideForPlayer(callto[playerid], TD_iPhone[PHONE]);
	    loop(0, sizeof(PTD_iPhone), PPHONE) PlayerTextDrawHide(callto[playerid], PTD_iPhone[PPHONE][callto[playerid]]);
	    PlayerTextDrawHide(callto[playerid], PTD_iPhone_Call[callto[playerid]]);
     	TextDrawHideForPlayer(callto[playerid], TD_iPhone_CallYesNo[0]);
		TextDrawHideForPlayer(callto[playerid], TD_iPhone_CallYesNo[1]);

		SendClientMessage(callto[playerid], -1, "No contestaron...");
        callto[callto[playerid]] = 0;
	}
	else if(iPhoneCallStatus[playerid] == 3)
	{
		iPhoneCallStatus[callto[playerid]] = 0;
        iPhoneStatus[callto[playerid]] = 0;

		loop(0, sizeof(TD_iPhone), PHONE) TextDrawHideForPlayer(callto[playerid], TD_iPhone[PHONE]);
	    loop(0, sizeof(PTD_iPhone), PPHONE) PlayerTextDrawHide(callto[playerid], PTD_iPhone[PPHONE][callto[playerid]]);
	    PlayerTextDrawHide(callto[playerid], PTD_iPhone_Call[callto[playerid]]);
     	TextDrawHideForPlayer(callto[playerid], TD_iPhone_CallYesNo[0]);
		TextDrawHideForPlayer(callto[playerid], TD_iPhone_CallYesNo[1]);

		SendClientMessage(callto[playerid], -1, "Han colgado...");
        callto[callto[playerid]] = 0;
	}
    var1[playerid] = "";
    var2[playerid] = "";
    called[playerid] = "";
    callto[playerid] = 0;
    DeletePVar(playerid,"tovar");
    iPhoneStatus[playerid] = 0;
    iPhone_CC[0][playerid] = 0;
	iPhone_CC[1][playerid] = 0;
	iPhone_CC[2][playerid] = 0;
	iPhone_CC[3][playerid] = 0;
    DestroyPlayerIphone(playerid);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    if(iPhoneStatus[playerid] > 0)
	{
    	if(IsValidObject(firstperson[playerid])) DestroyObject(firstperson[playerid]);
        DeletePVar(playerid,"tovar");
    	var1[playerid] = "";
    	var2[playerid] = "";
    	loop(0, sizeof(TD_iPhone), PHONE) TextDrawHideForPlayer(playerid, TD_iPhone[PHONE]);
	    loop(0, sizeof(PTD_iPhone), PPHONE) PlayerTextDrawHide(playerid, PTD_iPhone[PPHONE][playerid]);
	    HideIphoneMenu(playerid);
	    iPhoneStatus[playerid] = 0;
    }
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(strcmp("/iphone", cmdtext, true, 10) == 0)
	{
	    if(iPhoneStatus[playerid] == 0)
		{
			loop(0, 22, PHONE) TextDrawShowForPlayer(playerid, TD_iPhone[PHONE]);
            iPhoneStatus[playerid] = 1;
		}
		else
		{
		    loop(0, sizeof(TD_iPhone), PHONE) TextDrawHideForPlayer(playerid, TD_iPhone[PHONE]);
		    loop(0, sizeof(PTD_iPhone), PPHONE) PlayerTextDrawHide(playerid, PTD_iPhone[PPHONE][playerid]);
		    HideIphoneMenu(playerid);
		    iPhoneStatus[playerid] = 0;
		}
		return 1;
	}
	return 0;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(clickedid == TD_iPhone_Call[1])
	{
	    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	    strcat(called[playerid], "1");
	    PlayerTextDrawSetString(playerid, PTD_iPhone_Call[playerid], called[playerid]);
	}
	if(clickedid == TD_iPhone_Call[2])
	{
	    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	    strcat(called[playerid], "2");
	    PlayerTextDrawSetString(playerid, PTD_iPhone_Call[playerid], called[playerid]);
	}
	if(clickedid == TD_iPhone_Call[3])
	{
	    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	    strcat(called[playerid], "3");
	    PlayerTextDrawSetString(playerid, PTD_iPhone_Call[playerid], called[playerid]);
	}
	if(clickedid == TD_iPhone_Call[4])
	{
	    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	    strcat(called[playerid], "4");
	    PlayerTextDrawSetString(playerid, PTD_iPhone_Call[playerid], called[playerid]);
	}
	if(clickedid == TD_iPhone_Call[5])
	{
	    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	    strcat(called[playerid], "5");
	    PlayerTextDrawSetString(playerid, PTD_iPhone_Call[playerid], called[playerid]);
	}
	if(clickedid == TD_iPhone_Call[6])
	{
	    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	    strcat(called[playerid], "6");
	    PlayerTextDrawSetString(playerid, PTD_iPhone_Call[playerid], called[playerid]);
	}
	if(clickedid == TD_iPhone_Call[7])
	{
	    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	    strcat(called[playerid], "7");
	    PlayerTextDrawSetString(playerid, PTD_iPhone_Call[playerid], called[playerid]);
	}
	if(clickedid == TD_iPhone_Call[8])
	{
	    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	    strcat(called[playerid], "8");
	    PlayerTextDrawSetString(playerid, PTD_iPhone_Call[playerid], called[playerid]);
	}
	if(clickedid == TD_iPhone_Call[9])
	{
	    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	    strcat(called[playerid], "9");
	    PlayerTextDrawSetString(playerid, PTD_iPhone_Call[playerid], called[playerid]);
	}
	if(clickedid == TD_iPhone_Call[10])
	{
	    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	    strcat(called[playerid], "0");
	    PlayerTextDrawSetString(playerid, PTD_iPhone_Call[playerid], called[playerid]);
	}
	if(clickedid == TD_iPhone_Call[11]) //Call
	{
	    PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);
	    CancelSelectTextDraw(playerid);
     	loop(0, sizeof(TD_iPhone_Call), PHONE) TextDrawHideForPlayer(playerid, TD_iPhone_Call[PHONE]);
     	SendClientMessage(playerid, -1, "Estableciendo llamada...");
     	TextDrawShowForPlayer(playerid, TD_iPhone_CallYesNo[0]);
		TextDrawShowForPlayer(playerid, TD_iPhone_CallYesNo[1]);
     	iPhoneCallStatus[playerid] = 1;
     	new c;
		new ph = strval(called[playerid]);
		for(new i = 0; i != MAX_PLAYERS; i ++)
		{
		    if(IsPlayerConnected(i))
		    {
	            if(playerid != i)
	    		{
					if(PlayerInfo[i][PhoneNumber] == ph)
					{
				        if(iPhoneStatus[i] == 3) HideIphoneMenu(i);
					    iPhoneCallStatus[playerid] = 2;
					    iPhoneCallStatus[i] = 2;
					    callto[playerid] = i;
					    callto[i] = playerid;
					    c = 1;
					    PlayerPlaySound(i, 20600, 0.0, 0.0, 0.0);
					    TextDrawShowForPlayer(i, TD_iPhone_CallYesNo[0]);
					    TextDrawShowForPlayer(i, TD_iPhone_CallYesNo[1]);
					    iPhoneStatus[i] = 3;
					    TextDrawHideForPlayer(i, TD_iPhone[25]);
					    loop(0, 19, PHONE) TextDrawShowForPlayer(i, TD_iPhone[PHONE]);
					    loop(19, sizeof(TD_iPhone), PHONE) TextDrawHideForPlayer(i, TD_iPhone[PHONE]);
    					loop(1, sizeof(PTD_iPhone), PPHONE) PlayerTextDrawHide(i, PTD_iPhone[PPHONE][i]);
					    TextDrawShowForPlayer(i, TD_iPhone[22]);
					    TextDrawShowForPlayer(i, TD_iPhone[23]);
					    TextDrawShowForPlayer(i, TD_iPhone[24]);
                        PlayerTextDrawSetString(i, PTD_iPhone[0][i], "Llamar");
				        PlayerTextDrawShow(i, PTD_iPhone[0][i]);
						break;
					}
				}
		    }
		}
		if(c == 0)
		{
		    iPhoneCallStatus[playerid] = 0;
      		PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
	        iPhoneStatus[playerid] = 2;
	        HideIphoneMenu(playerid);
	        TextDrawShowForPlayer(playerid, TD_iPhone[25]);
	        loop(1, 37, PPHONE) PlayerTextDrawShow(playerid, PTD_iPhone[PPHONE][playerid]);
			SendClientMessage(playerid, -1, "El número marcado no existe o esta fuera de cobertura.");
		}
		else SendClientMessage(playerid, -1, "Llamando...");
	}
	if(clickedid == TD_iPhone_Call[12]) //Delete
	{
	    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        new size = strlen(called[playerid]);
		if(size == 1) strdel(called[playerid],0,1),PlayerTextDrawSetString(playerid,PTD_iPhone_Call[playerid],"_");
		else strdel(called[playerid],size-1,size), PlayerTextDrawSetString(playerid,PTD_iPhone_Call[playerid],called[playerid]);
	}
    if(clickedid == TD_iPhone_Calculator[0])
    {
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        if(!GetPVarInt(playerid, "tovar"))
        {
        	strcat(var1[playerid], "0");
        	PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], var1[playerid]);
		}
		else
		{
		    strcat(var2[playerid], "0");
        	PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], var2[playerid]);
		}
    }
    if(clickedid == TD_iPhone_Calculator[1])
    {
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        if(!GetPVarInt(playerid, "tovar"))
        {
        	var1[playerid] = "";
        	var2[playerid] = "";
        	PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], "ERROR");
		}
		else
		{
		    new s = GetPVarInt(playerid, "tovar");
		    switch(s)
		    {
				case 1:
				{
				    new str[24];
				    format(str, 24, "%d", (strval(var1[playerid])/strval(var2[playerid])));
	        		PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], str);
				}
				case 2:
				{
				    new str[24];
				    format(str, 24, "%d", (strval(var1[playerid])*strval(var2[playerid])));
	        		PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], str);
				}
				case 3:
				{
				    new str[24];
				    format(str, 24, "%d", (strval(var1[playerid])-strval(var2[playerid])));
	        		PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], str);
				}
				case 4:
				{
				    new str[24];
				    format(str, 24, "%d", (strval(var1[playerid])+strval(var2[playerid])));
	        		PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], str);
				}
			}
			DeletePVar(playerid, "tovar");
			var1[playerid] = "";
        	var2[playerid] = "";
		}
	}
	if(clickedid == TD_iPhone_Calculator[2])
    {
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        if(!GetPVarInt(playerid, "tovar"))
        {
        	strcat(var1[playerid], "1");
        	PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], var1[playerid]);
		}
		else
		{
		    strcat(var2[playerid], "1");
        	PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], var2[playerid]);
		}
    }
    if(clickedid == TD_iPhone_Calculator[3])
    {
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        if(!GetPVarInt(playerid, "tovar"))
        {
        	strcat(var1[playerid], "2");
        	PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], var1[playerid]);
		}
		else
		{
		    strcat(var2[playerid], "2");
        	PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], var2[playerid]);
		}
    }
    if(clickedid == TD_iPhone_Calculator[4])
    {
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        if(!GetPVarInt(playerid, "tovar"))
        {
        	strcat(var1[playerid], "3");
        	PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], var1[playerid]);
		}
		else
		{
		    strcat(var2[playerid], "3");
        	PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], var2[playerid]);
		}
    }
    if(clickedid == TD_iPhone_Calculator[5])
    {
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        if(!GetPVarInt(playerid, "tovar"))
        {
        	strcat(var1[playerid], "4");
        	PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], var1[playerid]);
		}
		else
		{
		    strcat(var2[playerid], "4");
        	PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], var2[playerid]);
		}
    }
    if(clickedid == TD_iPhone_Calculator[6])
    {
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        if(!GetPVarInt(playerid, "tovar"))
        {
        	strcat(var1[playerid], "5");
        	PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], var1[playerid]);
		}
		else
		{
		    strcat(var2[playerid], "5");
        	PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], var2[playerid]);
		}
    }
    if(clickedid == TD_iPhone_Calculator[7])
    {
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        if(!GetPVarInt(playerid, "tovar"))
        {
        	strcat(var1[playerid], "6");
        	PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], var1[playerid]);
		}
		else
		{
		    strcat(var2[playerid], "6");
        	PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], var2[playerid]);
		}
    }
    if(clickedid == TD_iPhone_Calculator[8])
    {
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        if(!GetPVarInt(playerid, "tovar"))
        {
        	strcat(var1[playerid], "7");
        	PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], var1[playerid]);
		}
		else
		{
		    strcat(var2[playerid], "7");
        	PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], var2[playerid]);
		}
    }
    if(clickedid == TD_iPhone_Calculator[9])
    {
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        if(!GetPVarInt(playerid, "tovar"))
        {
        	strcat(var1[playerid], "8");
        	PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], var1[playerid]);
		}
		else
		{
		    strcat(var2[playerid], "8");
        	PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], var2[playerid]);
		}
    }
    if(clickedid == TD_iPhone_Calculator[10])
    {
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        if(!GetPVarInt(playerid, "tovar"))
        {
        	strcat(var1[playerid], "9");
        	PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], var1[playerid]);
		}
		else
		{
		    strcat(var2[playerid], "9");
        	PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], var2[playerid]);
		}
    }
    if(clickedid == TD_iPhone_Calculator[11])
    {
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        if(!GetPVarInt(playerid, "tovar"))
        {
            SetPVarInt(playerid, "tovar", 1);
        	PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], "/");
		}
		else
		{
		    DeletePVar(playerid, "tovar");
		    var1[playerid] = "";
        	var2[playerid] = "";
        	PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], "ERROR");
		}
    }
    if(clickedid == TD_iPhone_Calculator[12])
    {
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        if(!GetPVarInt(playerid, "tovar"))
        {
            SetPVarInt(playerid, "tovar", 2);
        	PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], "X");
		}
		else
		{
		    DeletePVar(playerid, "tovar");
		    var1[playerid] = "";
        	var2[playerid] = "";
        	PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], "ERROR");
		}
    }
    if(clickedid == TD_iPhone_Calculator[13])
    {
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        if(!GetPVarInt(playerid, "tovar"))
        {
            SetPVarInt(playerid, "tovar", 3);
        	PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], "-");
		}
		else
		{
		    DeletePVar(playerid, "tovar");
		    var1[playerid] = "";
        	var2[playerid] = "";
        	PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], "ERROR");
		}
    }
    if(clickedid == TD_iPhone_Calculator[14])
    {
        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
        if(!GetPVarInt(playerid, "tovar"))
        {
            SetPVarInt(playerid, "tovar", 4);
        	PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], "+");
		}
		else
		{
		    DeletePVar(playerid, "tovar");
		    var1[playerid] = "";
        	var2[playerid] = "";
        	PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], "ERROR");
		}
    }
    return 1;
}

public OnPlayerText(playerid, text[])
{
	if(iPhoneCallStatus[playerid] == 3)
	{
	    new str[256];
	    format(str, 256, "{00CCFF}* Telefóno: {FFFFFF}%s", text);
	    SendClientMessage(callto[playerid], -1, str);
	    format(str, 256, "{CCCCCC}* Telefóno: {FFFFFF}%s", text);
	    SendClientMessage(playerid, -1, str);
	    return 0;
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_YES)
	{
	    if(iPhoneCallStatus[playerid] == 2)
	    {
	        iPhoneCallStatus[playerid] = 3;
	        iPhoneCallStatus[callto[playerid]] = 3;
	        SendClientMessage(callto[playerid], -1, "Llamada establecida");
	        return 1;
	    }
	    if(iPhone_CC[1][playerid] == 1 || iPhone_CC[2][playerid] == 1)
	    {
            PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	        StopAudioStreamForPlayer(playerid);
	        return 1;
		}
	    if(iPhoneStatus[playerid] == 1)
	    {
	        PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	        iPhoneStatus[playerid] = 2;
	        TextDrawHideForPlayer(playerid, TD_iPhone[19]);
	        TextDrawHideForPlayer(playerid, TD_iPhone[20]);
	        TextDrawHideForPlayer(playerid, TD_iPhone[21]);
	        loop(22, 26, PHONE) TextDrawShowForPlayer(playerid, TD_iPhone[PHONE]);
	        loop(0, 37, PPHONE) PlayerTextDrawShow(playerid, PTD_iPhone[PPHONE][playerid]);
	        UpdateCoordinates(playerid, MenuX[playerid], MenuY[playerid]);
	    }
	    else if(iPhoneStatus[playerid] == 2)
	    {
	        new menuid = UpdateCoordinates(playerid, MenuX[playerid], MenuY[playerid]);
	        if(menuid == 12) return PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
	        PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	        iPhoneStatus[playerid] = 3;
	        TextDrawHideForPlayer(playerid, TD_iPhone[25]);
	        loop(1, 37, PPHONE) PlayerTextDrawHide(playerid, PTD_iPhone[PPHONE][playerid]);
	        ShowIphoneMenu(playerid, menuid);
	    }
	    return 1;
	}
	if(newkeys & KEY_NO)
	{
	    if(iPhoneStatus[playerid] == 1)
	    {
	        PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
	        loop(0, 22, PHONE) TextDrawHideForPlayer(playerid, TD_iPhone[PHONE]);
		    iPhoneStatus[playerid] = 0;
	    }
	    else if(iPhoneStatus[playerid] == 2)
	    {
	        PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
	        iPhoneStatus[playerid] = 1;
	        loop(22, 26, PHONE) TextDrawHideForPlayer(playerid, TD_iPhone[PHONE]);
	        loop(0, 37, PPHONE) PlayerTextDrawHide(playerid, PTD_iPhone[PPHONE][playerid]);
	        TextDrawShowForPlayer(playerid, TD_iPhone[19]);
	        TextDrawShowForPlayer(playerid, TD_iPhone[20]);
	        TextDrawShowForPlayer(playerid, TD_iPhone[21]);
	    }
	    else if(iPhoneStatus[playerid] == 3)
	    {
	        PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
	        iPhoneStatus[playerid] = 2;
	        TextDrawShowForPlayer(playerid, TD_iPhone[25]);
	        loop(1, 37, PPHONE) PlayerTextDrawShow(playerid, PTD_iPhone[PPHONE][playerid]);
	        HideIphoneMenu(playerid);
	    }
	    return 1;
	}
	if(newkeys & KEY_ANALOG_LEFT)
	{
	    if(iPhone_CC[0][playerid] == 1)
	    {
	        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	        PlayerTextDrawSetString(playerid, PTD_iPhone_Gallery[playerid], Gallery[random(sizeof(Gallery))]);
	        return 1;
	    }
	    if(iPhone_CC[1][playerid] == 1)
	    {
	        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	        StopAudioStreamForPlayer(playerid);
	        PlayAudioStreamForPlayer(playerid, Radio[random(sizeof(Radio))]);
	        return 1;
	    }
	    if(iPhone_CC[2][playerid] == 1)
	    {
	        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	        StopAudioStreamForPlayer(playerid);
	        PlayAudioStreamForPlayer(playerid, Music[random(sizeof(Music))]);
	        return 1;
	    }
	    if(iPhoneStatus[playerid] == 2)
	    {
	        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
			if(MenuX[playerid] == 0)
			{
			    if(MenuY[playerid] == 0)
			    {
			        MenuX[playerid] = 2;
				    MenuY[playerid] = 3;
				    UpdateCoordinates(playerid, MenuX[playerid], MenuY[playerid]);
			        return 1;
			    }
			    MenuY[playerid] -= 1;
			    MenuX[playerid] = 2;
			    UpdateCoordinates(playerid, MenuX[playerid], MenuY[playerid]);
				return 1;
			}
	        MenuX[playerid] -= 1;
	        UpdateCoordinates(playerid, MenuX[playerid], MenuY[playerid]);
	    }
	    return 1;
	}
	if(newkeys & KEY_ANALOG_RIGHT)
	{
	    if(iPhone_CC[0][playerid] == 1)
	    {
	        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	        PlayerTextDrawSetString(playerid, PTD_iPhone_Gallery[playerid], Gallery[random(sizeof(Gallery))]);
	        return 1;
	    }
	    if(iPhone_CC[1][playerid] == 1)
	    {
	        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	        StopAudioStreamForPlayer(playerid);
	        PlayAudioStreamForPlayer(playerid, Radio[random(sizeof(Radio))]);
	        return 1;
	    }
	    if(iPhone_CC[2][playerid] == 1)
	    {
	        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
	        StopAudioStreamForPlayer(playerid);
	        PlayAudioStreamForPlayer(playerid, Music[random(sizeof(Music))]);
	        return 1;
	    }
	    if(iPhoneStatus[playerid] == 2)
	    {
	        PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
			if(MenuX[playerid] == 2)
			{
			    if(MenuY[playerid] == 3)
			    {
			        MenuY[playerid] = 0;
				    MenuX[playerid] = 0;
				    UpdateCoordinates(playerid, MenuX[playerid], MenuY[playerid]);
			        return 1;
			    }
			    MenuY[playerid] += 1;
			    MenuX[playerid] = 0;
			    UpdateCoordinates(playerid, MenuX[playerid], MenuY[playerid]);
			    return 1;
			}
	        MenuX[playerid] += 1;
	        UpdateCoordinates(playerid, MenuX[playerid], MenuY[playerid]);
	    }
	    return 1;
	}
	return 1;
}

/*public OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid, bodypart)
{
    return 1;
} */

stock ShowIphoneMenu(playerid, menuid)
{
	switch(menuid)
	{
	    case 1:
	    {
	        TextDrawShowForPlayer(playerid, TD_iPhone_Clock[0]);
	        TextDrawShowForPlayer(playerid, TD_iPhone_Clock[1]);
	    }
	    case 2:
	    {
	        iPhone_CC[3][playerid] = 1;
	        firstperson[playerid] = CreateObject(19300, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
	        AttachObjectToPlayer(firstperson[playerid],playerid, 0.0, 0.12, 0.7, 0.0, 0.0, 0.0);
	        AttachCameraToObject(playerid, firstperson[playerid]);
	    }
	    case 3:
	    {
	        iPhone_CC[0][playerid] = 1;
	        TextDrawShowForPlayer(playerid, TD_iPhone_Gallery);
			PlayerTextDrawShow(playerid, PTD_iPhone_Gallery[playerid]);
	    }
	    case 4:
	    {
	        TextDrawShowForPlayer(playerid, TD_iPhone_Time[0]);
	        TextDrawShowForPlayer(playerid, TD_iPhone_Time[1]);
	        TextDrawShowForPlayer(playerid, TD_iPhone_Time[2]);
	    }
	    case 5:
	    {
	        SelectTextDraw(playerid, -1);
	        PlayerTextDrawShow(playerid, PTD_iPhone_Calculator[playerid]);
	        loop(0, sizeof(TD_iPhone_Calculator), PHONE) TextDrawShowForPlayer(playerid, TD_iPhone_Calculator[PHONE]);
	    }
	    case 6:
	    {
	        GetPlayerZone(playerid);
	        TextDrawShowForPlayer(playerid, TD_iPhone_GPS);
	        PlayerTextDrawShow(playerid, PTD_iPhone_GPS[playerid]);
	    }
	    case 7:
	    {
	        iPhone_CC[1][playerid] = 1;
	        TextDrawShowForPlayer(playerid, TD_iPhone_Radio[0]);
	        TextDrawShowForPlayer(playerid, TD_iPhone_Radio[1]);
	    }
	    case 8:
	    {
	        iPhone_CC[2][playerid] = 1;
	        TextDrawShowForPlayer(playerid, TD_iPhone_Music[0]);
	        TextDrawShowForPlayer(playerid, TD_iPhone_Music[1]);
	    }
	    case 9: TextDrawShowForPlayer(playerid, TD_iPhone_Map);
	    case 10:
	    {
	        SelectTextDraw(playerid, -1);
	        loop(0, sizeof(TD_iPhone_Call), PHONE) TextDrawShowForPlayer(playerid, TD_iPhone_Call[PHONE]);
	        PlayerTextDrawShow(playerid, PTD_iPhone_Call[playerid]);
	    }
	    case 11:
	    {
	        TextDrawShowForPlayer(playerid, TD_iPhone_Internet[0]);
	        TextDrawShowForPlayer(playerid, TD_iPhone_Internet[1]);
	    }
	}
	return 1;
}

stock HideIphoneMenu(playerid)
{
	if(iPhoneCallStatus[playerid] == 1) return 1;
	else if(iPhoneCallStatus[playerid] == 2)
	{
	    iPhoneCallStatus[playerid] = 0;
	    iPhoneCallStatus[callto[playerid]] = 0;
	    iPhoneStatus[playerid] = 0;
        iPhoneStatus[callto[playerid]] = 0;

        loop(0, sizeof(TD_iPhone), PHONE) TextDrawHideForPlayer(playerid, TD_iPhone[PHONE]);
	    loop(0, sizeof(PTD_iPhone), PPHONE) PlayerTextDrawHide(playerid, PTD_iPhone[PPHONE][playerid]);
	    PlayerTextDrawHide(playerid, PTD_iPhone_Call[playerid]);
     	TextDrawHideForPlayer(playerid, TD_iPhone_CallYesNo[0]);
		TextDrawHideForPlayer(playerid, TD_iPhone_CallYesNo[1]);

		loop(0, sizeof(TD_iPhone), PHONE) TextDrawHideForPlayer(callto[playerid], TD_iPhone[PHONE]);
	    loop(0, sizeof(PTD_iPhone), PPHONE) PlayerTextDrawHide(callto[playerid], PTD_iPhone[PPHONE][callto[playerid]]);
	    PlayerTextDrawHide(callto[playerid], PTD_iPhone_Call[callto[playerid]]);
     	TextDrawHideForPlayer(callto[playerid], TD_iPhone_CallYesNo[0]);
		TextDrawHideForPlayer(callto[playerid], TD_iPhone_CallYesNo[1]);

		SendClientMessage(callto[playerid], -1, "No contestaron...");
        callto[callto[playerid]] = 0;
	    callto[playerid] = 0;
	    return 1;
	}
	else if(iPhoneCallStatus[playerid] == 3)
	{
	    iPhoneCallStatus[playerid] = 0;
	    iPhoneCallStatus[callto[playerid]] = 0;
	    iPhoneStatus[playerid] = 0;
        iPhoneStatus[callto[playerid]] = 0;

        loop(0, sizeof(TD_iPhone), PHONE) TextDrawHideForPlayer(playerid, TD_iPhone[PHONE]);
	    loop(0, sizeof(PTD_iPhone), PPHONE) PlayerTextDrawHide(playerid, PTD_iPhone[PPHONE][playerid]);
	    PlayerTextDrawHide(playerid, PTD_iPhone_Call[playerid]);
     	TextDrawHideForPlayer(playerid, TD_iPhone_CallYesNo[0]);
		TextDrawHideForPlayer(playerid, TD_iPhone_CallYesNo[1]);

		loop(0, sizeof(TD_iPhone), PHONE) TextDrawHideForPlayer(callto[playerid], TD_iPhone[PHONE]);
	    loop(0, sizeof(PTD_iPhone), PPHONE) PlayerTextDrawHide(callto[playerid], PTD_iPhone[PPHONE][callto[playerid]]);
	    PlayerTextDrawHide(callto[playerid], PTD_iPhone_Call[callto[playerid]]);
     	TextDrawHideForPlayer(callto[playerid], TD_iPhone_CallYesNo[0]);
		TextDrawHideForPlayer(callto[playerid], TD_iPhone_CallYesNo[1]);

		SendClientMessage(callto[playerid], -1, "Han colgado...");
        callto[callto[playerid]] = 0;
	    callto[playerid] = 0;
	    return 1;
	}
    CancelSelectTextDraw(playerid);
	TextDrawHideForPlayer(playerid, TD_iPhone_Clock[0]);
	TextDrawHideForPlayer(playerid, TD_iPhone_Clock[1]);
	TextDrawHideForPlayer(playerid, TD_iPhone_Gallery);
	PlayerTextDrawHide(playerid, PTD_iPhone_Gallery[playerid]);
	TextDrawHideForPlayer(playerid, TD_iPhone_Time[0]);
    TextDrawHideForPlayer(playerid, TD_iPhone_Time[1]);
    TextDrawHideForPlayer(playerid, TD_iPhone_Time[2]);
    TextDrawHideForPlayer(playerid, TD_iPhone_GPS);
    PlayerTextDrawHide(playerid, PTD_iPhone_GPS[playerid]);
    TextDrawHideForPlayer(playerid, TD_iPhone_Radio[0]);
	TextDrawHideForPlayer(playerid, TD_iPhone_Radio[1]);
	TextDrawHideForPlayer(playerid, TD_iPhone_Music[0]);
 	TextDrawHideForPlayer(playerid, TD_iPhone_Music[1]);
 	TextDrawHideForPlayer(playerid, TD_iPhone_Map);
 	TextDrawHideForPlayer(playerid, TD_iPhone_Internet[0]);
  	TextDrawHideForPlayer(playerid, TD_iPhone_Internet[1]);
  	PlayerTextDrawHide(playerid, PTD_iPhone_Calculator[playerid]);
   	loop(0, sizeof(TD_iPhone_Calculator), PHONE) TextDrawHideForPlayer(playerid, TD_iPhone_Calculator[PHONE]);
   	loop(0, sizeof(TD_iPhone_Call), PHONE) TextDrawHideForPlayer(playerid, TD_iPhone_Call[PHONE]);
    PlayerTextDrawHide(playerid, PTD_iPhone_Call[playerid]);
   	var1[playerid] = "";
    var2[playerid] = "";
    called[playerid] = "";
    TextDrawHideForPlayer(playerid, TD_iPhone_CallYesNo[0]);
	TextDrawHideForPlayer(playerid, TD_iPhone_CallYesNo[1]);
    PlayerTextDrawSetString(playerid, PTD_iPhone_Call[playerid], "");
    PlayerTextDrawSetString(playerid, PTD_iPhone_Calculator[playerid], "0");
    DeletePVar(playerid,"tovar");
	iPhone_CC[0][playerid] = 0;
	iPhone_CC[1][playerid] = 0;
	iPhone_CC[2][playerid] = 0;
	if(iPhone_CC[3][playerid] == 1)
	{
	    iPhone_CC[3][playerid] = 0;
		SetCameraBehindPlayer(playerid);
		DestroyObject(firstperson[playerid]);
	}
	return 1;
}

stock ReturnPlayerZone(playerid)
{
	new playerzone[256] = "Desconocida";
	for(new j; j < sizeof(zones); j++) {
		if(IsPlayerInZone(playerid,j)) {
			memcpy(playerzone, zones[j][zone_name], 0, 108);
			break;
		}
	}
    return playerzone;
}
stock IsPlayerInZone(playerid, zoneid) {
	if(zoneid == -1) return false;
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	if(x >= zones[zoneid][zone_minx] && x < zones[zoneid][zone_maxx] && y >= zones[zoneid][zone_miny] && y < zones[zoneid][zone_maxy] && z >= zones[zoneid][zone_minz] && z < zones[zoneid][zone_maxz] && z < 900.0) return true;
	return false;
}
stock GetPlayerZone(playerid)
{
	new string[256];
    format(string,sizeof(string),"%s",ReturnPlayerZone(playerid));
    PlayerTextDrawSetString(playerid,PTD_iPhone_GPS[playerid],string);
	return 1;
}

stock UpdateCoordinates(playerid, aMenuX, aMenuY)
{
	switch(aMenuX)
	{
	    case 0:
	    {
	        switch(aMenuY)
	        {
	            case 0:
	            {
	                PlayerTextDrawSetString(playerid, PTD_iPhone[0][playerid], "Reloj");
	                loop(1, 13, i)
					{
						PlayerTextDrawColor(playerid, PTD_iPhone[i][playerid], -256);
						PlayerTextDrawShow(playerid, PTD_iPhone[i][playerid]);
					}
	                PlayerTextDrawColor(playerid, PTD_iPhone[1][playerid], -1);
	                PlayerTextDrawShow(playerid, PTD_iPhone[1][playerid]);
					return 1;
	            }
	            case 1:
	            {
	                PlayerTextDrawSetString(playerid, PTD_iPhone[0][playerid], "El tiempo");
	                loop(1, 13, i)
					{
						PlayerTextDrawColor(playerid, PTD_iPhone[i][playerid], -256);
						PlayerTextDrawShow(playerid, PTD_iPhone[i][playerid]);
					}
	                PlayerTextDrawColor(playerid, PTD_iPhone[4][playerid], -1);
	                PlayerTextDrawShow(playerid, PTD_iPhone[4][playerid]);
					return 4;
	            }
	            case 2:
	            {
	                PlayerTextDrawSetString(playerid, PTD_iPhone[0][playerid], "Radio");
	                loop(1, 13, i)
					{
						PlayerTextDrawColor(playerid, PTD_iPhone[i][playerid], -256);
						PlayerTextDrawShow(playerid, PTD_iPhone[i][playerid]);
					}
	                PlayerTextDrawColor(playerid, PTD_iPhone[7][playerid], -1);
	                PlayerTextDrawShow(playerid, PTD_iPhone[7][playerid]);
					return 7;
	            }
	            case 3:
	            {
	                PlayerTextDrawSetString(playerid, PTD_iPhone[0][playerid], "Llamar");
	                loop(1, 13, i)
					{
						PlayerTextDrawColor(playerid, PTD_iPhone[i][playerid], -256);
						PlayerTextDrawShow(playerid, PTD_iPhone[i][playerid]);
					}
	                PlayerTextDrawColor(playerid, PTD_iPhone[10][playerid], -1);
	                PlayerTextDrawShow(playerid, PTD_iPhone[10][playerid]);
					return 10;
	            }
	        }
	    }
	    case 1:
	    {
	        switch(aMenuY)
	        {
	            case 0:
	            {
	                PlayerTextDrawSetString(playerid, PTD_iPhone[0][playerid], "Camara");
	                loop(1, 13, i)
					{
						PlayerTextDrawColor(playerid, PTD_iPhone[i][playerid], -256);
						PlayerTextDrawShow(playerid, PTD_iPhone[i][playerid]);
					}
	                PlayerTextDrawColor(playerid, PTD_iPhone[2][playerid], -1);
	                PlayerTextDrawShow(playerid, PTD_iPhone[2][playerid]);
					return 2;
	            }
	            case 1:
	            {
	                PlayerTextDrawSetString(playerid, PTD_iPhone[0][playerid], "Calculadora");
	                loop(1, 13, i)
					{
						PlayerTextDrawColor(playerid, PTD_iPhone[i][playerid], -256);
						PlayerTextDrawShow(playerid, PTD_iPhone[i][playerid]);
					}
	                PlayerTextDrawColor(playerid, PTD_iPhone[5][playerid], -1);
	                PlayerTextDrawShow(playerid, PTD_iPhone[5][playerid]);
					return 5;
	            }
	            case 2:
	            {
	                PlayerTextDrawSetString(playerid, PTD_iPhone[0][playerid], "Musica");
	                loop(1, 13, i)
					{
						PlayerTextDrawColor(playerid, PTD_iPhone[i][playerid], -256);
						PlayerTextDrawShow(playerid, PTD_iPhone[i][playerid]);
					}
	                PlayerTextDrawColor(playerid, PTD_iPhone[8][playerid], -1);
	                PlayerTextDrawShow(playerid, PTD_iPhone[8][playerid]);
					return 8;
	            }
	            case 3:
	            {
	                PlayerTextDrawSetString(playerid, PTD_iPhone[0][playerid], "Internet");
	                loop(1, 13, i)
					{
						PlayerTextDrawColor(playerid, PTD_iPhone[i][playerid], -256);
						PlayerTextDrawShow(playerid, PTD_iPhone[i][playerid]);
					}
	                PlayerTextDrawColor(playerid, PTD_iPhone[11][playerid], -1);
	                PlayerTextDrawShow(playerid, PTD_iPhone[11][playerid]);
					return 11;
	            }
	        }
	    }
	    case 2:
	    {
	        switch(aMenuY)
	        {
	            case 0:
	            {
	                PlayerTextDrawSetString(playerid, PTD_iPhone[0][playerid], "Galeria");
	                loop(1, 13, i)
					{
						PlayerTextDrawColor(playerid, PTD_iPhone[i][playerid], -256);
						PlayerTextDrawShow(playerid, PTD_iPhone[i][playerid]);
					}
	                PlayerTextDrawColor(playerid, PTD_iPhone[3][playerid], -1);
	                PlayerTextDrawShow(playerid, PTD_iPhone[3][playerid]);
					return 3;
	            }
	            case 1:
	            {
	                PlayerTextDrawSetString(playerid, PTD_iPhone[0][playerid], "GPS");
	                loop(1, 13, i)
					{
						PlayerTextDrawColor(playerid, PTD_iPhone[i][playerid], -256);
						PlayerTextDrawShow(playerid, PTD_iPhone[i][playerid]);
					}
	                PlayerTextDrawColor(playerid, PTD_iPhone[6][playerid], -1);
	                PlayerTextDrawShow(playerid, PTD_iPhone[6][playerid]);
					return 6;
	            }
	            case 2:
	            {
	                PlayerTextDrawSetString(playerid, PTD_iPhone[0][playerid], "Mapa");
	                loop(1, 13, i)
					{
						PlayerTextDrawColor(playerid, PTD_iPhone[i][playerid], -256);
						PlayerTextDrawShow(playerid, PTD_iPhone[i][playerid]);
					}
	                PlayerTextDrawColor(playerid, PTD_iPhone[9][playerid], -1);
	                PlayerTextDrawShow(playerid, PTD_iPhone[9][playerid]);
					return 9;
	            }
	            case 3:
	            {
	                PlayerTextDrawSetString(playerid, PTD_iPhone[0][playerid], "SMS");
	                loop(1, 13, i)
					{
						PlayerTextDrawColor(playerid, PTD_iPhone[i][playerid], -256);
						PlayerTextDrawShow(playerid, PTD_iPhone[i][playerid]);
					}
	                PlayerTextDrawColor(playerid, PTD_iPhone[12][playerid], -1);
	                PlayerTextDrawShow(playerid, PTD_iPhone[12][playerid]);
					return 12;
	            }
	        }
	    }
	}
	return 0;
}

stock CreatePlayerIphone(playerid)
{
	PTD_iPhone[0][playerid] = CreatePlayerTextDraw(playerid, 550.133544, 233.225967, "Not selected");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[0][playerid], 0.276333, 1.346963);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[0][playerid], 2);
	PlayerTextDrawColor(playerid, PTD_iPhone[0][playerid], -1);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[0][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[0][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, PTD_iPhone[0][playerid], 255);
	PlayerTextDrawFont(playerid, PTD_iPhone[0][playerid], 1);
	PlayerTextDrawSetProportional(playerid, PTD_iPhone[0][playerid], 1);

	PTD_iPhone[1][playerid] = CreatePlayerTextDraw(playerid, 516.600280, 254.681549, "ld_poke:cd1d");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[1][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[1][playerid], 19.000009, 23.644432);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[1][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[1][playerid], -256);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[1][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[1][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[1][playerid], 4);

	PTD_iPhone[2][playerid] = CreatePlayerTextDraw(playerid, 540.866333, 254.681549, "ld_poke:cd1d");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[2][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[2][playerid], 19.000009, 23.644432);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[2][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[2][playerid], -256);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[2][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[2][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[2][playerid], 4);

	PTD_iPhone[3][playerid] = CreatePlayerTextDraw(playerid, 565.599304, 254.681549, "ld_poke:cd1d");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[3][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[3][playerid], 19.000009, 23.644432);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[3][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[3][playerid], -256);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[3][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[3][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[3][playerid], 4);

	PTD_iPhone[4][playerid] = CreatePlayerTextDraw(playerid, 516.600280, 284.445159, "ld_poke:cd1d");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[4][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[4][playerid], 19.000009, 23.644432);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[4][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[4][playerid], -256);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[4][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[4][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[4][playerid], 4);

	PTD_iPhone[5][playerid] = CreatePlayerTextDraw(playerid, 540.866333, 284.445159, "ld_poke:cd1d");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[5][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[5][playerid], 19.000009, 23.644432);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[5][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[5][playerid], -1);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[5][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[5][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[5][playerid], 4);

	PTD_iPhone[6][playerid] = CreatePlayerTextDraw(playerid, 565.599304, 284.445159, "ld_poke:cd1d");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[6][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[6][playerid], 19.000009, 23.644432);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[6][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[6][playerid], -256);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[6][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[6][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[6][playerid], 4);

	PTD_iPhone[7][playerid] = CreatePlayerTextDraw(playerid, 516.600280, 314.208770, "ld_poke:cd1d");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[7][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[7][playerid], 19.000009, 23.644432);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[7][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[7][playerid], -256);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[7][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[7][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[7][playerid], 4);

	PTD_iPhone[8][playerid] = CreatePlayerTextDraw(playerid, 540.866333, 314.208770, "ld_poke:cd1d");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[8][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[8][playerid], 19.000009, 23.644432);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[8][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[8][playerid], -256);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[8][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[8][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[8][playerid], 4);

	PTD_iPhone[9][playerid] = CreatePlayerTextDraw(playerid, 565.599304, 314.208770, "ld_poke:cd1d");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[9][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[9][playerid], 19.000009, 23.644432);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[9][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[9][playerid], -256);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[9][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[9][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[9][playerid], 4);

	PTD_iPhone[10][playerid] = CreatePlayerTextDraw(playerid, 516.600280, 348.338378, "ld_poke:cd1d");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[10][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[10][playerid], 19.000009, 23.644432);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[10][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[10][playerid], -256);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[10][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[10][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[10][playerid], 4);

	PTD_iPhone[11][playerid] = CreatePlayerTextDraw(playerid, 540.866333, 348.338378, "ld_poke:cd1d");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[11][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[11][playerid], 19.000009, 23.644432);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[11][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[11][playerid], -256);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[11][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[11][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[11][playerid], 4);

	PTD_iPhone[12][playerid] = CreatePlayerTextDraw(playerid, 565.599304, 348.338378, "ld_poke:cd1d");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[12][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[12][playerid], 19.000009, 23.644432);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[12][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[12][playerid], -256);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[12][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[12][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[12][playerid], 4);

	PTD_iPhone[13][playerid] = CreatePlayerTextDraw(playerid, 517.000122, 255.526031, "ld_poke:cd1d");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[13][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[13][playerid], 18.333343, 22.399990);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[13][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[13][playerid], 255);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[13][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[13][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[13][playerid], 4);

	PTD_iPhone[14][playerid] = CreatePlayerTextDraw(playerid, 541.266174, 255.526031, "ld_poke:cd1d");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[14][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[14][playerid], 18.333343, 22.399990);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[14][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[14][playerid], 255);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[14][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[14][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[14][playerid], 4);

	PTD_iPhone[15][playerid] = CreatePlayerTextDraw(playerid, 565.999145, 255.526031, "ld_poke:cd1d");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[15][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[15][playerid], 18.333343, 22.399990);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[15][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[15][playerid], 255);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[15][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[15][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[15][playerid], 4);

	PTD_iPhone[16][playerid] = CreatePlayerTextDraw(playerid, 517.000122, 285.289642, "ld_poke:cd1d");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[16][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[16][playerid], 18.333343, 22.399990);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[16][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[16][playerid], 255);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[16][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[16][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[16][playerid], 4);

	PTD_iPhone[17][playerid] = CreatePlayerTextDraw(playerid, 541.266174, 285.289642, "ld_poke:cd1d");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[17][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[17][playerid], 18.333343, 22.399990);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[17][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[17][playerid], 255);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[17][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[17][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[17][playerid], 4);

	PTD_iPhone[18][playerid] = CreatePlayerTextDraw(playerid, 565.999145, 285.289642, "ld_poke:cd1d");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[18][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[18][playerid], 18.333343, 22.399990);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[18][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[18][playerid], 255);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[18][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[18][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[18][playerid], 4);

	PTD_iPhone[19][playerid] = CreatePlayerTextDraw(playerid, 517.000122, 315.053253, "ld_poke:cd1d");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[19][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[19][playerid], 18.333343, 22.399990);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[19][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[19][playerid], 255);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[19][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[19][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[19][playerid], 4);

	PTD_iPhone[20][playerid] = CreatePlayerTextDraw(playerid, 541.266174, 315.053253, "ld_poke:cd1d");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[20][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[20][playerid], 18.333343, 22.399990);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[20][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[20][playerid], 255);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[20][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[20][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[20][playerid], 4);

	PTD_iPhone[21][playerid] = CreatePlayerTextDraw(playerid, 565.999145, 315.053253, "ld_poke:cd1d");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[21][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[21][playerid], 18.333343, 22.399990);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[21][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[21][playerid], 255);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[21][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[21][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[21][playerid], 4);

	PTD_iPhone[22][playerid] = CreatePlayerTextDraw(playerid, 517.000122, 349.182861, "ld_poke:cd1d");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[22][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[22][playerid], 18.333343, 22.399990);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[22][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[22][playerid], 255);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[22][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[22][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[22][playerid], 4);

	PTD_iPhone[23][playerid] = CreatePlayerTextDraw(playerid, 541.266174, 349.182861, "ld_poke:cd1d");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[23][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[23][playerid], 18.333343, 22.399990);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[23][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[23][playerid], 255);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[23][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[23][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[23][playerid], 4);

	PTD_iPhone[24][playerid] = CreatePlayerTextDraw(playerid, 565.999145, 349.182861, "ld_poke:cd1d");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[24][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[24][playerid], 18.333343, 22.399990);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[24][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[24][playerid], 255);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[24][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[24][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[24][playerid], 4);

	PTD_iPhone[25][playerid] = CreatePlayerTextDraw(playerid, 518.700134, 257.085144, "ld_grav:timer");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[25][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[25][playerid], 14.999999, 17.422224);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[25][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[25][playerid], -1);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[25][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[25][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[25][playerid], 4);

	PTD_iPhone[26][playerid] = CreatePlayerTextDraw(playerid, 543.000000, 258.140777, "hud:radar_gym");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[26][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[26][playerid], 14.999999, 17.422224);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[26][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[26][playerid], -1);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[26][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[26][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[26][playerid], 4);

	PTD_iPhone[27][playerid] = CreatePlayerTextDraw(playerid, 567.699951, 257.611114, "hud:radar_enemyattack");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[27][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[27][playerid], 14.999999, 17.422224);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[27][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[27][playerid], -1);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[27][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[27][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[27][playerid], 4);

	PTD_iPhone[28][playerid] = CreatePlayerTextDraw(playerid, 518.500183, 287.118560, "hud:radar_fire");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[28][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[28][playerid], 14.999999, 17.422224);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[28][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[28][playerid], -1);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[28][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[28][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[28][playerid], 4);

	PTD_iPhone[29][playerid] = CreatePlayerTextDraw(playerid, 542.966796, 287.288879, "hud:radar_modgarage");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[29][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[29][playerid], 14.999999, 17.422224);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[29][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[29][playerid], -1);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[29][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[29][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[29][playerid], 4);

	PTD_iPhone[30][playerid] = CreatePlayerTextDraw(playerid, 567.633361, 287.359222, "hud:arrow");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[30][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[30][playerid], 14.999999, 17.422224);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[30][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[30][playerid], -1);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[30][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[30][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[30][playerid], 4);

	PTD_iPhone[31][playerid] = CreatePlayerTextDraw(playerid, 518.900207, 316.781402, "hud:radar_flag");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[31][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[31][playerid], 14.999999, 17.422224);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[31][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[31][playerid], -1);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[31][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[31][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[31][playerid], 4);

	PTD_iPhone[32][playerid] = CreatePlayerTextDraw(playerid, 542.866943, 317.151763, "hud:radar_datedisco");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[32][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[32][playerid], 14.999999, 17.422224);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[32][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[32][playerid], -1);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[32][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[32][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[32][playerid], 4);

	PTD_iPhone[33][playerid] = CreatePlayerTextDraw(playerid, 567.500305, 317.007293, "hud:radar_light");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[33][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[33][playerid], 14.999999, 17.422224);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[33][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[33][playerid], -1);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[33][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[33][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[33][playerid], 4);

	PTD_iPhone[34][playerid] = CreatePlayerTextDraw(playerid, 518.566955, 351.092498, "hud:radar_propertyg");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[34][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[34][playerid], 14.999999, 17.422224);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[34][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[34][playerid], -1);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[34][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[34][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[34][playerid], 4);

	PTD_iPhone[35][playerid] = CreatePlayerTextDraw(playerid, 543.100280, 351.103698, "hud:radar_locosyndicate");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[35][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[35][playerid], 14.999999, 17.422224);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[35][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[35][playerid], -1);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[35][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[35][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[35][playerid], 4);

	PTD_iPhone[36][playerid] = CreatePlayerTextDraw(playerid, 567.566833, 351.147979, "hud:radar_propertyr");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone[36][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone[36][playerid], 14.999999, 17.422224);
	PlayerTextDrawAlignment(playerid, PTD_iPhone[36][playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone[36][playerid], -1);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone[36][playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone[36][playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone[36][playerid], 4);

	PTD_iPhone_Gallery[playerid] = CreatePlayerTextDraw(playerid, 511.266784, 249.677749, "loadsc1:loadsc1");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone_Gallery[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, PTD_iPhone_Gallery[playerid], 78.666625, 70.518501);
	PlayerTextDrawAlignment(playerid, PTD_iPhone_Gallery[playerid], 1);
	PlayerTextDrawColor(playerid, PTD_iPhone_Gallery[playerid], -1);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone_Gallery[playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone_Gallery[playerid], 0);
	PlayerTextDrawFont(playerid, PTD_iPhone_Gallery[playerid], 4);

	PTD_iPhone_GPS[playerid] = CreatePlayerTextDraw(playerid, 548.666931, 266.481384, "Los Santos");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone_GPS[playerid], 0.253666, 1.322074);
	PlayerTextDrawAlignment(playerid, PTD_iPhone_GPS[playerid], 2);
	PlayerTextDrawColor(playerid, PTD_iPhone_GPS[playerid], -5963521);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone_GPS[playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone_GPS[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, PTD_iPhone_GPS[playerid], 255);
	PlayerTextDrawFont(playerid, PTD_iPhone_GPS[playerid], 1);
	PlayerTextDrawSetProportional(playerid, PTD_iPhone_GPS[playerid], 1);

	PTD_iPhone_Calculator[playerid] = CreatePlayerTextDraw(playerid, 583.899963, 268.370300, "0");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone_Calculator[playerid], 0.267999, 1.599999);
	PlayerTextDrawAlignment(playerid, PTD_iPhone_Calculator[playerid], 3);
	PlayerTextDrawColor(playerid, PTD_iPhone_Calculator[playerid], -1);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone_Calculator[playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone_Calculator[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, PTD_iPhone_Calculator[playerid], 51);
	PlayerTextDrawFont(playerid, PTD_iPhone_Calculator[playerid], 2);
	PlayerTextDrawSetProportional(playerid, PTD_iPhone_Calculator[playerid], 1);

	PTD_iPhone_Call[playerid] = CreatePlayerTextDraw(playerid, 586.666870, 264.651885, "_");
	PlayerTextDrawLetterSize(playerid, PTD_iPhone_Call[playerid], 0.333332, 1.239110);
	PlayerTextDrawAlignment(playerid, PTD_iPhone_Call[playerid], 3);
	PlayerTextDrawColor(playerid, PTD_iPhone_Call[playerid], -1);
	PlayerTextDrawSetShadow(playerid, PTD_iPhone_Call[playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_iPhone_Call[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, PTD_iPhone_Call[playerid], 51);
	PlayerTextDrawFont(playerid, PTD_iPhone_Call[playerid], 1);
	PlayerTextDrawSetProportional(playerid, PTD_iPhone_Call[playerid], 1);
	return 1;
}

stock DestroyPlayerIphone(playerid)
{
	loop(0, 37, PHONE) PlayerTextDrawDestroy(playerid, PTD_iPhone[PHONE][playerid]);
	PlayerTextDrawDestroy(playerid, PTD_iPhone_Gallery[playerid]);
	PlayerTextDrawDestroy(playerid, PTD_iPhone_GPS[playerid]);
	PlayerTextDrawDestroy(playerid, PTD_iPhone_Calculator[playerid]);
	PlayerTextDrawDestroy(playerid, PTD_iPhone_Call[playerid]);
	DestroyObject(firstperson[playerid]);
	return 1;
}


/*

iPhone S by adri1 (http://forum.sa-mp.com/member.php?u=106967)

Test: adri1 & Alex15 (http://forum.sa-mp.com/member.php?u=207755)

*/
