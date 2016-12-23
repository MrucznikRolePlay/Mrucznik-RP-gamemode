/************************************ [=Multimap=] ************************************/
/************** [=Local Multimaps=] **************/
native cmmap(); // Create a new multimap, return a instance id

native cmmap_insert(multimapid, key[], value); // Insert a new value to key, return value index 
native cmmap_insert_arr(multimapid, key[], value[]); // Insert a new string to key, return value index 
native cmmap_insert_float(multimapid, key[], Float:value); // Insert a new float to key, return value index 

native cmmap_insert_key_int(multimapid, key, value); // Insert a new value to key, return value index 
native cmmap_insert_key_int_arr(multimapid, key, value[]); // Insert a new string to key, return value index 
native cmmap_insert_key_int_float(multimapid, key, Float:value); // Insert a new float to key, return value index 

native cmmap_insert_key_float(multimapid, Float:key, value); // Insert a new value to key, return value index 
native cmmap_insert_key_float_arr(multimapid, Float:key, value[]); // Insert a new string to key, return value index 
native cmmap_insert_key_float_float(multimapid, Float:key, Float:value); // Insert a new float to key, return value index 

native cmmap_get(mapid, key[], index); // Get a value from key
native cmmap_get_arr(mapid, key[], index, buffer[], buffersize = sizeof buffer); // Get a value from key
native Float:cmmap_get_float(mapid, key[], index); // Get a value from key

native cmmap_get_key_int(mapid, key, index); // Get a value from key
native cmmap_get_key_int_arr(mapid, key, index, buffer[], buffersize = sizeof buffer); // Get a value from key
native Float:cmmap_get_key_int_float(mapid, key, index); // Get a value from key

native cmmap_get_key_float(mapid, Float:key, index); // Get a value from key
native cmmap_get_key_float_arr(mapid, Float:key, index, buffer[], buffersize = sizeof buffer); // Get a value from key
native Float:cmmap_get_key_float_float(mapid, Float:key, index); // Get a value from key

native cmmap_contains(mapid, key[], index=-1); // If index == -1, returns if key contains, otherwise returns if key contains the index
native cmmap_contains_int(mapid, Float:key, index=-1); // If index == -1, returns if key contains, otherwise returns if key contains the index
native cmmap_contains_float(mapid, key, index=-1); // If index == -1, returns if key contains, otherwise returns if key contains the index

native cmmap_get_type(mapid, key[], index); // If index == -1, returns if key contains, otherwise returns if key contains the index
native cmmap_get_type_int(mapid, Float:key, index); // If index == -1, returns if key contains, otherwise returns if key contains the index
native cmmap_get_type_float(mapid, key, index); // If index == -1, returns if key contains, otherwise returns if key contains the index

native cmmap_clear(mapid); // Remove all keys in map
native cmmap_size(mapid); // Return a multimap size

native cmmap_remove(mapid, key[], index=-1); // If index == -1, removes key
native cmmap_remove_int(mapid, key, index=-1); // If index == -1, removes key
native cmmap_remove_float(mapid, Float:key, index=-1); // If index == -1, removes key

native cmmap_swap_map(mapid, to_swap); // Swaps to multimaps
native cmmap_empty(mapid); // If multimap empty

native cmmap_count(mapid, key[]); // Value count in key
native cmmap_count_float(mapid, Float:key); // Value count in key
native cmmap_count_int(mapid, key); // Value count in key

native cmmap_set(mapid, key[], index, newvalue);
native cmmap_set_arr(mapid, key[], index, newvalue[]); 
native cmmap_set_float(mapid, key[], index, Float:newvalue); 

native cmmap_set_key_int(mapid, key, index, newvalue);
native cmmap_set_key_int_arr(mapid, key, index, newvalue[]); 
native cmmap_set_key_int_float(mapid, key, index, Float:newvalue); 

native cmmap_set_key_float(mapid, Float:key, index, newvalue);
native cmmap_set_key_float_arr(mapid, Float:key, index, newvalue[]); 
native cmmap_set_key_float_float(mapid, Float:key, index ,Float:newvalue); 

