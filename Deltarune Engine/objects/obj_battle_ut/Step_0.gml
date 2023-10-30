/// @desc
#region input
var left = input_check_pressed("left");
var right = input_check_pressed("right");
var down = input_check_pressed("down");
var up = input_check_pressed("up");
var confirm = input_check_pressed("confirm");
var cancel = input_check_pressed("cancel");

var hmove = right-left;
var vmove = down-up;
#endregion


switch(state){
	case BATTLE_UT.BUTTON_SEL:
		button_sel = modulo(button_sel+hmove,button_total);		//loop through buttons
		if left || right SFX_play(snd_menu_switch);
		if confirm button_confirm();
		break;
	case BATTLE_UT.FIGHT_SEL:
		if cancel button_change(-1,BATTLE_UT.BUTTON_SEL);
		else if confirm fight_confirm();
		break;
	case BATTLE_UT.ACT_SEL:
		if cancel button_change(-1,BATTLE_UT.BUTTON_SEL);
		else if confirm act_confirm();
		break;
	case BATTLE_UT.ITEM_SEL:
		if cancel button_change(-1,BATTLE_UT.BUTTON_SEL);
		else if confirm item_confirm();
		break;
	case BATTLE_UT.MERCY_SEL:
		if cancel button_change(-1,BATTLE_UT.BUTTON_SEL);
		else if confirm mercy_confirm();
		break;
}










