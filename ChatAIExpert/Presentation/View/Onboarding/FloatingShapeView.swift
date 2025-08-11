//
//  FloatingShapeView.swift
//  ChatAI
//
//  Created by Dilara Akdeniz on 30.07.2025.
//

import SwiftUI

struct FloatingShapesView: View {
    let accentColor: Color
    @State private var animationPhase: Double = 0
    
    var body: some View {
        ZStack {
            ForEach(0..<12, id: \.self) { index in
                Circle()
                    .fill(accentColor.opacity(0.1))
                    .frame(width: CGFloat.random(in: 4...8), height: CGFloat.random(in: 4...8))
                    .offset(
                        x: cos(animationPhase + Double(index) * 0.5) * 100,
                        y: sin(animationPhase + Double(index) * 0.7) * 150
                    )
                    .blur(radius: 1)
            }
            
            ForEach(0..<6, id: \.self) { index in
                RoundedRectangle(cornerRadius: 2)
                    .fill(accentColor.opacity(0.08))
                    .frame(width: 6, height: 6)
                    .rotationEffect(.degrees(animationPhase * 20 + Double(index) * 60))
                    .offset(
                        x: sin(animationPhase * 0.8 + Double(index)) * 120,
                        y: cos(animationPhase * 0.6 + Double(index)) * 180
                    )
                    .blur(radius: 0.5)
            }
        }
        .onAppear {
            withAnimation(
                .linear(duration: 20)
                .repeatForever(autoreverses: false)
            ) {
                animationPhase = .pi * 2
            }
        }
    }
}
