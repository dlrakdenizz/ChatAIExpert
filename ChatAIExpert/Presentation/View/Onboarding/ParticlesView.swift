//
//  ParticlesView.swift
//  ChatAI
//
//  Created by Dilara Akdeniz on 30.07.2025.
//


import SwiftUI

struct ParticlesView: View {
    @State private var phase = 0.0
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                let timeNow = timeline.date.timeIntervalSinceReferenceDate
                let angle = timeNow.remainder(dividingBy: 2)
                let phase = angle / 2
                context.drawLayer { ctx in
                    for i in 1..<30 {
                        let position = CGPoint(
                            x: size.width * (0.5 + 0.4 * sin(Double(i) * phase)),
                            y: size.height * (0.5 + 0.4 * cos(Double(i) * phase))
                        )
                        let path = Path(ellipseIn: CGRect(x: position.x, y: position.y, width: 3, height: 3))
                        ctx.addFilter(.blur(radius: 2))
                        ctx.fill(path, with: .color(Color.white.opacity(0.3)))
                    }
                }
            }
        }
    }
}
#Preview {
    ParticlesView()
}
