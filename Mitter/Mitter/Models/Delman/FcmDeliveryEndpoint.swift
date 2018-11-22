//
//  FcmDeliveryEndpoint.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 15/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

public class FcmDeliveryEndpoint: DeliveryEndpoint {
    public let registrationToken: String
    
    public init(registrationToken: String) {
        self.registrationToken = registrationToken
        
        super.init(
            serializedEndpoint: "\(StandardEndpointTypes.FcmDeliveryEndpoint):\(registrationToken)",
            endpointType: StandardEndpointTypes.FcmDeliveryEndpoint
        )
    }
    
    public required init(map: Mapper) throws {
        self.registrationToken = ""
        
        super.init(
            serializedEndpoint: "",
            endpointType: StandardEndpointTypes.FcmDeliveryEndpoint
        )
    }
}
