//
//  FcmMessageProcessor.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 20/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

class FcmMessageProcessor: Processor {
    typealias T = String
    typealias V = MessagingPipelinePayload?
    
    func process(t: FcmMessageProcessor.T) -> FcmMessageProcessor.V {
        let fcmMessageData = t.data(using: .utf8)
        let JSON = try! JSONSerialization.jsonObject(with: fcmMessageData!, options: []) as? NSDictionary
        return MessagingPipelinePayload.from(JSON!)
    }
}
