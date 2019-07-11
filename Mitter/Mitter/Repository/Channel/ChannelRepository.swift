//
//  ChannelRepository.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 26/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

class ChannelRepository: ChannelRepositoryContract {
    private let channelRemoteSource: ChannelRemoteSource
    
    init(channelRemoteSource: ChannelRemoteSource) {
        self.channelRemoteSource = channelRemoteSource
    }
    
    func fetchChannels(channelIds: [String]) -> PrimitiveSequence<SingleTrait, [Channel]> {
        return channelRemoteSource.fetchChannels(channelIds: channelIds)
    }
    
    func fetchChannelsForUser(userId: String) -> PrimitiveSequence<SingleTrait, [ParticipatedChannel]> {
        return channelRemoteSource.fetchChannelsForUser(userId: userId)
    }
    
    func fetchParticipantsForChannel(channelId: String) -> PrimitiveSequence<SingleTrait, [ChannelParticipation]> {
        return channelRemoteSource.fetchParticipantsForChannel(channelId: channelId)
    }
    
    func addChannel(channel: Channel) -> PrimitiveSequence<SingleTrait, Identifiable<Channel>> {
        return channelRemoteSource.addChannel(channel: channel)
    }
    
    func addParticipantToChannel(
        channelId: String,
        channelParticipation: ChannelParticipation
        ) -> PrimitiveSequence<SingleTrait, Empty> {
        return channelRemoteSource.addParticipantToChannel(channelId: channelId, channelParticipation: channelParticipation)
    }
    
    func removeChannel(channelId: String) -> PrimitiveSequence<SingleTrait, Empty> {
        return channelRemoteSource.removeChannel(channelId: channelId)
    }
}
