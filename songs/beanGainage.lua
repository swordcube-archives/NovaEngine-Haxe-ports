local allowedToEnd = false
local alphaTween = nil

local lerpScore = 0
local canLerp = false

function onEndSong(event)
    if not allowedToEnd then
        event.cancel()
        obtainBeans()
        allowedToEnd = true
    end
end

function obtainBeans()
    local beanAmount = math.floor(parent.songScore / 600) -- this is all impostor does to obtain the amount of beans you get
    lerpScore = beanAmount

    SettingsAPI:set(mod..":beans", SettingsAPI:get(mod..":beans") + beanAmount)
    SettingsAPI:flush()

    print("GIIVNG U BEANS!")

    local colorShader = CustomShader:new("shaders/ColorShader")
    colorShader:hset("amount", 0)

    local group = FlxSpriteGroup:new()
    group.cameras = {parent.camOther}
    parent:add(group)

    popupBG = FlxSprite:new(FlxG.width - 300, 0):makeGraphic(300, 100, FlxColor.BLACK)
    popupBG.visible = false
    group:add(popupBG)

    bean = FlxSprite:new(0, 0):loadGraphic(Paths:image('impostor/shop/bean'))
    bean:setPosition(popupBG:getGraphicMidpoint().x - 90, popupBG:getGraphicMidpoint().y - (bean.height / 2))
    group:add(bean)

    theText = FlxText:new(popupBG.x + 90, popupBG.y + 35, 200, Std:string(beanAmount), 35)
    theText:setFormat(Paths:font("ariblk.ttf"), 35, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK)
    theText:setPosition(popupBG:getGraphicMidpoint().x - 10, popupBG:getGraphicMidpoint().y - (theText.height / 2))
    theText.borderSize = 3
    theText.scrollFactor:set()
    group:add(theText)

    bean.shader = colorShader
    theText.shader = colorShader

    FlxTween:tween(group, {y = 0}, 0.35, {ease = FlxEase.circOut})

    local timer = FlxTimer:new():start(0.9)
    timer.onComplete = function(tmr)
        canLerp = true
        colorShader:hset("amount", 1)
        local numTween = FlxTween:num(colorShader.data.amount.value[0], 0, 0.8, {ease = FlxEase.expoOut})
        numTween._tweenFunction = function(v)
			colorShader:hset("amount", v)
		end
        FlxG.sound:play(Paths:sound('getbeans'), 0.9)
    end

    group.alpha = 0

    alphaTween = FlxTween:tween(group, {alpha = 1}, 0.5)
    alphaTween.onComplete = function(twn)
        alphaTween = FlxTween:tween(group, {alpha = 0}, 0.5, {startDelay = 2.5})
        alphaTween.onComplete = function(twn)
            alphaTween = nil
            parent:remove(group, true)
            parent:endSong()
        end
    end
end

function onUpdate(elapsed)
    if not allowedToEnd then return end

    if canLerp then
        lerpScore = math.floor(FlxMath:lerp(lerpScore, 0, FlxMath:bound(elapsed * 4, 0, 1)/1.5))
        if math.abs(0 - lerpScore) < 10 then lerpScore = 0 end
    end

    theText.text = Std:string(lerpScore)
    bean:setPosition(popupBG.getGraphicMidpoint().x - 90, popupBG.getGraphicMidpoint().y - (bean.height / 2))
    theText:setPosition(popupBG.getGraphicMidpoint().x - 10, popupBG.getGraphicMidpoint().y - (theText.height / 2))
end

function onDestroy()
    if alphaTween ~= nil then
        alphaTween:cancel()
    end
end