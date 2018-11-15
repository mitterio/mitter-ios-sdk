//
//  FcmDeliveryEndpoint.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 15/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

public class FcmDeliveryEndpoint: DeliveryEndpoint, Mappable {
    public let registrationToken: String
    
    public required init(map: Mapper) throws {
        registrationToken = try map.from("registrationToken")
        
        super.init(
            serializedEndpoint: "\(StandardEndpointTypes.FcmDeliveryEndpoint):\(registrationToken)",
            endpointType: StandardEndpointTypes.FcmDeliveryEndpoint
        )
    }
}
