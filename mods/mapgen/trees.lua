mp = core.get_modpath("mapgen")

minetest.register_decoration({
    deco_type = "schematic",

    -- Nodes on which the tree may be placed
    place_on = {
        "natural_blocks:grass",
    },

    -- Restrict placement to these biomes, if desired
    biomes = {
        "forest"
    },

    -- How often the decoration is attempted
    sidelen = 16,
    fill_ratio = 0.01,

    -- The schematic file inside this mod
    schematic = mp .. "/schematics/tree1.mts",

    -- Center the schematic on the randomly selected location
    flags = "place_center_x, place_center_z",

    -- Allow the tree to face different directions
    rotation = "random",

    -- Optional height limits
    y_min = 0,
    y_max = 31000,
})

minetest.register_decoration({
    deco_type = "schematic",

    -- Nodes on which the tree may be placed
    place_on = {
        "natural_blocks:grass",
    },

    -- Restrict placement to these biomes, if desired
    biomes = {
        "forest"
    },

    -- How often the decoration is attempted
    sidelen = 16,
    fill_ratio = 0.01,

    -- The schematic file inside this mod
    schematic = mp .. "/schematics/tree2.mts",

    -- Center the schematic on the randomly selected location
    flags = "place_center_x, place_center_z",

    -- Allow the tree to face different directions
    rotation = "random",

    -- Optional height limits
    y_min = 0,
    y_max = 31000,
})