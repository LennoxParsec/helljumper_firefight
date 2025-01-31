DebugMode = true
local balltze = Balltze
local engine = Engine

-- Gameplay Core Modules
local dynamicCross = require "the_flood.gameplay_core.dynamicCross"
local hudExtensions = require "the_flood.gameplay_core.hudExtensions"
local healthRegen = require "the_flood.gameplay_core.healthRegen"
local aimingDownSights = require "the_flood.gameplay_core.aimingDownSights"
local playerPingObjectives = require "the_flood.gameplay_core.playerPingObjectives"
local sprint = require "the_flood.gameplay_core.sprint"
local weaponExtensions = require "the_flood.gameplay_core.weaponExtensions"
local firefightManager = require "the_flood.firefight_modules.firefightManager"
local vehiclesManager = require "the_flood.firefight_modules.vehiclesManager"

dynamicCross.initializeSettings()

-- Functions OnTick
function OnTick()
    dynamicCross.dynamicReticles()
    hudExtensions.radarHideOnZoom()
    hudExtensions.hudBlurOnLowHealth()
    hudExtensions.changeGreandeSound()
    healthRegen.regenerateHealth()
    -- aimingDownSights.customKeys()
    playerPingObjectives.pingObjectives()
    --weaponExtensions.casterFixHeat()
    firefightManager.eachTick()
    vehiclesManager.eachTick()
end

local onTickEvent = balltze.event.tick.subscribe(function(event)
    if event.time == "before" then
        OnTick()
    end
end)
local onFrameEvent = balltze.event.frame.subscribe(function(event)
    if event.time == "before" then
        OnFrame()
    end
end)
local onRconMessageEvent = balltze.event.rconMessage.subscribe(function(event)
    if event.time == "before" then
        if blam.rcon.handle(event.context:message()) == false then
            event:cancel()
        end
    end
end)

return {
    unload = function()
        logger:warning("Unloading main")
        onTickEvent:remove()
        onFrameEvent:remove()
        onRconMessageEvent:remove()
    end
}
