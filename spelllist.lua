function VocalRaidAssistant:GetSpellList ()
	return {
		auraApplied ={					-- aura applied [spellid] = ".mp3 file name",
			--general
			--druid
			[29166] = "innervate",
			[102342] = "ironbark",

			--paladin
			[1022] = "handOfProtection", 
			[6940] = "sacrifice", 
			
			--rogue
			[57934] = "tricksofthetrade",
			--warrior
			[114030] = "vigilance",

			--preist
			[33206] = "painSuppression", 
			[47788] = "guardianSpirit",
			
			--shaman
			
			--mage
			
			--dk
			
			--hunter
			[34477] = "misdirection",
			--lock
			
			--monk
			
			[116849] = "lifeCocoon",
		},
		auraRemoved = {					-- aura removed [spellid] = ".mp3 file name",
			
		},
		castStart = {					-- cast start [spellid] = ".mp3 file name",
			
		},
		castSuccess = {					--cast success [spellid] = ".mp3 file name",
			--druid
			[740] = "tranquility",
			[110707] = "smassdispel",
			[106898] = "stampedingRoar",
			[77764] = "stampedingRoar", --cat
			[77761] = "stampedingRoar", --bear
			[20484] = "rebirth",
			
			--paladin	
			[31821] = "auraMastery",
			[633] = "layonHands",

			--rogue
			[76577] = "smokeBomb", 

			--warrior
			[97462] = "rallyingCry", 
			[114207] = "skullBanner",
			[114203] = "demoralizingBanner",
			[122294] = "sstampedingshout",
			--priest
			[64843] = "divineHymn",
			[64901] = "hymnOfHope",
			[62618] = "barrier",
			[32375] = "massdispel",
			[113277] = "stranquility",
			[15286] = "vampiricembrace",
			--shaman
			[16190] = "ManaTide",
			[98008] = "spiritlinktotem",
			[108280] = "healingTide",
			[120668] = "stormlash",
			[2825] = "bloodLust",
			[32182] = "heroism",
			--mage
			[80353] = "timewarp",
			--dk
			[51052] = "antiMagicZone",
			[61999] = "raiseally",
			--hunter
			[90355] = "ancienthysteria",
			--warlock
			[20707] = "soulstone",
			-- monk
			[115213] = "avertHarm",
			[115310] = "revival",
			
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

