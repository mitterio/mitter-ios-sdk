//
//  Presence.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 22/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

public class Presence: Mappable {
    public let type: String
    public let timeToLive: Int64
    public let expiresTo: Presence?
    
    public init(
        type: String,
        timeToLive: Int64,
        expiresTo: Presence? = nil
    ) {
        self.type = type
        self.timeToLive = timeToLive
        self.expiresTo = expiresTo
    }
    
    public required init(map: Mapper) throws {
        type = try map.from("type")
        timeToLive = try map.from("timeToLive")
        expiresTo = map.optionalFrom("expiresTo")
    }
}
