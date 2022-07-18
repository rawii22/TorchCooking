name = "Torch+ (git)"
description = "Ever wanted to cook with fire? Why can't you cook with your torch? Well now you can.\nIf you hover a food item over the torch, it will cook it.\nTorches can also be fueled by anything that can fuel a fire pit."
author = "rawii22 & lord_of_les_ralph"
version = "1.3"
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
		name = "FUELABLE",
		label = "Fuelable torches",
		hover = "This allows you to fuel torches with burnable items.",
		default = true,
		options = {
			{description = "Enabled", data = true},
			{description = "Disabled", data = false}
		}
	},
}