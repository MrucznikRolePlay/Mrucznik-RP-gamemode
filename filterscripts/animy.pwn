//All SA-MP animations for 0.3b
//Edited by erik019
#include <a_samp>
#include <core>
#include <float>
#include <dini>
#include <dutils>
#include <dudb>
#include <a_objects>
#include <time>
#include <string>
#include <file>

#define COLOR_SYSTEM 0xEFEFF7AA
#define COLOR_VIOLET 0x9955DEEE
#define COLOR_LIGHTRED 0xFF99AADD
#define COLOR_SEAGREEN 0x00EEADDF
#define COLOR_GRAYWHITE 0xEEEEFFC4
#define COLOR_LIGHTNEUTRALBLUE 0xabcdef66
#define COLOR_GREENISHGOLD 0xDEAD4370
#define COLOR_LIGHTBLUEGREEN 0x0FFDD349
#define COLOR_NEUTRALBLUE 0xABCDEF01
#define COLOR_LIGHTCYAN 0xAAFFCC33
#define COLOR_LEMON 0xDDDD2357
#define COLOR_MEDIUMBLUE 0x63AFF00A
#define COLOR_NEUTRAL 0xABCDEF97
#define COLOR_BLACK 0x00000000
#define COLOR_NEUTRALGREEN 0x81CFAB00
#define COLOR_DARKGREEN 0x12900BBF
#define COLOR_LIGHTGREEN 0x24FF0AB9
#define COLOR_DARKBLUE 0x300FFAAB
#define COLOR_BLUEGREEN 0x46BBAA00
#define COLOR_PINK 0xFF66FFAA
#define COLOR_BLUE 0x0000BBAA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_DARKRED 0x660000AA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_PURPLE 0x800080AA
#define COLOR_CYAN  	0x40FFFFFF


