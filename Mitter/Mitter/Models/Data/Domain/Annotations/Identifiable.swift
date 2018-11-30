//
//  Identifiable.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 08/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

public struct Identifiable<T>: Mappable, CustomStringConvertible {
    public let domainId: String
    public let ofType: T.Type
    
    public init(domainId: String) {
        self.domainId = domainId
        ofType = T.self
    }
    
    public init(map: Mapper) throws {
        try domainId = map.from("identifier")
        ofType = T.self
    }
    
    public var description: String {
        return "\(ofType): \(domainId)"
    }
}
