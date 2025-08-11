
//  SendMessageUseCase.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 20.07.2025.
//

import Foundation
import UIKit

protocol SendMessageUseCaseProtocol {
    func execute(message: String, chatbotType: Chatbots, image: UIImage?) async throws -> String
}

struct SendMessageUseCase: SendMessageUseCaseProtocol {
    private let repository: ChatRepositoryProtocol
    
    init(repository: ChatRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(message: String, chatbotType: Chatbots, image: UIImage?) async throws -> String {
        return try await repository.sendMessage(message, chatbotType: chatbotType, image: image)
    }
}
