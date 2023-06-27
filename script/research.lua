local script_data = {
    players = {[1]=-5253834},
}

local on_player_joined = function(event)

    local player = event.player_index
    if script_data.players[player] then
        local time_gone = script_data.players[player] - event.tick

        if time_gone >= 60 then
            local second = math.floor(time_gone/60) % 60

            if time_gone >= 3600 then
                local minute = math.floor(time_gone/3600) % 60

                if time_gone >= 216000 then
                    local hour = math.floor(time_gone/216000) % 24

                    if time_gone >= 5184000 then
                        local day = math.floor(time_gone/5184000)
                        game.print({"script.player-joined-back-after", time_gone, {{"time.day", day},{"time.hour", hour},{"time.minute", minute},{"time.second", second}}})
                    else
                        game.print({"script.player-joined-back-after", time_gone, {{"time.hour", hour},{"time.minute", minute},{"time.second", second}}})
                    end
                else
                    game.print({"script.player-joined-back-after", time_gone, {{"time.minute", minute},{"time.second", second}}})
                end
            else
                game.print({"script.player-joined-back-after", time_gone, {{"time.second", second}}})
            end
        else
            game.print({"script.player-joined-back-after", time_gone, ""})
        end
    end
end


local events = {
    [defines.events.on_player_joined_game] = on_player_joined,
    [defines.events.on_player_left_game] = on_player_left,
}

local lib = {}

lib.get_events = function() return events end

lib.on_init = function()
  global.player_info = global.player_info or script_data
  reset_forces()
end

lib.on_load = function()
  script_data = global.player_info or script_data
end

lib.on_configuration_changed = function()
  
end

return lib