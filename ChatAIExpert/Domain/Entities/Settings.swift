//
//  Settings.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 20.07.2025.
//

import Foundation

struct SettingsItem {
    let id: UUID = UUID()
    let title: String
    let icon: String
    let section: SettingsSection
    let action: SettingsAction
}

enum SettingsSection: String, CaseIterable {
    case account = "Account"
    case inApp = "In-App Purchases"
    case appearance = "Appearance"
    case spread = "Spread the World"
    case support = "Support & Privacy"
    
    var id: String { rawValue }
    
    var localizedName: String {
        NSLocalizedString(self.rawValue, comment: "Category name")
    }
}


enum SettingsAction {
    case changeLanguage
    case rateApp
    case shareApp
    case contactSupport
    case openPrivacy
    case openTerms
    case openTeam
}
