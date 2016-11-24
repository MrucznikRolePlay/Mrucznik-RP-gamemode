//-------------------------------------------------------------------------------

stock encrypt(string[]) //By Alex "Y_Less" Cole (Based on code from Jeremy Cole)
{
	static key[] = "1345767";
	static size = sizeof(key) - 1;
	new retval[64];
	new j, k, sum, tmp[] = {0, 0};
	j = strlen(string);
	sum = j;
	k = ((j >> 4) + 1) << 4;
	for (new i = 0; i < k; i++)
	{
		if (i < j)
		{
			tmp[0] = string[i];
		}
		else
		{
			tmp[0] = ' ';
		}
		sum = ((sum + strfind(key, tmp) + 1) % size);
		retval[i] = key[sum];
	}
	return retval;
}
native encrypt(string[]);

//-------------------------------------------------------------------------------

stock left(source[], len) //By Alex "Y_Less" Cole (Edited by Sacky)
{
	new retval[MAX_STRING];
	strmid(retval, source, 0, len, MAX_STRING);
	return retval;
}
native left(source[], len);

//-------------------------------------------------------------------------------

stock right(source[], len) //By Alex "Y_Less" Cole
{
	new retval[MAX_STRING], srclen;
	srclen = strlen(source);
	strmid(retval, source, srclen - len, srclen, MAX_STRING);
	return retval;
}
native right(source[], len);

//-------------------------------------------------------------------------------

stock parsecommand(cmdtext[], cmd[], text[], parcount) //By Alex "Y_Less" Cole
{
	new index = 0, length;
	length = strlen(cmdtext);
	while ((index < length) && (cmdtext[index] != ' '))
	{
		index++;
	}
	if (index == length)
	{
		strcat(cmd, cmdtext, 256);
		text[0] = EOS;
		return 0;
	}
	else
	{
	    strmid(cmd, cmdtext, 0, index, 256);
	    cmd[index] = EOS;
	    strmid(text, cmdtext, index + 1, length, 256);
		text[length] = EOS;
		if (parcount)
		{
		    index = 0;
			new pars = 0;
			length = strlen(text);
			while (index < length)
			{
				if ((text[index] != ' ') && ((index == 0) || ((index > 0) && (text[index - 1] == ' '))))
				{
				    pars++;
				}
				index++;
			}
			return pars;
		}
		else
		{
			return 1;
		}
	}
	return 0;
}
native parsecommand(cmdtext[], cmd[], text[], parcount);

//-------------------------------------------------------------------------------

stock minrand(min, max) //By Alex "Y_Less" Cole
{
	return random(max - min) + min;
}
native minrand(min, max);

//-------------------------------------------------------------------------------

stock Float:floatrand(Float:min, Float:max) //By Alex "Y_Less" Cole
{
	new imin;
	imin = floatround(min);
	return float(random((floatround(max) - imin) * 100) + (imin * 100)) / 100.0;
}
native Float:floatrand(Float:min, Float:max);

//-------------------------------------------------------------------------------

stock Float:floatquad(Float:a,Float:b,Float:c) //by [NB]Boylett
{
new Float:x[3];
x[2] = (b*b)-(4*a*c);
if(x[2] < 0) return x;
x[0] = ((-1*b)+floatsqroot(x[2]))/(2*a);
x[1] = ((-1*b)-floatsqroot(x[2]))/(2*a);
return x;
}
native Float:floatquad(Float:a,Float:b,Float:c);

//-------------------------------------------------------------------------------

stock FloatMutliply(Float:data1,Float:data2) //by Pixels^ and Xtreme
{
  format(string,sizeof(string),"%.2f",floatmul(dasta1,data2));
  return string;
}
native FloatMutliply(Float:data1,Float:data2);

//-------------------------------------------------------------------------------

stock FloatDivide(Float:data1,Float:data2) //by Pixels^ and Xtreme
{
  format(string,sizeof(string),"%.2f",floatdiv(dasta1,data2));
  return string;
}
native FloatDivide(Float:data1,Float:data2);

//-------------------------------------------------------------------------------

stock IsFloatSize(Float:value,size) //by Pixels^ and Xtreme
{
  if(floatabs(value) == size) {
    return true;
  }
  else {
    return false
  }
}
native IsFloatSize(Float:value,size);

//-------------------------------------------------------------------------------

stock IsFloatBigger(float:data1,Float:data2) //by Pixels^ and Xtreme
{
  if(data1 > data2) {
    return true;
  }
  else {
    return false;
  }
}
native IsFloatBigger(float:data1,Float:data2);

//-------------------------------------------------------------------------------

stock IsFloatSmaller(float:data1,Float:data2) //by Pixels^ and Xtreme
{
  if(data1 < data2) {
    return true;
  }
  else {
    return false;
  }
}
native IsFloatSmaller(float:data1,Float:data2);

//-------------------------------------------------------------------------------

stock Divide(data1,data2) //by Pixels^ and Xtreme
{
  format(string,sizeof(string),"%d",data1 - data2);
  return string;
}
native Divide(data1,data2);

//-------------------------------------------------------------------------------

stock Square(Float:num) //by Pixels^ and Xtreme
{
  format(string,sizeof(string),"%.2f",floatsqroot(num));
  return string;
}
native Square(Float:num);

//-------------------------------------------------------------------------------

stock FloatDecrease(Float:data1,Float:data2) //by Pixels^ and Xtreme
{
  format(string,sizeof(string),"%.2f",floatsub(data1, data2));
  return string;
}
native FloatDecrease(Float:data1,Float:data2);

//-------------------------------------------------------------------------------

stock RetStr(num) //By Alex "Y_Less" Cole
{
	new str[11];
	valstr(str, num);
	return str;
}
native RetStr(num);

//-------------------------------------------------------------------------------

stock ValidEmail(email[]) //By Jan "DracoBlue" Schütze
{
  new len=strlen(email);
  new cstate=0;
  new i;
  for(i=0;i<len;i++) {
    if ((cstate==0 || cstate==1) && (email[i]>='A' && email[i]<='Z') || (email[i]>='a' && email[i]<='z')  || (email[i]=='.')  || (email[i]=='-')  || (email[i]=='_'))
    {
    } else {
       if ((cstate==0) &&(email[i]=='@')) {
          cstate=1;
       } else {
          return false;
       }
    }
  }
  if (cstate<1) return false;
  if (len<6) return false;
  if ((email[len-3]=='.') || (email[len-4]=='.') || (email[len-5]=='.')) return true;
  return false;
}
native ValidEmail(email[]);

//-------------------------------------------------------------------------------

stock Float:lengthdir_x(Float:length,Float:angle) //By Slick
{
return floatmul(floatcos(floatdiv(floatmul(angle,pi),180.00)),length);
}
native Float:lengthdir_x(Float:length,Float:angle);

//-------------------------------------------------------------------------------

stock Float:lengthdir_y(Float:length,Float:angle) //By Slick
{
return floatmul(-floatsin(floatdiv(floatmul(angle,pi),180.00)),length);
}
native Float:lengthdir_y(Float:length,Float:angle);

//-------------------------------------------------------------------------------

stock Float:isin(Float:opp,Float:hyp) //By Sacky
{
new Float:x = opp/hyp;
if(x < 1 && x > -1){
new Float:ret = x+(1.0/2.0)*(floatpower(x,3)/3.0)+((1.0*3.0)/(2.0*4.0))*(floatpower(x,5)/5.0)+((1.0*3.0*5.0)/(2.0*4.0*6.0))*(floatpower(x,7)/7.0)+((1.0*3.0*5.0*7.0)/(2.0*4.0*6.0*8.0))*(floatpower(x,9)/9.0)+((1.0*3.0*5.0*7.0*9.0)/(2.0*4.0*6.0*8.0*10.0))*(floatpower(x,11)/11.0);
return ret;
}
return -1.00;
}
native Float:isin(Float:opp,Float:hyp);

