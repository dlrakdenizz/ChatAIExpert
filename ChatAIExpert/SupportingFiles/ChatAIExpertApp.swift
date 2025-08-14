//
//  ChatAIExpertApp.swift
//  ChatAIExpert
//
//  Created by Dilara Akdeniz on 31.07.2025.
//

import SwiftUI
import FirebaseCore
import FirebaseAI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct ChatAIExpertApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var viewID = UUID()
    
    init() {
        // Configure TabBar appearance
        UITabBar.configureAppearance()
        _ = LanguageManager.shared
        
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .preferredColorScheme(.light)
                .id(viewID) // View'ı yeniden çizmeye zorlar
                .onReceive(NotificationCenter.default.publisher(for: .languageChanged)) { _ in
                    // Dil değiştiğinde (notification geldiğinde) viewID'yi değiştirerek
                    // tüm arayüzün yeniden çizilmesini tetikle.
                    viewID = UUID()
                }
        }
    }
}

// MARK: - UITabBar Extension
extension UITabBar {
    static func configureAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor.systemBackground
        UITabBar.appearance().standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}
