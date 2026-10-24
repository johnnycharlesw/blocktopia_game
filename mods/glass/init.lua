glass_sounds = {
    footstep = {
        name = "stones_stone_break",
        gain = 0.25,
    },
    dig = {
        name = "glass_break",
        gain = 0.5,
    },
    place = {
        name = "stones_stone_break",
        gain = 0.95
    }

}

core.register_node("glass:glass", {
    description="Glass",
    tiles = {"glass.png"},
    drawtype = "glasslike",
    use_texture_alpha = true,
    sounds = glass_sounds
})