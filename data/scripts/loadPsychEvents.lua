-- makes 0.4.2 psych events work during gameplay  lol
-- impostor was made in psych 0.4.2 so yeha

script:import("backend.dependency.ScriptHandler")
script:import("music.EventManager")
script:import("music.Song")

local EVENTS = {}

function onCreate()
    EVENTS = Paths:json("songs/"..PlayState.SONG.name.."/events").song

    -- haxe arrays are handled slightly differently from lua ones!
    -- haxe arrays start from zero, so you would do
    -- threeArgFunc(haxeArray[0], haxeArray[1], haxeArray[2])
    -- or smth like that
    -- and doing #haxeArray won't work, you have to instead
    -- do haxeArray.length on it

    for i = 0, EVENTS.notes.length do
        local section = EVENTS.notes[i]

        if section == nil then goto continue end
    
        if section.sectionNotes == nil then goto continue end
        if section.sectionNotes.length < 1 then goto continue end

        for i = 0, section.sectionNotes.length do
            local event = section.sectionNotes[i]
            if event == nil then goto continue2 end

            -- Convert the Psych event to a Nova event
            local convertedEvent = EventManager:convert({name = event[2], parameters = {event[3], event[4]}})
            parent.events:add(event[0], {convertedEvent})

            -- Allow the event script to actually run and do shit
            if event[2] == "Change Character" and not parent.preloadedCharacters:exists(event[3]) then
                parent.preloadedCharacters:set(event[3], Character:preloadCharacter(event[4]))
            end
            if parent.eventScripts:exists(event[2]) then goto continue2 end

            local script = ScriptHandler:loadModule(Paths:script("data/events/"..event[2]))
            parent.eventScripts:set(event[2], script)
            parent.scripts:add(script)

            -- this is dumb but whatever it works
            FlxTimer:new():start(0.01, function(timer)
                script:load()
                script:call("onCreate", {})
            end)

            ::continue2::
        end

        ::continue::
    end
end