ESX = exports["es_extended"]:getSharedObject()

local selectedLanguage = Config.Locale
local playerLicenses = nil
local inExam = false

-- ====================================
-- VYTVOŘENÍ BLIPU
-- ====================================

CreateThread(function()
    if Config.SchoolLocation.blip.enabled then
        local blip = AddBlipForCoord(Config.SchoolLocation.marker.coords.x, Config.SchoolLocation.marker.coords.y, Config.SchoolLocation.marker.coords.z)
        SetBlipSprite(blip, Config.SchoolLocation.blip.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, Config.SchoolLocation.blip.scale)
        SetBlipColour(blip, Config.SchoolLocation.blip.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.SchoolLocation.blip.label)
        EndTextCommandSetBlipName(blip)
    end
end)

-- ====================================
-- INTERAKCE S AUTOŠKOLU
-- ====================================

CreateThread(function()
    local point = lib.points.new({
        coords = Config.SchoolLocation.interaction.coords,
        distance = Config.SchoolLocation.interaction.distance,
    })

    function point:onEnter()
        lib.showTextUI(Config.SchoolLocation.interaction.label, {
            position = "right-center",
            icon = 'fa-solid fa-car',
            style = {
                borderRadius = 5,
                backgroundColor = Config.UI.primary_color,
                color = Config.UI.secondary_color
            }
        })
    end

    function point:onExit()
        lib.hideTextUI()
    end

    function point:nearby()
        if self.currentDistance < 2.5 and IsControlJustReleased(0, 38) then -- E
            OpenMainMenu()
        end
    end
end)

-- ====================================
-- HLAVNÍ MENU
-- ====================================

function OpenMainMenu()
    -- Nejprve výběr jazyka pokud není nastaven
    if not selectedLanguage then
        SelectLanguage()
        return
    end
    
    -- Kontrola zda není v aktivní zkoušce
    ESX.TriggerServerCallback('tx_drivingschool:isInExam', function(isInExam)
        if isInExam then
            lib.notify({
                title = 'Autoškola',
                description = _U('already_in_exam'),
                type = 'error'
            })
            return
        end
        
        -- Načíst licence hráče
        ESX.TriggerServerCallback('tx_drivingschool:getLicenses', function(licenses)
            playerLicenses = licenses
            ShowCategoryMenu()
        end)
    end)
end

-- ====================================
-- VÝBĚR JAZYKA
-- ====================================

function SelectLanguage()
    lib.registerContext({
        id = 'language_select',
        title = _U('language_select'),
        options = {
            {
                title = '🇨🇿 Čeština',
                description = 'Czech language',
                icon = 'flag',
                onSelect = function()
                    selectedLanguage = 'cs'
                    Config.Locale = 'cs'
                    lib.notify({
                        title = 'Jazyk nastaven',
                        description = 'Byl nastaven český jazyk',
                        type = 'success'
                    })
                    Wait(500)
                    OpenMainMenu()
                end
            },
            {
                title = '🇸🇰 Slovenčina',
                description = 'Slovak language',
                icon = 'flag',
                onSelect = function()
                    selectedLanguage = 'sk'
                    Config.Locale = 'sk'
                    lib.notify({
                        title = 'Jazyk nastavený',
                        description = 'Bol nastavený slovenský jazyk',
                        type = 'success'
                    })
                    Wait(500)
                    OpenMainMenu()
                end
            }
        }
    })
    lib.showContext('language_select')
end

-- ====================================
-- MENU KATEGORIÍ
-- ====================================

function ShowCategoryMenu()
    local options = {}
    
    for cat, data in pairs(Config.Categories) do
        local hasLicense = false
        
        if playerLicenses then
            local column = 'category_' .. cat
            hasLicense = playerLicenses[column] == 1
        end
        
        local status = hasLicense and '✅ ' .. _U('already_have') or '❌'
        local description = data.description .. '\n' .. status
        
        table.insert(options, {
            title = data.icon .. ' ' .. data.label,
            description = description,
            icon = 'car',
            disabled = hasLicense,
            onSelect = function()
                ShowExamMenu(cat)
            end
        })
    end
    
    -- Možnost změnit jazyk
    table.insert(options, {
        title = '🌍 ' .. _U('language_select'),
        description = 'Aktuální: ' .. (selectedLanguage == 'cs' and 'Čeština' or 'Slovenčina'),
        icon = 'language',
        onSelect = function()
            SelectLanguage()
        end
    })
    
    lib.registerContext({
        id = 'category_menu',
        title = _U('menu_title'),
        options = options
    })
    lib.showContext('category_menu')
