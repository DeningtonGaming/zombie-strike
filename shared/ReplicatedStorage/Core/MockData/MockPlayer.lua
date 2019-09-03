local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MockPlayer = {}

MockPlayer.Level = 1
MockPlayer.XP = 0

MockPlayer.Weapon = {
	Type = "Pistol",
	Level = 1,
	Rarity = 1,
	Name = "Average Pistol",

	Damage = 20,
	FireRate = 5,
	CritChance = 0.08,
	Magazine = 9,

	Model = 1,
}

MockPlayer.Armor = {
	Type = "Armor",
	Level = 1,
	Rarity = 1,
	Name = "Armor",

	Model = 1,
}

MockPlayer.Helmet = {
	Type = "Helmet",
	Level = 1,
	Rarity = 1,
	Name = "Helmet",

	Model = 1,
}

MockPlayer.EquippedWeapon = 1
MockPlayer.EquippedArmor = 2
MockPlayer.EquippedHelmet = 3

MockPlayer.Inventory = {
	MockPlayer.Weapon,
	MockPlayer.Armor,
	MockPlayer.Helmet,
	{
		Type = "Helmet",
		Level = 10,
		Rarity = 5,
		Name = "Helmet",
		Model = 5,
	}
}

return MockPlayer
