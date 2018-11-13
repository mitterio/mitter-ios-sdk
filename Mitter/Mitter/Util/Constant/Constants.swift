//
//  UserConstants.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 12/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation

enum Constants {
    enum Headers {
        static let applicationId = "X-Mitter-Application-Id"
        static let userAuthToken = "X-Issued-Mitter-User-Authorization"
    }
    
    enum Users {
        static let userRemoteSource = "UserRemoteSource"
        static let userRepository = "UserRepository"
        
        enum Actions {
            static let fetchUser = "FetchUserAction"
        }
    }
    
    enum Keys {
        static let userId = "UserId"
        static let authToken = "AuthToken"
    }
}
