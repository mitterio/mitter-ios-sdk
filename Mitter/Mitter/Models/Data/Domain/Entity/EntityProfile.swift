//
//  EntityProfile.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 08/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

public struct EntityProfile<T>: Mappable {
    public let entityId: Identifiable<T>
    public var attributes: [Attribute] = [Attribute]()
    
    public init(map: Mapper) throws {
        try entityId = map.from("entityId")
        try attributes = map.from("attributes")
    }
}
