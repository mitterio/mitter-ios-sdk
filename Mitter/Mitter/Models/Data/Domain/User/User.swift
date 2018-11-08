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
    public var userId: String
    public var internalId: String
    public var screenName: ScreenName?
    
    public init(map: Mapper) throws {
        try userId = map.from("identifier")
        try internalId = map.from("internalId")
        screenName = map.optionalFrom("screenName")
    }
}
