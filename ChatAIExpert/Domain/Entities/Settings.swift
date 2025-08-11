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
    case spread = "Spread the Word"
    case support = "Support & Privacy"
}

enum SettingsAction {
    case rateApp
    case shareApp
    case contactSupport
    case openPrivacy
    case openTerms
}
