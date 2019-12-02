local ReplicatedStorage = game:GetService("ReplicatedStorage")

local t = require(ReplicatedStorage.Vendor.t)

local schema = t.values(t.strictInterface({
	Text = t.string,
	Args = t.array(
		t.union(
			t.strictInterface({
				Type = t.literal("Number"),
				Range = t.strictInterface({ t.number, t.number }),
				RoundToNearest = t.optional(t.number),
			}),

			t.strictInterface({
				Type = t.literal("Weapon"),
			})
		)
	),
}))

local QuestsDictionary = {
	Reward = 100,
	Quests = {
		KillZombies = {
			Text = "Kill %d zombies as a team",
			Args = {
				{
					Type = "Number",
					Range = { 60, 100 },
					RoundToNearest = 5,
				},
			},
		},

		KillZombiesWeapon = {
			Text = "Kill %d zombies with a %s as a team",
			Args = {
				{
					Type = "Number",
					Range = { 50, 80 },
					RoundToNearest = 5,
				},

				{
					Type = "Weapon",
				},
			},
		},

		KillZombiesGrenade = {
			Text = "Kill %d zombies with a grenade as a team",
			Args = {
				{
					Type = "Number",
					Range = { 50, 80 },
					RoundToNearest = 5,
				},
			},
		},

		BeatHardcoreMissions = {
			Text = "Beat %d hardcore missions",
			Args = {
				{
					Type = "Number",
					Range = { 5, 7 },
				},
			},
		},

		PlayMissionWithFriend = {
			Text = "Play %d mission with a friend",
			Args = {
				{
					Type = "Number",
					Range = { 1, 1 },
				},
			},
		},

		DefeatBossWithoutDamage = {
			Text = "Defeat %d boss without taking any damage",
			Args = {
				{
					Type = "Number",
					Range = { 1, 1 },
				},
			}
		},
	},
}

assert(schema(QuestsDictionary.Quests))

return QuestsDictionary
