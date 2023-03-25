local lastNote = {
    dad = {time = -math.huge, data = -1},
    bf = {time = -math.huge, data = -1},
}

local opponentTrail
local playerTrail

function onCreatePost()
    local char = parent.dad
    opponentTrail = Character:new(char.x, char.y, char.curCharacter, char.isPlayer)
    opponentTrail.color = FlxColor:fromRGB(char.healthBarColorArray[0] + 50, char.healthBarColorArray[1] + 50, char.healthBarColorArray[2] + 50)
    opponentTrail.blend = BlendMode.HARDLIGHT
    opponentTrail.alpha = 0
    opponentTrail:playAnim(char.animation.name, true)
    opponentTrail.danceOnBeat = false
    opponentTrail.idleAfterSinging = false
    parent:insert(parent.members:indexOf(char), opponentTrail)

    local char = parent.boyfriend
    playerTrail = Character:new(char.x, char.y, char.curCharacter, char.isPlayer)
    playerTrail.color = FlxColor:fromRGB(char.healthBarColorArray[0] + 50, char.healthBarColorArray[1] + 50, char.healthBarColorArray[2] + 50)
    playerTrail.blend = BlendMode.HARDLIGHT
    playerTrail.alpha = 0
    playerTrail:playAnim(char.animation.name, true)
    playerTrail.danceOnBeat = false
    playerTrail.idleAfterSinging = false
    parent:insert(parent.members:indexOf(char), playerTrail)
end

function onOpponentHit(event)
    local doDouble = (not event.note.isSustainNote) and (math.abs(event.note.strumTime - lastNote.dad.time) <= 2) and (event.note.noteData ~= lastNote.dad.data)

    if doDouble then
        doTrail(0)
    end

    lastNote.dad.time = event.note.strumTime
    lastNote.dad.data = event.note.noteData
end

function onPlayerHit(event)
    local doDouble = (not event.note.isSustainNote) and (math.abs(event.note.strumTime - lastNote.bf.time) <= 2) and (event.note.noteData ~= lastNote.bf.data)

    if doDouble then
        doTrail(1)
    end

    lastNote.bf.time = event.note.strumTime
    lastNote.bf.data = event.note.noteData
end

local opponentTrailTween
local playerTrailTween

function doTrail(charNum)
    local char = nil
    local realChar = nil

    if charNum == 0 then
        char = opponentTrail
        realChar = parent.dad
        if opponentTrailTween ~= nil then
            opponentTrailTween:cancel()
        end
    elseif charNum == 1 then
        char = playerTrail
        realChar = parent.boyfriend
        if playerTrailTween ~= nil then
            playerTrailTween:cancel()
        end
    end

    char.alpha = 0.8
    char:playAnim(realChar.animation.name, true)

    local tween = FlxTween:tween(char, {alpha = 0}, 0.75, {ease = FlxEase.linear})
    tween.onComplete = function(tween)
        if charNum == 0 then
            opponentTrailTween = nil
        elseif charNum == 1 then
            playerTrailTween = nil
        end
    end

    if charNum == 0 then
        opponentTrailTween = tween
    elseif charNum == 1 then
        playerTrailTween = tween
    end

    parent.camGame.zoom = parent.camGame.zoom + 0.015
    parent.camHUD.zoom = parent.camHUD.zoom + 0.015
end