local function CanCookWithTorch(component)

	--stores original function in variable so we don't have to type it again
	local CanCook = component.CanCook 
	
	--will run the original function to get the original boolean value...
	component.CanCook = function(self, item, chef)
	
	--this will return(and possibly change) the boolean value from before
		return
		CanCook(self, item, chef)
		
		--new comparison will see if the torch can cook the item(through the food's caloric value)
		and (self.inst:HasTag("lightcooker") and item.components.edible ~= nil and item.components.edible.hungervalue <= TUNING.CALORIES_SMALL)
		or not self.inst:HasTag("lightcooker")
	end
end
--add changes
AddComponentPostInit("cooker", CanCookWithTorch)

--will give the torch prefab then ability to cook(with tag used above)
local function AllowToCook(prefab)
	prefab:AddComponent("cooker")
	prefab:AddTag("lightcooker")
end
--add changes
AddPrefabPostInit("torch", AllowToCook)

--Because the ACTION.COOK.fn in actions.lua is weird with wether the 'invobject' or 'target' is the item being cooked vs the cooker, we compare them by checking their tags/components
local COOKFN = GLOBAL.ACTIONS.COOK.fn
--the above line will, like before, store the whole function(and it's looooong)

--this will override the original function. It will perform it, but then check to see if the item can be cooked by the torch(also through the food's caloric value)
GLOBAL.ACTIONS.COOK.fn = function(act)
	if act.invobject then
		if act.invobject.components.cooker then
			local temp = act.invobject
			act.invobject = act.target
			act.target = temp
		end
		local cancook, str = COOKFN(act)
		if not cancook then
			if act.invobject:HasTag("lightcooker") and act.target.components.edible ~= nil and act.target.components.edible.hungervalue > TUNING.CALORIES_SMALL then
				return false, "TOODENSE"
			elseif act.target:HasTag("lightcooker") and act.invobject.components.edible ~= nil and act.invobject.components.edible.hungervalue > TUNING.CALORIES_SMALL then
				return false, "TOODENSE"
			else
				return cancook, str
			end
		else
			return cancook, str
		end
	end
end

local function AddCharacterSpeech()
	--loop allows all characters to access this string
	for k, v in pairs(GLOBAL.STRINGS.CHARACTERS) do
		v.ACTIONFAIL.COOK.TOODENSE = "It simply won't cook."
	end
end
--add changes
AddSimPostInit(AddCharacterSpeech)