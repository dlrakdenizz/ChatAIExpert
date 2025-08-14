//
//  ChatRepositoryProtocol.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 20.07.2025.
//

import Foundation
import UIKit

protocol ChatRepositoryProtocol {
    func sendMessage(_ message: String, chatbotType: Chatbots, image: [UIImage]?) async throws -> String
    func clearChatHistory(for chatbotType: Chatbots)
}
