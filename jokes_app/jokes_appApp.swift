//
//  jokes_appApp.swift
//  jokes_app
//
//  Created by Vilius Bundulas on 14/12/2023.
//

import SwiftUI
import Swinject

@main
struct jokes_appApp: App {
    
    private let container: Container = {
        let container = Container()
        container.register(ApiServiceProtocol.self) { _ in
            ApiService()
        }
        container.register(JokesViewModel.self) { resolver in
            JokesViewModel(apiService: resolver.resolve(ApiServiceProtocol.self)!)
        }
        container.register(UserModel.self) { _ in UserModel() }
                    .inObjectScope(.container)
        return container
    }()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(container.resolve(JokesViewModel.self)!)
                .environmentObject(container.resolve(UserModel.self)!)
        }
    }
}
