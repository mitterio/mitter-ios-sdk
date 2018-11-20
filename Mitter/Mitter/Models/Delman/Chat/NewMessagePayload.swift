//
//  NewMessagePayload.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 20/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Unbox

public class NewMessagePayload: MessagingPipelinePayload {
    public let message: Message
    
    required init(unboxer: Unboxer) throws {
        message = try unboxer.unbox(key: "message")
        try super.init(unboxer: unboxer)
    }
}
