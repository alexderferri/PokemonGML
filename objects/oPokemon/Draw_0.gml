/// @description Draw

var _sprite = alliance == Alliance.PLAYER ? data.base.spriteBack : data.base.spriteFront;
draw_sprite(_sprite, image_index, x, y);

for (var i = 0; i < array_length(data.moveset); i++) {
	draw_text(32, 32 * i, data.moveset[i].name);
}
