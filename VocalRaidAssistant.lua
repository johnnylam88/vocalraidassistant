VocalRaidAssistant = LibStub("AceAddon-3.0"):NewAddon("VocalRaidAssistant", "AceEvent-3.0","AceConsole-3.0","AceTimer-3.0")

local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfig = LibStub("AceConfig-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("VocalRaidAssistant")
local LSM = LibStub("LibSharedMedia-3.0")
local self, VRA = VocalRaidAssistant, VocalRaidAssistant
local VRA_TEXT = "VocalRaidAssistant"
local VRA_VERSION = " " .. GetAddOnMetadata("VocalRaidAssistant", "Version")
local VRA_AUTHOR = " updated by Nitrak"
local tankSpecs = {250,104,268,66,73} --Blood DK, Guardian, Brewmaster, Prot Pala, Prot Warr
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
		onlyRaidGroup = true,
		buffAppliedTank = false,
		field = true,
		path = "VocalRaidAssistant\\Voice_enUS",
		throttle = 0,
		smartDisable = false,
		
		
		aruaApplied = false,
		aruaRemoved = false,
		castStart = false,
		castSuccess = false,
		interrupt = false,
		
		innervate = false,
		misdirection = false,
		tricksofthetrade = false,
		bloodlust = false,
		heroism = false,
		ancienthysteria = false,
		timewarp = false,
		massdispel = false,
		smassdispel = false,
		
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
					custom = {
						order = 5,
						type = "header",
						name = L["CUSTOM_ABILITIES_HEADER"],
					},
					desc3 = {
						order = 6,
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
						order = 1,
						type = "description",
						name = "Current version: " .. L["GET_VERSION"] .. "\n",
					},
					header1 = {
							order = 2,
							type = "header",
							name = "1.0.3",
					},
					desc1 = {
						order	= 3,
						type	= "description",
						name	= L["1.0.3 Changelog"],
					},
					header2 = {
							order = 4,
							type = "header",
							name = "1.0.2",
					},
					desc2 = {
						order	= 5,
						type	= "description",
						name	= L["1.0.2 Changelog"],
					},
					header3 = {
							order = 6,
							type = "header",
							name = "1.0.1",
					},
					desc3 = {
						order	= 7,
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

	for i=1,5 do
		if GetInspectSpecialization(name)==tankSpecs[i] then
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
	if (not ((currentZoneType == "none" and vradb.field) or (currentZoneType == "raid" and vradb.raid) or vradb.all)) then
		return
	end
	local timestamp,event,hideCaster,sourceGUID,sourceName,sourceFlags,sourceFlags2,destGUID,destName,destFlags,destFlags2,spellID,spellName= select ( 1 , ... );
	if not VRA_EVENT[event] then return end
	--print(playerName,sourceName,destName,destFlags,event,spellName,spellID)
	--print(GetInspectSpecialization(destName))
	--if GetInspectSpecialization(destName)==tankSpecs[2] then
	--	print("test")
	--end
	
	--if(test==0) then
	--	for i=1, GetNumGroupMembers() do
	--		name = GetRaidRosterInfo(i)
	--		print(name)
	--	end
	--	test=1
	--end
	
	--if(self:isTankSpec(destName)) then
	--	print("TANK!!!!!")
	--end
	
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
	if (event == "SPELL_AURA_APPLIED" and desttype[COMBATLOG_FILTER_ME] and not sourcetype[COMBATLOG_FILTER_ME] and (not vradb.aonlyTF or destuid.target or destuid.focus) and not vradb.aruaApplied) then
		if(vradb.onlyRaidGroup) then
			if(UnitInRaid(destName) or UnitInParty(destName)) then
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
	elseif (event == "SPELL_AURA_APPLIED" and desttype[COMBATLOG_FILTER_FRIENDLY_UNITS] and (not vradb.aonlyTF or destuid.target or destuid.focus) and not vradb.aruaApplied) then
		if(vradb.onlyRaidGroup) then
			if(UnitInRaid(destName) or UnitInParty(destName)) then
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
			if(vradb.onlyRaidGroup) then
				if(UnitInRaid(sourceName) or UnitInParty(sourceName)) then
					self:PlaySpell("castSuccess", spellID)
				end
			else
				self:PlaySpell("castSuccess", spellID)
			end
		end
	elseif (event == "SPELL_INTERRUPT" and desttype[COMBATLOG_FILTER_HOSTILE_PLAYERS] and not vradb.interrupt) then 
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