local VRA = VocalRaidAssistant
local vradb
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfig = LibStub("AceConfig-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("VocalRaidAssistant")
local LSM = LibStub("LibSharedMedia-3.0")
local rosterInfoArray = {}
local rosterStatusArray = {}
local rosterStatusOldArray = {}
local rosterNameArray = {}
local testnull = 0
local first = true
local raidMaxSize = 40

function VRA:ShowConfig()
	InterfaceOptionsFrame_OpenToCategory(GetAddOnMetadata("VocalRaidAssistant", "Title"))
	InterfaceOptionsFrame_OpenToCategory(GetAddOnMetadata("VocalRaidAssistant", "Title"))
end

function VRA:ChangeProfile()
	vradb = self.db1.profile
	for k,v in VocalRaidAssistant:IterateModules() do
		if type(v.ChangeProfile) == 'function' then
			v:ChangeProfile()
		end
	end
end

function VRA:AddOption(name, keyName)
	
	return AceConfigDialog:AddToBlizOptions("VocalRaidAssistant", name, "VocalRaidAssistant", keyName)
end

function VRA:UpdateRoster()
	
	rosterStatusOldArray[1] = vradb.raid1
	rosterStatusOldArray[2] = vradb.raid2
	rosterStatusOldArray[3] = vradb.raid3
	rosterStatusOldArray[4] = vradb.raid4
	rosterStatusOldArray[5] = vradb.raid5
	rosterStatusOldArray[6] = vradb.raid6
	rosterStatusOldArray[7] = vradb.raid7
	rosterStatusOldArray[8] = vradb.raid8
	rosterStatusOldArray[9] = vradb.raid9
	rosterStatusOldArray[10] = vradb.raid10
	rosterStatusOldArray[11] = vradb.raid11
	rosterStatusOldArray[12] = vradb.raid12
	rosterStatusOldArray[13] = vradb.raid13
	rosterStatusOldArray[14] = vradb.raid14
	rosterStatusOldArray[15] = vradb.raid15
	rosterStatusOldArray[16] = vradb.raid16
	rosterStatusOldArray[17] = vradb.raid17
	rosterStatusOldArray[18] = vradb.raid18
	rosterStatusOldArray[19] = vradb.raid19
	rosterStatusOldArray[20] = vradb.raid20
	rosterStatusOldArray[21] = vradb.raid21
	rosterStatusOldArray[22] = vradb.raid22
	rosterStatusOldArray[23] = vradb.raid23
	rosterStatusOldArray[24] = vradb.raid24
	rosterStatusOldArray[25] = vradb.raid25
	rosterStatusOldArray[26] = vradb.raid26
	rosterStatusOldArray[27] = vradb.raid27
	rosterStatusOldArray[28] = vradb.raid28
	rosterStatusOldArray[29] = vradb.raid29
	rosterStatusOldArray[30] = vradb.raid30
	rosterStatusOldArray[31] = vradb.raid31
	rosterStatusOldArray[32] = vradb.raid32
	rosterStatusOldArray[33] = vradb.raid33
	rosterStatusOldArray[34] = vradb.raid34
	rosterStatusOldArray[35] = vradb.raid35
	rosterStatusOldArray[36] = vradb.raid36
	rosterStatusOldArray[37] = vradb.raid37
	rosterStatusOldArray[38] = vradb.raid38
	rosterStatusOldArray[39] = vradb.raid39
	rosterStatusOldArray[40] = vradb.raid40
	
	for i=1,raidMaxSize do
		if GetRaidRosterInfo(i) ~= nil then
			rosterNameArray[i] = GetRaidRosterInfo(i)
		else
			rosterNameArray[i] = ""
		end
		
	end
	
	for i=1,raidMaxSize do
		local found = false
		for j=1,raidMaxSize do
			if(rosterNameArray[i] == rosterInfoArray[j]) then
			found = true
				if(rosterStatusOldArray[j] ~= nil) then
					rosterStatusArray[i] = rosterStatusOldArray[j]
				end
			end
		end
		if(not found and not first) then
			rosterStatusArray[i] = false
		end
		if(first) then
			rosterStatusArray[i] = rosterStatusOldArray[i]
		end
		
	end
	
	first = false
	
	for i=1,raidMaxSize do
		rosterInfoArray[i] = rosterNameArray[i]
		--rosterStatusOldArray[i] = rosterStatusArray[i]
	end
	
	vradb.raid1 = rosterStatusArray[1]
	vradb.raid2 = rosterStatusArray[2]
	vradb.raid3 = rosterStatusArray[3]
	vradb.raid4 = rosterStatusArray[4]
	vradb.raid5 = rosterStatusArray[5]
	vradb.raid6 = rosterStatusArray[6]
	vradb.raid7 = rosterStatusArray[7]
	vradb.raid8 = rosterStatusArray[8]
	vradb.raid9 = rosterStatusArray[9]
	vradb.raid10 = rosterStatusArray[10]
	vradb.raid11 = rosterStatusArray[11]
	vradb.raid12 = rosterStatusArray[12]
	vradb.raid13 = rosterStatusArray[13]
	vradb.raid14 = rosterStatusArray[14]
	vradb.raid15 = rosterStatusArray[15]
	vradb.raid16 = rosterStatusArray[16]
	vradb.raid17 = rosterStatusArray[17]
	vradb.raid18 = rosterStatusArray[18]
	vradb.raid19 = rosterStatusArray[19]
	vradb.raid20 = rosterStatusArray[20]
	vradb.raid21 = rosterStatusArray[21]
	vradb.raid22 = rosterStatusArray[22]
	vradb.raid23 = rosterStatusArray[23]
	vradb.raid24 = rosterStatusArray[24]
	vradb.raid25 = rosterStatusArray[25]
	vradb.raid26 = rosterStatusArray[26]
	vradb.raid27 = rosterStatusArray[27]
	vradb.raid28 = rosterStatusArray[28]
	vradb.raid29 = rosterStatusArray[29]
	vradb.raid30 = rosterStatusArray[30]
	vradb.raid31 = rosterStatusArray[31]
	vradb.raid32 = rosterStatusArray[32]
	vradb.raid33 = rosterStatusArray[33]
	vradb.raid34 = rosterStatusArray[34]
	vradb.raid35 = rosterStatusArray[35]
	vradb.raid36 = rosterStatusArray[36]
	vradb.raid37 = rosterStatusArray[37]
	vradb.raid38 = rosterStatusArray[38]
	vradb.raid39 = rosterStatusArray[39]
	vradb.raid40 = rosterStatusArray[40]
	
	
	if(testnull == 1) then
	LibStub("AceConfigRegistry-3.0"):NotifyChange("VocalRaidAssistant")
	else 
	testnull = 1
	end
	
end

function VRA:IsSelected(name)
	
	rosterStatusOldArray[1] = vradb.raid1
	rosterStatusOldArray[2] = vradb.raid2
	rosterStatusOldArray[3] = vradb.raid3
	rosterStatusOldArray[4] = vradb.raid4
	rosterStatusOldArray[5] = vradb.raid5
	rosterStatusOldArray[6] = vradb.raid6
	rosterStatusOldArray[7] = vradb.raid7
	rosterStatusOldArray[8] = vradb.raid8
	rosterStatusOldArray[9] = vradb.raid9
	rosterStatusOldArray[10] = vradb.raid10
	rosterStatusOldArray[11] = vradb.raid11
	rosterStatusOldArray[12] = vradb.raid12
	rosterStatusOldArray[13] = vradb.raid13
	rosterStatusOldArray[14] = vradb.raid14
	rosterStatusOldArray[15] = vradb.raid15
	rosterStatusOldArray[16] = vradb.raid16
	rosterStatusOldArray[17] = vradb.raid17
	rosterStatusOldArray[18] = vradb.raid18
	rosterStatusOldArray[19] = vradb.raid19
	rosterStatusOldArray[20] = vradb.raid20
	rosterStatusOldArray[21] = vradb.raid21
	rosterStatusOldArray[22] = vradb.raid22
	rosterStatusOldArray[23] = vradb.raid23
	rosterStatusOldArray[24] = vradb.raid24
	rosterStatusOldArray[25] = vradb.raid25
	rosterStatusOldArray[26] = vradb.raid26
	rosterStatusOldArray[27] = vradb.raid27
	rosterStatusOldArray[28] = vradb.raid28
	rosterStatusOldArray[29] = vradb.raid29
	rosterStatusOldArray[30] = vradb.raid30
	rosterStatusOldArray[31] = vradb.raid31
	rosterStatusOldArray[32] = vradb.raid32
	rosterStatusOldArray[33] = vradb.raid33
	rosterStatusOldArray[34] = vradb.raid34
	rosterStatusOldArray[35] = vradb.raid35
	rosterStatusOldArray[36] = vradb.raid36
	rosterStatusOldArray[37] = vradb.raid37
	rosterStatusOldArray[38] = vradb.raid38
	rosterStatusOldArray[39] = vradb.raid39
	rosterStatusOldArray[40] = vradb.raid40
	
	for i=1,raidMaxSize do
		if(rosterNameArray[i]==name) then
			if(rosterStatusOldArray[i]==true) then
				return true
			end
		end
	end
	return false
end


local function setOption(info, value)
	local name = info[#info]
	vradb[name] = value
	if value then 
		PlaySoundFile("Interface\\Addons\\"..vradb.path.."\\"..name..".ogg","Master");
	end
end
local function getOption(info)
	local name = info[#info]
	return vradb[name]
end
local function spellOption(order, spellID, ...)
	local spellname, _, icon = GetSpellInfo(spellID)	
	if (spellname ~= nil) then
		return {
			type = 'toggle',
			name = "\124T" .. icon .. ":24\124t" .. spellname,							
			desc = function () 
				GameTooltip:SetHyperlink(GetSpellLink(spellID));
				--GameTooltip:Show();
			end,
			descStyle = "custom",
					order = order,
		}
	else
		VRA.log("spell id: " .. spellID .. " is invalid")
		return {
			type = 'toggle',
			name = "unknown spell, id:" .. spellID,	
			order = order,
		}
	end
end

local function listOption(spellList, listType, ...)
	local args = {}
	for k, v in pairs(spellList) do
		if VRA.spellList[listType][v] then
			rawset (args, VRA.spellList[listType][v] ,spellOption(k, v))
		else 
		--[[debug
			print (v)
		]]
		end
	end
	return args
end

function VRA:MakeCustomOption(key)
	local options = self.options.args.custom.args
	local db = vradb.custom
	options[key] = {
		type = 'group',
		name = function() return db[key].name end,
		set = function(info, value) local name = info[#info] db[key][name] = value end,
		get = function(info) local name = info[#info] return db[key][name] end,
		order = db[key].order,
		args = {
			name = {
				name = L["name"],
				type = 'input',
				set = function(info, value)
					if db[value] then VRA.log(L["same name already exists"]) return end
					db[value] = db[key]
					db[value].name = value
					db[value].order = #db + 1
					db[value].soundfilepath = "Interface\\VRASound\\"..value..".ogg"
					db[key] = nil
					--makeoption(value)
					options[value] = options[key]
					options[key] = nil
					key = value
				end,
				order = 10,
			},
			spellid = {
				name = L["spellid"],
				type = 'input',
				order = 20,
				pattern = "%d+$",
			},
			remove = {
				type = 'execute',
				order = 25,
				name = L["Remove"],
				confirm = true,
				confirmText = L["Are you sure?"],
				func = function() 
					db[key] = nil
					options[key] = nil
				end,
			},
			test = {
				type = 'execute',
				order = 28,
				name = L["Test"],
				func = function() PlaySoundFile(db[key].soundfilepath, "Master") end,
			},
			existingsound = {
				name = L["Use existing sound"],
				type = 'toggle',
				order = 30,
			},
			existinglist = {
				name = L["choose a sound"],
				type = 'select',
				dialogControl = 'LSM30_Sound',
				values =  LSM:HashTable("sound"),
				disabled = function() return not db[key].existingsound end,
				order = 40,
			},
			NewLine3 = {
				type= 'description',
				order = 45,
				name= '',
			},
			soundfilepath = {
				name = L["file path"],
				type = 'input',
				width = 'double',
				order = 27,
				disabled = function() return db[key].existingsound end,
			},
			eventtype = {
				type = 'multiselect',
				order = 50,
				name = L["event type"],
				values = self.VRA_EVENT,
				get = function(info, k) return db[key].eventtype[k] end,
				set = function(info, k, v) db[key].eventtype[k] = v end,
			},
			sourceuidfilter = {
				type = 'select',
				order = 61,
				name = L["Source unit"],
				values = self.VRA_UNIT,
			},
			sourcetypefilter = {
				type = 'select',
				order = 59,
				name = L["Source type"],
				values = self.VRA_TYPE,
			},
			sourcecustomname = {
				type= 'input',
				order = 62,
				name= L["Custom unit name"],
				disabled = function() return not (db[key].sourceuidfilter == "custom") end,
			},
			destuidfilter = {
				type = 'select',
				order = 65,
				name = L["Dest unit"],
				values = self.VRA_UNIT,
			},
			desttypefilter = {
				type = 'select',
				order = 60,
				name = L["Dest type"],
				values = self.VRA_TYPE,
			},
			destcustomname = {
				type= 'input',
				order = 68,
				name = L["Custom unit name"],
				disabled = function() return not (db[key].destuidfilter == "custom") end,
			},
			--[[NewLine5 = {
				type = 'header',
				order = 69,
				name = "",
			},]]
		}
	}
end


function VRA:OnOptionCreate()

	vradb = self.db1.profile
	self:UpdateRoster()
	self.options = {
		type = "group",
		name = "Vocal Raid Assistant",
		args = {
			general = {
				type = 'group',
				name = L["General"],
				desc = L["General options"],
				set = setOption,
				get = getOption,
				order = 1,
				args = {
					enableArea = {
						type = 'group',
						inline = true,
						name = L["Enable area"],
						order = 1,
						args = {
							all = {
								type = 'toggle',
								name = L["Anywhere"],
								desc = L["Alert works anywhere"],
								order = 1,
							},
							raid = {
								type = 'toggle',
								name = L["Raid"],
								desc = L["Alert only works in raid instances"],
								disabled = function() return vradb.all end,
								order = 2,
							},
							field = {
								type = 'toggle',
								name = L["World"],
								desc = L["Alert works anywhere else than raid instances"],
								disabled = function() return vradb.all end,
								order = 5,
							}
						},
					},
					voice = {
						type = 'group',
						inline = true,
						name = L["Voice config"],
						order = 2,
						args = {
							path = {
								type = 'select',
								name = L["Voice language"],
								desc = L["Select language of the alert"],
								values = self.VRA_LANGUAGE,
								order = 1,
							},
							volumn = {
								type = 'range',
								max = 1,
								min = 0,
								step = 0.1,
								name = L["Volume"],
								desc = L["adjusting the voice volume(the same as adjusting the system master sound volume)"],
								set = function (info, value) SetCVar ("Sound_MasterVolume",tostring (value)) end,
								get = function () return tonumber (GetCVar ("Sound_MasterVolume")) end,
								order = 2,
							},
						},
					},
					advance = {
						type = 'group',
						inline = true,
						name = L["Advance options"],
						order = 3,
						args = {
							smartDisable = {
								type = 'toggle',
								name = L["Smart disable"],
								desc = L["Disable addon for a moment while too many alerts comes"],
								order = 1,
							},
							throttle = {
								type = 'range',
								max = 5,
								min = 0,
								step = 0.1,
								name = L["Throttle"],
								desc = L["The minimum interval of each alert"],
								order = 2,
							},
						},
					},
				},
			},
			spells = {
				type = 'group',
				name = L["Abilities"],
				desc = L["Abilities options"],
				set = setOption,
				get = getOption,
				childGroups = "tab",
				order = 2,
				args = {
					spellSpec = {
						type = 'group',
						name = "Target specific",
						desc = "Buffs on Specialization",
						inline = true,
						order = -2,
						args = {
							buffAppliedSpecific = {
								type = 'toggle',
								name = "Individual Buff",
								desc = "Check this will only alert for buff applied to specific players",
								order = 1,
							},
							onlyRaidGroup = {
								type = 'toggle',
								name = "Only Check Raid Group",
								desc = "Check this will only alert for buff/casts from/to raid group",
								order = 2,
								disabled = function() return vradb.buffAppliedSpecific end,
							},
							buffAppliedTank = {
								type = 'toggle',
								name = "Only Buffs On Tank",
								desc = "Check this will only alert for buff applied to friendly tanks",
								order = 3,
								disabled = function() return vradb.buffAppliedSpecific end,
							},
							
						},
					},
					spellGeneral = {
						type = 'group',
						name = L["Disable options"],
						desc = L["Disable abilities by type"],
						inline = true,
						order = -1,
						args = {
							aruaApplied = {
								type = 'toggle',
								name = L["Disable Buff Applied"],
								desc = L["Check this will disable alert for buff applied to friendly targets"],
								order = 1,
							},
							castSuccess = {
								type = 'toggle',
								name = L["Disable special abilities"],
								desc = L["Check this will disable alert for instant-cast important abilities"],
								order = 4,
							},
							interrupt = {
								type = 'toggle',
								name = L["Disable friendly interrupt"],
								desc = L["Check this will disable alert for successfully-landed friendly interrupting abilities"],
								order = 5,
							}
						},
					},
					spellAuraApplied = {
						type = 'group',
						--inline = true,
						name = L["Buff Applied"],
						disabled = function() return vradb.aruaApplied end,
						order = 1,
						args = {
							dk	= {
								type = 'group',
								inline = true,
								name = L["|cffC41F3BDeath Knight|r"],
								order = 5,
								args = listOption({},"auraApplied"),
							},
							druid = {
								type = 'group',
								inline = true,
								name = L["|cffFF7D0ADruid|r"],
								order = 6,
								args = listOption({29166,102342},"auraApplied"),	
							},
							hunter = {
								type = 'group',
								inline = true,
								name = L["|cffABD473Hunter|r"],
								order = 7,
								args = listOption({34477},"auraApplied"),
							},
							mage = {
								type = 'group',
								inline = true,
								name = L["|cff69CCF0Mage|r"],
								order = 8,
								args = listOption({},"auraApplied"),
							},
							monk = {
								type = 'group',
								inline = true,
								name = L["|cFF558A84Monk|r"],
								order = 9,
								args = listOption({116849},"auraApplied"),
							},
							paladin = {
								type = 'group',
								inline = true,
								name = L["|cffF58CBAPaladin|r"],
								order = 10,
								args = listOption({6940,1022},"auraApplied"),
							},
							preist	= {
								type = 'group',
								inline = true,
								name = L["|cffFFFFFFPriest|r"],
								order = 11,
								args = listOption({33206,47788},"auraApplied"),
							},
							rogue = {
								type = 'group',
								inline = true,
								name = L["|cffFFF569Rogue|r"],
								order = 12,
								args = listOption({57934},"auraApplied"),
							},
							shaman	= {
								type = 'group',
								inline = true,
								name = L["|cff0070daShaman|r"],
								order = 13,
								args = listOption({},"auraApplied"),
							},
							warlock	= {
								type = 'group',
								inline = true,
								name = L["|cff9482C9Warlock|r"],
								order = 14,
								args = listOption({},"auraApplied"),
							},
							warrior	= {
								type = 'group',
								inline = true,
								name = L["|cffC79C6EWarrior|r"],
								order = 15,
								args = listOption({114030},"auraApplied"),	
							},
						},
					},
				
					spellCastSuccess = {
						type = 'group',
						--inline = true,
						name = L["Special Abilities"],
						disabled = function() return vradb.castSuccess end,
						order = 3,
						args = {
							general = {
								type = 'group',
								inline = true,
								name = L["General Abilities"],
								order = 4,
								args = listOption({},"castSuccess"),
							},
							dk	= {
								type = 'group',
								inline = true,
								name = L["|cffC41F3BDeath Knight|r"],
								order = 5,
								args = listOption({51052,61999},"castSuccess"),
							},
							druid = {
								type = 'group',
								inline = true,
								name = L["|cffFF7D0ADruid|r"],
								order = 6,
								args = listOption({740,110707,106898,77764,77761,20484},"castSuccess"),
							},
							hunter = {
								type = 'group',
								inline = true,
								name = L["|cffABD473Hunter|r"],
								order = 7,
								args = listOption({90355},"castSuccess"),
							},
							mage = {
								type = 'group',
								inline = true,
								name = L["|cff69CCF0Mage|r"],
								order = 8,
								args = listOption({80353},"castSuccess"),
							},
							monk = {
								type = 'group',
								inline = true,
								name = L["|cFF558A84Monk|r"],
								order = 9,
								args = listOption({115213},"castSuccess"),
							},
							paladin = {
								type = 'group',
								inline = true,
								name = L["|cffF58CBAPaladin|r"],
								order = 10,
								args = listOption({31821,633},"castSuccess"),
							},
							preist	= {
								type = 'group',
								inline = true,
								name = L["|cffFFFFFFPriest|r"],
								order = 110,
								args = listOption({64843,64901,62618,32375,113277,15286},"castSuccess"),
							},
							rogue = {
								type = 'group',
								inline = true,
								name = L["|cffFFF569Rogue|r"],
								order = 111,
								args = listOption({76577},"castSuccess"),
							},
							shaman	= {
								type = 'group',
								inline = true,
								name = L["|cff0070daShaman|r"],
								order = 112,
								args = listOption({2825,32182,108280,98008,16190,120668},"castSuccess"),
							},
							warlock = {
								type = 'group',
								inline = true,
								name = L["|cff9482C9Warlock|r"],
								order = 113,
								args = listOption({20707},"castSuccess"),
							},
							warrior	= {
								type = 'group',
								inline = true,
								name = L["|cffC79C6EWarrior|r"],
								order = 114,
								args = listOption({97462,114203,114207,122294},"castSuccess"),	
							},
						},
					},
					spellInterrupt = {
						type = 'group',
						--inline = true,
						name = L["Friendly Interrupt"],
						disabled = function() return vradb.interrupt end,
						order = 4,
						args = {
							lockout = {
								type = 'toggle',
								name = L["Friendly Interrupt"],
								desc = L["Spell Lock, Counterspell, Kick, Pummel, Mind Freeze, Skull Bash, Rebuke, Solar Beam, Spear Hand Strike, Wind Shear"],
								order = 1,
							},
						}
					},
				},
			},
			IndividualAssingment = {
				type = 'group',
				name = "Individual Assingment",
				desc = L["Abilities options"],
				set = setOption,
				get = getOption,
				childGroups = "tab",
				order = 3,
				args = {
					Individual = {
						type = 'group',
						name = "Target specific",
						desc = "Buffs on Specialization",
						inline = true,
						order = -2,
						args = {
							raid1 = {
								type = 'toggle',
								name = function() return rosterInfoArray[1] end,
								desc = "Check this will alert for buff applied to this player",
								order = 1,
								disabled = function() return (rosterInfoArray[1] == "") end,
								hidden = function() return (rosterInfoArray[1] == "") end,
							},
							raid2 = {
								type = 'toggle',
								name = function() return rosterInfoArray[2] end,
								desc = "Check this will alert for buff applied to this player",
								order = 2,
								disabled = function() return (rosterInfoArray[2] == "") end,
								hidden = function() return (rosterInfoArray[2] == "") end,
							},
							raid3 = {
								type = 'toggle',
								name = function() return rosterInfoArray[3] end,
								desc = "Check this will alert for buff applied to this player",
								order = 3,
								disabled = function() return (rosterInfoArray[3] == "") end,
								hidden = function() return (rosterInfoArray[3] == "") end,
							},
							raid4 = {
								type = 'toggle',
								name = function() return rosterInfoArray[4] end,
								desc = "Check this will alert for buff applied to this player",
								order = 4,
								disabled = function() return (rosterInfoArray[4] == "") end,
								hidden = function() return (rosterInfoArray[4] == "") end,
							},
							raid5 = {
								type = 'toggle',
								name = function() return rosterInfoArray[5] end,
								desc = "Check this will alert for buff applied to this player",
								order = 5,
								disabled = function() return (rosterInfoArray[5] == "") end,
								hidden = function() return (rosterInfoArray[5] == "") end,
							},
							raid6 = {
								type = 'toggle',
								name = function() return rosterInfoArray[6] end,
								desc = "Check this will alert for buff applied to this player",
								order = 6,
								disabled = function() return (rosterInfoArray[6] == "") end,
								hidden = function() return (rosterInfoArray[6] == "") end,
							},
							raid7 = {
								type = 'toggle',
								name = function() return rosterInfoArray[7] end,
								desc = "Check this will alert for buff applied to this player",
								order = 7,
								disabled = function() return (rosterInfoArray[7] == "") end,
								hidden = function() return (rosterInfoArray[7] == "") end,
							},
							raid8 = {
								type = 'toggle',
								name = function() return rosterInfoArray[8] end,
								desc = "Check this will alert for buff applied to this player",
								order = 8,
								disabled = function() return (rosterInfoArray[8] == "") end,
								hidden = function() return (rosterInfoArray[8] == "") end,
							},
							raid9 = {
								type = 'toggle',
								name = function() return rosterInfoArray[9] end,
								desc = "Check this will alert for buff applied to this player",
								order = 9,
								disabled = function() return (rosterInfoArray[9] == "") end,
								hidden = function() return (rosterInfoArray[9] == "") end,
							},
							raid10 = {
								type = 'toggle',
								name = function() return rosterInfoArray[10] end,
								desc = "Check this will alert for buff applied to this player",
								order = 10,
								disabled = function() return (rosterInfoArray[10] == "") end,
								hidden = function() return (rosterInfoArray[10] == "") end,
							},
							raid11 = {
								type = 'toggle',
								name = function() return rosterInfoArray[11] end,
								desc = "Check this will alert for buff applied to this player",
								order = 11,
								disabled = function() return (rosterInfoArray[11] == "") end,
								hidden = function() return (rosterInfoArray[11] == "") end,
							},
							raid12 = {
								type = 'toggle',
								name = function() return rosterInfoArray[12] end,
								desc = "Check this will alert for buff applied to this player",
								order = 12,
								disabled = function() return (rosterInfoArray[12] == "") end,
								hidden = function() return (rosterInfoArray[12] == "") end,
							},
							raid13 = {
								type = 'toggle',
								name = function() return rosterInfoArray[13] end,
								desc = "Check this will alert for buff applied to this player",
								order = 13,
								disabled = function() return (rosterInfoArray[13] == "") end,
								hidden = function() return (rosterInfoArray[13] == "") end,
							},
							raid14 = {
								type = 'toggle',
								name = function() return rosterInfoArray[14] end,
								desc = "Check this will alert for buff applied to this player",
								order = 14,
								disabled = function() return (rosterInfoArray[14] == "") end,
								hidden = function() return (rosterInfoArray[14] == "") end,
							},
							raid15 = {
								type = 'toggle',
								name = function() return rosterInfoArray[15] end,
								desc = "Check this will alert for buff applied to this player",
								order = 15,
								disabled = function() return (rosterInfoArray[15] == "") end,
								hidden = function() return (rosterInfoArray[15] == "") end,
							},
							raid16 = {
								type = 'toggle',
								name = function() return rosterInfoArray[16] end,
								desc = "Check this will alert for buff applied to this player",
								order = 16,
								disabled = function() return (rosterInfoArray[16] == "") end,
								hidden = function() return (rosterInfoArray[16] == "") end,
							},
							raid17 = {
								type = 'toggle',
								name = function() return rosterInfoArray[17] end,
								desc = "Check this will alert for buff applied to this player",
								order = 17,
								disabled = function() return (rosterInfoArray[17] == "") end,
								hidden = function() return (rosterInfoArray[17] == "") end,
							},
							raid18 = {
								type = 'toggle',
								name = function() return rosterInfoArray[18] end,
								desc = "Check this will alert for buff applied to this player",
								order = 18,
								disabled = function() return (rosterInfoArray[18] == "") end,
								hidden = function() return (rosterInfoArray[18] == "") end,
							},
							raid19 = {
								type = 'toggle',
								name = function() return rosterInfoArray[19] end,
								desc = "Check this will alert for buff applied to this player",
								order = 19,
								disabled = function() return (rosterInfoArray[19] == "") end,
								hidden = function() return (rosterInfoArray[19] == "") end,
							},
							raid20 = {
								type = 'toggle',
								name = function() return rosterInfoArray[20] end,
								desc = "Check this will alert for buff applied to this player",
								order = 20,
								disabled = function() return (rosterInfoArray[20] == "") end,
								hidden = function() return (rosterInfoArray[20] == "") end,
							},
							raid21 = {
								type = 'toggle',
								name = function() return rosterInfoArray[21] end,
								desc = "Check this will alert for buff applied to this player",
								order = 21,
								disabled = function() return (rosterInfoArray[21] == "") end,
								hidden = function() return (rosterInfoArray[21] == "") end,
							},
							raid22 = {
								type = 'toggle',
								name = function() return rosterInfoArray[22] end,
								desc = "Check this will alert for buff applied to this player",
								order = 22,
								disabled = function() return (rosterInfoArray[22] == "") end,
								hidden = function() return (rosterInfoArray[22] == "") end,
							},
							raid23 = {
								type = 'toggle',
								name = function() return rosterInfoArray[23] end,
								desc = "Check this will alert for buff applied to this player",
								order = 23,
								disabled = function() return (rosterInfoArray[23] == "") end,
								hidden = function() return (rosterInfoArray[23] == "") end,
							},
							raid24 = {
								type = 'toggle',
								name = function() return rosterInfoArray[24] end,
								desc = "Check this will alert for buff applied to this player",
								order = 24,
								disabled = function() return (rosterInfoArray[24] == "") end,
								hidden = function() return (rosterInfoArray[24] == "") end,
							},
							raid25 = {
								type = 'toggle',
								name = function() return rosterInfoArray[25] end,
								desc = "Check this will alert for buff applied to this player",
								order = 25,
								disabled = function() return (rosterInfoArray[25] == "") end,
								hidden = function() return (rosterInfoArray[25] == "") end,
							},
							raid26 = {
								type = 'toggle',
								name = function() return rosterInfoArray[26] end,
								desc = "Check this will alert for buff applied to this player",
								order = 26,
								disabled = function() return (rosterInfoArray[26] == "") end,
								hidden = function() return (rosterInfoArray[26] == "") end,
							},
							raid27 = {
								type = 'toggle',
								name = function() return rosterInfoArray[27] end,
								desc = "Check this will alert for buff applied to this player",
								order = 27,
								disabled = function() return (rosterInfoArray[27] == "") end,
								hidden = function() return (rosterInfoArray[27] == "") end,
							},
							raid28 = {
								type = 'toggle',
								name = function() return rosterInfoArray[28] end,
								desc = "Check this will alert for buff applied to this player",
								order = 28,
								disabled = function() return (rosterInfoArray[28] == "") end,
								hidden = function() return (rosterInfoArray[28] == "") end,
							},
							raid29 = {
								type = 'toggle',
								name = function() return rosterInfoArray[29] end,
								desc = "Check this will alert for buff applied to this player",
								order = 29,
								disabled = function() return (rosterInfoArray[29] == "") end,
								hidden = function() return (rosterInfoArray[29] == "") end,
							},
							raid30 = {
								type = 'toggle',
								name = function() return rosterInfoArray[30] end,
								desc = "Check this will alert for buff applied to this player",
								order = 30,
								disabled = function() return (rosterInfoArray[30] == "") end,
								hidden = function() return (rosterInfoArray[30] == "") end,
							},
							raid31 = {
								type = 'toggle',
								name = function() return rosterInfoArray[31] end,
								desc = "Check this will alert for buff applied to this player",
								order = 31,
								disabled = function() return (rosterInfoArray[31] == "") end,
								hidden = function() return (rosterInfoArray[31] == "") end,
							},
							raid32 = {
								type = 'toggle',
								name = function() return rosterInfoArray[32] end,
								desc = "Check this will alert for buff applied to this player",
								order = 32,
								disabled = function() return (rosterInfoArray[32] == "") end,
								hidden = function() return (rosterInfoArray[32] == "") end,
							},
							raid33 = {
								type = 'toggle',
								name = function() return rosterInfoArray[33] end,
								desc = "Check this will alert for buff applied to this player",
								order = 33,
								disabled = function() return (rosterInfoArray[33] == "") end,
								hidden = function() return (rosterInfoArray[33] == "") end,
							},
							raid34 = {
								type = 'toggle',
								name = function() return rosterInfoArray[34] end,
								desc = "Check this will alert for buff applied to this player",
								order = 34,
								disabled = function() return (rosterInfoArray[34] == "") end,
								hidden = function() return (rosterInfoArray[34] == "") end,
							},
							raid35 = {
								type = 'toggle',
								name = function() return rosterInfoArray[35] end,
								desc = "Check this will alert for buff applied to this player",
								order = 35,
								disabled = function() return (rosterInfoArray[35] == "") end,
								hidden = function() return (rosterInfoArray[35] == "") end,
							},
							raid36 = {
								type = 'toggle',
								name = function() return rosterInfoArray[36] end,
								desc = "Check this will alert for buff applied to this player",
								order = 36,
								disabled = function() return (rosterInfoArray[36] == "") end,
								hidden = function() return (rosterInfoArray[36] == "") end,
							},
							raid37 = {
								type = 'toggle',
								name = function() return rosterInfoArray[37] end,
								desc = "Check this will alert for buff applied to this player",
								order = 37,
								disabled = function() return (rosterInfoArray[37] == "") end,
								hidden = function() return (rosterInfoArray[37] == "") end,
							},
							raid38 = {
								type = 'toggle',
								name = function() return rosterInfoArray[38] end,
								desc = "Check this will alert for buff applied to this player",
								order = 38,
								disabled = function() return (rosterInfoArray[38] == "") end,
								hidden = function() return (rosterInfoArray[38] == "") end,
							},
							raid39 = {
								type = 'toggle',
								name = function() return rosterInfoArray[39] end,
								desc = "Check this will alert for buff applied to this player",
								order = 39,
								disabled = function() return (rosterInfoArray[39] == "") end,
								hidden = function() return (rosterInfoArray[39] == "") end,
							},
							raid40 = {
								type = 'toggle',
								name = function() return rosterInfoArray[40] end,
								desc = "Check this will alert for buff applied to this player",
								order = 40,
								disabled = function() return (rosterInfoArray[40] == "") end,
								hidden = function() return (rosterInfoArray[40] == "") end,
							},
						},
					},
				},
			},
			custom = {
				type = 'group',
				name = L["Custom"],
				desc = L["Custom Spell"],
				order = 4,
				args = {
					newalert = {
						type = 'execute',
						name = L["New Sound Alert"],
						order = -1,

						func = function()
							vradb.custom[L["New Sound Alert"]] = {
								name = L["New Sound Alert"],
								soundfilepath = "Interface\\VRASound\\"..L["New Sound Alert"]..".ogg",
								sourceuidfilter = "any",
								destuidfilter = "any",
								eventtype = {
									SPELL_CAST_SUCCESS = true,
									SPELL_CAST_START = false,
									SPELL_AURA_APPLIED = false,
									SPELL_AURA_REMOVED = false,
									SPELL_INTERRUPT = false,
								},
								sourcetypefilter = COMBATLOG_FILTER_EVERYTHING,
								desttypefilter = COMBATLOG_FILTER_EVERYTHING,
								order = 0,
							}
							self:MakeCustomOption(L["New Sound Alert"])
						end,
						disabled = function()
							if vradb.custom[L["New Sound Alert"]] then
								return true
							else
								return false
							end
						end,
					}
				}
			}
		}
	}
	for k, v in pairs(vradb.custom) do
		self:MakeCustomOption(k)
	end	
	AceConfig:RegisterOptionsTable("VocalRaidAssistant", self.options)
	self:AddOption(L["General"], "general")
	self.options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db1)
	self.options.args.profiles.order = -1
	
	self:AddOption(L["Abilities"], "spells")
	self:AddOption("Individual Assingment", "IndividualAssingment")
	self:AddOption(L["Custom"], "custom")
	self:AddOption(L["Profiles"], "profiles")
end