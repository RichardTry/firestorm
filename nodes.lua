minetest.register_node("firestorm:firestorm", {
	description = "Firestorm", 
	drawtype = "glasslike",
	tiles = {
		{
			name = "firestorm_firestorm_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5
			},
		},
	},
	--inventory_image = "firestorm.png",
	use_texture_alpha = true,
	paramtype = "light",
	light_source = 13,
	walkable = false,
	pointable = false,
	buildable_to = true,
	sunlight_propagates = true,
	floodable = true,
	groups = {igniter = 2, dig_immediate = 3, in_creative_inventory = 1},
	drop = "",
	post_effect_color = {a = 101, r = 255, g = 44, b = 0},
	on_flood = flood_flame,
})