/************** [=Global Multimaps=] **************/
native cmmap_g(); // Create a new global multimap, return a instance id

native cmmap_g_insert(multimapid, key[], value); // Insert a new value to key, return value index 
native cmmap_g_insert_arr(multimapid, key[], value[]); // Insert a new string to key, return value index 
native cmmap_g_insert_float(multimapid, key[], Float:value); // Insert a new float to key, return value index 

native cmmap_g_insert_key_int(multimapid, key, value); // Insert a new value to key, return value index 
native cmmap_g_insert_key_int_arr(multimapid, key, value[]); // Insert a new string to key, return value index 
native cmmap_g_insert_key_int_float(multimapid, key, Float:value); // Insert a new float to key, return value index 

native cmmap_g_insert_key_float(multimapid, Float:key, value); // Insert a new value to key, return value index 
native cmmap_g_insert_key_float_arr(multimapid, Float:key, value[]); // Insert a new string to key, return value index 
native cmmap_g_insert_key_float_float(multimapid, Float:key, Float:value); // Insert a new float to key, return value index 

native cmmap_g_get(mapid, key[], index); // Get a value from key
native cmmap_g_get_arr(mapid, key[], index, buffer[], buffersize = sizeof buffer); // Get a value from key
native Float:cmmap_g_get_float(mapid, key[], index); // Get a value from key

native cmmap_g_get_key_int(mapid, key, index); // Get a value from key
native cmmap_g_get_key_int_arr(mapid, key, index, buffer[], buffersize = sizeof buffer); // Get a value from key
native Float:cmmap_g_get_key_int_float(mapid, key, index); // Get a value from key

native cmmap_g_get_key_float(mapid, Float:key, index); // Get a value from key
native cmmap_g_get_key_float_arr(mapid, Float:key, index, buffer[], buffersize = sizeof buffer); // Get a value from key
native Float:cmmap_g_get_key_float_float(mapid, Float:key, index); // Get a value from key

native cmmap_g_contains(mapid, key[], index=-1); // If index == -1, returns if key contains, otherwise returns if key contains the index
native cmmap_g_contains_int(mapid, Float:key, index=-1); // If index == -1, returns if key contains, otherwise returns if key contains the index
native cmmap_g_contains_float(mapid, key, index=-1); // If index == -1, returns if key contains, otherwise returns if key contains the index

native cmmap_g_get_type(mapid, key[], index); // If index == -1, returns if key contains, otherwise returns if key contains the index
native cmmap_g_get_type_int(mapid, Float:key, index); // If index == -1, returns if key contains, otherwise returns if key contains the index
native cmmap_g_get_type_float(mapid, key, index); // If index == -1, returns if key contains, otherwise returns if key contains the index

native cmmap_g_clear(mapid); // Remove all keys in map
native cmmap_g_size(mapid); // Return a multimap size

native cmmap_g_remove(mapid, key[], index=-1); // If index == -1, removes key
native cmmap_g_remove_int(mapid, key, index=-1); // If index == -1, removes key
native cmmap_g_remove_float(mapid, Float:key, index=-1); // If index == -1, removes key

native cmmap_g_swap_map(mapid, to_swap); // Swaps to multimaps
native cmmap_g_empty(mapid); // If multimap empty

native cmmap_g_count(mapid, key[]); // Value count in key
native cmmap_g_count_float(mapid, Float:key); // Value count in key
native cmmap_g_count_int(mapid, key); // Value count in key

native cmmap_g_set(mapid, key[], index, newvalue);
native cmmap_g_set_arr(mapid, key[], index, newvalue[]); 
native cmmap_g_set_float(mapid, key[], index, Float:newvalue); 

native cmmap_g_set_key_int(mapid, key, index, newvalue);
native cmmap_g_set_key_int_arr(mapid, key, index, newvalue[]); 
native cmmap_g_set_key_int_float(mapid, key, index, Float:newvalue); 

native cmmap_g_set_key_float(mapid, Float:key, index, newvalue);
native cmmap_g_set_key_float_arr(mapid, Float:key, index, newvalue[]); 
native cmmap_g_set_key_float_float(mapid, Float:key, index ,Float:newvalue); 
