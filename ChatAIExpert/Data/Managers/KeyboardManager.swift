//
//  KeyboardManager.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 20.07.2025.
//


import Combine
import Foundation
import SwiftUI

class KeyboardManager: ObservableObject {
    @Published var isKeyboardVisible: Bool = false
    @Published var keyboardHeight: CGFloat = 0

    private var cancellableSet: Set<AnyCancellable> = []

    init() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .sink { [weak self] notification in
                self?.keyboardWillShow(notification: notification)
            }
            .store(in: &cancellableSet)

        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { [weak self] notification in
                self?.keyboardWillHide(notification: notification)
            }
            .store(in: &cancellableSet)
    }

    private func keyboardWillShow(notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            DispatchQueue.main.async {
                self.keyboardHeight = keyboardFrame.height
                self.isKeyboardVisible = true
            }
        }
    }
    
    func dismissKeyboard() {
           UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
       }

    private func keyboardWillHide(notification: Notification) {
        DispatchQueue.main.async {
            self.keyboardHeight = 0
            self.isKeyboardVisible = false
        }
       
    }
}

