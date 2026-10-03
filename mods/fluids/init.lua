core.register_node("fluids:water", {
    description = "Water",
    tiles = {"water.png"},
    drawtype = "liquid",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    pointable = false,
    buildable_to = true,     -- allows placement/doesn’t block
    climbable = false,
    diggable = false,
    groups = {water = 1, liquid = 1, not_in_creative_inventory = 1},
    liquidtype = "source",
    liquid_alternative_flowing = "fluids:water_flowing",
    liquid_alternative_source = "fluids:water",
    liquid_viscosity = 1,
    liquid_range = 8,

})
core.register_node("fluids:water_flowing", {
    description = "Water",
    tiles = {"water.png"},
    drawtype = "liquid",
    paramtype = "light",
    paramtype2 = "flowingliquid",
    sunlight_propagates = true,
    walkable = false,
    pointable = false,
    buildable_to = true,     -- allows placement/doesn’t block
    climbable = false,
    diggable = false,
    liquidtype = "flowing",
    liquid_alternative_flowing = "fluids:water_flowing",
    liquid_alternative_source = "fluids:water",
    liquid_viscosity = 1,
    liquid_range = 8,
    groups = { liquid = 1, water = 1, not_in_creative_inventory = 1},
})
core.register_node("fluids:lava", {
    description = "Lava (yes, I know it should extremely burn, but I'll get to that soon)",
    tiles = {"lava.png"},
    drawtype = "liquid",
    paramtype = "light",
    walkable = false,
    pointable = false,
    buildable_to = true,     -- allows placement/doesn’t block
    climbable = false,
    diggable = false,
    light_source = 12,
    groups = {lava=1, liquid=1, not_in_creative_inventory = 1},
    liquidtype = "source",
    liquid_alternative_flowing = "fluids:lava_flowing",
    liquid_alternative_source = "fluids:lava",
    liquid_viscosity = 7,
    liquid_range = 8,
})

core.register_node("fluids:lava_flowing", {
    description = "Lava (yes, I know it should extremely burn, but I'll get to that soon)",
    tiles = {"lava.png"},
    drawtype = "liquid",
    paramtype = "light",
    paramtype2 = "flowingliquid",
    walkable = false,
    pointable = false,
    buildable_to = true,     -- allows placement/doesn’t block
    climbable = false,
    diggable = false,
    light_source = 12,
    groups = {lava=1, liquid=1, not_in_creative_inventory = 1},
    liquidtype = "flowing",
    liquid_alternative_flowing = "fluids:lava_flowing",
    liquid_alternative_source = "fluids:lava",
    liquid_viscosity = 7,
    liquid_range = 8,
})

core.register_abm({
    label = "Water turns lava source into obsidian",
    nodenames = {
        "fluids:lava",
        "fluids:lava_flowing",
    },
    neighbors = {
        "fluids:water",
        "fluids:water_flowing",
    },
    interval = 1,
    chance = 1,

    action = function(pos)
        core.set_node(pos, {
            name = "stones:obsidian",
        })
    end,
})


core.register_alias("default:water", "fluids:water")
core.register_alias("default:lava", "fluids:lava")


