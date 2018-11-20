//
//  MessagingPipelinePayload.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 20/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Unbox

public class MessagingPipelinePayload: Unboxable {
    private let type: String
    let payload: MessagingPipelinePayload?
    
    public required init(unboxer: Unboxer) throws {
        type = try unboxer.unbox(key: "@type")
        
        switch type {
        case StandardPipelinePayloadNames.NewMessagePayload:
            let message: NewMessagePayload = try unboxer.unbox(key: "message")
            payload = message
            
            return
        default:
            payload = nil
            return
        }
    }
}
