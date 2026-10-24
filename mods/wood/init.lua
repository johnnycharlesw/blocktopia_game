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

core.register_alias("wood:oak_log", "natural_blocks:oak_log")
core.register_node("wood:oak_planks", {
    description = "Oak Planks",
    tiles = {
        "oak_planks.png"
    },
    sounds = wood_sounds
})
core.register_craft({
    type = "shapeless",
    output = "wood:oak_planks 4",
    recipe = {"natural_blocks:oak_log"}
})
core.register_alias("default:oak_planks", "wood:oak_planks")