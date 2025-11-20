Locales['cs'] = {
    -- ====================================
    -- UI TEXTY
    -- ====================================
    ['menu_title'] = 'Autoškola',
    ['menu_subtitle'] = 'Vyberte si kategorii řidičského oprávnění',
    ['language_select'] = 'Vyberte jazyk / Select Language',
    ['select_category'] = 'Vybrat kategorii',
    ['start_theory'] = 'Zahájit teoretickou zkoušku',
    ['start_practical'] = 'Zahájit praktickou zkoušku',
    ['view_license'] = 'Zobrazit řidičský průkaz',
    ['already_have'] = 'Již vlastníte',
    ['price'] = 'Cena',
    ['retry_price'] = 'Opakování',
    
    -- ====================================
    -- NOTIFIKACE
    -- ====================================
    ['not_enough_money'] = 'Nemáte dostatek peněz! Potřebujete %s Kč',
    ['theory_passed'] = 'Gratulujeme! Prošli jste teoretickou zkouškou (%s/%s chyb)',
    ['theory_failed'] = 'Neprošli jste! Udělali jste %s chyb (max %s)',
    ['practical_passed'] = 'Výborně! Prošli jste praktickou zkouškou!',
    ['practical_failed'] = 'Zkouška neúspěšná! Chyby: %s/%s',
    ['license_obtained'] = 'Získali jste řidičský průkaz kategorie %s!',
    ['already_in_exam'] = 'Již máte rozjetou zkoušku!',
    ['need_theory_first'] = 'Nejprve musíte projít teoretickou zkouškou!',
    
    -- ====================================
    -- PRAKTICKÁ ZKOUŠKA - INSTRUKCE
    -- ====================================
    ['phase_1'] = 'Fáze 1: Jízdní cvičiště',
    ['phase_2'] = 'Fáze 2: Městská jízda',
    ['phase_3'] = 'Fáze 3: Dálnice',
    ['instructor_welcome'] = 'Dobrý den, já budu váš instruktor. Začneme na cvičišti.',
    ['instructor_cones_start'] = 'Nyní provedeme cvičení s kužely. Postupujte pomalu.',
    ['instructor_city_start'] = 'Výborně! Nyní vyjedeme do města. Sledujte semafory a značky.',
    ['instructor_highway_start'] = 'Teď vyjedeme na dálnici. Držte se vpravo a dodržujte rychlost.',
    ['instructor_checkpoint'] = 'Pokračujte k dalšímu bodu.',
    ['instructor_speed_warning'] = 'Zpomalte! Překročili jste povolenou rychlost!',
    ['instructor_crash'] = 'To byla nehoda! Buďte opatrnější.',
    ['instructor_red_light'] = 'Projeli jste na červenou! To je chyba.',
    ['instructor_final'] = 'Směřujeme zpět do autoškoly. Už to máte skoro za sebou.',
    
    -- ====================================
    -- HUD TEXTY
    -- ====================================
    ['speed'] = 'Rychlost',
    ['errors'] = 'Chyby',
    ['checkpoint'] = 'Checkpoint',
    ['phase'] = 'Fáze',
    
    -- ====================================
    -- TEORETICKÁ ZKOUŠKA - 25 OTÁZEK
    -- ====================================
    ['questions'] = {
        {
            question = "Co znamená tato dopravní značka? (červený trojúhelník s vykřičníkem)",
            answers = {
                "Jiné nebezpečí",
                "Zákaz vjezdu",
                "Konec všech zákazů",
                "Hlavní silnice"
            },
            correct = 1
        },
        {
            question = "Na křižovatce se značkou 'Dej přednost v jízdě' musíte:",
            answers = {
                "Vždy zastavit",
                "Dát přednost vozidlům na hlavní silnici",
                "Jet bez zastavení",
                "Troubí a projet"
            },
            correct = 2
        },
        {
            question = "Maximální povolená rychlost v obci je:",
            answers = {
                "40 km/h",
                "50 km/h",
                "60 km/h",
                "70 km/h"
            },
            correct = 2
        },
        {
            question = "Bezpečnostní pásy jsou povinné:",
            answers = {
                "Pouze na dálnici",
                "Pouze pro řidiče",
                "Pro všechny cestující",
                "Jen při rychlosti nad 90 km/h"
            },
            correct = 3
        },
        {
            question = "Modrá kulatá značka s bílou šipkou doprava znamená:",
            answers = {
                "Zákaz odbočení vpravo",
                "Přikázaný směr jízdy vpravo",
                "Hlavní silnice vpravo",
                "Informace o směru"
            },
            correct = 2
        },
        {
            question = "Při jízdě za deště byste měli:",
            answers = {
                "Jet rychleji kvůli aquaplaningu",
                "Zvýšit bezpečný odstup",
                "Vypnout světla",
                "Nic neměnit"
            },
            correct = 2
        },
        {
            question = "Červený trojúhelník s dvěma dětmi znamená:",
            answers = {
                "Škola",
                "Děti",
                "Hřiště",
                "Zákaz vjezdu dětí"
            },
            correct = 2
        },
        {
            question = "Na přechodu pro chodce musíte:",
            answers = {
                "Jet rychle",
                "Dát přednost chodcům",
                "Zatroubit",
                "Projet bez ohledu na chodce"
            },
            correct = 2
        },
        {
            question = "Žlutá přerušovaná čára na vozovce znamená:",
            answers = {
                "Zákaz předjíždění",
                "Dočasné dopravní značení",
                "Konec vozovky",
                "Parkovací místo"
            },
            correct = 2
        },
        {
            question = "Při odbočování vlevo v křižovatce dáváte přednost:",
            answers = {
                "Pouze vozidlům zprava",
                "Vozidlům protijedoucím rovně",
                "Nikomu",
                "Pouze cyklistům"
            },
            correct = 2
        },
        {
            question = "Modrá značka s písmenem 'P' znamená:",
            answers = {
                "Zákaz parkování",
                "Parkoviště",
                "Přechod pro chodce",
                "Policejní stanice"
            },
            correct = 2
        },
        {
            question = "Maximální rychlost mimo obec na silnici je:",
            answers = {
                "70 km/h",
                "80 km/h",
                "90 km/h",
                "100 km/h"
            },
            correct = 3
        },
        {
            question = "Při jízdě v tunelu musíte:",
            answers = {
                "Vypnout světla",
                "Mít rozsvícená světla",
                "Jet maximální rychlostí",
                "Zastavit"
            },
            correct = 2
        },
        {
            question = "Červený kruh s bílou vodorovnou čarou znamená:",
            answers = {
                "Zákaz vjezdu",
                "Jednosměrná ulice",
                "Konec zákazu",
                "Hlavní silnice"
            },
            correct = 1
        },
        {
            question = "Co je aquaplaning?",
            answers = {
                "Sportovní disciplína",
                "Ztráta přilnavosti pneumatik na mokré vozovce",
                "Typ vozu",
                "Závodní technika"
            },
            correct = 2
        },
        {
            question = "Na dálnici je minimální povolená rychlost:",
            answers = {
                "50 km/h",
                "60 km/h",
                "80 km/h",
                "Není stanovena"
            },
            correct = 3
        },
        {
            question = "Při předjíždění musíte:",
            answers = {
                "Předjíždět zprava",
                "Předjíždět zleva",
                "Zatroubit",
                "Blikat všemi světly"
            },
            correct = 2
        },
        {
            question = "Červený trojúhelník se sobem znamená:",
            answers = {
                "Pozor, sob!",
                "Zvěř",
                "Zoo",
                "Zákaz lovu"
            },
            correct = 2
        },
        {
            question = "Povinná výbava vozidla obsahuje:",
            answers = {
                "Pouze lékárničku",
                "Lékárničku, trojúhelník, reflexní vestu",
                "Jen hasicí přístroj",
                "Pouze mobilní telefon"
            },
            correct = 2
        },
        {
            question = "Při couvání jste povinni:",
            answers = {
                "Jet rychle",
                "Dávat pozor na ostatní",
                "Nedávat znamení",
                "Zavřít oči"
            },
            correct = 2
        },
        {
            question = "Žlutá nepřerušovaná čára znamená:",
            answers = {
                "Můžete přejet",
                "Zákaz zastavení",
                "Parkovací místo",
                "Přechod"
            },
            correct = 2
        },
        {
            question = "Co znamená blikající zelená na semaforu?",
            answers = {
                "Zrychlit",
                "Připravit se na červenou",
                "Zastavit okamžitě",
                "Přednost zprava"
            },
            correct = 2
        },
        {
            question = "Při jízdě v mlze musíte:",
            answers = {
                "Jet rychle",
                "Použít mlhová světla",
                "Vypnout světla",
                "Nic"
            },
            correct = 2
        },
        {
            question = "Červený trojúhelník s obrázkem auta a vlaku znamená:",
            answers = {
                "Parkoviště pro vlaky",
                "Železniční přejezd",
                "Nádraží",
                "Muzeum dopravy"
            },
            correct = 2
        },
        {
            question = "Pod vlivem alkoholu je povoleno řídit:",
            answers = {
                "Do 0,5 promile",
                "Nikdy",
                "Do 1,0 promile",
                "Podle vlastního uvážení"
            },
            correct = 2
        }
    }
}
