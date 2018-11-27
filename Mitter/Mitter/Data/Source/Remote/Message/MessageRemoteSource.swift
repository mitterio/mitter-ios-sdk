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
    
    func addMessageToChannel(channelId: String, message: Message) -> PrimitiveSequence<SingleTrait, Empty> {
        return apiProvider
            .rx
            .request(.addMessageToChannel(channelId: channelId, message: message))
            .map(to: Empty.self)
    }
}
