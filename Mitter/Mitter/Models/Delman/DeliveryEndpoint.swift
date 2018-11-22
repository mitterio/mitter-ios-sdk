//
//  DeliveryEndpoint.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 15/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

public class DeliveryEndpoint: Mappable {
    public let serializedEndpoint: String
    public let endpointType: String
    public var autoExpireAt: Int64 = Int64.max
    
    public init(serializedEndpoint: String, endpointType: String) {
        self.serializedEndpoint = serializedEndpoint
        self.endpointType = endpointType
    }
    
    public required init(map: Mapper) throws {
        serializedEndpoint = try map.from("serializedEndpoint")
        endpointType = try map.from("endpointType")
        autoExpireAt = try map.from("autoExpireAt")
    }
}
