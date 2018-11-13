//
//  AuthToken.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 13/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation

public struct AuthToken: Codable {
    let id: String
    let signedToken: String
    
    init(id: String = "", signedToken: String = "") {
        self.id = id
        self.signedToken = signedToken
    }
}
