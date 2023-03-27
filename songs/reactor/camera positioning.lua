local dadX = 1725
local dadY = 1100
local bfX = 1725
local bfY = 1100

local cameraIntensity = 10
local offsetShit = {
    {"idle", 0, 0},
    {"singLEFT", -cameraIntensity, 0},
    {"singDOWN", 0, cameraIntensity},
    {"singUP", 0, -cameraIntensity},
    {"singRIGHT", cameraIntensity, 0}
}

function onUpdatePost()
    if Conductor.curBeat == 64 then
        parent.defaultCamZoom = 0.8
        dadX = 1450
        dadY = 1150
        bfX = 1950
        bfY = 1150
    end
    if Conductor.curBeat == 128 then
        parent.defaultCamZoom = 0.7
        dadX = 1725
        dadY = 1100
        bfX = 1725
        bfY = 1100
    end
    if Conductor.curBeat == 192 then
        parent.defaultCamZoom = 0.8
        dadX = 1450
        dadY = 1150
        bfX = 1950
        bfY = 1150
    end
    if Conductor.curBeat == 224 then
        parent.defaultCamZoom = 0.8
        dadX = 1725
        dadY = 1100
        bfX = 1725
        bfY = 1100
    end
    if Conductor.curBeat == 256 then
        parent.defaultCamZoom = 0.8
        dadX = 1450
        dadY = 1150
        bfX = 1950
        bfY = 1150
    end
    if Conductor.curBeat == 320 then
        parent.defaultCamZoom = 0.7
        dadX = 1725
        dadY = 1100
        bfX = 1725
        bfY = 1100
    end
    if Conductor.curBeat == 384 then
        parent.defaultCamZoom = 0.8
        dadX = 1450
        dadY = 1150
        bfX = 1950
        bfY = 1150
    end
    if Conductor.curBeat == 479 then
        parent.defaultCamZoom = 0.9
        dadX = 1725
        dadY = 1200
        bfX = 1725
        bfY = 1200
    end
    if Conductor.curBeat == 544 then
        parent.defaultCamZoom = 0.8
        dadX = 1725
        dadY = 1100
        bfX = 1725
        bfY = 1100
    end
    if Conductor.curBeat == 608 then
        parent.defaultCamZoom = 0.9
        dadX = 1725
        dadY = 1200
        bfX = 1725
        bfY = 1200
    end
    if Conductor.curBeat == 672 then
        parent.defaultCamZoom = 0.7
        dadX = 1725
        dadY = 1100
        bfX = 1725
        bfY = 1100
    end

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

        parent.camFollow:setPosition(bfX + offsetX, bfY + offsetY)
    else
        for i = 1, #offsetShit do
            if parent.dad.animation.name == offsetShit[i][1] then
                offsetX = offsetShit[i][2]
                offsetY = offsetShit[i][3]
                break
            end
        end

        parent.camFollow:setPosition(dadX + offsetX, dadY + offsetY)
    end
end