//-------------------------------------------------------------------------------

stock Float:icos(Float:adj,Float:hyp) //By Sacky
{
new Float:x = adj/hyp;
if(x < 1 && x > -1){
new Float:ret = (pi/2.0)-isin(adj,hyp);
return ret;
}
return -1.00;
}
native Float:icos(Float:adj,Float:hyp);

//-------------------------------------------------------------------------------

stock Float:itan(Float:opp,Float:adj) //By Sacky
{
new Float:x = opp/adj;
if(x < 1 && x > -1){
new Float:ret = x-(1.0/3.0)*floatpower(x,3)+(1.0/5.0)*floatpower(x,5)-(1.0/7.0)*floatpower(x,7)+(1.0/9.0)*floatpower(x,9)-(1.0/11.0)*floatpower(x,11)+(1.0/13.0)*floatpower(x,13)-(1.0/15.0)*floatpower(x,15)+(1.0/17.0)*floatpower(x,17)-(1.0/19.0)*floatpower(x,19)+(1.0/21.0)*floatpower(x,21)-(1.0/23.0)*floatpower(x,23)+(1.0/25.0)*floatpower(x,25);
return ret;
}
return -1.00;
}
native Float:itan(Float:opp,Float:adj);

//-------------------------------------------------------------------------------
/*
stock RadiansToDegrees(Float:radian) //By Sacky
{
new Float:tmp = floatdiv(floatmul(float(radian),pi),float(180));
return floatround(tmp);
}
native RadiansToDegrees(Float:radian);

//-------------------------------------------------------------------------------

stock Float:DegreesToRadians(Float:degrees) //By Sacky
{
new Float:multiply = floatmul(float(degrees),float(180));
new Float:tmp = floatdiv(multiply,pi);
return tmp;
}
native Float:DegreesToRadians(Float:degrees);
*/

//-------------------------------------------------------------------------------

stock str_replace(search[], replace[], source[]) //By Tratulla
{
	new newnick[256];
	new newlen;
	for (new i; i < strlen(source); i++)
	{
	    if (strlen(search) > 1 && i != (strlen(source) - 1))
	    {
	        new matched = 1;
	        new start = i;
	        for (new s; s < strlen(search) && matched == 1; s++)
	        {
	            if (source[i] != search[s] && s == 0)
	            {
	                newnick[newlen] = source[i];
	                matched = 0;
				} else
				{
		            if (source[i] == search[s])
		            {
		                i++;
		            } else
		            {
		                matched = 0;
					}
				}
	        }
	        if (matched == 0)
	        {
	            for (;start <= i; start++)
	            {
	                newnick[newlen] = source[start];
	                newlen++;
	            }
	        } else
	        {
	            for (new r; r < strlen(replace); r++)
	            {
	                newnick[newlen] = replace[r];
	                newlen++;
	            }
				i = (start + (strlen(search) - 1));
	        }
	    } else
	    {
			if (strlen(search) == 1 && source[i] == search[0])
			{
			    for (new r; r < strlen(replace); r++)
			    {
			        newnick[newlen] = replace[r];
			        newlen++;
			    }
			} else
			{
			    newnick[newlen] = source[i];
			    newlen++;
			}
		}
	}
	newnick[newlen] = EOS;
	return newnick;
}
native str_replace(search[], replace[], source[]);

//-------------------------------------------------------------------------------

stock str_replaceEx(search[], replace[], source[]) //by Y_Less
{
new i = 0, len, j = 0;
new retstr[256] = "";
len = strlen(search);
while ((i = strfind(source, search, true, j)) != -1)
{
strcat(retstr, strpart(source, j, i));
strcat(retstr, replace);
j = i + len;
}
strcat(retstr, source[j]);
return retstr;
}
native str_replaceEx(search[], replace[], source[]);

//-------------------------------------------------------------------------------

stock str_replaceEx2(search[],replace[],source[]) //by Sacky
{
	new retstr[256];
	format(retstr,sizeof(retstr),"%s",source);
	new len = strlen(search);
	for(new i=0;i<256;i++){
		new sit[256];
		strmid(sit,source,i,i+len);
		if(equal(len,replace,false)){
			strdel(retstr,i,i+len);
			strins(retstr,replace,i);
		}
		if(i == strlen(retstr)) break;
	}
	return retstr;
}
native str_replaceEx2(search[],replace[],source[]);

//-------------------------------------------------------------------------------

stock strinject(source[], adress, injection[]) // By Luby
{  
 new temp[1024];
 set(temp, source);
 new g=adress;
 while(g<strlen(injection)+adress){
  temp[g]=injection[g-adress];
  g++;
 }
 g=adress+strlen(injection);
 while(g<strlen(source)+strlen(injection)){
  temp[g]=source[g-strlen(injection)];
  g++;
 }
 return temp;
}
native strinject(source[], adress, injection[]);

//-------------------------------------------------------------------------------

stock sprintf(const Format[], {Float,_}:...) //by Peter
{
    new bool:searching, x;

    new string[256], tmp[256], tmp2[256];
    new currarg, i;
    currarg=1;
    for(i=0; i < strlen(Format); i++) {
        if(Format[i] != '%') {
            string[strlen(string)] = Format[i];
            string[strlen(string)] = '\0';
            continue;
         }
        if(Format[i] == '%' && Format[i+1] == '%') {
            string[strlen(string)] = Format[i];
            string[strlen(string)] = '\0';
            i++;
            continue;
         }
         searching = true;

        new tempFormat[256];

        while(searching) {
            tempFormat[strlen(tempFormat)] = Format[i];
            tempFormat[strlen(tempFormat)] = '\0';
            switch(Format[i]) {
                case 's', 'S' : {
                    strdel(tmp, 0, sizeof(tmp));
                    strdel(tmp2, 0, sizeof(tmp2));
                    x=0;
                    for(x=0; getarg(currarg, x) != '\0'; x++) {
                        tmp2[x] = getarg(currarg, x);
                       }
                       tmp2[x] = '\0';
                    format(tmp, sizeof(tmp), tempFormat, tmp2);
                    strcat(string, tmp);
                    searching = false;
                    currarg++;
                   }
                case 'f', 'F' : {
                    strdel(tmp, 0, sizeof(tmp));
                    format(tmp, sizeof(tmp), tempFormat, Float:getarg(currarg));
                    strcat(string, tmp);
                    searching = false;
                    currarg++;
                   }
                case 'd', 'D', 'i' : {
                    strdel(tmp, 0, sizeof(tmp));
                    format(tmp, sizeof(tmp), tempFormat, getarg(currarg));
                    strcat(string, tmp);
                    searching = false;
                    currarg++;
                   }
               }
               if(searching)
                i++;
          }
    }

    return string;
}
native sprintf(const Format[], {Float,_}:...);

//-------------------------------------------------------------------------------

stock strfloat(Float:value) //by Sacky
{
	new str[64];
	format(str,sizeof(str),"%f",value);
	return str;
}
native strfloat(Float:value);

//-------------------------------------------------------------------------------

stock strsep(const str[] , &idx , sep1=',' , sep2='?' , sep3=':' , sep4=' ') //by yom
{
    new len = strlen(str),offset = idx,result[255];

    while ((str[idx] != sep1 && str[idx] != sep2 && str[idx] != sep3 && str[idx] != sep4) && idx < len && (idx - offset < sizeof(result) - 1))
    {
        result[idx - offset] = str[idx];
        idx++;
    }

    result[idx - offset] = EOS;

    if ((str[idx] == sep1 || str[idx] == sep2 || str[idx] == sep3 || str[idx] == sep4) && idx < len)
    {
        idx++;
    }

    return result;
}
native strsep(const str[] , &idx , sep1=',' , sep2='?' , sep3=':' , sep4=' ');

