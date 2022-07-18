local FUELABLE = GetModConfigData("FUELABLE")

local function ontakefuel(inst)
    inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
end

--will give the torch prefab the ability to cook (with tag used above) --and fuelable too (7/18/2022)
local function ModifyTorch(prefab)
	prefab:AddComponent("cooker")
	if FUELABLE then
		if prefab.components.fueled ~= nil then
			prefab.components.fueled.accepting = true
			prefab.components.fueled:SetTakeFuelFn(ontakefuel)
		end
	end
end
--add changes
AddPrefabPostInit("torch", ModifyTorch)