local hscOld = require "the_flood.hsc"
local hsc = require "hsc"
local blam = require "blam"
local engine = Engine
local balltze = Balltze
local scriptBlock = require "script".block
local vehiclesManager = {}

function vehiclesManager.eachTick()
    vehiclesManager.vehiclesRespawn()
    vehiclesManager.vehiclesLiveCount()
end

-- These are the variables for vehiclesManager.vehiclesRespawn()
local vehicleRespawnTimer = 300
local redVehiclesRespawnStart = false
local redVehiclesCounter = 300
local blueVehiclesRespawnStart = false
local blueVehiclesCounter = 300
local wraithsRespawnStart = false
local wraithsCounter = 300
function vehiclesManager.vehiclesRespawn()
    -- Spawning the Red Vehicles.
    if redVehiclesRespawnStart == true and redVehiclesCounter > 0 then
        redVehiclesCounter = redVehiclesCounter - 1
    elseif redVehiclesRespawnStart == true and redVehiclesCounter <= 0 then
        redVehiclesRespawnStart = false
        redVehiclesCounter = vehicleRespawnTimer
        console_out("Placing red vehicles...")
        hsc.ai_place("Covenant_Pilots/red_revenant")
        hsc.object_create_anew("red_revenant")
        hsc.vehicle_load_magic("red_revenant", "G-driver", "Covenant_Pilots/red_revenant")
        --hsc.ai_vehicle_encounter("red_revenant", "Covenant_Bastards")
        hsc.ai_place("Covenant_Pilots/red_ghost_a")
        hsc.object_create_anew("red_ghost_a")
        hsc.vehicle_load_magic("red_ghost_a", "G-driver", "Covenant_Pilots/red_ghost_a")
        --hsc.ai_vehicle_encounter("red_ghost_a", "Covenant_Bastards")
        hsc.ai_place("Covenant_Pilots/red_ghost_b")
        hsc.object_create_anew("red_ghost_b")
        hsc.vehicle_load_magic("red_ghost_b", "G-driver", "Covenant_Pilots/red_ghost_b")
        --hsc.ai_vehicle_encounter("red_ghost_b", "Covenant_Bastards")
    end
    -- Spawning the Blue Vehicles.
    if blueVehiclesRespawnStart == true and blueVehiclesCounter > 0 then
        blueVehiclesCounter = blueVehiclesCounter - 1
    elseif blueVehiclesRespawnStart == true and blueVehiclesCounter <= 0 then
        blueVehiclesRespawnStart = false
        blueVehiclesCounter = vehicleRespawnTimer
        console_out("Placing blue vehicles...")
        hsc.ai_place("Covenant_Pilots/blue_revenant")
        hsc.object_create_anew("blue_revenant")
        hsc.vehicle_load_magic("blue_revenant", "G-driver", "Covenant_Pilots/blue_revenant")
        --hsc.ai_vehicle_encounter("blue_revenant", "Covenant_Bastards")
        hsc.ai_place("Covenant_Pilots/blue_ghost_a")
        hsc.object_create_anew("blue_ghost_a")
        hsc.vehicle_load_magic("blue_ghost_a", "G-driver", "Covenant_Pilots/blue_ghost_a")
        --hsc.ai_vehicle_encounter("blue_ghost_a", "Covenant_Bastards")
        hsc.ai_place("Covenant_Pilots/blue_ghost_b")
        hsc.object_create_anew("blue_ghost_b")
        hsc.vehicle_load_magic("blue_ghost_b", "G-driver", "Covenant_Pilots/blue_ghost_b")
        --hsc.ai_vehicle_encounter("blue_ghost_b", "Covenant_Bastards")
    end
    -- Spawning the Wraiths.
    if wraithsRespawnStart == true and wraithsCounter > 0 then
        wraithsCounter = wraithsCounter - 1
    elseif wraithsRespawnStart == true and wraithsCounter <= 0 then
        wraithsRespawnStart = false
        wraithsCounter = vehicleRespawnTimer
        console_out("Placing wraith vehicles...")
        hsc.ai_place("Covenant_Pilots/red_wraith")
        hsc.object_create_anew("red_wraith")
        hsc.vehicle_load_magic("red_wraith", "G-driver", "Covenant_Pilots/red_wraith")
        hsc.ai_place("Covenant_Pilots/blue_wraith")
        hsc.object_create_anew("blue_wraith")
        hsc.vehicle_load_magic("blue_wraith", "G-driver", "Covenant_Pilots/blue_wraith")
    end
end

-- These are the variables for vehiclesManager.vehiclesLiveCount()
local redVehiclesLivingCount
local blueVehiclesLivingCount
local wraithsLivingCount
-- This checks the state of the AI to respawn them and make them follow the player.
function vehiclesManager.vehiclesLiveCount()
    -- Needed variable for hsc.AiLivingCount to work.
    blueVehiclesLivingCount = hscOld.aiLivingCount("Covenant_Pilots/blue_revenant", "blue_revenant") + hscOld.aiLivingCount("Covenant_Pilots/blue_ghost_a", "blue_ghost_a") + hscOld.aiLivingCount("Covenant_Pilots/blue_ghost_b", "blue_ghost_b")
    redVehiclesLivingCount = hscOld.aiLivingCount("Covenant_Pilots/red_revenant", "red_revenant") + hscOld.aiLivingCount("Covenant_Pilots/red_ghost_a", "red_ghost_a") + hscOld.aiLivingCount("Covenant_Pilots/red_ghost_b", "red_ghost_b")
    wraithsLivingCount = hscOld.aiLivingCount("Covenant_Pilots/red_wraith", "red_wraith") + hscOld.aiLivingCount("Covenant_Pilots/blue_wraith", "blue_wraith")
    -- Triggering the order to initiate respawn when living count reaches 0. Has to be this way because of object_create_anew.
    if redVehiclesLivingCount == 0 then
        redVehiclesRespawnStart = true
    end
    if blueVehiclesLivingCount == 0 then
        blueVehiclesRespawnStart = true
    end
    if wraithsLivingCount == 0 then
        wraithsRespawnStart = true
    end
end

---- These are the variables for vehiclesManager.warthogsRespawn()
--local vehicles = blam.findTagsList("", blam.tagClasses.vehicle)
--local keywords = {"gauss", "rocket", "chaingun"}
---- This attemps to initiate the respawn for a destroyed Warthog. Currently unactive.
--function vehiclesManager.warthogsRespawn()
--    -- We check the current state for all Warthog vehicles in the map.
--    for _, tagEntry in pairs(vehicles) do
--        local vehicleTag = blam.vehicle(tagEntry.id)
--        local isWarthogVehicle = table.find(keywords, function (keyword) return vehicleTag.path:includes(keyword) end)
--        if isWarthogVehicle then
--            if vehicleTag.health == 0 then
--                do crazy shit
--            end
--        end
--    end
--end

return vehiclesManager