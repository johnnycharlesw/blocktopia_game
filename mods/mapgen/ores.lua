function register_ore(name, scarcity_factor)
    if not core.registered_nodes[name] then
        return
    end
    core.register_ore({
        ore_type = "scatter",

        ore = name,

        y_min = -31099,
        y_max = 31000,
        wherein = "stones:stone",


        clust_scarcity = scarcity_factor*scarcity_factor*scarcity_factor,
        clust_num_ores = 3,
        clust_size = 3,
    })
end

register_ore("stones:diamond_ore", 50)
register_ore("stones:coal_ore", 8)
register_ore("stones:copper_ore", 10)
register_ore("stones:emerald_ore", 20)