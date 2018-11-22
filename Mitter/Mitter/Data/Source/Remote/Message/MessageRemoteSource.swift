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
    
    func fetchMessage(messageId: String) -> PrimitiveSequence<SingleTrait, Message> {
        return apiProvider
            .rx
            .request(.fetchMessage(messageId: messageId))
            .map(to: Message.self)
    }
}
