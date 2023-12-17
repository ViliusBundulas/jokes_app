//
//  UserDefaultsHelper.swift
//  jokes_app
//
//  Created by Vilius Bundulas on 17/12/2023.
//

import Foundation

class UserDefaultsHelper {
    
    static var userDefaults = UserDefaults.standard
    
    enum BoolKey: String, CaseIterable {
        case userSawOnboarding
    }
    
    static func bool(forKey key: BoolKey, defaultValue: Bool = false) -> Bool {
        userDefaults.value(forKey: key.rawValue) as? Bool ?? defaultValue
    }

    static func setBool(_ value: Bool, forKey key: BoolKey) {
        userDefaults.set(value, forKey: key.rawValue)
    }
}
