//
//  Metadata.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 16/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

public struct Metadata {
    public let key: String
    public let value: String
}

extension Metadata: Mappable {
    public init(map: Mapper) throws {
        key = try map.from("key")
        value = try map.from("value")
    }
}
