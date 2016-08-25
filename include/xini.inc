#if defined _xini_included
#endinput
#endif

#define _xini_included
#pragma library xini

#if !defined floatstr
native Float:floatstr(const string[]);
#endif

/*
native MakeOneLine(text[256]);
native xini_get(filename[],header[],key[],bool:ignorecase=true);
native xini_set(filename[],header[],key[],value[],bool:ignorecase=true);
native xini_isset(filename[],header[],key[],bool:ignorecase=true);
native xini_setint(filename[],header[],key[],value,bool:ignorecase=true);
native xini_int(filename[],header[],key[],bool:ignorecase=true);
native xini_setfloat(filename[],header[],key[],Float:value,bool:ignorecase=true);
native Float:xini_float(filename[],header[],key[],bool:ignorecase=true);
*/

MakeOneLine(text[256])
{
	new string[256], pos;
	string = text;
	pos = strfind(string,"\n");
	if(pos != -1) strmid(string,string,0,pos);
	pos = strfind(string,"\r");
	if(pos != -1)  strmid(string,string,0,pos);
	return string;
}

xini_get(filename[],header[],key[],bool:ignorecase=true)
{
	new File:file, line[256], key2[256], header2[256];
	if((file = fopen(filename,io_read)))
	{
	    format(key2,256,"%s=",key);
	    format(header2,256,"[%s]",header);
		new bool:inheader = false;
		while(fread(file,line))
		{
		    if(strcmp(MakeOneLine(line),header2,ignorecase) == 0) inheader = true;
		    else if(strfind(line,"=",true) == -1) inheader = false;
			else if(inheader && !strfind(line,key2,ignorecase))
			{
			    format(line,256,"%s",line[strlen(key2)]);
			    return MakeOneLine(line);
			}
		}
	}
	line = "";
	return line;
}

xini_set(filename[],header[],key[],value[],bool:ignorecase=true)
{
	new File:file, File:file2, line[256], key2[256], header2[256], filename2[256], tmp[256];
	format(filename2,256,"%s.xini",filename);
	if((file = fopen(filename,io_read)) && (file2 = fopen(filename2,io_write)))
	{
	    format(key2,256,"%s=",key);
	    format(header2,256,"[%s]",header);
	    format(tmp,256,"%s%s\n",key2,value);
		new bool:inheader = false;
		new bool:written = false;
		new bool:headerexists = false;
		while(fread(file,line))
		{
		    if(strcmp(MakeOneLine(line),header2,ignorecase) == 0)
			{
				inheader = true;
				headerexists = true;
				fwrite(file2,line);
			} else if(strfind(line,"=",true) == -1)
			{
			    if(inheader && !written)
			    {
			        fwrite(file2,tmp);
			        written = true;
			    }
				inheader = false;
				fwrite(file2,line);
			} else if(inheader && !strfind(line,key2,ignorecase))
			{
			    fwrite(file2,tmp);
			    written = true;
			} else fwrite(file2,line);
		}
		if(!written)
		{
			if(!headerexists)
		 	{
			 	format(header2,256,"[%s]\n",header);
		    	fwrite(file2,header2);
			}
		    fwrite(file2,tmp);
		}
		fclose(file);
		fclose(file2);
		fremove(filename);
		if((file = fopen(filename,io_write)) && (file2 = fopen(filename2,io_read)))
		{
		    while(fread(file2,line))
		    {
		        fwrite(file,line);
		    }
		    fclose(file);
		    fclose(file2);
		    fremove(filename2);
		}
	}
}

xini_isset(filename[],header[],key[],bool:ignorecase=true)
{
	new File:file, line[256], key2[256], header2[256];
	if((file = fopen(filename,io_read)))
	{
	    format(key2,256,"%s=",key);
	    format(header2,256,"[%s]",header);
		new bool:inheader = false;
		while(fread(file,line))
		{
		    if(strcmp(MakeOneLine(line),header2,ignorecase) == 0) inheader = true;
		    else if(strfind(line,"=",true) == -1) inheader = false;
			else if(inheader && !strfind(line,key2,ignorecase))
			{
			    return true;
			}
		}
	}
	return false;
}

xini_setint(filename[],header[],key[],value,bool:ignorecase=true)
{
	new string[256];
	format(string,256,"%d",value);
	xini_set(filename,header,key,string,ignorecase);
}

xini_int(filename[],header[],key[],bool:ignorecase=true)
{
	return strval(xini_get(filename,header,key,ignorecase));
}

xini_setfloat(filename[],header[],key[],Float:value,bool:ignorecase=true)
{
	new string[256];
	format(string,256,"%f",value);
	xini_set(filename,header,key,string,ignorecase);
}

Float:xini_float(filename[],header[],key[],bool:ignorecase=true)
{
	return floatstr(xini_get(filename,header,key,ignorecase));
}

#pragma unused MakeOneLine
#pragma unused xini_float
#pragma unused xini_get
#pragma unused xini_int
#pragma unused xini_isset
#pragma unused xini_set
#pragma unused xini_setfloat
#pragma unused xini_setint