public OnPlayerCommandText(playerid, cmdtext[])
{
	new animationplayed;
	new tmp[256];
	new cmd[256];
	new idx;
	cmd = strtok(cmdtext, idx);
	
	if(strcmp(cmdtext, "/animhelp", true) == 0)
	{
		SendClientMessage(playerid, COLOR_GREEN, ">/animped /dance /animclothes /animcoach /animcolt /animcopa /animcod /animcrack");
		SendClientMessage(playerid, COLOR_GREEN, ">/animairport /animat /animbar /animball /animfire /animbeach");
		SendClientMessage(playerid, COLOR_GREEN, ">/animbp /animinf /animbiked /animbh /animfood /animbikelp /animms /animbikes /animcar");
		SendClientMessage(playerid, COLOR_GREEN, ">/animbikev /animbmx /animbikedbz /animchase /animbox /animbomber /animbsp /animcamera ");
		SendClientMessage(playerid, COLOR_GREEN, ">/animgym /animgangs /animlookers /animcarchat /animcasino /animbuddy /animbus");
		SendClientMessage(playerid, COLOR_GREEN, ">/animcarry /animintshop /animjst /animkart /animkissing /animknife /animlapdan /animdend");
		SendClientMessage(playerid, COLOR_GREEN, ">/animmedic /animmtb /animmusc /animotb /animpark /animsaw /animchoppa");
		SendClientMessage(playerid, COLOR_GREEN, ">/animhelp2 - next animation list.");
		return 1;
	}
	else if(strcmp(cmdtext, "/animhelp2", true) == 0)
	{
		SendClientMessage(playerid, COLOR_GREEN, ">/animcrib /animjump /animdealer /animdildo /animdodge /animdozer  /animdrivebys /animfat");
		SendClientMessage(playerid, COLOR_GREEN, ">/animfightb /animfightc /animfightd /animfighte /animfinale /animfinale2 /animflamef");
		SendClientMessage(playerid, COLOR_GREEN, ">/animflowers /animghands /animfw /animghetto /animgog /animgraffity /animgreya /animgren");
		SendClientMessage(playerid, COLOR_GREEN, ">/animhaircut /animheist  /animinthouse /animintoffice /animplayerdbf /animplayidles /animpolice");
		SendClientMessage(playerid, COLOR_GREEN, ">/animpool /animpoor /animpython /animquad /animquadbz /animrapping  /animrifle /animriot /animrobbank ");
		SendClientMessage(playerid, COLOR_GREEN, ">/animrocket /animrustler /animryder /animscrat /animshamal /animshop /animskate /animshotgun");
		SendClientMessage(playerid, COLOR_GREEN, ">/animvortex /animtec /animtrain /animsil /animtattoo  /animsmoking /animsniper /animspray /animstrip");
		SendClientMessage(playerid, COLOR_GREEN, ">/animbath /animswat /animsweet /animswim /animsword /animtank /animtruck /animuzi  /animvan /animvending");
		SendClientMessage(playerid, COLOR_GREEN, ">/animway /animweap /animsex /animbjob /animphone");
		return 1;
	}
	else if(strcmp(cmd, "/animbar", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbar[1-12]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 12)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbar[1-12]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "BAR", "Barcustom_get", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019,1,1);
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "BAR", "Barcustom_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019,1,1);
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "BAR", "Barcustom_order", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019,1,1);
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "BAR", "Barserve_bottle", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019,1,1);
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "BAR", "Barserve_give", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019,1,1);
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "BAR", "Barserve_glass", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019,1,1);
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "BAR", "Barserve_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019,1,1);
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "BAR", "Barserve_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019,1,1);
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "BAR", "Barserve_order", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019,1,1);
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "BAR", "dnk_stndF_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019,1,1);
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "BAR", "dnk_stndM_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019,1,1);
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "BAR", "BARman_idle", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019,1,1);
		}
		return 1;
	}
	else if(strcmp(cmd, "/animball", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animball[1-11]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 11)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animball[1-11]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "BASEBALL", "Bat_1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019,1,1);
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "BASEBALL", "Bat_2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019,1,1);
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "BASEBALL", "Bat_2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019,1,1);
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "BASEBALL", "Bat_4", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019,1,1);
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "BASEBALL", "Bat_block", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019,1,1);
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "BASEBALL", "Bat_Hit_1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019,1,1);
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "BASEBALL", "Bat_Hit_2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019,1,1);
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "BASEBALL", "Bat_Hit_3", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019,1,1);
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "BASEBALL", "Bat_IDLE", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019,1,1);
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "BASEBALL", "Bat_M", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019,1,1);
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "BASEBALL", "BAT_PART", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019,1,1);
		}
		return 1;
	}
	else if(strcmp(cmd, "/animfire", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animfire[1-13]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 13)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animfire[1-13]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "BD_FIRE", "BD_Fire1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "BD_FIRE", "BD_Fire2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "BD_FIRE", "BD_Fire3", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "BD_FIRE", "BD_GF_Wave", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "BD_FIRE", "BD_Panic_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "BD_FIRE", "BD_Panic_02", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "BD_FIRE", "BD_Panic_03", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "BD_FIRE", "BD_Panic_04", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "BD_FIRE", "BD_Panic_Loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "BD_FIRE", "M_smklean_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "BD_FIRE", "M_smklean_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "BD_FIRE", "Playa_Kiss_03", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animbeach", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbeach[1-5]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 5)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbeach[1-5]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "BEACH", "bather", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "BEACH", "Lay_Bac_Loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "BEACH", "BD_Fire3", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "BEACH", "ParkSit_W_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "BEACH", "SitnWait_loop_W", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animinf", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animinf[1-4]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 4)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animinf[1-4]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "BF_injection", "BF_getin_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "BF_injection", "BF_getin_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "BF_injection", "BF_getout_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "BF_injection", "BF_getout_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animbiked", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbiked[1-18]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 18)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbiked[1-18]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_Back", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_drivebyFT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_drivebyLHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_drivebyRHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_Fwd", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_getoffBACK", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_getoffLHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_getoffRHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_hit", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_jumponL", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_jumponR", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_kick", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_Left", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_passenger", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_pushes", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_Ride", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_Right", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_shuffle", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 18)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_Still", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animbp", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbp[1-7]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 7)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbp[1-7]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "benchpress", "gym_bp_celebrate", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "benchpress", "gym_bp_down", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "benchpress", "gym_bp_getoff", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "benchpress", "gym_bp_geton", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "benchpress", "gym_bp_up_A", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "benchpress", "gym_bp_up_B", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "benchpress", "gym_bp_up_smooth", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animbh", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbh[1-18]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 18)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbh[1-18]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "BIKEH", "BIKEh_Back", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "BIKEH", "BIKEh_drivebyFT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "BIKEH", "BIKEh_drivebyLHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "BIKEH", "BIKEh_drivebyRHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "BIKEH", "BIKEh_Fwd", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "BIKEH", "BIKEh_getoffBACK", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "BIKEH", "BIKEh_getoffLHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "BIKEH", "BIKEh_getoffRHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "BIKEH", "BIKEh_hit", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "BIKEH", "BIKEh_jumponL", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "BIKEH", "BIKEh_jumponR", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "BIKEH", "BIKEh_kick", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "BIKEH", "BIKEh_Left", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "BIKEH", "BIKEh_passenger", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "BIKEH", "BIKEh_pushes", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "BIKEH", "BIKEh_Ride", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "BIKEH", "BIKEh_Right", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 18)
		{
			ApplyPlayerAnimation(playerid, "BIKEH", "BIKEh_Still", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animms", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animms[1-8]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 8)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animms[1-8]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "BIKEH", "BIKEh_Back", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "BIKEH", "BIKEh_drivebyFT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "BIKEH", "BIKEh_drivebyLHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "BIKEH", "BIKEh_drivebyRHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "BIKEH", "BIKEh_Fwd", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "BIKEH", "BIKEh_getoffBACK", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "BIKEH", "BIKEh_getoffLHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "BIKEH", "BIKEh_getoffRHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animfood", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animfood[1-33]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 33)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animfood[1-33]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "EAT_Chicken", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "EAT_Pizza", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "EAT_Vomit_P", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "EAT_Vomit_SK", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "FF_Dam_Bkw", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "FF_Dam_Fwd", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "FF_Dam_Left", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "FF_Dam_Right", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "FF_Die_Bkw", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "FF_Die_Fwd", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "FF_Die_Left", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "FF_Die_Right", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "FF_Sit_Eat1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "FF_Sit_Eat2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "FF_Sit_Eat3", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "FF_Sit_In", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 18)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "FF_Sit_In_L", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 19)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "FF_Sit_In_R", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 20)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "FF_Sit_Look", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 21)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "FF_Sit_Loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 22)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "FF_Sit_Out_180", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 23)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "FF_Sit_Out_L_180", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 24)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "FF_Sit_Out_R_180", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 25)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "SHP_Thank", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 26)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "SHP_Tray_In", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 27)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "SHP_Tray_Lift", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 28)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "SHP_Tray_Lift_In", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 29)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "SHP_Tray_Lift_Loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 30)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "SHP_Tray_Lift_Out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 31)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "SHP_Tray_Out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 32)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "SHP_Tray_Pose", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 33)
		{
			ApplyPlayerAnimation(playerid, "FOOD", "SHP_Tray_Return", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animms", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animms[1-41]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 41)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animms[1-41]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "MISC", "bitchslap", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "MISC", "BMX_celebrate", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "MISC", "BMX_comeon", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "MISC", "bmx_idleloop_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "MISC", "bmx_idleloop_02", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "MISC", "bmx_talkleft_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "MISC", "bmx_talkleft_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "MISC", "bmx_talkleft_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "MISC", "bmx_talkright_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "MISC", "bmx_talkright_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "MISC", "bmx_talkright_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "MISC", "bng_wndw", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "MISC", "bng_wndw_02", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "MISC", "Case_pickup", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "MISC", "door_jet", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "MISC", "GRAB_L", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "MISC", "GRAB_R", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 18)
		{
			ApplyPlayerAnimation(playerid, "MISC", "Hiker_Pose", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 19)
		{
			ApplyPlayerAnimation(playerid, "MISC", "Hiker_Pose_L", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 20)
		{
			ApplyPlayerAnimation(playerid, "MISC", "Idle_Chat_02", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 21)
		{
			ApplyPlayerAnimation(playerid, "MISC", "KAT_Throw_K", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 22)
		{
			ApplyPlayerAnimation(playerid, "MISC", "KAT_Throw_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 23)
		{
			ApplyPlayerAnimation(playerid, "MISC", "KAT_Throw_P", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 24)
		{
			ApplyPlayerAnimation(playerid, "MISC", "PASS_Rifle_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 25)
		{
			ApplyPlayerAnimation(playerid, "MISC", "PASS_Rifle_Ped", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 26)
		{
			ApplyPlayerAnimation(playerid, "MISC", "PASS_Rifle_Ply", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 27)
		{
			ApplyPlayerAnimation(playerid, "MISC", "pickup_box", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 28)
		{
			ApplyPlayerAnimation(playerid, "MISC", "Plane_door", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 29)
		{
			ApplyPlayerAnimation(playerid, "MISC", "Plane_exit", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 30)
		{
			ApplyPlayerAnimation(playerid, "MISC", "Plane_hijack", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 31)
		{
			ApplyPlayerAnimation(playerid, "MISC", "Plunger_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 32)
		{
			ApplyPlayerAnimation(playerid, "MISC", "Plyrlean_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 33)
		{
			ApplyPlayerAnimation(playerid, "MISC", "plyr_shkhead", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 34)
		{
			ApplyPlayerAnimation(playerid, "MISC", "Run_Dive", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 35)
		{
			ApplyPlayerAnimation(playerid, "MISC", "Scratchballs_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 36)
		{
			ApplyPlayerAnimation(playerid, "MISC", "SEAT_LR", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 37)
		{
			ApplyPlayerAnimation(playerid, "MISC", "Seat_talk_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 38)
		{
			ApplyPlayerAnimation(playerid, "MISC", "Seat_talk_02", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 39)
		{
			ApplyPlayerAnimation(playerid, "MISC", "SEAT_watch", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 40)
		{
			ApplyPlayerAnimation(playerid, "MISC", "smalplane_door", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 41)
		{
			ApplyPlayerAnimation(playerid, "MISC", "smlplane_door", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animbikelp", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbikelp[1-9]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 9)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbikelp[1-9]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "BIKELEAP", "bk_blnce_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "BIKELEAP", "bk_blnce_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "BIKELEAP", "bk_jmp", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "BIKELEAP", "bk_rdy_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "BIKELEAP", "bk_rdy_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "BIKELEAP", "struggle_cesar", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "BIKELEAP", "struggle_driver", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "BIKELEAP", "truck_driver", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "BIKELEAP", "truck_getin", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animbikes", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbikes[1-18]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 18)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbikes[1-18]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "BIKES", "BIKEs_Back", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "BIKES", "BIKEs_drivebyFT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "BIKES", "BIKEs_drivebyLHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "BIKES", "BIKEs_drivebyRHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "BIKES", "BIKEs_Fwd", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "BIKES", "BIKEs_getoffBACK", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "BIKES", "BIKEs_getoffLHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "BIKES", "BIKEs_getoffRHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "BIKES", "BIKEs_hit", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "BIKES", "BIKEs_jumponL", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "BIKES", "BIKEs_jumponR", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "BIKES", "BIKEs_kick", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "BIKES", "BIKEs_Left", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "BIKES", "BIKEs_passenger", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "BIKES", "BIKEs_pushes", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "BIKES", "BIKEs_Ride", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "BIKES", "BIKEs_Right", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 18)
		{
			ApplyPlayerAnimation(playerid, "BIKES", "BIKEs_Still", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animbikev", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbikev[1-18]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 18)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbikev[1-18]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "BIKEV", "BIKEv_Back", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "BIKEV", "BIKEv_drivebyFT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "BIKEV", "BIKEv_drivebyLHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "BIKEV", "BIKEv_drivebyRHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "BIKEV", "BIKEv_Fwd", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "BIKEV", "BIKEv_getoffBACK", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "BIKEV", "BIKEv_getoffLHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "BIKEV", "BIKEv_getoffRHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "BIKEV", "BIKEv_hit", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "BIKEV", "BIKEv_jumponL", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "BIKEV", "BIKEv_jumponR", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "BIKEV", "BIKEv_kick", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "BIKEV", "BIKEv_Left", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "BIKEV", "BIKEv_passenger", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "BIKEV", "BIKEv_pushes", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "BIKEV", "BIKEv_Ride", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "BIKEV", "BIKEv_Right", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 18)
		{
			ApplyPlayerAnimation(playerid, "BIKEV", "BIKEv_Still", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animbmx", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbmx[1-18]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 18)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbmx[1-18]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "BMX", "BMX_back", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "BMX", "BMX_bunnyhop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "BMX", "BMX_drivebyFT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "BMX", "BMX_driveby_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "BMX", "BMX_driveby_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "BMX", "BMX_fwd", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "BMX", "BMX_getoffBACK", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "BMX", "BMX_pushes", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "BMX", "BMX_getoffLHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "BMX", "BMX_getoffRHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "BMX", "BMX_jumponL", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "BMX", "BMX_jumponR", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "BMX", "BMX_Left", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "BMX", "BMX_pedal", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "BMX", "BMX_Ride", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "BMX", "BMX_Right", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "BMX", "BMX_sprint", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 18)
		{
			ApplyPlayerAnimation(playerid, "BMX", "BMX_still", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animbikedbz", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbikedbz[1-4]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 4)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbikedbz[1-4]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "BIKE_DBZ", "Pass_Driveby_BWD", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "BIKE_DBZ", "Pass_Driveby_FWD", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "BIKE_DBZ", "Pass_Driveby_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "BIKE_DBZ", "Pass_Driveby_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animchase", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animchase[1-25]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 25)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animchase[1-25]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "MD_CHASE", "Carhit_Hangon", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "MD_CHASE", "Carhit_Tumble", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "MD_CHASE", "donutdrop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "MD_CHASE", "Fen_Choppa_L1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "MD_CHASE", "Fen_Choppa_L2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "MD_CHASE", "Fen_Choppa_L3", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "MD_CHASE", "Fen_Choppa_R1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "MD_CHASE", "Fen_Choppa_R2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "MD_CHASE", "Fen_Choppa_R3", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "MD_CHASE", "Hangon_Stun_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "MD_CHASE", "Hangon_Stun_Turn", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "MD_CHASE", "MD_BIKE_2_HANG", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "MD_CHASE", "MD_BIKE_Jmp_BL", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "MD_CHASE", "MD_BIKE_Jmp_F", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "MD_CHASE", "MD_BIKE_Lnd_BL", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "MD_CHASE", "MD_BIKE_Lnd_Die_BL", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "MD_CHASE", "MD_BIKE_Lnd_Die_F", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 18)
		{
			ApplyPlayerAnimation(playerid, "MD_CHASE", "MD_BIKE_Lnd_F", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 19)
		{
			ApplyPlayerAnimation(playerid, "MD_CHASE", "MD_BIKE_Lnd_Roll", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 20)
		{
			ApplyPlayerAnimation(playerid, "MD_CHASE", "MD_BIKE_Lnd_Roll_F", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 21)
		{
			ApplyPlayerAnimation(playerid, "MD_CHASE", "MD_BIKE_Punch", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 22)
		{
			ApplyPlayerAnimation(playerid, "MD_CHASE", "MD_BIKE_Punch_F", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 23)
		{
			ApplyPlayerAnimation(playerid, "MD_CHASE", "MD_BIKE_Shot_F", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 24)
		{
			ApplyPlayerAnimation(playerid, "MD_CHASE", "MD_HANG_Lnd_Roll", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 25)
		{
			ApplyPlayerAnimation(playerid, "MD_CHASE", "MD_HANG_Loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animbox", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbox[1-10]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 10)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbox[1-10]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "BOX", "boxhipin", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "BOX", "boxhipup", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "BOX", "boxshdwn", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "BOX", "boxshup", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "BOX", "bxhipwlk", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "BOX", "bxhwlki", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "BOX", "bxshwlk", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "BOX", "bxshwlki", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "BOX", "bxwlko", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "BOX", "catch_box", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animbomber", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbomber[1-6]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 6)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbomber[1-6]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "BOMBER", "BOM_Plant_2Idle", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "BOMBER", "BOM_Plant_Crouch_In", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "BOMBER", "BOM_Plant_Crouch_Out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "BOMBER", "BOM_Plant_In", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animbsp", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbsp[1-41]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 41)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbsp[1-41]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_def_jump_shot", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_def_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_def_stepL", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_def_stepR", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_Dnk", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_Dnk_Gli", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_Dnk_Gli_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_Dnk_Lnch", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_Dnk_Lnch_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_Dnk_Lnd", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_Dnk_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_idle", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_idle2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_idle2_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_idleloop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_idleloop_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_idle_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 18)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_Jump_Cancel", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 19)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_Jump_Cancel_0", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 20)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_Jump_End", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 21)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_Jump_Shot", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 22)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_Jump_Shot_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 23)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_Net_Dnk_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 24)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_pickup", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 25)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_pickup_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 26)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_react_miss", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 27)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_react_score", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 28)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_run", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 29)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_run_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 30)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_SkidStop_L", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 31)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_SkidStop_L_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 32)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_SkidStop_R", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 33)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_SkidStop_R_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 34)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_walk", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 35)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_WalkStop_L", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 36)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_WalkStop_L_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 37)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_WalkStop_R", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 38)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_WalkStop_R_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 39)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_walk_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 40)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_walk_start", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 41)
		{
			ApplyPlayerAnimation(playerid, "BSKTBALL", "BBALL_walk_start_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animcamera", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animcamera[1-14]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 14)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animcamera[1-14]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "CAMERA", "camcrch_cmon", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "CAMERA", "camcrch_idleloop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "CAMERA", "camcrch_stay", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "CAMERA", "camcrch_to_camstnd", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "CAMERA", "camstnd_cmon", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "CAMERA", "camstnd_idleloop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "CAMERA", "camstnd_lkabt", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "CAMERA", "camstnd_to_camcrch", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "CAMERA", "piccrch_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "CAMERA", "piccrch_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "CAMERA", "piccrch_take", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "CAMERA", "picstnd_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "CAMERA", "picstnd_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "CAMERA", "picstnd_take", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animgym", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animgym[1-24]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 24)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animgym[1-24]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "GYMNASIUM", "GYMshadowbox", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "GYMNASIUM", "gym_bike_celebrate", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "GYMNASIUM", "gym_bike_fast", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "GYMNASIUM", "gym_bike_faster", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "GYMNASIUM", "gym_bike_getoff", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "GYMNASIUM", "gym_bike_geton", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "GYMNASIUM", "gym_bike_pedal", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "GYMNASIUM", "gym_bike_slow", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "GYMNASIUM", "gym_bike_still", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "GYMNASIUM", "gym_jog_falloff", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "GYMNASIUM", "gym_shadowbox", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "GYMNASIUM", "gym_tread_celebrate", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "GYMNASIUM", "gym_tread_falloff", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "GYMNASIUM", "gym_tread_getoff", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "GYMNASIUM", "gym_tread_geton", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "GYMNASIUM", "gym_tread_jog", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "GYMNASIUM", "gym_tread_sprint", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 18)
		{
			ApplyPlayerAnimation(playerid, "GYMNASIUM", "gym_tread_tired", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 19)
		{
			ApplyPlayerAnimation(playerid, "GYMNASIUM", "gym_tread_walk", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 20)
		{
			ApplyPlayerAnimation(playerid, "GYMNASIUM", "gym_walk_falloff", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 21)
		{
			ApplyPlayerAnimation(playerid, "GYMNASIUM", "Pedals_fast", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 22)
		{
			ApplyPlayerAnimation(playerid, "GYMNASIUM", "Pedals_med", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 23)
		{
			ApplyPlayerAnimation(playerid, "GYMNASIUM", "Pedals_slow", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 24)
		{
			ApplyPlayerAnimation(playerid, "GYMNASIUM", "Pedals_still", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animpara", true) == 0)
	{
		SendClientMessage(playerid, 0xFF0000FF, "Te animacje zostaly zablokowane!");
		return 1;
	}
	/*if(strcmp(cmd, "/animpara", true) == 0) {
	tmp = strtok(cmdtext, idx);
	if(!strlen(tmp)) {
	SendClientMessage(playerid,0xFF0000FF,">Write /animpara[1-22]");
	return 1;
	}
	animationplayed = strval(tmp);
	if(animationplayed < 1 || animationplayed > 22) {
	SendClientMessage(playerid,0xFF0000FF,">Write /animpara[1-22]");
	return 1;
	}
	if(animationplayed == 1) {
	ApplyPlayerAnimation(playerid,"PARACHUTE","FALL_skyDive",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 2) {
	ApplyPlayerAnimation(playerid,"PARACHUTE","FALL_SkyDive_Accel",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 3) {
	ApplyPlayerAnimation(playerid,"PARACHUTE","FALL_skyDive_DIE",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 4) {
	ApplyPlayerAnimation(playerid,"PARACHUTE","FALL_SkyDive_L",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 5) {
	ApplyPlayerAnimation(playerid,"PARACHUTE","FALL_SkyDive_R",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 6) {
	ApplyPlayerAnimation(playerid,"PARACHUTE","PARA_decel",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 7) {
	ApplyPlayerAnimation(playerid,"PARACHUTE","PARA_decel_O",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 8) {
	ApplyPlayerAnimation(playerid,"PARACHUTE","PARA_float",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 9) {
	ApplyPlayerAnimation(playerid,"PARACHUTE","PARA_float_O",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 10) {
	ApplyPlayerAnimation(playerid,"PARACHUTE","PARA_Land",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 11) {
	ApplyPlayerAnimation(playerid,"PARACHUTE","PARA_Land_O",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 12) {
	ApplyPlayerAnimation(playerid,"PARACHUTE","PARA_Land_Water",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 13) {
	ApplyPlayerAnimation(playerid,"PARACHUTE","PARA_Land_Water_O",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 14) {
	ApplyPlayerAnimation(playerid,"PARACHUTE","PARA_open",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 15) {
	ApplyPlayerAnimation(playerid,"PARACHUTE","PARA_open_O",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 16) {
	ApplyPlayerAnimation(playerid,"PARACHUTE","PARA_Rip_Land_O",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 17) {
	ApplyPlayerAnimation(playerid,"PARACHUTE","PARA_Rip_Loop_O",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 18) {
	ApplyPlayerAnimation(playerid,"PARACHUTE","PARA_Rip_O",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 19) {
	ApplyPlayerAnimation(playerid,"PARACHUTE","PARA_steerL",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 20) {
	ApplyPlayerAnimation(playerid,"PARACHUTE","PARA_steerL_O",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 21) {
	ApplyPlayerAnimation(playerid,"PARACHUTE","PARA_steerR",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 22) {
	ApplyPlayerAnimation(playerid,"PARACHUTE","PARA_steerR_O",4.1,0,1,1,1,1,1);	//edited by erik019
	}
	return 1;
	}*/
	else if(strcmp(cmd, "/animgangs", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animgangs[1-22]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 22)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animgangs[1-22]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "DEALER_DEAL", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "DEALER_IDLE", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "drnkbr_prtl", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "drnkbr_prtl_F", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "DRUGS_BUY", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "hndshkaa", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "hndshkba", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "hndshkca", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "hndshkcb", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "hndshkda", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "hndshkea", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "hndshkfa", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "hndshkfa_swt", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "Invite_No", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "Invite_Yes", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "leanIDLE", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "leanIN", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 18)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "leanOUT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 19)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "prtial_gngtlkA", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 20)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "prtial_gngtlkB", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 21)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "prtial_gngtlkCt", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 22)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "prtial_gngtlkD", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 23)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "prtial_gngtlkE", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 24)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "prtial_gngtlkF", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 25)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "prtial_gngtlkG", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 26)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "prtial_gngtlkH", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 27)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "prtial_hndshk_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 28)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "prtial_hndshk_biz_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 29)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "shake_cara", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 30)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "shake_carK", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 31)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "shake_carSH", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 32)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "smkcig_prtl", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 33)
		{
			ApplyPlayerAnimation(playerid, "GANGS", "smkcig_prtl_F", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animlowrider", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animlowrider[1-39]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 39)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animlowrider[1-39]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "F_smklean_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "lrgirl_bdbnce", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "lrgirl_hair", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "lrgirl_hurry", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "lrgirl_idleloop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "lrgirl_idle_to_l0", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "lrgirl_l0_bnce", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "lrgirl_l0_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "lrgirl_l0_to_l1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "lrgirl_l12_to_l0", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "lrgirl_l1_bnce", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "lrgirl_l1_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "lrgirl_l1_to_l2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "lrgirl_l2_bnce", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "lrgirl_l2_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "lrgirl_l2_to_l3", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "lrgirl_l345_to_l1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 18)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "lrgirl_l3_bnce", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 19)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "lrgirl_l3_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 20)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "lrgirl_l3_to_l4", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 21)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "lrgirl_l4_bnce", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 22)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "lrgirl_l4_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 23)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "lrgirl_l4_to_l5", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 24)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "lrgirl_l5_bnce", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 25)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "lrgirl_l5_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 26)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "M_smklean_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 27)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "M_smkstnd_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 28)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "prtial_gngtlkB", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 29)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "prtial_gngtlkC", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 30)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "prtial_gngtlkD", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 31)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "prtial_gngtlkE", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 32)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "prtial_gngtlkF", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 33)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "prtial_gngtlkG", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 34)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "prtial_gngtlkH", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 35)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "RAP_A_Loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 36)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "RAP_B_Loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 37)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "RAP_C_Loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 38)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "Sit_relaxed", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 39)
		{
			ApplyPlayerAnimation(playerid, "LOWRIDER", "Tap_hand", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animlookers", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animlookers[1-25]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 25)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animlookers[1-25]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "ON_LOOKERS", "lkaround_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "ON_LOOKERS", "lkaround_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "ON_LOOKERS", "lkaround_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "ON_LOOKERS", "lkup_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "ON_LOOKERS", "lkup_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "ON_LOOKERS", "lkup_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "ON_LOOKERS", "lkup_point", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "ON_LOOKERS", "panic_cower", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "ON_LOOKERS", "panic_hide", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "ON_LOOKERS", "panic_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "ON_LOOKERS", "panic_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "ON_LOOKERS", "panic_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "ON_LOOKERS", "panic_point", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "ON_LOOKERS", "panic_shout", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "ON_LOOKERS", "Pointup_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "ON_LOOKERS", "Pointup_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "ON_LOOKERS", "Pointup_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 18)
		{
			ApplyPlayerAnimation(playerid, "ON_LOOKERS", "Pointup_shout", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 19)
		{
			ApplyPlayerAnimation(playerid, "ON_LOOKERS", "point_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 20)
		{
			ApplyPlayerAnimation(playerid, "ON_LOOKERS", "point_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 21)
		{
			ApplyPlayerAnimation(playerid, "ON_LOOKERS", "point_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 22)
		{
			ApplyPlayerAnimation(playerid, "ON_LOOKERS", "shout_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 23)
		{
			ApplyPlayerAnimation(playerid, "ON_LOOKERS", "shout_02", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 24)
		{
			ApplyPlayerAnimation(playerid, "ON_LOOKERS", "shout_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 25)
		{
			ApplyPlayerAnimation(playerid, "ON_LOOKERS", "shout_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 26)
		{
			ApplyPlayerAnimation(playerid, "ON_LOOKERS", "shout_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 27)
		{
			ApplyPlayerAnimation(playerid, "ON_LOOKERS", "wave_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 28)
		{
			ApplyPlayerAnimation(playerid, "ON_LOOKERS", "wave_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 25)
		{
			ApplyPlayerAnimation(playerid, "ON_LOOKERS", "wave_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animcarchat", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animcarchat[1-20]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 20)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animcarchat[1-20]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "CAR_CHAT", "carfone_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "CAR_CHAT", "carfone_loopA", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "CAR_CHAT", "carfone_loopA_to_B", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "CAR_CHAT", "carfone_loopB", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "CAR_CHAT", "carfone_loopB_to_A", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "CAR_CHAT", "carfone_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "CAR_CHAT", "CAR_Sc1_BR", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "CAR_CHAT", "CAR_Sc1_FL", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "CAR_CHAT", "CAR_Sc1_FR", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "CAR_CHAT", "CAR_Sc2_FL", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "CAR_CHAT", "CAR_Sc3_BR", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "CAR_CHAT", "CAR_Sc3_FL", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "CAR_CHAT", "CAR_Sc3_FR", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "CAR_CHAT", "CAR_Sc4_BL", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "CAR_CHAT", "CAR_Sc4_BR", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "CAR_CHAT", "CAR_Sc4_FL", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "CAR_CHAT", "CAR_Sc4_FR", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 18)
		{
			ApplyPlayerAnimation(playerid, "CAR_CHAT", "car_talkm_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 19)
		{
			ApplyPlayerAnimation(playerid, "CAR_CHAT", "car_talkm_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 20)
		{
			ApplyPlayerAnimation(playerid, "CAR_CHAT", "car_talkm_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animcasino", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animcasino[1-23]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 23)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animcasino[1-23]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "CASINO", "cards_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "CASINO", "cards_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "CASINO", "cards_lose", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "CASINO", "cards_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "CASINO", "cards_pick_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "CASINO", "cards_pick_02", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "CASINO", "cards_raise", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "CASINO", "cards_win", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "CASINO", "manwinb", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "CASINO", "manwind", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "CASINO", "Roulette_bet", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "CASINO", "Roulette_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "CASINO", "Roulette_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "CASINO", "Roulette_lose", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "CASINO", "Roulette_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "CASINO", "Roulette_win", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "CASINO", "Slot_bet_02", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 18)
		{
			ApplyPlayerAnimation(playerid, "CASINO", "Slot_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 19)
		{
			ApplyPlayerAnimation(playerid, "CASINO", "Slot_lose_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 20)
		{
			ApplyPlayerAnimation(playerid, "CASINO", "Slot_Plyr", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 21)
		{
			ApplyPlayerAnimation(playerid, "CASINO", "Slot_wait", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 22)
		{
			ApplyPlayerAnimation(playerid, "CASINO", "Slot_win_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 23)
		{
			ApplyPlayerAnimation(playerid, "CASINO", "wof", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animbuddy", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbuddy[1-5]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 5)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbuddy[1-5]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "BUDDY", "buddy_crouchfire", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "BUDDY", "buddy_crouchreload", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "BUDDY", "buddy_fire", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "BUDDY", "buddy_fire_poor", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "BUDDY", "buddy_reload", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animbus", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbus[1-9]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 9)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbus[1-9]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "BUS", "BUS_close", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "BUS", "BUS_getin_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "BUS", "BUS_getin_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "BUS", "BUS_getout_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "BUS", "BUS_getout_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "BUS", "BUS_jacked_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "BUS", "BUS_open", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "BUS", "BUS_open_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "BUS", "BUS_pullout_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animcar", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animcar[1-11]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 11)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animcar[1-11]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "CAR", "Fixn_Car_Loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "CAR", "Fixn_Car_Out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "CAR", "flag_drop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "CAR", "Sit_relaxed", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "CAR", "Tap_hand", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "CAR", "Tyd2car_bump", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "CAR", "Tyd2car_high", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "CAR", "Tyd2car_low", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "CAR", "Tyd2car_med", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "CAR", "Tyd2car_TurnL", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "CAR", "Tyd2car_TurnR", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animcarry", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animcarry[1-7]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 7)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animcarry[1-7]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "CARRY", "crry_prtial", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "CARRY", "liftup", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "CARRY", "liftup05", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "CARRY", "liftup105", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "CARRY", "putdwn", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "CARRY", "putdwn05", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "CARRY", "putdwn105", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animintshop", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animintshop[1-8]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 8)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animintshop[1-8]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "INT_SHOP", "shop_cashier", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "INT_SHOP", "shop_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "INT_SHOP", "shop_lookA", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "INT_SHOP", "shop_lookB", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "INT_SHOP", "shop_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "INT_SHOP", "shop_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "INT_SHOP", "shop_pay", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "INT_SHOP", "shop_shelf", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animjst", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animjst[1-4]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 4)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animjst[1-4]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "JST_BUISNESS", "girl_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "JST_BUISNESS", "girl_02", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "JST_BUISNESS", "player_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "JST_BUISNESS", "smoke_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animkart", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animkart[1-4]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 4)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animkart[1-4]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "KART", "KART_getin_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "KART", "KART_getin_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "KART", "KART_getout_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "KART", "KART_getout_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animkissing", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animkissing[1-14]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 14)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animkissing[1-14]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "KISSING", "BD_GF_Wave", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "KISSING", "gfwave2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "KISSING", "GF_CarArgue_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "KISSING", "GF_CarArgue_02", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "KISSING", "GF_CarSpot", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "KISSING", "GF_StreetArgue_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "KISSING", "GF_StreetArgue_02", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "KISSING", "gift_give", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "KISSING", "Grlfrd_Kiss_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "KISSING", "Grlfrd_Kiss_02", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "KISSING", "Grlfrd_Kiss_03", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "KISSING", "Playa_Kiss_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "KISSING", "Playa_Kiss_02", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "KISSING", "Playa_Kiss_03", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animknife", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animknife[1-14]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 14)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animknife[1-14]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "KNIFE", "KILL_Knife_Ped_Damage", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "KNIFE", "KILL_Knife_Ped_Die", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "KNIFE", "KILL_Knife_Player", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "KNIFE", "KILL_Partial", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "KNIFE", "knife_2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "KNIFE", "knife_3", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "KNIFE", "knife_4", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "KNIFE", "Knife_G", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "KNIFE", "knife_hit_1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "KNIFE", "knife_hit_2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "KNIFE", "knife_IDLE", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "KNIFE", "knife_hit_3", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "KNIFE", "knife_part", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "KNIFE", "WEAPON_knifeidle", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animlapdan", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animlapdan[1-6]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 6)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animlapdan[1-6]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "LAPDAN1", "LAPDAN_D", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "LAPDAN1", "LAPDAN_P", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "LAPDAN2", "LAPDAN_D", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "LAPDAN2", "LAPDAN_P", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "LAPDAN3", "LAPDAN_D", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "LAPDAN3", "LAPDAN_P", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animdend", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animdend[1-8]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 8)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animdend[1-8]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "MD_END", "END_SC1_PLY", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "MD_END", "END_SC1_RYD", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "MD_END", "END_SC1_SMO", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "MD_END", "END_SC1_SWE", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "MD_END", "END_SC2_PLY", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "MD_END", "END_SC2_RYD", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "MD_END", "END_SC2_SMO", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "MD_END", "END_SC2_SWE", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}

	else if(strcmp(cmd, "/animmedic", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animmedic[1]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 1)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animmedic[1]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "MEDIC", "CPR", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animmtb", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animmtb[1-18]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 18)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animmtb[1-18]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "MTB", "MTB_back", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "MTB", "MTB_bunnyhop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "MTB", "MTB_drivebyFT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "MTB", "MTB_driveby_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "MTB", "MTB_driveby_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "MTB", "MTB_fwd", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "MTB", "MTB_getoffBACK", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "MTB", "MTB_pushes", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "MTB", "MTB_getoffLHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "MTB", "MTB_getoffRHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "MTB", "MTB_jumponL", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "MTB", "MTB_jumponR", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "MTB", "MTB_Left", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "MTB", "MTB_pedal", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "MTB", "MTB_Ride", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "MTB", "MTB_Right", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "MTB", "MTB_sprint", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 18)
		{
			ApplyPlayerAnimation(playerid, "MTB", "MTB_still", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animmusc", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animmusc[1-17]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 17)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animmusc[1-17]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "MUSCULAR", "MscleWalkst_armed", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "MUSCULAR", "MscleWalkst_Csaw", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "MUSCULAR", "Mscle_rckt_run", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "MUSCULAR", "Mscle_rckt_walkst", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "MUSCULAR", "Mscle_run_Csaw", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "MUSCULAR", "MuscleIdle", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "MUSCULAR", "MuscleIdle_armed", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "MUSCULAR", "MuscleIdle_Csaw", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "MUSCULAR", "MuscleIdle_rocket", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "MUSCULAR", "MuscleRun", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "MUSCULAR", "MuscleRun_armed", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "MUSCULAR", "MuscleSprint", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "MUSCULAR", "MuscleWalk", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "MUSCULAR", "MuscleWalkstart", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "MUSCULAR", "MuscleWalk_armed", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "MUSCULAR", "Musclewalk_Csaw", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "MUSCULAR", "Musclewalk_rocket", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animotb", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animotb[1-11]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 11)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animotb[1-11]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "OTB", "betslp_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "OTB", "betslp_lkabt", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "OTB", "betslp_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "OTB", "betslp_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "OTB", "betslp_tnk", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "OTB", "wtchrace_cmon", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "OTB", "wtchrace_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "OTB", "wtchrace_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "OTB", "wtchrace_lose", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "OTB", "wtchrace_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "OTB", "wtchrace_win", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animnevada", true) == 0)
	{
		SendClientMessage(playerid, 0xFF0000FF, "Te animacje zostaly zablokowane!");
		return 1;
	}
	/*if(strcmp(cmd, "/animnevada", true) == 0) {
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
	tmp = strtok(cmdtext, idx);
	if(!strlen(tmp)) {
	SendClientMessage(playerid,0xFF0000FF,">Write /animnevada[1-2]");
	return 1;
	}
	animationplayed = strval(tmp);
	if(animationplayed < 1 || animationplayed > 2) {
	SendClientMessage(playerid,0xFF0000FF,">Write /animnevada[1-2]");
	return 1;
	}
	if(animationplayed == 1) {
	ApplyPlayerAnimation(playerid,"NEVADA","NEVADA_getin",4.1,0,1,1,1,1,1);	//edited by erik019
	} else if(animationplayed == 2) {
	ApplyPlayerAnimation(playerid,"NEVADA","NEVADA_getout",4.1,0,1,1,1,1,1);	//edited by erik019
	}
	return 1;
	}
	}*/
	else if(strcmp(cmd, "/animpark", true) == 0)
	{
		if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
				SendClientMessage(playerid, 0xFF0000FF, ">Write /animpark[1-3]");
				return 1;
			}
			animationplayed = strval(tmp);
			if (animationplayed < 1 || animationplayed > 3)
			{
				SendClientMessage(playerid, 0xFF0000FF, ">Write /animpark[1-3]");
				return 1;
			}
			if (animationplayed == 1)
			{
				ApplyPlayerAnimation(playerid, "PARK", "Tai_Chi_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
			}
			else if (animationplayed == 2)
			{
				ApplyPlayerAnimation(playerid, "PARK", "Tai_Chi_Loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
			}
			else if (animationplayed == 3)
			{
				ApplyPlayerAnimation(playerid, "PARK", "Tai_Chi_Out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
			}
			return 1;
		}
	}
	else if(strcmp(cmd, "/animpaul", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animpaul[1-12]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 12)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animpaul[1-12]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "PAULNMAC", "Piss_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "PAULNMAC", "Piss_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "PAULNMAC", "Piss_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "PAULNMAC", "PnM_Argue1_A", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "PAULNMAC", "PnM_Argue1_B", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "PAULNMAC", "PnM_Argue2_A", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "PAULNMAC", "PnM_Argue2_B", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "PAULNMAC", "PnM_Loop_A", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "PAULNMAC", "PnM_Loop_B", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "PAULNMAC", "wank_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "PAULNMAC", "wank_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "PAULNMAC", "wank_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animsaw", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animsaw[1-10]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 12)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animsaw[1-10]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "CHAINSAW", "CSAW_1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "CHAINSAW", "CSAW_2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "CHAINSAW", "CSAW_3", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "CHAINSAW", "CSAW_G", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "CHAINSAW", "CSAW_Hit_1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "CHAINSAW", "CSAW_Hit_2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "CHAINSAW", "CSAW_Hit_3", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "CHAINSAW", "IDLE_csaw", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "CHAINSAW", "WEAPON_csaw", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "CHAINSAW", "WEAPON_csawlo", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animchoppa", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animchoppa[1-18]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 18)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animchoppa[1-18]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "CHOPPA", "CHOPPA_back", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "CHOPPA", "CHOPPA_bunnyhop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "CHOPPA", "CHOPPA_drivebyFT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "CHOPPA", "CHOPPA_driveby_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "CHOPPA", "CHOPPA_driveby_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "CHOPPA", "CHOPPA_fwd", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "CHOPPA", "CHOPPA_getoffBACK", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "CHOPPA", "CHOPPA_getoffLHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "CHOPPA", "CHOPPA_getoffRHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "CHOPPA", "CHOPPA_jumponL", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "CHOPPA", "CHOPPA_jumponR", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "CHOPPA", "CHOPPA_Left", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "CHOPPA", "CHOPPA_pedal", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "CHOPPA", "CHOPPA_Pushes", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "CHOPPA", "CHOPPA_ride", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "CHOPPA", "CHOPPA_Right", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "CHOPPA", "CHOPPA_sprint", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 18)
		{
			ApplyPlayerAnimation(playerid, "CHOPPA", "CHOPPA_Still", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}

	else if(strcmp(cmd, "/animclothes", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animclothes[1-13]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 13)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animclothes[1-13]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "CLOTHES", "CLO_Buy", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "CLOTHES", "CLO_In", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "CLOTHES", "CLO_Out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "CLOTHES", "CLO_Pose_Hat", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "CLOTHES", "CLO_Pose_In", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "CLOTHES", "CLO_Pose_In_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "CLOTHES", "CLO_Pose_Legs", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "CLOTHES", "CLO_Pose_Loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "CLOTHES", "CLO_Pose_Out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "CLOTHES", "CLO_Pose_Out_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "CLOTHES", "CLO_Pose_Shoes", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "CLOTHES", "CLO_Pose_Torso", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "CLOTHES", "CLO_Pose_Watch", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animcoach", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animcoach[1-6]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 6)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animcoach[1-6]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "COACH", "COACH_inL", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "COACH", "COACH_inR", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "COACH", "COACH_opnL", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "COACH", "COACH_opnR", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "COACH", "COACH_outL", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "COACH", "COACH_outR", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}

	else if(strcmp(cmd, "/animcolt", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animcolt[1-7]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 7)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animcolt[1-7]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "COLT45", "2guns_crouchfire", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "COLT45", "colt45_crouchfire", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "COLT45", "colt45_crouchreload", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "COLT45", "colt45_fire", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "COLT45", "colt45_fire_2hands", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "COLT45", "colt45_reload", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "COLT45", "sawnoff_reload", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animcopa", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animcopa[1-12]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 12)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animcopa[1-12]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "COP_AMBIENT", "Copbrowse_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "COP_AMBIENT", "Copbrowse_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "COP_AMBIENT", "Copbrowse_nod", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "COP_AMBIENT", "Copbrowse_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "COP_AMBIENT", "Copbrowse_shake", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "COP_AMBIENT", "Coplook_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "COP_AMBIENT", "Coplook_nod", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "COP_AMBIENT", "Coplook_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "COP_AMBIENT", "Coplook_shake", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "COP_AMBIENT", "Coplook_think", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "COP_AMBIENT", "Coplook_watch", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animcod", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animcod[1-4]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 4)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animcod[1-4]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "COP_DVBYZ", "COP_Dvby_B", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "COP_DVBYZ", "COP_Dvby_FT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "COP_DVBYZ", "COP_Dvby_L", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "COP_DVBYZ", "COP_Dvby_R", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animcrack", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animcrack[1-9]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 9)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animcrack[1-9]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "CRACK", "Bbalbat_Idle_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "CRACK", "Bbalbat_Idle_02", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "CRACK", "crckdeth1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "CRACK", "crckdeth2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "CRACK", "crckdeth3", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "CRACK", "crckdeth4", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "CRACK", "crckidle1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "CRACK", "crckidle2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "CRACK", "crckidle3", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animcrib", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animcrib[1-5]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 5)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animcrib[1-5]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "CRIB", "CRIB_Console_Loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "CRIB", "CRIB_Use_Switch", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "CRIB", "PED_Console_Loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "CRIB", "PED_Console_Loose", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "CRIB", "PED_Console_Win", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animjump", true) == 0)
	{
		/*
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) {
		SendClientMessage(playerid,0xFF0000FF,">Write /animjump[1-5]");
		return 1;
		}
		animationplayed = strval(tmp);
		if(animationplayed < 1 || animationplayed > 5) {
		SendClientMessage(playerid,0xFF0000FF,">Write /animjump[1-5]"); */
		SendClientMessage(playerid, 0xFF0000FF, "Te animacje zostaly zablokowane");
		return 1;
	}
	/*
	if(animationplayed == 1) {
	ApplyPlayerAnimation(playerid,"DAM_JUMP","DAM_Dive_Loop",4.1,0,1,1,1,1,1);	//edited by erik019
	} else if(animationplayed == 2) {
	ApplyPlayerAnimation(playerid,"DAM_JUMP","DAM_Land",4.1,0,1,1,1,1,1);	//edited by erik019
	} else if(animationplayed == 3) {
	ApplyPlayerAnimation(playerid,"DAM_JUMP","DAM_Launch",4.1,0,1,1,1,1,1);	//edited by erik019
	} else if(animationplayed == 4) {
	ApplyPlayerAnimation(playerid,"DAM_JUMP","Jump_Roll",4.1,0,1,1,1,1,1);	//edited by erik019
	} else if(animationplayed == 5) {
	ApplyPlayerAnimation(playerid,"DAM_JUMP","SF_JumpWall",4.1,0,1,1,1,1,1);	//edited by erik019
	}
	return 1;
	}*/
	else if(strcmp(cmd, "/animdance", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animdance[1-13]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 13)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animdance[1-13]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "DANCING", "bd_clap", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "DANCING", "bd_clap1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "DANCING", "dance_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "DANCING", "DAN_Down_A", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "DANCING", "DAN_Left_A", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "DANCING", "DAN_Loop_A", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "DANCING", "DAN_Right_A", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "DANCING", "DAN_Up_A", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "DANCING", "dnce_M_a", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "DANCING", "dnce_M_b", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "DANCING", "dnce_M_c", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "DANCING", "dnce_M_d", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "DANCING", "dnce_M_e", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animdealer", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animdealer[1-7]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 7)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animdealer[1-7]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "DEALER", "DEALER_DEAL", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "DEALER", "DEALER_IDLE", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "DEALER", "DEALER_IDLE_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "DEALER", "DEALER_IDLE_02", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "DEALER", "DEALER_IDLE_03", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "DEALER", "DRUGS_BUY", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "DEALER", "shop_pay", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animdildo", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animdildo[1-9]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 9)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animdildo[1-9]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "DILDO", "DILDO_1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "DILDO", "DILDO_2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "DILDO", "DILDO_3", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "DILDO", "DILDO_block", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "DILDO", "DILDO_G", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "DILDO", "DILDO_Hit_1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "DILDO", "DILDO_Hit_2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "DILDO", "DILDO_Hit_3", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "DILDO", "DILDO_IDLE", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animdodge", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animdodge[1-4]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 4)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animdodge[1-4]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "DODGE", "Cover_Dive_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "DODGE", "Cover_Dive_02", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "DODGE", "Crushed", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "DODGE", "Crush_Jump", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animdozer", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animdozer[1-9]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 9)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animdozer[1-9]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "DOZER", "DOZER_Align_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "DOZER", "DOZER_Align_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "DOZER", "DOZER_getin_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "DOZER", "DOZER_getin_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "DOZER", "DOZER_getout_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "DOZER", "DOZER_getout_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "DOZER", "DOZER_Jacked_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "DOZER", "DOZER_Jacked_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "DOZER", "DOZER_pullout_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animdrivebys", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animdrivebys[1-8]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 8)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animdrivebys[1-8]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "DRIVEBYS", "Gang_DrivebyLHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "DRIVEBYS", "Gang_DrivebyLHS_Bwd", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "DRIVEBYS", "Gang_DrivebyLHS_Fwd", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "DRIVEBYS", "Gang_DrivebyRHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "DRIVEBYS", "Gang_DrivebyRHS_Bwd", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "DRIVEBYS", "Gang_DrivebyRHS_Fwd", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "DRIVEBYS", "Gang_DrivebyTop_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "DRIVEBYS", "Gang_DrivebyTop_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animfat", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animfat[1-17]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 17)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animfat[1-17]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "FAT", "FatIdle", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "FAT", "FatIdle_armed", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "FAT", "FatIdle_Csaw", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "FAT", "FatIdle_Rocket", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "FAT", "FatRun", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "FAT", "FatRun_armed", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "FAT", "FatRun_Csaw", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "FAT", "FatRun_Rocket", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "FAT", "FatSprint", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "FAT", "FatWalk", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "FAT", "FatWalkstart", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "FAT", "FatWalkstart_Csaw", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "FAT", "FatWalkSt_armed", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "FAT", "FatWalkSt_Rocket", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "FAT", "FatWalk_armed", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "FAT", "FatWalk_Csaw", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "FAT", "FatWalk_Rocket", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "FAT", "IDLE_tired", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animfightb", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animfightb[1-10]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 10)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animfightb[1-10]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_B", "FightB_1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_B", "FightB_2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_B", "FightB_3", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_B", "FightB_block", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_B", "FightB_G", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_B", "FightB_IDLE", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_B", "FightB_M", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_B", "HitB_1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_B", "HitB_2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_B", "HitB_3", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animfightc", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animfightc[1-12]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 12)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animfightc[1-12]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_C", "FightC_1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_C", "FightC_2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_C", "FightC_3", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_C", "FightC_block", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_C", "FightC_blocking", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_C", "FightC_G", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_C", "FightC_IDLE", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_C", "FightC_M", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_C", "FightC_Spar", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_C", "HitC_1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_C", "HitC_2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_C", "HitC_3", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animfightd", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animfightd[1-10]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 10)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animfightd[1-10]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_D", "FightD_1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_D", "FightD_2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_D", "FightD_3", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_D", "FightD_block", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_D", "FightD_G", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_D", "FightD_IDLE", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_D", "FightD_M", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_D", "HitD_1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_D", "HitD_2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_D", "HitD_3", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}

	else if(strcmp(cmd, "/animfighte", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animfighte[1-4]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 4)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animfighte[1-4]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_E", "FightKick", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_E", "FightKick_B", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_E", "Hit_fightkick", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "FIGHT_E", "Hit_fightkick_B", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animfinale", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animfinale[1-15]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 15)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animfinale[1-15]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "FINALE", "FIN_Climb_In", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "FINALE", "FIN_Cop1_ClimbOut2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "FINALE", "FIN_Cop1_Loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "FINALE", "FIN_Cop1_Stomp", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "FINALE", "FIN_Hang_L", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "FINALE", "FIN_Hang_Loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "FINALE", "FIN_Hang_R", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "FINALE", "FIN_Hang_L", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "FINALE", "FIN_Jump_On", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "FINALE", "FIN_Land_Car", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "FINALE", "FIN_Land_Die", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "FINALE", "FIN_LegsUp", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "FINALE", "FIN_LegsUp_L", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "FINALE", "FIN_LegsUp_Loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "FINALE", "FIN_LegsUp_R", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "FINALE", "FIN_Let_Go", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animfinale2", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animfinale2[1-8]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 8)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animfinale2[1-8]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "FINALE2", "FIN_Cop1_ClimbOut", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "FINALE2", "FIN_Cop1_Fall", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "FINALE2", "FIN_Cop1_Loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "FINALE2", "FIN_Cop1_Shot", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "FINALE2", "FIN_Cop1_Swing", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "FINALE2", "FIN_Cop2_ClimbOut", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "FINALE2", "FIN_Switch_P", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "FINALE2", "FIN_Switch_S", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animflamef", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animflamef[1-1]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 1)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animflamef[1-1]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "FLAME", "FLAME_fire", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animflowers", true) == 0)
	{
		if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
				SendClientMessage(playerid, 0xFF0000FF, ">Write /animflowers[1-3]");
				return 1;
			}
			animationplayed = strval(tmp);
			if (animationplayed < 1 || animationplayed > 3)
			{
				SendClientMessage(playerid, 0xFF0000FF, ">Write /animflowers[1-3]");
				return 1;
			}
			if (animationplayed == 1)
			{
				ApplyPlayerAnimation(playerid, "Flowers", "Flower_attack", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
			}
			else if (animationplayed == 2)
			{
				ApplyPlayerAnimation(playerid, "Flowers", "Flower_attack_M", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
			}
			else if (animationplayed == 3)
			{
				ApplyPlayerAnimation(playerid, "Flowers", "Flower_Hit", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
			}
			return 1;
		}
	}
	else if(strcmp(cmd, "/animghands", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animghands[1-20]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 20)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animghands[1-20]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "GHANDS", "gsign1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "GHANDS", "gsign1LH", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "GHANDS", "gsign2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "GHANDS", "gsign2LH", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "GHANDS", "gsign3", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "GHANDS", "gsign3LH", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "GHANDS", "gsign4", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "GHANDS", "gsign4LH", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "GHANDS", "gsign5", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "GHANDS", "gsign5LH", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "GHANDS", "LHGsign1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "GHANDS", "LHGsign2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "GHANDS", "LHGsign3", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "GHANDS", "LHGsign4", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "GHANDS", "LHGsign5", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "GHANDS", "RHGsign1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "GHANDS", "RHGsign2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 18)
		{
			ApplyPlayerAnimation(playerid, "GHANDS", "RHGsign3", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 19)
		{
			ApplyPlayerAnimation(playerid, "GHANDS", "RHGsign4", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 20)
		{
			ApplyPlayerAnimation(playerid, "GHANDS", "RHGsign5", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animfw", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animfw[1-9]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 9)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animfw[1-9]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "Freeweights", "gym_barbell", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "Freeweights", "gym_free_A", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "Freeweights", "gym_free_B", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "Freeweights", "gym_free_celebrate", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "Freeweights", "gym_free_down", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "Freeweights", "gym_free_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "Freeweights", "gym_free_pickup", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "Freeweights", "gym_free_putdown", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "Freeweights", "gym_free_up_smooth", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animghetto", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animghetto[1-7]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 7)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animghetto[1-7]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "GHETTO_DB", "GDB_Car2_PLY", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "GHETTO_DB", "GDB_Car2_SMO", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "GHETTO_DB", "GDB_Car2_SWE", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "GHETTO_DB", "GDB_Car_PLY", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "GHETTO_DB", "GDB_Car_RYD", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "GHETTO_DB", "GDB_Car_SMO", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "GHETTO_DB", "GDB_Car_SWE", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animgog", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animgog[1-1]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 1)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animgog[1-1]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "goggles", "goggles_put_on", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animgraffity", true) == 0)
	{
		if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
				SendClientMessage(playerid, 0xFF0000FF, ">Write /animgraffity[1-2]");
				return 1;
			}
			animationplayed = strval(tmp);
			if (animationplayed < 1 || animationplayed > 2)
			{
				SendClientMessage(playerid, 0xFF0000FF, ">Write /animgraffity[1-2]");
				return 1;
			}
			if (animationplayed == 1)
			{
				ApplyPlayerAnimation(playerid, "GRAFFITI", "graffiti_Chkout", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
			}
			else if (animationplayed == 2)
			{
				ApplyPlayerAnimation(playerid, "GRAFFITI", "spraycan_fire", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
			}
			return 1;
		}
	}
	else if(strcmp(cmd, "/animgreya", true) == 0)
	{
		if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
				SendClientMessage(playerid, 0xFF0000FF, ">Write /animgreya[1-3]");
				return 1;
			}
			animationplayed = strval(tmp);
			if (animationplayed < 1 || animationplayed > 3)
			{
				SendClientMessage(playerid, 0xFF0000FF, ">Write /animgreya[1-3]");
				return 1;
			}
			if (animationplayed == 1)
			{
				ApplyPlayerAnimation(playerid, "GRAVEYARD", "mrnF_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
			}
			else if (animationplayed == 2)
			{
				ApplyPlayerAnimation(playerid, "GRAVEYARD", "mrnM_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
			}
			else if (animationplayed == 3)
			{
				ApplyPlayerAnimation(playerid, "GRAVEYARD", "prst_loopa", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
			}
			return 1;
		}
	}
	else if(strcmp(cmd, "/animgren", true) == 0)
	{
		if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
				SendClientMessage(playerid, 0xFF0000FF, ">Write /animgren[1-3]");
				return 1;
			}
			animationplayed = strval(tmp);
			if (animationplayed < 1 || animationplayed > 3)
			{
				SendClientMessage(playerid, 0xFF0000FF, ">Write /animgren[1-3]");
				return 1;
			}
			if (animationplayed == 1)
			{
				ApplyPlayerAnimation(playerid, "GRENADE", "WEAPON_start_throw", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
			}
			else if (animationplayed == 2)
			{
				ApplyPlayerAnimation(playerid, "GRENADE", "WEAPON_throw", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
			}
			else if (animationplayed == 3)
			{
				ApplyPlayerAnimation(playerid, "GRENADE", "WEAPON_throwu", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
			}
			return 1;
		}
	}
	else if(strcmp(cmd, "/animhaircut", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animhaircut[1-13]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 13)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animhaircut[1-13]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "HAIRCUTS", "BRB_Beard_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "HAIRCUTS", "BRB_Buy", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "HAIRCUTS", "BRB_Cut", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "HAIRCUTS", "BRB_Cut_In", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "HAIRCUTS", "BRB_Cut_Out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "HAIRCUTS", "BRB_Hair_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "HAIRCUTS", "BRB_Hair_02", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "HAIRCUTS", "BRB_In", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "HAIRCUTS", "BRB_Out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "HAIRCUTS", "BRB_Loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "HAIRCUTS", "BRB_Sit_In", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "HAIRCUTS", "BRB_Sit_Loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "HAIRCUTS", "BRB_Sit_Out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animheist", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animheist[1-10]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 10)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animheist[1-10]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "HEIST9", "CAS_G2_GasKO", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "HEIST9", "swt_wllpk_L", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "HEIST9", "swt_wllpk_L_back", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "HEIST9", "swt_wllpk_R", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "HEIST9", "swt_wllpk_R_back", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "HEIST9", "swt_wllshoot_in_L", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "HEIST9", "swt_wllshoot_in_R", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "HEIST9", "swt_wllshoot_out_L", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "HEIST9", "swt_wllshoot_out_R", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "HEIST9", "Use_SwipeCard", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animinthouse", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animinthouse[1-10]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 10)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animinthouse[1-10]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "INT_HOUSE", "BED_In_L", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "INT_HOUSE", "BED_In_R", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "INT_HOUSE", "BED_Loop_L", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "INT_HOUSE", "BED_Loop_R", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "INT_HOUSE", "BED_Out_L", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "INT_HOUSE", "BED_Out_R", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "INT_HOUSE", "LOU_In", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "INT_HOUSE", "LOU_Loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "INT_HOUSE", "LOU_Out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "INT_HOUSE", "wash_up", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animintoffice", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animintoffice[1-10]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 10)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animintoffice[1-10]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "INT_OFFICE", "FF_Dam_Fwd", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "INT_OFFICE", "OFF_Sit_2Idle_180", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "INT_OFFICE", "OFF_Sit_Bored_Loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "INT_OFFICE", "OFF_Sit_Crash", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "INT_OFFICE", "OFF_Sit_Drink", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "INT_OFFICE", "OFF_Sit_Idle_Loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "INT_OFFICE", "OFF_Sit_In", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "INT_OFFICE", "OFF_Sit_Read", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "INT_OFFICE", "OFF_Sit_Type_Loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "INT_OFFICE", "OFF_Sit_Watch", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animplayerdbf", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animplayerdbf[1-4]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 4)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animplayerdbf[1-4]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "PLAYER_DVBYS", "Plyr_DrivebyBwd", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "PLAYER_DVBYS", "Plyr_DrivebyFwd", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "PLAYER_DVBYS", "Plyr_DrivebyLHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "PLAYER_DVBYS", "Plyr_DrivebyRHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animplayidles", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animplayidles[1-5]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 5)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animplayidles[1-5]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "PLAYIDLES", "shift", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "PLAYIDLES", "shldr", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "PLAYIDLES", "stretch", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "PLAYIDLES", "strleg", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "PLAYIDLES", "time", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animpolice", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animpolice[1-10]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 10)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animpolice[1-10]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "POLICE", "CopTraf_Away", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "POLICE", "CopTraf_Come", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "POLICE", "CopTraf_Left", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "POLICE", "CopTraf_Stop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "POLICE", "COP_getoutcar_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "POLICE", "Cop_move_FWD", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "POLICE", "crm_drgbst_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "POLICE", "Door_Kick", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "POLICE", "plc_drgbst_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "POLICE", "plc_drgbst_02", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animpool", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animpool[1-21]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 21)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animpool[1-21]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "POOL", "POOL_ChalkCue", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "POOL", "POOL_Idle_Stance", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "POOL", "POOL_Long_Shot", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "POOL", "POOL_Long_Shot_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "POOL", "POOL_Long_Start", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "POOL", "POOL_Long_Start_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "POOL", "POOL_Med_Shot", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "POOL", "POOL_Med_Shot_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "POOL", "POOL_Med_Start", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "POOL", "POOL_Med_Start_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "POOL", "POOL_Place_White", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "POOL", "POOL_Short_Shot", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "POOL", "POOL_Short_Shot_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "POOL", "POOL_Short_Start", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "POOL", "POOL_Short_Start_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "POOL", "POOL_Walk", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "POOL", "POOL_Walk_Start", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 18)
		{
			ApplyPlayerAnimation(playerid, "POOL", "POOL_XLong_Shot", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 19)
		{
			ApplyPlayerAnimation(playerid, "POOL", "POOL_XLong_Shot_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 20)
		{
			ApplyPlayerAnimation(playerid, "POOL", "POOL_XLong_Start", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 21)
		{
			ApplyPlayerAnimation(playerid, "POOL", "POOL_XLong_Start_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animpoor", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animpoor[1-2]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 2)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animpoor[1-2]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "POOR", "WINWASH_Start", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "POOR", "WINWASH_Wash2Beg", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animpython", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animpython[1-5]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 5)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animpython[1-5]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "PYTHON", "python_crouchfire", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "PYTHON", "python_crouchreload", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "PYTHON", "python_fire", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "PYTHON", "python_fire_poor", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "PYTHON", "python_reload", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animquad", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animquad[1-17]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 17)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animquad[1-17]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "QUAD", "QUAD_back", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "QUAD", "QUAD_driveby_FT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "QUAD", "QUAD_driveby_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "QUAD", "QUAD_driveby_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "QUAD", "QUAD_FWD", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "QUAD", "QUAD_getoff_B", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "QUAD", "QUAD_getoff_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "QUAD", "QUAD_getoff_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "QUAD", "QUAD_geton_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "QUAD", "QUAD_geton_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "QUAD", "QUAD_hit", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "QUAD", "QUAD_kick", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "QUAD", "QUAD_Left", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "QUAD", "QUAD_passenger", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "QUAD", "QUAD_reverse", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "QUAD", "QUAD_ride", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "QUAD", "QUAD_Right", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animquadbz", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animquadbz[1-4]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 4)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animquadbz[1-4]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "QUAD_DBZ", "Pass_Driveby_BWD", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "QUAD_DBZ", "Pass_Driveby_FWD", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "QUAD_DBZ", "Pass_Driveby_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "QUAD_DBZ", "Pass_Driveby_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animrapping", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animrapping[1-8]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 8)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animrapping[1-8]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "RAPPING", "Laugh_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "RAPPING", "RAP_A_IN", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "RAPPING", "RAP_A_Loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "RAPPING", "RAP_A_OUT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "RAPPING", "RAP_B_IN", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "RAPPING", "RAP_B_Loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "RAPPING", "RAP_B_OUT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "RAPPING", "RAP_C_Loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animrifle", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animrifle[1-5]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 5)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animrifle[1-5]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "RIFLE", "RIFLE_crouchfire", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "RIFLE", "RIFLE_crouchload", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "RIFLE", "RIFLE_fire", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "RIFLE", "RIFLE_fire_poor", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "RIFLE", "RIFLE_load", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animriot", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animriot[1-7]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 7)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animriot[1-7]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "RIOT", "RIOT_ANGRY", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "RIOT", "RIOT_ANGRY_B", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "RIOT", "RIOT_challenge", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "RIOT", "RIOT_CHANT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "RIOT", "RIOT_FUKU", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "RIOT", "RIOT_PUNCHES", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "RIOT", "RIOT_shout", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animrobbank", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animrobbank[1-5]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 5)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animrobbank[1-5]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "ROB_BANK", "CAT_Safe_End", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "ROB_BANK", "CAT_Safe_Open", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "ROB_BANK", "CAT_Safe_Open_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "ROB_BANK", "CAT_Safe_Rob", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "ROB_BANK", "SHP_HandsUp_Scr", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animrocket", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animrocket[1-5]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 5)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animrocket[1-5]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "ROCKET", "idle_rocket", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "ROCKET", "RocketFire", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "ROCKET", "run_rocket", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "ROCKET", "walk_rocket", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "ROCKET", "WALK_start_rocket", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animrustler", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animrustler[1-5]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 5)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animrustler[1-5]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "RUSTLER", "Plane_align_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "RUSTLER", "Plane_close", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "RUSTLER", "Plane_getin", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "RUSTLER", "Plane_getout", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "RUSTLER", "Plane_open", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animbiked", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbiked[1-18]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 18)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbiked[1-18]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_Back", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_drivebyFT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_drivebyLHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_drivebyRHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_Fwd", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_getoffBACK", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_getoffLHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_getoffRHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_hit", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_jumponL", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_jumponR", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_kick", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_Left", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_passenger", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_pushes", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_Ride", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_Right", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_shuffle", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 18)
		{
			ApplyPlayerAnimation(playerid, "BIKED", "BIKEd_Still", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animryder", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animryder[1-14]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 14)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animryder[1-14]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "RYDER", "RYD_Beckon_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "RYDER", "RYD_Beckon_02", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "RYDER", "RYD_Beckon_03", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "RYDER", "RYD_Die_PT1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "RYDER", "RYD_Die_PT2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "RYDER", "Van_Crate_L", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "RYDER", "Van_Crate_R", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "RYDER", "Van_Fall_L", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "RYDER", "Van_Fall_R", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "RYDER", "Van_Lean_L", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "RYDER", "Van_Lean_R", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "RYDER", "VAN_PickUp_S", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "RYDER", "Van_Stand", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "RYDER", "Van_Stand_Crate", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "RYDER", "Van_Throw", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animscrat", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animscrat[1-12]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 12)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animscrat[1-12]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "SCRATCHING", "scdldlp", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "SCRATCHING", "scdlulp", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "SCRATCHING", "scdrdlp", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "SCRATCHING", "scdrulp", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "SCRATCHING", "sclng_l", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "SCRATCHING", "sclng_r", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "SCRATCHING", "scmid_l", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "SCRATCHING", "scmid_r", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "SCRATCHING", "scshrtl", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "SCRATCHING", "scshrtr", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "SCRATCHING", "sc_ltor", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "SCRATCHING", "sc_rtol", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animshamal", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animshamal[1-4]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 4)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animshamal[1-4]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "SHAMAL", "SHAMAL_align", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "SHAMAL", "SHAMAL_getin_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "SHAMAL", "SHAMAL_getout_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "SHAMAL", "SHAMAL_open", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animshop", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animshop[1-24]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 24)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animshop[1-24]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "SHOP", "ROB_2Idle", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "SHOP", "ROB_Loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "SHOP", "donutdrop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "SHOP", "ROB_Loop_Threat", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "SHOP", "ROB_Shifty", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "SHOP", "ROB_StickUp_In", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "SHOP", "SHP_Duck_Fire", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "SHOP", "SHP_Gun_Aim", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "SHOP", "SHP_Gun_Duck", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "SHOP", "SHP_Gun_Fire", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "SHOP", "SHP_Gun_Grab", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "SHOP", "SHP_Gun_Threat", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "SHOP", "SHP_HandsUp_Scr", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "SHOP", "SHP_Jump_Glide", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "SHOP", "SHP_Jump_Land", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "SHOP", "SHP_Jump_Launch", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "SHOP", "SHP_Rob_GiveCash", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 18)
		{
			ApplyPlayerAnimation(playerid, "SHOP", "SHP_Rob_HandsUp", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 19)
		{
			ApplyPlayerAnimation(playerid, "SHOP", "SHP_Rob_React", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 20)
		{
			ApplyPlayerAnimation(playerid, "SHOP", "SHP_Serve_End", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 21)
		{
			ApplyPlayerAnimation(playerid, "SHOP", "SHP_Serve_Idle", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 22)
		{
			ApplyPlayerAnimation(playerid, "SHOP", "SHP_Serve_Loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 23)
		{
			ApplyPlayerAnimation(playerid, "SHOP", "SHP_Serve_Start", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 24)
		{
			ApplyPlayerAnimation(playerid, "SHOP", "Smoke_RYD", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animshotgun", true) == 0)
	{
		if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
				SendClientMessage(playerid, 0xFF0000FF, ">Write /animshotgun[1-3]");
				return 1;
			}
			animationplayed = strval(tmp);
			if (animationplayed < 1 || animationplayed > 3)
			{
				SendClientMessage(playerid, 0xFF0000FF, ">Write /animshotgun[1-3]");
				return 1;
			}
			if (animationplayed == 1)
			{
				ApplyPlayerAnimation(playerid, "SHOTGUN", "shotgun_crouchfire", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
			}
			else if (animationplayed == 2)
			{
				ApplyPlayerAnimation(playerid, "SHOTGUN", "shotgun_fire", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
			}
			else if (animationplayed == 3)
			{
				ApplyPlayerAnimation(playerid, "SHOTGUN", "shotgun_fire_poor", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
			}
			return 1;
		}
	}
	else if(strcmp(cmd, "/animskate", true) == 0)
	{
		if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
				SendClientMessage(playerid, 0xFF0000FF, ">Write /animskate[1-3]");
				return 1;
			}
			animationplayed = strval(tmp);
			if (animationplayed < 1 || animationplayed > 3)
			{
				SendClientMessage(playerid, 0xFF0000FF, ">Write /animskate[1-3]");
				return 1;
			}
			if (animationplayed == 1)
			{
				ApplyPlayerAnimation(playerid, "SKATE", "skate_idle", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
			}
			else if (animationplayed == 2)
			{
				ApplyPlayerAnimation(playerid, "SKATE", "skate_run", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
			}
			else if (animationplayed == 3)
			{
				ApplyPlayerAnimation(playerid, "SKATE", "skate_sprint", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
			}
			return 1;
		}
	}
	else if(strcmp(cmd, "/animvortex", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animvortex[1-4]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 4)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animvortex[1-4]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "VORTEX", "CAR_jumpin_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "VORTEX", "CAR_jumpin_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "VORTEX", "vortex_getout_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "VORTEX", "vortex_getout_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animtec", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animtec[1-4]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 4)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animtec[1-4]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "TEC", "TEC_crouchfire", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "TEC", "TEC_crouchreload", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "TEC", "TEC_fire", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "TEC", "TEC_reload", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animtrain", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animtrain[1-4]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 4)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animtrain[1-4]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "TRAIN", "tran_gtup", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "TRAIN", "tran_hng", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "TRAIN", "tran_ouch", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "TRAIN", "tran_stmb", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animsil", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animsil[1-4]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 4)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animsil[1-4]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "SILENCED", "CrouchReload", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "SILENCED", "SilenceCrouchfire", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "SILENCED", "Silence_fire", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "SILENCED", "Silence_reload", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animtattoo", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animtattoo[1-56]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 56)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animtattoo[1-56]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_ArmL_In_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_ArmL_In_P", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_ArmL_In_T", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_ArmL_Out_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TA_ArmL_Out_P", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_ArmL_Out_T", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_ArmL_Pose_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_ArmL_Pose_P", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_ArmL_Pose_T", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_ArmR_In_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_ArmR_In_P", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_ArmR_In_T", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_ArmR_Out_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_ArmR_Out_P", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_ArmR_Out_T", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_ArmR_Pose_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_ArmR_Pose_P", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 18)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_ArmR_Pose_T", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 19)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Back_In_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 20)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Back_In_P", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 21)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Back_In_T", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 22)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Back_Out_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 23)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Back_Out_P", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 24)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Back_Out_T", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 25)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Back_Pose_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 26)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Back_Pose_P", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 27)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Back_Pose_T", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 28)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Back_Sit_In_P", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 29)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Back_Sit_Loop_P", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 30)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Back_Sit_Out_P", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 31)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Bel_In_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 32)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Bel_In_T", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 33)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Bel_Out_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 34)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Bel_Out_T", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 35)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Bel_Pose_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 36)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Bel_Pose_T", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 37)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Che_In_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 38)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "Sit_relaxed", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 39)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Che_In_P", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 40)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Che_In_T", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 41)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Che_Out_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 41)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Che_Out_P", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 42)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Che_Out_T", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 43)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Che_Pose_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 44)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Che_Pose_P", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 45)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Che_Pose_T", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 46)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Idle_Loop_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 47)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Idle_Loop_T", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 48)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Sit_In_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 49)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Sit_In_P", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 50)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Sit_In_T", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 51)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Sit_Loop_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 52)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Sit_Loop_P", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 53)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Sit_Loop_T", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 54)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Sit_Out_O", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 55)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Sit_Out_P", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 56)
		{
			ApplyPlayerAnimation(playerid, "TATTOOS", "TAT_Sit_Out_T", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animsmoking", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animsmoking[1-8]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 8)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animsmoking[1-8]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "SMOKING", "F_smklean_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "SMOKING", "M_smklean_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "SMOKING", "M_smkstnd_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "SMOKING", "M_smk_drag", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "SMOKING", "M_smk_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "SMOKING", "M_smk_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "SMOKING", "M_smk_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "SMOKING", "M_smk_tap", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animsniper", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animsniper[1-1]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 1)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animsniper[1-1]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "SNIPER", "WEAPON_sniper", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animspray", true) == 0)
	{
		if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
				SendClientMessage(playerid, 0xFF0000FF, ">Write /animspray[1-2]");
				return 1;
			}
			animationplayed = strval(tmp);
			if (animationplayed < 1 || animationplayed > 2)
			{
				SendClientMessage(playerid, 0xFF0000FF, ">Write /animspray[1-2]");
				return 1;
			}
			if (animationplayed == 1)
			{
				ApplyPlayerAnimation(playerid, "SPRAYCAN", "spraycan_fire", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
			}
			else if (animationplayed == 2)
			{
				ApplyPlayerAnimation(playerid, "SPRAYCAN", "spraycan_full", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
			}
			return 1;
		}
	}
	else if(strcmp(cmd, "/animstrip", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animstrip[1-20]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 20)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animstrip[1-20]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "STRIP", "PLY_CASH", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "STRIP", "PUN_CASH", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "STRIP", "PUN_HOLLER", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "STRIP", "PUN_LOOP", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "STRIP", "strip_A", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "STRIP", "strip_B", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "STRIP", "strip_C", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "STRIP", "strip_D", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "STRIP", "strip_E", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "STRIP", "strip_F", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "STRIP", "strip_G", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "STRIP", "STR_A2B", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "STRIP", "STR_B2A", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "STRIP", "STR_B2C", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "STRIP", "STR_C1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "STRIP", "STR_C2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "STRIP", "STR_C2B", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 18)
		{
			ApplyPlayerAnimation(playerid, "STRIP", "STR_Loop_A", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 19)
		{
			ApplyPlayerAnimation(playerid, "STRIP", "STR_Loop_B", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 20)
		{
			ApplyPlayerAnimation(playerid, "STRIP", "STR_Loop_C", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animbath", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbath[1-17]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 18)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animbath[1-17]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "SUNBATHE", "batherdown", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "SUNBATHE", "batherup", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "SUNBATHE", "Lay_Bac_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "SUNBATHE", "Lay_Bac_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "SUNBATHE", "ParkSit_M_IdleA", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "SUNBATHE", "ParkSit_M_IdleB", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "SUNBATHE", "ParkSit_M_IdleC", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "SUNBATHE", "ParkSit_M_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "SUNBATHE", "ParkSit_M_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "SUNBATHE", "ParkSit_W_idleA", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "SUNBATHE", "ParkSit_W_idleB", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "SUNBATHE", "ParkSit_W_idleC", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "SUNBATHE", "ParkSit_W_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "SUNBATHE", "ParkSit_W_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "SUNBATHE", "SBATHE_F_LieB2Sit", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "SUNBATHE", "SBATHE_F_Out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "SUNBATHE", "SitnWait_in_W", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "SUNBATHE", "SitnWait_out_W", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	/*
	if(strcmp(cmd, "/animswat", true) == 0) {
	tmp = strtok(cmdtext, idx);
	if(!strlen(tmp)) {
	SendClientMessage(playerid,0xFF0000FF,">Write /animswat[1-24]");
	return 1;
	}*/
	else if(strcmp(cmd, "/animswat", true) == 0)
	{
		SendClientMessage(playerid, 0xFF0000FF, "Te animacje zostaly zablokowane!");
		return 1;
	}
	/*
	animationplayed = strval(tmp);
	if(animationplayed < 1 || animationplayed > 24) {
	SendClientMessage(playerid,0xFF0000FF,">Write /animswat[1-24]");
	return 1;
	}
	if(animationplayed == 1) {
	ApplyPlayerAnimation(playerid,"SWAT","gnstwall_injurd",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 2) {
	ApplyPlayerAnimation(playerid,"SWAT","JMP_Wall1m_180",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 3) {
	ApplyPlayerAnimation(playerid,"SWAT","Rail_fall",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 4) {
	ApplyPlayerAnimation(playerid,"SWAT","Rail_fall_crawl",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 5) {
	ApplyPlayerAnimation(playerid,"SWAT","swt_breach_01",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 6) {
	ApplyPlayerAnimation(playerid,"SWAT","cards_pick_02",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 7) {
	ApplyPlayerAnimation(playerid,"SWAT","swt_breach_02",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 8) {
	ApplyPlayerAnimation(playerid,"SWAT","swt_breach_03",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 9) {
	ApplyPlayerAnimation(playerid,"SWAT","swt_go",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 10) {
	ApplyPlayerAnimation(playerid,"SWAT","swt_lkt",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 11) {
	ApplyPlayerAnimation(playerid,"SWAT","swt_sty",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 12) {
	ApplyPlayerAnimation(playerid,"SWAT","swt_vent_01",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 13) {
	ApplyPlayerAnimation(playerid,"SWAT","swt_vent_02",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 14) {
	ApplyPlayerAnimation(playerid,"SWAT","swt_vnt_sht_die",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 15) {
	ApplyPlayerAnimation(playerid,"SWAT","swt_vnt_sht_in",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 16) {
	ApplyPlayerAnimation(playerid,"SWAT","swt_vnt_sht_loop",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 17) {
	ApplyPlayerAnimation(playerid,"SWAT","swt_wllpk_L",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 18) {
	ApplyPlayerAnimation(playerid,"SWAT","swt_wllpk_L_back",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 19) {
	ApplyPlayerAnimation(playerid,"SWAT","swt_wllpk_R",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 20) {
	ApplyPlayerAnimation(playerid,"SWAT","swt_wllpk_R_back",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 21) {
	ApplyPlayerAnimation(playerid,"SWAT","swt_wllshoot_in_L",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 22) {
	ApplyPlayerAnimation(playerid,"SWAT","swt_wllshoot_in_R",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 23) {
	ApplyPlayerAnimation(playerid,"SWAT","swt_wllshoot_out_L",4.1,0,1,1,1,1,1);	//edited by erik019
	}else if(animationplayed == 24) {
	ApplyPlayerAnimation(playerid,"SWAT","swt_wllshoot_out_R",4.1,0,1,1,1,1,1);	//edited by erik019
	}
	return 1;
	}*/
	else if(strcmp(cmd, "/animsweet", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animsweet[1-7]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 7)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animsweet[1-7]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "SWEET", "ho_ass_slapped", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "SWEET", "LaFin_Player", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "SWEET", "LaFin_Sweet", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "SWEET", "plyr_hndshldr_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "SWEET", "sweet_ass_slap", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "SWEET", "sweet_hndshldr_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "SWEET", "Sweet_injuredloop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animswim", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animswim[1-7]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 7)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animswim[1-7]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "SWIM", "Swim_Breast", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "SWIM", "SWIM_crawl", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "SWIM", "Swim_Dive_Under", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "SWIM", "Swim_Glide", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "SWIM", "Swim_jumpout", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "SWIM", "Swim_Tread", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "SWIM", "Swim_Under", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animsword", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animsword[1-10]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 10)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animsword[1-10]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "SWORD", "sword_1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "SWORD", "sword_2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "SWORD", "sword_3", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "SWORD", "sword_4", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "SWORD", "sword_block", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "SWORD", "Sword_Hit_1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "SWORD", "Sword_Hit_2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "SWORD", "Sword_Hit_3", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "SWORD", "sword_IDLE", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "SWORD", "sword_part", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animtank", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animtank[1-6]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 6)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animtank[1-6]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "TANK", "TANK_align_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "TANK", "TANK_close_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "TANK", "TANK_doorlocked", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "TANK", "TANK_getin_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "TANK", "TANK_getout_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "TANK", "TANK_open_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animtruck", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animtruck[1-17]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 17)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animtruck[1-17]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "TRUCK", "TRUCK_ALIGN_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "TRUCK", "TRUCK_ALIGN_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "TRUCK", "TRUCK_closedoor_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "TRUCK", "TRUCK_closedoor_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "TRUCK", "TRUCK_close_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "TRUCK", "TRUCK_close_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "TRUCK", "TRUCK_getin_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "TRUCK", "TRUCK_getin_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "TRUCK", "TRUCK_getout_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "TRUCK", "TRUCK_getout_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "TRUCK", "TRUCK_jackedLHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "TRUCK", "TRUCK_jackedRHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "TRUCK", "TRUCK_open_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "TRUCK", "TRUCK_open_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "TRUCK", "TRUCK_pullout_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "TRUCK", "TRUCK_pullout_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "TRUCK", "TRUCK_Shuffle", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animuzi", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animuzi[1-5]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 5)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animuzi[1-5]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "UZI", "UZI_crouchfire", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "UZI", "UZI_crouchreload", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "UZI", "UZI_fire", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "UZI", "UZI_fire_poor", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "UZI", "UZI_reload", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animvan", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animvan[1-8]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 8)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animvan[1-8]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "VAN", "VAN_close_back_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "VAN", "VAN_close_back_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "VAN", "VAN_getin_Back_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "VAN", "VAN_getin_Back_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "VAN", "VAN_getout_back_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "VAN", "VAN_getout_back_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "VAN", "VAN_open_back_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "VAN", "VAN_open_back_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animvending", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animvending[1-6]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 6)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animvending[1-6]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "VENDING", "VEND_Drink2_P", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "VENDING", "VEND_Drink_P", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "VENDING", "vend_eat1_P", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "VENDING", "VEND_Eat_P", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "VENDING", "VEND_Use", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "VENDING", "VEND_Use_pt2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animway", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animway[1-17]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 17)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animway[1-17]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "WAYFARER", "WF_Back", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "WAYFARER", "WF_drivebyFT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "WAYFARER", "WF_drivebyLHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "WAYFARER", "WF_drivebyRHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "WAYFARER", "WF_Fwd", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "WAYFARER", "WF_getoffBACK", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "WAYFARER", "WF_getoffLHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "WAYFARER", "WF_getoffRHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "WAYFARER", "WF_hit", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "WAYFARER", "WF_jumponL", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "WAYFARER", "WF_jumponR", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "WAYFARER", "WF_kick", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "WAYFARER", "WF_Left", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "WAYFARER", "WF_passenger", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "WAYFARER", "WF_pushes", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "WAYFARER", "WF_Ride", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "WAYFARER", "WF_Right", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "WAYFARER", "WF_Still", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animweap", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animweap[1-17]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 17)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animweap[1-17]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "WEAPONS", "SHP_1H_Lift", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "WEAPONS", "SHP_1H_Lift_End", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "WEAPONS", "SHP_1H_Ret", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "WEAPONS", "SHP_1H_Ret_S", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "WEAPONS", "SHP_2H_Lift", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "WEAPONS", "SHP_2H_Lift_End", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "WEAPONS", "SHP_2H_Ret", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "WEAPONS", "SHP_2H_Ret_S", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "WEAPONS", "SHP_Ar_Lift", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "WEAPONS", "SHP_Ar_Lift_End", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "WEAPONS", "SHP_Ar_Ret", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "WEAPONS", "SHP_Ar_Ret_S", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "WEAPONS", "SHP_G_Lift_In", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "WEAPONS", "SHP_G_Lift_Out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "WEAPONS", "SHP_Tray_In", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "WEAPONS", "SHP_Tray_Out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "WEAPONS", "SHP_Tray_Pose", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animwuzi", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animwuzi[1-12]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 12)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animwuzi[1-12]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "WUZI", "CS_Plyr_pt1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "WUZI", "CS_Plyr_pt2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "WUZI", "CS_Wuzi_pt1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "WUZI", "CS_Wuzi_pt2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "WUZI", "Walkstart_Idle_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "WUZI", "Wuzi_follow", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "WUZI", "Wuzi_Greet_Plyr", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "WUZI", "Wuzi_Greet_Wuzi", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "WUZI", "Wuzi_grnd_chk", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "WUZI", "Wuzi_stand_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "WUZI", "Wuzi_Walk", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}
	else if(strcmp(cmd, "/animat", true) == 0)
	{
		if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
				SendClientMessage(playerid, 0xFF0000FF, ">Write /animat[1-3]");
				return 1;
			}
			animationplayed = strval(tmp);
			if (animationplayed < 1 || animationplayed > 3)
			{
				SendClientMessage(playerid, 0xFF0000FF, ">Write /animat[1-3]");
				return 1;
			}
			if (animationplayed == 1)
			{
				ApplyPlayerAnimation(playerid, "Attractors", "Stepsit_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
			}
			else if (animationplayed == 2)
			{
				ApplyPlayerAnimation(playerid, "Attractors", "Stepsit_loop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
			}
			else if (animationplayed == 3)
			{
				ApplyPlayerAnimation(playerid, "Attractors", "Stepsit_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
			}
			return 1;
		}
	}
	else if(strcmp(cmd, "/animairport", true) == 0)
	{
		if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
				SendClientMessage(playerid, 0xFF0000FF, ">Write /animairport[1]");
				return 1;
			}
			animationplayed = strval(tmp);
			if (animationplayed < 1 || animationplayed > 1)
			{
				SendClientMessage(playerid, 0xFF0000FF, ">Write /animairport[1]");
				return 1;
			}
			if (animationplayed == 1)
			{
				ApplyPlayerAnimation(playerid, "AIRPORT", "thrw_barl_thrw", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
			}
			return 1;
		}
	}
	else if(strcmp(cmd, "/animped", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp))
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animped[1-295]");
			return 1;
		}
		animationplayed = strval(tmp);
		if (animationplayed < 1 || animationplayed > 295)
		{
			SendClientMessage(playerid, 0xFF0000FF, ">Write /animped[1-295]");
			return 1;
		}
		if (animationplayed == 1)
		{
			ApplyPlayerAnimation(playerid, "PED", "IDLE_CHAT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 2)
		{
			ApplyPlayerAnimation(playerid, "PED", "WALK_DRUNK", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 3)
		{
			ApplyPlayerAnimation(playerid, "PED", "abseil", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 4)
		{
			ApplyPlayerAnimation(playerid, "PED", "ARRESTgun", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 5)
		{
			ApplyPlayerAnimation(playerid, "PED", "ATM", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 6)
		{
			ApplyPlayerAnimation(playerid, "PED", "BIKE_elbowL", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 7)
		{
			ApplyPlayerAnimation(playerid, "PED", "BIKE_fallR", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 8)
		{
			ApplyPlayerAnimation(playerid, "PED", "BIKE_fall_off", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 9)
		{
			ApplyPlayerAnimation(playerid, "PED", "BIKE_pickupL", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 10)
		{
			ApplyPlayerAnimation(playerid, "PED", "BIKE_pickupR", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 11)
		{
			ApplyPlayerAnimation(playerid, "PED", "BIKE_pullupL", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 12)
		{
			ApplyPlayerAnimation(playerid, "PED", "BIKE_pullupR", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 13)
		{
			ApplyPlayerAnimation(playerid, "PED", "bomber", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 14)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_alignHI_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 15)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_alignHI_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 16)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_align_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 17)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_align_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 18)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_closedoorL_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 19)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_closedoorL_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 20)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_closedoor_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 21)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_closedoor_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 22)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_close_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 23)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_crawloutRHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 24)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_dead_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 25)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_dead_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 26)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_doorlocked_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 27)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_fallout_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 28)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_fallout_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 29)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_getinL_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 30)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_getinL_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 31)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_getin_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 32)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_getin_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 33)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_getoutL_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 34)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_getout_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 35)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_getout_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 36)
		{
			ApplyPlayerAnimation(playerid, "PED", "car_hookertalk", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 37)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_jackedLHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 38)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_jackedRHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 39)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_jumpin_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 40)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_LB", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 41)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_LB_pro", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 42)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_LB_weak", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 43)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_LjackedLHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 44)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_Lshuffle_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 45)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_Lsit", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 46)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_open_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 47)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_open_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 49)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_pulloutL_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 50)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_pulloutL_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 51)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_pullout_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 52)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_pullout_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 53)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_Qjacked", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 54)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_rolldoor", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 55)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_rolldoorLO", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 56)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_rollout_LHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 57)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_rollout_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 58)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_shuffle_RHS", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 59)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_sit", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 60)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_sitp", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 61)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_sitpLO", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 62)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_sit_pro", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 63)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_sit_weak", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 64)
		{
			ApplyPlayerAnimation(playerid, "PED", "CAR_tune_radio", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 65)
		{
			ApplyPlayerAnimation(playerid, "PED", "CLIMB_idle", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 66)
		{
			ApplyPlayerAnimation(playerid, "PED", "CLIMB_jump", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 67)
		{
			ApplyPlayerAnimation(playerid, "PED", "CLIMB_jump2fall", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 68)
		{
			ApplyPlayerAnimation(playerid, "PED", "CLIMB_jump_B", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 69)
		{
			ApplyPlayerAnimation(playerid, "PED", "CLIMB_Pull", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 70)
		{
			ApplyPlayerAnimation(playerid, "PED", "CLIMB_Stand", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 71)
		{
			ApplyPlayerAnimation(playerid, "PED", "CLIMB_Stand_finish", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 72)
		{
			ApplyPlayerAnimation(playerid, "PED", "cower", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 73)
		{
			ApplyPlayerAnimation(playerid, "PED", "Crouch_Roll_L", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 74)
		{
			ApplyPlayerAnimation(playerid, "PED", "Crouch_Roll_R", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 75)
		{
			ApplyPlayerAnimation(playerid, "PED", "DAM_armL_frmBK", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 76)
		{
			ApplyPlayerAnimation(playerid, "PED", "DAM_armL_frmFT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 77)
		{
			ApplyPlayerAnimation(playerid, "PED", "DAM_armL_frmLT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 78)
		{
			ApplyPlayerAnimation(playerid, "PED", "DAM_armR_frmBK", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 79)
		{
			ApplyPlayerAnimation(playerid, "PED", "DAM_armR_frmFT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 80)
		{
			ApplyPlayerAnimation(playerid, "PED", "DAM_armR_frmRT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 81)
		{
			ApplyPlayerAnimation(playerid, "PED", "DAM_LegL_frmBK", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 82)
		{
			ApplyPlayerAnimation(playerid, "PED", "DAM_LegL_frmFT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 83)
		{
			ApplyPlayerAnimation(playerid, "PED", "DAM_LegL_frmLT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 84)
		{
			ApplyPlayerAnimation(playerid, "PED", "DAM_LegR_frmBK", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 85)
		{
			ApplyPlayerAnimation(playerid, "PED", "DAM_LegR_frmFT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 86)
		{
			ApplyPlayerAnimation(playerid, "PED", "DAM_LegR_frmRT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 87)
		{
			ApplyPlayerAnimation(playerid, "PED", "DAM_stomach_frmBK", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 88)
		{
			ApplyPlayerAnimation(playerid, "PED", "DAM_stomach_frmFT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 89)
		{
			ApplyPlayerAnimation(playerid, "PED", "DAM_stomach_frmLT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 90)
		{
			ApplyPlayerAnimation(playerid, "PED", "DAM_stomach_frmRT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 91)
		{
			//ApplyPlayerAnimation(playerid,"PED","DOOR_LHinge_O",4.1,0,1,1,1,1,1); 
			SendClientMessage(playerid, -1, "Ta animacja jest zablokowana!");
		}
		else if (animationplayed == 92)
		{
			//ApplyPlayerAnimation(playerid,"PED","DOOR_RHinge_O",4.1,0,1,1,1,1,1);
			SendClientMessage(playerid, -1, "Ta animacja jest zablokowana!");
		}
		else if (animationplayed == 93)
		{
			ApplyPlayerAnimation(playerid, "PED", "DrivebyL_L", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 94)
		{
			ApplyPlayerAnimation(playerid, "PED", "DrivebyL_R", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 95)
		{
			ApplyPlayerAnimation(playerid, "PED", "Driveby_L", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 96)
		{
			ApplyPlayerAnimation(playerid, "PED", "Driveby_R", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 97)
		{
			ApplyPlayerAnimation(playerid, "PED", "DRIVE_BOAT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 98)
		{
			ApplyPlayerAnimation(playerid, "PED", "DRIVE_BOAT_back", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 99)
		{
			ApplyPlayerAnimation(playerid, "PED", "DRIVE_BOAT_L", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 100)
		{
			ApplyPlayerAnimation(playerid, "PED", "DRIVE_BOAT_R", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 101)
		{
			ApplyPlayerAnimation(playerid, "PED", "Drive_L", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 102)
		{
			ApplyPlayerAnimation(playerid, "PED", "Drive_LO_l", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 103)
		{
			ApplyPlayerAnimation(playerid, "PED", "Drive_LO_R", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 104)
		{
			ApplyPlayerAnimation(playerid, "PED", "Drive_L_pro", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 105)
		{
			ApplyPlayerAnimation(playerid, "PED", "Drive_L_pro_slow", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 106)
		{
			ApplyPlayerAnimation(playerid, "PED", "Drive_L_slow", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 107)
		{
			ApplyPlayerAnimation(playerid, "PED", "Drive_L_weak", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 108)
		{
			ApplyPlayerAnimation(playerid, "PED", "Drive_L_weak_slow", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 109)
		{
			ApplyPlayerAnimation(playerid, "PED", "Drive_R", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 110)
		{
			ApplyPlayerAnimation(playerid, "PED", "Drive_R_pro", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 111)
		{
			ApplyPlayerAnimation(playerid, "PED", "Drive_R_pro_slow", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 112)
		{
			ApplyPlayerAnimation(playerid, "PED", "Drive_R_slow", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 113)
		{
			ApplyPlayerAnimation(playerid, "PED", "Drive_R_weak", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 114)
		{
			ApplyPlayerAnimation(playerid, "PED", "Drive_R_weak_slow", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 115)
		{
			ApplyPlayerAnimation(playerid, "PED", "Drive_truck", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 116)
		{
			ApplyPlayerAnimation(playerid, "PED", "DRIVE_truck_back", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 117)
		{
			ApplyPlayerAnimation(playerid, "PED", "DRIVE_truck_L", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 118)
		{
			ApplyPlayerAnimation(playerid, "PED", "DRIVE_truck_R", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 119)
		{
			ApplyPlayerAnimation(playerid, "PED", "Drown", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 120)
		{
			ApplyPlayerAnimation(playerid, "PED", "DUCK_cower", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 121)
		{
			ApplyPlayerAnimation(playerid, "PED", "endchat_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 122)
		{
			ApplyPlayerAnimation(playerid, "PED", "endchat_02", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 123)
		{
			ApplyPlayerAnimation(playerid, "PED", "endchat_03", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 124)
		{
			ApplyPlayerAnimation(playerid, "PED", "DRIVE_truck_back", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 125)
		{
			ApplyPlayerAnimation(playerid, "PED", "DRIVE_truck_back", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 126)
		{
			ApplyPlayerAnimation(playerid, "PED", "EV_dive", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 127)
		{
			ApplyPlayerAnimation(playerid, "PED", "EV_step", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 128)
		{
			ApplyPlayerAnimation(playerid, "PED", "facanger", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 129)
		{
			ApplyPlayerAnimation(playerid, "PED", "facanger", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 130)
		{
			ApplyPlayerAnimation(playerid, "PED", "facgum", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 131)
		{
			ApplyPlayerAnimation(playerid, "PED", "facsurp", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 132)
		{
			ApplyPlayerAnimation(playerid, "PED", "facsurpm", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 133)
		{
			ApplyPlayerAnimation(playerid, "PED", "factalk", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 134)
		{
			ApplyPlayerAnimation(playerid, "PED", "facurios", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 135)
		{
			ApplyPlayerAnimation(playerid, "PED", "FALL_back", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 136)
		{
			ApplyPlayerAnimation(playerid, "PED", "FALL_collapse", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 137)
		{
			ApplyPlayerAnimation(playerid, "PED", "FALL_fall", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 138)
		{
			ApplyPlayerAnimation(playerid, "PED", "FALL_front", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 139)
		{
			ApplyPlayerAnimation(playerid, "PED", "FALL_glide", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 140)
		{
			ApplyPlayerAnimation(playerid, "PED", "FALL_land", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 141)
		{
			ApplyPlayerAnimation(playerid, "PED", "FALL_skyDive", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 142)
		{
			ApplyPlayerAnimation(playerid, "PED", "Fight2Idle", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 143)
		{
			ApplyPlayerAnimation(playerid, "PED", "FightA_1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 144)
		{
			ApplyPlayerAnimation(playerid, "PED", "FightA_2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 145)
		{
			ApplyPlayerAnimation(playerid, "PED", "FightA_3", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 146)
		{
			ApplyPlayerAnimation(playerid, "PED", "FightA_block", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 147)
		{
			ApplyPlayerAnimation(playerid, "PED", "FightA_G", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 148)
		{
			ApplyPlayerAnimation(playerid, "PED", "FightA_M", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 149)
		{
			ApplyPlayerAnimation(playerid, "PED", "FIGHTIDLE", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 150)
		{
			ApplyPlayerAnimation(playerid, "PED", "FightShB", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 151)
		{
			ApplyPlayerAnimation(playerid, "PED", "FightShF", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 152)
		{
			ApplyPlayerAnimation(playerid, "PED", "FightSh_BWD", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 153)
		{
			ApplyPlayerAnimation(playerid, "PED", "FightSh_FWD", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 154)
		{
			ApplyPlayerAnimation(playerid, "PED", "FightSh_Left", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 155)
		{
			ApplyPlayerAnimation(playerid, "PED", "FightSh_Right", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 156)
		{
			ApplyPlayerAnimation(playerid, "PED", "flee_lkaround_01", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 157)
		{
			ApplyPlayerAnimation(playerid, "PED", "FLOOR_hit", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 158)
		{
			ApplyPlayerAnimation(playerid, "PED", "FLOOR_hit_f", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 159)
		{
			ApplyPlayerAnimation(playerid, "PED", "fucku", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 160)
		{
			ApplyPlayerAnimation(playerid, "PED", "gang_gunstand", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 161)
		{
			ApplyPlayerAnimation(playerid, "PED", "gas_cwr", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 162)
		{
			ApplyPlayerAnimation(playerid, "PED", "getup", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 163)
		{
			ApplyPlayerAnimation(playerid, "PED", "getup_front", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 164)
		{
			ApplyPlayerAnimation(playerid, "PED", "gum_eat", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 165)
		{
			ApplyPlayerAnimation(playerid, "PED", "GunCrouchBwd", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 166)
		{
			ApplyPlayerAnimation(playerid, "PED", "GunCrouchFwd", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 167)
		{
			ApplyPlayerAnimation(playerid, "PED", "GunMove_BWD", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 168)
		{
			ApplyPlayerAnimation(playerid, "PED", "GunMove_FWD", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 169)
		{
			ApplyPlayerAnimation(playerid, "PED", "GunMove_L", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 170)
		{
			ApplyPlayerAnimation(playerid, "PED", "GunMove_R", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 171)
		{
			ApplyPlayerAnimation(playerid, "PED", "Gun_2_IDLE", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 172)
		{
			ApplyPlayerAnimation(playerid, "PED", "GUN_BUTT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 173)
		{
			ApplyPlayerAnimation(playerid, "PED", "GUN_BUTT_crouch", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 174)
		{
			ApplyPlayerAnimation(playerid, "PED", "Gun_stand", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 175)
		{
			ApplyPlayerAnimation(playerid, "PED", "handscower", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 176)
		{
			ApplyPlayerAnimation(playerid, "PED", "handsup", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 177)
		{
			ApplyPlayerAnimation(playerid, "PED", "HitA_1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 178)
		{
			ApplyPlayerAnimation(playerid, "PED", "HitA_2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 179)
		{
			ApplyPlayerAnimation(playerid, "PED", "HitA_3", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 180)
		{
			ApplyPlayerAnimation(playerid, "PED", "HIT_back", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 181)
		{
			ApplyPlayerAnimation(playerid, "PED", "HIT_behind", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 182)
		{
			ApplyPlayerAnimation(playerid, "PED", "HIT_front", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 183)
		{
			ApplyPlayerAnimation(playerid, "PED", "HIT_GUN_BUTT", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 184)
		{
			ApplyPlayerAnimation(playerid, "PED", "HIT_L", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 185)
		{
			ApplyPlayerAnimation(playerid, "PED", "HIT_R", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 186)
		{
			ApplyPlayerAnimation(playerid, "PED", "HIT_walk", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 187)
		{
			ApplyPlayerAnimation(playerid, "PED", "HIT_wall", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 188)
		{
			ApplyPlayerAnimation(playerid, "PED", "Idlestance_fat", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 189)
		{
			ApplyPlayerAnimation(playerid, "PED", "idlestance_old", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 190)
		{
			ApplyPlayerAnimation(playerid, "PED", "IDLE_armed", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 191)
		{
			ApplyPlayerAnimation(playerid, "PED", "IDLE_chat", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 192)
		{
			ApplyPlayerAnimation(playerid, "PED", "IDLE_csaw", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 193)
		{
			ApplyPlayerAnimation(playerid, "PED", "Idle_Gang1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 194)
		{
			ApplyPlayerAnimation(playerid, "PED", "IDLE_HBHB", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 195)
		{
			ApplyPlayerAnimation(playerid, "PED", "IDLE_ROCKET", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 196)
		{
			ApplyPlayerAnimation(playerid, "PED", "IDLE_stance", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 197)
		{
			ApplyPlayerAnimation(playerid, "PED", "IDLE_taxi", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 198)
		{
			ApplyPlayerAnimation(playerid, "PED", "IDLE_tired", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 199)
		{
			ApplyPlayerAnimation(playerid, "PED", "Jetpack_Idle", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 200)
		{
			ApplyPlayerAnimation(playerid, "PED", "JOG_femaleA", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 201)
		{
			ApplyPlayerAnimation(playerid, "PED", "JOG_maleA", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 202)
		{
			ApplyPlayerAnimation(playerid, "PED", "JUMP_glide", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 203)
		{
			ApplyPlayerAnimation(playerid, "PED", "JUMP_land", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 204)
		{
			ApplyPlayerAnimation(playerid, "PED", "JUMP_launch", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 205)
		{
			ApplyPlayerAnimation(playerid, "PED", "JUMP_launch_R", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 206)
		{
			ApplyPlayerAnimation(playerid, "PED", "KART_drive", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 207)
		{
			ApplyPlayerAnimation(playerid, "PED", "KART_L", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 208)
		{
			ApplyPlayerAnimation(playerid, "PED", "KART_LB", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 209)
		{
			ApplyPlayerAnimation(playerid, "PED", "KART_R", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 210)
		{
			ApplyPlayerAnimation(playerid, "PED", "KD_left", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 211)
		{
			ApplyPlayerAnimation(playerid, "PED", "KD_right", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 212)
		{
			ApplyPlayerAnimation(playerid, "PED", "KO_shot_face", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 213)
		{
			ApplyPlayerAnimation(playerid, "PED", "KO_shot_front", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 214)
		{
			ApplyPlayerAnimation(playerid, "PED", "KO_shot_stom", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 215)
		{
			ApplyPlayerAnimation(playerid, "PED", "KO_skid_back", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 216)
		{
			ApplyPlayerAnimation(playerid, "PED", "KO_skid_front", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 217)
		{
			ApplyPlayerAnimation(playerid, "PED", "KO_spin_L", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 218)
		{
			ApplyPlayerAnimation(playerid, "PED", "KO_spin_R", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 219)
		{
			ApplyPlayerAnimation(playerid, "PED", "pass_Smoke_in_car", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 220)
		{
			ApplyPlayerAnimation(playerid, "PED", "phone_in", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 221)
		{
			ApplyPlayerAnimation(playerid, "PED", "phone_out", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 222)
		{
			ApplyPlayerAnimation(playerid, "PED", "phone_talk", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 223)
		{
			ApplyPlayerAnimation(playerid, "PED", "Player_Sneak", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 224)
		{
			ApplyPlayerAnimation(playerid, "PED", "Player_Sneak_walkstart", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 225)
		{
			ApplyPlayerAnimation(playerid, "PED", "roadcross", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 226)
		{
			ApplyPlayerAnimation(playerid, "PED", "roadcross_female", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 227)
		{
			ApplyPlayerAnimation(playerid, "PED", "roadcross_gang", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 228)
		{
			ApplyPlayerAnimation(playerid, "PED", "roadcross_old", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 229)
		{
			ApplyPlayerAnimation(playerid, "PED", "run_1armed", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 230)
		{
			ApplyPlayerAnimation(playerid, "PED", "run_armed", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 231)
		{
			ApplyPlayerAnimation(playerid, "PED", "run_civi", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 232)
		{
			ApplyPlayerAnimation(playerid, "PED", "run_csaw", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 233)
		{
			ApplyPlayerAnimation(playerid, "PED", "run_fat", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 234)
		{
			ApplyPlayerAnimation(playerid, "PED", "run_fatold", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 235)
		{
			ApplyPlayerAnimation(playerid, "PED", "run_gang1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 236)
		{
			ApplyPlayerAnimation(playerid, "PED", "run_left", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 237)
		{
			ApplyPlayerAnimation(playerid, "PED", "run_old", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 238)
		{
			ApplyPlayerAnimation(playerid, "PED", "run_player", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 239)
		{
			ApplyPlayerAnimation(playerid, "PED", "run_right", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 240)
		{
			ApplyPlayerAnimation(playerid, "PED", "run_rocket", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 241)
		{
			ApplyPlayerAnimation(playerid, "PED", "Run_stop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 242)
		{
			ApplyPlayerAnimation(playerid, "PED", "Run_stopR", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 243)
		{
			ApplyPlayerAnimation(playerid, "PED", "Run_Wuzi", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 244)
		{
			ApplyPlayerAnimation(playerid, "PED", "SEAT_down", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 245)
		{
			ApplyPlayerAnimation(playerid, "PED", "SEAT_idle", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 246)
		{
			ApplyPlayerAnimation(playerid, "PED", "SEAT_up", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 247)
		{
			ApplyPlayerAnimation(playerid, "PED", "SHOT_leftP", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 248)
		{
			ApplyPlayerAnimation(playerid, "PED", "SHOT_partial", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 249)
		{
			ApplyPlayerAnimation(playerid, "PED", "SHOT_partial_B", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 250)
		{
			ApplyPlayerAnimation(playerid, "PED", "SHOT_rightP", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 251)
		{
			ApplyPlayerAnimation(playerid, "PED", "Shove_Partial", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 252)
		{
			ApplyPlayerAnimation(playerid, "PED", "Smoke_in_car", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 253)
		{
			ApplyPlayerAnimation(playerid, "PED", "sprint_civi", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 254)
		{
			ApplyPlayerAnimation(playerid, "PED", "sprint_panic", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 255)
		{
			ApplyPlayerAnimation(playerid, "PED", "Sprint_Wuzi", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 256)
		{
			ApplyPlayerAnimation(playerid, "PED", "swat_run", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 257)
		{
			ApplyPlayerAnimation(playerid, "PED", "Swim_Tread", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 258)
		{
			ApplyPlayerAnimation(playerid, "PED", "Tap_hand", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 259)
		{
			ApplyPlayerAnimation(playerid, "PED", "Tap_handP", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 260)
		{
			ApplyPlayerAnimation(playerid, "PED", "turn_180", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 261)
		{
			ApplyPlayerAnimation(playerid, "PED", "Turn_L", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 262)
		{
			ApplyPlayerAnimation(playerid, "PED", "Turn_R", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 263)
		{
			ApplyPlayerAnimation(playerid, "PED", "WALK_armed", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 264)
		{
			ApplyPlayerAnimation(playerid, "PED", "WALK_civi", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 265)
		{
			ApplyPlayerAnimation(playerid, "PED", "WALK_csaw", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 266)
		{
			ApplyPlayerAnimation(playerid, "PED", "Walk_DoorPartial", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 267)
		{
			ApplyPlayerAnimation(playerid, "PED", "WALK_drunk", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 268)
		{
			ApplyPlayerAnimation(playerid, "PED", "WALK_fat", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 269)
		{
			ApplyPlayerAnimation(playerid, "PED", "WALK_fatold", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 270)
		{
			ApplyPlayerAnimation(playerid, "PED", "WALK_gang1", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 271)
		{
			ApplyPlayerAnimation(playerid, "PED", "WALK_gang2", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 272)
		{
			ApplyPlayerAnimation(playerid, "PED", "WALK_old", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 273)
		{
			ApplyPlayerAnimation(playerid, "PED", "WALK_player", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 274)
		{
			ApplyPlayerAnimation(playerid, "PED", "WALK_rocket", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 275)
		{
			ApplyPlayerAnimation(playerid, "PED", "WALK_shuffle", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 276)
		{
			ApplyPlayerAnimation(playerid, "PED", "WALK_start", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 277)
		{
			ApplyPlayerAnimation(playerid, "PED", "WALK_start_armed", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 278)
		{
			ApplyPlayerAnimation(playerid, "PED", "WALK_start_csaw", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 279)
		{
			ApplyPlayerAnimation(playerid, "PED", "WALK_start_rocket", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 280)
		{
			ApplyPlayerAnimation(playerid, "PED", "Walk_Wuzi", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 281)
		{
			ApplyPlayerAnimation(playerid, "PED", "WEAPON_crouch", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 282)
		{
			ApplyPlayerAnimation(playerid, "PED", "woman_idlestance", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 283)
		{
			ApplyPlayerAnimation(playerid, "PED", "woman_run", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 284)
		{
			ApplyPlayerAnimation(playerid, "PED", "WOMAN_runbusy", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 285)
		{
			ApplyPlayerAnimation(playerid, "PED", "WOMAN_runfatold", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 286)
		{
			ApplyPlayerAnimation(playerid, "PED", "woman_runpanic", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 287)
		{
			ApplyPlayerAnimation(playerid, "PED", "WOMAN_runsexy", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 288)
		{
			ApplyPlayerAnimation(playerid, "PED", "WOMAN_walkbusy", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 289)
		{
			ApplyPlayerAnimation(playerid, "PED", "WOMAN_walkfatold", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 290)
		{
			ApplyPlayerAnimation(playerid, "PED", "WOMAN_walknorm", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 291)
		{
			ApplyPlayerAnimation(playerid, "PED", "WOMAN_walkold", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 292)
		{
			ApplyPlayerAnimation(playerid, "PED", "WOMAN_walkpro", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 293)
		{
			ApplyPlayerAnimation(playerid, "PED", "WOMAN_walksexy", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 294)
		{
			ApplyPlayerAnimation(playerid, "PED", "WOMAN_walkshop", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		else if (animationplayed == 295)
		{
			ApplyPlayerAnimation(playerid, "PED", "XPRESSscratch", 4.1, 0, 1, 1, 1, 1, 1);	//edited by erik019
		}
		return 1;
	}

	else if(strcmp(cmd, "/animphone", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		new a;
		a = strval(tmp);
		if (!strlen(tmp) || a < 1 || a > 3)
		{
			SendClientMessage(playerid, 0xFF0000FF, "U¯YJ: /animphone[1-3]");
			return 1;
		}
		if (a == 1)
		{
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
		}
		else if (a == 2)
		{
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SITTING);
		}
		else if (a == 3)
		{
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
		}
		return 1;
	}
	/*if(strcmp(cmd, "/animsex", true) == 0)
	{
		new atmp[256];  atmp = strtokcmd(cmdtext, idx);
		a = strval(atmp);
		if(!strlen(atmp) || a < 1 || a > 8)
		{
			SendClientMessage(playerid, 0xFF0000FF, "U¯YJ: /animsex[1-8]");
			return 1;
		}
		AnimSex(playerid,a);
		return 1;
	}*/

	else if(strcmp(cmd, "/animbjob", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		new a;
		a = strval(tmp);
		if (!strlen(tmp) || a < 1 || a > 12)
		{
			SendClientMessage(playerid, 0xFF0000FF, "U¯YJ: /animbjob[1-12]");
			return 1;
		}
		if (a == 1)
		{
			ApplyPlayerAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_START_W", 4.1, 0, 1, 1, 1, 1, 1);	//BY MRUCZNIK
		}
		else if (a == 2)
		{
			ApplyPlayerAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_W", 4.1, 0, 1, 1, 1, 1, 1);	//BY MRUCZNIK
		}
		else if (a == 3)
		{
			ApplyPlayerAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_END_W", 4.1, 0, 1, 1, 1, 1, 1);	//BY MRUCZNIK
		}
		else if (a == 4)
		{
			ApplyPlayerAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_START_P", 4.1, 0, 1, 1, 1, 1, 1);	//BY MRUCZNIK
		}
		else if (a == 5)
		{
			ApplyPlayerAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_P", 4.1, 0, 1, 1, 1, 1, 1);	//BY MRUCZNIK
		}
		else if (a == 6)
		{
			ApplyPlayerAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_END_P", 4.1, 0, 1, 1, 1, 1, 1);	//BY MRUCZNIK
		}
		else if (a == 7)
		{
			ApplyPlayerAnimation(playerid, "BLOWJOBZ", "BJ_STAND_START_W", 4.1, 0, 1, 1, 1, 1, 1);	//BY MRUCZNIK
		}
		else if (a == 8)
		{
			ApplyPlayerAnimation(playerid, "BLOWJOBZ", "BJ_STAND_LOOP_W", 4.1, 0, 1, 1, 1, 1, 1);	//BY MRUCZNIK
		}
		else if (a == 9)
		{
			ApplyPlayerAnimation(playerid, "BLOWJOBZ", "BJ_STAND_END_W", 4.1, 0, 1, 1, 1, 1, 1);	//BY MRUCZNIK
		}
		else if (a == 10)
		{
			ApplyPlayerAnimation(playerid, "BLOWJOBZ", "BJ_STAND_START_P", 4.1, 0, 1, 1, 1, 1, 1);	//BY MRUCZNIK
		}
		else if (a == 11)
		{
			ApplyPlayerAnimation(playerid, "BLOWJOBZ", "BJ_STAND_LOOP_P", 4.1, 0, 1, 1, 1, 1, 1);	//BY MRUCZNIK
		}
		else if (a == 12)
		{
			ApplyPlayerAnimation(playerid, "BLOWJOBZ", "BJ_STAND_END_P", 4.1, 0, 1, 1, 1, 1, 1);	//BY MRUCZNIK
		}
		return 1;
	}

	else if(strcmp(cmd, "/dance", true) == 0)
	{
		if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp))
			{
				SendClientMessage(playerid, 0xFF0000FF, ">Write /dance[1-4]");
				return 1;
			}
			animationplayed = strval(tmp);
			if (animationplayed < 1 || animationplayed > 4)
			{
				SendClientMessage(playerid, 0xFF0000FF, ">Write /dance[1-4]");
				return 1;
			}
			if (animationplayed == 1)
			{
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE1);
			}
			else if (animationplayed == 2)
			{
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE2);
			}
			else if (animationplayed == 3)
			{
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE3);
			}
			else if (animationplayed == 4)
			{
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE4);
			}
			return 1;
		}
	}
	return 0;
}

public OnPlayerConnect(playerid)
{
	SendClientMessage(playerid, COLOR_YELLOW, ">Anim System by[VLA]Wooz1e za³adowany. Wpisz /animhelp aby wyœwietliæ listê dostêpnych animacji.");
	return 1;
}