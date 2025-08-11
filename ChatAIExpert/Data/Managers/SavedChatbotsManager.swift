//
//  SavedChatbotsManager.swift
//  ChatAI
//
//  Created by Dilara Akdeniz on 27.07.2025.
//

import Foundation

class SavedChatbotsManager {
    static let shared = SavedChatbotsManager()
    private let userDefaults = UserDefaults.standard
    private let savedChatbotsKey = "savedChatbots"
    
    private init() {}
    
    func saveChatbot(_ chatbot: Chatbots) {
        var savedChatbots = getSavedChatbots()
        if !savedChatbots.contains(chatbot) {
            savedChatbots.append(chatbot)
            saveToUserDefaults(savedChatbots)
        }
    }
    
    func unsaveChatbot(_ chatbot: Chatbots) {
        var savedChatbots = getSavedChatbots()
        savedChatbots.removeAll { $0 == chatbot }
        saveToUserDefaults(savedChatbots)
    }
    
    func isChatbotSaved(_ chatbot: Chatbots) -> Bool {
        return getSavedChatbots().contains(chatbot)
    }
    
    func getSavedChatbots() -> [Chatbots] {
        guard let data = userDefaults.data(forKey: savedChatbotsKey),
              let savedChatbots = try? JSONDecoder().decode([Chatbots].self, from: data) else {
            return []
        }
        return savedChatbots
    }
    
    private func saveToUserDefaults(_ chatbots: [Chatbots]) {
        if let data = try? JSONEncoder().encode(chatbots) {
            userDefaults.set(data, forKey: savedChatbotsKey)
        }
    }
}
