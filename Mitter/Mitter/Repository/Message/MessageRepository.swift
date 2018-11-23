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
    
    func fetchMessage(messageId: String) -> PrimitiveSequence<SingleTrait, Message> {
        return messageRemoteSource.fetchMessage(messageId: messageId)
    }
    
    func addMessageToChannel(channelId: String, message: Message) -> PrimitiveSequence<SingleTrait, Empty> {
        return messageRemoteSource.addMessageToChannel(channelId: channelId, message: message)
    }
}
