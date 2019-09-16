local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

ws_basic = {}
ws_basic.onlineplayers = {}
ws_basic.fire_start = function()
    local neigh = {{x=pos.x+1,y=pos.y,z=pos.z},{x=pos.x-1,y=pos.y,z=pos.z},{x=pos.x,y=pos.y,z=pos.z+1},{x=pos.x,y=pos.y,z=pos.z-1},
                  {x=pos.x+1,y=pos.y,z=pos.z+1},{x=pos.x-1,y=pos.y,z=pos.z-1},{x=pos.x+1,y=pos.y,z=pos.z-1},{x=pos.x-1,y=pos.y,z=pos.z+1}}
    for k,v in ipairs(neigh)do 
    end
end
ws_basic.rand = function(x)
    math.randomseed(os.time())
   x= math.random(x);   
   x= math.random(x);   
   x= math.random(x);  
   x= math.random(x);
return x
end

minetest.register_on_punchnode(function(pos,node,puncher, pointed_thing)
    if(node.name == "ws_core:dirt_dry" or node.name == "ws_core:gravel")then
        if(puncher:get_wielded_item():get_name() == "ws_basic:sift_hand")then
        local metan = minetest.get_meta(pos)
        metan:set_int("sift_step",metan:get_int("sift_step") + 1)
        --minetest.chat_send_all(metan:get_int("sift_step"))
        minetest.add_particlespawner({
            amount = 8,
            time = 1,
            minpos = {x=pos.x-0.5, y=pos.y, z=pos.z-0.5},
            maxpos = {x=pos.x+0.5, y=pos.y+0.5, z=pos.z+0.5},
            minvel = {x=0, y=0.2, z=0},
            maxvel = {x=0, y=0.4, z=0},
            maxacc = {x=0.1, y=0.2, z=0.1},
            minacc = {x=0, y=0, z=0},
            minexptime = 1,
            maxexptime = 1,
            minsize = 1,
            maxsize = 1,
        
            collisiondetection = false,
            collision_removal = false,
            attached = ObjectRef,
            vertical = false,
            texture = "hole_small.png",
            glow = 0
        })
        if(node.name == "ws_core:dirt_dry" and metan:get_int("sift_step") >= 16)then
           minetest.remove_node(pos)
           math.randomseed(os.time())
           math.random(); math.random(); math.random()
           if(math.random(10) >= 9)then
           minetest.add_item(pos,{name="ws_basic:seeds_u", count = 1})
           else end
            metan:set_int("sift_step", 0)
           -- puncher:set_wielded_item({name = "ws_core:stick", count = 1})
        elseif(node.name == "ws_core:gravel" and metan:get_int("sift_step") >= 16)then
            minetest.remove_node(pos)
            math.randomseed(os.time())
            math.random(); math.random(); math.random()
            if(math.random(10) >= 3) then
            minetest.add_item(pos,{name="ws_core:flint", count = 1})
            else end
             metan:set_int("sift_step", 0)
             puncher:set_wielded_item({name = "ws_core:stick", count = 2})
        end
        end 
        
    elseif(node.name == "ws_core:dead_tree" or node.name == "ws_core:wood")then
        if(puncher:get_wielded_item():get_name() == "ws_core:knife_flint")then
            local metan = minetest.get_meta(pos)
        metan:set_int("chop_step",metan:get_int("chop_step") + 1)
        --minetest.chat_send_all(metan:get_int("chop_step"))
        minetest.add_particlespawner({
            amount = 8,
            time = 1,
            minpos = {x=pos.x-0.5, y=pos.y, z=pos.z-0.5},
            maxpos = {x=pos.x+0.5, y=pos.y+0.5, z=pos.z+0.5},
            minvel = {x=0, y=0.2, z=0},
            maxvel = {x=0, y=0.4, z=0},
            maxacc = {x=0.1, y=0.2, z=0.1},
            minacc = {x=0, y=0, z=0},
            minexptime = 1,
            maxexptime = 1,
            minsize = 1,
            maxsize = 1,
        
            collisiondetection = false,
            collision_removal = false,
            attached = ObjectRef,
            vertical = false,
            texture = "hole_small.png",
            playername = "singleplayer",
            glow = 0
        })
        if(metan:get_int("chop_step") >= 16)then
            minetest.remove_node(pos)
            if(node.name == "ws_core:dead_tree")then
            minetest.add_item(pos,{name="ws_core:wood", count = 1})
            puncher:get_wielded_item():add_wear(40)
            elseif(node.name == "ws_core:wood") then
                minetest.add_item(pos,{name="ws_core:stick", count = 4})
            puncher:get_wielded_item():add_wear(40)
            end
        end
    end
    

end

end)
--[[ws_basic.hatpick_sapling = function()
    math.random(); math.random(); math.random()
    local num = math.random(135)
    local s = ""
    if(num >=1 and num <=8 )then
        s = "food_expansion:sapling_almond"
    elseif(num >=9 and num <=21 )then
        s = "food_expansion:sapling_dragonfruit"
    elseif(num >=22 and num <=30 )then
        s = "food_expansion:sapling_peach"
    elseif(num >=31 and num <= 35) then
        s = "food_expansion:sapling_pear"
    elseif(num >=36 and num <=40 )then
        s = "food_expansion:sapling_pomegranate"
    elseif(num >=41 and num <=50 )then
        s = "food_expansion:sapling_persimmon"
    elseif(num >=51 and num <=59 )then
        s = "food_expansion:sapling_date"
    elseif(num >=60 and num <= 65) then
        s = "food_expansion:sapling_fig"
    elseif(num >=66 and num <=78 )then
        s = "food_expansion:sapling_orange"
    elseif(num >=79 and num <=89 )then
        s = "food_expansion:sapling_breadfruit"
    elseif(num >=90 and num <=100 )then
        s = "food_expansion:sapling_cashew"
    elseif(num >=101 and num <= 135) then
        s = "food_expansion:sapling_banana"
    end
    return s
end]]

