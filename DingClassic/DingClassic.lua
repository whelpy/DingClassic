local addonName = "DingClassic"
--local ding_version = "1.0.6"
local isAddonLoaded = false  -- Variable to track if the addon has been loaded

-- Initialize the settings table
DingClassicSettings = {
    showDingMessages = true,
    sendToSay = true,
    sendToGuild = true,
    sendToParty = true,
    messageSent = {},
    selectedMessagePool = "Default"
}

local messagePoolDescriptions = {
    Default = "The default pool of ding messages.",
    WoWHardCore = "Hardcore-themed ding messages for the ultimate leveling experience.",
    WoWFunny = "Funny and lighthearted ding messages for a good laugh while leveling.",
    WoWLore = "Discover bite-sized tales, lore snippets, and legendary quotes from the vast world of Azeroth.",
}

-- Define arrays of different ding messages
local messagePools = {
    Default = {
        "Ding! Level %d! My character's leveling is so epic, even dragons ask for tips on breathing fire.",
        "Ding! Level %d! My character has gained more levels than I've had hot dinners.",
        "Ding! Level %d! I've leveled up so much, I'm considering opening a 'Level Up' consultancy.",
        "Ding! Level %d! My character is so legendary, they put 'Legend of Zelda' to shame.",
        "Ding! Level %d! My character's leveling speed is faster than a caffeinated squirrel on a double espresso.",
        "Ding! Level %d! My character is now so powerful, they don't defeat bosses, bosses defeat themself out of fear.",
        "Ding! Level %d! I've leveled up so much, even Gandalf asked for leveling advice.",
        "Ding! Level %d! My character is so maxed out, they can high-five Thor without flinching.",
        "Ding! Level %d! My character is so overpowered, they can sneeze and defeat an entire army.",
        "Ding! Level %d! My character's leveling speed is faster than my WiFi... most of the time.",
        "Ding! Level %d! My character is so strong, they can open a pickle jar on the first try.",
        "Ding! Level %d! I've leveled up so many times, my character has a Ph.D. in Dingology.",
        "Ding! Level %d! I'm not addicted, I'm just passionately committed to my character's success.",
        "Ding! Level %d! My character is now eligible for the 'Most Leveled' award at the MMO Oscars.",
        "Ding! Level %d! My character is so fast at leveling, they give The Flash a run for his money.",
        "Ding! Level %d! I've leveled up so much, even the loading screen tips ask me for advice.",
        "Ding! Level %d! My character is so good, they leveled up while I was writing this message.",
        "Ding! Level %d! My character now has a better credit score than I do.",
        "Ding! Level %d! I've leveled up so much, I'm considering a second life as a professional leveler.",
        "Ding! Level %d! My character is so maxed out, they're on the cover of Leveler's Weekly.",
        "Ding! Level %d! My character has more XP than all the coffee I've ever consumed.",
        "Ding! Level %d! My character is now legally allowed to carry an oversized weapon.",
        "Ding! Level %d! I've spent more time in Azeroth than I have in reality.",
        "Ding! Level %d! My character is so legendary, they put Chuck Norris out of a job.",
        "Ding! Level %d! I've leveled up more times than I've changed my profile picture.",
        "Ding! Level %d! My character is so overpowered, even Chuck Norris asks for tips.",
        "Ding! Level %d! My character is so epic, they can even butter toast perfectly.",
        "Ding! Level %d! My character is now old enough to vote in Azeroth.",
        "Ding! Level %d! I've spent more time leveling than I have at family gatherings.",
        "Ding! Level %d! My character's Tinder profile just got a lot more impressive.",
        "Ding! Level %d! My character is so fit from all this leveling, even the NPCs are mirin'.",
        "Ding! Level %d! I've achieved the level of procrastination master.",
        "Ding! Level %d! I've probably defeated more dragons than all medieval knights combined.",
        "Ding! Level %d! If only I could level up my cooking skills as fast as my character.",
        "Ding! Level %d! My character is leveling faster than my plants are growing.",
        "Ding! Level %d! I'm so good at this game, I should put it on my resume.",
        "Ding! Level %d! My character is more maxed out than my credit cards.",
        "Ding! Level %d! Now I can finally tell my parents I've achieved something in life.",
        "Ding! Level %d! My social life may be in ruins, but at least my character is thriving!",
        "Ding! Level %d! I swear I'll go outside... after just one more level.",
        "Ding! Level %d! My parents said I'd never amount to anything. Look at me now, Mom!",
        "Ding! Level %d! Who needs sleep when there are epic loot and quests to conquer?",
        "Ding! Level %d! I'd like to thank my coffee maker for keeping me awake on this journey.",
        "Ding! Level %d! My character is leveling up faster than my bank account is depleting.",
        "Ding! Level %d! I may not have a real job, but I'm %d level in a fantasy world!",
        "Ding! Level %d! I've reached the level where I can procrastinate even more effectively.",
        "Ding! Level %d! I'm not addicted; I just have an intense dedication to my virtual self.",
        "Ding! Level %d! My character is now officially better at life than I am.",
        "Ding! Level %d! I'd like to thank my pizza delivery guy for sustaining me through this journey.",
        "Ding! Level %d! I may not have a real diploma, but I have a %d character!",
        "Ding! Level %d! If only I could level up my real-life responsibilities as easily.",
        "Ding! Level %d! Who needs a gym when you can level up from the comfort of your chair?",
        "Ding! Level %d! I told my boss I'm 'leveling up' my skills while working from home.",
        "Ding! Level %d! At this point, I think my character deserves a virtual Ph.D.",
        "Ding! Level %d! I've spent more time in Azeroth than I have in my own hometown.",
        "Ding! Level %d! My character is so legendary, even NPCs ask for autographs.",
        "Ding! Level %d! I've reached the level where I can procrastinate professionally.",
        "Ding! Level %d! My character's leveling speed could break the space-time continuum.",
        "Ding! Level %d! My character is so buffed, even Hercules asked for workout tips.",
        "Ding! Level %d! I've spent more time leveling than I have sleeping... and that's saying something.",
    },
    WoWHardCore = {
        "Ding! Level %d! I've ascended to a new tier of gaming greatness.",
        "Ding! Level %d! I don't always level up, but when I do, it's hardcore.",
        "Ding! Level %d! I eat mobs for breakfast, and leveling up for dessert.",
        "Ding! Level %d! My keyboard fears me and my leveling prowess.",
        "Ding! Level %d! I measure success in levels, and I'm a level millionaire now.",
        "Ding! Level %d! I level up so fast, the game developers send me thank you cards.",
        "Ding! Level %d! I'd say I'm addicted, but that's an understatement.",
        "Ding! Level %d! My character is a max-level beast with legendary gear.",
        "Ding! Level %d! If leveling up was an Olympic sport, I'd be a gold medalist.",
        "Ding! Level %d! My character is the stuff of legends, literally.",
        "Ding! Level %d! I've leveled up so much, even the NPCs ask for my autograph.",
        "Ding! Level %d! I've conquered more dungeons than I have life responsibilities.",
        "Ding! Level %d! I'm the hero Azeroth deserves, and the one it needs right now.",
        "Ding! Level %d! My character is maxed out, and so is my dedication.",
        "Ding! Level %d! My character has leveled up more times than I've said 'for the Horde!'",
        "Ding! Level %d! My character is so hardcore, even Deathwing gives me a high-five.",
        "Ding! Level %d! I've grinded more mobs than I can count.",
        "Ding! Level %d! I've seen things. Terrible, terrible things in Azeroth.",
        "Ding! Level %d! My character is so maxed out, even Khadgar asks for advice.",
        "Ding! Level %d! My character is max level, and my life is max Azeroth.",
        "Ding! Level %d! I've leveled up so much, I should get an honorary degree in leveling.",
        "Ding! Level %d! My character is the living embodiment of 'No life, only leveling.'",
        "Ding! Level %d! I've spent more time in dungeons than I have in daylight.",
        "Ding! Level %d! My character is so hardcore, they punch Deathwing in the face.",
        "Ding! Level %d! My character has achieved levels beyond mortal comprehension.",
        "Ding! Level %d! I've leveled up so much, my character has a fan club.",
        "Ding! Level %d! My character is so legendary, even Illidan takes notes.",
        "Ding! Level %d! I've leveled up more times than I've had hot meals.",
        "Ding! Level %d! My character is max level, max gear, max awesome.",
        "Ding! Level %d! My character is so buffed, even the Lich King is impressed.",
        "Ding! Level %d! My character is so hardcore, they PvP with their eyes closed.",
        "Ding! Level %d! My character is max level, and I'm max addicted.",
        "Ding! Level %d! I've leveled up so much, even the Old Gods fear me.",
        "Ding! Level %d! My character is so epic, they solo raids for fun.",
        "Ding! Level %d! My character is so hardcore, they dual-wield legendary weapons.",
        "Ding! Level %d! My character has leveled up more times than I've blinked.",
        "Ding! Level %d! I've grinded so hard, my coffee machine is my best friend.",
        "Ding! Level %d! My character is so maxed out, they have their own theme music.",
        "Ding! Level %d! My character is so legendary, even Sargeras is taking notes.",
        "Ding! Level %d! My character is max level, max stats, max dedication.",
        "Ding! Level %d! My character is so hardcore, even Ragnaros calls me 'The Firelord'.",
        "Ding! Level %d! My character has leveled up so much, I should get an achievement for it.",
        "Ding! Level %d! My character is max level, and I'm max in-game hours.",
        "Ding! Level %d! My character is so epic, they defeated the Loading Screen Boss.",
        "Ding! Level %d! My character is so hardcore, they level up while sleeping.",
        "Ding! Level %d! My character is max level, and I've maxed out my keyboard.",
        "Ding! Level %d! My character is so legendary, even Arthas calls for my aid.",
        "Ding! Level %d! My character is so maxed out, even Khadgar asks for selfies.",
        "Ding! Level %d! My character is so hardcore, even Deathwing runs away.",
        "Ding! Level %d! My character is max level, and I've maxed out my social life.",
        "Ding! Level %d! My character is so legendary, they have their own holiday in Azeroth.",
        "Ding! Level %d! My character is so hardcore, they don't level up, levels level them.",
        "Ding! Level %d! My character is max level, and my life is max dungeons.",
        "Ding! Level %d! My character is so epic, they solo raid bosses with one hand.",
        "Ding! Level %d! My character is so hardcore, they have a 'Noob Slayer' title.",
        "Ding! Level %d! My character is max level, max gear, and max raiding.",
        "Ding! Level %d! My character is so legendary, they have a legendary cereal named after them.",
        "Ding! Level %d! My character is so hardcore, they PvP blindfolded and still win.",
        "Ding! Level %d! My character is max level, and my real-life XP is lacking.",
        "Ding! Level %d! My character is so legendary, even Thrall asks for advice.",
    },
    WoWFunny = {
        "Ding! Level %d! My character now qualifies for the 'Azeroth's Next Top Model' competition.",
        "Ding! Level %d! I've leveled up so much, I think I now have a PhD in 'Clicking Random Buttons'.",
        "Ding! Level %d! I've leveled up more times than I've blinked today.",
        "Ding! Level %d! My character is now so legendary, they autograph other player's gear.",
        "Ding! Level %d! I've spent more time leveling than I have at family gatherings... oops!",
        "Ding! Level %d! My character's leveling speed is faster than my Wi-Fi... on a good day.",
        "Ding! Level %d! I'm not addicted, I'm just committed to maxing out my character's awesomeness.",
        "Ding! Level %d! My character is now so epic, they defeat bosses in a rock-paper-scissors game.",
        "Ding! Level %d! I've leveled up so much, even the NPCs call me 'boss'.",
        "Ding! Level %d! My character is now maxed out in levels and bad jokes.",
        "Ding! Level %d! My character is now so good, even the game developers ask for tips.",
        "Ding! Level %d! My character is leveling up faster than my pet cat chasing a laser.",
        "Ding! Level %d! My character is so legendary, they've been nominated for 'Character of the Year'.",
        "Ding! Level %d! My character's leveling speed is faster than a mage trying to conjure snacks.",
        "Ding! Level %d! My character has leveled up so much, they're considering retirement in Dalaran.",
        "Ding! Level %d! My character is now so buffed, even the NPCs ask for workout tips.",
        "Ding! Level %d! I've leveled up more times than I've seen the sun this week.",
        "Ding! Level %d! My character is now so epic, they have their own fan club in Stormwind.",
        "Ding! Level %d! My character is leveling up faster than I can find matching socks.",
        "Ding! Level %d! My character is so powerful, they defeat monsters with a stern look.",
        "Ding! Level %d! My character's leveling speed is faster than a murloc running from a raid group.",
        "Ding! Level %d! My character is now so legendary, they have a constellation named after them.",
        "Ding! Level %d! My character has gained more levels than I've had cups of coffee today.",
        "Ding! Level %d! My character is so maxed out, they can solo a raid while doing the Macarena.",
        "Ding! Level %d! My character is now so epic, even the Lich King wants their autograph.",
        "Ding! Level %d! My character's leveling speed is faster than a mage teleporting to Ironforge.",
        "Ding! Level %d! My character is so good, even the Loading Screen Tips are impressed.",
        "Ding! Level %d! My character has leveled up so much, they're considering starting a 'Levelers Anonymous' group.",
        "Ding! Level %d! My character is so legendary, they have a theme song composed in their honor.",
        "Ding! Level %d! My character's leveling speed is faster than a rogue pickpocketing in a crowded Stormwind.",
        "Ding! Level %d! My character is so buffed, they could flex the Exodar into orbit.",
        "Ding! Level %d! My character has more levels than a multi-story gnome engineering project.",
        "Ding! Level %d! My character's leveling speed is faster than a druid shifting forms.",
        "Ding! Level %d! My character is now so epic, even the NPCs roll out the red carpet.",
        "Ding! Level %d! My character's leveling speed is faster than a warlock summoning a demon.",
        "Ding! Level %d! My character is so legendary, even Illidan is taking notes.",
        "Ding! Level %d! My character is now so maxed out, they can solo a raid with a blindfold on.",
        "Ding! Level %d! My character has gained more levels than I have gold... and that's saying something.",
        "Ding! Level %d! My character is so good, even the bosses need a strategy guide to beat them.",
        "Ding! Level %d! My character's leveling speed is faster than a mage portal network.",
        "Ding! Level %d! My character is so legendary, they've been offered a spot in the 'Epic Hall of Fame'.",
        "Ding! Level %d! My character has more levels than a tower of stacked gnomes.",
        "Ding! Level %d! My character is so buffed, they can do push-ups with an ogre on their back.",
        "Ding! Level %d! My character is now so epic, they have their own theme music when they walk.",
        "Ding! Level %d! My character's leveling speed is faster than a gnome with a rocket pack.",
        "Ding! Level %d! My character is so legendary, even Ragnaros is jealous of their fiery attitude.",
        "Ding! Level %d! My character is now max level, max coolness, and max procrastination.",
        "Ding! Level %d! My character is so good, they've been asked to write a 'Leveling for Dummies' book.",
        "Ding! Level %d! My character's leveling speed is faster than a paladin charging into battle.",
        "Ding! Level %d! My character is so legendary, even the Titans ask for advice.",
        "Ding! Level %d! My character is now so buffed, they can lift Mjolnir with one finger.",
        "Ding! Level %d! My character has gained more levels than I've had epic drops.",
        "Ding! Level %d! My character is so good, even Deathwing bowed down in respect.",
        "Ding! Level %d! My character's leveling speed is faster than a rogue pickpocketing at a trade fair.",
        "Ding! Level %d! My character is so legendary, they have a fan club in Darnassus.",
        "Ding! Level %d! My character has gained more levels than I've had Mage conjured pastries.",
        "Ding! Level %d! My character is now so maxed out, they can bench press Orgrimmar.",
        "Ding! Level %d! My character is so good, even the bosses beg for mercy.",
        "Ding! Level %d! My character's leveling speed is faster than a gnome tinkering with explosives.",
        "Ding! Level %d! My character is now so legendary, even the loading screen admires them.",
    },
    WoWLore = {
        "Ding! Level %d! Just like Thrall, I've risen from the ashes to face the challenges of Azeroth!",
        "Ding! Level %d! I'm channeling my inner Arthas as I march towards max level and beyond.",
        "Ding! Level %d! Like Jaina, I'll stand proud and strong as I progress through Azeroth's trials.",
        "Ding! Level %d! My journey echoes the lore of Illidan Stormrage, embracing power and sacrifice.",
        "Ding! Level %d! I feel the spirit of Uther the Lightbringer guiding me on this path of leveling.",
        "Ding! Level %d! Just like Sylvanas, I'm making my mark in this world, one level at a time.",
        "Ding! Level %d! Much like Malfurion Stormrage, I'm attuned to the natural flow of leveling.",
        "Ding! Level %d! My leveling journey mirrors the rise of the noble Cairne Bloodhoof.",
        "Ding! Level %d! My determination rivals that of Grom Hellscream, charging into the levels ahead.",
        "Ding! Level %d! As a true disciple of the Light, I'm leveling up with the grace of Turalyon.",
        "Ding! Level %d! Like the defiant Varian Wrynn, I stand steadfast in my leveling journey.",
        "Ding! Level %d! My determination matches that of Maiev Shadowsong as I progress in levels.",
        "Ding! Level %d! Much like Khadgar, I seek knowledge and power in the form of leveling up.",
        "Ding! Level %d! My leveling path is reminiscent of the heroic deeds of Anduin Lothar.",
        "Ding! Level %d! Embracing the fire within, I level up with the spirit of Ragnaros.",
        "Ding! Level %d! My leveling journey is a saga worthy of the high chieftain Vol'jin.",
        "Ding! Level %d! Just like the cunning Gul'dan, I'm mastering the levels through intellect and strategy.",
        "Ding! Level %d! I feel the pulse of the Emerald Dream as I level up, much like Ysera.",
        "Ding! Level %d! My leveling journey is a reflection of the fierce warrior Saurfang the Younger.",
        "Ding! Level %d! My leveling path is as legendary as the ancient dragon, Alexstrasza.",
        "Ding! Level %d! I channel the spirit of Jaina Proudmoore as I navigate the levels of Azeroth.",
        "Ding! Level %d! My leveling journey echoes the wisdom of the Prophet Velen.",
        "Ding! Level %d! Just like the legendary Deathwing, I'm causing tremors in the leveling world.",
        "Ding! Level %d! My journey through Azeroth's levels mirrors the vengeance of Akama.",
        "Ding! Level %d! Like Cenarius, I guide my path through leveling with nature's grace.",
        "Ding! Level %d! My leveling adventure is as daring as the deeds of Tirion Fordring.",
        "Ding! Level %d! My leveling journey is a reflection of the resilience of Genn Greymane.",
        "Ding! Level %d! My determination is akin to the bravery of Varok Saurfang.",
        "Ding! Level %d! Like the wise Chen Stormstout, I'm leveling up with jovial determination.",
        "Ding! Level %d! My path through the levels is as iconic as the legendary Medivh.",
        "Ding! Level %d! My leveling journey is a tribute to the legacy of Archmage Antonidas.",
        "Ding! Level %d! My leveling adventure is as enigmatic as the whispers of N'Zoth.",
        "Ding! Level %d! My leveling path mirrors the strategic prowess of Khadgar.",
        "Ding! Level %d! My journey echoes the resilience of the Earthen Ring.",
        "Ding! Level %d! I level up with the wisdom of the mighty Archimonde.",
        "Ding! Level %d! My leveling adventure is a testament to the grit of the Warchief.",
        "Ding! Level %d! I channel the essence of the Dragon Aspects in my leveling journey.",
        "Ding! Level %d! My leveling journey is as fierce as the determination of Grommash Hellscream.",
        "Ding! Level %d! My leveling path is akin to the strength of Cairne Bloodhoof.",
        "Ding! Level %d! Like the legendary Aegwynn, I wield the arcane to level up.",
        "Ding! Level %d! My journey mirrors the might of the ancient Thunderaan, Prince of Air.",
        "Ding! Level %d! My leveling adventure is as legendary as the story of the Ashbringer.",
        "Ding! Level %d! I'm leveling up with the tenacity of the mighty Thoradin.",
        "Ding! Level %d! My path through the levels echoes the lore of the Scarlet Crusade.",
        "Ding! Level %d! My leveling journey is as bold as the tale of The Dark Portal.",
        "Ding! Level %d! I channel the wisdom of the ancients, much like Fandral Staghelm.",
        "Ding! Level %d! Like the resilient Kalecgos, I rise and conquer the levels.",
        "Ding! Level %d! My leveling journey is a tribute to the honor of the Kaldorei.",
        "Ding! Level %d! My leveling adventure mirrors the strength of the mighty Turalyon.",
        "Ding! Level %d! My path through the levels is as noble as the story of Aegwynn.",
        "Ding! Level %d! Like the cunning Blackhand, I dominate the leveling world.",
        "Ding! Level %d! I'm leveling up with the zeal of the Scarlet Crusade.",
        "Ding! Level %d! My leveling journey echoes the legendary tales of the Titans.",
        "Ding! Level %d! My adventure is as mysterious as the whispers of the Old Gods.",
        "Ding! Level %d! My leveling path is as bold as the mighty Khaz'goroth.",
        "Ding! Level %d! My journey is akin to the tales of the legendary Lo'Gosh.",
        "Ding! Level %d! My leveling adventure mirrors the legendary tales of the Titans.",
        "Ding! Level %d! My path through the levels is as enigmatic as the history of Elune.",
        "Ding! Level %d! I'm leveling up with the resilience of the legendary Gnomeregan.",
        "Ding! Level %d! My leveling journey is as legendary as the ancient Tirisfal Glades.",
    },
}

