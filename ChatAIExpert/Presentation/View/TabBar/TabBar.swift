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
                    .navigationTitle(TabBarItem.chatbots.name)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar { toolbarContent() }
                    
            }
            .tabItem {
                Label(TabBarItem.chatbots.name, systemImage: TabBarItem.chatbots.icon)
            }
            .tag(TabBarItem.chatbots)
            
            NavigationStack {
                HistoryView()
                    .navigationTitle(TabBarItem.history.name)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar { toolbarContent() }
                
            }
            .tabItem {
                Label(TabBarItem.history.name, systemImage: TabBarItem.history.icon)
            }
            .tag(TabBarItem.history)
        }
        .background(Color(.systemBackground))
        .alert("Question Credits Info", isPresented: $showQuestionInfoAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Shows your daily remaining question credits. 5 question credits are allocated each new day.")
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
            NavigationLink(destination: SettingsView()) {
                Image(systemName: "gearshape")
                    .foregroundColor(.black)
            }
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            HStack(spacing: 4) {
                Button(action: {
                    showQuestionInfoAlert = true
                }) {
                    Image(systemName: "questionmark.circle.fill")
                        .foregroundColor(.green)
                    Text("\(questionCredits)")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                }
            }
        }
    }
}
