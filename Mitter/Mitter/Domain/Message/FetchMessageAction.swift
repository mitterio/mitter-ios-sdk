//
//  FetchMessageAction.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 16/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

class FetchMessageAction: UniParamAction {
    private let messageRepository: MessageRepository
    
    init(messageRepository: MessageRepository) {
        self.messageRepository = messageRepository
    }
    
    func execute(t: String) -> PrimitiveSequence<SingleTrait, Message> {
        return messageRepository.fetchMessage(messageId: t)
    }
}
