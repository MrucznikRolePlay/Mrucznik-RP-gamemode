/*
 *	Project:		dirReader
 *	File:			dirReader.inc
 *	Description:	native definitions for plugin call
 *	Author:			RyDeR
 */
 
#define FNM_PATHNAME	(1 << 0) 	// No wildcard can ever match `/'
#define FNM_NOESCAPE	(1 << 1)	// Backslashes don't quote special chars
#define FNM_PERIOD		(1 << 2) 	// Leading `.' is matched only explicitly
#define FNM_LEADING_DIR	(1 << 3)	// Ignore `/...' after a match
#define FNM_CASEFOLD	(1 << 4)	// Compare without regard to case
#define FNM_EXTMATCH	(1 << 5)	// Use ksh-like extended matching
#define DR_NO_DIR		(1 << 6)	// Skips directories

native DR: dirReader_open(szName[], szPattern[], const iFlags);
native dirReader_close(DR: drHandle);
native dirReader_getCount(DR: drHandle);
native dirReader_getFileAtIndex(DR: drHandle, const iIdx, szBuf[], const iSize = sizeof(szBuf));