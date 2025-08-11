//
//  GetChatbotsByCategoryUseCase.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 15.07.2025.
//

import Foundation

protocol GetChatbotsByCategoryUseCaseProtocol {
    func execute(category: ChatbotCategory) -> [Chatbots]
}

struct GetChatbotsByCategoryUseCase: GetChatbotsByCategoryUseCaseProtocol {
    private let repository: ChatbotsRepositoryProtocol
    
    init(repository: ChatbotsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(category: ChatbotCategory) -> [Chatbots] {
        return repository.fetchChatbotsByCategory(category)
    }
}

