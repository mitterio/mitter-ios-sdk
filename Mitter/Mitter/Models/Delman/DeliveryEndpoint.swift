//
//  DeliveryEndpoint.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 15/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation

public class DeliveryEndpoint {
    public let serializedEndpoint: String
    public let endpointType: String
    public let autoExpireAt: Int64 = Int64.max
    
    public init(serializedEndpoint: String, endpointType: String) {
        self.serializedEndpoint = serializedEndpoint
        self.endpointType = endpointType
    }
}
