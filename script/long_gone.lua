local script_data = {
    players = {},
}

local on_player_joined = function(event)

    local player = event.player_index
    if script_data.players[player] then
        local time_gone = event.tick - script_data.players[player]
        local time_string = ""

        if time_gone >= 60 then
            local second = math.floor(time_gone/60) % 60

            if time_gone >= 3600 then
                local minute = math.floor(time_gone/3600) % 60

                if time_gone >= 216000 then
                    local hour = math.floor(time_gone/216000) % 24

                    if time_gone >= 5184000 then
                        local day = math.floor(time_gone/5184000)
                        
                        time_string = {"time.day-hour-minute-second", day, hour, minute, second}
                    else
                        time_string = {"time.hour-minute-second", hour, minute, second}
                    end
                else
                    time_string = {"time.minute-second", minute, second}
                end
            else
                time_string = {"time.second", second}
            end
            game.print({"script.player-joined-back-after", game.players[player].name, time_gone, time_string})
        else
            game.print({"script.player-joined-back-only-ticks", game.players[player].name, time_gone})
        end
    else
        game.print({"script.welcome", game.players[player].name})
    end
end

local on_player_left = function(event)
    script_data.players[event.player_index] = event.tick
end

local events = {
    [defines.events.on_player_joined_game] = on_player_joined,
    [defines.events.on_player_left_game] = on_player_left,
}

local lib = {}

lib.get_events = function() return events end

lib.on_init = function()
  global.player_info = global.player_info or script_data
end

lib.on_load = function()
  script_data = global.player_info or script_data
end

lib.on_configuration_changed = function()
  
end

return lib