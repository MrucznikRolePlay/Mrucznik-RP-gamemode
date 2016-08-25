/************************************ [=Map=] ************************************/
/************** [=Local Maps=] **************/
native cmap(); // Create a new map, return instance id

native cmap_insert(mapid, key[], value); // Insert (if exists, set) value with string key
native cmap_insert_arr(mapid, key[], value[]); // Insert (if exists, set) string with string key
native cmap_insert_float(mapid, key[],Float:value); // Insert (if exists, set) float with string key

native cmap_insert_key_int(mapid, key, value); // Insert (if exists, set) value with int key
native cmap_insert_key_int_arr(mapid, key, value[]); // Insert (if exists,set) string with int key
native cmap_insert_key_int_float(mapid, key, Float:value); // Insert (if exists, set) float with int key

native cmap_insert_key_float(mapid, Float: key, value); // Insert (if exists, set) value with float key
native cmap_insert_key_float_arr(mapid, Float: key, value[]); // Insert (if exists, set) string with float key
native cmap_insert_key_float_float(mapid, Float: key, Float:value); // Insert (if exists, set) float with float key

native cmap_get(mapid, key[]); // Get a value with string key
native cmap_get_arr(mapid, key[], buffer[], buffersize = sizeof buffer); // Get&copy a string with string key
native Float:cmap_get_float(mapid, key[]); // Get a float with string key

native cmap_get_key_int(mapid, key); // Get a value with int key
native cmap_get_key_int_arr(mapid, key, buffer[], buffersize = sizeof buffer); // Get&copy a string with int key
native Float:cmap_get_key_int_float(mapid, key); // Get a float with int key

native cmap_get_key_float(mapid, Float:key); // Get a value with float key
native cmap_get_key_float_arr(mapid, Float:key, buffer[], buffersize = sizeof buffer); // Get&copy a string with float key
native Float:cmap_get_key_float_float(mapid, Float:key); // Get a float with float key

native cmap_contains(mapid, key[]); // If map contains a key(string control)
native cmap_contains_int(mapid, key); // If map contains a key(int control)
native cmap_contains_float(mapid, Float:key); // If map contains a key(float control) 
// Notice: All keys parse to string by c++, so Float key 1 = int key 1 = string key "1"
	// For example: cmap_contains(mapid,"1") = cmap_contains_int(mapid,1) = cmap_contains_float(mapid,1)

native cmap_get_type(mapid, key[]); // Get a value type with string key 
native cmap_get_type_int(mapid, key); // Get a value type with int key 
native cmap_get_type_float(mapid, Float:key); // Get a value type with float key 

native cmap_remove(mapid, key[]); // Remove a key
native cmap_remove_int(mapid, key); // Remove a key
native cmap_remove_float(mapid, Float:key); // Remove a key

native cmap_swap_map(mapid, to_swap_id); // Swap two map

native cmap_swap(mapid, key[], tokey[]); // Swap two keys
native cmap_swap_int(mapid, key[], tokey); // Swap two keys
native cmap_swap_float(mapid, key[], Float:tokey); // Swap two keys

native cmap_swap_key_int(mapid, key, tokey); // Swap two keys
native cmap_swap_key_int_float(mapid, key, Float:tokey); // Swap two keys
native cmap_swap_key_int_arr(mapid, key, tokey[]); // Swap two keys

native cmap_swap_key_float(mapid, Float:key, Float: tokey); // Swap two keys
native cmap_swap_key_float_int(mapid, Float:key, tokey); // Swap two keys
native cmap_swap_key_float_arr(mapid, Float:key, tokey[]); // Swap two keys

native cmap_empty(mapid); // If map is empty
/************** [=Global Maps=] **************/
native cmap_g(); // Create a new global map, return instance id

native cmap_g_insert(mapid, key[], value); // Insert (if exists, set) value with string key
native cmap_g_insert_arr(mapid, key[], value[]); // Insert (if exists, set) string with string key
native cmap_g_insert_float(mapid, key[],Float:value); // Insert (if exists, set) float with string key

native cmap_g_insert_key_int(mapid, key, value); // Insert (if exists, set) value with int key
native cmap_g_insert_key_int_arr(mapid, key, value[]); // Insert (if exists,set) string with int key
native cmap_g_insert_key_int_float(mapid, key, Float:value); // Insert (if exists, set) float with int key

native cmap_g_insert_key_float(mapid, Float: key, value); // Insert (if exists, set) value with float key
native cmap_g_insert_key_float_arr(mapid, Float: key, value[]); // Insert (if exists, set) string with float key
native cmap_g_insert_key_float_float(mapid, Float: key, Float:value); // Insert (if exists, set) float with float key

native cmap_g_get(mapid, key[]); // Get a value with string key
native cmap_g_get_arr(mapid, key[], buffer[], buffersize = sizeof buffer); // Get&copy a string with string key
native Float:cmap_g_get_float(mapid, key[]); // Get a float with string key

native cmap_g_get_key_int(mapid, key); // Get a value with int key
native cmap_g_get_key_int_arr(mapid, key, buffer[], buffersize = sizeof buffer); // Get&copy a string with int key
native Float:cmap_g_get_key_int_float(mapid, key); // Get a float with int key

native cmap_g_get_key_float(mapid, Float:key); // Get a value with float key
native cmap_g_get_key_float_arr(mapid, Float:key, buffer[], buffersize = sizeof buffer); // Get&copy a string with float key
native Float:cmap_g_get_key_float_float(mapid, Float:key); // Get a float with float key

native cmap_g_contains(mapid, key[]); // If map contains a key(string control)
native cmap_g_contains_int(mapid, key); // If map contains a key(int control)
native cmap_g_contains_float(mapid, Float:key); // If map contains a key(float control) 
// Notice: All keys parse to string by c++, so Float key 1 = int key 1 = string key "1"
	// For example: cmap_contains(mapid,"1") = cmap_contains_int(mapid,1) = cmap_contains_float(mapid,1)

native cmap_g_get_type(mapid, key[]); // Get a value type with string key 
native cmap_g_get_type_int(mapid, key); // Get a value type with int key 
native cmap_g_get_type_float(mapid, Float:key); // Get a value type with float key 

native cmap_g_remove(mapid, key[]); // Remove a key
native cmap_g_remove_int(mapid, key); // Remove a key
native cmap_g_remove_float(mapid, Float:key); // Remove a key

native cmap_g_swap_map(mapid, to_swap_id); // Swap two map

native cmap_g_swap(mapid, key[], tokey[]); // Swap two keys
native cmap_g_swap_int(mapid, key[], tokey); // Swap two keys
native cmap_g_swap_float(mapid, key[], Float:tokey); // Swap two keys

native cmap_g_swap_key_int(mapid, key, tokey); // Swap two keys
native cmap_g_swap_key_int_float(mapid, key, Float:tokey); // Swap two keys
native cmap_g_swap_key_int_arr(mapid, key, tokey[]); // Swap two keys

native cmap_g_swap_key_float(mapid, Float:key, Float: tokey); // Swap two keys
native cmap_g_swap_key_float_int(mapid, Float:key, tokey); // Swap two keys
native cmap_g_swap_key_float_arr(mapid, Float:key, tokey[]); // Swap two keys

native cmap_g_empty(mapid); // If map is empty