//
//  SettingsRepository.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 20.07.2025.
//

import Foundation

class SettingsRepository: SettingsRepositoryProtocol {
    
    private let userDefaults: UserDefaults
    private let userIdKey = "userId"
    private let questionCreditsKey = "questionCredits"
    private let lastLoginDateKey = "lastLoginDate"
    private let dailyCreditsLimit = 5
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func getUserSettings() -> UserSettings {
        return UserSettings(
            userId: getUserId(),
            questionCredits: getQuestionCredits(),
            lastLoginDate: getLastLoginDate()
        )
    }
    
    func getUserId() -> String {
        return userDefaults.string(forKey: userIdKey) ?? "USER123456"
    }
    
    func getQuestionCredits() -> Int {
        return userDefaults.integer(forKey: questionCreditsKey)
    }
    
    func setQuestionCredits(_ credits: Int) {
        userDefaults.set(credits, forKey: questionCreditsKey)
        NotificationCenter.default.post(name: .questionCreditsChanged, object: nil)
    }
    
    func decrementQuestionCredits() {
        let currentCredits = getQuestionCredits()
        if currentCredits > 0 {
            setQuestionCredits(currentCredits - 1)
        }
    }
    
    func checkAndUpdateDailyCredits() {
        let lastLoginDate = getLastLoginDate()
        let currentDate = Date()
        
        // Eğer ilk giriş ise veya farklı bir gün ise
        if lastLoginDate == nil || !Calendar.current.isDate(lastLoginDate!, inSameDayAs: currentDate) {
            let currentCredits = getQuestionCredits()
            
            // Eğer 5'ten az kredi varsa 5'e tamamla
            if currentCredits < dailyCreditsLimit {
                setQuestionCredits(dailyCreditsLimit)
            }
            
            setLastLoginDate(currentDate)
        }
    }
    
    func getLastLoginDate() -> Date? {
        return userDefaults.object(forKey: lastLoginDateKey) as? Date
    }
    
    func setLastLoginDate(_ date: Date) {
        userDefaults.set(date, forKey: lastLoginDateKey)
    }
}

extension Notification.Name {
    static let questionCreditsChanged = Notification.Name("questionCreditsChanged")
}
