//
//  DIContainer.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 13.07.2025.
//

import Foundation

class DIContainer {
    
    static let shared = DIContainer()
    
    private init() {}
    
    // **MARK: - Managers**
    lazy var languageManager: LanguageManager = {
        LanguageManager.shared
    }()
    
    // **MARK: - Network**
    lazy var networkManager: NetworkManagerProtocol = {
        NetworkManager()
    }()
    
    // **MARK: - Repositories**
    lazy var tabBarRepository : TabBarRepositoryProtocol = {
        TabBarRepository()
    }()
    
    lazy var chatbotsRepository: ChatbotsRepositoryProtocol = {
        ChatbotsRepository()
    }()
    
    lazy var chatRepository: ChatRepositoryProtocol = {
        ChatRepository(firebaseService: FirebaseAIService.shared)
    }()
    
    lazy var settingsRepository: SettingsRepositoryProtocol = {
        SettingsRepository()
    }()
    
    // **MARK: - Use Cases**
    
    lazy var getChatbotsByCategoryUseCase: GetChatbotsByCategoryUseCaseProtocol = {
        GetChatbotsByCategoryUseCase(repository: chatbotsRepository)
    }()
    
    lazy var sendMessageUseCase: SendMessageUseCaseProtocol = {
        SendMessageUseCase(repository: chatRepository)
    }()
    
    lazy var shareChatUseCase: ShareChatUseCaseProtocol = {
          ShareChatUseCase()
      }()
    
    lazy var getUserSettingsUseCase: GetUserSettingsUseCaseProtocol = {
        GetUserSettingsUseCase(repository: settingsRepository)
    }()
    
    lazy var shareAppUseCase: ShareAppUseCaseProtocol = {
        ShareAppUseCase()
    }()
    
    lazy var openURLUseCase: OpenURLUseCaseProtocol = {
        OpenURLUseCase()
    }()
    
    lazy var manageSavedChatbotsUseCase: ManageSavedChatbotsUseCaseProtocol = {
        ManageSavedChatbotsUseCase(repository: chatbotsRepository)
    }()
    
    // **MARK: - View Models**
    func makeTabBarViewModel() -> TabBarViewModel {
        TabBarViewModel(repository: tabBarRepository)
    }
    
    func makeChatbotsViewModel() -> ChatbotsViewModel {
        ChatbotsViewModel(
            getChatbotsByCategoryUseCase: getChatbotsByCategoryUseCase,
            manageSavedChatbotsUseCase: manageSavedChatbotsUseCase
        )
    }
    
    func makeChatViewModel(chatbotType: Chatbots, historyId: String? = nil) -> ChatViewModel {
        ChatViewModel(
            chatbotType: chatbotType,
            historyId: historyId,
            sendMessageUseCase: sendMessageUseCase,
            shareChatUseCase: shareChatUseCase,
            repository: chatRepository
        )
    }
    
    func makeSettingsViewModel() -> SettingsViewModel {
        SettingsViewModel(
            getUserSettingsUseCase: getUserSettingsUseCase,
            shareAppUseCase: shareAppUseCase,
            openURLUseCase: openURLUseCase
        )
    }
}
