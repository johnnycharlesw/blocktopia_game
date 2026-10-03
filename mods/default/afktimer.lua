-- afktimer.lua

local afk_timeout = 30 * 60 -- 30 minutes

local last_activity = {}

local function reset(player)
    last_activity[player:get_player_name()] = os.time()
end

local function is_afk(player)
    local name = player:get_player_name()
    local last = last_activity[name]

    if not last then
        return false
    end

    return os.time() - last >= afk_timeout
end

core.register_on_joinplayer(function(player)
    reset(player)
end)

core.register_on_leaveplayer(function(player)
    last_activity[player:get_player_name()] = nil
end)

local function is_exempt(player)
    local expires = tonumber(
        player:get_attribute("beds:timeout_expires")
    ) or 0

    return os.time() < expires
end

-- Expose the functions to the calling mod.
return {
    reset = reset,
    is_afk = is_afk,
    is_exempt = is_exempt
}