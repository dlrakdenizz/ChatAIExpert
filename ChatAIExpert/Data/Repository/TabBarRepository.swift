//
//  TabBarRepository.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 13.07.2025.
//

import Foundation

class TabBarRepository : TabBarRepositoryProtocol {
    
    private var selectedTabId : Int = 0
    
    func getSelectedTab() -> TabBarItem {
        return TabBarItem.allCases.first {$0.id == selectedTabId} ?? .chatbots //TabBarItem CaseIterable olduğundan dolayı allCases kullanılabildi. first {$0.id == selectedTabId} bu ifade ile id'si selectedTabId'ye eşit olan ilk case bulunur.
    }
    
    func setSelectedTab(_ tab: TabBarItem) {
        selectedTabId = tab.id
    }
    
    
}
