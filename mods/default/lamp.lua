core.register_node("default:lamp", {
    paramtype = "light",
    paramtype2="none",
    description = "Lamp (on)",
    walkable = true,
    sunlight_propagates = true,

    light_source = 12, 
    tiles = {
        "redstone_lamp_on.png" -- Torch
    }
})
core.register_alias("default:redstone_torch", "default:lamp")
