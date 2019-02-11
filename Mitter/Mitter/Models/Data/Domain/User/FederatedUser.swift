//
//  FederatedUser.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 11/02/19.
//  Copyright © 2019 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

struct FederatedUser {
    let federatedUserId: String
}

extension FederatedUser: Mappable {
    public init(map: Mapper) throws {
        try federatedUserId = map.from("federatedUserId")
    }
}
