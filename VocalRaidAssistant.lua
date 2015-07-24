﻿VocalRaidAssistant = LibStub("AceAddon-3.0"):NewAddon("VocalRaidAssistant", "AceEvent-3.0","AceConsole-3.0","AceTimer-3.0")

local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfig = LibStub("AceConfig-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("VocalRaidAssistant")
local LSM = LibStub("LibSharedMedia-3.0")
local self, VRA = VocalRaidAssistant, VocalRaidAssistant
local VRA_TEXT = "VocalRaidAssistant"
local VRA_VERSION = " " .. GetAddOnMetadata("VocalRaidAssistant", "Version")
local VRA_AUTHOR = " updated by Nitrak"
local tankSpecs = {250,104,268,66,73} --Blood DK, Guardian, Brewmaster, Prot Pala, Prot Warr
local bossesAlive = {}
local killBoss = false
--local test = 0

local VRA_LOCALEPATH = {
	enUS = "VocalRaidAssistant\\Voice_enUS",
}
self.VRA_LOCALEPATH = VRA_LOCALEPATH
local VRA_LANGUAGE = {
	
	["VocalRaidAssistant\\Voice_enUS"] = L["English(female)"],
}
self.VRA_LANGUAGE = VRA_LANGUAGE
local VRA_EVENT = {
	SPELL_CAST_SUCCESS = L["Spell cast success"],
	SPELL_CAST_START = L["Spell cast start"],
	SPELL_AURA_APPLIED = L["Spell aura applied"],
	SPELL_AURA_REMOVED = L["Spell aura removed"],
	SPELL_INTERRUPT = L["Spell interrupt"],
	SPELL_SUMMON = L["Spell summon"]
	--UNIT_AURA = "Unit aura changed",
}
self.VRA_EVENT = VRA_EVENT
local VRA_UNIT = {
	any = L["Any"],
	player = L["Player"],
	target = L["Target"],
	focus = L["Focus"],
	mouseover = L["Mouseover"],
	--party = L["Party"],
	--raid = L["Raid"],
	--arena = L["Arena"],
	--boss = L["Boss"],
	custom = L["Custom"], 
}
self.VRA_UNIT = VRA_UNIT
local VRA_TYPE = {
	[COMBATLOG_FILTER_EVERYTHING] = L["Any"],
	[COMBATLOG_FILTER_FRIENDLY_UNITS] = L["Friendly"],
	[COMBATLOG_FILTER_HOSTILE_PLAYERS] = L["Hostile player"],
	[COMBATLOG_FILTER_HOSTILE_UNITS] = L["Hostile unit"],
	[COMBATLOG_FILTER_NEUTRAL_UNITS] = L["Neutral"],
	[COMBATLOG_FILTER_ME] = L["Myself"],
	[COMBATLOG_FILTER_MINE] = L["Mine"],
	[COMBATLOG_FILTER_MY_PET] = L["My pet"],
}
self.VRA_TYPE = VRA_TYPE
local sourcetype,sourceuid,desttype,destuid = {},{},{},{}
local vradb
local PlaySoundFile = PlaySoundFile
local dbDefaults = {
	profile = {
		all = false,
		raid = true,
		instance = true,
		scenario = true,
		
		buffAppliedSpecific = false,
		onlyRaidGroup = true,
		buffAppliedTank = false,
		
		
		field = true,
		path = "VocalRaidAssistant\\Voice_enUS",
		throttle = 0,
		smartDisable = false,
		spells = {},
		spellsO = {},
		spellsB = {},
		dataLock = true,
		
		
		aruaApplied = false,
		aruaRemoved = false,
		castStart = false,
		castSuccess = false,
		interrupt = false,
		
		unholyfrenzy = false,
		icebound = true,
		dancingruneweapon = true,
		vampiricblood = false,
		barkskin = false,
		bristlingfur = false,
		mightofursoc = false,
		survivalinstincts = true,
		guardianofancientkings = true,
		argentdefender = false,
		divineprotection = false,
		divineshield = false,
		shieldwall = true,
		laststand = true,
		demoralizingshout = false,
		shatteringthrow = false,
		ironbark = true,
		
		avengingwrath = false,
		ascendance = false,
		misdirection = false,
		tricksofthetrade = false,
		bloodlust = true,
		heroism = true,
		ancienthysteria = true,
		timewarp = true,
		massdispel = false,
		soulstone = false,
		rebirth = false,
		raiseally = false,
		runetap = false,
		antimagicshell = false,
		ancestralguidance = false,
		gorefiendsgrasp = false,
		naturesvigil = false,
		mockingbanner = false,
		stoneform = false,
		incarnationtree = false,
		sacredshield = false,
		eternalflame = false,
		guard = false,
		
		custom = {},
	}	
}

VRA.log = function(msg) DEFAULT_CHAT_FRAME:AddMessage("|cFF33FF22VocalRaidAssistant|r: "..msg) end

function VocalRaidAssistant:OnInitialize()
	if not self.spellList then
		self.spellList = self:GetSpellList()
	end
	for _,v in pairs(self.spellList) do
		for _,spell in pairs(v) do
			if dbDefaults.profile[spell] == nil then dbDefaults.profile[spell] = true end
		end
	end
	
	self.db1 = LibStub("AceDB-3.0"):New("VocalRaidAssistantDB",dbDefaults, "Default");
	--DEFAULT_CHAT_FRAME:AddMessage(VRA_TEXT .. VRA_VERSION .. VRA_AUTHOR .."  - /VRA ");
	--LibStub("AceConfig-3.0"):RegisterOptionsTable("VocalRaidAssistant", VocalRaidAssistant.Options, {"VocalRaidAssistant", "SS"})
	self:RegisterChatCommand("VocalRaidAssistant", "ShowConfig")
	self:RegisterChatCommand("VRA", "ShowConfig")
	self.db1.RegisterCallback(self, "OnProfileChanged", "ChangeProfile")
	self.db1.RegisterCallback(self, "OnProfileCopied", "ChangeProfile")
	self.db1.RegisterCallback(self, "OnProfileReset", "ChangeProfile")
	vradb = self.db1.profile
	
	

		-- Some sounds (copied from Omen).
		LSM:Register("sound", "Rubber Ducky", [[Sound\Doodad\Goblin_Lottery_Open01.wav]])
		LSM:Register("sound", "Cartoon FX", [[Sound\Doodad\Goblin_Lottery_Open03.wav]])
		LSM:Register("sound", "Explosion", [[Sound\Doodad\Hellfire_Raid_FX_Explosion05.wav]])
		LSM:Register("sound", "Shing!", [[Sound\Doodad\PortcullisActive_Closed.wav]])
		LSM:Register("sound", "Wham!", [[Sound\Doodad\PVP_Lordaeron_Door_Open.wav]])
		LSM:Register("sound", "Simon Chime", [[Sound\Doodad\SimonGame_LargeBlueTree.wav]])
		LSM:Register("sound", "War Drums", [[Sound\Event Sounds\Event_wardrum_ogre.wav]])
		LSM:Register("sound", "Cheer", [[Sound\Event Sounds\OgreEventCheerUnique.wav]])
		LSM:Register("sound", "Humm", [[Sound\Spells\SimonGame_Visual_GameStart.wav]])
		LSM:Register("sound", "Short Circuit", [[Sound\Spells\SimonGame_Visual_BadPress.wav]])
		LSM:Register("sound", "Fel Portal", [[Sound\Spells\Sunwell_Fel_PortalStand.wav]])
		LSM:Register("sound", "Fel Nova", [[Sound\Spells\SeepingGaseous_Fel_Nova.wav]])
		LSM:Register("sound", "You Will Die!", [[Sound\Creature\CThun\CThunYouWillDie.wav]])
		LSM:Register("sound", "Beware", [[Sound\Creature\AlgalonTheObserver\UR_Algalon_BHole01.ogg]])
	
	
	local options = {
		name = "Vocal Raid Assistant",
		desc = L["PVE Voice Alert"],
		type = 'group',
		args = {
			general = {
				order = 1,
				type = "group",
				name = L["Vocal Raid Assistant"],
				desc = L["VOCAL_RAID_ASSISTANCE_DESC"],
				args = {
					general = {
						order = 1,
						type = "header",
						name = L["GENERAL_HEADER"],
					},
					desc1 = {
						order = 2,
						type = "description",
						name = L["GENERAL_DESCRIPTION"],
					},
					abilities = {
						order = 3,
						type = "header",
						name = L["ABILITIES_HEADER"],
					},
					desc2 = {
						order = 4,
						type = "description",
						name = L["ABILITIES_DESCRIPTION"],
					},
					individual = {
						order = 5,
						type = "header",
						name = L["INDIVIDUAL_HEADER"],
					},
					desc3 = {
						order = 6,
						type = "description",
						name = L["ASSINGMENT_DESCRIPTION"],
					},
					custom = {
						order = 7,
						type = "header",
						name = L["CUSTOM_ABILITIES_HEADER"],
					},
					desc7 = {
						order = 8,
						type = "description",
						name = L["CUSTOM_ABILITIES_DESCRIPTION"],
					},
				},	
			},
			general2 = {
				order = 2,
				type = "group",
				name = L["Version"],
				desc = L["VERSION_DESC"],
				args = {
					version = {
						order = -700,
						type = "description",
						name = "Current version: " .. L["GET_VERSION"] .. "\n",
					},
					header14 = {
							order = -28,
							type = "header",
							name = "1.2.1",
					},
					desc14 = {
						order	= -27,
						type	= "description",
						name	= L["1.2.1 Changelog"],
					},
					header13 = {
							order = -26,
							type = "header",
							name = "1.2",
					},
					desc13 = {
						order	= -25,
						type	= "description",
						name	= L["1.2 Changelog"],
					},
					header12 = {
							order = -24,
							type = "header",
							name = "1.1.2",
					},
					desc12 = {
						order	= -23,
						type	= "description",
						name	= L["1.1.2 Changelog"],
					},
					header11 = {
							order = -22,
							type = "header",
							name = "1.1.1",
					},
					desc11 = {
						order	= -21,
						type	= "description",
						name	= L["1.1.1 Changelog"],
					},
					header10 = {
							order = -20,
							type = "header",
							name = "1.1.0",
					},
					desc10 = {
						order	= -19,
						type	= "description",
						name	= L["1.1.0 Changelog"],
					},
					header9 = {
							order = -18,
							type = "header",
							name = "1.0.9",
					},
					desc9 = {
						order	= -17,
						type	= "description",
						name	= L["1.0.9 Changelog"],
					},
					header8 = {
							order = -16,
							type = "header",
							name = "1.0.8",
					},
					desc8 = {
						order	= -15,
						type	= "description",
						name	= L["1.0.8 Changelog"],
					},
					header7 = {
							order = -14,
							type = "header",
							name = "1.0.7",
					},
					desc7 = {
						order	= -13,
						type	= "description",
						name	= L["1.0.7 Changelog"],
					},
					header6 = {
							order = -12,
							type = "header",
							name = "1.0.6",
					},
					desc6 = {
						order	= -11,
						type	= "description",
						name	= L["1.0.6 Changelog"],
					},
					header5 = {
							order = -10,
							type = "header",
							name = "1.0.5",
					},
					desc5 = {
						order	= -9,
						type	= "description",
						name	= L["1.0.5 Changelog"],
					},
					header4 = {
							order = -8,
							type = "header",
							name = "1.0.4",
					},
					desc4 = {
						order	= -7,
						type	= "description",
						name	= L["1.0.4 Changelog"],
					},
					header3 = {
							order = -6,
							type = "header",
							name = "1.0.3",
					},
					desc3 = {
						order	= -5,
						type	= "description",
						name	= L["1.0.3 Changelog"],
					},
					header2 = {
							order = -4,
							type = "header",
							name = "1.0.2",
					},
					desc2 = {
						order	= -3,
						type	= "description",
						name	= L["1.0.2 Changelog"],
					},
					header1 = {
							order = -2,
							type = "header",
							name = "1.0.1",
					},
					desc1 = {
						order	= -1,
						type	= "description",
						name	= L["1.0.1 Changelog"],
					},
				},	
			},			
		},
	}
	local bliz_options = CopyTable(options)
	
	LibStub("AceConfig-3.0"):RegisterOptionsTable("VocalRaidAssistant_bliz", bliz_options)
	AceConfigDialog:AddToBlizOptions("VocalRaidAssistant_bliz", "VocalRaidAssistant")
	self:OnOptionCreate() 
	
end
function VocalRaidAssistant:OnEnable()
	VocalRaidAssistant:RegisterEvent("PLAYER_ENTERING_WORLD")
	VocalRaidAssistant:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	VocalRaidAssistant:RegisterEvent("GROUP_ROSTER_UPDATE","UpdateRoster")
		
	--VocalRaidAssistant:RegisterEvent("UNIT_AURA")
	if not VRA_LANGUAGE[vradb.path] then vradb.path = VRA_LOCALEPATH[GetLocale()] end
	self.throttled = {}
	self.smarter = 0
end

function VocalRaidAssistant:OnDisable()

end




-- play sound by file name
function VRA:PlaySound(fileName, extend)
	PlaySoundFile("Interface\\Addons\\"..vradb.path.."\\"..fileName .. "." .. (extend or "ogg"), "Master")
end

function VocalRaidAssistant:ArenaClass(id)
	for i = 1 , 5 do
		if id == UnitGUID("arena"..i) then
			return select(2, UnitClass ("arena"..i))
		end
	end
end

function VocalRaidAssistant:PLAYER_ENTERING_WORLD()
	--CombatLogClearEntries()
end

function VocalRaidAssistant:isTankSpec(name)
	local spec = UnitGroupRolesAssigned(name)
	for i=1,5 do
		if spec=="TANK" then
			return true
		end
	end

	return false
	
end

-- play sound by spell id and spell type
function VocalRaidAssistant:PlaySpell(listName, spellID, ...)
	local list = self.spellList[listName]
	if not list[spellID] then return end
	if not vradb[list[spellID]] then return	end
	if vradb.throttle ~= 0 and self:Throttle("playspell",vradb.throttle) then return end
	if vradb.smartDisable then
		if (GetNumGroupMembers() or 0) > 20 then return end
		if self:Throttle("smarter",20) then
			self.smarter = self.smarter + 1
			if self.smarter > 30 then return end
		else 
			self.smarter = 0
		end
	end
	self:PlaySound(list[spellID]);
end
function VocalRaidAssistant:COMBAT_LOG_EVENT_UNFILTERED(event , ...)
	local _,currentZoneType = IsInInstance()
	if (not ((currentZoneType == "none" and vradb.field) or (currentZoneType == "pvp" and vradb.battleground) or (currentZoneType == "arena" and vradb.arena) or (currentZoneType == "party" and vradb.instance) or (currentZoneType == "raid" and vradb.raid) or (currentZoneType == nil and vradb.scenario) or vradb.all)) then
		return
	end
	local timestamp,event,hideCaster,sourceGUID,sourceName,sourceFlags,sourceFlags2,destGUID,destName,destFlags,destFlags2,spellID,spellName= select ( 1 , ... );
	if not VRA_EVENT[event] then return end

	if (destFlags) then
		for k in pairs(VRA_TYPE) do
			desttype[k] = CombatLog_Object_IsA(destFlags,k)
			--log("desttype:"..k.."="..(desttype[k] or "nil"))
		end
	else
		for k in pairs(VRA_TYPE) do
			desttype[k] = nil
		end
	end
	if (destGUID) then
		for k in pairs(VRA_UNIT) do
			destuid[k] = (UnitGUID(k) == destGUID)
			--log("destuid:"..k.."="..(destuid[k] and "true" or "false"))
		end
	else
		for k in pairs(VRA_UNIT) do
			destuid[k] = nil
			--log("destuid:"..k.."="..(destuid[k] and "true" or "false"))
		end
	end
	destuid.any = true
	if (sourceFlags) then
		for k in pairs(VRA_TYPE) do
			sourcetype[k] = CombatLog_Object_IsA(sourceFlags,k)
			--log("sourcetype:"..k.."="..(sourcetype[k] or "nil"))
		end
	else
		for k in pairs(VRA_TYPE) do
			sourcetype[k] = nil
			--log("sourcetype:"..k.."="..(sourcetype[k] or "nil"))
		end
	end
	if (sourceGUID) then
		for k in pairs(VRA_UNIT) do
			sourceuid[k] = (UnitGUID(k) == sourceGUID)
			--log("sourceuid:"..k.."="..(sourceuid[k] and "true" or "false"))
		end
	else
		for k in pairs(VRA_UNIT) do
			sourceuid[k] = nil
			--log("sourceuid:"..k.."="..(sourceuid[k] and "true" or "false"))
		end
	end
	sourceuid.any = true
	--print (destuid.target,sourceName,destName)
	--[[debug
	if (spellID == 80964 or spellID == 80965 or spellID == 85285) then 
		print (sourceName,destName,event,spellName,spellID)
	end
	enddebug]]--
	
	
	if (UnitExists("boss1")) then
		killBoss = true
	elseif (killBoss and not UnitAffectingCombat("player")) then
		killBoss = false
		VRA:bossWipe()
	end
	
	if(spellID==123402) then
		spellID = 115295 --To make improved guard equal to guard
	end
	
	
	if (event == "SPELL_AURA_APPLIED" and desttype[COMBATLOG_FILTER_ME] and not sourcetype[COMBATLOG_FILTER_ME] and (not vradb.aonlyTF or destuid.target or destuid.focus) and not vradb.aruaApplied) then
		if(not vradb.buffAppliedSpecific) then
					if(vradb.buffAppliedTank) then
						if(self:isTankSpec(destName)) then
							self:PlaySpell("auraApplied", spellID)
						end
					else
						self:PlaySpell("auraApplied", spellID)
					end
			
		else
			if(IsInRaid() or IsInGroup()) then
				if(self:IsSelected(destName)) then
					self:PlaySpell("auraApplied", spellID)
				end
			else
				self:PlaySpell("auraApplied", spellID)
			end
		end
	elseif (event == "SPELL_AURA_APPLIED" and desttype[COMBATLOG_FILTER_FRIENDLY_UNITS] and not sourcetype[COMBATLOG_FILTER_ME] and (not vradb.aonlyTF or destuid.target or destuid.focus) and not vradb.aruaApplied) then
		if(not vradb.buffAppliedSpecific) then
			if(vradb.onlyRaidGroup) then
				if((UnitInRaid(destName))~=nil or (UnitInParty(destName))~=false) then
					if(vradb.buffAppliedTank) then
						if(self:isTankSpec(destName)) then
							self:PlaySpell("auraApplied", spellID)
						end
					else
						self:PlaySpell("auraApplied", spellID)
					end
				end
			else
				if(vradb.buffAppliedTank) then
					if(self:isTankSpec(destName)) then
						self:PlaySpell("auraApplied", spellID)
					end
				else
					self:PlaySpell("auraApplied", spellID)
				end
			end
		else
			if(IsInRaid() or IsInGroup()) then
				if(self:IsSelected(destName)) then
					self:PlaySpell("auraApplied", spellID)
				end
			else
				self:PlaySpell("auraApplied", spellID)
			end
		end
	elseif (event == "SPELL_AURA_REMOVED" and desttype[COMBATLOG_FILTER_FRIENDLY_UNITS] and (not vradb.ronlyTF or destuid.target or destuid.focus) and not vradb.auraRemoved) then
		if(vradb.onlyRaidGroup) then
			if(UnitInRaid(sourceName) or UnitInParty(sourceName)) then
				self:PlaySpell("auraRemoved", spellID)
			end
		else
			self:PlaySpell("auraRemoved", spellID)
		end
	elseif (event == "SPELL_CAST_START" and sourcetype[COMBATLOG_FILTER_FRIENDLY_UNITS] and (not vradb.conlyTF or sourceuid.target or sourceuid.focus) and not vradb.castStart) then
		if(vradb.onlyRaidGroup) then
			if(UnitInRaid(sourceName) or UnitInParty(sourceName)) then
				self:PlaySpell("castStart", spellID)
			end
		else
			self:PlaySpell("castStart", spellID)
		end
	elseif ((event == "SPELL_CAST_SUCCESS" or event == "SPELL_SUMMON") and sourcetype[COMBATLOG_FILTER_FRIENDLY_UNITS] and (not vradb.sonlyTF or sourceuid.target or sourceuid.focus) and not vradb.castSuccess) then
		if self:Throttle(tostring(spellID).."default", 0.05) then return end
		if (spellID == 42292 or spellID == 59752) and vradb.class and currentZoneType == "arena" then
			local c = self:ArenaClass(sourceGUID)
			if c then 
				self:PlaySound(c);
			end
		else
			if(vradb.onlyRaidGroup and vradb.buffAppliedTank and not vradb.buffAppliedSpecific) then
				if(UnitInRaid(sourceName) or UnitInParty(sourceName)) then
					if(self:isTankSpec(sourceName)) then
						self:PlaySpell("castSuccess", spellID)
					end
				end
			elseif(vradb.onlyRaidGroup and not vradb.buffAppliedSpecific) then
				if(UnitInRaid(sourceName) or UnitInParty(sourceName)) then
					self:PlaySpell("castSuccess", spellID)
				end
			elseif(vradb.buffAppliedSpecific) then
				if(IsInRaid() or IsInGroup()) then
					if(self:IsSelected(sourceName)) then
						self:PlaySpell("auraApplied", spellID)
					end	
				end
			else
				self:PlaySpell("castSuccess", spellID)
			end
		end
	elseif ((event == "SPELL_CAST_SUCCESS" or event == "SPELL_SUMMON") and sourcetype[COMBATLOG_FILTER_ME] and (not vradb.sonlyTF or sourceuid.target or sourceuid.focus) and not vradb.castSuccess) then
		
				--print(sourceName.. " " ..spellID)
			
			
	elseif (event == "SPELL_INTERRUPT" and (desttype[COMBATLOG_FILTER_HOSTILE_PLAYERS] or desttype[COMBATLOG_FILTER_HOSTILE_UNITS]) and not vradb.interrupt) then 
		if(vradb.onlyRaidGroup) then
				if(UnitInRaid(sourceName) or UnitInParty(sourceName)) then
					self:PlaySpell ("friendlyInterrupt", spellID)
				end
		else
			self:PlaySpell ("friendlyInterrupt", spellID)
		end
	end
	
	-- play custom spells
	for k, css in pairs (vradb.custom) do
		if css.destuidfilter == "custom" and destName == css.destcustomname then 
			destuid.custom = true  
		else 
			destuid.custom = false 
		end
		if css.sourceuidfilter == "custom" and sourceName == css.sourcecustomname then
			sourceuid.custom = true  
		else
			sourceuid.custom = false 
		end
		if css.eventtype[event] and destuid[css.destuidfilter] and desttype[css.desttypefilter] and sourceuid[css.sourceuidfilter] and sourcetype[css.sourcetypefilter] and spellID == tonumber(css.spellid) then
			if self:Throttle(tostring(spellID)..css.name, 0.1) then return end
			PlaySoundFile(css.soundfilepath, "Master")
		end
	end
end


function VocalRaidAssistant:Throttle(key,throttle)
	if (not self.throttled) then
		self.throttled = {}
	end
	-- Throttling of Playing
	if (not self.throttled[key]) then
		self.throttled[key] = GetTime()+throttle
		return false
	elseif (self.throttled[key] < GetTime()) then
		self.throttled[key] = GetTime()+throttle
		return false
	else
		return true
	end
end 