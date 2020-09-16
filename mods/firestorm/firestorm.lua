local side = 0 -- 0 = +x, 1 = +z, 2 = -x, 3 = -z

function set_firestorm(pos)
	if minetest.get_node(pos).name == "air" or minetest.get_item_group(minetest.get_node(pos).name, "leaves") > 0 or minetest.get_item_group(minetest.get_node(pos).name, "attached_node") > 0 then
		minetest.set_node(pos, {name="firestorm:firestorm"})
	end
end

function clear_firestorm(pos)
	if minetest.get_node(pos).name == "firestorm:firestorm" then
		minetest.set_node(pos, {name="air"})
	end
end

function init_firestorm()
	for z = firestorm.z_min, firestorm.z_max do
		for h = -20, 20 do
			set_firestorm({x = firestorm.x_min, y = h, z = z})
			set_firestorm({x = firestorm.x_max, y = h, z = z})
		end
	end
	for x = firestorm.x_min, firestorm.x_max do
		for h = -20, 20 do
			set_firestorm({x = x, y = h, z = firestorm.z_min})
			set_firestorm({x = x, y = h, z = firestorm.z_max})
		end
	end
end

function draw_firestorm()
	if side == 0 then
		if firestorm.x_max > firestorm.x_max_new then
			firestorm.x_max = firestorm.x_max - 1
			for z = firestorm.z_min, firestorm.z_max do
				for h = -20, 20 do
					clear_firestorm({x = firestorm.x_max + 1, y = h,z = z})
					set_firestorm({x = firestorm.x_max, y = h, z = z})
				end
			end
		else
			side = (side + 1) % 4
		end
	elseif side == 1 then
		if firestorm.z_max > firestorm.z_max_new then
			firestorm.z_max = firestorm.z_max - 1
			for x = firestorm.x_min, firestorm.x_max do
				for h = -20, 20 do
					clear_firestorm({x = x, y = h,z = firestorm.z_max + 1})
					set_firestorm({x = x, y = h, z = firestorm.z_max})
				end
			end
		else
			side = (side + 1) % 4
		end
	elseif side == 2 then
		if firestorm.x_min < firestorm.x_min_new then
			firestorm.x_min = firestorm.x_min + 1
			for z = firestorm.z_min, firestorm.z_max do
				for h = -20, 20 do
					clear_firestorm({x = firestorm.x_min - 1, y = h,z = z})
					set_firestorm({x = firestorm.x_min, y = h, z = z})
				end
			end
		else
			side = (side + 1) % 4
		end
	elseif side == 3 then
		if firestorm.z_min < firestorm.z_min_new then
			firestorm.z_min = firestorm.z_min + 1
			for x = firestorm.x_min, firestorm.x_max do
				for h = -20, 20 do
					clear_firestorm({x = x, y = h,z = firestorm.z_min - 1})
					set_firestorm({x = x, y = h, z = firestorm.z_min})
				end
			end
		else
			side = (side + 1) % 4
		end
	end
end

--[[function draw_firestorm()

	local h = 20
	local min = {
		x = firestorm.x_min,
		y = 0,
		z = firestorm.z_min
	}
	local x_corner = {
		x = firestorm.x_max,
		y = h,
		z = firestorm.z_min
	}
	local z_corner = {
		x = firestorm.x_min,
		y = h,
		z = firestorm.z_max
	}
	local max = {
		x = firestorm.x_max,
		y = 0,
		z = firestorm.z_max
	}



	local min_x_vm = minetest.get_voxel_manip()
	local emin, emax = min_x_vm:read_from_map(min, x_corner)
	local min_x_a = VoxelArea:new{
		MinEdge = emin,
		MaxEdge = emax
	}
	local data = min_x_vm:get_data()
	for z = min.z, max.z do
		for y = 0, h do
			local vi
			vi = min_x_a:index(min.x, y, z)
			if data[vi] == c_air then
				data[vi] = c_firestorm
			end
		end
	end
	min_x_vm:set_data(data)
	min_x_vm:write_to_map(data)
	min_x_vm:update_map()

	--

	local max_x_vm = minetest.get_voxel_manip()
	emin, emax = max_x_vm:read_from_map(z_corner, max)
	local max_x_a = VoxelArea:new{
		MinEdge = emin,
		MaxEdge = emax
	}
	data = max_x_vm:get_data()
	for z = min.z, max.z do
		for y = 0, h do
			local vi
			vi = max_x_a:index(max.x, y, z)
			if data[vi] == c_air then
				data[vi] = c_firestorm
			end
		end
	end
	max_x_vm:set_data(data)
	max_x_vm:write_to_map(data)
	max_x_vm:update_map()

	--

	local min_z_vm = minetest.get_voxel_manip()
	emin, emax = min_z_vm:read_from_map(min, z_corner)
	local min_z_a = VoxelArea:new{
		MinEdge = emin,
		MaxEdge = emax
	}
	data = min_x_vm:get_data()
	for x = min.x, max.x do
		for y = 0, h do
			local vi
			vi = min_z_a:index(x, y, min.z)
			if data[vi] == c_air then
				data[vi] = c_firestorm
			end
		end
	end
	min_z_vm:set_data(data)
	min_z_vm:write_to_map(data)
	min_z_vm:update_map()

	--

	local max_z_vm = minetest.get_voxel_manip()
	emin, emax = max_z_vm:read_from_map(x_corner, max)
	local max_z_a = VoxelArea:new{
		MinEdge = emin,
		MaxEdge = emax
	}
	data = max_z_vm:get_data()
	for x = min.x, max.x do
		for y = 0, h do
			local vi
			vi = max_z_a:index(x, y, max.z)
			if data[vi] == c_air then
				data[vi] = c_firestorm
			end
		end
	end
	max_z_vm:set_data(data)
	max_z_vm:write_to_map(data)
	max_z_vm:update_map()
end
]]
