//
//  OpenURLUseCase.swift
//  ChatAI
//
//  Created by Dilara Akdeniz on 31.05.2025.
//

import Foundation
import UIKit

protocol OpenURLUseCaseProtocol {
    func execute(urlString: String)
}

class OpenURLUseCase: OpenURLUseCaseProtocol {
    func execute(urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}
