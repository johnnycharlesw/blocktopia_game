local NORMAL_SPEED = 1.0
local MAX_SPRINT_SPEED = 1.8

local ACCELERATION = 1.0 -- speed multiplier gained per second
local DECELERATION = 2.0 -- speed multiplier lost per second

core.register_globalstep(function(dtime)
    for _, player in ipairs(core.get_connected_players()) do
        local controls = player:get_player_control()
        local current_speed = player._sprint_speed or NORMAL_SPEED

        if controls.aux1 then
            current_speed = math.min(
                current_speed + ACCELERATION * dtime,
                MAX_SPRINT_SPEED
            )
        else
            current_speed = math.max(
                current_speed - DECELERATION * dtime,
                NORMAL_SPEED
            )
        end

        if player._sprint_speed ~= current_speed then
            player:set_physics_override({
                speed = current_speed,
            })

            player._sprint_speed = current_speed
        end
    end
end)
