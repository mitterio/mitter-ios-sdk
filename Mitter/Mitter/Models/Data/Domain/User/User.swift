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
    public var systemUser: Bool
    public var synthetic: Bool? = false
    public var entityProfile: EntityProfile<User>?
    public var blocked: Bool? = false
    
    public init(map: Mapper) throws {
        try userId = map.from("identifier")
        try internalId = map.from("internalId")
        screenName = map.optionalFrom("screenName")
        try systemUser = map.from("systemUser")
        synthetic = map.optionalFrom("synthetic")
        entityProfile = map.optionalFrom("entityProfile")
        blocked = map.optionalFrom("blocked")
    }
}