local DingClassicFrame = CreateFrame("Frame")

-- Consolidate the message sending logic into a single function
local function SendRandomMessage(characterLevel)
    if DingClassicSettings.messageSent[characterLevel] then
        print("Ding message for level " .. characterLevel .. " has already been sent.")
        return
    end

    local selectedPool = messagePools[DingClassicSettings.selectedMessagePool]
    if selectedPool then
        local numMessages = #selectedPool
        if numMessages > 0 then
            local randomIndex = math.random(1, numMessages)
            local message = selectedPool[randomIndex]
            message = string.format(message, characterLevel)

            if DingClassicSettings.sendToSay then
                SendChatMessage(message, "SAY")
            end

            if DingClassicSettings.sendToGuild then
                SendChatMessage(message, "GUILD")
            end

            if DingClassicSettings.sendToParty then
                SendChatMessage(message, "PARTY")
            end

            DingClassicSettings.messageSent[characterLevel] = true
        else
            print("No messages found in the selected pool.")
        end
    else
        print("Selected message pool not found.")
    end
end

local function SaveDingClassicSettings()
    -- Save the settings
    DingClassicSavedSettings = DingClassicSettings

    -- Add this line to save the messageSent flag
    DingClassicSavedSettings.messageSent = DingClassicSettings.messageSent
