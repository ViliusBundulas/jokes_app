//
//  ApiService.swift
//  jokes_app
//
//  Created by Vilius Bundulas on 15/12/2023.
//

import Foundation

protocol ApiServiceProtocol {
    func fetchJoke<T: Codable>(from endpoint: ApiEndpoint, responseType: T.Type) async throws -> T
}

class ApiService: ApiServiceProtocol {
    
    func fetchJoke<T: Codable>(from endpoint: ApiEndpoint, responseType: T.Type) async throws -> T {
        let url = endpoint.url
        var request = URLRequest(url: url)
        for (headerField, headerValue) in endpoint.headers {
            request.addValue(headerValue, forHTTPHeaderField: headerField)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APIError.httpError((response as? HTTPURLResponse)?.statusCode ?? 0)
            }
            
            let decoder = JSONDecoder()
            let joke = try decoder.decode(T.self, from: data)
            return joke
        } catch {
            throw APIError.networkError(error)
        }
    }
}
