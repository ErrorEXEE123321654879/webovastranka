local currentCategory = nil
local currentLanguage = nil
local currentQuestion = 1
local totalErrors = 0
local answeredQuestions = {}

-- ====================================
-- SPUSTIT TEORETICKOU ZKOUŠKU
-- ====================================

function StartTheory(category, language)
    currentCategory = category
    currentLanguage = language
    currentQuestion = 1
    totalErrors = 0
    answeredQuestions = {}
    
    -- Načti otázky
    local questions = Locales[language]['questions']
    
    -- Zamíchej otázky
    local shuffled = {}
    for i = 1, #questions do
        local pos = math.random(1, #shuffled + 1)
        table.insert(shuffled, pos, questions[i])
    end
    
    -- Vezmi pouze potřebný počet
    local selectedQuestions = {}
    for i = 1, Config.Theory.questions_count do
        table.insert(selectedQuestions, shuffled[i])
    end
    
    -- Otevři NUI s první otázkou
    OpenTheoryUI(selectedQuestions)
end

-- ====================================
-- OTEVŘÍT THEORY NUI
-- ====================================

function OpenTheoryUI(questions)
    SetNuiFocus(true, true)
    
    SendNUIMessage({
        action = 'openTheory',
        questions = questions,
        currentQuestion = currentQuestion,
        totalQuestions = #questions,
        maxErrors = Config.Theory.max_errors,
        colors = Config.UI
    })
end

-- ====================================
-- NUI CALLBACK: ODPOVĚĎ
-- ====================================

RegisterNUICallback('answerQuestion', function(data, cb)
    local questions = Locales[currentLanguage]['questions']
    local questionData = questions[data.questionIndex]
    
    local isCorrect = data.answer == questionData.correct
    
    if not isCorrect then
        totalErrors = totalErrors + 1
    end
    
    table.insert(answeredQuestions, {
        question = data.questionIndex,
        answer = data.answer,
        correct = isCorrect
    })
    
    -- Kontrola zda neprošel
    if totalErrors > Config.Theory.max_errors then
        FinishTheory(false)
        cb({success = false, failed = true})
        return
    end
    
    -- Další otázka nebo konec
    if #answeredQuestions >= Config.Theory.questions_count then
        FinishTheory(true)
        cb({success = true, finished = true})
    else
        currentQuestion = currentQuestion + 1
        cb({success = true, continue = true})
    end
end)

-- ====================================
-- NUI CALLBACK: ZAVŘÍT
-- ====================================

RegisterNUICallback('closeTheory', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

-- ====================================
-- DOKONČIT TEORII
-- ====================================

function FinishTheory(passed)
    SetNuiFocus(false, false)
    
    -- Ulož výsledek
    TriggerServerEvent('tx_drivingschool:saveTheoryResult', currentCategory, passed, totalErrors, currentLanguage)
    TriggerServerEvent('tx_drivingschool:endExam')
    
    if passed then
        lib.notify({
            title = 'Teoretická zkouška',
            description = string.format(_U('theory_passed'), totalErrors, Config.Theory.max_errors),
            type = 'success',
            duration = 7000
        })
    else
        lib.notify({
            title = 'Teoretická zkouška',
            description = string.format(_U('theory_failed'), totalErrors, Config.Theory.max_errors),
            type = 'error',
            duration = 7000
        })
    end
    
    -- Reset
    currentCategory = nil
    currentLanguage = nil
    currentQuestion = 1
    totalErrors = 0
    answeredQuestions = {}
end

-- ====================================
-- EXPORT
-- ====================================

exports('StartTheory', StartTheory)
