local ServerScriptService = game:GetService("ServerScriptService")

local DataStore2 = require(ServerScriptService.Vendor.DataStore2)

return function(context, dungeons, player)
	local player = player or context.Executor
	DataStore2("DungeonsPlayed", player):Set(dungeons)
end
