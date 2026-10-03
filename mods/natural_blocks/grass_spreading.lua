core.register_abm({
    label = "Grass spreads",
    nodenames = {
        "natural_blocks:dirt"
    },
    neighbors = {
        "natural_blocks:grass",
        "default:air"
    },
    interval = 1,
    chance = 5,
    action = function (pos)
        local pos_above = {
            x = pos.x,
            y = pos.y + 1,
            z = pos.z,
        }
        pos_above.y = pos.y + 1
        node_above = core.get_node(pos_above)
        core.get_node(pos)
        nodeid_above = node_above.name
        if nodeid_above == "default:air" then
            core.set_node(pos, {
                name = "natural_blocks:grass"
            })
        else
        end
    end
})

core.register_abm({
     label = "Grass gets removed",
     nodenames = {
         "natural_blocks:grass"
     },
     neighbors = {
         "default:air"
     },
     interval = 1,
     chance =  1,
     action = function (pos)
         local pos_above = {
             x = pos.x,
             y = pos.y + 1,
             z = pos.z,
         }

         pos_above.y = pos.y + 1
         node_above = core.get_node(pos_above)
         core.get_node(pos)
         nodeid_above = node_above.name
         if nodeid_above ~= "default:air" and nodeid_above ~= "air" then
             core.set_node(pos, {
                 name = "natural_blocks:dirt"
             })
         end
     end
 })

