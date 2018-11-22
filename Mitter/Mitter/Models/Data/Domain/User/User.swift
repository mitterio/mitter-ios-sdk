//
//  User.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 06/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

public struct User {
    public let userId: String
    public let internalId: String
    public let screenName: ScreenName?
    public let systemUser: Bool
    public let synthetic: Bool?
    public let entityProfile: EntityProfile<User>?
    public let blocked: Bool?
    public let auditInfo: AuditInfo
    public var userLocators: [UserLocator] = [UserLocator]()
}

extension User: Mappable {
    public init(map: Mapper) throws {
        try userId = map.from("identifier")
        try internalId = map.from("internalId")
        screenName = map.optionalFrom("screenName")
        try systemUser = map.from("systemUser")
        synthetic = map.optionalFrom("synthetic")
        entityProfile = map.optionalFrom("entityProfile")
        blocked = map.optionalFrom("blocked")
        try auditInfo = map.from("auditInfo")
        userLocators = map.optionalFrom("userLocators") ?? []
    }
}
