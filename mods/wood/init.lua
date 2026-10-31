-- Hey, so you're looking in here? This is the code to register wooden plank blocks.
-- Maybe consider subscribing to @FocusPup824 on YouTube.

-- How should the blocks sound?
wood_sounds = {
    dig = {
        name = "wood_break",
        gain = 0.5,
    },
    place = {
        name = "wood_break",
        gain = 0.95
    },
    footstep = {
        name = "wood_step",
        gain = 0.25,
    },
}

function generate_wood_id_from_type (color)
    local id = string.lower(color)
    id = string.gsub(id, " ", "_")
    return id
end

wood_types = {"Oak", "Dark Oak", "Acacia"}
for index, type in ipairs(wood_types) do
    local id = generate_wood_id_from_type(type)
    core.register_alias("natural_blocks:"..id.."_log", "wood:"..id.."_log")
    core.register_node("wood:"..id.."_log", {
        description = type.." Log",
        tiles = {
            id.."_log_top.png", -- Top
            id.."_log_top.png", -- Bottom
            id.."_log.png", -- Right
            id.."_log.png", -- Left
            id.."_log.png", -- Back
            id.."_log.png" -- Front
        },
        paramtype2 = "facedir",
        sounds = wood_sounds,
        on_place = function(itemstack, placer, pointed_thing)
            if pointed_thing.type ~= "node" then
                return itemstack
            end

            local dir = vector.subtract(
                pointed_thing.above,
                pointed_thing.under
            )

            local param2

            if dir.y ~= 0 then
                -- Clicked the top or bottom: log stays vertical
                param2 = 0
            elseif dir.x ~= 0 then
                -- Clicked a side facing east/west: log runs along X
                param2 = 12
            else
                -- Clicked a side facing north/south: log runs along Z
                param2 = 8
            end

            return core.item_place_node(
                itemstack,
                placer,
                pointed_thing,
                param2
            )
        end, 
    })

    core.register_node("wood:"..id.."_wood", {
        description = type.." Wood",
        tiles = {
            id.."_log.png", -- texture
        },
        sounds = wood_sounds
    })

    core.register_node("wood:"..id.."_leaves", {
        description = type.." Leaves",
        drawtype = "allfaces_optional",
        tiles = {
            id.."_leaves.png"
        },
        paramtype = "light",
        sunlight_propagates = true,
        groups = {tree=1, leafdecay=1, snappy=3, leaves=1},
        use_texture_alpha = "clip",
        waving = 2
    })
    core.register_alias("natural_blocks:"..id.."_leaves", "wood:"..id.."_leaves")

    core.register_node("wood:"..id.."_planks", {
        description = type.." Planks",
        tiles = {
            id.."_planks.png"
        },
        sounds = wood_sounds
    })
    core.register_craft({
        type = "shapeless",
        output = "wood:"..id.."_planks 4",
        recipe = {"wood:"..id.."_log"}
    })
    core.register_alias("default:"..id.."_planks", "wood:"..id.."_planks")
end
