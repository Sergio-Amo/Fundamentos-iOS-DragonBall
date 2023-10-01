//
//  LocalDataModel.swift
//  DragonBall_practica-iOS
//
//  Created by Sergio Amo on 30/9/23.
//

import Foundation

struct LocalDataModel {
    private static let key = "SuperHeroesToken"
    
    private static let userDefaults = UserDefaults.standard
    
    static func getToken() -> String? {
        userDefaults.string(forKey: key)
    }
    
    static func save(token: String) {
        userDefaults.set(token, forKey: key)
    }
    
    static func deleteToken() {
        userDefaults.removeObject(forKey: key)
    }
}
