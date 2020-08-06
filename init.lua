firestorm = {center = {x = 0, y = 0, z = 0}, radius = 50, next_center = {x = 0, y = 0, z = 0}, next_radius = 100}

local modpath = minetest.get_modpath(minetest.get_current_modname())
dofile(modpath .. "/nodes.lua")
dofile(modpath .. "/firestorm.lua")

minetest.after(5, function()
draw_firestorm()
end)