--ITEMS
--[[minetest.register_craft(
    {output = 'ws_core:flint_knife',
    recipe = {
        {'default:cobble', 'default:cobble', 'default:cobble'},
        {'', 'default:stick', ''},
        {'', 'default:stick', ''}, -- Also groups; e.g. 'group:crumbly'
    },})]]







--NODES
minetest.register_node("ws_basic:seedling",{
    description = "Seedling",
    drawtype = "nodebox",
    paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.48750, 0.5}, -- NodeBox2
		}
    },
    tiles = {"seeds.png"},
    groups = {oddly_breakable_by_hand = 1},
    on_construct = function(pos)
        minetest.after(4, function()minetest.remove_node(pos);minetest.set_node(pos,{name = "food_expansion:sapling_orange"})end)
    end,
    groups = {oddly_breakable_by_hand = 1}
})
minetest.register_node("ws_basic:rod_wood", {
    description = "Wooden Rod",
	tiles = {
		"ws_barrel.png",
		"ws_barrel.png",
		"ws_barrel.png",
		"ws_barrel.png",
		"ws_barrel.png",
		"ws_barrel.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.5, -0.0625, 0.0625, 0.5, 0.0625}, -- NodeBox4
		}
    },
    groups = {oddly_breakable_by_hand = 1}
})
minetest.register_node("ws_basic:rack", {
    description = "Drying Rack",
	tiles = {
		"ws_barrel.png",
		"ws_barrel.png",
		"ws_barrel.png",
		"ws_barrel.png",
		"ws_barrel.png",
		"ws_barrel.png"
	},
	drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.5, -0.0625, 0.0625, 0.4375, 0.0625}, -- NodeBox4
			{0.4375, 0.4375, -0.5, 0.5, 0.5, 0.5}, -- NodeBox5
			{-0.5, 0.4375, -0.5, -0.4375, 0.5, 0.5}, -- NodeBox6
			{-0.4375, 0.4375, -0.0625, 0.4375, 0.5, 0.0625}, -- NodeBox7
		}
    },
    groups = {oddly_breakable_by_hand = 1}
})
minetest.register_node("ws_basic:rack_extension", {
    description = "Drying Rack Rods",
	tiles = {
		"ws_barrel.png",
		"ws_barrel.png",
		"ws_barrel.png",
		"ws_barrel.png",
		"ws_barrel.png",
		"ws_barrel.png"
	},
	drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.4375, -0.5, -0.4375, 0.5, 0.5}, -- NodeBox8
			{0.4375, 0.4375, -0.5, 0.5, 0.5, 0.5}, -- NodeBox9
		}
    },
    groups = {oddly_breakable_by_hand = 1},
    on_construct = function(pos)
       
    end
})
minetest.register_node("ws_basic:flesh_raw", {
    drawtype = "signlike",

    tiles = {"flesh_raw.png"},

    -- Required: store the rotation in param2
    paramtype2 = "wallmounted",

    selection_box = {
        type = "wallmounted",
    },
    on_construct = function(pos)
        minetest.after(6, function()minetest.set_node(pos, {name = "ws_basic:flesh_dried", param2 = 3})end)
    end,
    on_rightclick = function(pos)
        minetest.remove_node(pos)
    end
})
minetest.register_node("ws_basic:flesh_dried", {
    drawtype = "signlike",

    tiles = {"flesh_dry.png"},

    -- Required: store the rotation in param2
    paramtype2 = "wallmounted",

    selection_box = {
        type = "wallmounted",
    },
    on_rightclick = function(pos)
        minetest.remove_node(pos)
    end
})
minetest.register_node("ws_basic:flame",{
    description = "Flame",
    drawtype = "firelike",
    light_source = 10,
    tiles ={ {name="anim_test.png", animation={
        type = "vertical_frames",
        aspect_w = 16,
        aspect_h = 16,
        length = 3.0,
    },
    {
        type = "sheet_2d",
        frames_w = 5,
        frames_h = 3,
        frame_length = 0.5,
    }},
    walkable = true,
    pointable = false,
    diggable = false,
    on_construct = function(pos)
    
    end
}})
minetest.register_node("ws_basic:trap_fish_basebox", {
    description = "Fish Trap Pot",
	tiles = {
		"ws_barrel.png",
		"ws_barrel.png",
		"ws_barrel.png",
		"ws_barrel.png",
		"ws_barrel.png",
		"ws_barrel.png"
	},
    drawtype = "nodebox",
    paramtype2 = "facedir",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, -0.375, 0.375, 0.5}, -- NodeBox13
			{0.375, -0.5, 0.375, 0.5, 0.375, 0.5}, -- NodeBox14
			{-0.5, -0.5, -0.5, -0.375, 0.375, -0.375}, -- NodeBox15
			{0.375, -0.5, -0.5, 0.5, 0.375, -0.375}, -- NodeBox16
			{-0.375, -0.5, -0.4375, 0.375, 0.125, -0.375}, -- NodeBox17
			{-0.375, -0.5, 0.375, 0.375, 0.125, 0.4375}, -- NodeBox18
			{0.375, -0.5, -0.375, 0.4375, 0.125, 0.375}, -- NodeBox19
			{-0.4375, -0.5, -0.375, -0.375, 0.125, 0.375}, -- NodeBox20
			{0.375, 0.375, -0.4375, 0.4375, 0.4375, -0.375}, -- NodeBox22
			{-0.4375, 0.375, -0.4375, -0.375, 0.4375, -0.375}, -- NodeBox23
			{-0.4375, 0.375, 0.375, -0.375, 0.4375, 0.4375}, -- NodeBox24
			{0.375, 0.375, 0.375, 0.4375, 0.4375, 0.4375}, -- NodeBox25
			{0.3125, 0.4375, -0.375, 0.375, 0.5, 0.375}, -- NodeBox26
			{-0.375, 0.4375, -0.375, -0.3125, 0.5, 0.375}, -- NodeBox27
			{0.1875, 0.4375, -0.375, 0.25, 0.5, 0.375}, -- NodeBox28
			{-0.25, 0.4375, -0.375, -0.1875, 0.5, 0.375}, -- NodeBox29
			{0.0625, 0.4375, -0.375, 0.125, 0.5, 0.375}, -- NodeBox30
			{-0.125, 0.4375, -0.375, -0.0625, 0.5, 0.375}, -- NodeBox31
			{-0.0625, 0.4375, 0, 0.0625, 0.5, 0.0625}, -- NodeBox32
			{0.125, 0.4375, 0, 0.1875, 0.5, 0.0625}, -- NodeBox33
			{0.25, 0.4375, 0, 0.3125, 0.5, 0.0625}, -- NodeBox34
			{-0.3125, 0.4375, 0, -0.25, 0.5, 0.0625}, -- NodeBox35
			{-0.1875, 0.4375, 0, -0.125, 0.5, 0.0625}, -- NodeBox36
		}
    },
    groups = {oddly_breakable_by_hand = 2},
    on_construct = function(pos)
        minetest.set_node({x=pos.x,y=pos.y+2,z=pos.z},{name = "ws_basic:trap_fish_grate"})
    end
})
minetest.register_node("ws_basic:trap_fish_grate", {
    description = "Fish Trap Grate",
	tiles = {
		"ws_barrel.png",
		"ws_barrel.png",
		"ws_barrel.png",
		"ws_barrel.png",
		"ws_barrel.png",
		"ws_barrel.png"
    },
	drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
            {0.4375, -1.5, 0.4375, 0.5, -0.5, 0.5}, -- NodeBox41
			{-0.5, -1.5, 0.4375, -0.4375, -0.5, 0.5}, -- NodeBox42
			{0.3125, -1.5, 0.4375, 0.375, -0.625, 0.5}, -- NodeBox43
			{-0.375, -1.5, 0.4375, -0.3125, -0.625, 0.5}, -- NodeBox44
			{0.1875, -1.5, 0.4375, 0.25, -0.75, 0.5}, -- NodeBox45
			{-0.25, -1.5, 0.4375, -0.1875, -0.75, 0.5}, -- NodeBox46
			{0.0625, -1.5, 0.4375, 0.125, -0.875, 0.5}, -- NodeBox47
			{-0.125, -1.5, 0.4375, -0.0625, -0.875, 0.5}, -- NodeBox48
		}
    },    
    groups = {oddly_breakable_by_hand = 2}
})
minetest.register_node("ws_basic:dirt_sifted",{
    description = "NUUL",
    tiles = {"gui_formbg.png"},
    drawtype = "nodebox",
    leveled = 8,
    groups = {oddly_breakable_by_hand = 1},
    on_punch = function(pos)
    end
})
--PARTICLESPAWNERS
--[[ws_basic.microdig =
{
    amount = 8,
    time = 2,
--  ^ If time is 0 has infinite lifespan and spawns the amount on a
--  ^ per-second basis.
    minpos = {x=pos.x, y=pos.y, z=pos.z},
    maxpos = {x=pos.x, y=pos.y+1, z=pos.z},
    minvel = {x=0, y=0.2, z=0},
    maxvel = {x=0, y=0.4, z=0},
    minacc = {x=0.1, y=0.2, z=0.1},
    maxacc = {x=0, y=0, z=0},
    minexptime = 1,
    maxexptime = 1,
    minsize = 1,
    maxsize = 1,

    collisiondetection = false,
    collision_removal = false,
    attached = ObjectRef,
    vertical = false,
    texture = "hole_small.png",
    playername = "singleplayer",
    glow = 0
}]]
--CRAFTITEM
minetest.register_craftitem("ws_basic:sift_hand",{
    description = "Wooden Hand Sifter",
    wield_image = "tool_sifter_wood.png",
    inventory_image = "tool_sifter_wood.png",
    wear = 40
})
minetest.register_craftitem("ws_basic:seeds_u",{
    description = "Unidentified Seeds",
    wield_image = "seeds.png",
    inventory_image = "seeds.png",
    on_use = function(itemstack,user,pointed_thing)
        minetest.place_node((pointed_thing.above),{name = "ws_basic:seedling"})
        itemstack:take_item()
        return itemstack
    end
})
minetest.register_craftitem("ws_basic:dry_strands",{
    description = "Dry Strands",
    wield_image = "dry_strands.png",
    inventory_image = "dry_strands.png",
})
--RECIPES
minetest.register_craft(
{
    output = 'ws_basic:rod_wood',
    recipe = {
        {"", 'ws_core:stick',""},
        {'', 'ws_core:stick', ''},
        {'', 'ws_core:stick', ''}, 
    },
})
minetest.register_craft(
{
    type = "shapeless",
    output = 'ws_basic:dry_strands',
    recipe = {"ws_core:stick" 
    }
})
minetest.register_craft(
{
    output = 'ws_basic:rack',
    recipe = {
        {"", '',""},
        {'ws_basic:rod_wood', 'ws_core:stick', 'ws_basic:rod_wood'},
        {'', 'ws_basic:rod_wood', ''}, 
    },
})
minetest.register_craft(
{
    output = 'buildings:mat_woven',
    recipe = {
        {"", '',""},
        {'ws_basic:dry_strands', 'ws_basic:dry_strands', 'ws_basic:dry_strands'},
        {'ws_basic:dry_strands', 'ws_basic:dry_strands', 'ws_basic:dry_strands'}, 
    },
})
minetest.register_craft(
{
    output = 'ws_basic:rod_wood',
    recipe = {
        {"", 'ws_core:stick',""},
        {'', 'ws_core:stick', ''},
        {'', 'ws_core:stick', ''}, 
    },
})
minetest.register_craft(
{
    output = 'ws_basic:sift_hand',
    recipe = {
        {"", '',""},
        {'ws_core:stick', 'ws_basic:dry_strands', 'ws_core:stick'},
        {'', 'ws_core_stick', ''}, 
    },
})
minetest.register_craft(
{
    output = 'food_expansion:dirt_culinary_compressed',
    recipe = {
        {"", '',""},
        {'', 'ws_core:dirt', ''},
        {'', '', ''}, 
    }
})