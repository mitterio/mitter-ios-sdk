//
//  MessageApiContainer.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 16/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Swinject
import Moya

class MessageApiContainer {
    private let applicationId: String
    private let userAuthToken: String
    
    private let container: Container
    
    init(applicationId: String, userAuthToken: String) {
        self.applicationId = applicationId
        self.userAuthToken = userAuthToken
        
        container = Container()
        registerMessageApiLayers()
    }
    
    func getFetchMessagesInChannelAction() -> FetchMessagesInChannelAction {
        return FetchMessagesInChannelAction(messageRepository: getMessageRepository())
    }
    
    func getFetchMessageAction() -> FetchMessageAction {
        return FetchMessageAction(messageRepository: getMessageRepository())
    }
    
    func getFetchTimelineEventsAction() -> FetchTimelineEventsAction {
        return FetchTimelineEventsAction(messageRepository: getMessageRepository())
    }
    
    func getAddTextMessageAction() -> AddTextMessageAction {
        return AddTextMessageAction(messageRepository: getMessageRepository())
    }
    
    func getImageMessageAction() -> AddImageMessageAction {
        return AddImageMessageAction(messageRepository: getMessageRepository())
    }
    
    func getAddFileMessageAction() -> AddFileMessageAction {
        return AddFileMessageAction(messageRepository: getMessageRepository())
    }
    
    func getAddMessageAction() -> AddMessageAction {
        return AddMessageAction(messageRepository: getMessageRepository())
    }
    
    func getAddDeliveredTimelineEventAction() -> AddDeliveredTimelineEventAction {
        return AddDeliveredTimelineEventAction(messageRepository: getMessageRepository())
    }
    
    func getAddReadTimelineEventAction() -> AddReadTimelineEventAction {
        return AddReadTimelineEventAction(messageRepository: getMessageRepository())
    }
    
    func getRemoveMessagesFromChannelAction() -> RemoveMessagesFromChannelAction {
        return RemoveMessagesFromChannelAction(messageRepository: getMessageRepository())
    }
    
    private func registerMessageApiLayers() {
        container.register(MessageRepositoryContract.self, name: Constants.Messages.messageRemoteSource) {
            _ in MessageRemoteSource(
                apiProvider: MoyaProvider<MessageApiService>(
                    plugins: [
                        ApiAuthPlugin(
                            applicationId: self.applicationId,
                            userAuthToken: self.userAuthToken
                        ),
                        NetworkLoggerPlugin(verbose: true)
                    ]
                )
            )
        }
        
        container.register(MessageRepositoryContract.self, name: Constants.Messages.messageRepository) {
            resolver in MessageRepository(
                messageRemoteSource: resolver.resolve(
                    MessageRepositoryContract.self,
                    name: Constants.Messages.messageRemoteSource
                    ) as! MessageRemoteSource
            )
        }
    }
    
    private func getMessageRepository() -> MessageRepository {
        return container.resolve(
            MessageRepositoryContract.self,
            name: Constants.Messages.messageRepository
            ) as! MessageRepository
    }
}
