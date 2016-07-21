local death_kick = {}

minetest.register_on_joinplayer(function(player)
	death_kick[player:get_player_name()] = 0
end)

minetest.register_on_leaveplayer(function(player)
	death_kick[player:get_player_name()] = nil
end)

minetest.register_on_dieplayer(function(player)
	minetest.after(10, function()
		if (not player) or player:get_hp() ~= 0 then
			return false
		else
			player:set_hp(player:get_hp() - 1)
		end

		local name = player:get_player_name()
		if not death_kick[name] then
			death_kick[name] = 1
		else
			death_kick[name] = death_kick[name] + 1
		end

		if death_kick[name] == 5 then
			minetest.kick_player(name, "You died.")
		end
	end, player)
end)

minetest.register_on_respawnplayer(function(player)
	death_kick[player:get_player_name()] = 0
end)
