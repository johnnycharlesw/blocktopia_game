core.register_node("default:air", {
  description = "Air",
  drawtype = "airlike",     -- tell engine this is an airlike node
  paramtype = "light",     -- (common for airlike-type visuals)
  sunlight_propagates = true,
  walkable = false,
  pointable = false,
  buildable_to = true,     -- allows placement/doesn’t block
  climbable = false,
  diggable = false,
  groups = { not_in_creative_inventory = 1, unbreakable = 1 },
})

core.register_lbm({
    label = "Give planet Blocktopia an atmosphere",
    name = "default:atmospheregen",
    nodenames = {"air"},
    run_at_every_load = true,
    action = function(pos)
        if pos.y <= 10000 then
            core.set_node(pos, {name = "default:air"})
        end
    end,

})

core.register_lbm({
    label = "Cut off that atmosphere eventually",
    name = "default:atmosphere_cutoff",
    nodenames = {"default:air"},
    run_at_every_load = true,
    action = function(pos)
        if pos.y > 10000 then
            core.set_node(pos, {name = "air"})
        end
    end,

})


core.register_on_dignode(function(pos, oldnode, digger)
    if pos.y <= 10000 then
        core.set_node(pos, {name = "default:air"})
    end
end)