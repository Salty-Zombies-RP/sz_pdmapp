local Core = exports['qb-core']:GetCoreObject()
local identifier = "PDM"

CreateThread(function ()
    while GetResourceState("lb-phone") ~= "started" do
        Wait(500)
    end

    local function AddApp()
        local added, errorMessage = exports["lb-phone"]:AddCustomApp({
            identifier = identifier,
            name = "PDM",
            description = "Premium Deluxe Motorsports Catalogue",
            developer = "MT Scripts",
            defaultApp = false,
            size = 59812,
            ui = GetCurrentResourceName() .. "/ui/index.html",
            icon = "https://cfx-nui-" .. GetCurrentResourceName() .. "/ui/assets/icon.png"
        })

        if not added then
            print("Could not add app:", errorMessage)
        end
    end

    AddApp()

    AddEventHandler("onResourceStart", function(resource)
        if resource == "lb-phone" then
            AddApp()
        end
    end)

    SendNuiMessage({
        vehicles = json.encode((function()
            local t = {}
            for k, v in pairs(Core.Shared.Vehicles) do
                if v.shop == "pdm" then
                    table.insert(t, v)
                end
            end
            table.sort(t, function(a, b) return a.price < b.price end) -- Sort by price in ascending order
            return t
        end)())
    })
end)

RegisterNUICallback('getVehicles', function(data, cb)
    cb({
        vehicles = json.encode((function()
            local t = {}
            for k, v in pairs(Core.Shared.Vehicles) do
                if v.shop == "pdm" then
                    table.insert(t, v) -- Use table.insert to create an array-like table
                end
            end
            table.sort(t, function(a, b) return a.price < b.price end) -- Sort by price in ascending order
            return t
        end)()),
        categories = json.encode(Config.vehicleCategories)
    })
end)