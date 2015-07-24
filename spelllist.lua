function VocalRaidAssistant:GetBarData() 
	return {
	
		[51052] = {
			desc = "",
			type = "premade",
			class = "DEATH KNIGHT",
			cd = 2*60,
		},
		[740] = {
			desc = "",
			type = "premade",
			class = "DRUID",
			cd = 8*60,
		},
		[115310] = {
			desc = "",
			type = "premade",
			class = "MONK",
			cd = 3*60,
		},
		[31821] = {
			desc = "",
			type = "premade",
			class = "PALADIN",
			cd = 3*60,
		},
		[64843] = {
			desc = "",
			type = "premade",
			class = "PRIEST",
			cd = 3*60,
		},
		[62618] = {
			desc = "",
			type = "premade",
			class = "PRIEST",
			cd = 3*60,
		},
		[15286] = {
			desc = "",
			type = "premade",
			class = "PRIEST",
			cd = 3*60,
		},
		[76577] = {
			desc = "",
			type = "premade",
			class = "ROGUE",
			cd = 3*60,
		},
		[108280] = {
			desc = "",
			type = "premade",
			class = "SHAMAN",
			cd = 3*60,
		},
		[98008] = {
			desc = "",
			type = "premade",
			class = "SHAMAN",
			cd = 3*60,
		},
		[97462] = {
			desc = "",
			type = "premade",
			class = "WARRIOR",
			cd = 3*60,
		},
		[159916] = {
			desc = "",
			type = "premade",
			class = "MAGE",
			cd = 2*60,
		},
	}
end

function VocalRaidAssistant:GetBarDataO() 
	return {
	
		[90355] = {
			desc = "",
			type = "premade",
			class = "HUNTER",
			duration = 40,
		},
		[80353] = {
			desc = "",
			type = "premade",
			class = "MAGE",
			duration = 40,
		},
		[2825] = {
			desc = "",
			type = "premade",
			class = "SHAMAN",
			duration = 40,
		},
		[32182] = {
			desc = "",
			type = "premade",
			class = "SHAMAN",
			duration = 40,
		},
		[64382] = {
			desc = "",
			type = "premade",
			class = "WARRIOR",
			duration = 10,
		},
		[172106] = {
			desc = "",
			type = "premade",
			class = "HUNTER",
			duration = 6,
		},
	}
end	

function VocalRaidAssistant:GetBarDataB() 
	return {
	
		[51052] = {
			desc = "",
			type = "premade",
			class = "DEATH KNIGHT",
			duration = 3,
		},
		[740] = {
			desc = "",
			type = "premade",
			class = "DRUID",
			duration = 8,
		},
		[115213] = {
			desc = "",
			type = "premade",
			class = "MONK",
			duration = 6,
		},
		[31821] = {
			desc = "",
			type = "premade",
			class = "PALADIN",
			duration = 6,
		},
		[64843] = {
			desc = "",
			type = "premade",
			class = "PRIEST",
			duration = 8,
		},
		[62618] = {
			desc = "",
			type = "premade",
			class = "PRIEST",
			duration = 10,
		},
		[15286] = {
			desc = "",
			type = "premade",
			class = "PRIEST",
			duration = 15,
		},
		[76577] = {
			desc = "",
			type = "premade",
			class = "ROGUE",
			duration = 5,
		},
		[108280] = {
			desc = "",
			type = "premade",
			class = "SHAMAN",
			duration = 10,
		},
		[98008] = {
			desc = "",
			type = "premade",
			class = "SHAMAN",
			duration = 6,
		},
		[97462] = {
			desc = "",
			type = "premade",
			class = "WARRIOR",
			duration = 10,
		},
		[159916] = {
			desc = "",
			type = "premade",
			class = "MAGE",
			duration = 6,
		},
	}
end	
		


function VocalRaidAssistant:GetSpellList ()
	return {
		auraApplied ={					-- aura applied [spellid] = ".mp3 file name",
			--general
			--druid
			[102342] = "ironbark",
			[22812] = "barkskin",
			[61336] = "survivalinstincts",
			[155835] = "bristlingfur", --guardian

			--paladin
			[1022] = "handOfProtection", 
			[6940] = "sacrifice", 
			[86659] = "guardianofancientkings",
			[31850] = "ardentdefender",
			[498] = "divineprotection",
			[642] = "divineshield",
			[31842] = "avengingwrath",
			--rogue
			[57934] = "tricksofthetrade",
			--warrior
			[114030] = "vigilance",
			[871] = "shieldwall",
			[12975] = "laststand",
			
			--preist
			[33206] = "painSuppression", 
			[47788] = "guardianSpirit",
			
			--shaman
			[165344] = "ascendance",
			--mage
			
			--dk
			[48792] = "icebound",
			[49028] = "dancingruneweapon",
			[55233] = "vampiricblood",
			--hunter
			[34477] = "misdirection",
			[53480] = "roarofsacrifice",
			--lock
			
			--monk
			[115203] = "fortifyingbrew",
			[116849] = "lifeCocoon",
		},
		auraRemoved = {					-- aura removed [spellid] = ".mp3 file name",
			
		},
		castStart = {					-- cast start [spellid] = ".mp3 file name",
			
		},
		castSuccess = {					--cast success [spellid] = ".mp3 file name",
			--druid
			[740] = "tranquility",
			[106898] = "stampedingRoar",
			[77764] = "stampedingRoar", --cat
			[77761] = "stampedingRoar", --bear
			[20484] = "rebirth",

			
			--paladin	
			[31821] = "devotionaura",
			[633] = "layonHands",

			--rogue
			[76577] = "smokeBomb", 

			--warrior
			[97462] = "rallyingCry", 
			[1160] = "demoralizingshout",
			[64382] = "shatteringthrow",
			--priest
			[64843] = "divineHymn",
			[62618] = "barrier",
			[32375] = "massdispel",
			[15286] = "vampiricembrace",
			--shaman
			[98008] = "spiritlinktotem",
			[108280] = "healingTide",
			[2825] = "bloodLust",
			[32182] = "heroism",
			
			--mage
			[80353] = "timewarp",
			[159916] = "amplifymagic",
			--dk
			[51052] = "antiMagicZone",
			[61999] = "raiseally",
			--hunter
			[90355] = "ancienthysteria",
			[172106] = "aspectofthefox",
			--warlock
			[20707] = "soulstone",
			-- monk
			[115310] = "Revival",
			
		},
		friendlyInterrupt = {			--friendly interrupt [spellid] = ".mp3 file name",
			[19647] = "lockout", -- Spell Lock
			[2139] = "lockout", -- Counter Spell
			[1766] = "lockout", -- Kick
			[6552] = "lockout", -- Pummel
			[47528] = "lockout", -- Mind Freeze
			[96231] = "lockout", -- Rebuke
			[93985] = "lockout", -- Skull Bash
			[97547] = "lockout", -- Solar Beam
			[57994] = "lockout", -- Wind Shear
			[116705] = "lockout", -- Spear Hand Strike
			[113287] = "lockout", -- Symbiosis Solar Beam
			[147362] = "lockout", -- Counter Shot
			[34490] = "lockout", -- Silencing Shot
		},
	}
end

