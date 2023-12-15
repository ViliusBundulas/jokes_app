//
//  ContentView.swift
//  jokes_app
//
//  Created by Vilius Bundulas on 14/12/2023.
//

import SwiftUI
import Swinject

struct HomeView: View {
    
    @EnvironmentObject var jokesViewModel: JokesViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Text(jokesViewModel.dadJoke?.joke ?? "There is no dad joke")
            Text(jokesViewModel.chuckNorrisJokes?.value ?? "There is no chuck norris joke")
            
            Button("Fetch Chuck Norris Jokes") {
                jokesViewModel.getJoke(from: .chuckNorrisJokes)
            }
            
            Button("Fetch Dad Jokes") {
                jokesViewModel.getJoke(from: .dadJokes)
            }
        }
        .padding()
    }
}
