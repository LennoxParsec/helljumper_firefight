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
local covieRespawnCounter = 300
local covieRespawnTimer = 300
local odstsRespawnStart = false
local odstRespawnCounter = 300
local odstRespawnTimer = 300
-- This respawn the AI when triggered by firefightManager.aiCheck()
function firefightManager.respawnTimer()
    -- This spawn the Covenant when there are only 4 of them.
    if coviesRespawnStart == true and covieRespawnCounter > 0 then
        covieRespawnCounter = covieRespawnCounter - 1
    elseif coviesRespawnStart == true and covieRespawnCounter <= 0 then
        console_out("Covenant Bastards Inbound...")
        hsc.ai_place("Covenant_Bastards")
        hsc.ai_magically_see_players("Covenant_Bastards")
        coviesRespawnStart = false
        covieRespawnCounter = covieRespawnTimer
    end
    -- This spawn the Helljumpers when there are only 2 of them.
    if odstsRespawnStart == true and odstRespawnCounter > 0 then
        odstRespawnCounter = odstRespawnCounter - 1
    elseif odstsRespawnStart == true and odstRespawnCounter <= 0 then
        console_out("Helljumpers Incoming!")
        hsc.ai_place("Grid_Allies")
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
    if covieLivingCount <= 8 then
        coviesRespawnStart = true
    end
    if odstLivingCount <= 2 then
        odstsRespawnStart = true
    end
    -- Makes the AI follow the player. Very much needed.
    hsc.ai_follow_target_players("Covenant_Bastards")
    hsc.ai_follow_target_players("Grid_Allies")
end

-- These are the variables for firefightManager.aiMagicallySee()
local magicallySeeCounter = 0
local magicallySeeTimer = 300
-- This allows AI to magically see you. This is called each tick.
function firefightManager.aiMagicallySee()
    hsc.ai_magically_see_players("Grid_Allies")
    -- Enemies can only see you one tick after certain time. Currently testing sweet spot.
    if magicallySeeCounter > 0 then
        magicallySeeCounter = magicallySeeCounter - 1
    elseif magicallySeeCounter <= 0 then
        hsc.ai_magically_see_players("Covenant_Bastards")
        magicallySeeCounter = magicallySeeTimer
    end
end

return firefightManager