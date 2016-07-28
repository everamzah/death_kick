local death_kick = {}

minetest.register_on_joinplayer(function(player)
	death_kick[player:get_player_name()] = nil
end)

minetest.register_on_leaveplayer(function(player)
	death_kick[player:get_player_name()] = nil
end)

minetest.register_on_respawnplayer(function(player)
	death_kick[player:get_player_name()] = nil
end)

minetest.register_on_dieplayer(function(player)
	if not death_kick[player:get_player_name()] then
		death_kick[player:get_player_name()] = minetest.get_us_time()
	end

	if minetest.get_us_time() - death_kick[player:get_player_name()] < 120 * 1000000 then
		minetest.after(10, function()
			if (not player) or player:get_hp() ~= 0 then
				return
			end
			player:set_hp(0)
		end, player)
	else
		minetest.kick_player(player:get_player_name(), "You died.")
	end
end)
