//
//  GiftWithRibbonView.swift

import SwiftUI

// Define the properties that will drive the animations. Create a new struct to contain all the properties that will be independently animated.
struct RibbonGiftAnimation {
    var scale = 1.0
    var verticalStretch = 1.0
    var verticalTranslation = 0.0
    var angle = Angle.zero
    var chromaAngle = Angle.zero
}

struct GiftWithRibbonView: View {
    @State private var isAnimating = false
    @State private var showPulse = false
    var onClaim: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("🎁")
                .font(.system(size: 100))
                .keyframeAnimator(
                    initialValue: RibbonGiftAnimation()) { content, value in
                        content
                            .rotationEffect(value.angle)
                            .hueRotation(value.chromaAngle)
                            .scaleEffect(value.scale)
                            .scaleEffect(y: value.verticalStretch)
                            .offset(y: value.verticalTranslation)
                    } keyframes: { _ in
                        KeyframeTrack(\.angle) {
                            CubicKeyframe(.zero, duration: 0.58)
                            CubicKeyframe(.degrees(16), duration: 0.125)
                            CubicKeyframe(.degrees(-16), duration: 0.125)
                            CubicKeyframe(.degrees(16), duration: 0.125)
                            CubicKeyframe(.zero, duration: 0.125)
                        }
                        
                        KeyframeTrack(\.verticalStretch) {
                            CubicKeyframe(1.0, duration: 0.1)
                            CubicKeyframe(0.6, duration: 0.15)
                            CubicKeyframe(1.5, duration: 0.1)
                            CubicKeyframe(1.05, duration: 0.15)
                            CubicKeyframe(3.0, duration: 0.88)
                            CubicKeyframe(0.8, duration: 0.1)
                            CubicKeyframe(1.04, duration: 0.4)
                            CubicKeyframe(1.0, duration: 0.22)
                        }
                        
                        KeyframeTrack(\.scale) {
                            LinearKeyframe(1.0, duration: 0.36)
                            SpringKeyframe(2.0, duration: 0.8, spring: .bouncy)
                            SpringKeyframe(1, spring: .bouncy)
                        }
                        
                        KeyframeTrack(\.verticalTranslation) {
                            LinearKeyframe(0.0, duration: 0.1)
                            SpringKeyframe(20.0, duration: 0.15, spring: .bouncy)
                            SpringKeyframe(-240.0, duration: 1.0, spring: .bouncy)
                            SpringKeyframe(0.0, spring: .bouncy)
                        }
                        
                        KeyframeTrack(\.chromaAngle) {
                            LinearKeyframe(.zero, duration: 0.58)
                            LinearKeyframe(.degrees(45), duration: 0.125)
                            LinearKeyframe(.degrees(-30), duration: 0.125)
                            LinearKeyframe(.degrees(150), duration: 0.125)
                            LinearKeyframe(.zero, duration: 0.125)
                        }
                    }
                .scaleEffect(showPulse ? 1.1 : 1.0)
                .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: showPulse)
            
            Button(action: onClaim) {
                Text(localized("claim_reward"))
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 12)
                    .background(Color.green)
                    .cornerRadius(25)
            }
        }
        .onAppear {
            isAnimating = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                showPulse = true
            }
        }
    }
}

#Preview {
    GiftWithRibbonView(onClaim: {})
        .preferredColorScheme(.dark)
}
