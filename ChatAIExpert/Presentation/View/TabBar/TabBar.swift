//
//  TabBar.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 13.07.2025.
//

import SwiftUI

struct TabBar: View {
    
    @StateObject private var viewModel: TabBarViewModel
    @State private var questionCredits: Int = 0
    @State private var showCreditBoostAlert: Bool = false
    @State private var showGiftAnimation: Bool = false
    @State private var showClearAllConfirmation = false
    @State private var showQuestionInfoAlert: Bool = false
    
    private let settingsRepository = SettingsRepository()
    
    init() {
        self._viewModel = StateObject(wrappedValue: DIContainer.shared.makeTabBarViewModel())
    }
    
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            
            
            NavigationStack {
                ChatbotsView()
                    .toolbar { toolbarContent() }
                    .navigationBarTitleDisplayMode(.large)
                
                
            }
            .tabItem {
                Label(TabBarItem.chatbots.name, systemImage: TabBarItem.chatbots.icon)
            }
            .tag(TabBarItem.chatbots)
            
            NavigationStack {
                HistoryView()
                    .toolbar { toolbarContent() }
                    .navigationBarTitleDisplayMode(.large)
                
                
            }
            .tabItem {
                Label(TabBarItem.history.name, systemImage: TabBarItem.history.icon)
            }
            .tag(TabBarItem.history)
        }
        .background(Color(.systemBackground))
        .alert(NSLocalizedString("question_credits_info", comment: ""), isPresented: $showQuestionInfoAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(NSLocalizedString("credit_alert", comment: ""))
        }
        .onAppear {
            updateQuestionCredits()
            setupNotificationObserver()
        }
        .onChange(of: viewModel.selectedTab) { _ in
            updateQuestionCredits()
        }
        .onDisappear {
            removeNotificationObserver()
        }
    }
    
    private func updateQuestionCredits() {
        questionCredits = settingsRepository.getQuestionCredits()
    }
    
    private func setupNotificationObserver() {
        NotificationCenter.default.addObserver(
            forName: .questionCreditsChanged,
            object: nil,
            queue: .main
        ) { _ in
            updateQuestionCredits()
        }
    }
    
    private func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(self, name: .questionCreditsChanged, object: nil)
    }
}

#Preview {
    TabBar()
}

extension TabBar {
    @ToolbarContentBuilder
    private func toolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            HStack(spacing: 12) {
                Text(getCurrentTabTitle())
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            HStack(spacing: 2) {
                Button(action: {
                    showQuestionInfoAlert = true
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "sparkles")
                            .symbolRenderingMode(.multicolor)
                            .font(.system(size: 14, weight: .medium))
                        
                        Text("\(questionCredits)")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.primary)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(Color(.systemGray6))
                    )
                }
                
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gearshape")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.primary)
                        .padding(2)
                }
            }
        }
    }
    
    private func getCurrentTabTitle() -> String {
        switch viewModel.selectedTab {
        case .chatbots:
            return TabBarItem.chatbots.name
        case .history:
            return TabBarItem.history.name
        default:
            return ""
        }
    }
}
