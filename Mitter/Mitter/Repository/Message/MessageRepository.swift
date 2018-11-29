//
//  MessageRepository.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 16/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

class MessageRepository: MessageRepositoryContract {
    private let messageRemoteSource: MessageRemoteSource
    
    init(messageRemoteSource: MessageRemoteSource) {
        self.messageRemoteSource = messageRemoteSource
    }
    
    func fetchMessagesInChannel(channelId: String) -> PrimitiveSequence<SingleTrait, [Message]> {
        return messageRemoteSource.fetchMessagesInChannel(channelId: channelId)
    }
    
    func fetchMessage(messageId: String) -> PrimitiveSequence<SingleTrait, Message> {
        return messageRemoteSource.fetchMessage(messageId: messageId)
    }
    
    func fetchTimelineEventsForMessages(
        channelId: String,
        messageIds: [String],
        eventTypes: [String]
    ) -> PrimitiveSequence<SingleTrait, [MessageTimelineEvent]> {
        return messageRemoteSource.fetchTimelineEventsForMessages(channelId: channelId, messageIds: messageIds, eventTypes: eventTypes)
    }
    
    func addMessageToChannel(channelId: String, message: Message) -> PrimitiveSequence<SingleTrait, Empty> {
        return messageRemoteSource.addMessageToChannel(channelId: channelId, message: message)
    }
    
    func addFileMessageToChannel(channelId: String, message: Message, file: URL) -> PrimitiveSequence<SingleTrait, Empty> {
        return messageRemoteSource.addFileMessageToChannel(channelId: channelId, message: message, file: file)
    }
    
    func removeMessagesFromChannel(channelId: String, messageIds: [String]) -> PrimitiveSequence<SingleTrait, Empty> {
        return messageRemoteSource.removeMessagesFromChannel(channelId: channelId, messageIds: messageIds)
    }
}
