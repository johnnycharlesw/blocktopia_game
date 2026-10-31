local function get_track_time_duration(hours, minutes, seconds)
    local minutes_ = minutes + hours * 60
    local seconds_ = seconds + minutes_ * 60
    return seconds_
end

local tracks = {
    {
        name = "focuspup824_dog",
        title = "FocusPup824 - dog",
        duration = get_track_time_duration(0, 0, 33),
    },
    {
        name = "focuspup824_pause",
        title = "FocusPup824 - pause",
        duration = get_track_time_duration(0, 0, 8),
    },
    {
        name = "focuspup824_shop",
        title = "FocusPup824 - shop",
        duration = get_track_time_duration(0, 0, 32),
    },
    -- {
    --     name = "oublaire_history-hates-lovers",
    --     title = "Oublaire - History Hates Lovers",
    --     duration = get_track_time_duration(0, 3, 44),
    -- },
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
    if not data.nobgm then
        core.chat_send_player(player_name, "Now playing: "..song.title)
        data.handle = core.sound_play(song.name, {
            to_player = player_name,
            gain = 1.0,
            loop = false,
        })
    end

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
        nobgm = false
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

core.register_chatcommand("togglebgm", {
    params = "",
    description = "Toggle the bgm",
    privs = {},

    func = function(name)
        local data = players[name]
        if data.nobgm then
            core.chat_send_all("BGM will play for "..name)
            data.nobgm = false
            data.job:cancel()
            play_next(name)
        else
            core.chat_send_all("BGM won't play for "..name)
            if data.handle then
                core.sound_stop(data.handle)
            end
            data.job:cancel()
            data.nobgm = true
        end
    end,
})