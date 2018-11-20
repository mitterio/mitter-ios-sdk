//
//  FcmMessageProcessor.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 20/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Unbox

class FcmMessageProcessor: Processor {
    typealias T = Data
    typealias V = MessagingPipelinePayload?
    
    func process(t: FcmMessageProcessor.T) -> FcmMessageProcessor.V {
        return try? unbox(data: t)
    }
}
