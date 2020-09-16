firestorm = {iteration = 0, x_min = -100, x_max = 100, z_min = -100, z_max = 100, x_min_new = -3, x_max_new = 3, z_min_new = -3, z_max_new = 3, alive_players = 1}

local modpath = minetest.get_modpath(minetest.get_current_modname())
dofile(modpath .. "/nodes.lua")
dofile(modpath .. "/firestorm.lua")

function draw_line(near)
	for i = -250, 250 do
		for h = -20, 20 do
			if minetest.get_node({x=near-1,y=h,z=i}).name == "firestorm:firestorm" then
				minetest.set_node({x=near-1,y=h,z=i}, {name="air"})
			end
			if minetest.get_node({x=near,y=h,z=i}).name == "air" then
				minetest.set_node({x=near,y=h,z=i}, {name="firestorm:firestorm"})
			end
		end
	end
end

minetest.after(5, init_firestorm)

for _,player in ipairs(minetest.get_connected_players()) do
	local name = player:get_player_name()
	minetest.chat_send_player(name, "Hello " .. name)
end

minetest.register_on_joinplayer(function(player)
	alive_players = #minetest.get_connected_players()
	minetest.chat_send_all(player:get_player_name().." joined!")
end)

minetest.register_on_dieplayer(function(player)
	minetest.chat_send_all(player:get_player_name().." died.")
	firestorm.alive_players = math.max(0, firestorm.alive_players - 1)
	minetest.chat_send_all(firestorm.alive_players.." is alive.")
end)

function inside_zone(player)
	pos = player:get_pos()
	return pos.x < firestorm.x_min + 0.5 or pos.x > firestorm.x_max - 0.5 or pos.z < firestorm.z_min + 0.5 or pos.z > firestorm.z_max - 0.5
end

local timer = 0
minetest.register_globalstep(function(dtime)
	timer = timer + dtime
	if timer >= 1 then
		for _,player in ipairs(minetest.get_connected_players()) do
			if inside_zone(player) then
				player:set_hp(player:get_hp() - 2)
			end
		end
		draw_firestorm()
		timer = 0
	end
end)
