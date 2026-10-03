local function fixtime()
    local t = os.date("*t")           -- server local time
    local seconds = t.hour * 3600 + t.min * 60 + t.sec
    local day_fraction = seconds / 86400
    local game_time = math.floor(day_fraction * 24000) % 24000  -- 0..23999

    core.set_timeofday(game_time/24000)
end

core.register_chatcommand("fixtime", {
    privs = { interact = true },
    func = fixtime,
})

core.register_globalstep(fixtime)