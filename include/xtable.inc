#if defined _xtable_included
  #endinput
#endif

#define _xtable_included
#pragma library xtable

#if !defined floatstr
native floatstr(const string[]);
#endif

bool:xtable_create(filename[],rows,columns)
{
	if(rows < 0 || columns < 0 || fexist(filename)) return false;
	new File:file;
	if((file = fopen(filename,io_write)))
	{
	    fwrite(file,"<table cellpadding=\"0\" cellspacing=\"0\" border=\"1\" bordercolor=\"#000000\" width=\"100%\" height=\"100%\">\n");
		for(new i; i < rows; i++)
		{
		    fwrite(file,"<tr>\n");
		    for(new j; j < columns; j++)
		    {
		        fwrite(file,"<td>&nbsp;</td>\n");
		    }
		    fwrite(file,"</tr>\n");
		}
		fclose(file);
		return true;
	}
	return false;
}

bool:xtable_set(filename[],row,column,value[])
{
	if(row < 0 || column < 0 || strfind(name,"\r",true) != -1 || strfind(name,"\n",true) != -1) return false;
	new File:file, File:file2, filename2[256], line[256];
	format(filename2,256,"%s.tab",filename);
	if((file = fopen(filename,io_read)) && (file2 = fopen(filename2,io_write)))
	{
		new curr = -1, curc = -1, bool:written = false;
		while(fread(file,line))
		{
		    if(!strfind(line,"<table",true)) fwrite(file2,line);
		    else if(!strfind(line,"<tr>",true))
			{
				curr++;
				curc = -1;
				fwrite(file2,line);
			} else if(!strfind(line,"<td>",true))
			{
				curc++;
				if(curr == row && curc == column)
				{
				    if(!strlen(name)) format(line,256,"<td>&nbsp;</td>");
				    else format(line,256,"<td>%s</td>\n",name);
				    fwrite(file2,line);
					written = true;
				} else fwrite(file2,line);
			} else fwrite(file2,line);
		}
		fclose(file);
		fclose(file2);
		if(!written)
		{
			fremove(filename2);
		    return false;
		} else {
		    fremove(filename);
			if((file = fopen(filename,io_write)) && (file2 = fopen(filename2,io_read)))
			{
				while(fread(file2,line)) fwrite(file,line);
				fclose(file);
				fclose(file2);
				fremove(filename2);
				return true;
			}
		}
	}
	return false;
}

xtable_get(filename[],row,column)
{
	new File:file, line[256];
	if(row < 0 || column < 0) return line;
	if((file = fopen(filename,io_read)))
	{
		new curr = -1, curc = -1;
		while(fread(file,line))
		{
		    if(!strfind(line,"<tr>",true))
			{
				curr++;
				curc = -1;
			} else if(!strfind(line,"<td>",true))
			{
				curc++;
				if(curr == row && curc == column)
				{
				    strmid(line,line,4,strfind(line,"</td>"));
					fclose(file);
					return line;
				}
			}
		}
		fclose(file);
	}
	line = "";
	return line;
}

xtable_getint(filename[],row,column) return strval(xtable_get(filename,row,column));
Float:xtable_getfloat(filename[],row,column) return floatstr(xtable_get(filename,row,column));
bool:xtable_getbool(filename[],row,column)
{
	if(!strcmp(xtable_get(filename,row,column),"true",true) return true;
	return false;
}

bool:xtable_setint(filename[],row,column,value)
{
	new string[256];
	valstr(string,value);
	return xtable_set(filename,row,column,string);
}

bool:xtable_setfloat(filename[],row,column,Float:value)
{
	new string[256];
	format(string,256,"%f",value);
	return xtable_set(filename,row,column,string);
}

bool:xtable_setbool(filename[],row,column,bool:value)
{
	if(value) return xtable_set(filename,row,column,"true");
	return xtable_set(filename,row,column,"false");
}

#pragma unused xtable_create
#pragma unused xtable_set
#pragma unused xtable_get
#pragma unused xtable_getint
#pragma unused xtable_getfloat
#pragma unused xtable_getbool
#pragma unused xtable_setint
#pragma unused xtable_setfloat
#pragma unused xtable_setbool

/*
native xtable_create(filename[],rows,columns);
native xtable_set(filename[],row,column,value[]);
native xtable_get(filename[],row,column)
native xtable_getint(filename[],row,column)
native xtable_getfloat(filename[],row,column)
native xtable_getbool(filename[],row,column)
native xtable_setint(filename[],row,column,value);
native xtable_setfloat(filename[],row,column,Float:value);
native xtable_setbool(filename[],row,column,bool:value);
*/
