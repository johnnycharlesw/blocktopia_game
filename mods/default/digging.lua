local digging = {}

local function pos_key(pos)
    return pos.x .. "," .. pos.y .. "," .. pos.z
end

local function stop_digging(name)
    digging[name] = nil
end

local function play_node_dig_sound(pos, node)
    local def = core.registered_nodes[node.name]
    if not def or not def.sounds or not def.sounds.dig then
        return
    end

    local sound = def.sounds.dig

    core.sound_play(sound.name, {
         pos = pos,
        gain = sound.gain or 1.0,
         max_hear_distance = 16,
     })

end

local function play_node_dug_sound(pos, node)
    local def = core.registered_nodes[node.name]

    if not def or not def.sounds or not def.sounds.dug then
        return
    end

    core.sound_play(def.sounds.dug, {
        pos = pos,
        max_hear_distance = 16,
    })
end


local function dig_node(pos, node, player)
    -- Remove the node first.
    core.remove_node(pos)
    play_node_dug_sound(pos, node)
    -- Get the node's normal drops.
    local drops = core.get_node_drops(node.name, player:get_wielded_item())

    -- Drop everything into the world.
    for _, item in ipairs(drops) do
        core.add_item(pos, item)
    end
end

core.register_on_leaveplayer(function(player)
    stop_digging(player:get_player_name())
end)

core.register_on_punchnode(function(pos, node, puncher, pointed_thing)
    local name = puncher:get_player_name()

    if core.get_item_group(node.name, "unbreakable") == 1 then
        stop_digging(name)
        return
    end
    play_node_dig_sound(pos, node)

    local key = pos_key(pos)

    if not digging[name] or digging[name].key ~= key then
        digging[name] = {
            key = key,
            pos = vector.copy(pos),
            node = node,
            progress = 0,
            dig_time = 1.0,
        }
        
    end
end)

core.register_globalstep(function(dtime)
    for name, state in pairs(digging) do
        local player = core.get_player_by_name(name)

        if not player then
            digging[name] = nil
        else
            local node = core.get_node(state.pos)

            if node.name ~= state.node.name then
                digging[name] = nil
            else
                local controls = player:get_player_control()

                if not controls.dig then
                    digging[name] = nil
                else
                    state.progress = state.progress + dtime / state.dig_time

                    if state.progress >= 1 or core.is_creative_enabled(player:get_player_name()) then
                        dig_node(state.pos, state.node, player)
                        digging[name] = nil
                    end
                end
            end
        end
    end
end)

-- core.register_on_punchnode(function(pos, node, puncher, pointed_thing)
--     diggable = true
--     prop_unbreakable = core.get_item_group(node.name, "unbreakable") or false
--     if prop_unbreakable == 1 then
--         diggable = false
--     else
--         diggable = true
--     end
--     if diggable then
--         core.dig_node(pos)
--     end
-- end)