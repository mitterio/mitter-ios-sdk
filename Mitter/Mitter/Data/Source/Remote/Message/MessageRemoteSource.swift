//
//  MessageRemoteSource.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 16/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class MessageRemoteSource: MessageRepositoryContract {
    private let apiProvider: MoyaProvider<MessageApiService>
    
    init(apiProvider: MoyaProvider<MessageApiService>) {
        self.apiProvider = apiProvider
    }
    
    func fetchMessagesInChannel(channelId: String) -> PrimitiveSequence<SingleTrait, [Message]> {
        return apiProvider
            .rx
            .request(.fetchMessagesInChannel(channelId: channelId))
            .map(to: [Message].self)
    }
    
    func fetchMessage(messageId: String) -> PrimitiveSequence<SingleTrait, Message> {
        return apiProvider
            .rx
            .request(.fetchMessage(messageId: messageId))
            .map(to: Message.self)
    }
    
    func fetchTimelineEventsForMessages(
        channelId: String,
        messageIds: [String],
        eventTypes: [String]
        ) -> PrimitiveSequence<SingleTrait, [MessageTimelineEvent]> {
        let flattenedMessageIds = messageIds.flattenWithCommas()
        let flattenedEventTypes = eventTypes.flattenWithCommas()
        
        return apiProvider
            .rx
            .request(.fetchTimelineEventsForMessages(channelId: channelId, messageIds: flattenedMessageIds, eventTypeFilter: flattenedEventTypes))
            .map(to: [MessageTimelineEvent].self)
    }
    
    func addMessageToChannel(channelId: String, message: Message) -> PrimitiveSequence<SingleTrait, Empty> {
        return apiProvider
            .rx
            .request(.addMessageToChannel(channelId: channelId, message: message))
            .map(to: Empty.self)
    }
    
    func addFileMessageToChannel(channelId: String, message: Message, file: URL) -> PrimitiveSequence<SingleTrait, Empty> {
        return apiProvider
            .rx
            .request(.addMultipartMessageToChannel(channelId: channelId, message: message, file: file))
            .map(to: Empty.self)
    }
    
    func removeMessagesFromChannel(channelId: String, messageIds: [String]) -> PrimitiveSequence<SingleTrait, Empty> {
        let flattenedMessageIds = messageIds.flattenWithCommas()
        return apiProvider
            .rx
            .request(.removeMessagesFromChannel(channelId: channelId, messageIds: flattenedMessageIds))
            .map(to: Empty.self)
    }
}