//-------------------------------------------------------------------------------

stock StripChr(string[],chr) //by Sacky
{
new retstr[256];
for(new i=0,j=strlen(string);i<j;i++) if(string[i] != chr) retstr[strlen(retstr)] = chr;
return retstr;
}
native StripChr(string[],chr);

//-------------------------------------------------------------------------------

stock StrToHacker(string[]) //by Ramjet.
{
    new len = strlen(string);
    new result[256];
    for(new i; i < len; i++)
    {
        switch(string[i])
        {
             case 'a': format(result, sizeof(result), "%s4", result);
             case 'b': format(result, sizeof(result), "%sl3", result);
             case 'c': format(result, sizeof(result), "%s(", result);
             case 'd': format(result, sizeof(result), "%s|)", result);
             case 'e': format(result, sizeof(result), "%s3", result);
             case 'f': format(result, sizeof(result), "%sl=", result);
             case 'g': format(result, sizeof(result), "%s6", result);
             case 'h': format(result, sizeof(result), "%s#", result);
             case 'i': format(result, sizeof(result), "%s|", result);
             case 'j': format(result, sizeof(result), "%s_l", result);
             case 'k': format(result, sizeof(result), "%s|<", result);
             case 'l': format(result, sizeof(result), "%sl_", result);
             case 'm': format(result, sizeof(result), "%sl\\/l", result);
             case 'n': format(result, sizeof(result), "%sl/l", result);
             case 'o': format(result, sizeof(result), "%s0", result);
             case 'p': format(result, sizeof(result), "%sl*", result);
             case 'q': format(result, sizeof(result), "%s&", result);
             case 'r': format(result, sizeof(result), "%sl2", result);
             case 's': format(result, sizeof(result), "%s5", result);
             case 't': format(result, sizeof(result), "%s7", result);
             case 'u': format(result, sizeof(result), "%sl_l", result);
             case 'v': format(result, sizeof(result), "%s\\/", result);
             case 'w': format(result, sizeof(result), "%s\\/\\/", result);
             case 'x': format(result, sizeof(result), "%s><", result);
             case 'y': format(result, sizeof(result), "%sY", result);
             case 'z': format(result, sizeof(result), "%s2", result);
             default: format(result, sizeof(result), "%s%c", result, string[i]); // Unrecognised Symbol
         }
    }
    return result;
}
native StrToHacker(string[]);

//-------------------------------------------------------------------------------

stock strequal(string1[],string2[],bool:ignorecase=true,start=0,end=256) //by [NB]Boylett
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
native strequal(string1[],string2[],bool:ignorecase=true,start=0,end=256);

//-------------------------------------------------------------------------------

stock strcon(string[],find[],bool:ignorecase=true,start=0,end=256) //by [NB]Boylett
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
naive strcon(string[],find[],bool:ignorecase=true,start=0,end=256);

//-------------------------------------------------------------------------------

stock strsplit(string[],start,end) //by [NB]Boylett
{
new split[256];
for(new i = start; i < end; i++) split[i-start] = string[i];
return split;
}
native strsplit(string[],start,end);

//-------------------------------------------------------------------------------

stock strvalue(string[]) //by [NB]Boylett
{
new value, tmpval, len, bool:negative;
len = strlen(string);
negative = false;
for(new i = 0; i < len; i++)
{
    switch(string[i])
    {
        case '-':
        {
            if(i == 0) negative = true;
            else return 0;
        }
        case '1'..'9':
        {
            tmpval = string[i] - 48;
            for(new j = i+1; j < len; j++) tmpval *= 10;
            value += tmpval;
        }
        case '0':
        {
// do nothing, itll sort out itself
        }
        default: return 0;
    }
}
if(negative) return value*-1;
return value;
}
native strvalue(string[]);

//-------------------------------------------------------------------------------

stock strtoval(strText[]) //by MaXx001
{
    // This function replaces strval. The difference is that
    // this function returns -1 if the string cant be converted.
    new n,i;
    new bool:numneg;
    new len = strlen(strText);

    if(strText[0] == 0x2D){
        numneg = true;
        i++;
    }

    while(i<len){
        if((strText[i] >= 0x30) && (strText[i]<=0x39)){
            n = (n*10) + (strText[i] - 48);
        } else {
            // Encountered non-numeric ascii
            return -1;
        }
        i++;
    }
    if(numneg){ return 0 - n; }
    return n;
}
native strtoval(strText[]);

//-------------------------------------------------------------------------------

stock strpart(string[], start, end) //by Y_Less
{
new retstr[256];
strmid(retstr, string, start, end);
return retstr;
}
native strpart(string[], start, end);

//-------------------------------------------------------------------------------

