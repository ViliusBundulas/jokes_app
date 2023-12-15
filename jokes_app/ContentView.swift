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
                        chuckNorrisJoke = try await fetchJoke(from: .chuckNorrisJokes, responseType: ChuckNorrisJoke.self)
                        print("#### \(chuckNorrisJoke)")
                    } catch {
                        if case let APIError.httpError(statusCode) = error {
                            print("HTTP error: Status Code \(statusCode)")
                        } else {
                            print("Error fetching Chuck Norris jokes: \(error)")
                        }
                    }
                }
            }
            
            Button("Fetch Dad Jokes") {
                Task {
                    do {
                        dadJoke = try await fetchJoke(from: .dadJokes, responseType: DadJoke.self)
                    } catch {
                        if case let APIError.httpError(statusCode) = error {
                            print("HTTP error: Status Code \(statusCode)")
                        } else {
                            print("Error fetching Dad jokes: \(error)")
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    func fetchJoke<T: Decodable>(from endpoint: ApiEndpoint, responseType: T.Type) async throws -> T {
        let url = endpoint.url
        var request = URLRequest(url: url)
        for (headerField, headerValue) in endpoint.headers {
            request.setValue(headerValue, forHTTPHeaderField: headerField)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
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

struct JokeResponse<T: Decodable>: Decodable {
    let id: String
    let joke: T
    let status: Int
}

enum APIError: Error {
    case networkError(Error)
    case httpError(Int)
}
