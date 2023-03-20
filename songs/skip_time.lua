-- uncomment to unlock this debug functionality

-- function onUpdatePost()
--     if FlxG.keys.justPressed.F1 then
--         Conductor.songPosition = Conductor.songPosition + 5000
        
--         FlxG.sound.music:pause()
--         parent.vocals:pause()

--         FlxG.sound.music.time = Conductor.songPosition
--         parent.vocals.time = Conductor.songPosition

--         FlxG.sound.music:play()
--         parent.vocals:play()

--         Conductor:update()        
--     end
-- end

-- function onPlayerMiss(event)
--     parent.health = 2
-- end