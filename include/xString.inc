#if defined _xstring_included
  #endinput
#endif

#define _xstring_included
#pragma library xstring

/*
native strequal(string1[],string2[],bool:ignorecase=true,start=0,end=256);
native strcon(string[],find[],bool:ignorecase=true,start=0,end=256);
native strsplit(string[],start,end);
native strinsert(string[],insert[],point);
native strdelete(string[],start,end);
native intstr(integer);
native strset(string[],set[]);
*/

/*
 *  See if 2 strings are equal
 */
strequal(string1[],string2[],bool:ignorecase=true,start=0,end=256)
{
	for(new i = start; i < strlen(string1); i++)
	{
		if(i > end) break;
		if(string1[i] == string2[i]) continue;
		else if(!ignorecase) return false;
		else if((string1[i] >= 65 || string1[i] <= 90) && ((string1[i] + 0x20) == string2[i])) continue;
		else if((string1[i] >= 97 || string1[i] <= 122) && ((string1[i] - 0x20) == string2[i])) continue;
		else return false;
	}
	return true;
}

/*
 *  See if a string is in a string
 */
strcon(string[],find[],bool:ignorecase=true,start=0,end=256)
{
	new len;
	len = strlen(find);
	for(new i = start; i < strlen(string)-len+1; i++)
	{
		if(i > end) break;
		if(strequal(string[i],find,ignorecase,0,len-1)) return i;
	}
	return -1;
}

/*
 *  Split a string up
 */
strsplit(string[],start,end)
{
	new split[256];
	for(new i = start; i < end; i++) split[i-start] = string[i];
	return split;
}

/*
 *  Insert a string into a string
 */
strinsert(string[],insert[],point)
{
	new inserted[256], len[2], i;
	len[0] = strlen(insert);
	len[1] = point+len[0];
	while(i < len[0]+strlen(string))
	{
	    if(i >= point && i < len[1]) inserted[i]=insert[i-point];
	    else if(i >= len[1]) inserted[i] = string[i-len[0]];
		else inserted[i]=string[i];
		i++;
	}
	return inserted;
}

/*
 *  Delete a part of a string
 */
strdelete(string[],start,end)
{
	new deleted[256], len, i;
	while(i < strlen(string))
	{
	    if(i < start) deleted[i] = string[i];
	    else if(i > end) deleted[i-len] = string[i];
	    else len++;
	    i++;
	}
	return deleted;
}

/*
 *  Convert integer into string
 */
intstr(integer)
{
	new string[10];
	format(string,10,"%d",integer);
	return string;
}

/*
 *  Set a string
 */
strset(string[],set[])
{
	new i;
	while(i < strlen(set))
	{
	    string[i] = set[i];
	    i++;
	}
	string[i+1] = EOS;
}

#pragma unused strequal
#pragma unused strcon
#pragma unused strsplit
#pragma unused strinsert
#pragma unused strdelete
#pragma unused intstr
#pragma unused strset
