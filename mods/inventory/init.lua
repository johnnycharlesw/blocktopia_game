local function inv_formspec(player)
    local name = player:get_player_name()
    return table.concat({
        "size[8,7.5]",
		"label[0.3,0.2;Pockets]",
        "model[1,0.6;1,2;Player Character;player.obj;player.png]",
        "list[current_player;main;0,3.5;8,4;]",
        "list[current_player;craft;4,0.5;2,2;]",
        "list[current_player;craftpreview;7,1;1,1;]"
    })
end

core.register_on_joinplayer(function(ObjectRef, last_login)
    ObjectRef:set_inventory_formspec(inv_formspec(ObjectRef))
end)