script:import("music.Ranking")
script:import("objects.TrackingSprite")
script:import("flixel.ui.FlxBar")
script:import("flixel.ui.FlxBarFillDirection")

local scoreTxtTween

local timeBarBG
local timeBar
local timeTxt

function onCreatePost()
    parent.scoreTxt.size = 20
    parent.scoreTxt.borderSize = 1.25
    parent.scoreTxt.color = parent.dad.healthBarColor

    local rankList = {"Perfect!!", "Sick!", "Great", "Good", "Meh", "Bruh", "Bad", "Shit", "You Suck!"}
    for i = 1, #rankList do
        Ranking.ranks[i-1].name = rankList[i]
    end

    parent.timeBarBG.visible = false
    parent.timeBar.visible = false
    parent.timeTxt.visible = false

    timeTxt = FlxText:new(42 + (FlxG.width / 2) - 585, 20, 400, string:upper(PlayState.SONG.name), 32)
    timeTxt:setFormat(Paths:font("vcr.ttf"), 14, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK)
    timeTxt.cameras = {parent.camHUD}
    timeTxt.alpha = 0
    timeTxt.borderSize = 1
    if SettingsAPI.downscroll then
        timeTxt.y = FlxG.height - 45
    end

    timeBarBG = TrackingSprite:new():loadGraphic(Paths:image("UI/base/timeBar"))
    timeBarBG.x = timeTxt.x
    timeBarBG.y = timeTxt.y + (timeTxt.height / 4)
    timeBarBG.cameras = {parent.camHUD}
    timeBarBG.alpha = 0
    timeBarBG.trackingOffset.x = -4
    timeBarBG.trackingOffset.y = -4
    timeBarBG.trackingMode = 1

    timeBar = FlxBar:new(timeBarBG.x + 4, timeBarBG.y + 4, FlxBarFillDirection.LEFT_TO_RIGHT, math.floor(timeBarBG.width - 8), math.floor(timeBarBG.height - 8), Conductor,
        'songPosition', 0, FlxG.sound.music.length)
    timeBar.scrollFactor:set()
    timeBar:createFilledBar(FlxColor:fromString("#2e412e"), FlxColor:fromString("#44d844"))
    timeBar.numDivisions = 800
    timeBar.alpha = 0
    timeBar.cameras = {parent.camHUD}
    timeBarBG.tracked = timeBar
    timeTxt.x = timeTxt.x + 10
    timeTxt.y = timeTxt.y + 4

    parent:add(timeBarBG)
    parent:add(timeBar)
    parent:add(timeTxt)

    updateScoreText()
end

function onSongStart()
    FlxTween:tween(timeBar, {alpha = 1}, 0.5, {ease = FlxEase.circOut})
    FlxTween:tween(timeTxt, {alpha = 1}, 0.5, {ease = FlxEase.circOut})
end

function onEvent(name, parameters)
    if name == "Change Character" then
        parent.scoreTxt.color = parent.dad.healthBarColor
    end
end

function onStartEndCutscene(event)
    parent:remove(timeBarBG, true)
    parent:remove(timeBar, true)
    parent:remove(timeTxt, true)
end

function onUpdatePost(elapsed)
    updateScoreText()
end

function updateScoreText()
    local rank = Ranking:rankFromAccuracy(parent.accuracy * 100)
    local fcRank = parent:getFCRank()

    parent.scoreTxt.text = 'Score: ' .. parent.songScore
    .. ' | Combo Breaks: ' .. parent.songMisses
    .. ' | Accuracy: ' .. ((parent.accuracyPressedNotes > 0) and FlxMath:roundDecimal(parent.accuracy * 100, 2)..'%' or "?")
    .. ((parent.accuracyPressedNotes > 0) and ((fcRank ~= "CLEAR") and " ["..fcRank.."]" or "") or "")

    parent.scoreTxt:applyMarkup(parent.scoreTxt.text, {parent.rankFormat})

    -- doin this so the text doesn't look weird when centered & antialiased
    parent.scoreTxt.x = math.floor((FlxG.width - parent.scoreTxt.width) * 0.5)
end

function onPlayerHit(event)
    if event.note.isSustainNote then
        return
    end
    
    if scoreTxtTween ~= nil then
        scoreTxtTween:cancel()
    end
    
    parent.scoreTxt.scale.x = 1.075
    parent.scoreTxt.scale.y = 1.075
    scoreTxtTween = FlxTween:tween(parent.scoreTxt.scale, {x = 1, y = 1}, 0.2)
    scoreTxtTween.onComplete = function(twn)
        scoreTxtTween = nil
    end
end