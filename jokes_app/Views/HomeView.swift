//
//  HomeView.swift
//  jokes_app
//
//  Created by Vilius Bundulas on 17/12/2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var jokesViewModel: JokesViewModel
    
    var body: some View {
        VStack {
            JokesButton(title: "Get random Dad joke") {
                jokesViewModel.getJoke(from: .dadJokes)
            }
            
            Text("Or")
                .font(.caption)
                .foregroundStyle(.black.opacity(0.8))
                .padding(.vertical, 5)
            
            JokesButton(title: "Get random Chuck Norris joke") {
                jokesViewModel.getJoke(from: .chuckNorrisJokes)
            }
        }
        .padding()
        .sheet(item: $jokesViewModel.chuckNorrisJokes) { joke in
            JokeView(joke: joke.value)
        }
        .sheet(item: $jokesViewModel.dadJoke) { joke in
            JokeView(joke: joke.joke)
        }
    }
}

struct JokeView: View {
    
    let joke: String
    
    var body: some View {
        Text(joke)
            .padding()
    }
}
