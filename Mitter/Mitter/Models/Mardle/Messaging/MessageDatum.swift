//
//  MessageDatum.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 16/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

public struct MessageDatum: Mappable {
    public let dataType: String
    public let data: String
    
    public init(map: Mapper) throws {
        dataType = try map.from("dataType")
        data = try map.from("data")
    }
    
    public init(dayaType: String, data: String) {
        self.dataType = dayaType
        self.data = data
    }
}
