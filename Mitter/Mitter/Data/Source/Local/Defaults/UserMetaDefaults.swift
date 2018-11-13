//
//  UserMetaDefaults.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 13/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation

protocol UserMetaDefaults {
    func getUserId() -> String
    func saveUserId(userId: String)
}
