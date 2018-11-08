//
//  UserLocator.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 08/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

public struct UserLocator: Mappable {
    public let type: String
    public var verificationStatus: VerificationStatus = VerificationStatus.StatusNotProvided
    public let userLocatorId: String
    public let locator: String
    public let identifier: String
    public let phoneNumber: String?
    public let email: String?
    public let applicationId: Identifiable<Application>
    
    public init(map: Mapper) throws {
        try type = map.from("@type")
        try verificationStatus = VerificationStatus(rawValue: map.from("verificationStatus")) ?? VerificationStatus.StatusNotProvided
        try userLocatorId = map.from("userLocatorId")
        try locator = map.from("locator")
        try identifier = map.from("identifier")
        phoneNumber = map.optionalFrom("phoneNumber")
        email = map.optionalFrom("email")
        try applicationId = map.from("applicationId")
    }
}
