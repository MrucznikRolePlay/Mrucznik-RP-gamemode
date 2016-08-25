/************************************ [=Deque=] ************************************/
/************** [=Local Deques=] **************/
native cdeque(); // Create a new deque, Returns: created deque id
native cdeque_push_back(dequeid,push_value); // Push back a value to deque
native cdeque_push_back_arr(dequeid,push_arr[]); // Push back a string to deque
native cdeque_push_back_float(dequeid,Float:push_float); // Push back a float value to deque 
native cdeque_push_front(dequeid,push_value); // Push front a value to deque
native cdeque_push_front_arr(dequeid,push_arr[]); // Push front a string to deque 
native cdeque_push_front_float(dequeid,Float:push_float); // Push front a float value to deque
native cdeque_get_type(dequeid, value_index); // Get type(String, int, float) defined..
native cdeque_pop_back(dequeid); // Remove a value from back
native cdeque_pop_front(dequeid); // Remove a value from front
native cdeque_clear(dequeid); // Delete all values from deque
native cdeque_size(dequeid); // Return a deque size(value count)
native cdeque_empty(dequeid); // If deque is empty
native cdeque_resize(dequeid,newsize); // Resize the deque, if value count < newsize, pushes 0 to new values
native cdeque_remove(dequeid, itemid, end_itemid = -1); // Start removing from itemid, end stop on end_itemid.If end_itemid == -1, only removes itemid
native cdeque_swap_deque(dequeid, to_swap_deque_id); // Swap the two deque values
native cdeque_swap(dequeid, itemid, to_swap_item_id); // Swap a two values in the same deque
native cdeque_shrink_to_fit(dequeid); // Shrink to fit a deque
native cdeque_get(dequeid, itemid); // Get a int value
native cdeque_get_arr(dequeid, itemid, buffer[], buffersize=sizeof buffer); // Copy a string value to buffer
native Float:cdeque_get_float(dequeid, itemid); // Get a float value
native cdeque_is_exists(dequeid, itemid); // If item exists 
native cdeque_is_deque_exists(dequeid); // If deque exists
native cdeque_reverse(dequeid); // Reverse a deque values.Example 1,3,2 will be 2,3,1
native cdeque_find(dequeid, find_value, from = 0, to=-1); // Start finding a value from (from) variable, end on to variable.If found return itemid, otherwise return -1((to=-1) = (to end of deque))
native cdeque_find_arr(dequeid, find_value[], from=0, to=-1); // Start finding a string from (from) variable, end on to variable.If found return itemid, otherwise return -1((to=-1) = (to end of deque))
native cdeque_find_float(dequeid, Float:find_value, from=0, to=-1); // Start finding a float from (from) variable, end on to variable.If found return itemid, otherwise return -1((to=-1) = (to end of deque))
native cdeque_set(dequeid, itemid, new_value); // Set a new value to item
native cdeque_set_arr(dequeid, itemid, new_value[]); // Set a new string to item
native cdeque_set_float(dequeid, itemid, Float:new_value); // Set a new float to item
native cdeque_assign(dequeid, time, value); // Push back a value until i==time
native cdeque_assign_arr(dequeid, time, value[]); // Push back a string until i==time
native cdeque_assign_float(dequeid, time, Float:value); // Push back a float until i==time
native cdeque_sort(dequeid, funcname[]); // Sort deque items
/************** [=Global Deques=] **************/
native cdeque_g(); // Create a new global deque, Returns: created deque id
native cdeque_g_push_back(dequeid,push_value); // Push back a value to deque
native cdeque_g_push_back_arr(dequeid,push_arr[]); // Push back a string to deque
native cdeque_g_push_back_float(dequeid,Float:push_float); // Push back a float value to deque 
native cdeque_g_push_front(dequeid,push_value); // Push front a value to deque
native cdeque_g_push_front_arr(dequeid,push_arr[]); // Push front a string to deque 
native cdeque_g_push_front_float(dequeid,Float:push_float); // Push front a float value to deque
native cdeque_g_get_type(dequeid, value_index); // Get type(String, int, float) defined..
native cdeque_g_pop_back(dequeid); // Remove a value from back
native cdeque_g_pop_front(dequeid); // Remove a value from front
native cdeque_g_clear(dequeid); // Delete all values from deque
native cdeque_g_size(dequeid); // Return a deque size(value count)
native cdeque_g_empty(dequeid); // If deque is empty
native cdeque_g_resize(dequeid,newsize); // Resize the deque, if value count < newsize, pushes 0 to new values
native cdeque_g_remove(dequeid, itemid, end_itemid = -1); // Start removing from itemid, end stop on end_itemid.If end_itemid == -1, only removes itemid
native cdeque_g_swap_deque(dequeid, to_swap_deque_id); // Swap the two deque values
native cdeque_g_swap(dequeid, itemid, to_swap_item_id); // Swap a two values in the same deque
native cdeque_g_shrink_to_fit(dequeid); // Shrink to fit a deque
native cdeque_g_get(dequeid, itemid); // Get a int value
native cdeque_g_get_arr(dequeid, itemid, buffer[], buffersize=sizeof buffer); // Copy a string value to buffer
native Float:cdeque_g_get_float(dequeid, itemid); // Get a float value
native cdeque_g_is_exists(dequeid, itemid); // If item exists 
native cdeque_g_is_deque_exists(dequeid); // If deque exists
native cdeque_g_reverse(dequeid); // Reverse a deque values.Example 1,3,2 will be 2,3,1
native cdeque_g_find(dequeid, find_value, from = 0, to=-1); // Start finding a value from (from) variable, end on to variable.If found return itemid, otherwise return -1((to=-1) = (to end of deque))
native cdeque_g_find_arr(dequeid, find_value[], from=0, to=-1); // Start finding a string from (from) variable, end on to variable.If found return itemid, otherwise return -1((to=-1) = (to end of deque))
native cdeque_g_find_float(dequeid, Float:find_value, from=0, to=-1); // Start finding a float from (from) variable, end on to variable.If found return itemid, otherwise return -1((to=-1) = (to end of deque))
native cdeque_g_set(dequeid, itemid, new_value); // Set a new value to item
native cdeque_g_set_arr(dequeid, itemid, new_value[]); // Set a new string to item
native cdeque_g_set_float(dequeid, itemid, Float:new_value); // Set a new float to item
native cdeque_g_assign(dequeid, time, value); // Push back a value until i==time
native cdeque_g_assign_arr(dequeid, time, value[]); // Push back a string until i==time
native cdeque_g_assign_float(dequeid, time, Float:value); // Push back a float until i==time
native cdeque_g_sort(dequeid, funcname[]); // Sort deque items