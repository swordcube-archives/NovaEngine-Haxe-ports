function onBeatHit(curBeat)
    if curBeat % 2 == 0 then
        if not string:startsWith(parent.bf.animation.name, "sing") then
            parent.bf:dance(true)
        end

        if not string:startsWith(parent.dad.animation.name, "sing") then
            parent.dad:dance(true)
        end
    end
end