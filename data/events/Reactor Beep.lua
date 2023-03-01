local flashSprite

function onCreate()
    flashSprite = FlxSprite:new(0, 0):makeGraphic(1280, 720, FlxColor:fromString("#b30000"))
    flashSprite.alpha = 0
    parent:add(flashSprite)

    flashSprite.cameras = {parent.camOther}
end

function onUpdate(elapsed)
    flashSprite.alpha = FlxMath:lerp(flashSprite.alpha, 0, FlxMath:bound(elapsed * 9, 0, 1))
end

function onEvent(time, value1, value2)
    local charType = Std:parseFloat(value1)
    if Math:isNaN(charType) then
        charType = 0.4
    end

    flashSprite.alpha = charType

    FlxG.camera.zoom = FlxG.camera.zoom + 0.015
    parent.camHUD.zoom = parent.camHUD.zoom + 0.03
end