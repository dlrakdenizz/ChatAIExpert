//
// Created by Furkan ERKORKMAZ.
// Copyright © Furkan ERKORKMAZ. All rights reserved.
//

import SwiftUI
import UIKit

// MARK: - Swipe Back Gesture Helper

struct SwipeBackGestureEnabler: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        SwipeBackViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    class SwipeBackViewController: UIViewController {
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            parent?.navigationController?.interactivePopGestureRecognizer?.delegate = nil
            parent?.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        }
    }
}

extension View {
    func enableSwipeBackGesture() -> some View {
        background(SwipeBackGestureEnabler())
    }
}
