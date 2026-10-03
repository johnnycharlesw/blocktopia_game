local mp = core.get_modpath("default")
afktimer = dofile(mp .. '/afktimer.lua')
local function check_afk(player)
    if afktimer.is_afk(player) and not afktimer.is_exempt(player) then
        return true
    else
        return false
    end
end

local function check_afk_for_everyone()
    local players = core.get_connected_players()
    for index, player in ipairs(players) do
        if check_afk(player) then
            core.disconnect_player(player:get_player_name(), "It appears you were AFK and not sleeping, going AFK to farm rewards is not allowed.", true)
        end
    end
end

core.register_globalstep(check_afk_for_everyone)