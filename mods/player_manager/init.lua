local mp = core.get_modpath(core.get_current_modname())
local skins = core.get_dir_list(mp .. '/textures', false)

function contains(list, item)
    for _, value in ipairs(list) do
        if value == item then
            return true
        end
    end
    return false
end

core.register_on_joinplayer(function(ObjectRef, last_login)
    core.chat_send_all(ObjectRef:get_player_name() .. " joined the game")
    skins = core.get_dir_list(mp .. '/textures', false)
    if contains(skins, ObjectRef:get_player_name()..".png") then
      texture = ObjectRef:get_player_name()..".png"
    else
      texture = "player.png"
    end
    ObjectRef:set_properties({
        visual      = "mesh",
        mesh        = "player.obj",
        textures    = {texture},
        visual_size = {x=-10, y=10},
    })
    ObjectRef:hud_set_flags({
      hotbar = false,
      wielditem = true,
      minimap = false,
      health=false
    })
end)


core.register_entity("player_manager:npc_builder", {
  initial_properties = {
    visual      = "mesh",
    mesh        = "player.obj",
    textures    = {"npc.png"},
    visual_size = {x=10, y=10},
    physical = true,
    collide_with_objects = true,
    collisionbox = {-0.3, -0.3, -0.3, 0.3, 0.3, 0.3},

    stepheight = 0.6
  },
  on_activate = function (self, staticdata, dtime_s)
    -- This is an old NPC that does not work anymore - respawn it as a new version of the NPC
    local pos = self.object:get_pos()
    local name = "npc:npc"
    local staticdata = self:get_staticdata(self)
    core.add_entity(pos, name, staticdata)
    self.object:remove()
  end,
    get_staticdata = function(self)
    return core.serialize({
      state = self.state,
      reaction_until = self.reaction_until,
      wander_target = self.wander_target,
      last_react_at = self.last_react_at,
      name_ = self.name_
    })
  end,
})

local function place_facing_player(itemstack, placer, pointed_thing)
    local pos = pointed_thing.above

    local dir = vector.direction(pos, placer:get_pos())
    local param2 = core.dir_to_facedir(dir)

    return core.item_place_node(
        itemstack,
        placer,
        pointed_thing,
        param2
    )
end

local skins = core.get_dir_list(mp .. "/textures", false)

for _, skin in ipairs(skins) do
    if skin:lower():match("%.png$") then
        local name = skin:gsub("%.png$", "")
        local node_name = name:lower():gsub("[^a-z0-9_]", "_")

        core.register_node("player_manager:" .. node_name .. "_statue", {
            description = "Statue of " .. name,
            drawtype = "mesh",
            mesh = "player.obj",
            on_place = place_facing_player,
            tiles = {skin},
        })
    end
end
