//
//  SettingsViewModel.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 20.07.2025.
//

import SwiftUI
import Foundation
import StoreKit

final class SettingsViewModel: ObservableObject {
    
    @Published var userSettings: UserSettings
    @Published var items: [SettingsSection: [SettingsItem]] = [:]
    @Published var showToast = false
    @Published var toastMessage = ""
    
    private let getUserSettingsUseCase: GetUserSettingsUseCaseProtocol
    private let shareAppUseCase: ShareAppUseCaseProtocol
    private let openURLUseCase: OpenURLUseCaseProtocol
    
    init(
        getUserSettingsUseCase: GetUserSettingsUseCaseProtocol,
        shareAppUseCase: ShareAppUseCaseProtocol,
        openURLUseCase: OpenURLUseCaseProtocol
    ) {
        self.getUserSettingsUseCase = getUserSettingsUseCase
        self.shareAppUseCase = shareAppUseCase
        self.openURLUseCase = openURLUseCase
        
        // Initialize with current settings
        self.userSettings = getUserSettingsUseCase.execute()
        
        setupItems()
    }
    
    func refreshSettings() {
        userSettings = getUserSettingsUseCase.execute()
    }
    
    func handle(action: SettingsAction) {
        switch action {
        case .shareApp:
            shareApp()
        case .rateApp:
            requestReview()
        case .contactSupport:
            contactSupport()
        case .openPrivacy:
            openPrivacyPolicy()
        case .openTerms:
            openTermsOfUse()
        }
    }
    
    private func shareApp() {
        shareAppUseCase.execute()
    }
    
    private func requestReview() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
            print("SKStoreReviewController is not available on this iOS version.")
        }
    }
    
    private func contactSupport() {
        let email = "dev.dlrakdeniz@icloud.com"
        let subject = "Support Request"  // E-posta başlığı
        let body = "Hello, I am reaching out for support regarding the following issue:"  // E-posta içeriği
        let urlString = "mailto:\(email)?subject=\(subject)&body=\(body)"
        
        if let url = URL(string: urlString) {
            openURLUseCase.execute(urlString: url.absoluteString)
        }
    }

    
    private func openPrivacyPolicy() {
        let urlString = "https://aliduman.tech/privacy-policy-ios"
        openURLUseCase.execute(urlString: urlString)
    }
    
    private func openTermsOfUse() {
        let urlString = "https://aliduman.tech/privacy-policy-ios"
        openURLUseCase.execute(urlString: urlString)
    }
    
    
    private func showToastMessage(_ message: String) {
        toastMessage = message
        showToast = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showToast = false
        }
    }
    
    private func setupItems() {
        items[.spread] = [
            SettingsItem(title: "Rate App", icon: "star", section: .spread, action: .rateApp),
            SettingsItem(title: "Share App", icon: "square.and.arrow.up", section: .spread, action: .shareApp)
        ]
        
        items[.support] = [
            SettingsItem(title: "Contact Support", icon: "envelope.badge", section: .support, action: .contactSupport),
            SettingsItem(title: "Privacy Policy", icon: "hand.raised", section: .support, action: .openPrivacy),
            SettingsItem(title: "Terms of Use", icon: "doc.text", section: .support, action: .openTerms)
        ]
    }
}
