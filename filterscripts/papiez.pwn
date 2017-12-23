//STARE OBIEKTY WYBORCZE

#include <a_samp>
public OnFilterScriptInit()
{
	Create3DTextLabel("œw. Jan Pawe³ II\n18.05.1920 - 02.04.2005\nNa upamiêtnienie XII rocznicy œmierci\n\nPalomino Creek, 02.04.2017", 0xFFFFFFFF, 2267.88306, -41.95980, 27.50000, 7.5, 0, 0);

	new jp2_1 = CreateObject(14467, 2267.63574, -42.98346, 30.23000,   0.00000, 0.00000, -180.00000); //pomnik
	SetObjectMaterial(jp2_1, 0, 11459, "des_pueblo", "des_adobewall3", 0xFFFFFFFF);
	SetObjectMaterial(jp2_1, 1, 11459, "des_pueblo", "des_adobewall3", 0xFFFFFFFF);

	new jp2_2 = CreateObject(18763, 2267.88843, -43.38080, 25.70140,   0.00000, 0.00000, 0.00000); //monument
	SetObjectMaterial(jp2_2, 0, 11459, "des_pueblo", "des_adobewall3", 0xFFFFFFFF);

	new jp2_3 = CreateObject(19993, 2267.96094, -43.47350, 31.89570,   11.00000, -149.00000, 295.00000); //papiuska
	SetObjectMaterial(jp2_3, 0, 2525, "cj_bathroom", "cj_toilet", 0xFFFFFFFF);

	new jp2_5 = CreateObject(3790, 2268.75635, -43.50600, 32.04350,   -11.00000, 69.00000, -149.00000); //krzyz
	SetObjectMaterial(jp2_5, 0, 11459, "des_pueblo", "des_adobewall3", 0xFFFFFFFF);
	SetObjectMaterial(jp2_5, 1, 11459, "des_pueblo", "des_adobewall3", 0xFFFFFFFF);
	SetObjectMaterial(jp2_5, 2, 11459, "des_pueblo", "des_adobewall3", 0xFFFFFFFF);

	new jp2_6 = CreateObject(1014, 2268.94189, -43.50600, 32.45990,   -47.00000, 40.00000, 40.00000); //krzyz
	SetObjectMaterial(jp2_6, 0, 11459, "des_pueblo", "des_adobewall3", 0xFFFFFFFF);

	new jp2_4 = CreateObject(19787, 2267.88306, -41.95980, 27.22410,   0.00000, 0.00000, 180.00000); //tablica
	SetObjectMaterial(jp2_4, 0, 2318, "cj_tv_stand", "CJ_Black_metal", 0xFFFFFFFF);
	SetObjectMaterial(jp2_4, 1, 2318, "cj_tv_stand", "cj_sheetmetal", 0xFFFFFFFF);

	CreateObject(19121, 2269.19653, -42.02730, 27.74000,   0.00000, 0.00000, 0.00000);
	CreateObject(19121, 2269.19702, -44.73000, 27.74000,   0.00000, 0.00000, 0.00000);
	CreateObject(19121, 2266.55127, -44.74603, 27.74000,   0.00000, 0.00000, 0.00000);
	CreateObject(19121, 2266.51611, -42.04623, 27.74000,   0.00000, 0.00000, 0.00000);

	CreateObject(325, 2268.36719, -42.78670, 28.13960,   0.00000, -84.00000, 11.00000);
	CreateObject(325, 2267.68164, -42.14956, 28.13960,   0.00000, -84.00000, -215.00000);
	return 1;
}
