local cameraIntensity = 10
local offsetShit = {
    {"idle", 0, 0},
    {"singLEFT", -cameraIntensity, 0},
    {"singDOWN", 0, cameraIntensity},
    {"singUP", 0, -cameraIntensity},
    {"singRIGHT", cameraIntensity, 0}
}

function onUpdatePost()
    if parent.stage.curStage == "polus" then
        focusThing({470, 250}, {820, 250})
    elseif parent.stage.curStage == "toogus" then
        focusThing({500, 475}, {900, 475})
    end
end

function focusThing(pos1, pos2)
    local offsetX = 0
    local offsetY = 0

    if PlayState.SONG.sections[Conductor.curMeasure].playerSection then
        for i = 1, #offsetShit do
            if parent.boyfriend.animation.name == offsetShit[i][1] then
                offsetX = offsetShit[i][2]
                offsetY = offsetShit[i][3]
                break
            end
        end

        parent.camFollow:setPosition(pos2[1] + offsetX, pos2[2] + offsetY)
    else
        for i = 1, #offsetShit do
            if parent.dad.animation.name == offsetShit[i][1] then
                offsetX = offsetShit[i][2]
                offsetY = offsetShit[i][3]
                break
            end
        end

        parent.camFollow:setPosition(pos1[1] + offsetX, pos1[2] + offsetY)
    end
end