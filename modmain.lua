local TORCHFUELABLE = GetModConfigData("TORCHFUELABLE")
KINDLINGFUELLIMIT = GLOBAL.TUNING[GetModConfigData("KINDLINGFUELLIMIT")]

-- Add new fuel type
GLOBAL.FUELTYPE.KINDLING = "KINDLING"

local function ontakefuel(inst)
    inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
end

-- Will give the torch prefab the ability to cook, and to accept fuel too (7/18/2022)
local function ModifyTorch(prefab)
	prefab:AddComponent("cooker")
	if TORCHFUELABLE then
		if prefab.components.fueled ~= nil then
			prefab.components.fueled.accepting = true
			prefab.components.fueled:SetTakeFuelFn(ontakefuel)
		end
	end
end
AddPrefabPostInit("torch", ModifyTorch)

--this function prevents the "add fuel" option from appearing on burnable items that are too large and acting on a torch
local function OverrideCollectActions(prefab)
	local fuel = prefab.components.fuel or prefab.components.fueler
	if fuel and fuel.fueltype == GLOBAL.FUELTYPE.BURNABLE and fuel.fuelvalue > KINDLINGFUELLIMIT then --check whether the prefab has fuel or fueler component and if it has the right fuel type and value
		local OldCollectActions = prefab.CollectActions
		prefab.CollectActions = function(self, actiontype, ...)
			OldCollectActions(self, actiontype, ...) --CollectActions from componentactions compiles a list of actions that an item can perform based on the components of that item
			if actiontype == "USEITEM" then --fueling a torch is a "USEITEM" type of action
				local _, target, actions = ... --"USEITEM" actions use these specific parameters. (Look at componentactions.lua)
				if target.prefab == "torch" then
					local fuelActionIdx = nil
					for i,action in ipairs(actions) do --find the fuel action
						if action.id == "ADDFUEL" or action.id == "ADDWETFUEL" then
							fuelActionIdx = i
						end
					end
					if fuelActionIdx then --if it has a fuel action, remove it
						table.remove(actions, fuelActionIdx)
					end
				end
			end
		end
	end
end

if TORCHFUELABLE then
	AddPrefabPostInitAny(OverrideCollectActions)
end