end


local function InitializeOptionsPanel()
    if optionsPanelInitialized then
        return
    end

    local optionsPanel = CreateFrame("Frame", "DingClassicOptionsPanel", InterfaceOptionsFramePanelContainer)
    optionsPanel.name = "Ding Classic"

    -- Create the dropdown menu
    local dropdown = CreateFrame("Frame", "DingClassicDropdown", optionsPanel, "UIDropDownMenuTemplate")
    dropdown:SetPoint("TOPLEFT", 16, -16)
    UIDropDownMenu_SetWidth(dropdown, 160)
    UIDropDownMenu_Initialize(dropdown, function(self, level)
        local info = UIDropDownMenu_CreateInfo()

        for poolName, poolDescription in pairs(messagePoolDescriptions) do
            info.text = poolName
            info.checked = DingClassicSettings.selectedMessagePool == poolName
            info.func = function(self)
                DingClassicSettings.selectedMessagePool = self.value
                UIDropDownMenu_SetText(dropdown, self:GetText())
            end
            info.value = poolName

            -- Add tooltip information
            info.tooltipTitle = poolName
            info.tooltipText = poolDescription

            UIDropDownMenu_AddButton(info, level)
        end
    end)
    UIDropDownMenu_SetSelectedValue(dropdown, DingClassicSettings.selectedMessagePool)
    UIDropDownMenu_SetText(dropdown, DingClassicSettings.selectedMessagePool)

    -- Create the "Enable Ding Messages" checkbox
    local checkbox = CreateFrame("CheckButton", "$parentCheckbox", optionsPanel, "InterfaceOptionsCheckButtonTemplate")
    checkbox:SetPoint("TOPLEFT", dropdown, "BOTTOMLEFT", 0, -10)
    checkbox.Text:SetText("Enable Ding Messages")
    checkbox:SetChecked(DingClassicSettings.showDingMessages)

    -- Add a tooltip for the "Enable Ding Messages" checkbox
    checkbox.tooltipText = "Enable or disable displaying ding messages."
    checkbox:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(self.tooltipText, 1, 1, 1, nil, true)
        GameTooltip:Show()
    end)
    checkbox:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    checkbox:SetScript("OnClick", function(self)
        DingClassicSettings.showDingMessages = self:GetChecked()
    end)

    -- Create the "Send to Say" checkbox
    local checkboxSay = CreateFrame("CheckButton", "$parentCheckboxSay", optionsPanel, "InterfaceOptionsCheckButtonTemplate")
    checkboxSay:SetPoint("TOPLEFT", checkbox, "BOTTOMLEFT", 0, -10)
    checkboxSay.Text:SetText("Send to Say")
    checkboxSay:SetChecked(DingClassicSettings.sendToSay)

    -- Add a tooltip for the "Send to Say" checkbox
    checkboxSay.tooltipText = "Send ding messages to the Say chat channel."
    checkboxSay:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(self.tooltipText, 1, 1, 1, nil, true)
        GameTooltip:Show()
    end)
    checkboxSay:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    checkboxSay:SetScript("OnClick", function(self)
        DingClassicSettings.sendToSay = self:GetChecked()
    end)

    -- Create the "Send to Guild" checkbox
    local checkboxGuild = CreateFrame("CheckButton", "$parentCheckboxGuild", optionsPanel, "InterfaceOptionsCheckButtonTemplate")
    checkboxGuild:SetPoint("TOPLEFT", checkboxSay, "BOTTOMLEFT", 0, -10)
    checkboxGuild.Text:SetText("Send to Guild")
    checkboxGuild:SetChecked(DingClassicSettings.sendToGuild)

    -- Add a tooltip for the "Send to Guild" checkbox
    checkboxGuild.tooltipText = "Send ding messages to the Guild chat channel."
    checkboxGuild:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(self.tooltipText, 1, 1, 1, nil, true)
        GameTooltip:Show()
    end)
    checkboxGuild:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    checkboxGuild:SetScript("OnClick", function(self)
        DingClassicSettings.sendToGuild = self:GetChecked()
    end)

