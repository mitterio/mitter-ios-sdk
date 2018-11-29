//
//  AddDeliveredTimelineEventAction.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 29/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

class AddDeliveredTimelineEventAction: TriParamAction {
    private let messageRepository: MessageRepository
    
    init(messageRepository: MessageRepository) {
        self.messageRepository = messageRepository
    }
    
    func execute(t1: String, t2: String, t3: String) -> PrimitiveSequence<SingleTrait, Empty> {
        let receiver = Identifiable<User>(domainId: t3)
        let deliveredTimelineEvent = TimelineEvent(
            eventId: UUID().uuidString,
            type: StandardTimelineEventTypeNames.Messages.DeliveredTime,
            eventTimeMs: getCurrentTimeInMillis(),
            subject: receiver)
        
        return messageRepository.addTimelineEventToMessage(channelId: t1, messageId: t2, timelineEvent: deliveredTimelineEvent)
    }
}
