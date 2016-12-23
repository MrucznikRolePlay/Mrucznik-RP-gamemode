#if defined _strtok_included
	#endinput
#endif
#define _strtok_included

strtok(const stringe[], &index)
{
		new length = strlen(stringe);
		while ((index < length) && (stringe[index] <= ' '))
		{
			index++;
		}

		new offset = index;
		new result[20];
		while ((index < length) && (stringe[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
		{
			result[index - offset] = stringe[index];
			index++;
		}
		result[index - offset] = EOS;
		return result;
}

stock strrest(const stringe[], &index)
{
	new length = strlen(stringe);
	while ((index < length) && (stringe[index] <= ' '))
	{
		index++;
	}
	new offset = index;
	new result[128];
	while ((index < length) && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = stringe[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}