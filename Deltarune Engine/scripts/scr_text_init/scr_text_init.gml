global.text_data = {
	color : {},
	font : {},
	sound : {},
	func : {},
	gain : 1,
	silent : " \n\t"
}

#region in-text command functions
function __text_init_func(name, func) {
	__text_add_func_index(0, name, func);
}

function __text_type_func(name, func) {
	__text_add_func_index(1, name, func);
}

function __text_draw_func(name, func) {
	__text_add_func_index(2, name, func);
}

function __text_refresh_func(name, func) {
	__text_add_func_index(3, name, func);
}

///@function __text_set_alias(func_name,alias_1,alias_2,...)
function __text_set_alias(func_name) {
	var func = global.text_data.func[$ func_name];
	for (var i=1; i<argument_count; i++) {
		global.text_data.func[$ argument[i]] = func;
	}
}

function __text_add_func_index(type_index, name, func) {
	var arr = global.text_data.func[$ name];
	if (!is_array(arr)) {
		arr = [undefined, undefined, undefined, undefined];
		global.text_data.func[$ name] = arr;
	}
	arr[type_index] = func;
}
#endregion

#region formatting
__text_draw_func("color", function(inst, param) {
	var col = global.text_data.color[$ param[0]] ?? c_white;
	draw_set_color(col);
});
__text_set_alias("color", "col", "c");

__text_draw_func("/color", function(inst) {
	draw_set_color(inst.defaultColor);
});
__text_set_alias("/color", "/col", "/c");

var fontFunc = function(inst, param) {
	var fn = global.text_data.font[$ param[0]] ?? draw_get_font();
	draw_set_font(fn);
}
__text_draw_func("font", fontFunc);
__text_refresh_func("font", fontFunc);

var fontEndFunc = function(inst) {
	draw_set_font(inst.defaultFont);
}
__text_draw_func("/font", fontEndFunc);
__text_refresh_func("/font", fontEndFunc);
#endregion

#region typing options
__text_type_func("sound", function(inst, param) {
	inst.typeSound = global.text_data.sound[$ param[0]];
});
__text_set_alias("sound", "snd");

__text_type_func("/sound", function(inst) {
	inst.typeSound = inst.defaultSound;
});
__text_set_alias("/sound", "/snd");

__text_type_func("speed", function(inst, param) {
	inst.typeSpeed = game_get_speed(gamespeed_fps) / real(param[0]);
});
__text_set_alias("speed", "spd");

__text_type_func("/speed", function(inst) {
	inst.typeSpeed = inst.defaultSpeed;
});
__text_set_alias("/speed", "/spd");
#endregion

#region transform effects
__text_draw_func("shake", function(inst) {
	inst.textStyle = "shake";
});

__text_draw_func("/shake", function(inst) {
	inst.textStyle = inst.defaultStyle;
});
__text_set_alias("/shake", "/wave", "/scared");

__text_draw_func("wave", function(inst) {
	inst.textStyle = "wave";
});

__text_draw_func("scared", function(inst) {
	inst.textStyle = "scared";
});
#endregion

#region random
__text_type_func("wait", function(inst, param) {
	inst.typeTimer += real(param[0]) * inst.typeSpeed * game_get_speed(gamespeed_fps);
});

__text_draw_func("sprite", function(inst, param) {
	var spr = asset_get_index(param[0]);
	if (spr = -1) return;
	with inst {
		var spd = sprite_get_speed(spr);
		//feather disable once all
		if (sprite_get_speed_type(spr) = spritespeed_framespersecond) spd /= game_get_speed(gamespeed_fps);
		var subimg = (spd * frame) % sprite_get_number(spr);
		var w = sprite_get_width(spr) * drawScale;
		var h = sprite_get_height(spr) * drawScale;
		var _x = drawX + xx * drawScale;
		var _y = drawY + yy * drawScale + 0.5 * (lineHeight - h);
		draw_sprite_stretched(spr, subimg, _x, _y, w, h);
		xx += sprite_get_width(spr);
	}
});
__text_type_func("sprite", function(inst) {
	inst.typeTimer += inst.typeSpeed * 2;
	inst.playSound = true;
});
__text_refresh_func("sprite", function(inst, param) {
	var spr = asset_get_index(param[0]);
	if (spr = -1) return;
	inst.wordWidth += sprite_get_width(spr);
})
__text_set_alias("sprite", "spr");
#endregion