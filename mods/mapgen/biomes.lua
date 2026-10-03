core.register_biome({
    name = "grasslands",
    node_top = "natural_blocks:grass",
    depth_top = 1,
    node_filler = "natural_blocks:dirt",
    depth_filler = 3,
    y_max = 5000,
    y_min = -32767,
    heat_point = 70,
    humidity_point = 50,
})

core.register_biome({ -- Decide when trees should and should not generate 
    name = "forest",
    node_top = "natural_blocks:grass",
    depth_top = 1,
    node_filler = "natural_blocks:dirt",
    depth_filler = 3,
    y_max = 5000,
    y_min = -32767,
    heat_point = 50,
    humidity_point = 50,
})


core.register_biome({
    name = "snowy_mountains",
    node_top = "natural_blocks:grass",
    depth_top = 1,
    node_filler = "stones:stone",
    depth_filler = 3,
    y_max = 10000,
    y_min = 5000,
    heat_point = 40,
    humidity_point = 50,
})

core.register_biome({
    name = "outer_space",
    node_top = "stones:cobblestone",
    depth_top = 1,
    node_filler = "stones:stone",
    depth_filler = 3,
    y_max = 32767,
    y_min = 10000,
    heat_point = 20,
    humidity_point = 50,
})
