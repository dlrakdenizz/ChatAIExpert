//
//  AddView.swift
//  SwiftUI-Animations
//
//  Created by Shubham Singh on 21/08/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import SwiftUI

struct AddView: View {
    
    // MARK:- variables
    @State var isAnimating: Bool = false
    @Binding var isImagePickerPresented: Bool
    @Binding var isCameraPresented: Bool
    
    // MARK:- views
    var body: some View {
        ZStack {
            ZStack {
                ExpandingView(expand: $isAnimating, direction: .top, symbolName: "photo")
                    .onTapGesture {
                        isImagePickerPresented = true
                        isAnimating = false
                    }
                ExpandingView(expand: $isAnimating, direction: .bottom, symbolName: "camera")
                    .onTapGesture {
                        isCameraPresented = true
                        isAnimating = false
                    }
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 24, weight: self.isAnimating ? .regular : .semibold, design: .rounded))
                    .foregroundColor(.black)
                    .rotationEffect(self.isAnimating ? .degrees(45) : .degrees(0))
                    .scaleEffect(self.isAnimating ? 1.2 : 1)
                    .animation(Animation.spring(response: 0.35, dampingFraction: 0.85, blendDuration: 1))
                    .onTapGesture {
                        self.isAnimating.toggle()
                    }
            }.frame(height: 100)
            .padding()
        }
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        AddView(isImagePickerPresented: .constant(false), isCameraPresented: .constant(false))
    }
}

enum ExpandDirection {
    case bottom
    case left
    case right
    case top
    
    var offsets: (CGFloat, CGFloat) {
        switch self {
        case .bottom:
            return (32, 32)
        case .left:
            return (-32, 32)
        case .top:
            return (-32, -32)
        case .right:
            return (32, -32)
        }
    }
    
    var containerOffset: (CGFloat, CGFloat) {
        switch self {
        case .bottom:
            return (0, 0)
        case .left:
            return (0, 0)
        case .top:
            return (0, 0)
        case .right:
            return (0, 0)
        }
    }
}
