//
//  NewMessagePayload.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 20/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Unbox
import Mapper

public class NewMessagePayload: MessagingPipelinePayload {
    public let message: Message
    
    required init(unboxer: Unboxer, message: Message) throws {
        self.message = message
        try super.init(unboxer: unboxer)
    }
    
    required init(map: Mapper, message: Message) throws {
        self.message = message
        try super.init(map: map)
    }
    
    public required init(map: Mapper) throws {
        message = try map.from("message")
        try super.init(map: map)
    }
    
    required init(unboxer: Unboxer) throws {
        message = try unboxer.unbox(key: "message")
        try super.init(unboxer: unboxer)
    }
}
