//
//  UserPresence.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 11/07/19.
//  Copyright © 2019 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Foundation
import Mapper

public struct UserPresence {
    public let userId: Identifiable<User>
    public let presence: ImpressedPresence
}

extension UserPresence: Mappable {
    public init(map: Mapper) throws {
        userId = try map.from("userId")
        presence = try map.from("presence")
    }
}
