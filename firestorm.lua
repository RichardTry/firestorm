local c_air        = minetest.get_content_id("air")
local c_firestorm        = minetest.get_content_id("firestorm:firestorm")

function restart_firestorm(center, radius)
	firestorm.center = center
	firestorm.radius = radius
end

function draw_firestorm()
	
	local vm = minetest.get_voxel_manip()

	local h = 20
	local min = {
		x = firestorm.center.x - firestorm.radius,
		y = -h,
		z = firestorm.center.z - firestorm.radius
	}
	local x_corner = {
		x = firestorm.center.x + firestorm.radius,
		y = h,
		z = firestorm.center.z - firestorm.radius
	}
	local z_corner = {
		x = firestorm.center.x - firestorm.radius,
		y = h,
		z = firestorm.center.z + firestorm.radius
	}
	local max = {
		x = firestorm.center.x + firestorm.radius,
		y = -h,
		z = firestorm.center.z + firestorm.radius
	}

	local emin, emax = vm:read_from_map(min, x_corner)
	local min_x = VoxelArea:new{
		MinEdge = emin,
		MaxEdge = emax
	}
	emin, emax = vm:read_from_map(z_corner, max)
	local max_x = VoxelArea:new{
		MinEdge = emin,
		MaxEdge = emax
	}
	emin, emax = vm:read_from_map(min, z_corner)
	local min_z = VoxelArea:new{
		MinEdge = emin,
		MaxEdge = emax
	}
	emin, emax = vm:read_from_map(x_corner, max)
	local max_z = VoxelArea:new{
		MinEdge = emin,
		MaxEdge = emax
	}

	local data = vm:get_data()
	for x = min.x, max.x do
		local vi
		if x == min.x then
			for z = min.z, max.z do
				for y = 0, h do
					vi = min_x:index(x, y, z)
					if data[vi] == c_air then
						data[vi] = c_firestorm
					end
				end
			end
		elseif x == max.x then
			for z = min.z, max.z do
				for y = 0, h do
					vi = max_x:index(x, y, z)
					if data[vi] == c_air then
						data[vi] = c_firestorm
					end
				end
			end
		else
			for y = 0, h do
				vi = min_z:index(x, y, min.z)
				if data[vi] == c_air then
					data[vi] = c_firestorm
				end
				vi = max_z:index(x, y, max.z)
				if data[vi] == c_air then
					data[vi] = c_firestorm
				end
			end
		end
	end

	vm:set_data(data)
	vm:write_to_map(data)
	vm:update_map()
end

