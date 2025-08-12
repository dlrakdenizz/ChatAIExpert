//
//  LanguageManager.swift
//  ChatAIExpert
//
//  Created by Dilara Akdeniz on 31.07.2025.
//

import Foundation
import UIKit

final class LanguageManager: ObservableObject {
    static let shared = LanguageManager()
    
    @Published var currentLanguage: String {
        didSet {
            UserDefaults.standard.set(currentLanguage, forKey: "selectedLanguage")
            UserDefaults.standard.set([currentLanguage], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
        }
    }
    
    private init() {
        // Get saved language or device language as default
        if let savedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") {
            self.currentLanguage = savedLanguage
        } else {
            // Get device language
            let deviceLanguage = Locale.current.language.languageCode?.identifier ?? "en"
            // Check if device language is supported, otherwise default to English
            self.currentLanguage = ["en", "tr"].contains(deviceLanguage) ? deviceLanguage : "en"
            // Save device language as default
            UserDefaults.standard.set(self.currentLanguage, forKey: "selectedLanguage")
            UserDefaults.standard.set([self.currentLanguage], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
        }
    }
    
    func changeLanguage(to language: String) {
        guard currentLanguage != language else { return }
        
        currentLanguage = language
        
        // Post notification for language change
        NotificationCenter.default.post(name: .languageChanged, object: language)
        
        // For SwiftUI apps, we need to restart the app to apply language changes
        // Give user a moment to see the confirmation
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            exit(0)
        }
    }
}

// MARK: - Notification Names
extension Notification.Name {
    static let languageChanged = Notification.Name("languageChanged")
}
