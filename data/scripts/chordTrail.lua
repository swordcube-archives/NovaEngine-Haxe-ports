local lastNote = {
    dad = {time = -math.huge, data = -1},
    bf = {time = -math.huge, data = -1},
}

function onOpponentHit(event)
    local doDouble = (not event.note.isSustainNote) and ((event.note.strumTime - lastNote.dad.time) <= 2) and (event.note.noteData ~= lastNote.dad.data)

    if doDouble then
        local char = parent.dad
        doTrail(char, FlxColor:fromRGB(char.healthBarColorArray[0] + 50, char.healthBarColorArray[1] + 50, char.healthBarColorArray[2] + 50))
    end

    lastNote.dad.time = event.note.strumTime
    lastNote.dad.data = event.note.noteData
end

function onPlayerHit(event)
    local doDouble = (not event.note.isSustainNote) and ((event.note.strumTime - lastNote.bf.time) <= 2) and (event.note.noteData ~= lastNote.bf.data)

    if doDouble then
        local char = parent.boyfriend
        doTrail(char, FlxColor:fromRGB(char.healthBarColorArray[0] + 50, char.healthBarColorArray[1] + 50, char.healthBarColorArray[2] + 50))
    end

    lastNote.bf.time = event.note.strumTime
    lastNote.bf.data = event.note.noteData
end

function doTrail(char, color)
    local trail = Character:new(char.x, char.y, char.curCharacter, char.isPlayer)
    trail.color = color
    trail.blend = BlendMode.HIGHLIGHT
    trail.alpha = 0.8
    trail:playAnim(char.animation.name, true)
    trail.idleAfterSinging = false

    local tween = FlxTween:tween(trail, {alpha = 0}, 0.75, {ease = FlxEase.linear})
    tween.onComplete = function(tween)
        trail:kill()
        trail:destroy()
        parent:remove(trail, true)
    end

    parent:insert(parent.members:indexOf(char), trail)
end