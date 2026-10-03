local function oven_formspec()
    return table.concat({
        "size[8,8]",
        "label[2.8,0.2;Conventional Oven]",
        "list[context;src;2.5,1;1,1;]",
        "list[context;fuel;2.5,3;1,1;]",
        "list[context;dst;5,2;1,1;]",
        "list[current_player;main;0,4;8,4;]",
        "listring[context;src]",
        "listring[context;fuel]",
        "listring[context;dst]",
    })
end

local function update_oven(pos)
    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()

    local source = inv:get_stack("src", 1)
    local fuel = inv:get_stack("fuel", 1)
    local output = inv:get_stack("dst", 1)

    local cooking = core.get_craft_result({
        method = "cooking",
        width = 1,
        items = { source },
    })

    local fuel_result = core.get_craft_result({
        method = "fuel",
        width = 1,
        items = { fuel },
    })

    local has_recipe = cooking.item and not cooking.item:is_empty()
    local has_fuel = fuel_result.time and fuel_result.time > 0
    local can_accept = output:is_empty()
        or output:get_name() == cooking.item:get_name()

    if not has_recipe or not has_fuel or not can_accept then
        meta:set_int("oven_active", 0)
        core.get_node_timer(pos):stop()
        return
    end

    meta:set_int("oven_active", 1)

    if meta:get_float("fuel_time") <= 0 then
        meta:set_float("fuel_time", fuel_result.time)
        meta:set_float("fuel_total", fuel_result.time)

        fuel:take_item(1)
        inv:set_stack("fuel", 1, fuel)
    end

    core.get_node_timer(pos):start(1)
end

local function oven_on_timer(pos, elapsed)
    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()

    local source = inv:get_stack("src", 1)
    local output = inv:get_stack("dst", 1)

    local cooking = core.get_craft_result({
        method = "cooking",
        width = 1,
        items = { source },
    })

    if not cooking.item or cooking.item:is_empty() then
        update_oven(pos)
        return false
    end

    local fuel_time = meta:get_float("fuel_time") - elapsed
    meta:set_float("fuel_time", fuel_time)

    if fuel_time <= 0 then
        source:take_item(1)
        inv:set_stack("src", 1, source)

        if output:is_empty() then
            inv:set_stack("dst", 1, cooking.item)
        else
            output:set_count(output:get_count() + cooking.item:get_count())
            inv:set_stack("dst", 1, output)
        end

        meta:set_float("fuel_time", 0)
        meta:set_float("fuel_total", 0)
    end

    update_oven(pos)
    return true
end

core.register_node("workbenches:oven", {
    description = "Conventional Oven",

    tiles = {
        "graysquare.png",
        "graysquare.png",
        "graysquare.png",
        "graysquare.png",
        "graysquare.png",
        "furnace_front.png",
    },

    groups = {
        cracky = 2,
    },

    paramtype2 = "facedir",

    on_construct = function(pos)
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()

        inv:set_size("src", 1)
        inv:set_size("fuel", 1)
        inv:set_size("dst", 1)

        meta:set_string("formspec", oven_formspec())
        meta:set_string("infotext", "Conventional Oven")
    end,

    on_rightclick = function(pos, node, clicker)
        local meta = core.get_meta(pos)
        local formspec = meta:get_string("formspec")

        core.show_formspec(
            clicker:get_player_name(),
            "workbenches:oven",
            formspec
        )
    end,
    

    on_timer = oven_on_timer,

    allow_metadata_inventory_put = function(pos, listname, index, stack)
        if listname == "dst" then
            return 0
        end

        return stack:get_count()
    end,

    allow_metadata_inventory_move = function(pos, from_list, from_index, to_list)
        if to_list == "dst" then
            return 0
        end

        return 1
    end,

    on_metadata_inventory_put = update_oven,
    on_metadata_inventory_take = update_oven,
    on_metadata_inventory_move = update_oven,
})

core.register_craft({
    output = "workbenches:oven",
    -- A 3x3 recipe which needs 3 stone in the 1st row,
    -- and 1 stick in the horizontal middle in each of the 2nd and 3nd row.
    -- The 4 remaining slots have to be empty.
    recipe = {
        {"stones:cobblestone", "stones:cobblestone", "stones:cobblestone"}, -- row 1
        {"stones:cobblestone",  "", "stones:cobblestone"}, -- row 2
        {"stones:cobblestone",  "stones:cobblestone", "stones:cobblestone"}, -- row 3
    --   ^ column 1       ^ column 2       ^ column 3
    },
    -- There is no replacements table, so every input item
    -- will be consumed.
})