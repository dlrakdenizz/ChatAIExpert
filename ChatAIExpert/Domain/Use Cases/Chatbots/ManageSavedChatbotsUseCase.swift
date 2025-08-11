//
//  ManageSavedChatbotsUseCase.swift
//  ChatAI
//
//  Created by Dilara Akdeniz on 27.07.2025.
//

import Foundation

protocol ManageSavedChatbotsUseCaseProtocol {
    func saveChatbot(_ chatbot: Chatbots)
    func unsaveChatbot(_ chatbot: Chatbots)
    func getSavedChatbots() -> [Chatbots]
    func isChatbotSaved(_ chatbot: Chatbots) -> Bool
}

struct ManageSavedChatbotsUseCase: ManageSavedChatbotsUseCaseProtocol {
    private let repository: ChatbotsRepositoryProtocol
    
    init(repository: ChatbotsRepositoryProtocol) {
        self.repository = repository
    }
    
    func saveChatbot(_ chatbot: Chatbots) {
        repository.saveChatbot(chatbot)
    }
    
    func unsaveChatbot(_ chatbot: Chatbots) {
        repository.unsaveChatbot(chatbot)
    }
    
    func getSavedChatbots() -> [Chatbots] {
        return repository.getSavedChatbots()
    }
    
    func isChatbotSaved(_ chatbot: Chatbots) -> Bool {
        return repository.isChatbotSaved(chatbot)
    }
}

