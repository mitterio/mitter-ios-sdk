//
//  Identifiable.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 08/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper
import Unbox

public struct Identifiable<T>: Mappable, Unboxable {
    public let domainId: String
    public let ofType: Identifiable<T>.Type
    
    public init(map: Mapper) throws {
        try domainId = map.from("identifier")
        ofType = type(of: self)
    }
    
    public init(unboxer: Unboxer) throws {
        domainId = try unboxer.unbox(key: "identifier")
        ofType = type(of: self)
    }
}