stock strrest(const string[], index) //Unnamed
{
	new length = strlen(string);

	new offset = index;
	new result[256];
	while ((index < length) && ((index - offset) < (sizeof(result) - 1)) && (string[index] > '\r'))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
native strrest(const string[], index);

//-------------------------------------------------------------------------------

stock strswap (a[], b[]) //by 50p
{
	new swaped[255];
	format(swaped, sizeof(swaped), "%s", a);
	format(a, 255, "%s", b);
	format(b, 255, "%s", swaped);
}
native strswap (a[], b[]);

//-------------------------------------------------------------------------------

stock varswap (&a, &b) //by 50p
{
	new c=a; a=b; b=c;
}
native varswap (&a, &b);

//-------------------------------------------------------------------------------

stock sscanf(string[], format[], {Float,_}:...) //by Y_Less
{
new
formatPos,
stringPos,
paramPos = 2,
paramCount = numargs();
while (paramPos < paramCount && string[stringPos])
{
switch (format[formatPos])
{
case '\0': break;
case 'i', 'd': setarg(paramPos, 0, strval(string[stringPos]));
case 'c': setarg(paramPos, 0, string[stringPos]);
case 'f': setarg(paramPos, 0, _:floatstr(string[stringPos]));
case 's':
{
new
i;
if(format[formatPos + 1] != '\0')
while (string[stringPos] != ' ' && string[stringPos] != '\0') setarg(paramPos, i++, string[stringPos++]);
else
while (string[stringPos] != '\0') setarg(paramPos, i++, string[stringPos++]);
setarg(paramPos, i, '\0');
}
default: goto skip;
}
while (string[stringPos] && string[stringPos] != ' ') stringPos++;
while (string[stringPos] == ' ') stringPos++;
paramPos++;
skip:
formatPos++;
}
return format[formatPos] ? 0 : 1;
}
native sscanf(string[], format[], {Float,_}:...);

//-------------------------------------------------------------------------------

stock split(const strsrc[], strdest[][], delimiter, maxitems) //by MaXx001
{
new i, li;
new aNum;
new len;
new remdel;

while((i <= strlen(strsrc)) && (aNum < maxitems)){
        if(strsrc[i]==0x22){    // 0x22 = "
            if(delimiter != 0x22){
                remdel = delimiter;
                delimiter = 0x22;
                i++;
                li++;
            }
        }
    if((strsrc[i]==delimiter) || (i==strlen(strsrc))){
        len = strmid(strdest[aNum], strsrc, li, i, 128);
        strdest[aNum][len] = 0; // zero terminate string
        li = i+1;
        aNum++;
        if(delimiter==0x22){
                delimiter = remdel;
                li++;
                i++;
            }
}
i++;
}

return 1;
}
native split(const strsrc[], strdest[][], delimiter, maxitems);

//-------------------------------------------------------------------------------

stock ReadParam(strParams[], nParam) //by MaXx001
{
new oldpos;
new newpos = -1;
  new strParam[33];

for(new i=0;i<nParam;i++){
oldpos = newpos+1;
    newpos = strfind(strParams, ",", true, oldpos);
    if(newpos==-1){
       // This only happens if you try to read a param that isnt there
        strParam[0] = '-';
        strParam[1] = '1';
        strParam[2] = 0;
        return strParam;
}
}
strParam[strmid(strParam, strParams, oldpos, newpos, 32)] = 0;

    if(strlen(strParam) > 3){
    if(strParam[strlen(strParam)-2]==13){
            strParam[strlen(strParam)-2] = 0;
        }
    }
return strParam;
}
native ReadParam(strParams[], nParam);

//-------------------------------------------------------------------------------

stock print_array(array[],array_size = sizeof array) //by [NB]Boylett
{
    printf("new array[%d] = {", array_size);
for(new i; i < array_size; i++)
{
    if(i == (array_size - 1)) printf("{%d}",array[i]);
    else printf("{%d},",array[i]);
}
printf("};");
}
native print_array(array[],array_size = sizeof array);

//-------------------------------------------------------------------------------

stock print_doublearray(array[][],array_size = sizeof array,subarray_size = sizeof array[]) //by [NB]Boylett
{
    printf("new double_array[%d][%d] = {", array_size,subarray_size);
for(new i; i < array_size; i++)
{
    new string[256];
    format(string,256,"{");
    for(new j; j < subarray_size; j++)
    {
        if(j == (subarray_size - 1)) format(string,256,"%s%d}", string, array[i][j]);
        else format(string,256,"%s%d,", string, array[i][j]);
    }
    if(i == (array_size - 1)) print(string);
    else printf("%s,",string);
}
printf("};");
}
native print_doublearray(array[][],array_size = sizeof array,subarray_size = sizeof array[]);

//-------------------------------------------------------------------------------

stock t_print(const string1[]) //by Allan
{
static amtprints;
new string[256],Y,M,D,H,m,S;
gettime(H,m,S);
getdate(Y,M,D);
format(string,256,"<%d/%d/%d @ %d:%d:%d> : %s",D,M,Y,H,m,S,string1);
if(strlen(string1)<=0)
{
printf("Error: No String Defined in t_print call number %d",amtprints+1);
}
else
{
print(string);
}
amtprints++;
}
native t_print(const string1[]);

//-------------------------------------------------------------------------------

stock fcreate(filename[]) //by Sacky
{
	if (fexist(filename)){return false;}
	new File:fhandle = fopen(filename,io_write);
	fclose(fhandle);
	return true;
}
native fcreate(filename[]);

//-------------------------------------------------------------------------------

stock fdeleteline(filename[], line[]) //by Sacky
{
	if(fexist(filename))
 {
		new temp[256];
		new File:fhandle = fopen(filename,io_read);
		fread(fhandle,temp,sizeof(temp),false);
		if(strfind(temp,line,true)==-1){return 0;}
		else{
			fclose(fhandle);
			fremove(filename);
			for(new i=0;i<strlen(temp);i++){
				new templine[256];
				strmid(templine,temp,i,i+strlen(line));
				if(equal(templine,line,true)){
					strdel(temp,i,i+strlen(line));
					fcreate(filename);
					fhandle = fopen(filename,io_write);
					fwrite(fhandle,temp);
					fclose(fhandle);
					return 1;
				}
			}
		}
	}
	return 0;
}
native fdeleteline(filename[], line[]);

//-------------------------------------------------------------------------------

stock CreateAndIntSet(filename[],key[],val[]) //by Pixels^ and Xtreme
{
  new File:f;
  if (fexist(filename)) return false;
  f=fopen(filename,io_write);
  fclose(f);
  if (key[0]==0) {
    return false;
  }
  format(tmpres,sizeof(tmpres),"%s.part",filename);
  fohnd=fopen(filename,io_read);
  format(tmpres,sizeof(tmpres),"%s=%s",key,value);
  fwrite(fwhnd,tmpres);
  fwrite(fwhnd,"\r\n");
}
native CreateAndIntSet(filename[],key[],val[]);

//-------------------------------------------------------------------------------

stock CreateAndFloatSet(filename[],key[],Float:value) //by Pixels^ and Xtreme
{
   new string[MAX_STRING];
   format(string,sizeof(valuestring),"%f",value);
   return CreateAndIntSet(filename,key,string);
}
native CreateAndFloatSet(filename[],key[],Float:value);

//-------------------------------------------------------------------------------

stock CreateAndNumSet(filename[],key[],Float:value) //by Pixels^ and Xtreme
{
   new string[MAX_STRING];
   format(string,sizeof(valuestring),"%d",value);
   return CreateAndIntSet(filename,key,string);
}
native CreateAndNumSet(filename[],key[],Float:value);

//-------------------------------------------------------------------------------

stock FileSize(filename[]) //by yom
{
    new size[10];
    new File:file = fopen(filename,io_append);
    new Float:flen = flength(file)/1048576.0; //bytes to Mo
    if(flen < 1.0) //Mo to Ko
    {
        flen *= 1024;
        format(size,sizeof(size),"%.f Ko",flen);
    }
    else //Mo
    {
        format(size,sizeof(size),"%.2f Mo",flen);
    }
    fclose(file);
    return size;
}
native FileSize(filename[]);

//-------------------------------------------------------------------------------

stock fconfig(filename[],key[],seperator=' ',bool:ignorecase=true) //by [NB]Boylett
{
new File:file, string[256];
    if((file = fopen(filename,io_read)))
    {
    while(fread(file,string))
{
        if(!strfind(string,key,ignorecase) && charfind(string,seperator) == strlen(key))
        {
            strmid(string, string, strlen(key)+1, strlen(string));
            new pos[2];
            pos[0] = strfind(string,"\r",true);
            pos[1] = strfind(string,"\n",true);
            if(pos[1] == -1 && pos[0] == -1) { /* do nothing */ }
            else if(pos[1] == -1) strmid(string, string, 0, pos[0]);
            else if(pos[0] == -1) strmid(string, string, 0, pos[1]);
            else if(pos[0] < pos[1]) strmid(string, string, 0, pos[0]);
            else strmid(string, string, 0, pos[1]);
            return string;
        }
    }
    fclose(file);
    }
    return string;
}
native fconfig(filename[],key[],seperator=' ',bool:ignorecase=true);

//-------------------------------------------------------------------------------

stock GetFileAttributes(filename[],&bytes,&lines) //by Allan
{
	if(!fexist(filename))
	{
	    printf("\nError: Cannot open file: '%s' . Please check the file exists,",filename);
		print("and that the server's directory has a folder named 'scriptfiles'.\n");
		return;
	}
	else
	{
	    new File:tmp=fopen(filename);
		bytes=flength(tmp);
		new tmps[256];
		while(fread(tmp,tmps))
		{
			lines++;
		}
		fclose(tmp);
		return;
	}
}
native GetFileAttributes(filename[],&bytes,&lines);

//-------------------------------------------------------------------------------

stock PrintFileLines(filename[],Start,End) //by Allan
{
if(!fexist(filename))
{
printf("\nError: Cannot open file: '%s' . Please check the file exists,",filename);
print("and that the server's directory has a folder named 'scriptfiles'.\n");
return 0;
}
else
{
new File:tmp=fopen(filename);
new tmps[256];
new lines;
if(Start>End)
{
print("Error: Invalid Search Range.");
}
while(fread(tmp,tmps))
{
lines++;
if(lines>=Start&&lines<=End)
{
print(tmps);
}
}
fclose(tmp);
return 1;
}
return -1;
}
native PrintFileLines(filename[],Start,End);

//-------------------------------------------------------------------------------

stock dini_Add(file[], key[], value) //by [NB]Boylett
{
return dini_IntSet(file, key, dini_Int(file, key) + value);
}
native dini_Add(file[], key[], value);

//-------------------------------------------------------------------------------

stock charfind(string[],character) //by [NB]Boylett
{
for(new i; i < strlen(string); i++)
{
    if(string[i] == character) return i;
}
return -1;
}
native charfind(string[],character);

//-------------------------------------------------------------------------------

stock chrfind(needle, haystack[], start = 0) //by Y_Less
{
new
len = strlen(haystack);
while (start < len)
{
if (haystack[start] == needle) return start;
start++;
}
return -1;
}
native chrfind(needle, haystack[], start = 0);

//-------------------------------------------------------------------------------

stock charpos(const string[], character = ' ', index = 0) //by yom
{
    for(new i = index, j = strlen(string); i < j; i++)
        if (string[i] == character && string[i+1] != character)
            return i+1;

    return -1;
}
native charpos(const string[], character = ' ', index = 0);

//-------------------------------------------------------------------------------

stock Chr(val) //by Sacky
{
new string[3];
string[0] = val;
return string;
}
native Chr(val);

//-------------------------------------------------------------------------------

stock reversejenkins(string[]) //by Y_Less
{
// Based on a Jenkins hash
new
dwHash = 0,
pos = strlen(string);
while (pos--)
{
dwHash += string[pos];
dwHash += (dwHash << 10);
dwHash ^= (dwHash >> 6);
}
dwHash += (dwHash << 3);
dwHash ^= (dwHash >> 11);
dwHash += (dwHash << 15);
return dwHash;
}
native reversejenkins(string[]);

//-------------------------------------------------------------------------------

stock jenkins(string[]) //by Y_Less
{
// Based on a Jenkins hash
new
dwHash = 0,
len = strlen(string),
pos = 0,
c;
while (pos < len)
{
c = string[pos];
dwHash += (c > 'Z' || c < 'A') ? (c) : (c | 0x20); // Lower case
dwHash += (dwHash << 10);
dwHash ^= (dwHash >> 6);
pos++;
}
dwHash += (dwHash << 3);
dwHash ^= (dwHash >> 11);
dwHash += (dwHash << 15);
return dwHash;
}
native jenkins(string[]);

//-------------------------------------------------------------------------------

stock bernstein(string[]) //by Y_Less
{
new
hash = -1,
i,
j;
while ((j = string[i++])) hash = hash * 33 + j;
return hash;
}
native bernstein(string[]);

//-------------------------------------------------------------------------------

stock RandomEx(max,...) //by Sacky
{
	new gen,bool:tainted = false,j = numargs(),enough = 0;
	while(true){
		tainted = false;
		enough++;
		if(enough == 20000) break;
		gen = random(max);
		for(new i=1;i<j;i++){
			if(getarg(i) == gen){
				tainted = true;
				break;
			}
		}
		if(tainted == false) return gen;
	}
	return -1;
}
native RandomEx(max,...);

//-------------------------------------------------------------------------------

stock RandomString(len,bool:lenrand = true) //by Sacky
{
	new retstr[256];
	if(len < sizeof(retstr)){
		if(lenrand == true) for(new i=0,j=random(len);i<j;i++) retstr[i] = minrand(32,126);
		else for(new i=0;i<len;i++) retstr[i] = minrand(32,126);
	}
	else print(" Error in RandomString: Len is bigger than 256 (MAX LEN)");
	return retstr;
}
native RandomString(len,bool:lenrand = true);

//-------------------------------------------------------------------------------

stock concat(str[], len, ...) //by Y_Less
{
len--;
new num = numargs();
new strindex = 0;
new arg = 2;
new argindex;
new argval;
while (arg < num)
{
argindex = 0;
do
{
argval = getarg(arg, argindex);
if (argval == 0) break;
str[strindex] = argval;
strindex++;
if (strindex == len) goto concatend;
argindex++;
}
while (argindex != 0); // Impossible (ignores a warning)
arg++;
}
concatend: // Stupid single level breaks!
str[strindex] = 0; // Null terminate
}
native concat(str[], len, ...);

//-------------------------------------------------------------------------------

stock YomHash(buffer[]) //by yom
{
    new mod = 0xFFF1,
        len = strlen(buffer),
        a = 0,
        b = 1,
        c = 2,
        d = 3;

    for (new i = 0; i < len; i++)
    {
        a = ((a + buffer[i]) % mod);
        b = ((a + b)      % mod);
        c = ((a + b + c)     % mod);
        d = ((a + b + c + d) % mod);
    }

    return ((a + b + c) + (d << 16));
}
native YomHash(buffer[]);

//-------------------------------------------------------------------------------

stock RMB1(buf[]) //by Ramjet.
{
new length=strlen(buf);
new a;

new s1 = 2;
new s2 = 3;
    new s3 = 5;
    new s4 = 7;
    new s5 = 9;
    new s6 = 11;
    new s7 = 13;
    new s8 = 17;
    new s9 = 7919;
    new s10 = 7907;
    new s11 = 7901;
    new s12 = 7883;
    new s13 = 7879;
    new s14 = 7877;
    new s15 = 7873;
    new s16 = 7867;

    for (a=0; a<length; a++)
    {
        s1 = (s1 + buf[a]) * 65521;
        s2 = (s2 / s1 + buf[a]) * 65521;
        s3 = (s3 * s2 / s1 + buf[a]) * 65521;
        s4 = (s4 + s3 - s2 * s1 / buf[a]) * 65521;
        s5 = (s5 / s4 + s3 - s2 * s1 / buf[a]) * 65521;
        s6 = (s6 * s5 / s4 + s3 - s2 * s1 / buf[a]) * 65521;
        s7 = (s7 - s6 * s5 / s4 + s3 - s2 * s1 / buf[a]) * 65521;
        s8 = (s8 + s7 - s6 * s5 / s4 + s3 - s2 * s1 / buf[a]) * 65521;
        s9 = (s9 / s8 + s7 - s6 * s5 / s4 + s3 - s2 * s1 / buf[a]) * 65521;
        s10 = (s10 * s9 / s8 + s7 - s6 * s5 / s4 + s3 - s2 * s1 / buf[a]) * 65521;
        s11 = (s11 - s10 * s9 / s8 + s7 - s6 * s5 / s4 + s3 - s2 * s1 / buf[a]) * 65521;
        s12 = (s12 + s11 - s10 * s9 / s8 + s7 - s6 * s5 / s4 + s3 - s2 * s1 / buf[a]) * 65521;
        s13 = (s13 / s12 + s11 - s10 * s9 / s8 + s7 - s6 * s5 / s4 + s3 - s2 * s1 / buf[a]) * 65521;
        s14 = (s14 * s13 / s12 + s11 - s10 * s9 / s8 + s7 - s6 * s5 / s4 + s3 - s2 * s1 / buf[a]) * 65521;
        s15 = (s15 - s14 * s13 / s12 + s11 - s10 * s9 / s8 + s7 - s6 * s5 / s4 + s3 - s2 * s1 / buf[a]) * 65521;
        s16 = (s16 + s15 - s14 * s13 / s12 + s11 - s10 * s9 / s8 + s7 - s6 * s5 / s4 + s3 - s2 * s1 / buf[a]) * 65521;
    }
 return (s16 << 128) * s1 * s2 * s3 * s4 * s5 * s6 * s7 + s8 + s9 + s10 + s11 + s12 + s13 + s14 + s15 + s16;
}
native RMB1(buf[]);

//-------------------------------------------------------------------------------

stock IsNumeric(const string[]) //By Mike
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
	    if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}
