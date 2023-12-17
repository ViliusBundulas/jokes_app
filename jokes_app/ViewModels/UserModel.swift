//
//  UserModel.swift
//  jokes_app
//
//  Created by Vilius Bundulas on 17/12/2023.
//

import Foundation

class UserModel: ObservableObject {
    
    @Published var userSawOnboarding = UserDefaultsHelper.bool(forKey: .userSawOnboarding, defaultValue: false) {
        didSet {
            UserDefaultsHelper.setBool(userSawOnboarding, forKey: .userSawOnboarding)
        }
    }
}
