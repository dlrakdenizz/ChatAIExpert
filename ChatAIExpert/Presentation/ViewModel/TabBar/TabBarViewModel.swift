//
//  TabBarViewModel.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 13.07.2025.
//

import Foundation

class TabBarViewModel : ObservableObject {
    @Published var selectedTab: TabBarItem = .chatbots
    
    private let repository: TabBarRepositoryProtocol
    
    init(repository: TabBarRepositoryProtocol) {
        self.repository = repository
    }
}
