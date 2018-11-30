//
//  AddReadTimelineEventAction.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 30/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

class AddReadTimelineEventAction: TriParamAction {
    private let messageRepository: MessageRepository
    
    init(messageRepository: MessageRepository) {
        self.messageRepository = messageRepository
    }
    
    func execute(t1: String, t2: String, t3: String) -> PrimitiveSequence<SingleTrait, Empty> {
        let receiver = Identifiable<User>(domainId: t3)
        let readTimelineEvent = TimelineEvent(
            eventId: UUID().uuidString,
            type: StandardTimelineEventTypeNames.Messages.ReadTime,
            eventTimeMs: getCurrentTimeInMillis(),
            subject: receiver
        )
        
        return messageRepository.addTimelineEventToMessage(channelId: t1, messageId: t2, timelineEvent: readTimelineEvent)
    }
}
