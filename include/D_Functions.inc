/*
	INCLUDE STWORZONY PRZEZ FIRE DRAGON'A !
	UKRADNIESZ MOJ¥ PRACÊ TO UMRZE CI MATKA !
*/


/*------------------------------------
native djSetIntEx(filename[], name[], dataname[], data);
native djIntEx(filename[], name[], dataname[]);
native Float: djSetFloatEx(filename[], name[], dataname[], Float: data);
native Float: djFloatEx(filename[], name[], dataname[]);
native djSetEx(filename[], name[], dataname[], data[]);
native djEx(filename[], name[], dataname[]);
*/

//intigery

stock djSetIntEx(filename[], name[], dataname[], data) //by Fire Dragon
{
	new SPos[64], SFile[64];
	format(SPos, 64, "%s/%s", name, dataname);
	format(SFile, 64, "%s.json", filename);
	return djSetInt(SFile, SPos, data);
}

stock djIntEx(filename[], name[], dataname[]) //by Fire Dragon
{
	new SPos[64], SFile[64];
	format(SPos, 64, "%s/%s", name, dataname);
	format(SFile, 64, "%s.json", filename);
	return djInt(SFile, SPos);
}


//floaty

stock Float: djSetFloatEx(filename[], name[], dataname[], Float: data) //by Fire Dragon
{
	new SPos[64], SFile[64];
	format(SPos, 64, "%s/%s", name, dataname);
	format(SFile, 64, "%s.json", filename);
	return djSetFloat(SFile, SPos, data);
}

stock Float: djFloatEx(filename[], name[], dataname[]) //by Fire Dragon
{
	new SPos[64], SFile[64];
	format(SPos, 64, "%s/%s", name, dataname);
	format(SFile, 64, "%s.json", filename);
	return djFloat(SFile, SPos);
}


//stingi

stock djSetEx(filename[], name[], dataname[], data[]) //by Fire Dragon
{
	new SPos[64], SFile[64];
	format(SPos, 64, "%s/%s", name, dataname);
	format(SFile, 64, "%s.json", filename);
	return djSet(SFile, SPos, data);
}

stock djEx(filename[], name[], dataname[]) //by Fire Dragon
{
	new SPos[64], SFile[64];
	format(SPos, 64, "%s/%s", name, dataname);
	format(SFile, 64, "%s.json", filename);
	return dj(SFile, SPos);
}