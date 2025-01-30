local hscOld = require "the_flood.hsc"
local hsc = require "hsc"
local blam = require "blam"
local engine = Engine
local balltze = Balltze
local scriptBlock = require "script".block
local firefightManager = {}

-- These are the functions that are called each tick.
function firefightManager.eachTick()
    firefightManager.aiCheck()
    firefightManager.respawnTimer()
    firefightManager.aiMagicallySee()
end

-- These are the variables for firefightManager.respawnTimer()
local coviesRespawnStart = false
local covieRespawnCounter = 0
local covieRespawnTimer = 300
local odstsRespawnStart = false
local odstRespawnCounter = 0
local odstRespawnTimer = 150
-- This respawn the AI when triggered by firefightManager.aiCheck()
function firefightManager.respawnTimer()
    -- This spawn the Covenant when there are only 4 of them.
    if coviesRespawnStart == true and covieRespawnCounter > 0 then
        covieRespawnCounter = covieRespawnCounter - 1
    elseif coviesRespawnStart == true and covieRespawnCounter <= 0 then
        console_out("Covenant Bastards Inbound...")
        hscOld.aiSpawn(1, "Covenant_Bastards")
        hsc.ai_magically_see_players("Covenant_Bastards")
        coviesRespawnStart = false
        covieRespawnCounter = covieRespawnTimer
    end
    -- This spawn the Helljumpers when there are only 2 of them.
    if odstsRespawnStart == true and odstRespawnCounter > 0 then
        odstRespawnCounter = odstRespawnCounter - 1
    elseif odstsRespawnStart == true and odstRespawnCounter <= 0 then
        console_out("Helljumpers Incoming!")
        hscOld.aiSpawn(1, "Grid_Allies")
        odstsRespawnStart = false
        odstRespawnCounter = odstRespawnTimer
    end
end

-- These are the variables for firefightManager.aiCheck()
local covieLivingCount
local odstLivingCount
-- This checks the state of the AI to respawn them and make them follow the player.
function firefightManager.aiCheck()
    -- Needed variable for hsc.AiLivingCount to work.
    covieLivingCount = hscOld.aiLivingCount("Covenant_Bastards", "covie_bastards")
    odstLivingCount = hscOld.aiLivingCount("Grid_Allies", "odst_allies")
    -- Triggering the order to initiate respawn when living count reaches threshold.
    if covieLivingCount <= 4 then
        coviesRespawnStart = true
    end
    if odstLivingCount <= 2 then
        odstsRespawnStart = true
    end
    -- Makes the AI follow the player. Very much needed.
    hscOld.aiAction(1, "Covenant_Bastards")
    hscOld.aiAction(1, "Grid_Allies")
end

-- These are the variables for firefightManager.aiMagicallySee()
local magicallySightCounter = 0
local magicallySightTimer = 900
-- This allows AI to magically see you. This is called each tick.
function firefightManager.aiMagicallySee()
    hsc.ai_magically_see_players("Grid_Allies")
    -- Enemies can only see you one tick, each 30 seconds. This should give you room to breath.
    if magicallySightCounter > 0 then
        covieRespawnCounter = magicallySightCounter - 1
    elseif magicallySightCounter <= 0 then
        hsc.aiMagicallySeePlayers("Covenant_Bastards")
        magicallySightCounter = magicallySightTimer
    end
end

return firefightManager