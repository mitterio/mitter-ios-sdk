//
//  MessageDatum.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 16/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

public struct MessageDatum {
    public let dataType: String
    public let data: NSDictionary
    
    public init(dataType: String, data: NSDictionary) {
        self.dataType = dataType
        self.data = data
    }
}

extension MessageDatum: Mappable {
    public init(map: Mapper) throws {
        dataType = try map.from("dataType")
        data = try map.from("data")
    }
}
