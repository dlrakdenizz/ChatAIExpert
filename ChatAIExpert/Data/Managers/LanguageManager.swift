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
    
    // Supported languages with their display names and flags
    static let supportedLanguages: [(code: String, name: String, flag: String)] = [
        ("en", "English", "🇺🇸"),
        ("tr", "Türkçe", "🇹🇷"),
        ("de", "Deutsch", "🇩🇪"),
        ("fr", "Français", "🇫🇷"),
        ("it", "Italiano", "🇮🇹"),
        ("es", "Español", "🇪🇸"),
        ("ko", "한국어", "🇰🇷")
    ]
    
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
            let supportedCodes = Self.supportedLanguages.map { $0.code }
            self.currentLanguage = supportedCodes.contains(deviceLanguage) ? deviceLanguage : "en"
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
    }
    
    func getSupportedLanguages() -> [(code: String, name: String, flag: String)] {
        return Self.supportedLanguages
    }
    
    func getLanguageName(for code: String) -> String? {
        return Self.supportedLanguages.first { $0.code == code }?.name
    }
    
    func getLanguageFlag(for code: String) -> String? {
        return Self.supportedLanguages.first { $0.code == code }?.flag
    }
}

// MARK: - Notification Names
extension Notification.Name {
    static let languageChanged = Notification.Name("languageChanged")
}
