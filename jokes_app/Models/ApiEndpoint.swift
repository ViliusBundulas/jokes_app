//
//  ApiEndpoint.swift
//  jokes_app
//
//  Created by Vilius Bundulas on 15/12/2023.
//

import Foundation

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
