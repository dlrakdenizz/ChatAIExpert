//
//  TabBarRepositoryProtocol.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 13.07.2025.
//

import Foundation

protocol TabBarRepositoryProtocol {
    func getSelectedTab() -> TabBarItem
    func setSelectedTab(_ tab: TabBarItem)
}