native IsNumeric(const string[]);

//-------------------------------------------------------------------------------

stock IsNumericEx(const string[]) //by DracoBlue
{
  new length=strlen(string);
  if (length==0) return false;
  for (new i = 0; i < length; i++)
    {
      if (
            (string[i] > '9' || string[i] < '0' && string[i]!='-' && string[i]!='+') // Not a number,'+' or '-'
             || (string[i]=='-' && i!=0)                                             // A '-' but not at first.
             || (string[i]=='+' && i!=0)                                             // A '+' but not at first.
         ) return false;
    }
  if (length==1 && (string[0]=='-' || string[0]=='+')) return false;
  return true;
}
native IsNumericEx(const string[]);

//-------------------------------------------------------------------------------

stock IsNumberEven(number) //by [NB]Boylett
{
new string[256];
format(string, sizeof(string), "%d", number);
strmid(string, string, strlen(string)-1, strlen(string));
switch(strval(string))
{
    case 1, 3, 5, 7, 9: return false;
    case 0, 2, 4, 6, 8: return true;
}
return true;
}
native IsNumberEven(number);

//-------------------------------------------------------------------------------

stock IsNumberEvenEx(number) //by Y_Less
{
 return (number % 2) ? 0 : 1;
}
native IsNumberEvenEx(number);

