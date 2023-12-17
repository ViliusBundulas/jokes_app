//
//  ChuckNorrisJoke.swift
//  jokes_app
//
//  Created by Vilius Bundulas on 15/12/2023.
//

import Foundation

struct ChuckNorrisJoke: Codable, Identifiable {
    let iconURL: String
    let id: String
    let url: String
    let value: String

    enum CodingKeys: String, CodingKey {
        case iconURL = "icon_url"
        case id
        case url
        case value
    }
}
