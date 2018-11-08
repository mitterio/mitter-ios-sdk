//
//  Identifiable.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 08/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

public struct Identifiable<T>: Mappable {
    public var domainId: String
    public var ofType: Identifiable<T>.Type
    
    public init(map: Mapper) throws {
        try domainId = map.from("identifier")
        ofType = type(of: self)
    }
}
