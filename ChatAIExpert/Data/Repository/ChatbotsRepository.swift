//
//  ChatbotsRepository.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 13.07.2025.
//

import Foundation

class ChatbotsRepository : ChatbotsRepositoryProtocol {
    
    func fetchAllChatbots() -> [Chatbots] {
        return Chatbots.allCases
    }
    
    func fetchChatbotsByCategory(_ category: ChatbotCategory) -> [Chatbots] {
        let allChatbots = fetchAllChatbots()
        switch category {
        case .saved:
            return SavedChatbotsManager.shared.getSavedChatbots()
        case .popular:
            return allChatbots.filter { [.chatAI, .drLove, .flirty, .loveMelody, .slimmy, .gymbuddy, .salsaMaster, .turkishDelight, .mathMaster ].contains($0) }
        case .relationship:
            return allChatbots.filter { [.drLove, .astroAgent, .giftie, .flirty, .loveCode, .nameMystic, .dateGenie, .loveMelody].contains($0) }
        case .health:
            return allChatbots.filter { [.slimmy, .gymbuddy, .nutripal, .musclemax, .burnie, .snoozer, .bitebuddy, .calomate].contains($0) }
        case .language:
            return allChatbots.filter { [.theBritisher, .salsaMaster, .leFrancaisCharmant, .deutscheKraft, .mandarinMagician, .senseiXpert, .vivaItaliano, .turkishDelight].contains($0) }
        case .education:
            return allChatbots.filter { [.mathMaster, .scienceSage, .historyHero, .geoGuru, .litLover].contains($0) }
            
        }
    }
    
    // MARK: - Saved Chatbots Operations (Delegate to SavedChatbotsManager)
    func saveChatbot(_ chatbot: Chatbots) {
        SavedChatbotsManager.shared.saveChatbot(chatbot)
    }
    
    func unsaveChatbot(_ chatbot: Chatbots) {
        SavedChatbotsManager.shared.unsaveChatbot(chatbot)
    }
    
    func getSavedChatbots() -> [Chatbots] {
        return SavedChatbotsManager.shared.getSavedChatbots()
    }
    
    func isChatbotSaved(_ chatbot: Chatbots) -> Bool {
        return SavedChatbotsManager.shared.isChatbotSaved(chatbot)
    }
}
