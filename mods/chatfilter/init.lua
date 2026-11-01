
local mp = core.get_modpath(core.get_current_modname())
local slurlist = {}

local function escape_pattern(text)
    return text:gsub("([^%w])", "%%%1")
end

local function loadSlurlist()
    local file = io.open(mp .. "/en.txt", "r")

    if not file then
        return
    end

    for line in file:lines() do
        line = line:lower():match("^%s*(.-)%s*$")

        if line ~= "" then
            slurlist[#slurlist + 1] = escape_pattern(line)
        end
    end

    file:close()
end

core.register_on_chat_message(function(name, message)
    local lower_message = message:lower()

    for _, slur in ipairs(slurlist) do
        if lower_message:match("%s"..slur..".") then
            core.chat_send_player(name, "<"..name.."> [filtered]")
            return true
        end
    end

    return false
end)

loadSlurlist()