end

-- ====================================
-- MENU ZKOUŠKY (TEORIE/PRAKTIKA)
-- ====================================

function ShowExamMenu(category)
    -- Zkontroluj zda má teorii
    ESX.TriggerServerCallback('tx_drivingschool:hasPassedTheory', function(hasTheory)
        local options = {
            {
                title = '📚 ' .. _U('start_theory'),
                description = _U('price') .. ': ' .. Config.Prices.theory_only .. ' Kč\n' .. Config.Theory.questions_count .. ' otázek, max ' .. Config.Theory.max_errors .. ' chyby',
                icon = 'book',
                onSelect = function()
                    StartTheoryExam(category)
                end
            }
        }
        
        if hasTheory then
            table.insert(options, {
                title = '🚗 ' .. _U('start_practical'),
                description = _U('price') .. ': ' .. Config.Prices.practical_only .. ' Kč\n3 fáze: Cvičiště → Město → Dálnice',
                icon = 'car',
                onSelect = function()
                    StartPracticalExam(category)
                end
            })
        else
            table.insert(options, {
                title = '🚗 ' .. _U('start_practical'),
                description = _U('need_theory_first'),
                icon = 'car',
                disabled = true
            })
        end
        
        table.insert(options, {
            title = '◀️ Zpět',
            icon = 'arrow-left',
            onSelect = function()
                ShowCategoryMenu()
            end
        })
        
        lib.registerContext({
            id = 'exam_menu',
            title = Config.Categories[category].icon .. ' ' .. Config.Categories[category].label,
            options = options
        })
        lib.showContext('exam_menu')
    end, category)
end

-- ====================================
-- SPUSTIT TEORII
-- ====================================

function StartTheoryExam(category)
    ESX.TriggerServerCallback('tx_drivingschool:checkMoney', function(hasMoney)
        if not hasMoney then
            lib.notify({
                title = 'Autoškola',
                description = _U('not_enough_money', Config.Prices.theory_only),
                type = 'error'
            })
            return
        end
        
        -- Odečti peníze
        TriggerServerEvent('tx_drivingschool:takeMoney', Config.Prices.theory_only)
        TriggerServerEvent('tx_drivingschool:startExam', category, 'theory')
        
        -- Spusť teorii
        exports.tx_drivingschool:StartTheory(category, selectedLanguage)
        
    end, Config.Prices.theory_only)
end

-- ====================================
-- SPUSTIT PRAKTIKU
-- ====================================

function StartPracticalExam(category)
    ESX.TriggerServerCallback('tx_drivingschool:checkMoney', function(hasMoney)
        if not hasMoney then
            lib.notify({
                title = 'Autoškola',
                description = _U('not_enough_money', Config.Prices.practical_only),
                type = 'error'
            })
            return
        end
        
        -- Odečti peníze
        TriggerServerEvent('tx_drivingschool:takeMoney', Config.Prices.practical_only)
        TriggerServerEvent('tx_drivingschool:startExam', category, 'practical')
        
        -- Spusť praktiku
        exports.tx_drivingschool:StartPractical(category, selectedLanguage)
        
    end, Config.Prices.practical_only)
end

-- ====================================
-- HELPER: Překlad
-- ====================================

function _U(str, ...)
    if Locales[Config.Locale] and Locales[Config.Locale][str] then
        return string.format(Locales[Config.Locale][str], ...)
    else
        return 'Translation [' .. str .. '] not found'
    end
end

-- ====================================
-- EXPORTS
-- ====================================

exports('OpenMainMenu', OpenMainMenu)
exports('GetPlayerLicenses', function() return playerLicenses end)
