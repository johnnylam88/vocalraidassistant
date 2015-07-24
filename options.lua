local VRA = VocalRaidAssistant
local vradb
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfig = LibStub("AceConfig-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("VocalRaidAssistant")
local LSM = LibStub("LibSharedMedia-3.0")


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
								args = listOption({29166},"auraApplied"),	
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
								args = listOption({51052},"castSuccess"),
							},
							druid = {
								type = 'group',
								inline = true,
								name = L["|cffFF7D0ADruid|r"],
								order = 6,
								args = listOption({740,110707,106898,77764,77761},"castSuccess"),
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
								args = listOption({64843,64901,62618,32375,113277},"castSuccess"),
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
								args = listOption({},"castSuccess"),
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
	self:AddOption(L["Custom"], "custom")
	self:AddOption(L["Profiles"], "profiles")
end