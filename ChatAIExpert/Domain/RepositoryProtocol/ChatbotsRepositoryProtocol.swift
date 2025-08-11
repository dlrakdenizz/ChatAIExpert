//
//  ChatbotsRepositoryProtocol.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 13.07.2025.
//

import Foundation

protocol ChatbotsRepositoryProtocol {
    func fetchAllChatbots() -> [Chatbots]
    func fetchChatbotsByCategory(_ category: ChatbotCategory) -> [Chatbots]
    func saveChatbot(_ chatbot: Chatbots)
    func unsaveChatbot(_ chatbot: Chatbots)
    func getSavedChatbots() -> [Chatbots]
    func isChatbotSaved(_ chatbot: Chatbots) -> Bool
}
