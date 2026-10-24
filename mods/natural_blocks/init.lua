mp = core.get_modpath('natural_blocks')
dirt_sounds = {
    footstep = {
        name = "natural_blocks_grass_step",
        gain = 0.25,
    },
    dig = {
        name = "natural_blocks_grass_dig",
        gain = 0.5,
    },
    place = {
        name = "natural_blocks_grass_step",
        gain = 0.95
    }

}

core.register_node("natural_blocks:grass", {
    description = "Grass Block",
    tiles = {"grass_block_top.png"},
    sounds = dirt_sounds, 
    drop = "natural_blocks:dirt"
})
core.register_node("natural_blocks:dirt", {
    description = "Dirt Block",
    tiles = {"dirt.png"},
    sounds = dirt_sounds
})

core.register_node("natural_blocks:oak_log", {
    description = "Oak Log",
    tiles = {
        "oak_log_top.png", -- Top
        "oak_log_top.png", -- Bottom
        "oak_log.png", -- Right
        "oak_log.png", -- Left
        "oak_log.png", -- Back
        "oak_log.png" -- Front
    },
    sounds = wood_sounds
})

core.register_node("natural_blocks:dark_oak_log", {
    description = "Dark Oak Log",
    tiles = {
        "dark_oak_log_top.png", -- Top
        "dark_oak_log_top.png", -- Bottom
        "dark_oak_log.png", -- Right
        "dark_oak_log.png", -- Left
        "dark_oak_log.png", -- Back
        "dark_oak_log.png" -- Front
    },
    sounds = wood_sounds
})

core.register_node("natural_blocks:oak_leaves", {
    description = "Oak Leaves",
    drawtype = "allfaces_optional",
    tiles = {
        "oak_leaves.png"
    },
    paramtype = "light",
    sunlight_propagates = true,
    groups = {tree=1, leafdecay=1, snappy=3, leaves=1},
    use_texture_alpha = true
})
core.register_craft({
    type = "shapeless",
    output = "natural_blocks:grass 1",
    recipe = {
        "natural_blocks:dirt"
    }
})

dofile(mp .. '/grass_spreading.lua')

core.register_alias("default:grass", "natural_blocks:grass")
core.register_alias("default:dirt", "natural_blocks:dirt")
core.register_alias("default:oak_log", "natural_blocks:oak_log")
core.register_alias("default:oak_leaves", "natural_blocks:oak_leaves")
