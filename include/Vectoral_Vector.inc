/************************************ [=Vector=] ************************************/
/************** [=Local Vectors=] **************/
native cvector(); // Create a new vector, Returns: created vector id
native cvector_push_back(vectorid,push_value); // Push back a value to vector
native cvector_push_back_arr(vectorid,push_arr[]); // Push back a string to vector
native cvector_push_back_float(vectorid,Float:push_float); // Push back a float value to vector 
native cvector_push_front(vectorid,push_value); // Push front a value to vector
native cvector_push_front_arr(vectorid,push_arr[]); // Push front a string to vector 
native cvector_push_front_float(vectorid,Float:push_float); // Push front a float value to vector
native cvector_get_type(vectorid, value_index); // Get type(String, int, float) defined..
native cvector_pop_back(vectorid); // Remove a value from back
native cvector_pop_front(vectorid); // Remove a value from front
native cvector_clear(vectorid); // Delete all values from vector
native cvector_size(vectorid); // Return a vector size(value count)
native cvector_capacity(vectorid); // Return a vector capacity
native cvector_empty(vectorid); // If vector is empty
native cvector_resize(vectorid,newsize); // Resize the vector, if value count < newsize, pushes 0 to new values
native cvector_remove(vectorid, itemid, end_itemid = -1); // Start removing from itemid, end stop on end_itemid.If end_itemid == -1, only removes itemid
native cvector_swap_vector(vectorid, to_swap_vector_id); // Swap the two vector values
native cvector_swap(vectorid, itemid, to_swap_item_id); // Swap a two values in the same vector
native cvector_shrink_to_fit(vectorid); // Shrink to fit a vector
native cvector_get(vectorid, itemid); // Get a int value
native cvector_get_arr(vectorid, itemid, buffer[], buffersize=sizeof buffer); // Copy a string value to buffer
native Float:cvector_get_float(vectorid, itemid); // Get a float value
native cvector_is_exists(vectorid, itemid); // If item exists 
native cvector_is_vector_exists(vectorid); // If vector exists
native cvector_reverse(vectorid); // Reverse a vector values.Example 1,3,2 will be 2,3,1
native cvector_find(vectorid, find_value, from = 0, to=-1); // Start finding a value from (from) variable, end on to variable.If found return itemid, otherwise return -1((to=-1) = (to end of vector))
native cvector_find_arr(vectorid, find_value[], from=0, to=-1); // Start finding a string from (from) variable, end on to variable.If found return itemid, otherwise return -1((to=-1) = (to end of vector))
native cvector_find_float(vectorid, Float:find_value, from=0, to=-1); // Start finding a float from (from) variable, end on to variable.If found return itemid, otherwise return -1((to=-1) = (to end of vector))
native cvector_set(vectorid, itemid, new_value); // Set a new value to item
native cvector_set_arr(vectorid, itemid, new_value[]); // Set a new string to item
native cvector_set_float(vectorid, itemid, Float:new_value); // Set a new float to item
native cvector_reserve(vectorid, size); // Reserve a vector
native cvector_assign(vectorid, time, value); // Push back a value until i==time
native cvector_assign_arr(vectorid, time, value[]); // Push back a string until i==time
native cvector_assign_float(vectorid, time, Float:value); // Push back a float until i==time
native cvector_sort(vectorid, funcname[]);
/************** [=Global Vectors=] **************/
native cvector_g(); // Create a new global vector, Returns: created vector id
native cvector_g_push_back(vectorid,push_value); // Push back a value to vector
native cvector_g_push_back_arr(vectorid,push_arr[]); // Push back a string to vector
native cvector_g_push_back_float(vectorid,Float:push_float); // Push back a float value to vector 
native cvector_g_push_front(vectorid,push_value); // Push front a value to vector
native cvector_g_push_front_arr(vectorid,push_arr[]); // Push front a string to vector 
native cvector_g_push_front_float(vectorid,Float:push_float); // Push front a float value to vector
native cvector_g_get_type(vectorid, value_index); // Get type(String, int, float) defined..
native cvector_g_pop_back(vectorid); // Remove a value from back
native cvector_g_pop_front(vectorid); // Remove a value from front
native cvector_g_clear(vectorid); // Delete all values from vector
native cvector_g_size(vectorid); // Return a vector size(value count)
native cvector_g_capacity(vectorid); // Return a vector capacity
native cvector_g_empty(vectorid); // If vector is empty
native cvector_g_resize(vectorid,newsize); // Resize the vector, if value count < newsize, pushes 0 to new values
native cvector_g_remove(vectorid, itemid, end_itemid = -1); // Start removing from itemid, end stop on end_itemid.If end_itemid == -1, only removes itemid
native cvector_g_swap_vector(vectorid, to_swap_vector_id); // Swap the two vector values
native cvector_g_swap(vectorid, itemid, to_swap_item_id); // Swap a two values in the same vector
native cvector_g_shrink_to_fit(vectorid); // Shrink to fit a vector
native cvector_g_get(vectorid, itemid); // Get a int value
native cvector_g_get_arr(vectorid, itemid, buffer[], buffersize=sizeof buffer); // Copy a string value to buffer
native Float:cvector_g_get_float(vectorid, itemid); // Get a float value
native cvector_g_is_exists(vectorid, itemid); // If item exists 
native cvector_g_is_vector_exists(vectorid); // If vector exists
native cvector_g_reverse(vectorid); // Reverse a vector values.Example 1,3,2 will be 2,3,1
native cvector_g_find(vectorid, find_value, from = 0, to=-1); // Start finding a value from (from) variable, end on to variable.If found return itemid, otherwise return -1((to=-1) = (to end of vector))
native cvector_g_find_arr(vectorid, find_value[], from=0, to=-1); // Start finding a string from (from) variable, end on to variable.If found return itemid, otherwise return -1((to=-1) = (to end of vector))
native cvector_g_find_float(vectorid, Float:find_value, from=0, to=-1); // Start finding a float from (from) variable, end on to variable.If found return itemid, otherwise return -1((to=-1) = (to end of vector))
native cvector_g_set(vectorid, itemid, new_value); // Set a new value to item
native cvector_g_set_arr(vectorid, itemid, new_value[]); // Set a new string to item
native cvector_g_set_float(vectorid, itemid, Float:new_value); // Set a new float to item
native cvector_g_reserve(vectorid, size); // Reserve a vector
native cvector_g_assign(vectorid, time, value); // Push back a value until i==time
native cvector_g_assign_arr(vectorid, time, value[]); // Push back a string until i==time
native cvector_g_assign_float(vectorid, time, Float:value); // Push back a float until i==time
native cvector_g_sort(vectorid, funcname[]);