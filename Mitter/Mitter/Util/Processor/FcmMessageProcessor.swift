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
    typealias T = Data
    typealias V = MessagingPipelinePayload?
    
    func process(t: FcmMessageProcessor.T) -> FcmMessageProcessor.V {
        let JSON = try! JSONSerialization.jsonObject(with: t, options: []) as? NSDictionary
        return MessagingPipelinePayload.from(JSON!)
    }
}
