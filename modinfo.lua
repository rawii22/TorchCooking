name = "Torch+ (git)"
description = "Ever wanted to cook with fire? Why can't you cook with your torch? Well now you can.\nIf you hover a food item over the torch, it will cook it.\nTorches can also be fueled by burnable items. The size of these items can be configured."
author = "rawii22 & lord_of_les_ralph"
version = "1.4"
icon = "modicon.tex"
icon_atlas = "modicon.xml"

forumthread = ""

api_version = 10

priority = - 1
dst_compatible = true
all_clients_require_mod = true
client_only_mod = false

configuration_options = {
	{
		name = "TORCHFUELABLE",
		label = "Fuelable torches",
		hover = "Allows you to fuel torches with burnable items.",
		default = true,
		options = {
			{description = "Enabled", data = true},
			{description = "Disabled", data = false}
		}
	},
	{
		name = "KINDLINGFUELLIMIT",
		label = "Fuel item size",
		hover = "Set the largest burnable item that can fuel a torch.",
		default = "MED_FUEL",
		options = {
			{description = "Tiny fuel", data = "TINY_FUEL"},
			{description = "Small fuel", data = "SMALL_FUEL"},
			{description = "Medium fuel", data = "MED_FUEL"},
			{description = "Medium-large fuel", data = "MED_LARGE_FUEL"},
			{description = "Large fuel", data = "LARGE_FUEL"}
		}
	},
}