function onCreate()
    parent.camBumping = false
    parent.camZooming = false
end

function onOpponentHit()
    parent.camBumping = true
    parent.camZooming = true
end