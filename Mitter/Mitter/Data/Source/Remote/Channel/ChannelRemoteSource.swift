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
    
    func fetchChannels(channelIds: [String]) -> PrimitiveSequence<SingleTrait, [Channel]> {
        let flattenedChannelIds = channelIds.flattenWithCommas()
        return apiProvider
            .rx
            .request(.fetchChannels(channelIds: flattenedChannelIds))
            .map(to: [Channel].self)
    }
    
    func fetchChannelsForUser(userId: String) -> PrimitiveSequence<SingleTrait, [ParticipatedChannel]> {
        return apiProvider
        .rx
        .request(.fetchChannelsForUser(userId: userId))
        .map(to: [ParticipatedChannel].self)
    }
    
    func fetchParticipantsForChannel(channelId: String) -> PrimitiveSequence<SingleTrait, [ChannelParticipation]> {
        return apiProvider
        .rx
        .request(.fetchParticipantsForChannel(channelId: channelId))
        .map(to: [ChannelParticipation].self)
    }
    
    func addChannel(channel: Channel) -> PrimitiveSequence<SingleTrait, Identifiable<Channel>> {
        return apiProvider
            .rx
            .request(.addChannel(channel: channel))
            .map(to: Identifiable<Channel>.self)
    }
    
    func addParticipantToChannel(
        channelId: String,
        channelParticipation: ChannelParticipation
        ) -> PrimitiveSequence<SingleTrait, Empty> {
        return apiProvider
        .rx
        .request(.addParticipantToChannel(channelId: channelId, channelParticipation: channelParticipation))
        .map(to: Empty.self)
    }
    
    func removeChannel(channelId: String) -> PrimitiveSequence<SingleTrait, Empty> {
        return apiProvider
        .rx
        .request(.removeChannel(channelId: channelId))
        .map(to: Empty.self)
    }
}
