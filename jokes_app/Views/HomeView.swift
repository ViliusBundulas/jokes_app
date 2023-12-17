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
        NavigationStack {
            VStack {
                
                Text(jokesViewModel.dadJoke?.joke ?? "There is no dad joke")
                Text(jokesViewModel.chuckNorrisJokes?.value ?? "There is no chuck norris joke")
                
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
        }
    }
}
