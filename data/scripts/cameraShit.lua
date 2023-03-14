function onUpdatePost()
    if parent.stage.curStage == "polus" then
        focusThing({470, 250}, {820, 250})
    elseif parent.stage.curStage == "toogus" then
        focusThing({500, 475}, {900, 475})
    end
end

function focusThing(pos1, pos2)
    if PlayState.SONG.sections[Conductor.curMeasure].playerSection then
        parent.camFollow:setPosition(pos2[1], pos2[2])
    else
        parent.camFollow:setPosition(pos1[1], pos1[2])
    end
end