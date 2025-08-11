//
//  SplashView.swift
//  ChatAI
//
//  Created by Dilara Akdeniz on 29.07.2025.
//

import SwiftUI

struct SplashView: View {
    
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                
                VStack(spacing: 0) {
                    Spacer()
                    
                    Image(.appLogoSplash)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                        .phaseAnimator([false, true]) { logo, chromaRotate in
                            logo
                                .scaleEffect(1, anchor: chromaRotate ? .bottom : .topTrailing)
                        } animation: { _ in
                            .easeInOut(duration: 3)
                        }

                   
                    Image(.chatai)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180, height: 180)
                        .phaseAnimator([false, true]) { chatai, chromaRotate in
                            chatai
                                .scaleEffect(1, anchor: chromaRotate ? .bottom : .topTrailing)
                                .hueRotation(.degrees(chromaRotate ? 600 : 0))
                            
                        } animation: { chromaRotate in
                                .easeInOut(duration: 3)
                        }
                    
                    Spacer()
                }
            }
            .onAppear {
                Task {
                    try? await Task.sleep(nanoseconds: 3 * 1_000_000_000)
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
