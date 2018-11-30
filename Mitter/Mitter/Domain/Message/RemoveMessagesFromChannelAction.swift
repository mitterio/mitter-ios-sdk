//
//  RemoveMessagesFromChannelAction.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 29/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

class RemoveMessagesFromChannelAction: BiParamAction {
    private let messageRepository: MessageRepository
    
    init(messageRepository: MessageRepository) {
        self.messageRepository = messageRepository
    }
    
    func execute(t1: String, t2: [String]) -> PrimitiveSequence<SingleTrait, Empty> {
        return messageRepository.removeMessagesFromChannel(channelId: t1, messageIds: t2)
    }
}
