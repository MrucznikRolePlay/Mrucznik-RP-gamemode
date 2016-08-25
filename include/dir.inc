/*
	Includ
   Directory v2.0 by Terminator3 
	(c) 2012


native IntToOctal(value);

*/

#if defined _Directory_included
	#endinput
#endif
#define _Directory_included

#define type_unknown		0
#define type_file		1
#define type_dir		2
#define type_other		-1



native DIR:DirOpen(const dirname[]);
native DirClose(DIR:dir);
native DirRead(DIR:dir, name[]);
native DirRewind(DIR:dir);
native DirCreate(const name[], mode = 420);
native DirRemove(const name[], bool:empty = false);

native Rename(const oldname[], const newname[]); 	// files too
native CheckPath(const patch[]); 			// fexist + dexist return defined types
native Chmod(const patch[], mode);


#if defined WIN32 || defined WIN

#define FILE_ATTRIBUTE_READONLY			1
#define FILE_ATTRIBUTE_HIDDEN			2
#define FILE_ATTRIBUTE_SYSTEM			4
#define FILE_ATTRIBUTE_ARCHIVE			32
#define FILE_ATTRIBUTE_NORMAL			128
#define FILE_ATTRIBUTE_TEMPORARY		256
#define FILE_ATTRIBUTE_OFFLINE			4096
#define FILE_ATTRIBUTE_NOT_CONTENT_INDEXED	8192 

#else

#define S_IXOTH		1	/* (00001) */
#define S_IWOTH		2	/* (00002) */
#define S_IROTH		4	/* (00004) */
#define S_IXGRP		8	/* (00010) */
#define S_IWGRP		16	/* (00020) */
#define S_IRGRP		32	/* (00040) */
#define S_IXUSR		64	/* (00100) */
#define S_IWUSR		128	/* (00200) */
#define S_IRUSR		256	/* (00400) */
#define S_ISVTX		512	/* (01000) */
#define S_ISGID		1024	/* (02000) */
#define S_ISUID		2048	/* (04000) */

#define S_IREAD		S_IRUSR
#define S_IWRITE	S_IWUSR
#define S_IEXEC		S_IXUSR

stock IntToOctal(x)
{
	new str[10], rn;
	valstr(str, x);
	for(new z, i = strlen(str) - 1; i >= 0; i--, z++)
	    rn += (str[i] - '0') * floatround(floatpower(8.0, z));

	return rn;
}

#endif