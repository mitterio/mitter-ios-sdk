//
//  MessagingPipelinePayload.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 20/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

public class MessagingPipelinePayload: Mappable {
    let type: String
    public let message: Message?
    public let globalPipelinePayloadId: String
    
    public required init(map: Mapper) throws {
        type = try map.from("@type")
        message = map.optionalFrom("message")
        globalPipelinePayloadId = try map.from("globalPipelinePayloadId")
    }
}
