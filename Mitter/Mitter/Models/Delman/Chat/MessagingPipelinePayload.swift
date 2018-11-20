//
//  MessagingPipelinePayload.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 20/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Unbox
import Mapper

public class MessagingPipelinePayload: Mappable, Unboxable {
    private let type: String
    public let payload: MessagingPipelinePayload?
    
    public required init(map: Mapper) throws {
        type = try map.from("@type")
        
        switch type {
        case StandardPipelinePayloadNames.NewMessagePayload:
            let message: Message = try map.from("message")
            payload = try NewMessagePayload(map: map, message: message)
            return
        default:
            payload = nil
            return
        }
    }
    
    public required init(unboxer: Unboxer) throws {
        type = try unboxer.unbox(key: "@type")
        
        switch type {
        case StandardPipelinePayloadNames.NewMessagePayload:
            let message: Message = try unboxer.unbox(key: "message")
            payload = try NewMessagePayload(unboxer: unboxer, message: message)
            return
        default:
            payload = nil
            return
        }
    }
}
