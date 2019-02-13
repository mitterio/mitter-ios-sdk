//
//  FederatedUserRegistration.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 11/02/19.
//  Copyright © 2019 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

struct FederatedUserRegistration {
    let federatedUser: FederatedUser
    let autoLoginToken: String
}

extension FederatedUserRegistration: Mappable {
    public init(map: Mapper) throws {
        try federatedUser = map.from("federatedUser")
        try autoLoginToken = map.from("autoLoginToken")
    }
}
