colors = {"Black", "Blue", "Brown", "Cyan", "Gray", "Green", "Light Blue", "Light Gray", "Lime", "Magenta", "Orange", "Pink", "Purple", "Red", "White", "Yellow"}
function on_rightclick_bed(pos, node, player)
    local name = player:get_player_name()

    core.log("[" .. name .. "] Zzzz...")

    player:set_attribute("beds:respawn_pos", core.pos_to_string(pos))
    player:set_attribute(
        "beds:timeout_expires",
        tostring(os.time() + 8 * 60 * 60)
    )
end




function generate_id_from_color (color)
    local id = string.lower(color)
    id = string.gsub(id, " ", "_")
    return id
end

function register_bed(color)
    core.register_node("beds:"..generate_id_from_color(color), {
        description = color.." Bed",

        drawtype = "mesh",
        mesh = "bed_fixed.obj",

        tiles = {generate_id_from_color(color)..".png"},

        paramtype = "light",
        paramtype2 = "facedir",

        groups = {
            choppy = 2,
            oddly_breakable_by_hand = 2,
        },

        selection_box = {
            type = "fixed",
            fixed = {
                -0.5, -0.5, -1.0,
                0.5,  0.0625,  1.0
            },
        },

        collision_box = {
            type = "fixed",
            fixed = {
                -0.5, -0.5, -1.0,
                0.5,  0.0625,  1.0
            },
        },
        on_rightclick = on_rightclick_bed,
    })

end

for index, color in ipairs(colors) do
    register_bed(color)
end