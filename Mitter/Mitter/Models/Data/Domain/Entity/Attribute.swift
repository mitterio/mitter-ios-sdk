//
//  Attribute.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 08/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

public struct Attribute: Mappable {
    public var key: String
    public var contentType: String
    public var contentEncoding: String
    public var value: String
    
    public init(map: Mapper) throws {
        try key = map.from("key")
        try contentType = map.from("contentType")
        try contentEncoding = map.from("contentEncoding")
        try value = map.from("value")
    }
}
