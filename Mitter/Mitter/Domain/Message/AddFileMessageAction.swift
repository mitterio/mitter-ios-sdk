//
//  AddFileMessageAction.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 28/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

class AddFileMessageAction: TriParamAction {
    private let messageRepository: MessageRepository
    
    init(messageRepository: MessageRepository) {
        self.messageRepository = messageRepository
    }
    
    func execute(t1: String, t2: Message, t3: URL) -> PrimitiveSequence<SingleTrait, Empty> {
        return messageRepository.addFileMessageToChannel(channelId: t1, message: t2, file: t3)
    }
}
