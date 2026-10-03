local BEDROCK_Y = -31000
local bedrock_cid = core.get_content_id("stones:bedrock")

core.register_on_generated(function(minp, maxp)
    -- This map chunk does not contain the bedrock layer
    if BEDROCK_Y < minp.y or BEDROCK_Y > maxp.y then
        return
    end

    local vm, emin, emax = core.get_mapgen_object("voxelmanip")

    local area = VoxelArea:new({
        MinEdge = emin,
        MaxEdge = emax,
    })

    local data = vm:get_data()

    for z = minp.z, maxp.z do
        for x = minp.x, maxp.x do
            data[area:index(x, BEDROCK_Y, z)] = bedrock_cid
        end
    end

    vm:set_data(data)
    vm:write_to_map()
end)