//-------------------------------------------------------------------------------

stock IsNumberOdd(number) //by Y_Less
{
return number % 2;
}
native IsNumberOdd(number);

//-------------------------------------------------------------------------------

stock MultiNumeric(d1,d2,d3,d4,d5,d6) //by Pixels^ and Xtreme
{
  format(string,sizeof(string),"%d",d1 * d2 * d3 * d4 * d5 * d6);
  return string;
}
native MultiNumeric(d1,d2,d3,d4,d5,d6);

//-------------------------------------------------------------------------------

stock NumLength(data1) //by Pixels^ and Xtreme
{
  return strlen(data1);
}
native NumLength(data1);

//-------------------------------------------------------------------------------

stock NumExt(const string[], const sub[]) //by Pixels^ and Xtreme
{
  tmp = strlen(sub[0]);
  tmp2 = strmid(string[0], sub[0], sub[0], strval(tmp));
  format(string,sizeof(string),"%d",strval(tmp2));
  return string;
}
native NumExt(const string[], const sub[]);

//-------------------------------------------------------------------------------

stock RGBAToHex(r, g, b, a) //By Betamaster
{
	return (r<<24 | g<<16 | b<<8 | a);
}
native RGBAToHex(r, g, b, a);

//-------------------------------------------------------------------------------

stock HexToRGBA(colour, &r, &g, &b, &a) //By Betamaster
{
	r = (colour >> 24) & 0xFF;
	g = (colour >> 16) & 0xFF;
	b = (colour >> 8) & 0xFF;
	a = colour & 0xFF;
}
native HexToRGBA(colour, &r, &g, &b, &a);

//-------------------------------------------------------------------------------

stock IsHex(const string[]) //by Sacky
{
if(strlen(string) < 4) return false;
new start = 0;
if(string[0] == '0' && string[1] == 'x') start = 2;
else if(string[0] == '&' && string[1] == 'H') start = 2;
for(new i=start,j=strlen(string);i<j;i++){
if(string[i] <  '0'
&& string[i] >  '9'
&& string[i] != 'a'
&& string[i] != 'A'
&& string[i] != 'b'
&& string[i] != 'B'
&& string[i] != 'c'
&& string[i] != 'C'
&& string[i] != 'd'
&& string[i] != 'D'
&& string[i] != 'e'
&& string[i] != 'E') return false;
}
return true;
}
native IsHex(const string[]);

//-------------------------------------------------------------------------------

stock IsAlpha(const string[]) //by Sacky
{
new len = strlen(string);
if(!len) return false;
for(new i=0;i<len;i++){
if((string[i] < 'a' && string[i] > 'z') && (string[i] < 'A' && string[i] > 'Z')) return false;
}
return true;
}
native IsAlpha(const string[]);

//-------------------------------------------------------------------------------

stock IsSymbol(const string[]) //by Sacky
{
if(!IsNumeric(string) && !IsAlpha(string)) return true;
return false;
}
native IsSymbol(const string[]);

//-------------------------------------------------------------------------------

stock GetCaps(const ascii) //by Sacky
{
if(!IsAlpha(Chr(ascii))) return false;
if(ascii >= 'A' && ascii <= 'Z') return UPPER_CASE;
return LOWER_CASE;
}
native GetCaps(const ascii);

//-------------------------------------------------------------------------------

