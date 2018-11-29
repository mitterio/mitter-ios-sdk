//
//  FetchTimelineEventsAction.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 29/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

class FetchTimelineEventsAction: TriParamAction {
    private let messageRepository: MessageRepository
    
    init(messageRepository: MessageRepository) {
        self.messageRepository = messageRepository
    }
    
    func execute(t1: String, t2: [String], t3: [String]) -> PrimitiveSequence<SingleTrait, [MessageTimelineEvent]> {
        return messageRepository.fetchTimelineEventsForMessages(channelId: t1, messageIds: t2, eventTypes: t3)
    }
}
