core.register_chatcommand("me", {
    params = "<action>",
    description = "Perform an action",
    privs = {},

    func = function(name, param)
        if param == "" then
            return false, "You need to describe an action."
        end

        core.chat_send_all("* " .. name .. " " .. param)
        return true
    end,
})

core.register_chatcommand("say", {
    params = "<message>",
    description = "Say something (unverified, use actual chat)",
    privs = {},

    func = function(name, param)
        if param == "" then
            return false, "Say something."
        end

        core.chat_send_all("[" .. name .. "] " .. param)
        return true
    end,
})

-- core.register_chatcommand("playsound", {
--     params = "[sound] [category]",
--     description = "Play a sound.",

--     func = function(name, param)
--         -- Parse parameters here
--     end,
-- })