stock SetCaps(string[],caps) //by Sacky
{
new len = strlen(string);
if(!len) return string;
for(new i=0;i<len;i++){
if(IsAlpha(Chr(string[i])){
new res = GetCaps(string[i]);
if(res != caps){
if(res == UPPER_CASE) string[i] += 32;
else string[i] -= 32;
}
}
}
return string;
}
native SetCaps(string[],caps);

//-------------------------------------------------------------------------------

stock AsInteger({Float,_}:...) //by Sacky
{
new type;
GetArgType(0,type);
switch(type){
case TYPE_STR:{
new string[256];
GetArgString(0,string);
return strval(string);
}
case TYPE_FLO: return floatround(Float:getarg(0));
case TYPE_INT: return getarg(0);
}
return false;
}
native AsInteger({Float,_}:...);

//-------------------------------------------------------------------------------

stock bool:AsBool({Float,_}:...) //by Sacky
{
new type;
GetArgType(0,type);
switch(type){
case TYPE_STR:{
new string[256];
GetArgString(0,string);
return bool:strval(string);
}
case TYPE_FLO:{
if(floatround(Float:getarg(0)) < 1) return false;
else return true;
}
case TYPE_INT:{
if(getarg(0) < 1) return false;
else return true;
}
}
return false;
}
native bool:AsBool({Float,_}:...);

//-------------------------------------------------------------------------------

stock Float:AsFloat({Float,_}:...) //by Sacky
{
new type;
GetArgType(0,type);
switch(type){
case TYPE_STR:{
new string[256];
GetArgString(0,string);
return floatstr(string);
}
case TYPE_FLO: return Float:getarg(0);
case TYPE_INT: return float(getarg(0));
}
return false;
}
native Float:AsFloat({Float,_}:...);

//-------------------------------------------------------------------------------

stock AsString({Float,_}:...) //by Sacky
{
new type;
GetArgType(0,type);
new string[256];
switch(type){
case TYPE_STR:{
GetArgString(0,string);
return string;
}
case TYPE_FLO: return strfloat(Float:getarg(0));
case TYPE_INT:{
valstr(string,getarg(0));
return string;
}
}
return string;
}
native AsString({Float,_}:...)

//-------------------------------------------------------------------------------

stock Hello({Float,_}:...) //by Sacky
{
	new type;
	GetArgType(0,type);
	return type;
}
native Hello({Float,_}:...);

//-------------------------------------------------------------------------------

stock CombSort(lArray[], lArraySize = sizeof(lArray)) //by PsYcHoGoD
{
new lGap = lArraySize;
new lSwaps;
new I;
new lSwap;
new lCount;

while((lGap != 1) || (lSwaps != 0)) {
if (lGap > 1) {
lGap = floatround(lGap/1.3, floatround_floor);
if ((lGap == 10) || (lGap == 9)) lGap = 11;
}

I = 0;
lSwaps = 0;
while((I + lGap) < lArraySize) {
if (lArray[I] > lArray[I + lGap]) {
lSwap = lArray[I];
lArray[I] = lArray[I + lGap];
lArray[I + lGap] = lSwap;
lSwaps++;
}
I++;
}
lCount++;
}
}
native CombSort(lArray[], lArraySize = sizeof(lArray));

//-------------------------------------------------------------------------------

stock ShellSort(lArray[], lArraySize = sizeof(lArray)) //by PsYcHoGoD
{
new I;
new J;
new Incr;
new lTemp;

Incr = 3;
while(Incr > 0) {
for(I = 0; I < lArraySize; I++) {
J = I;
lTemp = lArray[I];
while ((J >= Incr) && (lArray[J-Incr] > lTemp)) {
lArray[J] = lArray[J - Incr];
J = J - Incr;
}
lArray[J] = lTemp;
}
Incr /= 2;
}
}
native ShellSort(lArray[], lArraySize = sizeof(lArray));

//-------------------------------------------------------------------------------

stock _Insert(lArray[], lLength, lValue) //by PsYcHoGoD
{
new I = lLength - 1;

while(I >= 0 && lArray[I] > lValue) {
lArray[I + 1] = lArray[I];
I--;
}
lArray[I + 1] = lValue;
}
native _Insert(lArray[], lLength, lValue);

//-------------------------------------------------------------------------------

stock InsertionSort(lArray[], lArraySize = sizeof(lArray)) //by PsYcHoGoD
{
new I;

while(I < lArraySize) {
_Insert(lArray, I, lArray[I]);
I++;
}
}
native InsertionSort(lArray[], lArraySize = sizeof(lArray));

//-------------------------------------------------------------------------------

stock GnomeSort(lArray[], lArraySize = sizeof(lArray)) //by PsYcHoGoD
{
new I = 1;
new J = 2;
new lSwap;

while(I < lArraySize) {
if (lArray[I-1] <= lArray[I]) {
I = J;
J++;
}
else {
lSwap = lArray[I-1];
lArray[I-1] = lArray[I];
lArray[I] = lSwap;
I--;
if (I == 0) I = 1;
}
}
}
native GnomeSort(lArray[], lArraySize = sizeof(lArray));

//-------------------------------------------------------------------------------

stock SelectionSort(lArray[], lArraySize = sizeof(lArray)) //by PsYcHoGoD
{
new lIndex;
new lSwap;

for(new I = 0; I < lArraySize; I++) {
for(lIndex = I; lIndex < lArraySize; lIndex++) {
if(lArray[lIndex] < lArray[I]) {
lSwap = lArray[I];
lArray[I] = lArray[lIndex];
lArray[lIndex] = lSwap;
}
}
}
}
native SelectionSort(lArray[], lArraySize = sizeof(lArray));

//-------------------------------------------------------------------------------

stock BubbleSort(lArray[], lArraySize = sizeof(lArray)) //by PsYcHoGoD
{
new lSwap;
new bool:bSwapped = true;
new I;

while(bSwapped) {
bSwapped = false;
for(I = lArraySize-1; I > 0; I--) {
if(lArray[I] < lArray[I - 1]) {
lSwap = lArray[I - 1];
lArray[I - 1] = lArray[I];
lArray[I] = lSwap;
bSwapped = true;
}
}
}
}
native BubbleSort(lArray[], lArraySize = sizeof(lArray));

//-------------------------------------------------------------------------------

stock CocktailSort(lArray[], lArraySize = sizeof(lArray)) //by PsYcHoGoD
{
new lSwap;
new bool:bSwapped = true;
new I;

while(bSwapped) {
bSwapped = false;
for(I = lArraySize-1; I > 0; I--) {
if(lArray[I] < lArray[I - 1]) {
lSwap = lArray[I - 1];
lArray[I - 1] = lArray[I];
lArray[I] = lSwap;
bSwapped = true;
}
if(lArray[lArraySize - I-1] > lArray[lArraySize - I]) {
lSwap = lArray[lArraySize - I];
lArray[lArraySize - I] = lArray[lArraySize - I-1];
lArray[lArraySize - I-1] = lSwap;
bSwapped = true;
}
}
}
}
native CocktailSort(lArray[], lArraySize = sizeof(lArray));

//-------------------------------------------------------------------------------

stock quickSort(numbers[], arraySize) //by Y_Less
{
q_sort(numbers, 0, arraySize - 1);
}
native quickSort(numbers[], arraySize);

//-------------------------------------------------------------------------------

stock q_sort(numbers[], left, right) //by Y_Less
{
new
pivot,
l_hold,
r_hold;
l_hold = left;
r_hold = right;
pivot = numbers[left];
while (left < right)
{
while ((numbers[right] >= pivot) && (left < right)) right--;
if (left != right)
{
numbers[left] = numbers[right];
left++;
}
while ((numbers[left] <= pivot) && (left < right)) left++;
if (left != right)
{
numbers[right] = numbers[left];
right--;
}
}
numbers[left] = pivot;
pivot = left;
left = l_hold;
right = r_hold;
if (left < pivot) q_sort(numbers, left, pivot - 1);
if (right > pivot) q_sort(numbers, pivot + 1, right);
}
native q_sort(numbers[], left, right);

//-------------------------------------------------------------------------------

stock WhichBig(i,j,k,x) //by Pixels^
{
      if(i > j && i > k && i > x) return i;
      if(j > i && j > k && j > x) return j;
      if(k > i &&  k > j && k > x) return k;
      if(x > i && x > k && x > j) return x;
      return false;
}
native WhichBig(i,j,k,x);

//-------------------------------------------------------------------------------

stock Big(...) //by Sacky
{
new big = -2147483647;
for(new i=0,j=numargs();i<j;i++){
new t = getarg(i);
if(t > big) big = t;
}
return big;
}
native Big(...);

//-------------------------------------------------------------------------------

stock Max(...) //by PsYcHoGoD
{
new lRet = getarg(0);
for (new I = 1, J=numargs(); I < J; I++) lRet = max(lRet, getarg(I));
return lRet;
}
native Max(...);

//-------------------------------------------------------------------------------

stock Min(...) //by PsYcHoGoD
{
new lRet = getarg(0);
for (new I = 1, J=numargs(); I < J; I++) lRet = min(lRet, getarg(I));
return lRet;
}
native Min(...);

//-------------------------------------------------------------------------------

stock ranstr(length) //by [NB]Boylett
{
new string[256];
for(new i; i < length; i++)
{
if(!random(2)) string[i] = random(26) + 'a';
else string[i] = random(26) + 'A';
}
return string;
}
native ranstr(length);

//-------------------------------------------------------------------------------

stock ranstrEx(length) //by Ramjet.
{
     new string[256];
     for(new i; i < length; i++)
     {
          new rand;
          randomize:
          {
               rand = minrand(32, 255);
               if(rand == 37) goto randomize; // Percentage sign will crash server.
          }
          string[i] = rand;
     }
     return string;
}
native ranstrEx(length);

//-------------------------------------------------------------------------------

stock ranstrEx2(string[], length) //by Y_Less
{
    new
        i,
        rand;
    length--;
    while (i < length)
    {
        rand = minrand(32, 255);
        if(rand != 37) string[i++] = rand;
    }
    string[i] = '\0';
}
native ranstrEx2(string[], length);

//-------------------------------------------------------------------------------

stock GetInvalidCharacter(text[]) //by Cypog
{
	#define n_chars 38
	new invalid;
	new chars[n_chars] = " abcdefghijklmnopqrstuvwxyz0123456789";
	for(new zahl = strlen(text); zahl != 0; zahl--)
	{
		new Char[2];
		strmid(Char, text, zahl-1, zahl);
		if (strfind(chars, Char, true)==-1)
		{
			invalid = 1;
			zahl = 1;
		}
	}
	if (invalid!=1)
		invalid = 0;
	return invalid;
}
native GetInvalidCharacter(text[]);

//-------------------------------------------------------------------------------

stock DeleteDoubleCharacters(string[]) //by [NB]Boylett
{
new offset = 0, i = 0, lastletter, len = strlen(string);
for(i = 0; i < len; i++)
{
new tmpoffset = i-offset;
if(i != 0 && lastletter == string[i]) offset++;
else {
string[tmpoffset] = string[i];
lastletter = string[i];
}
}
string[i-offset] = '\0';
}
native DeleteDoubleCharacters(string[]);

//-------------------------------------------------------------------------------

stock GetXYOnCircle(&Float:x, &Float:y, Float:cx, Float:cy, Float:radius, Float:angle) //by Betamaster
{
x = cx + radius*floatcos(angle, degrees);
y = cy + radius*floatsin(angle, degrees);
}
native GetXYOnCircle(&Float:x, &Float:y, Float:cx, Float:cy, Float:radius, Float:angle);

//-------------------------------------------------------------------------------

stock GetRandomCirclePos(Float:x,Float:y,Float:radius,&Float:x2,&Float:y2) //by Sacky
{
x2 = x + float(TwoWayRand(floatround(floatrand(radius))));
y2 = y + float(TwoWayRand(floatround(floatrand(radius))));
}
native GetRandomCirclePos(Float:x,Float:y,Float:radius,&Float:x2,&Float:y2);

//-------------------------------------------------------------------------------

stock QuadFormula(a,b,c) //by Pixels^ and Xtreme
{
  new Float:yos, Float:neg, string[256];
  yos = ((-1*b) + (floatsqroot((B^2)*(4*a*c)) / (2*a))
  neg = ((-1*b) - (floatsqroot((B^2)*(4*a*c)) / (2*a))
  format(string,sizeof(string),"%.2f, %.2f",yos,neg);
  return string;
}
native QuadFormula(a,b,c);

//-------------------------------------------------------------------------------

stock TwoWayRand(value) //By Allan
{
value=(random(value*2+1)-value);
return value;
}
native TwoWayRand(value);

//-------------------------------------------------------------------------------

stock Factorial(value) //by Pixels^ and Xtreme
{
  new data;
  for(new i = 0; i <= value; i++) data *= i;
  return data;
}
native Factorial(value);

//-------------------------------------------------------------------------------

stock IntDivide(data1,data2) //by Pixels^ and Xtreme
{
  format(string,sizeof(string),"%0.f",data1 / data2);
  return string;
}
native IntDivide(data1,data2);

//-------------------------------------------------------------------------------

stock Add(data1,data2) //by Pixels^ and Xtreme
{
  format(string,sizeof(string),"%d",data1 + data2);
  return string;
}
native Add(data1,data2);

//-------------------------------------------------------------------------------

stock Subtract(data1,data2) //by Pixels^ and Xtreme
{
  format(string,sizeof(string),"%d",data1 - data2);
  return string;
}
native Subtract(data1,data2);

//-------------------------------------------------------------------------------

stock multiply(data1,data2) //by Pixels^ and Xtreme
{
  format(string,sizeof(string),"%d",data1 * data2);
  return string;
}
native multiply(data1,data2);

//-------------------------------------------------------------------------------

stock QuadraticRootCalc(Float:Xsq,Float:X,Float:num) //By Allan
{
new Float:Val1;
new Float:Val2;
Val1=floatsqroot(floatpower(X,2)*4*Xsq*num)/2*Xsq+X;
Val2=floatsqroot(floatpower(X,2)*4*Xsq*num)/2*Xsq-X;
return floatround(Val1*Val2);
}
native QuadraticRootCalc(Float:Xsq,Float:X,Float:num);

//-------------------------------------------------------------------------------

stock ReverseStr(string[]) //by Ramjet.
{
        new result[256], len = strlen(string);
        for(new i; i < len; i++) result[i] = string[len - (i + 1)];
        return result;
}
native ReverseStr(string[]);

//-------------------------------------------------------------------------------

stock MulStrings(const string[], const str[]) //by Pixels^ and Xtreme
{
  tmp = strlen(string[0]);
  tmp1 = strlen(strp[0]);
  format(string,sizeof(string),"%d",strval(tmp) * strval(tmp1));
  return string;
}
native MulStrings(const string[], const str[]);

//-------------------------------------------------------------------------------

stock Strsub(const string[], const sub[]) //by Pixels^ and Xtreme
{
  if(strfind(string[0], sub[0], true)) {
    return true;
  }
  else {
    return false;
  }
}
native Strsub(const string[], const sub[]);

//-------------------------------------------------------------------------------

stock IsStringLength(const string[], length) //by Pixels^ and Xtreme
{
  if(strlen(string[0]) == length) {
    return true;
  }
  else {
    return false;
  }
}
native IsStringLength(const string[], length);

//-------------------------------------------------------------------------------

stock SearchAndDelete(const string[],const sub[]) //by Pixels^ and Xtreme
{
  new tmp[256];
  if(strfind(string[0], sub[0], true)) {
    tmp = strlen(sub[0]);
    strdel(string[0], sub[0], strval(tmp));
    return true;
  }
  else {
    return false;
  }
}
native SearchAndDelete(const string[],const sub[]);

//-------------------------------------------------------------------------------

stock IsSize(const string[],size) //by Pixels^ and Xtreme
{
  if(sizeof(string[0]) == size) {
    return true;
  }
  else {
    return false;
  }
}
native IsSize(const string[],size);

//-------------------------------------------------------------------------------

stock CombineString(const string[], const str[]) //by Pixels^ and Xtreme
{
  strins(string[0], str[0], str[]);
}
native CombineString(const string[], const str[]);

//-------------------------------------------------------------------------------

stock IsStringSameEx(string1[], string2[], len) //by Unnamed
{
		for(new i = 0; i < len; i++) {
		    if(string1[i]!=string2[i])
		        return 0;
			if(string1[i] == 0 || string1[i] == '\n')
			    return 1;
		}
 return 1;
}
native IsStringSameEx(string1[], string2[], len);

//-------------------------------------------------------------------------------

stock ConvertToSafeInput(input[], dest[]) //by Simon
{
new len = strlen(input), idx = 0;
strcat(dest, input, 64);
while (idx < len)
{
    if (dest[idx] == '%')
    {
    strins(dest, "%", idx, 1);
    idx += 2;
    len++;
    }
    else idx++;
}
}
native ConvertToSafeInput(input[], dest[]);

//-------------------------------------------------------------------------------

stock randlet(max) //by Arsenic
{
	return random(max * 100) / 100;
}
native randlet(max);

//-------------------------------------------------------------------------------

stock IsStringIP(string[]) //by Sacky
{
new icnt;
new port;
for(new i=0,j=strlen(string);i<j;i++){
if(string[i] == '.') icnt++;
else if(string[i] ==':') port++;
}
if(icnt == 3){
if(port == 1) return 2;
else if(port == 0) return 1;
}
return 0;
}
native IsStringIP(string[]);

//-------------------------------------------------------------------------------

stock GameTextCheck(const string[]) //By Kamazy
{
for (new i = 0; i < strlen(string); i++)
	{
    if ((string[i] == 126) && (string[i-1] == 126)
	|| (string[i] == ' ') && (string[i-1] == '~') && (string[i-2] == ' ')
	|| (string[i] == '~') && (string[i+2] != '~') && (string[i-2] != '~')
	|| (string[i] == '~') && (string[i+2] == '~') && (string[i-2] == '~')) return 1;
    }
return 0;
}
native GameTextCheck(const string[]);

//-------------------------------------------------------------------------------

stock randarg( ... ) //by Simon
{
return getarg( random( numargs( ) ) );
}
native randarg( ... );

//-------------------------------------------------------------------------------

stock FixChars(string[]) for (new i=0;i<strlen(string);i++) if (string[i] < 0) string[i] += 256; //by ProRail
native FixChars(string[]);
//-------------------------------------------------------------------------------

stock FilterCaps(string[]) //by Y_Less
{
 for (new i = 0, j = strlen(string); i < j; i++)
 {
  if (string[i] > 0x40 && string[i] < 0x5B) string[i] += 0x20;
 }
}
native FilterCaps(string[]);

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------
