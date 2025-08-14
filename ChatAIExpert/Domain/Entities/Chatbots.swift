//
//  Chatbots.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 13.07.2025.
//

import Foundation

enum Chatbots : String, CaseIterable, Codable {
    //Relationship
    case drLove
    case astroAgent
    case giftie
    case flirty
    case loveCode
    case nameMystic
    case dateGenie
    case loveMelody
    
    // Health
    case slimmy
    case gymbuddy
    case nutripal
    case musclemax
    case burnie
    case snoozer
    case bitebuddy
    case calomate
    
    // Education
    case mathMaster
    case scienceSage
    case historyHero
    case geoGuru
    case litLover
    
    //Language
    case theBritisher
    case salsaMaster
    case leFrancaisCharmant
    case deutscheKraft
    case mandarinMagician
    case senseiXpert
    case vivaItaliano
    case turkishDelight
    
    
    var image : String {
        switch self {
        case .drLove : "dr_love"
        case .astroAgent : "astro_agent"
        case .giftie : "giftie"
        case .flirty : "flirty"
        case .loveCode : "love_code"
        case .nameMystic : "name_mystic"
        case .dateGenie : "date_genie"
        case .loveMelody : "love_melody" 
        case .slimmy: "slimmy"
        case .gymbuddy: "gym_buddy"
        case .nutripal: "nutripal"
        case .musclemax: "muscle_max"
        case .burnie: "burnie"
        case .snoozer: "snoozer"
        case .bitebuddy: "bite_buddy"
        case .calomate: "calomate"
        case .theBritisher: "the_britisher"
        case .salsaMaster: "salsa_master"
        case .leFrancaisCharmant: "le_francais_charmant"
        case .deutscheKraft: "deutsche_kraft"
        case .mandarinMagician: "mandarin_magician"
        case .senseiXpert: "sensei_xpert"
        case .vivaItaliano: "viva_italiano"
        case .turkishDelight: "turkish_delight"
        case .mathMaster: "math_master"
        case .scienceSage: "science_sage"
        case .historyHero: "history_hero"
        case .geoGuru: "geo_guru"
        case .litLover: "lit_lover"
        }
    }
    
    var title : String {
        switch self {
        case .drLove : "DR. LOVE"
        case .astroAgent : "AstroAgent"
        case .giftie : "Giftie"
        case .flirty : "Flirty"
        case .loveCode : "LoveCode"
        case .nameMystic : "NameMystic"
        case .dateGenie : "DateGenie"
        case .loveMelody : "LoveMelody"
        case .slimmy: "Slimmy"
        case .gymbuddy: "GymBuddy"
        case .nutripal: "Nutripal"
        case .musclemax: "MuscleMax"
        case .burnie: "Burnie"
        case .snoozer: "Snoozer"
        case .bitebuddy: "BiteBuddy"
        case .calomate: "Calomate"
        case .theBritisher: "The Britisher"
        case .salsaMaster: "SalsaMaster"
        case .leFrancaisCharmant: "Le Francais Charmant"
        case .deutscheKraft: "DeutscheKraft"
        case .mandarinMagician: "MandarinMagician"
        case .senseiXpert: "SenseiXpert"
        case .vivaItaliano: "VivaItaliano"
        case .turkishDelight: "TurkishDelight"
        case .mathMaster: "MathMaster"
        case .scienceSage: "ScienceSage"
        case .historyHero: "HistoryHero"
        case .geoGuru: "GeoGuru"
        case .litLover: "LitLover"
        }
    }
    
    var description : String {
        switch self {
        case .drLove : return localized("chatbot.dr_love.description")
        case .astroAgent : return localized("chatbot.astro_agent.description")
        case .giftie : return localized("chatbot.giftie.description")
        case .flirty : return localized("chatbot.flirty.description")
        case .loveCode : return localized("chatbot.love_code.description")
        case .nameMystic : return localized("chatbot.name_mystic.description")
        case .dateGenie : return localized("chatbot.date_genie.description")
        case .loveMelody : return localized("chatbot.love_melody.description")
        case .slimmy: return localized("chatbot.slimmy.description")
        case .gymbuddy: return localized("chatbot.gymbuddy.description")
        case .nutripal: return localized("chatbot.nutripal.description")
        case .musclemax: return localized("chatbot.musclemax.description")
        case .burnie: return localized("chatbot.burnie.description")
        case .snoozer: return localized("chatbot.snoozer.description")
        case .bitebuddy: return localized("chatbot.bitebuddy.description")
        case .calomate: return localized("chatbot.calomate.description")
        case .theBritisher: return localized("chatbot.the_britisher.description")
        case .salsaMaster: return localized("chatbot.salsamaster.description")
        case .leFrancaisCharmant: return localized("chatbot.le_francais_charmant.description")
        case .deutscheKraft: return localized("chatbot.deutschekraft.description")
        case .mandarinMagician: return localized("chatbot.mandarinmagician.description")
        case .senseiXpert: return localized("chatbot.senseixpert.description")
        case .vivaItaliano: return localized("chatbot.vivaitaliano.description")
        case .turkishDelight: return localized("chatbot.turkishdelight.description")
        case .mathMaster: return localized("chatbot.mathmaster.description")
        case .scienceSage: return localized("chatbot.sciencesage.description")
        case .historyHero: return localized("chatbot.historyhero.description")
        case .geoGuru: return localized("chatbot.geoguru.description")
        case .litLover: return localized("chatbot.litlover.description")
            
        }
    }
    
