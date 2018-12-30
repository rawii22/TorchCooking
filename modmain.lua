local function CanCookWithTorch(component)
	local CanCook = component.CanCook 
	component.CanCook = function(item, chef)
		return 
		CanCook(item, chef)
		and (self.inst:HasTag("lightcooker") and item.components.edible ~= nil and item.components.edible.hungervalue <= TUNING.CALORIES_SMALL)
		or not self.inst:HasTag("lightcooker")
	end
end

AddComponentPostInit("cooker", CanCookWithTorch)


local function AllowToCook(prefab)
	prefab:AddComponent("cooker")
	prefab:AddTag("lightcooker")
end

AddPrefabPostInit("torch", AllowToCook)