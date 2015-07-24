function VocalRaidAssistant:GetSpellList ()
	return {
		auraApplied ={					-- aura applied [spellid] = ".mp3 file name",
			--general
			[20594] = "stoneform",
			--druid
			[102342] = "ironbark",
			[22812] = "barkskin",
			[61336] = "survivalinstincts",
			[155835] = "bristlingfur", --guardian
			[33891] = "incarnationtree", --resto

			--paladin
			[1022] = "handOfProtection", 
			[6940] = "sacrifice", 
			[86659] = "guardianofancientkings",
			[31850] = "ardentdefender",
			[498] = "divineprotection",
			[642] = "divineshield",
			[31842] = "avengingwrath",
			[148039] = "sacredshield",
			[156322] = "eternalflame",
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
			[114052] = "ascendance",
			--mage
			
			--dk
			[48792] = "icebound",
			[49028] = "dancingruneweapon",
			[55233] = "vampiricblood",
			[48707] = "antimagicshell",
			[48982] = "runetap",
			--hunter
			[34477] = "misdirection",
			[53480] = "roarofsacrifice",
			--lock
			
			--monk
			[115203] = "fortifyingbrew",
			[116849] = "lifeCocoon",
			[115295] = "guard",
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
			[124974] = "naturesvigil",

			
			--paladin	
			[31821] = "devotionaura",
			[633] = "layonHands",

			--rogue
			[76577] = "smokeBomb", 

			--warrior
			[97462] = "rallyingCry", 
			[1160] = "demoralizingshout",
			[64382] = "shatteringthrow",
			[114192] = "mockingbanner",
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
			[108281] = "ancestralguidance",
			
			--mage
			[80353] = "timewarp",
			[159916] = "amplifymagic",
			--dk
			[51052] = "antiMagicZone",
			[61999] = "raiseally",
			[108199] = "gorefiendsgrasp",
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

