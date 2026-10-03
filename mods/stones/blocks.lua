orenames = {"Diamond", 'Emerald', 'Coal', 'Gold', 'Lapis', 'Netherite'}

function get_oreid(name)
    lowered = string.lower(name)
    sanitized = string.gsub(lowered, ' ', '_')
    return sanitized.."_block"
end

function register_ore(name)
    core.register_node('stones:'..get_oreid(name), {
        description = name.." Block",
        tiles = {get_oreid(name)..".png"}
    })
end

for index, orename in ipairs(orenames) do
    register_ore(orename)
end