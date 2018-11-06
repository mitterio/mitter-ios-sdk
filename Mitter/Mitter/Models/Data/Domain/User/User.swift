//
//  User.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 06/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

public struct User: Mappable {
    var userId: String
    
    public init(map: Mapper) throws {
        try userId = map.from("userId")
    }
}