-- Create the "Send to Party" checkbox
local checkboxParty = CreateFrame("CheckButton", "$parentCheckboxParty", optionsPanel, "InterfaceOptionsCheckButtonTemplate")
checkboxParty:SetPoint("TOPLEFT", checkboxGuild, "BOTTOMLEFT", 0, -10)
checkboxParty.Text:SetText("Send to Party")
checkboxParty:SetChecked(DingClassicSettings.sendToParty)

    -- Add a tooltip for the "Send to Party" checkbox
    checkboxParty.tooltipText = "Send ding messages to the party chat channel."
    checkboxParty:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(self.tooltipText, 1, 1, 1, nil, true)
        GameTooltip:Show()
    end)
    checkboxParty:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    checkboxParty:SetScript("OnClick", function(self)
        DingClassicSettings.sendToParty = self:GetChecked()
    end)

-- Add a tooltip for the save button
local saveButton = CreateFrame("Button", "$parentSaveButton", optionsPanel, "UIPanelButtonTemplate")
saveButton:SetText("Save Settings")
saveButton:SetPoint("TOPLEFT", checkboxParty, "BOTTOMLEFT", 0, -20)
saveButton:SetSize(120, 25)

    saveButton.tooltipText = "Save the current settings."
    saveButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(self.tooltipText, 1, 1, 1, nil, true)
        GameTooltip:Show()
    end)
    saveButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
	saveButton:SetScript("OnClick", function()
        SaveDingClassicSettings()
    end)

