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
core.register_alias("default:oak_log", "wood:oak_log")
core.register_alias("default:oak_leaves", "wood:oak_leaves")
