//
//  OnboardingView.swift
//  jokes_app
//
//  Created by Vilius Bundulas on 17/12/2023.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var userModel: UserModel
    
    var body: some View {
        VStack {
            Image(.onboarding)
                .resizable()
                .scaledToFit()
                .overlay(LinearGradient(gradient: Gradient(colors: [.clear, .clear, .white]), startPoint: .top, endPoint: .bottom))
                .overlay(alignment: .bottom) {
                    Text("Dad Jokes or Chuck Norris Jokes? Wanna find out?")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.center)
                }
            
            Spacer()
        }
        .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .move(edge: .bottom)))
        .ignoresSafeArea()
        .overlay(alignment: .bottom) {
            JokesButton(title: "Let's go!") {
                userModel.userSawOnboarding = true
            }
            .padding()
        }
        .overlay(alignment: .top) {
            Image(.vs)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
        }
    }
}
