//
//  PushMessageManager.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 20/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation

class PushMessageManager {
    private let fcmMessageProcessor: FcmMessageProcessor
    
    init(fcmMessageProcessor: FcmMessageProcessor) {
        self.fcmMessageProcessor = fcmMessageProcessor
    }
    
    func parseFcmMessage(data: Data) -> MessagingPipelinePayload? {
        return fcmMessageProcessor.process(t: data)
    }
    
    func isMitterMessage(messagingPipelinePayload: MessagingPipelinePayload?) -> Bool {
        return messagingPipelinePayload != nil
    }
}