-- Modify the test button creation to add a tooltip
local testButton = CreateFrame("Button", "$parentTestButton", optionsPanel, "UIPanelButtonTemplate")
testButton:SetText("Send Random Message")
testButton:SetPoint("TOPLEFT", saveButton, "BOTTOMLEFT", 0, -10)
testButton:SetSize(160, 25)

    testButton.tooltipText = "Send a random or custom message."
    testButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(self.tooltipText, 1, 1, 1, nil, true)
        GameTooltip:Show()
    end)
    testButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    testButton:SetScript("OnClick", function()
        SendRandomMessage()
    end)

    -- Register the panel
    InterfaceOptions_AddCategory(optionsPanel)
    optionsPanelInitialized = true
end

local function LoadDingClassic()
    if not isAddonLoaded then
        -- Load saved settings if available
        if DingClassicSavedSettings then
            DingClassicSettings = DingClassicSavedSettings
        end

        -- Initialize the messageSent flag for each level
        DingClassicSettings.messageSent = {}

        InitializeOptionsPanel()
        isAddonLoaded = true
        print(addonName .. " is loaded!")
    end
end

--Loads the addon and also registers the levelup event
local function OnEvent(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == addonName then
        LoadDingClassic()
    elseif event == "PLAYER_LEVEL_UP" then
        local level = arg1
        SendRandomMessage(level)
    end
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_LEVEL_UP")  -- Register for PLAYER_LEVEL_UP here
f:SetScript("OnEvent", OnEvent)

-- Define your slash commands
SLASH_DINGCLASSIC1 = "/dingclassic"
SLASH_DINGCLASSIC2 = "/ding"
SLASH_DINGCLASSIC3 = "/dc"

-- Function to open the Ding Classic options window
local function OpenDingClassicOptions()
    InterfaceOptionsFrame_OpenToCategory("Ding Classic")
end

-- Assign the function to the slash commands
SlashCmdList["DINGCLASSIC"] = OpenDingClassicOptions
SlashCmdList["DING"] = OpenDingClassicOptions
SlashCmdList["dc"] = OpenDingClassicOptions