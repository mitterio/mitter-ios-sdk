//
//  AddImageMessageAction.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 29/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

class AddImageMessageAction: TriParamAction {
    private let messageRepository: MessageRepository
    
    init(messageRepository: MessageRepository) {
        self.messageRepository = messageRepository
    }
    
    func execute(t1: String, t2: ImageMessage, t3: URL) -> PrimitiveSequence<SingleTrait, Empty> {
        let sender = Identifiable<User>(domainId: t2.senderId)
        
        let sentTimelineEvent = TimelineEvent(
            eventId: UUID().uuidString,
            type: StandardTimelineEventTypeNames.Messages.SentTime,
            eventTimeMs: getCurrentTimeInMillis(),
            subject: sender
        )
        
        let message = Message(
            messageId: UUID().uuidString,
            payloadType: StandardPayloadTypeNames.ImageMessage,
            senderId: sender,
            textPayload: t2.caption,
            timelineEvents: [sentTimelineEvent]
        )
        
        return messageRepository.addFileMessageToChannel(channelId: t1, message: message, file: t3)
    }
}
