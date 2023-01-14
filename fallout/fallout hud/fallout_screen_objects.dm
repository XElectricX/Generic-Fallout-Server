//Changing the position
/atom/movable/screen/action_button/get_button_screen_loc(button_number)
	var/row = round((button_number-1)/9) //9 is max amount of buttons per row
	var/col = ((button_number - 1)%(9)) + 1
	var/coord_col = "-[col-1]"
	var/coord_row = "[-1 - row]"
	var/coord_row_offset = 26
	return "EAST[coord_col]:0,NORTH[coord_row]:[coord_row_offset]"
