-- uncomment to unlock this debug functionality

function onUpdatePost()
    if FlxG.keys.justPressed.F1 then
        Conductor.songPosition = Conductor.songPosition + 5000
        updateConductorShit()
        return
    end

    if FlxG.keys.justPressed.F2 then
        for i = 0, parent.notes.length - 1 do
            parent.notes.members[i]:kill()
            parent.notes.members[i]:destroy()
            parent.songScore = parent.songScore + 350
        end
        parent.notes:clear()
        
        Conductor.songPosition = FlxG.sound.music.length - 1000
        updateConductorShit()
        return
    end
end

function updateConductorShit()
    FlxG.sound.music:pause()
    parent.vocals:pause()

    FlxG.sound.music.time = Conductor.songPosition
    parent.vocals.time = Conductor.songPosition

    FlxG.sound.music:play()
    parent.vocals:play()

    Conductor:update()     
end

function onPlayerMiss(event)
    parent.health = 2
end