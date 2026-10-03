orenames = {"Diamond", "Coal", "Copper", "Emerald"}

function get_oreid(name)
    lowered = string.lower(name)
    sanitized = string.gsub(lowered, ' ', '_')
    return sanitized
end

function register_ore(name)
    id = get_oreid(name)
    core.register_node('stones:'..id..'_ore', {
        description = name.." Ore",
        tiles = {id.."_ore.png"}
    })
    core.register_alias('default:stone_with_'..id, 'stones:'..id..'_ore')
end

for index, orename in ipairs(orenames) do
    register_ore(orename)
end