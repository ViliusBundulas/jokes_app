//
//  ContentView.swift
//  jokes_app
//
//  Created by Vilius Bundulas on 14/12/2023.
//

import SwiftUI
import Swinject

struct MainView: View {
    
    @EnvironmentObject var userModel: UserModel
    
    var body: some View {
        
        if userModel.userSawOnboarding {
            HomeView()
        } else {
            OnboardingView()
        }
    }
}
