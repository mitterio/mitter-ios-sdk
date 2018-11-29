//
//  MessageRepositoryContract.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 16/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

protocol MessageRepositoryContract {
    func fetchMessagesInChannel(channelId: String) -> PrimitiveSequence<SingleTrait, [Message]>
    
    func fetchMessage(messageId: String) -> PrimitiveSequence<SingleTrait, Message>
    
    func addMessageToChannel(channelId: String, message: Message) -> PrimitiveSequence<SingleTrait, Empty>
    
    func addFileMessageToChannel(channelId: String, message: Message, file: URL) -> PrimitiveSequence<SingleTrait, Empty>
    
    func removeMessagesFromChannel(channelId: String, messageIds: [String]) -> PrimitiveSequence<SingleTrait, Empty>
}
