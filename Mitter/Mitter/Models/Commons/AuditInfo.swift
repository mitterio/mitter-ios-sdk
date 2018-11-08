//
//  AuditInfo.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 08/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

public struct AuditInfo: Mappable {
    public let createdAt: Int64?
    public let updatedAt: Int64?
    
    public init(map: Mapper) throws {
        createdAt = map.optionalFrom("createdAt")
        updatedAt = map.optionalFrom("updatedAt")
    }
}
