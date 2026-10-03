local function place_facing_player(itemstack, placer, pointed_thing)
    local pos = pointed_thing.above

    local dir = vector.direction(pos, placer:get_pos())
    local param2 = core.dir_to_facedir(dir)

    return core.item_place_node(
        itemstack,
        placer,
        pointed_thing,
        param2
    )
end

local function on_construct_chest(pos)
    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()

    inv:set_size("main", 27)
end


local function on_rightclick_chest(pos, node, player)
    local name = player:get_player_name()

    local formspec = string.format([[
        formspec_version[4]
        size[12,9]

        label[0.5,0.35;Chest]

        list[nodemeta:%d,%d,%d;main;0.5,0.8;9,3;]

        label[0.5,4.7;Inventory]

        list[current_player;main;0.5,5;9,3;]

        listring[nodemeta:%d,%d,%d;main]
        listring[current_player;main]
    ]],
        pos.x, pos.y, pos.z,
        pos.x, pos.y, pos.z
    )

    core.show_formspec(name, "workbenches:chest", formspec)
end

core.register_node("workbenches:chest", {
    description = "Chest",
    drawtype = "mesh",
    mesh = "chest_fixed.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    tiles = {"chest.png"},
    on_rightclick = on_rightclick_chest,
    on_place = place_facing_player,
    on_construct = on_construct_chest,
    on_destruct = function(pos)
        local inv = core.get_meta(pos):get_inventory()
        local drops = inv:get_list("main")

        for _, stack in ipairs(drops) do
            if not stack:is_empty() then
                core.add_item(pos, stack)
            end
        end
    end,
})

core.register_craft({
    output = "workbenches:chest",
    -- A 3x3 recipe which needs 3 stone in the 1st row,
    -- and 1 stick in the horizontal middle in each of the 2nd and 3nd row.
    -- The 4 remaining slots have to be empty.
    recipe = {
        {"wood:oak_planks", "wood:oak_planks", "wood:oak_planks"}, -- row 1
        {"wood:oak_planks",  "", "wood:oak_planks"}, -- row 2
        {"wood:oak_planks",  "wood:oak_planks", "wood:oak_planks"}, -- row 3
    --   ^ column 1       ^ column 2       ^ column 3
    },
    -- There is no replacements table, so every input item
    -- will be consumed.
})