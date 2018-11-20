//
//  EntityMetadata.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 16/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper
import Unbox

public struct EntityMetadata: Mappable, Unboxable {
    public let metadata: [Metadata]
    
    public init(map: Mapper) throws {
        metadata = try map.from("metadata")
    }
    
    public init(unboxer: Unboxer) throws {
        metadata = try unboxer.unbox(key: "metadata")
    }
}
