//
//  AuditInfo.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 08/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper
import Unbox

public struct AuditInfo: Mappable, Unboxable {
    public let createdAt: Int64?
    public let updatedAt: Int64?
    
    public init(map: Mapper) throws {
        createdAt = map.optionalFrom("createdAt")
        updatedAt = map.optionalFrom("updatedAt")
    }
    
    public init(unboxer: Unboxer) throws {
        createdAt = unboxer.unbox(key: "createdAt")
        updatedAt = unboxer.unbox(key: "updatedAt")
    }
}
