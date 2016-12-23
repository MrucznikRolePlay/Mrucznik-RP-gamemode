/*  SA:MP MySQL Functions  */

#if defined _sampmysql_included
	#endinput
#endif
#define _sampmysql_included
#pragma library lgw
native samp_mysql_connect(server[], user[], password[]);
native samp_mysql_select_db(db[]);
native samp_mysql_query(query[]);
native samp_mysql_store_result();
native samp_mysql_fetch_row(line[]);
native samp_mysql_get_field(field[], value[]);
native samp_mysql_num_rows();
native samp_mysql_num_fields();
native samp_mysql_ping();
native samp_mysql_real_escape_string(src[], dest[]);
native samp_mysql_free_result();
native samp_mysql_strtok(dest[], separator[], src[]);
native samp_mysql_close();


//Function by Mlody626
stock mysql_get(where[],fieldname[],variable[],db[])
{

	new resultline[1024];
	new query[128];
	new dest[256];
	new field[128];
	new str[128];
	new log[256];
	new bool:BreakWhile;
	new bool:ContinueWhile;
	format(str,sizeof(str),"SELECT %s,%s FROM %s WHERE %s = %s",where,variable,db,where,fieldname);
	samp_mysql_real_escape_string(str, query);
	samp_mysql_query(query);
	samp_mysql_store_result();
	format(log,256,"%s (%s)",str,fieldname);
	while(samp_mysql_fetch_row(resultline)==1)
	{

	if(BreakWhile) break;	
	ContinueWhile = false;
	new xb = strlen(fieldname);
	strmid(field,resultline,0,xb);
	//printf("%s >>> %s",resultline,field);
	if(strfind(field,fieldname,false)>0 || strfind(field,fieldname,false) < 0){
ContinueWhile = true;
//print("Block");
}else{
//print("End of Searching");
BreakWhile = true;
}

if(ContinueWhile) continue;
	
//print("x1");

	    new xx = strlen(resultline);
	    for(new x=0;x<xx;x++){
//print("x2");
	        if(strfind(resultline[x],"|",false) == 0){
//print("x3");
	        	strmid(field,resultline,0,x);
	        	if(strcmp(field,fieldname,false)==0){
//print("x4");
	        		strmid(dest,resultline,x+1,xx);
				BreakWhile = true;
	        		break;
	            }
	        }
	    }
	}

	format(log,256,"%s >>> %s",log,dest);
//	print(log);

	return dest;
}
