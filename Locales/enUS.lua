﻿local L = LibStub("AceLocale-3.0"):NewLocale("VocalRaidAssistant", "enUS",true)
if not L then return end

L["Main Options"] = "Main Options"
L["MAIN_OPTIONS_DESC"] = "Main Options test"
L["GET_VERSION"] = GetAddOnMetadata("VocalRaidAssistant", "Version")
L["Vocal Raid Assistant"] = "Vocal Raid Assistant"
L["VOCAL_RAID_ASSISTANCE_DESC"] = ""
L["Version"] = "Version/Changelog"
L["VERSION_DESC"] = ""
L["1.0.4 Changelog"] = "Added \"Individual Buff\" feature" .. "\n" .. "Added abilities:" .. "\n" .. "  - Soulstone" .. "\n" .. "  - Raise Ally" .. "\n" .. "  - Rebirth"
L["1.0.3 Changelog"] = "Added \"Buffs on Tank\" only feature" .. "\n" .. "Added \"Only Check Raid Group\" feature" .. "\n" .. "Added abilities:" .. "\n" .. "  - Iron Bark" .. "\n" .. "  - Vampiric Embrace"
L["1.0.2 Changelog"] = "Improved menu utility" .. "\n" .. "Removed Load Configuration and now load on default" .. "\n" .. "Added abilities:" .. "\n" .. "  - Tricks of the Trade (Off by default)" .. "\n" .. "  - Misdirection (Off by default)" .. "\n" .. "Fixed multiple appliances of buff (Bloodlust, Heroism, Time Warp, Ancient Hysteria)"
L["1.0.1 Changelog"] = "Fixed raid was not toggled as default" .. "\n" .. "Added abilities:" .. "\n" .. "  - Innervate" .. "\n" .. "Fixed multiple appliances of buff (Like Stampede and Avert Harm)"
L["GENERAL_HEADER"] = "General"
L["GENERAL_DESCRIPTION"] = "Enabled area: Determines where you want Vocal Raid Assistant to be active" .. "\n\n" .. "Voice Config: Set up voice and volume (Currently only one voice available)" .. "\n\n" .. "Advance options: Enable thotteling of sounds to not be overwhelmed (Try without throtteling first)"
L["ABILITIES_HEADER"] = "Abilities"
L["ABILITIES_DESCRIPTION"] = "Target specific: Enable you to select who you want to hear receive buffs" .. "\n\n" .. "Disable options: Disable segments of vocal options with one click" .. "\n\n" .. "Buff Applied: Single buffs applied to a friendly unit" .. "\n\n" .. "Special Abilities: Multi target or raid abilities to several friendly units" .. "\n\n" .. "Friendly Interrupt: Announce successful friendly interrupts"
L["CUSTOM_ABILITIES_HEADER"] = "Custom Abilities"
L["CUSTOM_ABILITIES_DESCRIPTION"] = "Enable you to track a custom ability of your own choice. Fill in the fields as asked, and it should work!" .. "\n\n" .. "Use existing sound currently does not work, but will in a later version. You will have to provide the sound file yourself"





L["Spell cast success"] = true
L["Spell cast start"] = true
L["Spell aura applied"] = true
L["Spell aura removed"] = true
L["Spell interrupt"] = true
L["Spell summon"] = true
L["Any"] = true
L["Player"] = true
L["Target"] = true
L["Focus"] = true
L["Mouseover"] = true
L["Party"] = true
L["Raid"] = true
L["Arena"] = true
L["Boss"] = true
L["Custom"] = true
L["Friendly"] = true
L["Hostile player"] = true
L["Hostile unit"] = true
L["Neutral"] = true
L["Myself"] = true
L["Mine"] = true
L["My pet"] = true
L["Custom Spell"] = true
L["New Sound Alert"] = true
L["name"] = true
L["same name already exists"] = true
L["spellid"] = true
L["Remove"] = true
L["Are you sure?"] = true
L["Test"] = true
L["Use existing sound"] = true
L["choose a sound"] = true
L["file path"] = true
L["event type"] = true
L["Source unit"] = true
L["Source type"] = true
L["Custom unit name"] = true
L["Dest unit"] = true
L["Dest type"] = true

L["PVP Voice Alert"] = true
L["PVE Voice Alert"] = true
L["Load Configuration"] = true
L["Load Configuration Options"] = true
L["Load Configuration Options - Red + will appear"] = true
L["General"] = true
L["General options"] = true
L["Enable area"] = true
L["Anywhere"] = true
L["Alert works anywhere"] = true
L["Arena"] = true
L["Alert only works in arena"] = true
L["Raid"] = true
L["Alert only works in raid instances"] = true
L["Battleground"] = true
L["Alert only works in BG"] = true
L["World"] = true
L["Alert works anywhere else than raid instances"] = true
L["Voice config"] = true
L["Voice language"] = true
L["Select language of the alert"] = true
L["Chinese(female)"] = true
L["English(female)"] = true
L["Volume"] = true
L["adjusting the voice volume(the same as adjusting the system master sound volume)"] = true
L["Advance options"] = true
L["Smart disable"] = true
L["Disable addon for a moment while too many alerts comes"] = true
L["Throttle"] = true
L["The minimum interval of each alert"] = true
L["Abilities"] = true
L["Abilities options"] = true
L["Disable options"] = true
L["Disable abilities by type"] = true
L["Disable Buff Applied"] = true
L["Check this will disable alert for buff applied to friendly targets"] = true
L["Disable Buff Down"] = true
L["Check this will disable alert for buff removed from friendly targets"] = true
L["Disable Spell Casting"] = true
L["Chech this will disable alert for spell being casted to friendly targets"] = true
L["Disable special abilities"] = true
L["Check this will disable alert for instant-cast important abilities"] = true
L["Disable friendly interrupt"] = true
L["Check this will disable alert for successfully-landed friendly interrupting abilities"] = true
L["Buff Applied"] = true
L["Target and Focus Only"] = true
L["Alert works only when your current target or focus gains the buff effect or use the ability"] = true
L["Alert Drinking"] = true
L["In arena, alert when enemy is drinking"] = true
L["PvP Trinketed Class"] = true
L["Also announce class name with trinket alert when hostile targets use PvP trinket in arena"] = true
L["General Abilities"] = true
L["|cffFF7D0ADruid|r"] = true
L["|cffF58CBAPaladin|r"] = true
L["|cffFFF569Rogue|r"] = true
L["|cffC79C6EWarrior|r"] = true
L["|cffFFFFFFPriest|r"] = true
L["|cff0070daShaman|r"] = true
L["|cff69CCF0Mage|r"] = true
L["|cffC41F3BDeath Knight|r"] = true
L["|cffABD473Hunter|r"] = true
L["|cFF558A84Monk|r"] = true
L["Buff Down"] = true
L["Spell Casting"] = true
L["Big Heals"] = true
L["Greater Heal, Divine Light, Greater Healing Wave, Healing Touch, Enveloping Mist"] = true
L["Resurrection"] = true
L["Resurrection, Redemption, Ancestral Spirit, Revive, Resuscitate"] = true
L["|cff9482C9Warlock|r"] = true
L["Special Abilities"] = true
L["Friendly Interrupt"] = true
L["Spell Lock, Counterspell, Kick, Pummel, Mind Freeze, Skull Bash, Rebuke, Solar Beam, Spear Hand Strike, Wind Shear"] = true


L["Profiles"] = true