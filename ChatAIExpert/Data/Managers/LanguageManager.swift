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
    @Published private(set) var currentBundle: Bundle = .main
    
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
            updateBundle(for: currentLanguage)
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
        }
        // Başlangıçta doğru bundle'ı yükle
        updateBundle(for: currentLanguage)
    }
    
    
    func changeLanguage(to languageCode: String) {
        guard currentLanguage != languageCode else { return }
        
        currentLanguage = languageCode // Bu, didSet bloğunu tetikleyerek bundle'ı güncelleyecektir.
        
        // Bu notification ÇOK ÖNEMLİ. View'ı yeniden çizdirmek için bunu kullanacağız.
        NotificationCenter.default.post(name: .languageChanged, object: nil)
    }
    
    private func updateBundle(for languageCode: String) {
        guard let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            // Eğer bir sebepten ötürü ilgili dilin dosyası bulunamazsa, ana bundle'a dön.
            self.currentBundle = .main
            return
        }
        self.currentBundle = bundle
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

// Global helper fonksiyonu da buraya koyabilirsin.
func localized(_ key: String) -> String {
    let bundle = LanguageManager.shared.currentBundle
    return NSLocalizedString(key, bundle: bundle, comment: "")
}
