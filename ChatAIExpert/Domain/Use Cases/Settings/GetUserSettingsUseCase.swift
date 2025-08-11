//
//  GetUserSettingsUseCase.swift
//  ChatAI
//
//  Created by Dilara Akdeniz on 31.05.2025.
//

import Foundation

protocol GetUserSettingsUseCaseProtocol {
    func execute() -> UserSettings
}

class GetUserSettingsUseCase: GetUserSettingsUseCaseProtocol {
    private let repository: SettingsRepositoryProtocol
    
    init(repository: SettingsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() -> UserSettings {
        return repository.getUserSettings()
    }
}

