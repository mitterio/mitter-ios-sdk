//
//  AddTextMessageAction.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 23/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

class AddTextMessageAction: BiParamAction {
    private let messageRepository: MessageRepository
    
    init(messageRepository: MessageRepository) {
        self.messageRepository = messageRepository
    }
    
    func execute(t1: String, t2: TextMessage) -> PrimitiveSequence<SingleTrait, Empty> {
        let sender = Identifiable<User>(domainId: t2.senderId)
        
        let sentTimelineEvent = TimelineEvent(
            eventId: UUID().uuidString,
            type: StandardTimelineEventTypeNames.Messages.SentTime,
            eventTimeMs: getCurrentTimeInMillis(),
            subject: sender
        )
        
        let message = Message(
            messageId: UUID().uuidString,
            senderId: sender,
            textPayload: t2.message,
            timelineEvents: [sentTimelineEvent]
        )
        
        return messageRepository.addMessageToChannel(channelId: t1, message: message)
    }
}
