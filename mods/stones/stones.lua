stone_sounds = {
    dig = {
        name = "stones_stone_break",
        gain = 0.5,
    },
    place = {
        name = "stones_stone_break",
        gain = 0.95
    }

}


core.register_node("stones:stone", {
    description = "Stone Block",
    tiles = {"stone.png"},
    sounds = stone_sounds
})
core.register_node("stones:cobblestone", {
    description = "Cobblestone",
    tiles = {"cobblestone.png"},
    sounds = stone_sounds
})
core.register_node("stones:mossy_cobblestone", {
    description = "Mossy Cobblestone",
    tiles = {"mossy_cobblestone.png"},
    sounds = stone_sounds
})
core.register_node("stones:obsidian", {
    description = "Obsidian",
    tiles = {"obsidian.png"},
    sounds = stone_sounds
})
core.register_node("stones:bedrock", {
    description = "Bedrock",
    tiles = {"bedrock.png"},
    groups = {unbreakable = 1},
    sounds = stone_sounds
})
