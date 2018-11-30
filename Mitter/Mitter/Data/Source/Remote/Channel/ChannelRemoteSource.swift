//
//  ChannelRemoteSource.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 26/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class ChannelRemoteSource: ChannelRepositoryContract {
    private let apiProvider: MoyaProvider<ChannelApiService>
    
    init(apiProvider: MoyaProvider<ChannelApiService>) {
        self.apiProvider = apiProvider
    }
    
    func fetchChannel(channelId: String) -> PrimitiveSequence<SingleTrait, Channel> {
        return apiProvider
            .rx
            .request(.fetchChannel(channelId: channelId))
            .map(to: Channel.self)
    }
    
    func addChannel(channel: Channel) -> PrimitiveSequence<SingleTrait, Identifiable<Channel>> {
        return apiProvider
            .rx
            .request(.addChannel(channel: channel))
            .map(to: Identifiable<Channel>.self)
    }
}
