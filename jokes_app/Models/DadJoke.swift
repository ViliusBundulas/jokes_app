//
//  DadJoke.swift
//  jokes_app
//
//  Created by Vilius Bundulas on 15/12/2023.
//

import Foundation

struct DadJoke: Codable, Identifiable {
    let id: String
    let joke: String
    let status: Int
}