    var welcomeMessage : String {
        switch self {
        case .drLove: return localized("chatbot.dr_love.welcome")
        case .astroAgent: return localized("chatbot.astro_agent.welcome")
        case .giftie: return localized("chatbot.giftie.welcome")
        case .flirty: return localized("chatbot.flirty.welcome")
        case .loveCode: return localized("chatbot.love_code.welcome")
        case .nameMystic: return localized("chatbot.name_mystic.welcome")
        case .dateGenie: return localized("chatbot.date_genie.welcome")
        case .loveMelody: return localized("chatbot.love_melody.welcome")
        case .slimmy: return localized("chatbot.slimmy.welcome_message")
        case .gymbuddy: return localized("chatbot.gymbuddy.welcome_message")
        case .nutripal: return localized("chatbot.nutripal.welcome_message")
        case .musclemax: return localized("chatbot.musclemax.welcome_message")
        case .burnie: return localized("chatbot.burnie.welcome_message")
        case .snoozer: return localized("chatbot.snoozer.welcome_message")
        case .bitebuddy: return localized("chatbot.bitebuddy.welcome_message")
        case .calomate: return localized("chatbot.calomate.welcome_message")
        case .theBritisher: return localized("chatbot.the_britisher.welcome")
        case .salsaMaster: return localized("chatbot.salsamaster.welcome")
        case .leFrancaisCharmant: return localized("chatbot.le_francais_charmant.welcome")
        case .deutscheKraft: return localized("chatbot.deutschekraft.welcome")
        case .mandarinMagician: return localized("chatbot.mandarinmagician.welcome")
        case .senseiXpert: return localized("chatbot.senseixpert.welcome")
        case .vivaItaliano: return localized("chatbot.vivaitaliano.welcome")
        case .turkishDelight: return localized("chatbot.turkishdelight.welcome")
        case .mathMaster: return localized("chatbot.mathmaster.welcome")
        case .scienceSage: return localized("chatbot.sciencesage.welcome")
        case .historyHero: return localized("chatbot.historyhero.welcome")
        case .geoGuru: return localized("chatbot.geoguru.welcome")
        case .litLover: return localized("chatbot.litlover.welcome")
        }
    }
    
    var systemPrompts : String {
        switch self {
        case .drLove: return localized("chatbot.dr_love.system_prompt")
        case .astroAgent: return localized("chatbot.astro_agent.system_prompt")
        case .giftie: return localized("chatbot.giftie.system_prompt")
        case .flirty: return localized("chatbot.flirty.system_prompt")
        case .loveCode: return localized("chatbot.love_code.system_prompt")
        case .nameMystic: return localized("chatbot.name_mystic.system_prompt")
        case .dateGenie: return localized("chatbot.date_genie.system_prompt")
        case .loveMelody: return localized("chatbot.love_melody.system_prompt")
        case .slimmy: return localized("chatbot.slimmy.prompt")
        case .gymbuddy: return localized("chatbot.gymbuddy.prompt")
        case .nutripal: return localized("chatbot.nutripal.prompt")
        case .musclemax: return localized("chatbot.musclemax.prompt")
        case .burnie: return localized("chatbot.burnie.prompt")
        case .snoozer: return localized("chatbot.snoozer.prompt")
        case .bitebuddy: return localized("chatbot.bitebuddy.prompt")
        case .calomate: return localized("chatbot.calomate.prompt")
        case .theBritisher: return localized("chatbot.the_britisher.system_prompt")
        case .salsaMaster: return localized("chatbot.salsamaster.system_prompt")
        case .leFrancaisCharmant: return localized("chatbot.le_francais_charmant.system_prompt")
        case .deutscheKraft: return localized("chatbot.deutschekraft.system_prompt")
        case .mandarinMagician: return localized("chatbot.mandarinmagician.system_prompt")
        case .senseiXpert: return localized("chatbot.senseixpert.system_prompt")
        case .vivaItaliano: return localized("chatbot.vivaitaliano.system_prompt")
        case .turkishDelight: return localized("chatbot.turkishdelight.system_prompt")
        case .mathMaster: return localized("chatbot.mathmaster.system_prompt")
        case .scienceSage: return localized("chatbot.sciencesage.system_prompt")
        case .historyHero: return localized("chatbot.historyhero.system_prompt")
        case .geoGuru: return localized("chatbot.geoguru.system_prompt")
        case .litLover: return localized("chatbot.litlover.system_prompt")
        }
    }
}

