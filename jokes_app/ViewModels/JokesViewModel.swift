//
//  JokesViewModel.swift
//  jokes_app
//
//  Created by Vilius Bundulas on 15/12/2023.
//

import Foundation

class JokesViewModel: ObservableObject {
    @Published var chuckNorrisJokes: ChuckNorrisJoke?
    @Published var dadJoke: DadJoke?
    @Published var errorMessage: String?
    
    private let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol) {
        self.apiService = apiService
    }
    
    @MainActor func getJoke(from apiEndpoint: ApiEndpoint) {
        Task {
            do {
                switch apiEndpoint {
                case .dadJokes:
                    dadJoke = try await apiService.fetchJoke(from: .dadJokes, responseType: DadJoke.self)
                case .chuckNorrisJokes:
                    chuckNorrisJokes = try await apiService.fetchJoke(from: .chuckNorrisJokes, responseType: ChuckNorrisJoke.self)
                }
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}
