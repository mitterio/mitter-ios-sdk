//
//  LibDefaults.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 13/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation

class LibDefaults: UserMetaDefaults, TokenDefaults {
    private let applicationId: String
    private let userDefaults: UserDefaults
    
    init(applicationId: String) {
        self.applicationId = applicationId
        self.userDefaults = UserDefaults.standard
    }
    
    func getUserId() -> String {
        let key = getNamespacedKey(applicationId, Constants.Keys.userId)
        return userDefaults.string(forKey: key) ?? ""
    }
    
    func saveUserId(userId: String) {
        let key = getNamespacedKey(applicationId, Constants.Keys.userId)
        userDefaults.set(userId, forKey: key)
    }
    
    func getToken() -> AuthToken {
        let key = getNamespacedKey(applicationId, Constants.Keys.authToken)
        guard let authTokenData = userDefaults.data(forKey: key) else {
            return AuthToken()
        }
        
        return (try? PropertyListDecoder().decode(AuthToken.self, from: authTokenData)) ?? AuthToken()
    }
    
    func saveToken(authToken: AuthToken) {
        let key = getNamespacedKey(applicationId, Constants.Keys.authToken)
        userDefaults.set(try? PropertyListEncoder().encode(authToken), forKey: key)
    }
    
    private func getNamespacedKey(_ applicationId: String, _ key: String) -> String {
        return "\(applicationId):\(key)"
    }
}
