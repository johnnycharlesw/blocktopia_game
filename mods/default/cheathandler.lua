local function get_ground_y(pos)
    local x = math.floor(pos.x + 0.5)
    local z = math.floor(pos.z + 0.5)

    for y = math.floor(pos.y), -31000, -1 do
        local node = core.get_node({x = x, y = y, z = z})

        if node.name ~= "air" and node.name ~= "default:air" then
            return y
        end
    end

    return nil
end

core.register_on_cheat(function(ObjectRef, cheat)
    local name = ObjectRef:get_player_name()
    if cheat.type == "moved_too_fast" then
        local privs = core.get_player_privs(name)

        if privs.fly then
            return
        end

        pos = ObjectRef:get_pos()
        ground_y = get_ground_y(pos)
        if ground_y and pos.y - ground_y <= 10 then
            return
        end
        core.kick_player(name, "Please disable your flying mod, then try reconnecting.", false)
        return
    end
    core.kick_player(name, "The server admin did not allow you to be doing "..cheat.type)
end)