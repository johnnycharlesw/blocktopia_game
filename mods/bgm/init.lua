local function get_track_time_duration(hours, minutes, seconds)
    local minutes_ = minutes + hours * 60
    local seconds_ = seconds + minutes_ * 60
    return seconds_
end

local tracks = {
    {
        name = "vicetone_telykast_cozi-zueshsdorff_nevada",
        duration = get_track_time_duration(0, 3, 8),
    },
    {
        name = "oublaire_history-hates-lovers",
        duration = get_track_time_duration(0, 3, 44),
    },
}

local players = {}

local function play_next(player_name)
    local player = core.get_player_by_name(player_name)

    -- Player left the game
    if not player then
        players[player_name] = nil
        return
    end

    local data = players[player_name]

    -- Move to the next song
    data.track = data.track + 1

    if data.track > #tracks then
        data.track = 1
    end

    local song = tracks[data.track]

    data.handle = core.sound_play(song.name, {
        to_player = player_name,
        gain = 1.0,
        loop = false,
    })

    -- Schedule the next song
    data.job = core.after(song.duration, function()
        play_next(player_name)
    end)
end


core.register_on_joinplayer(function(player)
    local name = player:get_player_name()

    players[name] = {
        track = 0,
        handle = nil,
        job = nil,
    }

    play_next(name)
end)


core.register_on_leaveplayer(function(player)
    local name = player:get_player_name()
    local data = players[name]

    if data then
        if data.handle then
            core.sound_stop(data.handle)
        end

        if data.job then
            data.job:cancel()
        end

        players[name] = nil
    end
end)
