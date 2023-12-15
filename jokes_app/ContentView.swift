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
                        let response = try await fetchJoke(from: .chuckNorrisJokes, responseType: ChuckNorrisJoke.self)
                        print("Received chuck norris joke: \(response)")
                    } catch {
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
            
            Button("Fetch Dad Jokes") {
                Task {
                    do {
                        let response = try await fetchJoke(from: .dadJokes, responseType: DadJoke.self)
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

func fetchJoke<T: Decodable>(from endpoint: ApiEndpoint, responseType: T.Type) async throws -> T {
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
        case .chuckNorrisJokes:
            return [:]
        case .dadJokes:
            return ["Accept" : "application/json", "User-Agent" : Bundle.main.bundleIdentifier ?? ""]
        }
    }
}

enum APIError: Error {
    case networkError(Error)
    case httpError(Int)
}
