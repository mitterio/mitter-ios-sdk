//
//  ChannelApiContainer.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 26/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Swinject
import Moya

class ChannelApiContainer {
    private let applicationId: String
    private let userAuthToken: String
    
    private let container: Container
    
    init(applicationId: String, userAuthToken: String) {
        self.applicationId = applicationId
        self.userAuthToken = userAuthToken
        
        container = Container()
        registerChannelApiLayers()
    }
    
    func getFetchChannelAction() -> FetchChannelAction {
        return FetchChannelAction(channelRepository: getChannelRepository())
    }
    
    func getAddDirectMessageChannelAction() -> AddDirectMessageChannelAction {
        return AddDirectMessageChannelAction(channelRepository: getChannelRepository())
    }
    
    func getAddGroupChatChannelAction() -> AddGroupChatChannelAction {
        return AddGroupChatChannelAction(channelRepository: getChannelRepository())
    }
    
    func getAddChannelAction() -> AddChannelAction {
        return AddChannelAction(channelRepository: getChannelRepository())
    }
    
    private func registerChannelApiLayers() {
        container.register(ChannelRepositoryContract.self, name: Constants.Channels.channelRemoteSource) {
            _ in ChannelRemoteSource(
                apiProvider: MoyaProvider<ChannelApiService>(
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
        
        container.register(ChannelRepositoryContract.self, name: Constants.Channels.channelRepository) {
            resolver in ChannelRepository(
                channelRemoteSource: resolver.resolve(
                    ChannelRepositoryContract.self,
                    name: Constants.Channels.channelRemoteSource
                    ) as! ChannelRemoteSource
            )
        }
    }
    
    private func getChannelRepository() -> ChannelRepository {
        return container.resolve(
            ChannelRepositoryContract.self,
            name: Constants.Channels.channelRepository
            ) as! ChannelRepository
    }
}
