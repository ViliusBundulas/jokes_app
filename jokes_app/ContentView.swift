//
//  ContentView.swift
//  jokes_app
//
//  Created by Vilius Bundulas on 14/12/2023.
//

import SwiftUI

struct DadJoke: Codable {
    let id: String
    let joke: String
    let status: Int
}

struct ChuckNorrisJoke: Codable {
    let iconURL: String
    let id: String
    let url: String
    let value: String

    enum CodingKeys: String, CodingKey {
        case iconURL = "icon_url"
        case id, url, value
    }
}

struct ContentView: View {
    
    @State private var chuckNorrisJoke: ChuckNorrisJoke?
    @State private var dadJoke: DadJoke?
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Button("Fetch Chuck Norris Jokes") {
                Task {
                    do {
                        let response: ChuckNorrisJoke = try await fetchJoke(from: .chuckNorrisJokes)
                        print("Received chuck norris joke: \(response)")
                    } catch {
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
            
            Button("Fetch Dad Jokes") {
                Task {
                    do {
                        let response: DadJoke = try await fetchJoke(from: .dadJokes)
                        print("Received dad joke: \(response)")
                    } catch {
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
        }
        .padding()
    }
}

func fetchJoke<T: Codable>(from endpoint: ApiEndpoint) async throws -> T {
    var urlRequest = URLRequest(url: endpoint.url)
    urlRequest.httpMethod = "GET"
    urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

    let session = URLSession(configuration: .default)

    return try await withCheckedThrowingContinuation { continuation in 
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                continuation.resume(with: .failure(error))
                return
            }

            guard let data = data else {
                let error = NSError(domain: "YourErrorDomain", code: 0, userInfo: [
                    NSLocalizedDescriptionKey: "No data received"
                ])
                continuation.resume(with: .failure(error))
                return
            }

            do {
                let responseObject = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    continuation.resume(with: .success(responseObject))
                }
            } catch {
                continuation.resume(with: .failure(error))
            }
        }
        
        dataTask.resume()
    }
}


enum ApiEndpoint {
    case dadJokes
    case chuckNorrisJokes
    
    var url: URL {
        switch self {
        case .dadJokes:
            return URL(string: "https://icanhazdadjoke.com/")!
        case .chuckNorrisJokes:
            return URL(string: "https://api.chucknorris.io/jokes/random")!
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .dadJokes:
            return [:]
        case .chuckNorrisJokes:
            return ["Accept": "application/json"]
        }
    }
}

enum APIError: Error {
    case networkError(Error)
    case httpError(Int)
}
