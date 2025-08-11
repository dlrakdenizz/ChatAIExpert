//
//  SettingsRepositoryProtocol.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 20.07.2025.
//

import Foundation

protocol SettingsRepositoryProtocol {
    func getUserSettings() -> UserSettings
    func getUserId() -> String
    func getQuestionCredits() -> Int
    func setQuestionCredits(_ credits: Int)
    func decrementQuestionCredits()
    func checkAndUpdateDailyCredits()
    func getLastLoginDate() -> Date?
    func setLastLoginDate(_ date: Date)
}
