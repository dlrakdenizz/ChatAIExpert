//
//  NetworkManager.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 22.07.2025.
//

import Foundation

protocol NetworkManagerProtocol {
    func executeRequest<T: Decodable>(_ request: URLRequest) async throws -> T
}

enum NetworkError: Error {
    case invalidResponse
    case decodingError(Error)
    case custom(String)
}

final class NetworkManager: NetworkManagerProtocol {
    func executeRequest<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.invalidResponse
        }
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}

