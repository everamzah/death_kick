local die = {}

minetest.register_on_joinplayer(function(player)
	die[player:get_player_name()] = 0
end)

minetest.register_on_leaveplayer(function(player)
	die[player:get_player_name()] = nil
end)

minetest.register_on_dieplayer(function(player)
	local name = player:get_player_name()
	if not die[name] then
		die[name] = 0
	end
	die[name] = die[name] + 1
	if die[name] == 5 then
		minetest.kick_player(name, "You died.")
	end
	minetest.after(10, function()
		if not player then
			return
		end
		if player:get_hp() == 0 then
			player:set_hp(player:get_hp() - 20)
		end
	end, player)
end)

minetest.register_on_respawnplayer(function(player)
	die[player:get_player_name()] = 0
end)
