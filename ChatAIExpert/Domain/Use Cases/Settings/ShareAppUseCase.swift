//
//  ShareAppUseCase.swift
//  ChatAI
//
//  Created by Dilara Akdeniz on 31.05.2025.
//

import Foundation
import UIKit

protocol ShareAppUseCaseProtocol {
    func execute()
}

class ShareAppUseCase: ShareAppUseCaseProtocol {
    func execute() {
        DispatchQueue.main.async {
            let appURL = "https://apps.apple.com/tr/app/chatai-chat-with-ai-experts/id6749398918?l=tr"
            let shareText = "Check out this amazing ChatAI app: \(appURL)"
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                let activityVC = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
                window.rootViewController?.present(activityVC, animated: true)
            }
        }
    }
}
