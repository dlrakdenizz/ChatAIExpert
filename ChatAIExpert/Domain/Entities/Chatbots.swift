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
        case .drLove : return NSLocalizedString("chatbot.dr_love.description", comment: "")
        case .astroAgent : return NSLocalizedString("chatbot.astro_agent.description", comment: "")
        case .giftie : return NSLocalizedString("chatbot.giftie.description", comment: "")
        case .flirty : return NSLocalizedString("chatbot.flirty.description", comment: "")
        case .loveCode : return NSLocalizedString("chatbot.love_code.description", comment: "")
        case .nameMystic : return NSLocalizedString("chatbot.name_mystic.description", comment: "")
        case .dateGenie : return NSLocalizedString("chatbot.date_genie.description", comment: "")
        case .loveMelody : return NSLocalizedString("chatbot.love_melody.description", comment: "")
        case .slimmy: return NSLocalizedString("chatbot.slimmy.description", comment: "")
        case .gymbuddy: return NSLocalizedString("chatbot.gymbuddy.description", comment: "")
        case .nutripal: return NSLocalizedString("chatbot.nutripal.description", comment: "")
        case .musclemax: return NSLocalizedString("chatbot.musclemax.description", comment: "")
        case .burnie: return NSLocalizedString("chatbot.burnie.description", comment: "")
        case .snoozer: return NSLocalizedString("chatbot.snoozer.description", comment: "")
        case .bitebuddy: return NSLocalizedString("chatbot.bitebuddy.description", comment: "")
        case .calomate: return NSLocalizedString("chatbot.calomate.description", comment: "")
        case .theBritisher: return NSLocalizedString("chatbot.the_britisher.description", comment: "")
        case .salsaMaster: return NSLocalizedString("chatbot.salsamaster.description", comment: "")
        case .leFrancaisCharmant: return NSLocalizedString("chatbot.le_francais_charmant.description", comment: "")
        case .deutscheKraft: return NSLocalizedString("chatbot.deutschekraft.description", comment: "")
        case .mandarinMagician: return NSLocalizedString("chatbot.mandarinmagician.description", comment: "")
        case .senseiXpert: return NSLocalizedString("chatbot.senseixpert.description", comment: "")
        case .vivaItaliano: return NSLocalizedString("chatbot.vivaitaliano.description", comment: "")
        case .turkishDelight: return NSLocalizedString("chatbot.turkishdelight.description", comment: "")
        case .mathMaster: return NSLocalizedString("chatbot.mathmaster.description", comment: "")
        case .scienceSage: return NSLocalizedString("chatbot.sciencesage.description", comment: "")
        case .historyHero: return NSLocalizedString("chatbot.historyhero.description", comment: "")
        case .geoGuru: return NSLocalizedString("chatbot.geoguru.description", comment: "")
        case .litLover: return NSLocalizedString("chatbot.litlover.description", comment: "")
            
        }
    }
    
    var welcomeMessage : String {
        switch self {
        case .drLove: return NSLocalizedString("chatbot.dr_love.welcome", comment: "")
        case .astroAgent: return NSLocalizedString("chatbot.astro_agent.welcome", comment: "")
        case .giftie: return NSLocalizedString("chatbot.giftie.welcome", comment: "")
        case .flirty: return NSLocalizedString("chatbot.flirty.welcome", comment: "")
        case .loveCode: return NSLocalizedString("chatbot.love_code.welcome", comment: "")
        case .nameMystic: return NSLocalizedString("chatbot.name_mystic.welcome", comment: "")
        case .dateGenie: return NSLocalizedString("chatbot.date_genie.welcome", comment: "")
        case .loveMelody: return NSLocalizedString("chatbot.love_melody.welcome", comment: "")
        case .slimmy: return NSLocalizedString("chatbot.slimmy.welcome_message", comment: "")
        case .gymbuddy: return NSLocalizedString("chatbot.gymbuddy.welcome_message", comment: "")
        case .nutripal: return NSLocalizedString("chatbot.nutripal.welcome_message", comment: "")
        case .musclemax: return NSLocalizedString("chatbot.musclemax.welcome_message", comment: "")
        case .burnie: return NSLocalizedString("chatbot.burnie.welcome_message", comment: "")
        case .snoozer: return NSLocalizedString("chatbot.snoozer.welcome_message", comment: "")
        case .bitebuddy: return NSLocalizedString("chatbot.bitebuddy.welcome_message", comment: "")
        case .calomate: return NSLocalizedString("chatbot.calomate.welcome_message", comment: "")
        case .theBritisher: return NSLocalizedString("chatbot.the_britisher.welcome", comment: "")
        case .salsaMaster: return NSLocalizedString("chatbot.salsamaster.welcome", comment: "")
        case .leFrancaisCharmant: return NSLocalizedString("chatbot.le_francais_charmant.welcome", comment: "")
        case .deutscheKraft: return NSLocalizedString("chatbot.deutschekraft.welcome", comment: "")
        case .mandarinMagician: return NSLocalizedString("chatbot.mandarinmagician.welcome", comment: "")
        case .senseiXpert: return NSLocalizedString("chatbot.senseixpert.welcome", comment: "")
        case .vivaItaliano: return NSLocalizedString("chatbot.vivaitaliano.welcome", comment: "")
        case .turkishDelight: return NSLocalizedString("chatbot.turkishdelight.welcome", comment: "")
        case .mathMaster: return NSLocalizedString("chatbot.mathmaster.welcome", comment: "")
        case .scienceSage: return NSLocalizedString("chatbot.sciencesage.welcome", comment: "")
        case .historyHero: return NSLocalizedString("chatbot.historyhero.welcome", comment: "")
        case .geoGuru: return NSLocalizedString("chatbot.geoguru.welcome", comment: "")
        case .litLover: return NSLocalizedString("chatbot.litlover.welcome", comment: "")
        }
    }
    
    var systemPrompts : String {
        switch self {
        case .drLove: return NSLocalizedString("chatbot.dr_love.system_prompt", comment: "")
        case .astroAgent: return NSLocalizedString("chatbot.astro_agent.system_prompt", comment: "")
        case .giftie: return NSLocalizedString("chatbot.giftie.system_prompt", comment: "")
        case .flirty: return NSLocalizedString("chatbot.flirty.system_prompt", comment: "")
        case .loveCode: return NSLocalizedString("chatbot.love_code.system_prompt", comment: "")
        case .nameMystic: return NSLocalizedString("chatbot.name_mystic.system_prompt", comment: "")
        case .dateGenie: return NSLocalizedString("chatbot.date_genie.system_prompt", comment: "")
        case .loveMelody: return NSLocalizedString("chatbot.love_melody.system_prompt", comment: "")
        case .slimmy: return NSLocalizedString("chatbot.slimmy.prompt", comment: "")
        case .gymbuddy: return NSLocalizedString("chatbot.gymbuddy.prompt", comment: "")
        case .nutripal: return NSLocalizedString("chatbot.nutripal.prompt", comment: "")
        case .musclemax: return NSLocalizedString("chatbot.musclemax.prompt", comment: "")
        case .burnie: return NSLocalizedString("chatbot.burnie.prompt", comment: "")
        case .snoozer: return NSLocalizedString("chatbot.snoozer.prompt", comment: "")
        case .bitebuddy: return NSLocalizedString("chatbot.bitebuddy.prompt", comment: "")
        case .calomate: return NSLocalizedString("chatbot.calomate.prompt", comment: "")
        case .theBritisher: return NSLocalizedString("chatbot.the_britisher.system_prompt", comment: "")
        case .salsaMaster: return NSLocalizedString("chatbot.salsamaster.system_prompt", comment: "")
        case .leFrancaisCharmant: return NSLocalizedString("chatbot.le_francais_charmant.system_prompt", comment: "")
        case .deutscheKraft: return NSLocalizedString("chatbot.deutschekraft.system_prompt", comment: "")
        case .mandarinMagician: return NSLocalizedString("chatbot.mandarinmagician.system_prompt", comment: "")
        case .senseiXpert: return NSLocalizedString("chatbot.senseixpert.system_prompt", comment: "")
        case .vivaItaliano: return NSLocalizedString("chatbot.vivaitaliano.system_prompt", comment: "")
        case .turkishDelight: return NSLocalizedString("chatbot.turkishdelight.system_prompt", comment: "")
        case .mathMaster: return NSLocalizedString("chatbot.mathmaster.system_prompt", comment: "")
        case .scienceSage: return NSLocalizedString("chatbot.sciencesage.system_prompt", comment: "")
        case .historyHero: return NSLocalizedString("chatbot.historyhero.system_prompt", comment: "")
        case .geoGuru: return NSLocalizedString("chatbot.geoguru.system_prompt", comment: "")
        case .litLover: return NSLocalizedString("chatbot.litlover.system_prompt", comment: "")
        }
    }
}

