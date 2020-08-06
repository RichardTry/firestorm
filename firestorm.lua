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
		z = firestorm.center.z - firestorm.radius,
	}
	local max = {
		x = firestorm.center.x + firestorm.radius,
		y = h,
		z = firestorm.center.z + firestorm.radius,
	}

	local emin, emax = vm:read_from_map(min, max)
	local a = VoxelArea:new{
		MinEdge = emin,
		MaxEdge = emax
	}

	local data = vm:get_data()
	for x = min.x, max.x do
		local vi
		if x == min.x or x == max.x then
			for z = min.z, max.z do
				for y = 0, h do
					vi = a:index(x, y, z)
					if data[vi] == c_air then
						data[vi] = c_firestorm
					end
				end
			end
		else
			for y = 0, h do
				vi = a:index(x, y, min.z)
				if data[vi] == c_air then
					data[vi] = c_firestorm
				end
				vi = a:index(x, y, max.z)
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

